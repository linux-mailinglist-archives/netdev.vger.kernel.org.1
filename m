Return-Path: <netdev+bounces-253627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNayA73+d2lqnAEAu9opvQ
	(envelope-from <netdev+bounces-253627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:54:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937DC8E575
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84DF13038ACB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5B311C10;
	Mon, 26 Jan 2026 23:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMx+AoDz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A53101D8
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471637; cv=none; b=upDLRat9wvA+WFEQYtKyLrCGLfbNCfAYyF9w80mQj0TwLArowU/g6Pl64vDAVdniAhE62Rl6yLAh+qNjTWmfKknC8upKE8FqEy40OY5VjwaBPzNpwj3dyEHCtCOkY3mfN+glsuPHQcrNSUtvxiyeb+xRitoY7SrrbA96loawPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471637; c=relaxed/simple;
	bh=/ZXwZld5bLuwTdufAsGeC/Y6hOHBT6U4LJEcx8KgdPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+b0K8FQ0Z2mNVvqoYyBzZyAQV5AnMSi8TZEF07Ijkm38aRRKUwVn7foZFQxbfekbha86DGycqUjQT+pcpNumGwSwmA/GjPun+Bvv4km52QvrYTvHPms7u+wh2cCLfmzaaOAiMcE9aVTN5yV94JIiCA6r20MrCVxw4tWg7giH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMx+AoDz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso23174695e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 15:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769471634; x=1770076434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmWVMVwvPTK2FIwhrKTslQqaInGPyMYIwR91FiuxO70=;
        b=ZMx+AoDz9DwEy/rRjY61e1y7BIUWWZ+pbLRELT0EG9JGLDAiA/ydEtOKpT5m/e8VYH
         3v/lvhvqprw+nPuRghnaPDI0wZYNxuA/NLzf9kiaPu9hRBgxLbl6OkJMliONzTUhI5Fy
         kzdoV1+WLUOIa7X2PiZlpuHPzlX+sO66cZI5sTtL7gDr3VSBZCPQWJt6GVZ6/vYCbQuD
         8VgekPKX0ucAOTfkdx7v8nDH7ngAcv/38vAS9Px1I4pW8MTpCLe9vLR0FwKwxa63+1FD
         aco/B2Anr9FgWBiSnxj4EcFhLnym80MjjOvM4bXUyL6V5yXgTJYXMa/aomdlGrrtddj6
         ROmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471634; x=1770076434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmWVMVwvPTK2FIwhrKTslQqaInGPyMYIwR91FiuxO70=;
        b=hEXLK8y8KFY4ZVypGqTIStys5twMwfEitrlX/05baon7BP3rMDwYcmH26O7xQe9lBK
         idD5reRM11KUWmR40gCLRGaQRTdAhfb2znEmbNhr+fUeqWzwsk1zkYXO3FUjTx0rTxxc
         uzf88hMYMNXU7v0aWXfsuDQxF110/bs0OTkHezA9dnrho9GYg360xd26I/AGi1s4zmvc
         KszCzbgIWp5p/VVbeDNGhtuIGR50yRzTOBWwcVvQIY4EOpFiIe1iLEA4UwEoP/QUyQFA
         fex/8whwRG8hmHuly0v7g3N/hyWAuH6R/vzMPxxd+4+dCsQIFIIkuoaJVXjpUjqtb9U1
         qUdQ==
X-Gm-Message-State: AOJu0YwMFOCHhbVmK48NHs64jRALdqnqr1DSV8ov1F1SpQ9Z5Z8NvPEJ
	d7Y12ZIYfsxn8DO382PxdlXQqSxLx42LfZC8RhhFDRr6xK14wlorf4ux
X-Gm-Gg: AZuq6aKZc4QAxf1b+nrFBfnpJLuSEMCGfHesbATMYS0qnk6QyRygwtrl0sGT0LS/aIm
	PWD7Ab7NIcNFd3QGzpIRb5etu2aiOWWcWohMWwdHrofieGUdvgB9+efFIgwNW5uHJdHsovwReST
	/KmRdfkE7DnfbwI4sbFy7jIpHColcjQ59zrYfo2pxJ+nO2ohODmDHqU+rYoeWx+CNYFCeedxDVB
	JXZEPojgOjFkR+TT/VQBF+mOv0UscMmuqQnjoU6eOPtegzXi236ZAs16q50uJgHUti9jY0/Af1d
	qkAlFf609QJje7XpcKVDcqYMDq45nx8/JEgd2/WlXtT9o5cJR05+EO/uHiyhat7oRq2TPUYX6a2
	nPpw37+qhowx/tbTu12hC/Pihu91ujzv+M8sy+NWmNGsBXlPvNZcZT2+tAlrmkZdIoySSKJi9yN
	R6z/P3ddkzmr6qsFQCSPG8Q+gMaWUiK6cBanRstwJixH1u2aRJdxZ/Tr6IUGOg6ySdFknrfzDYG
	VRsCDl2uPQmS6m/GLYwyIXSoUgE2q4AHM363VPSNpznKe4oFXDpa79X5BO0
X-Received: by 2002:a05:600c:4ec8:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4805cf5f978mr92113495e9.20.1769471634471;
        Mon, 26 Jan 2026 15:53:54 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066be7404sm22658615e9.1.2026.01.26.15.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:53:54 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	vadim.fedorenko@linux.dev,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH net v2 3/4] neigh: discard invalid lladdr (b/mcast poison)
