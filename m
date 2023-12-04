Return-Path: <netdev+bounces-53567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648CD803BE0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950021C20A21
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49022E84F;
	Mon,  4 Dec 2023 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jikU+oxI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41228E5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 09:42:34 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c627dd2accso1696773a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701711754; x=1702316554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oclHkiXhP9AH9qxtZO4NZEqr37yXlDxNsnoG2f4TTTw=;
        b=jikU+oxIbJepbha1OTkJKnCyMd1mFh8aehjCIRYg/nEiwL8Tel5S7AB5TKgxHo26fo
         scxY/I2ZLLtLe3ppJGJFa7F+jJCB3pU6BeW1WVtqViWrV6YZdhdmL0XYnBoO4fXe61yJ
         LRZRh4YyaYAo5nSMIYolLAqdlbr0RcfDhz/Xs91RXbWoJ9tq4djH6+BmAuqbg4TUrTwo
         4cwHfvSHxDcFpFuTSwrwtti0EbTavOv37PpRDpOMjMkpYyiSw28CIUlc11qlnRyJxPep
         kgClByXAKUInPVWW3Lw6O0Q0INPpEikIX2JnaibW3rJi7JpgftSfFl9zWiS0iFDsD1y6
         yoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711754; x=1702316554;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oclHkiXhP9AH9qxtZO4NZEqr37yXlDxNsnoG2f4TTTw=;
        b=WVkpsIegvZ+vshp5xy/R0KxyRTojgKaYomLBvPSC9usZHgZ16wBmtziHzvJvv67StX
         aQWTeU4EcD+3dSezjGAFRY68NBId6Km1OtNubX7JJeMVDt/anpaTrB3DeeSiL1jz6eWY
         N9wt002ixGevd35EsARbhYnRS9YCoxOAOCQR8TM2j4mdFLBLgd2PuArVUo05voAaSBgG
         NUIGmSWLiuRmj3QmFF7tCNatdzX1aLLrtPLcSbBsooTdMr1szHEw0Bv4yf5m9QBjwJ8q
         Oy9HTXCxqTZw2A+dME25Fzo9/rhIuIG0chZ8XQB3KKHoYJatHPUwof627KdZ1I8LICjJ
         I+yQ==
X-Gm-Message-State: AOJu0Yz9YiW92Z8KvcKnMsrwJLC+9LIaopf4goYh2m27JjVHKxRONf8L
	Q2mv2NWEzxtX5wpPqKPJy92UYSY=
X-Google-Smtp-Source: AGHT+IH5yAVIO/3R6uSF4o3BGdNrm5HO1yH9t7OQQdICWvUaAadHfp4HSnYzoDjRqB9kdScv2F3ApU0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:2218:0:b0:5be:123c:5fc with SMTP id
 i24-20020a632218000000b005be123c05fcmr4147138pgi.10.1701711753640; Mon, 04
 Dec 2023 09:42:33 -0800 (PST)
Date: Mon,  4 Dec 2023 09:42:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204174231.3457705-1-sdf@google.com>
Subject: [PATCH bpf-next] xsk: Add missing SPDX to AF_XDP TX metadata documentation
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Not sure how I missed that. I even acknowledged it explicitly
in the changelog [0]. Add the tag for real now.

[0]: https://lore.kernel.org/bpf/20231127190319.1190813-1-sdf@google.com/

Cc: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>
Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/networking/xsk-tx-metadata.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index 97ecfa480d00..bd033fe95cca 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==================
 AF_XDP TX Metadata
 ==================
-- 
2.43.0.rc2.451.g8631bc7472-goog


