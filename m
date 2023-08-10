Return-Path: <netdev+bounces-26480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB1B777ECC
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1032B282275
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C952214EC;
	Thu, 10 Aug 2023 17:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A2214E6
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:07:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9295D26BD
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691687273; x=1723223273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z9DaIQ6kaQZ8dEiGibqGexJ/ErmfTN8j/W6eaNiP+zg=;
  b=bEtYlfJQD7By+00bCH5evB9eHOrsMTmHx/jrD6HUooVQyZ4YGlpmmzEC
   mo/L0qNjPBYNpjhheVNN5f8IExii4J+vbdMNabUIw36ZS5JddDqlUWW/a
   PlfS7ArY9EFLQfq+WQWtNOHIud2JnVSguQ6Re835DUzZccPYo6q/EfrU9
   ij6494y9lYbjbPbgh2qBuLza+PuSv2hq/99xymXWmKTYGQj4dKE0+sbQn
   OZMjb72lbmJtrSkfYWmsJBS4QPP863q3zPc4eutSTlornNCf9++IktIAy
   Sab4yU6IhjxDAJ5Cytoy+D9ZunTbTceN5ideBOpWRVNM45kd3DUbE+MnV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="371476132"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="371476132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709234182"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="709234182"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 10:07:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 4/5] ice: add ability to read FW log data and configure the number of log buffers
Date: Thu, 10 Aug 2023 10:01:08 -0700
Message-Id: <20230810170109.1963832-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230810170109.1963832-1-anthony.l.nguyen@intel.com>
References: <20230810170109.1963832-1-anthony.l.nguyen@intel.com>
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

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Once logging is enabled the user should read the data from the 'data'
file. The data is in the form of a binary blob that can be sent to Intel
for decoding. To read the data use a command like:

cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/data > log_data.bin

If the user wants to clear the FW log data that has been stored in the
driver then they can write a 0 to the 'data' file and that will clear
the data.

In addition to being able to read the data the user can configure how
many buffers can be used to store the FW logs within the driver. This
allows the user to increase/decrease the number of buffers used based on
the users situation. The buffers are used as a ring so if the driver
runs out of buffers then it will overwrite data. To change the number of
buffers the user can write to the 'nr_buffs' file like this:

echo 128 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/nr_buffs

