Return-Path: <netdev+bounces-274289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aInlBRK2zWkLgAYAu9opvQ
	(envelope-from <netdev+bounces-274289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:19:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ACA381F07
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 02:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1F763016909
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593B1A6813;
	Thu,  2 Apr 2026 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx2u7NVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F02175A6A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775089165; cv=none; b=hPoT5DCzviAkPHdU7VKCz+FzjFkpUDahmCv7eluVo8nE11gEdCK8d6NR/aijJjJBspDYE4Q6ytxHzOm2rTmSp1APmmNKjdLU1KxPcGn5nyF5Jw3LlziIZWR5gEAT2fFQLeOkoo2RlNFEscRqb4adHgJhCdtqkZONxOQaZ/RwxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775089165; c=relaxed/simple;
	bh=Kd5VrKrqKfsc/qf74ox6gpaM91NNsEfHy80sDZyUCjk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fX987jLqEs1SE21GF0jGFF3/witWvLossv0ZfeyGCgm86ntQGf+XbbDuyqOvQZyFCUS86CFPmRy+Fff3W9TViUqoCqCh1gt6khUznJHR0JUcvfjOwK1wrt1qQXOWjuCsWDdRVOlp0wrx5whH5AgToQjNDU2HpE3oK5jQI7PQH0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx2u7NVm; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-650221149e2so339807d50.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 17:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089164; x=1775693964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbrVAn2IFF+vVLDH+Ic8CmXdw5gi/Gp09v2+/WfQEWI=;
        b=Hx2u7NVm5paGdKQM+4VWTNzm8Pf6cOEugMOdSaekyUx0L9IV6hhenciMcnaQgdDeGu
         bcBy6+jtMtisXyBnD5ndTQOXM7O8FUGUHTxC16Dr65B3MoyIve28XUuhX+lcAmwX8Ijl
         BtCm5yxLB8uaer1O/QcycjKPdusTl2uTmd52xlel9wnQhYqQrN2/8rwTUZpDZrMoCJO2
         N0c5zdu4j2LbxSypbYrx2zDLE5nrL5yhySB6jSj3OJLFfUEeb/phnWW8QNvKy8OURWVT
         keLYwZj1wx3a0L7TlP8bZQgLUI0dyDMHm3jdXA/QDTp9ZbbiPSHUXC9c1Z9mcg31YrH2
         XF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089164; x=1775693964;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbrVAn2IFF+vVLDH+Ic8CmXdw5gi/Gp09v2+/WfQEWI=;
        b=G7pEbTZv3n0nMUfVWbk6uB8BccdSXauHy/PZX32ijMu2ZRwzj33tLVtLj/I+jD8BQh
         QZupRzo54VkJhbATUBkDuh7CddjJGcI/T7OjoBckaZMl7WE0CoZ/AqLvprbeeAYIuVLW
         zepxwe3ATMpGfBd/XqPsj6TSRAvXwKxZInkT8SJaFM0aA3bFa4dfKgozekiCtm3rKBqh
         h7z6uAj57hisCJrHW5PjDeHhWvphgyPPls1sUUMkyt1ImVr0zCvBf1luWo0lKT94v5Mp
         FImwB6XS0zaA0zwMjtFqHGVkLPLyBOrEXECoDjqMHAqtl2315yhr57o4jrCi1/eBYvUF
         T0IQ==
X-Gm-Message-State: AOJu0YzD2IModym8K/VSZUmKoV+n7F27HBdweyAcN8IQL2GhXkM6ZhSw
	wr51WzVSJZ/3f+7pLhCKcfdDu+UKNc/UC1ah+9Jg82YMF9CCABhFduwR
X-Gm-Gg: AeBDieuohMlmIRerfNGuDKwKSo90y2Bup6n5uhX477MVG2Qyey14UcfUYGheeBQiM3A
	lyen/H4SgMR1e7djxOEYlQDM2kmrqztGflx4CNLXPM54Q0De2DU7279izm6KVUGY3Y3Hrt2ygzF
	JlhpUeKH3ErQYgq6+TCpGRPG4j1AEgmUbvZpHLfy9dSHovkWal58rD0HAekrogFtzqlE5dRZ+Sy
	5Amyv3iDplbSnucVv4Djroza/RhdcegtwMROxFJcgmuzCXpzaMiA13MenqbdR/QKIowZ/6BateH
	SJkKPQCNxvCoP6yRrxcFbzy1AYPlYNgbhM+7dDAP7rbK+d73bchuotdPU9YVz49mbG92FIGPI5X
	mz1JENC+MnQ6bqYZpDKF+PeRrFfGY4PCjtVPRbaW1wV7ISSOyAevBrKn9Bup7NURmOaezWjuffz
	iY479pY0hVU+MpXFNbh5azS8Xn+f2rEuw/8XqO38z5ndUU/ZVm0bWFWdIULsXdQLWE7A7SOIxvc
	bDC
X-Received: by 2002:a05:690e:43d6:b0:650:3355:7279 with SMTP id 956f58d0204a3-6503bc1c246mr949324d50.61.1775089163855;
        Wed, 01 Apr 2026 17:19:23 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a73d18fsm583867d50.0.2026.04.01.17.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:19:23 -0700 (PDT)
Date: Wed, 01 Apr 2026 20:19:22 -0400
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
Message-ID: <willemdebruijn.kernel.2bad50f4f67f6@gmail.com>
In-Reply-To: <20260401182625.372605-1-kuba@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/6] selftests: drv-net: gro: more test cases
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274289-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 68ACA381F07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> Add a few more test cases for GRO.
> 
> Jakub Kicinski (6):
>   selftests: drv-net: gro: add data burst test case
>   selftests: drv-net: gro: add 1 byte payload test
>   selftests: drv-net: gro: always wait for FIN in the capacity test
>   selftests: drv-net: gro: prepare for ip6ip6 support
>   selftests: drv-net: gro: test ip6ip6
>   selftests: drv-net: gro: add a test for bad IPv4 csum
> 
>  tools/testing/selftests/net/lib/gro.c      | 171 +++++++++++++++------
>  tools/testing/selftests/drivers/net/gro.py |  24 ++-
>  2 files changed, 143 insertions(+), 52 deletions(-)

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>



