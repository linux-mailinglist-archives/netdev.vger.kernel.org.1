Return-Path: <netdev+bounces-129237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252BF97E699
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA5AB20CBD
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 07:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF294EB51;
	Mon, 23 Sep 2024 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJase340"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142153E49E;
	Mon, 23 Sep 2024 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076548; cv=none; b=GqCw2zUVZ0KMMMYk39UesxCkRX0asBn4hU7x7jsyN+ILCyVcueuoqi8NAypufDlGxbbGSrq21SOY8Trrdl3SbEdK+UHx7DPakNSQNHF8p9o+TLJJsw09ldMynFZw7jtSc62sQ6Cv1iIuC314HG59cVkZKiuY5uKbUUKiX2gCync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076548; c=relaxed/simple;
	bh=lPM7uFSqCfEGSIf6vjbIKhNCRwm0OmTJEE2lN8Nt18g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNAgg5TA77VPaXoGGirfr1DOVzvU6g/xizDbyBBFnAC2uBAWO8O0JEKH/zPyTAtPkeSOCXeP1lIJR62TAyYbdUpcNu/GrwlfKccZL7ONsstGysHRo0ZZdDM6lS6dxUxYPfkhobMBNfpkI0IYhfwK4KjiftiFKa2+ZugZlobWcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJase340; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e04801bb65so2114267b6e.0;
        Mon, 23 Sep 2024 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727076545; x=1727681345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIVIVYYQShi+AHq5DrHJj2/+M6JZof4RPiuCjUXL9z4=;
        b=DJase340Sr+SKM4uC16/cqFG2k7ZY4kWW3TvnWdcO/MCF6gSnLIaUnYM7J7xkO2Hed
         6iuwHCZ7WjxK40/+XwvdKYRlSSFtsM1saL+K3s4alZkMbd91Y9uJvzr5TeeI6jwzOfGG
         LY40Hyo2ESZu+6Vlb1pM2DoAVJF4xmYRcdHV6CNLCHZLnVrxEFje2vtz0H3b0NfHBlfc
         kczYL5TaQm4oFqqzgtFE1sPfBly5tIA5dETBAYbCIf/kw6Rglm+V3S6mU5fa9B39ete/
         46Qe08oRtwL6upE48uhuSGkXhqZLkeTMKtIDxLuNSfAn2+qfk1E38dV+6XQssG8QCsBO
         udfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727076545; x=1727681345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EIVIVYYQShi+AHq5DrHJj2/+M6JZof4RPiuCjUXL9z4=;
        b=Ri5WftdLSkGxCA1QWu9CbLXz4zrMZITsZT5LXXhea9kwL8SaF5lXEDKQdRaHPCQZJW
         6bg0Ia8kBjfbUDazE/BTTeXRNXx/iQbhMy/TwGkArX5+K9gpptymiG5el9Ibil9QvhMy
         SmJMoPBlSVsWKKZPIw+WUsBVEhcD8A82hL73CjEbYO1rVeTBIf27r86mMFs5WTi0z2js
         Z/rQr4+2v+tzfXkoBD8Z2s0BsGSnU+UGZImRRjUAB/tXoaYTF+nmY5zh//t5IUBZ8292
         8wWtjgbme/bUY5hCC74dh6EOsu1AHKarSU9Oeoo3gBtNveAlaNlNY/st7d0EYlv7Hi4H
         uyEg==
X-Forwarded-Encrypted: i=1; AJvYcCWsJVGZXamGg0uA5+hLvR9Rle0gJ6OUX0/M5OyRXil+rI3fdmI6AHkUAkFQo7O6pSUK6E+vrDnqaiSK/Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGg706qri+jGRQK8akh7AAYb7Zvl14Cg2Wha62KNebgTA6aNR6
	KBsZprdpIOIFnk9PZwFkps4xBZzfDudK3D2DFylbksYcAB23DVEjIrBRFNrIZ1QSXA==
X-Google-Smtp-Source: AGHT+IFuFGjlw5DVtSMYKHnnMheMVvD3mWuLUcPM3nV0ZsA1tUfJ85vuKWAS7kN58lA5Bl2C01d53w==
X-Received: by 2002:a05:6808:2111:b0:3d9:36ba:2c9 with SMTP id 5614622812f47-3e271cedbe8mr6114231b6e.41.1727076545357;
        Mon, 23 Sep 2024 00:29:05 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4992cafasm14821382a12.54.2024.09.23.00.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 00:29:04 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] bonding: show slave priority in proc info
Date: Mon, 23 Sep 2024 07:28:43 +0000
Message-ID: <20240923072843.46809-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The slave priority is currently not shown in the proc filesystem, which
prevents users from retrieving this information via proc. This patch fixes
the issue by printing the slave priority in the proc filesystem, making it
accessible to users.

Fixes: 0a2ff7cc8ad4 ("Bonding: add per-port priority for failover re-selection")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_procfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_procfs.c b/drivers/net/bonding/bond_procfs.c
index 7edf72ec816a..8b8580956edd 100644
--- a/drivers/net/bonding/bond_procfs.c
+++ b/drivers/net/bonding/bond_procfs.c
@@ -210,6 +210,7 @@ static void bond_info_show_slave(struct seq_file *seq,
 	seq_printf(seq, "Permanent HW addr: %*phC\n",
 		   slave->dev->addr_len, slave->perm_hwaddr);
 	seq_printf(seq, "Slave queue ID: %d\n", READ_ONCE(slave->queue_id));
+	seq_printf(seq, "Slave prio: %d\n", READ_ONCE(slave->prio));
 
 	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
 		const struct port *port = &SLAVE_AD_INFO(slave)->port;
-- 
2.46.0


