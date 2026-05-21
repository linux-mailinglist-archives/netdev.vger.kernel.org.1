Return-Path: <netdev+bounces-290393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIl4DGL5DmoSDwYAu9opvQ
	(envelope-from <netdev+bounces-290393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:24:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C762C5A4B89
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC14A3002312
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE039EF12;
	Thu, 21 May 2026 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alP3XDgh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF013803F2
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366111; cv=none; b=YgUvp4Y96NwKFrECCUnHlukiEZb1QIygUeggTN8vj9lHz+8BsOEb6P+i5sueqGpLxr93geUN5UVgKbhmNBcjBXggviOjZ7+7KRwfwplszyEt6zdQNw9S9CtAeOVfPCZCEeUlKDwtr5p9gUOtmDy0xcQxyNuylDtRXZgoq18Wva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366111; c=relaxed/simple;
	bh=df+czxFJY62wmy0BBv2jp/l705aaRE9bztdDwIaIRjk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gwndq+n03RuQsgEdhUAGSxT1nsWLCwvyXEHkBL5a7KGCI4tOLvowTwdUBScXyRC+hV3j2mRJbzxfXIJrEirPSJOrrGP0COpR1ESbzTtVRgwtfuPFakEYaKxWjDpbUB9tVLCeFADQTbWfv81sbHtUZDoW2o3ijVs4G7fY9CPTmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alP3XDgh; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-910304978f3so1227032985a.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779366109; x=1779970909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RmzeDLfWAnv7ll84t2xkJqhf2kd2cAoqRZvN2MkbXlA=;
        b=alP3XDgh9hKsx25YqfEczObIRzovupavMHFeRf9efeal4X0joylHArBKaw47sIKq8X
         U7XGWmCzWoggTfD0NniISInwWeFX9a61mqg0qL/WIHeNgFNmccEdWkxwGkBtBdpul2ph
         rlS8/3u0BrYsfiXDTIU1sjZn+NJZKsAhZ2yMR8PzjkzHzbh0GyxrhaFFRMGMtBUsZiNh
         3d7pQpjaGlQrUtVB1jVQwZTL+8+u+saCo6ynCZ5XUlRrhoIoiUrl85oiTccHxJFcv/Cx
         0OALX3QxJtKiEYwU73SgGT9BQgnH4+radcrxGZ7Z7gtN4OrSBaDOzscw8hp+nzd7U0lZ
         btaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366109; x=1779970909;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmzeDLfWAnv7ll84t2xkJqhf2kd2cAoqRZvN2MkbXlA=;
        b=Psucx+kzPFkdHDjVS/Y6lOhUZHQxSdiXM/Zy1KFgrWUFtfmSpAlxnR7Oty189lCie+
         vdSSpnamWfg7XuR9ykNsJebNRYOqWtONl7pYIpw5VinImvC2Xb+oC0QalyYd2pebbXdX
         TOAgDGljt2FPrFjpIVciSJAW+YeS+AH1IfPCOtqAQNFVjf6OKiuLKWkf+LFpxhDZ1mtJ
         xJlklTXcSMDf4OLBx5clKrRrTXgo5SHsCM0IpT/QpAQNV6GQdpO3ydCJNbEx3HZTP95s
         p5YblWZGpRpg3YU6gRNYZibK8NjmO9eSMxFRU61SqetY1XfUSgd+coVsYWoLmS+9igJr
         usnw==
X-Forwarded-Encrypted: i=1; AFNElJ9LwtyEqIaVe1S8o0q/KnLKZlibCcm6P2zY1stRsZQsZiKMVkHOXPICCy2R9uZkF5kyXPsjAGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BBfJkyPM2EEdPVwgUJvSS44paV/CpOstUXIBVFkzBCgIq8Rl
	M/tEAY0JgABTjH5uEXbsMUn5jac25ei7ZBpVgQ1XBJUHv7+sFFhGNOWA0H4so9VK1XO1sCvyId6
	DratmoTvQ5oTXeg==
X-Received: from qknqc4.prod.google.com ([2002:a05:620a:6544:b0:910:350a:6468])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:404b:b0:8f8:d17c:9f9 with SMTP id af79cd13be357-914a272c301mr299429085a.16.1779366108655;
 Thu, 21 May 2026 05:21:48 -0700 (PDT)
Date: Thu, 21 May 2026 12:21:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521122147.3584624-1-edumazet@google.com>
Subject: [PATCH net] ipv4: free net->ipv4.sysctl_local_reserved_ports after unregister_net_sysctl_table()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, "Ji'an Zhou" <eilaimemedsnaimel@gmail.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290393-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C762C5A4B89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipv4_sysctl_exit_net() is currently freeing net->ipv4.sysctl_local_reserved_ports
too soon.

Only after unregister_net_sysctl_table() we can be sure no threads can possibly
use the sysctls, including /proc/sys/net/ipv4/ip_local_reserved_ports.

Fixes: 122ff243f5f1 ("ipv4: make ip_local_reserved_ports per netns")
Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index d8bdb1bdbff17ab52fe969b93ce13673e88c05a4..c0e85cc171aec099fd5d4897b1a623dd27eaee08 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1705,10 +1705,10 @@ static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
 	const struct ctl_table *table;
 
-	kfree(net->ipv4.sysctl_local_reserved_ports);
 	table = net->ipv4.ipv4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
 	kfree(table);
+	kfree(net->ipv4.sysctl_local_reserved_ports);
 }
 
 static __net_initdata struct pernet_operations ipv4_sysctl_ops = {
-- 
2.54.0.669.g59709faab0-goog


