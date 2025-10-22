Return-Path: <netdev+bounces-231825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E8BFDD22
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC6A1A049C6
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510E34845E;
	Wed, 22 Oct 2025 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="U5a+i6a5"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AF345749;
	Wed, 22 Oct 2025 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157640; cv=none; b=OJYwIuR1wMcp2xtBQ8OEbzFTGm4gK5nunEcsiBtbHjj96mhiN9dsQAO/j1JbYyrUBoc1nXREQGo0DNTLiw4jqM3dwnH2bdLJw0VbUzMg49jWkQe5+PmH0wDfBAXyB6fXloUUhVwp3XsNZmJhR5hfTMnUDH5sQ71Be6RBghQrPZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157640; c=relaxed/simple;
	bh=6HQ7FnLmTaEfzf3bCO0gsOgjyTTSNfAG8WwaCExdgsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dY/MI9eryHhA86r6ShvnMcnr5/GWB93NwuBCcBC3w7M9UIIWhf01dEQO93WCwOyrPjEQFMET46Fl0By2kInhCHCXgBTwUqrpzCE+bjC3XLwHrUuYwunCn8vRfp2IC003uqnDsDu44/k5/qmNC8+wHkfENEXPoSCywo9uGf7rxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=U5a+i6a5; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761157634;
	bh=6HQ7FnLmTaEfzf3bCO0gsOgjyTTSNfAG8WwaCExdgsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5a+i6a5/nx2IGH9IG/UcKdHB5lyKpYajqGZmUDxiDAgGUZi3LaAqM8ksHhkTW3To
	 1uP8EL5yX0aQ6C2m+5Ifqper9HuWryJ93bedNMLyno28DKnp/KbyNA3kGkGalyIFUG
	 9pqotb9Ni59gM4TdvIONuwTTb9UhDm6wobX0KJERmk1R0+sK40s4FOrnqsGk+zwi/y
	 kIafMwWy3Kb6NhYdEjBAWB9cDO9pjSj/3n/Ql2iwqmh3QXlzvhnzi23bWtWTx0bnjb
	 DQTsup0hoPBalQSfEUYUHTuR3WsVEXDlzSyhu6qyIGftWGhDfmiwWoVaUuV/qvh6Rl
	 SfUUrtEGwqcWw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 77C09600BF;
	Wed, 22 Oct 2025 18:27:14 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id B23EB2025C5; Wed, 22 Oct 2025 18:27:09 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 5/7] netlink: specs: nlctrl: set ignore-index on indexed-arrays
Date: Wed, 22 Oct 2025 18:26:58 +0000
Message-ID: <20251022182701.250897-6-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022182701.250897-1-ast@fiberby.net>
References: <20251022182701.250897-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The indexes in nlctrl indexed-arrays have no special meaning,
they are just written with an iterator index, which refers to
the order in which they have been packed into the netlink message.

Thus this patch sets ignore-index on these attributes.

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━┳━━━━━━━━┳━━━━━━━━┓
┃                                     ┃ out/ ┃ input/ ┃ ignore ┃
┃ Attribute                           ┃ dump ┃ parsed ┃ -index ┃
┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━╇━━━━━━━━╇━━━━━━━━┩
│ CTRL_ATTR_OPS                       │ 1++  │ -      │ yes    │
│ CTRL_ATTR_MCAST_GROUPS              │ 1++  │ -      │ yes    │
└─────────────────────────────────────┴──────┴────────┴────────┘

Where:
  1++) incrementing index starting from 1

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/nlctrl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index 8b4472a6aa36a..753cf1b48c252 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -67,11 +67,13 @@ attribute-sets:
         name: ops
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: op-attrs
       -
         name: mcast-groups
         type: indexed-array
         sub-type: nest
+        ignore-index: true
         nested-attributes: mcast-group-attrs
       -
         name: policy
-- 
2.51.0


