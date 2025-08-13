Return-Path: <netdev+bounces-213393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F745B24D72
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD9A188FF10
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5623B63C;
	Wed, 13 Aug 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTzwKX9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679502376F2;
	Wed, 13 Aug 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098884; cv=none; b=i4S6pEcyYUWjg3+uwCdbtj0mH3/gxocs+7yOvLFB0+iyNQgf78Y+tNLFxyVfIVQ7iChIMprQzH5i38zJWBTb0hoCq+Uh/fAOjqUdm2OF1DRQdcGW13zWiPaN3G+1kHKj4AltiSs9cB0uIx+wT5tSmkjUirjMJxoP8K0ciKjphvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098884; c=relaxed/simple;
	bh=CP8upqvVtn9Z3m5+ff43o5AJYwx/FwOQd/acka/t9P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2vPycotmAxSRxJ9e2Lhq5K2CG9Ts8ahBhu0yMqyY/CQa8xBQQ9XJyu8IN43bCIOGy3TsopzAjsnHaTJ0BbKtAsJxmjEX/N/5uftSNKI3GOyRYh2yR5UorJJDyrYTVFx9XugGbwS7GBt3BBawu8fmYc5yZhIFkL2kL/8AOlIOME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTzwKX9F; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b78bca0890so3424116f8f.3;
        Wed, 13 Aug 2025 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098881; x=1755703681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dCXGQ3wCen5hO/RhZ9y8kY2psIxwBZyCJWwI1Ahh5o=;
        b=fTzwKX9FGU/t8B14s+ZDfznycIYwPLQ6hlFWW7yvPNFSQpjqPTxG9sHnfSovdgNO4o
         Z0npyB9y/wfsOSIADea2ZGFyqHWQYHgMYzy2PnXAEegJ1VdNorPOU2jg1j2xncFFoYss
         lvJ+J0AQroBuYLsko38oE3MekCkUGVCVBGe0iGcH44CFhY1iWd0NgtkhjGcb8ine674v
         ENmfu/CL/rbh2XaX20fIVa5V4uZiPit7tc8OeR+6S3Qno4Wu8agUA5yF5CHH9kncPVpw
         TXh1NPYR3gLlBmeResZtiwyAen9W6jfVYPIl7gH8dY3/KPGzYdGbjlQP3JDAXaXbjRuX
         XWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098881; x=1755703681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dCXGQ3wCen5hO/RhZ9y8kY2psIxwBZyCJWwI1Ahh5o=;
        b=j/AJrBDMDisYRkxx9S5Q41H8nd+FTsIyXta0mx9nYqZDOe84zLuuH4gRtccsa7wbI1
         SZO/t4RaHNulnZqnzB8b+5ml92WvkCsxoyJ+TWx+Lw/VZtNYRK3FDT3IWEkOxRGPRdA6
         EZnOeib0fJyl+Fc1sas44IgBdW2nkRmYo0TTm2cNrtdEpqkJXSm4cO15UcCY6tx8gl+q
         dhUt3wkEnvXiihefS+KbYcp+dFBE1Nonx48a3MV4x8gZSf3KGiMF7p4y52JrEnfxxPtf
         zJNfv9scS/UZ9BXxVZc32AU2hoymbwC5KAodJDGoWFDWv3ihjzaTj9Ie4hMIGkLd5kI3
         2FlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoIEMcoLeBR98jpXeLtxQhwS6uYW2xsx+w9kosHgyA4axV7G6qxFGofryo6BAgGWEm/+EGYWXXTBis@vger.kernel.org, AJvYcCXASho++/gLSut0G9hnrkjlgZyC3WRsXiv8zffmfmN/59kU2aW6aNIyNcRSClC6j5CttRfbwkxAcAolVsaM@vger.kernel.org
X-Gm-Message-State: AOJu0YzqN/pr61XsVdqOaNu42zU8BcOCJG9Do7/50/an/CYHEQ9i1hTA
	2CALk3TQ9A/R1z3dJDchZpQQde8nFqP1Xj6dNwPOl4DMdl1tjENcOj64
