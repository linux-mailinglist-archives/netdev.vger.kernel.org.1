Return-Path: <netdev+bounces-111761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DF932794
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5728D1C214D6
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65459199EA8;
	Tue, 16 Jul 2024 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qMZy4Xgf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78714386C
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136942; cv=none; b=hDDvsgLtr6D3Osn5ovnaOc8Kq/bQnk1HuIh9CMbJxSHgD8Wb2+ELcxA/lDs8HroHLp/TwakdC/Sr4mfvkD6TmE80yAfmefF0B0w2eU+U9p7LpPMaXwgkwfYXu5pvKn6Dpq7N7HPYGZNUUaoA7o2XV3DX8eEt5N0mJYW6G04ekUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136942; c=relaxed/simple;
	bh=SHA6XzNBDtNCpeLH5H6tMZTlZbqVJSkKI7SmUrMJCQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8vrTgmros5LC8N6zkiISGro4ZyEFFar5+V+uE0kJxuRtogujMUha/C3Ec3/MJE5LDZEvGQamhC1KHScD7/UHyQu4kQ/ga/tuxd1VI0ibAHR+bd10jNFP/CVUKi13jfekOnPrbMdiy3crnX+v40CP4e5iXNP7haN7PZNJugNMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qMZy4Xgf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso595539766b.0
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721136939; x=1721741739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFjg4n1wzh4t973XA1/AdkYSFNq35oOYhW36cZtWCFg=;
        b=qMZy4XgftTzrGgd7ZZFXF3WCb3GyLkTTTfDQHger6Xz47ZdjOt3Se9Alt+xHCwNsG+
         lkgfvWeI/fz+MddckgroV+d1Bzs+Aq3foYO4zz8+PWHTsVd4j/B+maUN7EhLNW0yLLwg
         cklyCqbV9S8LG2OJLYLRg7eD6ILx5lJOAcHuKkiN7Ljg0Ep1b/dd8NzecUJx+ATvBxSQ
         xuMQqfOVQAob7zP77jeDsdxcUmXlxtUhoMkAY6KHQD88MCY7sjTCGcSy/UK6JxLZ35ny
         NNGtxMgRST0fpMzblpOixZe54Vhtj0do1msqzAMx9bYGxmrzCgUOW+SQX/zp2sj3DiOo
         Swcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136939; x=1721741739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFjg4n1wzh4t973XA1/AdkYSFNq35oOYhW36cZtWCFg=;
        b=jLEOI9zatIJ4cw/+1jajvdrLWafr4Z+Ic0XsEz6/IYBRaNdXOgVA4LDwI/P4BMXdHj
         pLSj/CtsrFDR/oOPBEHVFPpkcgYt0Hr9OXI3ukzQPZGTcgFYk8rUNT4z1Os9G7majQfZ
         QaKEBaN+WyhupxAMRq98bUuYP7JD3J2RuEOE0eYJTyZp5lGZ+ijlPcv6G0xKkq+x0Uqr
         OziTDw114fbS5GiJBh0RWHaYt46vRYEXnGy3PhP1nvDgIOwlzyuxNC4yMhwzSn8bJxp2
         HyPXKNHhJdJGbp6s/+OGUqD7aJkvTD491n3SbpYLV2UG2ruACCV78G4pGpneeBZx+zlX
         n6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa4FZXek27Qzx6J0/rCQpednxXGMDABksiaPnP8nujkHm1HIqJo60/xhXGLMbivT+fkxkbniBbSXHXAgCRw5tDW96U467+
X-Gm-Message-State: AOJu0YxC2kNlYJcjpMmXBKRngczLFt3/SQ2eepe1WBz6bzJitZaYo2F4
	2sbgbd133asjmitNd6JPV+lf55maRyWqZSNt9n3UQMoEhbDUUk/w9NI6NzyGuFg=
X-Google-Smtp-Source: AGHT+IEPGWldCOq3DrqOqQ6u4hGsqzCinS8QCDTE+FoqyPZtQ/xFkFMEKGsB3mC54pYBTlbhKbojvA==
X-Received: by 2002:a17:906:855:b0:a77:cdaa:88a7 with SMTP id a640c23a62f3a-a79eaa332cdmr159358366b.48.1721136938680;
        Tue, 16 Jul 2024 06:35:38 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ffffbsm323050066b.173.2024.07.16.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 06:35:38 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:35:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Kamal Heib <kheib@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next] i40e: Add support for fw health report
Message-ID: <ZpZ3JrM9Gu3R358u@nanopsycho.orion>
References: <20240715191148.746362-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715191148.746362-1-kheib@redhat.com>

