Return-Path: <netdev+bounces-306753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RBJSH2HtUWpMKgMAu9opvQ
	(envelope-from <netdev+bounces-306753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:14:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C47740B52
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=zZjQOj4+;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306753-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306753-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EF483045E0F
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 07:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120337A833;
	Sat, 11 Jul 2026 07:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D14377566
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 07:13:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783754026; cv=none; b=RrTAhKIVznnvtIP/eFxxXfhzhK2SBrzI2hkEzLZXS9jvSrb8kjYllCNUNWQcKrItuOqkfHgNgbCwi5HnhhC/25Kxi/e8HD16I21oY8SmtQ/MGGMB2Ianbjy1FxDMeeJuDVZDRWYMLRQGE8X0mk7RLcHQcgIR2znoHE5opJGhv88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783754026; c=relaxed/simple;
	bh=+/tkY4Q2PIoNmSY1FcLszemDBSTTa8pciPDIAh6Unuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q98djQGjBjt02iR3k10RPih0JhFAoCPb66aVS2ECahb26Jeghc2Im8AlJBKOXmWedwJJsDtB9BvsivE7Hg6HG2Zcz0eGm27jHp3oZBkkRApvU4C4SvcKiNfiX3cFU4all4v4SsZsnGNycbVSpnHwBJA6B7oZdVARLXaDvreHA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=zZjQOj4+; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4759b4f0897so893932f8f.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783754022; x=1784358822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dEi1m+eaAK5Iu/90PGDOyH4Bqqrw8wWIiPdDe9qpKnE=;
        b=zZjQOj4+N+RwhF0Ipc/kaaFTRi7StYKtnHdJCdkr4ph+4ukZdRREQRCBZOtS+d78ha
         FLmcKcv/gtsxk6vt4Hl2J5DK7mxymy4XDHvcZ1bSv3tUZ9XQ7mhTtLRP7RwzEWsXINo4
         176V/NzegZdQkRZTvYJLjEZDr9EBtFYMYtTg03xoc3KZWq4zAnNK/telHlXCRh9O6QWC
         pCRoEaB/UyRjqiOszlSz/6r2qYUq2BXp2442N6CxP+Ggbks1TjVntRAtsMkjr3JG33Ur
         ZqDIp7/H9P3jWyFGwYjXtNpEd0UzrVhd0QcAI8h5fU15y2uWADj48x0AI+fnA2oluDEQ
         WAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783754022; x=1784358822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dEi1m+eaAK5Iu/90PGDOyH4Bqqrw8wWIiPdDe9qpKnE=;
        b=jhMnzGbRWFNgTbNir9YU4JxXijujvQQJyqz0qOZcKBR+rDGpF4GXBTi8lK4W74UnIk
         MfmvC9D//DpkRLMIR9ybySfBsi4PInrpjbLfAt53C9hMyktz7sh04qdAbrmQ0BkDx8Zg
         4jB2/TtDmmPJBmeY49X0y3v8/lAwJByfXY8eoJNucCkbn8VR7rBSk5pfCPtRgDh71suD
         eucFbDngOn+x/RrTx6ZJKqW2AS3BkLAS3eAJJrc22HkofGJ0pBv+c4bkHKz0Z68qzPTG
         vI66xodH+EBF9VVpZcNs2/sYkuOcct9dsPl+7mhFSsSx1s5rIvmMCJ2bAe3s+YEo6VpN
         lWMw==
X-Forwarded-Encrypted: i=1; AHgh+RqLPnzPwu4vYZrzb6EAdoj2WLyCvi0FM6f8ceZzdcMf76zfc5hexjUo5zqhPtTEveTHZKM8EI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZZs76vGTO2ZFxVVpWGcznfjJVucbBGWUXl8KKPzwYerWDLco
	qowOdX+o7tx2wZ8zP/7PqXJRIL3QbWwllRkbRDZGmRe+yslZz2Bz2ybx8aPpnzOpRvrE
X-Gm-Gg: AfdE7cn/gKUMPYTNLrv7BKddTwlEj1a6FE60w7r8AK6xA+1O8eivrPu9rUrOq1UV85C
	LCM6HEM54sSFR1+TKr8YdNqZAftJvk6VWK0vgRQuVlb98k6DX0eKKCrHXTG/oFSnw6y8pSpjKuc
	s6yURVLdWHFXgur3CKag2eznvo92R/fO0UWQTI1yYwrW+4DM97ZpHWegIqcCucxeRTH4aI9Buoy
	18R9poH1ZvikT6KLFTnIfrsQddnVOTZ2V48atbKDNsnZCTh/2D9eDK0WC6uremG4j0l7/E/2WHV
	GKSmBa7Tp7uZKufkjlWYEuKUbcmDinctkDsuYn9xQp2lLIJyqDIjhSUP/VA0xyTo8N3JqP131J6
	2zg0oCwhbsSDoI3gtXN2ZBZ2MSXb5ImRpz3vjjGO8Iy9HotqDg+Roo+tqVGOkQVNN3UwBlXotze
	+DfLURcjK9rcjYeG6WH7NQoynaxbuPaGE8c7HLfiger81XL61FoIYjUyXrhVoJgs9qJ2+uA9iTj
	8JleG20Mep2qtMVPTh6H4spXn2aLf0ZltI=
X-Received: by 2002:a05:600c:5395:b0:493:df5d:6ca6 with SMTP id 5b1f17b1804b1-493f881de70mr14942685e9.25.1783754021017;
        Sat, 11 Jul 2026 00:13:41 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742a49sm185161215e9.12.2026.07.11.00.13.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 00:13:40 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>
Cc: Liu Haijun <haijun.liu@mediatek.com>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: wwan: t7xx: validate control-message data_length against the skb
Date: Sat, 11 Jul 2026 09:13:38 +0200
Message-ID: <20260711071338.58345-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306753-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,oss.qualcomm.com,gmail.com,sipsolutions.net,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:chandrashekar.devegowda@intel.com,m:ricardo.martinez@linux.intel.com,m:haijun.liu@mediatek.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	DKIM_TRACE(0.00)[0sec.ai:-];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:from_mime,0sec.ai:url,0sec.ai:mid,0sec.ai:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0C47740B52

control_msg_handler() handles a CTL_ID_HS2_MSG control message by pulling
the ctrl_msg_header and passing the modem-supplied data_length as the
length of the handshake-2 payload to t7xx_fsm_append_event():

	ret = t7xx_fsm_append_event(ctl, event, skb->data,
				    le32_to_cpu(ctrl_msg_h->data_length));

data_length is a device-controlled __le32 that is never bounded against
the actual received payload (skb->len after the pull).
t7xx_fsm_append_event() then does memcpy(event->data, data, length) with
skb->data as the source, so a data_length larger than the payload reads
out of bounds past the control skb (the destination is sized to length,
so only the source over-reads). A compromised or malfunctioning modem can
trigger it during the bring-up handshake; both the modem and AP control
ports reach the same call site.

Reject a data_length that exceeds the received payload.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing bound is evident from source. Compile-tested.

Fixes: da45d2566a1d ("net: wwan: t7xx: Add control port")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
index f869e4ed9ee9..871ed63d3c4d 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
@@ -186,10 +186,15 @@ static int control_msg_handler(struct t7xx_port *port, struct sk_buff *skb)
 			int event = port_conf->rx_ch == PORT_CH_CONTROL_RX ?
 				    FSM_EVENT_MD_HS2 : FSM_EVENT_AP_HS2;
 
-			ret = t7xx_fsm_append_event(ctl, event, skb->data,
-						    le32_to_cpu(ctrl_msg_h->data_length));
-			if (ret)
-				dev_err(port->dev, "Failed to append Handshake 2 event");
+			if (le32_to_cpu(ctrl_msg_h->data_length) > skb->len) {
+				dev_err(port->dev, "Invalid Handshake 2 data length\n");
+				ret = -EINVAL;
+			} else {
+				ret = t7xx_fsm_append_event(ctl, event, skb->data,
+							    le32_to_cpu(ctrl_msg_h->data_length));
+				if (ret)
+					dev_err(port->dev, "Failed to append Handshake 2 event");
+			}
 		}
 
 		dev_kfree_skb_any(skb);
-- 
2.43.0


