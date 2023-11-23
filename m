Return-Path: <netdev+bounces-50347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E127F5681
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF411C20B06
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41272EA8;
	Thu, 23 Nov 2023 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPslDqhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7E191;
	Wed, 22 Nov 2023 18:45:30 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id 006d021491bc7-58d205245feso30123eaf.0;
        Wed, 22 Nov 2023 18:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700707530; x=1701312330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BY40MezrcROj3/F+9yGbhrX7rr/7MPMOcTvBUms6oE=;
        b=UPslDqhvuuPkNgQNfztukeMUU81+GQpeDIoSpOLkOCaRWzSOUxJdrRjzkFTJARjPb2
         z9C0AEzX8dnXi4uq5hFVJV8h6W7Uur0gvLgDwXI43SZeonhA2IfW0ja+WlTBdV1FioB1
         vP0aKlYRGz9e0y1kEYjfYLz6xXflKuwMkymMu7Jedigc/68MfX/vZZB55EdzrG1GZr2Y
         WRZefEVr4qaLjok8++4EKwjpi2MggQPBCh3MIMGubhxKL3M/7wo4nXt7aRuvv/uZpgQK
         JpwAIVc39SigngyQEf4YQvKDKAuSsKokPCX0mc8qI54PRKGHK5XWcs7k5KaYEe/h3is1
         Yn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700707530; x=1701312330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BY40MezrcROj3/F+9yGbhrX7rr/7MPMOcTvBUms6oE=;
        b=MxRMItVqioJCdrODaw1l3Dm/nzQGdA6pJfe7h2omTOTY39JhSlDyzYI9s3nqLziP9g
         5rZHBgT5Cs7bc53jwPhN0akz5DEnXkN1sLdH/0/sYwnZk+oFBQcdv1nn8mbyCGQrvB2i
         npHkS/ficrvOo07xkYtBgMMDTcdpBRKjoXqJrbdjH3lQX4/T5R/rXCdCYVV82HdwVTTY
         AUZ1GlppocftIIdFC/6G3CGAgnR66p1xVERZtdgN4OvLr1dhJ5Izz3cOJK18xvQ6IaFB
         cPeynGIILpasMhik2COIXSOuemkDlF8KcNbzkVemQL/1xrzX+8XUu9VqqNkg3WULpJj3
         /2qg==
X-Gm-Message-State: AOJu0YxDHeTNygYoAXpzgI4feLmFosiz7nUE0dPzsaSH3vWGKa3Wqu9z
	nqTY/jyjccgI1OyvArrEbhM8l7Z7O3Zv9g==
X-Google-Smtp-Source: AGHT+IEKwbX1uokHFfShgnFs/nAmq1IE1FkfGzTJV4UGa3tzYd/TUvjxRtyu+cCgPPaI5QTLb959QA==
X-Received: by 2002:a05:6870:f14f:b0:1f4:be52:b129 with SMTP id l15-20020a056870f14f00b001f4be52b129mr5540504oac.56.1700707529929;
        Wed, 22 Nov 2023 18:45:29 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b006cb7feae74fsm167990pff.164.2023.11.22.18.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 18:45:29 -0800 (PST)
From: xu.xin.sc@gmail.com
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	xu.xin16@zte.com.cn,
	xu xin <xu.xin.sc@gmail.com>
Subject: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in tipc_rcv
Date: Thu, 23 Nov 2023 02:45:10 +0000
Message-Id: <20231123024510.2037882-1-xu.xin.sc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xu xin <xu.xin.sc@gmail.com>

Background
==========
As we know, for now, TIPC doesn't support RPS balance based on the port
of tipc skb destination. The basic reason is the increased contention of
node lock when the packets from the same link are distributed to
different CPUs for processing, as mentioned in [1].

Questions to talk
=================
Does tipc_link_rcv() really need hold the tipc_node's read or write lock?
I tried to look through the procudure code of tipc_link_rcv, I didn't find
the reason why it needs the lock. If tipc_link_rcv does need it, Can anyone
tells me the reason, and if we can reduce it's holding time more.

Advantage
=========
If tipc_link_rcv does not need the lock, with this patch applied, enabling
RPS based destination port (my experimental code) can increase the tipc
throughput by approximately 25% (in a 4-core cpu).

[1] commit 08bfc9cb76e2 ("flow_dissector: add tipc support")

Signed-off-by: xu xin <xu.xin.sc@gmail.com>
---
 net/tipc/node.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..2a036b8a7da3 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2154,14 +2154,15 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 	/* Receive packet directly if conditions permit */
 	tipc_node_read_lock(n);
 	if (likely((n->state == SELF_UP_PEER_UP) && (usr != TUNNEL_PROTOCOL))) {
+		tipc_node_read_unlock(n);
 		spin_lock_bh(&le->lock);
 		if (le->link) {
 			rc = tipc_link_rcv(le->link, skb, &xmitq);
 			skb = NULL;
 		}
 		spin_unlock_bh(&le->lock);
-	}
-	tipc_node_read_unlock(n);
+	} else
+		tipc_node_read_unlock(n);
 
 	/* Check/update node state before receiving */
 	if (unlikely(skb)) {
@@ -2169,12 +2170,13 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 			goto out_node_put;
 		tipc_node_write_lock(n);
 		if (tipc_node_check_state(n, skb, bearer_id, &xmitq)) {
+			tipc_node_write_unlock(n);
 			if (le->link) {
 				rc = tipc_link_rcv(le->link, skb, &xmitq);
 				skb = NULL;
 			}
-		}
-		tipc_node_write_unlock(n);
+		} else
+			tipc_node_write_unlock(n);
 	}
 
 	if (unlikely(rc & TIPC_LINK_UP_EVT))
-- 
2.15.2



