Return-Path: <netdev+bounces-227635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A329BB4519
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC84219E24A1
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402AA1D8DFB;
	Thu,  2 Oct 2025 15:26:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3A1ACEDC
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418804; cv=none; b=LD77NVYySCi2sEX9patjzBUmRDr9RVxGPhadIs/opPGadkmvVa+iKmsbHOZ2ku9bHuX7gSmW5iuqdPuvRzKgrcS/dE5JGWx5nxUkOtdFc8tkLJw+LLOfRUoIWzeYnwGZXTzaE7w9e33+2VoGH1gBMn596K5N1tuEVYH3RJkVvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418804; c=relaxed/simple;
	bh=Z86lLnI5Tm3fzb69918VDPeWt3usJ2k/s66dsD2rV1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tMwziS+9Y0+GzWO32qwikzjT9pg1/tePEagng/nofdtT6w6i2DW1Oxry4gQFrWcKbq2hvw1v7/b4c/BE5a3mDyCwrkuLdZBc67ou6Zy7JOJq965xlwF9XcOMfjAk/RhSYqxPH/YnwWmDZbnAQ61aW2xuAqzThlZKRCVW0gFmj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-637dbabdb32so2036860a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 08:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759418801; x=1760023601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fV7gueGwrkVggKjpKT46wk+Vba2utbQt9f8Z8d2dnHs=;
        b=X7zl3w3QIwS/WyBDTFzCgrpqOfiZZ4Ugo8W2FZjbq3/M4j9nJmWwO//niJl91Hnw5J
         46+I7LLgadQi+6MGrbg9Ww61Dy9lX/p5W1XaX5X1SIlc+dibsPaBNMc79pzqQtD7mrJC
         Iyxtwqx+iAnLUDExDeNbEex+a05O7nGWZesUHVJkGzVT+1chH8VZU937D6OkRkkcxrsI
         413p/vTBDuoSTjJIqVp3v7/l0m/KT0J51iPbHxETr6yxk+G5yzFzY7Pzkt57O+uD4deg
         BnDLAHdHNNl1wcSuN+TWaEXzkdnwZPNgEsiYVJBvue5gNF+s6iotw5on88EdSRiak4O+
         0KUg==
X-Forwarded-Encrypted: i=1; AJvYcCUtmWbu8L9pwcoa617J23PGye35T5kjIQPrD1LIU6maUj4dapNWTuR8RDE4LkYRsszEFAEhWBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGVLwg4ZAG1QGEGHtHTwv6jOSTkqQt2vmopgXa49aiVVF/nKc
	vZvMECAi9qmQqn2rxOpmoVG3avheToLeZjYd0qae3YWbeYOtwo/k2tYE
X-Gm-Gg: ASbGncvOdJWzxr3oNcHdZGeDx5CE0XGyflH/G2kDb4QdBELXoI3MnIdfjwtF+PM3XrI
	KoVZneqffu8cHCxfn2NA32T0vJpgiQ+MUFGpbp4Pql7qcmj8oLOuJLLaSV8828yML2xbmSumAj0
	zXoXLZMjWMVo+mKAQhzrNqtqNYkLymNlNheXnBL+OAEL5hmyaGYAK0Stb4P83ykH6Ljzwt4AKOL
	5jn7PL15a17Q1T3gUzMnW5Z9BFdTcLIqpaykJq80gpQt17cf4KYDx5iZb1VY60Jg5kGQzxsWKge
	OLBfWEAs8Gy0Z5GrWOwcsdsCipiU2WGvj5RgXvbuqQzBpaH4cnjpq4wjCuZFqvCjFRaa+nQfr7W
	wUlu3BfPZEs1gr5zNcYIU6/bAixzKBtyfjkZhDQ==
X-Google-Smtp-Source: AGHT+IHu4WE80t/90uYDNyDhdDM+IRvgxuoF7rHrcmkwwOikdOlCR5zfrTQPjaAV6zMrz5FIvlZlJA==
X-Received: by 2002:a17:907:728e:b0:b3d:73e1:d809 with SMTP id a640c23a62f3a-b46ea414aefmr989484766b.48.1759418800558;
        Thu, 02 Oct 2025 08:26:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4e613sm217854966b.81.2025.10.02.08.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:26:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 02 Oct 2025 08:26:26 -0700
