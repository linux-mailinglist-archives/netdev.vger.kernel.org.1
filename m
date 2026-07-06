Return-Path: <netdev+bounces-305222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4JfxFqUUTGpHgAEAu9opvQ
	(envelope-from <netdev+bounces-305222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:48:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 013B471588B
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 22:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=mZ3QsY+A;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305222-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305222-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71BB1301FFDB
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EBF3EFFBD;
	Mon,  6 Jul 2026 20:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442DC3ED11D
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 20:48:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370915; cv=none; b=ecth0uc5ZSRF6EHAtbw3bWmv73BVCFfD+NV2yK+jyPdyVB5CrIWwHu9w12RZxfuzoIqeySjcqaQ8X2J1WKPm2LGrFQ00lsvCbGhZVIGHRCXexrCUVprgfhNWP4Gb/FULZNK92GRuaGFH0snrbUcd3pKJ0ehpyCvW+Tghuwv4OFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370915; c=relaxed/simple;
	bh=sA3bUyxlyAgtfUkMb0H5qkmTnmpV+7g5kV7l0iLbrg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGOTPtq4sOk/HIR2K278RX4Zs2S5onEIi/jxWKJ9a2uQwn9d6Wj4ordKm8YWQp/r2yHkRjcUhDB0VYO+8zlCP3LnFVWRHAkqLUKaI0uMuCgx9bCOKSDCUfNqRr/jknlyCaSn496Ztl1FCAB3diPvXXLtn0S2D/KPmPvXYM9ZHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=mZ3QsY+A; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-470174001a0so1832095f8f.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783370912; x=1783975712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0UHpBUD3cu/Rp4zLRsGuE1AtMqiOkk0aTyTzhiJ1BL8=;
        b=mZ3QsY+AsrHxo3EAM2ic9C5MGyspmw2OwlRSqtOP1RX+npnC1yJlQfLVToZ6tp2L+D
         1FDQ8vg8CtTeW1uLeyRJ4k5u8EpVauS3/891pOD7PU5dvtbD4pwaiEd2vCEIYfzvT0Kp
         vHg2XXaJTbU8yjeHrYZszqaK8+068r7gx7WpPvrpLGuadZu9JauwioCLswVB+VZp7UYO
         zXDG9BmwxAHmApF29H05BNPvzhqh1hMu2Zz+EsHYHTbxBFS+0cjczj4b4FeQi7bXl6zL
         NZy79GxlTszrRqwt+jWi6VWTIYb4oEl8udgaIUV+wh2tURFq4JNT0BiobJVjoyhdRH7/
         0dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783370912; x=1783975712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0UHpBUD3cu/Rp4zLRsGuE1AtMqiOkk0aTyTzhiJ1BL8=;
        b=NmDPPOpXy7Y0xnhu//oQVvK6rNAj5Yi/pOyEBm/ESQaIblSDdWoYFW/zvU/GKGyXmk
         tvBfpQAiSL0bS7+T07TyAKtV0fYVmtSwgPK2olSQZslV/7/8c301bb2qFiU0NNHuO+Sg
         fuHgUdabWRDkMyzsZoaw1DrnDVdb5/eVojG94Xag9aU4fZK43uOiPMEjj5HvepdRpRk9
         oR9I6S8hLGDLU7rZeAlOLs4q0Pd+82H86HnL7Gd2DFDJt9qgj1f11eAL3PKkhLB6mtPR
         4q8l+6qeBUu0Lxf2zG+D7PvFl9ahpOM/VG8VT518R0MNsYqaMLWIOQz+qhO8fQn1c1fs
         /yyw==
X-Forwarded-Encrypted: i=1; AHgh+RpEXsdWhFe3LU7d1z3rmP9QUY286RBEkHk4wBH4PdShO34CkXSLMnggDvkdmiA+wPw1JfKfNcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXRdjWe9oLNhOcjJAfc2IZ1h8x3hl3csadNoqArGF05kY3wki
	N84RE9TOCi6go9+Ny+P8HaYG6pPCFHJ+HfaIRMuHvWJEtJg+tvjsNvanxYVpkU6IC1M=
X-Gm-Gg: AfdE7cn+QIKaUwbrkOl+PP0OCtMX1rtBcLd2LStfUyjEpi1RhfSguO5IepCc2pTDxWI
	KSjrCXNqgeSF818Qhr/HXwCPw/N3pVLOw3WCw3o4uLZbtYPuS8UsuhBWnt5mDM8rl3z2xnbENlJ
	Ubx5xRzwm8e0bA1SLvpaJEcocj1b6ZBnQmKSNCQcnhPUWfJUfx9IymU0Q7Xb4WdcTtDHCMocTy4
	Cli/WpBfbdlOn/g3XmCYbWrX7Cn3wgs4GV/t02JpT/H0/8xjKRNUvLQOEg17u49SxjbWIFrSmch
	eI1BZePIaGYZW9R32teBametuWaeXqIJLDECZvMD4myf2/6NBzRP5YZkmaS5OhDNrEuv53dGnoi
	Oo3TVJJzQ4ZiVCojb39Nz9bECrnlQegP+AnfQJhV0OOnY8htxnVrHEUxukYxu/MA/jeKya7gO+W
	eZQy5lZkb7SRP7JcbbOHW4lY/hoGsv
X-Received: by 2002:a05:6000:2484:b0:476:6bd4:82b8 with SMTP id ffacd0b85a97d-47de66d0032mr2092771f8f.14.1783370911620;
        Mon, 06 Jul 2026 13:48:31 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9e4d7801sm28301287f8f.16.2026.07.06.13.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:48:30 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:48:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
Message-ID: <akwToZyYvHZPtdjV@monoceros>
References: <ca270a534d0f230a939a3fb4a661808b35d6436d.1783329817.git.u.kleine-koenig@baylibre.com>
 <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yznje6wp3egk2oea"
Content-Disposition: inline
In-Reply-To: <12ec5246-4124-4edb-a5f8-f10c73b1fcb7@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305222-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 013B471588B


--yznje6wp3egk2oea
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next] net: phy: Drop #inclusion of
 <linux/mod_devicetable.h> from <linux/mdio.h>
