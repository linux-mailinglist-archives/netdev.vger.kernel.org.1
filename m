Return-Path: <netdev+bounces-22055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB94765C7C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 21:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101891C216F2
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801C01C9E0;
	Thu, 27 Jul 2023 19:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692741805C
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 19:54:46 +0000 (UTC)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42E2D45;
	Thu, 27 Jul 2023 12:54:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-78bb3ff7cbcso52339539f.3;
        Thu, 27 Jul 2023 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690487682; x=1691092482;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA1Ej8D+EFTNWOOS9QHxr8OeI1Siz6rer2cWaFmQmi8=;
        b=frDaPNjrnSvVWelMYsZyaHJVQfzMEAWVn8UTeg4Ggt2n7qpatf/pwmmO8GlB1ig3tO
         FX3dCOSmi2wJHw1cOiVv35w+4YPdCVDwCO2rpdpmL9bi8JTyC1G7r105tscy0Ngt8lgr
         QcV/tY7EVD8rjX8aerfVhHJP6jSpZ9X/9pfFuPwAcLwTJM0Iv+f6Ab6n/qWP7Te4+fmA
         MliNe0MfMekHDEolDYtAtBfo91oJCPZ4ns+C2aLnZ1m4qmFlf1BsB8EMTmAcuulI5sNe
         JaCmr8teG2/T+dcugdeU03D21XX0PCvGUnG1IdLahGyDTSl5q/21U9+eEkgkqlzvVXnX
         qQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690487682; x=1691092482;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NA1Ej8D+EFTNWOOS9QHxr8OeI1Siz6rer2cWaFmQmi8=;
        b=bKiDix+FVlIudWCkCTzMnKRxBOGM87b3G9EhXs1KKNU8nXtYY1IyuymGsnLKM15hI0
         MF1XJsHGPcMEdXLS6W92u94hTFHL2aX6H3gxas/aCcfTK+jeAnUhbArzkwBXm6ryX64/
         Xfn1bsiagV+22DAYORrhJ7XWDEqv74KxuokW5ozhQZcCIYPrDAHfIUfWic6z7VOXpsWF
         kiucfmQuP3Ntp3u5f68CKwZvrYdO4n1ycSICiVoF2ZkJ9ysb1ALrgOi/6RLpZMpRC/QU
         /lFhi3ydL4e8sC1faJrJcPffbw09JMth4saVuMaib88X46wRr0cSttIttfTGVYIqFZVv
         Ew+w==
X-Gm-Message-State: ABy/qLZJLt84dRVQUPSWjAnG6s6VJEMw1r8fOiUrsd30/vAFvvvfMukr
	RnllL4s56GF5Fh/tPgLNc14=
X-Google-Smtp-Source: APBJJlFiY+sbNG8zvwYrhQbpbeu0AHtmI5kQVdoHF1KFwg08YAyaKhFAGQnFXL8UFCPj4xjs2YxffA==
X-Received: by 2002:a5d:8e19:0:b0:783:31bf:7d8b with SMTP id e25-20020a5d8e19000000b0078331bf7d8bmr562431iod.4.1690487682077;
        Thu, 27 Jul 2023 12:54:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d9391000000b00786ea00bdb5sm672540iol.2.2023.07.27.12.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 12:54:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9479d3cb-0e1c-a55a-ca07-97f4205c46c8@roeck-us.net>
Date: Thu, 27 Jul 2023 12:54:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Adham Faris <afaris@nvidia.com>,
 Gal Pressman <gal@nvidia.com>
References: <20230727185922.72131-1-saeed@kernel.org>
 <20230727185922.72131-3-saeed@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH net-next 2/2] net/mlx5: Expose NIC temperature via
 hardware monitoring kernel API
