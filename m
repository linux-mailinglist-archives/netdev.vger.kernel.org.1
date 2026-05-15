Return-Path: <netdev+bounces-288387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBYhERFfB2pa0QIAu9opvQ
	(envelope-from <netdev+bounces-288387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2153555C2F
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F86930ACE00
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CD34F7965;
	Fri, 15 May 2026 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbC2z9VN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32FD4F7970
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865170; cv=none; b=dP+vVvtwHgypv4JgUC/TzBweMt2mg2A4f8FbR0NuHU8ZGh99ltamBxzt0wL33DysSHDSBb6uyYymlQdwMmoX34kj2+edCx9/fR2DtFai9aMRSrBDJKex1vQHzCgO8XRjONZEd8UiD+y6oQJNDYSboiGkXJVq79hCTPm2MBSJ5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865170; c=relaxed/simple;
	bh=0A+nM/+sysN2KGQXhhO4JcJYWEOq2c2OfNIxDSDBn70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnkXcTF0x55ZJZxO8vqCNWCqLmfV7ZnFzTv97dcxUR5WEzu0rKTWL6VwIVSg7E73vAZRwJCgyk5p1jnAd0DWs6uH6bgC1LWTlh+8ZhF3683UXGj5QzbONsIaoVj0u0Qh2AhHpyS9Nbqdzs/5nxoydU43/Mau9HBizGsWo5bh3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbC2z9VN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83537a80ab6so46164b3a.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778865169; x=1779469969; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j2H8+FgdgJN+H8gAB0oUD1LeAPsq2ZPySE5IJb34ngg=;
        b=nbC2z9VNJIseawfjAdnp/plrA0Dhm8GDib7Fvc427Rztntyzd4A8OL6JX8/RA81Wa1
         frULWNkH5j4Brv2vfWxtqvzWjnlYiUD2ngvDbSgVynZuUwUqQwsNmbKsPZX3i44aJ0Lu
         agHCJ4kcOu7DVK7Qj5Wda1Ju1JxQeIEAuZc8zYoFszdLSbI7xaAorILvYT40+vDT5Bqe
         TqYIPqwjgYOJ1IU81dV22OyE1GtQvqvP7fl/kZkQ1jGsZ/Ddu2jB1d+7EwiK+v8Tl/9K
         vL4oCXgr3nxRoz6si5G84OPH2hLFQZxXL+j09jFw5Gviz3dRRdgnd/eOEUGSIB2wD8X+
         VQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865169; x=1779469969;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2H8+FgdgJN+H8gAB0oUD1LeAPsq2ZPySE5IJb34ngg=;
        b=KA1/xsFd6SaLk6bFo6KcSJ64brdaDcJmYfBTXZaw6DwRs/sJSpcv1hp47sDrgHO3Uk
         SYEMMqwGYMKGuLE3hcEWTLAby2f/TIUjCueHIOEFmP90aIB19avNY/gSKwl2WnzCIcFK
         snr/Cv5QRsOppsnr+MlZzFGMO2gyRJr0suUxaqBNM5n3QqQWK05j/oi+SSc2dhGni7+Q
         o8AEU4Gc3GcBOko8Q4EU31jqjLOfsVJpjY+DoHWQWDMdJWp01E5Cf3aRDkihK6q51ieZ
         PQpilQBYmvSm7iYQcpkhUTEMFa0cvenm2LfTfs1eSN513gh/2QW3hy/zmmkwF5o6MZhw
         S/Ow==
X-Gm-Message-State: AOJu0YwUo9QIg1J4fAJOqMKQuO08X8o+e9LH0aSQKFuC1QG/cq4Sktqi
	Vm+VGFGjEM+lkqYAbSiVdl9id8siE/0u1D3D2xPiA388Ru36L7/A9xVf
X-Gm-Gg: Acq92OGJaVki3o+fEiayTGPzYml7c3YNsXHDvswjw8NeCliv9IorzJUvsTkpFSLh60G
	+XQyftrzVDqj1N3X/G9IDh1WQBFlGGFfL1EGo8L8A4npt1/0TdB0FuzVgv7QjoAdFCGvTW8+ZQh
	uRdAE5M/g80svjcLY4c5Pr8mhSc0SbUY1rhzP+EJRFpKj2a8jwXIHxp1grnF6X/Rr0o9cWp/RB2
	XwdM1VXD4JMvUFLZgMZEIyePitm58JPJBQtYKtLn3I0NFqznC2+4n/lqoR+E/oyQ6s3q/LfrUT/
	HEbLIKDLl25ewTt1zUhbf+7qcCB7iRtoKAGRaBEiVox/Js6u5RtvdpSOqnTVJX/uf1Xvwoc4v04
	2CsVgmE3WRWcpeABQ6M3bRQ88RvUwIdKAn8myo6ldE2PlR7QgFR3kfPWi6p6nsE/9nHODnOnK5X
	KI9OurnNy2nrCEuBDJbIhgB3P6F3GgZBPOIqGOShxTY9irGdUyHkvsDLqow7BMulCOdrJo5xo8r
	dJCqR0xDXiHZCf3X9CNwfFFWwbFOVK1nsXFehG1OdmNaQP/SwAjyaUNEtOCziAn7rz+
X-Received: by 2002:a05:6a00:448a:b0:838:1c02:276c with SMTP id d2e1a72fcca58-83f33dee8b8mr5572533b3a.40.1778865168762;
        Fri, 15 May 2026 10:12:48 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f19c5c39esm7730851b3a.36.2026.05.15.10.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:12:48 -0700 (PDT)
Message-ID: <d55bd2281e7b3670c96fb3478d0417c79dc777f3.camel@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: pcs: xpcs: Add handling for 4
 channel rsfec device
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: mike.marciniszyn@gmail.com, Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski	 <kuba@kernel.org>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Kees
 Cook <kees@kernel.org>,  Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 May 2026 10:12:46 -0700
In-Reply-To: <20260511182604.1338-3-mike.marciniszyn@gmail.com>
References: <20260511182604.1338-1-mike.marciniszyn@gmail.com>
	 <20260511182604.1338-3-mike.marciniszyn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A2153555C2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288387-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 14:26 -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>=20
> This patch introduces the configuration of vendor specific
> registers for alignment encoding, PCS Mode, and VL_INTVL
> over the one or two instances as required.
>=20
> The DW_PCS IP specification calls out the need to configure both
> lanes identically when using 2 lane modes such as 50-R2 and 100-R2, so
> the programming is repeated for each lane.
>=20
> The encoding tables are derived from the IEEE 8023-2022 spec sections
> 82.2.7 and tables 82-2 and 82-3 for the alignment markers and their
> insertion.
>=20
> Note that there is a conflict between VRs DW_VR_XS_PCS_DIG_STS and
> and the DW_PCS_IP DW_VR_MII_PCS_PCS_MODE.  The bit mask for
> DW_VR_XS_PCS_DIG_STS/RX_FIFO_ERR fits within the reserved bits for
> the DW_PCS IP the DW_VR_MII_PCS_PCS_MODE register so there is no issue.
>=20
> There is also a confict between DW_VR_MII_PCS_VL_INTVL and
> DW_VR_MII_AN_INTR_STS but an_mode differs, so again there is no issue.
>=20
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> ---
> v2:
>   - Replace xpcs_write_pcs_prtad() wiht xpcs_write_pcs_mdev() to
>     avoid hardcoded prtaddr value
> v1: https://lore.kernel.org/all/20260506190904.4029-3-mike.marciniszyn@gm=
ail.com/
>=20
>  drivers/net/pcs/pcs-xpcs.c | 91 +++++++++++++++++++++++++++++++++++++-
>  drivers/net/pcs/pcs-xpcs.h | 25 +++++++++++
>  2 files changed, 115 insertions(+), 1 deletion(-)
>=20
>=20

[...]

> @@ -1464,6 +1521,23 @@ xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const =
struct pma_pcs_values *v)
> =20
>  	for (i =3D 0; mdev && ret >=3D 0 && i < v->lanes;
>  	     i++, mdev =3D xpcs_find_next_mdev(xpcs, mdev)) {

The use of the "find_next_mdev" essentially taints this patch with the
same issues from the first.

We know the offsets. We shouldn't be blindly reaching around for
devices and writing to them. If we need to we should be creating the
devices for the second lane of the PCS ourselves and using that instead
of letting the phy_device code autoprobe in a device based on the PMD.

Specifically we should just be writing to our bus ID and bus ID + 1 in
the case of the 50GR2 and 100G configurations as we have to configure
the 2 lanes. We shouldn't risk this thing going off the rails and
grabbing some random bus ID if it were loaded on another device. If we
need to we could make it so that the Meta device ID on the PCS is what
triggers it setting.

My advice would be to look at creating a new version of
xpcs_create_pcs_mdiodev, maybe "xpcs_create_pcs_mdiodevs", that you can
pass a lanes value to and perhaps look at making addr an array of
addresses. Then you could have that spawn the additional lanes via
mdio_device_create, record them in the dw_xpcs struct, and avoid having
to do as much blind searching to find the devices that you are
currently doing.

