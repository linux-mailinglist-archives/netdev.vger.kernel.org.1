Return-Path: <netdev+bounces-264866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH3vLeX3qmlxZAEAu9opvQ
	(envelope-from <netdev+bounces-264866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDDB2243C6
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45EB4304465A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B93B7B8B;
	Fri,  6 Mar 2026 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRBrHklH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31C13ECBE1
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812169; cv=none; b=uhD5tMXY6ZdvWDTNrCTwD5m5Bdv3YURdHW7X+bJF7JRU27qAwuvHBapF9QIyhEthPi2vFOm8N0tDhXkdJWqZAsgx3hFkpR8F6hyO0otMQ/3kaZ7nhR2TZzG1+KNaMPqd34I4jUamLTyEqBSRxgnlApN7r3yy5j0KsBR8iPpXYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812169; c=relaxed/simple;
	bh=3cpgGyRLj6sul9nzYAxLQTLt55Ny7PN6onFZ9bvvoZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Idn951ZvSbtrw+ZSzrghMZLto6ijNDnWqDKgoeDXUiszFAgmbWHjU8pvZSHuA8e58IdM353cxiJvyeVEg5KMPH1ocz2yMkArh++sBL7Wl7e0qV4uWOSkYlzMjgds4IGffke55AXCjiGK0dQ8laOe7IpidamA7BMb/ins1m0xl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRBrHklH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso4669223a91.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772812167; x=1773416967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UmJ4tUBHK8D2f6KPBQS77aZz4Lp3+MUVhaUhscsX3o=;
        b=HRBrHklH99MBWdkWOh6xCeOg9yP+G+K4mujvFTXYKTPKa4wz+9BNVYRzEu8YRgi1mU
         g0YegNHBLN8eLpgTIqe+W7EBw/TKdkHwWUsjwot+9xBxDUJx2q7NfKhRsX7eCgMUj6vK
         lKuURxI5rqP2KkwWLXKq7IZ0pnS3CCt5AsM1QYC+BO7SOxaPuQ4M8QfTXGGZ3UdkBTWZ
         JO+JJwRq3eMDfQKfwO7le+4MZMT5tKyR+zDH2Pm/FLwKfVYXtJ6pi4nAZ0yGxW2Fl9vv
         cjsi9ni1jB2tUc6GLX8/UlY47bi7WQSxRgljwa37ROwPN/YX8Al/x/8evDHwmBETDasr
         vk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812167; x=1773416967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UmJ4tUBHK8D2f6KPBQS77aZz4Lp3+MUVhaUhscsX3o=;
        b=XPqfFWnpTMMcbJbFSmHjmwlA3VEywSVt1369fnmtXAygiCyMOl0hCjBo+TDVe80lP2
         Q2PBsJhTF32QME1522tfLPmK5TeIsxMc4VogZawK4TscWYVG3ssLOLBkITu8ldgoQoY1
         fYNecye1lWJ60YPRpLM7Qwmfqx8pcy0eV4EL6dAKRIs5dN7edZ7Qb9Z+3ska/wQcsIve
         e4iqjE0Outlj5KroENl5KngtZ6ct+NgZukI9K1zxyC4sTH/QVas4C01H/TMBds+gsuz6
         RG2uGFFddx48xzoWkBi44kOimPHBueE9cwSarcyPa6+W1A3E5iqIy1B9LaJNb7R4zfS0
         utSA==
X-Gm-Message-State: AOJu0YzBEFkM/mHfAXZqRixhtWlkq9SF3Kt4paVesPT4XF3yxjOtozGn
	xe/u5Vo6bIdjmFPRNsQ5OeWjb5LgBpt9euw0gj1AkMe7t2cgKceaUQEQ5ZJT9tx5uWc=
X-Gm-Gg: ATEYQzxQ+os/epbv6BFQezrahuFtnxX7+nESzwdgl346uyGFm72lL/TkFF7Eb2Jqu3N
	XJY+b83QYD79PNJURyYYop4MvrdCzo4/VY3lMxy2ZdYMOavrzJ8fE1sTdoQlE7qbhZFcit973pn
	guRVdS5iGy2YCjjeN9O9Bxh4N6pl0/ibGLxkcVXd2V41pcI4uCpF+69IUdUGAa8DP4LU5/C3yUT
	NQjo7YdtbrFd6iv1TIAO4Tbow17afzgQSENGGE411O3RmbwD4j/CgN+cA8sNyBoZAMuUSZ2Nauv
	3yzJZswkukbe5zeGeze3Kl31HMCE27pikD74h2hey8Gy7SUQ60mb3kVFQ07A0niyf9LFt063YU9
	0Khm4h1FS3uZ8Y0WaqatcUPPILGhzPg5t9HLLTXjI9rzi8TO4iejTMruZZHl9RlGUagCoALfjJ4
	jAdx97U4LArPJWpfwUOyY9sTahknE8CO2L/pA+QQRd3lp3
X-Received: by 2002:a17:90b:2ccb:b0:355:35b0:8b83 with SMTP id 98e67ed59e1d1-359be38ffdemr2215431a91.33.1772812167105;
        Fri, 06 Mar 2026 07:49:27 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbaa5fa1sm1532769a91.0.2026.03.06.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 07:49:26 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] net: dsa: yt921x: Return early for failed MIB read
Date: Fri,  6 Mar 2026 23:46:26 +0800
Message-ID: <20260306154637.3126497-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306154637.3126497-1-mmyangfl@gmail.com>
References: <20260306154637.3126497-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7FDDB2243C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264866-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is a prerequisite for another patch, no behavior changes on the
success path. Though rx_frames and tx_frames will no longer be computed
using the partially-read MIB values if any read fails, we do not bother
with nonexistent consistency.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 98e8915dd6c2..a968a3fb56f8 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -711,6 +711,12 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		WRITE_ONCE(*valp, val);
 	}
 
+	if (res) {
+		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
+			port, res);
+		return res;
+	}
+
 	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
 			mib->rx_128_255byte + mib->rx_256_511byte +
 			mib->rx_512_1023byte + mib->rx_1024_1518byte +
@@ -720,10 +726,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			mib->tx_512_1023byte + mib->tx_1024_1518byte +
 			mib->tx_jumbo;
 
-	if (res)
-		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
-			port, res);
-	return res;
+	return 0;
 }
 
 static void yt921x_poll_mib(struct work_struct *work)
-- 
2.51.0


