Return-Path: <netdev+bounces-224370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F263B8432E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6D23A4C9D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB27301008;
	Thu, 18 Sep 2025 10:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8F2FF17D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192143; cv=none; b=ly6ftJrlBASLx5LrMFR/CGbfxRckixIA63XPkFix5wvgPw6IAUJgcNCiETcvm7+fV4Y3oNd4JFCQzDjRlvL6JEIKyXwMLHbi1I62kn3LOSBCgtYPi7z8vSxd+l9096tkr9RWW+J65Vy5sVQrNVx6CQaQ7fqnoHEzkFoFPkYuNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192143; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwC4cA460b0jqWRGKUbBsRzzWETsFJnhBIAPk8Uw7NX5rTdkmZ1l6vpkp5ZMxbSTSoZVHWG1dAEP2Ls75gyxU2hy6EAnTL0857svQVkPk+dG90zhR+q/8MQucUVmqB7Qbn9VwNXrvXBs4jvgqjNLopw1fJXt5w8QVSpTcNGTVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b042eb09948so147583066b.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 03:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192137; x=1758796937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=ZkCpx0lN7r/La/wp4q4vhvxFdnPJwGoRxP3x6UlVsXQFlM80Nq4oIWOOR5DDfEHTLa
         RFxyvAc7rJIiIkkNetycnxSF/SfIxN1ximXJ3/lGaDl1h4geCp+pNluTFmJiAABLju1A
         SrHAyivzouxa4MkO5LCHVlZUoPfuim9VhpmRAZkwfFOi7R7Q334FCMVSJpXwdG54f68s
         2xe2Or8xNymO2EvfqPZMlW7SUQt2349vNniGG6rqQ0ZfnRLCbjDERXRvWd8E/5F8OqnX
         6qyZCb1750EABUhEIJbCGW+tMgJo7YlqhvS7QlXL4kzajAMGjoSha5yEuRq9xsyoHRIe
         6DTg==
X-Forwarded-Encrypted: i=1; AJvYcCVNTag8jtvzWCYBPbGB8UvCgoQGt7CRQsAbbh5H9cJXtVzzy16l/YrFsaSRVqRck2TPKzCFyPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKpbA4i5nAEDn8D3VNHrlAAsGl0a00e7KZtozpvqazMsxvKco
	D9Rg0LhRv8CPkPxVbvF7nmfQyPn1C9IUrynuha6sIjTP9zZ/aHVAxy5c
X-Gm-Gg: ASbGncuy1fQ9KTUi28db5bAkmG3i1syYLBl0oL8eVNZrHQqdI7Z0HTfl6V0grlRviaX
	PxKiVFy5kYmvy+M1JMCVcv979+1wD0rEZLz3U7EV09SkIsPbz3+yzNyLnE57XVww/vRYs0ijac3
	TjI9qGZsr5iAMYQ/7l1v8iEgYI2fRtU2NZt6lQeYLf/6kbkucVEcAN8rkTTNt7iGgIoFT8XmMha
	qPeGYGi+YkStY/cJAOj4zIx3lETi6JEtudBrWVc5/cgp4e1EqDsLMLMRCO5nwgZbz5kvoQ3WMd9
	DTikHt4BpQbAnCZL8uhkTwRuDLOP6cGWw0a1X2DtSkOWvCdtVS2JhXko9TjtPX4ppU4eSBf3V5s
	B+MMn00R2bwvXDIkkVlUiDYEpNTi+rAiQwhsBaKkxjiQ=
X-Google-Smtp-Source: AGHT+IHZ76Ty7W0omcpdo3n5MkN3sf6Q4OcP/Bdw9ZDtOAwYzRo7981Z0ymOu7nfRAbVU1mgwU++uQ==
X-Received: by 2002:a17:907:3f92:b0:b07:c1d1:4b66 with SMTP id a640c23a62f3a-b1bb0a58881mr566493066b.14.1758192136915;
        Thu, 18 Sep 2025 03:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f43879sm173383366b.7.2025.09.18.03.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:42:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 18 Sep 2025 03:42:06 -0700
Subject: [PATCH net v5 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-netconsole_torture-v5-2-77e25e0a4eb6@debian.org>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
In-Reply-To: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2478; i=leitao@debian.org;
 h=from:subject:message-id; bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoy+IEgwKHhN8NHKFIUq0Vt3srwkf2ttcLoURlY
 hzNAvymcd6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMviBAAKCRA1o5Of/Hh3
 bbMuD/9ibiWGvzvApY+fBVKhaZM0LGqn9Oip3ni+snNHPdKRVDyLJYlTgNXb9V8vR6ip/8XAKKO
 D5uOPpwPkJyt3WMpHIPyWeQudIgJv/8b4id7rKfTuxsclBKj7N5UI8wjcOa2rrf3Pv6S7UeHN4i
 kgsfcHQX53pFlNwCxwgBLRYRKcgxiLKAg6fDPpoAMLQOqigGqBYNqMmVEAqygaxf2yEYxlI+17i
 kK94C+s4mf94LOER7dFm1XOGCXRPMhltb33JaTSWDY4XI2OjEqKYBKYscaEzTLurVY+g0/4YkF6
 4YeD1VanH3qOqcDy+we+OVWpAOzNPPQOwZxOZVWKBl0iyaylbvKSKxAizn064Z5kMam4/2RMD+x
 5K5jGiawNdojFfxsooK7EFnU/zyuT1GBHWiyCCGRn+cnS4WTP3V763y+z4177HWjd+uLFPvzGbb
 3O1rnUR8yWWlz2suewde6z+rlAP/jNqEmtxSbVYcI/1Kx8mzRfbmnfWuDpmMwvYHCFnwLYkbG1a
 wCaE7EHZorMM8sEvNxQec8y3q4xhA5++EIyTjw6LNLbojYMKhryi5Hg8XVb2P+eqrKvLIXa3PiN
 AkYP1DT0t3kdEHxxPZ1UYaVYpLlkUbIQcZ/gdcKsHnJglQYyTaHOM7TYxdGQ3Hh4QerpCPsDmxz
 P3bTQgr+qMJ6wCg==
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
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++++++++++--------
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


