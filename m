Return-Path: <netdev+bounces-163283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6075A29CF4
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3781F16993D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68C218E99;
	Wed,  5 Feb 2025 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emukgLRS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66021772B
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738796185; cv=none; b=JNZUNkfMWoaY68Z8viESlGTKnm89ZcusvlLW//OZIfHuMWGkjlhCmv4fJZb1sbc+lK7P5MSX9wLQK7o0d25QUuWX81Cv7Am9NToeLL+ljKPba+FOtfN8rLqm6V23IORceuHu4dQHb+5PXu3qUNEGmuBbmNHglcVsoiP5RaeHAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738796185; c=relaxed/simple;
	bh=iNZSz3AjheIgxJ3lywk6jo8Fdlzw1iEuDEJBOx4M+VY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpY9AuHLKqGvqGomntDDV2TV24dodnpKOY5S82zIxMIRG8FR5QJIV4bVwoD2nQW+n86XxWUsH6q6oVeKQhxJZnP+BpPQG1YW+y9OakFMFyptljFV3NvxRWXOKDoOLB2ooaLTFkKy5DBavuUbAt8jnDM/A3Ty6ucjhb4UzzaVmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emukgLRS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so3289045e9.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738796181; x=1739400981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goFHG8ttUyK2DIwKn/61AgjnHRGyVIbJtnRdtWRi+M0=;
        b=emukgLRSLFvM2dFJRNoi5ost2TOSXPwyEQi2CHjJn0Wu60iO3HhgDqmfhBG10/CF8j
         YbFaoH7E5DYEw39OLqTNGvQyig0H85mQO+LU3u02Ec9q5IDPk/iF4jnVuJF0+Fiv40ZL
         Loo4Q+CxcOHgprjNxjEGjfDVZuYDSGLD9HbR4BBPIbeMN6agl7US45HnGs19k0Sr5OLp
         J8jPav4CpWhghTbIX/CqCfYx4LksHwqc13VIOoeKvj+H1APFemgurEliPCbF7XbEXD1l
         0rQBwHPf1yENvWg5jgzZsctRkmFaL1HqIMNwnc/7WPpze/Z7B1JB2LymPXRZEyr8ovem
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738796181; x=1739400981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goFHG8ttUyK2DIwKn/61AgjnHRGyVIbJtnRdtWRi+M0=;
        b=GPKJR0SlXjBFiq9cACvkDTKdmuYXpjw3m73B+ncOKFhUhNnEoAL2g56dwHTqvapi8h
         TWKe8bBR54BQ3MGjunPFv5aqogDh97TPvXSPTGYfqUT+vGeflRcjNhQ4oa8rVMIMgADD
         G7w/nDk9SfLCkI6+rrMZM+0h3MV2fVaqrwJojUe9BBSTN0uK9lxjjl9r0B4cs6N6pkb2
         5o+T+WcDWKzUzMAwsUdwQKzykb+YnEJniyq0rPz9+/SmjC6X/pCdUPs58g3Kou5D1xq9
         2B+OXIx3QpO2ApHp6tPMvLX+cWFzRMR0KHmiLfnTZtHaOb/BrGSc1kkON8julgK/bgpW
         /U7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzHhpRXYLpwqhGvKuq9d6OHpkRmwq8s8KZySjk+Dmh0PpwwYWtb/jHUh9I+ybkWAI9TllCuKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPdMo2fN7lA1mY0HlVMwCQuL/+8EmDjamnbYqQ9fOVF3ieseh
	xnLlhHNxQURH5IrjJXHHvElwZHpEtpmyRSOAm5AgUTid8yIEHdpiU4v19g==
X-Gm-Gg: ASbGncts6A+9PdNMCj0mJF5EuLbHZQ3nZdFowfGptk3P7oPDq2MApUrU8I68SJ4UfIa
	0yfnFBxJMmwBuRiScfbQ1X8l9cK5gPoXu9lQhrV+Q3xJNitZVMdLfyf5ftZwQAjlAqI51V2b1cL
	a3R2Wyi924D7nAseXqYWcj/3MM6+okI//g3uq+Us6MXdiQtxg88AKV4wch8Fw2m1JFBuKFrhvK6
	+6pIfLesOMwo2yCv+6OMPQQSQu1ZFkCfxfp/hpdTOwOkJ0F1bE9EFkLw4JrZs8FYhCRmHbeER3G
	vHx4Q6JRD0lPvL+BG7FVfyw53hudpTSwfnR6rzmCQw6S7s0wEspgWw==
