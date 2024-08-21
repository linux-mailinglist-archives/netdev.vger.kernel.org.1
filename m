Return-Path: <netdev+bounces-120597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8CA959ED9
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B4D1C227D3
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300701A7AFF;
	Wed, 21 Aug 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtMAH+1a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CC1A7AD5
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247457; cv=none; b=i1bLisaOmW/5N/+zITTIpGt+LigLlKWb0ba9kz7OFj4glTfDrXGlzx0mLWaLmd3UDbtNZ+h9PA1kL0XgGJugnIncCRkV30iEwPMX3HCdp5zBW2hEKo8Q8wd63c8pbJ+MbnVGueJR9VvSjAtz6wqjs2JYqKFUr2TUCG2pkIe7TXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247457; c=relaxed/simple;
	bh=C8ttAvSNO0SlJh14VqyZzsFEn/LBgTrhy1JJwP90Xqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7AMDUEpbsTJCeTr7Dd1kp8wvSQxmKig9PVhAFTw1MrcH2AUW3AcMlqhiJTFggRCnIMNCQPXp90EWRzUvUGnsa+aQACOdZ42SrfBztAmQ1sgGnt4nTz3siuksrI1SEzuhWmednkOaKRIwW7ZfnIZH5sWAihQ1cqF4nsYk6McSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtMAH+1a; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724247456; x=1755783456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8ttAvSNO0SlJh14VqyZzsFEn/LBgTrhy1JJwP90Xqw=;
  b=YtMAH+1aQoJxw9FDl+kNrP6slZpO8i/NiQeCEwcjUYfr1KJZfoAD5kyo
   72FP2U+X/KWrljW34aM+rab1UHQYRJPnGHf3UqwJTx7dUmtblKs7LDK69
   Agjhog+X97pcp8qnw0ZtnnKG4F++C2aMZI6QGNggxxPxJrIBWp5TxFnNA
   VYJjrDEBC5oicnnF6cGwV78iH5CaRhIaAnxqGcERmlzhNWb3aJ9S6EXrs
   CKEWbVco7lA0MaqBIk4Rbq1R0hVwwL/EqTDC/5E1nR/vqDgO/wYKn73Hr
   7QguvH2fAKIRmr3RNHsesNAvATCvUefmhIt2SU2afyfRvyE4G3nlbAyGE
   g==;
X-CSE-ConnectionGUID: qsy6KPSxS4eLafA7WsGrJg==
X-CSE-MsgGUID: KMDIyS4/QpGAbS0H9a0INg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45131421"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45131421"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:37:35 -0700
X-CSE-ConnectionGUID: fNRBsvOzQiqaDIwWjW+qyg==
X-CSE-MsgGUID: yBz4ED8wSNyTjDDGjTxQQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61071255"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 06:37:31 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id F2B782878D;
	Wed, 21 Aug 2024 14:37:28 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v3 1/6] checkpatch: don't complain on _Generic() use
Date: Wed, 21 Aug 2024 15:37:09 +0200
Message-Id: <20240821133714.61417-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
References: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve CamelCase recognition logic to avoid reporting on
_Generic() use.

Other C keywords, such as _Bool, are intentionally omitted, as those
should be rather avoided in new source code.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..d609d47144ff 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5858,6 +5858,8 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
-- 
2.39.3


