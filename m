Return-Path: <netdev+bounces-143488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E89C29B6
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 04:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD50284137
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 03:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46141760;
	Sat,  9 Nov 2024 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEaj6rY2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE504437C;
	Sat,  9 Nov 2024 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123062; cv=none; b=XSJD16U+YmuHXx9Gty7IkfG4zq+hUXcVJqJXyKVGnPXSTtcR8fKt4dvwPjllKAK4gLFo3CV0TgnwtntvHD3T7tyNMiIuAkCNUeGWnB/QPI0zzZ4KwOBzNl5NZYDl9Zt3T2YiaIYKckjlwLSiPq+2RYtXElpPLjI/E0Ciem3o/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123062; c=relaxed/simple;
	bh=kqWaRla6KeqcWyUcL4vlHDNP/HV9ak9BMf3rplR7720=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFI4iCC/+iYC6FH5qfGfBahnMVbYsg9t8knpMFaTy4cadE59GZ1ugMKY1nBNBKGdAtO7PzqqivP+T0Q3sJzHFiN4cn5u69nlQvuDvEMBDT304RVp5FlZPVrENWx5+SWacCCWlDLzqGR6YU4U3HM2sM/M93iohPYphQRDuHyHBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEaj6rY2; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so2167239a91.1;
        Fri, 08 Nov 2024 19:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731123060; x=1731727860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvZFakif94DezrvyJP/D/64cCh5NjTgQ0ptlotViedM=;
        b=FEaj6rY2q+8Go+Pr0pv+exiLzCDv3ZI2scW92gTLmCqczqQ6hlyvMwGJBeQBTOFLDl
         /Zzjy4a7Z4c11GWHSCoM/x9IEDNhBYs/bbaXn9kNenOnyUHv+1MYe5KF+0OruiXknH+t
         9BXbc5tu9dwXKRVco7Bcr/WfcUTS5M/OoKdMECuXSo1/xVEhEi0bzPkrpp7d5S4x5sxN
         I7xbU4R2ZVHRHqTYOGlgVmzSmck+SMMMctugDJvdBD7ub3iZUdQ4ojGRSVZjuQ5yQWGM
         jUGBJ2MluJ4pgoCqRVkwVzt/+GPVCttlAo0zIuclSn9/h+OpoffpCAZmK2rFrKKWYznt
         Ge8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731123060; x=1731727860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvZFakif94DezrvyJP/D/64cCh5NjTgQ0ptlotViedM=;
        b=U3LuHXxyVmAaKIn5DRciMLwcbO7gaqNn5mIU6UYdWdBFhZ/I35Re+zihKewSxa5g1+
         yW+0qGfXUj0M4L3Acfo8HZlKO+VD9LTSp6J7H6hZjHw0S9FcjFqDkNzuGUyOnQogWY+e
         pzWUKusFcg3clgc58Qo2keEXcIJE1md+PWs5mseFYIpeWgza79YfwOI1UkJYRCDiZYOy
         z5zJXO3AOtoC+PacvBlYWR9UPRf/3XuUWWwnqYU6qEr0xGxTzpA9HhHrbU6QPJSY+my6
         mSnr35+7fHDvVNHU/1sBodRkUzlpi2Du5CJacdLLIX/nClF3OKr09FwCgLF71LZ+MaaO
         72AA==
X-Forwarded-Encrypted: i=1; AJvYcCUjtihwdbl8ovn3TZYzUs4pTGpwzB8tB6Arw9ZLTTuFranSSthtF2wdAp+pJ6n4nmY6AWyAiAq1VoA=@vger.kernel.org, AJvYcCVFyavCRL1zv/DWx0F2hfHRemIoiBc+il2GBQwYXP4Howloaz42xGxYxf36GrDXUpWmjwbonIbF@vger.kernel.org, AJvYcCWhRM/bRZQl6Hy7EjLj8RD8JxVJGj2Xl02WsvuOTbNQx/NbBTOo4hZuxE9hgXvBh/dLxtSRBBiMt2ska1IE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh31vsvnFl58bH5L4eSg56/ynZDkPhZTFkmvmCkXG9/LC7nDBK
	FuavA5Q14SqlUX6ByMujiU8gp8h80uc7xMc2Y4yXacNcOkey8O+3
