Return-Path: <netdev+bounces-111594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681F931AA8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 21:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F032811F7
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43A78C6C;
	Mon, 15 Jul 2024 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4nVlNV2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526317588
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070738; cv=none; b=klTjgg25LUseScl7PI8nOcEOqX/ahbeX675JoeY1Sq2vYct21up0zSzlEge5lQJ+8EUgvqGRMUdWrCVOzd1YE6YNsmehUrCJYKB3kZRFRRwmg0Lz/7Pi4An4TzOAhkR6IZLmRNQpHU/l8/3kZ/eNWnerMVXpzWzhZGv3Z3UK380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070738; c=relaxed/simple;
	bh=5e32aGrDkQ+8+nnK1OKNyx/Zqlk2eAxCsTVxfnQQC/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gq3OJ97pC6K+3ycBDl2PRoBjbkURusu+ccuOhQIqLJsQnPUUZqQfqVfy6i5Q91pbi7nCMxnn+tesLFU7rZNG/wJMS4ujg3NpwdGta/f6Z0URgwd9igj8o18rybUFd650BJ1LeHMhVY2sgF1/kdrnVhLrhKjctCxZ1XQGj3TU994=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M4nVlNV2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721070735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9FyOTMQEyctKcX6PD7xEEfPVD/zlnl5HQmXYTfM+6jY=;
	b=M4nVlNV2C8CjHhd8QrDMaWZOrQGrseNZWGH+Fc+aaNVI69dw9UwsK2pePagfhXMX7jelEa
	lPuDXAPG6YH6md6cmmobSjGxXYu/kgf9DcgLc+9ympv+rH0s2Lt06gebwQGZpOJ4o6M84U
	w8GbMjBAujsULflBEciqAcu2YgmpSt0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-On_l9IgAOuGIKzO9doLriA-1; Mon,
 15 Jul 2024 15:12:11 -0400
X-MC-Unique: On_l9IgAOuGIKzO9doLriA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10DDE1955D53;
	Mon, 15 Jul 2024 19:12:10 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.16.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9479D19560AE;
	Mon, 15 Jul 2024 19:12:07 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH iwl-next] i40e: Add support for fw health report
Date: Mon, 15 Jul 2024 15:11:48 -0400
Message-ID: <20240715191148.746362-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support for reporting fw status via the devlink health report.

Example:
 # devlink health show pci/0000:02:00.0 reporter fw
 pci/0000:02:00.0:
   reporter fw
     state healthy error 0 recover 0
 # devlink health diagnose pci/0000:02:00.0 reporter fw
 Status: normal

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 57 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.h    |  2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 15 +++++
 4 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d546567e0286..f94671b6e7c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -465,6 +465,7 @@ static inline const u8 *i40e_channel_mac(struct i40e_channel *ch)
 struct i40e_pf {
 	struct pci_dev *pdev;
 	struct devlink_port devlink_port;
+	struct devlink_health_reporter *fw_health_report;
 	struct i40e_hw hw;
 	DECLARE_BITMAP(state, __I40E_STATE_SIZE__);
 	struct msix_entry *msix_entries;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index cc4e9e2addb7..ad91c150cdba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -122,6 +122,25 @@ static int i40e_devlink_info_get(struct devlink *dl,
 	return err;
 }
 
+static int i40e_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
+				     struct devlink_fmsg *fmsg,
+				     struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_health_reporter_priv(reporter);
+
+	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
+		devlink_fmsg_string_pair_put(fmsg, "Status", "recovery");
+	else
+		devlink_fmsg_string_pair_put(fmsg, "Status", "normal");
+
+	return 0;
+}
+
+static const struct devlink_health_reporter_ops i40e_fw_reporter_ops = {
+	.name = "fw",
+	.diagnose = i40e_fw_reporter_diagnose,
+};
+
 static const struct devlink_ops i40e_devlink_ops = {
 	.info_get = i40e_devlink_info_get,
 };
@@ -233,3 +252,41 @@ void i40e_devlink_destroy_port(struct i40e_pf *pf)
 {
 	devlink_port_unregister(&pf->devlink_port);
 }
+
+/**
+ * i40e_devlink_create_health_reporter - Create the health reporter for this PF
+ * @pf: the PF to create reporter for
+ *
+ * Create health reporter for this PF.
+ *
+ * Return: zero on success or an error code on failure.
+ **/
+int i40e_devlink_create_health_reporter(struct i40e_pf *pf)
+{
+	struct devlink *devlink = priv_to_devlink(pf);
+	struct device *dev = &pf->pdev->dev;
+	int rc = 0;
+
+	devl_lock(devlink);
+	pf->fw_health_report =
+		devl_health_reporter_create(devlink, &i40e_fw_reporter_ops, 0, pf);
+	if (IS_ERR(pf->fw_health_report)) {
+		rc = PTR_ERR(pf->fw_health_report);
+		dev_err(dev, "Failed to create fw reporter, err = %d\n", rc);
+	}
+	devl_unlock(devlink);
+
+	return rc;
+}
+
+/**
+ * i40e_devlink_destroy_health_reporter - Destroy the health reporter
+ * @pf: the PF to cleanup
+ *
+ * Destroy the health reporter
+ **/
+void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf)
+{
+	if (!IS_ERR_OR_NULL(pf->fw_health_report))
+		devlink_health_reporter_destroy(pf->fw_health_report);
+}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.h b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
index 469fb3d2ee25..018679094bb5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
@@ -14,5 +14,7 @@ void i40e_devlink_register(struct i40e_pf *pf);
 void i40e_devlink_unregister(struct i40e_pf *pf);
 int i40e_devlink_create_port(struct i40e_pf *pf);
 void i40e_devlink_destroy_port(struct i40e_pf *pf);
+int i40e_devlink_create_health_reporter(struct i40e_pf *pf);
+void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf);
 
 #endif /* _I40E_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index cbcfada7b357..13cad5f58029 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15370,6 +15370,9 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
 		dev_crit(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
 		dev_crit(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
 		set_bit(__I40E_RECOVERY_MODE, pf->state);
+		if (pf->fw_health_report)
+			devlink_health_report(pf->fw_health_report,
+					      "FW recovery mode detected", pf);
 
 		return true;
 	}
@@ -15636,6 +15639,14 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENOMEM;
 		goto err_pf_alloc;
 	}
+
+	err = i40e_devlink_create_health_reporter(pf);
+	if (err) {
+		dev_err(&pdev->dev,
+			"Failed to create health reporter %d\n", err);
+		goto err_health_reporter;
+	}
+
 	pf->next_vsi = 0;
 	pf->pdev = pdev;
 	set_bit(__I40E_DOWN, pf->state);
@@ -16180,6 +16191,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_pf_reset:
 	iounmap(hw->hw_addr);
 err_ioremap:
+	i40e_devlink_destroy_health_reporter(pf);
+err_health_reporter:
 	i40e_free_pf(pf);
 err_pf_alloc:
 	pci_release_mem_regions(pdev);
@@ -16209,6 +16222,8 @@ static void i40e_remove(struct pci_dev *pdev)
 
 	i40e_devlink_unregister(pf);
 
+	i40e_devlink_destroy_health_reporter(pf);
+
 	i40e_dbg_pf_exit(pf);
 
 	i40e_ptp_stop(pf);
-- 
2.45.2


