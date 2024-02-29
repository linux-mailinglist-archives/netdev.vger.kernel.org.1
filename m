Return-Path: <netdev+bounces-76103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E686C54B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3676F1C215DB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7995D90B;
	Thu, 29 Feb 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ja7ilSTk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730835D72B
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199127; cv=none; b=RJOB5BbQxGWAjK2abFaBJGyexmuPyuhinaKlXFN4llYS8IeUF3IGzL+J2IaIgFbbqs4E3geDpHCkzr7ce8nqauPlQbEv4T6Vv1a6h8tYtnCsF281vNPFZB8vcyNbGKFFvQFCT7L5MJ2bnM470BXNTsKo1pF8iOIsJFyoIqsVnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199127; c=relaxed/simple;
	bh=6i2k1HfZmq0eCuNTltsb8L0/Mha/pPwS9ImAT/+P2w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr0FMtq+fjcz3am+Dx/vXdnY1VieJeWD8aayrTVDHuwfrvmXp15VcNu8JximCj+qqR9Fk14jumD38GWwEeSxdqdeVlHEwc8EU7rBSuLyHExKkvOcFqrW2lm4HTRM7USp2n7MJPh4RgfVD3j4FszUWy1aHR4BR/RfTDQmCYixz50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ja7ilSTk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso900332a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709199123; x=1709803923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iM6QUg9bjSZl8uSCUZVhzf0WX0iuuwwjiA47u4B1bsA=;
        b=Ja7ilSTkeoR0r/We13xhEhr41CP/uGtsYykVhCgLq898UP5kH1s68ldlMd4MqSAHld
         FZfK8xZCGdBFPZRQzQsTyEM92Ynag/cy1p6CqlJTFxX2b4o3JmJY8PzHnac8SrDSOw6R
         Ik30xKniwXqOLh10h+Gx6DOPIa2gfTqXUgsOSros9uMXmJ75Rz+s2okXVvGahlZ9dEUg
         mcF1z52TsSp12oRMjpAsLwDxRC/9fR1XBomPPLKL5Ky+9f9X8WQHjA+EzgAe5nD8iPTl
         61TiUfvER6xCq0id1dEP4Ig03iAsF8rbcAN/UxPL0CMjxO41GAM8+57Mux3UJWwRArG1
         HQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199123; x=1709803923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM6QUg9bjSZl8uSCUZVhzf0WX0iuuwwjiA47u4B1bsA=;
        b=U/b5ucU9u6z4sgxhHErjmA8jRBVcTfvhBVjUSNiZKQH5ZksM9Cl854ywet/CT8jeLw
         hOrIO7Fs5rHXNG/NJPP5DhuxNK92VgwUtx9jEcB7U2rRiw4FFTqAK0FvL49oQV3MnoAw
         +BzTufJqa/Vltjl0y43wpmt8/LLBQrMV2/97QHIxGAqcEXkPPjraalwsiioilNjGcwcJ
         srFnuTWihGgyShm96jfiHSDReqSYwtBUBpxS71wcA8mJ/CXaR7WsO8neyxBgFZvjosax
         BKFpVaNZHqZaXDblHzQum3kiBJ/Y/uGHHkcS69fZiF4i24WQq+EHhXsOcUWDcbGccxO3
         s9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVU5kmHl4nLa6goLoItQGf1ceGgL1Ne+7EmnCKqrZKd2FF04Wk0oSIJmIWFRAD0ARDmjwQXTZrax66vaWjj2iUqa/Vua0U9
X-Gm-Message-State: AOJu0YxiULrsmi1kKK7NcO0bEP1QZ1g1d2n/dDXze7MfhsJshZwK7Ym5
	Xep2oOQwFkAixU/oSGL98ZkQwzoGUdwjr1ll1CT1axIITr0hb7S3e7D5hTEnpGs=
X-Google-Smtp-Source: AGHT+IFbgMTA7l2LY6u7O5iqg2yN+YwDx8P8i1I1cf92NyS3RjoRIzybLhQ3EBwnL/OlWPmKmeOLuQ==
X-Received: by 2002:a50:ef07:0:b0:566:2a1a:fe18 with SMTP id m7-20020a50ef07000000b005662a1afe18mr1034928eds.36.1709199123487;
        Thu, 29 Feb 2024 01:32:03 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f4-20020a05640214c400b005660742bf6bsm441622edx.52.2024.02.29.01.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:32:02 -0800 (PST)
