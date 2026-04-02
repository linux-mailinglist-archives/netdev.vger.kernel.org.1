Return-Path: <netdev+bounces-274432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA3FEt0uzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB638655E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49CF03035AC4
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8C3AF67D;
	Thu,  2 Apr 2026 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGgNpv97";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfJKtm+b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF61E0E14
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120089; cv=none; b=L2qystHkCZ+kiZv3MmDTwaNwxyX5su0xmhH8q33QOQxhmIR+QttqhP0MXe3nDRSWVpaKIaGEcHb8pH5RDnEAYKcKJDpxZ4+cWRUD0MrVT/O3icPlcJjPPQzzz4DJpvPaOCDd4O1VrOIS305lNOfsZ/u2Xu0JX8gtFy60zFpfVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120089; c=relaxed/simple;
	bh=TmXtfrkVEQnquTCvxTkGtndXJ71C/6/lm3RkiXKS5DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUJhGnmCjubmjO3Xram3c/adRwjNEpjHHRqzUWqN9UGOUql+FwwcAWxRVaUIJIRLK6Rt+8cjkB7lqsGt+UcaL0k7wABtNgf4kW3/1KrJ1KVlWeiyAUmdC8WEolM/rwn7FGc8sYmR9PLoMZ4p5uq7yPmfoIA71YjLF6I5pfu7TX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGgNpv97; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfJKtm+b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775120087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR2GdOsoccNygo6JqgvzAS/wYB5w56TPtdWluZ2eAI0=;
	b=UGgNpv97e7xwCY4irYpGBhtn16AUow/R1LaN/jkGA/vKlCiTOd+KdXWq3YM5rUHrbW8C+t
	bFiiqSWySsB9lOEJ+Yab66hQdiiTb4PNa4o72iKIKVczohPhCNzeAqeQ54ee89lKYE2HM5
	aJJUtXGOZQPFykjZ7Wskw+RU7Bo1uzY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-ZKL6tLdLMiKeEj0-Zz9v1g-1; Thu, 02 Apr 2026 04:54:46 -0400
X-MC-Unique: ZKL6tLdLMiKeEj0-Zz9v1g-1
X-Mimecast-MFC-AGG-ID: ZKL6tLdLMiKeEj0-Zz9v1g_1775120085
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48886f1bbd4so4574455e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775120085; x=1775724885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR2GdOsoccNygo6JqgvzAS/wYB5w56TPtdWluZ2eAI0=;
        b=DfJKtm+b5gXvZbryMu8d+RW47uvvbYOzIAxitd8pyD0Js9czDTQfn0upguTpz69UXN
         c59c0xrvSSIOJapp2rQqkwbAIYAv3m/zwYAq6mrpCXbxaUbYdju0u7L+0LhGPQq5jK+s
         GYQtqVtGhml2nD9kSqcK9aXV07rIXdEL6LU+WbPAc1kFw5usjLjsyh5QmYzFH+jyX3mm
         fEwzLHhjNp/XLu2XfgpRb1tk0KNaZMEqJi4GIMkxxkQxZTJcZ0ZEixLzts1/SvOha/iX
         nwSHD7rAX6tDiBi/c6kUur+Tuh5wZfvuHQrAqjhvIPtpV5oQe1e+CndLw3J3M1i53v+9
         cZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120085; x=1775724885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR2GdOsoccNygo6JqgvzAS/wYB5w56TPtdWluZ2eAI0=;
        b=ARHNyMbNGqdobzVsxcw7mujaC8A3vVsYdaVV46r0sD2BJydVv33FjrSyqajwfT8bvd
         2L8Qzwj7/+aZM4/HGzQk+ZEnRkeZOQPr3FPWHCibzVWhf2gO3MIA89evNXM+DXMr23JC
         hERrq7irKPy8pkx0cahuCF15oLKWPiK+x6ueywr483Z4cFB6M1KZTjaSfsPbUgyEGjeg
         LoNDx/gSm0uwdgPSfWl3MhkZVyFyrKZ1XDFImRDItja4VY0D8/S8HdzitS4tLuy6Ov6Q
         W2qonKMtCHIx/ajutMqlM3xoO1riZtVGNd7p8QzYRd5Gnq20Z3ORYKteeRPL2jdR7GAR
         FEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo3MRSW2ZW4l6IWVeIHvUL5dA2F7ZHAbzAnbR+UXyPbHJIl1WTE1g2Ha99+NGBjvDi5MPWgeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuoPFo8Tkw2qJxgwkwK3zSqDfnNtJx/MTQ0LJUfDFc70RIh0Aa
	K2WzCTNHIfe9fWQeD34g/TIyzGmAf3eL5uCnkfkkXXs0qOBiOPpiaExIeSVXgp84b0YoWFvFLun
	rP8JXcyN40DzXmfdiwzZ4vOOIPzBXp6niEmgvwyHJyxtFZ9fFvr/R6LrNDDp3NoKB6A==
