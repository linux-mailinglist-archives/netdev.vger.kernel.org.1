Return-Path: <netdev+bounces-253119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLm+NmhgdWkAEwEAu9opvQ
	(envelope-from <netdev+bounces-253119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:14:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D0F7F548
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 01:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4742C3019F24
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C72DF59;
	Sun, 25 Jan 2026 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U13tpxLj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C764C81
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769300045; cv=none; b=NliWNdqorCzD9tVyHoxAg6eVTEXmiGirUs5lm53n69AjZVhqAPEqDAMqHdnlVZFdlieKOPoDfT5z5P2Mwj8V9ngJBL636U7SQ1rweFQXjoXeBTtiPj1onhRHXkRkzcvI/sdUeSr3ZTwbw6B4NTatXUjIsWp/9E8DJL3Yp4D6Khs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769300045; c=relaxed/simple;
	bh=qLMIT8Ws33pYlSoHCrt/RVncgm7aYhmOwxAU9uVlwHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlpNwrFyCc1zj+30WJCClo9hDrkER7mq7o0ur+L5zQUv4q+FM2YbRXyk/pMWywFAnD1oUDlcfQDIw4wZ7qwgiam+NQkwM2wI/Qu+fWTeIsrnZzQ3OYW+FJJP851E5BDOygtWd/Nni8LpXDnTgrVInLckX+OAXRDNt1oghWOuuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U13tpxLj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so1736239b3a.3
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 16:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769300043; x=1769904843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7W4ETZqG8skHoTE538RFRAe6Lb7JM/auRjP6xeCdlU=;
        b=U13tpxLjjH0gBuuCXb+/dYjFOp1jezlCP+wiKjMwiOBog6HcAlMpEFkbQ/wWFnhDQy
         q8dY9J5yZSvdtvwjatM7vEGqSsFIMfTeZHEftNOwot6xYcvE5wrn9XXarStNA1315zc1
         4zUo5TrhS0fEabLXQrM3Bfxd0ykTBwkPxkBQbmDRHHnSQ9Gmh2QXmz0EKkfdRROM3g+X
         jkWfcsICJLBWVi3e6uXekxKftaKEGc/gRY2nwjX63z6oRCm/VDNH2tt9U2PkL9u2miMO
         9AFmwlKSQWOGRWAFPn5/MGCG9m97ZqE021nplXE1fQC7XIeLJEel0Qf1rqyjmsXHV7dz
         PXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769300043; x=1769904843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7W4ETZqG8skHoTE538RFRAe6Lb7JM/auRjP6xeCdlU=;
        b=hXpycHJubK9h95eSE23hCocM6BWvRI6IRl3ySqplto07to5b/5zqf7sTYvzbSc7srm
         b44JB/m28Ff+TNo4tI8e8CpxjLnZ+lP7OOZtFDds4oFl5s/gySl6M/mT1PeeHfZycT/f
         W9lBXWl46QgTGOO+2PLFWzwBfqGa/vcRcox49A/TBSM1DgDlkfuQdUaavwVAhR2gXPOe
         E2fdf6TKFBzuqBgwc/QwPV02O23Ey+aZL+IKjfNJeTRj4rJU0oiIogf6mKjWMNksVXBW
         fWGLcDiVRi77//ZgHdXGeTlS3uvs/sRWBNrcNctmyxJ7Dfvwvysz584VGuDXPQc1SLDW
         bcgg==
X-Gm-Message-State: AOJu0YzbNB12u7YKZup9EZx2f6h37BQPv2dD2ekr1Smb90oXxQVn3cgq
	6GLLvRkZcgK5GD6+/K0841NjqHsI8FBYQ2aB/r5zA+xb8OWrpSKE1CAA96WxHg==
X-Gm-Gg: AZuq6aLAm/NTN379l4W0+5yGtnj91SF+1wlf/ajJQdqS3RGMt221DpCzuxeTg0CoyjB
	zWw1a6mEPCMo8oe/vpkY/h7aylhwXJQz2j+aQupf4Yj7ZnkT5YOI5PbEOSEig5IfWDkft3ri6YK
	/trnPXb5Tx4IbSDDZeU0XbaOR5hGHn677DG/0imr/kBYhB3tBHdGqgkLhCFGwbmCLYzhl8t/T7E
	u5oG4fAMCbwb00fabqINDC54asCcAEQGh0HhOt0onfa/FrUtDTxRB6+KK1oW5J6S3Z7DyszQkDC
	YGQQp55NACGmit2P1MhdgQ1z82IUznjMltnCsTOeQWXjEwABKUv3yRMjHdo7d9ktmCC+ykqumAx
	SRqRiCExwtkRJrqIhv7njFnAC2F0H1SBjkjbn+drSfTV19ujEpvFRHiF34FkBZb9jkSzjxGGAqW
	TYpNamJc/lSkxLKT6oMeCjygjQ1mUyxMwPwUpDU0n5z4a5M9YEjgcrvw==
X-Received: by 2002:a05:6a00:b51:b0:81f:852b:a93a with SMTP id d2e1a72fcca58-8234119f794mr208832b3a.2.1769300042849;
        Sat, 24 Jan 2026 16:14:02 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873ec59sm5683488b3a.53.2026.01.24.16.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 16:14:02 -0800 (PST)
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
Subject: [PATCH net-next v3 1/3] net: dsa: tag_yt921x: fix priority support
Date: Sun, 25 Jan 2026 08:13:22 +0800
Message-ID: <20260125001328.3784006-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125001328.3784006-1-mmyangfl@gmail.com>
References: <20260125001328.3784006-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253119-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49D0F7F548
X-Rspamd-Action: no action

The packet priority is embedded in the rx tag. It defaults to 0, but
adding DCB support to the switch driver will break the tag driver by
setting it to non-zero.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 6bbfd42dc5df..b93715a057c7 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -17,7 +17,8 @@
  *   2: Rx Port
  *     15b: Rx Port Valid
  *     14b-11b: Rx Port
- *     10b-0b: Cmd?
+ *     10b-8b: Priority
+ *     7b-0b: Cmd
  *   2: Tx Port(s)
  *     15b: Tx Port(s) Valid
  *     10b-0b: Tx Port(s) Mask
@@ -33,7 +34,8 @@
 
 #define YT921X_TAG_PORT_EN		BIT(15)
 #define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
-#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
+#define YT921X_TAG_RX_PRIO_M		GENMASK(10, 8)
+#define YT921X_TAG_RX_CMD_M		GENMASK(7, 0)
 #define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
 #define  YT921X_TAG_RX_CMD_FORWARDED		0x80
 #define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
@@ -98,6 +100,8 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		return NULL;
 	}
 
+	skb->priority = FIELD_GET(YT921X_TAG_RX_PRIO_M, rx);
+
 	cmd = FIELD_GET(YT921X_TAG_RX_CMD_M, rx);
 	switch (cmd) {
 	case YT921X_TAG_RX_CMD_FORWARDED:
-- 
2.51.0


