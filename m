Return-Path: <netdev+bounces-111915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5602934176
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464CD1F2111D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449961822CA;
	Wed, 17 Jul 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qnzpf/cO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AE274E26
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237155; cv=none; b=iRaW+OKxsZVDpufqZ3YDwhbjnfCfRcZIYuL6CrWZltbxotazzulaVV4YLCQDNqzFsNLiJi2Az6CjKKp4j+zmR+Eiw000MX+EFpEMls7RFYOgBqSmM79lwL6k5bw0ErG9O3EOIu/U3EWCb3JpjYRv4PP/Qahi/d5hCFcMGyeOrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237155; c=relaxed/simple;
	bh=1SbBRcGJHRZdJQSKkAtElFYIJFXy5aDBQ07yqD4E2rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM2tWpltwWsevN+WBc/zR7lA/EtIEVtH6zz14F/bfGIExelmDFlp2QbWT/Spgqa3XKEFrcs57HKGkAk+ZbCKs49mr3RZcXNOyHm3RKjm5gjna4Q9qa0CaCCu8+8sDEJmVfS5vJ3Vj+v735tdUpR5dP7XM9WIvGGbwImlmnZZLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qnzpf/cO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721237152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lu1GyI9JAIOiUE0J5ISEn7mevghFQULbc7dQVhpdMfg=;
	b=Qnzpf/cOcDqDpxHc7hsuy+ICBpVXnFVGMDQDmHhZR1dbL7NRs7tDIZ4kHxk0MKF2Z5qD5B
	S/lOVqITLz7WweafAv9AvG1bFGdlEqqhuRafvyngZMfsOGcS1LoZY8lKyc2TBvtZwcv1HV
	JTV6p5H2zDXBHMlNNAvnZZJJwDUp4Bk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-q1ld7Ay-M8ytkzTgtZ4hDg-1; Wed, 17 Jul 2024 13:25:50 -0400
X-MC-Unique: q1ld7Ay-M8ytkzTgtZ4hDg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b79a77f265so126536d6.2
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 10:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721237150; x=1721841950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu1GyI9JAIOiUE0J5ISEn7mevghFQULbc7dQVhpdMfg=;
        b=NO3nyrJ6/ISJW84/+5QXRr9vDuFhXIcYf3Pq+hsccX/5CaVbatHTZSMfgwLJ1s/qEd
         5jtsXv8RnxxfpBPzM6JWFGHrHodjz0ZP7c2rnOgHgo/GW4bzgD7WNcuMuNioL5QvEFm+
         PNYl6p/jLvEc0v4twivi8AwMCnXGGtcLaSLgY8lPrhHYL+3iDAEJuHWpCnTESdTVwHVq
         xphydqk9RtBX5PpUixqdBXvr8RIJx99C1syWCkyyPmlmghTNqdAIwcRkpAg6CppCMyjc
         ubGMLLUDc+JUWHib9KpVLIePDVfMHSB8cxPGjnIEhBd3zaVmOdAFmoLE1Qd+DcpQEha7
         GNKg==
X-Forwarded-Encrypted: i=1; AJvYcCW5anb2z0LKCh5456BHfsSJFf/UAQqpdIlh60uxE8uEQgcY+Zhu3Ss85WYW/CIOO6ScX3HXkX9XVszHqnsimW6fGjz4OFV2
X-Gm-Message-State: AOJu0Yz2W5LXfTifnUygFHQ6N6Hsm+GOivt/OiyBA99nvVBsfBV0fq23
	UJ1PR1fQq47uKWGVQtQVScl7jX3aZoza12qvKhbdnZaFUnaxuK0MDgthgDNE+DHfxXJ1FRNxX9R
	1BuGRGyUzDrUjNngs6S+LunONcz3j+ppHi+HpO2p45E3TfOCse+VxVg==
X-Received: by 2002:a05:6214:20a7:b0:6b5:2b33:5445 with SMTP id 6a1803df08f44-6b79c5c9a1cmr1077666d6.25.1721237150296;
        Wed, 17 Jul 2024 10:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhXarTu58sXJCSQkMUfsI0kMSFzUiUh2z8hFp1TcU+T3Xeke850y5NpiqMVazkQooE2oLEQw==
