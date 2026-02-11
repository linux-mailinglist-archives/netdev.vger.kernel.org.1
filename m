Return-Path: <netdev+bounces-258359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKxLGiDyjGmqvwAAu9opvQ
	(envelope-from <netdev+bounces-258359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:18:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E80127B07
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0991301C917
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015D3542F3;
	Wed, 11 Feb 2026 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRybapHc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4534F257
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844692; cv=none; b=rCeHB833fC6LC1OhnEsOLa90wpBfDKJjVeP5328snBk57r+nIKJfKEfjqRBhCk1Luj6/cn5b49xECOgXZhCF56XHL7PK5sk1uBwO0NMEWjx6+OyJFKH7MMiKBmb/C129gaMg7dakHu964n4KFWAVpD6H1ocmc+oDLUtG1Fu6zus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844692; c=relaxed/simple;
	bh=8WVSzAFHZ0uD1jFYXicORj5daPRN4knVO81v5+nxA8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuBn+q7Rar95NlBvNeuGq3TvLxs1VtDheNdTPUBS+UYWMWIEyJjzf04ipzEeWljdaCkeDX2aWTOXPtlFhGGYWmvFQo46HKU4Ya2OScRlFHFtw8C05D8v99MtKulDsp17Pyet5DkdHmSIojVIwPNXRmZNnZOKX3RgwfFPkYXx+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRybapHc; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba94dbf739so2320495eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 13:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770844690; x=1771449490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rm1W2/RdUc17RSuNVntKJEJGSadq+iXoYMQ0RQ2PvVA=;
        b=RRybapHcDynrrga2ft8mDOE0VKeU1928Dz05UZEESwRU1MzJiyND2dX7WcwZeRPvnq
         NrqB1FeJIcXBL0nHJoygcfneCLd/lg/wEGW48gWrKPDLcyqj2/3HRmaFHejmVeWosAXI
         wgFbXPA79z4zwb/9oEC5pf1WWI5N1Z3avqD74TXkFrD2IdmZza8/InI7z3d9UA/eQJ8s
         GcYnH2xJEZj7rc/8NaERkGHdEbeFz6WB3EX9E0aOylFCvvvldSuIxeIFx1Anw7beUPMX
         gibxq58lR4U39uE672EZkIXdyhLxiH02Pt7tYFB2oo/Vh/CZoRHTKJA9t9P8AxOcQf47
         Dxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770844690; x=1771449490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm1W2/RdUc17RSuNVntKJEJGSadq+iXoYMQ0RQ2PvVA=;
        b=t1Q+/xoOpBcs+bHDMAKMb6jhCw3wLSuOiZkClQmOP5o/4fYskaCC2ktmAiff84Yrhh
         fe1aRe/dHKUCV/y8Jt+9zeRkgf/NBcVxeqKd6pwVc4f+EdTT+p4iANQS9Bg1717DC3Dr
         V4uFr2Sp5vhOwL633hwuMq4ASA+SGNlsvCP/dIR9Q6qPtkfOiuTz3ABQIDToDpcedTpa
         8Y+970Z25YNGos/5+fFrebUllP1FVBokWoiUBfAZpNos0PuikJ+rTUQ2vbolztxSG+N/
         TNs/KC2z75bDj2z0rjF0O5UKCAxwxHU9NH9RPQGSp9AlvgBIxgPSW7T+ktGoGZiEelTl
         sgOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgqvTtP763MF3JD1chM0vf7o8JqOOtYqQyH1UhuyO/DVzhRIF0AKeNfEeHnaubmAB2de/Ry9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIu3HnR5p4X16wC8nwJCZp/gTweB02mUwyFgzSnwg452jNFgic
	YufM4G2Iv3mPqMbqEU3erRflHpjEo7EhGVNo8AHvmgYvMIswk3V45YN5
X-Gm-Gg: AZuq6aJ0lrX9VYIBIhhJAXJJ6AktepCpdBfNyS4lOD1BibcuhJhxRmR4vxT6g1pwJMN
	LpKe0WmQAzUgdUwJ6Yo1xcryZPXILr2J3lb4TWZjBa3Gem1xsuNNCj1YWm90AGCpEKZfSME5JzC
	zHx+QQyRdDj4PbY8C6zHq60RxllMMED0IFXjctTmPhX9n1GJ7ZUs/0UVS4Dag3iHEMBil2yandK
	yGcoHyPSS4gM+D1pn79hGLWQXuV9grbre5/IQWO6qee8RcvkOFXIiMF5ztbJMhioD+FC6aDE5Fy
	NelNpiG1JOdBcDdKBLpbbYcwtSa1ZX1RM34d5viJzvrZzGVtbahoPW7lfYfe/pU3AVjiYT0A56j
	Krs8BdPPMAohnqlKOuLCNCVm6pwkt00kAZtnDOlv0j6gA83uoEFbhIPpPAT5FP3WhwXxsjd0uCX
	i+zmVLiF1Lr7x9+/AiIFCponEsG+d1hCbp6W3GNcMk1Rfr3xIvbH2JRa0E8deMpLHihMs3i728k
	txjBgj8MoXSEQ==
X-Received: by 2002:a05:7300:2314:b0:2ba:a15b:5f2c with SMTP id 5a478bee46e88-2baac5b8f4dmr24907eec.10.1770844690248;
        Wed, 11 Feb 2026 13:18:10 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::3:7099])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcead76sm2008628eec.27.2026.02.11.13.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 13:18:09 -0800 (PST)
Message-ID: <7722cd96-49ed-4988-abf4-8b0755453f14@gmail.com>
Date: Wed, 11 Feb 2026 13:18:06 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 5/5] eth: mlx5: Move pause storm errors to
 pause stats
To: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 kuba@kernel.org, lee@trager.us, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux@armlinux.org.uk, mbloch@nvidia.com, o.rempel@pengutronix.de,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com,
 vadim.fedorenko@linux.dev
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
 <20260207010525.3808842-6-mohsin.bashr@gmail.com>
 <b108212c-99c8-4f02-9e61-3564e544eab3@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <b108212c-99c8-4f02-9e61-3564e544eab3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258359-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10E80127B07
X-Rspamd-Action: no action



On 2/11/26 1:49 AM, Tariq Toukan wrote:

>> +static int mlx5e_stats_get_per_prio(struct mlx5_core_dev *mdev,
>> +                    u32 *ppcnt_per_prio)
>> +{
>> +    u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
>> +    int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
>> +
>> +    if (!(MLX5_CAP_PCAM_FEATURE(mdev, pfcc_mask) &&
>> +          MLX5_CAP_DEBUG(mdev, stall_detect)))
>> +        return -EOPNOTSUPP;
>> +
>> +    MLX5_SET(ppcnt_reg, in, local_port, 1);
>> +    MLX5_SET(ppcnt_reg, in, grp, MLX5_PER_PRIORITY_COUNTERS_GROUP);
>> +    MLX5_SET(ppcnt_reg, in, prio_tc, 0);
> 
> No interest in all other non-0 prios?
> 
I opted for prio 0 for simplicity. I can iterate over all prios and 
aggregate if that's needed.

