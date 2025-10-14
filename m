Return-Path: <netdev+bounces-229046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F0EBD77E2
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 998734F69A8
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1605296BD3;
	Tue, 14 Oct 2025 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ1+ybYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585AB288C25
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760421163; cv=none; b=jM1dsN2p8NjPe++cOZx9UsjTgQO9aYjBkdYNQxw2VljTHEGeHbsB/ff192wu7rwSRFUMQ1K2jvKKhvzd5nSAfzvINLh6GOTkMUJRp5Fb9LE4wm49dDVVyVOkd29pTiFQ0pAMZY5z6qYUCbg+x7XXBljvA7KmaML349zP9q6sikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760421163; c=relaxed/simple;
	bh=xiqFJOykby4cQK17gVtELNe3dahFjsM+TAM/4GuYD9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RST7ePblLxWoCtIHD+39GdUj4Nf5jksIlXPppb05ue/lKf/73WMt1Au8P8DLs5e4ORkXNSesS2NY3COQe4VplisTJbRv6Lmuqs0KeahAk/jmR5GvsVcPNtp6qVGiBiPkUFMJBetK+RgPNCm/4zo0Hp3ypvW7RiJPdQkjAEJank0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ1+ybYH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so4398710a91.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 22:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760421161; x=1761025961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWlNVmLtjnf8rAcNm545u/wbHRU51ZDEKLc4vvLow4M=;
        b=DJ1+ybYHL4cjKKbSwkXU6gG1UUY9+h5g+o1p/XIGZoO7DSK4y/CnqS5A0e+NYJe7fP
         09KHxRjHC4ZvC7WGZP3c3yZxE4qNP4pH1mdTIi8GbuAVtQKELP2d9r39iSBLUIq1Qf/r
         c4UDvNA2xUsSQGhcPrxQ85ELUVg3HwxMPDwRAzm748x9/YtMvF6vhP7v2RgjlvxhcvI6
         OONC3FagZW5enMG0bpmzBxV+JKy6mxneZF0Yb6Sy1bpjQ2ukXUiJJHawKG/XCyUNQwin
         0wEeM6So8r42Wo4X2VfkxllL7k4zH+w1byiU4bvSI0qU6gWP2UL2Tx8VymUZqjAPYkBu
         bXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760421161; x=1761025961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWlNVmLtjnf8rAcNm545u/wbHRU51ZDEKLc4vvLow4M=;
        b=d5JhniWi0O6cDY3x5BMJNsiiNLjPqO3iydKTA8KNiGdJymphctzOu7/IGMDr6CTiIK
         PIywn1oKaul+BeM/IV9ekTmmxItbSgPkgqvyx/pVLYy/P/rSkRlxWeizCykSpRQp8g+P
         rmpyYX5bu3d8SG6rwiZMF7asdtFWhNTEZoX8lyq8ivlATPI76d/seCL63rzUTnRN+oWs
         0qw9J6AlflWWWG/j6/GjzAQPW524lpDO7NOIaX47xlcHh4ZEMs8t0pD/xcrsUPoYCZwe
         4GQhz+q3dhHpm/mwgVgiu2U96/p7DS6DYuho4gJMDZO7Pixi25gQMxjcHK4t9GUngI/w
         be8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZX62SqrX+K136zesMjCdQPp1WZnGu2czRbh6VglS717anqG7Vedb1x9/PGgqXSDkSF85tk0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+LrT+L+n/HQg9IsieoHasN9U+FD/oUPt/G4R2UbEIKBYXAc2
	I278DO2qLyexbHde3hSf3v+jlGxEDK4frSfBqfEwGWCu97m3hZhETvtm
X-Gm-Gg: ASbGnctH6cAK5uGDxaa60+KGEemvMht+sUDgbevNbkEbu56e60ig18p+pHLihWzwIgN
	rxCfjJ+NTqtY0R65D7A0XVWIxRNPYEJRJTvPcwvQPL4NGVSbFXbbSVHXKuzEc2+ahXABxpe7GS5
	HITdOsnVC9Qd7nOIXwj/wjx8y7kXvzAGfC5aONKKVgvlyqzpv6QLQoDPgzTu4e1pG43irLDwZ64
	5erFeyRPB/JWu2D8pLWimXN5OmYK37U+2Ry+TlE45rzEL0ORFf7KK8thk8pr1JqWCR94GZke2p+
	QtS2GQR9PosGI1KABAxNIbP6YC3wnjj+Q8AF4QqXUOO778p4yHzG5zUdRnw0s27j4IgghFf3fnc
	8jDh9sxPODQmvSsueJuLTTWLVnBZwD92DZW0sbnN6pysJdU84/MM/z7KmmHGYp/U2zhnyxVeQ7Z
	CZB04=
X-Google-Smtp-Source: AGHT+IGZ4VytOKfxuKimiMVWhQiKhxNFaYk8/G36/eeE0Sx6uLTpUHGY3Bg+9lWRu14oZFzlLrNxWg==
X-Received: by 2002:a17:90b:224a:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-33b5112504amr30797652a91.4.1760421161516;
        Mon, 13 Oct 2025 22:52:41 -0700 (PDT)
Received: from arawal-thinkpadp1gen4i.rmtin.csb ([2402:a00:401:b8b3:f979:38a1:d361:cdf4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62657166sm14391472a91.11.2025.10.13.22.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:52:41 -0700 (PDT)
From: rawal.abhishek92@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: arawal@redhat.com,
	jamie.bainbridge@gmail.com,
	Abhishek Rawal <rawal.abhishek92@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] r8152: Advertise software timestamp information.
Date: Tue, 14 Oct 2025 11:22:33 +0530
Message-ID: <20251014055234.46527-1-rawal.abhishek92@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhishek Rawal <rawal.abhishek92@gmail.com>

Driver calls skb_tx_timestamp(skb) in rtl8152_start_xmit(), but does not advertise the capability in ethtool.
Advertise software timestamp capabilities on struct ethtool_ops.

Signed-off-by: Abhishek Rawal <rawal.abhishek92@gmail.com>
Reviewed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 44cba7acfe7d9bfbcc96a1e974762657bd1c3c33..f896e9f28c3b0ce2282912c9ea37820160df3a45 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9311,6 +9311,7 @@ static const struct ethtool_ops ops = {
 	.set_ringparam = rtl8152_set_ringparam,
 	.get_pauseparam = rtl8152_get_pauseparam,
 	.set_pauseparam = rtl8152_set_pauseparam,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 static int rtl8152_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
-- 
2.51.0


