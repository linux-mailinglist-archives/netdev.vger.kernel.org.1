Return-Path: <netdev+bounces-125745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350CC96E663
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 01:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CCE1C22F6E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE01B4C56;
	Thu,  5 Sep 2024 23:39:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720F65381B;
	Thu,  5 Sep 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579551; cv=none; b=XaxDKm/Byf/W1bCt3B+WgjUq82+kgeNd8t70YtwkduLTGcQu9YegIlhhZGaILDq7kn9HiCRPMtRbpzOwGShTZ43R4SBmrCO4vGtt15J+eqH8LEPXzwZvRnRt20etBoap0hAyISKfNxcR5xUh+oLq/EnsrwjQvNcjf12mgZor/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579551; c=relaxed/simple;
	bh=cQQmJ5AgekB3x6oTYMEqlDF58JG5FJt2/c46w/qfVsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=stSRxcqex+VOUlv1GOIGfXUf4AwUR2twnxf/DLAMlBwTVL44Rogs4vx4sWphupVuOhPmHP4iZMd8an+wmBL4PYYDhJw6AHV+orgrDM1MWbJuLhYZgXSZArpe0q4m7ur6FlZ5tJbJUM6abrx0WNe0wrioL55gFEuo2kMpqMO5kTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=localhost)
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1smM44-00024n-O4; Thu, 05 Sep 2024 23:39:01 +0000
From: Lee Trager <lee@trager.us>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Shinas Rasheed <srasheed@marvell.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Lee Trager <lee@trager.us>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Sanman Pradhan <sanmanpradhan@meta.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] eth: fbnic: Add devlink firmware version info
Date: Thu,  5 Sep 2024 16:37:51 -0700
Message-ID: <20240905233820.1713043-1-lee@trager.us>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support to show firmware version information for both stored and
running firmware versions. The version and commit is displayed separately
to aid monitoring tools which only care about the version.

Example output:
  # devlink dev info
  pci/0000:01:00.0:
    driver fbnic
    serial_number 88-25-08-ff-ff-01-50-92
    versions:
        running:
          fw 24.07.15-017
          fw.commit h999784ae9df0
          fw.bootloader 24.07.10-000
          fw.bootloader.commit hfef3ac835ce7
        stored:
          fw 24.07.24-002
          fw.commit hc9d14a68b3f2
          fw.bootloader 24.07.22-000
          fw.bootloader.commit h922f8493eb96
          fw.undi 01.00.03-000

Signed-off-by: Lee Trager <lee@trager.us>
---
 .../device_drivers/ethernet/index.rst         |  1 +
 .../device_drivers/ethernet/meta/fbnic.rst    | 29 +++++++
 MAINTAINERS                                   |  1 +
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   | 75 +++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/meta/fbnic.rst

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 6932d8c043c2..6fc1961492b7 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -44,6 +44,7 @@ Contents:
    marvell/octeon_ep
    marvell/octeon_ep_vf
    mellanox/mlx5/index
+   meta/fbnic
    microsoft/netvsc
    neterion/s2io
    netronome/nfp
diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
new file mode 100644
index 000000000000..32ff114f5c26
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=====================================
+Meta Platforms Host Network Interface
+=====================================
+
+Firmware Versions
+-----------------
+
+fbnic has three components stored on the flash which are provided in one PLDM
+image:
+
+1. fw - The control firmware used to view and modify firmware settings, request
+   firmware actions, and retrieve firmware counters outside of the data path.
+   This is the firmware which fbnic_fw.c interacts with.
+2. bootloader - The firmware which validate firmware security and control basic
+   operations including loading and updating the firmware. This is also known
+   as the cmrt firmware.
+3. undi - This is the UEFI driver which is based on the Linux driver.
+
+fbnic stores two copies of these three components on flash. This allows fbnic
+to fall back to an older version of firmware automatically in case firmware
+fails to boot. Version information for both is provided as running and stored.
+The undi is only provided in stored as it is not actively running once the Linux
+driver takes over.
+
+devlink dev info provides version information for all three components. In
+addition to the version the hg commit hash of the build is included as a
+separate entry.
diff --git a/MAINTAINERS b/MAINTAINERS
index baf88e74c907..fae13f784226 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14819,6 +14819,7 @@ M:	Alexander Duyck <alexanderduyck@fb.com>
 M:	Jakub Kicinski <kuba@kernel.org>
 R:	kernel-team@meta.com
 S:	Supported
