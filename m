Return-Path: <netdev+bounces-90302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFB78AD936
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 01:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD9282609
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 23:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533644C73;
	Mon, 22 Apr 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="mslzyq0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDJ/EHHC"
X-Original-To: netdev@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942191C287
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829061; cv=none; b=BPbZpwlAvNPOKStp06CD2nG8Rmzn5g6hTXt4369VMliUdF9myTX3FYrWODTV7jf3sLEdM1R9TW4kvbGdDpRPwWceyXfetacQI7DtWWdto2A1X4tuycfBABSwf4NQwBql1MQyQO9C7YtVGO2TtsMeWCEi+gtL6H814hotT+ZVg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829061; c=relaxed/simple;
	bh=5I/S7pW6SovQgvIa/uG08wwMVmaD4ojyv+Zzh91UIKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Id5rLTpUlUP1hgEWkZETeLpqjpJZ31ekH0ToMoL/iH+kklxMb0JIE1AcaRJwAJxBGC1F+GlxUxV7Keb3fQW9EgdGGriX1ToBq18tibxLf/OVehIRRveI8ZChTRu7KyfASpYDWWeZa6YzyXiRjvS3WAu0K4r3CPnE8UZ6euI0nqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=mslzyq0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDJ/EHHC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 71C351380159;
	Mon, 22 Apr 2024 19:37:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 19:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1713829058;
	 x=1713915458; bh=Vzcli0zyq82s9TDwPdvMJHbQvnNT0eFN+sB/uS7f00g=; b=
	mslzyq0FUHG/1FhpIjQPBLScNzfbfgZySxe9Pls7PS2F8uXu8qaSDixBGPjo3zjD
	fIV1Ajl27q+rTcRBcQrP8b5jiLx4yo0Kul50ptpDkBI7jrf1WdJck9LHbwlUMe5g
	XzRMeJFCLpmhcch1uyw/QpCEvm2XM+CkHQrrpeM9FRJtw1JnAcPnsB9QXo8AeaVb
	YtlWtaDn9GfmwEKXQz25/M0aBsH2hW5uanL20Irj1cOw8CWz65hSSK6Nj5VKyU1N
	ouOvThMgawolndFeQPFRSCPRxA6sw/jydc5oi+zeNKemYw/4ul4+5DMjt+qdmHaR
	7YmDe5izpcY2Od8MZYpV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713829058; x=1713915458; bh=Vzcli0zyq82s9TDwPdvMJHbQvnNT
	0eFN+sB/uS7f00g=; b=SDJ/EHHCvoC3hyyJHjOGuk8d0bGI9iqtyNuN8jcwyqiX
	P3ISe7/vaBwG3cDP61s5w503EEShYI3k8wybKL2GnqWlSBwPpWeP9zO8SaX8q0T1
	1JhcwVRsVS561yiQ+/5pDC/lAgrHG0/wBWkfpsftTUafr6SzchyFVdmM38n600ki
	wEUAs14DYE+rRxvCjDxcb0gZ2z1fmNmOujjWMDFkI6vbXfBZOZxFQr6nnj2cIT8B
	pqIHZnBukNg3LONsDIV/XQGVkQqhxMueToJiKK0LP1tsP4JBX+GBd2sL3qnoe4hd
	lAw/fH0laU2VQRAZjY16BqabO+mqmI2xZQzbs/ofzw==
X-ME-Sender: <xms:wfQmZn3ZYZG15FhEFvNPZowDW-jiEM0sD6XO5FcZD2MKADETjOVZmA>
    <xme:wfQmZmEEQv1nimYjrXvvjskBl0hKPHhZJT0ECJhgadkikAePmQ97GBnnV9TpT2LsY
    J19xE2CfmkNjA>
