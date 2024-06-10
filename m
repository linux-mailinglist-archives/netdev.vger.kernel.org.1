Return-Path: <netdev+bounces-102245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF790213E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AE1F222E4
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0A7E58C;
	Mon, 10 Jun 2024 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNIHKWj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9A502B1
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021157; cv=none; b=TiTCLXd6xkhtSl4XWLvhrYHzP4lDpmvFWKZnZADxS4xKvqMEyUw601c2MPLbbNEHtN/jJl9MPz/F4FVhV1Ussz/SdTgusQrn0mWmQdyXXcjYFD10ihSOmbRgJXWjiqCfbudZu67M/z9kLIy5K02IMmS5xBThms9iL1hdFdm6eGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021157; c=relaxed/simple;
	bh=JkVWyxBnchNctF3HRa1gN42Mj9xihcyP7+P6RlDkct8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KFEp6FFqyx8A+f/IfzXpisGlr0Zj6ch8jCfoOU8miSiw9Dyx9X/GX5eQchl5NNaXT/LglzgOHTD9Um7/EEoP+32Eq5OQYwgzj4fns5J707da67XAnMY7guDvpySHGY3/vHglP945SicFBw3IUhAvxFmFpkCt9pzP6cn9RtyleTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNIHKWj4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6daf644b0so1401535ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718021155; x=1718625955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRF+qHB1IAmBEzalBWrzRf0y+KvtbBk5ylzpKz88u34=;
        b=HNIHKWj4PwxOYF8i/fGeBdCnCZAQPYJCj1X6q02Un9UcaEkF8FnU0wvmncMLTczcTa
         K6VYvYRtq/15EhfUVkqREl2DWWeT6UaWE8jnzwFIy2GZelFS1kMD0ceuaYpPgMBiqfZz
         FWHLC9u+5u4oGaIJ9EX9nunAjTg9iJdB7N4RpoEmjwO4ld8BCQYuyDpo1+BuCjhhpvJ/
         edUqGKXiKiG570dcTMWW2OKRf/UE7SX2C14eekQMm/yQe3oZzELXfH7SyQqKN15gEgRl
         KiL27M3YamW5DR37W8Y2+2rtEjEsI5aD7SVcR+Db4YUmHi1M7cRMtAK4fa/g8igZ/aBY
         TJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021155; x=1718625955;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rRF+qHB1IAmBEzalBWrzRf0y+KvtbBk5ylzpKz88u34=;
        b=I7KjnWyXVrw/ig0CTyfDnKhZDZhHvKO5jkLRiIYkOuf3IeYEKuMJjfeCrRbUnoq4AP
         /1woz0fB5YdFWB6612CsHQQi8ZJV+mAW/Eduti04AZYWlP5UWLXE4sa9qcwBhQZjj0FB
         Q43o5zJK7uOqRDeP1x5txMX3ivF2dwBT4wTihbT6SFBMU3dLP4Ut24Q29kDotIira7zi
         BYtCk3YealDK/4pW2h/+XXYurE02mbmKX1V6X1sXWyLeIkxcIpXUWUJ2BBaXkraDi7fD
         GIslsu+28aecgy5gSkSscQDkbkjQ/ewPhlpPsqJmGPOOJQaeuPaQbNyit76TxPmS44kn
         dFFg==
X-Forwarded-Encrypted: i=1; AJvYcCWL68PDaRxO2Iec7pcbUjScgcp3tzedaQQQtEHQjIqMC56v85YTsaLCq0nj2z04VLERnhzDuDjibhZK9w7Q+NxZPTKahECJ
X-Gm-Message-State: AOJu0YzQW6ak3Paz/jBKlCGAhF+GZb67qoHSbVZbtA3UrwzLJRfnnFlH
	0iiZQllqv+z7EuYlWuKo/KQhc1PDO3JxBM0eZ9bO/R/gGhKK5Vxy
X-Google-Smtp-Source: AGHT+IHxhZq/8ilgykBLjrQxXXNAD5LzLyy7lxPXFbRoMw31neJer1d1tSnE/j6u4fsz10+0PgtIrA==
X-Received: by 2002:a17:903:2349:b0:1f7:12c9:9426 with SMTP id d9443c01a7336-1f712c9974fmr28830575ad.3.1718021154798;
        Mon, 10 Jun 2024 05:05:54 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75ef35sm81920385ad.56.2024.06.10.05.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:05:54 -0700 (PDT)
Date: Mon, 10 Jun 2024 21:05:47 +0900 (JST)
Message-Id: <20240610.210547.418635399210812330.fujita.tomonori@gmail.com>
To: linux@armlinux.org.uk
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 5/6] net: tn40xx: add mdio bus support
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZmbPxgG7vqEyhxEc@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<20240605232608.65471-6-fujita.tomonori@gmail.com>
	<ZmbPxgG7vqEyhxEc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 11:04:54 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Jun 06, 2024 at 08:26:07AM +0900, FUJITA Tomonori wrote:
>> +static int tn40_mdio_get(struct tn40_priv *priv, u32 *val)
> 
> I think this would be better named "tn40_mdio_wait_nonbusy()" because
> that seems to be this function's primary purpose.

Surely, sounds much better. I'll rename.

>> +static int tn40_mdio_read_cb(struct mii_bus *mii_bus, int addr, int devnum,
>> +			     int regnum)
>> +static int tn40_mdio_write_cb(struct mii_bus *mii_bus, int addr, int devnum,
>> +			      int regnum, u16 val)
> 
> I think it would be better to name these both with a _c45 suffix (which
> tells us that they're clause 45 accessors) rather than using _cb
> (presumably for callback which tells us nothing!)

Indeed. I'll use tn40_mdio_read_c45/tn40_mdio_write_c45 names in
v10. I felt that _cb was meaningless but I couldn't come up with good
names.

Thanks!


