Return-Path: <netdev+bounces-132519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D87E991FB8
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD229B21862
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDEA189B82;
	Sun,  6 Oct 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxnOMGio"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55694101C4;
	Sun,  6 Oct 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233232; cv=none; b=M/jicu2Xg9l+UMOaAUKp2uYjJ+dof1AFeTjsUymVxNXrQUY+BgjDqIkESs/2Wb5XRWkPxEjAZzqyEd3GbrthTswk8OcLIuPcY3JDBZ7J7QnCzKapzXSW0giu6XYbuL+WGX1aqaDQnrmF15cF/h4C1rmKcDJU7FTvo8VHudo7gSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233232; c=relaxed/simple;
	bh=BautKf7vziCSJbSfESOL9y3Dv626eoXGdCzCtqq7Nks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLJpvz8S2204uZDn8bKWXyVGHSG7ZWZOVBEVMAfZ7ehE5EC2fQu63gOWrxXUZPJV4UAjC3rPe6z/RP6UzFteJG0ZZM3Fnf5/YCzTzpY5PXIkTXBlZLP2swWckfB0IeAHZy53TVXSwp7+jP1bC050rVeKH0cLZIXoTvMwPLmkfxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxnOMGio; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20bc506347dso29949105ad.0;
        Sun, 06 Oct 2024 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728233231; x=1728838031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vC0tEgvksW2SjvqO5D8v5m9lP9JGQ5m114TaIw9h+/Y=;
        b=dxnOMGioCL4dV1gcoyo7HYcihe5lnuWRXgIP58KvNQri0FvN6QBqfVG7K8nrjClGUN
         n3aUG4KtMQoehyMR0NL3ZbiOSe1lBFVZHpMxUn2KS6FAwlKG0QQozzSOMOxawQWKWneP
         4fIE7DHyptYh+ywyBfziIJZ95KLkV98dRzvi9ZqfI/3dy48/CXui1vooO2LCkbnY4xw5
         OEpO2bn3ani3PXACYUTstZfWu8eI+Rjb+Bqa8Ydf+O4UmHwnLPCdI/hS1wD6eyHGd5Kp
         XGRhT6T76ELlVbDCmdeYZnflu8OwekK5nP74zMYj8LjSbVJf4BOQsgHbRP+Lmf7WOo++
         dYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728233231; x=1728838031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vC0tEgvksW2SjvqO5D8v5m9lP9JGQ5m114TaIw9h+/Y=;
        b=WsknVT9x/KtfXPgdmC1DnlpMQLxG+y5tw74xe7cmVE6ejDTP4g9BDsGC1JZo53NU1O
         DOW8h0sifLG6fXyuwYpIjeGvjJEQL4nWevvk5heg4UgPU/e21TrQIrWCsNtoZ9297hJl
         RN1aoXy0aI1ZVtjDja7CaapxhxN7eC+eIAsEO0XcJvWJ54WtaASsWB3IjERoy5uJTx3Q
         mqNSrrFBm+770fi/eWksv3srUeiW0vjpVDNG1l4YsTOpeNmNhM2wR1IlS6VvLX0hmPXP
         zvcmCyUble9wSgSYP1VFXAqd8oBKbkIoqKFgwCl+C6hRGYLhzrDdRL/hhiFY+yl9Qhaw
         C+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAhKcMfrf/46XR5LVoVK65utVcBD2QmOlHnMvAYGDAy9dBNjZIsguNtcUSqXnFFmRln7tdJa0KAy9QF6g=@vger.kernel.org, AJvYcCW1+F7UpamzoxyE+NojOQWL4xql89bJKOlolPS03F7Ff4Y8iCoWMMz6i6VUWB/ZlyTdw1OTMUxs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gRWmDJQEKJQtWPq/o9xlZzAVPecI4tcUls97InN4by7AWCbU
	Ugd/blv+XdujfL3mOT0auk+yHx4dUxwKTchhEouh+BSLT2BiXC1D
X-Google-Smtp-Source: AGHT+IEnhpQUWb5mxVaLQ2SKQxy8kq5tKtkBJX1KjP115+fvNsvSxdaEFuonYwJ7fRASOvOhRqeJVA==
X-Received: by 2002:a17:902:e810:b0:20b:cae5:dec4 with SMTP id d9443c01a7336-20bfe0626c3mr128373975ad.24.1728233230618;
        Sun, 06 Oct 2024 09:47:10 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930996sm26997295ad.169.2024.10.06.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:47:10 -0700 (PDT)
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
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 6/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dcbnl.c
Date: Sun,  6 Oct 2024 16:47:02 +0000
Message-ID: <20241006164703.2177-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer check after calling otx2_mbox_get_rsp().

Fixes: 8e675581("octeontx2-pf: PFC config support with DCBx")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
index aa01110f04a3..294fba58b670 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c
@@ -315,6 +315,11 @@ int otx2_config_priority_flow_ctrl(struct otx2_nic *pfvf)
 	if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
 		rsp = (struct cgx_pfc_rsp *)
 		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			err = PTR_ERR(rsp);
+			goto unlock;
+		}
+
 		if (req->rx_pause != rsp->rx_pause || req->tx_pause != rsp->tx_pause) {
 			dev_warn(pfvf->dev,
 				 "Failed to config PFC\n");
--
2.43.0


