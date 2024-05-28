Return-Path: <netdev+bounces-98655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441488D1F94
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736691C2243B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381BA171E76;
	Tue, 28 May 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThERsgqb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9643171064
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908555; cv=none; b=OfzshWW9EuCrjc7o+GGYQebcqTzjhAcY0kSTYVfBNdH8X6I1HfP/6OrtdVC4i/zZQpE6hilgTbnGYenh9btwhtPApRmS7VE8GY4cpVXk33FES8E5ClOMjd5xHCncf4NtQVvjYdY285/KR1mh9mYlzOf/fBw2JwJv0PKwaW/9+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908555; c=relaxed/simple;
	bh=2UNAaQ/30oJpeCNFCKdqMqQ017Ee3JxN1z//WtgKcuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OJSn3f52WKYuVg587HzxdYmBJhOsh+3qV7Z/49S/74z9iFEIRn0qlxK6Tfy1MeqL1BsmKV6R3XjLSz1b89q25LXj58/2tNAWnQd/44qgITaM26RbhUy1CiJM6KF/N/DIXPdNl0C6VwbWRKvNsGUgoEaVXAQEX7IPcK5WR5zRKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThERsgqb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716908552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C3+ZIRNnT7WCQphjrDbOHHUSbOz2wS7xfoUOS89MF08=;
	b=ThERsgqbMh19nunzc8PPhTmv1g2JoJBZ+uWZ+agenwzVJa90z10qoXRqUTI5niq8cGVb4N
	T4oMyDKQdfZ5WBQtA1AbNdk+IIWkSRWtpAECY4/3N1yZX1aXmkA08lYzyoZJvazzrH9m6H
	rKWgsyOaZnEhJIGzQ/S5SHKrvdqn9bE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-DjOuceJ6PYu8wpVAvTKG1g-1; Tue, 28 May 2024 11:02:28 -0400
X-MC-Unique: DjOuceJ6PYu8wpVAvTKG1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2010812296;
	Tue, 28 May 2024 15:02:26 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 297AE2873;
	Tue, 28 May 2024 15:02:18 +0000 (UTC)
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
Subject: [PATCH iwl-next v12] ice: Add get/set hw address for VFs using devlink commands
Date: Tue, 28 May 2024 20:32:12 +0530
Message-Id: <20240528150213.16771-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Dear Maintainers,
    Thanks for the review and suggestions for my patch.
v11 -> v12
----------
- Fix kernel-doc warnings

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


