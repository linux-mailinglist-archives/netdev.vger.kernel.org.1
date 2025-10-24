Return-Path: <netdev+bounces-232599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE18C06F60
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CD71505579
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47D3254AA;
	Fri, 24 Oct 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="YMad+Ui+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322A32548F
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319559; cv=none; b=UwPpxHUZEMSyuCqtlFBhbnkj+q+0sN4uLTS5C/Xh53qTybYPyCN7iJIVE/VS+qF33pFW3eVhPuFpIGgwEQumhKTFgov1Y+ikmKRoFs6RXGvDzYMaAY6GkRmJGWd4GEhz0bRa80Iyi68o152Q4MiA92Ro7W/ZkVK42KX/fsvjSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319559; c=relaxed/simple;
	bh=fja91hhNTAD2uFFp9ltnm5Xmev+0fEePBFFlNHs6kKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkTK+Hv+Bauriey9xUCz93c3jjte964Vkj1rt2vBT1kmYxnHf3l8FoTl0o2hDBS51wX7+om4QwdpmlgTpTBJ7IY8UPSveCJu/rdUlXhtxhqMm8EU2d7FC7XAMqCJmfJSvylfbCvQkZPr562JRiDWaWOqXF874IMm5YxDNJjUbhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=YMad+Ui+; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550eff972eso1513129a12.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761319556; x=1761924356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/T1Z+K8DQK4zGm2l4hT1fnBVPvldXVlObiMpVzg/wBA=;
        b=YMad+Ui+gCzdOxEHZy8gSopcxU+q55qq5CTnsvUPnj6nRulddk3QK1GjtLohB8kOWu
         H/rx2L+ADJQtkEIYyHsLmIw/rHfaTQ9lzFxhpk3yXVxcuut2OJ4DLRCEs407+WMZl674
         eq7nyRwbvwfL6+2I+4LcF7pCzvhxLLlaooBtPdBGtH6VUTYqJTqqB80HzVz2jMPh2LQS
         eKsnx3gvCza93nLVaBF2iyiSUISejCbeHJYJAt+3WovLLj4IW9UJYKL2HC3jOLJ2pXBa
         CDLRoUpv8YBTnR0gev1Way3T9guh+9TUOSTBdqAV/3f6TJw/h7kubVSdmWUKubum1Qeo
         +qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319556; x=1761924356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/T1Z+K8DQK4zGm2l4hT1fnBVPvldXVlObiMpVzg/wBA=;
        b=N1svq1ZvEhl0C/BaXOWTUDdN15C4T8DewW85IPyKx4liQoge33pqjRfIu1JaqkRhqk
         X9EFlgc0y6D/wXNsL7TY7KBb52SNSIx71371VY9YVNiux0A58w0d6oCeQ0wlTCQNOY1v
         M2KBWtTNSxlpi5HIzhArru6v3Xp+JfTC/4BEXcGRIpeDyfMKMGhJJSJjvKwPET50Lhp6
         b2CMTTXtQbRzr5pP1sX4bwi1tFKDbQjdmyZ2mPtWJbPl6DhBt/NtA/zw+35WiJt3ndEg
         WUFp0dUHmRZZLFPp2qpyQYjJXzFuHK4nCe/2TDvfWG4go3UNZeAaRVpfIZY1Xcmw2zjL
         0JLw==
X-Forwarded-Encrypted: i=1; AJvYcCUPQt7rIfOVx+kglilVbRrr3QzmX9Xfazvb1DfOgOdX05CFUHuQjoYb+zitQnWHxCZCOwcDQqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TpoMoCPujItQNJ5TzeC2UFoFy5Zk+Jk+CsOZ8hQ62h7j5Eta
	69n8TVgC+27cPuRo1V2Nh888hkG1d4NI3Ov/35E2ME7TbClALoXGLKJB2e8sB3aSlUE=
X-Gm-Gg: ASbGncuRT/8m8UYgamv7Jh1NO12J04MFBpo+Ib+S46BRBYDqO7gaSQg5s0w47y3NJA8
	AHcHkBcNd577B7gKkGTOcbCjmo+e5Dk/dzwnFrx2caK5bsCZPiRepm3GibIWYlLldcd9Ivzg1Pz
	wuSPBca5ahDfCMVobIXgb0AnkSctE61Cf2o9OFN+6dgCShCVJHgFf8rlJWkOG1L6ro0xeUN5z/R
	MbHGKS1O5OlcS7yEGDsqiiVkllsrLlXIG62Nhj28KO9uHUNUJObMXTjN6CRHlq07mG289O2pfH+
	aYlmtonHO/URurbvG6m2LErU2/xjlREXGcdoV385FnRLDWcF/BJ4dO35zdTcHdb5WsOBjQb/xqQ
	cLx1EEiIGKqtF4HQa9bMoHfVXDPJeB0940QvMIcOOM4daOLk0h8iwlvDFHAF1AW0jaR6lnI+Y5I
	JZMEEC/GyyiqHVC4zzjoIgCg==
X-Google-Smtp-Source: AGHT+IHrQTR8H4ei07O1j4Cthyaw9aGZFdCNOut1bzwa+dLtNpq6RmIRrnDxWJ42MNn2CSeAbj9IfQ==
X-Received: by 2002:a17:903:19cb:b0:28e:a70f:e882 with SMTP id d9443c01a7336-290c9c8c5f5mr17531795ad.11.1761319555989;
        Fri, 24 Oct 2025 08:25:55 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-294942c412bsm5135135ad.72.2025.10.24.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:25:55 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: kuba@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	tglx@linutronix.de,
	louis.peens@corigine.com,
	mingo@kernel.org,
	mheib@redhat.com,
	easwar.hariharan@linux.microsoft.com,
	sdf@fomichev.me,
	kees@kernel.org,
	niklas.soderlund@corigine.com,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] nfp: xsk: fix memory leak in nfp_net_alloc()
Date: Fri, 24 Oct 2025 20:55:22 +0530
Message-ID: <20251024152528.275533-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nfp_net_alloc(), the memory allocated for xsk_pools is not freed in
the subsequent error paths, leading to a memory leak. Fix that by
freeing it in the error path.

Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 132626a3f9f7..f59466877be2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2566,6 +2566,7 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
 	return nn;
 
 err_free_nn:
+	kfree(nn->dp.xsk_pools);
 	if (nn->dp.netdev)
 		free_netdev(nn->dp.netdev);
 	else
-- 
2.43.0


