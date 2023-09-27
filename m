Return-Path: <netdev+bounces-36553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209127B05DB
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BB00E280DD5
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7D31A66;
	Wed, 27 Sep 2023 13:55:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD731C681
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 13:55:37 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D511D;
	Wed, 27 Sep 2023 06:55:35 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fca042ec0so216289539f.3;
        Wed, 27 Sep 2023 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695822935; x=1696427735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CH/Eo1sgizTrV730//5FZOJoFdy/XL4xbWf+vIO6S60=;
        b=gRKzsKUfzY/y5nMVq6RL8/Wj+Vvnob3VRriFjdwPUANzuq+rGad4+y1q6dkuIdNPDu
         aGpOQ1xvJFmlw9d8THeT4e2/Hm6kKoIGXIQ/taYHGOkjMNL871eTb8bPLMrgIQ+pn35f
         9k/4lSb8Rk67+kyRSusF6INpcRg/Bx8CmiRN9w5BDJDNWtxjrYFNSEWb4pmLP5tNyJjR
         tRNx3JQlp4TWhDlGmcAkHMAz5oeRMywpc8z0YU7519Yr6ciN/KlFDZ31ENRTFde1eJjy
         stfEMFumExX22XeVmecs/BYft95Vlru0w/0rvYrtVOKCfFV044WfGPHMqXE/4GqaIp9Y
         7Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695822935; x=1696427735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH/Eo1sgizTrV730//5FZOJoFdy/XL4xbWf+vIO6S60=;
        b=kodzISLrdJFUNtPdl489SUVfM/CGg26yg+GO33X85l3rVijJRL46qZrifoRc6KQOJs
         f0rylUsMojm4xk/HJrePKaWbHu7hrHIH6Izv35SG+n6ofpf6q2lCJlyVAJJP3HQ9tZoq
         4kifa434vHC2IPpGDTFM+dgFapTHRNOaTE/Ux5OutzySp57D09JfiLtPs9jNLFgNYZUe
         R1WKLyJ5fGzF1J6qFZN4+IYpXWaDqV4cSUkxGdEh2fFJ7bVOXcDp4FgzGQEK3PCpzUBo
         tG8CHTEebfNet3WiBPX7vtabOfpu/kFz9CnkgOoW4g7jxqRbMql46oHikCd1riDEXTu6
         9PWg==
X-Gm-Message-State: AOJu0YxctHP82qdAPIBVg7Z8zN+NzIYAGzQ05k51McOEo+AsJgf77Lx7
	CzOuFivarbqpKt7z5lKCBs0c/LyuCV4=
X-Google-Smtp-Source: AGHT+IErMc9W3WyRXfawq6WyLmU7hTIXrLHKzURkt3YIiUE1SBnFj+Nyew6FNlW193QroGfaQDQixA==
X-Received: by 2002:a6b:fd05:0:b0:79f:ce11:c1b0 with SMTP id c5-20020a6bfd05000000b0079fce11c1b0mr2311233ioi.6.1695822934893;
        Wed, 27 Sep 2023 06:55:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a02cac4000000b00439f4bf154csm4009933jap.46.2023.09.27.06.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:55:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Sep 2023 06:55:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/9] bnxt_en: Move hwmon functions into a
 dedicated file
Message-ID: <73c7e8c3-82fe-4530-b11f-7fa9a4a2b644@roeck-us.net>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
 <20230927035734.42816-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927035734.42816-4-michael.chan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 08:57:28PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> This is in preparation for upcoming patches in the series.
