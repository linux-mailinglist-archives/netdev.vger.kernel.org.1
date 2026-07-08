Return-Path: <netdev+bounces-305772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3G3OGtQxTmqeFwIAu9opvQ
	(envelope-from <netdev+bounces-305772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:17:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8581724CC7
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:17:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qeYd3w2+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305772-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305772-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 270403017C11
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC47403150;
	Wed,  8 Jul 2026 11:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E730C163
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 11:12:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509176; cv=none; b=m+RsUQfKuA6x93dLK81qrGSCS6EVGBZQlVYt5qvRZ6Nn4k5EkXPUHVyF+AQz2oKHTQdlDNOeiJ41Yj7DdDVMObJuumH8pNMOOEvZ5kRBfzbHCj4WUb6OpYLIRVHRfZvb37m3HVLFDCmhMOJK2rKPoVifnv9kaPFE+bFdRAYv5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509176; c=relaxed/simple;
	bh=vAYuSKepYX2R6SHPiXef5gcb+t+WIrxDadX/4+/aE/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYp2lCEh8LHfoE0R4GBISQHZRAslOE0PnYWjAbwNCqu3Sxi5tuZepc6KerfhjyxXG7ZTuZaDShr/N/sZ296vPnPZlQwqmc16Gvn2hYgcnoDn/v3ad+dRxdQy5J5RZgogz8FpEnH/RJUTuTaM+FwwOH3R2GrAJw9t9uVofgizoZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeYd3w2+; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacd69a9c0so6576695ad.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783509175; x=1784113975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s31bR1iKC+e6h6RE4wZIClsqmUypkmINB4OCzr0ClWk=;
        b=qeYd3w2+Mi4x8EL2Uj+6GSkm91Y5b/0Vir3TnPgMfsv6L3ALF1Etk8FU7POfNsuNzX
         FHDGAJo9CgkxzZCyLgn7mbX+YENou+i3COnArVb3TRUiNawE2lVM8WucYQg7IvI9Fahs
         xJE+5CYMuDUSqW3t32UArpJkoG93wDUNFA6lihQWrDjc+KErVCSKOtNYo8kbdJkv/v0V
         oT1CLBPNKIL+1qJr+gvj9QD7ZTP5RGiIhij4hATc3/Uuxdd5j+/W7nkKMQC0zOKsb52v
         UMgn6jI9nzI3RWZxn6hTxbD614jiIo/4uuxgSPE+rw5zL0XD7jFBI1kmO8TdOg+5Gkox
         Brtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783509175; x=1784113975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s31bR1iKC+e6h6RE4wZIClsqmUypkmINB4OCzr0ClWk=;
        b=pf7i+tGuB/1Vz5vY5OBtZM2zM/5e3LEW83NncoCSnROnlCas7KW5ZF/B0OrSpTxVCf
         iFgrilOLvKSaEwX9RrWY/Fz4upM2rlAceKYaYPw0B09WSg/cE/tzNl+H8OQuRFaxzUzW
         Pc1Hph6L2U+JYIcUwhGWBYp+iTy6UA7HWD7KR45sg6uHBFdpCaeOmUEWJTckr5d6rlX5
         QLwhF1FV6LdWJQSFu/yYTcAPxJ13xVRL2sB6Tz7SDMomARSUE/KiXGIekn9Rc3xvhYky
         zuzCki6t4uSnf/3rDRalYXJLNsca4ue1xEJS+Z9lD7wJeE3ip64+IRtLSWrmo4on/Jrl
         c9sA==
X-Forwarded-Encrypted: i=1; AHgh+RpVoVgNguwSpJW1JkQfU6TQWq8WGXlQ+6ZQch5IjFMCVT+Rj3HAxgPwO/tMVTKa57MLtEzy3Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJexXcrQU+Z76Yh9YhGnkNVW/WPMB+FZ7V1a9EiLfc9TvAl/w
	yYmf367DHhzvK5+jhTDMCf4Ts90jZCkNyY+ZDXFudwYDzxDbb9qr7hqT
X-Gm-Gg: AfdE7cl7fCtkltr/7fdCU/F52g1UHElaC4kGTnjvXlYgshaF/wYu4yqtW56V/FXobmj
	lAgpebeot/4pC4O0K5cAFAOeLkAF5LC4oNKOdJYZ2gCWxikCTqA782ta+PJuui3mWLqVspIH2ta
	vobsPsh+bbHYMn9G5XBzWHgNw6f2H7zT/FLYGPovGFodq5Igc0Z9Y4FcflajQFbpSsAaN3yoXvp
	1aj4VV5eal8hDJKcnbvzPSwkfGbltrwNI3KihaXH3AFhvq+nxzhPod3EAXoSYXmuHyfgduS9T6C
	6LkS8etdk0oJswkkY+TFNO7IYPNabc5oQ9E/KRhleSIPJnLO85rGn3OMjcTIcHogKd2a3jlQFcf
	vpa6hObRGG6UpQC78nxLGxyBcs0wyt9xZ5oiohB9VDDE9kRlf2aLpGRQm3G5CBIbnGOQ3+Ig=
X-Received: by 2002:a17:903:4b30:b0:2c6:a012:6241 with SMTP id d9443c01a7336-2ccea348876mr23010425ad.6.1783509174902;
        Wed, 08 Jul 2026 04:12:54 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf8d80sm26679355ad.25.2026.07.08.04.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 04:12:54 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] dpaa2-switch: put MAC endpoint device on disconnect
Date: Wed,  8 Jul 2026 19:10:25 +0800
Message-ID: <20260708111025.749311-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305772-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ioana.ciornei@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8581724CC7

fsl_mc_get_endpoint() returns the MAC endpoint device with a reference
taken through device_find_child(). The switch port connect path stores
that device in mac->mc_dev and keeps it for the lifetime of the connected
MAC object.

However, the disconnect path only closes the MAC and frees the dpaa2_mac
object. It does not drop the endpoint device reference stored in
mac->mc_dev, so every successful connect leaks that device reference when
the MAC is later disconnected.

Drop the endpoint device reference before freeing the dpaa2_mac object.

Fixes: 84cba72956fd ("dpaa2-switch: integrate the MAC endpoint support")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 858ba844ac51..dd4f60031d0c 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1560,6 +1560,7 @@ static void dpaa2_switch_port_disconnect_mac(struct ethsw_port_priv *port_priv)
 		dpaa2_mac_disconnect(mac);
 
 	dpaa2_mac_close(mac);
+	put_device(&mac->mc_dev->dev);
 	kfree(mac);
 }
 
-- 
2.43.0


