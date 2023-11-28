Return-Path: <netdev+bounces-51615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3737FB5CB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEAE1C20F25
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D89487B9;
	Tue, 28 Nov 2023 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlJSZMnx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFD1CB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701163777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqtlxM7GFQZXHgjH0zB9XWmn8WNFIyJK5XRONp7hXak=;
	b=TlJSZMnxYlhDPxY/piG0n+2WuP4zqnxfLcCKmQywBZlEOYtzn9OOf0Zp/OGau006b9PiIr
	35kJSrYXrjjl64OjLSHhpjgZ3qyX1ReSnh3r7LdV+c9orZGpWUXTH1hXIZqqy3qljAKBCt
	R85uyQoZIHkfaqwsdZIfJANGuGLjcMs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-LjOz0CKAPk25O6xFf-uCzw-1; Tue, 28 Nov 2023 04:29:36 -0500
X-MC-Unique: LjOz0CKAPk25O6xFf-uCzw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5450c83aa5dso468289a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 01:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163775; x=1701768575;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqtlxM7GFQZXHgjH0zB9XWmn8WNFIyJK5XRONp7hXak=;
        b=DncknUvmtCRceflRkH2p0sDwczD4gfAYffWeU2wTTc6X8WOdTCsUEm2sN+m8Z302sC
         NgfS7SaSLpDXZHHwej0k8hOVYg2ztfET+KCvFozJucGpjpt68yvJ33Ty1AOKcLsP0Kal
         MO+1gcM8bJJvSL2Tv3FAFISACt/1RycdL49LDWmkkfaFe6QMAXoB8bN/tAJzSgYqMpb/
         taicZY15gY5e+Y/4EfZoMKWIc4oGzGp8b65jmZat2fvvCVoIHotEPciWfG9I4TTw3g/A
         Y8ITjv03IjzTL+J+XsLuP61Lv8v/r/Vm5htiWJrT6SljRLn6UoN3pzat4BJW5vO8VAlF
         yrzg==
X-Gm-Message-State: AOJu0Yza62HiPyufI0/vvLOpZYbd+K/QXhxv2YbusMS4tpguoeiuoti7
	NW00k7NLZ+SVjo4/bSNiasbcZjUhKU5JRsT6ARJKIrOeOinxmbZsYT+lkO74LTwqAHaddWUMl8p
	l+aTjVVLy2dgN+Inz
X-Received: by 2002:a05:6402:513:b0:54b:5052:e8dc with SMTP id m19-20020a056402051300b0054b5052e8dcmr4917097edv.1.1701163775089;
        Tue, 28 Nov 2023 01:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEot1IhWN0J2XnqZbGQrLBGO5LU8L7U29OjFUZE2cK8+dg/qQmf571zz96IaGjAZL6rSZaF3g==
X-Received: by 2002:a05:6402:513:b0:54b:5052:e8dc with SMTP id m19-20020a056402051300b0054b5052e8dcmr4917076edv.1.1701163774737;
        Tue, 28 Nov 2023 01:29:34 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-156.dyn.eolo.it. [146.241.249.156])
        by smtp.gmail.com with ESMTPSA id c21-20020a056402101500b0053e5f67d637sm6108032edu.9.2023.11.28.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 01:29:34 -0800 (PST)
Message-ID: <5e8d805ba8e033d495c879d1f58c90dc1f3ea23b.camel@redhat.com>
Subject: Re: [PATCH net-next v5 1/1] ptp: clockmatrix: support 32-bit
 address space
From: Paolo Abeni <pabeni@redhat.com>
To: Min Li <lnimi@hotmail.com>, richardcochran@gmail.com, lee@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Min Li
	 <min.li.xe@renesas.com>
Date: Tue, 28 Nov 2023 10:29:32 +0100
In-Reply-To: <PH7PR03MB7064DBC8094260993E1B524BA0B8A@PH7PR03MB7064.namprd03.prod.outlook.com>
References: 
	<PH7PR03MB7064DBC8094260993E1B524BA0B8A@PH7PR03MB7064.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I'm sorry for the late feedback, I have a few comments below...

On Fri, 2023-11-24 at 15:20 -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
>=20
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
>=20
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul
> - Apply SCSR_ADDR to scrach register in idtcm_load_firmware advised by Si=
mon
> - Apply u32 to base in idtcm_output_enable advised by Simon
> - Correct sync_ctrl0/1 parameter position for idtcm_write advised by Simo=
n
> - Restore adjphase function suggested by Rahul
>=20
>  drivers/ptp/ptp_clockmatrix.c    |  69 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  32 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 329 insertions(+), 314 deletions(-)
>=20
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.=
c
> index f6f9d4adce04..8a48214adc26 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -41,7 +41,7 @@ module_param(firmware, charp, 0);
>  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm=
);
> =20
>  static inline int idtcm_read(struct idtcm *idtcm,
> -			     u16 module,
> +			     u32 module,
>  			     u16 regaddr,

If you change 'regaddr' type to u32, that will allow reducing some
relevant 'noise' in the chunks below, avoid swapping the 'mudule' and
'regaddr' arguments from the callers.

Such mentioned chunks are IMHO quite confusing/counter-intuitive, it
would be better get rid of them regardless of the better diffstat.

>  			     u8 *buf,
>  			     u16 count)
> @@ -50,7 +50,7 @@ static inline int idtcm_read(struct idtcm *idtcm,
>  }
> =20
>  static inline int idtcm_write(struct idtcm *idtcm,
> -			      u16 module,
> +			      u32 module,
>  			      u16 regaddr,

Same here.

>  			      u8 *buf,
>  			      u16 count)

> @@ -1395,6 +1396,20 @@ static int idtcm_set_pll_mode(struct idtcm_channel=
 *channel,
>  	struct idtcm *idtcm =3D channel->idtcm;
>  	int err;
>  	u8 dpll_mode;
> +	u8 timeout =3D 0;
> +
> +	/* Setup WF/WP timer for phase pull-in to work correctly */
> +	err =3D idtcm_write(idtcm, channel->dpll_n, DPLL_WF_TIMER,
> +			  &timeout, sizeof(timeout));
> +	if (err)
> +		return err;
> +
> +	if (mode =3D=3D PLL_MODE_WRITE_PHASE)
> +		timeout =3D 160;
> +	err =3D idtcm_write(idtcm, channel->dpll_n, DPLL_WP_TIMER,
> +			  &timeout, sizeof(timeout));
> +	if (err)
> +		return err;
> =20
>  	err =3D idtcm_read(idtcm, channel->dpll_n,
>  			 IDTCM_FW_REG(idtcm->fw_ver, V520, DPLL_MODE),

I think this chunk could/should go in a different patch: a first one is
implementing the support for 32 bit address space, a 2nd is leveraging
it to configure the PLL correctly.

Cheers,

Paolo


