Return-Path: <netdev+bounces-108387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34895923AAE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A170DB207E8
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0260155C90;
	Tue,  2 Jul 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2vfFP39"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DB7150987
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913915; cv=none; b=TeSrAv30+YrFY7TY5yHfEOSbnahJFgow4H00/bawaIETJgkOda0EoYmm7FXsAQl1mhFiIfSPq1dl6YUJUyMN3b2nnyWTWYrx0HCL7GiiNtCNmN+GW2HpDwse9Wd2xnBKrG7oHnTYgzv6P/s4gvpCfnJxSw4R8Xzrh/3I/KhUNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913915; c=relaxed/simple;
	bh=cpgWs0AOBQ/WXjBSrdDLs4dO9T4L45C6ToPDwoRQQcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SasEO/jEb/WgBivBMptNtR9K0e6kBEeaEHCOjlmATrFmqCJWrLkOAPA8Bv4ge9atGPVCY+4bqOQiEczjiYxnyAYGEv7v4Ky0dHC9waio8oEe8FwUJcmCCUZi818v5CaTWKtKzhbNBQ9jnWWT2yq//y+qYiiJ2BNtnLrhbwDFXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2vfFP39; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719913913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cpgWs0AOBQ/WXjBSrdDLs4dO9T4L45C6ToPDwoRQQcc=;
	b=g2vfFP39DcaVdtn3e8++TEj1WL5IrMEjXxyiFaJfj2nUYGcdcXanq2X9G+V0KOq2WD1yqc
	Q3M4zceXsBOZ4bvgUkPk2vlUlpDvsTP7yPEagFruMIYuSFbP9w7f+TcBcnj9EN1jddMHaE
	m8BegAESSEQBPrLXEtcA/edwORkd5T8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-hTBJ3KhzMrCFNmZvYDy-OA-1; Tue, 02 Jul 2024 05:51:49 -0400
X-MC-Unique: hTBJ3KhzMrCFNmZvYDy-OA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42568f0bc56so6753985e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 02:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913908; x=1720518708;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpgWs0AOBQ/WXjBSrdDLs4dO9T4L45C6ToPDwoRQQcc=;
        b=IsDyQt97ciAZpiIkDc+wuFHvJQ0iJZUOF52VNwh/E+S6gzWZilwP73RWrqhQVQHGZG
         o/xLRwPOw9ZHbW1EXbP5fP1Iek+C69ROIs19BQ6DXZOni5hK6FDfi92LWXTZpGb3urTL
         PSxCq78OhG9d5NK/Cs2cs4ycKrnAdivpDILak4ek7jeCYVoAVsrQ7u7umdFaL2m+uOZZ
         9MrxE019+ZMDpWNBckuqEK/quPT9ZzD8IwWwQoQKf4b53S7D09x/FNmZrLgYVI5OPtRz
         3ZzkCIXxZYqMLHoN/LSCfnbIiRcLfwH6nfgq+O1nyDKkiSlTbvdmCoJfVImMc2wvfXlC
         dg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlEqNXttY+1okxeAITJgSMunA3nwDOr/+qu99jdSdYpyuuUuK88P/0c0E9qYFiDTrR+43TZkovXDV1RRzLvx/nJdpk54Qs
X-Gm-Message-State: AOJu0YyaloEBwsoY5dXEag8PXVxqVZy4/awUEknDJDyJPOuuKW9yIMHv
	nAX8E2SlkJfwrz067h81xk/Q0TSD4cjrO12eXD5VBF0nkWdqB3Gqu/+AfqQDD3T7iFsfp9cNoTP
	r3c8cSF8qSeQfIgagF4CtyUm35/vcxJoaYFNfWIsA4v4GcVzrl/+Lhg==
X-Received: by 2002:a05:6000:1445:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-367757214d5mr4679484f8f.3.1719913908618;
        Tue, 02 Jul 2024 02:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq7VGct7kCCUQQ4zIQVK3uj27FCJT1maoTnNA6OKDfuzLKbhrbTh76GJUysY/Y2Nx19b1Uuw==
X-Received: by 2002:a05:6000:1445:b0:366:eb60:bd12 with SMTP id ffacd0b85a97d-367757214d5mr4679481f8f.3.1719913908276;
        Tue, 02 Jul 2024 02:51:48 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0a6:6710:872d:b0f7:af0b:a62f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678a23b349sm887210f8f.36.2024.07.02.02.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:51:47 -0700 (PDT)
Message-ID: <2346b61ddecfca4d95a20415d27bdd8c50a83e9b.camel@redhat.com>
Subject: Re: [PATCH net v4] net: allow skb_datagram_iter to be called from
 any context
From: Paolo Abeni <pabeni@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, netdev@vger.kernel.org, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Matthew Wilcox <willy@infradead.org>
Date: Tue, 02 Jul 2024 11:51:46 +0200
In-Reply-To: <20240626100008.831849-1-sagi@grimberg.me>
References: <20240626100008.831849-1-sagi@grimberg.me>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 13:00 +0300, Sagi Grimberg wrote:
> We only use the mapping in a single context, so kmap_local is sufficient
> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> contain highmem compound pages and we need to map page by page.

My understanding of the discussion on previous revision is that Matthew
prefers dropping the reference to 'highmem':

https://lore.kernel.org/netdev/Zn1-2QVyOJe_y6l1@casper.infradead.org/#t

To avoid a repost, I can drop it while applying the patch, if there is
agreement.

Thanks,

Paolo


