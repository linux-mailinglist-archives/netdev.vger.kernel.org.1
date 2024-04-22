Return-Path: <netdev+bounces-90201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0D8AD0EC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E3828C9C8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE69153578;
	Mon, 22 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wsH5swK4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3B7153564
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799992; cv=none; b=AjFcDi9s8YUP2ZsUcjNxfa6VEUmUwEvLkLeqfzdsj1VncZicSB/DuWKH1Y+Kiq/c6LfPaeLuDUSKRrmb6VXn1v/4t+z1oV0MBepfyIBrg9mnUUvqvPWjtDoucLalOMI/GUodvWU5Q3VW/KeDavAx2qpJW74Lu3Anrnc0PTRWibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799992; c=relaxed/simple;
	bh=skJZVZU2JBI8WGJ+4NhCiFRl3ZLQsAGK0b5U2Pn3qOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2kWuXd+NvnDGZNqmurw8R1cAZfhUGkDBpw3aDMaa9jq9zo+74346okqs/KGkCPXOf8bl/cjkkS245W5t7XgCoqnTDOCO/pF6Hp8OhVb1+qQy3wNDhquo+e76ulQdpFW9fqrWrxgQJT97JFWMpPnPpkQqtiuHECalXWpW4ADvTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wsH5swK4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57215beb016so444476a12.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799989; x=1714404789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=wsH5swK4piHxAh6vBXou7KBNbBifNwiGDOD2iA7orZ3u45elB13lq7kbtxvLokmHON
         Pv5aHSmWqnjGAmXikpBEmVTZJjrPQ+iBDFysKzf1TUaDpbWUOLDJvmk9PMIL1uzxqCE5
         oz3yQHmQKaqZzteo6YCB7iGDQvpV3MBzUmkYAzvlwBg48XZq8Qk4lNHDK2UnWb8ulAgK
         UNowwB3N2Gfb9VCAvNmtJ/yf8SpzkutOSmuyNw0NDh0BrNgjUwOj4ZACNIWcKQgaNVGR
         P/IkVh7MP+Kd1IO0AG9zSbdPdIQnH+f3qlQsvv0EEkE6Nk1ftTEaWwvHNFKZsQ4NITV1
         Kxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799989; x=1714404789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=iQTxNqpRGxPKX1Ys5amVNqrZCk93dWelpxktn/j6I3qoAU6+v1CCACjed7HQYJXGts
         HnksZSrolmi9isA6bvo8Oiz0kwMxjMtQyfN9UaIefO0/4ip9WFEfIAgGCYYrYGDN88ZV
         hasw6zQbgokLbLGIzGR+p6Kzzxumll5fQUh2MTZnOBOzkk+073Ta3mPupMvJsSqPetnr
         m4crfUHjqnlcksfzTPOAdwHyVyWDZAAQRCbIFLq/J8Q2r0NiQMFcCxZZJR2J+1P0pnEb
         dAwSWDMvSUBDLkJtrEmnMQ8VXf2jn4Rp+GLQE3EVFbhJPW4VfkWksvx4EHUYNJ0boaI2
         xYQw==
X-Gm-Message-State: AOJu0YxwOhAMrzmRYBOpd/1DAiTmT37Ar1R11dFDLcaTkAu4DxnZQYY9
	KRQSuepPLtVvXQBys6OrrXYc35mjoSDL29EnAX8blZ9wX6usdNE+79H4rttM4pQXp1UXCbaH7z2
	A
X-Google-Smtp-Source: AGHT+IHiS8PFHdDPbSER4uV1DnQ3cF2U5SMqkAyux8sxGiCt0YEkFKykDoxzO5Jsq4lWpSkPyp+UBQ==
X-Received: by 2002:a50:d4d9:0:b0:56e:2452:f864 with SMTP id e25-20020a50d4d9000000b0056e2452f864mr7375041edj.35.1713799989283;
        Mon, 22 Apr 2024 08:33:09 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b005705bfeeb27sm5619252edb.66.2024.04.22.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v5 3/5] selftests: forwarding: add check_driver() helper
Date: Mon, 22 Apr 2024 17:32:58 +0200
Message-ID: <20240422153303.3860947-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418160830.3751846-1-jiri@resnulli.us>
References: <20240418160830.3751846-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9d6802c6c023..00e089dd951d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -278,10 +278,17 @@ check_port_mab_support()
 	fi
 }
 
-if [[ "$(id -u)" -ne 0 ]]; then
-	echo "SKIP: need root privileges"
-	exit $ksft_skip
-fi
+check_driver()
+{
+	local dev=$1; shift
+	local expected=$1; shift
+	local driver_name=`driver_name_get $dev`
+
+	if [[ $driver_name != $expected ]]; then
+		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
+		exit $ksft_skip
+	fi
+}
 
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
-- 
2.44.0


