Return-Path: <netdev+bounces-139732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD29B3EA2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB91C2195D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F71D460B;
	Mon, 28 Oct 2024 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh8REOix"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07961DDC06;
	Mon, 28 Oct 2024 23:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159173; cv=none; b=DsyZQ3lgGUVhZoLV4KHYSbcWcBGvJigsEwP8tDxJvO8YyJDG/SbdF2wyAeyfVRwgvtCivMKN7g/VmQ0TxxbULJiYerGcPQH1EI/0bMJdBDTqPrCNPhWcD5CUPk/Th/TvFm37DzcE020t19RcjKmKwbLhFr32F57YK7y1y9Rn33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159173; c=relaxed/simple;
	bh=G/lT6n8WuMOSLqZQcfomU4Jl3O2N1nr6l1dVCyCnw24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuAvX+U4e1g6IoPItRihgUEZzSMCFjmLhgGoEfur/y7S0M+CezL5GOHLAfzyEi3afY26trfok92gcebFx4l4sjehT88ysjC46ux+3hEx7rUhNHgLepjGoP+N/EHa0LF4kI6qaBp20SmK3AZGLicB/75wpIMI3uqwn3iOI+AbWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sh8REOix; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431616c23b5so34573245e9.0;
        Mon, 28 Oct 2024 16:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730159168; x=1730763968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbWOI8rIJnE4PgyHSLr+n4TOjxtKcIqiIr0r/OJFP0A=;
        b=Sh8REOixwfEmJgWQLssGUSGXqCVDaIp0aetkcZd1KMkJY3+1G/v1Nq7lswaoH+Eh/+
         jMYOpQAv+CLtCNhG5xG9onY22eHJbiypXziHzDVtZxWjAbB1u0g7dUqZx42piA94UFab
         J+MLforADiS9BP2ALVrUIYqs75CkyWBSQ+3/PIFkzmAnrPyCwmThz7H14pD1Jt61ocKm
         66v9rwQdLHRTTh/Lf63tYC51MxPDxpwN5nIPjF0GMi64ANywR0YWeW38aqmZc+mo+Pts
         qii6qCvX0U9BIYlf9z9hKcb9JD2SJKYscqj2O/9FwZFCkVYM7dM1KnKY7mQ/YgjzPdS4
         95Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730159168; x=1730763968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbWOI8rIJnE4PgyHSLr+n4TOjxtKcIqiIr0r/OJFP0A=;
        b=L58vGNJ/6MdfTbjJ879AI/KPPChJQT7AuM5hjntGAwSSonIvCUhdQOXX1hTqKBJjTe
         3IgOotX/2AcFyE7Ruh97ErRoZfnnUeCUhFoRaqrN4MN5QRXEgKpSEVIj0KjD6iMuDOmb
         lyGYoEG6xp7PJjK2yqdeGYZD9tdXnoQQ2GLMSwsvmhlbMtQyGCC+6pb4s1K1JgdXJW8Q
         XGqXosvrEtH9xfYskC5JfuQQJLyJ0/KKNImh/quzwxhCT3n5K3YIlOqQtpPZhJy2lpDg
         KhfzDZ3mjFPbz8wk9Xcw89/4FsoNTKT6VAyNBn0dmT5YA4/1Cl8osDPr58rbcV91Pu7Q
         HcVg==
X-Forwarded-Encrypted: i=1; AJvYcCUVmNIuWgSzimA+DxfRfspLkqx5ZSs2E+pCbRP5o/KxOHbO4qBZIG4FaH0tguTg+sO5La1HPb6+sCX5EIUk@vger.kernel.org, AJvYcCV9oQP/aSeMKPbty+VKkiLtaktdZ3VsiaqKxFvOtZuwUiUOwo3vOjWg0gCTtuCLLSOE2Ec/UXrK4Lo=@vger.kernel.org, AJvYcCW/5uGEJX4U587FyE3xEn9T32HQubeQxSJvV4TVF3Jc7aZMVTzVQC55S++SqDRaZm50psCIA/pW@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUjpkpR3T5E9WNwpPiYa8bJABHv7kYmzYOIyS3iRTq8Gp5g6g
	3jj2uspwX0Igrx6Tb95fGSkId8XQp85fEd3t9JY+ZNFDenu0DXKb
