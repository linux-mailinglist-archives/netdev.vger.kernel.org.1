Return-Path: <netdev+bounces-275409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHQ8KueK0WmFLAcAu9opvQ
	(envelope-from <netdev+bounces-275409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:04:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B63439CB47
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 00:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DDF83004920
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 22:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A35366045;
	Sat,  4 Apr 2026 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="X8vVl/2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9D2EF67A
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775340260; cv=none; b=R0ju/GIM6IQvtydEdIQlSz+3By2QeBAFXxq8lLG6bEUvDY9i0Th9xTDHCDlTjwxry6tSaophSD7jS4lq2P7y8qyEpvQFvXQFszXcn3bosvPg0rSZBdnZLH8yyM9DJ/gxgObC+yEU/AVxS+JQFSt2f8WDbrzgVcbNLRwczHfFQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775340260; c=relaxed/simple;
	bh=3htDMpijlLdFNOIylX/zvA3+e/VpyjafNLK2zZk0uec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbyN+gv8g8ULPBiSDZQcIQX4+g10Btut1dUaXKT4WPbLALby35UTn8Lveu3Zy5mLckNfjtmP+tA7/+A240BAAp79rCYS3u0X6TzW8vg2tPPRUteIYyChqbMb3v9e2i59HgI/iEQaZ330Cvl4eohzDkCwNI3K8CvnwTMafXSK3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=X8vVl/2E; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-127380532eeso3209036c88.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775340258; x=1775945058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/O3tdPENN2AxnV6AVy4gv+gRyQfl50um97+1tUDvCl4=;
        b=X8vVl/2E+/JGVpuHA5sTYNwJWPxoZGJyz4KIAMqmHLO2+okttoD5MSpryiXlWvzcfP
         zsjPh1BBi/dzIs5grYRXkhmg/ve7GuSOvFMVN4j3tnX8dnXpICQE7xYylHfv6vRKA0PQ
         GKKT2oMdBiFAE7PJrUENh523KfOQPg/VURTUPjaRnkMRYwT8H2/kKKFD+dof7dqAI/l3
         euYnSBEuKygBGT26Ufsomw5A97shtENvRnpNBixLHfX+jdq8576GtjCf+AZ+dZkwgGjL
         06QWoHxdXI5vxtdig1Vk99FIfPFPTKErI7ev+0ldBZGQOvErjNL8ODEi+wJHIC3RJC4B
         D3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775340258; x=1775945058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O3tdPENN2AxnV6AVy4gv+gRyQfl50um97+1tUDvCl4=;
        b=deH3AJK/mekRjVgvDHuyaCWKfol2BHmvCVcarH90HXpIHH24VV4aNjcEmSX4jYp/Bg
         OnyRZ6z4gAp/kDbvk8KF2j1vCVnbwje8H0nPBI3dyNMo33OgYYThPx8wMLlD2o7Odxcn
         oHxH+oXl3KrWa6/bmnstUk5up00FTh48See7JlSzyqThux82XnEBWKYVRYASe5SYKpmd
         4Fjmd8JgIZmaYnCwCSrqqSsbrkkSZ7gIPaENRMSN2o9XkZrEdUvr2mkFrBsqafIO7mv+
         +4oDVOL8fxJHtqdf5JwREGmm/tG+MLaLmdWJPW3mn/nE0s23Ysnd6BJmjXIkMQQBAXSA
         d11g==
X-Gm-Message-State: AOJu0YxPy78Xhmm5T1rAVZXfCD42P7SJnNZA6h4QsZbrig0r812sIt7A
	Zu24OkSi3PdPoG6qQzsWF0euKcsUYWyT1jwJbmrs8JrHk35XEPpR5h3psAeaN9pKOkzkCgK4Ah2
	s+mgW/g==
X-Gm-Gg: AeBDieu3ySe8qbmr5h14wGtXLLzvx4cyg7DLn7ydECENV7a4DWEQ45Nav9OEPlNF0t8
	GvhkBKJeuZekiK/KBY0SeCGZmuR9NwDEJMFaU3NldptBHXzKEriP+2tl/Ap1AS1xqO8/VDjTeHN
	AbHrkA38l8YkyUJFABQY2knVuv+G3DAwWUVNPwXbENmv0cEiPaoQLzT/nO621m1aOUsg/Y7kNo6
	zD5NI4vqHOmhTa0woHZBLvqia32FhiU6kbPUBHVbBhtLVEBfgyYcMSrIrXHLPI0OVHC8nR038Gs
	rbAAlBz3T+8BoLc8assBSl4KC9VtBJgqvfdnip5bwynAtz7QEyxBbTF1DqalEVy9fawTK5X8ve1
	SOTVb3ZPVy0LcT/Kv2rs9voJy88oaoO6YZF5ZUq7AVGqc8xqEqBrf2NOCoGximUaCD8TFH9WhRW
	Jr/FyfRnh/uoyPNPBaf/0qH2kTzCtO5u6tqhodFWAH00FSFifshxAPeQ==
X-Received: by 2002:a05:7022:61f:b0:12a:713b:8964 with SMTP id a92af1059eb24-12bfb6f6569mr4185933c88.11.1775340258079;
        Sat, 04 Apr 2026 15:04:18 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede7f085sm7911992c88.12.2026.04.04.15.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 15:04:17 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net,
	andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net-next] bonding: remove unused bond_is_first_slave and bond_is_last_slave macros
Date: Sat,  4 Apr 2026 15:04:12 -0700
Message-ID: <20260404220412.444753-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 4B63439CB47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 2884bf72fb8f ("net: bonding: fix use-after-free in
bond_xmit_broadcast()"), bond_is_last_slave() was only used in
bond_xmit_broadcast().  After the recent fix replaced that usage with
a simple index comparison, bond_is_last_slave() has no remaining
callers.  bond_is_first_slave() likewise has no callers.

Remove both unused macros.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 include/net/bonding.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 395c6e281c5fc..a95ec27c1c1a8 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -69,9 +69,6 @@
 #define bond_first_slave_rcu(bond) \
 	netdev_lower_get_first_private_rcu(bond->dev)
 
-#define bond_is_first_slave(bond, pos) (pos == bond_first_slave(bond))
-#define bond_is_last_slave(bond, pos) (pos == bond_last_slave(bond))
-
 /**
  * bond_for_each_slave - iterate over all slaves
  * @bond:	the bond holding this list
-- 
2.43.0


