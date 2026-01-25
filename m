Return-Path: <netdev+bounces-253118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDXPGVVgdWkAEwEAu9opvQ
	(envelope-from <netdev+bounces-253118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:14:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C161B7F53D
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A3E3011590
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 00:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F771C68F;
	Sun, 25 Jan 2026 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE6a7/HY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43F8F4A
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769300041; cv=none; b=BRsHIW2QRQnv7t+XJol791CiqxG8LFOTaRx7MpLj1NSh08cxMgUFqmygzVIS/A9BCQMYmeAZ4iPPENZc7dmHNZMw9hNk3KSuNl/xhQr37W1myHddgX9MbOCnynLaCTGSNeDX7/BmFo0RzVnwCIqWH+WtilaX/E7/1egZBAUpfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769300041; c=relaxed/simple;
	bh=AeXtKObizoo73jdpzWjN+BArFgYEkzud5nVgNawNRyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cv4W7GaAIgXt6cY6g9AXUBGhlDdhQSAV+q4J4eKButsNHmhkeqhGdUgr1/m8yD6MLU7hMwHidnf1lq/6OEjylmKCCVJhf/2RHqNGgyFrlyLDv1rre8Mq4nDOD9DT3NRPa0v0vl1x3u8PnG6DLGeZZ0WlLLL8y6HwA3J/0fhvbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE6a7/HY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso1461264b3a.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 16:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769300038; x=1769904838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJmtWrprWI+nZr+kZXyzireoTq93JleopmEATHxkwfw=;
        b=BE6a7/HYxqXv7naAiE2ovhkeT7k+cLIBB9WhEa5HiP10j1cENAOoJGCw3h1WU7h0NT
         2f4VC/xfkeV239mebiXCGuGoCzfHpAcDw/ooUVFZXXYPIaD03d9TZ2ZrnnHJlEkOa4Xu
         QWNrrMvHh8oryxhZ/EyYpg7lMZ3g6yRdBNly9wfNIbePrI7HVytzn6d/eb5nmJSw1W4s
         4o9KWh1WB4erjhHvFe1UX+Dz26N/rYZXocVJv0kBH6Vt+YWEjrGvJuyijlQMJdcKvwPi
         X6efRanZlAzYbwp5tofqoNwbXQZeUCOVKoPnaBbAFCD8+QmdZxCR4coERNpkoRW0cwvp
         rbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769300038; x=1769904838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJmtWrprWI+nZr+kZXyzireoTq93JleopmEATHxkwfw=;
        b=ZWUhKJA+BTCHpxMYKUWFWMj9evsl75jWa31C5OYD6e7qFbRHYs3zWr5vbo7m/w05RD
         IZT4FYakh4aR1kq0VfYutYAnjatnKNI8ha9oZr774tBZrnSwN+KjSIYH91p2vJZjrUtY
         uzbNs+HA4yq+OjncbmluvnYYGvtYu3wcMGIqQafUnn31XFWnwmlurmGNduzNX8PbSUbz
         UqocWDuHAwjsbhdEh9c8LLV12LJN+xP/21O5pgUksGnxYzfasWtfQV+joBhCgYvqeFrj
         wG43fj93go7RbJvhXCW04rb5q0H694NSLzppqJYis501iVrJZgv+tgtVbnzWze4e+wzc
         eO7Q==
X-Gm-Message-State: AOJu0Yznnd2G2pd4CTQ4aChpsv1i1Wlc6t4P+58AT0Sgy5wGVVU2MQd6
	PldOyQif0y4VrNWFOLLaTrwRm2fkUEZWdnXDc9iYJvWuETojrc5CpTKcPYSz1g==
X-Gm-Gg: AZuq6aJu5aa3jY+aRvPk7pNjVWPLJigR+S4AKKsZ/YtXJu9yqNpvuNeBhnWyRFf10o9
	PwuGaJGgWoPVvw9J606rl+PAbQqwH8Uz88hKytNkadHTfNNs79XLduVr8rBwmeR6t4iuxPwsklq
	AlgRsroe7UAMES1CzPx/FdTT54Ma+TE7TAjhzwgZYYiHfcQhN+nyUOMYO2kaCkp53F2l+IUa+UO
	FBZepVA9ajNGDHeVmyi/vXJ/kCYL02rnvCIUser99svsw9r1bF12dOCxSZeWPg+i/+sXSuhKLi0
	BAiJd46ePYPrdGUNkZlthZ5sAapDlziwag5OzM1VaPF9ugTIQ/GEnk0LyNMDpi4bkUkF3tn4AwB
	4njTbmZOtk6o9mpRbtagk888DmcLEz+Eed76AMK3hq/1cIvTVridkzNriFjKeyivcwZSO0z6Tp+
	dG68j4M87oRUoo4UiYCFurGQC8q3dIE9yzglwSJ6jOAXCuZZKKCnScLHU/ESuLijb1
X-Received: by 2002:a05:6a00:94f3:b0:81c:717b:9d39 with SMTP id d2e1a72fcca58-823412bf455mr164621b3a.56.1769300038380;
        Sat, 24 Jan 2026 16:13:58 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873ec59sm5683488b3a.53.2026.01.24.16.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 16:13:57 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: dsa: yt921x: Add DCB/QoS support
Date: Sun, 25 Jan 2026 08:13:21 +0800
Message-ID: <20260125001328.3784006-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253118-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C161B7F53D
X-Rspamd-Action: no action

This series add DCB/QoS support to the driver.

v2: https://lore.kernel.org/r/20260122194233.2777550-1-mmyangfl@gmail.com
  - make DCB support optional
  - refine with enum yt921x_app_selector
  - add missing dscp_prio_mapping_is_global
  - fix pcp support
v1: https://lore.kernel.org/r/20260119185935.2072685-1-mmyangfl@gmail.com
  - rebase

David Yang (3):
  net: dsa: tag_yt921x: fix priority support
  net: dsa: yt921x: Refactor VLAN awareness setting
  net: dsa: yt921x: Add DCB/QoS support

 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/yt921x.c | 260 +++++++++++++++++++++++++++++++++++++--
 drivers/net/dsa/yt921x.h |  52 ++++++--
 net/dsa/tag_yt921x.c     |   8 +-
 4 files changed, 300 insertions(+), 21 deletions(-)

-- 
2.51.0


