Return-Path: <netdev+bounces-239451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A28C68872
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A50F94ED45F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5361312820;
	Tue, 18 Nov 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wSj7tz4C"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A9F30FC0A
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457980; cv=none; b=XKvo5duOUJjJeo6cNLe1T1HwZsQPx6lK1lRP1KyxcIQ4dsZgm5I9+cP8D1naLPMUlvTVwabN0ano37AHp2oVGd43nD9OWVfMV85Z5JkfiaKyB5y/6rTEfeMd6ED+HzZRgkwWYfQMHyR5rS03oirUgrurmJZsqgqC2jvQzw5nL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457980; c=relaxed/simple;
	bh=a3ozMkFpQVb1x9C7JpLZzUDyGA69jVmBVw7CtNVSaz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxw2g+4Cp3G1eJcsV/7xvx+JOB0itRSR4Qky7KElR0yztEpqAlUjf8gFCeXIzBmkLIlgY1xpql3BDxNJZP33xOF4T4nIicUPTfp+Mllh4anHiee+YNtN60vUfQjJowTaZSOrKMWRVHJ0WWX5RrvJ4oD4k2qbZK7+ygA2IHYLbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wSj7tz4C; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EE3EC2080B;
	Tue, 18 Nov 2025 10:26:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Kt0LJeNCVkV; Tue, 18 Nov 2025 10:26:16 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B26B620841;
	Tue, 18 Nov 2025 10:26:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B26B620841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457974;
	bh=rm9SO7AwSck7LOTRIoLPV4Nif7mDFYoIzraQIEfhENQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=wSj7tz4CLspDD9mjUMjaJ2cC20weFFZuX10oZ56Hrf51V8wuB118zoi1wTF6S4faO
	 A4HEeZcc6I8A5PW0QZNyQVfHOU872G6ZGel18v6M+aTPiJlnTzsN570JiMFsp0CUJu
	 4U/vnyhZ33xws8cf9fjfNco6utIPLm5SeMkTOEnLhUFtrBr9b7r/CPCuQK1cqrGKHp
	 6wReDYcwtUdN9WreWvQhYMUYGAs5TKGtuey4u+sifyZ/hQvd3yMZUMzEWp7fnq6kgq
	 I0IFeNTnu2exk/FQ0OTR91i7D0qAh6ngw8xd5BInaKUQBRyMaioq3ckbnQOS0Zwhl4
	 9t03oKV6vngsg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:14 +0100
Received: (nullmailer pid 2223988 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/12] Documentation: xfrm_sysctl: Trim trailing colon in section heading
Date: Tue, 18 Nov 2025 10:25:46 +0100
Message-ID: <20251118092610.2223552-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118092610.2223552-1-steffen.klassert@secunet.com>
References: <20251118092610.2223552-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Bagas Sanjaya <bagasdotme@gmail.com>

The sole section heading ("/proc/sys/net/core/xfrm_* Variables") has
trailing colon. Trim it.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 Documentation/networking/xfrm_sysctl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm_sysctl.rst
index 47b9bbdd0179..7d0c4b17c0bd 100644
--- a/Documentation/networking/xfrm_sysctl.rst
+++ b/Documentation/networking/xfrm_sysctl.rst
@@ -4,8 +4,8 @@
 XFRM Syscall
 ============
 
-/proc/sys/net/core/xfrm_* Variables:
-====================================
+/proc/sys/net/core/xfrm_* Variables
+===================================
 
 xfrm_acq_expires - INTEGER
 	default 30 - hard timeout in seconds for acquire requests
-- 
2.43.0


