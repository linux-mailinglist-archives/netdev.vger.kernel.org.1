Return-Path: <netdev+bounces-133394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F0995C91
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32021C20E3D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70678133987;
	Wed,  9 Oct 2024 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="B/iFlElN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31927DA79
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435375; cv=none; b=CgLM9WAQdPc8VZMnT7GKRVhCA01xoomIaMia0Von6dpo+6Vf+Sf9rorJhjXabBYVsJHuMGUHTKZqhEE0HQGy6OXXqXhhSQm31TBUWZNoiKkKPo9QUvnCl83WJvLwX2jTsyymN+DGuX4Vv6Xcc5o9BDKU9ihDWQPrhDMCy3MFJdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435375; c=relaxed/simple;
	bh=DHbZfeA6zp3c1SN+4z3kVAiT7+/abWBwPzDqDLUbUl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FG8MCoGZbQy0/Lmw0Y3QZij2C6dEv/Q5VteQ3HHrSGp6fPZC6HVG081h2lBon5M7HAmDcXS24hC/edVcKoZIO8ieXrD4TkKLWiiigqb5dXKY8qIbE/coNhDprfF+1DXbjJQwceZHkSk8rAJf7ZXIaesH3+ThKCH0+JK847DRee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=B/iFlElN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b9b35c7c3so65732305ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435373; x=1729040173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJVHwUgMs+rfxIOK3S7MBwjWGHZYDl++VcT9JOMBFYY=;
        b=B/iFlElNjQqlitvIAzQdGEII/NxNoQTxFDK8+tRzr/cL5p6C7zXg1vCB4XU/95RUXw
         G5BBaeNAP5wa8SlZgXYCgmRRvXlSbqiR7+qydpO58PSifQaCrl257q2VyRSoUxQS68/b
         hNtvOI+KIxeTjvC+yAKP4+pmmsP9hAc1c78cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435373; x=1729040173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJVHwUgMs+rfxIOK3S7MBwjWGHZYDl++VcT9JOMBFYY=;
        b=nsl2M7R5kw56D5XYlbFVIYil6gVG/B831bC4VpW0wAvj++azZmloBzSG7scMpp9KZa
         f/bC/h4fwzsnrerxxxbSjWXAR7zElsbRyzBpXpMshNdPFdUHRd0QWU2kTMnhdAOv/OFu
         3P8nmoCRlEi6qPTxhweyhI0TZ+FQ0W2jYKl6Lh8xPxd5eABGbKP5QCP1epIw+VHujOIU
         V3h8+42elnO8pSVZ8/1g6n796K5M5osBUT5x3XvhPCAk0epaxAZDERHfmFB2M2VGOT9J
         ikGY+sz6ePuVZ+mLXJvU8GV23uKy7apC7iJhHWXYeHLUOrH7EfspUGV9e5SpA40xzCoV
         +53A==
X-Gm-Message-State: AOJu0YzeDkoYf2eECAkQcAPkTfk8LhaBFTH404nt8fsuZ6NR+EtqTsoE
	29+DZS4LnKwsWnQZJBD3RKYl7lZer4Nfujnh0qFaYC5o6B64Eb+w0fQN0T7T6RAhVG5UHrT0K3z
	p99r5QCfwFDrBAT2xLHjKu2LVVlTmhP6J+PiklQ1tP/v9J5bBWCvFqqgNtaiHLmWJYgcLQDS6ZH
	NFq1zSjpXTt5cdlJP7KJIpCcdwt3twxTACEeo=
X-Google-Smtp-Source: AGHT+IE+Jy6YzaCczW12PcHPToB8Qp5/Tm1AJJplbGlk9QLna4eYrt4cJ6UOiJ/ettHxwkoxAnC7Gw==
X-Received: by 2002:a17:902:e802:b0:20b:8924:3a89 with SMTP id d9443c01a7336-20c6375b2b8mr14141655ad.12.1728435372708;
        Tue, 08 Oct 2024 17:56:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:56:12 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 7/9] bnxt: Add support for persistent NAPI config
Date: Wed,  9 Oct 2024 00:55:01 +0000
Message-Id: <20241009005525.13651-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..f5da2dace982 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_config(bp->dev, &bnapi->napi, poll_fn,
+				      bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.34.1