X-Google-Smtp-Source: AGHT+IEm5cdECDcC075T2ciC+EHG/aGnVIfVUqsgpYBy81rbSVo6Q7McubPYJvFBi3u7SRszziz9Bg==
X-Received: by 2002:a05:6000:4020:b0:38c:5bc1:1ef5 with SMTP id ffacd0b85a97d-38db4857e36mr3935634f8f.3.1738796181166;
        Wed, 05 Feb 2025 14:56:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fbeesm23160f8f.66.2025.02.05.14.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 14:56:20 -0800 (PST)
Date: Wed, 5 Feb 2025 22:56:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>, Michal
 Swiatkowski <michal.swiatkowski@linux.intel.com>, Qiuxu Zhuo
 <qiuxu.zhuo@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <kees@kernel.org>, Nick Desaulniers <nick.desaulniers@gmail.com>,
 Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH iwl-net] ice: health.c: fix compilation on gcc 7.5
Message-ID: <20250205225619.31af041c@pumpkin>
In-Reply-To: <20250205204546.GM554665@kernel.org>
References: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>
	<20250205204546.GM554665@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 20:45:46 +0000
Simon Horman <horms@kernel.org> wrote:

> + Jiri
> 
> On Wed, Feb 05, 2025 at 11:42:12AM +0100, Przemek Kitszel wrote:
> > GCC 7 is not as good as GCC 8+ in telling what is a compile-time const,
> > and thus could be used for static storage. So we could not use variables
> > for that, no matter how much "const" keyword is sprinkled around.
> > 
> > Excerpt from the report:
> > My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.
> > 
> >   CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
> > drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
> >    ice_common_port_solutions, {ice_port_number_label}},
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
> > drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
> >    ice_common_port_solutions, {ice_port_number_label}},
> >                                ^~~~~~~~~~~~~~~~~~~~~
> > drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
> > drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
> >    "Change or replace the module or cable.", {ice_port_number_label}},
> >                                               ^~~~~~~~~~~~~~~~~~~~~
> > drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
> > drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
> >    ice_common_port_solutions, {ice_port_number_label}},
> >    ^~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
> > Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> > I would really like to bump min gcc to 8.5 (RH 8 family),
> > instead of supporting old Ubuntu. However SLES 15 is also stuck with gcc 7.5 :(
> > 
> > CC: Linus Torvalds <torvalds@linux-foundation.org>
> > CC: Kees Cook <kees@kernel.org>
> > CC: Nick Desaulniers <nick.desaulniers@gmail.com>  
> 
> Hi Prezemek,
> 
> I ran into a similar problem not so long ago and I'm wondering if
> the following, based on a suggestion by Jiri Slaby, resolves your
> problem.

I'm sure I remember from somewhere that although the variables are
'static const' they have to be real variables because they can still
be patched.

Which stops you using their contents as initialisers.

Maybe I'm mis-remembering it.

	David

> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index ea40f7941259..19c3d37aa768 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -25,10 +25,10 @@ struct ice_health_status {
>   * The below lookup requires to be sorted by code.
>   */
>  
> -static const char *const ice_common_port_solutions =
> +static const char ice_common_port_solutions[] =
>  	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
> -static const char *const ice_port_number_label = "Port Number";
> -static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
> +static const char ice_port_number_label[] = "Port Number";
> +static const char ice_update_nvm_solution[] = "Update to the latest NVM image.";
>  
>  static const struct ice_health_status ice_health_status_lookup[] = {
>  	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",
> 
> 
> Link: https://lore.kernel.org/netdev/485dbc5a-a04b-40c2-9481-955eaa5ce2e2@kernel.org/
> Link: https://git.kernel.org/netdev/net-next/c/36fb51479e3c
> 


