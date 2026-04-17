Return-Path: <netdev+bounces-279270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGvLH2z44Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:07:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD2419161
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6396C30B9C49
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AEF3B2FEC;
	Fri, 17 Apr 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LlWN8KL/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C83806C9
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416612; cv=none; b=XkpGQjxj1Za/t6ZmrhPWKcdJcG4u/KbVXNaSPn833rJd+8fOsYbiTVpq5KS9TLtQqetMywLa9mUt2J42Cxy4URSZR55AEaKCjvfv5HPvS3YJK6E6pdwzT7u4m11LVTNt3c1ztaj99KNPddhUgjMSGCNjxw6Vk4q0sA6DS1hAKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416612; c=relaxed/simple;
	bh=2MD4mw9VtT92c+XLvgL57rMrXsAFd3YknTwrxiwVYBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oivH4FXj4lvgts6m7JUcuHQ3BnFUzP9iGYwBP+jlUGAPlEnrfSX2Or/fQE/Ydg3Wfe92UXgStqNd6aZpDJIHM1dhu4mkqhwQfPkrJBY/leuiU9imZvz2v1EkpxYv3vmfzGOfCjEWRwQjh4vFrtQhf1vDIMT2M1fpQYvYcHJTldw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LlWN8KL/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso3810165e9.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776416609; x=1777021409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8Mfdg4Ypl8F8vizSjaXQ98wwfwZessRlBGANjO9ivQ=;
        b=LlWN8KL/m+0OtEUSOhAND5cDuTt756AqBZHMyrvAvCWussT7BMimbdVm7oIBiBT+TK
         lwD2EHAtQDKHwr0oRbBM0rCI0D9Kqlr3Q3W69hK8SlkhuhLO5GcPHs2axLFByWAx6dCa
         Y/HflmgPIR4qnZadt0l3lngdwmrMYtlqQRhN/7ZSvYO5PnbXoeUyBHiujLAt2Do0UYlW
         yn3p7RLj0J1nlmQkVD4EasCXPH/IqynVAP6ltoLQzpdxiRdOT4dZCcW1tkxczFjD2sYg
         c547rIvDvd3qZB/aKD/Z9C8oNJv/QBBUp67uHXrTSDh4QJgi76zXgrkS+SfTpobmoI3Y
         pfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416609; x=1777021409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8Mfdg4Ypl8F8vizSjaXQ98wwfwZessRlBGANjO9ivQ=;
        b=m8UvcFsil16JZKvvEw9VIaJaR6ZSkSZ0wMh+oFEPgXpAfyOviScF5rjA/UHvq0yrSO
         E9kxIbU+orNVbeMZbTtkfeYjVBx2snMPKfaWsa0+Je2AtfjuecUOzeryrOOZrNI423NX
         h6yJEaL2WeF/yAulDTjmoa6LkvT1jVxS16sjd8mqfLFtkycqJAtsAqd5TkzO0d+H5Nqu
         0YSbMOgdhfDv5SSyNquZ2PucsjqJKBYPX1hyajCpS+k0oUG7b4xjyP7F4xY6V9wyYnXQ
         XK+Ss9lQ0BAsf1ZFypHUr8Wse2oZxVnBsADQOxIaQXB9igtAIVcUUansT7IGzRFYMsa0
         UfOg==
X-Gm-Message-State: AOJu0Yze7XaS0LJa7nQuhmeoyxp6gQe/zbg7454AmTLnMZ2bboENRzJv
	lSRLJ4sRftNx7j3ISjUC9alNGofji1uea7PLJTcy5NVLKhOcMPgKYfNqXsXmp4rE+s4dw4LTiAR
	S7dheRVaX2ACIEgfDkoxm6y0/sLYmuyBxn07hd+LRMVvVuQixMZbtIQ3NcvKYTEsh
X-Gm-Gg: AeBDieutFuIjbBjdiIo2CmyTF+JYlea62QNBrsCl3nnjul9zj8O6ObhJGjZ/THjwvfJ
	y8r5GsPk3Jne+LTYyHUxlnKPlp++zOLVJaM0m3GrCfgYm5Fzs/sZFtkFpL09ZC2I/h7gebU0qWt
	wXEbs/DXfcJatU93nDei8wGHa31kDW/+UgX56KNYJ2GPlku9kBBia1W4/7L/xpKcV7wsZgBMZZz
	1gvlWDVzucmZvjOhQibjUes5uOZReSG1mBpHWQzcgkYgZtuYb9DfpYCztThNbM5rMYlc76C9Rq7
	YmCJlVGa/xBkwhjKeWdgOpivMxkbEhCPxDZJwJZjlb5nDPtHM8fk9ApxAVTYYi+1hUgOrCq97A5
	nTsTJGHnkiTRmaWfHD7nwavXzr9aEifVo8fEbIqWCJZpE/2pG1YMdZ7bFR7xBypqZrIhmcJbI3H
	J/C0tE3kz9amVntDR1lAYY+OaY/GUHVDIkMeh/M5Sp70Y5WD0=
X-Received: by 2002:a05:600c:1c11:b0:488:9ed3:148f with SMTP id 5b1f17b1804b1-488fb782a93mr28391075e9.21.1776416609533;
        Fri, 17 Apr 2026 02:03:29 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7524:fc82:dee5:4129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm4120151f8f.36.2026.04.17.02.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:03:29 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	shuah@kernel.org,
	horms@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/6] selftests: ovpn: add nftables config dependencies for test-mark
Date: Fri, 17 Apr 2026 11:03:00 +0200
Message-ID: <20260417090305.2775723-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417090305.2775723-1-antonio@openvpn.net>
References: <20260417090305.2775723-1-antonio@openvpn.net>
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
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279270-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,openvpn.net:dkim,openvpn.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mandelbit.com:email]
X-Rspamd-Queue-Id: 1FDD2419161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

test-mark.sh installs nftables rules in an inet/filter output chain and
verifies packet drops via nft counters. In vmksft this can fail when the
nftables core is not enabled by the ovpn selftest config.

Add the missing kernel options required by this test:
- CONFIG_NETFILTER
- CONFIG_NF_TABLES
- CONFIG_NF_TABLES_INET

Fixes: 7b80d8a33500 ("selftests: ovpn: add test for the FW mark feature")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/all/20260319124114.42f91f72@kernel.org/
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/ovpn/config b/tools/testing/selftests/net/ovpn/config
index 42699740936d..d6cf033d555e 100644
--- a/tools/testing/selftests/net/ovpn/config
+++ b/tools/testing/selftests/net/ovpn/config
@@ -5,6 +5,9 @@ CONFIG_CRYPTO_GCM=y
 CONFIG_DST_CACHE=y
 CONFIG_INET=y
 CONFIG_NET=y
+CONFIG_NETFILTER=y
 CONFIG_NET_UDP_TUNNEL=y
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_INET=y
 CONFIG_OVPN=m
 CONFIG_STREAM_PARSER=y
-- 
2.52.0