Mon, Jul 15, 2024 at 09:11:48PM CEST, kheib@redhat.com wrote:
>Add support for reporting fw status via the devlink health report.
>
>Example:
> # devlink health show pci/0000:02:00.0 reporter fw
> pci/0000:02:00.0:
>   reporter fw
>     state healthy error 0 recover 0
> # devlink health diagnose pci/0000:02:00.0 reporter fw
> Status: normal
>
>Signed-off-by: Kamal Heib <kheib@redhat.com>
>---
> drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
> .../net/ethernet/intel/i40e/i40e_devlink.c    | 57 +++++++++++++++++++
> .../net/ethernet/intel/i40e/i40e_devlink.h    |  2 +
> drivers/net/ethernet/intel/i40e/i40e_main.c   | 15 +++++
> 4 files changed, 75 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>index d546567e0286..f94671b6e7c6 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e.h
>+++ b/drivers/net/ethernet/intel/i40e/i40e.h
>@@ -465,6 +465,7 @@ static inline const u8 *i40e_channel_mac(struct i40e_channel *ch)
> struct i40e_pf {
> 	struct pci_dev *pdev;
> 	struct devlink_port devlink_port;
>+	struct devlink_health_reporter *fw_health_report;
> 	struct i40e_hw hw;
> 	DECLARE_BITMAP(state, __I40E_STATE_SIZE__);
> 	struct msix_entry *msix_entries;
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>index cc4e9e2addb7..ad91c150cdba 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>@@ -122,6 +122,25 @@ static int i40e_devlink_info_get(struct devlink *dl,
> 	return err;
> }
> 
>+static int i40e_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
>+				     struct devlink_fmsg *fmsg,
>+				     struct netlink_ext_ack *extack)
>+{
>+	struct i40e_pf *pf = devlink_health_reporter_priv(reporter);
>+
>+	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "recovery");

Is it "Status" or "Mode" ?


>+	else
>+		devlink_fmsg_string_pair_put(fmsg, "Status", "normal");
>+
>+	return 0;
>+}
>+
>+static const struct devlink_health_reporter_ops i40e_fw_reporter_ops = {
>+	.name = "fw",
>+	.diagnose = i40e_fw_reporter_diagnose,
>+};
>+
> static const struct devlink_ops i40e_devlink_ops = {
> 	.info_get = i40e_devlink_info_get,
> };
>@@ -233,3 +252,41 @@ void i40e_devlink_destroy_port(struct i40e_pf *pf)
> {
> 	devlink_port_unregister(&pf->devlink_port);
> }
>+
>+/**
>+ * i40e_devlink_create_health_reporter - Create the health reporter for this PF
>+ * @pf: the PF to create reporter for
>+ *
>+ * Create health reporter for this PF.
>+ *
>+ * Return: zero on success or an error code on failure.
>+ **/
>+int i40e_devlink_create_health_reporter(struct i40e_pf *pf)
>+{
>+	struct devlink *devlink = priv_to_devlink(pf);
>+	struct device *dev = &pf->pdev->dev;
>+	int rc = 0;
>+
>+	devl_lock(devlink);
>+	pf->fw_health_report =
>+		devl_health_reporter_create(devlink, &i40e_fw_reporter_ops, 0, pf);
>+	if (IS_ERR(pf->fw_health_report)) {
>+		rc = PTR_ERR(pf->fw_health_report);
>+		dev_err(dev, "Failed to create fw reporter, err = %d\n", rc);
>+	}
>+	devl_unlock(devlink);
>+
>+	return rc;
>+}
>+
>+/**
>+ * i40e_devlink_destroy_health_reporter - Destroy the health reporter
>+ * @pf: the PF to cleanup
>+ *
>+ * Destroy the health reporter
>+ **/
>+void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf)
>+{
>+	if (!IS_ERR_OR_NULL(pf->fw_health_report))
>+		devlink_health_reporter_destroy(pf->fw_health_report);
>+}
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.h b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
>index 469fb3d2ee25..018679094bb5 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.h
>+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
>@@ -14,5 +14,7 @@ void i40e_devlink_register(struct i40e_pf *pf);
> void i40e_devlink_unregister(struct i40e_pf *pf);
> int i40e_devlink_create_port(struct i40e_pf *pf);
> void i40e_devlink_destroy_port(struct i40e_pf *pf);
>+int i40e_devlink_create_health_reporter(struct i40e_pf *pf);
>+void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf);
> 
> #endif /* _I40E_DEVLINK_H_ */
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>index cbcfada7b357..13cad5f58029 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>@@ -15370,6 +15370,9 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
> 		dev_crit(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
> 		dev_crit(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
> 		set_bit(__I40E_RECOVERY_MODE, pf->state);
>+		if (pf->fw_health_report)
>+			devlink_health_report(pf->fw_health_report,
>+					      "FW recovery mode detected", pf);

You report it on "FW" reporter. Why "FW" is needed in the message?


> 
> 		return true;
> 	}
>@@ -15636,6 +15639,14 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> 		err = -ENOMEM;
> 		goto err_pf_alloc;
> 	}
>+
>+	err = i40e_devlink_create_health_reporter(pf);
>+	if (err) {
>+		dev_err(&pdev->dev,
>+			"Failed to create health reporter %d\n", err);
>+		goto err_health_reporter;
>+	}
>+
> 	pf->next_vsi = 0;
> 	pf->pdev = pdev;
> 	set_bit(__I40E_DOWN, pf->state);
>@@ -16180,6 +16191,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> err_pf_reset:
> 	iounmap(hw->hw_addr);
> err_ioremap:
>+	i40e_devlink_destroy_health_reporter(pf);
>+err_health_reporter:
> 	i40e_free_pf(pf);
> err_pf_alloc:
> 	pci_release_mem_regions(pdev);
>@@ -16209,6 +16222,8 @@ static void i40e_remove(struct pci_dev *pdev)
> 
> 	i40e_devlink_unregister(pf);
> 
>+	i40e_devlink_destroy_health_reporter(pf);
>+
> 	i40e_dbg_pf_exit(pf);
> 
> 	i40e_ptp_stop(pf);
>-- 
>2.45.2
>
>

