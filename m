Return-Path: <netdev+bounces-108861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A3F926186
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190B3B278B6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AD17967E;
	Wed,  3 Jul 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0/fLfYf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9C1791EF;
	Wed,  3 Jul 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012362; cv=none; b=VmJxWPgux6mKKLb8hsnoReJ+NMEmCkJ0jn+L8jBPThR+zVwaOAvnD0OoAlJg6fhGJsRaNNO9gQA1wn+I3ONUWxnaJUy3z+g/KHBDzRViAFajjB+oYIh9oHkI7JFOIO8hURBKs05eB1/rj2rJF1lvSnnJtxQ9CwlwdEB9qA7wRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012362; c=relaxed/simple;
	bh=yQu9fQgGjxdEvUh1kA9hqCIosvig4Bw04UCcKOaSYv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U46pbDPJJEC5nRzkRAmS92dRMZSB3vDOx9yQFfzx273a/i4yGPSvToVaBwL2WBLrJ+drB4FR54pmRZHZxGpSS9+ou+Vcb55CqASEHl9H0rpQ+nipjY76yRDcjvGZd4csZvLD8zuKU8m/y42gkNqx4JWFf+Hobln3Iov8kwxc0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0/fLfYf; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012361; x=1751548361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQu9fQgGjxdEvUh1kA9hqCIosvig4Bw04UCcKOaSYv0=;
  b=T0/fLfYfFsvETaeb3m5bEhLD5FUlR3RPqwGSsQK4LDDRX8RncoyNuS0H
   477aHpYztmzU1KP+zRMXTvPB2CIE+BeERg3Nki10MUek/AQXaLwTeUjXq
   sKVmXWJjm6MZFX3OSir/8i2u3sMMCup/SboiLmnjD86KbvZJ8krExaHqk
   +If5ZYSYRyI2epYt5SNgbOoVSIADgG53vfA4fetBuIFjiS4+EFkjIla3u
   hWRXRMrLKWke2tmh1ZyVKmCupox+XaYBUxKB2IRWVnk8XllVGHGsSEpZ7
   6q6WtUNbOTZgAa6Tg2jMxRsrFgGmQDiveMrOi6IRcsQbBu2Vpac7B12jE
   g==;
X-CSE-ConnectionGUID: Du/mH8BOTtKkUB8VxgPAhw==
X-CSE-MsgGUID: mzVZvABeQHWwegylsHc46w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27857086"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27857086"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:12:27 -0700
X-CSE-ConnectionGUID: sQdj08F3R1OxeWP/o6BN0w==
X-CSE-MsgGUID: Dl8G0ZMOTm2121fFamINmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46321548"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 06:12:24 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 04DDB28778;
	Wed,  3 Jul 2024 14:12:22 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/6] checkpatch: don't complain on _Generic() use
Date: Wed,  3 Jul 2024 08:59:17 -0400
Message-Id: <20240703125922.5625-2-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
References: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
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

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2b812210b412..c4a087d325d4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5840,6 +5840,8 @@ sub process {
 #CamelCase
 			if ($var !~ /^$Constant$/ &&
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
+#Ignore C keywords
+			    $var !~ /^_Generic$/ &&
 #Ignore some autogenerated defines and enum values
 			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
 #Ignore Page<foo> variants
-- 
2.38.1