X-Gm-Gg: ASbGnctXuVWGSFebR1ZBlGGmKtjmyfTX1p2MhZziQAarEd18wdWqPg3DR1aiApLskfT
	qou700c/l8mbS9F9gd+G4cnT3ZCiRVVbBVYrudldbAV5WimjOtWELk3W9r42XrQ1mU4CdHnD/es
	a6UTx+rhEwDfMNBk10sPYPewx2OnHj7kj6gcFW0BMgkj0qTG9HSDXP+5Zu7xgTEPjRU4nswx/wV
	+F7JRw7Cb+5oC6ulMS7AZDlzbLvZvs3lcJW4/vorTJQp02W6hsXAFvppILlXsTTHveycDmxWuuD
	5jiLun9N2x2UZo+yYlA+j2/vOHNPMsZCyVsJpzbWV6PEr0T4GAhTJqoOD+QHxo9n5A9RviMuVFO
	y0h7XBSLUjxqJpgEAh3fDk/34A41m2F+XZXyMWKQO9WiRx2HCWl6zCWnu9TAtGApm/QH3uUELsO
	+Xjex7rdWU
X-Google-Smtp-Source: AGHT+IGvCYpe77xXC4O8RNzirUxA7cMzbuFpGjarjyQuF4h4e0X7kLLiXN7Oa7TmkKyvCs586LY0fA==
X-Received: by 2002:a05:6000:2dc8:b0:3b8:d955:c598 with SMTP id ffacd0b85a97d-3b917e90664mr2385608f8f.30.1755098880683;
        Wed, 13 Aug 2025 08:28:00 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a53905asm6336365e9.22.2025.08.13.08.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:28:00 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject:
 Re: [PATCH net-next v2 09/10] arm64: dts: allwinner: t527: avaota-a1: enable
 second Ethernet port
Date: Wed, 13 Aug 2025 17:27:58 +0200
Message-ID: <13821245.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20250813145540.2577789-10-wens@kernel.org>
References:
 <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-10-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 13. avgust 2025 ob 16:55:39 Srednjeevropski poletni =C4=8Das je =
Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> On the Avaota A1 board, the second Ethernet controller, aka the GMAC200,
> is connected to a second external RTL8211F-CG PHY. The PHY uses an
> external 25MHz crystal, and has the SoC's PJ16 pin connected to its
> reset pin.
>=20
> Enable the second Ethernet port. Also fix up the label for the existing
> external PHY connected to the first Ethernet port.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
> Changes since v1:
> - Switch to generic (tx|rx)-internal-delay-ps properties
> ---
>  .../dts/allwinner/sun55i-t527-avaota-a1.dts   | 26 +++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> index e7713678208d..f540965ffaa4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
> @@ -13,6 +13,7 @@ / {
> =20
>  	aliases {
>  		ethernet0 =3D &gmac0;
> +		ethernet1 =3D &gmac1;
>  		serial0 =3D &uart0;
>  	};
> =20
> @@ -67,7 +68,7 @@ &ehci1 {
> =20
>  &gmac0 {
>  	phy-mode =3D "rgmii-id";
> -	phy-handle =3D <&ext_rgmii_phy>;
> +	phy-handle =3D <&ext_rgmii0_phy>;
>  	phy-supply =3D <&reg_dcdc4>;
> =20
>  	allwinner,tx-delay-ps =3D <100>;
> @@ -76,13 +77,24 @@ &gmac0 {
>  	status =3D "okay";
>  };
> =20
> +&gmac1 {
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ext_rgmii1_phy>;
> +	phy-supply =3D <&reg_dcdc4>;
> +
> +	tx-internal-delay-ps =3D <100>;
> +	rx-internal-delay-ps =3D <100>;
> +
> +	status =3D "okay";
> +};
> +
>  &gpu {
>  	mali-supply =3D <&reg_dcdc2>;
>  	status =3D "okay";
>  };
> =20
>  &mdio0 {
> -	ext_rgmii_phy: ethernet-phy@1 {
> +	ext_rgmii0_phy: ethernet-phy@1 {
>  		compatible =3D "ethernet-phy-ieee802.3-c22";
>  		reg =3D <1>;
>  		reset-gpios =3D <&pio 7 8 GPIO_ACTIVE_LOW>; /* PH8 */
> @@ -91,6 +103,16 @@ ext_rgmii_phy: ethernet-phy@1 {
>  	};
>  };
> =20
> +&mdio1 {
> +	ext_rgmii1_phy: ethernet-phy@1 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <1>;
> +		reset-gpios =3D <&pio 9 16 GPIO_ACTIVE_LOW>; /* PJ16 */
> +		reset-assert-us =3D <10000>;
> +		reset-deassert-us =3D <150000>;
> +	};
> +};
> +
>  &mmc0 {
>  	vmmc-supply =3D <&reg_cldo3>;
>  	cd-gpios =3D <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
>=20





