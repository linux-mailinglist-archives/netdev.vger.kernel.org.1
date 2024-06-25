Return-Path: <netdev+bounces-106674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189939172E1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 511F3B22B46
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136F17DE0D;
	Tue, 25 Jun 2024 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/HZoBQR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D515746B;
	Tue, 25 Jun 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349181; cv=none; b=bkJu5f8CnQEy3DwrJ3wJbdk28lCh3CWrW4ccrq42yYQqi9JztOiF4Lo8czTLmD7gJxlYZAM75VuOYN39dan9ed1UUH8iWspN5zpWF1nchg1B3rKgGKD68v4o+75+70hvJzS2ljsNoVcdrVTBkQ6fdL68scv9gwuo/lz6BmQtEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349181; c=relaxed/simple;
	bh=SYpfwoQBP9K0+mgjXAjCBkA+VjbYsp8LOlvT8tUO+AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRXjfLlQI7lAaAfTJtNYVftQIYe1ZIJ/0RNJG50v1F2eVjHewYscLpQdv33pHQ3k2cxWS8cJov/aIstgy0n0KzUqD1JfRzysGZptbEcX3Z+ylU8Ml7SNFb8CxISk+QiVufF3lcD8YeK96LDCz5RftpMDliEJrmfKqscqyPXB/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/HZoBQR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424798859dfso49462915e9.0;
        Tue, 25 Jun 2024 13:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719349178; x=1719953978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTG2TvCrIw1jmVcR2e9S1P6f3u4TysIFWdqM45nr8ns=;
        b=Z/HZoBQRlrZYYcx40uzwKbjqzrVIzdk5tIYA+RoaGyftohoRTjJuWmqaVZctUjZ8Xo
         BXlz39abKHMRRaq9sxih1icQGIxIbVhJID7y+9QSXP7S9pheyf11xfELqKIPfBIdpg2K
         NE7l3/OlDvH3eESL9LqNv1Y5zdOJ2tQC40+F4RWUB7nHysuCdEPF8ZjTITnx5Sqi/alV
         iyGA1Yww3w+7d2wrbLPTj0D0HU7kmMf3mQ0LfFg+o+mu3FtRHnAlA2/E9Deufo5ip09d
         nptoe/u+FeansI2zRETLhIi2EiwqsExwGWLjrFVuz2OyaBD4wokNiB/qXPtyIeSeRPGP
         p1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349178; x=1719953978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTG2TvCrIw1jmVcR2e9S1P6f3u4TysIFWdqM45nr8ns=;
        b=P0we89kTEpTvaPPP/hQ1jSsEVgk0lyJw8zfbdXXir8ejFf9pMa8OyLLuvn2McAG/kP
         SIq5Lj61xhvcxIzl9Ts//8nDbZY8AqRnpyfJKDp1dQ6PPKr5WD6Fp2e5baPqger4/Mo0
         N7laZEX/Oll2FMOKjol5u8L6V/GWzB0RDVnVEppXjGUyl1LlnIUYb1sIxh90rEvVvvF2
         S6FtRzEwytuQW9TEwQ/AwrIuVRZVx41Ro7bTvS2HhioOxa45EdtQ8lKIRrr7kzSvWtWm
         +v8B2NDsJNxNaTTeDg26RH77AwlR9u3Hudmne/uiTuoKBtyhUCOjGGRCXfOs7Ia13pVr
         93pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4UxPwEnyvWghzKSxPqKrFCfoovVdT6G9c0QI+O7rD3o79tmDBVLp/PK1xVJHNY+t+v6CCIIHdAryaYtDSbWvmjGresfVD
X-Gm-Message-State: AOJu0YwzqzLVJ4xMu0ya+TqC/QPe3D/Z6Ima3uBYghzKPQDZAtYgyrlu
	oxvIlha0+IoJHaX2koOF7oRbeY9BYe5Gb/fhA2UT3qDzf6gwPLNJ
X-Google-Smtp-Source: AGHT+IHtYKCogX6K7UIQnMF1Eh5YfbNmd7oi/WFVvKFSjsiuiZjL2swgM2RzHNfkKw77CiiXttfXQQ==
X-Received: by 2002:a7b:c3c1:0:b0:421:2b13:e9cf with SMTP id 5b1f17b1804b1-4248cc66b18mr59034765e9.36.1719349177757;
        Tue, 25 Jun 2024 13:59:37 -0700 (PDT)
