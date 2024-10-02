Return-Path: <netdev+bounces-131149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C2F98CF75
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB2A1C20B9F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2428198845;
	Wed,  2 Oct 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hSpobwN6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12691974F4
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859802; cv=none; b=Bkqf4lvbMMVuFW5TbFXXOXd8zyWxxU3fooL17v7O3teSO829H1fmzZxQjQD5cLaShS0wU4piMqq/aOOYqc56UC0O36DUJzROXMkiC4szWvLwpw1MsoYY4suiH1WaarsAFGHQ5UaYGHzDM3QCH9ZG/NkQ21zudT6FvmsPzyHzM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859802; c=relaxed/simple;
	bh=BlosqxkVcubrmJg/4VB7LReocifRDKBIus4x10zDNg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o14ZsyQ2gUPvmsm/Nnt9LiYuds4gblkHsxbJJ618EDRYtXBl2BEM3zzYZf9CaAdCe3OKPLYXOLWMaRgKZHRU8TvVjYrGGJljTtxLWIB5XFvQMb3xVum9KbEv1twHfX5aui++/ikrn0JIZrh1T1Pd3iRAaW/ZWVwaK92eZZng3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hSpobwN6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ce9644daaso2239733f8f.3
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 02:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859799; x=1728464599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnrRM9dH2ACQXMxz9IzXWQR3bhpJdNYqVmlVj8NU+CA=;
        b=hSpobwN697kWWm/WTGzQw/xuldb9wberrNYzweilVl0J9U8s50DOFMeKYXdl+TTNkW
         M+bxX1QRfAQ4a2S1owXGv++UtS9Rhl1GpZ7elPLjK0cTAStOgdQ1el3YPXry7Rm90UY8
         4p4TyCGd2GYPCtXHWlOyIAYng1e5D2pBUzMO11Uoil1loFCpTOkAYLGzDha/prINTXTi
         wH6kbZxVGeWlc2jAEzG5xDZAQR/CfXn17/NQwyCLqP+lGM8ydDxantgsYUl4yNaZikg6
         cMeqG2JVgjlLHAP5IWEvOyFkdq8zQJGk/Ctz0v/WfjHdPHC6lE8gWSD5t1bDyQbdxfHb
         LMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859799; x=1728464599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnrRM9dH2ACQXMxz9IzXWQR3bhpJdNYqVmlVj8NU+CA=;
        b=kpBSyzPCaW+FeLXlooll39NqPMtFn66cXu8rMGbc8jT+q7a44sHP79Hv8yBptPQ3oA
         BuwcoqbRLJaoYNmqiciKjcK8R3u1GgyyAhZnP7e+zAOujtZ0gsrgiqQmpx7pDEOLNScp
         epJzc/8VdthIqd4+bOwKQKg4HVr2cy5eTRFZszNrwhwLbOWyFTmLSfsqpD6Cj5DO2BoR
         0MNJpV+tCCQkI7HY91ugTs7x9ZOBlwg95NU+2Te0gV/fPLi7xaPn8nc1+yxy4xFLqPbi
         y7Ujqqg8ePGJYqspxnHbOl7i1VEgsc55wxdOo/kaQO8JT22KWYo89ZXTT0gw8A8F9De7
         NYHw==
X-Gm-Message-State: AOJu0Ywf+KEKDNI38340kPe0siesDw5Ex3ozBCUSf6AkxowQHyuXE1Bj
	ltq+r9ldenTLcqBafOJir4D8eWa+a1nqtjo13Uljmq85NJcKywtnoebJj/g9JJw=
X-Google-Smtp-Source: AGHT+IHq+1W/hdrmTuCIm42N/nm8hnQR6YetKPtHvBzxj6CavoV/oKNue+L2qRwxN8TkU9S4YAci9w==
X-Received: by 2002:a5d:6189:0:b0:374:cbc4:53b1 with SMTP id ffacd0b85a97d-37cfba0a641mr1417496f8f.40.1727859798949;
        Wed, 02 Oct 2024 02:03:18 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:18 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:15 +0200
Subject: [PATCH net-next v8 01/24] netlink: add NLA_POLICY_MAX_LEN macro
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=BlosqxkVcubrmJg/4VB7LReocifRDKBIus4x10zDNg0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxQDUeMpT4CQRRPSNmsg6uA36wdILEsWR2YN
 XhA5+OTrZaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUAAKCRALcOU6oDjV
 hzjaB/9LFbG/DdXZJfVBAml13MngrdL8EDI+wtbFws8hT517/dYRe16eEwq9vtREmMYCglyD4mk
 OhmXkwuAIIuSGNW14J2F/gdYxSmha49EZo7F9zGHNHwVJ8Krf+h/xFAHyPrU6ZBDGHgz3phIg7m
 ERvKfA8Arck6jKxv/4yOjsRmdhaAFw/wYnsbUmTSJF6iYyXnfoSRk3isphHcddcKhhhPR37yl8j
 bZKkumK0OZ2ymnfiLSL8/aLCaszHlxOY1POwp/cMRl+yIy0o4j1kU9/SXfmZfAvF6VoCwtoWx5e
 QreWQvz3jsoui2V9a7oANKLxvxZmevPGKkc9vL2q+Jz2CYRe
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Similarly to NLA_POLICY_MIN_LEN, NLA_POLICY_MAX_LEN defines a policy
with a maximum length value.

The netlink generator for YAML specs has been extended accordingly.

Cc: donald.hunter@gmail.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 include/net/netlink.h      | 1 +
 tools/net/ynl/ynl-gen-c.py | 2 ++
 2 files changed, 3 insertions(+)

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
index 717530bc9c52e7cfa897814870b4583c88618a27..3ccbb301be87f80bbcf03da63d60f58c4fedc1c8 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -466,6 +466,8 @@ class TypeBinary(Type):
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
             mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+        elif 'max-len' in self.checks:
+            mem = 'NLA_POLICY_MAX_LEN(' + str(self.get_limit('max-len')) + ')'
         else:
             mem = '{ '
             if len(self.checks) == 1 and 'min-len' in self.checks:

-- 
2.45.2


