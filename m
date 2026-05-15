Return-Path: <netdev+bounces-288191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FrUOGS8BmpAnQIAu9opvQ
	(envelope-from <netdev+bounces-288191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:25:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BB1549F84
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E47AE3016261
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 06:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267D36F90E;
	Fri, 15 May 2026 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ49ZISy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E7379C31
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826331; cv=none; b=kVmsutJRJ2bTOwvTVd+8W0P38IdghoXH6rva+psWP+ayx4pRkwtDI1cfZdLenr0YQwQevacfv09iWrf2gOaFCxx6jJ2E7KkrWxwkw5/kllucbYhbkxLAPfDbv7GOk0kG1cJ2pr95yufnIOkiLaC8VKMbBiGk5OFIEru0BgkNNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826331; c=relaxed/simple;
	bh=zdMaYaIF/WCaUO1A22gCU0P+PgdUjBhJZEz17jz2Bt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOQYCKOVvw8FvztAY+7xoPqYHUrJg8E8wqL7McDKee6JDggsBn7pjPubT2rNczdS2CxyrmNQd+WvwEBErdBcoN+/7GR9EXfd5bMGS6Xsc/pssrVSObwqbgCjY6Y24Uh0BqCVz9V4h50tyV9XPwc3gh21ncNO66I+R3s0dfIAleM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ49ZISy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so76477495e9.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 23:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778826328; x=1779431128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1gkR6dt+RMCWBmuIuEthasGqBXKYWjHEwzJZ2BcFqc=;
        b=gQ49ZISyin+W8yjszGpFSi7ZaUKdSAvM0tNvvdRwICjjvTSEFZTSWMUMuaG50FB22o
         lXpzYamlmkvSZjUSaESGg7LswCiqg5VtdQHB1rcLNZ/SYniUmSVlK0XY4PnzIzcUjZO1
         z0v/KYppWaGYUsTGsmLQBpNQpGfjT/NrKwgHPXzoIVijd/vrEomX1vc9FeQBbjywU/76
         VdgaQHICSOUuDPEwcs+YMp7JWS2fENdnum+FdoVuVVg9KWwMlKPY7rj2EXNNkjoscXUf
         wVtxDViEx1yiP93S1OAPGAoUdU2xdPFkmP42ft8MROjzL7DsXY6rQ4LVJLdprtOc0Bjv
         GQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778826328; x=1779431128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1gkR6dt+RMCWBmuIuEthasGqBXKYWjHEwzJZ2BcFqc=;
        b=YSijGxL77Qp9DswPOW0rGDt65FpNkwx6jo8SlnoFWSKtcWTFum8m28wpGwKbamx65V
         k4aGaf8+vOBBzLWxxYsw09BOgUTPl4iPgmpEUF71RYftB2NgrvGJLCEk6jsu9Di/xfwI
         W4mDnBHOeBmDao0/ttfOfLWIgamF1iWMd+9CfseVo+c9MzFnBro8k8Mnm2tqJPKv+MvB
         XWBGAY+0es0AIZgC10FXJfWNyX1oFX30/4UJbULjPG+jYsGahbKC9FQlfEQHYcsoW9xl
         Nk8WyzYCDfVQPgeTrTdDSTwnGUEU0IgnGGitd8Gq7y7uPetUqy1qb00ol3h4QCP09CSY
         sung==
X-Gm-Message-State: AOJu0Yyd+MoUGhphvaIfHsTF/tDcHYxW+zsxqLvERlQ68YcYT2Omj7uN
	14/ejtxw34yhdRMLN0+zsxT8xeLilqpPwREcnalwdLAL46jPOop4Z/eM9hyERsO5
X-Gm-Gg: Acq92OEFFEZqPBqjV2zViu2uQ6wcFN1NqjtLh9wE5QZbkIRK+cVthXClhBLosOwUUGr
	6SxZ8qGwr0M8mx6p82zu+1RUMxL8tl9HSpWiGQ5rTAVBbmcxiuh0yx9HTOCTBzQWGYvdnUxWrVR
	pa5KjLPyzlbfsvMxfuIDVyXzyYDCPEIswAlYka0awgTDoIOkx2yByKbPangaGi5SzWJXO2FlDcl
	o8+lAuMWKT11+pPYWjcXIWVTwlEJRQ2trMoPcf/lUwDSYiJXnKQavwqKrU7izD8OUjZ1ttgw0tq
	M7tzVLdeTw8nLk70cF6QeIcE7+3A2BE+U4tXVsVovX9UQEbJvR6CcqgM61xO2tj2W6P2mgk+Dd0
	0qjgxL09hbcRadF12qCtThT2hJZ+V8gbiwksgl3uup9K9+EaW7ueZaiynGy5gElpDMz29MthfGu
	lO7mtHgs35GDLuV4Anw/fZYWCCzDU7b6Tw6aJNnQ1hBKmGg2r4ohoNf+sQRl7M+fshfuQLfyO8T
	55H8PMsIjilGhL/VUc47g==
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr29688155e9.10.1778826328398;
        Thu, 14 May 2026 23:25:28 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm11016277f8f.24.2026.05.14.23.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:25:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] Bluetooth: ISO: drop ISO_END frames received without prior ISO_START
Date: Fri, 15 May 2026 07:25:25 +0100
Message-ID: <20260515062525.57603-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62BB1549F84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,holtmann.org];
	TAGGED_FROM(0.00)[bounces-288191-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ISO data PDUs carry a packet-boundary flag indicating START, CONT, END
or SINGLE. The ISO_CONT branch of iso_recv() guards against a missing
ISO_START by checking conn->rx_len before touching conn->rx_skb, but
ISO_END does not.

If a peer sends an ISO_END as the first packet on a fresh ISO
connection, conn->rx_skb is still NULL and conn->rx_len is zero, so
skb_put(conn->rx_skb, ...) dereferences NULL and oopses. For BIS,
where receivers sync to a broadcaster without pairing, any broadcaster
on the air can trigger this.

Mirror the ISO_CONT check at the top of ISO_END so a stray end fragment
is logged and dropped instead of crashing the host.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/bluetooth/iso.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 7cb2864fe872..b971281f0a2b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2593,6 +2593,11 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.53.0


