Return-Path: <netdev+bounces-284596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDtzGD53+mkQPQMAu9opvQ
	(envelope-from <netdev+bounces-284596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:03:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 009FB4D488A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1CC30977AB
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0433242A9;
	Tue,  5 May 2026 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI24vbSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E432E6BB
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022107; cv=none; b=HY07wIrhuUB9F+EgmzMND4rFDS5Slmtke8FXZMZM6SGsNUK2aPfVYFC8m+aqDwpwVuJkzZgRjMzgg+iW/28ULOiPvEXSBk6vHGIN4HPbGtmYx01sHfs4/y7eMotGc4RGyep/cJA8VUBKGPntnw72Uau5OJcqdPd1MOkZFu7W03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022107; c=relaxed/simple;
	bh=6UrFc7LXWdtlhi/uvQ1wdVFJTmOu7xq6IMgdnMT72kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OAlIt8t9rllHuT92oglmven0YI1RU+eno8WH7E5QJDGZvx0Rph9mrs6b8VKTnsEIUcUFzaM80vLzDBVBGA0QPugFGzzGqoCIEnWxO3x/gSa2ezfH4r3wXFNy1MU8BD3ACTKA0uNmeyjCHDVb6HTXG3K++UJ3g/u/aZDXv4JluBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI24vbSv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a1307438ddso6004234e87.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778022103; x=1778626903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/RR5f943AwElNEO63sE0ST9zupLWkbKClhD86SMNzM=;
        b=cI24vbSvxtBx7JF51wno/ivNGDgLVcOMEp3vvtUMN8dDcb7ySmwYdK6s+jHeXaCgRa
         1PA+0gn9YfxcMBkgcKCuW9x/7G584HD0TC74EmS69wS/K43+ivDOU276nEHOhIA626AN
         nLLIcGAHTQ/fck/IOUWxu1pw6UJfIdxRBBpSRVlA0JgWabD/04kPISF8Oyg5I4GDaxPR
         UtHTkA9uv/yKQjkI6LE4PeTRs25F3zsp4UGG+0jrE6W6M/R2/o50PW3sXdD1R59LyOdd
         nVCsHuvZ8fMtTCshTp36RYb/gDLNzDpgYUpJgKolj8fGaRu+tZEjO+MQ1PUZxcz/gmcB
         ZVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022103; x=1778626903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/RR5f943AwElNEO63sE0ST9zupLWkbKClhD86SMNzM=;
        b=RTADRXhCLHJ1Vy6/57Wr1QTI5XNF3ucKR0Xf3XOOtfpKSu7dhcQD1wnHFyMzgq8eoR
         whjJfxU4os8WPhDH52KrfgoZIuMC7TpRYSZynrJpDMic3+DxUo1jNEs63IHQV4V2kJxQ
         nqsartZHxv2LNymgc2v63psZhdVvctz21QqZSoNiXWsRA2RnHdhU1rgzo46oj54m1oKz
         7xNZAHX+rMwyL9P1/rM7Ej1dVGrcGboiFCd+1IVOjobYD3GPCHfp2pkTYjC5VTxNPNBO
         dfQm94AoocGdsQNJoCuL8Aoj/r67O2ySuHGK6r/XzM480SzCmhyM/6qwrfzTwe+70Kk3
         50cQ==
X-Gm-Message-State: AOJu0YzaIJefJb4oPCdzphI1z0j9cKY2HG4qPGKKG2PVojgOehEogL8s
	Ybu9YxM9XNfQIesGtaQGXKbe8DDewt1+z8uqG4ZjbmWZGsodxbJkA1bVdpfgkpyw
X-Gm-Gg: AeBDiesd5cO/zrHOWbwV/TIvmPqMYi2d3/KgYj2AWKlJ6/pDf28N3Yjf0C1ZhJtNuAx
	FzEN6qhpxv64dB8SHBLkhG1WKxnm76a7RBj003HoQfF/eYK3jNOsMW6NJuprkbHgoq3zx3j0YUz
	Rg1UhTaet0imJo7nCFfFoiqZmpojGNqJiDBUFmNER/z2a6jZu+3IvP2AQXOa/JXCj0FJpp7u98m
	D3V73Xp+Fqs8ySGXFNXAuBGlnCPo8Mxi27iNUkMIwsIa4VH770qCaY+w67nEg+kNmXCAzk7V1Cp
	ibRzwS5VitICkOFWBQc11U4zb4qkjXcuB6M1x2PN18Wi8xRxde/O3dPERJtskTgC6G1s4to0Bdr
	mdRaATrJoMXoKVkv0IELfIchngY20DoPQNjNVRnIxQBHiBVh9JM3OfO0lfRkGWbZLGZ3Ref5puq
	0pIR/2oIjCxYP9ImkEV8XNAI+B+L9c2D54OhBMq6EKcgFONxSTkmOENI/yPXPHcx266ew=
X-Received: by 2002:a05:6512:4017:b0:5a8:7f30:6091 with SMTP id 2adb3069b0e04-5a887cebf27mr200087e87.37.1778022103017;
        Tue, 05 May 2026 16:01:43 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39361323f4csm45209511fa.32.2026.05.05.16.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:01:40 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] igb: Remove redundant extern declarations
Date: Wed,  6 May 2026 02:01:38 +0300
Message-ID: <20260505230138.7397-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 009FB4D488A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284596-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shofiqtest@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

igb_open() and igb_close() are already declared in igb.h which
is included by igb_main.c. Remove the duplicate extern declarations
from igb_main.c to avoid redundancy and fix checkpatch warnings.
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00..e2691b5c0 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -108,8 +108,6 @@ static void igb_free_all_rx_resources(struct igb_adapter *);
 static void igb_setup_mrqc(struct igb_adapter *);
 static void igb_init_queue_configuration(struct igb_adapter *adapter);
 static int igb_sw_init(struct igb_adapter *);
-int igb_open(struct net_device *);
-int igb_close(struct net_device *);
 static void igb_configure(struct igb_adapter *);
 static void igb_configure_tx(struct igb_adapter *);
 static void igb_configure_rx(struct igb_adapter *);
-- 
2.51.1


