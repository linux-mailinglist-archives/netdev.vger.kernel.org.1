Return-Path: <netdev+bounces-264800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHa9EL3ZqmkZXwEAu9opvQ
	(envelope-from <netdev+bounces-264800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:42:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D806221F51
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C02AA300371B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1D273803;
	Fri,  6 Mar 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CmkehRQ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447222459DD
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803931; cv=none; b=IZqN2V1Hvq4Ilkqqzd6IBmqDXjg73C3Vqt+dCsvR5a8UtbeiH/JN34mqPP9q1GTwTue4TGloMy6w86wMu12s6sRKViolxd5sbMNvPPstN28DYbWNV2rFNV3yMc26QgQaJcthMCyd8+/T/4WBdl5OZ5UO4k+r5Xzt7k39v5oHmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803931; c=relaxed/simple;
	bh=yglAOU9EoSizb5k31tzUSZH4Y6UBTD/3pT/iR9wOnVw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TqWFd0c8Y/ftwAw8uMlC/8WJQ8o4vizPp69Hjy0j/5yWef7+7V9wGrM02689vSdjA3CBlJ5nnJ0Unj+2Ncekb8tz3cMNq2SESbBBPaFxBXHGDFZUntWztejPm7o+lwsCMVXxIXcaj8f1AhpV9kC7/pwjqRcBj7DjbaCSzE2BFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CmkehRQ6; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb5359e9d3so5542379785a.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 05:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772803929; x=1773408729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C70vZFB5s1l7KkMHM++Ikt2rVAfRsUYTpLA6EyebqCE=;
        b=CmkehRQ6bnEKtqIenE0wK9HyLM8wfAVpmPWEn6mQAvHixBWTR7iYrjyf8ZElkS8y/q
         L45l4KWFEKkkdvt1aQoJmxQ3lZTiLvZ5EJDCfMQmSU35G01LwTaHYFnEbH1eqMDhvC6z
         tjUNMvuvxcuPgDAo5uz2PLK3/ZTrQh2pOU2YWNQxrGT6vkhIPEz5hge2C6+0IYHbJAht
         /zhvT5p1ihCj52qz2OttCFum5gYp/45d+QzBlPokAT6S47dKYPcamTGFg7L94K/lQiEr
         pZEkFjluCae4POy1cUGCHNigblHqcMFlESSQzvfGdkfymLwZySZJoK1dVcTDXpOp07+Y
         VHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772803929; x=1773408729;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C70vZFB5s1l7KkMHM++Ikt2rVAfRsUYTpLA6EyebqCE=;
        b=itiHRRjrdCx7fqRk71H4e4S+aLsZSF34C+rzbWsrf+bse97B9LQz1Nguel39Pv4a0v
         PKgvUOafxRosbJUcwEy3tLDXmoPxciGjvc+Tb4kaNmgwUC9Zfp9hdex3mPdavrAC34+D
         1CSdJc61akDvaKBrxus5XNv3vQpR543xj6Fdw717Id3kOBUzSGEWOhM9hTHYToL6gveE
         +Of7sW/L4XK4gO5g9QvGgQPIyjfH309jTswblKT1nmL8ySeig+ZMqKpDXlSx5Fh7AmiO
         ESVziEphAlnlGZy7wgt/Hr+8fPVSiYByk1K51oBIYJLfDv7s8n4heME/K3vrOhhf9tor
         BqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU05i3dVpDQIeTahTk2wLn9GKYzdEi8YX66otkB5GBnM+CenDB7rC9Nid9FXuHOLjVVBWHdjAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjYaPkIimPefBfWaXk/HsIjO6m9cV3WrhxaGiZmSWeqZbzomz
	M61Neo1ZT9hen5sMibXW+9oHAkayAYNzqIVlZhLjHR6NHasP5B4qlbljqNARdvXVfjGNTEM3Esa
	FcOw3TLc62FZiJg==
X-Received: from qkip25.prod.google.com ([2002:a05:620a:22f9:b0:8c7:cb6:2f03])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3183:b0:8c6:a3ed:2f65 with SMTP id af79cd13be357-8cd6d386220mr254014285a.23.1772803928753;
 Fri, 06 Mar 2026 05:32:08 -0800 (PST)
Date: Fri,  6 Mar 2026 13:31:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306133154.678730-1-edumazet@google.com>
Subject: [PATCH net-next] net/sched: use rtnl_kfree_skbs() in pfifo_fast_reset()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4D806221F51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264800-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

rtnl_kfree_skbs() reduces RTNL and qdisc spinlock hold time.

skbs are freed later after RTNL has been released.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 55e17f9e5636f2d9e798889ff59b2f69c9c1709c..40e0d20ed0227ede4f1cb292613f1918c5a48f2c 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -850,7 +850,7 @@ static void pfifo_fast_reset(struct Qdisc *qdisc)
 			continue;
 
 		while ((skb = __skb_array_consume(q)) != NULL)
-			kfree_skb(skb);
+			rtnl_kfree_skbs(skb, skb);
 	}
 
 	if (qdisc_is_percpu_stats(qdisc)) {
-- 
2.53.0.473.g4a7958ca14-goog