The value written to the file must be a power of 2 value between 1 (not
recommended) and 512.

Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 242 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.c    | 130 +++++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |  20 ++
 drivers/net/ethernet/intel/ice/ice_main.c     |  29 +++
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 6 files changed, 423 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index a8d2f4cab168..8b1d2c4c46e9 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2123,6 +2123,7 @@ enum ice_aqc_fw_logging_mod {
 /* Set FW Logging configuration (indirect 0xFF30)
  * Register for FW Logging (indirect 0xFF31)
  * Query FW Logging (indirect 0xFF32)
+ * FW Log Event (indirect 0xFF33)
  */
 struct ice_aqc_fw_log {
 	u8 cmd_flags;
@@ -2426,6 +2427,7 @@ enum ice_adminq_opc {
 	ice_aqc_opc_fw_logs_config			= 0xFF30,
 	ice_aqc_opc_fw_logs_register			= 0xFF31,
 	ice_aqc_opc_fw_logs_query			= 0xFF32,
+	ice_aqc_opc_fw_logs_event			= 0xFF33,
 };
 
 #endif /* _ICE_ADMINQ_CMD_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index 104ea962adee..e3bc1f7a525c 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -509,6 +509,240 @@ static const struct file_operations ice_debugfs_enable_fops = {
 	.write = ice_debugfs_enable_write,
 };
 
+/**
+ * ice_debugfs_nr_buffs_read - read from 'nr_buffs' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_nr_buffs_read(struct file *filp,
+					 char __user *buffer, size_t count,
+					 loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct ice_hw *hw = &pf->hw;
+	char buff[32] = {};
+	int status;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(&pf->hw))
+		return -EOPNOTSUPP;
+
+	snprintf(buff, sizeof(buff), "%d\n", hw->fwlog_ring.size);
+
+	status = simple_read_from_buffer(buffer, count, ppos, buff,
+					 strlen(buff));
+
+	return status;
+}
+
+/**
+ * ice_debugfs_nr_buffs_write - write into 'nr_buffs' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_nr_buffs_write(struct file *filp, const char __user *buf,
+			   size_t count, loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	ssize_t ret;
+	char **argv;
+	int argc;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(hw))
+		return -EOPNOTSUPP;
+
+	/* don't allow partial writes */
+	if (*ppos != 0)
+		return 0;
+
+	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
+	if (ret)
+		goto err_copy_from_user;
+
+	if (argc == 1) {
+		s16 nr_buffs;
+
+		ret = kstrtos16(argv[0], 0, &nr_buffs);
+		if (ret)
+			goto nr_buffs_write_error;
+
+		if (nr_buffs <= 0 || nr_buffs > ICE_FWLOG_RING_SIZE_MAX) {
+			dev_info(dev, "nr_buffs '%d' is not within bounds. Please use a value between 1 and %d\n",
+				 nr_buffs, ICE_FWLOG_RING_SIZE_MAX);
+			ret = -EINVAL;
+			goto nr_buffs_write_error;
+		} else if (hweight16(nr_buffs) > 1) {
+			dev_info(dev, "nr_buffs '%d' is not a power of 2. Please use a value that is a power of 2.\n",
+				 nr_buffs);
+			ret = -EINVAL;
+			goto nr_buffs_write_error;
+		} else if (hw->fwlog_cfg.options &
+			   ICE_FWLOG_OPTION_IS_REGISTERED) {
+			dev_info(dev, "FW logging is currently running. Please disable FW logging to change nr_buffs\n");
+			ret = -EINVAL;
+			goto nr_buffs_write_error;
+		}
+
+		/* free all the buffers and the tracking info and resize */
+		ice_fwlog_realloc_rings(hw, nr_buffs);
+	} else {
+		dev_info(dev, "unknown or invalid command '%s'\n", argv[0]);
+		ret = -EINVAL;
+		goto nr_buffs_write_error;
+	}
+
+	/* if we get here, nothing went wrong; return bytes copied */
+	ret = (ssize_t)count;
+
+nr_buffs_write_error:
+	argv_free(argv);
+err_copy_from_user:
+	/* This function always consumes all of the written input, or produces
+	 * an error. Check and enforce this. Otherwise, the write operation
+	 * won't complete properly.
+	 */
+	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
+		ret = -EIO;
+
+	return ret;
+}
+
+static const struct file_operations ice_debugfs_nr_buffs_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_nr_buffs_read,
+	.write = ice_debugfs_nr_buffs_write,
+};
+
+/**
+ * ice_debugfs_data_read - read from 'data' file
+ * @filp: the opened file
+ * @buffer: where to write the data for the user to read
+ * @count: the size of the user's buffer
+ * @ppos: file position offset
+ */
+static ssize_t ice_debugfs_data_read(struct file *filp, char __user *buffer,
+				     size_t count, loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct ice_hw *hw = &pf->hw;
+	int data_copied = 0;
+	bool done = false;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(&pf->hw))
+		return -EOPNOTSUPP;
+
+	if (ice_fwlog_ring_empty(&hw->fwlog_ring))
+		return 0;
+
+	while (!ice_fwlog_ring_empty(&hw->fwlog_ring) && !done) {
+		struct ice_fwlog_data *log;
+		u16 cur_buf_len;
+
+		log = &hw->fwlog_ring.rings[hw->fwlog_ring.head];
+		cur_buf_len = log->data_size;
+
+		if (cur_buf_len >= count) {
+			done = true;
+			continue;
+		}
+
+		if (copy_to_user(buffer, log->data, cur_buf_len)) {
+			/* if there is an error then bail and return whatever
+			 * the driver has copied so far
+			 */
+			done = true;
+			continue;
+		}
+
+		data_copied += cur_buf_len;
+		buffer += cur_buf_len;
+		count -= cur_buf_len;
+		*ppos += cur_buf_len;
+		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
+					 hw->fwlog_ring.size);
+	}
+
+	return data_copied;
+}
+
+/**
+ * ice_debugfs_data_write - write into 'data' file
+ * @filp: the opened file
+ * @buf: where to find the user's data
+ * @count: the length of the user's data
+ * @ppos: file position offset
+ */
+static ssize_t
+ice_debugfs_data_write(struct file *filp, const char __user *buf, size_t count,
+		       loff_t *ppos)
+{
+	struct ice_pf *pf = filp->private_data;
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	ssize_t ret;
+	char **argv;
+	int argc;
+
+	/* don't allow commands if the FW doesn't support it */
+	if (!ice_fwlog_supported(hw))
+		return -EOPNOTSUPP;
+
+	/* don't allow partial writes */
+	if (*ppos != 0)
+		return 0;
+
+	ret = ice_debugfs_parse_cmd_line(buf, count, &argv, &argc);
+	if (ret)
+		goto err_copy_from_user;
+
+	if (argc == 1) {
+		if (!(hw->fwlog_cfg.options & ICE_FWLOG_OPTION_IS_REGISTERED)) {
+			hw->fwlog_ring.head = 0;
+			hw->fwlog_ring.tail = 0;
+		} else {
+			dev_info(dev, "Can't clear FW log data while FW log running\n");
+			ret = -EINVAL;
+			goto nr_buffs_write_error;
+		}
+	} else {
+		dev_info(dev, "unknown or invalid command '%s'\n", argv[0]);
+		ret = -EINVAL;
+		goto nr_buffs_write_error;
+	}
+
+	/* if we get here, nothing went wrong; return bytes copied */
+	ret = (ssize_t)count;
+
+nr_buffs_write_error:
+	argv_free(argv);
+err_copy_from_user:
+	/* This function always consumes all of the written input, or produces
+	 * an error. Check and enforce this. Otherwise, the write operation
+	 * won't complete properly.
+	 */
+	if (WARN_ON(ret != (ssize_t)count && ret >= 0))
+		ret = -EIO;
+
+	return ret;
+}
+
+static const struct file_operations ice_debugfs_data_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read = ice_debugfs_data_read,
+	.write = ice_debugfs_data_write,
+};
+
 /**
  * ice_debugfs_fwlog_init - setup the debugfs directory
  * @pf: the ice that is starting up
@@ -543,6 +777,14 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 
 	debugfs_create_file("enable", 0600, pf->ice_debugfs_pf_fwlog,
 			    pf, &ice_debugfs_enable_fops);
+
+	debugfs_create_file("nr_buffs", 0600, pf->ice_debugfs_pf_fwlog,
+			    pf, &ice_debugfs_nr_buffs_fops);
+
+	debugfs_create_file("data", 0600, pf->ice_debugfs_pf_fwlog,
+			    pf, &ice_debugfs_data_fops);
+
+	return;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index ce857ddd4be8..8cd9fdbaec90 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -1,10 +1,111 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022, Intel Corporation. */
 
