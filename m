Return-Path: <netdev+bounces-284031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBXnGpD1+Glr3gIAu9opvQ
	(envelope-from <netdev+bounces-284031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:37:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1AB4C34DC
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D43C3007AC9
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5315D3DCDB8;
	Mon,  4 May 2026 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSCcPRq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F153C1419
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923468; cv=none; b=E7D6+EpjRlp8ejptvhm8nTflOgtsXrqQ7yig4GF38r3mVDOzqXOWNqPNBtEkguW2WtfB8zbXdXgCKua4JyCCvQgd6zF5eub7BxT7Fkjf5Lat53GvqF583zH3TirUNYFQLlFJaXmJjvLZcSAFa8y1pcFR585gK8wuWA7G0J42MQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923468; c=relaxed/simple;
	bh=1JOyIRRgBwbB/DhfXPbjmSn8yLF9GaFDLeyZF/pITec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=po2kGCIGHV89gs4OYCQMnEEVg59d1bPyvvxdo5JvibONWgQlEWQLVPlpq1icp54ZA5oy6fh8MUeH/soRmlLkyAkYPo0kIHjoWhz6PQ+hPLZhXwxArQVRWFo1epx8ZZVw4a7TJwa1xrZBwa/4XMwLs5OXHIRAEJJckiPDseaHUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSCcPRq5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8296d553142so3363895b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777923466; x=1778528266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0aIguRQYWYljT8AmitpZ9/B4tpFTi2ewvWnvOjrRTM=;
        b=SSCcPRq5Ssgo+8Kjf84DWCka94hZLFw8sTMgiVgfAdZ1DQ+yt7bu/gXG2voYqFe0g9
         3lB90HgwGgAKXsshtNsxiHxB+A7gsX6qRPjdpVANMcXc71OsTg5gV8WccvI34K1sEiOm
         K+ZepyzbKqay8soo1WLsl7r+7H+pixbstcegEedpIW8ScTfVMVLEkl25e7nb1ELW0iFN
         Rw8+o9qXQ8JVCApGCZaEl5avy4g1zjo5h09naV5/Ix3d+qTorKyJmocfxvtNFYlKIOe1
         4DTga03LkTI7/GwXY7eovJG222znrMkQyN4qvDGn2P/V3U0Wbadp2fQ4VCFodgK5H6Bq
         7iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777923466; x=1778528266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0aIguRQYWYljT8AmitpZ9/B4tpFTi2ewvWnvOjrRTM=;
        b=nylt+v8DdZsohLQxNRc06JXF8RLImGyUkOrKUDgm/QKpHhP8CVJX3xlrrfWP+FooEd
         PukoV42KIYYYvEEDxXu77mryTwE3sGwpxcd41gYLH4BXbSw1CWujfEad5zX7BGaEwhCN
         SNYcC8nYXq9dIhZ3CZBWz1uBAfeWVPcSL44PKgbH9cJb8v6Ov7FsJtk0LkRKwyNzmaBO
         pOI6INe+Q2C2wplLJwyKJsAM89tOvYyXHePxmCv2u9AXmzengpPGfqFpw/OBg0n00U9R
         03bPKhHVp8Ru/tYvnwGghxOGaWRARglxLmw28TsmT0xsD9mLcAin+3aFrD9J2tfFXe0A
         NdcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4qGh/5Ld009LrBB67mplH/w8lvAyNJ29E2OlXOx4eu8dkaRN9EZ7I+sEb5GrePSfjrU2fq0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0mu812f0o7fj6Y/9QyUKSr3UIaft+GzF5zOXpw6iHrD21r2u
	r2eCn0SqYhhY1DE7eiTfA5var8TwK8mrFThoaxGRmzRyPPWkCg5r+qao
X-Gm-Gg: AeBDieuLgwMiw7qxENtlTYuyrTENfmqUMgnuNt8D1aCTXnhJzZOLTTNvOL9jGBfwtu9
	XtAzvM9dLvOUYntOan7tdxk3k6IZyXIfnYP2S6LS6xJl0qZ1lmlW6AQRhNFL53z+VPk5opSf4ZY
	XnmugAdF7U2dXU//QHueFxXG6SG33bCLh4pV1FlTQoPiVOxpTivcUrGf9l1omFcRZ6sXS8q2H3u
	Ps6IeG0+JjQ0PgVigwF1CFQtJ8Mri9N9k4pG11t2TFQk7ImNzkFYJ9XudmXdo9exfgy61O+ZlvW
	TZIZCgOw/9Ca0Ysma3Izy0CARJRgkDUckMwKTzPK4ZynsFRfiwCzk/IIEjCT1f0oCfMgkM1RaoY
	dLlEtITPNoLhO1z8K77cxBH1T4rFTbVWuJk1yZO86upzPOemjeC7DSrdPo8PHGKRQ/nqeRkjGBH
	n/nVrwqGyiPjXdWR6T+1+pMrMhdiZeDIyOGcsMCOUb104myKS0TbOn/gLUGglzo+OYkHNsT//X
X-Received: by 2002:a05:6a00:3a15:b0:82f:761:2b49 with SMTP id d2e1a72fcca58-8352d2b0b51mr9887750b3a.49.1777923466340;
        Mon, 04 May 2026 12:37:46 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8392aeed4e2sm88980b3a.15.2026.05.04.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:37:45 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>,
	Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH net] i2c: sun6i-p2wi: fix of_node reference leak in probe
Date: Tue,  5 May 2026 01:06:59 +0530
Message-Id: <20260504193659.3515669-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BD1AB4C34DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-284031-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org,cambiumnetworks.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cambiumnetworks.com:mid,cambiumnetworks.com:email]

of_get_next_available_child() returns a device_node pointer with an
incremented reference count.  The reference taken in p2wi_probe() for
the optional child node was dropped on neither the early return when
the "reg" property is missing/invalid nor on the success path, so a
reference is leaked once on every successful probe and twice on every
failed one.

Use the scoped __free(device_node) cleanup helper at the point of
acquisition so the reference is dropped automatically on every exit
path.

Suggested-by: Felix Gu <ustc.gu@gmail.com>
Link: https://lore.kernel.org/linux-i2c/20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com/
Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")

Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index fb5280b8cf7f..652b37b57159 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -184,7 +184,6 @@ static int p2wi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *childnp;
 	unsigned long parent_clk_freq;
 	u32 clk_freq = I2C_MAX_STANDARD_MODE_FREQ;
 	struct p2wi *p2wi;
@@ -223,7 +222,8 @@ static int p2wi_probe(struct platform_device *pdev)
 	 * In this case the target_addr is set to -1 and won't be checked when
 	 * launching a P2WI transfer.
 	 */
-	childnp = of_get_next_available_child(np, NULL);
+	struct device_node *childnp __free(device_node) =
+		of_get_next_available_child(np, NULL);
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
 		if (ret) {
-- 
2.25.1


