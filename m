Return-Path: <netdev+bounces-225713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3B4B97703
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CFB167AFA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3794B30CB5A;
	Tue, 23 Sep 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4jOnM9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA230C61E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657659; cv=none; b=ogdHoLT+6Qj8moqQiV8685EZA0fXCWpyTBZU6YucZcHPTGNtsNlEoYUtCrf+0evpGrYFc+ReePciX2zaqAhP/a4Cs8Ggtz8yXYqoHqzI6GTKL1/zq/GUGI2ZtOzX0uTAFSJ7pgt7muD6EQBbnIOMTWlLWSqmuzvo4CLJnQRBYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657659; c=relaxed/simple;
	bh=za6eoflza+eI0daPO52VrArrXQQh9oKqLFL2yU7G4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4hcLQl/JzhbY7RnBbKWVDUYFR0zIEZilXHWOBkYrqGmNFWiuUhPHel/UYxOp6kIlSuX2IeDvuCts67MmRGWTHYnl2FA8K12JNUB9cin5ysW6vh2Cy99QWVz1c+ozmb7ixwgXVa7jFZ96WSpPedUmEamYNGq8RIIxGAXlFGHPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4jOnM9Q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b2a1a166265so49778866b.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657656; x=1759262456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvM5EG3LMIQuZITndtrZP0Eki684ON50PFEBay054lA=;
        b=c4jOnM9QEkWDqPrR+CsDuHhhX2WaAYDyMzb0l2y9LULpcKUAItkDpwx5lt6sjg4kE+
         UyPAFDmu4aR2C5snhubvV28QfEVemUgyCWRvisVCCCtw36vDRb/fgyIausDx0hNS7+xB
         57jqpD25HqdsXSXljGRYdGUfnjEXAFbQ7tRukTAtUzlFgb7gjcHlLxIdbLmijBrHhplW
         QXCoglWLdYwq97XzTljwFvTr1dlmJZse6/8/FGPS3aNtVUUL+cq8i55XS+mWTpYQcdLZ
         suuPqkJnieST71cj0UPW5T8J/XmqrgQFIarUYWIDiIAHpbJN4c6bRBxXmyh+4IEipQrM
         Z5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657656; x=1759262456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvM5EG3LMIQuZITndtrZP0Eki684ON50PFEBay054lA=;
        b=Iq5e7+J5KOUxTpKeLcAo2jeEwwyHQYxxFnm8LvMtlpDgIyYl/x5cOay7cddmL697zI
         vx74Yj/+IOn0Gz9KgD2xsvMhgMYfpB3AIjv3ieNriwCtZlx7ofEAyVmnL4wLsXji2i3Y
         C0YAy8ySkOHItdl6tdGlspRYGXNlc5NZFygXihVA30FQGAyBrAgpE6TcxEUtip5ckA4J
         xooAn366sN8AosjkiNIXkGep1JWxzMMwebINwqn6VPkpGjlcTJaF+WIKjD+OXlyeWzS4
         7CB/hcMojeo0/sd1nWIatzv/jvgbGxP8UfmoONqMYQf5ra/aPDDxyf3Zyy6Do53VmJAM
         cS1g==
X-Forwarded-Encrypted: i=1; AJvYcCWPq8yr7f4BAGOWVJZSztjScjVQjKBMbXrhyetCnPOFNJpdwXMrtYZpuF9TILwknyV4wdAIzew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAN1vAhulWxZVGmgPpds08G21aQSuzO3ttUpN5D+4098SStXtg
	EYFzTCWfE9LsTKEHuO5dmTERgoY7i9SV3zsUlv9v8lQ4zjNNIixxMV1r
X-Gm-Gg: ASbGncteDBgqzpRsneTrktgc+KB9rd6XM6hzDxtu7wo/QihGaWB7VDM8EDZFVYnDqNM
	ryxmNv4IeyMWfze4DvmwGW1CSzbdVzVRE6aPjm+DEAns4dOeobphKiVMcyHlCfTItA7E34ryvaK
	3LyR+V2EevtWl21NSb8sVUvxp0H1BDnsRowgdz8cw46e3elDvGVAWhxpJebcbLnz71WgrtWgrU2
	tGILpDnFzuzhrVNGK0AfrBP2qTdyxZxsYE3wUD05q9B7bGZ3FwdjxZ3VCfkuopjGsZbZyTIHNds
	lcO3lm878tYqiK/l88zA+raZ/2reztKeINqgdA8ooMYDAK5oqyDLuBZefwj5fSLgoDCapw6TiGx
	Qdmgnv0TfyZwwXAWjIZ9mySQP
X-Google-Smtp-Source: AGHT+IFnbqnzDpvcF1npAo3gJlRiN0aWJNOZlV40ujMaGftot7QGowUdecTibpSbqF5TWABjiIk+nA==
X-Received: by 2002:a17:907:3f1b:b0:afe:88ac:ab9 with SMTP id a640c23a62f3a-b302c10a6acmr180708366b.9.1758657655543;
        Tue, 23 Sep 2025 13:00:55 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:55 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 4/4] net: veth: Implement RX queue index XDP hint
Date: Tue, 23 Sep 2025 22:00:15 +0100
Message-ID: <20250923210026.3870-5-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement xmo_rx_queue_index callback in veth driver
to export queue_index for use in eBPF programs.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index a3046142cb8e..be76dd292819 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1692,6 +1692,17 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_queue_index(const struct xdp_md *ctx, u32 *queue_index)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+
+	if (!_ctx->xdp.rxq)
+		return -ENODATA;
+
+	*queue_index = _ctx->xdp.rxq->queue_index;
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1717,6 +1728,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_queue_index		= veth_xdp_rx_queue_index,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
-- 
2.51.0


