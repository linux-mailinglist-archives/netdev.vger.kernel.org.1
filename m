Return-Path: <netdev+bounces-34138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13B07A2469
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE3282303
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B515EA2;
	Fri, 15 Sep 2023 17:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E69111B2
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:14:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B97D186
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694798047; x=1726334047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L1FNUKAO0ZZNzndWtLywfusp2YGoeldjcbuAcc9MUGM=;
  b=C/gEKWvx9hb3RYQWznDXieIz5+nFVtYB91G4So/83lGltgItHQ9mpfLH
   BnvseNsu9lAWdWagz3xnSQHGNOw3i2Zu/kMYqoFrhLoSdXmKhXXLbiOZD
   9/HfV6yyaCB1rfQIjMERuChjMjatf6/yP2Qt1xKVTsjbc7qAJXex7F4FE
   jUBQOWysCDCGaZPi4HO1SXRWemqb1Ud709EjDo4fYnSvfQm2KlwIhReSb
   KM+/zOo8SULiL1NhmdMFZW2nvMq+uPYzRHQvlw5SOjNLi4Uy8XBjVzyCu
   ag+4VQOeY3WIKgzhl0eEgSifZyR30AdnCtF3KHuGES8IghqOWtsx+oXHA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="383132321"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="383132321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="860244183"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="860244183"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 15 Sep 2023 10:12:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Radoslaw Tyl <radoslawx.tyl@intel.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/4] iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set
Date: Fri, 15 Sep 2023 10:11:36 -0700
Message-Id: <20230915171139.3822904-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915171139.3822904-1-anthony.l.nguyen@intel.com>
References: <20230915171139.3822904-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

Prevent schedule operations for adminq during device remove and when
__IAVF_IN_REMOVE_TASK flag is set. Currently, the iavf_down function
adds operations for adminq that shouldn't be processed when the device
is in the __IAVF_REMOVE state.

Reproduction:

echo 4 > /sys/bus/pci/devices/0000:17:00.0/sriov_numvfs
ip link set dev ens1f0 vf 0 trust on
ip link set dev ens1f0 vf 1 trust on
ip link set dev ens1f0 vf 2 trust on
ip link set dev ens1f0 vf 3 trust on

ip link set dev ens1f0 vf 0 mac 00:22:33:44:55:66
ip link set dev ens1f0 vf 1 mac 00:22:33:44:55:67
ip link set dev ens1f0 vf 2 mac 00:22:33:44:55:68
ip link set dev ens1f0 vf 3 mac 00:22:33:44:55:69

echo 0000:17:02.0 > /sys/bus/pci/devices/0000\:17\:02.0/driver/unbind
echo 0000:17:02.1 > /sys/bus/pci/devices/0000\:17\:02.1/driver/unbind
echo 0000:17:02.2 > /sys/bus/pci/devices/0000\:17\:02.2/driver/unbind
echo 0000:17:02.3 > /sys/bus/pci/devices/0000\:17\:02.3/driver/unbind
sleep 10
echo 0000:17:02.0 > /sys/bus/pci/drivers/iavf/bind
echo 0000:17:02.1 > /sys/bus/pci/drivers/iavf/bind
echo 0000:17:02.2 > /sys/bus/pci/drivers/iavf/bind
echo 0000:17:02.3 > /sys/bus/pci/drivers/iavf/bind

modprobe vfio-pci
echo 8086 154c > /sys/bus/pci/drivers/vfio-pci/new_id

qemu-system-x86_64 -accel kvm -m 4096 -cpu host \
-drive file=centos9.qcow2,if=none,id=virtio-disk0 \
-device virtio-blk-pci,drive=virtio-disk0,bootindex=0 -smp 4 \
-device vfio-pci,host=17:02.0 -net none \
-device vfio-pci,host=17:02.1 -net none \
-device vfio-pci,host=17:02.2 -net none \
-device vfio-pci,host=17:02.3 -net none \
-daemonize -vnc :5

Current result:
There is a probability that the mac of VF in guest is inconsistent with
it in host

Expected result:
When passthrough NIC VF to guest, the VF in guest should always get
the same mac as it in host.

Fixes: 14756b2ae265 ("iavf: Fix __IAVF_RESETTING state usage")
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7b300c86ceda..b23ca9d80189 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1421,7 +1421,8 @@ void iavf_down(struct iavf_adapter *adapter)
 	iavf_clear_fdir_filters(adapter);
 	iavf_clear_adv_rss_conf(adapter);
 
-	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)) {
+	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) &&
+	    !(test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))) {
 		/* cancel any current operation */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		/* Schedule operations to close down the HW. Don't wait
-- 
2.38.1


