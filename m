Return-Path: <netdev+bounces-287865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEbFOU+QBWrfYgIAu9opvQ
	(envelope-from <netdev+bounces-287865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:05:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2453F915
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF1BC30062EC
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5563D9DA4;
	Thu, 14 May 2026 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfWI/j4P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbFlIouP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619313D7D79
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749515; cv=none; b=kge5yisHVKpC29EqWlAV7aSIJ/5uxUETglW3YTIhGvpy42QvPqgZzFQRhZEbPyBYd3RLi8dXpAzD4aDJ0Ap31I7rJ8sFkN+FWFVfOO1JVzuxMZ9ywWmeJksLurYXBAeQ9Ivycgi++JtJCj7H27E+Xaa7qZHaO7fWBiOJWpF/A5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749515; c=relaxed/simple;
	bh=qVyr4qt77zsuqXZ9w/JXIjpv6jtxz9aHDD5YCfrstEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwshKj0exIt5i+jYPyoZ5zHFjCQWJ19fUB57p5YTl9lbItqh+HQheLu+y1YsTvLVrqZrlvcT8NCCOciD0yyQP3v5bF6ABP1E0IEyJp+g4Y924C+DnWp+VC0zfUrGhknLvBKESZL/p9ljhl8SewiypHvxJGbDE7jFhgbI+8Pn004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfWI/j4P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbFlIouP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778749513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CemDzzrwR3SGpVnjXIQxXW5PCfyUzVu1NubMUDPJPt4=;
	b=EfWI/j4PykZNIiWtia9Jd44EejJFwUMqtJyEwjEqvl6BQAWv0OFBM3dh1w5Lki8+89ev+l
	k6tPTO3rmVuU+jhL0wIhHRFtlXZx4cnnOaSJpNLM5sm4GqMNKrfe3NRKrEKgd/hKcb/4E0
	FsZjS7y6FppUgfWwSM6pN8iGXZZKAks=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-Qq2ZBc4yNgOqTBylsVtfDg-1; Thu, 14 May 2026 05:05:11 -0400
X-MC-Unique: Qq2ZBc4yNgOqTBylsVtfDg-1
X-Mimecast-MFC-AGG-ID: Qq2ZBc4yNgOqTBylsVtfDg_1778749511
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e51dc35a3so66240485e9.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778749510; x=1779354310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CemDzzrwR3SGpVnjXIQxXW5PCfyUzVu1NubMUDPJPt4=;
        b=KbFlIouP5PsMGl9utsOCb6TIQnPu3Bq0GK5s/G/FB+LpluxxFFI8OO0zP3JmrvJ+DI
         VezaG5fYA2ogipVnzoS+SaxklbXHUWZG3Hs9Ri4fVvuJti3kGo7dVR2nscjHdC0az+Re
         nDnpUM5auvRsagT+SaT8gtO/wr2DvHoo4rti4tKC6mM2eviSyGvCatpiiOu4DPGghSEn
         RNVnXGDWgmZdfp8Ux77ybytkqHz3rLjJqdUMVINgSfOjaAnx5YMwMtqx+PT5tMQBFzJu
         htFioCsp28DHGjXXeaNcppbi+RcqBNvm09PVzEBM2kvfJZWNtZZKMeUukBcCgaiMbhfp
         K2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778749510; x=1779354310;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CemDzzrwR3SGpVnjXIQxXW5PCfyUzVu1NubMUDPJPt4=;
        b=hsnY73rEn45D5daRx6iWnB/MaJ6RxLcBetQJBApBa0MRChYa3l60tpJn4bgh0wpC+j
         UNk0tMUlzbtJWqrFUh6EHWXrcr7Vqz8Ija/xNjN0GaMAiDd5FYssFbiSDvD7rlVCvCa/
         WHmLDVmLm+haowBuE0WuLw61N3VSMEVD66o3KiL3gvSUbRgEpAE5T2f0klizJsWheStq
         HKR/BVPgPIY3xWcuRo6EzV//jy8Zz1DTxLl5OFpR7ltd8QG/Ovx4h3xOfEUNG69SvoZW
         jTJE7JalNOmgZLwSl29rlUb4jeiUbhlJkMuX8URyJeKquDV20lwLIxxcF8/3Spe/DZfh
         3now==
X-Forwarded-Encrypted: i=1; AFNElJ++wB7iCHE7PtEo7yK6eHXea4xLPj6TytgfULjr/gAXIqDC+3dAuBM9B6lOLsaxZYxItB6S7A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMcg7MZIqxrH2IMYAV11ZLebgR6KiCZ97HQak/1IjeC3RC0iy
	S4XLQed7568/GjoXpPpA9MzMwbeLgKDDfrU1Pw/DbujLCG/kSpSVbssrTMHrrSS/4Fe9TTobetF
	2h7Asjqin346ajlvA7MvOeyVVlmCFFBx01t+1HL4iossmZ/aAMFIEVLhoFA==
X-Gm-Gg: Acq92OGJxAV1u92FTOEh/CO6QT/dGdNFzKe3oirJE6AoCHEGoAVKPRDTT4dFl7xVaTi
	Hp6SxhOB3s02NPzeA1Do87SmmL+qPJraNXe6GCV8L8XGoPihkt/ahRr5l99PZ0yF7vQCd5enovr
	8WCt4SeGJo2oAipxwUN3KHatpT9BBkz/vkc5tA0aWE0fTqTzUF5ZS+Vrp6G8DmVM4DVv8UodDLq
	5PyO2UkdGpVGSBtm8K+6hHsNM5NxmWp8MgiryqVCcdA851ZTNs0cPWBOJGRRoGo4sAa9Vo2RTUv
	bU0FydMPAD3tVRY2oHlyUvWJ50B5/Y0/PlkFHU+p6J3McwOIfZ1JsFccH7zzkT7yOY2z4ikZGgd
	qX0ROkntb78qeRHMB4Lc5S2lREW59QzeKv/ECTyVaG4YG4OsWxSUvD3k=
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr101445195e9.19.1778749510621;
        Thu, 14 May 2026 02:05:10 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr101444475e9.19.1778749510167;
        Thu, 14 May 2026 02:05:10 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd648a7e5sm51353085e9.3.2026.05.14.02.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:05:09 -0700 (PDT)
Message-ID: <73a19f89-ccd7-4762-8e07-812d8d95ead2@redhat.com>
Date: Thu, 14 May 2026 11:05:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/13] net: lan966x: add PCIe FDMA support
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Herve Codina
 <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260508-lan966x-pci-fdma-v4-9-14e0c89d8d63@microchip.com>
 <20260509082720.503A6C2BCB2@smtp.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260509082720.503A6C2BCB2@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 61D2453F915
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-287865-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/9/26 10:27 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
>> +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
>> +{
> [ ... ]
>> +	/* Get all received skbs. */
>> +	while (counter < weight) {
>> +		if (!fdma_has_frames(fdma))
>> +			break;
>> +		/* Order DONE read before DCB/frame reads below. */
>> +		dma_rmb();
>> +		counter++;
>> +		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
>> +		case FDMA_PASS:
>> +			break;
>> +		case FDMA_ERROR:
>> +			fdma_dcb_advance(fdma);
>> +			goto allocate_new;
>> +		}
>> +		skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
>> +		fdma_dcb_advance(fdma);
>> +		if (!skb)
>> +			goto allocate_new;
> 
> If napi_alloc_skb() fails due to memory pressure, does branching to
> allocate_new prematurely break out of the processing loop? Since the hardware
> interrupt was already cleared, and napi_complete_done() is called below,
> will this cause the RX queue to stall permanently for the remaining
> unprocessed frames? Should the code drop the packet and continue instead?

I went over the series and sashiko feedback, and generally speaking the
series LGTM, but I think this one is real and should be addressed.

Also it would be very helpful if you could (for future series/revision)
reply to the (wrong) sashiko comments individually explaining with a few
words why the are off: decoding the context requires much more time for
whoever has not wrote the code itself.

I understand that dealing with AI feedback is a pain, but, paraphrasing
a great aphorisms creator, I can assure you that ours (maintainers) pain
is greater.

Thanks,

Paolo


