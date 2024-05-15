Return-Path: <netdev+bounces-96525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1598C64F7
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77543283F95
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BA75A11F;
	Wed, 15 May 2024 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EejJup9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E225FB87
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768985; cv=none; b=i2Ih43xozlUyga6ZAJOZt+OmIho4YJsXt312FnLMCGT2u6NgCOzUWdp0LLB5P9nL0/IpmcADzDPXDYxtyBe7SYXWkxFJWR7PU4RCC07bivMJvS9TIT96sv6h1XgAnQrgjVNawZ6c8IAW7uslKnFy2CA7GEG7kYZyyA5DL7dVDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768985; c=relaxed/simple;
	bh=rj28eTDzEICny43y6e3oMxikszWeWB/4UDA4a0mTl5k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MWkWJ9evxryCXYqE1v8rZJklK8updi1WATZ3h8q2FPijISWknuElhloAzyR7aVso4RWk3I55aMgT2XT/6GjtG9o8OVPghNqxGy4z14QddjfdZGyjYS573OwSHAeP/hItcJwUeT7nnE/5g/0M+YvyrbP4g4OfD2MADm3xXUdPnJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EejJup9G; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b299c3ff63so162602eaf.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715768983; x=1716373783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UvtjDEeMSsNWuEgiZU66lYfptCJM8gucEfi5L4lf9Y=;
        b=EejJup9G9cK0+iuSjI+vpl6CeeX80R9x3QbRgChjRBBegv+vHql2QH6siP5MyRPySl
         J7H69vy717yVUr6pAwEPBPfwmqNXeYCjlT9qwXrCo1uK+8QEn9MJjV8GBzSGq0DW0Nml
         0PiJwWjKYg2R2iRW9EpCmV//qUYB+bAqR+8znBtIFGi3zawiIS3BTgCBmeHdwEM8orrF
         f2WucYjEizKT3wnEynoCoRaDk2xpvvVov1kTFhlGbNkxUOaYRQoB3zsablG9CDSA2QOi
         aCxYLD/Z39R8QMVufSxnmMNzUE21rp3MKI9h3PsaVuvF5TCmybdeLrrFmoAKEIbpBrrK
         DKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715768983; x=1716373783;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6UvtjDEeMSsNWuEgiZU66lYfptCJM8gucEfi5L4lf9Y=;
        b=QpDIvQPms7Y+xFm7dCqeb6Hcv5oQvjtNWDHavDUAnnuQP9uRxLCtjwfgT5F8iD7GPY
         Mn4+28rSWBmDY24FqzmWzpA6wzKXrJE3krnOqQqPom9eOnraHJ16KXabB+Y4EUxs+t1W
         vPwppeGNS93YPPKqyd2wxLX3PLfLU9OGFTccZcYh2EmvYYc5wBoStszchjuzF4POhnZc
         WCqBqE2XR4QLaER8c5hF9wqQaKUQZRDYeosyoKNsdBsEnYnI+WNwoSYlkXhMWD0ymXuj
         BVqRYQ0GH/a82cmhDdMvesRaL4+z5FCelgmpw5JyA65KbkkGJ9PvZNPYoJW3VF6ylcUU
         9Y5g==
X-Forwarded-Encrypted: i=1; AJvYcCW3FVUyW59rmOAZzrWG/if8uTay7F5Y3wJ5Ci6f6m3pqAy26+VxqJKlSldHxU0nCcE2CGYm4J7I9E/9LuBLdNNUyN7Mtr9j
X-Gm-Message-State: AOJu0Ywdlwe6kYt6T8QoAPd+eTppqVlqqDDMKLTFADy5+3tFj1+Z+ukF
	IF91Hbkpt05e4w553KdutubIG9IWOYdGQnzRauKXwUO+KaaDitUO
X-Google-Smtp-Source: AGHT+IFTRtVfgKahJZt1zfvDZG2w4y6n7l/19nUtY0UMVQZUbvoJs2+kyzRqvXJHqjkzl2JUK9VuZw==
X-Received: by 2002:a05:6870:cb94:b0:239:6927:6826 with SMTP id 586e51a60fabf-241721ade50mr19916796fac.0.1715768982962;
        Wed, 15 May 2024 03:29:42 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66585sm11074805b3a.10.2024.05.15.03.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:29:42 -0700 (PDT)
Date: Wed, 15 May 2024 19:29:38 +0900 (JST)
Message-Id: <20240515.192938.1400783775062196516.fujita.tomonori@gmail.com>
To: naveenm@marvell.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, hfdevel@gmx.net
Subject: Re: [PATCH net-next v6 5/6] net: tn40xx: add mdio bus support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <SJ2PR18MB5635B758C9807AA7520E01EFA2E22@SJ2PR18MB5635.namprd18.prod.outlook.com>
References: <20240512085611.79747-1-fujita.tomonori@gmail.com>
	<20240512085611.79747-6-fujita.tomonori@gmail.com>
	<SJ2PR18MB5635B758C9807AA7520E01EFA2E22@SJ2PR18MB5635.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 13 May 2024 09:40:08 +0000
Naveen Mamindlapalli <naveenm@marvell.com> wrote:

>> +static u32 tn40_mdio_stat(struct tn40_priv *priv) {
>> +	void __iomem *regs = priv->regs;
>> +
>> +	return readl(regs + TN40_REG_MDIO_CMD_STAT); }
>> +
>> +static int tn40_mdio_get(struct tn40_priv *priv, u32 *val) {
> 
> The argument "val" is not used inside this function.

Oops, I'll fix in v7.


>> +static int tn40_mdio_write(struct tn40_priv *priv, int port, int device,
>> +			   u16 regnum, u16 data)
>> +{
>> +	void __iomem *regs = priv->regs;
>> +	u32 tmp_reg = 0;
>> +	int ret;
>> +
>> +	/* wait until MDIO is not busy */
>> +	if (tn40_mdio_get(priv, NULL))
>> +		return -EIO;
>> +	writel(TN40_MDIO_CMD_VAL(device, port), regs +
>> TN40_REG_MDIO_CMD);
>> +	writel((u32)regnum, regs + TN40_REG_MDIO_ADDR);
>> +	if (tn40_mdio_get(priv, NULL))
>> +		return -EIO;
>> +	writel((u32)data, regs + TN40_REG_MDIO_DATA);
>> +	/* read CMD_STAT until not busy */
>> +	ret = tn40_mdio_get(priv, &tmp_reg);
> 
> Is "tn40_mdio_get()" supposed to return any status in tmp_reg (which is missing?).

Indeed.

Thanks a lot!