Subject: [PATCH net v6 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-netconsole_torture-v6-2-543bf52f6b46@debian.org>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=leitao@debian.org;
 h=from:subject:message-id; bh=Z86lLnI5Tm3fzb69918VDPeWt3usJ2k/s66dsD2rV1E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo3pmspZB8YD2VU7zArjltNHoR3Lv5JL4ulcLK/
 0QwucYTe+CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN6ZrAAKCRA1o5Of/Hh3
 bQu3EACLUz67wGRPN9BfvCvd4welZkaPX5R64wU0e0JPLIx8IybZT4DThQgjZo+SHbCPnOyyPev
 ci4ZZlxLvQY4DX3zszY5Hj9mgzp87uLLiP3U76hnN8sKyVemm4b/JOmIxlYBkHmRzBozg/3BIdf
 M/zs9uXms2MrN5+lkmoN9+d6hyA/fmULTbHc2nH3ZRI2VJsembz116cS2ncRS1Df00uSRZrvt0d
 XCrlOLp/Rj3oUD8wDWzBE6ou7D8RLTS5TKLlZh+GxiRiBnUk4ycTfVu7tenhr/16hseDacUDnr8
 +eyro2kmx3Ipi5gdesBRat4P7xzhiIuIkNYvNPUc0bnUiD75e2XSdBOk9kNofP4i1oisZcU8pMX
 QaQVX0mVWr4URMEkJTgOSU6it8h2vsVmQCZgKdnJAHZ5s293JNNuzjGHXuLsmvg5mJDRP/lp2jQ
 rmSrW4caPmcJpPSFFTBkkKF/1dFHCfBx5gX3Z/9Dvv/xdGJx/kB1CBLG+JfQybzTuKzZom7g2xV
 UjxMbgw9yk/XNOKu+02TMxwBhdZeQwEgf5xefelb5sMfUAE/0dQUUE6SoL+LgDLxZuAfkGerS7i
 +xnCrjc34r35cViwnYkLXkMwz7VhF82gBaoTm+n6I8zi+pakdwjeBX+lACJc+LFmVMxMP3DNmci
 1+VcNwkEQj2XmLw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the netconsole target creation from create_dynamic_target(), by
moving it from create_dynamic_target() into a new helper function. This
enables other tests to use the creation of netconsole targets with
arbitrary parameters and no sleep.

The new helper will be utilized by forthcoming torture-type selftests
that require dynamic target management.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
index 8e1085e896472..9b5ef8074440c 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
@@ -113,31 +113,39 @@ function set_network() {
 	configure_ip
 }
 
-function create_dynamic_target() {
-	local FORMAT=${1:-"extended"}
+function _create_dynamic_target() {
+	local FORMAT="${1:?FORMAT parameter required}"
+	local NCPATH="${2:?NCPATH parameter required}"
 
 	DSTMAC=$(ip netns exec "${NAMESPACE}" \
 		 ip link show "${DSTIF}" | awk '/ether/ {print $2}')
 
 	# Create a dynamic target
-	mkdir "${NETCONS_PATH}"
+	mkdir "${NCPATH}"
 
-	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
-	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
-	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
-	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
+	echo "${DSTIP}" > "${NCPATH}"/remote_ip
+	echo "${SRCIP}" > "${NCPATH}"/local_ip
+	echo "${DSTMAC}" > "${NCPATH}"/remote_mac
+	echo "${SRCIF}" > "${NCPATH}"/dev_name
 
 	if [ "${FORMAT}" == "basic" ]
 	then
 		# Basic target does not support release
-		echo 0 > "${NETCONS_PATH}"/release
-		echo 0 > "${NETCONS_PATH}"/extended
+		echo 0 > "${NCPATH}"/release
+		echo 0 > "${NCPATH}"/extended
 	elif [ "${FORMAT}" == "extended" ]
 	then
-		echo 1 > "${NETCONS_PATH}"/extended
+		echo 1 > "${NCPATH}"/extended
 	fi
 
-	echo 1 > "${NETCONS_PATH}"/enabled
+	echo 1 > "${NCPATH}"/enabled
+
+}
+
+function create_dynamic_target() {
+	local FORMAT=${1:-"extended"}
+	local NCPATH=${2:-"$NETCONS_PATH"}
+	_create_dynamic_target "${FORMAT}" "${NCPATH}"
 
 	# This will make sure that the kernel was able to
 	# load the netconsole driver configuration. The console message

-- 
2.47.3


