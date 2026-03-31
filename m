Return-Path: <netdev+bounces-273648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIfDGy3Wy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:11:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5236ABC5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB645312902A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65C3F9F35;
	Tue, 31 Mar 2026 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y20Y33KU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F93F99EA
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965856; cv=none; b=SDiOqgtVEKkL64IhgyxiRjtX+f2qGx0PgqpR6W65xXinJxOxMjyHkCohZqqvNt6KO+vKVH8iaII6pkDEJbI66BzXq7gp0wugJbkXXkqyT4wRjPVgWmmk+Nq7ow9gYAYq6nwtpQK1DWdX7eOUpPHCyyXYJQxY8FHXPpHu//xRxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965856; c=relaxed/simple;
	bh=37nbG4gJmkccQcIksDYjMXdd/xnpcnyuONrB5wJuNSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIsUvd+AjMv4WoBQLkKFu70dvnBPpp6+MMT3lvgQYWvsobfrATV1pKTIB65WkSzOH3YpDXpSMgSF0pOGb8k40HZ5cg2ryzYC3F1ZLxk6yoC71maEKTMG1VZylEn2Tg0ovaQfWAbaIJZbyz3hd9NJXxyc6pc5c84egh7Xmyk2Qz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y20Y33KU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89cd8596724so63558916d6.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774965852; x=1775570652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdS+/cZl1pi2qzLz4uyzHMn5VKIUFezcLCJ+nH+UYH4=;
        b=Y20Y33KU/BehCMgY2VnTTIe2UZMwB2ULoAyijJ7gWqyAyQeG4P/o4TfPI6aOjq4xda
         qKOMy4JpMQ9qINreHzcF+RPzsxqOcKvaC4wNf+zwjMcUo9tuGGMXKT9YGjGd+2Q+chbl
         NDLMcFscQ9mkFTnZDkg5yTxrSD5RkzF4AFd9PpC9muIJlgpRBfBob2+cfqNtlczz89NR
         Wnc6iE1rz+TjTTKdeKciaZlGno54anmGU1gtCyWqGhzA06Vd+zPn073HrBjb5mN+PGyO
         bbcQLe/iOLkIRCDyRUQbXLN8FaPm/kUjYNoHwrW59sj6nNHcHT1U97nkVva+bGbFWG7h
         LGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965852; x=1775570652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdS+/cZl1pi2qzLz4uyzHMn5VKIUFezcLCJ+nH+UYH4=;
        b=IxOOB4aSU0rybFqmT805Gxe8FlCEVrbeeLufaPqsog92Jif+phIBIlbdnn8/MoH2uO
         OUrxLwGJhE09swHi4oOA0xSzJ4egzhm1e9aPwUpycjCJumLGtugAL97IfanAd3KumZss
         5vaGamPSKOd0mnBwNoH2SwVxg72xbLq0WuVUj7b9aM8vjmX+JNjLdh1TdC7a95+4SyHS
         VJeE75+QDN+HoD36sQYPrhGDPLuvCx+ogyTkDbOvLGyfqLi8IM2TRGR4B91nLZnZSyiW
         y2bW32EngwnD9gpOgK2RtB4Gv61somQ6HQ8WexZHk29rW53sNLXvU4/4CdSbNcgHX+RV
         1/GA==
X-Forwarded-Encrypted: i=1; AJvYcCXLPBEJQwC6rM5e4nlJkDyaxEtmAaU8dybe4ZkZQR1XqjZtHr4lMGp0oEs6KqGbGOlIsxjX+po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SLvri0eoMKy4BW3/3cRBWFvBq/4bLyLdMmeXN+/cMNKO8HDL
	IYsnNPH/pAT1MEd/Qgs0SmQwYw/GGKNVQeHAewMUhFff9O0Dp6sBaGtU
