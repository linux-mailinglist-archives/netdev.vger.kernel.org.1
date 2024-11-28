Return-Path: <netdev+bounces-147704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A19DB497
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6982816D1
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F298154C0F;
	Thu, 28 Nov 2024 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0E4x33h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE9E1547C5
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732785056; cv=none; b=gzZrj/QcVT9Fc565kFPPfseLISUwY0eVNu2oIZSbR14QdIacmcZVb0uddTqLp4Sl/FalUiXrvKpY6T9IDnG0gVGK8Cqadl1zQ0qK939rf3Q/XtO39gzq9MbLzRB4FRPy1R7B9pniARNX/cQRmIJ+rsjz3VkK51bx5I0wXcHBw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732785056; c=relaxed/simple;
	bh=5aM6RUx2SpmIVmv77g8XGYaRBXTXgbsI0IpnnLfE7Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSGyodSpsKro5OhEf2Jd/fF8SERNUzPRhl602yOPp6b3ThpIBO9LT0sqg+WH8Zg5/hlG8YpE81wXpFDO+2Ch0XxpOODwjGFMIZtTo99wtse5E7h6onlVhX4y95hHUchrK0r0e1GNFGcUC9+obXVY0gkaxokLngsPaiBNvN+CAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0E4x33h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732785053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDJda/po3QEjwQCtXovWuVSEwD6COQFMRUy2RBfefjI=;
	b=Z0E4x33hKczw1q91pWPrX3/b9tPGqinzdDq7Vchgkuh/2lrzq0FlW8ZgfPdIsAwnMK5Cv+
	qhrf+Ter75rfCIFEM+pO7no09BOq/KT8GMDgyiegCGD5IL0afxjYYgSnpK+lv5CNStAeRu
	Xta/jGcWUIZ57eRwzaDLiEssJ9HzbDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-7ZtGD_nqNRKMiseJHxLnkQ-1; Thu, 28 Nov 2024 04:10:52 -0500
X-MC-Unique: 7ZtGD_nqNRKMiseJHxLnkQ-1
X-Mimecast-MFC-AGG-ID: 7ZtGD_nqNRKMiseJHxLnkQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a876d15cso8781485e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 01:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732785051; x=1733389851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDJda/po3QEjwQCtXovWuVSEwD6COQFMRUy2RBfefjI=;
        b=ahJHB1BvFP/BYLg/uZ7AbNiRwgF7JO5yXofX7sZr/3jBCTLuvnYmaq0dj8jWPHir78
         cCBs1X/QzZmEgbcjOQFhNuCEiV6DIgBbNRoWGlJ+h1pS4GLFNMyr9UFMK7IYEMzsiarX
         Lke3sUQFdFDi+qWf5o8RZjqaiSoQNfXUeJ836j3nfDbdkqiwg+MzJQfl9mTZXImgFULH
         BFSdL0ACB0iydIegf6S+rc8tos3n73ohjBwLJmDDCy9N56qUJHztSu7ME2g1mGToLZzc
         39kokdTC6T9DnhMrgX40U5eMipwF/U/vegfJ8yIFMm2BH6aB5F5yWumH58gY1GFDZPiQ
         eafQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqm64mNNhkpRybXofBdEq9tsNNf3UeSkmBZ7lsnvIK2sS6cc+BMjtPRimbXYJd22KbdkUCg38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUjxke/zrVbiI8T7+EqlGon0yBCbszqEz+ipuX+0CfvmhFNZbo
	56Bxo8nsiAr+a1vuJezJXGB0vEi1y2v0Ekmc3lr6Nnoc0iS4wylesTeVhI0HNqcgzaVkZV/mRsi
	SITM2JOX0tqzsxrAwfdN0ehOrn37qXRLgmjrkfwFtN2P/RFbPBdMkPA==
X-Gm-Gg: ASbGncs3fLXKmgrZY2WsY+XEAf++kSGk48FqLHnUvbravW60ZAG5Dkp3bV1TIiKdS7T
	6l6EtF9neDTIfil9AHv2Xzhf0m7M3JItVTxcVF76QaPIWG7N4HcvaqCkVqO/6hS/tzOZQttpf9Q
	3UEGfKzMR70Mx5VS0GA6qevr0i5KkG+Nzz/OrtRUW0WCgez4MpfT4EPNG1ScNv21W5iLYxghn8g
	DY63yMXhKqUyqxWDsqz34PQt2wt1avh2K3F9vV37pLX14gVq4MrGNku1ZPX12YVGiYylEZOMBpk
X-Received: by 2002:a5d:6d8c:0:b0:382:42d7:eec4 with SMTP id ffacd0b85a97d-385cbd60477mr1866280f8f.4.1732785050895;
        Thu, 28 Nov 2024 01:10:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsTuVKbDatDJibWkkBY3qyBNrUOmRjmmbtXs6DloxMmrX6/Eh68Wlf/OFtK/lIK3HxJfy0wg==
X-Received: by 2002:a5d:6d8c:0:b0:382:42d7:eec4 with SMTP id ffacd0b85a97d-385cbd60477mr1866256f8f.4.1732785050538;
        Thu, 28 Nov 2024 01:10:50 -0800 (PST)
Received: from [192.168.88.24] (146-241-60-32.dyn.eolo.it. [146.241.60.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd7fd3csm1101404f8f.92.2024.11.28.01.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 01:10:50 -0800 (PST)
Message-ID: <db62a6ad-b96a-403a-9b70-9223dc6a3856@redhat.com>
Date: Thu, 28 Nov 2024 10:10:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 5/6] usbnet: ipheth: refactor NCM datagram loop,
 fix DPE OoB read
Content-Language: en-US
To: Foster Snowhill <forst@pen.gy>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20241123235432.821220-1-forst@pen.gy>
 <20241123235432.821220-5-forst@pen.gy>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241123235432.821220-5-forst@pen.gy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/24 00:54, Foster Snowhill wrote:
> Introduce an rx_error label to reduce repetitions in the header signature
> checks.
> 
> Store wDatagramIndex and wDatagramLength after endianness conversion to
> avoid repeated le16_to_cpu() calls.
> 
> Rewrite the loop to return on a null trailing DPE, which is required
> by the CDC NCM spec. In case it is missing, fall through to rx_error.
> 
> Fix an out-of-bounds DPE read, limit the number of processed DPEs to
> the amount that fits into the fixed-size NDP16 header.

It looks like this patch is doing 2 quite unrelated things, please split
it in 2 separate patch:

patch 1 refactors the code introducing the rx_error label
patch 2 fixes the out-of-bounds

Thanks,

Paolo


