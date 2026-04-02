Return-Path: <netdev+bounces-274708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOwKGJXhzml2rAYAu9opvQ
	(envelope-from <netdev+bounces-274708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:37:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D233438E669
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A584302DF7B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2593B47DE;
	Thu,  2 Apr 2026 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTMT7GUT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C23B7759
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165842; cv=none; b=YQz55Qe1c08DIdbAhBZfvbo8VEFsr3gTf0WTNSQcOju6j7VKHB8TlmcZCvFu3bBbUK8rFhzT+KAP59tnV5CE1kiT9zLsyoDbadqwrXDuTvNE7RpplgDg9qcLdLs16lss8y+2oBJ6+vODmppkvOrvbZWh6gPdWkjGMY3luNGB3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165842; c=relaxed/simple;
	bh=W3scN7dzNt1e15M5oNBsPnC7KIKxRsloBy39yk58Ja0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=E+HeXp7tNY22gV6JYSFQOVd0gXim6siiqFggYS523tKxZ1v74j/Hbm2ylXCjV9KIzG2tAhjD4G+P2fq8+JTWO0Xc43wg/ICM8a+WHNs7hS79EouIEtpUV2Y8LazRVetYmbppuAJSpvnBoC+UhtVxZ1wfzWISdk7P2gu/GhmlCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTMT7GUT; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6500040f128so1277174d50.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165840; x=1775770640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7TuW0G8B0XaMIfsGGJiYSCTzDLrTNNDB5kSjHsf114=;
        b=mTMT7GUTpGpPoYrudzEtF2EL9iUEQGIsG9I/qg8ishfZwFKPhZNblqqaFvJOfG77dZ
         d2zIRHRqD/r00Nh4oV+qpAJi8iyjy7bUj6Esi8PZ0XFjTQ6NVverkVGFCPQVuEf2ZEDD
         uiVg1ioO2dWepco/opJFPbP5VBcOgtst5ut1ANMYycqcH/JIO6i4NwZx6AwhC5Ateelr
         QkR6C07mhQXju20le9EGgSPPYj1HF1AGTIzsO6z0lIS7MslW8Bcv31C3MT1rcnb+AMA3
         OfFH8QgHeYcpqG/aXVCfMMB6v1zKVr/1DhMZMk2EaV66AiAWRXN7O9GcEEIMmy5pCjPZ
         97yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165840; x=1775770640;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7TuW0G8B0XaMIfsGGJiYSCTzDLrTNNDB5kSjHsf114=;
        b=oqKDmqEpdUdYS2ed1yS1lpNYs0ihHGoOHSohO+hGRIneje6jE0PYO/T/+0WKAdcLTl
         CzgospMgSTnQO2pz02BUje2g349MmxwcNIbLKDKmkka59fgRVYqOID5LlgS/rgsBLpJk
         /MzgSIdgJobtQHoe78JEXqCiBWp5F+2WCrlFQVSbnrmnVWHvKHZSEB4PZ/unNuhoE1Ak
         iQIDmWNGryvLKBIHrvw+UJrYzt9T7WH3Oq6ywjLOJa0HZvb5ZCMaFei/XqCekLdRMoEl
         WEB9m1X7lRWF9xLiYb8bVLRNgbCnNPerXn4CVAlZLaR5jF4TaEXeUSnrMkXQKDU4xFuL
         1GBA==
X-Gm-Message-State: AOJu0Yxj4gtHGe9TziaQpG5bjxcJCLbgUoar7yv7bXBMPtnkk2vniDTz
	DwPKNrE3M68Km/EqEAZvSSwfTkko37B+3AX937ILTP8bMjhAAe0AwrNy
X-Gm-Gg: AeBDietG+x/+MKp4ESBg48cP1cVaxPlLha1yRzYfBXQdty3jLYZ3id+PmGuVISBGaUl
	hKvsn63933xnoRSKgnbIzzZZpENe83+S86FQ/MmxH25NaZihZOS9KcDiKTECVGoi/eNtAZmOhc0
	HiUOBDhe9trlSm+qlRPqcTQ+pTMp5z/6rXPBO1dJLPR/g0hAbVI23ZQhYe42hV57OXXiJKYfTwn
	UIFfzEc1QfCtARuCk3yQVGRrq4WZZsJC/IPo0Lj3+LRjYchz7Mt504BfX5EWFvQEVPt9AL1aqQa
	Ae9o8DRZd079NujAOAXCvOR0DOjWc7euNuKiPoN85IUAUN+1nYNACX7LTHxq6d4z8qufTRNOu5S
	lQ+n4qhMsZBaPtG9OuIMaxpUF6g9o9IWpAkfPhL0Qwdj8xN+heM61HjLZWD/MVAYtL+m5DLNkOV
	MjyqEnbdCfJVTbcOkHWot2eMp4eDbNGylKO2uZ+Y6znygKY8ZOnKWP7JIs1H+a6173xTLa7/FIR
	q0I
X-Received: by 2002:a05:690c:110:b0:7a3:3192:386e with SMTP id 00721157ae682-7a4d68304a8mr10511047b3.53.1775165839769;
        Thu, 02 Apr 2026 14:37:19 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36ea27d19sm15135357b3.20.2026.04.02.14.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:37:19 -0700 (PDT)
Date: Thu, 02 Apr 2026 17:37:18 -0400
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
Message-ID: <willemdebruijn.kernel.1b7e7cef1d1b6@gmail.com>
In-Reply-To: <20260402210000.1512696-1-kuba@kernel.org>
References: <20260402210000.1512696-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 0/8] selftests: drv-net: gro: more test cases
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274708-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D233438E669
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> Add a few more test cases for GRO.
> 
> First 4 patches are unchanged from v1.
> 
> Patches 5 and 6 are new. Willem pointed out that the defines are
> duplicated and all these imprecise defines have been annoying me
> for a while so I decided to clean them up.
> 
> With the defines cleaned up and now more precise patch 7 (was 5)
> no longer has to play any games with the MTU for ip6ip6.
> 
> The last patch now sends 3 segments as requested.
> 
> v1: https://lore.kernel.org/20260401182625.372605-1-kuba@kernel.org
> 
> Jakub Kicinski (8):
>   selftests: drv-net: gro: add data burst test case
>   selftests: drv-net: gro: add 1 byte payload test
>   selftests: drv-net: gro: always wait for FIN in the capacity test
>   selftests: drv-net: gro: prepare for ip6ip6 support
>   selftests: drv-net: gro: remove TOTAL_HDR_LEN
>   selftests: drv-net: gro: make large packet math more precise
>   selftests: drv-net: gro: test ip6ip6
>   selftests: drv-net: gro: add a test for bad IPv4 csum
> 
>  tools/testing/selftests/net/lib/gro.c      | 207 +++++++++++++++------
>  tools/testing/selftests/drivers/net/gro.py |   7 +-
>  2 files changed, 157 insertions(+), 57 deletions(-)

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>

