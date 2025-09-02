Return-Path: <netdev+bounces-219363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE0B410B6
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4D07002A5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57E280309;
	Tue,  2 Sep 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gE4dh46v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B327EFF7
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855304; cv=none; b=I3fdcob/ZlWRCbnwkvCO4nRh3gazcWa55Ll802MukXfEqlAJ+V2ljoYqXc0uoFLM4R0msYsXMzOn95GOz6tlTzYmS5DRVJtrwNftKWT8RbHq+cfgFZmvIZiJj9PHvR+qVpT893/InUDJG1pbb14/5mellvUSw3lb3pPUUnlYKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855304; c=relaxed/simple;
	bh=53V4qY1sa5GGEJCcutzHhai/49Z7vtVJXpCPK9jkyTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPme8COpVjkvVTqvGNWjv7qiSHpt7zX7wLacMITWfcfuU/6SlIckBGcIW/DqVpa7eJwqJ9VFc5xSNt9NQkjp/Lnb9ef/6gqUT7/a+oBCRys7duknJ/cxNsn5A797pk1wvTMmtliuyjF3BPYZq1rXchObCRITOE8+D2jnX5hAXS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gE4dh46v; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855302; x=1788391302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53V4qY1sa5GGEJCcutzHhai/49Z7vtVJXpCPK9jkyTA=;
  b=gE4dh46vsiypqkugl7MrMAQwN+VGwd/RFlBnD91jar3585IBCnMELIXl
   2Kt6lL2xyNigNZoVq8iy4QJxkcP01W66r2mNza9FE8lUTcsN2+YiTaWbT
   ybsSUXjz5iKB1Ak2ctbaPK6CYzhhULw6F1GNLUOU+Ai53am387z8XnRab
   BJzoygFnrOCUqIV/fPwvqmBx3blYEsKpBvJvrAE6dGu9xuKkojSkwcGxz
   Bt/KvStkemPESvh9e7RrYNXmlMDUvog6l3AuLmaMwaAkFiYt7KoT+3HX3
   huoY0Eot6tID38lyQhHNn1rx14yjymhobALvTI3YYxbcbp93pKMMl2Ct/
   g==;
X-CSE-ConnectionGUID: hIVbqu+QR96VcXZG0z2WHw==
X-CSE-MsgGUID: OeyGt//kTyOCs2WFBLFk5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767217"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767217"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:38 -0700
X-CSE-ConnectionGUID: 3mHfSGyERZCHBv3+raepDw==
X-CSE-MsgGUID: ZYVs/1H4QraQZYs2Mefbvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575903"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	sln@onemain.com,
	Kunwu Chan <chentao@kylinos.cn>,
	Wang Haoran <haoranwangsec@gmail.com>,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 5/8] i40e: remove read access to debugfs files
Date: Tue,  2 Sep 2025 16:21:25 -0700
Message-ID: <20250902232131.2739555-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
References: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The 'command' and 'netdev_ops' debugfs files are a legacy debugging
interface supported by the i40e driver since its early days by commit
02e9c290814c ("i40e: debugfs interface").

Both of these debugfs files provide a read handler which is mostly useless,
and which is implemented with questionable logic. They both use a static
256 byte buffer which is initialized to the empty string. In the case of
the 'command' file this buffer is literally never used and simply wastes
space. In the case of the 'netdev_ops' file, the last command written is
saved here.

On read, the files contents are presented as the name of the device
followed by a colon and then the contents of their respective static
buffer. For 'command' this will always be "<device>: ". For 'netdev_ops',
this will be "<device>: <last command written>". But note the buffer is
shared between all devices operated by this module. At best, it is mostly
meaningless information, and at worse it could be accessed simultaneously
as there doesn't appear to be any locking mechanism.

We have also recently received multiple reports for both read functions
about their use of snprintf and potential overflow that could result in
reading arbitrary kernel memory. For the 'command' file, this is definitely
impossible, since the static buffer is always zero and never written to.
For the 'netdev_ops' file, it does appear to be possible, if the user
carefully crafts the command input, it will be copied into the buffer,
which could be large enough to cause snprintf to truncate, which then
causes the copy_to_user to read beyond the length of the buffer allocated
by kzalloc.

A minimal fix would be to replace snprintf() with scnprintf() which would
cap the return to the number of bytes written, preventing an overflow. A
more involved fix would be to drop the mostly useless static buffers,
saving 512 bytes and modifying the read functions to stop needing those as
input.

