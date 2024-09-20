Return-Path: <netdev+bounces-129124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C497D9B4
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E51B227ED
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C878185920;
	Fri, 20 Sep 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajUkKCxN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9818454C
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726858799; cv=none; b=uRWp7xIpi2kTSZWjGkT/whGZJiuNumKhnBuYS0XknmOCtiTsbXO045RW6IUq9Zy3xGY+ziwkN3ySxE+10DG3wxyg6UqkQroA2cw2VyXDgaNWF3AjJ9Z2ArI62o7o17aat9jLWUpZDydGiN5Kli6sXA8cRd+S0uQbV6SsG+B+ZZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726858799; c=relaxed/simple;
	bh=LxLBmWjEBsEkWdXPM1cCpZB2brCOEuiw7eWlLY7icMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrCyB9Dn6Z9FpwEfr8TbZ21nvmFVM43gS6NI4iDNyvV84dOb4H59fppg8UCq4Zgqhd0koBFviosBf2AVK//zOZLBk5rDBlDv6KFCuPcd5k6Hi2A1/RBXPduPxEDWygGqEz4OnApPpn73AW8nrd+KpuZ/gury0Lx9BGiOKTBBHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajUkKCxN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726858796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//K1ULstEOc/DI/axpvjaD18nBiH0yOhZIjWSw/nkxo=;
	b=ajUkKCxNAHHviyX7x5yYW5hQ+e0m6cKjfR5B+psPAEUJbviFCTnKdd4foqt5nvKSkS68YU
	kUiFtFxJNcu2g2q7x4N//fAHJLRCsEOg1/iwJ7Aj28tJGb/k6Cmbv6BwK9/zaagjgBNWf/
	RA+bdKrng+aP+vngfYTyJEsgQhkLfiY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-dMb4Mp14MS2qMw2n-pHRyw-1; Fri,
 20 Sep 2024 14:59:53 -0400
X-MC-Unique: dMb4Mp14MS2qMw2n-pHRyw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5389B1933B65;
	Fri, 20 Sep 2024 18:59:52 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.33.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BF1C19560AA;
	Fri, 20 Sep 2024 18:59:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Wander Lairson Costa <wander@redhat.com>,
	Yuying Ma <yuma@redhat.com>
Subject: [PATCH 1/2] igb: Disable threaded IRQ for igb_msix_other
Date: Fri, 20 Sep 2024 15:59:16 -0300
Message-ID: <20240920185918.616302-2-wander@redhat.com>
In-Reply-To: <20240920185918.616302-1-wander@redhat.com>
References: <20240920185918.616302-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

During testing of SR-IOV, Red Hat QE encountered an issue where the
ip link up command intermittently fails for the igbvf interfaces when
using the PREEMPT_RT variant. Investigation revealed that
e1000_write_posted_mbx returns an error due to the lack of an ACK
from e1000_poll_for_ack.

The underlying issue arises from the fact that IRQs are threaded by
default under PREEMPT_RT. While the exact hardware details are not
available, it appears that the IRQ handled by igb_msix_other must
be processed before e1000_poll_for_ack times out. However,
e1000_write_posted_mbx is called with preemption disabled, leading
to a scenario where the IRQ is serviced only after the failure of
e1000_write_posted_mbx.

To resolve this, we set IRQF_NO_THREAD for the affected interrupt,
ensuring that the kernel handles it immediately, thereby preventing
the aforementioned error.

Reproducer:

    #!/bin/bash

    # echo 2 > /sys/class/net/ens14f0/device/sriov_numvfs
    ipaddr_vlan=3
    nic_test=ens14f0
    vf=${nic_test}v0

    while true; do
	    ip link set ${nic_test} mtu 1500
	    ip link set ${vf} mtu 1500
	    ip link set $vf up
	    ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
	    ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
	    ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
	    if ! ip link show $vf | grep 'state UP'; then
		    echo 'Error found'
		    break
	    fi
	    ip link set $vf down
    done

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reported-by: Yuying Ma <yuma@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1ef4cb871452..8a1696d7289f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -907,7 +907,7 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	int i, err = 0, vector = 0, free_vector = 0;
 
 	err = request_irq(adapter->msix_entries[vector].vector,
-			  igb_msix_other, 0, netdev->name, adapter);
+			  igb_msix_other, IRQF_NO_THREAD, netdev->name, adapter);
 	if (err)
 		goto err_out;
 
-- 
2.46.1