MIME-Version: 1.0

Hello Andrew,

On Mon, Jul 06, 2026 at 04:17:47PM +0200, Andrew Lunn wrote:
> On Mon, Jul 06, 2026 at 11:29:19AM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > <linux/mdio.h> itself doesn't use any of the device id structures. The
> > files #including <linux/mdio.h> use a variety of them:
> >=20
> > 	$ git grep -l '<linux/mdio.h>' | xargs grep --color  -E '\<(acpi_devic=
e_id|amba_id|ap_device_id|apr_device_id|auxiliary_device_id|bcma_device_id|=
ccw_device_id|cdx_device_id|coreboot_device_id|css_device_id|dfl_device_id|=
dmi_(device|system)_id|eisa_device_id|fsl_mc_device_id|hda_device_id|hid_de=
vice_id|hv_vmbus_device_id|i2c_device_id|i3c_device_id|ieee1394_device_id|i=
nput_device_id|ipack_device_id|isapnp_device_id|ishtp_device_id|mcb_device_=
id|mdio_device_id|mei_cl_device_id|mhi_device_id|mips_cdmm_device_id|of_dev=
ice_id|parisc_device_id|pci_device_id|pci_epf_device_id|pcmcia_device_id|pl=
atform_device_id|pnp_(card_)?device_id|rio_device_id|rpmsg_device_id|sdio_d=
evice_id|sdw_device_id|serio_device_id|slim_device_id|spi_device_id|spmi_de=
vice_id|ssam_device_id|ssb_device_id|tb_service_id|tee_client_device_id|typ=
ec_device_id|ulpi_device_id|usb_device_id|vchiq_device_id|virtio_device_id|=
wmi_device_id|x86_(cpu|device)_id|zorro_device_id|cpu_feature)\>'
> > 	...
> >=20
> > but none of them relies on <linux/mdio.h>'s #include.
> >=20
> > <linux/mod_devicetable.h> is a bad header mixing many different device
> > id structures and thus is an unfortunate dependency because if e.g.
> > struct wmi_device_id is modified all users of <linux/mdio.h> need to be
> > recompiled despite none of them using struct wmi_device_id.
> >=20
> > So drop the unused header.
>=20
> While i agree that there are lots of unneeded dependencies here, does
> this change actually solve anything? Pretty much every PHY driver
> needs mdio_device_id, which is part of mod_devicetable.h. So it must
> be getting included somehow.
>=20
> I assume the long term plan is to move all the structure definitions
> out of mod_devicetable.h, so a driver can include just the ones it
> needs?

Yes, however not long term, but I intend to get most of this done for
7.3-rc1.

> Is this patch somehow a step along that path? Why not move
> mdio_device_id into mod_devicetable_mdio.h and include that? It seems
> like the more obvious fix.

That's exactly my thought, and there is commit ad428f5811bd
("mod_devicetable.h: Split into per subsystem headers") that is part of
v7.2-rc2 and that does exactly that (apart from the filename).

Best regards
Uwe

--yznje6wp3egk2oea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpMFJgACgkQj4D7WH0S
/k5dHQf/QoJwvEDslmRdlY/7+cdVFzKOjggf0jklvP1rIUOxJuc1G9pdBRKfCACH
cSpHt0herH2EwKaXrpQPVdJgTNWwURKJ55j1fkP/YEPEGE7i3TM5JktQ/YAOPWj7
MvfcQ5Ia8h40i/1g3X3gyKqaEGrB/eFDslsEGcMYiEUTLjtK8P/CqyubD+YXDJ7M
mfLuW6fu6/U8gdw9fQay/J2UaM/zV1iNqAzgmD7eRAvje4WgrUnw6xm9RtaSimOq
NUZtsQfvjxDJHWtJFNQODzR44GsLymwK6H+5bQLiVuBFtBR1LLlg28qipw3VRWtF
2ncfNVS3on+zC95LHbfABSDLS7LqOw==
=Y4bH
-----END PGP SIGNATURE-----

--yznje6wp3egk2oea--

