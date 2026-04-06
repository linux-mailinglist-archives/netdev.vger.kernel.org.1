Return-Path: <netdev+bounces-275571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PFRxES+X02n3jQcAu9opvQ
	(envelope-from <netdev+bounces-275571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:21:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F93A3135
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 270883006827
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD843264C2;
	Mon,  6 Apr 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNRICWkm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451FA3195FC
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474475; cv=none; b=L46J8IrB0UgRTNqrBHAcxT7a9cXUuvuCH/3cSrv1HK6B/sUuPcTMskLbLViCDAcZMgl/BdOKebpgSqQlqgS4LYxe5ZRwD4zETSnj7xFcn+xaOuiTpglY1hQ79v/bannR4hz8QTz4U6Bx0aC7/IDPmsr5IL/N3Xrw7QVVltif9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474475; c=relaxed/simple;
	bh=oP+J4GfGCQ85I/W1iPCu8993CzzEnQjRrTSmBNvLZzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcWS1XIoMrXlH7MmnALPS47mIquM2Dk2RUvOlGOVkBsMQ9aOOaRP4zbUZNTIY9urQhak5A6DyM+ubeNQWLQ6W24KW60lXTbCOVSosnvh6ySIc02qa7yBKARnSpgbh1VNcs7bphWSr++P90TgzGafz8Xa/pHNa3CRrOw+wUuCwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNRICWkm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775474473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OHB5rvbHOIfZdqV/Ia+WSfXX4qz29mspQuLK0d1ndu0=;
	b=TNRICWkmXcFIeIPonjewcJorINyrn8fEhFbsLqfDbZea+nPzwNqWqBTW9mNJKEzgqOZWkG
	xzAtp2ka6knAUQsphZlqILhIihcZ437abRXs00NgDDfzjk4f43gNeuh59zw5tZVIMvDdra
	VnasfsxOAG2VUjDFKf5pVzHqk/gBpS0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-SUbSvAxUOHO4dA-ObDbbDA-1; Mon,
 06 Apr 2026 07:21:08 -0400
X-MC-Unique: SUbSvAxUOHO4dA-ObDbbDA-1
X-Mimecast-MFC-AGG-ID: SUbSvAxUOHO4dA-ObDbbDA_1775474467
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B449819560A7;
	Mon,  6 Apr 2026 11:21:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7510300019F;
	Mon,  6 Apr 2026 11:21:02 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH net 0/3] Fix i40e/iavf VF bonding after netdev lock changes
Date: Mon,  6 Apr 2026 13:20:54 +0200
Message-ID: <20260406112057.906685-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-275571-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C56F93A3135
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes VF bonding failures introduced by commit ad7c7b2172c3
("net: hold netdev instance lock during sysfs operations").

The core issue is lock contention: iavf_set_mac() is now called with the
netdev lock held and waits for MAC change completion while holding it.
However, the watchdog task that processes the request also needs this lock,
creating a deadlock scenario where the watchdog cannot run, causing
timeouts.

Additionally, setting VF trust triggers an unnecessary ~10 second VF reset
that delays bonding setup, even though filter synchronization happens
naturally during normal VF operation.

This series:
1. Adds safety guard to avoid waiting with locks during reset
2. Eliminates unnecessary VF reset when setting trust (major performance
   win)
3. Fixes the lock contention by dropping the lock while waiting

Testing shows VF bonding now works reliably in ~5 seconds vs 15+ seconds
before, without timeouts or errors.

Tested on Intel 700-series dual-port NIC (i40e) with iavf driver.

Thanks to Jan Tluka <jtluka@redhat.com> for reporting the issue.

Jose Ignacio Tornos Martinez (3):
  iavf: return EBUSY if reset in progress during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: drop netdev lock while waiting for MAC change completion

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 +++++++-----
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

--
2.43.0


