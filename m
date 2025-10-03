Return-Path: <netdev+bounces-227750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7934BB692C
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 13:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861AE19E5831
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C992BE7C3;
	Fri,  3 Oct 2025 11:57:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83D28BA83
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759492645; cv=none; b=dzK80oaNm56rNdg/6y8QCca+dForruzF58kW7XUIURp/b0hKGz13XaHkjMZxbkSYpfMTXgVLWQW9slHS2U7besNKI9yKCQErd8X5pw3RKUYyLlMgoCJyUtcNtVap9TTGfP2UAxfxN8SIns3EYbeuFvUCtYCqNDkl5MRCjyHIsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759492645; c=relaxed/simple;
	bh=g8Rymja0V72nq6OnDIyWQadzgQlOQaCKBNDvE6hktyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XX70W+Z6kvpaUgmybrgMYmunHsOa8FPwrW1ilB81uO1WYZ8bPhVkwVUQinmAGv69rhaXbgDJYxs37d8FB6SPKufkQW/kwdwehBeuQA+bjAG8r/eDAlSo9T1kayoJOrLnDnqcFW2LJWSubY4zsD8PH7o00+LhpBbCIi3E6Yax0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso5051478a12.3
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 04:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759492642; x=1760097442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hnf8G2/o1fozlbYtBL0vduYZr+SYz2Fp67m1oGmqTd0=;
        b=F9OLXpDVjvjbIkwgjwKnK9XDcNd59bveVlq44Q4UwLcc/yVAwMbKvXDy/n03aTPZYC
         XJoqqQXZ6I7bGHm8topGa9dEyOi8SBKQ8Rwo2PVXgC6Bk4Le4H6Yr0slYUGFqGnlitYU
         23+JYcQ85wDXvbEC5oYpuSeLJebgB4eauPPE6NG8pKW73VXrdx4ks7iWhY50hTJx3ESh
         qY7gTIeibW+HR8MDq6R1FYUGyI3XXghQzVyXw2k+n6nLf/f0NrvXawMvKwVPMnMOmth8
         J2q4ytWnnqknwrOAzmnrm7uEe5qaOlbnLm21ZU6OdhojsfQK4yAdhOGZioFBTcxAf5N/
         7x/w==
X-Forwarded-Encrypted: i=1; AJvYcCW8+rOjDSps6aqTUyBU44NAucIlcZbtgKK+WE9ny83DpvgRt56jKe4hPq3GxzE1DrmsClSkVqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/CN9fTx8lkAwU0t8OCUnMa3Yu0TTx+oLK1+rrYL4JyOLPeR4B
	0BKwxNhuv0jDL2BYdcNnLMhGxqzzMbueJfiC+azsOm5C+/V9ACpofebUIo7R2w==
X-Gm-Gg: ASbGncvyzRWVdoIIoZ+xTcuV8Xf5cqlb8ijBG4Id7UVSPtT3FCswx83OZyhZ8zMZxfw
	LbwEA0HPnys8789Urn2G3GHsUbs+eptYewWE8pWG7N8xvNRot6P5HZQwa9iNLfZp2rWyS7PT8Ym
	SKAYvCz6qv1PXvOIbf5FsK+9QNpz7mz0sqFE8A0w0JdKqBLhYvoXZbqstWMyS6SnkjkfEohrAXq
	WUTKyXxwwJYPcjCZ63VJ7WZtcGtQ9eI3Z3wrbm2hM+nZSZ0t8J838gngKehuCofH2Yp8hy7HSPP
	p0bkyKWCw5a28zxdAdUKfmXEzjSNGcfpUGVFfquKaflY4q7XTzToJZeOLLmlrVLDKHqMxmwMaZM
	CyGe75OMk9aj8wI7r5GQxehftgVg8VK+Jdep4NA==
X-Google-Smtp-Source: AGHT+IFe+e7BtR6KHk8+3xXfcyL5nJihXhgLVyegD/fHJ6X33+sQ2DypzZV2awvTjaBOoEGaQZ2YyQ==
X-Received: by 2002:a05:6402:50d2:b0:629:e50c:b058 with SMTP id 4fb4d7f45d1cf-63939c2348cmr2890100a12.28.1759492641821;
        Fri, 03 Oct 2025 04:57:21 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffdf7sm3960903a12.28.2025.10.03.04.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 04:57:21 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Oct 2025 04:57:13 -0700
Subject: [PATCH net v7 2/4] selftest: netcons: refactor target creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-netconsole_torture-v7-2-aa92fcce62a9@debian.org>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
In-Reply-To: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo37odeOah+/XaoNPfaLxvw310AnBgjuhJMREou
 LmSJh7sbpuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaN+6HQAKCRA1o5Of/Hh3
 bXXTD/4iax2NkJa3PtFgrzOYfMIn1p+/F4yEva2mj0mIH4fP/l1GaLlFdOlBq0m+5IyRyLF1TJr
 xsorqbc1PD39f6UfY4IfibeXbeewQeCH+Rdx5ml/2l51tHYaMEYF7Mzyh+Nr9mc1MMHPGHIijzq
 MgY8dE0n/hTLqRgz0o9PgLqDYGJ6XHpV/uvFLX4AcnmqQSOta0cMuOCzPIHyfaXTRwm/Yln1yix
 S8EtnIzERcooSYCWaym7aDo7u/+4NM/kBVl0Bua74lxwJTydcW09rNhliTngSXkAq+7IMSPXGQe
 iImck6h8EdsZlreu9EVxoNiA5bsxNDkBbdCOoAvdCOH5LDSYL9TU8C3QSitYd9Uln4KIn11tpNL
 dQ/RbZJKDjcmEvopW0mdedsSubukCi345gVmZ53zF4k0oylGTmotV9jq3WgqjNT3ZLE+7lWtyYU
 547e8YqsZbOvhxfRft6UPbrLOJ2dE74YzDitOgETUnuDFuodcneXSpIrXUA/xSkrDxq5YZvi13P
 CbtYQPZ4lyB39jsL8aaItXzlNLRj6TKMQerlw+N+pC6BZZatdaVKWcJDd1jOk3Dc3VR3UyJZoZh
 b5MsEkFdfmDpufKQ3zgXdYt/Z9tbS/frNcGGDyI52nVKNJRlIPGXHeUNWP9a2BixrBmONqqkbTW
 sRU8hz1A0jg1z1A==
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


