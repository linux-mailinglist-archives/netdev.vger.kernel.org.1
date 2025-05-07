Return-Path: <netdev+bounces-188727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8011FAAE635
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62D316CC39
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1910728BABD;
	Wed,  7 May 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMVgn1VR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CEE28A706
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634426; cv=none; b=BpgDiXy0N5LfP0cPzMr7gH47foCEIrF+lDrYAs9ZiLaFTx5LeAgQdJ+9KZ97RR6fmlxHnnp8ZedObeLR+ne38ohJXRdxVScwgs7ZQSAeu68GSRJe395bUbtmm3E4rBemu0Brt4iDAVzHMOpw/gXj3EBvI1jTUzgCuafJlFo5ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634426; c=relaxed/simple;
	bh=2ilPNKF6f/rDkMNB2UoP20P3lHsdIGcLFDsA/AUjOXo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bl14RB2S6pyA0bcLbRhP+RGEDNiTnXKYxSH0AY5IIhgN0Vxj+qE7EFd9laWWkUNqyF1APpBFWwsq0utfrF9XfveTwrYw1pLQe1Qpe1ZiKe7uUwNB+qCe1ULXR6N8kJf/p9Fme4sa8wsgjkXU7XQSzt5BoHlhDrgNYxDQTcea1Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMVgn1VR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746634422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/Vr0zVbcT7BzCMh97BIa3Lqx/NCn2qxIyCi3f2m9aU=;
	b=JMVgn1VRARrvD2O5oQGD4PX2lVkWfYGIfOPWXuuGcXgbDvSp4Ufn2S6mkJc666fAhVPRlv
	K0B9/IWU1M/Goul5fKpaLaMr+U7mLNY/MTbUTstn2vS3LCHucLL0sPGm8oFH/5FZgVh3ZO
	YKfDpPUkxya/Ht9vlgtLsKx4SgJW+/0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-SXPiZFViOwKTJHjCPGb2vw-1; Wed,
 07 May 2025 12:13:36 -0400
X-MC-Unique: SXPiZFViOwKTJHjCPGb2vw-1
X-Mimecast-MFC-AGG-ID: SXPiZFViOwKTJHjCPGb2vw_1746634414
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE1B5195608B;
	Wed,  7 May 2025 16:13:33 +0000 (UTC)
Received: from [10.44.33.91] (unknown [10.44.33.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B246A30001A1;
	Wed,  7 May 2025 16:13:12 +0000 (UTC)
Message-ID: <2c41caf5-0579-42d8-8f7e-4a9b1a0baa48@redhat.com>
Date: Wed, 7 May 2025 18:13:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/8] Add Microchip ZL3073x support (part 1)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250507152504.85341-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20250507152504.85341-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 07. 05. 25 5:24 odp., Ivan Vecera wrote:
> Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> provides DPLL and PTP functionality. This series bring first part
> that adds the common MFD driver that provides an access to the bus
> that can be either I2C or SPI.
> 
> The next part of the series is bringing the DPLL driver that will
> covers DPLL functionality. Another series will bring PTP driver and
> flashing capability via devlink in the MFD driver will follow soon.
> 
> Testing was done by myself and by Prathosh Satish on Microchip EDS2
> development board with ZL30732 DPLL chip connected over I2C bus.
> 
> Patch breakdown
> ===============
> Patch 1 - Common DT schema for DPLL device and pin
> Patch 2 - DT bindings for microchip,zl3073* devices
> Patch 3 - Basic support for I2C, SPI and regmap configuration
> Patch 4 - Devlink device registration and info
> Patch 5 - Helpers for reading and writing register mailboxes
> Patch 6 - Fetch invariant register values used by DPLL/PTP sub-drivers
> Patch 7 - Clock ID generation for DPLL driver
> Patch 8 - Register/create DPLL device cells
> 
> ---
> v7->v8:
> * replaced zl3073x_pdata array ZL3073X_PDATA macro in patch 8
> v6->v7:
> * pass channel number using platform data instead of mfd_cell->id
> v5->v6:
> * fixed devlink info firmware version to be running instead of fixed
> * added documentation for devlink info versions
> v4->v5:
> * fixed DT patches description
> * dropped mailbox API
> * added type-safe register access functions
> * added an ability to protect multi-op accesses
> v3->v4:
> * fixed shortcomings in DT patches
> * completely reworked register access
> * removed a need to manage locking during mailbox accesses by callers
> * regcache switched to maple
> * dev_err_probe() in probe path
> * static mfd cells during sub-devices registration
> v1->v3:
> * dropped macros for generating register access functions
> * register access functions are provided in <linux/mfd/zl3073x_regs.h>
> * fixed DT descriptions and compatible wildcard usage
> * reworked regmap locking
>    - regmap uses implicit locking
>    - mailbox registers are additionally protected by extra mutex
> * fixed regmap virtual address range
> * added regmap rbtree cache (only for page selector now)
> * dropped patches for exporting strnchrnul and for supporting mfg file
>    this will be maybe added later
> 
> Ivan Vecera (8):
>    dt-bindings: dpll: Add DPLL device and pin
>    dt-bindings: dpll: Add support for Microchip Azurite chip family
>    mfd: Add Microchip ZL3073x support
>    mfd: zl3073x: Add support for devlink device info
>    mfd: zl3073x: Protect operations requiring multiple register accesses
>    mfd: zl3073x: Fetch invariants during probe
>    mfd: zl3073x: Add clock_id field
>    mfd: zl3073x: Register DPLL sub-device during init
> 
>   .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
>   .../devicetree/bindings/dpll/dpll-pin.yaml    |  45 +
>   .../bindings/dpll/microchip,zl30731.yaml      | 115 +++
>   Documentation/networking/devlink/index.rst    |   1 +
>   Documentation/networking/devlink/zl3073x.rst  |  37 +
>   MAINTAINERS                                   |  11 +
>   drivers/mfd/Kconfig                           |  32 +
>   drivers/mfd/Makefile                          |   5 +
>   drivers/mfd/zl3073x-core.c                    | 872 ++++++++++++++++++
>   drivers/mfd/zl3073x-i2c.c                     |  68 ++
>   drivers/mfd/zl3073x-regs.h                    |  54 ++
>   drivers/mfd/zl3073x-spi.c                     |  68 ++
>   drivers/mfd/zl3073x.h                         |  31 +
>   include/linux/mfd/zl3073x-regs.h              |  88 ++
>   include/linux/mfd/zl3073x.h                   | 202 ++++
>   15 files changed, 1705 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
>   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>   create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
>   create mode 100644 Documentation/networking/devlink/zl3073x.rst
>   create mode 100644 drivers/mfd/zl3073x-core.c
>   create mode 100644 drivers/mfd/zl3073x-i2c.c
>   create mode 100644 drivers/mfd/zl3073x-regs.h
>   create mode 100644 drivers/mfd/zl3073x-spi.c
>   create mode 100644 drivers/mfd/zl3073x.h
>   create mode 100644 include/linux/mfd/zl3073x-regs.h
>   create mode 100644 include/linux/mfd/zl3073x.h

I apologize for this quick update not respecting the 24 hour grace
period, I was not aware of such rule and otherwise I would not have been
able to send the v8 before Monday.

Ivan


