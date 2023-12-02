Return-Path: <netdev+bounces-53230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F30801AC8
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FEE1C20AEF
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBD47497;
	Sat,  2 Dec 2023 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR68eEvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E847910C2;
	Fri,  1 Dec 2023 20:49:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c21e185df5so947600a12.1;
        Fri, 01 Dec 2023 20:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701492560; x=1702097360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDM7c+J640phVwZ5XAJUWTL/q6brdZPnES26u51DJ/M=;
        b=LR68eEvHvn4cBOMIj029ghGq+rxu4lf9++Y/FylRtrfsdVWwZidYGl0/W1pV4EXJZ7
         BSCQgxueGYyNchPmUAD+MZGC3gMjQWWkPxcjJx9I0b1JvLadUJabFO0POkf+cu3BWEgr
         cAZiOzun4nOlpPhfcy03HnUt1VuRVD8Vd+TcZYgwDIUSQa5kB/Cc5tuEULqStxArtFQ0
         Qxpn1ezUxuXN2CgRM0DG2rmtBZD8BgIZTj+jlwT/1iyNQPCvFo/VovRngLNsjVQw90mN
         fs3QCTQR8UROdkXCqUTIThFuaFyfNswmmc9conQWcxeqr+sUabK02HhUeEzWk+pZgRQy
         eeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701492560; x=1702097360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDM7c+J640phVwZ5XAJUWTL/q6brdZPnES26u51DJ/M=;
        b=RIlx7yUuP625QoWn8rycCXzBapBKXeYtCIvsmtqHthnE6ZaowKDrZ19BwL+bquxMN2
         IZliV5aP2uNMk0BKBZc0tBl9SFI7WtCO4vGlMp0KASPOSbSGvNo02/osZgUcwY2DtdrO
         4Ty3IYcp0HARa9GwrnPXNdJPTdly98mhX/hL/kfigVXC7Lfnxcicdag9U+nuABb/zSGe
         2E/WHb+g4Mtu5i2mCJrXnxfzlFs4qD5QrxkseM35aQgZvsNv3xnsSwyNP45Z1NYqX9nb
         Zr4m/VNDSQv4QUqg0ViCwtNyhK/4JmalUq8Q12BcpkX1fAicQy7QLw4Itxt5WqvRueLT
         PsHg==
X-Gm-Message-State: AOJu0YzIkbI3ro6dbmgMDLxANY6CAuM+k/b+FuNiv7qXV4+7W7UXJAAR
	edFOJeuXPl6r824fPCucn0k=
X-Google-Smtp-Source: AGHT+IFZYcp1sHZaaQ1PH+HUoGIIaqmYaZeowIbuF4MCveJ2xYTvOeak3SGKUDxBGl1uQRjQPOxvMA==
X-Received: by 2002:a05:6a20:c1aa:b0:18f:97c:978f with SMTP id bg42-20020a056a20c1aa00b0018f097c978fmr940032pzb.119.1701492560286;
        Fri, 01 Dec 2023 20:49:20 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id js3-20020a17090b148300b002809822545dsm3925725pjb.32.2023.12.01.20.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:49:19 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1FFB710211875; Sat,  2 Dec 2023 11:49:16 +0700 (WIB)
Date: Sat, 2 Dec 2023 11:49:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Linux Networking <netdev@vger.kernel.org>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, corbet@lwn.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [patch net-next v3] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <ZWq3S_EEFfCaaEGf@archie.me>
References: <20231201180154.864007-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4mQa6Zyb7za6H4+"
Content-Disposition: inline
In-Reply-To: <20231201180154.864007-1-jiri@resnulli.us>


--o4mQa6Zyb7za6H4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 07:01:54PM +0100, Jiri Pirko wrote:
> diff --git a/Documentation/userspace-api/netlink/intro.rst b/Documentatio=
n/userspace-api/netlink/intro.rst
> index 7b1d401210ef..aacffade8f84 100644
> --- a/Documentation/userspace-api/netlink/intro.rst
> +++ b/Documentation/userspace-api/netlink/intro.rst
> @@ -234,6 +234,10 @@ ACK attributes may be present::
>    | ** optionally extended ACK                 |
>    ----------------------------------------------
> =20
> +Note that some implementations may issue custom ``NLMSG_DONE`` messages
> +in reply to ``do`` action requests. In that case the payload is
> +implementation-specific and may also be absent.
> +
>  .. _res_fam:
> =20
>  Resolving the Family ID

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--o4mQa6Zyb7za6H4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWq3SwAKCRD2uYlJVVFO
oxjbAP9AarUu2n9EKnzgCkkOwiMGjbpkoBRqtCz7KNLFrriFEAD/XzJJwUEScOXU
6vmxKU/hTr1RceftTUwLRdPL0eTN3gU=
=nDqC
-----END PGP SIGNATURE-----

--o4mQa6Zyb7za6H4+--

