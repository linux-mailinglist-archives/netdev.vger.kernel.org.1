Return-Path: <netdev+bounces-240348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E9C73A63
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D14A3513F4
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F7530E843;
	Thu, 20 Nov 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpdWvT0u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CScb18ra"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91232F74F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637099; cv=none; b=QNsPNxQTdbZ1MuT1kf+RZSuXrRRepHKDq4KW2lTsroIUSwUr8dUdb1F2dORERUFAaJHvPNw7nVmsjmfUxV+Pazweww8pcop/3TKskRVpjLStyFASA+rvZP+U+PzGAZLDX4lMkTuK3ln5ORrqzHyx6L4N6spqEFEC/eQXrzHpy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637099; c=relaxed/simple;
	bh=4w94fCVl14EEV0Zihb71NNS/ooZ/eDdAuYJP2GMD/70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6is15NMPzvb36tqcSF1PZwBLKAUF40g+jH+4sC8tWPfI7X4i2IGXlqBocreI1uGUwTLwY8X2b8ZhBkKrYPQfkpVrJh7OuCv9UrHKByQS2JNPjQAJKc8qXA7XoILVFsLteg+p+l1JSVyGH5db7gPgVCGx7UMTBXqW4iOVupqtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpdWvT0u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CScb18ra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763637096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
	b=KpdWvT0uZ2qx+QDM8CL/dLdWkdlp+uRU9HduFtVwF1E3xVDt9lBCRk3An4OYcjD/XuozMA
	GS/84mBCzzE2YSTMN+t0MQxhn1HUj5wjw1g5tE1Kch/bSvZomHrNqWQ17yp2KOmYztvZgY
	3ZrbSV6D+LzSDH2JblFNSAeAEmwV/4g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-IRHpCNvIMmCbTwVh-QJGIg-1; Thu, 20 Nov 2025 06:11:29 -0500
X-MC-Unique: IRHpCNvIMmCbTwVh-QJGIg-1
X-Mimecast-MFC-AGG-ID: IRHpCNvIMmCbTwVh-QJGIg_1763637085
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47754e6bddbso5218485e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763637084; x=1764241884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
        b=CScb18raWHf2CQJLRDUi+l8B51BmVrX63VFmtLeUAtYlhRak/R/TCDgO+VJp69KXqo
         Y+itwfjb52IW8k7ojUeCy0Aj8yU0lSf7S7RVZ/joHObbAWxw1HRG/5tLAzOzVH1Uf5UD
         484OCGFvuf8vrABUtbgzrk0y7DLCNZX+oRgsukkc3N2OW2TfrbvRYJcnym7ycGwTOcgr
         W5SPH8Q0eHi1RMl3Zt9stGiFjnP2V03ZcFycwGt8GYTPuEU6U4SzlhOx/mbKOpm0z0Lo
         FyALlrXpRTFN7PdDP33mq3Z4p3bWNaDp1ZQD+PYmFGuhoiG1ZjiqfHiRzC+L2ED/ZVgh
         sKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763637084; x=1764241884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMS34UwrZ8S2nle8FVRzl8w579va+uy0VBnhRljJShQ=;
        b=OsRcAN6rsOM8r7ixu72l1G63CHcmXJWfSRhyyHbcfOCVkpHy2UIMmT1tOSsvhqMdv0
         43qxWnOT3ysSkpng0hK5L9EZzend1znejA8tfs6nuFALY0X4NAqJ8Sicq06bqK/xUPqM
         kvU4cWuVuS1BOi7TxffPRuN9yAWroY+A/M06DQ010+NY2w7AnbBBVXd4eHk9mgQdkykF
         UzoE9+JTy4+fm+b5e3huDEDXKeOHD5ZT6UFJTmoGkhVVK6w45J2iM3Tjm+NnzZIKfx40
         o/ma2bqQGjLRVyjpTYZ+FMlm1Y2HUR4JfXFfqml79HA9+al5TuzrEYsPqj1G2x9SP2gz
         pjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7fE4ElCragRN1IYms71mI+k0Wd2u5hyDVqrIlEHJ9gYzNznENCuW71b22XOq4x3g2Z2Bccg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMXFmn7iMzzvSfTcr++pic70gv7cbKth5LaJ11v9S2Ice7zbM
	kjSwu9CuqAYnAp+9wVHyXo/h70o+GrUE5YYhM90cPfTLgVkCXlmG6aaGu/jEDMgc3+AQ9T8YzHM
	/UwrndBkLGw0Ei260vmCAEg15Iyq18o8KAcCh6r4gax1mta6Or84B2m4XIw==
