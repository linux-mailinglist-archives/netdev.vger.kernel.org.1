Return-Path: <netdev+bounces-92612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541E58B819E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31217B209C5
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79071A0AF0;
	Tue, 30 Apr 2024 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QU4Z4w7w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BC179B2
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509653; cv=none; b=RRfPGP83ikd1VjHHkgmB6nwkxUs80e/xRwkvmoBZ02EoHCHgPQOe25goqvQWHukL5UjmB6JVKxPlpsV0KgNL+cGkRfnhZy81F1deumbS13vpOnEpdw3l4/WLSjSkIApVdcPtgCcY6OpzUsHiGo0ALxDVnuCKvVIbRJ3XAugVvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509653; c=relaxed/simple;
	bh=g4KcU5ndEYbberSlTcHA147B2Lb41kO/2LL5txZwjVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEuFeeWt35zfh9qJqQ0n82XhFdAm6kJ/0NY1p9YTMcPFfsC7/XjmOfemzhlDBfPSp/EUQKZTjtfQiCMq4tqaHGyep9eLtIynDPucWrV7V+0rmXagw9PetH2IfpsWXemMsPuzQoIPEkTJxTsj5eDN0txF1+XC5yOBtDvtem2Rn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QU4Z4w7w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hnq0FKiwIItMbEYN0UYf68fTZlJrFk5zDwRVgngUGOo=; b=QU4Z4w7w5AP6ISjloHoXn1cTTe
	1atdtcjYUSywxCk2K/pYR3XS0RzBLft1hKR3p5t7EOcO1vWX2AcfAmjO/cEBGqphAVwgmaUxWNy4m
	F65Qd+aB1pR6G8ZEgqSi+kftvesjWhBpKN6AlRuorupYem/B9AAEyRS2sq0Uw5/KcxD4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1uHP-00ENsT-Bn; Tue, 30 Apr 2024 22:40:47 +0200
Date: Tue, 30 Apr 2024 22:40:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: tn40xx: add basic Tx handling
Message-ID: <c2b5177c-3782-44fb-b7b0-d3ca610af1b8@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
 <20240429043827.44407-4-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429043827.44407-4-fujita.tomonori@gmail.com>

> --- a/drivers/net/ethernet/tehuti/tn40.c
> +++ b/drivers/net/ethernet/tehuti/tn40.c
> @@ -3,10 +3,1177 @@
>  
> +static inline void tn40_do_tx_db_ptr_next(struct tn40_txdb *db,
> +					  struct tn40_tx_map **pptr)

inline functions are not liked in .c files. Leave it to the compiler
to decide.

> +{
> +	++*pptr;
> +	if (unlikely(*pptr == db->end))
> +		*pptr = db->start;
> +}
> +
> +static inline void tn40_tx_db_inc_rptr(struct tn40_txdb *db)
> +{
> +	tn40_do_tx_db_ptr_next(db, &db->rptr);
> +}
> +
> +static inline void tn40_tx_db_inc_wptr(struct tn40_txdb *db)
> +{
> +	tn40_do_tx_db_ptr_next(db, &db->wptr);
> +}

Functions like this are likely to be inlined even without the keyword.
Please look through all the code and remove the inline keyword from .c
files. They are O.K. in headers, so long as they are static inline.

> +#include <linux/delay.h>
> +#include <linux/etherdevice.h>
> +#include <linux/firmware.h>
> +#include <linux/if_ether.h>
> +#include <linux/if_vlan.h>
> +#include <linux/in.h>
> +#include <linux/interrupt.h>
> +#include <linux/ip.h>
>  #include <linux/module.h>
> +#include <linux/netdevice.h>
>  #include <linux/pci.h>
> +#include <linux/phy.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>

More headers which should be in the .c file.

>  
>  #include "tn40_regs.h"

> +/* netdev tx queue len for Luxor. The default value is 1000.
> + * ifconfig eth1 txqueuelen 3000 - to change it at runtime.
> + */
> +#define TN40_NDEV_TXQ_LEN 3000

This comment does not seem to match the #define?

     Andrew