X-Google-Smtp-Source: AGHT+IHb1Axcuu0I4KSesHeVGzDHB/9Qn0FsdmvRACndMRVgunYKP3/3xOkI8mu2ykQb6JKpCpJQtg==
X-Received: by 2002:a05:600c:a4b:b0:431:4a82:97f2 with SMTP id 5b1f17b1804b1-431b55e5dfcmr1226035e9.6.1730159167546;
        Mon, 28 Oct 2024 16:46:07 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b79esm158178125e9.47.2024.10.28.16.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 16:46:07 -0700 (PDT)
Message-ID: <b3aab30d-7c9a-451a-aea9-6bba72fe986d@gmail.com>
Date: Tue, 29 Oct 2024 01:46:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v7 2/2] net: wwan: t7xx: Add debug port
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, chandrashekar.devegowda@intel.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
 corbet@lwn.net, linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, korneld@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, edumazet@google.com
References: <20241026090921.8008-1-jinjian.song@fibocom.com>
 <20241026090921.8008-3-jinjian.song@fibocom.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241026090921.8008-3-jinjian.song@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjian,

On 26.10.2024 12:09, Jinjian Song wrote:
> Add support for userspace to switch on the debug port(ADB,MIPC).
>   - ADB port: /dev/wwan0adb0
>   - MIPC port: /dev/wwan0mipc0
> 
> Application can use ADB (Android Debug Bridge) port to implement
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
> to debug antenna tuner or noise profiling through this MTK modem
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

Looks like this part of the message needs an update. Now driver uses a 
dedicated file for this operation.

> 
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
> v7:
>   * Adjust t7xx.rst columns and word spelling in commit message
> v5:
>   * modify line length warning in t7xx_proxy_port_debug()
> v4:
>   * modify commit message t7xx_mode to t7xx_port_mode
> v3:
>   * add sysfs interface t7xx_port_mode
>   * delete spin_lock_init in t7xx_proxy_port_debug()
>   * modify document t7xx.rst
> v2:
>   * add WWAN ADB and MIPC port
> ---
>   .../networking/device_drivers/wwan/t7xx.rst   | 64 +++++++++++++++---
>   drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
>   drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
>   drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
>   drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 44 +++++++++++-
>   drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
>   drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
>   7 files changed, 176 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
> index f346f5f85f15..6071dee8c186 100644
> --- a/Documentation/networking/device_drivers/wwan/t7xx.rst
> +++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
> @@ -7,12 +7,13 @@
>   ============================================
>   t7xx driver for MTK PCIe based T700 5G modem
>   ============================================
> -The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS platforms
> -for data exchange over PCIe interface between Host platform & MediaTek's T700 5G modem.
> -The driver exposes an interface conforming to the MBIM protocol [1]. Any front end
> -application (e.g. Modem Manager) could easily manage the MBIM interface to enable
> -data communication towards WWAN. The driver also provides an interface to interact
> -with the MediaTek's modem via AT commands.
> +The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS
> +platforms for data exchange over PCIe interface between Host platform &
> +MediaTek's T700 5G modem.
> +The driver exposes an interface conforming to the MBIM protocol [1]. Any front
> +end application (e.g. Modem Manager) could easily manage the MBIM interface to
> +enable data communication towards WWAN. The driver also provides an interface
> +to interact with the MediaTek's modem via AT commands.

Thank you for taking care and unifying documentation, still, I believe, 
this change doesn't belong to this specific patch, what introduced debug 
ports toggling knob. Could you factor our these formating updating 
changes into a dedicated patch? E.g. add a new patch "2/3: unify 
documentation" and make this patch third in the series.

[skipped]

> @@ -67,6 +68,28 @@ Write from userspace to set the device mode.
>   ::
>     $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
>   
> +t7xx_port_mode

