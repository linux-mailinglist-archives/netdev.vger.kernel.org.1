Return-Path: <netdev+bounces-290431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABS/LLARD2qSEgYAu9opvQ
	(envelope-from <netdev+bounces-290431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:07:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9745A6D4B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8536B330129B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6743DBD4F;
	Thu, 21 May 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZF1Tf1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9B3DB636
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369563; cv=none; b=Q5J3qbP2HWO6vuAuQ4WhMnqtzugGgXeanqY/UYHqMdSdaHAdm9q6SPwYJ+iF8gxlYla3jIXJikPJazzpxNeDwfa+pU0Vy/tCGL8YsaiGXRnQiGCR9RQDyMPFgFBV2fSWPefK9NWNNVsDS954hw2JOqF+SJUGT8nPe9ZkI7qlMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369563; c=relaxed/simple;
	bh=n4jUwDN00IoCg9eM4tdjajzWwhNoFWpvMQYkIHLvKlk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=spz5Ljn5nDxWpDGucZUOCYAs8w2k+A58wBpM3rFcENziJBesqnApjQbXcmMPNHcIGRE2zBoKhXUbcAn3672Vqn8ASgHLyRrVfuTG0OGUwNgrPkpjKOZaAfjmRaeCWSsPRRkJDh+12FmfEb3H+IgYGUP5ovamzByvEtKWX3HFzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZF1Tf1W; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d8e8c47a3so34771461cf.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779369561; x=1779974361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lLeARIn6HK81yx2IwCYu0ZPFekOnuaSqLzvfeFL7y5k=;
        b=vZF1Tf1WWNwd3pue7ULrY1c57PmD6m4CIGCiTV8PSaRhlFDQPQjy9Rwf5iNsjpUn1N
         CYxekK8aizo80FhgKVpvFAdvwu3iBw4p6MCJuwUusG8zdcf6TNXo7W4cINeY0G2lLab8
         173CG67lT89RgBA0SnnBOXCdrf2ToOiZKrt3Zjy53SRIwV1jvAIHEaTG/tQlSZUq+oNH
         kiwWIaerkgy6DtvE6XsF56Q/9jz8KMy1Triqpk5huqXzQC18dk9nCGFhS6Bybn6WWvzL
         i3D580IsbBGfXSSDkdAuB06tf9hhr0U8KTyPYoliTBtOgFzTQu3x8k3F6qsrNVHMg3OK
         5yLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369561; x=1779974361;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLeARIn6HK81yx2IwCYu0ZPFekOnuaSqLzvfeFL7y5k=;
        b=IP8E8VmPApy/El/DA0HuGtks7o/8/o42++FloooeyEPLnmSAOIfWiQLEiIGqsaCKCw
         VPt+C9ecTc9KrsyfTkjBdNb02N0MkR1JN516ltnuH6ufx+KyJTM66/gl6n7DNGEhj9La
         gUEJS7mQbna4/ZL7JcHEk4LuesfyrXJmTi0qUufgFgG2K72AkDu3tc3us0okSdzFSdMM
         yo7YDuWHi0QK3c/0YpNMUN9FgEIks3x6O3iabrU94O+P/JxxwntisWIn6gvLl0S4ony9
         dC015Ysi+tMjrsFqtS3S0aT3PZmSozecAzr0oWjVxMi/q0/HUu0wBC0KVt2D6w/wNROo
         E9jw==
X-Forwarded-Encrypted: i=1; AFNElJ90D13x75N639B0jZG47L/RFpfRTNNdNJwGpi3RFDDUblVLANJXqcuyMOskbUNGbM1MfWAxLlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Y12O8AIPsw2TeKDAJypUYahWkcY6FsljHfDc8Tqo0IXj2uHF
	tix3hHDFnHwiw1FfxMvvn+EmrKcu52N/ZdYW8sbvF0XN3PBKKgC2v9Sx9Z+EsIktbIftObSDi27
	XRbIROVoNNakF0A==
X-Received: from qtbkj1.prod.google.com ([2002:a05:622a:7781:b0:50e:5e33:ee38])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:9:b0:50e:89e6:669c with SMTP id d75a77b69052e-516c551500emr35571471cf.37.1779369560740;
 Thu, 21 May 2026 06:19:20 -0700 (PDT)
Date: Thu, 21 May 2026 13:19:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521131916.3627204-1-edumazet@google.com>
Subject: [PATCH net-next 00/11] bridge: prepare lockless br_port_fill_attrs() (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,blackwall.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290431-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C9745A6D4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

medium-term goal is to allow "ip link show" dump commands to run without RTNL.

This round of patches adds/fixes some lockess accesses in bridge.

This is not complete, more patches will come later.

Ultimately all changes to p->flags should use set_bit()/clear_bit().

Eric Dumazet (11):
  bridge: add a READ_ONCE() in br_timer_value()
  bridge: add bridge_flags_bit enum
  bridge: use BR_PROMISC_BIT
  bridge: use BR_ADMIN_COST_BIT
  bridge: provide lockless access to p->path_cost
  bridge: provide lockless access to p->designated_cost
  bridge: provide lockless access to p->designated_port
  bridge: provide lockless access to p->priority
  bridge: provide lockless access to p->port_id
  bridge: provide lockless access to p->config_pending
  bridge: read p->flags once in br_port_fill_attrs()

 include/linux/if_bridge.h | 78 ++++++++++++++++++++++++++-------------
 net/bridge/br_if.c        |  8 ++--
 net/bridge/br_ioctl.c     | 10 ++---
 net/bridge/br_netlink.c   | 55 ++++++++++++++-------------
 net/bridge/br_private.h   |  2 +-
 net/bridge/br_stp.c       | 38 ++++++++++---------
 net/bridge/br_stp_if.c    | 16 ++++----
 net/bridge/br_stp_timer.c |  2 +-
 net/bridge/br_sysfs_if.c  | 12 +++---
 9 files changed, 128 insertions(+), 93 deletions(-)

-- 
2.54.0.669.g59709faab0-goog