X-Google-Smtp-Source: AGHT+IFvLYiofLEeObMTgPz0JbiECsd/UHWiaWpFLstJtOTWGgmXI+jX91RLajLSNDzlY0GoqEOV3g==
X-Received: by 2002:a17:90b:1bc3:b0:2e0:7b03:1908 with SMTP id 98e67ed59e1d1-2e9b0a57d33mr7793250a91.10.1731123060065;
        Fri, 08 Nov 2024 19:31:00 -0800 (PST)
Received: from archie.me ([103.124.138.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541cf0sm6394682a91.12.2024.11.08.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 19:30:59 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EC1E941F52F8; Sat, 09 Nov 2024 10:30:54 +0700 (WIB)
Date: Sat, 9 Nov 2024 10:30:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, jdamato@fastly.com, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] eth: fbnic: Add PCIe hardware statistics
Message-ID: <Zy7Xbr3_mAMhzaIh@archie.me>
References: <20241108204640.3165724-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IQS/oihujBOXZaWb"
Content-Disposition: inline
In-Reply-To: <20241108204640.3165724-1-sanman.p211993@gmail.com>


--IQS/oihujBOXZaWb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2024 at 12:46:40PM -0800, Sanman Pradhan wrote:
> diff --git a/Documentation/networking/device_drivers/ethernet/meta/fbnic.=
rst b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> index 32ff114f5c26..13ebcdbb5f22 100644
> --- a/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> +++ b/Documentation/networking/device_drivers/ethernet/meta/fbnic.rst
> @@ -27,3 +27,29 @@ driver takes over.
>  devlink dev info provides version information for all three components. =
In
>  addition to the version the hg commit hash of the build is included as a
>  separate entry.
> +
> +PCIe Statistics
> +---------------
> +
> +The fbnic driver exposes PCIe hardware performance statistics through de=
bugfs
> +(``pcie_stats``). These statistics provide insights into PCIe transaction
> +behavior and potential performance bottlenecks.
> +
> +Statistics Categories
> +
> +1. PCIe Transaction Counters:
> +
> +   These counters track PCIe transaction activity:
> +        - pcie_ob_rd_tlp: Outbound read Transaction Layer Packets count
> +        - pcie_ob_rd_dword: DWORDs transferred in outbound read transact=
ions
> +        - pcie_ob_wr_tlp: Outbound write Transaction Layer Packets count
> +        - pcie_ob_wr_dword: DWORDs transferred in outbound write transac=
tions
> +        - pcie_ob_cpl_tlp: Outbound completion TLP count
> +        - pcie_ob_cpl_dword: DWORDs transferred in outbound completion T=
LPs
> +
> +2. PCIe Resource Monitoring:
> +
> +   These counters indicate PCIe resource exhaustion events:
> +        - pcie_ob_rd_no_tag: Read requests dropped due to tag unavailabi=
lity
> +        - pcie_ob_rd_no_cpl_cred: Read requests dropped due to completio=
n credit exhaustion
> +        - pcie_ob_rd_no_np_cred: Read requests dropped due to non-posted=
 credit exhaustion

The docs LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--IQS/oihujBOXZaWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZy7XagAKCRD2uYlJVVFO
ozyYAQCkAF4wy6AD6plL4hz3QjSm/r9d+aHXVVAMMDfMddrNcgD+IV1l/U90p8p0
uHoBF+vQz7+/MbXf1vtJ3qJsKxf8sAc=
=bTYN
-----END PGP SIGNATURE-----

--IQS/oihujBOXZaWb--

