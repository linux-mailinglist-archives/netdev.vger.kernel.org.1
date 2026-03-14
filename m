Return-Path: <netdev+bounces-267818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCNrA0SktWm32wAAu9opvQ
	(envelope-from <netdev+bounces-267818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:09:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C7528E601
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B94B300F1B8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B4332EB1;
	Sat, 14 Mar 2026 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDusEpQe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D772930B514
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511741; cv=none; b=nLICWymtsaWkd3Wa43P7Vs4bowaRurMEguI11kdh6D2RmvMEAl0J+QHgsber1MqEKEhSuvoGty6LLgWiJYcff8YNgoH0DN3bUuKZT2lku65PnOVf7hyT71m8AfNJVgT1Td6ueOpmwoZhzXpcbmcbFOfRVO30Tyojp/JJasjVs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511741; c=relaxed/simple;
	bh=sgqL8KpIIHRD9MI6qo6387VoZioZ038KUxLGGgRk7Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih79n6FHBdZfDt/xCJbodWmNyi7VwOqJLUu6m7A7wyuRIPS5cFdiaqCSL8s6uZJvw+bH8/6n3CHMImeIDN1D3L4As7bjLaCExcior9navi+c2mOTTNNc6Ja97RlSqWphMY5i+3ZjXrMx4hCR9IWvtf50+yvmGesod/97S8zN3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDusEpQe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so18283045e9.3
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773511737; x=1774116537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwUtMn/m/4+36i0A4XHwUjxig/62BCw6PL79NAq4P3I=;
        b=cDusEpQeIyxY2aH8W/BEAGV7f6oFyDNB3Ah/neGXABIRHCI5ltgydIbHPfgk4EnBR4
         xNOd147EhkkhI5PP3ipDqK/MpG42FfWxHJXq1d6EO2qZw5icXC3w683hwOYLtCbq1E+I
         ZMT6jXsy3Tag9sTBFDiT/9L7VGCsl+Dcf29RxeMa7pII/97W/4O9Vk8cDxnRXpTbHhZM
         NHZjUK6rzcqKbq8v6IuJW11Ih98YYXqVSVn3mEDCqi0g/BDj9UEJeulnQ4o1j5Wh+3zh
         SfzkC53L5TylXepnp2n3DPovWnb3rxqxkj/6fDxd9YWx0A8Ep0T4JP4CnEBAE+fIEAuw
         6z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773511737; x=1774116537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwUtMn/m/4+36i0A4XHwUjxig/62BCw6PL79NAq4P3I=;
        b=gz0XxNPpcsITDO0bHkECFWtcRmdBKjLwcUqV5aMbZ+K8+QobhM7MT0+1CB9odeCvuR
         vm9X2up4mYiGQyRoDtvbGj2OS8KgFxJFCfILYTtxrwYRw+hoYiYReSkDc8+OEC7kGeWu
         5uRWua/+Lqw/iFwaigMm/UWKgZokLyjntGBnTeG1phG0AcoCcLjzvyjxzlm9TmcXWBPb
         7+BouGN0A8dE43NuwI4ey5JF/BUmoyW9Y0peIf2kZacJjj0vfdhV/fR8wyvgG+bFzG46
         SZCu6JawksNXXQTVVdlh4coaRAk/ENFRVkVYbegpcqg0ghcLDLxSg255alhu2fAGTe4m
         t5bA==
X-Forwarded-Encrypted: i=1; AJvYcCVbE7lfK6Eg3EqdWoiys1j2oZlq4azF3Au4UckM6LoVswT1hE6NsohFekg4gNc/7XsGqD3AuoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywquvi/In+daiOrmsIAjpyCsO4WOFM486Wn0maU3qsvPZYdrrv6
	avAJ7Dhc7nhm/y4Ftiv4KfL0q4McK3oVgPvasQS08ayn2YFe5eeIUo90
X-Gm-Gg: ATEYQzzRjwH3B8uGKUiEDHWW7vUTEag2/IEVvhB5yU4K5DGu6O+eQPkdhi0efmqsGoe
	eJPsFRzNnoV4JfpYhPrtSLs2psLAC1YBOLqu/1kt3KMiZmtIEN2yjTCzAGcf2DNGaV7BcBGP8dn
	GlR3jbllCDLqXht4KDmSEb/w4bwWReqfaJIk1FpJSWKqiLrziV1/YvhLpx+iMIabBJ+41JrG5ov
	JdtoQDCMfYR2XL+8+W38pxVFm40BPtvfSVj8NGuzxq2WUhhvih8GsHV7i05Oa4CMOgEULqnFs/1
	ZMSOY3mAAisLaR/+89UVdRKrToqA+HSZv8qGZYLZPpdYHdSFmCdnF7qwCr33frfo1SVYEoi93NI
	qLvbuGYnf8KJSqsMRwtC9V1FQLmnqfC86tO3tq3CFcFzkQ9oZzuWBM3HOYMBqwbAeZzXRe75GR+
	Rtt51MfbL/jxnRKWfzU2ck9FTXv0dQnZq/pAWWxIMJF98JV12bxC2g0QCZ
X-Received: by 2002:a05:600c:1e8b:b0:485:4278:24f0 with SMTP id 5b1f17b1804b1-48556728bf7mr117765285e9.30.1773511736863;
        Sat, 14 Mar 2026 11:08:56 -0700 (PDT)
Received: from [10.125.203.73] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm31539541f8f.34.2026.03.14.11.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 11:08:56 -0700 (PDT)
Message-ID: <d700f3fc-727f-4321-8bdd-43c36a2dbedf@gmail.com>
Date: Sat, 14 Mar 2026 20:08:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next V2 0/9] mlx5-next updates 2026-03-09
To: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drory <shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77C7528E601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/03/2026 11:34, Tariq Toukan wrote:
> Hi,
> 
> This series contains mlx5 shared updates as preparation for upcoming
> features.
> 
> First patch by Alex contains IFC changes as preparation for an upcoming
> feature.
> Last patch does definition movement to expose a HW constant so it could
> be used later also by core and Eth drivers.
> 
> Patches 2 to 8 by Shay introduce mlx5 infrastructure for SD switchdev
> and LAG support.
> Detailed description by Shay below.
> 
> Regards,
> Tariq
> 

Hi Leon, no comments for a while, let's merge it please.