Received: from [192.168.0.5] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f675esm13924469f8f.22.2024.06.25.13.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 13:59:37 -0700 (PDT)
Message-ID: <9cc44560-2226-446d-9b95-02edc9c8a008@gmail.com>
Date: Wed, 26 Jun 2024 00:00:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2 2/2] net: wwan: t7xx: Add debug port
To: Jinjian Song <songjinjian@hotmail.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jinjian Song <jinjian.song@fibocom.com>
References: <20240625084518.10041-1-songjinjian@hotmail.com>
 <SYBP282MB3528BE02090B58B84CD714DFBBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <SYBP282MB3528BE02090B58B84CD714DFBBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjian,

On 25.06.2024 11:45, Jinjian Song wrote:
> Add support for userspace to switch on the debug port(ADB,MIPC).
>   - ADB port: /dev/wwan0adb0
>   - MIPC port: /dev/wwan0mipc0
> 
> Application can use ADB (Android Debg Bridge) port to implement
> functions (shell, pull, push ...) by ADB protocol commands.
> E.g., ADB commands:
>   - A_OPEN: OPEN(local-id, 0, "destination")
>   - A_WRTE: WRITE(local-id, remote-id, "data")
>   - A_OKEY: READY(local-id, remote-id, "")
>   - A_CLSE: CLOSE(local-id, remote-id, "")
> 
> Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
> 
> Application can use MIPC (Modem Information Process Center) port
> to debug antenna tunner or noise profiling through this MTK modem
> diagnostic interface.
> 
> By default, debug ports are not exposed, so using the command
> to enable or disable debug ports.
> 
> Switch on debug port:
>   - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode
> 
> Switch off debug port:
>   - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode
> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
>   .../networking/device_drivers/wwan/t7xx.rst   | 29 ++++++++++++
>   drivers/net/wwan/t7xx/t7xx_pci.c              |  7 +++
>   drivers/net/wwan/t7xx/t7xx_pci.h              |  2 +
>   drivers/net/wwan/t7xx/t7xx_port.h             |  3 ++
>   drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 45 ++++++++++++++++++-
>   drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
>   drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 +++-
>   7 files changed, 91 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
> index f346f5f85f15..3d70c5e3f769 100644
> --- a/Documentation/networking/device_drivers/wwan/t7xx.rst
> +++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
> @@ -56,6 +56,10 @@ Device mode:
>   - ``fastboot_switching`` represents that device in fastboot switching status
>   - ``fastboot_download`` represents that device in fastboot download status
>   - ``fastboot_dump`` represents that device in fastboot dump status
> +- ``debug`` represents switching on debug ports (write only)
> +- ``normal`` represents switching off debug ports (write only)
> +
> +Currently supported debug ports (ADB/MIPC)

Could you clarify a bit the availability of these debug ports (ADB and 
MIPC)? Looks like these ports are always available when a modem is 
booted in a 'normal' mode. They are available among other types of ports 
like AT, MBIM, etc. And you want to hide them, or speaking more 
precisely, you want to make debug ports availability configurable. Do I 
understand it right?

I just have doubts regarding the chosen configuration approach. We 
already have a 'ready' mode indicating a normal operation. Now we are 
introducing a 'debug' mode that only makes available ADB/MIPC ports, but 
reading from the 't7xx_mode' file will return 'ready'. And also we are 
going to introduce a 'normal' mode, that actually means 'hide this debug 
ports please'. While easy to introduce, looks like puzzle for a user.

I also would like to mention a potentially dangerous case. If a modem is 
already booted in the 'fastboot_download' mode, and someone writes 
'normal' into the 't7xx_mode' file. Will it switch the modem into a 
normal operational state. Also the activation itself lacks a couple of 
checks regarding a double port activation. Please see below.

How we can make this configuration process less puzzling? Should we 
rework the state machine more carefully or should we introduce a 
dedicated control file this purpose?

