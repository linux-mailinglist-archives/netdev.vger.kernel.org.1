Return-Path: <netdev+bounces-304265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CC1FAwa/RmoucgsAu9opvQ
	(envelope-from <netdev+bounces-304265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6CD6FC94A
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 21:41:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NO1hN1f3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304265-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D922300E24B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916970830;
	Thu,  2 Jul 2026 19:35:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BD390218
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 19:35:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020912; cv=none; b=qaq1MX8Yl9pC774mYMuCxEFLD0dilSQF94pqm3fi+hpNDeeMd4mhihWJId1vod34LdsjWwdGZwDvrNEoyt+z0COa0O1NyEyn0gmuw3ssNXbQCliI4sdTfeK4kth/ZeWJaQfevlG9+lYtFFCUmdI6jf8uuu3q2PvIYpK21zmzmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020912; c=relaxed/simple;
	bh=+4SsahEkMw7Fcn3TjVnOdE18l/AhKXzwhlUQChrQT6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkL+j+GUWfCF0kdoLBKCEhshFTQYWKIGjq0jUMw0ezKTKzulzXfDEIDQKCNdK1u5CwQDMkoLlO8FjiPOUn6l18FDaOP8EK5j90rZg+7vVeWOVB6ltETWfI59bDz3QeoDU7UFkpMkhuoqUK0Qra8wtU5ELI4NLqj2PHI7wUHzcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NO1hN1f3; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso12413025e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783020909; x=1783625709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VhDTGu29o5KH/AhRoHVjtgLPjge4hAd7CEpqieumsDI=;
        b=NO1hN1f3YHse+cksy1K+0dPEKDStskMz3/ZDSBbUHOMqi0mHGzqyeRt8KFJ1dyL9xQ
         9Iwx5fTpTzDwnRpIS96AG3TnYE0IXJ2BIuFXB1winBrZOjDs4phHLramIUl3oxR+6RjZ
         CiUqWOh38elSTb/AMOe9BycKKhHJksPvCKDo4Kbi8bNPD9hx3vSPJs4tobvY6DI0isbg
         8Dfa2R/EkDAulk7Dpw+kCemrfxa4R5AtciKT/LGToQPF95dJwfd95FeZ1E2gPQkqSRsN
         fiQ12CakrpcbCZA0SkoQ/AHYdR2fA6Geilp1aIIFaUjHWqZWo7gEe0U16ZLSexRmScWT
         0BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783020909; x=1783625709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhDTGu29o5KH/AhRoHVjtgLPjge4hAd7CEpqieumsDI=;
        b=R9ReCeKC1YaETtq5ZejAmbq6gMpNMVLhah9Q/3vfjlb6rTIoPZa+kZxQNEyGEdeN0K
         EEAJLBVhWt8R3UiOiISy61XXHLpenJZup6gg2LdMqGXP9JESrlfhbLIC9cKzvrgybJ9v
         nVNAU3EK8V5yYYI9mofkeqnNKvOOUBTWIWWfBjPIYyVl8KeW+kifHxwZpfi8ks61F8GG
         cBhK0i7zDwlsbQtr6ZSyoih0wpAZF6lh20fF28z+/Op0RpU2rJnHzC7Y3xv1a31DHCt9
         fDD+VDuGNCBPLv0yM/JzPiWeVyMI2P5XKSlGNJ6LKRnStb4QZ5+YhGh5tSuDfqqI+pLT
         RYtA==
X-Forwarded-Encrypted: i=1; AFNElJ9z2tkNseo3AYw6egNvArfKaU99XcvaFn+8/DCGl7cd4ygwgNodkVqVj4ztszGNbvYBppx9ZYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAzyaK572Q62ryIsNLL4YlJJ2iS20p7d9CIzYXsZGC3LCFPTq
	Nd0iUyvPsdtZpkE+A7EDwLAocZSO4Q6aRtJV5A1ZGvi18n+vOsWc9Bix
X-Gm-Gg: AfdE7ckM36yn+VpyM2MONU+lbUh2/HHS79szRs9LZD++CYszqV8odzsJq8WRc0dtSlh
	ZaUrty/cTKpBTHRg3cSukjj5LpeKqM9yFMtGM1Fv4hQZ+gcJzOAN74LMtrjVLk88viCSk/1A7y0
	M/qDlqvWVJWeKjEjZiyH6dtFEJ6+N2ROwIqwSHia6qeDyK4xUoH4D+PGT/XbeyNHa++5qRM6scp
	XXxwb1/dbr1tA16d84p5gnKy7nXO3AWbnAl3MUhqTxEl3OZRtnXdu4TR23TDy80f+vSjiBio6yL
	lB9LuuEFveJlwHqZtXqBcCR4XstmI8vTagZL1G6ZbnH2BRthOftYys5AVoVkYgmTF1Txc6n4c8f
	ZzhfeiM4adZlK+VqjVOcti8gtujsDhJ0ojCveJrZSlClIPYKxySRooE11hlAlM5yhKGi1HmHD0z
	C+zraNwsOqvt8MW1fhB3lNkxqxr7GLdXEIratOq0/hDvdD3eMeMxUJGyDEOgwwYmLfuxozMdRrc
	cru2skM
X-Received: by 2002:a05:600c:3e14:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-493c2b9022dmr105939745e9.26.1783020909053;
        Thu, 02 Jul 2026 12:35:09 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bfe616f5sm97757665e9.1.2026.07.02.12.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 12:35:06 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <3fb40218-e493-4772-8200-74497efdd9a2@gmail.com>
Date: Thu, 2 Jul 2026 20:35:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/2] dinghai: add ZTE network driver support
To: han.junyang@zte.com.cn, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 ran.ming@zte.com.cn, han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
References: <20260630111300830lukBczfNSgWE5wt6qR95k@zte.com.cn>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260630111300830lukBczfNSgWE5wt6qR95k@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304265-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:han.junyang@zte.com.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E6CD6FC94A

Hi Junyang,

On 6/30/26 04:13, han.junyang@zte.com.cn wrote:
> +if NET_VENDOR_ZTE
> +
> +source "drivers/net/ethernet/zte/dinghai/Kconfig"
> +
> +endif # NET_VENDOR_ZTE

> +++ b/drivers/net/ethernet/zte/dinghai/Kconfig
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# ZTE DingHai Ethernet driver configuration
> +#
> +
> +config DINGHAI
> +    bool "ZTE DingHai Ethernet driver"
> +    depends on NET_VENDOR_ZTE && PCI

DINGHAI has a duplicate dependency on NET_VENDOR_ZTE since you put the
import for the file inside 'if NET_VENDOR_ZTE..endif' and then also gave
it the 'depends on NET_VENDOR_ZTE'.

- Julian Braha

