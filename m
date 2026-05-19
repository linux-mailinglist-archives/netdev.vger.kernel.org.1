Return-Path: <netdev+bounces-289420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI4GBm5QDGqTewUAu9opvQ
	(envelope-from <netdev+bounces-289420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:58:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8454E57E2DE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6A323103687
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CEB4921A6;
	Tue, 19 May 2026 11:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dua2tXJg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44B4A2E1F
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191041; cv=none; b=r2dPZKpZZ05Du7u5GLV3EXc+LUaEGyL+GjQ68xTUQs31plhFmGGOjj9n37xji/BBV/fDNTB44avlVbLOw2I2J/8zYAaAs8079pKEf0vIdmAWpBCPwUAE6Cil4/Ba+ok508IUKQW90BR/A24J0D4Q3DkD6hBrRTNJ61d2dqO9Fws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191041; c=relaxed/simple;
	bh=c/trwgziv1vz2AwyOeXMFX4AVndsk0kHdmZmLkXT20s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A6GjppTs0gVAR1tHN/EJtLnxc8HgJ0CzQdw8souHPCe44lSbK2hHs/rICMQrfsr8q223MW6Bf8/LJN6bXXA0y4XS4qfqrlPQcBNTPHaUsM6ssNfTtdMFiVMT/ovCLxEDncoyax1hnFvI+BqunpZlYQzsD1J1wb58fEMPOuAB9So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dua2tXJg; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-90cbd806004so865079685a.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779191039; x=1779795839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QkPgyF49xu09RNO4wUWq+KVBfoZAcFGIUSSqnIfmUw=;
        b=dua2tXJgo9tqh2HMv2qSbTB/Ko71s5/FyaUwYhLcE/Bd1DmaJaLs8Slv2/Nf1egAs5
         DC/l34kvCwKYvwcGLC1x81xQ1X4g1COvihM5xGGE2H1hlR0znYIzprzZl0QJoXSoXEPr
         61bSZ6Syd/sWE+J/KmSFm1QSpi/mBC0EA/PNJBxQZ43gS0FDxEL/wl9wdyt3SIskQOSc
         E5r8kVhkkpIVy7T7nL2AQOMeA41xdeKyD6xFk2lizBPEtYp2JR2zPj5YBUOTH2GTB4PC
         q9zJjex1LZK0lvkzcHs+B9hOxUrRiCKusctVKfLj10Dt3AcbxA87FFC4L4B7TK4nTxSy
         8T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191039; x=1779795839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QkPgyF49xu09RNO4wUWq+KVBfoZAcFGIUSSqnIfmUw=;
        b=kOZX8DeM4Ue2AusWfMMETsfVE1hE7b9vzDtuSea8F9E3eFgdxiWOslvyvDLlM0hGih
         4C6WXibaODzraGenfPui950BFKgetnD8XnUVidAtfjcnQXGzZeJ5akYa5YU4QRmYoyQF
         bX+BTYPNwVFrocrsKfWrj0tTota27nZNHf9o5IeABWdaHX5dtZCNy3X6QFdNjlfH0I58
         TGTRpZfxnhyR65NBLW8umRI2GsR2Gh7XvnAc03lkwoQoA7bb71MFU8YeNRe4Cx8Y01HX
         AFCtV+uuIMjtvSpmXEOgSfG/EyijCs5Xvh+jCw8nIoEO+P+IlZlqUFCRklLkWMMIwT1y
         AX/g==
X-Forwarded-Encrypted: i=1; AFNElJ8UQ4D01MPp6TwxUmmS6kbQ0fzYdRaYhcnio6VI7DSVMqolGK2phKGlXc6XNB0prqIDpQXWT4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vf3NX0VFWryrnC/hMIzTkbm+3xlId8rgwrPYPLfL6ATwOHoA
	bWDXLd+3k6aoL8nxFhZTicZFiZooA8FO0cnIFGySIbtAUdyx5C7frhVZzfadr4WSING06luoZis
	sBJAAWtY+2ZZt5g==
X-Received: from qknvq27.prod.google.com ([2002:a05:620a:559b:b0:910:656:27b2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4887:b0:8df:1541:d782 with SMTP id af79cd13be357-911cf1fa25bmr2890241885a.52.1779191038422;
 Tue, 19 May 2026 04:43:58 -0700 (PDT)
Date: Tue, 19 May 2026 11:43:54 +0000
In-Reply-To: <20260519114355.2769474-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519114355.2769474-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519114355.2769474-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/2] rtnetlink: use nla_nest_end_safe() in rtnl_fill_prop_list()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8454E57E2DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid corrupting a netlink message and confuse user space in the
unlikely case rtnl_fill_prop_list was able to produce a very big
nested element.

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
2.54.0.563.g4f69b47b94-goog


