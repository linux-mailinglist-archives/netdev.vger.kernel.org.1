Return-Path: <netdev+bounces-263921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE2cOvZdqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:29:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EC463204465
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A394830634C4
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE035E954;
	Wed,  4 Mar 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXjZZcfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3635F17A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641054; cv=none; b=OSl/q8t0EW3jsTqzkX6q8cZ38SIiVCSi9acE558gPqvX30dztH1fWXiJWKw24fQ2fDXfJ6lt1LivCJo7t7TAUVcREF9UZtskvkFijwKIHaa47GSKJE3o7o71f/95lrVcoOO6zVSFZhla06Y88iU25am2U9OngKCdHz425uH2yg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641054; c=relaxed/simple;
	bh=Jvb1rVCOM6U/ZqwMEdVq2XIa/Y++7Mt5uVCXqrWQMRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hIrKA2Exs0K3By+lh0vKXlMWivTJbWmAjYrlmQHzv9ZU30afbaOLo4BTNjynhonDKGtst6BIAJVqgwlOzstF0LpPLXfCHpLeVH0/pUFHUEal+MhHb2khLlFTTBOPiWelZ6Mv9q0wHglhhiKW29OYoNfugx04PerFzoxHuVmuFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXjZZcfO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a1347051aso26613606d6.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772641051; x=1773245851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRJEH4pR8LqfPxQHnyHrv9zCGvjvaxYgR3oxj/WbAzE=;
        b=KXjZZcfOxzwN+IvLAEEd19+K4v97MiKyGS8LeI3d1J4IdPtVZUcfYb1kJNJOxZ1xIB
         8aCaAAgoSsFZNxWF58xxuriktBm6bEybXbNokt4rPxmF0OZ0IZbNgsGCvN9FYavY+9vW
         97C1tlh17ZkZbshuWhz2LQMlo1M7Xl7MJt0WTytvjGLbVEt/rfDos49+ZktrFlrncavB
         J+l7KEhXInhH1fxsfu5pQ97HItUFTTYwKNs76MbG8Ik50G24hfCoOtMSqigt0qEh3OCg
         PUgmfwslr+V0yNzLLjssIyZYNMyR0AXHpmBFmV/ChoN/GUhtnQJGgX1wzAEUn2sDaa0A
         ZGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641051; x=1773245851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRJEH4pR8LqfPxQHnyHrv9zCGvjvaxYgR3oxj/WbAzE=;
        b=nk6ULiV7IdRLpUgmIrdpd+Jgf5E98Dr1ksLhwhGqGGJxkBhJT7Y5szyDqFcJdD7RIe
         smScMdKoYj8Z05+8UcTPdZEHY/HDdMdrNiD7bILh2KGHHjf5Eyy+8IvZVXI2nJqYSgEp
         sx7CwzIYZRKEHsCoJ17d1qr2s3tEnTAQzNRDFLzbEuLBZo8IwI6G3cOrdHTkrnJlwve0
         6lvSY3FFl73RxlAsQlo2WXFKXyACmoOqaw0rkYWwSDJeN9kp6+89JtCfk7WNK0J6DrT5
         muGgFhNcZ0ygkmFdqDf2dm6UKp3wA70a0RtshzxJtAw/84907tB7kwuQd/9m1e5YSjhI
         0z5A==
X-Forwarded-Encrypted: i=1; AJvYcCV6T1rIv09VLwSzfnkX3KTlbZdOyabKG/5ZscqLIJMFrFOCBB969hCaUrW9WW1l5mENfr8Rgkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6PX/OQVEElcz6NBs4qFx8izX3/CNN4W7FUeHhCIRUB9MiHyc
	8OHQ9Q2RLocJh4qu3bB2/k9v1u4Gnsbjxfy/AQpyM3PqZiYnoMQVJrOc
X-Gm-Gg: ATEYQzzUdACoZgU1qeT+U4mETv7aJs98LHx0fpih2Qxh5PQ/MPQvETpPvqGTZm3dqXv
	R68GznRzNY5c84ViGFrwpFJLg/6S5IVHr0nPf9JwsJn6f3/qtO9BZrQOzLm2pcvmgzD3opQF605
	a+Ojr7CdE4FJZiNoQ+DL0+1O79V+UMbJuVTU5bml/UeztAACcRl0dhOoc5HgfX93ojB9a48AFj1
	pA6D4mK2hrx7Wz8Eil7YvwAfgqHlXevJ9XqPzdh2yhQWoT1Jl/7B5TcrTVm8AMvLyHkzkcPG62W
	y9jhFGeTmWCF44LTF+zlzoa6VmB5XXz7BMN6VI3F2fgUcYVj7URUz98ICnmvnXjL5jB3elXXh6c
	5m31+bHdmnhRGZLRwCGgxcok0xFA872XuP2KepLBmWUam8xogTsBBgXKT25CBlESamF/EIt8pRH
	9F9IjJTaymJuiNE/Qn6gPRenPTNItjvtP8cdyKxGOHaZS/3d6cg/q4
X-Received: by 2002:a05:6214:1c08:b0:897:306d:98c1 with SMTP id 6a1803df08f44-89a19d215c4mr34833766d6.34.1772641051357;
        Wed, 04 Mar 2026 08:17:31 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d19b:d485:ed5f:e15b? ([2620:10d:c091:500::3418])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e608cfc6sm100754396d6.14.2026.03.04.08.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 08:17:31 -0800 (PST)
Message-ID: <316b1fdd-f495-4a12-acd8-669ba5f2bf26@gmail.com>
Date: Wed, 4 Mar 2026 11:17:29 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 6/9] psp: Add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny@fb.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-7-weibunny@fb.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260304000050.3366381-7-weibunny@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EC463204465
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/3/26 7:00 PM, Wei Wang wrote:
> +int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_assoc_dev *entry, *found = NULL;
> +	struct psp_dev *psd = info->user_ptr[0];
> +	u32 assoc_ifindex;
> +	struct sk_buff *rsp;
> +	struct net *net;
> +	int nsid;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
> +		return -EINVAL;
> +
> +	nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> +	net = get_net_ns_by_id(genl_info_net(info), nsid);
> +	if (!net) {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_NSID]);
> +		return -EINVAL;
> +	}
> +
> +	assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> +
> +	/* Search the association list by ifindex and netns */
> +	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> +		if (entry->assoc_dev->ifindex == assoc_ifindex &&
> +		    dev_net(entry->assoc_dev) == net) {
> +			found = entry;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		put_net(net);
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
> +		return -ENODEV;
> +	}
> +
> +	rsp = psp_nl_reply_new(info);
> +	if (!rsp) {
> +		put_net(net);
> +		return -ENOMEM;
> +	}
> +
> +	/* Remove from the association list */
> +	list_del(&found->dev_list);
> +	rcu_assign_pointer(found->assoc_dev->psp_dev, NULL);
> +	netdev_put(found->assoc_dev, &found->dev_tracker);
> +	kfree(found);

in the case where found was the last associated device in its netns in 
psd->assoc_dev_list, listeners in that netns will not receive any 
notification that a psp device has gone away.

> +
> +	put_net(net);
> +
> +	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);