> Driver has to expose more threshold temperatures through the
> hwmon sysfs interface. More code will be added and do not
> want to overload bnxt.c.
> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/net/ethernet/broadcom/bnxt/Makefile   |  1 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 76 +----------------
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.c   | 82 +++++++++++++++++++
>  .../net/ethernet/broadcom/bnxt/bnxt_hwmon.h   | 25 ++++++
>  4 files changed, 109 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
>  create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
> index 2bc2b707d6ee..ba6c239d52fa 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/Makefile
> +++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_BNXT) += bnxt_en.o
>  bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o
>  bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
>  bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
> +bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 785084147994..b83f8de0a015 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -52,8 +52,6 @@
>  #include <linux/cpu_rmap.h>
>  #include <linux/cpumask.h>
>  #include <net/pkt_cls.h>
> -#include <linux/hwmon.h>
> -#include <linux/hwmon-sysfs.h>
>  #include <net/page_pool/helpers.h>
>  #include <linux/align.h>
>  #include <net/netdev_queues.h>
> @@ -71,6 +69,7 @@
>  #include "bnxt_tc.h"
>  #include "bnxt_devlink.h"
>  #include "bnxt_debugfs.h"
> +#include "bnxt_hwmon.h"
>  
>  #define BNXT_TX_TIMEOUT		(5 * HZ)
>  #define BNXT_DEF_MSG_ENABLE	(NETIF_MSG_DRV | NETIF_MSG_HW | \
> @@ -10250,79 +10249,6 @@ static void bnxt_get_wol_settings(struct bnxt *bp)
>  	} while (handle && handle != 0xffff);
>  }
>  
> -#ifdef CONFIG_BNXT_HWMON
> -static ssize_t bnxt_show_temp(struct device *dev,
> -			      struct device_attribute *devattr, char *buf)
> -{
> -	struct hwrm_temp_monitor_query_output *resp;
> -	struct hwrm_temp_monitor_query_input *req;
> -	struct bnxt *bp = dev_get_drvdata(dev);
> -	u32 len = 0;
> -	int rc;
> -
> -	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
> -	if (rc)
> -		return rc;
> -	resp = hwrm_req_hold(bp, req);
> -	rc = hwrm_req_send(bp, req);
> -	if (!rc)
> -		len = sprintf(buf, "%u\n", resp->temp * 1000); /* display millidegree */
> -	hwrm_req_drop(bp, req);
> -	if (rc)
> -		return rc;
> -	return len;
> -}
> -static SENSOR_DEVICE_ATTR(temp1_input, 0444, bnxt_show_temp, NULL, 0);
> -
> -static struct attribute *bnxt_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	NULL
> -};
> -ATTRIBUTE_GROUPS(bnxt);
> -
> -static void bnxt_hwmon_uninit(struct bnxt *bp)
> -{
> -	if (bp->hwmon_dev) {
> -		hwmon_device_unregister(bp->hwmon_dev);
> -		bp->hwmon_dev = NULL;
> -	}
> -}
> -
> -static void bnxt_hwmon_init(struct bnxt *bp)
> -{
> -	struct hwrm_temp_monitor_query_input *req;
> -	struct pci_dev *pdev = bp->pdev;
> -	int rc;
> -
> -	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
> -	if (!rc)
> -		rc = hwrm_req_send_silent(bp, req);
> -	if (rc == -EACCES || rc == -EOPNOTSUPP) {
> -		bnxt_hwmon_uninit(bp);
> -		return;
> -	}
> -
> -	if (bp->hwmon_dev)
> -		return;
> -
> -	bp->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
> -							  DRV_MODULE_NAME, bp,
> -							  bnxt_groups);
> -	if (IS_ERR(bp->hwmon_dev)) {
> -		bp->hwmon_dev = NULL;
> -		dev_warn(&pdev->dev, "Cannot register hwmon device\n");
> -	}
> -}
> -#else
> -static void bnxt_hwmon_uninit(struct bnxt *bp)
> -{
> -}
> -
> -static void bnxt_hwmon_init(struct bnxt *bp)
> -{
> -}
> -#endif
> -
>  static bool bnxt_eee_config_ok(struct bnxt *bp)
>  {
>  	struct ethtool_eee *eee = &bp->eee;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> new file mode 100644
> index 000000000000..476616d97071
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.c
> @@ -0,0 +1,82 @@
> +/* Broadcom NetXtreme-C/E network driver.
> + *
> + * Copyright (c) 2023 Broadcom Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/pci.h>
> +
> +#include "bnxt_hsi.h"
> +#include "bnxt.h"
> +#include "bnxt_hwrm.h"
> +#include "bnxt_hwmon.h"
> +
> +static ssize_t bnxt_show_temp(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	struct hwrm_temp_monitor_query_output *resp;
> +	struct hwrm_temp_monitor_query_input *req;
> +	struct bnxt *bp = dev_get_drvdata(dev);
> +	u32 len = 0;
> +	int rc;
> +
> +	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
> +	if (rc)
> +		return rc;
> +	resp = hwrm_req_hold(bp, req);
> +	rc = hwrm_req_send(bp, req);
> +	if (!rc)
> +		len = sprintf(buf, "%u\n", resp->temp * 1000); /* display millidegree */
> +	hwrm_req_drop(bp, req);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, bnxt_show_temp, NULL, 0);
> +
> +static struct attribute *bnxt_attrs[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(bnxt);
> +
> +void bnxt_hwmon_uninit(struct bnxt *bp)
> +{
> +	if (bp->hwmon_dev) {
> +		hwmon_device_unregister(bp->hwmon_dev);
> +		bp->hwmon_dev = NULL;
> +	}
> +}
> +
> +void bnxt_hwmon_init(struct bnxt *bp)
> +{
> +	struct hwrm_temp_monitor_query_input *req;
> +	struct pci_dev *pdev = bp->pdev;
> +	int rc;
> +
> +	rc = hwrm_req_init(bp, req, HWRM_TEMP_MONITOR_QUERY);
> +	if (!rc)
> +		rc = hwrm_req_send_silent(bp, req);
> +	if (rc == -EACCES || rc == -EOPNOTSUPP) {
> +		bnxt_hwmon_uninit(bp);
> +		return;
> +	}
> +
> +	if (bp->hwmon_dev)
> +		return;
> +
> +	bp->hwmon_dev = hwmon_device_register_with_groups(&pdev->dev,
> +							  DRV_MODULE_NAME, bp,
> +							  bnxt_groups);
> +	if (IS_ERR(bp->hwmon_dev)) {
> +		bp->hwmon_dev = NULL;
> +		dev_warn(&pdev->dev, "Cannot register hwmon device\n");
> +	}
> +}
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> new file mode 100644
> index 000000000000..af310066687c
> --- /dev/null
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwmon.h
> @@ -0,0 +1,25 @@
> +/* Broadcom NetXtreme-C/E network driver.
> + *
> + * Copyright (c) 2023 Broadcom Limited
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef BNXT_HWMON_H
> +#define BNXT_HWMON_H
> +
> +#ifdef CONFIG_BNXT_HWMON
> +void bnxt_hwmon_uninit(struct bnxt *bp);
> +void bnxt_hwmon_init(struct bnxt *bp);
> +#else
> +static inline void bnxt_hwmon_uninit(struct bnxt *bp)
> +{
> +}
> +
> +static inline void bnxt_hwmon_init(struct bnxt *bp)
> +{
> +}
> +#endif
> +#endif
> -- 
> 2.30.1
> 



