Return-Path: <netdev+bounces-91876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B444C8B44CE
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 09:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AD71C219E7
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7F43AD5;
	Sat, 27 Apr 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="is7zPmnw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201642055
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202788; cv=none; b=dttGOqY9hFfWtyLgKaFhD5yyU+YMC7td5/CEiJnnZ8TslqmZ+5ZCJDvbWR6ypOCE9dtVFXfGA9Pl2gLOrDdJvbbkzqaP29n5jITOg8dkbTZtuDCtfGnEziFhOKbaRVFsvkrkRaaGzBrB/p0o7kcsHrhSxULXg20+BNl7Evxm4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202788; c=relaxed/simple;
	bh=rfBP2Pzpfb7knll4pClmVsouTJ4TG5aRphXSlSFXA6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7kpV7vhjRRgvD//DUn2qlTPWYvMOcZKznHegKsdBDSTSF5/FN5psWd/S1KXhknQOEdiCvknD3LPhKtcRkjf3SAU4NHcechHvcw2P18GcCcbM5mNJz2AxIvColudy4nQwPXGWPYjPbh0LaJFvSf6WgH8YffBEdJvTeCoh4zV08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=is7zPmnw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714202786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oU0PI/3hFSKCw5O/amXoTchq7YWCXQ97GsK4JttEy+E=;
	b=is7zPmnwaxJYFScq4A/vhAMg1PnBeVYoWR79HTT18izZxqxeelTMQnWCqE5Th0tJ+djBre
	qa1sqEb1cwqg3MLTFFGeXIPdKDmhyIB6qFs8AEpBRXx0RLDqmToGUypBV6iClPTRQCuPUZ
	lq+wEFxZ6PmXgiTP0ifeDMivlTVd9kg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-TseoSWE1NmyCFPqcAuhqhw-1; Sat, 27 Apr 2024 03:26:19 -0400
X-MC-Unique: TseoSWE1NmyCFPqcAuhqhw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FD0218065AA;
	Sat, 27 Apr 2024 07:26:18 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4CA240F17B;
	Sat, 27 Apr 2024 07:26:16 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v4 0/7] i40e: cleanups & refactors
Date: Sat, 27 Apr 2024 09:26:01 +0200
Message-ID: <20240427072615.226151-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This series do following:
Patch 1 - Removes write-only flags field from i40e_veb structure and
          from i40e_veb_setup() parameters
Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
          and i40e_notify_client_of_netdev_close()
Patch 3 - Refactors parameter of i40e_detect_recover_hung()
Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
          in existing code
Patch 5 - Consolidates checks whether given VSI is the main one
Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
          in existing code
Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
          particular and uses it to replace existing open-coded pieces

Note that this series should go directly to net-next as the IWL review
and validation were already done.

Changes since v3:
- fixed new kdoc warnings
Changes since v2:
- resubmitted per Tony's request (no new kdoc errors were found)
- added existing reviewed-by and tested-by tags
Changes since v1:
- adjusted titles for patches 2 & 3

Ivan Vecera (7):
  i40e: Remove flags field from i40e_veb
  i40e: Refactor argument of several client notification functions
  i40e: Refactor argument of i40e_detect_recover_hung()
  i40e: Add helper to access main VSI
  i40e: Consolidate checks whether given VSI is main
  i40e: Add helper to access main VEB
  i40e: Add and use helper to reconfigure TC for given VSI

 drivers/net/ethernet/intel/i40e/i40e.h        |  29 ++-
 drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 ++--
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 200 ++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
 10 files changed, 211 insertions(+), 152 deletions(-)

-- 
2.43.2


