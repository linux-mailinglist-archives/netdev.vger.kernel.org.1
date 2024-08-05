Return-Path: <netdev+bounces-115734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38C0947A19
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084301C20F07
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE41552FF;
	Mon,  5 Aug 2024 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="anHvnetz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D67154BE4
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855438; cv=none; b=mb1WhT/EYnztlO7EECcpCtk3j42wV7HLoa3dYEZ96E6MPiL9ksluyIv7baPTjZZPXKO4+6QusEI7DbCLIucRoSO8xZA8qyRY1xr53uw3Y/LiEyMvJnM4esOxwoExqV5gQYYxgcxeWULMCncm3BF8qiRLulfbTN/7TJjPqV7vZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855438; c=relaxed/simple;
	bh=v/yXJrBDlpAQrlFKowIyb4g9XUvrM0bLLMWzVwzKonU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1ClP0/UF2j3/J5LQRzCsdHKBG3/Bw9hgKKbY3oicuyhM2rAWz6dALig6rCs5FEJeX/hxdsaI5VzNA1TOoEQVSD4q6fNxXKhQk9E33KkjAExjcgjJgHK0K0FF32mv4Es6b+cNqbd2eQDM6vOudSWYhmYxdg3+iwtFc7xk5zuVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=anHvnetz; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1e2ac1ee5so662950085a.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722855435; x=1723460235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vsfsWl1qU21FyjK2pca4Vhgh1w520tV98Txp3TT/7s=;
        b=anHvnetzeXki9KIaeBg7uFGwmQxZJK6zXei++vYZXLzh3Vbt8ePVwkjpO3xyX+EoAz
         PqKEQbloBIUB4ObCJhjmMkMsDLDwm6yz+8Vp/o1V5cY/pEAoojO5T47q6eRxPt8Ir/n9
         rKv/PqFAAGyhBUHaLzKn0UnpzfcKmVPut8Om4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855435; x=1723460235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vsfsWl1qU21FyjK2pca4Vhgh1w520tV98Txp3TT/7s=;
        b=IytZM2yCFAbr3fT1Lcm40duUuAymq4gnCqEbzCPNIrIk1HPzEsJFBjl250HIKgv6b2
         LSaarKrXgBJR5DxuYls7VPNLmuPd2ahfYpY/ucRtL4/hMNwz+kmdo/d/f0RKxYmbcNiS
         /IMAI2O9ZdlEY1zbMB1QgWriuiFqdbEHq4WgRqGyEoF9p7+QLDRV2RKVRmt6UODRJxHl
         PmBKk0XlPqLQFQhYiuDtvCNBQsL6KBc/GWXEpn465G3ORDho8sQ688DCAy1spvufGR5V
         SLTalhYePPNIP5XFjwY3KI/PBYlN/d6uasoIVm5HrNzxqXTAtr9HqWRhgwOb8B1Ud50e
         yNWg==
X-Gm-Message-State: AOJu0YwFCKGmCb97fO7VboTY5KXaQsOVUpuacAx93litqBHC/JF4RthS
	P1pF3yB9aoqeu6cHNbvM2NAiXHUCAvlL3+M8tbsx3M8WHyHkEGQrP7DzoPgf9sX3Pbvt3b0v0Hv
	R/DDb9cilRgx1ECSrzVjC6zNrVFLCAuxWzOmpbmwzKXGmnjYkmYj2h2VsahxS36xOhhZf/A6PeT
	Tdor/vszAB1Wdcan0DvbkeMo1dp7dwSPXZrRqXOjatZXOjElNM
X-Google-Smtp-Source: AGHT+IEmQEjwP1ujLpx4z2MXZ5ZWnHVoyC3L1CtWbmkdFBbRumLuxPvwGVAaYfa/la7U/St01o/DPA==
X-Received: by 2002:a05:620a:424d:b0:7a1:c40d:7575 with SMTP id af79cd13be357-7a34eeeb1damr1339125485a.17.1722855435201;
        Mon, 05 Aug 2024 03:57:15 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fb785sm332890785a.56.2024.08.05.03.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:57:14 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next 4/5] act_vlan: open code skb_vlan_push
Date: Mon,  5 Aug 2024 13:56:48 +0300
Message-ID: <20240805105649.1944132-5-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to do act_vlan specific network header adjustment by
copy-pasting several lines of skb_vlan_push code.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 net/sched/act_vlan.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 22f4b1e8ade9..84b79096df2a 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -49,10 +49,15 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 			goto drop;
 		break;
 	case TCA_VLAN_ACT_PUSH:
-		err = skb_vlan_push(skb, p->tcfv_push_proto, p->tcfv_push_vid |
+		if (skb_vlan_tag_present(skb)) {
+			err = skb_vlan_flush(skb);
+			if (err)
+				goto drop;
+
+			skb->mac_len += VLAN_HLEN;
+		}
+		__vlan_hwaccel_put_tag(skb, p->tcfv_push_proto, p->tcfv_push_vid |
 				    (p->tcfv_push_prio << VLAN_PRIO_SHIFT));
-		if (err)
-			goto drop;
 		break;
 	case TCA_VLAN_ACT_MODIFY:
 		/* No-op if no vlan tag (either hw-accel or in-payload) */
-- 
2.42.0


