Return-Path: <netdev+bounces-112129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A393524A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6111F217A4
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8672144D28;
	Thu, 18 Jul 2024 19:58:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE743172
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332719; cv=none; b=jvEoVv0mnwC/tWWriTNMzJEfbDr/sLWGfcKInhQ/CbEjQ2SDnXXgy0xjz50dU/EZNilDy4oLmwYazptdpENyleODhDJ//6NhTRjVID7ILxXEKPN4/j1qYFF4gQzOO/KOnvbMCQfaHrq0M/QKXsE2Q5Cp4yJsM57Fq7mPupggB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332719; c=relaxed/simple;
	bh=uJN5VKG/3El0xeF3kZknK7Wfi/ntTPGeaNaA/KBCOGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO9avlBlzilm6RpGA3PiqzZHGJOGmbr3c5Js6mbbBw5duoW+NUi3hsezWbLZBN6mVHhC7UrQevo0PnmgmsBvN0q7xLXXJ9DQNv1UPomxZfuV9eQrH9tMXK84YjOdq+zZz8FKjtc6anG0ev2wsrtOJX0U4Lmx1DDWtAhPk+HCa8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af546.dynamic.kabel-deutschland.de [95.90.245.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A313961E5FE01;
	Thu, 18 Jul 2024 21:57:44 +0200 (CEST)
Message-ID: <09299d30-50d6-4132-871b-2ed4b3fe5c68@molgen.mpg.de>
Date: Thu, 18 Jul 2024 21:57:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] i40e: Add support for fw
 health report
To: Kamal Heib <kheib@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, Ivan Vecera <ivecera@redhat.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S . Miller" <davem@davemloft.net>
References: <20240718181319.145884-1-kheib@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240718181319.145884-1-kheib@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kamal,


Thank you for your patch.

Am 18.07.24 um 20:13 schrieb Kamal Heib:
> Add support for reporting fw status via the devlink health report.

I do not know the interface. So, the driver already has some way to 
communicate with the firmware, and you only need to hook it up to devlink?

> Example:
>   # devlink health show pci/0000:02:00.0 reporter fw
>   pci/0000:02:00.0:
>     reporter fw
>       state healthy error 0 recover 0
>   # devlink health diagnose pci/0000:02:00.0 reporter fw
>   Mode: normal

Any way to force it into recovery mode to also check it?

> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
> v2:
> - Address comments from Jiri.
> - Move the creation of the health report.
> ---
>   drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>   .../net/ethernet/intel/i40e/i40e_devlink.c    | 57 +++++++++++++++++++
>   .../net/ethernet/intel/i40e/i40e_devlink.h    |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 14 +++++
>   4 files changed, 74 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index d546567e0286..f94671b6e7c6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -465,6 +465,7 @@ static inline const u8 *i40e_channel_mac(struct i40e_channel *ch)
>   struct i40e_pf {
>   	struct pci_dev *pdev;
>   	struct devlink_port devlink_port;
> +	struct devlink_health_reporter *fw_health_report;
>   	struct i40e_hw hw;
>   	DECLARE_BITMAP(state, __I40E_STATE_SIZE__);
>   	struct msix_entry *msix_entries;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index cc4e9e2addb7..8fe64284e8d3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> @@ -122,6 +122,25 @@ static int i40e_devlink_info_get(struct devlink *dl,
>   	return err;
>   }
>   
> +static int i40e_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
> +				     struct devlink_fmsg *fmsg,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct i40e_pf *pf = devlink_health_reporter_priv(reporter);
> +
> +	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
> +		devlink_fmsg_string_pair_put(fmsg, "Mode", "recovery");
> +	else
> +		devlink_fmsg_string_pair_put(fmsg, "Mode", "normal");

I’d use ternary operator.

> +
> +	return 0;
> +}
> +
> +static const struct devlink_health_reporter_ops i40e_fw_reporter_ops = {
> +	.name = "fw",
> +	.diagnose = i40e_fw_reporter_diagnose,
> +};
> +
>   static const struct devlink_ops i40e_devlink_ops = {
>   	.info_get = i40e_devlink_info_get,
>   };
> @@ -233,3 +252,41 @@ void i40e_devlink_destroy_port(struct i40e_pf *pf)
>   {
>   	devlink_port_unregister(&pf->devlink_port);
>   }
> +
> +/**
> + * i40e_devlink_create_health_reporter - Create the health reporter for this PF
> + * @pf: the PF to create reporter for
> + *
> + * Create health reporter for this PF.
> + *
> + * Return: zero on success or an error code on failure.

No dot/period at the end.

> + **/
> +int i40e_devlink_create_health_reporter(struct i40e_pf *pf)
> +{
> +	struct devlink *devlink = priv_to_devlink(pf);
> +	struct device *dev = &pf->pdev->dev;
> +	int rc = 0;
> +
> +	devl_lock(devlink);
> +	pf->fw_health_report =
> +		devl_health_reporter_create(devlink, &i40e_fw_reporter_ops, 0, pf);
> +	if (IS_ERR(pf->fw_health_report)) {
> +		rc = PTR_ERR(pf->fw_health_report);
> +		dev_err(dev, "Failed to create fw reporter, err = %d\n", rc);
> +	}
> +	devl_unlock(devlink);
> +
> +	return rc;
> +}
> +
> +/**
> + * i40e_devlink_destroy_health_reporter - Destroy the health reporter
> + * @pf: the PF to cleanup

The verb is spelled with a space: clean up.

> + *
> + * Destroy the health reporter
> + **/
> +void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf)
> +{
> +	if (!IS_ERR_OR_NULL(pf->fw_health_report))
> +		devlink_health_reporter_destroy(pf->fw_health_report);
> +}
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.h b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
> index 469fb3d2ee25..018679094bb5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
> @@ -14,5 +14,7 @@ void i40e_devlink_register(struct i40e_pf *pf);
>   void i40e_devlink_unregister(struct i40e_pf *pf);
>   int i40e_devlink_create_port(struct i40e_pf *pf);
>   void i40e_devlink_destroy_port(struct i40e_pf *pf);
> +int i40e_devlink_create_health_reporter(struct i40e_pf *pf);
> +void i40e_devlink_destroy_health_reporter(struct i40e_pf *pf);
>   
>   #endif /* _I40E_DEVLINK_H_ */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index cbcfada7b357..b6b3ae299b28 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -15370,6 +15370,9 @@ static bool i40e_check_recovery_mode(struct i40e_pf *pf)
>   		dev_crit(&pf->pdev->dev, "Firmware recovery mode detected. Limiting functionality.\n");
>   		dev_crit(&pf->pdev->dev, "Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
>   		set_bit(__I40E_RECOVERY_MODE, pf->state);
> +		if (pf->fw_health_report)
> +			devlink_health_report(pf->fw_health_report,
> +					      "recovery mode detected", pf);
>   
>   		return true;
>   	}
> @@ -15810,6 +15813,13 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (test_bit(__I40E_RECOVERY_MODE, pf->state))
>   		return i40e_init_recovery_mode(pf, hw);
>   
> +	err = i40e_devlink_create_health_reporter(pf);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"Failed to create health reporter %d\n", err);
> +		goto err_health_reporter;
> +	}
> +
>   	err = i40e_init_lan_hmc(hw, hw->func_caps.num_tx_qp,
>   				hw->func_caps.num_rx_qp, 0, 0);
>   	if (err) {
> @@ -16175,6 +16185,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	(void)i40e_shutdown_lan_hmc(hw);
>   err_init_lan_hmc:
>   	kfree(pf->qp_pile);
> +	i40e_devlink_destroy_health_reporter(pf);
> +err_health_reporter:
>   err_sw_init:
>   err_adminq_setup:
>   err_pf_reset:
> @@ -16209,6 +16221,8 @@ static void i40e_remove(struct pci_dev *pdev)
>   
>   	i40e_devlink_unregister(pf);
>   
> +	i40e_devlink_destroy_health_reporter(pf);
> +
>   	i40e_dbg_pf_exit(pf);
>   
>   	i40e_ptp_stop(pf);


Kind regards,

Paul