X-Gm-Gg: ASbGncssOP/YRtdQbyZVeXZNk+8+ci7to8Xjij4aZKJRHEWKPSB1trf2GjoXKuLuycB
	+YuGeikKqsoq292H9AaIIASzqm8KPrQcRgQRc8a0kUGYCYKh5PApxd8smweDkVtIVXdqu3JP3r4
	aIiVWbd35UhXhrGo8q+G/d8RcCBa0cqYXRUq7Ze7J095uAj9AJiC6m9xZJitKH0M5/mdtWPuiwS
	jcStuOsq8DRPYV4iZhZ2RFsLXgw/kdqOaLiVZ5DlpMXn3Pt90FBn510NvDDPh66HxfHQP9A2fP4
	6zq9mYBjYi9XrgPVXSVKMp4cb4oSWow/zl7LSmXQBfPlbFdJDRjgKBx23yTr1w1fmw+vKUVHPjC
	w9D/6sqj+Glmj
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-477b9ea4d28mr16744335e9.5.1763637084545;
        Thu, 20 Nov 2025 03:11:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/fUTeDI0WH8NPmq3GHHJh/IHPYx2tPHiKQdM9TuqaRUB2LyRCR8etaEIrIUjerN5jw8l6jg==
X-Received: by 2002:a05:600c:21d6:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-477b9ea4d28mr16743945e9.5.1763637084152;
        Thu, 20 Nov 2025 03:11:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9ddef38sm63385435e9.3.2025.11.20.03.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 03:11:23 -0800 (PST)
Message-ID: <7d835eb1-f111-46e5-8834-a1fafb53bd8f@redhat.com>
Date: Thu, 20 Nov 2025 12:11:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v2] net: mana: Handle hardware recovery events
 when probing the device
To: longli@linux.microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Simon Horman <horms@kernel.org>, Konstantin Taranov
 <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 Erick Archer <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
References: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1763430724-24719-1-git-send-email-longli@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 2:52 AM, longli@linux.microsoft.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When MANA is being probed, it's possible that hardware is in recovery
> mode and the device may get GDMA_EQE_HWC_RESET_REQUEST over HWC in the
> middle of the probe. Detect such condition and go through the recovery
> service procedure.
> 
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> Signed-off-by: Long Li <longli@microsoft.com>

Does not apply cleanly anymore due to commit
934fa943b53795339486cc0026b3ab7ad39dc600, please rebase and repost.

> +static void mana_recovery_delayed_func(struct work_struct *w)
> +{
> +	struct mana_dev_recovery_work *work;
> +	struct mana_dev_recovery *dev, *tmp;
> +	unsigned long flags;
> +
> +	work = container_of(w, struct mana_dev_recovery_work, work.work);
> +
> +	spin_lock_irqsave(&work->lock, flags);
> +
> +	list_for_each_entry_safe(dev, tmp, &work->dev_list, list) {
> +		list_del(&dev->list);

Minor nit: here and in similar code below I find sligly more readable
something alike:

	while (!list_empty(&work->dev_list)) {
		dev = list_first_entry(&work->dev_list);
		list_del(dev);
		//...

as it's more clear that releasing the lock will not causes races, but no
strong opinion against the current style.

/P

/P


