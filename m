Return-Path: <netdev+bounces-158174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBA9A10CA0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F6B1889B1F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C05B1B21AD;
	Tue, 14 Jan 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="uCA7NPIO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D45C17CA12
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873172; cv=none; b=SVn0TM46dvIcCA7QMEI5Xumw58iPWciwdPoZv+DcPDzhC+P87sn7GjTsnBM4ZvpBD82jBB2U/3MV5nIFRToF7BYZUR+6xYJ7IwaPDfcxIabTKS9ZOwkret6R53ON0bwarvnpYEt6mZTjxS5jax/LhGgUkiSukl1EH47eFTlp4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873172; c=relaxed/simple;
	bh=FeGRHC4opBjeYP+NykQJ9KuRA1EzhXTFeXezxUccur4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq1ntuQxNeoWpO5XQg6TwJfTQxEStg27FScz32/OCtOXordyrJVbF8csv3PZjjfGCLewRCTYewBsuZJDZ9kx/3WUa4J+I8MnbZhHEoSLHh4TBYTheVZPamyAVoLJ/TtUFQ2pcfhtoBPQDb2eUREPpHper6m7qNe7X6LuHCdDzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=uCA7NPIO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21669fd5c7cso104829005ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1736873169; x=1737477969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxWYotfxywN3NwGBQO3BiIkoRPcGTpIVsh2/TXME74Q=;
        b=uCA7NPIOcbXCFnA8+H16dcqnyoaP3hU3Ya+s4nJbEZLKwRAy0nKoWWaNYhC0/TIh57
         HPDOI71FtcZGwliRegj+fQBm6jhGRcQqKD8qFhIY3s7rJYexWE+a56cDrSTvc83Kkz5T
         k8hid0dHLR4WxNJ7IsredvG2eKsHqhJe+ltwLxfPNaZArLPvhoSNPDPDPeWKoU1eJZRW
         DIlXBC9e6J+OQ5Sk+bIS/YnUZcUcCsSb+WHdQe0Etrar8PaEFd6/Wx0UqUotf9YM1Ks8
         6eU9mVLUqjBdF1OeP8QsFwDIRCpbmWpcOxu5YXBDVcMaNR4XFO4kxr/kzvRkVvsXA/8B
         fvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736873169; x=1737477969;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxWYotfxywN3NwGBQO3BiIkoRPcGTpIVsh2/TXME74Q=;
        b=xC+kG/gKSm/CQ6Fo9MI0cu8Vtm+KdLjZdYAAK8VjbQb7MzKv8MGhEpzFOuIv1uiSeM
         7iqZ2BEQiuE+ekXdpYqHcc2yscexWDDnYC4YjH6DhEhfEV8L0rZ6DZablh2wuDbL7ftl
         x0zUsEjUtpxEKcW4xI9Kx6h489y6B6jmGSpxXMdfPvuKTXZK+kqmZBs8ctRX+Xg9hNya
         tvU4BcaPjWgp9TQOaBbO3CvKqsk7/1Ea1VeRIBc0CpcxfQz3WGOGkla9YtyJYCLM12ys
         hZKh+SslJtgN+OSOF8TsBhobv1Q6u5jbQgUc2jXvyBd1GC/uHiAziODdGS002QlhWTft
         OQDg==
X-Forwarded-Encrypted: i=1; AJvYcCVW3pYRmxp01yiqTKp9KTDmHB2ddpCnaa2K0mCVgXOCvYcA8ns3LPu+pSRdMkLmKUqjnHSNEFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx6ykDAb6h8SndJZwMuEXWSCCPJWb6+D6XX/y5vOCqr+fe/u8x
	Iv5fEc7tCkmPSCsoURnhCsFhbwUjIeUeBdQHh37fvn2Aae65URQesWIojqETc5E=
X-Gm-Gg: ASbGncsqTIb78gkVrE8sMCUmXzYzsTl3wQe6dmvglPuvl65R9pfCWIrtLBjLiK7PEw5
	5daojIjoPKwz5CxLUUDW9UPEwfOVtXC/Gi14+/dinIgSsKuX0ZMx2drKqygzA5CI4fIfRQ1LoDS
	ZEcCMM+hD2PpNc2+u7541jiEY92pB7hzCNj2I17fKtMXNFIZOuYkzE0jpZodkO7d+XvsEaizrfR
	C/KP8v/ky+O/xPmmXeKFIkhpUNKCr1lP/8/6lk0gAFolYlU8jGCeDa6v+bn
X-Google-Smtp-Source: AGHT+IFduq35RcsU3aO5RRhPDalwAW/p83/zhfkLttMULeNifRcViC7DtwI7vuIYT8rQlSliD0flaA==
X-Received: by 2002:aa7:8887:0:b0:72a:bb83:7804 with SMTP id d2e1a72fcca58-72d21fd2e16mr34122515b3a.17.1736873169522;
        Tue, 14 Jan 2025 08:46:09 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:4641:6dae:60a7:e5ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065a560sm7614353b3a.87.2025.01.14.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 08:46:08 -0800 (PST)
Date: Tue, 14 Jan 2025 10:46:01 -0600
From: Corey Minyard <corey@minyard.net>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] bindings: ipmi: Add binding for IPMB device intf
Message-ID: <Z4aUyX8g-JprzLpd@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250113194822.571884-1-ninad@linux.ibm.com>
 <20250113194822.571884-3-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113194822.571884-3-ninad@linux.ibm.com>

On Mon, Jan 13, 2025 at 01:48:12PM -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> new file mode 100644
> index 000000000000..136806cba632
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: The Intelligent Platform Management Bus(IPMB) Device
> +
> +description: |
> +  The IPMB is an I2C bus which provides interconnection between Baseboard

"Baseboard -> "a Baseboard"

> +  Management Controller(BMC) and chassis electronics. The BMC sends IPMI
> +  requests to intelligent controllers like Satellite Management Controller(MC)
> +  device via IPMB and the device sends a response back to the BMC.

device -> devices
"a response" -> responses

> +  This device binds backend Satelite MC which is a I2C slave device with the BMC

You use IPMB devices on both the BMC and the MCs.  The sentence above is
a little confusing, too.  How about:

This device uses an I2C slave device to send and receive IPMB messages,
either on a BMC or other MC.

> +  for management purpose. A miscalleneous device provices a user space program

Misspelling: miscellaneous

> +  to communicate with kernel and backend device. Some IPMB devices only support

"kernel" -> "the kernel"

> +  I2C protocol instead of SMB protocol.

the I2C protocol and not the SMB protocol.

Yes, the English language uses way too many articles...

That is a lot of detail, but it looks good beyond what I've commented
on.

> +
> +  IPMB communications protocol Specification V1.0
> +  https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmp-spec-v1.0.pdf
> +
> +maintainers:
> +  - Ninad Palsule <ninad@linux.ibm.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ipmb-dev
> +
> +  reg:
> +    maxItems: 1
> +
> +  i2c-protocol:
> +    description:
> +      Use I2C block transfer instead of SMBUS block transfer.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ipmb-dev@10 {
> +            compatible = "ipmb-dev";
> +            reg = <0x10>;

I'm not sure of the conventions around device tree here, but the reg is
not used in the driver and it will always be the I2C address that
already in that node just one level up.  It does not serve any purpose
that I can see.  My suggestion would be to remove it.

-corey

> +            i2c-protocol;
> +        };
> +    };
> -- 
> 2.43.0
> 

