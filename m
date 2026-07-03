Return-Path: <netdev+bounces-304655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jCTQDlAFSGqOjgAAu9opvQ
	(envelope-from <netdev+bounces-304655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:54:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4A705028
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:54:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=CaWD5eZs;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304655-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304655-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 601683009813
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD603128D5;
	Fri,  3 Jul 2026 18:54:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8263016F7;
	Fri,  3 Jul 2026 18:53:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783104842; cv=none; b=d3+wFDxSoAdjlO7f8lPxLljkkHdjT+d8X+pM/UUPB6qsxqlXSd4tt/Oy8OX1rfdNjQpDZ9dzJtgphEcQyG/BLM+4g7JwV/zxmJIEPO58Xv2G7klABc7Fdal/G3YQVKVdU6OTmYE0el4HFjW671DPXWxtvZsoSXD2Awgavdf7wtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783104842; c=relaxed/simple;
	bh=k8eAyWfiavhZPQUIRN7Hwwm6tZEyjbfZBMp188AI/nE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=skZokr193PEt8hvJ5Jfh3qkLoMOR8VUDSot1MB6ohRcvMGUCa7vv2FBW2VCLvS78qN19MAMStr990UOkqCaBdAjK5XhKNzbsTBmJZKd50mDEnr03Ln4gj6Ou/G/DDpJNdRNZ7QziKs2JDZ6qHlvZ4za9iKPa2nNSnQlHXM8xTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=CaWD5eZs; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4571920758;
	Fri,  3 Jul 2026 20:53:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZZKk4vse5xv; Fri,  3 Jul 2026 20:53:56 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8DCC520561;
	Fri,  3 Jul 2026 20:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8DCC520561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783104836;
	bh=9o8/bqXzxkD5g4mMHZoquLRFczrFTBCt291qnAraS3A=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=CaWD5eZshNXSwsWef7R8VQh4ipyB7CW8qDJZxIE/dHHpbho/Z6TnMjCJvo5V1nS0p
	 9VPJLUhQYrP+eoRJqB26/trRnwl+FhZVWayvOoO1y9Vv2odwgQGihjZFZzc6jDbZfW
	 XbVAbZatiKwqgtn+uzEHANhyxeO4TWsaxDw4p5KijcSGdBPfs5drwEzvQgorGuaGaN
	 ZIYvVpYlpU5MbyTP3jb2ipZPCUtaRbojeuRVjT4293S8Qz/cf1W1a0FHGf3bVAvoYu
	 HHtPIkBic1tbqs4an85lmcNjl2q8E/Lbs/e6k63OrNPrZlqloUDTWv/GpluYjO8TyF
	 TABNK/rn5UxcA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 3 Jul
 2026 20:53:54 +0200
Date: Fri, 3 Jul 2026 20:53:44 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
	<dsahern@kernel.org>, Antony Antony <antony.antony@secunet.com>, Jamal Hadi
 Salim <hadi@cyberus.ca>, Shuah Khan <shuah@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, Yan Yan
	<evitayan@google.com>, Tobias Brunner <tobias@strongswan.org>, Florian
 Westphal <fw@strlen.de>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Sashiko <sashiko-bot@kernel.org>, Antony Antony
	<antony@phenome.org>
Subject: [PATCH ipsec 0/8] xfrm: state: exact mark/mask match for
 control-plane SA lookups
Message-ID: <migrate-state-fixes-v0-0-a69e8637ba3b@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-B4-Tracking: v=1; b=H4sIAH7pR2oC/z2OwQrDIBBEf6V4rmCiWNNfKT2YdU32EBNcKSkh/
 15toZeF2eHNzCEYMyGL++UQGV/EtKYq1PUiYPZpQkmharHQlH1ByaXdSDuyVFYjKm1623WiAqN
 nlGP2CeaG0MYIMuFe/iasy0KlmX1vo/FmUKHzg3YRnHbBRQfGeoPgnTWgws01dMv4Lazc45cqn
 vU9E5c1v9v08zw/L1A8zMoAAAA=
X-Change-ID: migrate-state-fixes-063ee0342611
X-Mailer: b4 0.16-dev
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:antony.antony@secunet.com,m:hadi@cyberus.ca,m:shuah@kernel.org,m:sd@queasysnail.net,m:netdev@vger.kernel.org,m:evitayan@google.com,m:tobias@strongswan.org,m:fw@strlen.de,m:linux-kselftest@vger.kernel.org,m:linux-doc@vger.kernel.org,m:sashiko-bot@kernel.org,m:antony@phenome.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304655-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,secunet.com:replyto,secunet.com:mid,secunet.com:from_mime,secunet.com:email,secunet.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[antony.antony@secunet.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28C4A705028

While looking into a XFRM_MSG_MIGRATE_STATE issue reported by Sashiko,
we found the underlying problem generalizes: xfrm allows multiple SAs
to coexist for the same (SPI, daddr, proto) differing only in mark,
and every control-plane operation that resolves "which SA" - get,
delete, update, get_ae, new_ae, expire, migrate - uses the same
wildcard mark match the data path needs. A broader-mask SA can
silently shadow a more specific one:

  # ip xfrm state add ... spi 0x1000 mark 1 mask 1 (SA_target)
  # ip xfrm state add ... spi 0x1000 mark 0 mask 0
    (SA_decoy, catch-all, added after -> bucket head)
  # ip xfrm state delete dst ... proto esp spi 0x1000 mark 1 mask 1
    -> deletes SA_decoy; SA_target survives, untouched

xfrm policy had the same bug, fixed in commit 4f47e8ab6ab7
("xfrm: policy: match with both mark and mask on user interfaces").

Control-plane lookups need an exact mark/mask match; the wildcard
match stays for the data path and state_add only.
This series applies that fix across every affected method,
not just XFRM_MSG_MIGRATE_STATE.

More examples in the attached self tests.
This series not fixing likely isusses PF_KEY. As it
is no more receiving non critical fixes.

---
Antony Antony (8):
      xfrm: state: exact mark/mask match for SPI-keyed control-plane SA lookups
      xfrm: state: exact mark/mask match for by-address control-plane SA lookups
      selftests: net: xfrm_state: add mark shadowing tests for state lookups
      xfrm: fix use-after-free of migrated state in xfrm_do_migrate_state()
      xfrm: fix hw offload state leak on xfrm_do_migrate_state() error path
      xfrm: include mark in MIGRATE_STATE SA collision check
      xfrm: pass extack through to xfrm_init_replay() from xfrm_init_state()
      docs: xfrm: include mark in XFRM_MSG_MIGRATE_STATE EEXIST tuple

 .../networking/xfrm/xfrm_migrate_state.rst         |  20 ++--
 include/net/xfrm.h                                 |   5 +-
 net/ipv6/xfrm6_input.c                             |   2 +-
 net/xfrm/xfrm_state.c                              | 109 +++++++++++++----
 net/xfrm/xfrm_user.c                               |  49 +++++---
 tools/testing/selftests/net/xfrm_state.sh          | 130 ++++++++++++++++++++-
 6 files changed, 262 insertions(+), 53 deletions(-)
---
base-commit: 226f4a490d1a938fc838d8f8c46a4eca864c0d78
change-id: migrate-state-fixes-063ee0342611

Best regards,
--  
Antony Antony <antony.antony@secunet.com>


