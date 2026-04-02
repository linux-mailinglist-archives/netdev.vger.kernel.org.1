Return-Path: <netdev+bounces-274290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCrZJHC2zWkLgAYAu9opvQ
	(envelope-from <netdev+bounces-274290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:21:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3FF381F1F
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB6D304139A
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF31A6830;
	Thu,  2 Apr 2026 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPTjtjxU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240B1A681B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089212; cv=none; b=V7eAb49yo9FdqSU2n835F360SxnBBohnIrJXtB24cHI0vEQTr4wfzZ4vzNvAilVCJdLwuTZt5to/ebD/ijwhWqGdD8H3EHnelIMlaCo+nalYwTYN+4iNizTDrKpNH9UCtnpRNBacjBYyTqWO8FdR/7XoBKLrB7yqankPP4Libn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089212; c=relaxed/simple;
	bh=8hUVXnaRIpo4Ykg4m4ff98IfHNLZs9BsG9DsIiYtg2k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QrovSHQl46CEwkdK1dr4tUAsKdygESrmENKATzu0jlG/HMCDmW4uaag9TnO0p9JwgK583Nb57BVmMNauVQzZ534awjkwauDnauYMYZ4qzdc93Szp9W+xlSt3TQ7XTHjiLSfke48AGBmegwKu9t8+heLj7iz8JleNlA1LSZBB8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPTjtjxU; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64eb84d1e37so260900d50.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 17:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089211; x=1775694011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGQ4G1CjcmvuU29zY2NXv+44QXIA6kMAHI99Qiwbhn0=;
        b=oPTjtjxUe7jjTHZaXspA3sVSCkC/d6tiUqC4ILsHRzkwnxPOf52v1yCkudWE64n34x
         /VaO0QlNWK32LEscUhoA4+RMQwrGOXrRN2/5JezhwWujeNd57KSg1lxel8Befpq+Mlc7
         JU6bMC5csjjq7Fcx+gYiYnmUYzM7bdf/Xu/oOGHteRe9ZsVPpPfUc+I9qtXAAFTEPKdh
         KtXvDglAtpu5ihPOM48cvQCZytJ/9h5i8CNeXXfAy+3NojkTWRqwosGnxoQC/nU+tFvy
         NQZY+FLFrbtVmgKLFRBpfTz+vYCmATxkcErGPbho0tGYImeY+/oaOKv7bKZ6J60lzmpc
         sssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089211; x=1775694011;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGQ4G1CjcmvuU29zY2NXv+44QXIA6kMAHI99Qiwbhn0=;
        b=ca/9GSPKI5RLhj4UwqZ/YN4ogxx+wzMd0KJEIQNCC1Kz2+CpGbpyAx15vj2MGGR7X0
         l0XBWm4hhiFpxwgagc+bmWPwhsKSy5SGMeO4xhzzpKXEcM3fhzj1RkXM6akU7akThGyA
         08IGqpLay2s1rhAanuMcHhsZYiQBI2ykBqElwZchq6XCOORjBdcOh81D9bb23FuFOWue
         6ShiHIq7AGV74W8sgaCInjmRk2FdobI4X+ys7nu6wQB/WAvQqhdLeHp/gW2VnAE6zM6/
         YhLaNreva2sw1tLbRRoeClGY0X6JOLHwgdG7kRW6YhciMuzilROKfwsbSYLGZDoIt8IN
         EuLA==
X-Gm-Message-State: AOJu0YzJGqykJ5elmfPzQgfZnXbPpW7urPM+/bnri2vgFgPIA9Z+DpUz
	EWYwwEoKkk84MA21DikHuwItSwY54JRGNSP6ixdvBwUF29UVj48N3UBI
X-Gm-Gg: AeBDievI5XsT6gYx8ZDmxgGcKMc++ihW4C96eHE7laJYPiKhV1CDrPR1w/+gpJdHn2c
	os7Cqa3n8WwyACCujrRwGSibYwjSmwXMM03Hf0y+6QzLjV2hoZNKTrZqN0qivIMvUE7kvPtGVgN
	F0N32TvwyuEzSyCxwgsYM6BpbVJSxkPKE0QXGcVXxRYwoFX4imTEpRXrY8b46AtwdIbC+zJMUKi
	BMlHFD+AkboiMC843bZziRRXiePI8Jaf/hidLIvcoHFZwgu6BPEAbZm8RTJRYISvd6ZJ4ah2aMn
	Ax85LHKOsl+5247BWNrPxe6mwzy4ZgC/XIPfnJqJxEI3beCAL0/m+meI3sgm2M8YuA4734gXMU+
	QPAvTWOh+iW3T56XA30UZGMcTcSEvPmlBxY8PxcaG4vqQOD8T7rLHCojpqXO/t1E9bOVeGFajjj
	hKO4Q1V8XlijmediWDKoNj3QOx8j4/7Gb0U3nWkdnjaPzIXIXoYZJib+zdiEGK/qHuITOQjil9f
	AF+
X-Received: by 2002:a05:690e:d83:b0:64e:e53a:abb4 with SMTP id 956f58d0204a3-6503ba7e60cmr1195519d50.0.1775089210805;
        Wed, 01 Apr 2026 17:20:10 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a824d30sm583815d50.1.2026.04.01.17.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:20:10 -0700 (PDT)
Date: Wed, 01 Apr 2026 20:20:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 anubhavsinggh@google.com, 
 richardbgobert@gmail.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.39650fe9b7b33@gmail.com>
In-Reply-To: <20260401182625.372605-6-kuba@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
 <20260401182625.372605-6-kuba@kernel.org>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: gro: test ip6ip6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274290-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF3FF381F1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> We explicitly test ipip encap. Let's add ip6ip6, too. Having
> just ipip seems like favoring IPv4 which we should not do :)
> Testing all combinations is left for future work, not sure
> it's actually worth it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/gro.c      | 29 ++++++++++++++++------
>  tools/testing/selftests/drivers/net/gro.py | 19 ++++++++------
>  2 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
> index 57080ecc3df8..762e88932ed2 100644
> --- a/tools/testing/selftests/net/lib/gro.c
> +++ b/tools/testing/selftests/net/lib/gro.c
> @@ -94,11 +94,14 @@
>  #define START_SEQ 100
>  #define START_ACK 100
>  #define ETH_P_NONE 0
> -#define TOTAL_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
> +#define TOTAL_HDR_LEN \
> +	(ETH_HLEN + sizeof(struct ipv6hdr) * 2 + sizeof(struct tcphdr))
>  #define MSS (4096 - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
> -#define MAX_PAYLOAD (IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
> +#define MAX_PAYLOAD \
> +	(IP_MAXPACKET - sizeof(struct tcphdr) - sizeof(struct ipv6hdr))
>  #define NUM_LARGE_PKT (MAX_PAYLOAD / MSS)
> -#define MAX_HDR_LEN (ETH_HLEN + sizeof(struct ipv6hdr) + sizeof(struct tcphdr))
> +#define MAX_HDR_LEN \
> +	(ETH_HLEN + sizeof(struct ipv6hdr) * 2 + sizeof(struct tcphdr))

Not something that needs to be addressed here (or at all), but
TOTAL_HDR_LEN and MAX_HDR_LEN seem to be the same.

