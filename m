Return-Path: <netdev+bounces-133355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED26995BA7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA11C1F25237
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB982141A6;
	Tue,  8 Oct 2024 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlAIqGmL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB96192B6F;
	Tue,  8 Oct 2024 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430255; cv=none; b=Ooc/znZRA1yogIF4KsXg1c8lnhSDc1iDAouMEeDQunqW3AtLuANy1dTJMlmAY+KhBNzmbcf+P9UrnHO0315XMAAcHRu8BXiCYvf34bDPOUQD9YSKd1PHQuLQkKNu7B4VxEljTQrNeKaw0W2VfaVOr7agLB+Cd+fHwHh+X5CdfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430255; c=relaxed/simple;
	bh=2+cfVs98NAbMVMei9tVtS/3Ha5ACjYkKn/NQ7+yiwVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mK02L4AJnYXDIjQvlZORzlLtXNL1ZYrL+Zmk1jlAWDkkWaSE3A5vkDl4QoJY2Grt5jv3UxH3eSKcfmlX+8/Tjzep1kC6HtolEzpayest2X3FnrNkbQkfe2QC40lEQeQNjUZG/Fqoz2aR3lH9P/DrlVckL8WZ1xdg2aiuEAyG+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlAIqGmL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so182054b3a.1;
        Tue, 08 Oct 2024 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728430253; x=1729035053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8h4OuAkaeKlVdzZdGipoiLGad1VH1PX/36iQieLhsE=;
        b=DlAIqGmLxdEN5LOd1kunM86lixpYAED9TvrKDVhAC3fVDCcvqt7qD7qiFSQF/peu8p
         RgS2Sk/dqSYsTmEwfmsNXnKsiO8qXFknoy60F+G64TC3fCuA5ODpbzYI3UXmr5ZrUP17
         xtrEhgyLpHoVTL8174d0oqPc++vJdSPNdIt5XPH9h7GTnKdyK/PrV9AFDNSkLj+YXbu8
         fnS2KIq/lsEaNtjXmbTOtYPUbgfeu35LBBsZqG+nSY0aNMikpo0R4R//3Mnx+cGrc1et
         qLpcx/BudrBNr6MwDNrpUY0X7FRKaO5JtU2Ce3zmK0BzD/KM5TkPnUJINmMTZQ2urm2j
         Zjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430253; x=1729035053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8h4OuAkaeKlVdzZdGipoiLGad1VH1PX/36iQieLhsE=;
        b=LD6PQJ9V2Sk8d77EyAxLTMeoRTlN8vdm1vKp7uEeAemDTC/klgyj+DX+rE5+4uxnkm
         gobIVx81HVGKp7AobF2tmR5THoNw/bLK2PR5LpcR5gMX9Mobc6ExsXd5TGRHQ7UXU2kX
         y2zIGETfugYLx4iNQ7wUdFdG4TIcwaSFADlr8OqGxzYp1YTP/lf9vFrgeCqnqt5S4EYM
         ZSP/kuVTr7v2PbNwm8B3cSsCJVCKfMWoVYC6wcgI1CmrHJWR2BE+FTqO5Zi8071jkSTm
         lwXFXlo6Wit7Ps5dax202HvmWrLKGe8RbA1fWQpHe4IVVKXk/9k6qQc66jzLsTAL4cKJ
         6Pig==
X-Forwarded-Encrypted: i=1; AJvYcCXMhEeekRnz70Fxc77YIvGL3CehMdVmPcJHjUNazdRzr8X4EhK1rOu1St/y4so1e1sBq5LCl15Sfd2X51g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuybKfSoYCuj3Rvs13Fmq0KDLOOkNhVVoW+GJSRa3XmSvCwON
	DFHSNM9JE8DOBAiGlchWg5z760ZlSX/vL6VvllEsd1AaiESM1+Ui+79kDVRC
X-Google-Smtp-Source: AGHT+IH2YC4dLf7BX27VSYGuwuKPHmzw9NZyrrR42wywP8BQi2byS3lvz9tj6mcmP5jXwA9w3s/ZFA==
X-Received: by 2002:a05:6a21:501:b0:1d5:377c:2244 with SMTP id adf61e73a8af0-1d8a35300b4mr952450637.20.1728430253108;
        Tue, 08 Oct 2024 16:30:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7b9e1sm6670000b3a.188.2024.10.08.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 16:30:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Breno Leitao <leitao@debian.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net] net: ibm: emac: mal: add dcr_unmap to _remove
Date: Tue,  8 Oct 2024 16:30:50 -0700
Message-ID: <20241008233050.9422-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's done in probe so it should be done here.

Fixes: 1d3bb996 ("Device tree aware EMAC driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Rebase and add proper fixes line.
 drivers/net/ethernet/ibm/emac/mal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index a93423035325..c634534710d9 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -742,6 +742,8 @@ static void mal_remove(struct platform_device *ofdev)
 
 	free_netdev(mal->dummy_dev);
 
+	dcr_unmap(mal->dcr_host, 0x100);
+
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
 			  (NUM_TX_BUFF * mal->num_tx_chans +
-- 
2.46.2


