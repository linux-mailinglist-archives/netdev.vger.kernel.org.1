Return-Path: <netdev+bounces-289880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIPzL6OODWoIzQUAu9opvQ
	(envelope-from <netdev+bounces-289880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:36:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B7158BD69
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1923024A43
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358F3D7D70;
	Wed, 20 May 2026 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpC5fJh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2333A033
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273154; cv=none; b=J5XqlO65qGDkdvx3O9LGwxkZbXZhSEGZN18UOv1SzZ4rCm6zWPMc3OFWLySjX9nbXDLns+FoiaL4O9G21Q50KCxN+W2sbqehUL4z8+JDJgRbxzEirPLajmFYSkjBepNxAtP6Iauc2clQg3DWO1oABIJgeSTXPs9p3PPnYAWCQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273154; c=relaxed/simple;
	bh=YKoKTzPmc0Ns1fUpaPBm4bCN1fYXvIOnoP2Hh6GyYhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pOy6f10AtWxvQmqkTpnC+mcAzZvBcZrRblku8behiGuwaaqBKTlwyOfCqiv4Vt1IK4S9BLHZdkZ07OGFwzXXAlEqt+uoTWpgdW2Zzj2pjq0isrIPKP1PeLYhsGVxXrPOSkFTWvBpTs31QasSQSsI93r8tfzQQYlfbd/bnkObBEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpC5fJh4; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8b5f089a5c3so144789436d6.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779273150; x=1779877950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VhLla85HBliFX5MZ2Eqkpo+dLermZyEPOnC0bOJTlU=;
        b=MpC5fJh4WbYbpd+lHKZpxJFg4w6PNR1pLDTqIQTiYX5SZbIOpbLnt6AaP5DcUM7JIp
         20FbQea/Lo+u4FlDK/eztxip8SXBo+i6N826xLxcchr2IcEc491AlEsgIWwUtEapoESD
         n9Nyrvrf2QPZX27OGJEqGphGq80cSzupqLQv07ql7ztx8hssGrcrkuoYZxvdQBSWycEW
         jsJIirOkzg9OyoaMEBet9ndMpsGv5wYh4wfIErTsI2CU4ROPUgBijPCJlfnir9otAz5T
         c6to1yEJCFVr3J39GQDHNas3d8+XQsRmUDRS706pXbijIeTWHr6whdLLtAJko3C/Dqt+
         Osfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779273150; x=1779877950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VhLla85HBliFX5MZ2Eqkpo+dLermZyEPOnC0bOJTlU=;
        b=RgHlVuHoBGWYNT34IEuZW+kavmzFdQ2gSkTLEzDthZ4nzCPyiNmmXfFRoxT+q7hydp
         qHHQzEhtJ0W1YNda9O20xqFwGJpwYdJKUO4UGSCUsGsQ0GZWpMRqRCDpoDNrn+3FC5l7
         FXFUAxO24emQWAnk/nS8yL9LhjNBSiTzcODnZJh/qVgkRLjsM6EDcWwTgSPAgYSo3oSX
         eAQZ4a/cqydbTJcNVQzHjgWd2dMtP8Ok9rEH6jOFJa23oNmEbebF4SYD5mjgaCevbmlI
         hYuS3RSpKxnsdkcUYgGartZmCfwy/+aoqlWhDFS5CvPEG/QLjAtEx1SNKPLrivtiWzV4
         ES9w==
X-Forwarded-Encrypted: i=1; AFNElJ/nwxR5esw9qKT1IdS8GcN+f6KeSZeReYFnd7CGuYnOgZ3TX0ANZlCJvy2IrxpUasrd9BRH4yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6cQOL51Kk8wTDe5q0pAQJi86nbiNYdwJMV1oz0xBE1QwshQY
	g2HpG3P4srTI+wjSbg1xwEbNzyR7nzGdURSqEyZp6BWmYHUeiFjXXqFnvI2LQwAzynM2hzjWGtE
	37h2NQdaKp46Vug==
X-Received: from qvbpn6.prod.google.com ([2002:a05:6214:1306:b0:8c7:ae9b:ce71])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:e08a:0:b0:89e:a170:6af2 with SMTP id 6a1803df08f44-8ca0f6b9fecmr361382696d6.41.1779273150112;
 Wed, 20 May 2026 03:32:30 -0700 (PDT)
Date: Wed, 20 May 2026 10:32:25 +0000
In-Reply-To: <20260520103227.1133277-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520103227.1133277-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260520103227.1133277-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/3] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289880-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68B7158BD69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid corrupting a netlink message and confuse user space in the
very unlikely case rtnl_fill_prop_list was able to produce a very big
nested element.

This is extremely unlikely, because rtnl_prop_list_size()
provisions nla_total_size(ALTIFNAMSIZ) per altname.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6a5e9ace55a0880d7b1e4303d12dc0a8b8b7c5ed..ae0254f19178735b2805a8189e81a960a49b2858 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1971,7 +1971,9 @@ static int rtnl_fill_prop_list(struct sk_buff *skb,
 	if (ret <= 0)
 		goto nest_cancel;
 
-	nla_nest_end(skb, prop_list);
+	if (nla_nest_end_safe(skb, prop_list) < 0)
+		goto nest_cancel;
+
 	return 0;
 
 nest_cancel:
-- 
2.54.0.631.ge1b05301d1-goog


