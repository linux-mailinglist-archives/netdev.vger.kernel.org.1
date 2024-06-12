Return-Path: <netdev+bounces-102827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83217904F5B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40A9B250C4
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B64416DEC0;
	Wed, 12 Jun 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnVoGqSU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4616D9AC;
	Wed, 12 Jun 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184748; cv=none; b=RiulIOeP/V6oaxOMQRK0+Ex095IQdtTOIam5oqms/6peBUPUkd6kLL1JNQ5CKO24rGjeh2haXWdivE/YW5OZqcRQy1H6j+B7YZUNS+/yph8XkkM5sbcIR7w8c8KLQKAA3DHcdML+REb/y15R6G0RrZvQ77TlCtBEScqxM5UxAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184748; c=relaxed/simple;
	bh=6X0iD7TzpO+roGTpjK6TPJPfQxfbzItBOFhP+OjO2G8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsacgVob7MI0mjww44OzY1HtuZm2Ov+/Z9A8/1ecFR/SgmCHo5U519H9t0YqmDSXzeoHOlpKZQCvme5xqph97zMegeHgIE4fcYbEdHsoZrhVa0P+CddyOsRnlRla3YFV6rOyy4iJ4NXnUPblrx6SC+/IIThovR0d5kToqQvhDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnVoGqSU; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-705c1220a52so194617b3a.1;
        Wed, 12 Jun 2024 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718184746; x=1718789546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FQNww1AD6dH8cAepq1wCWnMnAcDBJE7rz1cWisQhNU=;
        b=ZnVoGqSUOIIVP9N3HfXs+JHhD/OWvxQ6hOqmg+5Q9zAn6NFjRhJu1U+8Zq6jrFrsvY
         cQPw0HWIeBiZMtb+2XipOXKU2C8zrm8fQRzOZdDRIRdvPYOpb72e+S554UwI+38A7MTA
         njVJdHNu6lxn7xyytbYVMkLlKFinMxNC9DZUK7DJu7uyb4Ti3SH1lvWfccVM5bnn0sK4
         80louL6R/W2hEyLNOch+nQn3h7ChVfRF8VMsqzXOIqxmAaxT8KqvKaLukupIQM1y04b4
         8L5IZSTrAxJW7U0pgVK0eB++jPYQux43ZnnibUiBC5KJl/wXiAvzY5Vnwg1BsZ367dVS
         iTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184746; x=1718789546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FQNww1AD6dH8cAepq1wCWnMnAcDBJE7rz1cWisQhNU=;
        b=oF+8rBH61KQPruHg4Ifpio5T8DJFnZWEmJML93O1HFkSLgjAAM8sPF0jPaONsDvpWH
         dpDN5TAj9KW0YXXTw6b2Z10akZGAdeoOig+eMqJ9nWN81iTH6tOifHQuFQmvLTfGirMG
         9os4J6FNpdXXSSAd2MLbiUDZR44Y8B8/9XSRV8FfgdwA9l9QS1drGlLRr2jvUR4YzcvO
         6STl4bNWC1FaND159fwFVRWQhd105fnBglUnIASZMgCqlEdNDqcMA8Z43IBJFV/YJpLu
         RC8j0qrc+W+RHJh+4Y7fSLDn5fsHy3MjXUJ+pJkcTOS2MhuG+ku6ByYYN7/dQfYpflqv
         WZZg==
X-Forwarded-Encrypted: i=1; AJvYcCXbofqOgK2mtA+JHXhYzjgUc8uMpcErcCZEmEO/mVn0q0wnIu1wvvtpytecpTvJ/LeRcIXbW3LsyoZueAz05rkPeGoyQV+ErZo86ec05AA4athG0K1YyV9lenDuzDbqortmRprU
X-Gm-Message-State: AOJu0YzpitVyezBZzNO101aB1nKoMH9CNfHYqc2LxOHKmPD77pmLWaDL
	bnRt1rjSRA5CcbewgbQaEPKZWlLEG5OD1eULQwUp/M2VbGLSoRBW
X-Google-Smtp-Source: AGHT+IFFogTLuH64nEqmLHYgxgSfQlcYfIeRTZOamLN1Dw4tSaasHxdPL+wJBoZgTkyLeT9PAPCdYA==
X-Received: by 2002:a05:6a00:a14:b0:6fc:fcc8:cb38 with SMTP id d2e1a72fcca58-705bcf1accamr1608167b3a.33.1718184746256;
        Wed, 12 Jun 2024 02:32:26 -0700 (PDT)
Received: from lhy-a01-ubuntu22.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd39569csm10223126b3a.72.2024.06.12.02.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:32:25 -0700 (PDT)
From: Huai-Yuan Liu <qq810974084@gmail.com>
To: jes@trained-monkey.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hippi@sunsite.dk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Huai-Yuan Liu <qq810974084@gmail.com>
Subject: [PATCH] hippi: fix possible buffer overflow caused by bad DMA value in rr_start_xmit()
Date: Wed, 12 Jun 2024 17:31:53 +0800
Message-Id: <20240612093153.297167-1-qq810974084@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value rrpriv->info->tx_ctrl is stored in DMA memory, and it is
assigned to txctrl, so txctrl->pi can be modified at any time by malicious
hardware. Becausetxctrl->pi is assigned to index, buffer overflow may
occur when the code "rrpriv->tx_skbuff[index]" is executed.

To address this issue, the index should be checked.

Fixes: f33a7251c825 ("hippi: switch from 'pci_' to 'dma_' API")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
---
 drivers/net/hippi/rrunner.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
index aa8f828a0ae7..184f0933bca0 100644
--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1440,6 +1440,11 @@ static netdev_tx_t rr_start_xmit(struct sk_buff *skb,
 	txctrl = &rrpriv->info->tx_ctrl;
 
 	index = txctrl->pi;
+	if (index < 0 || index >= TX_RING_ENTRIES) {
+		printk("invalid index value %02x\n", index);
+		spin_unlock_irqrestore(&rrpriv->lock, flags);
+		return NETDEV_TX_BUSY;
+	}
 
 	rrpriv->tx_skbuff[index] = skb;
 	set_rraddr(&rrpriv->tx_ring[index].addr,
-- 
2.34.1