X-Gm-Gg: ATEYQzwcYQizaZ9pqB6VtQCBHOkIdAtVK7enaGhw+Dqy6Y/Ru6fXpONHYui0QPyHeU6
	HDxJalVf2Z82dHjegviiFyYjk78mmWNaA1MA0R3GU8feyfUoIw5aa9bkfKzqZ914KFTvsTPvvQl
	lBUjeY/wYVWiKX4KSWVbyUglyWw2y9IHqwoLNtq3E5Fgql1DQpvkzhmwk6hCI/gIDAAoM3Qheof
	fFV2HEEp767mXQyLhclukS4FQK9RqHUE1dx9vnDnnnfy4j7PtEQb+DTKO2BfTNnjSTrLBuO/eSF
	+Wb4dUmchLaBYnyYYya2vQAnwd1FwUALNiKoIwtHN1mxIbxXaRHCkg0tydD6USfzimvddqqOWCb
	Xwkb6huoMUdWV550txN3wPio0oTFUY1KajyfVBx/LeOxx4gxPoXMnL/1vaA==
X-Received: by 2002:a05:600c:1d16:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-4888359d2afmr115404855e9.28.1775120085090;
        Thu, 02 Apr 2026 01:54:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1d16:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-4888359d2afmr115404265e9.28.1775120084622;
        Thu, 02 Apr 2026 01:54:44 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e93cf2dsm162267625e9.11.2026.04.02.01.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 01:54:44 -0700 (PDT)
Message-ID: <ac20d8bc-4af5-4338-adc3-01e4aac4e70e@redhat.com>
Date: Thu, 2 Apr 2026 10:54:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 6/6] octeontx2-af: npc: Support for custom KPU
 profile from filesystem
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, donald.hunter@gmail.com,
 horms@kernel.org, jiri@resnulli.us, chuck.lever@oracle.com,
 matttbe@kernel.org, cjubran@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, dtatulea@nvidia.com
References: <20260330053105.2722453-1-rkannoth@marvell.com>
 <20260330053105.2722453-7-rkannoth@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260330053105.2722453-7-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-274432-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E3BB638655E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 7:31 AM, Ratheesh Kannoth wrote:
> @@ -1635,9 +1651,9 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
>  	}
>  
>  	/* Verify if profile fits the HW */
> -	if (fw->kpus > profile->kpus) {
> -		dev_warn(rvu->dev, "Not enough KPUs: %d > %ld\n", fw->kpus,
> -			 profile->kpus);
> +	if (fw->kpus > rvu->hw->npc_kpus) {
> +		dev_warn(rvu->dev, "Not enough KPUs: %d > %d\n", fw->kpus,
> +			 rvu->hw->npc_kpus);
>  		return -EINVAL;
>  	}

AI review says:

---
The bounds check was changed from profile->kpus (which equals
ARRAY_SIZE(npc_kpu_profiles) = 16) to rvu->hw->npc_kpus (a 5-bit
hardware field, max value 31). Can this cause an out-of-bounds write?

In the subsequent loop at lines 1658-1685 (visible earlier in the
function), the code writes to profile->kpu[kpu].cam[entry] and
profile->kpu[kpu].action[entry], where profile->kpu points to the static
global npc_kpu_profiles[] array that has exactly 16 elements.

If cn20k hardware reports npc_kpus > 16 and the firmware provides
fw->kpus > 16, the new check passes but the loop iterates beyond the
array bounds, corrupting adjacent memory.
---

Also there are several remarks for sashiko, some of them looks valid:

https://sashiko.dev/#/patchset/20260330053105.2722453-1-rkannoth%40marvell.com

please a look.

Thanks,

Paolo