I believe we should use the plural form - portS, since this knob 
controls behaviour of the group of ports.

And I have one more suggestion. "mode" sounds too generic, can we 
consider renaming this option to something, what includes more details 
about the mode. E.g. can we rename this knob to 't7xx_debug_ports' and 
make it simple boolean (on/off) option?

> +--------------
> +The sysfs interface provides userspace with access to the port mode, this
> +interface supports read and write operations.
> +
> +Port mode:
> +
> +- ``normal`` represents switching off debug ports
> +- ``debug`` represents switching on debug ports
> +
> +Currently supported debug ports (ADB/MIPC).
> +
> +Read from userspace to get the current port mode.
> +
> +::
> +  $ cat /sys/bus/pci/devices/${bdf}/t7xx_port_mode
> +
> +Write from userspace to set the port mode.
> +
> +::
> +  $ echo debug > /sys/bus/pci/devices/${bdf}/t7xx_port_mode
> +
>   Management application development
>   ==================================
>   The driver and userspace interfaces are described below. The MBIM protocol is
> @@ -139,6 +162,25 @@ Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
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
> @@ -164,3 +206,9 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
>   [5] *fastboot "a mechanism for communicating with bootloaders"*
>   
>   - https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
> +
> +[6] *ADB (Android Debug Bridge) "a mechanism to keep track of Android devices
> +and emulators instances connected to or running on a given host developer
> +machine with ADB protocol"*
> +
> +- https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index 4f89a353588b..687a5e73508a 100644
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
> @@ -61,7 +62,13 @@ static const char * const t7xx_mode_names[] = {
>   	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
>   };
>   
> +static const char * const t7xx_port_mode_names[] = {
> +	[T7XX_DEBUG] = "debug",
> +	[T7XX_NORMAL] = "normal",
> +};
> +
>   static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
> +static_assert(ARRAY_SIZE(t7xx_port_mode_names) == T7XX_PORT_MODE_LAST);
>   
>   static ssize_t t7xx_mode_store(struct device *dev,
>   			       struct device_attribute *attr,
> @@ -120,13 +127,61 @@ static ssize_t t7xx_mode_show(struct device *dev,
>   
>   static DEVICE_ATTR_RW(t7xx_mode);
>   
> -static struct attribute *t7xx_mode_attr[] = {
> +static ssize_t t7xx_port_mode_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct t7xx_pci_dev *t7xx_dev;
> +	struct pci_dev *pdev;
> +	int index = 0;
> +
> +	pdev = to_pci_dev(dev);

This assignment should be done along the variable declaration to make 
code shorter:

struct pci_dev *pdev = to_pci_dev(dev);

> +	t7xx_dev = pci_get_drvdata(pdev);
> +	if (!t7xx_dev)
> +		return -ENODEV;
> +
> +	index = sysfs_match_string(t7xx_port_mode_names, buf);
> +	if (index == T7XX_DEBUG) {
> +		t7xx_proxy_port_debug(t7xx_dev, true);

Another one nit picking question. It is unclear what is going to happen 
after this call. Can we rename this function to something what clearly 
indicates the desired reaction? E.g. t7xx_proxy_debug_ports_show(...).

> +		WRITE_ONCE(t7xx_dev->port_mode, T7XX_DEBUG);
> +	} else if (index == T7XX_NORMAL) {
> +		t7xx_proxy_port_debug(t7xx_dev, false);
> +		WRITE_ONCE(t7xx_dev->port_mode, T7XX_NORMAL);
> +	}
> +
> +	return count;
> +};
> +
> +static ssize_t t7xx_port_mode_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	enum t7xx_port_mode port_mode = T7XX_NORMAL;
> +	struct t7xx_pci_dev *t7xx_dev;
> +	struct pci_dev *pdev;
> +
> +	pdev = to_pci_dev(dev);

Also should be assigned on declaration.

> +	t7xx_dev = pci_get_drvdata(pdev);
> +	if (!t7xx_dev)
> +		return -ENODEV;
> +
> +	port_mode = READ_ONCE(t7xx_dev->port_mode);
> +	if (port_mode < T7XX_PORT_MODE_LAST)
> +		return sysfs_emit(buf, "%s\n", t7xx_port_mode_names[port_mode]);
> +
> +	return sysfs_emit(buf, "%s\n", t7xx_port_mode_names[T7XX_NORMAL]);
> +}
> +
> +static DEVICE_ATTR_RW(t7xx_port_mode);
> +
> +static struct attribute *t7xx_attr[] = {
>   	&dev_attr_t7xx_mode.attr,
> +	&dev_attr_t7xx_port_mode.attr,
>   	NULL
>   };
>   
> -static const struct attribute_group t7xx_mode_attribute_group = {
> -	.attrs = t7xx_mode_attr,
> +static const struct attribute_group t7xx_attribute_group = {
> +	.attrs = t7xx_attr,
>   };
>   
>   void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
> @@ -843,7 +898,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
>   
>   	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
> -				 &t7xx_mode_attribute_group);
> +				 &t7xx_attribute_group);
>   	if (ret)
>   		goto err_md_exit;
>   
> @@ -859,7 +914,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   err_remove_group:
>   	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
> -			   &t7xx_mode_attribute_group);
> +			   &t7xx_attribute_group);
>   
>   err_md_exit:
>   	t7xx_md_exit(t7xx_dev);
> @@ -874,7 +929,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
>   	t7xx_dev = pci_get_drvdata(pdev);
>   
>   	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
> -			   &t7xx_mode_attribute_group);
> +			   &t7xx_attribute_group);
>   	t7xx_md_exit(t7xx_dev);
>   
>   	for (i = 0; i < EXT_INT_NUM; i++) {
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
> index cd8ea17c2644..1d632405c89b 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.h
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.h
> @@ -53,6 +53,12 @@ enum t7xx_mode {
>   	T7XX_MODE_LAST, /* must always be last */
>   };
>   
> +enum t7xx_port_mode {
> +	T7XX_NORMAL,
> +	T7XX_DEBUG,
> +	T7XX_PORT_MODE_LAST, /* must always be last */
> +};
> +
>   /* struct t7xx_pci_dev - MTK device context structure
>    * @intr_handler: array of handler function for request_threaded_irq
>    * @intr_thread: array of thread_fn for request_threaded_irq
> @@ -94,6 +100,7 @@ struct t7xx_pci_dev {
>   	struct dentry		*debugfs_dir;
>   #endif
>   	u32			mode;
> +	u32			port_mode;

If we agree to rename the sysfs file to 't7xx_debug_ports', this field 
can be renamed to something more specific like 'debug_ports_show'.

>   };
>   
>   enum t7xx_pm_id {
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
> index 35743e7de0c3..26d3f57732cc 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
> @@ -39,6 +39,8 @@
>   
>   #define Q_IDX_CTRL			0
>   #define Q_IDX_MBIM			2
> +#define Q_IDX_MIPC			2

Are you sure that we should define a new name for the same queue id? Can 
we just specify Q_IDX_MBIM in the port description or rename Q_IDX_MBIM 
to Q_IDX_MBIM_MIPC to avoid id names duplication?

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
> @@ -505,13 +527,31 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
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
> +		if (port_conf->debug && port_conf->ops && port_conf->ops->init) {
> +			if (show)
> +				port_conf->ops->init(port);
> +			else
> +				port_conf->ops->uninit(port);

I still do not like the assumption that if .init method is defined then 
the .uninit method is defined too. Is it make sense to compose these 
checks like below. Mmove the check for .init/.uninit inside and add a 
comment justifying absense of a check of a current port state.

/* NB: it is safe to call init/uninit multiple times */
if (port_conf->debug && port_conf->ops) {
	if (show && port_conf->ops->init)
		port_conf->ops->init(port);
	else if (!show && port_conf->ops->uninit)
		port_conf->ops->uninit(port);
}

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


