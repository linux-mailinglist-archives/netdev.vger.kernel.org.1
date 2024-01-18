Return-Path: <netdev+bounces-64281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8330F832097
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 21:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63388B21CA4
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FDF2E836;
	Thu, 18 Jan 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVhR51B/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CB1E89F
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 20:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611072; cv=none; b=avn2kTu8uoXGJwAV5no/39oKS+nUTpB+Ko0LysBv1uKFPGy1bkXv2jzoiSDl29ioDCdYXPs+YNTFQR/NBHBX3DU7s7Uh1CwrHiqUX9Nz+c7UBMcdIB45emC8D36d/nqDnInzJJHRBgDMclK+VTPI3tW6DuYjcWBHffsT0OwvzBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611072; c=relaxed/simple;
	bh=bNUdIl4TsR2hyd/G4amykKVPGAbc9OSx5YWbH29Yg8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzVoNYc/FF3EV1jIQIbfxBYW1z/pL8mBYLUAmqm4h+/ui0sGRDSTB63gx+qb/6Q5wH0sDPTGuO8c4FJUuBj0GUONzc78EgszM4GtzcgO5wneshuI16g7gNTZA0UlN1Pqk+P/dHzGzkRhhq90n62+3hesGAXGACiB7KNMiZtxdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVhR51B/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705611068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bRDXSn6I/hp6Tvmtx7L1Eze/oOIEVT2dyNd7wAVTXkk=;
	b=fVhR51B/nWc+o+pPt2pRNR/3XGD5t2/m1OlsPGbni4KEwumlcR89jYxZvOSexlCrryRYJd
	MkUjTs+L+7+2xelOnarZDKbA2Cq7Sz0qq+nPaiCoZmkAwPlsT+9KIXfPs8rPERnNuxPOJN
	A8+DgupoiM2esWsePbGrDZ3GJugXoqo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-SdIH67f5N-6RoALllVyzqg-1; Thu, 18 Jan 2024 15:51:03 -0500
X-MC-Unique: SdIH67f5N-6RoALllVyzqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 545D283B86B;
	Thu, 18 Jan 2024 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 396F21C05E0F;
	Thu, 18 Jan 2024 20:51:01 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>
Subject: [PATCH net] idpf: distinguish vports by the dev_port attribute
Date: Thu, 18 Jan 2024 21:50:40 +0100
Message-ID: <20240118205040.346632-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

idpf registers multiple netdevs (virtual ports) for one PCI function,
but it does not provide a way for userspace to distinguish them with
sysfs attributes. Per Documentation/ABI/testing/sysfs-class-net, it is
a bug not to set dev_port for independent ports on the same PCI bus,
device and function.

Without dev_port set, systemd-udevd's default naming policy attempts
to assign the same name ("ens2f0") to all four idpf netdevs on my test
system and obviously fails, leaving three of them with the initial
eth<N> name.

With this patch, systemd-udevd is able to assign unique names to the
netdevs (e.g. "ens2f0", "ens2f0d1", "ens2f0d2", "ens2f0d3").

The Intel-provided out-of-tree idpf driver already sets dev_port. In
this patch I chose to do it in the same place in the idpf_cfg_netdev
function.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5fea2fd957eb..58179bd733ff 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -783,6 +783,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	/* setup watchdog timeout value to be 5 second */
 	netdev->watchdog_timeo = 5 * HZ;
 
+	netdev->dev_port = idx;
+
 	/* configure default MTU size */
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
-- 
2.41.0


