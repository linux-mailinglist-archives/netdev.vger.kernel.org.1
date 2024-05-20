Return-Path: <netdev+bounces-97173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F888C9B21
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BF71F215F5
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F042350A6A;
	Mon, 20 May 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lpi6wqEk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625414F5E6
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200458; cv=none; b=qATs0o/lHVBNeMJfChOHcfnelo8azQnX4SWdiED+ziKS7HmYWgc3YR2O1/LKDbrFut7XYX/16DqbkWSYU0OLLgmL/Co342+YVizAgVuJ4eKh4Iff2yonGwbWMpk9/aTZ+V6DYZZ3kOzZiP/hQfkEJnmcX6gXgYMLgdWu9mqsVys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200458; c=relaxed/simple;
	bh=oMXk/qpTlpZ5s8mr7KLSCHfsfAAOFrl6IrT+dBIeh98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DAEFXrVnTOwV5YadeI0oKgJy2rb+1TcxeBXYYj8FYyGQgc4ee7V+tnmnvT+l6idKJsY6UhB/0DNA5O7ubNLN4BM1Jqyliq/OOIz5j8wX+hJ2Lx2LeNLbS6Z+xhLjNuyeU9bziKaj7yDosC25pUHPSYXzGWKH+8mvofeluiTQt8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lpi6wqEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716200456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AAQLSghKJY4IZ/0q6PLJciOBFBZAIvtvgNLoe1np3LA=;
	b=Lpi6wqEk4r0LsLOQJoKQh+CD//ylWRxqVJEqYZb9g2vzAXe/kxmIWkVjjwm4jHWrJPeaBe
	js2OuK22hvkAaBBLKaUa99rfejXg5w8RSOdHNxtm8/d7FNdG1ja5X2nOTfUz2Sw1RTySTB
	imvo5H6Vev+zqyShVBKTtx2RK21hzAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-fVZCWuO9MtWh0K4gwBpdBg-1; Mon, 20 May 2024 06:20:52 -0400
X-MC-Unique: fVZCWuO9MtWh0K4gwBpdBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8366581227E;
	Mon, 20 May 2024 10:20:51 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AD0C72026D68;
	Mon, 20 May 2024 10:20:43 +0000 (UTC)
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
Subject: [PATCH iwl-next v11] ice: Add get/set hw address for VFs using devlink commands 
Date: Mon, 20 May 2024 15:50:39 +0530
Message-Id: <20240520102040.54745-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Dear Maintainers,
    Thanks for the review and suggestions for my patch.

v10 -> v11
----------
- rename the function ice_set_vf_mac_fn() to __ice_set_vf_mac()

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