Date: Thu, 29 Feb 2024 10:32:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	andrew@lunn.ch, netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH v2] net: txgbe: fix GPIO interrupt blocking
Message-ID: <ZeBPEYBG6y5bUP8u@nanopsycho>
References: <20240229024237.22568-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229024237.22568-1-jiawenwu@trustnetic.com>

Thu, Feb 29, 2024 at 03:42:37AM CET, jiawenwu@trustnetic.com wrote:
>There were two problems to be solved in this patch:
>
>1. The register of GPIO interrupt status is masked before MAC IRQ
>is enabled. This is because of hardware deficiency. So manually
>clear the interrupt status before using them. Otherwise, GPIO
>interrupts will never be reported again. There is a workaround for
>clearing interrupts to set GPIO EOI in txgbe_up_complete().
>
>2. GPIO EOI is not set to clear interrupt status after handling
>the interrupt. It should be done in irq_chip->irq_ack, but this
>function is not called in handle_nested_irq(). So executing
>function txgbe_gpio_irq_ack() manually in txgbe_gpio_irq_handler().

Two patches then, no?


>
>Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
>Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
>---
> .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
> .../net/ethernet/wangxun/txgbe/txgbe_phy.c    | 29 +++++++++++++++++++
> .../net/ethernet/wangxun/txgbe/txgbe_phy.h    |  1 +
> 3 files changed, 31 insertions(+)
>
>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
>index e67a21294158..bd4624d14ca0 100644
>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
>@@ -81,6 +81,7 @@ static void txgbe_up_complete(struct wx *wx)
> {
> 	struct net_device *netdev = wx->netdev;
> 
>+	txgbe_reinit_gpio_intr(wx);
> 	wx_control_hw(wx, true);
> 	wx_configure_vectors(wx);
> 
>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>index bae0a8ee7014..93295916b1d2 100644
>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>@@ -475,8 +475,10 @@ irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
> 	gc = txgbe->gpio;
> 	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
> 		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
>+		struct irq_data *d = irq_get_irq_data(gpio);
> 		u32 irq_type = irq_get_trigger_type(gpio);
> 
>+		txgbe_gpio_irq_ack(d);
> 		handle_nested_irq(gpio);
> 
> 		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
>@@ -489,6 +491,33 @@ irqreturn_t txgbe_gpio_irq_handler(int irq, void *data)
> 	return IRQ_HANDLED;
> }
> 
>+void txgbe_reinit_gpio_intr(struct wx *wx)
>+{
>+	struct txgbe *txgbe = wx->priv;
>+	irq_hw_number_t hwirq;
>+	unsigned long gpioirq;
>+	struct gpio_chip *gc;
>+	unsigned long flags;
>+
>+	/* for gpio interrupt pending before irq enable */
>+	gpioirq = rd32(wx, WX_GPIO_INTSTATUS);
>+
>+	gc = txgbe->gpio;
>+	for_each_set_bit(hwirq, &gpioirq, gc->ngpio) {
>+		int gpio = irq_find_mapping(gc->irq.domain, hwirq);
>+		struct irq_data *d = irq_get_irq_data(gpio);
>+		u32 irq_type = irq_get_trigger_type(gpio);
>+
>+		txgbe_gpio_irq_ack(d);
>+
>+		if ((irq_type & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
>+			raw_spin_lock_irqsave(&wx->gpio_lock, flags);
>+			txgbe_toggle_trigger(gc, hwirq);
>+			raw_spin_unlock_irqrestore(&wx->gpio_lock, flags);
>+		}
>+	}
>+}
>+
> static int txgbe_gpio_init(struct txgbe *txgbe)
> {
> 	struct gpio_irq_chip *girq;
>diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
>index 9855d44076cb..8a026d804fe2 100644
>--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
>+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
>@@ -5,6 +5,7 @@
> #define _TXGBE_PHY_H_
> 
> irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
>+void txgbe_reinit_gpio_intr(struct wx *wx);
> irqreturn_t txgbe_link_irq_handler(int irq, void *data);
> int txgbe_init_phy(struct txgbe *txgbe);
> void txgbe_remove_phy(struct txgbe *txgbe);
>-- 
>2.27.0
>
>

