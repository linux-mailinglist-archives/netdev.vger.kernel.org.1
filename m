Return-Path: <netdev+bounces-299477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rJB8LdIGMGoSMAUAu9opvQ
	(envelope-from <netdev+bounces-299477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:06:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BF0686ECE
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:06:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=xRXe2fo2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299477-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299477-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4B5030091F7
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEC3F6C59;
	Mon, 15 Jun 2026 14:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3413F54C8
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:05:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532340; cv=none; b=A0FNoyjbkVspPk2DZVRfmUOq7xYJtuyOi65AyXdSW5gM8lplq+UUbx3fEXGcXOIAo8dkljAem2yd/BY6GmdCnyHtKjWEivGlDusOBN1rZ+9dvKHPhtZDvSBsGffhaWRqRw8YVxujvxHoo7fa89ymjgjjzmibfBVww/sVLbw8LtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532340; c=relaxed/simple;
	bh=sti5Jiq+zf2c5nD7digmzH9DCz+UDe5i9vlPytyemk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qU64V8AANLuo5ZjRi41Qtz2qvokh7GYwL8vn9rW2EspdHvqWgeNISE+OEOrVfVUv6/VKWuWp1O/r/m3uPLFCv9I+BHiXtKtGIeNrGM1cpJd3HLoe/TFIzmOHMgnwxuK4PT0TFKq30hYZRlQnYDx0SoA1e1WAt4cQbIUPLVOU2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=xRXe2fo2; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so34342505e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781532338; x=1782137138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YyI4pG06qj9OsAcBatlXpkpRpnZN2jeAS5FUIDcJdlk=;
        b=xRXe2fo2lPX5GfdP30jcAqpG9U5tYLiZWHhG28/v0ees0KGqwoc/NrxkRzutkEdk4m
         JIt8UL0lA8X7vf4CUwL49LeZYYFH8WsXklNaCoMI59v8paODydb3+vJmZb8PaR5P1nSa
         u56rD78Sfdza+AXoXZogwBc3q7rS7Xa1Z5esH12vtujw+pw4jG6MtXaBEczAtRESukJx
         KLyC8sbbKj+EbAq1nmmUPmlRB/YyeSLQkjL/bJS/sw+qKIJxX/XJBc9dFrbWltrEANwj
         SnhZXXRTCRInkDLGb7Y7Twr2T2ZArZY1UzBLV+MAzybLzx2wR9jcLJ1a4gxMfNm+xUo5
         pdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532338; x=1782137138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyI4pG06qj9OsAcBatlXpkpRpnZN2jeAS5FUIDcJdlk=;
        b=eKlSKuNXRkXjRQSJsPRqPuXEmckwloLjymo+knPEplFkHMgt3Xk0lJ2cOpNWeEDbU9
         us6bOUUsDLCPoqegULUNv+TmRwt5WfcLJarZbseql8kSYoZaTupIjuu8O2oql4zZmvgz
         3lIX0slXBMVMt9E8H41XH9QWOHsjICb+BiZPJkwqSLay2BKGmCPTNZshwoEV7dlHXlBY
         zddGWJCzClARUrulCkLZkS5k3zc3nUoqwZBZELNs/WGeojK3IZXvcL38/5ZnZG3px5sB
         jIwwjL3qP4NOIpUZywj+JEmHvIy/xw9BO3UXJe52dn1syhxd+ACXw52EypJYeL7kZZak
         9pBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8PetGn1bfbVoBloZzqBQIISzwAv9McbiHWiHJEzSL9KPWDFMd5RwAavR293rW8Wh6B1LgSeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4CtY4bZeG0up/+PBTfJg3p2S77xpo5QDGKFLT4FWVJ/fe6hXg
	a+Ff4TXc4oyytMxBC7ys6y3E/IKVXKOmaeA/+22e0cXcc0F9zDw8qyzCtXKkGshesj48
X-Gm-Gg: Acq92OEv/DJDUmxIPBN6licTpTlIk9VyVmABMQ9z+k0h+bjYAnv0/zz8RxfFhAW8sKp
	D9dDGN7r6MOv2Qk3iUt3GytNzG8s0VLDMyvuWSJwWkJAkQm6UP/P4XezVuvm54fpq4/cOcVyflZ
	DOEoOmOqt7fT6dhrBy9lAjY5JvFEI6DKbwcr3NxMd55X/QBlly2kEBBlirdPwL9tsHca5yd68Oo
	vopoNMsXzr55tgPFosGedN0pM2zG0N3paePsKPEIhmTGSfVplyvQz4Vie2x87LwypbJakr9OGfZ
	lpHyNeCrgj/SeYpVfxyiwUy64md0TVXU1jM75coUqn/oZRpRJujmyOGU7fUj1A2L6M415woIPsF
	HWNyyyhyDOcDuSTZua7JxL6KECzZB0cugrZQ3F3q6NPfIyaktwthcQuxBWEeQVGua5eDdNSLuJ/
	McyStMlDLkKE7uHDC72sb6ovoTsN4cZgHUVeMSC21pOB6SWlCecO3dEUdXvRlaIpgCnGqlaFenN
	NCU9h88KUkGeSOEHB83VUseRyyuZJJYQDDyZjNUYNt45A==
X-Received: by 2002:a05:600c:3f07:b0:492:1e36:bafc with SMTP id 5b1f17b1804b1-4921e36bb41mr143543765e9.36.1781532337618;
        Mon, 15 Jun 2026 07:05:37 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203dd0b9sm249125435e9.15.2026.06.15.07.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jun 2026 07:05:36 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: borisp@nvidia.com,
	sd@queasysnail.net,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Mon, 15 Jun 2026 16:05:34 +0200
Message-ID: <20260615140534.52691-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-299477-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:sd@queasysnail.net,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6BF0686ECE

macsec_del_rxsc_ctx() frees the RX SC metadata_dst via
metadata_dst_free(), which directly kfree()s the object and ignores the
dst_entry refcount. The MACsec RX offload datapath
mlx5e_macsec_offload_handle_rx_skb() takes a reference on this dst with
dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
is still in flight when the RX SC is deleted, the metadata_dst is freed
while the skb still references it; the subsequent dst_release() on skb
free then operates on already-freed memory.

Replace metadata_dst_free() with dst_release() so the metadata_dst is
freed only after the last reference is dropped. The dst subsystem frees
metadata_dst objects from dst_destroy() once the refcount reaches zero
(DST_METADATA is set by metadata_dst_alloc()).

Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
nft_tunnel: fix use-after-free on object destroy").

Fixes: 9b9e23c4dc2b ("net/mlx5e: MACsec, fix memory leak when MACsec device is deleted")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a059c964..2a4e7ed76d31 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -829,7 +829,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	 */
 	list_del_rcu(&rx_sc->rx_sc_list_element);
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
-	metadata_dst_free(rx_sc->md_dst);
+	dst_release(&rx_sc->md_dst->dst);
 	kfree(rx_sc->sc_xarray_element);
 	kfree_rcu_mightsleep(rx_sc);
 }
-- 
2.43.0


