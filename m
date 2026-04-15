Return-Path: <netdev+bounces-278796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLJzO22h32mBXAAAu9opvQ
	(envelope-from <netdev+bounces-278796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321640550D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 808CD30F459D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270A3D4135;
	Wed, 15 Apr 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="g5fNoxfg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4C63D3CF2
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263309; cv=none; b=rAqYxfAlLkVNOKO2tSHfLGrg751ZSoitD3xGs6NNylgzUbF8Tenit1EE3AtABSvTFYzmiwNcNmvXZkzZWggIhfZfduTHzTge9xILDdq8j4NqP5Ua6Qtt01cLHQd3mRUYOSU/8iAiKfotOW2D4SgPDwQpKVHMTczL6jkcuHme8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263309; c=relaxed/simple;
	bh=fbqM3x3GD1CCUD2vyX99XNBmMghubH80srElmDJt3Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tq8fItvzslR8ah5/GND9ow9qZzUDIHnLxTydw1rUdl8U6mpOAuEy5yTX+Ocjq6OtXCL8IjfMFvE+wgJKRGytKW3NAgC3qnRUivDhAY29SUUOXcZWTj3Lfh9RPLnqZa1OlJ3rUExb3htvA9oeJASjxOOT6iEPbqb2aQrKbqq0HmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=g5fNoxfg; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2dee127b3c5so723347eec.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776263307; x=1776868107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=g5fNoxfgIjDKv3tanIuKHoZv3kuR0md+4z06gtrmk+lYro4waIkTM55cx/MNlAUQO5
         gsTC3+jJweDWM8GNASSDOt+1a67yvN8ZlixhENT3tNCKkJaqNKno2LSBTn6OAt3T19jl
         suH5WqX0wCqCWaW9XfIkwtNuXzKSrCXVwbbaRiAPruhJWGmEohBth8gU90ci/Y7ADWHJ
         KW6r36gGo9HmFnlke01tzB3zZaVUVsokT3wgBXv0TqFNNQNPoYHKq8s6M2dhm1AnaJlN
         LnGJ22WJ5ARJ3fz0QZ1PvmAOXKIU4PMzYgWb2iiYNbOW0eB67nPP32BJeZmutGUc8CqH
         +PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263307; x=1776868107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=AJb6Yzg9mYUu0a3hoJn2WOgq3+kUSAI3qzvfmsTciooYL44gqzAfqyBxBBf43f/1Gp
         hp/OHypeSJDArY5Wh3nXL0IJ6SHwwMQFV5B3o99wDQVh2CeJyHfPt1X+CA5uiBZB699S
         3m1FfXULc6aQJHEX1RM4xaezuBssg9Li/Fyx+W27Nt8idJx6DkqHJ2FcBOXA6VttQE+W
         A691xUbR1QbnFrrw0QyPafVH5VKlxGOV3X1s+Oc3a3B7LhipERaD6vkQ/KF+e1GFHOo8
         BQgPBbVmb4q+oP+G73I2EMQ7U2bxXBRBZlHK0cIWvpDd995CxxM6bqkAaFXll7m38DQ/
         hM0A==
X-Gm-Message-State: AOJu0YyWisHex4hKTu0dhlYahq/JeH6Gd3sZq9b1xppGzlFTPbfXFFGK
	fYHCEe9V3+8sxY7SJRnh6DHYUwqSJo0Gx3MxSHhJVMTVBvq4YXP6LuIluTPVvlng783HTWIRhEs
	n6X42
X-Gm-Gg: AeBDieswkBfacQqJJLauCD4pHmQyBFRxHeB/8VICHRMmKMi1FgkvjscRJAVSjYzS8k9
	TuhCKL2ABPUB0v+vOD2cBjYRpQD16+y+tmQulPG0ep6R7ESOe1RMmrfE0kZ+9iKzQQYJp4abyiC
	kPMiXbt0I/wYTMN3kql1pYAOn7XvSG70qLeRn/Ce/hVu/zsqNQa93x9twXzIKD+g+mUjIsYhZDV
	jBx/WcAMScM9e8NZqHEWIakxemToBd9j+SdMp/SPShlnpUNGYqu5qoILFaUvyMO2xeOAqQBb1VU
	NKToSuQiCQ4X4Z1CoW9LnIfnjx1Vfmf9k18dd0RSTB6Q8Gf3j0a8lYjZiGO+iAcYmieRbUKxf4h
	3PFlwfI4X6292KSFqSVeOwDDSBal+H1+OKK/S8/9Bzi8FGRNW4uZ0FrmjTi9YMWg3xdbiY3Z3Gg
	36QcAbT2+YUnlwMwZgooHfVhGeVtT9jYfDxaDUutD0Sos=
X-Received: by 2002:a05:7301:6895:b0:2de:aafb:fed5 with SMTP id 5a478bee46e88-2deaafc0253mr1249127eec.9.1776263306811;
        Wed, 15 Apr 2026 07:28:26 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm2751347eec.18.2026.04.15.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:28:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 1/5] net/sched: netem: fix probability gaps in 4-state loss model
Date: Wed, 15 Apr 2026 07:27:04 -0700
Message-ID: <20260415142822.133241-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415142822.133241-1-stephen@networkplumber.org>
References: <20260415142822.133241-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278796-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5321640550D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 4-state Markov chain in loss_4state() has gaps at the boundaries
between transition probability ranges. The comparisons use:

  if (rnd < a4)
  else if (a4 < rnd && rnd < a1 + a4)

When rnd equals a boundary value exactly, neither branch matches and
no state transition occurs. The redundant lower-bound check (a4 < rnd)
is already implied by being in the else branch.

Remove the unnecessary lower-bound comparisons so the ranges are
contiguous and every random value produces a transition, matching
the GI (General and Intuitive) loss model specification.

This bug goes back to original implementation of this model.

Fixes: 661b79725fea ("netem: revised correlated loss generator")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 20df1c08b1e9..8ee72cac1faf 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -227,10 +227,10 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
-		} else if (clg->a1 + clg->a4 < rnd) {
+		} else {
 			clg->state = TX_IN_GAP_PERIOD;
 		}
 
@@ -247,9 +247,9 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
-		} else if (clg->a2 + clg->a3 < rnd) {
+		} else {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		}
-- 
2.53.0