X-ME-Received: <xmr:wfQmZn5b10Mrt89Ajn-PPQGh20-xYmvQAohqOmC4DvH812MqxBZGeQFCTO4Ypu9R0TP6yOG2pZyCoUzUF1Hm5NP9jtteGXzTnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
    khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
    hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgfdu
    leetfeevhfefheeiteeliefhjefhleduveetteekveettddvgeeuteefjedunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:wfQmZs2U8D8vgAyy70ac29I28ToJobRuDpiChI17YK0SGdRPND5Y6w>
    <xmx:wfQmZqFNX47DOeoD1JaK78Vh8NtLn0QJZJlvF-Ck0mXB04XZVLKfnw>
    <xmx:wfQmZt9Ppe2RSka4Me0cRc1tA1apapLhSZRJS_RgBYI8_fgcHje5qA>
    <xmx:wfQmZnntVivZFdlfpt_qCwsuCJHDatB_6GR6QTjZB1LK8oCSghJ86w>
    <xmx:wvQmZmGV4f1FGxTPXgUhxzpcoA31D93k3NzyFuI8ppt6ksKyBs6CIhB6>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 19:37:35 -0400 (EDT)
Date: Tue, 23 Apr 2024 01:37:33 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	sasha.neftin@intel.com, Roman Lozko <lozko.roma@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
Message-ID: <Zib0veVgvgTg7Mq6@mail-itl>
References: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
 <96939b80-b789-41a6-bea6-78f16833bbc9@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qZGNviBJH3QVfuS4"
Content-Disposition: inline
In-Reply-To: <96939b80-b789-41a6-bea6-78f16833bbc9@intel.com>


--qZGNviBJH3QVfuS4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Apr 2024 01:37:33 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	sasha.neftin@intel.com, Roman Lozko <lozko.roma@gmail.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind

On Mon, Apr 22, 2024 at 04:32:01PM -0700, Jacob Keller wrote:
> On 4/22/2024 1:45 PM, Tony Nguyen wrote:
> > From: Lukas Wunner <lukas@wunner.de>
> >=20
> > Roman reports a deadlock on unplug of a Thunderbolt docking station
> > containing an Intel I225 Ethernet adapter.
> >=20
> > The root cause is that led_classdev's for LEDs on the adapter are
> > registered such that they're device-managed by the netdev.  That
> > results in recursive acquisition of the rtnl_lock() mutex on unplug:
> >=20
> > When the driver calls unregister_netdev(), it acquires rtnl_lock(),
> > then frees the device-managed resources.  Upon unregistering the LEDs,
> > netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
> > which tries to acquire rtnl_lock() again.
> >=20
> > Avoid by using non-device-managed LED registration.
>=20
> Could we instead switch to using devm with the PCI device struct instead
> of the netdev struct? That would make it still get automatically cleaned
> up, but by cleaning it up only when the PCIe device goes away, which
> should be after rtnl_lock() is released..

Wouldn't that effectively leak memory if driver is unbound from the
device and then bound back (and possibly repeated multiple times)?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--qZGNviBJH3QVfuS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmYm9L0ACgkQ24/THMrX
1yzI7Af/fIY9mlFrcBazZoZfYF6WN5ItdZRmhK1Sj6o5LZdkQfysHXarwCYPjahn
7Puzyy/Nk7S46OmNLpTUsY+757p7p3FQTuGZ/n8fstFpMPXJphdi+WCiB74NJBrE
nN8Mv+WYkNc6bhivEsoEMEkO1MPPD3ciEizgD5qxewncKzFLKlaLurH5xF43crlD
1sTt1RPIWAb9b38H7hXmCaZ5oiKvUJmMxP9y4LymtN2xslfq2P/Vzw0E4VAXQT3L
f3xozQjv8YG647yKeJnjILRQJ5dJmuZ4SofePIQi0un0WRFmuJNEH5gDqZRI0uW8
CupNByOea9tE28D4dIx8Rm5+jEFA8w==
=7nCY
-----END PGP SIGNATURE-----

--qZGNviBJH3QVfuS4--

