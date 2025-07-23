Return-Path: <netdev+bounces-209372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC83B0F685
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98E5178CC5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9BF2FD5AA;
	Wed, 23 Jul 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5OIn9ex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DF02F6F99
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282840; cv=none; b=Vvv2zdN1hUDPsZusSJd3HFdmeel8ijtlD5xSHtMbWzJy0EdXUoKkAjhdxqRgz8+isyonfk/Kbm6dcN/qf0tJd/L388eeMa6dGW1Hu8Ty2mSNJvn5VQ/Lr2JbLtp9dhUbINcEnRWppphWoLivu55tLXAv97yU/sCE9UajakvrbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282840; c=relaxed/simple;
	bh=0k0791S51sKw6HHriyPNDJ7fpdSMyLS8SMOoFFDC9uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVR2A12TBz6uK5KdOcDQEuwStF7gDPV9kqK07/yq9PbzwSgIx8CdLZhZsWq0MBQBouD2sahS6HaD3pyXt57PM2+H9os4iNl4jpMi+FKiliGHKla4u3rdttRzQJRWPKktRVWqP2JlZ+iJBQYfZACoweEp3bTBC/wocmwbYtGwGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5OIn9ex; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so6188263f8f.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282804; x=1753887604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV58jU3iDRMSvFKeRVjmD80ktBZ8qchI2hSY+q9ToFM=;
        b=K5OIn9ex8ffjqehWovo2WylCqgj7zkgDX3s8ywTvaDnhE+ySn3lcEDegqCt+Xur76V
         DPL/HeX4aDLsLt+qQixcFVHBHcAT+Ll+QrOs5qPuuUzKXfwIAofQ27MaszJ8inINNePz
         Bzfaqj4arZH8zZXAZ2gM9doV2j2Nqlti14Irfp1ez5DMeMNG1/P/8eK4y/zFl9c3ih/R
         rsNojx/JK4U8LOd9LvTT12gbpZ1DP93rKxviyUNsMBZajg26tUpQuOrnPR07R1caOOp0
         RfXM2R8imIBvg6kS05XDBj4uXy8y455bZ1sYvE2ApFTPMjHpTe9QiF9X8OcLkLUW+Yso
         q+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282804; x=1753887604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uV58jU3iDRMSvFKeRVjmD80ktBZ8qchI2hSY+q9ToFM=;
        b=GYRSkJ8rilMpPEOLpgnZyU+8dBQ6SUB0aFP7FWDiWYsqDDya7zsM6r5tOxtG5EdRtu
         HNWUqLVev+lInvNe7VXexVwRWHXL+OKrD5u0chIItIogzV97OaNoNCS1DU83C9XPm7Nm
         R/Uf4liyKmOzJtn7tUExFtgqg7MqUnn8AQUE7vvrZp20nLRyN8FRM6CRDt2nU89w9LCu
         LWHLoVuRORWDEHhSkAoLVX8wGVsE9ZYR3m99Vn6Tc0236FM2sYLhsovhDEqqCMM4bq9l
         yRAOGKJaO/sdljWbKwwdFWzMys3ShSVumiFYLRdpTcGy+upgY2GDIzUVPSrWMtth9RvO
         E2Ag==
X-Gm-Message-State: AOJu0YyMrzkewgrBHESLawjwnNl7ZYrUkhcOwZ2PTAuR5L4KTZ9IIpil
	jBOMx6WOV83zPy2Q3MnI2THIE2wUXhuesU+/PTrIQivwk16YJvB874xggXwjac/s
X-Gm-Gg: ASbGncvhCuvVq5Lk0kxrhHttsEGbNq1jFMAUADmsZBmEPrlWnVZlr602VXjNTilPtt2
	HQaTUPuCfZ4J5s4PPyhbhm9fnAGptJnCapgQqg7lWFWLfddEknFE+5H03i3mwUTMZFIDRsIsbND
	W4JIJC2o2K8t88Rkl/cOFiE4kWGJTv4YENd7qGr3SFYVMoXDwzEFIxglJysQmSNQG2DFCOVCGFh
	gWiKuJ5DPHmzLZVD4OFunQX2IAvyC647ByOTDRxYfvfSIPTasGDssDLi0qx6NzHWTAFb8HMDys1
	dN4N/mE1janOobi/2qIDMO0KQVkBcO/xtxjTzWiBf2MabQprKx2ZLBSmTylbj8x9McwiY1WRq9R
	19SuSw2JGNRlyz7qsllNc
X-Google-Smtp-Source: AGHT+IHqH2SmWxbVt1vPVeH9N23lbjrWYokVIpJHSf76x6+O0FSs7rjb/+S5SbczVag00raqHgnbSw==
X-Received: by 2002:a5d:5d07:0:b0:3a5:2fae:1348 with SMTP id ffacd0b85a97d-3b768f13852mr2774979f8f.51.1753282804147;
        Wed, 23 Jul 2025 08:00:04 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:4a::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca253f9sm16812352f8f.6.2025.07.23.08.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:03 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 2/9] eth: fbnic: Update Headroom
Date: Wed, 23 Jul 2025 07:59:19 -0700
Message-ID: <20250723145926.4120434-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fbnic currently reserves a minimum of 64B headroom, but this is
insufficient for inserting additional headers (e.g., IPV6) via XDP, as
only 24 bytes are available for adjustment. To address this limitation,
increase the headroom to a larger value while ensuring better page use.
Although the resulting headroom (192B) is smaller than the recommended
value (256B), forcing the headroom to 256B would require aligning to
256B (as opposed to the current 128B), which can push the max headroom
to 511B.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 4d248f94ec9b..398310be592e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -50,8 +50,9 @@ struct fbnic_net;
 
 #define FBNIC_RX_TROOM \
 	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+#define FBNIC_RX_HROOM_PAD		128
 #define FBNIC_RX_HROOM \
-	(ALIGN(FBNIC_RX_TROOM + NET_SKB_PAD, 128) - FBNIC_RX_TROOM)
+	(ALIGN(FBNIC_RX_TROOM + FBNIC_RX_HROOM_PAD, 128) - FBNIC_RX_TROOM)
 #define FBNIC_RX_PAD			0
 #define FBNIC_RX_PAYLD_OFFSET		0
 #define FBNIC_RX_PAYLD_PG_CL		0
-- 
2.47.1


