Return-Path: <netdev+bounces-258720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKOaNryukGnacAEAu9opvQ
	(envelope-from <netdev+bounces-258720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 18:19:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876213C972
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 18:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 230C03011A5D
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C353285C8E;
	Sat, 14 Feb 2026 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7tBfm1v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5842F0C74
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771089594; cv=none; b=Za0Prn1TsLTD0Op4c1/xq5DbXqxR3Ym11Ruoa2fhK9xPXI2q9+FCRKj0LgPutxqFb+kplE2LjwKDhIBEvmRf8MbTjqHI0Z8JEpBPnZ274BdnhL98YBQB2YLXloTyXj0yU/BnOrOZwDDYTUdfjDDarQ75W0eENLphvCcODR2J6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771089594; c=relaxed/simple;
	bh=f1rti9oeH7A6CzK1t+w7fJBpf/AnV39jCnE+N+mIK6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DY6Iz3xhJfb4C7XjIUM1BLbrfay7Z1dpC/npISk1E/MzIIpndQ23fBC1qMZOBIeGZCTys8LdEeeQFXqAiSDig5KlLv8LOq5qPU2g23OVIWcD5qSopYuaWDL37Ebqd0QFTs3+RuSPjqntUgs4qdfkn4U56Y6eEJIlerECEoI01iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7tBfm1v; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45effa36208so1374116b6e.1
        for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771089592; x=1771694392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deQy1Gi8bD3NohJGM3hXhCAHB18lIGL5Lign1o6SSv8=;
        b=d7tBfm1v6xftvuMKAyYKcDKB/dq5dIR089aTrTsfwa+oPf558V+O068Ie8MC/aIzCv
         h/RH1qLrbkeFELsTfBcFDonyeCMkmjYjdNCFA3ZEXM2rc81BfgnOiwEEpbR0z59QEbBr
         hSapsiFwNvxOyPI+GjO4/ymkuSr+a9eRSbw2UOaWpmvlAuJrzxnTVW3DGukn8C1MyIGC
         vPGveVeAR8r5FDIqMf+wQv3xXaQRRsy4T6L8weYbEXAUwx+pqiXkXg59Ol3WCSq//zsG
         njVDMBGzpJVxiMrrcLm89GaPoKp0wclNSsQT34kffYave9Co6EQPW3ECISfo5t8dbT0n
         V1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771089592; x=1771694392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deQy1Gi8bD3NohJGM3hXhCAHB18lIGL5Lign1o6SSv8=;
        b=b+vBDGzEY3wdZHIpaUdpcpWzVsG7xUd/KwRqkOP64MV7CqviOcI4tM2Bt1v65Kc+qt
         nwek0MYnNVN1nU0ZM6QY/lEVn6Xc2SoNA31nqe9GMq5/rre2oSfvk5RAL12dJ4dWTwe5
         Ytm7SPnQnbuLV+gewYyb/NsFZAcZaZP/FKSwuPUJj7D+n4PAOUfBZCZ+vajcRPTAhCdf
         YTI1Jd9yW0PH/BHojc2GMgEmx1uQ54yOL1Ict6vJ6z+okekVBmdrr6RdyQeZwFcZz4a1
         5QPlRjTFtBURLAP4khJMRfvumSYAel5iWxccCLN/yLL42zV64tY4+UyYh5ZQk75D/Ll+
         gOtw==
X-Forwarded-Encrypted: i=1; AJvYcCXMKIcjZLITng7EOCfSaM1kU19j6L/k/DYveOSGqCArtZcii/vRp2zSrKWOye3L9hy84Ny2Q2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbETvevT8Idf8IKm6+ZdaBZZ634sS+pU1KXCwE3z3L20CRQkhT
	MKef0f3lGeifVFb2uPZbgCq04qDCoDyHz69NkqT6CetXu05IZJrxThdw
X-Gm-Gg: AZuq6aKW6AV+pm39XlORxs6WFj4wXPD9brhr71sC7llMYLAX6dd0j0/UzfA7c6usJzu
	bzpjE8IqbBE9WdqsFXaDaNnvx9WyS5ZDmu4cAgmREO5Ll1SQdEnycYIrlGtwKODUIF0DbinFKN1
	zwX0pZszl5QU4ZMv17KRJjUvT817cFkIcB/ofS6uftF/NOcH+2/YgSbiKZIq4kSUt8W0b8IeXc0
	jbVzRi+9ZmhCcUisyi1ncqrYjzDp8a9HKU49ofXKIyB6xP+PYG80TlUJF/BPc/C5W207iObaijw
	ydOeEfWQnBiBx0IPOivvEOlG5PxANIsfN1//mvR9z1jp+m+CW5ASbYlcVt728YNVxa0+ihVbgui
	EMLJz/1emIcTgxrCbDhZeNQL/MdyqmLsr7Lxp0i/0VMoCzugwLECXKXWBW26IOMXOHn0wyWZInr
	63d0f4tCt2Rrk+206+00wHJwxJDWKbrQ==
X-Received: by 2002:a05:6808:5087:b0:450:41ca:6bd8 with SMTP id 5614622812f47-4639f08bb97mr3037172b6e.25.1771089592019;
        Sat, 14 Feb 2026 09:19:52 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-463be5433ebsm1009337b6e.17.2026.02.14.09.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 09:19:51 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] eth: fbnic: Add validation for MTU changes
Date: Sat, 14 Feb 2026 09:19:49 -0800
Message-ID: <20260214171949.772493-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258720-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,google.com,redhat.com,lunn.ch,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5876213C972
X-Rspamd-Action: no action

Increasing the MTU beyond the HDS threshold causes the hardware to
fragment packets across multiple buffers. If a single-buffer XDP program
is attached, the driver will drop all multi-frag frames. While we can't
prevent a remote sender from sending non-TCP packets larger than the MTU,
this will prevent users from inadvertently breaking new TCP streams.

Traditionally, drivers supported XDP with MTU less than 4Kb
(packet per page). Fbnic currently prevents attaching XDP when MTU is too high.
But it does not prevent increasing MTU after XDP is attached.

Fixes: 1b0a3950dbd4 ("eth: fbnic: Add XDP pass, drop, abort support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index 81c9d5c9a4b2..e3ca5fcfabef 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -262,6 +262,23 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
 	return 0;
 }
 
+static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct fbnic_net *fbn = netdev_priv(dev);
+
+	if (fbnic_check_split_frames(fbn->xdp_prog, new_mtu, fbn->hds_thresh)) {
+		dev_err(&dev->dev,
+			"MTU %d is larger than HDS threshold %d in XDP mode\n",
+			new_mtu, fbn->hds_thresh);
+
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(dev->mtu, new_mtu);
+
+	return 0;
+}
+
 void fbnic_clear_rx_mode(struct fbnic_dev *fbd)
 {
 	struct net_device *netdev = fbd->netdev;
@@ -533,6 +550,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_start_xmit		= fbnic_xmit_frame,
 	.ndo_features_check	= fbnic_features_check,
 	.ndo_set_mac_address	= fbnic_set_mac,
+	.ndo_change_mtu		= fbnic_change_mtu,
 	.ndo_set_rx_mode	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
 	.ndo_bpf		= fbnic_bpf,
-- 
2.47.3


