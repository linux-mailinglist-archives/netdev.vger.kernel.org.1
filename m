Return-Path: <netdev+bounces-138161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE519AC71B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A94DDB21F32
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA801A01B9;
	Wed, 23 Oct 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDH47RRC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61404194136;
	Wed, 23 Oct 2024 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677276; cv=none; b=rvpEE56LXweIYvH6fauozuMH6m6cKDkgvpZ2DBm0AYRDRzc240cc8m3JUldVvTSl/EnU+QYLERPr6Y/6Rs7azJVcClqXs1SFMlmIN/fxfUZ0pua9J/h896OUHAjIuptQNPt4w+nsM0xwXEoCmTfO8eTOuCa5dv7SP9EjTdVa8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677276; c=relaxed/simple;
	bh=QonsRn9UUYBCVKXdMXZZDVwET4/jsEve5vP7nGMrv4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwk+uBCi8n3g+0dRq9o9d4bQ9wVolUc4FnSR8rSkClXcXFBQZTmx7wxLg5B2JCLrvy+jxlu9QaKkVMMR1hk1WV4sWIEq6huJZKJh4IDKH1ffL+neKGd/DmMGFfQX2L6etGxloQmRoghlaG6MI2s7KPpWRZ/HUeYePflaTqjp3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDH47RRC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729677273; x=1761213273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QonsRn9UUYBCVKXdMXZZDVwET4/jsEve5vP7nGMrv4o=;
  b=EDH47RRCxWWw5LaFs4ok7u8KyeruBv0JbdfcOVzTqK5MGlzQf8uIxIP7
   IQdzjfybEkQr9aRYka6UQHLGZ7GP0C94MgRJoGbfw99vq/BmmX99jKYKp
   QFhLP5076soNSJ6W8oEwDz+eu0nmWd22Z6XJPOxsrhLd6Zg7m7gt5Od9h
   1bVh98s+4muf3EDOH4KOWyiLp4vjltuuEl9HmyPL/KRcsw1a/3GH6VO2s
   3vzuKeNi83eKuddS2Jndp5SVpa5+G0UuCytMW/MYFhZDdyZfWH7EOSeVG
   AU/A3DoSQ0hnbRx+0Qto4WXYkDVgAm396fAad/PWu525xT/CQuSynpvjb
   w==;
X-CSE-ConnectionGUID: 5O5XKdukRs+KPOk2dTw1WQ==
X-CSE-MsgGUID: xr6XwJNmSd2eVN6Lco5M7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54658354"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="54658354"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 02:54:32 -0700
X-CSE-ConnectionGUID: Kvwn5bz/TBC0+i6jazAi+w==
X-CSE-MsgGUID: u8SITGVSTbmrCwGjOTaD0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84771109"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 02:54:29 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D5E1428167;
	Wed, 23 Oct 2024 10:54:27 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-next v1 2/3] devlink: add devl guard
Date: Wed, 23 Oct 2024 12:07:02 +0200
Message-Id: <20241023100702.12606-3-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241023100702.12606-1-konrad.knitter@intel.com>
References: <20241023100702.12606-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devl guard for scoped_guard().

Example usage:

scoped_guard(devl, priv_to_devlink(pf)) {
	err = init_devlink(pf);
	if (err)
		return err;
}

Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
 include/net/devlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 7f5b36554778..6fa46ed3345f 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1534,6 +1534,7 @@ int devl_trylock(struct devlink *devlink);
 void devl_unlock(struct devlink *devlink);
 void devl_assert_locked(struct devlink *devlink);
 bool devl_lock_is_held(struct devlink *devlink);
+DEFINE_GUARD(devl, struct devlink *, devl_lock(_T), devl_unlock(_T));
 
 struct ib_device;
 
-- 
2.38.1


