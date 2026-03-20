Return-Path: <netdev+bounces-269875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADCKOwEdvWnG6QIAu9opvQ
	(envelope-from <netdev+bounces-269875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:10:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA192D8815
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE31F3209190
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15238A72C;
	Fri, 20 Mar 2026 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fIESjr/6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D7437F757
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001095; cv=none; b=gi765jNHbajQ1UmRsbK6oN+dmfTD70WboVRuqhwwFFk9/Ga3hejQ/UZrE6Ue9g5s4ebmBRjxHk03i6wKFTjYZtkMbDymfpeaVe6qbQfaJ9X2vnDLuQkRaBuU2nyIOpfCDxmvcfe1ExydydEI8t//YQhfbAl1KaD+FveUUUxWQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001095; c=relaxed/simple;
	bh=kszGZnIHjkAHezKG2UN+Wqh+hJaQGHJYw11y6nXVb+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVIQ3/zjk1r9vCgft6MDHwEG2R0WB+PCIR6kIHTSpH2QIbJCprqRYAGoPXPXxblTUV7GGrK1kozxicuHR3eD1sfqz75mEA4+/5XHUXeoMuzXw9x49fQQrXwP/m5xJAUB0pqWeUBBCH3pKo3U8CDY8XsJxO0tcIEGYOrARYUGIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fIESjr/6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b9675d36so13179405e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1774001092; x=1774605892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBFz609qSIaLc+ORm14FBBwKrkET7NQmJpfgLi+jBGU=;
        b=fIESjr/6tmAd/6a4rJR+F/bWohSmy7+gS2RZe+7JHLHBkCVzH/XEbUYSCmhh1yV9uf
         a8QQCpkZ9ir4jriKMz6yE7oPeKZtmjKzp6McPb6Gd9aDPjLUSrDc9vnhGQ3ZokgE4H37
         7QARNTNTiMRYYeXpIFNsFwQyIN+V1abrQB4gv0AzJey2il2Yjy2OZ8xprYQsJWB79XFl
         TU5af3yuaKd4Q5hzo7v0gLkPf7zX3fMha2QZJtjWESxF6OphJ94mycLahwcY/fHw2yMY
         hqIcAvudv+f6WmGrwYOibfjvrTwPuXw/0NEQxYQMunN+N0uw7ER0MVXR7uZug7YledKf
         2Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001092; x=1774605892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBFz609qSIaLc+ORm14FBBwKrkET7NQmJpfgLi+jBGU=;
        b=Lyr0ytRsYKe+QwwiEN3DfFhMoA2PE2jOXpiG9jB/Op3hCYn2adD7Da1MwQsDRkNhoR
         vlbAuMK5GqvdUh4qSsZN27O3uNuCFNYILS1IbUyhPD80aviN1EQ+bn/jBs9rC/2mk3b/
         sKaur3dF74KF9Sz1diPSbNTtnD+Wpt8H+3tRd1df1CYX0tvF3BFI7xNwVwJ+CDkf9/2M
         7Gff4+ic+l5wgk45OTPW5e31ME8iezo6c7AeUQPpAZ6HJfapz/Igr0dSt034Ld57dDbH
         zcE5MVkvpXQEl9Ipq4uhRPyng6KpEE4ggmDKwh9Wf0pYxWN/07ieABipr5OMCpliz8wq
         NlEg==
X-Gm-Message-State: AOJu0YwT9RRjQlQydeXqU8QDJ08p2Ejmc5IbUusyBeOqeHtHD90AKecU
	rlPXJ6zrC2BZpkmVAhkDYGqKkpEHbK59EUEQxmumLnlMg9MpLpb8S4xHaRFMXul4k/l/Dvj2+fs
	YB/rctpPsWJtsYpW0dm6uLyzMeX1kzclgl63/z2bs9Fz1jgQWa9/jKHsBjzQK2p0v
X-Gm-Gg: ATEYQzzNZH3ESML7quQKMcpM2PqvteT1c6Nyq8zD9T74MyXQ8Bko3vYgn9ju03yHWS6
	2DcXNHYbhXyVP1Qwi0jaBC1IL/6x0Hfj8MMxNldhknEyZrMCEA6vpaFwRMwDkuxmoc2RHhP3xxp
	sClT+TmcDwIP1MWkklLKhjjirgfBqTOwNS8eu5+XOoFmArj1X25CoWbAQNy4qhEuc9M6vOuHhNx
	kthZnrkyFbZ169Xnf0Ou+u56P5HGFCIzowB2zGowVFxEWNeXypk/Kr5J6gEhlEZPd2lTGmf6eCD
	watUr4YuF21/k2zp29HE4r0rhHh9YwK9QZJlpiotPT+/6UY8iRGrQ3DaxPY2QZmuJjBDgat2J+U
	BotwOhCl3ITz73eFOrMyO4qCDIwtFDo/md67Zwbq/Jq9CHFUVw51qUMFVGe+/eCyVF17F4q3DVA
	XS0LUBz51KsBsvcKxACHT5phFprwBGpEMpBk+k
X-Received: by 2002:a05:600c:3d97:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-486febb5989mr35615245e9.4.1774001091726;
        Fri, 20 Mar 2026 03:04:51 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:b932:6bec:9a0f:55df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff109b95sm30283915e9.1.2026.03.20.03.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 03:04:51 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 1/1] ovpn: fix race between deleting interface and adding new peer
Date: Fri, 20 Mar 2026 11:03:51 +0100
Message-ID: <20260320100351.2283994-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320100351.2283994-1-antonio@openvpn.net>
References: <20260320100351.2283994-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,openvpn.net,queasysnail.net,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269875-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.941];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,queasysnail.net:email]
X-Rspamd-Queue-Id: 5EA192D8815
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While deleting an existing ovpn interface, there is a very
narrow window where adding a new peer via netlink may cause
the netdevice to hang and prevent its unregistration.

It may happen during ovpn_dellink(), when all existing peers are
freed and the device is queued for deregistration, but a
CMD_PEER_NEW message comes in adding a new peer that takes again
a reference to the netdev.

At this point there is no way to release the device because we are
under the assumption that all peers were already released.

Fix the race condition by releasing all peers in ndo_uninit(),
when the netdevice has already been removed from the netdev
list and thus an incoming CMD_PEER_NEW cannot have any effect
anymore.

At this point ovpn_dellink() becomes empty and can just be
removed.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/netdev/aaVgJ16edTfQkYbx@v4bel/
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Fixes: 80747caef33d ("ovpn: introduce the ovpn_peer object")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..0eab305780c7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -92,6 +92,8 @@ static void ovpn_net_uninit(struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 
+	cancel_delayed_work_sync(&ovpn->keepalive_work);
+	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
 	gro_cells_destroy(&ovpn->gro_cells);
 }
 
@@ -208,15 +210,6 @@ static int ovpn_newlink(struct net_device *dev,
 	return register_netdevice(dev);
 }
 
-static void ovpn_dellink(struct net_device *dev, struct list_head *head)
-{
-	struct ovpn_priv *ovpn = netdev_priv(dev);
-
-	cancel_delayed_work_sync(&ovpn->keepalive_work);
-	ovpn_peers_free(ovpn, NULL, OVPN_DEL_PEER_REASON_TEARDOWN);
-	unregister_netdevice_queue(dev, head);
-}
-
 static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
@@ -235,7 +228,6 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.policy = ovpn_policy,
 	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
-	.dellink = ovpn_dellink,
 	.fill_info = ovpn_fill_info,
 };
 
-- 
2.52.0


