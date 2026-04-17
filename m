Return-Path: <netdev+bounces-279274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK2WGI/34Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:04:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D754190A1
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94A23305F023
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BD73B27C6;
	Fri, 17 Apr 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="V9wSRnfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579163B38B6
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416619; cv=none; b=KQwgmAahAEqDgkVkHnx8QeplnXiZlKH7ubRieIn1ezcstnGSntOKec3eoLMZ0uHP2E7KlxqY2T/38+2wZbXSKrlmLjZp/SiCB1Aiz120ToprqXHj0vROu9/XXQTUIc9IwkxNfbJH8SidBHLFZL/Nx6jlCrDZoVYiU5O8VliCCnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416619; c=relaxed/simple;
	bh=YsjOQ3aHko445jag4Dh8QBAHb3omr4vwGkNhwrhZYbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtI6e0tA2ulmLJl1ANOk64C8bRLbjcPajqtMQQNgDvsjBcNgUEoI9sjGW2NWklX+pMeGEJ1F2t/EN83mt1A68qfY6QRyQmDUWwTMHJckpsia1cByHw6XZoux2eY9De7uQwGoD2ZerFGsPGIzv5M0ucVMBiO4FchhvM5iqFs2Do8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=V9wSRnfL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so298747f8f.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776416616; x=1777021416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifnqGcLqtkdwlCTDNXlvm35Q8LBETRf2RztFCjdZK8Y=;
        b=V9wSRnfL5knxYjxTMcoVECAW7oOwsJruk1awAoXb1AB3PzdkQ20pZ/AKyVsSE6zU6I
         GCNye0zE+hgiZ26DTukDaO696RycFAlzadqFomwvYI/zdM3946ve+0RWxNQgZgTw800k
         jzFMvGh+yyc/C7POOYrMfPkC5QMCEjxF7+2EsJU+gGI4LFJijVLtu27caqkER/VGB61F
         7RUQwYNqDjBRfxkbblhB01wzHruU/6L+a1HWWwK95W067ce/X64Az8ESHFVjCzsDQVOJ
         JmswnYvbQBMNgPdRAOlh+zXxdCC5xaVB15t62Dznxm20xSAZXftsuAQVDsDG5uTNJt08
         wpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416616; x=1777021416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifnqGcLqtkdwlCTDNXlvm35Q8LBETRf2RztFCjdZK8Y=;
        b=S4wQSVxTO0LF08VFr8G4v0+ca7xqL2CB/tyX1V7hU8FmfmGekU6gthICBcBN6P01jU
         /3yr5C/X7VX6ErSxJLnICHu/aDXL/g2HsJswlLJANMAP+RLegGjk+YqKeUUwZiEfuoti
         3oPZIJf5YdsO2XrqTcuwE0PxgKZ0PswxFlG54tnfCYOxyv0ZfBc0X3eCeyBKJGTYqP4W
         rCbP+Gi46Exl+nHjULElTFvbImvqIHxE1AP8Wy02ekkdDc/Ip8iwjozpns+RzeykjjBx
         gvHgef+NmotUfLCfSuQscBebSXSELlqC+j7HqzBINO7VogtRZNGI/3Hr4oSC4ttgcGsY
         J0dA==
X-Gm-Message-State: AOJu0YwRzqNwN6HuQpFoex8Xyu1cijW2FoUPH6ai3qhuCdUEcrfuAqKB
	YcqnIDXESwyr2+E+QM9no6weu2f9LzJyQAEodPi2Nu9MbPHvr4eIOV2+tQE2hKfX/PoMEN6j3My
	lKuA4bOqR/TyiCNslmLifPxTD4KuS9uJuZmxSXAABYxKDA88jFGG++n6Bs/tFKWSK
X-Gm-Gg: AeBDietT0B58JUz1+Imvn6M7lhWRq/cOenAaZQjbXtTtKI/AVwNdw6KnX77c3f1V2Au
	bbJFbNBe9OwouIJ6Jm+hU9+JmRTe2VLEdGqiYEVe9dQndYzIhnv05ywKs0VXXOP2bz221zo1V6b
	nw9pghPoWFHuO3GRKf9I7AnT65Csjvr/9Z1EFEo9wJPacwJ0QEnN5mfjY3Z/rZply3pjJrkZRyp
	Wo8UbZwRxxhtHO0zaYuN26GUIqAdX27t3OriTxCwBhdY/3020hZ7Kvblx+Y6Cu+tgbTRPlxzL/m
	+vV42ppReFLUfLsPFeQCjoWUFYEqHnZmqSLm+FC1ob++9hyYU2gpDepHiLrwiWmo/nfR77saExD
	rb6CTY9Czbv+5QviMNYtlpt1M/GQtnUKGhBmdtlgqcDVi7PQJlmjNkkIqCV8Rdh0lrW/f9uOtie
	0m2wjprDNUHK7AYS1046YXN2zC/tvkbPlG9wJRDgM9dt/PQssJ1ZzYm1T1Bw==
X-Received: by 2002:a5d:5f88:0:b0:43d:7531:5ca7 with SMTP id ffacd0b85a97d-43fe3e16563mr2745568f8f.38.1776416616362;
        Fri, 17 Apr 2026 02:03:36 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7524:fc82:dee5:4129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm4120151f8f.36.2026.04.17.02.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:03:35 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	shuah@kernel.org,
	horms@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 6/6] selftests: ovpn: serialize YNL listener startup
Date: Fri, 17 Apr 2026 11:03:05 +0200
Message-ID: <20260417090305.2775723-7-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417090305.2775723-1-antonio@openvpn.net>
References: <20260417090305.2775723-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279274-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,test.sh:url]
X-Rspamd-Queue-Id: E6D754190A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

Starting one background YNL notification listener per peer back-to-back
can intermittently stall the test setup before the listeners even reach
the Python main function.

This was reproducible in a reduced test.sh setup-only loop: a single
listener stayed stable across repeated runs, while starting listeners
for all peers could hang early in the listener launch phase. Adding a
short delay between listener launches makes the listeners start cleanly
and eliminates the reproduced hangs in repeated normal and slow-runner
tests.

Serialize listener startup with a small sleep between setup_listener
calls.

Fixes: 77de28cd7cf1 ("selftests: ovpn: add notification parsing and matching")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/test.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index eca653112aeb..b50dbe45a4d0 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -31,6 +31,9 @@ ovpn_prepare_network() {
 	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
 		ovpn_cmd_ok "start notification listener peer${p}" \
 			ovpn_setup_listener "${p}"
+		# starting all YNL listeners back-to-back can intermittently
+		# stall their startup so serialize launches a bit
+		sleep 0.5
 	done
 
 	for p in $(seq 0 ${OVPN_NUM_PEERS}); do
-- 
2.52.0


