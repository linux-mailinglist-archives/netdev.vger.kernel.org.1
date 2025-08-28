Return-Path: <netdev+bounces-217754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32031B39BD7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DAE7BA68A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791630E85E;
	Thu, 28 Aug 2025 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/979i/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AA30E844;
	Thu, 28 Aug 2025 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381359; cv=none; b=mesb/MlMfYgclk1GJkX5jhSB7N8EBvv6LdNd4AzVLfCiik87JPs67Fi+g8NFmdD7+hx32lz21NCpcKaW9kF1W3BV4e4S4YmsCFSd52G1irh+fm85f9YpbqTR9eIAex2F/cGqI02LPOXKYEh2Tw5pE4w898oxcNzOkkW8H+pzLLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381359; c=relaxed/simple;
	bh=3kSZhBrKvz2aAzAzrAw6TsTEbys099B0Bx2hGX4t6q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZ+JdPOp3IYn4z7GNN9LJofXCL5zPGOMkLb8g0CW8I+5n2HZlld3ifok+w8+Wtf0Lw+skBHcPRBufSevkuxsusiMQT3n0ao+e6kl59z79B5ppnxJ305PFA5WW1MM4/FGKU85d7/xq+ZiiCDGBdOHpR6uSg0fFAmMT0zlgChv80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/979i/H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4c2630ae12so24072a12.3;
        Thu, 28 Aug 2025 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756381357; x=1756986157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zz5OdET14bvbaoUZxADja3Cnod6iht4siGFZlr3OPzI=;
        b=D/979i/HzM+Dcv6XmagEfMIU66t+tYKRtKV8WYfDMXZo0ooV1g+1x6/lpExiGYzBxd
         hglsZTtVvHBlIFdnz3K2frakydUHLtDP83AwEBekG5c95Kcy5/u/LOL0J/cJHJDpF4OQ
         IuAy8KqOpYPWQVhGA4VH2zcJMGQ668uZHFxcLjhMc81NJSUDqeVThUe+WSC+TwfCVJJw
         T78vBsA4/Na546YoY5BhZBQ0RNC1zzZbxD676QayGXV3ELJhbYycUFWzHN4c8kAQs7hW
         AoyKGYJSPkt08GJeLJNSxCVCGyHi+hrixkKECwwIU3St8rI/7kiOUZGTE4p70CAzFRDx
         GZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381357; x=1756986157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zz5OdET14bvbaoUZxADja3Cnod6iht4siGFZlr3OPzI=;
        b=Af1jsQyfD+j3rZ86ZsIcedhBHJq56yjcz3kMBu5lb2YYRSCWGeeACBMfjYT7Sh3o2h
         k+fVgRNz4i6NpExAG3hOzbKyh7WJRblrkJ9oK1vGY2y6a2W/Fl22+LGeB/f1TQQxg5+m
         QC7BauxkwcW73Lu/N7VVcpCVQNaDNZXtepaRoMegXC7o9lS5yXXgTj4yXItvz0dhZKk3
         ca7nexZaTdr9IvbcaxAoHiXqCUB2Cw40Z0to5KQip2TQ7hQ5XXdYsgGG3EN8jMmMesBS
         pb3m4Hj89uPacGLU3q9yK8qpXsmA2TjFz/rDe5Reqo8OIfQPpOvPoFFGz8LZQ1YRiZcg
         /zLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQtoB+XeEdNH4ZEfr28CS7EtImlPj68mEJVcCZJi3y9ljS6REk0idg6DoLQLbR62wQWLZU19zn@vger.kernel.org, AJvYcCXHvK1kOvrPRTJ0I/9T7Ge3RFTkceVj0qaOWpoPbb8vpqhRzW/Sc394JcYLIbaMKiUtSByWPWouhjzuCQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBT38B4LW83Ipc9q5AXg5+POMjd/jLQ60pEhwE5QPKAEOgMo8G
	ST1ETVvyuL41M85tw35IJJee895mT/Tw2ymtzzCk1msrlRfZOABz8tQY
X-Gm-Gg: ASbGncueciOvaRm0oxBoO3fLavzGvMW9rFKzITaM8l0rJ+WOllezSUQqp0SBk4hO7yL
	CAOt29Cjupu/rurET8ypCUT4nY2qvrRCWiFNXluSkge5Ng3JE13QpEl5EbOEX1aurFihONbxIt5
	93i0x/0GrwuqW44O1tvtApAeSsv94nBs/6Z4CSV7VxWALxeOfXt/ExhWhVYe2/OxW1bVHmiP1T/
	bWHlYbCyMWRa/1ntp1souh3GRF+q78lXAPliR69/FB4a8bMxkS4d6p3O6aeUZhpX8yUeMr/0fLI
	zw+QSfiElsQleVzZfu+ys9zqN+gbd9xTGcbRfVZO/Z22UFhz6stusS2HW4FbKHe40qbLC5fsNtI
	YZUcR+8O/3vsinXUXGVGmrvjAREAC
X-Google-Smtp-Source: AGHT+IGddHuFzGZuA8gyKj/JALukMUHFV1egCTs+17Xm1ZCD3HJRFq3WUNgi8BFJPyAK43GHrynRNQ==
X-Received: by 2002:a05:6a00:190e:b0:742:94fe:c844 with SMTP id d2e1a72fcca58-7702fc0c607mr15188840b3a.4.1756381357080;
        Thu, 28 Aug 2025 04:42:37 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:c01d:64c:3fe1:6c19:3ca8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771cd487f90sm11537306b3a.97.2025.08.28.04.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:42:36 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Ranganath V N <vnranganath.20@gmail.com>
Subject: [PATCH] net: igb: expose rx_dropped via ethtool -S
Date: Thu, 28 Aug 2025 17:12:08 +0530
Message-ID: <20250828114209.12020-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the igb driver does not reports RX dropped
packets in the ethtool -S statistics output, even though
this information is already available in struct
rtnl_link_stats64.

This patch adds rx_dropped, so users can monitor dropped
packet counts directly with ethtool.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 92ef33459aec..3c6289e80ba0 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -81,6 +81,7 @@ static const struct igb_stats igb_gstrings_stats[] = {
 }
 static const struct igb_stats igb_gstrings_net_stats[] = {
 	IGB_NETDEV_STAT(rx_errors),
+	IGB_NETDEV_STAT(rx_dropped),
 	IGB_NETDEV_STAT(tx_errors),
 	IGB_NETDEV_STAT(tx_dropped),
 	IGB_NETDEV_STAT(rx_length_errors),
-- 
2.43.0


