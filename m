Return-Path: <netdev+bounces-138721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861299AEA3C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F81F23149
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4C1E379C;
	Thu, 24 Oct 2024 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBJi7pJ2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5081E32CF
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783296; cv=none; b=Ak7RxGtkirVn2ItyYjQSez3yIjZf/cQNhNUU03zXbAkDovdwiJ4qKzuNEvqZpGvFXIbTTDwdJ1l5s6wFp59Nx/8aavSbSUbr5tGv/KcppCgE/Up+Wo6FA+5/5UR3JyLVi2gelpK1bQeqxc0veRoTWFYOdBcrGyNCWjFH4bWnEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783296; c=relaxed/simple;
	bh=nW0TWG7Fc0VNjERMXMTr1agpaawOY2IgT9uj4bNwY54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=josHQeMzVB6sqa/RoGZxztO1sh2xcz7nuw5Q+yKwqU7EQYtrI6UEicICc6wqmddEdjmZg5/7DqY9oLD6gZ3eV65sLnk/omxl3P4A+IYeBZtdKX0jcYZBy0bpScdhFlpwHwAoVid9ZW2ntBk18a2VU9kU7jOj0rD6/8qY7VoWFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBJi7pJ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729783293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qrw2RqXMP78nGKg8Lpv1jq5anNPyVA6VfKNmhQikqx0=;
	b=EBJi7pJ2gPJY+vR2c0iNk8BHJrvcfmHo4kyKtk9H3KnTa7NVEio+tdnRFGA0JIJC906O1g
	ASpv+AVUKt35EuN/4Es2MNF0yZ/7rJYCHWp5I6dfOU3w0U+A4ggE8cuu3Ju4sYy4AfWpci
	gc8IeRRf88cw2I3Bhq8yf3GdwAP0yKg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-DRts1yO_MO-Dk7zP9-DwZQ-1; Thu, 24 Oct 2024 11:21:32 -0400
X-MC-Unique: DRts1yO_MO-Dk7zP9-DwZQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460d8f8f5d4so16631801cf.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729783291; x=1730388091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrw2RqXMP78nGKg8Lpv1jq5anNPyVA6VfKNmhQikqx0=;
        b=cZHw66H2QMSdT27AsRx5Yf+FHE6WZ9HJj+X4z6OPnDdIXLgLvlPHp0tmoAFbiYz+DD
         Y1Kf+Jz3XNZD7afdyDJ9roSF9LCkh4DtFOm4XmsxHQU6VhvBZUOrOeU7ah/5BBt3Rj/C
         eRCaUYzprvNj4mv4szw3JIEaZx4z+vr/LnFt7kuffglydbaSSD9b2g23ZgD/Q7du5dGQ
         E4Fjebmlc444KxvEp0cL3qH5clIYcn6cQw2a/iJ2B9bGDFVJzJBbSD08i8ArQ3ZxnUJd
         kzkOXW0LL8xVIaJXdJlfQfr2+HskvAFshMra2cm3JUkAmuUFL57QTx/TtJLzM2JON4zT
         DGRA==
X-Forwarded-Encrypted: i=1; AJvYcCV29MVnNADWlhWzWLwGL81CJtuKD/oyTBpSN/3JEFhvcBqcoTE544rLSejiDRp1fvbvZR6Rz/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgcJA9VC0widldpyWrH3pIPiGaJyNdXEt4WAMEfTclP/9Khwp
	+jHkBH8Kp0ziFSl4Se5ZHDqZzdtWhFlPyzxLfnocwmoY+fb1LX937gukMUj/zWQa4BiYwNq3c2O
	NnznDtXwUzE/yYLPgwRWjOYYLteSwSYT99VZUipdLFvZ4Vi9+s48lYw==
X-Received: by 2002:ac8:498c:0:b0:461:2bbd:f96c with SMTP id d75a77b69052e-4612bbdfa90mr11593101cf.6.1729783291629;
        Thu, 24 Oct 2024 08:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENeP1TLULS4yPvQaHG4+jzlT08mwB6uRKJpkFnJDnX+eZo+AoJiFHON/m2ibWFVUzxSQuMdg==
X-Received: by 2002:ac8:498c:0:b0:461:2bbd:f96c with SMTP id d75a77b69052e-4612bbdfa90mr11592771cf.6.1729783291124;
        Thu, 24 Oct 2024 08:21:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3dab83fsm52808871cf.88.2024.10.24.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:21:30 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:21:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <4xfrphsdl7p2aqu6w7diow5shsnjq263lhfudi4yiqxvkvcmkq@ti2hcdbkthok>
References: <20241023210031.274017-1-kshk@linux.ibm.com>
 <k5otzhemrqeau7iilr6j42ytasddatbx53godcm2fm6zckevti@nqnetgj6odmb>
 <ca6702e0-bdd9-4ab7-8fbc-e8b0404c9ed5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ca6702e0-bdd9-4ab7-8fbc-e8b0404c9ed5@linux.ibm.com>

On Thu, Oct 24, 2024 at 10:00:47AM -0500, Konstantin Shkolnyy wrote:
>On 10/24/2024 03:43, Stefano Garzarella wrote:
>>Other setsockopt() in the tests where we use unsigned long are
>>SO_VM_SOCKETS_* but they are expected to be unsigned, so we should be
>>fine.
>
>It's actually not "signed vs unsigned", but a "size + endianess" problem.

I see, thanks!

>
>Also, looking at SO_VM_SOCKETS_* code in the test, it uses unsigned 
>long and size_t which (I believe) will both shrink to 4 bytes on 32-bit 
>machines, while the corresponding kernel code in af_vsock.c uses u64.  
>It looks to me that this kernel code will be unhappy to receive just 4 
>bytes when it expects 8.
>

In include/uapi/linux/vm_sockets.h we talk about unsigned long long for 
SO_VM_SOCKETS_*, that IIUC also on 32-bit machines should be on 64bit, 
so the kernel code looks okay, but the tests should be improved, right?

Thanks,
Stefano