>   Read from userspace to get the current device mode.
>   
> @@ -139,6 +143,25 @@ Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
>   port, because device needs a cold reset after enter ``fastboot_switching``
>   mode.
>   
> +ADB port userspace ABI
> +----------------------
> +
> +/dev/wwan0adb0 character device
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The driver exposes a ADB protocol interface by implementing ADB WWAN Port.
> +The userspace end of the ADB channel pipe is a /dev/wwan0adb0 character device.
> +Application shall use this interface for ADB protocol communication.
> +
> +MIPC port userspace ABI
> +-----------------------
> +
> +/dev/wwan0mipc0 character device
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The driver exposes a diagnostic interface by implementing MIPC (Modem
> +Information Process Center) WWAN Port. The userspace end of the MIPC channel
> +pipe is a /dev/wwan0mipc0 character device.
> +Application shall use this interface for MTK modem diagnostic communication.
> +
>   The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
>   
>   References
> @@ -164,3 +187,9 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
>   [5] *fastboot "a mechanism for communicating with bootloaders"*
>   
>   - https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
> +
> +[6] *ADB (Android Debug Bridge) "a mechanism to keep track of Android devices and
> +emulators instances connected to or running on a given host developer machine with
> +ADB protocol"*
> +
> +- https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index e0b1e7a616ca..6b18460d626c 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -41,6 +41,7 @@
>   #include "t7xx_pcie_mac.h"
>   #include "t7xx_reg.h"
>   #include "t7xx_state_monitor.h"
> +#include "t7xx_port_proxy.h"
>   
>   #define T7XX_PCI_IREG_BASE		0
>   #define T7XX_PCI_EREG_BASE		2
> @@ -59,6 +60,8 @@ static const char * const t7xx_mode_names[] = {
>   	[T7XX_FASTBOOT_SWITCHING] = "fastboot_switching",
>   	[T7XX_FASTBOOT_DOWNLOAD] = "fastboot_download",
>   	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
> +	[T7XX_DEBUG] = "debug",
> +	[T7XX_NORMAL] = "normal",
>   };
>   
>   static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
> @@ -82,6 +85,10 @@ static ssize_t t7xx_mode_store(struct device *dev,
>   	} else if (index == T7XX_RESET) {
>   		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
>   		t7xx_acpi_pldr_func(t7xx_dev);
> +	} else if (index == T7XX_DEBUG) {
> +		t7xx_proxy_port_debug(t7xx_dev, true);
> +	} else if (index == T7XX_NORMAL) {
> +		t7xx_proxy_port_debug(t7xx_dev, false);
>   	}
>   
>   	return count;
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
> index 49a11586d8d8..bdcadeb035e0 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.h
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.h
> @@ -50,6 +50,8 @@ enum t7xx_mode {
>   	T7XX_FASTBOOT_SWITCHING,
>   	T7XX_FASTBOOT_DOWNLOAD,
>   	T7XX_FASTBOOT_DUMP,
> +	T7XX_DEBUG,
> +	T7XX_NORMAL,
>   	T7XX_MODE_LAST, /* must always be last */
>   };
>   
> diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
> index f74d3bab810d..9f5d6d288c97 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port.h
> +++ b/drivers/net/wwan/t7xx/t7xx_port.h
> @@ -42,6 +42,8 @@ enum port_ch {
>   	/* to AP */
>   	PORT_CH_AP_CONTROL_RX = 0x1000,
>   	PORT_CH_AP_CONTROL_TX = 0x1001,
> +	PORT_CH_AP_ADB_RX = 0x100a,
> +	PORT_CH_AP_ADB_TX = 0x100b,
>   
>   	/* to MD */
>   	PORT_CH_CONTROL_RX = 0x2000,
> @@ -100,6 +102,7 @@ struct t7xx_port_conf {
>   	struct port_ops		*ops;
>   	char			*name;
>   	enum wwan_port_type	port_type;
> +	bool			debug;
>   };
>   
>   struct t7xx_port {
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> index 7d6388bf1d7c..3510f9013811 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> @@ -39,6 +39,8 @@
>   
>   #define Q_IDX_CTRL			0
>   #define Q_IDX_MBIM			2
> +#define Q_IDX_MIPC			2
> +#define Q_IDX_ADB			3
>   #define Q_IDX_AT_CMD			5
>   
>   #define INVALID_SEQ_NUM			GENMASK(15, 0)
> @@ -100,7 +102,27 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
>   		.path_id = CLDMA_ID_AP,
>   		.ops = &ctl_port_ops,
>   		.name = "t7xx_ap_ctrl",
> -	},
> +	}, {
> +		.tx_ch = PORT_CH_AP_ADB_TX,
> +		.rx_ch = PORT_CH_AP_ADB_RX,
> +		.txq_index = Q_IDX_ADB,
> +		.rxq_index = Q_IDX_ADB,
> +		.path_id = CLDMA_ID_AP,
> +		.ops = &wwan_sub_port_ops,
> +		.name = "adb",
> +		.port_type = WWAN_PORT_ADB,
> +		.debug = true,
> +	}, {
> +		.tx_ch = PORT_CH_MIPC_TX,
> +		.rx_ch = PORT_CH_MIPC_RX,
> +		.txq_index = Q_IDX_MIPC,
> +		.rxq_index = Q_IDX_MIPC,
> +		.path_id = CLDMA_ID_MD,
> +		.ops = &wwan_sub_port_ops,
> +		.name = "mipc",
> +		.port_type = WWAN_PORT_MIPC,
> +		.debug = true,
> +	}
>   };
>   
>   static const struct t7xx_port_conf t7xx_early_port_conf[] = {
> @@ -505,13 +527,32 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
>   		spin_lock_init(&port->port_update_lock);
>   		port->chan_enable = false;
>   
> -		if (port_conf->ops && port_conf->ops->init)
> +		if (!port_conf->debug && port_conf->ops && port_conf->ops->init)
>   			port_conf->ops->init(port);
>   	}
>   
>   	t7xx_proxy_setup_ch_mapping(port_prox);
>   }
>   
> +void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show)
> +{
> +	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
> +	struct t7xx_port *port;
> +	int i;
> +
> +	for_each_proxy_port(i, port, port_prox) {
> +		const struct t7xx_port_conf *port_conf = port->port_conf;
> +
> +		spin_lock_init(&port->port_update_lock);

This lock initialization does not seems correct. Should we reinitialize 
the lock on port hiding? And looks like the lock was already initialized 
in the t7xx_proxy_init_all_ports() function.

> +		if (port_conf->debug && port_conf->ops && port_conf->ops->init) {
> +			if (show)
> +				port_conf->ops->init(port);
> +			else
> +				port_conf->ops->uninit(port);

This part is also does not seems correct. Existing of the 'init' 
operation does not imply existing of 'uninit' operation. See 
t7xx_port_proxy_uninit() function.

Also t7xx_port_proxy_uninit() will call the uninitialization operation 
for us. Is it safe to call the uninitialization operation twice? Once to 
hide the ports and another one time on a driver unloading. Or what 
happens if someone will write 'normal' into 't7xx_mode' twice?

The same question is valid regarding the initialization (ports showing). 
If someone will write 'debug' into 't7xx_mode' twice, then we will 
register the same ADB port twice. Isn't it?

> +		}
> +	}
> +}
> +
>   void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
>   {
>   	struct port_proxy *port_prox = md->port_prox;
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
> index 7f5706811445..a9c19c1253e6 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
> +++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
> @@ -98,6 +98,7 @@ extern struct port_ops ctl_port_ops;
>   extern struct port_ops t7xx_trace_port_ops;
>   #endif
>   
> +void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show);
>   void t7xx_port_proxy_reset(struct port_proxy *port_prox);
>   void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
>   int t7xx_port_proxy_init(struct t7xx_modem *md);
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> index 4b23ba693f3f..7fc569565ff9 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
> @@ -169,7 +169,9 @@ static int t7xx_port_wwan_init(struct t7xx_port *port)
>   {
>   	const struct t7xx_port_conf *port_conf = port->port_conf;
>   
> -	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
> +	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
> +	    port_conf->port_type == WWAN_PORT_ADB ||
> +	    port_conf->port_type == WWAN_PORT_MIPC)
>   		t7xx_port_wwan_create(port);
>   
>   	port->rx_length_th = RX_QUEUE_MAXLEN;
> @@ -224,7 +226,9 @@ static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int
>   {
>   	const struct t7xx_port_conf *port_conf = port->port_conf;
>   
> -	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
> +	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
> +	    port_conf->port_type == WWAN_PORT_ADB ||
> +	    port_conf->port_type == WWAN_PORT_MIPC)
>   		return;
>   
>   	if (state != MD_STATE_READY)


