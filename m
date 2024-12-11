Return-Path: <netdev+bounces-151242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA29EDA02
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D6D2823D1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29C203D7D;
	Wed, 11 Dec 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGCc51IP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F37203D42
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956361; cv=none; b=PwYlQbe8/rJ0UgXiN4vHvpCepzOYp5YTKxFcTtrEsJTY8rBOz5fSyMS6wsS/98bCvSAzDMHGGxB/KWNi4aS0mMI4EFvXx5/MRcRlM74nInXOCPg9U+nPZ4UUQ7DxeZVzoVIODw/TtX8MfQOvOMgDzVOmSSFuF2LPKAhswFQzR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956361; c=relaxed/simple;
	bh=v1jgyJaEIdY+KSakjWhz+KYH00QDygQdpDx5SSwYOh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6n/mXTSYz3KsDA48Bg+0LbQg1aFHANxSu+mE5Tqk4A4NXkCgDhCYJ7N5LR37xyX4xjUclS3QldjG8I6NdRPLjcwliRMmbkub5Sy1GXdrvvFy53xyo6/ew4BQoHagR9T8gCZT4d8cBryb42aWHviZfzN3VNAzkTYL+tazCKOMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGCc51IP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733956359; x=1765492359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1jgyJaEIdY+KSakjWhz+KYH00QDygQdpDx5SSwYOh8=;
  b=KGCc51IPXqTWvtcvHC5lJk1MbXRu2tAU9YjmDbZ+MU3puLPB2To0tfKR
   jcPKpfLccnqsPe5AqA5DznabxtoKel+7AQheNnvmJ5xHbqtig/alWIwK3
   ljf8D7F/0u7w8TBwUwHp8oPbKRrIDLrzYZfC1Y2IbKweV6pVD5wIWANvN
   RpnmnzkZhSggXQ6lwlogriA5H8M9G5sp/DBIHuflHfu0YO/33nGn/opZZ
   aLecDjNh7K+6M7VRa+14x3YPKnuatfuyMkHSrS/QXBCFfENcciJkvZYkH
   oyLY5dlFaCE1aHRc0jCogFtDM8Sl2CxKunXIkS1byjvLOjbPLckSC/vYJ
   Q==;
X-CSE-ConnectionGUID: EFrb9xyVQdyShBCGm/F/dg==
X-CSE-MsgGUID: u6YzX9cISCGHRH1TCybXSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34599599"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34599599"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:32:38 -0800
X-CSE-ConnectionGUID: kbylXcSqQ0aOWpGFRdXOuA==
X-CSE-MsgGUID: jnmPdLJZQkG0u1fzehHmBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96192924"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 14:32:38 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com
Subject: [PATCH net-next 1/7] checkpatch: don't complain on _Generic() use
Date: Wed, 11 Dec 2024 14:32:09 -0800
Message-ID: <20241211223231.397203-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Improve CamelCase recognition logic to avoid reporting on
 _Generic() use.

Other C keywords, such as _Bool, are intentionally omitted, as those
should be rather avoided in new source code.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76..a2066a6c9dd8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5843,6 +5843,8 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
-- 
2.42.0


