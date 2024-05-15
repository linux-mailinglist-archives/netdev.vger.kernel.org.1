Return-Path: <netdev+bounces-96497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046478C639E
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CBEC1F23421
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F557CAB;
	Wed, 15 May 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awlq6Y1s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194AB57C8A
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765146; cv=none; b=itI5iTISPEs6i0JgfF1h1YKUC7SZ7YljBRpMhD1QB8tiiknlwoR5etp7zZOpZM7alnT9G8A99k5nvlEqTYrGjy5atCEbZZjG/nEMDvsJXd86afrC6ZZ4DDIXv93X09t3ogV+2Fh6Lohkfb9OOUTf2cwEc6KQuLA85L3tHXoR3zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765146; c=relaxed/simple;
	bh=Jo9dFJJk8Tej8ZAq1jgfwvB+c2XB/wn2uoUdHvg4kCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCaBQrT51dtRfI/UIidf5PZuTFM/kI1+vkVh3s2gSMRHMs9QZYrzv8LTo7uavWUz/qZ9JNXhqRQDSTXEoM/q8kZazz9MdITgR6+lt3yHfgqqobMyLFqlz0CbufnLk2E7UY6ZhRsOQ1QlrxwMnS1fhLKZPPwRJfQDgzZSxRK6bDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awlq6Y1s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715765144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cwgmU20xqKj4JxIRaIo+XjkFH1Bokj6japGSVd7cJpA=;
	b=awlq6Y1s6zDz3Ddr4eanns8Aq6uHVsKNFpMlwuUC2+QajU6IcVxwfgbhH1fA43LwpZ83Wk
	46nXYNuYv4nlONUwGkbbP2MSh2SAqXdKn5Trrzw+tItIyFzdol9MWs7JWAdTPoeJKcRFZi
	ObdYuXrqlKmhrUM37TdjRoWr1CjmJQw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-ko1Hznd6OVeBiirvtz07Sw-1; Wed, 15 May 2024 05:25:40 -0400
X-MC-Unique: ko1Hznd6OVeBiirvtz07Sw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D643803785;
	Wed, 15 May 2024 09:25:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.127])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3649BC15BB1;
	Wed, 15 May 2024 09:25:37 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Xu Du <xudu@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] idpf: don't skip over ethtool tcp-data-split setting
Date: Wed, 15 May 2024 11:24:14 +0200
Message-ID: <20240515092414.158079-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Disabling tcp-data-split on idpf silently fails:
  # ethtool -G $NETDEV tcp-data-split off
  # ethtool -g $NETDEV | grep 'TCP data split'
  TCP data split:        on

But it works if you also change 'tx' or 'rx':
  # ethtool -G $NETDEV tcp-data-split off tx 256
  # ethtool -g $NETDEV | grep 'TCP data split'
  TCP data split:        off

The bug is in idpf_set_ringparam, where it takes a shortcut out if the
TX and RX sizes are not changing. Fix it by checking also if the
tcp-data-split setting remains unchanged. Only then can the soft reset
be skipped.

Fixes: 9b1aa3ef2328 ("idpf: add get/set for Ethtool's header split ringparam")
Reported-by: Xu Du <xudu@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-36182
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 986d429d1175..6972d728431c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -376,7 +376,8 @@ static int idpf_set_ringparam(struct net_device *netdev,
 			    new_tx_count);
 
 	if (new_tx_count == vport->txq_desc_count &&
-	    new_rx_count == vport->rxq_desc_count)
+	    new_rx_count == vport->rxq_desc_count &&
+	    kring->tcp_data_split == idpf_vport_get_hsplit(vport))
 		goto unlock_mutex;
 
 	if (!idpf_vport_set_hsplit(vport, kring->tcp_data_split)) {
-- 
2.44.0