In-Reply-To: <20230727185922.72131-3-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/27/23 11:59, Saeed Mahameed wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> Expose NIC temperature by implementing hwmon kernel API, which turns
> current thermal zone kernel API to redundant.
> 
> For each one of the supported and exposed thermal diode sensors, expose
> the following attributes:
> 1) Input temperature.
> 2) Highest temperature.
> 3) Temperature label.
> 4) Temperature critical max value:
>     refers to the high threshold of Warning Event. Will be exposed as
>     `tempY_crit` hwmon attribute (RO attribute). For example for
>     ConnectX5 HCA's this temperature value will be 105 Celsius, 10
>     degrees lower than the HW shutdown temperature).
> 5) Temperature reset history: resets highest temperature.
> 
> For example, for dualport ConnectX5 NIC with a single IC thermal diode
> sensor will have 2 hwmon directories (one for each PCI function)
> under "/sys/class/hwmon/hwmon[X,Y]".
> 
> Listing one of the directories above (hwmonX/Y) generates the
> corresponding output below:
> 
> $ grep -H -d skip . /sys/class/hwmon/hwmon0/*
> 
> Output
> =======================================================================
> /sys/class/hwmon/hwmon0/name:0000:08:00.0

That name doesn't seem to be very useful. You might want to consider
using a different name, such as a simple "mlx5". Since the parent is
a pci device, the "sensors" command would translate that into something
like "mlx5-pci-XXXX" which would be much more useful than the
"0000:08:00.0-pci-0000" which is what you'll see with the current
name.

> /sys/class/hwmon/hwmon0/temp1_crit:105000
> /sys/class/hwmon/hwmon0/temp1_highest:68000
> /sys/class/hwmon/hwmon0/temp1_input:68000
> /sys/class/hwmon/hwmon0/temp1_label:sensor0

I don't really see the value of that label. A label provided by the driver
should be meaningful and indicate something such as the sensor location.
Otherwise the default of "temp1" seems to be just as useful to me.

> grep: /sys/class/hwmon/hwmon0/temp1_reset_history: Permission denied
> 
> Issue: 3451280
> Signed-off-by: Adham Faris <afaris@nvidia.com>
> Change-Id: Ic0d2c57c82f12e5d5886c8d86b4c91eec0a4057c
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
>   .../net/ethernet/mellanox/mlx5/core/hwmon.c   | 428 ++++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/hwmon.h   |  24 +
>   .../net/ethernet/mellanox/mlx5/core/main.c    |   8 +-
>   .../net/ethernet/mellanox/mlx5/core/thermal.c | 114 -----
>   .../net/ethernet/mellanox/mlx5/core/thermal.h |  20 -
>   include/linux/mlx5/driver.h                   |   3 +-
>   include/linux/mlx5/mlx5_ifc.h                 |  14 +-
>   8 files changed, 472 insertions(+), 141 deletions(-)
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
>   delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.c
>   delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/thermal.h
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index 35f00700a4d6..fddb88c000ec 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -78,7 +78,7 @@ mlx5_core-$(CONFIG_MLX5_ESWITCH)   += esw/acl/helper.o \
>   mlx5_core-$(CONFIG_MLX5_BRIDGE)    += esw/bridge.o esw/bridge_mcast.o esw/bridge_debugfs.o \
>   				      en/rep/bridge.o
>   
> -mlx5_core-$(CONFIG_THERMAL)        += thermal.o
> +mlx5_core-$(CONFIG_HWMON)          += hwmon.o
>   mlx5_core-$(CONFIG_MLX5_MPFS)      += lib/mpfs.o
>   mlx5_core-$(CONFIG_VXLAN)          += lib/vxlan.o
>   mlx5_core-$(CONFIG_PTP_1588_CLOCK) += lib/clock.o
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
> new file mode 100644
> index 000000000000..7f27bb62a1d5
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
> @@ -0,0 +1,428 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> +
> +#include <linux/hwmon.h>
> +#include <linux/bitmap.h>
> +#include <linux/mlx5/device.h>
> +#include <linux/mlx5/mlx5_ifc.h>
> +#include <linux/mlx5/port.h>
> +#include "mlx5_core.h"
> +#include "hwmon.h"
> +
> +#define CHANNELS_TYPE_NUM 2 /* chip channel and temp channel */
> +#define CHIP_CONFIG_NUM 1
> +
> +/* module 0 is mapped to sensor_index 64 in MTMP register */
> +#define to_mtmp_module_sensor_idx(idx) (64 + (idx))
> +
> +/* All temperatures retrieved in units of 0.125C. hwmon framework expect
> + * it in units of millidegrees C. Hence multiply values by 125.
> + */
> +#define mtmp_temp_to_mdeg(temp) ((temp) * 125)
> +
> +struct temp_channel_desc {
> +	u32 sensor_index;
> +	char sensor_name[32];
> +};
> +
> +/* chip_channel_config and channel_info arrays must be 0-terminated, hence + 1 */
> +struct mlx5_hwmon {
> +	struct mlx5_core_dev *mdev;
> +	struct device *hwmon_dev;
> +	struct hwmon_channel_info chip_info;
> +	u32 chip_channel_config[CHIP_CONFIG_NUM + 1];
> +	struct hwmon_channel_info temp_info;
> +	u32 *temp_channel_config;
> +	const struct hwmon_channel_info *channel_info[CHANNELS_TYPE_NUM + 1];
> +	struct hwmon_chip_info chip;
> +	const char *name;
> +	struct temp_channel_desc *temp_channel_desc;
> +	u32 asic_platform_scount;
> +	u32 module_scount;
> +};
> +
> +static int mlx5_hwmon_query_mtmp(struct mlx5_core_dev *mdev, u32 sensor_index, u32 *mtmp_out)
> +{
> +	u32 mtmp_in[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> +
> +	MLX5_SET(mtmp_reg, mtmp_in, sensor_index, sensor_index);
> +
> +	return mlx5_core_access_reg(mdev, mtmp_in,  sizeof(mtmp_in),
> +				    mtmp_out, MLX5_ST_SZ_BYTES(mtmp_reg),
> +				    MLX5_REG_MTMP, 0, 0);
> +}
> +
> +static int mlx5_hwmon_reset_max_temp(struct mlx5_core_dev *mdev, int sensor_index)
> +{
> +	u32 mtmp_out[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> +	u32 mtmp_in[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> +
> +	MLX5_SET(mtmp_reg, mtmp_in, sensor_index, sensor_index);
> +	MLX5_SET(mtmp_reg, mtmp_in, mtr, 1);
> +
> +	return mlx5_core_access_reg(mdev, mtmp_in,  sizeof(mtmp_in),
> +				    mtmp_out, sizeof(mtmp_out),
> +				    MLX5_REG_MTMP, 0, 0);
> +}
> +
> +static int mlx5_hwmon_enable_max_temp(struct mlx5_core_dev *mdev, int sensor_index)
> +{
> +	u32 mtmp_out[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> +	u32 mtmp_in[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> +	int err;
> +
> +	err = mlx5_hwmon_query_mtmp(mdev, sensor_index, mtmp_in);
> +	if (err)
> +		return err;
> +
> +	MLX5_SET(mtmp_reg, mtmp_in, mte, 1);
> +	return mlx5_core_access_reg(mdev, mtmp_in,  sizeof(mtmp_in),
> +				    mtmp_out, sizeof(mtmp_out),
> +				    MLX5_REG_MTMP, 0, 1);
> +}
> +
> +static int mlx5_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			   int channel, long *val)
> +{
> +	struct mlx5_hwmon *hwmon = dev_get_drvdata(dev);
> +	u32 mtmp_out[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> +	int err;
> +
> +	if (type != hwmon_temp)
> +		return -EOPNOTSUPP;
> +
> +	err = mlx5_hwmon_query_mtmp(hwmon->mdev, hwmon->temp_channel_desc[channel].sensor_index,
> +				    mtmp_out);
> +	if (err)
> +		return err;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		*val = mtmp_temp_to_mdeg(MLX5_GET(mtmp_reg, mtmp_out, temperature));
> +		return 0;
> +	case hwmon_temp_highest:
> +		*val = mtmp_temp_to_mdeg(MLX5_GET(mtmp_reg, mtmp_out, max_temperature));
> +		return 0;
> +	case hwmon_temp_crit:
> +		*val = mtmp_temp_to_mdeg(MLX5_GET(mtmp_reg, mtmp_out, temp_threshold_hi));
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int mlx5_hwmon_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			    int channel, long val)
> +{
> +	struct mlx5_hwmon *hwmon = dev_get_drvdata(dev);
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_reset_history)
> +		return -EOPNOTSUPP;
> +
> +	return mlx5_hwmon_reset_max_temp(hwmon->mdev,
> +				hwmon->temp_channel_desc[channel].sensor_index);
> +}
> +
> +static umode_t mlx5_hwmon_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
> +				     int channel)
> +{
> +	if (type != hwmon_temp)
> +		return 0;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_highest:
> +	case hwmon_temp_crit:
> +	case hwmon_temp_label:
> +		return 0444;
> +	case hwmon_temp_reset_history:
> +		return 0200;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int mlx5_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				  int channel, const char **str)
> +{
> +	struct mlx5_hwmon *hwmon = dev_get_drvdata(dev);
> +
> +	if (type != hwmon_temp || attr != hwmon_temp_label)
> +		return -EOPNOTSUPP;
> +
> +	*str = (const char *)hwmon->temp_channel_desc[channel].sensor_name;
> +	return 0;
> +}
> +
> +static const struct hwmon_ops mlx5_hwmon_ops = {
> +	.read = mlx5_hwmon_read,
> +	.read_string = mlx5_hwmon_read_string,
> +	.is_visible = mlx5_hwmon_is_visible,
> +	.write = mlx5_hwmon_write,
> +};
> +
> +static int mlx5_hwmon_init_channels_names(struct mlx5_hwmon *hwmon)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < hwmon->asic_platform_scount + hwmon->module_scount; i++) {
> +		u32 mtmp_out[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> +		char *sensor_name;
> +		int err;
> +
> +		err = mlx5_hwmon_query_mtmp(hwmon->mdev, hwmon->temp_channel_desc[i].sensor_index,
> +					    mtmp_out);
> +		if (err)
> +			return err;
> +
> +		sensor_name = MLX5_ADDR_OF(mtmp_reg, mtmp_out, sensor_name_hi);
> +		if (!*sensor_name) {
> +			snprintf(hwmon->temp_channel_desc[i].sensor_name,
> +				 sizeof(hwmon->temp_channel_desc[i].sensor_name), "sensor%u",
> +				 hwmon->temp_channel_desc[i].sensor_index);
> +			continue;
> +		}
> +
> +		memcpy(&hwmon->temp_channel_desc[i].sensor_name, sensor_name,
> +		       MLX5_FLD_SZ_BYTES(mtmp_reg, sensor_name_hi) +
> +		       MLX5_FLD_SZ_BYTES(mtmp_reg, sensor_name_lo));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mlx5_hwmon_get_module_sensor_index(struct mlx5_core_dev *mdev, u32 *module_index)
> +{
> +	int module_num;
> +	int err;
> +
> +	err = mlx5_query_module_num(mdev, &module_num);
> +	if (err)
> +		return err;
> +
> +	*module_index = to_mtmp_module_sensor_idx(module_num);
> +
> +	return 0;
> +}
> +
> +static int mlx5_hwmon_init_sensors_indexes(struct mlx5_hwmon *hwmon, u64 sensor_map)
> +{
> +	DECLARE_BITMAP(smap, BITS_PER_TYPE(sensor_map));
> +	unsigned long bit_pos;
> +	int err = 0;
> +	int i = 0;
> +
> +	bitmap_from_u64(smap, sensor_map);
> +
> +	for_each_set_bit(bit_pos, smap, BITS_PER_TYPE(sensor_map)) {
> +		hwmon->temp_channel_desc[i].sensor_index = bit_pos;
> +		i++;
> +	}
> +
> +	if (hwmon->module_scount)
> +		err = mlx5_hwmon_get_module_sensor_index(hwmon->mdev,
> +							 &hwmon->temp_channel_desc[i].sensor_index);
> +
> +	return err;
> +}
> +
> +static void mlx5_hwmon_channel_info_init(struct mlx5_hwmon *hwmon)
> +{
> +	int i;
> +
> +	hwmon->channel_info[0] = &hwmon->chip_info;
> +	hwmon->channel_info[1] = &hwmon->temp_info;
> +
> +	hwmon->chip_channel_config[0] = HWMON_C_REGISTER_TZ;
> +	hwmon->chip_info.config = (const u32 *)hwmon->chip_channel_config;
> +	hwmon->chip_info.type = hwmon_chip;
> +
> +	for (i = 0; i < hwmon->asic_platform_scount + hwmon->module_scount; i++)
> +		hwmon->temp_channel_config[i] = HWMON_T_INPUT | HWMON_T_HIGHEST | HWMON_T_CRIT |
> +					     HWMON_T_RESET_HISTORY | HWMON_T_LABEL;
> +
> +	hwmon->temp_info.config = (const u32 *)hwmon->temp_channel_config;
> +	hwmon->temp_info.type = hwmon_temp;
> +}
> +
> +static int mlx5_hwmon_is_module_mon_cap(struct mlx5_core_dev *mdev, bool *mon_cap)
> +{
> +	u32 mtmp_out[MLX5_ST_SZ_DW(mtmp_reg)];
> +	u32 module_index;
> +	int err;
> +
> +	err = mlx5_hwmon_get_module_sensor_index(mdev, &module_index);
> +	if (err)
> +		return err;
> +
> +	err = mlx5_hwmon_query_mtmp(mdev, module_index, mtmp_out);
> +	if (err)
> +		return err;
> +
> +	if (MLX5_GET(mtmp_reg, mtmp_out, temperature))
> +		*mon_cap = true;
> +
> +	return 0;
> +}
> +
> +static int mlx5_hwmon_get_sensors_count(struct mlx5_core_dev *mdev, u32 *asic_platform_scount)
> +{
> +	u32 mtcap_out[MLX5_ST_SZ_DW(mtcap_reg)] = {};
> +	u32 mtcap_in[MLX5_ST_SZ_DW(mtcap_reg)] = {};
> +	int err;
> +
> +	err = mlx5_core_access_reg(mdev, mtcap_in,  sizeof(mtcap_in),
> +				   mtcap_out, sizeof(mtcap_out),
> +				   MLX5_REG_MTCAP, 0, 0);
> +	if (err)
> +		return err;
> +
> +	*asic_platform_scount = MLX5_GET(mtcap_reg, mtcap_out, sensor_count);
> +
> +	return 0;
> +}
> +
> +static void mlx5_hwmon_free(struct mlx5_hwmon *hwmon)
> +{
> +	if (!hwmon)
> +		return;
> +
> +	kfree(hwmon->temp_channel_config);
> +	kfree(hwmon->temp_channel_desc);
> +	kfree(hwmon->name);
> +	kfree(hwmon);
> +}
> +
> +static struct mlx5_hwmon *mlx5_hwmon_alloc(struct mlx5_core_dev *mdev)
> +{
> +	struct mlx5_hwmon *hwmon;
> +	bool mon_cap = false;
> +	u32 sensors_count;
> +	int err;
> +
> +	hwmon = kzalloc(sizeof(*mdev->hwmon), GFP_KERNEL);
> +	if (!hwmon)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hwmon->name = hwmon_sanitize_name(pci_name(mdev->pdev));
> +	if (IS_ERR(hwmon->name)) {
> +		err = PTR_ERR(hwmon->name);
> +		goto err_free_hwmon;
> +	}
> +
> +	err = mlx5_hwmon_get_sensors_count(mdev, &hwmon->asic_platform_scount);
> +	if (err)
> +		goto err_free_name;
> +
> +	/* check if module sensor has thermal mon cap. if yes, allocate channel desc for it */
> +	err = mlx5_hwmon_is_module_mon_cap(mdev, &mon_cap);
> +	if (err)
> +		goto err_free_name;
> +
> +	hwmon->module_scount = mon_cap ? 1 : 0;
> +	sensors_count = hwmon->asic_platform_scount + hwmon->module_scount;
> +	hwmon->temp_channel_desc = kcalloc(sensors_count, sizeof(*hwmon->temp_channel_desc),
> +					   GFP_KERNEL);
> +	if (!hwmon->temp_channel_desc) {
> +		err = -ENOMEM;
> +		goto err_free_name;
> +	}
> +
> +	/* sensors configuration values array, must be 0-terminated hence, + 1 */
> +	hwmon->temp_channel_config = kcalloc(sensors_count + 1, sizeof(*hwmon->temp_channel_config),
> +					     GFP_KERNEL);
> +	if (!hwmon->temp_channel_config) {
> +		err = -ENOMEM;
> +		goto err_free_temp_channel_desc;
> +	}
> +
> +	hwmon->mdev = mdev;
> +
> +	return hwmon;
> +
> +err_free_temp_channel_desc:
> +	kfree(hwmon->temp_channel_desc);
> +err_free_name:
> +	kfree(hwmon->name);
> +err_free_hwmon:
> +	kfree(hwmon);
> +	return ERR_PTR(err);
> +}
> +
> +static int mlx5_hwmon_dev_init(struct mlx5_hwmon *hwmon)
> +{
> +	u32 mtcap_out[MLX5_ST_SZ_DW(mtcap_reg)] = {};
> +	u32 mtcap_in[MLX5_ST_SZ_DW(mtcap_reg)] = {};
> +	int err;
> +	int i;
> +
> +	err =  mlx5_core_access_reg(hwmon->mdev, mtcap_in,  sizeof(mtcap_in),
> +				    mtcap_out, sizeof(mtcap_out),
> +				    MLX5_REG_MTCAP, 0, 0);
> +	if (err)
> +		return err;
> +
> +	mlx5_hwmon_channel_info_init(hwmon);
> +	mlx5_hwmon_init_sensors_indexes(hwmon, MLX5_GET64(mtcap_reg, mtcap_out, sensor_map));
> +	err = mlx5_hwmon_init_channels_names(hwmon);
> +	if (err)
> +		return err;
> +
> +	for (i = 0; i < hwmon->asic_platform_scount + hwmon->module_scount; i++) {
> +		err = mlx5_hwmon_enable_max_temp(hwmon->mdev,
> +						 hwmon->temp_channel_desc[i].sensor_index);
> +		if (err)
> +			return err;
> +	}
> +
> +	hwmon->chip.ops = &mlx5_hwmon_ops;
> +	hwmon->chip.info = (const struct hwmon_channel_info **)hwmon->channel_info;
> +
> +	return 0;
> +}
> +
> +int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev)
> +{
> +	struct device *dev = mdev->device;
> +	struct mlx5_hwmon *hwmon;
> +	int err;
> +
> +	if (!MLX5_CAP_MCAM_REG(mdev, mtmp))
> +		return 0;
> +
> +	hwmon = mlx5_hwmon_alloc(mdev);
> +	if (IS_ERR(hwmon))
> +		return PTR_ERR(hwmon);
> +
> +	err = mlx5_hwmon_dev_init(hwmon);
> +	if (err)
> +		goto err_free_hwmon;
> +
> +	hwmon->hwmon_dev = hwmon_device_register_with_info(dev, hwmon->name,
> +							   hwmon,
> +							   &hwmon->chip,
> +							   NULL);
> +	if (IS_ERR(hwmon->hwmon_dev)) {
> +		err = PTR_ERR(hwmon->hwmon_dev);
> +		goto err_free_hwmon;
> +	}
> +
> +	mdev->hwmon = hwmon;
> +	return 0;
> +
> +err_free_hwmon:
> +	mlx5_hwmon_free(hwmon);
> +	return err;
> +}
> +

At first glance it seems to me that the hwmon device lifetime matches
the lifetime of the pci device. If so, it would be much easier and safe
to use devm_ functions and to tie unregistration to pci device removal.
Is there a reason for not doing that ?

Thanks,
Guenter

> +void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev)
> +{
> +	struct mlx5_hwmon *hwmon = mdev->hwmon;
> +
> +	if (!hwmon)
> +		return;
> +
> +	hwmon_device_unregister(hwmon->hwmon_dev);
> +	mlx5_hwmon_free(hwmon);
> +	mdev->hwmon = NULL;
> +}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
> new file mode 100644
> index 000000000000..999654a9b9da
> --- /dev/null
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved
> + */
> +#ifndef __MLX5_HWMON_H__
> +#define __MLX5_HWMON_H__
> +
> +#include <linux/mlx5/driver.h>
> +
> +#if IS_ENABLED(CONFIG_HWMON)

This may need IS_REACHABLE() - unless I am missing something, it is
possible to configure the mlx5 core with =y even if hwmon is built
as module. An alternative would be to add a dependency such as
	depends on HWMON || HWMON=n
to "config MLX5_CORE".

Thanks,
Guenter

> +
> +int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev);
> +void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev);
> +
> +#else
> +static inline int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev)
> +{
> +	return 0;
> +}
> +
> +static inline void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev) {}
> +
> +#endif
> +
> +#endif /* __MLX5_HWMON_H__ */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> index 88dbea6631d5..865d028b8abd 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
> @@ -49,7 +49,6 @@
>   #include <linux/version.h>
>   #include <net/devlink.h>
>   #include "mlx5_core.h"
> -#include "thermal.h"
>   #include "lib/eq.h"
>   #include "fs_core.h"
>   #include "lib/mpfs.h"
> @@ -73,6 +72,7 @@
>   #include "sf/dev/dev.h"
>   #include "sf/sf.h"
>   #include "mlx5_irq.h"
> +#include "hwmon.h"
>   
>   MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>   MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
> @@ -1920,9 +1920,9 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (err)
>   		dev_err(&pdev->dev, "mlx5_crdump_enable failed with error code %d\n", err);
>   
> -	err = mlx5_thermal_init(dev);
> +	err = mlx5_hwmon_dev_register(dev);
>   	if (err)
> -		dev_err(&pdev->dev, "mlx5_thermal_init failed with error code %d\n", err);
> +		mlx5_core_err(dev, "mlx5_hwmon_dev_register failed with error code %d\n", err);
>   
>   	pci_save_state(pdev);
>   	devlink_register(devlink);
> @@ -1954,7 +1954,7 @@ static void remove_one(struct pci_dev *pdev)
>   	mlx5_drain_health_wq(dev);
>   	devlink_unregister(devlink);
>   	mlx5_sriov_disable(pdev, false);
> -	mlx5_thermal_uninit(dev);
> +	mlx5_hwmon_dev_unregister(dev);
>   	mlx5_crdump_disable(dev);
>   	mlx5_uninit_one(dev);
>   	mlx5_pci_close(dev);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c b/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
> deleted file mode 100644
> index 52199d39657e..000000000000
> --- a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
> +++ /dev/null
> @@ -1,114 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> -// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
> -
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/device.h>
> -#include <linux/thermal.h>
> -#include <linux/err.h>
> -#include <linux/mlx5/driver.h>
> -#include "mlx5_core.h"
> -#include "thermal.h"
> -
> -#define MLX5_THERMAL_POLL_INT_MSEC	1000
> -#define MLX5_THERMAL_NUM_TRIPS		0
> -#define MLX5_THERMAL_ASIC_SENSOR_INDEX	0
> -
> -/* Bit string indicating the writeablility of trip points if any */
> -#define MLX5_THERMAL_TRIP_MASK	(BIT(MLX5_THERMAL_NUM_TRIPS) - 1)
> -
> -struct mlx5_thermal {
> -	struct mlx5_core_dev *mdev;
> -	struct thermal_zone_device *tzdev;
> -};
> -
> -static int mlx5_thermal_get_mtmp_temp(struct mlx5_core_dev *mdev, u32 id, int *p_temp)
> -{
> -	u32 mtmp_out[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> -	u32 mtmp_in[MLX5_ST_SZ_DW(mtmp_reg)] = {};
> -	int err;
> -
> -	MLX5_SET(mtmp_reg, mtmp_in, sensor_index, id);
> -
> -	err = mlx5_core_access_reg(mdev, mtmp_in,  sizeof(mtmp_in),
> -				   mtmp_out, sizeof(mtmp_out),
> -				   MLX5_REG_MTMP, 0, 0);
> -
> -	if (err)
> -		return err;
> -
> -	*p_temp = MLX5_GET(mtmp_reg, mtmp_out, temperature);
> -
> -	return 0;
> -}
> -
> -static int mlx5_thermal_get_temp(struct thermal_zone_device *tzdev,
> -				 int *p_temp)
> -{
> -	struct mlx5_thermal *thermal = thermal_zone_device_priv(tzdev);
> -	struct mlx5_core_dev *mdev = thermal->mdev;
> -	int err;
> -
> -	err = mlx5_thermal_get_mtmp_temp(mdev, MLX5_THERMAL_ASIC_SENSOR_INDEX, p_temp);
> -
> -	if (err)
> -		return err;
> -
> -	/* The unit of temp returned is in 0.125 C. The thermal
> -	 * framework expects the value in 0.001 C.
> -	 */
> -	*p_temp *= 125;
> -
> -	return 0;
> -}
> -
> -static struct thermal_zone_device_ops mlx5_thermal_ops = {
> -	.get_temp = mlx5_thermal_get_temp,
> -};
> -
> -int mlx5_thermal_init(struct mlx5_core_dev *mdev)
> -{
> -	char data[THERMAL_NAME_LENGTH];
> -	struct mlx5_thermal *thermal;
> -	int err;
> -
> -	if (!mlx5_core_is_pf(mdev) && !mlx5_core_is_ecpf(mdev))
> -		return 0;
> -
> -	err = snprintf(data, sizeof(data), "mlx5_%s", dev_name(mdev->device));
> -	if (err < 0 || err >= sizeof(data)) {
> -		mlx5_core_err(mdev, "Failed to setup thermal zone name, %d\n", err);
> -		return -EINVAL;
> -	}
> -
> -	thermal = kzalloc(sizeof(*thermal), GFP_KERNEL);
> -	if (!thermal)
> -		return -ENOMEM;
> -
> -	thermal->mdev = mdev;
> -	thermal->tzdev = thermal_zone_device_register_with_trips(data,
> -								 NULL,
> -								 MLX5_THERMAL_NUM_TRIPS,
> -								 MLX5_THERMAL_TRIP_MASK,
> -								 thermal,
> -								 &mlx5_thermal_ops,
> -								 NULL, 0, MLX5_THERMAL_POLL_INT_MSEC);
> -	if (IS_ERR(thermal->tzdev)) {
> -		err = PTR_ERR(thermal->tzdev);
> -		mlx5_core_err(mdev, "Failed to register thermal zone device (%s) %d\n", data, err);
> -		kfree(thermal);
> -		return err;
> -	}
> -
> -	mdev->thermal = thermal;
> -	return 0;
> -}
> -
> -void mlx5_thermal_uninit(struct mlx5_core_dev *mdev)
> -{
> -	if (!mdev->thermal)
> -		return;
> -
> -	thermal_zone_device_unregister(mdev->thermal->tzdev);
> -	kfree(mdev->thermal);
> -}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/thermal.h b/drivers/net/ethernet/mellanox/mlx5/core/thermal.h
> deleted file mode 100644
> index 7d752c122192..000000000000
> --- a/drivers/net/ethernet/mellanox/mlx5/core/thermal.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> - * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
> - */
> -#ifndef __MLX5_THERMAL_DRIVER_H
> -#define __MLX5_THERMAL_DRIVER_H
> -
> -#if IS_ENABLED(CONFIG_THERMAL)
> -int mlx5_thermal_init(struct mlx5_core_dev *mdev);
> -void mlx5_thermal_uninit(struct mlx5_core_dev *mdev);
> -#else
> -static inline int mlx5_thermal_init(struct mlx5_core_dev *mdev)
> -{
> -	mdev->thermal = NULL;
> -	return 0;
> -}
> -
> -static inline void mlx5_thermal_uninit(struct mlx5_core_dev *mdev) { }
> -#endif
> -
> -#endif /* __MLX5_THERMAL_DRIVER_H */
> diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
> index 25d0528f9219..7cb1520a27d6 100644
> --- a/include/linux/mlx5/driver.h
> +++ b/include/linux/mlx5/driver.h
> @@ -134,6 +134,7 @@ enum {
>   	MLX5_REG_PCAM		 = 0x507f,
>   	MLX5_REG_NODE_DESC	 = 0x6001,
>   	MLX5_REG_HOST_ENDIANNESS = 0x7004,
> +	MLX5_REG_MTCAP		 = 0x9009,
>   	MLX5_REG_MTMP		 = 0x900A,
>   	MLX5_REG_MCIA		 = 0x9014,
>   	MLX5_REG_MFRL		 = 0x9028,
> @@ -804,7 +805,7 @@ struct mlx5_core_dev {
>   	struct mlx5_rsc_dump    *rsc_dump;
>   	u32                      vsc_addr;
>   	struct mlx5_hv_vhca	*hv_vhca;
> -	struct mlx5_thermal	*thermal;
> +	struct mlx5_hwmon	*hwmon;
>   };
>   
>   struct mlx5_db {
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index b3ad6b9852ec..87fd6f9ed82c 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -10196,7 +10196,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
>   	u8         mrtc[0x1];
>   	u8         regs_44_to_32[0xd];
>   
> -	u8         regs_31_to_0[0x20];
> +	u8         regs_31_to_10[0x16];
> +	u8         mtmp[0x1];
> +	u8         regs_8_to_0[0x9];
>   };
>   
>   struct mlx5_ifc_mcam_access_reg_bits1 {
> @@ -10949,6 +10951,15 @@ struct mlx5_ifc_mrtc_reg_bits {
>   	u8         time_l[0x20];
>   };
>   
> +struct mlx5_ifc_mtcap_reg_bits {
> +	u8         reserved_at_0[0x19];
> +	u8         sensor_count[0x7];
> +
> +	u8         reserved_at_20[0x20];
> +
> +	u8         sensor_map[0x40];
> +};
> +
>   struct mlx5_ifc_mtmp_reg_bits {
>   	u8         reserved_at_0[0x14];
>   	u8         sensor_index[0xc];
> @@ -11036,6 +11047,7 @@ union mlx5_ifc_ports_control_registers_document_bits {
>   	struct mlx5_ifc_mfrl_reg_bits mfrl_reg;
>   	struct mlx5_ifc_mtutc_reg_bits mtutc_reg;
>   	struct mlx5_ifc_mrtc_reg_bits mrtc_reg;
> +	struct mlx5_ifc_mtcap_reg_bits mtcap_reg;
>   	struct mlx5_ifc_mtmp_reg_bits mtmp_reg;
>   	u8         reserved_at_0[0x60e0];
>   };


