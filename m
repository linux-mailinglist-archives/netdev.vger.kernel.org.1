Return-Path: <netdev+bounces-283856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C1IKCin+GlexgIAu9opvQ
	(envelope-from <netdev+bounces-283856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:03:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0317A4BE6C3
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62D7A306F188
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691833DE422;
	Mon,  4 May 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXSfyOB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C83DE428
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903101; cv=none; b=fUBxSCj9SSDnGnAtlkoPIEeCbivorYYUSIqY8gbD47l8cfasHcbuitn0IkMmAylBYnhkjS9OA9xZ7rCI3fRFvzLlNZwasQWV7MCVTDUpnEu3r+2cAFhzSP3u6oNJ6ipbFB/8dtdMRsq0x22BxsAlC2Qmg7gBqaHVUvwqFxqse1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903101; c=relaxed/simple;
	bh=q7tI3n4SWOo3NDQnNZRJsS/zndwtGxYY9hjK8ioYRIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1V2vfnlVymgebZnTIjZMSEQ5/P9YrjphmxYdPjTigf15BPTRmNQbcPfuq24gR9nTuexrFOcjIiybI4pTyGKpsdZ5uDYhNw1Fg+cIBQzc1/VW1x+bezNBWSCGclEGAnFokb18h90tIXV21tiNGQZtxz8JOsMLVFd+owAxnE2c+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sXSfyOB2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8f83efb5729so453222685a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903099; x=1778507899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SisvOL+tJ31Sva3YbBAzenwkJNsUltz/h4VPNt+Yuf0=;
        b=sXSfyOB2+WgyMSi3PZhhjGgGWjWmFagPYHYL4z9u4N95wU38jd3+eoE/WM0y8FwAZH
         uWdGP53hKAx7omVANJ+Aw3NKnwc0GhroaWjlvbn7h8zdFFnKywN6dFPbjioLFhLPEy9O
         1C/DHOhy/CUvUGF86iI+JXWxblR1/vcFSs4w+84CEil5ZMgEZJiPry3mtdM8rY+8eFF5
         ogg3eQwo6lIjy1uR3SmRkh3a+fM3SNiBqpSc5m7W8B2huM7rAAAXgL3JaA7FZBpxi2//
         ywishCXtyKmY6hTtI+a0X0l+w6Wz87/HDJTPBgGcWAx3pjBTfadbC45NTHa2G8z4xscK
         Z4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903099; x=1778507899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SisvOL+tJ31Sva3YbBAzenwkJNsUltz/h4VPNt+Yuf0=;
        b=KBBVT2WEg4Rv56FlXonJoScUl8/FS1KGPt3bWCS3rTc5d84Yt6rm6qtpRXbtxie8WT
         r5FjUjkYT2C1rXGln2J5rWShRKNNFgzXfpQWasRwKfBpImEU0Gz2ium+EBReIEIvXd7q
         aeF1XbSSX5pjmpA29uXit2h9tm+HixGafIFn4Hc6DyUQbeflZzBYulW15R3DTtARpeY0
         MmMc1j7/hnyG+rk+Ccp/wox4xsNxUPuQNwP5LmrAVWAbUyJX/TWFQCxGUlm5Lwl2qM0G
         PXD0o8Az5H5IX2gYWpLf8malTu6x1CG6zvTXIS1gIVyMY2/ZXo9LTosXp/rtmjWQnZCP
         wvNA==
X-Forwarded-Encrypted: i=1; AFNElJ+PBhRifhlCR/KNeCISyGtx0DVE9cOHqIL/7o73sd3UVxeHJ88kPrfajVVHxAB/3ZsA9FJf67c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1c6xktstgWx/xtj68Dm/SYfj29JJM9OFGSxDk69Li1n5RnkXK
	uxdipfUeh5UtfBcYupfe2e0FP+zKEXLekuyH+VOEqQmEwrrXCNGT3qJz
X-Gm-Gg: AeBDieuWsJQclXjfzx5eMPI2NNDEEcBFvvtZGTGCrB2UMnqxWY52FqTyU1A+PXJ7YzN
	2VEQ9Kf3+p9W0nD3E3uxgTosjMyYwUOEawOLEET+G6THGAjftgvEfskKsUh3X54m3JaZrLLrylJ
	WtuMCcoDhWgCpTGRF97Ge0n+TmAela2qipJ40TRARaJbS9Ku3IT7HHv5BPRfHUT9iXySCDt1RHc
	pM0hVq4/2i0aN4bfGLZ/nTz0Dfp3chxCvnNVvKnxN5Gx7dYn+Upkyz9BkxMeQnOQHNbA+avkKuh
	28HYTwX+fJYuK2xCDrP+LWzqtr2YR24buD15LgMHoNY1rQdZ5w50W463CcKT0wYLNA+m8aR6hs2
	Bixifaa3YmqKjF9BJQ8n8pydsWH2tUWVWpdXd/ZgKdAUnwQ7mpMcVsNTfttR4eSRUDz+LNtGmSJ
	AhT1pn1WJ4mYbzt1LvTyIPgV6rdKjcEMsbV/L7Vw18FYEyoR9GtUbCSD2ORqopYKFOtTSA2fw6n
	fbC7A==
X-Received: by 2002:a05:620a:489b:b0:8cf:d441:c7bd with SMTP id af79cd13be357-8fd178677b8mr1463526185a.38.1777903098759;
        Mon, 04 May 2026 06:58:18 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm1062878585a.35.2026.05.04.06.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:58:18 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/4] net: eth: fbnic: Fix addr validation in pcs write
Date: Mon,  4 May 2026 09:58:12 -0400
Message-ID: <20260504135815.44226-2-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0317A4BE6C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283856-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,intel.com,trager.us];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The DW IP has two distinct PCS address ranges cooresponding
to the C45 PCS registers.

The shim translates the PCS addr/regno into specific CSR writes
into one of those two zero-relative.

This patch fixes a one off in the test that could allow an invalid
CSR write if an addr == 2 was called.

This patch contains a fix for addr validation in fbnic_mdio_write_pcs()
to only return actual CSR reads for addr 0 and 1.

There are as of yet, no real impact for the bug as no PCS writes are
not yet present.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - put back into the series based on https://lore.kernel.org/all/9ec11642-8035-419c-a896-52f902020bb8@lunn.ch/
  - revised commit message will additional details
v2:
  - omitted from patch series
v1: https://lore.kernel.org/all/20260428172810.175077-2-mike.marciniszyn@gmail.com/

 drivers/net/ethernet/meta/fbnic/fbnic_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index 709041f7fc43..d6a124889f52 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -125,7 +125,7 @@ fbnic_mdio_write_pcs(struct fbnic_dev *fbd, int addr, int regnum, u16 val)
 		addr, regnum, val);
 
 	/* Allow access to both halves of PCS for 50R2 config */
-	if (addr > 2)
+	if (addr >= 2)
 		return;
 
 	/* Skip write for reserved registers */
-- 
2.43.0


