Return-Path: <netdev+bounces-96692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2358C72CB
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569801C219C0
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53612E1EE;
	Thu, 16 May 2024 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MtotPSTE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A012CDBF
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848073; cv=none; b=rF25VVnBHEuA5aXeP5FlHYXC0O537YS2P+X+g5uV1xROpGDzub03DEpMGm3pGfpXCedv02lL8W5/DD2+9PShzbz9XkUVg3v+t9MsUEDjIxygH1VNbB2Vd0UhMKKCzMVCnrHMn7dLG7ZMb6BSot8f2RnXtWplaLV3A2XwGpxVQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848073; c=relaxed/simple;
	bh=rvAPyJkeR+TboZ8lV4SzobDUy8jvlE9fbDs25cQI/TM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CMkBDW2yO0vzJkqjgRA7jjdkFexnEHg8Sl2GH5NGHTyOrXMLn0/DOckw4Gxg7YZhmRN8zGbKdYDtcp7tCBZWuTld+6TovWXmOCqqMAPrjUvpx+xzRPnKWMvZUIghyjRdaV9lAx3q83rHYkRjvj+o5P4KOzldvxpn3YT9UW3Efo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MtotPSTE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715848070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wp3xz/jEXktsfVHXaP1pl4p7Vr0VDUO5oIkhNKKtxrw=;
	b=MtotPSTE4VgaoccBj3njR9y1e63N1t2kB0U/Uc6DF2konp5FwOQgXLgMfY46HrItQkHPZW
	uY/fcaU34W3fV9ad/B4N0cD5T+GJ7C4kwnUoAaHIb4IeareO9SmEb6UAREvf7e9lZ1K6vl
	zyxKcpmrRNe5kpXSloT4/hXKOPC+yBY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-yw0N3rezPtq1pnTrowYLiQ-1; Thu,
 16 May 2024 04:27:46 -0400
X-MC-Unique: yw0N3rezPtq1pnTrowYLiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 974C83C025B8;
	Thu, 16 May 2024 08:27:45 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4CF85ADC45;
	Thu, 16 May 2024 08:27:37 +0000 (UTC)
From: Karthik Sundaravel <ksundara@redhat.com>
To: jesse.brandeburg@intel.com,
	wojciech.drewek@intel.com,
	sumang@marvell.com,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	bcreeley@amd.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH iwl-next v10] ice: Add get/set hw address for VFs using devlink commands 
Date: Thu, 16 May 2024 13:57:32 +0530
Message-Id: <20240516082733.35783-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Dear Maintainers,
    Thanks for the review and suggestions for my patch.

v9 -> v10
--------
- Refactor ice_set_vf_mac() to use reuse the common code blocks
  for setting the MAC addresses in both netdev and devlink flow.

v8 -> v9
--------
- Rebasing against dev-queue branch of next-queue tree

v7 -> v8
--------
- Added const keyword for the parameter ``mac`` in ice_set_vf_fn_mac()

v6 -> v7
--------
- Addressed Smatch and checkpatch issues

v5 -> v6
--------
- Changed data type of vf_id to u16
- Used container_of(port, struct ice_vf, devlink_port) to
  get the vf instead of ice_get_vf_by_id()/ice_put_vf()

v4 -> v5
--------
- Cloned ice_set_vf_mac() to ice_set_vf_fn_mac() so that the
  parameter ice_pf is used instead of net_device of vf
- removed redundant error handling

v3 -> v4
--------
- Released the vf device by calling ice_put_vf()

v2 -> v3
--------
- Fill the extack message instead of dev_err()

v1 -> v2
--------
- called ice_set_vf_mac() directly from the devlink port function
  handlers.

RFC -> v1
---------
- Add the function handlers to set and get the HW address for the
  VF representor ports.


