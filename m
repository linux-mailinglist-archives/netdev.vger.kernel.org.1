Return-Path: <netdev+bounces-139849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B49B4740
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0FD1F241AD
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92E206040;
	Tue, 29 Oct 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EjyWAGH+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA920493E
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198884; cv=none; b=HNVMT4IaqdLCKmjy1vOvKJQhD8ayJEpLDnkaziZuRkO3dtQcpdG5ffPzuJQx1z5kzpQUCMeAhiGkous+Yb31ZEogEJqJGk5pplFg4/+BO1tnM63l9QzKv3dQ8TY7KFFxm6AbwJBPHwCXv+6OE75syX2CNJeGo7A/qAztkS4Y4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198884; c=relaxed/simple;
	bh=3h6Wi7H1iKMwAf+WP49FV7oerS62QRBGc/xHHjDm4CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZatYfMhyyTvQBsDq6tnQ/EnQyOrzPM58VWVFEJam9W45BckfKoGJ67W0nAr7UHuT39KkIolyWhizfgEiAoOQ2himqVjCjvGl8hJNayySuWDr3hPhJqsGDOvabg3PsX1vb4xOGKYLuapy/Sj7NMotipB1QMdfUK5WBh0eYc+gOZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EjyWAGH+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e7e73740so4410070e87.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1730198879; x=1730803679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hHqB6mlKsN3r1iqdzDueTi/m2dV+1OPyVf3J9Nw6/k=;
        b=EjyWAGH+Z7NHlkMDerP7FIGuVhcJ9C8e5UnD6V0yvIaN5+wfD5X6smCKtcD8XR/ucV
         U6xS12g/je5MLq8xGBGpqDJXK5DBjUMwqYGCPJfpYSldZM9sediJ3P30Vu43VJJHXJBI
         bBvdKlF6jgFuJkGy+Ob7iBoRvJWPpL3kjXFIZuNQ2lpfZPsAcq7yIJZN88NMReICDWy2
         3XaqHjUf3bIcc27Fa8lnoLzsRg49hP14nUNjmJla8BdR+hVqaDnTyFS5IhEyoQ6sr14f
         SPWbXsMO1KGlS1KeG6AQRL5DBbIEmBldwzsohtsZpWcR6x4jgzjiBHlo4etT0zhWRotC
         HjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198880; x=1730803680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hHqB6mlKsN3r1iqdzDueTi/m2dV+1OPyVf3J9Nw6/k=;
        b=ilNYZVGo5r2nzNrkOkVrpVM2/DRE/ZLrfO7xOvRqWqV50TMGvaQ0XN1RFAZa5s/Tkw
         nDCkJrKxttghHMgW6D/JPizLKaNv5Km+dl0DoN03LOTjAMT5QgI9t9xIqiuQ2fJd9hni
         M0gR6daDhJ71Ns1fxhp368BGA80wZO0TvCp1laAczliz/nyiRszKF53jbmQUp+EVhIm+
         XQj1MgRGyUFA2V8T7AGZ07irpJ5qovSgCKrKdgpIEjH2yZydLtMS0rEAqHXDrcxk6bA/
         jSfcrYJ9OUADwsy1rCyjXyPYyML/GITFYoWqT8QB2CEnzEdh/Bpwr6I5JS+a6yDFlBw6
         LgrQ==
X-Gm-Message-State: AOJu0YwqCTsOwynWpwpHWoISt1uRCbHFpE84CN6TZxNkBAszXCnq2l98
	Nn7iEgV9uI7vwVpJ+AWXCUATQBb/GKYsrRd+3HEa0FjtTHMoohSgusiNtEdbNRo=
X-Google-Smtp-Source: AGHT+IHkzoVoOA57m72DKCIwc1HKkTpKSOjDNUJf3Fwa6VMnqHMqm1RR+0eWFHtWgqM9nPcFOFgiQw==
X-Received: by 2002:a05:6512:b9b:b0:53a:1a81:f006 with SMTP id 2adb3069b0e04-53b348daac3mr4991264e87.31.1730198879592;
        Tue, 29 Oct 2024 03:47:59 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3dcf:a6cb:47af:d9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm141124785e9.0.2024.10.29.03.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:47:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 29 Oct 2024 11:47:14 +0100
Subject: [PATCH net-next v11 01/23] netlink: add NLA_POLICY_MAX_LEN macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-b4-ovpn-v11-1-de4698c73a25@openvpn.net>
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
In-Reply-To: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=3h6Wi7H1iKMwAf+WP49FV7oerS62QRBGc/xHHjDm4CA=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnIL1qUWiqsiptxxgFRpa3gknKIb2UVV5lTIf2f
 RsOBqpYtuyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZyC9agAKCRALcOU6oDjV
 h3XIB/49iGwakal+50YuRUkoGo0eau/G32OMC5mzNo0Kx3snLNBqySl70M58tWbXgt3XBu9lxcE
 uIx+cJhuiPbty1nwDN7OSvcXpAB8jju/geLy5WECfDXhKh+N8w8ZWNqFu6scagrFhNbEeN/hL2M
 BnaX0TidiKIpEQHBz9KKRQks6ko8t4F4pvqXCSB8+P2qumANMueAjffkh9xctWs2NGAea9Z9CaY
 QWHR1J1ij8+g26ztS4/EY5MPkwaqPslLN4u9totCaEZSAa3jAPLVTxTOTuEJq6b4qrElgA/zILH
 +fy7fvH6uEZ3pijsl8rWMWkHDv3vKMm2IdlZMe/MVeqKWzVQ
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Similarly to NLA_POLICY_MIN_LEN, NLA_POLICY_MAX_LEN defines a policy
with a maximum length value.

The netlink generator for YAML specs has been extended accordingly.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 include/net/netlink.h      | 1 +
 tools/net/ynl/ynl-gen-c.py | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index db6af207287c839408c58cb28b82408e0548eaca..2dc671c977ff3297975269d236264907009703d3 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -469,6 +469,7 @@ struct nla_policy {
 	.max = _len						\
 }
 #define NLA_POLICY_MIN_LEN(_len)	NLA_POLICY_MIN(NLA_BINARY, _len)
+#define NLA_POLICY_MAX_LEN(_len)	NLA_POLICY_MAX(NLA_BINARY, _len)
 
 /**
  * struct nl_info - netlink source information
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 1a825b4081b222cf97eb73f01a2a5c1ffe47cd5c..aa22eb0924754f38ea0b9e68a1ff5a55d94d6717 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -481,7 +481,7 @@ class TypeBinary(Type):
             pass
         elif len(self.checks) == 1:
             check_name = list(self.checks)[0]
-            if check_name not in {'exact-len', 'min-len'}:
+            if check_name not in {'exact-len', 'min-len', 'max-len'}:
                 raise Exception('Unsupported check for binary type: ' + check_name)
         else:
             raise Exception('More than one check for binary type not implemented, yet')
@@ -492,6 +492,8 @@ class TypeBinary(Type):
             mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         elif 'min-len' in self.checks:
             mem = '{ .len = ' + self.get_limit_str('min-len') + ', }'
+        elif 'max-len' in self.checks:
+            mem = 'NLA_POLICY_MAX_LEN(' + self.get_limit_str('max-len') + ')'
 
         return mem
 

-- 
2.45.2


