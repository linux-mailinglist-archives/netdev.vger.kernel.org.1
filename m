Return-Path: <netdev+bounces-146320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EADA9D2D0B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F01F2287C
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74B1D2707;
	Tue, 19 Nov 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LguMHeEu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C551D07BB;
	Tue, 19 Nov 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038760; cv=none; b=XyUnoB9PYKwwxGtO4tbSC/DfSxF2GAvkVK2VMvATN5LX+BxZ/LgiL0pY2NmWMtzKSWgHp8hjZHq432a4Mf+UhtRx3iCyDJULf4jFsxej+jBFxPm9iEUUu+KZmF5gBSV80nL6HPU0eIj1D7/LsjUcZn98OUEc0lXibhWG/IvwSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038760; c=relaxed/simple;
	bh=3v8Kxm0aJIEv7WMZjJ/vtu1dfG1rAFuLoHlG8l+Hw0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iG+qb5s3wcgykwjGcDrhdx4sK69YAvvzRIYiDTivxoNzcLkTvEYPmbi88W592NwgQaX2MFkaj7gAYrfpWWnDvphhhDMQHB//PxU7WqGfXfsLHZUSmFm69JxGPAGhix0IiZqlFz/uBxDZOuCvfGxdO7/Dk91S/N/mIqdA4MFfnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LguMHeEu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431ac30d379so11194195e9.1;
        Tue, 19 Nov 2024 09:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732038757; x=1732643557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7x1Cvl6uYAhIlsTQJAM2lxLGZwm8G52/uSj6u7+hOrc=;
        b=LguMHeEujdocfsUrB9uGYLB30n5bg/v9WIxBmImhB9AERenBaQazbgan2/jdMEkrue
         Ta9EIufQAdctn7DuPhGe2dVAW55RioN9WJUw06OoPulDw/bH/P9F89y/aPlivpROCM+c
         hKGmIzVVBazKL2fkqnE6gF/rlnG8GzYxQzl3i1TA6orZigPzHpDdIb8yZF5GZmVhtqNW
         Ipjb/+/fign96e9ca5OPKZ6b4pAS7c5ZzZA8p74nBdtrTPPxyfOsl1lBYBsuuMkfIaxh
         MrMCzyx0gQ8KyoZgo+iH+mxKxyvCTsj8H4HQbI3Ub7H09Vmqg6F5mows+cw0j0tJKY0K
         BgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732038757; x=1732643557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7x1Cvl6uYAhIlsTQJAM2lxLGZwm8G52/uSj6u7+hOrc=;
        b=CBieDyCf9NjZuPLrAS+UNpSYpct2t971LLwtem3cuAtmyQ99vVsTAPArMoJozSohoj
         vND2tTNZvqtmTItqsKIpfVcMnfBKSxpoNbkFC3BTTDQk2qHUPSlyonTfdLnNdWp/6Zwt
         akMJ3R7W28XdXLvrixZEBX7C1FItua89cH9wthyQRuYXK1EV64N5GUqJqoBho8+fOUd5
         fgrIW+L6/EMNsmKmCHLgmw1gOngYvjYcpoPg6Oe+dFOgswX87+WHt6v0qYvydjS83LSP
         gSc9EMeRmsoHDW5I5+As7LyhGILXE5VwpAnltDMkEijqsVkZ0qHG1TajGhNcofI/5H4C
         PLcg==
X-Forwarded-Encrypted: i=1; AJvYcCWBZXtzRHXnkPolgtwuOA/V0mhVRjTKRitkhvXKvt4DImX3BbwTTJV7410LRsE714VoZOH/E86ywkzPKOE=@vger.kernel.org, AJvYcCX/zbI3+meBGt5aWslX0k7jtLZO9L5CooIctj7ClmbxfqsiJeaQ21Ek6XROE5YEUFoLSAPr/VrX@vger.kernel.org
X-Gm-Message-State: AOJu0YyqF8tqfw+6+rfbDV8Kj1OuknuyVJHpv8iT0D2PVFT4cY9dBsdU
	Yb0nL0XEBiGclSfSv8N1Lqt05VuveslE5QLST5jmLmvmc7tWgxXm
X-Google-Smtp-Source: AGHT+IEOJXELUvf9uYs3VOaj0xHe17Bk5fUMwLEL8rW80ii9z2sn1isp4uanHAx6agWwYDfN5sdXuw==
X-Received: by 2002:a05:600c:1c98:b0:431:5a0e:fa2e with SMTP id 5b1f17b1804b1-432df78a858mr126641465e9.21.1732038757144;
        Tue, 19 Nov 2024 09:52:37 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fcb4sm208414245e9.23.2024.11.19.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:52:36 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] octeontx2-pf: remove redundant assignment to variable target
Date: Tue, 19 Nov 2024 17:52:36 +0000
Message-Id: <20241119175236.2433366-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable target is being assigned a value that is never read, it
is being re-assigned a new value in both paths of a following if
statement. The assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index da69e454662a..ceaf5ca5c036 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1451,21 +1451,20 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 	 * rvu_pfvf for the target PF/VF needs to be retrieved
 	 * hence modify pcifunc accordingly.
 	 */
 
 	/* AF installing for a PF/VF */
 	if (!req->hdr.pcifunc)
 		target = req->vf;
 
 	/* PF installing for its VF */
 	if (!from_vf && req->vf && !from_rep_dev) {
-		target = (req->hdr.pcifunc & ~RVU_PFVF_FUNC_MASK) | req->vf;
 		pf_set_vfs_mac = req->default_rule &&
 				(req->features & BIT_ULL(NPC_DMAC));
 	}
 
 	/* Representor device installing for a representee */
 	if (from_rep_dev && req->vf)
 		target = req->vf;
 	else
 		/* msg received from PF/VF */
 		target = req->hdr.pcifunc;
-- 
2.39.5