X-Gm-Gg: ATEYQzx99qGPKJV23kHMfd1gws9cmKicPz80RhuN89KXMeIRZ+c/Kv+rAz+ugzYCO/h
	0zxdTNGYbE/OP2f2Tz1/RiLs+fRtA+9rNwfzPm2KS6MmUWTdVVxTjvC0S6FVq9qYZG+Qq265Vht
	80qmol+ecZ+Q+5xBL28uuU5sX2Ie2YltdWkJpa47+shLroA7tdk7nrQ+JsrVRdix+aSHVEMK0I7
	04zIV52sQJg5TNeRitpiyftnmB8nmZK1VOgLzyXnNG3wKHUGkmv/LcZPcJjQT93ZIsB+JCmRyq1
	NMCSsJUsn7pYfOG1qGpCMe3Y553XbjVJ8TGNvWpht/UvTw6nsH1+4aGdK83TyEgb1KdD4NL4bmg
	mDYD8eUrTOV1Z/HWGG/PJaGbMGhYv94L9NdEhnMQWI6tIPTbyjNDgrp3n0TqXGGsYdFJfOSLXUc
	4HhaTp2CORaldg7oYjb1vTd5GByThQBB5KtsKh09WnH58ARC7CpLG3tvi+9DeNqx1lk0OAhNted
	xS7JZ+/iqCARE0=
X-Received: by 2002:a05:6214:c46:b0:8a1:e26f:1c30 with SMTP id 6a1803df08f44-8a1e26f1e1dmr92249236d6.30.1774965851499;
        Tue, 31 Mar 2026 07:04:11 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:c599:9014:d27e:9c09? ([2620:10d:c091:500::1:4033])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecc1923c6sm90470666d6.22.2026.03.31.07.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 07:04:10 -0700 (PDT)
Message-ID: <956aefbd-b795-48be-ab73-58f489b1b535@gmail.com>
Date: Tue, 31 Mar 2026 10:04:08 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 5/5] selftest/net: psp: Add test for
 dev-assoc/disassoc
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-6-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260330223143.2394706-6-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2E5236ABC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/30/26 6:31 PM, Wei Wang wrote:
> +
> +def _dev_assoc_no_nsid(cfg):
> +    """ Test dev-assoc and dev-disassoc without nsid attribute """
> +    _init_psp_dev(cfg, True)
> +    psp_dev_id = cfg.psp_dev_id
> +
> +    # Get nk_host's ifindex (in host namespace, same as caller)
> +    nk_host_dev = ip(f"link show dev {cfg._nk_host_ifname}", json=True)[0]
> +    nk_host_ifindex = nk_host_dev['ifindex']
> +
> +    # Associate without nsid - should look up ifindex in caller's netns
> +    cfg.pspnl.dev_assoc({'id': psp_dev_id, 'ifindex': nk_host_ifindex})
> +
> +    # Verify assoc-list contains the device
> +    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
> +    ksft_true('assoc-list' in dev_info, "No assoc-list after association")
> +    found = False
> +    for assoc in dev_info['assoc-list']:
> +        if assoc['ifindex'] == nk_host_ifindex:
> +            found = True
> +            break
> +    ksft_true(found, "Associated device not found in assoc-list")
> +
> +    # Disassociate without nsid - should also use caller's netns
> +    cfg.pspnl.dev_disassoc({'id': psp_dev_id, 'ifindex': nk_host_ifindex})
> +
> +    # Verify assoc-list no longer contains the device
> +    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id})
> +    found = False
> +    if 'assoc-list' in dev_info:
> +        for assoc in dev_info['assoc-list']:
> +            if assoc['ifindex'] == nk_host_ifindex:
> +                found = True
> +                break
> +    ksft_true(not found, "Device should not be in assoc-list after disassociation")
> +
> +    del cfg.psp_dev_id
> +    del cfg.psp_info
> +
...
> +
> +@ksft_variants([
> +    KsftNamedVariant(f"v{v}_ip6", v, "6")
> +    for v in range(4)
> +])
> +def dev_assoc_no_nsid(cfg, version, ipver):
> +    cfg.require_ipver(ipver)
> +    _dev_assoc_no_nsid(cfg)
> +


Why do we need ip connectivity for this test? Why are you parameterizing 
over PSP version?