+F:	Documentation/networking/device_drivers/ethernet/meta/
 F:	drivers/net/ethernet/meta/

 METHODE UDPU SUPPORT
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index e87049dfd223..ef05ae8f5039 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -10,6 +10,56 @@

 #define FBNIC_SN_STR_LEN	24

+static int fbnic_version_running_put(struct devlink_info_req *req,
+				     struct fbnic_fw_ver *fw_ver,
+				     char *ver_name)
+{
+	char running_ver[FBNIC_FW_VER_MAX_SIZE];
+	int err;
+
+	fbnic_mk_fw_ver_str(fw_ver->version, running_ver);
+	err = devlink_info_version_running_put(req, ver_name, running_ver);
+	if (err)
+		return err;
+
+	if (strlen(fw_ver->commit) > 0) {
+		char commit_name[FBNIC_SN_STR_LEN];
+
+		snprintf(commit_name, FBNIC_SN_STR_LEN, "%s.commit", ver_name);
+		err = devlink_info_version_running_put(req, commit_name,
+						       fw_ver->commit);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int fbnic_version_stored_put(struct devlink_info_req *req,
+				    struct fbnic_fw_ver *fw_ver,
+				    char *ver_name)
+{
+	char stored_ver[FBNIC_FW_VER_MAX_SIZE];
+	int err;
+
+	fbnic_mk_fw_ver_str(fw_ver->version, stored_ver);
+	err = devlink_info_version_stored_put(req, ver_name, stored_ver);
+	if (err)
+		return err;
+
+	if (strlen(fw_ver->commit) > 0) {
+		char commit_name[FBNIC_SN_STR_LEN];
+
+		snprintf(commit_name, FBNIC_SN_STR_LEN, "%s.commit", ver_name);
+		err = devlink_info_version_stored_put(req, commit_name,
+						      fw_ver->commit);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int fbnic_devlink_info_get(struct devlink *devlink,
 				  struct devlink_info_req *req,
 				  struct netlink_ext_ack *extack)
@@ -17,6 +67,31 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
 	struct fbnic_dev *fbd = devlink_priv(devlink);
 	int err;

+	err = fbnic_version_running_put(req, &fbd->fw_cap.running.mgmt,
+					DEVLINK_INFO_VERSION_GENERIC_FW);
+	if (err)
+		return err;
+
+	err = fbnic_version_running_put(req, &fbd->fw_cap.running.bootloader,
+					DEVLINK_INFO_VERSION_GENERIC_FW_BOOTLOADER);
+	if (err)
+		return err;
+
+	err = fbnic_version_stored_put(req, &fbd->fw_cap.stored.mgmt,
+				       DEVLINK_INFO_VERSION_GENERIC_FW);
+	if (err)
+		return err;
+
+	err = fbnic_version_stored_put(req, &fbd->fw_cap.stored.bootloader,
+				       DEVLINK_INFO_VERSION_GENERIC_FW_BOOTLOADER);
+	if (err)
+		return err;
+
+	err = fbnic_version_stored_put(req, &fbd->fw_cap.stored.undi,
+				       DEVLINK_INFO_VERSION_GENERIC_FW_UNDI);
+	if (err)
+		return err;
+
 	if (fbd->dsn) {
 		unsigned char serial[FBNIC_SN_STR_LEN];
 		u8 dsn[8];
--
2.43.5