+#include <linux/vmalloc.h>
 #include "ice.h"
 #include "ice_common.h"
 #include "ice_fwlog.h"
 
+bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings)
+{
+	u16 head, tail;
+
+	head = rings->head;
+	tail = rings->tail;
+
+	if (head < tail && (tail - head == (rings->size - 1)))
+		return true;
+	else if (head > tail && (tail == (head - 1)))
+		return true;
+
+	return false;
+}
+
+bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings)
+{
+	return rings->head == rings->tail;
+}
+
+void ice_fwlog_ring_increment(u16 *item, u16 size)
+{
+	*item = (*item + 1) & (size - 1);
+}
+
+static int ice_fwlog_alloc_ring_buffs(struct ice_fwlog_ring *rings)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < rings->size; i++) {
+		struct ice_fwlog_data *ring = &rings->rings[i];
+
+		ring->data_size = ICE_AQ_MAX_BUF_LEN;
+		ring->data = vzalloc(ring->data_size);
+		if (!ring->data) {
+			ret = -ENOMEM;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void ice_fwlog_free_ring_buffs(struct ice_fwlog_ring *rings)
+{
+	int i;
+
+	for (i = 0; i < rings->size; i++) {
+		struct ice_fwlog_data *ring = &rings->rings[i];
+
+		vfree(ring->data);
+
+		ring->data_size = 0;
+	}
+}
+
+/**
+ * ice_fwlog_realloc_rings - reallocate the FW log rings
+ * @hw: pointer to the HW structure
+ * @ring_size: the new number of rings to allocate
+ *
+ */
+void ice_fwlog_realloc_rings(struct ice_hw *hw, int ring_size)
+{
+	struct ice_fwlog_ring ring;
+	int status;
+
+	if (ring_size == hw->fwlog_ring.size)
+		return;
+
+	/* allocate space for the new rings and buffers then release the
+	 * old rings and buffers. that way if we don't have enough
+	 * memory then we at least have what we had before
+	 */
+	ring.rings = kcalloc(ICE_FWLOG_RING_SIZE_DFLT,
+			     sizeof(*ring.rings), GFP_KERNEL);
+	if (!ring.rings) {
+		dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log ring\n");
+		return;
+	}
+
+	ring.size = ring_size;
+
+	status = ice_fwlog_alloc_ring_buffs(&ring);
+	if (status) {
+		dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log ring data buffers\n");
+		ice_fwlog_free_ring_buffs(&ring);
+		kfree(ring.rings);
+		return;
+	}
+
+	ice_fwlog_free_ring_buffs(&hw->fwlog_ring);
+	kfree(hw->fwlog_ring.rings);
+
+	hw->fwlog_ring.rings = ring.rings;
+	hw->fwlog_ring.size = ring.size;
+	hw->fwlog_ring.head = 0;
+	hw->fwlog_ring.tail = 0;
+}
+
 /**
  * ice_fwlog_init - Initialize FW logging configuration
  * @hw: pointer to the HW structure
@@ -14,16 +115,38 @@
  */
 int ice_fwlog_init(struct ice_hw *hw)
 {
-	int status;
+	/* only support fw log commands on PF 0 */
+	if (hw->bus.func)
+		return -EINVAL;
 
 	ice_fwlog_set_supported(hw);
 
 	if (ice_fwlog_supported(hw)) {
+		int status;
+
 		/* read the current config from the FW and store it */
 		status = ice_fwlog_get(hw, &hw->fwlog_cfg);
 		if (status)
 			return status;
 
+		hw->fwlog_ring.rings = kcalloc(ICE_FWLOG_RING_SIZE_DFLT,
+					       sizeof(*hw->fwlog_ring.rings),
+					       GFP_KERNEL);
+		if (!hw->fwlog_ring.rings) {
+			dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log ring\n");
+			return -ENOMEM;
+		}
+
+		hw->fwlog_ring.size = ICE_FWLOG_RING_SIZE_DFLT;
+
+		status = ice_fwlog_alloc_ring_buffs(&hw->fwlog_ring);
+		if (status) {
+			dev_warn(ice_hw_to_dev(hw), "Unable to allocate memory for FW log ring data buffers\n");
+			ice_fwlog_free_ring_buffs(&hw->fwlog_ring);
+			kfree(hw->fwlog_ring.rings);
+			return status;
+		}
+
 		ice_debugfs_fwlog_init(hw->back);
 	} else {
 		dev_warn(ice_hw_to_dev(hw), "FW logging is not supported in this NVM image. Please update the NVM to get FW log support\n");
@@ -59,6 +182,11 @@ void ice_fwlog_deinit(struct ice_hw *hw)
 	if (status)
 		dev_warn(ice_hw_to_dev(hw), "Unable to unregister FW logging, status: %d\n",
 			 status);
+
+	if (hw->fwlog_ring.rings) {
+		ice_fwlog_free_ring_buffs(&hw->fwlog_ring);
+		kfree(hw->fwlog_ring.rings);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.h b/drivers/net/ethernet/intel/ice/ice_fwlog.h
index 45865558425d..89969be69970 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.h
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.h
@@ -47,12 +47,32 @@ struct ice_fwlog_cfg {
 	u16 log_resolution;
 };
 
+struct ice_fwlog_data {
+	u16 data_size;
+	u8 *data;
+};
+
+struct ice_fwlog_ring {
+	struct ice_fwlog_data *rings;
+	u16 size;
+	u16 head;
+	u16 tail;
+};
+
+#define ICE_FWLOG_RING_SIZE_DFLT 256
+#define ICE_FWLOG_RING_SIZE_MAX 512
+
+bool ice_fwlog_ring_full(struct ice_fwlog_ring *rings);
+bool ice_fwlog_ring_empty(struct ice_fwlog_ring *rings);
+void ice_fwlog_ring_increment(u16 *item, u16 size);
 void ice_fwlog_set_supported(struct ice_hw *hw);
 bool ice_fwlog_supported(struct ice_hw *hw);
 int ice_fwlog_init(struct ice_hw *hw);
 void ice_fwlog_deinit(struct ice_hw *hw);
+void ice_fwlog_deinit(struct ice_hw *hw);
 int ice_fwlog_set(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_get(struct ice_hw *hw, struct ice_fwlog_cfg *cfg);
 int ice_fwlog_register(struct ice_hw *hw);
 int ice_fwlog_unregister(struct ice_hw *hw);
+void ice_fwlog_realloc_rings(struct ice_hw *hw, int num_rings);
 #endif /* _ICE_FWLOG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dd578b68467e..02f9ef360b51 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1250,6 +1250,32 @@ ice_handle_link_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 	return status;
 }
 
+/**
+ * ice_get_fwlog_data - copy the FW log data from ARQ event
+ * @pf: PF that the FW log event is associated with
+ * @event: event structure containing FW log data
+ */
+static void
+ice_get_fwlog_data(struct ice_pf *pf, struct ice_rq_event_info *event)
+{
+	struct ice_fwlog_data *fwlog;
+	struct ice_hw *hw = &pf->hw;
+
+	fwlog = &hw->fwlog_ring.rings[hw->fwlog_ring.tail];
+
+	memset(fwlog->data, 0, PAGE_SIZE);
+	fwlog->data_size = le16_to_cpu(event->desc.datalen);
+
+	memcpy(fwlog->data, event->msg_buf, fwlog->data_size);
+	ice_fwlog_ring_increment(&hw->fwlog_ring.tail, hw->fwlog_ring.size);
+
+	if (ice_fwlog_ring_full(&hw->fwlog_ring)) {
+		/* the rings are full so bump the head to create room */
+		ice_fwlog_ring_increment(&hw->fwlog_ring.head,
+					 hw->fwlog_ring.size);
+	}
+}
+
 enum ice_aq_task_state {
 	ICE_AQ_TASK_WAITING = 0,
 	ICE_AQ_TASK_COMPLETE,
@@ -1530,6 +1556,9 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 
 			ice_vc_process_vf_msg(pf, &event, &data);
 			break;
+		case ice_aqc_opc_fw_logs_event:
+			ice_get_fwlog_data(pf, &event);
+			break;
 		case ice_aqc_opc_lldp_set_mib_change:
 			ice_dcb_process_lldp_set_mib_change(pf, &event);
 			break;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 16904cb8a25b..f1231a8162af 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -865,6 +865,7 @@ struct ice_hw {
 
 	struct ice_fwlog_cfg fwlog_cfg;
 	bool fwlog_supported; /* does hardware support FW logging? */
+	struct ice_fwlog_ring fwlog_ring;
 
 /* Device max aggregate bandwidths corresponding to the GL_PWR_MODE_CTL
  * register. Used for determining the ITR/INTRL granularity during
-- 
2.38.1


