Return-Path: <netdev+bounces-39104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B787BE0F9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D12816AF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D73419F;
	Mon,  9 Oct 2023 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AzOPLoio"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF90328DB;
	Mon,  9 Oct 2023 13:45:59 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCD18C;
	Mon,  9 Oct 2023 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1696859154; x=1697118354;
	bh=dMqUwSLa3SeTGCAa8eakRnHMOOm1x+jefSWxaCHBezk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AzOPLoioSLo6ddt3m++0elqtw7Jr2zWtsUel59v4aY3w1XOzmZ+fwmuAR2P2wf9pX
	 2WZrUiD7qM7MwLuNXhzUQLnzASUBu2nE9tG9XfbIBI1Yhgt1ssSsPSBVgWDllqmbjd
	 aVmvCyATXMIBOqgbXzETn49HBleO2A1ypTeNS9ozvupzQpCxd+TL+Lw+X26A0vbuMj
	 ZF2GDYECNluuOH/9LCgW3mEuUUIxK1O/qkelzDTfDrXLAYqB0TJaon1AOOFXrzLBdM
	 LjN92vk2XnBo751Qs3+QtQKop588hro4LVrB6z2P2bzId6WaMzmaWl/hgfyAYaQ4KC
	 I8IslWA7/5Sew==
Date: Mon, 09 Oct 2023 13:45:49 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
Message-ID: <803e270b-7123-0ebd-439a-6eb0cece1373@proton.me>
In-Reply-To: <97058377-fd92-4315-9094-d1a4179d43fa@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com> <20231009013912.4048593-4-fujita.tomonori@gmail.com> <3dafc9f4-f371-a3d8-1d11-1b452b1c227e@proton.me> <97058377-fd92-4315-9094-d1a4179d43fa@lunn.ch>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09.10.23 15:15, Andrew Lunn wrote:
>>> +        if ret as u32 & uapi::BMCR_SPEED100 !=3D 0 {
>>> +            dev.set_speed(uapi::SPEED_100);
>>> +        } else {
>>> +            dev.set_speed(uapi::SPEED_10);
>>> +        }
>>
>> Maybe refactor to only have one `dev.set_speed` call?
>=20
> This is a common pattern in the C code. This is basically a
> re-implementation of
>=20
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device=
.c#L2432
>=20
> because this PHY is broken. Being one of the maintainers of the PHY
> subsystem, it helps me review this code if it happens to look like the
> existing code it is adding a workaround to.
>=20
> Is there a Rust reason to only have one call?

My reason was consistency, since the call to `set_duplex`
below that was changed to only have one call:

+        let duplex =3D if ret as u32 & uapi::BMCR_FULLDPLX !=3D 0 {
+            phy::DuplexMode::Full
+        } else {
+            phy::DuplexMode::Half
+        };
+        dev.set_duplex(duplex);

I think it should be consistent, I chose to reduce the number of
function calls, since it is immediately obvious that only the argument
is depending on the condition. But if you think it should mirror the C
side, then maybe change the duplex back to calling twice?

--=20
Cheers,
Benno



