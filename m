Return-Path: <netdev+bounces-90015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA78AC861
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC71F21492
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C561422AA;
	Mon, 22 Apr 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="LluJOyAc";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="YZOEyYhW"
X-Original-To: netdev@vger.kernel.org
Received: from e2i187.smtp2go.com (e2i187.smtp2go.com [103.2.140.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D214198E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.140.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776679; cv=none; b=rgZJ/z6ADlMXG9wwNSPOH19VWUGgNUjc9LbX++mV7rRWRsc+nkW8fNZyyZDLOZTGxqnmTN32O4fhXc+YkklBoAS3rh3qlNkYFeeMK1bnC8DvLVhqrvid9u7o+iUp6xxterayONFdbV4zcYOrAaQGMaRWZnwawpLPnoKrlUgcW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776679; c=relaxed/simple;
	bh=9KenQqv+kO2v4o7u59XGlbKR3pxTieI8phIko3F9f8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LWGb+TUVpbeB4K9aqvKG9n69Guv/PbxK1n2kd7l3+iSngVQ4GyrHp78pUKvkMgmjYq7tnFQRpaNlXb/iDgOk/QxKo1diBaYVdyIHxWqYmKP0QPw7K0LqwIj44BTFWobW2pa9ANBQc/PBVKuX9gFi+9XBEmdeZVqAX+Pg7BEsu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=LluJOyAc; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=YZOEyYhW; arc=none smtp.client-ip=103.2.140.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpcorp.com; s=a1-4; h=Feedback-ID:X-Smtpcorp-Track:Message-Id:Date:
	Subject:To:From:Reply-To:Sender:List-Unsubscribe;
	bh=epoZd4VyEro9D8FxheLPEmd8Umgh+ceKjCcGQ7KG1F4=; b=LluJOyAc0sc9a3/E8j2To77ASS
	keqBXLWH4tbkV7In0S4InMtebXzle6xIJJu9NctuUfbKEtrLtnZ12k5NYoN3shqiBADPnjd3C0WTT
	2qWwjIXNXEjumg7zEBDkKKZCo1b3sT8vIDhrHdrLsu02i0UE76SypYtY0/b7x6xcD0/E1gvBViuA1
	+D0ChgMIgotOZ51xONlZ9XP5ZDTxdDapjq58o6zSoGVKXRjzNEzD0ZbHXS7nJVkWTbhNnCdeRE/su
	Cg/+LStIImhWp3UEXBTjmbSisctHofa2fRR1F7yRPBiik8FfBaoD29kaWdzLAQPIXDuHZNW6dQHrv
	SFfrsdvg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713776655; h=from : subject : to
 : message-id : date; bh=epoZd4VyEro9D8FxheLPEmd8Umgh+ceKjCcGQ7KG1F4=;
 b=YZOEyYhWdC1Luz4WmTkpcDRfgXj8bl+nlmX0OEEI06RO4bUJpMiMXyXTgLLYTZNlizelR
 VV//aGLTQBfpMwsuPXOdr3bPlOQ1yGeeBLHTPrjWomB/0AmrlvhU/K10VS3zNMrGYuWr6Ox
 FLxvTO+cwAnirdJSkvdDN9rDzNOdbv281FaOxA0wKu6XPIbYgQYANdmBxx+k2rYEhmPamu1
 4f1xpLaQYnjNUSHa8ezRB9Tj8pWt3SOCfpYWWa3/mzGhre97avPHyZIu/Kpuap6i4CYnf/c
 obqjYdK0gshxET2nP3VmoFYrQcXbOFaYD3wMPn4Fu9m4kixGsiZonA1lc+LA==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <f.suligoi@asem.it>)
 id 1rypau-Y8PE26-Rt; Mon, 22 Apr 2024 09:04:12 +0000
Received: from [10.86.249.198] (helo=asas054.asem.intra)
 by smtpcorp.com with esmtpa (Exim 4.97-S2G)
 (envelope-from <f.suligoi@asem.it>) id 1rypau-FnQW0hPpvx6-g4B4;
 Mon, 22 Apr 2024 09:04:12 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with
 Microsoft SMTPSVC(10.0.14393.4169); Mon, 22 Apr 2024 11:04:08 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 4/5] arm64: dts: qcom: sa8540p-ride: remove tx-sched-sp
 property
Date: Mon, 22 Apr 2024 11:04:01 +0200
Message-Id: <20240422090402.33397-5-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422090402.33397-1-f.suligoi@asem.it>
References: <20240422090402.33397-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Apr 2024 09:04:08.0980 (UTC)
 FILETIME=[091CBD40:01DA9494]
X-Smtpcorp-Track: trBNRrrveXic.1sKkJnrbBhA6.HeHjuQAZirM
Feedback-ID: 1174574m:1174574aXfMg4B:1174574sZgEaNysWw
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

So we can safely remove this property from this device-tree.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---

v3 - Added history, as well as in the cover-letter.
v2 - This patch is the 2nd version of a previous patch, where both the DTS
     and the yaml files were included toghether. Then I split this 1st patch
     series in two, as suggested by Krzysztof.
v1 - Original version of the patch where, in addition to this DTS patch,
     there was also the one related to the correspondent snps,dwmac.yaml
     dt_binding file.

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 177b9dad6ff7..11663cf81e45 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -225,7 +225,6 @@ queue3 {
 
 	ethernet0_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
@@ -302,7 +301,6 @@ queue3 {
 
 	ethernet1_mtl_tx_setup: tx-queues-config {
 		snps,tx-queues-to-use = <1>;
-		snps,tx-sched-sp;
 
 		queue0 {
 			snps,dcb-algorithm;
-- 
2.34.1


