Return-Path: <netdev+bounces-132444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCFB991C01
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F2E283510
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718801684A8;
	Sun,  6 Oct 2024 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcy44svx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4517317622F;
	Sun,  6 Oct 2024 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180397; cv=none; b=XmraNj1mFnR4y/JuiGPnkyeQnO1S7r1tmQEKILVpx5ICRtChC1xLLPOt0bu1iE1KF5ULd0OFhS5FdBioECztI2NgwdceqbcOH284YR9TRI9W/EnWUuXlBS40LIqeSjjdQYXtk0M3J0VreCpAYArxdOJoRgYyn0ws7uP790Oytgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180397; c=relaxed/simple;
	bh=XpD5MBQNCdNE3E6DcHQM/wLKwiuZxSq0ZeTsC+ryFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szKkE+v7qvcetcxGO8ZMZT6t8Ayx92ruNXvkMvEXBqUEHpnzD/v2K1DJf+zDsFJK7IhuMdXO1adQW+5ZHjhsQkvhmFfuJ3zUQ+y48wXv+w2bLUuAIMZh3wxyc5rM1cmjTn7WNsDCndf4DSmmXPAJubipagvW0qoE0yIL3LIyhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcy44svx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea07610762so34853a12.0;
        Sat, 05 Oct 2024 19:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180391; x=1728785191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGZsdm5qLKZIv0DQdpgKSNQfTpwe6/VrtKx9+RL1Io4=;
        b=bcy44svxNDCEZJG0aw8OuRlq6KaUF9dnT5EyIKY8e1O+KF1NbVsASgga1UC9sjwx2W
         Cr6MSKT8dzZQi9yPBjQ29b84HVHGhjZMuWqsIpRTVzo/bCIVH34lDF8VIRdhRjcuurEH
         2TH2IsTkzQHSMkPJ+6dVeJJN7zi26TQ45zp405ue6aX7ZOKI5217N/h8GsqGOZTUyh/a
         V0gXt8YVZQEOEwZGywT5HWYZMj8sGNzyQ0ZeQHSr96cKZQ3M4YBStnbk4CnTguXgcQIt
         N3yAOMDXJrZV0vC9FXu4zL9fJ+ob403fWMrkDsWEz1j2/63YT17lkgea5jHXyVkXJHPD
         8n6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180391; x=1728785191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGZsdm5qLKZIv0DQdpgKSNQfTpwe6/VrtKx9+RL1Io4=;
        b=gOdj1usSI76dCf26ih5DMloWLzZwlkxYBbp+CjfoSiN6Wel1AHsvf4Xh73BF6/hm/E
         8dhMvXmZm1jFaYlUf3nu9zS3WIwgoJ5KhuHWPdnyG+MUMN58r4z7aF1G+3anrGkvEFeq
         bxOB90LQJO2LkBwjEgKJ1h8p7UH+3Zt4qIhEbdLcKF0JikB7cXdH8guKIQb41RzYDJBC
         diY3ERJi9Xs4veCH2gZrGLtr8BKNRvW4Y34uI8sjowYyWCKvRV6ZhbfLDL0JzQxI0M4X
         O21tx79FWArHrdRABV7mRLvaARYQgoOXYf6udTrmieP3npyetjMmV5rqq58BKOYiqXzr
         vp7A==
X-Forwarded-Encrypted: i=1; AJvYcCX41ZXh4kP+KrBnhkft7JmX0pfFKKKHkwvF51WJfOn9bxR+V/LI/1iaCF0ZeSskP0t7S+NPSFUchWZ9t1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmlDN9xypgpHW86/d72hEChtakF5vERFci/fvreDNZnQPmBqh
	OntA96qiqgUsKax9Fu/PbfSfc0KyNu2JLp5gQzNKb0jtVRp9bzkocnGx/g==
X-Google-Smtp-Source: AGHT+IFEqVdWdibs/SLVYCm/jAh9OWwcs/OuFTMgRkRZ2AqBUaKP3HjWo2kqAb1P6DVdwKUMizXHdA==
X-Received: by 2002:a05:6a21:1706:b0:1d3:294e:6c8d with SMTP id adf61e73a8af0-1d6dfa3fccfmr11089992637.21.1728180391463;
        Sat, 05 Oct 2024 19:06:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv4 net-next 8/8] net: ibm: emac: use of_find_matching_node
Date: Sat,  5 Oct 2024 19:06:16 -0700
Message-ID: <20241006020616.951543-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006020616.951543-1-rosenp@gmail.com>
References: <20241006020616.951543-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaner than using of_find_all_nodes and then of_match_node.

Also modified EMAC_BOOT_LIST_SIZE check to run before of_node_get to
avoid having to call of_node_put on failure.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 4b21bf2d3267..bc92cc35d8d5 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3253,21 +3253,17 @@ static void __init emac_make_bootlist(void)
 	int cell_indices[EMAC_BOOT_LIST_SIZE];
 
 	/* Collect EMACs */
-	while((np = of_find_all_nodes(np)) != NULL) {
+	while ((np = of_find_matching_node(np, emac_match))) {
 		u32 idx;
 
-		if (of_match_node(emac_match, np) == NULL)
-			continue;
 		if (of_property_read_bool(np, "unused"))
 			continue;
 		if (of_property_read_u32(np, "cell-index", &idx))
 			continue;
 		cell_indices[i] = idx;
-		emac_boot_list[i++] = of_node_get(np);
-		if (i >= EMAC_BOOT_LIST_SIZE) {
-			of_node_put(np);
+		if (i >= EMAC_BOOT_LIST_SIZE)
 			break;
-		}
+		emac_boot_list[i++] = of_node_get(np);
 	}
 	max = i;
 
-- 
2.46.2


