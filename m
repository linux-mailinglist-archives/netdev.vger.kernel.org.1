Return-Path: <netdev+bounces-274434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOnZDrExzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:06:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D6738676A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6560A301D6A2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309A2E36F8;
	Thu,  2 Apr 2026 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOB8RZOW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A18200110
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120570; cv=none; b=byg+FPsxV6fsiQpbyFT7K/xo6woMJ96OsOtCp2KuVZGWPs60LRBxo2ki+GcWJ0kK/i0fLtlp1PaOulw+4MFj6Oal1+QiQlzxWv9b+rd1vkhJ8lY8wdQx3vyKyr0T5LrpIrfsURhlTdOsN3Y9CVEcTSkfgdgDqSNj/iHkRz2pV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120570; c=relaxed/simple;
	bh=pQSfKt+QGiLG63KHk6IL/I9o4php1mlsqxvj8CbPmW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppXrV7p23hgRnCCEEP4XFMvQw94bhSM6f439Y9RYk5WgXHqQPkeJMoU2n+bJqWkT7rfdY7A+4IqxJy1wripM1fbcdTB6SBy8K2963sCxtruzLLJUBOy5jP8omn3b6lzCbVdtkjHwKvFyzyKBdQ+a0cB+aF9G8r33vhgMZYvYvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOB8RZOW; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba895adfeaso815832eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120567; x=1775725367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOynyHrMJ1gh1+3pdBDNr+UzOUPWLPLlK0eYSCZoPF0=;
        b=aOB8RZOWANLCA3Pnck7jWbq6aYRy186VCibUVMj5ToLrmyzv6d8Ok2zuuBgcGb2fcT
         VgRphh/K4bD5MWzKsGaG0iNozMpcPK45PIaFiimCZVrdsPXRO9O9lCccVv/J5wX24p1v
         ttK1OtR+TO1okK6wqVu/THAadtJFf0F7NlUP+lFguSLaBihKq/K0GNCXt6HBcyyki5cX
         Fk9q2SUJMv5zemDfq4JQTsKLbOFdNyeE4Qp5Eva67EwAOuD6PJ69xCFwjm7F36Z8WqQj
         B0GbNdkc2x0T+vbZhPFrNiHHCabl7IrPdNzlCdRMeLECwsY449PNxLDMxd/LY4TimOQw
         /c3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120567; x=1775725367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOynyHrMJ1gh1+3pdBDNr+UzOUPWLPLlK0eYSCZoPF0=;
        b=hCIlphcbpbxMi2u+fRyQDi1uqIedPTrpO+DJmkBJjL4U0D8FmGXa/j4b91WFimD+I2
         j82WJsKPlAZY/Vl/JmFkoUXuE2NAM3WGIFlttm7YaL7sqzA1cCFgVsYnXPwMU6irTdJY
         sZWI4d9qDnhWJkEcmGHXVy4oHSCtXpcQKKbSo3MUXNbLacE20dIFMIfz/a9XDafYwimZ
         5fR9ZcvaugZL8CEHqS4sp4TX+H7Q6PsQtC4aPy4VHGJN8mM14JUtZlzze27XrhtLXbYV
         vKrXkJszNbFL0WCz1tuZT5TXI893NcAgSR+FaIhBDjDWYVfmTbsri7evf2yPGl7wBkk3
         46XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtrlcpw4eSUvvlWG7Q8ixu2/vAGVAa8ca4lncGrFA2ExkZZJzZmYyVF3WnGmEMNV/0A9C8/ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YynU3i9+Fdz4q0mL2Ez2fo47lMI/6BfYrjWRwdM77bD3WLPPlgn
	9t5EMoXTMy0cN9wRfTbizGSAFW5e2mk/KOgc72PH5CvW+T+6LwSfyxXH
X-Gm-Gg: ATEYQzwQ/VfFk560BoR4kJmqp7OzZWYarZR87fcx6/UyVy0/V3E7oF1QdGmRS6ITi4r
	/mBhMRNN4wN7D6oec3jpc9KfBRC/MBVqpyLw2y5Bv4euzy033lovwID1os/1fbXtYazT9lhbfdP
	xR94arTz7bb8Q4Nog01fdqy14jguTrEZRcdy+mekyg7JbGjQ4x5oIWcDnoILlZr3LjgS88skyC3
	mh41IrbXEHMEhXLQVmuSyPwvtnrBBQEh3e9NlOXPU99cCxsiNM5dS7qlHWsKBaYKP2108d6Fl+5
	j9F44bOlRiryxMLQY2X4uqf/jsghjhvPePlj0Tk3Cd6t1VqGWt9S7O+wJtk4KM+8tAJSoZbWlPU
	gqmlQ+eKZGuYHvmaRa29qYWnCLg2iYvhNp24FlQL9QRl3G5yoWnjqocvrWgcr3QyIbW6alE8mDL
	kRN+zSmADKu210YnsaSHBCgAel++DAOgOD88Zs9lPr+P/3CdlRupWS0crgIeE0Cw4dncE5R9U=
X-Received: by 2002:a05:7300:a287:b0:2c5:3b87:2ffc with SMTP id 5a478bee46e88-2c930b800a4mr3553697eec.7.1775120566844;
        Thu, 02 Apr 2026 02:02:46 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21cf::147f? ([2620:10d:c090:400::5:9571])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf126c9sm1959194eec.27.2026.04.02.02.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:02:46 -0700 (PDT)
Message-ID: <bf9f7c6f-8759-4f4f-8e35-2bd7c446d102@gmail.com>
Date: Thu, 2 Apr 2026 02:02:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 net-next 02/11] net/nebula-matrix: add our driver
 architecture
To: "illusion.wang" <illusion.wang@nebula-matrix.com>,
 dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, kuba@kernel.org,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, jani.nikula@intel.com,
 open list <linux-kernel@vger.kernel.org>
