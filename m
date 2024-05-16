Return-Path: <netdev+bounces-96752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10858C7977
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3042B236DA
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB29714D43A;
	Thu, 16 May 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iIMabCed";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="iRF+9Q2q"
X-Original-To: netdev@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9F14D431;
	Thu, 16 May 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873296; cv=none; b=miJaGR+OjsK8dAvMFt8YcC/lLIlI1eufYTzDXJ/qwlAZBWD5uaT7dB+eBRDOzNGeaKYhK4RLaxPj/x1hDYoPwgtyapRfQYjkGTAF9BktC4Qg9O4V/QxbNa5xYJgTFh3vM9YJ9QWsCX/Je54MXqQ3J04SOpjCxkpYjQbNBPinH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873296; c=relaxed/simple;
	bh=jDGaIXZ6mwJSE++TssF9Hgd5zL7rRZplsxBJ8LGhBE0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hNpOUDTOOZkqli2PYjt6g62th3v+IEE1ZwpMw95eAj5bCvLkfcatRmWSOYo4SSY3T4hkN5UrmMA0IeXBjLNL+rESusT+qegiEu2tS+LY5MxbZW7owslwOtyFwz5fg+r10IE6oqsD4gJ8fAOIsEIVU+AIzlo+iVzkT9LBG8h+lRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iIMabCed; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=iRF+9Q2q; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CBDD20145;
	Thu, 16 May 2024 11:28:08 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=jDGaIXZ6mwJSE++TssF9Hgd5zL7rRZplsxBJ8L
	GhBE0=; b=iIMabCed0OLIq2MSNYAdqqL5B00RDZCoGMHJ+oKGm1jaBCDA2Vjs1w
	JlD9VLaJuZCyxIj84vW0xKKixfE41XreZbErLJOWgHR/vDlxKaNTNli6E53FrHem
	7OaffE4dpQ2+0Zk2ye2TcVDatSbWGz2lFyDNUk6kK0Ia+vo2s3+eM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FC8120144;
	Thu, 16 May 2024 11:28:08 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=jDGaIXZ6mwJSE++TssF9Hgd5zL7rRZplsxBJ8LGhBE0=; b=iRF+9Q2qWzw2ciruz1uGT5msSsWhWF+t0SqcIAcRKLfKZI9byA9Bg+I+r/KAit9buJxLZgg2E3DkBI9XwJ3eRn5qckpB+unpqs0Dq7Wb1YRAtLRn1BT+0cfTil9AIGZtktisONajvPuVvpYdRidGRvuZcO6iDFcG4+r5/T+nsNA=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6979020143;
	Thu, 16 May 2024 11:28:07 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 5B3AACAF973;
	Thu, 16 May 2024 11:28:06 -0400 (EDT)
Date: Thu, 16 May 2024 11:28:06 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Thorsten Blum <thorsten.blum@toblux.com>
cc: "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] net: smc91x: Fix pointer types
In-Reply-To: <20240516121142.181934-3-thorsten.blum@toblux.com>
Message-ID: <o61rp249-27sr-q9q5-118r-o531s8o80o8r@syhkavp.arg>
References: <20240516121142.181934-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 E5494648-1398-11EF-AF40-25B3960A682E-78420484!pb-smtp2.pobox.com

On Thu, 16 May 2024, Thorsten Blum wrote:

> Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
> to align with the parameter types of readw() and writew().
> 
> Consistently call SMC_outsw(), SMC_outsb(), SMC_insw(), and SMC_insb()
> with void __iomem pointers to address the following warnings reported by
> kernel test robot:
> 
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect type in argument 1 (different address spaces)
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void *a
> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void [noderef] __iomem *
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  drivers/net/ethernet/smsc/smc91x.h | 34 +++++++++++++++---------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
> index 45ef5ac0788a..204fbb5c975c 100644
> --- a/drivers/net/ethernet/smsc/smc91x.h
> +++ b/drivers/net/ethernet/smsc/smc91x.h
> @@ -142,14 +142,14 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
>  #define SMC_CAN_USE_32BIT	0
>  #define SMC_NOWAIT		1
>  
> -static inline void mcf_insw(void *a, unsigned char *p, int l)
> +static inline void mcf_insw(void __iomem *a, unsigned char *p, int l)
>  {
>  	u16 *wp = (u16 *) p;
>  	while (l-- > 0)
>  		*wp++ = readw(a);
>  }
>  
> -static inline void mcf_outsw(void *a, unsigned char *p, int l)
> +static inline void mcf_outsw(void __iomem *a, unsigned char *p, int l)
>  {
>  	u16 *wp = (u16 *) p;
>  	while (l-- > 0)
> @@ -1026,15 +1026,15 @@ static const char * chip_ids[ 16 ] =  {
>  		}							\
>  	} while (0)
>  
> -#define SMC_PUSH_DATA(lp, p, l)					\
> +#define SMC_PUSH_DATA(lp, p, l)						\
>  	do {								\
> -		if (SMC_32BIT(lp)) {				\
> +		void __iomem *__ioaddr = ioaddr;			\
> +		if (SMC_32BIT(lp)) {					\
>  			void *__ptr = (p);				\
>  			int __len = (l);				\
> -			void __iomem *__ioaddr = ioaddr;		\
>  			if (__len >= 2 && (unsigned long)__ptr & 2) {	\
>  				__len -= 2;				\
> -				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
> +				SMC_outsw(__ioaddr, DATA_REG(lp), __ptr, 1); \
>  				__ptr += 2;				\
>  			}						\
>  			if (SMC_CAN_USE_DATACS && lp->datacs)		\
> @@ -1042,20 +1042,20 @@ static const char * chip_ids[ 16 ] =  {
>  			SMC_outsl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
>  			if (__len & 2) {				\
>  				__ptr += (__len & ~3);			\
> -				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
> +				SMC_outsw(__ioaddr, DATA_REG(lp), __ptr, 1); \
>  			}						\
>  		} else if (SMC_16BIT(lp))				\
> -			SMC_outsw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
> -		else if (SMC_8BIT(lp))				\
> -			SMC_outsb(ioaddr, DATA_REG(lp), p, l);	\
> +			SMC_outsw(__ioaddr, DATA_REG(lp), p, (l) >> 1);	\
> +		else if (SMC_8BIT(lp))					\
> +			SMC_outsb(__ioaddr, DATA_REG(lp), p, l);	\
>  	} while (0)
>  
> -#define SMC_PULL_DATA(lp, p, l)					\
> +#define SMC_PULL_DATA(lp, p, l)						\
>  	do {								\
> -		if (SMC_32BIT(lp)) {				\
> +		void __iomem *__ioaddr = ioaddr;			\
> +		if (SMC_32BIT(lp)) {					\
>  			void *__ptr = (p);				\
>  			int __len = (l);				\
> -			void __iomem *__ioaddr = ioaddr;		\
>  			if ((unsigned long)__ptr & 2) {			\
>  				/*					\
>  				 * We want 32bit alignment here.	\
> @@ -1072,7 +1072,7 @@ static const char * chip_ids[ 16 ] =  {
>  				 */					\
>  				__ptr -= 2;				\
>  				__len += 2;				\
> -				SMC_SET_PTR(lp,			\
> +				SMC_SET_PTR(lp,				\
>  					2|PTR_READ|PTR_RCV|PTR_AUTOINC); \
>  			}						\
>  			if (SMC_CAN_USE_DATACS && lp->datacs)		\
> @@ -1080,9 +1080,9 @@ static const char * chip_ids[ 16 ] =  {
>  			__len += 2;					\
>  			SMC_insl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
>  		} else if (SMC_16BIT(lp))				\
> -			SMC_insw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
> -		else if (SMC_8BIT(lp))				\
> -			SMC_insb(ioaddr, DATA_REG(lp), p, l);		\
> +			SMC_insw(__ioaddr, DATA_REG(lp), p, (l) >> 1);	\
> +		else if (SMC_8BIT(lp))					\
> +			SMC_insb(__ioaddr, DATA_REG(lp), p, l);		\
>  	} while (0)
>  
>  #endif  /* _SMC91X_H_ */
> -- 
> 2.45.0
> 
> 

