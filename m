Return-Path: <netdev+bounces-235558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00374C32622
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E6423279
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27633C50C;
	Tue,  4 Nov 2025 17:37:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DD3385B5
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277839; cv=none; b=O+3LOLAGSSZm44QbuXNOZoYgp4CdLEVCjy4ApRF4R5RbxB+lyyXPhmjnD5f/OyjMJjYqarqEh8WLTKujxHQz5bIRvZYNCj7C8q134iX7C80FKg75llRk5sG1XXihnf+7rql32swk3SQ2pcNAwMieOLdBQ7rn8JFvmdVBGa0kkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277839; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZPi3X12LeW8NkGtgDl89RsB2Tc53oEUhhlFYE4pM2RD1gBjgdHdWBoO+qZbV5F68iWhCMMkQoXYHT4jsXuTDNANvNjOZW6JB2g45Gl51MR/zflLz44Esf1PplLpZMzcxYCEiesl1RsyHEWXK2A0g+O3BjP6JGkFzOTvPaUs9z3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so8236546a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762277836; x=1762882636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=VzFNrZ2pIEBO27RhukPRZoy1aLy6JXO3g2cnnKD6HHhQobev5wLkIxtgYXtoV5ftgG
         b+MbM0N8UYwnLLQnBK54DK4Iczpm1EY9zZv5nm6WH89UhhG6N5gdtFFsabOAW/YJM6m3
         ccj4ndz6JoHG6V12MsctBWz81z0obsxvneh6eOIi5H9IeCmtPM/rgAJTIjMITfWpvKPh
         RlM6awmKXEyqrbK2QUtcVz9Pu6DWPLnDgzGBKtoGhjGBidaVl6Vk4ieaqXvin7FKF2rB
         Z19elSQW1OBAEnNNgR+kDTnWz9c9rwNMJkLU3kkQ255Xyq+OEXgBSXj22U5ALXI7l9iu
         nP1A==
X-Forwarded-Encrypted: i=1; AJvYcCVsKCYal0ldN/K2DJFyYAOtvhm9esolqMP0O/bLI8yRxmISnuhYe3zt3KRTc2CLDWTDYF7hNng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYDcDmWv0jcDk0AxgPxcDREq9xWLv0RM1FyFKLA5SHKAufykF
	+Wq8Szm3ekK55oT+XteVO2F0uLgtiCmzTbd5Ak8AD+315CxeOM3bJl9P
X-Gm-Gg: ASbGncso2JxOXiaGHwiNKY5ijV0AuzXrMdeclJKJZg7IBplMaU/l5672WDJ/YfPqjDf
	LUoPGdCLTrM94LHUYf6HMNaedOiDKijHXr0EE6ZXlYMVf9qdVnmf1uOdd4mBtGPi+b2bCk4wQmF
	/8XPB68uvy4joW4WXMQRVTJxwhTniR7rQbLOdZXlQvhTgMjCAx6UgueTk4MEk8L4h+DGVUABRdm
	ArvUXESMkVw4WZyy/Sed4PPyqM+7UeESy3PsI/F1K3/YKqwCOFSdWeI1YZD0oOqAaeRgiSesbRj
	Qf1L/0XpPWdWYRJUclerNsSLZb8J4n9QoDt7H5DGumjdxEiwp3exL7FKkRqWUWYAIzeopDKX0Np
	lYsJ/f+Vr4jEEnqD4jt15o3Bjb0qHyjU2WNvPOy8AEsj15DtkW0KQbyljfK862OKkkoo=
X-Google-Smtp-Source: AGHT+IGyqhZnPAZs8wxqb5/9hR5rKWOTvfq4hgPumR/rNm1+T6y5YCKwl9LV+ZDez9YBKZSISt4tMg==
X-Received: by 2002:a17:907:7252:b0:b46:8bad:6981 with SMTP id a640c23a62f3a-b70701917e6mr1925813566b.20.1762277835835;
        Tue, 04 Nov 2025 09:37:15 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26adsm268280966b.43.2025.11.04.09.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 09:37:15 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Nov 2025 09:37:02 -0800
Subject: [PATCH net v8 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-netconsole_torture-v8-2-5288440e2fa0@debian.org>
References: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
In-Reply-To: <20251104-netconsole_torture-v8-0-5288440e2fa0@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpCjnHqDT6qXEqLTxwAX8xhl0e4iNRPUYiU746K
 xwQEgHvTCyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQo5xwAKCRA1o5Of/Hh3
 bVVLD/4hCI+77faS9q0HAjPcQ/c1iOqdLf4T98DLu6d3jyv+H3KLWbcLaB5urIs+V6mx72wMVKV
 xRvDqClh+6jVZd+01BWUnTTp4fUwq/Wb4BfRwxi2HfjcVCO1sV5zHhhBOO51qMXRmr6RVq/x4BX
 bGlw4ppnB15MPAQmHLc4COxXoN6JEpR3J9x6pL/KYthdKi07KT2viOYHOlUY+OVL4lhRwbPyntn
 3C4+H4i6tl2e7ifs2M2N/9PTZjhxxi1ITxrWRTXb5pa98P6my4fsouuQH2UdEEPSyZiUEbhz+Zu
 O91j3JnyypRnFnvJB/Sgncc6YXoFor3EvRuGg5BWapj/2LCEQnI5asxTcFQEvfXF0WPaZQhL5fq
 E4Rb6ypVwBR3AFzmY8WlqGqkkrTXDORcGfdfDsqCB4QlGgmA7wCZMrYsPm4Itb4IY0jvFtSED4V
 +MSS0dDheLI0iknsSc4NoW2uvju/3t77qsuqtSafwddrIedqb+ZtDmNJSUOQ0noDZBo740HbkWV
 qtILFVRhTFjExNPjxUzNdqc4qVxrNJ6rDNbF1VoeV4UjfH4mMkZZ2JHowrlLKki1cmJg9GJauWU
 ra9AzMGslC6yYw8QfAOeOszm3yvLhRWh730l7pIO80FJhA35MV82A7qeusfvJbdN+x/D/V7UZ7m
 cjiQ25budDdnXCg==
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


