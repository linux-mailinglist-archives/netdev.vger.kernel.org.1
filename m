Return-Path: <netdev+bounces-80958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06088558C
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADFD1C2126E
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B386997E;
	Thu, 21 Mar 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heQQ1Fkp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59169314
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009016; cv=none; b=i5zbqEcHsVlLKEMyxbJBfP0uxkXPf1GY99zljbe64kGOzn9jLmNWd7oDDJzfpv6cpiYDAJ7R/Y+pZoNQTlZWLnWJ5OqtKjjcK6sjo1WoLdhGTUWNy0ROjRpQnUBjTHOtSvBvG3a7rto9MribuNSTnBxUChXLk2wRhLZG6wxoHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009016; c=relaxed/simple;
	bh=+Mm+6jpJmyXFW/THWAVO/dtwVFwixZ6ckZAHYj76i1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0lh9DkbnK/0fN31qU/rUCU/Ir7Fm8nVLbKOYXh12fwutE+LNU7GZyczjukxEctJjesh3ub/+DU8t4rOYQvn/a62DVrnLmHumkNfpCbNVZ2Q9KbYa9Bam7kS3Av3D5I9SnUvwxXerCZA9w+97Ox/7qUckEyMUS07iR5du9uLNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=heQQ1Fkp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711009013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1nZmh/jwo6v3OqQ8SYcKAELLaS9OFz7pGZrI8EdfDco=;
	b=heQQ1FkpZCKI+vn/e9LjCYRlFzR+dv9QqmemNvH477eqWse0dn8Ea/aicNver75xWow8p2
	AjqNmuk5+ji0Mie2/02Hizg2PGvu6wXZsqEb1e/qF67dgQiuC2TwKXwgGRf9MPZP1i1MsC
	AeqZ4TzFxvvsbt5YOEe3S0mPbcbWYTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-OiBPrs-5OmuMWVaRFoX0Vw-1; Thu, 21 Mar 2024 04:16:45 -0400
X-MC-Unique: OiBPrs-5OmuMWVaRFoX0Vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC0CF85A58C;
	Thu, 21 Mar 2024 08:16:44 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.16.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BE6C41C060A6;
	Thu, 21 Mar 2024 08:16:37 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: 
Date: Thu, 21 Mar 2024 13:46:24 +0530
Message-Id: <20240321081625.28671-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Dear Maintainers,
    Thanks for the review and suggestions for my patch.
In this patch v6, I have used container_of() instead of
ice_get_vf_by_id(). Also since the ice_set_vf_fn_mac()
is a copy of the existing function ice_set_vf_mac(),
except for the parameters, I didn't absorb the review
comments on that. Please advise if the validation checks
needs to be modified.

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


