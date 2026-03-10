Return-Path: <netdev+bounces-266198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPhEM3I7sGmDhQIAu9opvQ
	(envelope-from <netdev+bounces-266198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:40:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F0253C49
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE5D532315AE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23FA3033F5;
	Tue, 10 Mar 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="b8+9g7KE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2132FE079
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154232; cv=none; b=ATYTZSYy7BkC8ibQWsptMZV5gnbDjVlhqtqZTy4T6a7nZlgwS6eNpnkv8oesaPBb4ZAfESDRJ5gtbt4y0oKF6P/4KnojXlx3g4s75tr5SaC7NcAwih0jn5ZL0pY69f4ROEOXimzdNYGRc7Sj1Mnnwsz4XfgZvRtSkpWzETxkmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154232; c=relaxed/simple;
	bh=aTGdGKIbN78z0HccJeLIaLaLIQQWPHWa0zQSLVb6wio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7o/olmLW412pCb/yt2IyGc9LRrMM9WcCvEBkH6VwQr1h5TwHKC6Hpv9X3OU+ki9h5N9k/og3BR4XbgRIF7OxsVwQZfjNgs1jgzewLVhYSAuGUfL4xhBRo5iq+UabjRN7KyFR3i6rGsGaQ+aSEryi5zxb5617XmYJEkT13wRjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=b8+9g7KE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so6034869f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773154229; x=1773759029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=b8+9g7KEotTiK+SMNrxSblCPUyjUmhJyWXH88hG/6B2/u5CZ1J8WbqpHoOFkN1Sddk
         WBlttAeQztad+jFvtVtKKUEi1cChtC05nxEP87I7ITWhzUaxJlsifLfeDKFV0bmt7jEy
         X633wntDJAxMH/zB20S2/2MLJ3lH2mcQVp0zlFGxjlvQX4N9fqG/qus2CY+xVsGFD0x8
         70FqfRGrZkaBeKWlp+WK8YodjcU7tdGbad1KODu0o7mleIFDQjjws41v1HZUo5LsvvpN
         yPGxNAFM0LzUsmmf/+mCZuCBsgxO8O30rBSQLbRm1WojtkoJZxOhqwuausDPNgpGPKOH
         pfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154229; x=1773759029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=eu9OZudbtffO+aNED/SBAhYW9hQ7ZhF/bPxlMykl6J0k+YgPb6Qvpj5xzqE7msituS
         vA23u1yjzfcK/Rn4K9CsmS9DJwGjLSSVR+TNowNw3EAnZqdrtFkkmSvvapQpsSzONJJX
         LXw5sJtSLfXZK7a9ydLX4NFwCoDXq5ca8l0BLPGHKjYs0HCUqGg3CCis6wq000MFJb8/
         xzUHYdo7DdQtkkBe72wZBN3IaKCLyB6CUg0/POtiQ+rYCwGBWBONfmyoOJQu/rNsZQFn
         vSkdsBaNP09mt9+Grq9mWCoqM1+UO6MjsUHdmhNok6bWkEr6aeP0qknS00GIrMi8U/EK
         pILQ==
X-Gm-Message-State: AOJu0YxGO2u/X17ndNkwwwO+YRr6XQvXoregt3BS5nVdWJCM4jra7WXj
	u0N34nFcAzOVOtlLg4HDZsXRIxdIo3zutAKopUe5uiFEkpmKYm/bRqikdSvxWm8CzHgQilTQCYg
	OtKXe6cjksiJ5vhtKV8wg3sUZwij2X7gUNMUCfACE8J8emQgnotCQw+QXdp1p0XsQ
X-Gm-Gg: ATEYQzy2mkowDSCaggszaEUM0f+xkPXCYDFl+LIKKaIaiPHl/yUBFzD6KrgYKCExRiN
	NA5ug00OwizU2Rxh1D7M/WgG0x5EQyLxxF0+TmwHIq0HSM8N21PFd++WDI2+2S0unwmISQDXhUT
	fLJs4KG/s4CY+6buT732LB7YknCffQOAenjs2YHSpBa3qaGkNUBxEtH+vE5QGt5XnxaqKF3DNDo
	2xgcRm3TsQDxarl4u1n23A2v1dSXwY/nSlSGMuCleXR9+unENLTgQdJmTUmVi7+SpCnPC6iYym9
	g2N05arHos7GC7FkA/E54Rqx0WLcWIA2g43n9AyvDS/a8k+PnKYKKdmsSOY4yGW06t7bKMDGDB5
	K14kI8HZzGKAF9javwYJ0ongx8o8bjePYBRdIrqX5nDf4jViOmEFxqfUmI8bWT8DlI1s4iI5UT4
	Zsp3YDolQq0qkmwCIcgxtb6dWdFjMl9Bo/NhoBwXd5tGEOQiw=
X-Received: by 2002:a05:6000:2307:b0:439:c1a7:9dee with SMTP id ffacd0b85a97d-439efeb0512mr7202129f8f.0.1773154229035;
        Tue, 10 Mar 2026 07:50:29 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5594:94ef:1bd6:89e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35586700f8f.6.2026.03.10.07.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:50:28 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/9] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
Date: Tue, 10 Mar 2026 15:49:59 +0100
Message-ID: <20260310145006.30858-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310145006.30858-1-antonio@openvpn.net>
References: <20260310145006.30858-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 503F0253C49
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266198-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sabrina Dubroca <sd@queasysnail.net>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

The wrong constant was introduced by commit 203e2bf55990
("ovpn: implement key add/get/del/swap via netlink")

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index c7f382437630..fed0e46b32a3 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1061,8 +1061,8 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.52.0