References: <20260401022318.28550-1-illusion.wang@nebula-matrix.com>
 <20260401022318.28550-3-illusion.wang@nebula-matrix.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260401022318.28550-3-illusion.wang@nebula-matrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org,intel.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url,nebula-matrix.com:email]
X-Rspamd-Queue-Id: 33D6738676A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/31/26 7:23 PM, illusion.wang wrote:
> our driver architecture:
> Hardware (HW), Channel, Resource, Dispatch, and Device Layer
> Struct Initialization/Deinitialization, and Operation Set Registration/
> Unregistration
> 
> Our driver architecture is relatively complex because the code is highly
> reusable and designed to support multiple features. Additionally, the
> codebase supports multiple chip variants, each with distinct
> hardware-software interactions.
> To ensure compatibility, our architecture is divided into the following
> layers:
> 
> 1. Dev Layer (Device Layer)
> The top-level business logic layer where all operations are
> device-centric. Every operation is performed relative to the device
> context. The intergration of base functions encompasses:
> management(ctrl only for leonis pf0), network(net_dev,this time not
> contained),common.
> 
> 2. Dispatch Layer
> The distribution from services to specific data operations is mainly
> divided into two types: direct pass-through and handling by the
> management PF. It shields the upper layer from the differences in
> specific underlying locations.
> It describes the processing locations and paths of the services.
> 
> 3. Resource Layer
> Handles tasks dispatched from Dispatch Layer. These tasks fall into two
> categories:
> 3.1 Hardware control
> The Resource Layer further invokes the HW Layer when hardware access is
> needed, as only the HW Layer has OS-level privileges.
> 3.2 Software resource management
> Operations like packet statistics collection that don't require hardware
> access.
> 
> 4. HW Layer (Hardware Layer)
> Serves the Resource Layer by interacting with different hardware
> chipsets.Writes to hardware registers to drive the hardware based on
> Resource Layer directives.
> 
> 5. Channel Layer
> 
> Handle communication between PF0(has ctrl func) and other PF,and provide
> basic interaction channels.
> 
> 6. Common Layer
> Provides fundamental services
> 
> Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
> ---
>   .../net/ethernet/nebula-matrix/nbl/Makefile   |   7 +-
>   .../nbl/nbl_channel/nbl_channel.c             |  82 ++++++++
>   .../nbl/nbl_channel/nbl_channel.h             |  29 +++
>   .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  43 +++++
>   .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  56 ++++++
>   .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  27 +++
>   .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  75 ++++++++
>   .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  25 +++
>   .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 140 ++++++++++++++
>   .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  14 ++
>   .../nbl_hw_leonis/nbl_resource_leonis.c       |  83 ++++++++
>   .../nbl_hw_leonis/nbl_resource_leonis.h       |  10 +
>   .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  68 +++++++
>   .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  30 +++
>   .../nbl/nbl_include/nbl_def_channel.h         |  26 +++
>   .../nbl/nbl_include/nbl_def_common.h          |  35 ++++
>   .../nbl/nbl_include/nbl_def_dev.h             |  16 ++
>   .../nbl/nbl_include/nbl_def_dispatch.h        |  29 +++
>   .../nbl/nbl_include/nbl_def_hw.h              |  22 +++
>   .../nbl/nbl_include/nbl_def_resource.h        |  20 ++
>   .../nbl/nbl_include/nbl_include.h             |  11 ++
>   .../nbl/nbl_include/nbl_product_base.h        |  18 ++
>   .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 179 ++++++++++++++++++
>   23 files changed, 1044 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
>   create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
> 
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> index b90fba239401..271605920396 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
> @@ -3,4 +3,9 @@
>   
>   obj-$(CONFIG_NBL) := nbl.o
>   
> -nbl-objs +=      nbl_main.o
> +nbl-objs +=       nbl_channel/nbl_channel.o \
> +				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
> +				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
> +				nbl_core/nbl_dispatch.o \
> +				nbl_core/nbl_dev.o \
> +				nbl_main.o
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> new file mode 100644
> index 000000000000..9f4603870cb4
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include "nbl_channel.h"
> +
> +static struct nbl_channel_ops chan_ops = {
> +};
> +
> +static struct nbl_channel_mgt *
> +nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter)
> +{
> +	struct nbl_hw_ops_tbl *hw_ops_tbl = adapter->intf.hw_ops_tbl;
> +	struct nbl_common_info *common = &adapter->common;
> +	struct device *dev = &adapter->pdev->dev;
> +	struct nbl_chan_info *mailbox;
> +	struct nbl_channel_mgt *chan_mgt;

Reverse xmas violation here

> +
> +	chan_mgt = devm_kzalloc(dev, sizeof(*chan_mgt), GFP_KERNEL);
> +	if (!chan_mgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	chan_mgt->common = common;
> +	chan_mgt->hw_ops_tbl = hw_ops_tbl;
> +
> +	mailbox = devm_kzalloc(dev, sizeof(*mailbox), GFP_KERNEL);
> +	if (!mailbox)
> +		return ERR_PTR(-ENOMEM);

Here, if mailbox allocation fails, we return without freeing chan_mgt 
resulting in a leak.

> +	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
> +	chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX] = mailbox;
> +
> +	return chan_mgt;
> +}
> +
> +static struct nbl_channel_ops_tbl *
> +nbl_chan_setup_ops(struct device *dev, struct nbl_channel_mgt *chan_mgt)
> +{
> +	struct nbl_channel_ops_tbl *chan_ops_tbl;
> +
> +	chan_ops_tbl = devm_kzalloc(dev, sizeof(*chan_ops_tbl), GFP_KERNEL);
> +	if (!chan_ops_tbl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	chan_ops_tbl->ops = &chan_ops;
> +	chan_ops_tbl->priv = chan_mgt;
> +
> +	return chan_ops_tbl;
> +}
> +
> +int nbl_chan_init_common(struct nbl_adapter *adap)
> +{
> +	struct nbl_channel_ops_tbl *chan_ops_tbl;
> +	struct device *dev = &adap->pdev->dev;
> +	struct nbl_channel_mgt *chan_mgt;
> +	int ret;
> +
> +	chan_mgt = nbl_chan_setup_chan_mgt(adap);
> +	if (IS_ERR(chan_mgt)) {
> +		ret = PTR_ERR(chan_mgt);
> +		goto setup_mgt_fail;
> +	}
> +	adap->core.chan_mgt = chan_mgt;
> +
> +	chan_ops_tbl = nbl_chan_setup_ops(dev, chan_mgt);
> +	if (IS_ERR(chan_ops_tbl)) {
> +		ret = PTR_ERR(chan_ops_tbl);
> +		goto setup_ops_fail;
> +	}
> +	adap->intf.channel_ops_tbl = chan_ops_tbl;
> +	return 0;
> +
> +setup_ops_fail:
> +setup_mgt_fail:
> +	return ret;
> +}

Why do we need two labels here? Looks like some piece of code will use 
two different clean-up paths in the later patches. Better to add related 
label then?

> +
> +void nbl_chan_remove_common(struct nbl_adapter *adap)
> +{
> +}
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> new file mode 100644
> index 000000000000..637912d1e806
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_CHANNEL_H_
> +#define _NBL_CHANNEL_H_
> +
> +#include <linux/types.h>
> +
> +#include "../nbl_include/nbl_include.h"
> +#include "../nbl_include/nbl_product_base.h"
> +#include "../nbl_include/nbl_def_channel.h"
> +#include "../nbl_include/nbl_def_hw.h"
> +#include "../nbl_include/nbl_def_common.h"
> +#include "../nbl_core.h"
> +
> +struct nbl_chan_info {
> +	u8 chan_type;
> +};
> +
> +struct nbl_channel_mgt {
> +	struct nbl_common_info *common;
> +	struct nbl_hw_ops_tbl *hw_ops_tbl;
> +	struct nbl_chan_info *chan_info[NBL_CHAN_TYPE_MAX];
> +	struct nbl_hash_tbl_mgt *handle_hash_tbl;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> index c525114297b4..aa4d24d04e2c 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
> @@ -6,6 +6,20 @@
>   #ifndef _NBL_CORE_H_
>   #define _NBL_CORE_H_
>   
> +#include <linux/pci.h>
> +#include "nbl_include/nbl_def_common.h"
> +#include "nbl_include/nbl_include.h"
> +
> +struct nbl_hw_mgt;
> +struct nbl_hw_ops_tbl;
> +struct nbl_resource_mgt;
> +struct nbl_resource_ops_tbl;
> +struct nbl_dispatch_mgt;
> +struct nbl_dispatch_ops_tbl;
> +struct nbl_channel_ops_tbl;
> +struct nbl_channel_mgt;
> +struct nbl_dev_mgt;
> +
>   enum {
>   	NBL_CAP_HAS_CTRL_BIT,
>   	NBL_CAP_HAS_NET_BIT,
> @@ -13,4 +27,33 @@ enum {
>   	NBL_CAP_IS_LEONIS_BIT,
>   };
>   
> +struct nbl_interface {
> +	struct nbl_hw_ops_tbl *hw_ops_tbl;
> +	struct nbl_resource_ops_tbl *resource_ops_tbl;
> +	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
> +	struct nbl_channel_ops_tbl *channel_ops_tbl;
> +};
> +
> +struct nbl_core {
> +	struct nbl_hw_mgt *hw_mgt;
> +	struct nbl_resource_mgt *res_mgt;
> +	struct nbl_dispatch_mgt *disp_mgt;
> +	struct nbl_dev_mgt *dev_mgt;
> +	struct nbl_channel_mgt *chan_mgt;
> +};
> +
> +struct nbl_adapter {
> +	struct pci_dev *pdev;
> +	struct nbl_core core;
> +	struct nbl_interface intf;
> +	struct nbl_common_info common;
> +	struct nbl_product_base_ops *product_base_ops;
> +};
> +
> +struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
> +				  struct nbl_init_param *param);
> +void nbl_core_remove(struct nbl_adapter *adapter);
> +int nbl_core_start(struct nbl_adapter *adapter);
> +void nbl_core_stop(struct nbl_adapter *adapter);
> +
>   #endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> new file mode 100644
> index 000000000000..5deb21e35f8e
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include "nbl_dev.h"
> +
> +static struct nbl_dev_mgt *nbl_dev_setup_dev_mgt(struct nbl_common_info *common)
> +{
> +	struct nbl_dev_mgt *dev_mgt;
> +
> +	dev_mgt = devm_kzalloc(common->dev, sizeof(*dev_mgt), GFP_KERNEL);
> +	if (!dev_mgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev_mgt->common = common;
> +	return dev_mgt;
> +}
> +
> +int nbl_dev_init(struct nbl_adapter *adapter)
> +{
> +	struct nbl_common_info *common = &adapter->common;
> +	struct nbl_dispatch_ops_tbl *disp_ops_tbl =
> +		adapter->intf.dispatch_ops_tbl;
> +	struct nbl_channel_ops_tbl *chan_ops_tbl =
> +		adapter->intf.channel_ops_tbl;
> +	struct nbl_dev_mgt *dev_mgt;
> +	int ret;
> +
> +	dev_mgt = nbl_dev_setup_dev_mgt(common);
> +	if (IS_ERR(dev_mgt)) {
> +		ret = PTR_ERR(dev_mgt);
> +		return ret;
> +	}
> +
> +	dev_mgt->disp_ops_tbl = disp_ops_tbl;
> +	dev_mgt->chan_ops_tbl = chan_ops_tbl;
> +	adapter->core.dev_mgt = dev_mgt;
> +
> +	return 0;
> +}
> +
> +void nbl_dev_remove(struct nbl_adapter *adapter)
> +{
> +}
> +
> +/* ----------  Dev start process  ---------- */
> +int nbl_dev_start(struct nbl_adapter *adapter)
> +{
> +	return 0;
> +}
> +
> +void nbl_dev_stop(struct nbl_adapter *adapter)
> +{
> +}
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
> new file mode 100644
> index 000000000000..9b71092b99a0
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEV_H_
> +#define _NBL_DEV_H_
> +
> +#include <linux/types.h>
> +
> +#include "../nbl_include/nbl_include.h"
> +#include "../nbl_include/nbl_product_base.h"
> +#include "../nbl_include/nbl_def_channel.h"
> +#include "../nbl_include/nbl_def_hw.h"
> +#include "../nbl_include/nbl_def_resource.h"
> +#include "../nbl_include/nbl_def_dispatch.h"
> +#include "../nbl_include/nbl_def_dev.h"
> +#include "../nbl_include/nbl_def_common.h"
> +#include "../nbl_core.h"
> +
> +struct nbl_dev_mgt {
> +	struct nbl_common_info *common;
> +	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
> +	struct nbl_channel_ops_tbl *chan_ops_tbl;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> new file mode 100644
> index 000000000000..8b031f6e963f
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include "nbl_dispatch.h"
> +
> +static struct nbl_dispatch_mgt *
> +nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
> +{
> +	struct nbl_dispatch_mgt *disp_mgt;
> +	struct device *dev = common->dev;
> +
> +	disp_mgt = devm_kzalloc(dev, sizeof(*disp_mgt), GFP_KERNEL);
> +	if (!disp_mgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	disp_mgt->common = common;
> +	return disp_mgt;
> +}
> +
> +static struct nbl_dispatch_ops_tbl *
> +nbl_disp_setup_ops(struct device *dev, struct nbl_dispatch_mgt *disp_mgt)
> +{
> +	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
> +	struct nbl_dispatch_ops *disp_ops;
> +
> +	disp_ops_tbl = devm_kzalloc(dev, sizeof(*disp_ops_tbl), GFP_KERNEL);
> +	if (!disp_ops_tbl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	disp_ops =
> +		devm_kzalloc(dev, sizeof(*disp_ops), GFP_KERNEL);
> +	if (!disp_ops)
> +		return ERR_PTR(-ENOMEM);
> +
> +	disp_ops_tbl->ops = disp_ops;
> +	disp_ops_tbl->priv = disp_mgt;
> +
> +	return disp_ops_tbl;
> +}
> +
> +int nbl_disp_init(struct nbl_adapter *adapter)
> +{
> +	struct nbl_common_info *common = &adapter->common;
> +	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
> +	struct nbl_resource_ops_tbl *res_ops_tbl =
> +		adapter->intf.resource_ops_tbl;
> +	struct nbl_channel_ops_tbl *chan_ops_tbl =
> +		adapter->intf.channel_ops_tbl;
> +	struct device *dev = &adapter->pdev->dev;
> +	struct nbl_dispatch_mgt *disp_mgt;
> +	int ret;
> +
> +	disp_mgt = nbl_disp_setup_disp_mgt(common);
> +	if (IS_ERR(disp_mgt)) {
> +		ret = PTR_ERR(disp_mgt);
> +		return ret;
> +	}
> +
> +	disp_ops_tbl = nbl_disp_setup_ops(dev, disp_mgt);
> +	if (IS_ERR(disp_ops_tbl)) {
> +		ret = PTR_ERR(disp_ops_tbl);
> +		return ret;
> +	}
> +
> +	disp_mgt->res_ops_tbl = res_ops_tbl;
> +	disp_mgt->chan_ops_tbl = chan_ops_tbl;
> +	disp_mgt->disp_ops_tbl = disp_ops_tbl;
> +	adapter->core.disp_mgt = disp_mgt;
> +	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
> new file mode 100644
> index 000000000000..fa7f4597febe
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DISPATCH_H_
> +#define _NBL_DISPATCH_H_
> +#include "../nbl_include/nbl_include.h"
> +#include "../nbl_include/nbl_product_base.h"
> +#include "../nbl_include/nbl_def_channel.h"
> +#include "../nbl_include/nbl_def_hw.h"
> +#include "../nbl_include/nbl_def_resource.h"
> +#include "../nbl_include/nbl_def_dispatch.h"
> +#include "../nbl_include/nbl_def_common.h"
> +#include "../nbl_core.h"
> +
> +struct nbl_dispatch_mgt {
> +	struct nbl_common_info *common;
> +	struct nbl_resource_ops_tbl *res_ops_tbl;
> +	struct nbl_channel_ops_tbl *chan_ops_tbl;
> +	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
> +	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> new file mode 100644
> index 000000000000..6dd8d3a087dd
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <linux/bits.h>
> +#include <linux/io.h>
> +#include <linux/spinlock.h>
> +#include "nbl_hw_leonis.h"
> +
> +static struct nbl_hw_ops hw_ops = {
> +};
> +
> +/* Structure starts here, adding an op should not modify anything below */
> +static struct nbl_hw_mgt *nbl_hw_setup_hw_mgt(struct nbl_common_info *common)
> +{
> +	struct device *dev = common->dev;
> +	struct nbl_hw_mgt *hw_mgt;
> +
> +	hw_mgt = devm_kzalloc(dev, sizeof(*hw_mgt), GFP_KERNEL);
> +	if (!hw_mgt)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hw_mgt->common = common;
> +
> +	return hw_mgt;
> +}
> +
> +static struct nbl_hw_ops_tbl *nbl_hw_setup_ops(struct nbl_common_info *common,
> +					       struct nbl_hw_mgt *hw_mgt)
> +{
> +	struct nbl_hw_ops_tbl *hw_ops_tbl;
> +	struct device *dev;
> +
> +	dev = common->dev;
> +	hw_ops_tbl =
> +		devm_kzalloc(dev, sizeof(*hw_ops_tbl), GFP_KERNEL);
> +	if (!hw_ops_tbl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	hw_ops_tbl->ops = &hw_ops;
> +	hw_ops_tbl->priv = hw_mgt;
> +
> +	return hw_ops_tbl;
> +}
> +
> +int nbl_hw_init_leonis(struct nbl_adapter *adapter)
> +{
> +	struct nbl_common_info *common = &adapter->common;
> +	struct pci_dev *pdev = common->pdev;
> +	struct nbl_hw_ops_tbl *hw_ops_tbl;
> +	struct nbl_hw_mgt *hw_mgt;
> +	int bar_mask;
> +	int ret;
> +
> +	hw_mgt = nbl_hw_setup_hw_mgt(common);
> +	if (IS_ERR(hw_mgt)) {
> +		ret = PTR_ERR(hw_mgt);
> +		goto setup_mgt_fail;
> +	}
> +	bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
> +	ret = pci_request_selected_regions(pdev, bar_mask, NBL_DRIVER_NAME);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Request memory bar and mailbox bar failed, err = %d\n",
> +			ret);
> +		goto request_bar_region_fail;
> +	}
> +
> +	if (common->has_ctrl) {
> +		hw_mgt->hw_addr =
> +			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
> +				pci_resource_len(pdev, NBL_MEMORY_BAR) -
> +					NBL_RDMA_NOTIFY_OFF);
> +		if (!hw_mgt->hw_addr) {
> +			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
> +			ret = -EIO;
> +			goto ioremap_err;
> +		}
> +		hw_mgt->hw_size = pci_resource_len(pdev, NBL_MEMORY_BAR) -
> +				  NBL_RDMA_NOTIFY_OFF;
> +	} else {
> +		hw_mgt->hw_addr =
> +			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
> +				NBL_RDMA_NOTIFY_OFF);
> +		if (!hw_mgt->hw_addr) {
> +			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
> +			ret = -EIO;
> +			goto ioremap_err;
> +		}
> +		hw_mgt->hw_size = NBL_RDMA_NOTIFY_OFF;
> +	}
> +
> +	hw_mgt->notify_offset = 0;
> +	hw_mgt->mailbox_bar_hw_addr = pci_ioremap_bar(pdev, NBL_MAILBOX_BAR);
> +	if (!hw_mgt->mailbox_bar_hw_addr) {
> +		dev_err(&pdev->dev, "Mailbox bar ioremap failed\n");
> +		ret = -EIO;
> +		goto mailbox_ioremap_err;
> +	}
> +
> +	spin_lock_init(&hw_mgt->reg_lock);
> +	adapter->core.hw_mgt = hw_mgt;
> +
> +	hw_ops_tbl = nbl_hw_setup_ops(common, hw_mgt);
> +	if (IS_ERR(hw_ops_tbl)) {
> +		ret = PTR_ERR(hw_ops_tbl);
> +		goto setup_ops_fail;
> +	}
> +	adapter->intf.hw_ops_tbl = hw_ops_tbl;
> +
> +	return 0;
> +
> +setup_ops_fail:
> +	iounmap(hw_mgt->mailbox_bar_hw_addr);
> +mailbox_ioremap_err:
> +	iounmap(hw_mgt->hw_addr);
> +ioremap_err:
> +	pci_release_selected_regions(pdev, bar_mask);
> +request_bar_region_fail:
> +setup_mgt_fail:
> +	return ret;
> +}
> +
> +void nbl_hw_remove_leonis(struct nbl_adapter *adapter)
> +{
> +	int bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
> +	struct nbl_common_info *common = &adapter->common;
> +	struct nbl_hw_mgt *hw_mgt = adapter->core.hw_mgt;
> +	u8 __iomem *hw_addr = hw_mgt->hw_addr;
> +	struct pci_dev *pdev = common->pdev;
> +	u8 __iomem *mailbox_bar_hw_addr;
> +
> +	mailbox_bar_hw_addr = hw_mgt->mailbox_bar_hw_addr;
> +
> +	iounmap(mailbox_bar_hw_addr);
> +	iounmap(hw_addr);
> +	pci_release_selected_regions(pdev, bar_mask);
> +}
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> new file mode 100644
> index 000000000000..77c67b67ba31
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_HW_LEONIS_H_
> +#define _NBL_HW_LEONIS_H_
> +
> +#include <linux/types.h>
> +
> +#include "../../nbl_include/nbl_include.h"
> +#include "../nbl_hw_reg.h"
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> new file mode 100644
> index 000000000000..355f7ea66b88
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include "nbl_resource_leonis.h"
> +
> +static struct nbl_resource_ops res_ops = {
> +};
> +
> +static struct nbl_resource_mgt *
> +nbl_res_setup_res_mgt(struct nbl_common_info *common)
> +{
> +	struct nbl_resource_info *resource_info;
> +	struct nbl_resource_mgt *res_mgt;
> +	struct device *dev = common->dev;
> +
> +	res_mgt = devm_kzalloc(dev, sizeof(*res_mgt), GFP_KERNEL);
> +	if (!res_mgt)
> +		return ERR_PTR(-ENOMEM);
> +	res_mgt->common = common;
> +
> +	resource_info =
> +		devm_kzalloc(dev, sizeof(*resource_info), GFP_KERNEL);
> +	if (!resource_info)
> +		return ERR_PTR(-ENOMEM);
> +	res_mgt->resource_info = resource_info;
> +
> +	return res_mgt;
> +}
> +
> +static struct nbl_resource_ops_tbl *
> +nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
> +{
> +	struct nbl_resource_ops_tbl *res_ops_tbl;
> +
> +	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
> +	if (!res_ops_tbl)
> +		return ERR_PTR(-ENOMEM);
> +
> +	res_ops_tbl->ops = &res_ops;
> +	res_ops_tbl->priv = res_mgt;
> +
> +	return res_ops_tbl;
> +}
> +
> +static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
> +{
> +	return 0;
> +}
> +
> +int nbl_res_init_leonis(struct nbl_adapter *adap)
> +{
> +	struct nbl_channel_ops_tbl *chan_ops_tbl = adap->intf.channel_ops_tbl;
> +	struct nbl_hw_ops_tbl *hw_ops_tbl = adap->intf.hw_ops_tbl;
> +	struct nbl_common_info *common = &adap->common;
> +	struct nbl_resource_ops_tbl *res_ops_tbl;
> +	struct device *dev = &adap->pdev->dev;
> +	struct nbl_resource_mgt *res_mgt;
> +	int ret;
> +
> +	res_mgt = nbl_res_setup_res_mgt(common);
> +	if (IS_ERR(res_mgt)) {
> +		ret = PTR_ERR(res_mgt);
> +		return ret;
> +	}
> +	res_mgt->chan_ops_tbl = chan_ops_tbl;
> +	res_mgt->hw_ops_tbl = hw_ops_tbl;
> +
> +	ret = nbl_res_start(res_mgt);
> +	if (ret)
> +		return ret;
> +	adap->core.res_mgt = res_mgt;
> +
> +	res_ops_tbl = nbl_res_setup_ops(dev, res_mgt);
> +	if (IS_ERR(res_ops_tbl)) {
> +		ret = PTR_ERR(res_ops_tbl);
> +		return ret;
> +	}
> +	adap->intf.resource_ops_tbl = res_ops_tbl;
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
> new file mode 100644
> index 000000000000..4e61a5c141e5
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_RESOURCE_LEONIS_H_
> +#define _NBL_RESOURCE_LEONIS_H_
> +
> +#include "../nbl_resource.h"
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
> new file mode 100644
> index 000000000000..46e58b4e73dc
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_HW_REG_H_
> +#define _NBL_HW_REG_H_
> +
> +#include <linux/types.h>
> +
> +#include "../nbl_include/nbl_product_base.h"
> +#include "../nbl_include/nbl_def_channel.h"
> +#include "../nbl_include/nbl_def_hw.h"
> +#include "../nbl_include/nbl_def_common.h"
> +#include "../nbl_core.h"
> +
> +#define NBL_MEMORY_BAR				0
> +#define NBL_MAILBOX_BAR				2
> +#define NBL_RDMA_NOTIFY_OFF			8192
> +#define NBL_HW_DUMMY_REG			0x1300904
> +
> +struct nbl_hw_mgt {
> +	struct nbl_common_info *common;
> +	u8 __iomem *hw_addr;
> +	u8 __iomem *mailbox_bar_hw_addr;
> +	u64 notify_offset;
> +	u32 version;
> +	u32 hw_size;
> +	spinlock_t reg_lock; /* Protect reg access */
> +};
> +
> +static inline u32 rd32(u8 __iomem *addr, u64 reg)
> +{
> +	return readl(addr + reg);
> +}
> +
> +static inline void wr32(u8 __iomem *addr, u64 reg, u32 value)
> +{
> +	writel(value, addr + reg);
> +}
> +
> +static inline void nbl_hw_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
> +{
> +	/* Used for emu, make sure that we won't write too frequently */
> +	wr32(hw_mgt->hw_addr, reg, value);
> +}
> +
> +static inline u32 nbl_hw_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
> +{
> +	return rd32(hw_mgt->hw_addr, reg);
> +}
> +
> +static inline void nbl_mbx_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
> +{
> +	writel(value, hw_mgt->mailbox_bar_hw_addr + reg);
> +}
> +
> +static inline void nbl_flush_writes(struct nbl_hw_mgt *hw_mgt)
> +{
> +	nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
> +}
> +
> +static inline u32 nbl_mbx_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
> +{
> +	return readl(hw_mgt->mailbox_bar_hw_addr + reg);
> +}
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> new file mode 100644
> index 000000000000..e08b6237da32
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_RESOURCE_H_
> +#define _NBL_RESOURCE_H_
> +
> +#include <linux/types.h>
> +
> +#include "../nbl_include/nbl_include.h"
> +#include "../nbl_include/nbl_product_base.h"
> +#include "../nbl_include/nbl_def_channel.h"
> +#include "../nbl_include/nbl_def_hw.h"
> +#include "../nbl_include/nbl_def_resource.h"
> +#include "../nbl_include/nbl_def_common.h"
> +#include "../nbl_core.h"
> +
> +struct nbl_resource_info {
> +};
> +
> +struct nbl_resource_mgt {
> +	struct nbl_common_info *common;
> +	struct nbl_resource_info *resource_info;
> +	struct nbl_channel_ops_tbl *chan_ops_tbl;
> +	struct nbl_hw_ops_tbl *hw_ops_tbl;
> +	struct nbl_interrupt_mgt *intr_mgt;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> new file mode 100644
> index 000000000000..ff03a53b9f5d
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEF_CHANNEL_H_
> +#define _NBL_DEF_CHANNEL_H_
> +
> +struct nbl_channel_mgt;
> +struct nbl_adapter;
> +enum nbl_channel_type {
> +	NBL_CHAN_TYPE_MAILBOX,
> +	NBL_CHAN_TYPE_MAX
> +};
> +
> +struct nbl_channel_ops {
> +};
> +
> +struct nbl_channel_ops_tbl {
> +	struct nbl_channel_ops *ops;
> +	struct nbl_channel_mgt *priv;
> +};
> +
> +int nbl_chan_init_common(struct nbl_adapter *adapter);
> +void nbl_chan_remove_common(struct nbl_adapter *adapter);
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
> new file mode 100644
> index 000000000000..cc73d6a91f3c
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEF_COMMON_H_
> +#define _NBL_DEF_COMMON_H_
> +
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/device.h>
> +#include "nbl_include.h"
> +
> +struct nbl_common_info {
> +	struct pci_dev *pdev;
> +	struct device *dev;
> +	u32 msg_enable;
> +	u16 vsi_id;
> +	u8 eth_id;
> +	u8 logic_eth_id;
> +	u8 eth_mode;
> +
> +	u8 function;
> +	u8 devid;
> +	u8 bus;
> +	u8 hw_bus;
> +	u16 mgt_pf;
> +
> +	bool pci_using_dac;
> +	enum nbl_product_type product_type;
> +	u8 has_ctrl;
> +	u8 has_net;
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
> new file mode 100644
> index 000000000000..32e6cce38d39
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEF_DEV_H_
> +#define _NBL_DEF_DEV_H_
> +
> +struct nbl_adapter;
> +
> +int nbl_dev_init(struct nbl_adapter *adapter);
> +void nbl_dev_remove(struct nbl_adapter *adapter);
> +int nbl_dev_start(struct nbl_adapter *adapter);
> +void nbl_dev_stop(struct nbl_adapter *adapter);
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> new file mode 100644
> index 000000000000..2230c728079e
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEF_DISPATCH_H_
> +#define _NBL_DEF_DISPATCH_H_
> +
> +struct nbl_dispatch_mgt;
> +struct nbl_adapter;
> +enum {
> +	NBL_DISP_CTRL_LVL_NEVER = 0,
> +	NBL_DISP_CTRL_LVL_MGT,
> +	NBL_DISP_CTRL_LVL_NET,
> +	NBL_DISP_CTRL_LVL_ALWAYS,
> +	NBL_DISP_CTRL_LVL_MAX,
> +};
> +
> +struct nbl_dispatch_ops {
> +};
> +
> +struct nbl_dispatch_ops_tbl {
> +	struct nbl_dispatch_ops *ops;
> +	struct nbl_dispatch_mgt *priv;
> +};
> +
> +int nbl_disp_init(struct nbl_adapter *adapter);
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> new file mode 100644
> index 000000000000..168504b30973
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEF_HW_H_
> +#define _NBL_DEF_HW_H_
> +
> +struct nbl_hw_mgt;
> +struct nbl_adapter;
> +struct nbl_hw_ops {
> +};
> +
> +struct nbl_hw_ops_tbl {
> +	struct nbl_hw_ops *ops;
> +	struct nbl_hw_mgt *priv;
> +};
> +
> +int nbl_hw_init_leonis(struct nbl_adapter *adapter);
> +void nbl_hw_remove_leonis(struct nbl_adapter *adapter);
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
> new file mode 100644
> index 000000000000..16add7e25eae
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEF_RESOURCE_H_
> +#define _NBL_DEF_RESOURCE_H_
> +
> +struct nbl_resource_mgt;
> +struct nbl_adapter;
> +struct nbl_resource_ops {
> +};
> +
> +struct nbl_resource_ops_tbl {
> +	struct nbl_resource_ops *ops;
> +	struct nbl_resource_mgt *priv;
> +};
> +
> +int nbl_res_init_leonis(struct nbl_adapter *adapter);
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> index 1046e6517b15..50f30f756bf3 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
> @@ -11,6 +11,11 @@
>   /*  ------  Basic definitions  -------  */
>   #define NBL_DRIVER_NAME					"nbl"
>   
> +enum nbl_product_type {
> +	NBL_LEONIS_TYPE,
> +	NBL_PRODUCT_MAX,
> +};
> +
>   struct nbl_func_caps {
>   	u32 has_ctrl:1;
>   	u32 has_net:1;
> @@ -18,4 +23,10 @@ struct nbl_func_caps {
>   	u32 rsv:29;
>   };
>   
> +struct nbl_init_param {
> +	struct nbl_func_caps caps;
> +	enum nbl_product_type product_type;
> +	bool pci_using_dac;
> +};
> +
>   #endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
> new file mode 100644
> index 000000000000..4368d4f57a03
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2025 Nebula Matrix Limited.
> + */
> +
> +#ifndef _NBL_DEF_PRODUCT_BASE_H_
> +#define _NBL_DEF_PRODUCT_BASE_H_
> +
> +struct nbl_adapter;
> +struct nbl_product_base_ops {
> +	int (*hw_init)(struct nbl_adapter *p);
> +	void (*hw_remove)(struct nbl_adapter *p);
> +	int (*res_init)(struct nbl_adapter *p);
> +	int (*chan_init)(struct nbl_adapter *p);
> +	void (*chan_remove)(struct nbl_adapter *p);
> +};
> +
> +#endif
> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 10c3536b327b..db035136e09c 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -6,17 +6,196 @@
>   #include <linux/device.h>
>   #include <linux/pci.h>
>   #include <linux/module.h>
> +#include <linux/bits.h>
>   #include "nbl_include/nbl_include.h"
> +#include "nbl_include/nbl_product_base.h"
> +#include "nbl_include/nbl_def_channel.h"
> +#include "nbl_include/nbl_def_hw.h"
> +#include "nbl_include/nbl_def_resource.h"
> +#include "nbl_include/nbl_def_dispatch.h"
> +#include "nbl_include/nbl_def_dev.h"
> +#include "nbl_include/nbl_def_common.h"
>   #include "nbl_core.h"
>   
> +static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
> +	{
> +		.hw_init	= nbl_hw_init_leonis,
> +		.hw_remove	= nbl_hw_remove_leonis,
> +		.res_init	= nbl_res_init_leonis,
> +		.chan_init	= nbl_chan_init_common,
> +		.chan_remove	= nbl_chan_remove_common,
> +	},
> +};
> +
> +int nbl_core_start(struct nbl_adapter *adapter)
> +{
> +	return nbl_dev_start(adapter);
> +}
> +
> +void nbl_core_stop(struct nbl_adapter *adapter)
> +{
> +	nbl_dev_stop(adapter);
> +}
> +
> +static struct nbl_product_base_ops *
> +nbl_core_setup_product_ops(struct nbl_adapter *adapter,
> +			   struct nbl_init_param *param)
> +{
> +	adapter->product_base_ops = &nbl_product_base_ops[param->product_type];
> +	return adapter->product_base_ops;
> +}
> +
> +struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
> +				  struct nbl_init_param *param)
> +{
> +	struct nbl_product_base_ops *product_base_ops;
> +	struct nbl_common_info *common;
> +	struct nbl_adapter *adapter;
> +	int ret;
> +
> +	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
> +	if (!adapter)
> +		return NULL;
> +
> +	adapter->pdev = pdev;
> +	common = &adapter->common;
> +
> +	common->pdev = pdev;
> +	common->dev = &pdev->dev;
> +	common->has_ctrl = param->caps.has_ctrl;
> +	common->has_net = param->caps.has_net;
> +	common->pci_using_dac = param->pci_using_dac;
> +	common->function = PCI_FUNC(pdev->devfn);
> +	common->devid = PCI_SLOT(pdev->devfn);
> +	common->bus = pdev->bus->number;
> +	common->product_type = param->product_type;
> +
> +	product_base_ops = nbl_core_setup_product_ops(adapter, param);
> +
> +	/*
> +	 *every product's hw/chan/res layer has a great difference,
> +	 *so call their own init ops
> +	 */
> +	ret = product_base_ops->hw_init(adapter);
> +	if (ret)
> +		goto hw_init_fail;
> +
> +	ret = product_base_ops->chan_init(adapter);
> +	if (ret)
> +		goto chan_init_fail;
> +
> +	ret = product_base_ops->res_init(adapter);
> +	if (ret)
> +		goto res_init_fail;
> +
> +	ret = nbl_disp_init(adapter);
> +	if (ret)
> +		goto res_init_fail;
> +
> +	ret = nbl_dev_init(adapter);
> +	if (ret)
> +		goto res_init_fail;
> +	return adapter;
> +

All the potential failures after res_init() do not need any other cleanup?

> +res_init_fail:
> +	product_base_ops->chan_remove(adapter);
> +chan_init_fail:
> +	product_base_ops->hw_remove(adapter);
> +hw_init_fail:
> +	return NULL;
> +}
> +
> +void nbl_core_remove(struct nbl_adapter *adapter)
> +{
> +	struct nbl_product_base_ops *product_base_ops;
> +
> +	product_base_ops = adapter->product_base_ops;
> +	nbl_dev_remove(adapter);
> +	product_base_ops->chan_remove(adapter);
> +	product_base_ops->hw_remove(adapter);
> +}
> +
> +static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
> +			       struct nbl_init_param *param)
> +{
> +	param->caps.has_ctrl = !!(driver_data & BIT(NBL_CAP_HAS_CTRL_BIT));
> +	param->caps.has_net = !!(driver_data & BIT(NBL_CAP_HAS_NET_BIT));
> +	param->caps.is_nic = !!(driver_data & BIT(NBL_CAP_IS_NIC_BIT));
> +
> +	if (!!(driver_data & BIT(NBL_CAP_IS_LEONIS_BIT)))
> +		param->product_type = NBL_LEONIS_TYPE;
> +
> +	/*
> +	 * Leonis only PF0 has ctrl capability, but PF0's pcie device_id
> +	 * is same with other PF.So handle it special.
> +	 */
> +	if (param->product_type == NBL_LEONIS_TYPE &&
> +	    (PCI_FUNC(pdev->devfn) == 0))
> +		param->caps.has_ctrl = 1;
> +}
> +
>   static int nbl_probe(struct pci_dev *pdev,
>   		     const struct pci_device_id *id)
>   {
> +	struct nbl_init_param param = { { 0 } };
> +	struct device *dev = &pdev->dev;
> +	struct nbl_adapter *adapter;
> +	int err;
> +
> +	if (pci_enable_device(pdev)) {
> +		dev_err(&pdev->dev, "Failed to enable PCI device\n");
> +		return -ENODEV;
> +	}
> +
> +	param.pci_using_dac = true;
> +	nbl_get_func_param(pdev, id->driver_data, &param);
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_dbg(dev, "Configure DMA 64 bit mask failed, err = %d\n",
> +			err);
> +		param.pci_using_dac = false;
> +		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +		if (err) {
> +			dev_err(dev,
> +				"Configure DMA 32 bit mask failed, err = %d\n",
> +				err);
> +			goto configure_dma_err;
> +		}
> +	}
> +	pci_set_master(pdev);
> +	pci_save_state(pdev);
> +	adapter = nbl_core_init(pdev, &param);
> +	if (!adapter) {
> +		dev_err(dev, "Nbl adapter init fail\n");
> +		err = -ENOMEM;
> +		goto adapter_init_err;
> +	}
> +	pci_set_drvdata(pdev, adapter);
> +	err = nbl_core_start(adapter);
> +	if (err)
> +		goto core_start_err;
>   	return 0;
> +core_start_err:
> +	nbl_core_remove(adapter);
> +adapter_init_err:
> +	pci_clear_master(pdev);
> +configure_dma_err:
> +	pci_disable_device(pdev);
> +	return err;
>   }
>   
>   static void nbl_remove(struct pci_dev *pdev)
>   {
> +	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	pci_disable_sriov(pdev);
> +
> +	nbl_core_stop(adapter);
> +	nbl_core_remove(adapter);
> +
> +	pci_clear_master(pdev);
> +	pci_disable_device(pdev);
>   }
>   
>   /*