Date: Tue, 27 Jan 2026 00:53:04 +0100
Message-ID: <973e792e8002319e6d61be82b79b1678027c30ee.1769464405.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1769464405.git.marcdevel@gmail.com>
References: <cover.1769464405.git.marcdevel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-253627-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 937DC8E575
X-Rspamd-Action: no action

Prior to this commit, the NDP implementation accepted NDP NS/NA with
the broadcast, multicast and null addresses as src/dst lladdr, and
updated the neighbour cache for that host.

Broadcast, multicast and null MAC addresses shall never be associated
with a unicast or a multicast IPv6 address (see RFC1812, section 3.3.2).

NDP poisioning with a broadcast MAC and certain multicast MAC addresses,
especially when poisoning a Gateway IP, have some undesired implications
compared to an NDP poisioning with a regular MAC (see ARP bcast poison
commit for more details).

Since these MACs should never be announced, discard/drop NDP with
lladdr={bcast, null}, which prevents the broadcast/multicast NDP
poisoning vector.

Signed-off-by: Marc Suñé <marcdevel@gmail.com>
---
 net/ipv6/ndisc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f6a5d8c73af9..34202a816a4f 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -830,6 +830,14 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 			return reason;
 		}
 
+		/*
+		 * Broadcast/Multicast and zero MAC addresses should
+		 * never be announced and accepted as llsrc address (prevent
+		 * NDP B/MCAST MAC poisoning attack).
+		 */
+		if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(lladdr))
+			return reason;
+
 		/* RFC2461 7.1.1:
 		 *	If the IP source address is the unspecified address,
 		 *	there MUST NOT be source link-layer address option
@@ -1033,6 +1041,14 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 			net_dbg_ratelimited("NA: invalid link-layer address length\n");
 			return reason;
 		}
+
+		/*
+		 * Broadcast/Multicast and zero MAC addresses should
+		 * never be announced and accepted as llsrc address (prevent
+		 * NDP B/MCAST MAC poisoning attack).
+		 */
+		if (dev->type == ARPHRD_ETHER && !is_valid_ether_addr(lladdr))
+			return reason;
 	}
 	ifp = ipv6_get_ifaddr(dev_net(dev), &msg->target, dev, 1);
 	if (ifp) {
-- 
2.47.3


