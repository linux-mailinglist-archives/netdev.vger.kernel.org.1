Return-Path: <netdev+bounces-183761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC139A91D86
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07963462F66
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B524C07C;
	Thu, 17 Apr 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GzO0IxHX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2829524BC18;
	Thu, 17 Apr 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895617; cv=none; b=K3I73XM1OG2EurnkJNoUu75uudC4SQGeqqj5c6sAzhnI/BWDI+PTPQd5O7wZiB65Lsw56xVc+/11c/2KfrO82SQJF4NDTr2lQTRHYR+fN4ArfTvy05ee7MHyQv2028tGSq1GIw8wYwTVyAucINixAaWK0wQCBmTmW65qOzwTf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895617; c=relaxed/simple;
	bh=DzWIUMgO/0aqjQKZLGHzjTpbRlPFNCqYf5Es4PwWA00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+encc8OXags7JTMhyKuZcu3S/sMTYufXKCh1f3+9U66/JUXkE0SALEQlpBpiRbHWdbxUCnngsVVxNt8qhWp6dK27YZ4D1xr/xu3Y92gMMV+Th4nned+/lCt57TBQytRqiCfaHKW9TdRefvzlNNTdIQLkrkIVPh/FX/ET+39BEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GzO0IxHX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=kqSGBFvBco4jOMm/RXWM5jN0BSdqtnNtjafj4ponO5E=; b=Gz
	O0IxHXQWLgWcGyU7z2o4uuOqx/kIuEPNQdLAVlq0CotfEkWnsIPQTIuvoCEKb4Of9OSgaLZidYGav
	aQeF/gRXD9syYuO/WRiLA60LEu+NEYuFCqu3dDhxsJQ0ltZ4TL9c4RNPRVyGh6mJtsM7hu9PJUc/+
	KG963Pq+b22gzAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5P3J-009mjg-HR; Thu, 17 Apr 2025 15:13:13 +0200
Date: Thu, 17 Apr 2025 15:13:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/8] mfd: Add Microchip ZL3073x support
Message-ID: <894d4209-4933-49bf-ae4c-34d6a5b1c9f1@lunn.ch>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-4-ivecera@redhat.com>
 <8fc9856a-f2be-4e14-ac15-d2d42efa9d5d@lunn.ch>
 <CAAVpwAsw4-7n_iV=8aXp7=X82Mj7M-vGAc3f-fVbxxg0qgAQQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpwAsw4-7n_iV=8aXp7=X82Mj7M-vGAc3f-fVbxxg0qgAQQA@mail.gmail.com>

On Wed, Apr 16, 2025 at 08:19:25PM +0200, Ivan Vecera wrote:
> On Wed, Apr 16, 2025 at 7:11 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
>     > +++ b/include/linux/mfd/zl3073x_regs.h
>     > @@ -0,0 +1,105 @@
>     > +/* SPDX-License-Identifier: GPL-2.0-only */
>     > +
>     > +#ifndef __LINUX_MFD_ZL3073X_REGS_H
>     > +#define __LINUX_MFD_ZL3073X_REGS_H
>     > +
>     > +#include <asm/byteorder.h>
>     > +#include <linux/lockdep.h>
> 
>     lockdep?
> 
> 
> lockdep_assert*() is used in later introduced helpers.

nitpicking, but you generally add headers as they are needed.

>     > +#include <linux/mfd/zl3073x.h>
>     > +#include <linux/regmap.h>
>     > +#include <linux/types.h>
>     > +#include <linux/unaligned.h>
>     > +
>     > +/* Registers are mapped at offset 0x100 */
>     > +#define ZL_RANGE_OFF        0x100
>     > +#define ZL_PAGE_SIZE        0x80
>     > +#define ZL_REG_ADDR(_pg, _off) (ZL_RANGE_OFF + (_pg) * ZL_PAGE_SIZE +
>     (_off))
>     > +
>     > +/**************************
>     > + * Register Page 0, General
>     > + **************************/
>     > +
>     > +/*
>     > + * Register 'id'
>     > + * Page: 0, Offset: 0x01, Size: 16 bits
>     > + */
>     > +#define ZL_REG_ID ZL_REG_ADDR(0, 0x01)
>     > +
>     > +static inline __maybe_unused int
>     > +zl3073x_read_id(struct zl3073x_dev *zldev, u16 *value)
>     > +{
>     > +     __be16 temp;
>     > +     int rc;
>     > +
>     > +     rc = regmap_bulk_read(zldev->regmap, ZL_REG_ID, &temp, sizeof
>     (temp));
>     > +     if (rc)
>     > +             return rc;
>     > +
>     > +     *value = be16_to_cpu(temp);
>     > +     return rc;
>     > +}
> 
>     It seems odd these are inline functions in a header file.
> 
> 
> There are going to be used by dpll_zl3073x sub-driver in series part 2.

The subdriver needs to know the ID, firmware version, etc?

Anyway, look around. How many other MFD, well actually, any sort of
driver at all, have a bunch of low level helpers as inline functions
in a header? You are aiming to write a plain boring driver which looks
like every other driver in Linux....

Think about your layering. What does the MFD need to offer to sub
drivers so they can work? For lower registers, maybe just
zl3073x_read_u8(), zl3073x_read_u16() & zl3073x_read_read_u32(). Write
variants as well. Plus the API needed to safely access the mailbox.
Export these using one of the EXPORT_SYMBOL_GPL() variants, so the sub
drivers can access them. The #defines for the registers numbers can be
placed into a shared header file.

The MFD needs to read the ID, firmware version etc, so it can have
local implementations of these, but if the sub drivers don't need
them, don't make them global scope.

	Andrew

