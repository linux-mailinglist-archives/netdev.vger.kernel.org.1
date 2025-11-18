Return-Path: <netdev+bounces-239462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB68C6886C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 456372A8E9
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE713191BA;
	Tue, 18 Nov 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="yo5O1x0q"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6F2F3609
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458050; cv=none; b=R67OyWGDnn53WT/mszwQKuZ+BJJYFPQCoJC9zEL+7+GJYEbL51ecIn3q68+WAXcIAN1Ue9Rke/YmBoieXrO/90KVKvaV4laKZIQTjz4n4yxs5DodKe4KFZB/R0Mx3eyLVEi5wV/E/JcQJEup4Knf5kb0ZQTv84dYnALa0f0hsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458050; c=relaxed/simple;
	bh=+bTVZ0QwrKMS3JoK1l2ncqHAfZyfu8xboPz/eSlmqS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J21W4FTNVBLY++ZPaOKM47b8oSz2a6pozQpoVQn1GFvZUPF62Y7tXGEGvN6btakYwBSaswDZaHY1mjBxftzbg81rphlOIF3RT6TmXVH6YjKK6uMZRjIBe1r5fGKbSxeH9+oElnw/c8qh9iZ+wuU0LIMYBj5zvLp9HXiC9FqnGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=yo5O1x0q; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EDFA4207B2;
	Tue, 18 Nov 2025 10:27:25 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uWQRjws6vCFz; Tue, 18 Nov 2025 10:27:25 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5845B200AC;
	Tue, 18 Nov 2025 10:27:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5845B200AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763458045;
	bh=sqmOy3XxzaKYlpgf9I8QjQOYQ+ZAst0DlvWwL+0thl0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=yo5O1x0qwIW8sKZ6rL5yP3w3Q1vr38Eq50+AO/xp1xQhLrusMhTy8zjLQitFctDCK
	 63eSsGTGec99K9O2KcSfH5PbImkX29AP+VvK2FOktaf7MzgctRUdYvMMe5CwkYVJYt
	 754P0zsWwLqJO0ICFF1JwWhfdPbx4X7maDNJ9fdPHMq3SP/p1IbbYNcPox39n784hB
	 o45hvzMp/5Nly+Ejm5lLUBrwuEWkMxdJxtlHt13wqyafJmvUeFWpBRbK01buP5vvjY
	 u2JSzKIJyqSeQdlbZTsDE+rHTHm2y+O4Yl6kDFUI39PA9amKfaPPX1Hg0EAyX8Ei2D
	 pE2qjntdcez9A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:27:24 +0100
Received: (nullmailer pid 2223978 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 08/12] Documentation: xfrm_sync: Trim excess section heading characters
Date: Tue, 18 Nov 2025 10:25:45 +0100
Message-ID: <20251118092610.2223552-9-steffen.klassert@secunet.com>
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

The first section "Message Structure" has excess underline, while the
second and third one ("TLVS reflect the different parameters" and
"Default configurations for the parameters") have trailing colon. Trim
them.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 Documentation/networking/xfrm_sync.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index c811c3edfa57..de4da4707037 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -36,7 +36,7 @@ is not driven by packet arrival.
 - the replay sequence for both inbound and outbound
 
 1) Message Structure
-----------------------
+--------------------
 
 nlmsghdr:aevent_id:optional-TLVs.
 
@@ -83,8 +83,8 @@ when going from kernel to user space)
 A program needs to subscribe to multicast group XFRMNLGRP_AEVENTS
 to get notified of these events.
 
-2) TLVS reflect the different parameters:
------------------------------------------
+2) TLVS reflect the different parameters
+----------------------------------------
 
 a) byte value (XFRMA_LTIME_VAL)
 
@@ -106,8 +106,8 @@ d) expiry timer (XFRMA_ETIMER_THRESH)
    This is a timer value in milliseconds which is used as the nagle
    value to rate limit the events.
 
-3) Default configurations for the parameters:
----------------------------------------------
+3) Default configurations for the parameters
+--------------------------------------------
 
 By default these events should be turned off unless there is
 at least one listener registered to listen to the multicast
-- 
2.43.0


