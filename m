Return-Path: <netdev+bounces-264079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOoVH7y7qGlbwwAAu9opvQ
	(envelope-from <netdev+bounces-264079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:09:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA037208DEC
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C170B30D6D2A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D411237F8CD;
	Wed,  4 Mar 2026 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SbLp41Sf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A5383C9D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665623; cv=none; b=JNx81tibKL2/ngwoFLbABmaaqRZ+woIxzXlmnMrzSIMFKi7q+bIDd1i8NJNzGU0UpSDG9p6hp7pZQajv4co3ZripjXfrRmcoQN+pjW2mJCiHJBEewss5WCNqhvnam7fxrh0Dqb1mYykd46KZkfpno2oTyvBk6bIxymDh25XTgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665623; c=relaxed/simple;
	bh=aTGdGKIbN78z0HccJeLIaLaLIQQWPHWa0zQSLVb6wio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEm70t07Y4kli5preTO0zqMeEHq2dE2podOLClnRo9CbDml1UOtlfjPGafqZ+rSbxUl5BSah+/n5Jm1ujHTL6a17ou+L8aaIgdr0E+r2rBkb1WrCt+4UHNPSSRXl5ukHUdLA8Syyx730E8744VstGngaHDM4kvHqnRAaJBGex3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SbLp41Sf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso67243275e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772665620; x=1773270420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=SbLp41SfwccUhoAwleQmErnb+xxp4b4JZoDFkHvyZeDlNi/aOI8MaXL2ab4lmSZ1eD
         U9FaaxkpCmwtgTnBeSE6nqLKocMHtSu8EnzXSD8e/gOH3KxtW03ISylaP1xWhmfhjy7b
         ho6DZ/PfQjA94v3AdiLAMKftJEIFIq81AlZKWe4uTE+lnZUzBAR2cinoLvNt6kku64eg
         AhWp0c/7pIPAcHVKTuoeTiiDdSpe2V0Y2gvgUWZf+tUQ9H5Dkvlc4ta9yan4O2ruV/Oy
         dcjngF1BUd+mdlH6Y5NFHGjq7j2DvWC37xsr06NzzwmxC3wOq80ZkAm3Jhy3JkVUtigd
         JXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772665620; x=1773270420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+c1YssimIKbOeI4y9o12dVhyqLS9jie10yKUyGHwPU=;
        b=i0OugOTVRTvkApYPrFQJO7xdzaQS1SxGAsm04Jhg02yFi+x/PWVtosesNLOZx+jKg9
         RtFBAHB5Qjffl4Fh2qipuzlALQyuAr7XDSzBkxdvqV9oPkiJIY9nOTXZ9AgtGLhR9eHc
         rpIgojGB8ewdXs/j80jGyG291owyPTp3eNCTNqRu7ehEfFma70T4iXVZLrsDsAy/Hfnz
         jJL0FIkII1wkAXbrZ2b4poZWZdsGnjaEJ2taTsbHuaQWI4qk/IL+aXciW15oRGhBkmOw
         jx+yP4TfdCz+WCeujq7iLwKwXFVu4QYmQTkjl1ILTCyXtfoMizPxff4ULS1tbfJ7wRZy
         /K6w==
X-Gm-Message-State: AOJu0YwBqiKqC0rEAT85tujwastOMdiEPt9AKlrlcl5mKi5h8dRrYrbv
	ndAo3rJOEwmv+kPw4QO31U28EMQilsFhK3DVzlFutKkPrug+gC6rt5KdC9OrOo9AxU78/HT6cid
	Rk4L05zfjOIoz4Ws9jwo/jDBpRIaS3/cdWg6cqXK9UphSUumLwEUxY06/8KmXS1tA
X-Gm-Gg: ATEYQzy8hN2rhv2wqILol1UrgZ3gVyDrWcjP2mTt0sYg4Nmj+mxB1a84hUNerZl3H22
	W0rV3umbpT4QsCVfu9XzEoJtUbSxr4RrMZpFdQzrhVIDGQ1OXvye3QujwM/xCaGJo/QKTDTAagE
	pKaqkMQ/AXF7E+Xe2UnVOxud6jy4jGlgKUAWgpdKpOgQ0gg/jm1Rlb4l2KimqIrI2RP1i0bv0i3
	DgPmTNRIp2rGRvgyLh0aB3qazK3FQ5BLmDKuyznMN6o+iCqldpYGhjdgHnsdjsDC0FamjtiFop0
	UtjWos/GJLa1DUy5z2jKd/kmPNsWaxxXWhSMfZphw0580UBj1Z4YriSqkq6LjzzfuzjcCSdcso+
	pkqGAdszvjLts5dVQLSTdfd3UDpls8qPQUZGjC2fYIm1eVJqlz0GUcy+K8GgkkDv4ETSboPbXRS
	wREHcazLqbS3b/QeVQXesTN+esbUlR0m/ITZA=
X-Received: by 2002:a05:600c:190e:b0:483:78c5:d743 with SMTP id 5b1f17b1804b1-485198bc219mr68100445e9.28.1772665620194;
        Wed, 04 Mar 2026 15:07:00 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:880:4d86:fc53:5d46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187caf9fsm87713475e9.7.2026.03.04.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:06:59 -0800 (PST)
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
Date: Thu,  5 Mar 2026 00:06:20 +0100
Message-ID: <20260304230643.1014-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304230643.1014-1-antonio@openvpn.net>
References: <20260304230643.1014-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA037208DEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264079-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,queasysnail.net:email]
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