Instead, lets just completely drop the read access to these files. These
are debug interfaces exposed as part of debugfs, and I don't believe that
dropping read access will break any script, as the provided output is
pretty useless. You can find the netdev name through other more standard
interfaces, and the 'netdev_ops' interface can easily result in garbage if
you issue simultaneous writes to multiple devices at once.

In order to properly remove the i40e_dbg_netdev_ops_buf, we need to
refactor its write function to avoid using the static buffer. Instead, use
the same logic as the i40e_dbg_command_write, with an allocated buffer.
Update the code to use this instead of the static buffer, and ensure we
free the buffer on exit. This fixes simultaneous writes to 'netdev_ops' on
multiple devices, and allows us to remove the now unused static buffer
along with removing the read access.

Fixes: 02e9c290814c ("i40e: debugfs interface")
Reported-by: Kunwu Chan <chentao@kylinos.cn>
Closes: https://lore.kernel.org/intel-wired-lan/20231208031950.47410-1-chentao@kylinos.cn/
Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Closes: https://lore.kernel.org/all/CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com/
Reported-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Closes: https://lore.kernel.org/all/20250722115017.206969-1-a.jahangirzad@gmail.com/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@linux.dev>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 123 +++---------------
 1 file changed, 19 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 6cd6f23d42a6..c17b5d290f0a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -40,48 +40,6 @@ static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
  * setup, adding or removing filters, or other things.  Many of
  * these will be useful for some forms of unit testing.
  **************************************************************/
