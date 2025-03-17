Return-Path: <netdev+bounces-175333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E4AA653A3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E812173CED
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8F23F404;
	Mon, 17 Mar 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtqO/ofN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169BC23F401;
	Mon, 17 Mar 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221929; cv=none; b=H8rseNVLNT4pGaeMUExx4m1v/FSKtfEugGa3Tuc9ESxj536REoLt+uP7Sw0BwwR6LzwghCbFxi+Qbe7pdUHxeVxUOHzM0CdamQi1AZcJ0koj20GqVjt3PnlURrP/MMSpQipS0gmtxPyCNw6mjUM+Oeoi2KOgK5tXtUYdnE/9r/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221929; c=relaxed/simple;
	bh=L6vZViLf/AWBBPqSQRxB9AbJIs22KZEVsuH/wa1qP3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjNqz++prAiT+kd7qNYYSMDcixE5eXdSHQQncI2spM6eDaIjMRtFWjTxdVJWhGFwHxjs0x8hH3w8Xdj5e/0/An5RxRqG4/eGcN8/tpua+69OPrgy2UbWXk5DGGYNA7hG/utfM5NvN+evMGX/GUxZrXhLYtBrtmc9J/e7Fo6sVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtqO/ofN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so71496485ad.2;
        Mon, 17 Mar 2025 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742221927; x=1742826727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObvDKNQs40eT4ahBFyXk+Ns0MX5dau0caAieOzlUfVs=;
        b=OtqO/ofNN0ozjz+ozyhlUFlCL1LtI6G7X37dJhM/ZTU90BhqVTsS64EKcOCOUxNzfI
         07zYQaSes7C+k5mgS6L0BKnk5PKXmyZhaos57U6++M+BAFLyAstTI1jhyrvGRduhaljH
         QUE8As4Noyp7Izs1HImYHRb+89E/91HKmpXvuzuw1jYXYWba1I9o6vsettO6YTx5gRfo
         WPYUXOu8ySPjEQbZOzI8Oburcb2pWc0TLo7wTFtQURqRocKxfeF1awavA+BD8VfaI6DN
         j+0leSapALwHTegN613p/qsg5V1vXpWW3IPtdLXPsoDMLn3SLtuw2029NnJDGnKvGG2i
         q2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742221927; x=1742826727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObvDKNQs40eT4ahBFyXk+Ns0MX5dau0caAieOzlUfVs=;
        b=DGEMqE1SvF2qci0aKVjM51k0kuICz1MOdtFpFkhZBKksLoWpvLoFV0GV9pQj8QUJLP
         dLzbPCOENp0iq05pO2COYP0PrduXS73L/FlG0MlYp0alMKQfNaWSPqhyT1G9iplz9bx2
         V61b+c9mkRol3zLmpnBj9AO3biwxDhexWV+W3Opyfa+0liX7BfTiD/HFdgEnFtptjwLR
         aqp4w2CzKB38hu724PLmC2L4oqt2S+fct7jf4AWHKj9aRgm3rxRMPy8YUo3QHI+rE8oN
         2I2ipUCLpCTb6he6taOb99OxXOhso6gx3Qw2Pi737xklaRujvIP+6+ZAcF5DJsRUMgMa
         +SDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcko9ewJLSXVB3csPPcb/i30AkmXvwrHwwRM76srpqTzqTRAhifFGZvFkQ8RQEkCsFRSbirC+hbp3VkFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnfLlFkxDZO6GRw+saWciOjt+WnKtByI4pBjWc586/5f3Gp8W
	LTfcF63kjGSiCWB+gX+LbI5sM5GcvY9deJBPiSGam7nTi1c7luvDAXoc34A=
X-Gm-Gg: ASbGncshDWY8/400apHm1flZlNJdCoS49yWTwfvt6HRy5463JwehKEQsFWsItIsshZv
	QBpDe2BvaDPQPnOOhVOM2Ka/8n1qvmkQFepwXAwL1Nw87WFEh+R/egAP/Ox1J7Y77pGa8DvHiq5
	s3/xSCfA74b8g8a7/WiR4BlQ7RPtmWQpNK9YGvW/X8SRRsEHqYv1Q3CIkaSRiUnkAa+RXqp/Ys7
	9gUAwl3YwPoJoktFW++LoyHX2GcV9612C+jUaTbZAhvO2JsBMn0KuyXtZio0aD2UBt9hZiiknP/
	4Bl1pAZLm47k1WHIo1nT1nMHrE7CgI6moWtNZWAU3WCWJzo4xv5aqyb8sTV8/TfZSCBaX3l+7TG
	ehhBhPcUQfoFHmljva75A//rH9s3mrAmy799Erw==
X-Google-Smtp-Source: AGHT+IEbqKnI0+Sr8aV2L8te6GQTPyogZQ/TEgsjcdG5GXG2JDBhtZaRB0lNEoehaoBBhGKlqzufzg==
X-Received: by 2002:a17:903:2cc:b0:224:1c41:a4c0 with SMTP id d9443c01a7336-225e0a34e4fmr136183185ad.9.1742221926687;
        Mon, 17 Mar 2025 07:32:06 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688856fsm76058925ad.14.2025.03.17.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:32:06 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
X-Google-Original-From: "Lucien.Jheng" <lucienX123@gmail.com>
To: linux-clk@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	ericwouds@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com,
	wenshin.chung@airoha.com,
	"Lucien.Jheng" <lucienX123@gmail.com>
Subject: [PATCH v4 net-next 0/1 ] net: phy: air_en8811h: Add clk provider for CKO pin 
Date: Mon, 17 Mar 2025 22:31:10 +0800
Message-Id: <20250317143111.28824-1-lucienX123@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds clk provider for the CKO pin of the Airoha en8811h PHY.

Change in PATCH v4:
air_en8811h.c:
 * Shorten commit messages
 * Change init.name clk to cko
 * Change init.flags CLK_GET_RATE_NOCACHE to 0
 * Rename to_en8811h_priv to clk_hw_to_en8811h_priv

Lucien.Jheng (1):
  net: phy: air_en8811h: Add clk provider for CKO pin

 drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

-- 
2.34.1


