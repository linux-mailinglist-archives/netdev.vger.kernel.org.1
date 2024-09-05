Return-Path: <netdev+bounces-125331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E996CC11
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A649D1F2783C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457B748D;
	Thu,  5 Sep 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="A3JUnKqh"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B347464
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498655; cv=none; b=Kp2W1QKqwYCAVu3t0Ie7wCoR5subXrNz4VemyJHlgMQjxdaFzz/KHJV5Q3J9PBYzqkOB6l8RqdoMnXGFMgqvU81vk2/Q9Q8nCeYOlArmKhQ0jnzIRdotP25yWsIm4QkxIC8gBhU/u2WqHcKo18EsJimGqqQBQRp/KCC/D692gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498655; c=relaxed/simple;
	bh=4COZQIO2vRuGzCmSL7tDE9xy6ioxi00OB4mSWuK+5dI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mF/Y1hV7CvTlXbu4GeRP7YgoALHySWJTXCmDZ/WOZiNWeZ0yhbmfZP8eancQZKP1Mt01M6ORJYzuBbK620sC5bVVudYVLtclOqVOlgw20Qt5meqX2XIVu4PTM7uMOCtXv4t4TCxaPHJk8yIlFTW+3xkE8skPrxwiZCxrb5uZkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=A3JUnKqh; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1270; q=dns/txt; s=iport;
  t=1725498653; x=1726708253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ukkBlmrwczL56501QLZWdDUSZiOk1ANr6A0ywAn8gqA=;
  b=A3JUnKqhJk24jQyLaUiO3awcT3SsfrvJQkOagLK5aVstanbgtMFdD48v
   DtjkZHvFFKW63tFkSYgtitt9+u42s0UjDFD1YebBzXM+Jiq4jdC1koYb/
   bFgLWtl73T+2VnsFxoX1bSodBxWBtr3yR5+Tz0wnettxvhc6aNghQK5sA
   c=;
X-CSE-ConnectionGUID: 6+UV6YlxTtKgtqQMPbCvBQ==
X-CSE-MsgGUID: rr9NJ+eTROytaWO4ObaPAw==
X-IronPort-AV: E=Sophos;i="6.10,203,1719878400"; 
   d="scan'208";a="339634104"
Received: from aer-core-3.cisco.com ([173.38.203.20])
  by alln-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:09:44 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by aer-core-3.cisco.com (8.15.2/8.15.2) with ESMTP id 48519hKH029102;
	Thu, 5 Sep 2024 01:09:43 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id AA90820F2003; Wed,  4 Sep 2024 18:09:42 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next v2 0/4] enic: Report per queue stats 
Date: Wed,  4 Sep 2024 18:08:56 -0700
Message-Id: <20240905010900.24152-1-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: aer-core-3.cisco.com

Hi,

This is V2 of a series that adds per queue stats report to enic driver.
Per Jakub's suggestion, I've added support for reporting the stats in netdev
qstats.  I've also split out the ethtool reporting into its own patch.

Patch #1: Use a macro instead of static const variables for array sizes.  I
          didn't want to add more static const variables in the next patch
          so clean up the existing ones first.

Patch #2: Collect per queue statistics

Patch #3: Report per queue stats in ethtool

Patch #4: Report per queue stats in netdev qstats

---

v2:
  - Split the ethtool stats reporting into its own patch
  - Added a patch for reporting stats with netdev qstats per Jakub's
    suggestion
v1: https://lore.kernel.org/all/20240823235401.29996-1-neescoba@cisco.com/

Nelson Escobar (4):
  enic: Use macro instead of static const variables for array sizes
  enic: Collect per queue statistics
  enic: Report per queue statistics in ethtool
  enic: Report per queue statistics in netdev qstats

 drivers/net/ethernet/cisco/enic/enic.h        |  38 ++++-
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 114 +++++++++++--
 drivers/net/ethernet/cisco/enic/enic_main.c   | 157 +++++++++++++++---
 3 files changed, 277 insertions(+), 32 deletions(-)

-- 
2.35.2


