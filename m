Return-Path: <netdev+bounces-299492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JS/XI/UTMGr6MwUAu9opvQ
	(envelope-from <netdev+bounces-299492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:02:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E05B4687712
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:02:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qYTKn/oT";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299492-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299492-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E83B303277F
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D7B3FF8AA;
	Mon, 15 Jun 2026 15:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABBC3FFAA3
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:01:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535672; cv=none; b=any9GHYO//L0L6+QxuwH/BR1L1LyzdGOyBIG2s04N7a88xdXzC/Tmtrkgg6VEn4Uy7+SLbrX3ilyZgG9zniSUTrc1Kqg6h8WLz2hyAwcHbypCSZtADS1bh3KsBjnmJBNNmXzBu8FCrytCiBBB5a8aYEPIjgAII6V0Gwgoh21NMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535672; c=relaxed/simple;
	bh=/9k6sT4MtrkT6HKWvvkUyJQlITanHuZy5nOkg8tNSqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcPMWdg3NEEw9b6YBychVZ33Sti4qNt4QIgLEm4qczo0fGqMYy+lMij7Y9RgKNb1S0g7V4JIpb6snrrA3Ndk3DsDg6RRg6zpXfNGmPRYUE1XIPSvSF8UoEdQFzYsSfN+sumH0/fqCASkO7HbVLfFveoDkq9tNtK9HJFuqfpVhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYTKn/oT; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cdae130cso16794815e9.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 08:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535667; x=1782140467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=khnpdZ2IamFmJh+fpxC56x6GA1zuKN5sdVLEGs525B8=;
        b=qYTKn/oT4I+IpLaxpqlQn9eQX99VzRNenvy81z5MqVSTo1toWHm9StrH4ElHSnsQRH
         X0E6HCJxYDCa9y/PeOQTO0A+H+g7blVwLVCnHj94HjWT6ytsAPiG4n11D1wNRR4mU8pP
         KcSWe0IGQhsAXcd8T7hfXuLvMZNVt4YMwedQBvMrMzQR/hGM73p6KlG9hIdT1UlgT4bc
         A1PNwuQg0p9Qr4jLyLMfLUvSd0XFfTaUJXUWQzceOiPk9C+NLqltJI02zc1vmXZUan2M
         gMshcDQy7UAeks9uq0ctMSB3+yqRXqPg+dXNo49hNqplig9t0+HCPtSovhnGQLOgBEFb
         5zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535667; x=1782140467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khnpdZ2IamFmJh+fpxC56x6GA1zuKN5sdVLEGs525B8=;
        b=bbvb6TBG0aoD6kKI/NqOLDIcN3DXqr68BGwI1dN1AXFdfXyIOOi6zX+2xkR23NCTlO
         /+A2oI03Y50BrhTVuCC2vFoj/8gaZQOMI8bKAdvxLSM+2ZtcsqpcDSRMxlQCBCMK5jPe
         SaaoywGID/b/cSPFy2T6hysp5QquSnFizC4baQpyhS+m8OCh6QN/leY3HTurkufxCfj0
         fHb4ExY3LhnmTxNx6khNQ08joTzZdmV8OeEKZWlJtNsjZ0cqkqsc2Cbl0hDHSJdwCFSX
         EZgo1Z9WJJ7NIql+EgYkl4+474eaq3PAGbvNQ1svAaTwVfQy5xgRIrsQd89VhQ55k3aM
         ivIw==
X-Forwarded-Encrypted: i=1; AFNElJ/HDW4U8+UdNChfKQc0wA1lStvl/gpK2irMsiPB3MPrRJAm1GinuckJKkEr+3KshUBhNUDgPc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydwCp62FoWOdh7I2ccfA1KeNcz4r7XPYpbytSo0Dhbwlq1bPes
	8Zovfv/s2FkdJF7ImmEnlTJlAUHQv8mS8BEKTLRfLq+lCoJK5DlNxCYr
X-Gm-Gg: Acq92OGU3HuA8woMUxZqsHAOsUuIPYA62xGLnR3DVPhIIx37Ld0CZ5hXV6eskbCp2dJ
	0/Hyzl/pWNCl5DbulgauYRwaUps1vIRvW56TJYFqZXYPhTbhr117qNXcVlw7QJAr/anUkjRfpyH
	FGuV28NMRzbDvP8R9qOZmr0F3x+J7b2H/K4RuAR7Okk1gDJ7t2k9dx5wu2S0HfqKuE+x0GogBXO
	4oDbvNxHDHKkusfJSb+Ed4AjkZM/+p6YBpq/aedp5BBGeR5BxnBVjDqYSBPrDit9ttD+f6dz8Yj
	m4N+a4fh5P06KgUVbMWlBQo8Dp1Ff0QzbOvX41JKvmAetjtYE4VI9du6JRNZiYKVm7Ggrr5M6DP
	1PGWM7o7w7wGOX+I0EBgoNF6/RoiZzPs40xlnRx5DsGWjJBTJYvzQwE8yVONTAE9CySK+uLMx6n
	5XKVRGBu6TzogwBfnqUEn25SNjH8kY6EGMAw3iUSkaRDmEdSZJoPvucUYWzCOJmiMpEL8YsVFIq
	wLB4dtpwN4lpHSMFoJ4rlswUWBJpQ==
X-Received: by 2002:a05:600c:c0c3:10b0:490:b724:dbd6 with SMTP id 5b1f17b1804b1-4922005087emr113879755e9.6.1781535666481;
        Mon, 15 Jun 2026 08:01:06 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619a041986sm11773154f8f.23.2026.06.15.08.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 08:01:05 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <eeacfa0d-9303-407f-8e8a-ecc95d1ab1c8@gmail.com>
Date: Mon, 15 Jun 2026 16:01:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
To: Kyle Switch <kyle.switch@motor-comm.com>, mmyangfl@gmail.com,
 andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, de.ge@motor-comm.com
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[motor-comm.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299492-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E05B4687712

Hi Kyle,

On 6/15/26 12:12, Kyle Switch wrote:

> diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
> new file mode 100644
> index 000000000000..f40d75e2a3f2
> --- /dev/null
> +++ b/drivers/net/dsa/motorcomm/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config MOTORCOMM
> +	tristate "Motorcomm YT92XX switch family support"
> +	depends on NET_DSA
> +	select FIXED_PHY
> +	help
> +	  This driver adds support for Motorcomm switch chips. It supports
> +	  YT921X and YT922X switch.
> +
> +choice
> +	prompt "Motorcomm switch series selection"
> +	depends on MOTORCOMM
> +
> +config MOTORCOMM_YT921X
> +	bool "Motorcomm YT921X series."
> +
> +config MOTORCOMM_YT922X
> +	bool "Motorcomm YT922X series."
> +endchoice
> +
> +config NET_DSA_MOTORCOMM
> +	tristate "Motorcomm YT92XX switch DSA driver"
> +	depends on MOTORCOMM
> +	depends on (MOTORCOMM_YT921X || MOTORCOMM_YT922X)
> +	select NET_DSA_TAG_MOTORCOMM
> +	select NET_IEEE8021Q_HELPERS if DCB
> +	help
> +	  Select to enable support for Motorcomm driver.
> +
> diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
NET_DSA_MOTORCOMM already depends on:
(MOTORCOMM_YT921X || MOTORCOMM_YT922X)
with both of those options depending on MOTORCOMM due to the 'choice'
that they're in, so this additional dependency on MOTORCOMM is
unnecessary.

You could also consider using a comment to document that this option is
depended on indirectly.

- Julian Braha

