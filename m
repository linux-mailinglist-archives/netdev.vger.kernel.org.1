Return-Path: <netdev+bounces-129339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D3697EF08
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BD91C2144C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E53B19D09E;
	Mon, 23 Sep 2024 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiU2BKgM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFF7DA81;
	Mon, 23 Sep 2024 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108267; cv=none; b=YgkHTmGvEiICV1GaQXWbxnY6xp5M0iYxrQvslYPWKVrIR8MBClHv82AgZktOU3+0kNyCClK15Nr/DJFghIoKbn4Sw5gz4scqsbMhWcT8xKcWqlhjUpCIYslqrNbne0EwTtWwGEYjZFR7R88AhKxH2aJH/Ixw+WBF+tE76k46QYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108267; c=relaxed/simple;
	bh=RLzJyfg5AK5xZRDFJSGR6hrofYoy+gBKxFGWXE0AAVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQSz4vMLRloGIVd5ecxqgwdIX1gWcjxVEdc9yqrRp1qSs8ZpnqNPCD/AL7ZZWiiNV9UC6GoSKymD+rqSwfGZLpMbU3TgXJ76c3u7V8pJjQX2QwL5geu7VlwxLfEzO/onuWPyFKidQQcJ7vZ+ASVMXEeyrptjvGYq0/TJCJ743yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiU2BKgM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so3694205a91.3;
        Mon, 23 Sep 2024 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727108265; x=1727713065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLgOKVLfgDO8mBE7MewwTev6JyniSNgCmsWCdduvp8A=;
        b=YiU2BKgMtFoicyW0mhgtiIgzCsfJjwC6Asb6QV2Q6BqpbmCvaDH2XHAMZ9h/VPJ2+y
         H0bsEfasGIoCqvRXFIBN+3mt+9wId34xBQNJEsC8zSJJ+Nz+YqVMpJgOKePEerVaMI0l
         KoC2TD4tS2LhoX6QZkKld20eKIs+NjLCl2T+zBy7sc/1hp4UvmyOwJDjcqgDruC2kDxx
         CFCsoTwJ2LpQDgv0drtS3BUe//o5nwoUjiL4maW8ymvBs4egmI7cPDrFA6bWULZXJI3E
         rHmZaUKOMJaZ4ODD0FGfKLEMk/azpC7nyX2KIKVtAv1nsWViBMtyCj0OGTDC6RJYAz1/
         RN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108265; x=1727713065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLgOKVLfgDO8mBE7MewwTev6JyniSNgCmsWCdduvp8A=;
        b=okVDOM8uSSQlp7pq5AXVNAuaDlZxxpkAX/AAmOzeWkmaPDVu+TTB4igUNgMW1k2Qn2
         P1CBPs+/x7tk4+j75lrtXdL9n1ZLj41iYARS3f+/QTZ6p2t0tV2EhwouVlGZtsalAEG9
         3ljOf+WK8i149dRemwn8K7sVJLIcZcml2uWKCxZg7Jlz8/NU8TMAO1JetCkdCeQTO8lU
         ZLYU3sRhLe1qQpxH1z8/VUoKrri5JigFigKwMtVzjrnHhACPWI2cMimcz08RP1npZih6
         2Hjy+HaSgw3o8+HQ2bbgljc2J8SOpc6BJDQ66MCo6Bg7Xfdf7ns18NinbVGw+IUM2+vY
         wrcw==
X-Forwarded-Encrypted: i=1; AJvYcCU6BoyTMM1pAt4+ZIch40qrZc/6LcS9bx4iZe2xTRQvgPefw1FT3paleFjJ0383Rs4h1vXJDxROuWV7pVU=@vger.kernel.org, AJvYcCVgxQBYTay5IBdF6TsOWbKxdI/G8usthF910esT17Wu6qWiMS3k9akb2jEOqHV2JX19wP+dbYTz@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5iOQ6f6nKLtvCAt7haIfknKRvVjojVhj3+40WMuajGibP40I
	oRPMxf0KWHr4C+UlGVcts4tryWvfm4Y1MQNrVV8wx2TfHLKTB5ww
X-Google-Smtp-Source: AGHT+IELuk9miNEkDnwZWDV41GLKiwIjj78ibzWscBvV8eQFS6DqsOB4w4ZcJ3ncawRVqTo61EBOFg==
X-Received: by 2002:a17:90b:3511:b0:2c9:9f50:3f9d with SMTP id 98e67ed59e1d1-2dd7f37f2c7mr17003285a91.5.1727108265117;
        Mon, 23 Sep 2024 09:17:45 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef3c64fsm9609082a91.38.2024.09.23.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:17:44 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: ethernet: marvell: octeontx2: nic: Add error pointer check in otx2_common.c
Date: Mon, 23 Sep 2024 16:17:37 +0000
Message-ID: <20240923161738.4988-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding error pointer check after calling otx2_mbox_get_rsp().

Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
v2:
 - Added Fixes: tag.
 - Changed the return logic to follow the existing return path.
v1: https://lore.kernel.org/all/20240923110633.3782-1-kdipendra88@gmail.com/
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 87d5776e3b88..e4bde38eebda 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1837,6 +1837,10 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 	if (!rc) {
 		rsp = (struct nix_hw_info *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			rc = PTR_ERR(rsp);
+			goto out;
+		}
 
 		/* HW counts VLAN insertion bytes (8 for double tag)
 		 * irrespective of whether SQE is requesting to insert VLAN
-- 
2.43.0


