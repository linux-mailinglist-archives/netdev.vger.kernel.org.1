Return-Path: <netdev+bounces-250509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A57ED30593
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAD373010778
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BBA378D68;
	Fri, 16 Jan 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="qOtyj+0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7C346FA2
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562785; cv=none; b=DqAiME6GoJYZ63d91ilvn3suFGOKBFMlZ+kjKBozfVGxKuqWHSExp3tBasaDPvr8eweuCB8KwlA94j4f91HyhoIuIHC2Mkaz/ZycDxAmtCXS+nBIWxPkNdeP87KOoOgdVA69ljIunht9Ek0VpyD/iakKIbiE+xIcQqjMys6H7pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562785; c=relaxed/simple;
	bh=/ULSGG+ggFcPYkKN3Wl1A6Xcp7YYNni7MtCGjWSYtT0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrDcJ/G2Lv1yGbmNdfKQ2qhfXQjddNZqIcjuROYCP/+m2xocgdaDL7Cya//GXviltmM3rHQWVuoEV2aCOSKZx8YJ2p2Q7rqr8NuT2GikJZwP+pNSZGdQLBIwM74VrvrquhzOcVhfN8dioJ9RxADDIrZrjZxs1MJRmNR1WLMb5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=qOtyj+0I; arc=none smtp.client-ip=79.135.106.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1768562772; x=1768821972;
	bh=aw/prP4HWB2VJzqDrojNpjLVseUyVkOp9/s6N953XOE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qOtyj+0IjQ42geMjyZ2rUftSZi19kgRxtkHopIPLmVNXBjhQItrwZJOYp72ojU89L
	 0q9R0TdKuLdjjKaFV3mBNaDeaipa6RmRmLkUNoIKcnXl4jg79TnhUsRD6SFzUrUWaY
	 RFC+czJpkxvNWSubNcDOiPdhXAKqSyiTmgwxjyIjiGlPqzTwscMLPjoy7epP69w83d
	 /os0skJbGS0pdRXiwVmgoovZTXQRJ2v/MGPBSvRGpRB9U9lTwBk8QRuXszUU9XKnjm
	 UCMKXPb4cuTAPNUouuwWk/VpwErw56HgG+jQfDBkeGA/rqwTDaHziFpMb1ySM4Q8SO
	 4oFgBkUPWOzsw==
Date: Fri, 16 Jan 2026 11:26:08 +0000
To: netdev@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH net v1 3/3] net/sched: act_gate: zero-initialize netlink dump struct
Message-ID: <20260116112522.159480-4-p@1g4.org>
In-Reply-To: <20260116112522.159480-1-p@1g4.org>
References: <20260116112522.159480-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 3acebd06d3eb1374ec933bd721aca6755c870092
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zero-initialize the tc_gate dump struct to avoid leaking padding bytes
to userspace. Without clearing the struct, uninitialized stack padding
can be copied into the netlink reply during action dumps.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
---
 net/sched/act_gate.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 6934df233df5e..043ad856361d7 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -644,19 +644,18 @@ static int dumping_entry(struct sk_buff *skb,
 static int tcf_gate_dump(struct sk_buff *skb, struct tc_action *a,
 =09=09=09 int bind, int ref)
 {
-=09unsigned char *b =3D skb_tail_pointer(skb);
 =09struct tcf_gate *gact =3D to_gate(a);
-=09struct tc_gate opt =3D {
-=09=09.index    =3D gact->tcf_index,
-=09=09.refcnt   =3D refcount_read(&gact->tcf_refcnt) - ref,
-=09=09.bindcnt  =3D atomic_read(&gact->tcf_bindcnt) - bind,
-=09};
 =09struct tcfg_gate_entry *entry;
 =09struct tcf_gate_params *p;
 =09struct nlattr *entry_list;
+=09struct tc_gate opt =3D { };
 =09struct tcf_t t;
+=09unsigned char *b =3D skb_tail_pointer(skb);
=20
 =09spin_lock_bh(&gact->tcf_lock);
+=09opt.index    =3D gact->tcf_index;
+=09opt.refcnt   =3D refcount_read(&gact->tcf_refcnt) - ref;
+=09opt.bindcnt  =3D atomic_read(&gact->tcf_bindcnt) - bind;
 =09opt.action =3D gact->tcf_action;
=20
 =09p =3D rcu_dereference_protected(gact->param,
--=20
2.52.GIT