-static char i40e_dbg_command_buf[256] = "";
-
-/**
- * i40e_dbg_command_read - read for command datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- **/
-static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
-				     size_t count, loff_t *ppos)
-{
-	struct i40e_pf *pf = filp->private_data;
-	struct i40e_vsi *main_vsi;
-	int bytes_not_copied;
-	int buf_size = 256;
-	char *buf;
-	int len;
-
-	/* don't allow partial reads */
-	if (*ppos != 0)
-		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOSPC;
-
-	main_vsi = i40e_pf_get_main_vsi(pf);
-	len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
-		       i40e_dbg_command_buf);
-
-	bytes_not_copied = copy_to_user(buffer, buf, len);
-	kfree(buf);
-
-	if (bytes_not_copied)
-		return -EFAULT;
-
-	*ppos = len;
-	return len;
-}
 
 static char *i40e_filter_state_string[] = {
 	"INVALID",
@@ -1621,7 +1579,6 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 static const struct file_operations i40e_dbg_command_fops = {
 	.owner = THIS_MODULE,
 	.open =  simple_open,
-	.read =  i40e_dbg_command_read,
 	.write = i40e_dbg_command_write,
 };
 
@@ -1630,48 +1587,6 @@ static const struct file_operations i40e_dbg_command_fops = {
  * The netdev_ops entry in debugfs is for giving the driver commands
  * to be executed from the netdev operations.
  **************************************************************/
-static char i40e_dbg_netdev_ops_buf[256] = "";
-
-/**
- * i40e_dbg_netdev_ops_read - read for netdev_ops datum
- * @filp: the opened file
- * @buffer: where to write the data for the user to read
- * @count: the size of the user's buffer
- * @ppos: file position offset
- **/
-static ssize_t i40e_dbg_netdev_ops_read(struct file *filp, char __user *buffer,
-					size_t count, loff_t *ppos)
-{
-	struct i40e_pf *pf = filp->private_data;
-	struct i40e_vsi *main_vsi;
-	int bytes_not_copied;
-	int buf_size = 256;
-	char *buf;
-	int len;
-
-	/* don't allow partal reads */
-	if (*ppos != 0)
-		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
-
-	buf = kzalloc(buf_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOSPC;
-
-	main_vsi = i40e_pf_get_main_vsi(pf);
-	len = snprintf(buf, buf_size, "%s: %s\n", main_vsi->netdev->name,
-		       i40e_dbg_netdev_ops_buf);
-
-	bytes_not_copied = copy_to_user(buffer, buf, len);
-	kfree(buf);
-
-	if (bytes_not_copied)
-		return -EFAULT;
-
-	*ppos = len;
-	return len;
-}
 
 /**
  * i40e_dbg_netdev_ops_write - write into netdev_ops datum
@@ -1685,35 +1600,36 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 					 size_t count, loff_t *ppos)
 {
 	struct i40e_pf *pf = filp->private_data;
+	char *cmd_buf, *buf_tmp;
 	int bytes_not_copied;
 	struct i40e_vsi *vsi;
-	char *buf_tmp;
 	int vsi_seid;
 	int i, cnt;
 
 	/* don't allow partial writes */
 	if (*ppos != 0)
 		return 0;
-	if (count >= sizeof(i40e_dbg_netdev_ops_buf))
-		return -ENOSPC;
 
-	memset(i40e_dbg_netdev_ops_buf, 0, sizeof(i40e_dbg_netdev_ops_buf));
-	bytes_not_copied = copy_from_user(i40e_dbg_netdev_ops_buf,
-					  buffer, count);
-	if (bytes_not_copied)
+	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!cmd_buf)
+		return count;
+	bytes_not_copied = copy_from_user(cmd_buf, buffer, count);
+	if (bytes_not_copied) {
+		kfree(cmd_buf);
 		return -EFAULT;
-	i40e_dbg_netdev_ops_buf[count] = '\0';
+	}
+	cmd_buf[count] = '\0';
 
-	buf_tmp = strchr(i40e_dbg_netdev_ops_buf, '\n');
+	buf_tmp = strchr(cmd_buf, '\n');
 	if (buf_tmp) {
 		*buf_tmp = '\0';
-		count = buf_tmp - i40e_dbg_netdev_ops_buf + 1;
+		count = buf_tmp - cmd_buf + 1;
 	}
 
-	if (strncmp(i40e_dbg_netdev_ops_buf, "change_mtu", 10) == 0) {
+	if (strncmp(cmd_buf, "change_mtu", 10) == 0) {
 		int mtu;
 
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i %i",
+		cnt = sscanf(&cmd_buf[11], "%i %i",
 			     &vsi_seid, &mtu);
 		if (cnt != 2) {
 			dev_info(&pf->pdev->dev, "change_mtu <vsi_seid> <mtu>\n");
@@ -1735,8 +1651,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "Could not acquire RTNL - please try again\n");
 		}
 
-	} else if (strncmp(i40e_dbg_netdev_ops_buf, "set_rx_mode", 11) == 0) {
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[11], "%i", &vsi_seid);
+	} else if (strncmp(cmd_buf, "set_rx_mode", 11) == 0) {
+		cnt = sscanf(&cmd_buf[11], "%i", &vsi_seid);
 		if (cnt != 1) {
 			dev_info(&pf->pdev->dev, "set_rx_mode <vsi_seid>\n");
 			goto netdev_ops_write_done;
@@ -1756,8 +1672,8 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "Could not acquire RTNL - please try again\n");
 		}
 
-	} else if (strncmp(i40e_dbg_netdev_ops_buf, "napi", 4) == 0) {
-		cnt = sscanf(&i40e_dbg_netdev_ops_buf[4], "%i", &vsi_seid);
+	} else if (strncmp(cmd_buf, "napi", 4) == 0) {
+		cnt = sscanf(&cmd_buf[4], "%i", &vsi_seid);
 		if (cnt != 1) {
 			dev_info(&pf->pdev->dev, "napi <vsi_seid>\n");
 			goto netdev_ops_write_done;
@@ -1775,21 +1691,20 @@ static ssize_t i40e_dbg_netdev_ops_write(struct file *filp,
 			dev_info(&pf->pdev->dev, "napi called\n");
 		}
 	} else {
-		dev_info(&pf->pdev->dev, "unknown command '%s'\n",
-			 i40e_dbg_netdev_ops_buf);
+		dev_info(&pf->pdev->dev, "unknown command '%s'\n", cmd_buf);
 		dev_info(&pf->pdev->dev, "available commands\n");
 		dev_info(&pf->pdev->dev, "  change_mtu <vsi_seid> <mtu>\n");
 		dev_info(&pf->pdev->dev, "  set_rx_mode <vsi_seid>\n");
 		dev_info(&pf->pdev->dev, "  napi <vsi_seid>\n");
 	}
 netdev_ops_write_done:
+	kfree(cmd_buf);
 	return count;
 }
 
 static const struct file_operations i40e_dbg_netdev_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = i40e_dbg_netdev_ops_read,
 	.write = i40e_dbg_netdev_ops_write,
 };
 
-- 
2.47.1