X-Received: by 2002:a05:6214:20a7:b0:6b5:2b33:5445 with SMTP id 6a1803df08f44-6b79c5c9a1cmr1077466d6.25.1721237149892;
        Wed, 17 Jul 2024 10:25:49 -0700 (PDT)
Received: from fedora-x1 ([142.126.87.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c64fe30sm287576d6.110.2024.07.17.10.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:25:49 -0700 (PDT)
Date: Wed, 17 Jul 2024 13:25:38 -0400
From: Kamal Heib <kheib@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next] i40e: Add support for fw health report
Message-ID: <Zpf-kvdAh1HRIchW@fedora-x1>
References: <20240715191148.746362-1-kheib@redhat.com>
 <ZpZ3JrM9Gu3R358u@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpZ3JrM9Gu3R358u@nanopsycho.orion>

On Tue, Jul 16, 2024 at 03:35:34PM +0200, Jiri Pirko wrote:
> Mon, Jul 15, 2024 at 09:11:48PM CEST, kheib@redhat.com wrote:
> >Add support for reporting fw status via the devlink health report.
> >
> >Example:
> > # devlink health show pci/0000:02:00.0 reporter fw
> > pci/0000:02:00.0:
> >   reporter fw
> >     state healthy error 0 recover 0
> > # devlink health diagnose pci/0000:02:00.0 reporter fw
> > Status: normal
> >
> >Signed-off-by: Kamal Heib <kheib@redhat.com>
> >---
> > drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
> > .../net/ethernet/intel/i40e/i40e_devlink.c    | 57 +++++++++++++++++++
> > .../net/ethernet/intel/i40e/i40e_devlink.h    |  2 +
> > drivers/net/ethernet/intel/i40e/i40e_main.c   | 15 +++++
> > 4 files changed, 75 insertions(+)
> >
> >diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> >index d546567e0286..f94671b6e7c6 100644
> >--- a/drivers/net/ethernet/intel/i40e/i40e.h
> >+++ b/drivers/net/ethernet/intel/i40e/i40e.h
> >@@ -465,6 +465,7 @@ static inline const u8 *i40e_channel_mac(struct i40e_channel *ch)
> > struct i40e_pf {
> > 	struct pci_dev *pdev;
> > 	struct devlink_port devlink_port;
> >+	struct devlink_health_reporter *fw_health_report;
> > 	struct i40e_hw hw;
> > 	DECLARE_BITMAP(state, __I40E_STATE_SIZE__);
> > 	struct msix_entry *msix_entries;
> >diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> >index cc4e9e2addb7..ad91c150cdba 100644
> >--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> >+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> >@@ -122,6 +122,25 @@ static int i40e_devlink_info_get(struct devlink *dl,
> > 	return err;
> > }
> > 
> >+static int i40e_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
> >+				     struct devlink_fmsg *fmsg,
> >+				     struct netlink_ext_ack *extack)
> >+{
> >+	struct i40e_pf *pf = devlink_health_reporter_priv(reporter);
> >+
> >+	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
> >+		devlink_fmsg_string_pair_put(fmsg, "Status", "recovery");
> 
> Is it "Status" or "Mode" ?
>

Thank you for your review.

It is "Mode", I'll fix it in v2.
> 
> >+	else
> >+		devlink_fmsg_string_pair_put(fmsg, "Status", "normal");
> >+
> >+	return 0;
> >+}
> >+
> >+static const struct devlink_health_reporter_ops i40e_fw_reporter_ops = {
> >+	.name = "fw",
> >+	.diagnose = i40e_fw_reporter_diagnose,
> >+};
> >+
> > static const struct devlink_ops i40e_devlink_ops = {
> > 	.info_get = i40e_devlink_info_get,
> > };
> >@@ -233,3 +252,41 @@ void i40e_devlink_destroy_port(struct i40e_pf *pf)
> > {
> > 	devlink_port_unregister(&pf->devlink_port);
> > }
> >+
> >+/**
> >+ * i40e_devlink_create_health_reporter - Create the health reporter for this PF
> >+ * @pf: the PF to create reporter for
> >+ *
> >+ * Create health reporter for this PF.
> >+ *
> >+ * Return: zero on success or an error code on failure.
> >+ **/
> >+int i40e_devlink_create_health_reporter(struct i40e_pf *pf)
> >+{
> >+	struct devlink *devlink = priv_to_devlink(pf);
> >+	struct device *dev = &pf->pdev->dev;
> >+	int rc = 0;
> >+
> >+	devl_lock(devlink);
> >+	pf->fw_health_report =
> >+		devl_health_reporter_create(devlink, &i40e_fw_reporter_ops, 0, pf);
> >+	if (IS_ERR(pf->fw_health_report)) {
> >+		rc = PTR_ERR(pf->fw_health_report);
> >+		dev_err(dev, "Failed to create fw reporter, err = %d\n", rc);
> >+	}
> >+	devl_unlock(devlink);
> >+
> >+	return rc;
> >+}
> >+
> >+/**
> >+ * i40e_devlink_destroy_health_reporter - Destroy the health reporter
> >+ * @pf: the PF to cleanup
> >+ *
> >+ * Destroy the health reporter
> >+ **/
> >+void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf)
> >+{
> >+	if (!IS_ERR_OR_NULL(pf->fw_health_report))
> >+		devlink_health_reporter_destroy(pf->fw_health_report);
> >+}
> >diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.h b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
> >index 469fb3d2ee25..018679094bb5 100644
> >--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.h
> >+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
> >@@ -14,5 +14,7 @@ void i40e_devlink_register(struct i40e_pf *pf);
> > void i40e_devlink_unregister(struct i40e_pf *pf);
> > int i40e_devlink_create_port(struct i40e_pf *pf);
> > void i40e_devlink_destroy_port(struct i40e_pf *pf);
> >+int i40e_devlink_create_health_reporter(struct i40e_pf *pf);
> >+void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf);
> > 
> > #endif /* _I40E_DEVLINK_H_ */
> >diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> >index cbcfada7b357..13cad5f58029 100644
> >--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> >+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> >@@ -15370,6 +15370,9 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
> > 		dev_crit(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
> > 		dev_crit(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
> > 		set_bit(__I40E_RECOVERY_MODE, pf->state);
> >+		if (pf->fw_health_report)
> >+			devlink_health_report(pf->fw_health_report,
> >+					      "FW recovery mode detected", pf);
> 
> You report it on "FW" reporter. Why "FW" is needed in the message?
>

You are right, I will remove it in v2.
 
> 
> > 
> > 		return true;
> > 	}
> >@@ -15636,6 +15639,14 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> > 		err = -ENOMEM;
> > 		goto err_pf_alloc;
> > 	}
> >+
> >+	err = i40e_devlink_create_health_reporter(pf);
> >+	if (err) {
> >+		dev_err(&pdev->dev,
> >+			"Failed to create health reporter %d\n", err);
> >+		goto err_health_reporter;
> >+	}
> >+
> > 	pf->next_vsi = 0;
> > 	pf->pdev = pdev;
> > 	set_bit(__I40E_DOWN, pf->state);
> >@@ -16180,6 +16191,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> > err_pf_reset:
> > 	iounmap(hw->hw_addr);
> > err_ioremap:
> >+	i40e_devlink_destroy_health_reporter(pf);
> >+err_health_reporter:
> > 	i40e_free_pf(pf);
> > err_pf_alloc:
> > 	pci_release_mem_regions(pdev);
> >@@ -16209,6 +16222,8 @@ static void i40e_remove(struct pci_dev *pdev)
> > 
> > 	i40e_devlink_unregister(pf);
> > 
> >+	i40e_devlink_destroy_health_reporter(pf);
> >+
> > 	i40e_dbg_pf_exit(pf);
> > 
> > 	i40e_ptp_stop(pf);
> >-- 
> >2.45.2
> >
> >
> 


