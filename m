Return-Path: <netdev+bounces-272690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO7+KdsAx2lIRQUAu9opvQ
	(envelope-from <netdev+bounces-272690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:12:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB6F34BE8A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 648A8300C6F5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 22:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6260E1EA7CE;
	Fri, 27 Mar 2026 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu0c69QL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D04611E
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649558; cv=none; b=q+J8YTkeqMw+Wvxv+cbYjgWzLkk3jGY2y8QAZsX0N2osFrl5NLK71g/9HJ+0xQHnu+RxxMe5D/9ur+c60dIjk2/yowsOvCRbLGpp0aQbZaUit3soD3TmjdI2NS8E1kwRcPoDgQzYnY2E5nuo/fOIVvDrTHn55yz2oLqDzbvcyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649558; c=relaxed/simple;
	bh=w/7fOtt4O/RRNzN3EAeqkf9yji8jFjcE4ul9TX/U5xA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=raANwXxQISv8kCwAedvjcOKL1T+lWVBAwOSdj/gBzO8iMh+C3yrJNcdcUbMBKjrcO4rHXLdjnFN6+jLzJYXRyJwgmkj4t64ksRmDUwpgRKEUrpxZ93SHt022DZvYq2JeZatnl2SZ1piueis5GDql90M5bsM1qP/L5cxgrt/mFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu0c69QL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e4989dacdso1256639e87.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774649555; x=1775254355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssFvq14p2MdVdvTTUPQxZPpSxGZHn0gLhIi+HQpimJA=;
        b=Cu0c69QLoelH908LCjwWN67tzh+/HvOJLhfTEbp2vKF+XYQFUu1VyES8hJc/vATdsY
         5h4lq6tMbRvsQqkxClMtkWtdFVbTBNXd+6e62aaqD9b11A5/NmStpG4I6UML9UVoayde
         lB+/KkJObJiUrHMlOfSQJBM4fS9ptQSEVF83tIfsEWVujd5izCw+GB7TXRaYQSlwJd3D
         gTKRluhPxvfUUC/gGzezAYvHe+6To114fjtiOoqsC41nPIKfSRdwSC/xASggzREnZiV2
         Zfqnohh9w8AjfmgOZUqyO6xMItN2uWrnhlKV+ltxoocvf0hEN5J9FDMWVaBa6avZP2pK
         QKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649555; x=1775254355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssFvq14p2MdVdvTTUPQxZPpSxGZHn0gLhIi+HQpimJA=;
        b=dcxqAdo/0AbgdTTNQjM5BAkTqUvVGDiNsBLaL39zHeNgMaoXIDdosHBf2WsqER8ogb
         DKplPq54IxDiT3BxcuU4Gq2WqUmnypDd9mdz+hvm+bLCyQOzUEQ27RXRWk5z2sk16n1D
         CFTcCIIl+oUGYWacBGLMqLTpMl29NvXnSQVwxztCpVY8XsB9HCIFAZMNpNsdYTEKT2ag
         hPqvoBDRZcrgMBI+9kX81ZbFL5cmWpIv6kyq1qvpczrseD0hST9oauX6gB2kxIZzzVy9
         NKzJlJWn9YfB72N9lLbqAg4Rg5IFaNzzkp1GpMPtbpNpTpX0rFkNWRwFNVfwXV/usYG/
         jO4w==
X-Gm-Message-State: AOJu0YxQw5yng3u/gaX1tKDo+sS9S/fNV/eiPAj3uumfETlYEg9SSucv
	xrkVFhD5PLAoS3C3k34m04jLIyJLbHzaClLNRA+g6vUGwI3npSEedbR4gxmSPgaKb6s=
X-Gm-Gg: ATEYQzyGlz2jkaeUeQ9po6wy/SpNlmS3XDPEZhwmNT4pQtv+hFDSc533uzDt3L8OCG4
	l/V30lHTHv2h0lgwb6NZcwjok/Pt9qzqKbZP57McENi0yrbaLEiPcz4kkXHLD4id5Ewa1LkSoAl
	EH8Kt11xIHV4hyZbajnr6ZcyX8lKmK9wF86vC73mS/+P9OsvFg2uewgcMvnZxV3XA8raaduQJIp
	AUdF8AYM5tLBlaYNCGe8qFuaA+dmGGTl8dv4k1zHF49FcHS24p2Ma9sQnkNWzAI9dY6pT20egvP
	zkIkwpIqLiI4T1AbkJ+vhGHbLZQa6v43KUr82lKLABI9wqVsZBDIMOLuzeHxMzdzpPSNxAIvwvd
	uIegnCu3Q4mA+q8YHIl5VcbsZ8WmiXPmrXBwA19078ZEfDFQNrpD8ETiSRtKoh0Uvop65GYptCw
	91P/2PaZ3gYet3kNvSu+lMFE9XuJoVJWDCwXTPyeA8ztp3M1aiRnWmIA6q/aAbUwfPt/y+QOZ3I
	b8kku742/6zWclV1vAqTLzrmfL9vDPskBLMjt/qfJDz9gGUVw0MesY=
X-Received: by 2002:a05:6512:6d1:b0:5a1:6c86:b957 with SMTP id 2adb3069b0e04-5a2ab7e9136mr1731606e87.3.1774649554600;
        Fri, 27 Mar 2026 15:12:34 -0700 (PDT)
Received: from localhost.localdomain (ti0034a401-0790.bb.online.no. [85.165.210.26])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b1456aa2sm49636e87.68.2026.03.27.15.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:12:34 -0700 (PDT)
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	nickgarlis@gmail.com,
	kuniyu@google.com
Subject: [PATCH net v2] rtnetlink: add missing netlink_ns_capable() check for peer netns
Date: Fri, 27 Mar 2026 23:12:03 +0100
Message-Id: <20260327221203.430454-1-nickgarlis@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272690-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nickgarlis@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9CB6F34BE8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_newlink() lacks a CAP_NET_ADMIN capability check on the peer
network namespace when creating paired devices (veth, vxcan,
netkit). This allows an unprivileged user with a user namespace
to create interfaces in arbitrary network namespaces, including
init_net.

Add a netlink_ns_capable() check for CAP_NET_ADMIN in the peer
namespace before allowing device creation to proceed.

Fixes: 81adee47dfb6 ("net: Support specifying the network namespace upon device creation.")
Signed-off-by: Nikolaos Gkarlis <nickgarlis@gmail.com>
---
v2:
 - Removed "Reported-by" tag
 - Fixed "Fixes" tag with the help of Kuniyuki Iwashima (thanks !)

 net/core/rtnetlink.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index fae8034efbf..ee7d9d65b2c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4059,8 +4059,15 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 				ret = PTR_ERR(peer_net);
 				goto put_ops;
 			}
-			if (peer_net)
+			if (peer_net) {
+				if (!netlink_ns_capable(skb, peer_net->user_ns,
+							CAP_NET_ADMIN)) {
+					put_net(peer_net);
+					ret = -EPERM;
+					goto put_ops;
+				}
 				rtnl_nets_add(&rtnl_nets, peer_net);
+			}
 		}
 	}
 
-- 
2.34.1


