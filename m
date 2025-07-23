Return-Path: <netdev+bounces-209143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE3B0E77C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30C97A794D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF0EAE7;
	Wed, 23 Jul 2025 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgs2i13d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45FC13B
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753229705; cv=none; b=lkjvGKDsk8WnxzNcaOVoh7X4ayxw2RJRGaY7Ha6oEO2PpN3v4WHoJHhdvAnIjM+Qi6ZTTJGE4Ewo7tX9tHejqxcSN+vjy+IUQ7gohqD5yWA+ThMGfPDtJh+hZM/ToU5uLdLo2180aG9CaFBpAlgF7NtiVk576oypKwYH1sh1MRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753229705; c=relaxed/simple;
	bh=sm2CA2uIi2k8E4WwjotnbQY2GEvlE/t9Zo/1xu6zMiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pJLHjE6peARNrRHKJ3LF4tNQt+Uc8p4/VwxSUa2TqwTUL/GBkZA32nusCTY1hI/JsGyU2/50aAB6YnkW+w6hfOTw2GJMcJAhFHWvhKe2iL77KApqJNgGfkQpNgudEwKB5vfnMJ7ALuotgCrXaKl1MYBVfUlN+QAoH2I3CsxW/ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgs2i13d; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753229704; x=1784765704;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=sm2CA2uIi2k8E4WwjotnbQY2GEvlE/t9Zo/1xu6zMiw=;
  b=Qgs2i13d7tISEXXARvndQzFXkimCyCnfQang2ibUaKu69TF5H6q9VGLy
   ioJ6WeaClEIrQmtwLdpublK4RZKJKNau+qCBZhTLI8rbGdNX5tt6QWIvq
   cschw1IfQwIZGfjLYJtkfh/FStoMarwUjfPTjB6m8ccOtAy2NJYlcGoae
   pz4ta3L36KFesgiwcelSAHBVrsE09Dn8AR9oqegwA++vKBmw6F1uqK4+r
   KeiCwuI1CUaLav2s3IQBYL2JOhMBPB2TVhDT6yIYw5RoJaVMkC/per2pI
   NavuIT5Ezl+tv8TSUC5eLBJpMnQJ6Z47ti6eAJfRbydgJOiPTJwOLpyqs
   w==;
X-CSE-ConnectionGUID: WSebdztVT2qL7Gk04yV3Zw==
X-CSE-MsgGUID: Q6iKxuBKTCC42Tdb63m9hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59299482"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59299482"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 17:15:03 -0700
X-CSE-ConnectionGUID: iFlcOIF9QqqbCIokH+4E8A==
X-CSE-MsgGUID: UssbUNy6Qw+kkrxrQkxgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159666364"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 17:15:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Jul 2025 17:14:37 -0700
Subject: [PATCH] i40e: remove read access to debugfs files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-jk-drop-debugfs-read-access-v1-1-27f13f08d406@intel.com>
X-B4-Tracking: v=1; b=H4sIAG0pgGgC/x3MwQqDMAwA0F+RnA1oaKnuV4aHrk01G6gkOAbiv
 694fJd3grEKGzyaE5S/YrKtFX3bQFriOjNKrgbqyHeBCN8fzLrtmPl1zMVQOWaMKbEZjqML1A/
 BkxugDrtykd+9P6fr+gNEWlXdbQAAAA==
X-Change-ID: 20250722-jk-drop-debugfs-read-access-994721875248
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Kunwu Chan <chentao@kylinos.cn>, Wang Haoran <haoranwangsec@gmail.com>, 
 Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.15-dev-d4ca8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10667;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=sm2CA2uIi2k8E4WwjotnbQY2GEvlE/t9Zo/1xu6zMiw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowGzSa+JQtve95Ovds8L+DmlevTn8265NMi2mnA7n9q4
 81s55C1HaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkqw4jw+r1bgZvbeasNz31
 UeDFu9asD98k3vhHnfl0frfqhhyXJbMZ/mlx31+msSh02b2NZdZHLPbaBXbKdKu/Ya74F79rjlR
 xLjMA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

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

Reported-by: Kunwu Chan <chentao@kylinos.cn>
Closes: https://lore.kernel.org/intel-wired-lan/20231208031950.47410-1-chentao@kylinos.cn/
Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Closes: https://lore.kernel.org/all/CANZ3JQRRiOdtfQJoP9QM=6LS1Jto8PGBGw6y7-TL=BcnzHQn1Q@mail.gmail.com/
Reported-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Closes: https://lore.kernel.org/all/20250722115017.206969-1-a.jahangirzad@gmail.com/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
I found several reports of the issues with these read functions going at
least as far back  as 2023, with suggestions to remove the read access even
back then. None of the fixes got accepted or applied, but neither did Intel
follow up with removing the interfaces. Its time to just drop the read
access altogether.
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 123 ++++---------------------
 1 file changed, 19 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 6cd9da662ae1..a5c794371dfe 100644
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
 

---
base-commit: cf074eca0065bc5142e6004ae236bb35a2687fdf
change-id: 20250722-jk-drop-debugfs-read-access-994721875248

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


