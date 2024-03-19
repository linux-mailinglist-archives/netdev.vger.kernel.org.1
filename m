Return-Path: <netdev+bounces-80553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD487FC7A
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD89B20B75
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129F7CF03;
	Tue, 19 Mar 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePKGhbMd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041365474B
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846049; cv=none; b=lhlyCd063R37HvIPvUuRqU5194u7Gm3305bIE092jA3BQ4lrWpJHh0ufZKecq70eZo2XnGsDFIoylada8EItn3FhP3Ah1oVy4QVlUmXcXtxB8NylzshjKjm5n0Ugifg5IdXqG9vbSEuNQu8DIzF3iuIlddQwxE5yZNbtFIT2zC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846049; c=relaxed/simple;
	bh=acTq8BezVeVw5OSpkfYCO2Y+D63QmpCWZc4Fkt86cEQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0/UhskxRvqXw9gvmfk66IyfjwSDkB4r4vcgS1Z7fkRRGwnPDFuYenM0iVX1vs+H2B5t8pdBfbl8TAFySEs7v7afZT4Eu1ccfNocYDRAgy2tfxqGOAWS0+4im2NtuvWAb1UzRM78xxH40FBKjNFaXb9awnRytiFnrJQoag8RE5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePKGhbMd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710846046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ndYUVv7CoKDqcRCNBxdFePZRaorGfGKBsYEQk1sOLBA=;
	b=ePKGhbMdUc+S/E2LhVhvvziG5Qxxh96rM4XWuwci7I0lwcrT/TwOL7K5tClV1D6ZuGhsBB
	Cbr01zvN/y379GLhDQQg/tX7SEOcd1O6Fmj+ZcT/PEUCv7UTkkuOEaIqq/3JzpxYh8ZFDO
	KL7Jnl/I3fmPEPx2Ir6M9OcvQGr+Aaw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-J8x4VPGYP-qoBWhEADhzrg-1; Tue, 19 Mar 2024 07:00:45 -0400
X-MC-Unique: J8x4VPGYP-qoBWhEADhzrg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-568d189d33aso291285a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 04:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846043; x=1711450843;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndYUVv7CoKDqcRCNBxdFePZRaorGfGKBsYEQk1sOLBA=;
        b=EKl3hlT1StWRK6njBUrCA6zWjLY2iaEJy9rdxSvFrNHOZOSOqAPX4Ha6GOak5XHkMs
         B5iYWYTHOSfHs7XtkYv3AaLOKjnx2gye9Qs0eUzn0IqpwgRIGZmyo6Y3iP6YiHcCt814
         Y3VrBKCyKVwMKpSEeGN6RxlqVTGiHrDPwoHgxWrFc9Pl1YWEP+xwhuChw03YE2nItysD
         91WjVjz28a5nVmyEXVh37lUXved/6OOS1E2GyfCQzfUd7kzD0UYNkEtYFculkCwRejks
         /sMxGqW07Vdi2BremGeNJtvJpiFmqCI3a7IvixAWfYvUfOppigCdmp0M8QopYfKnhadW
         p1vw==
X-Forwarded-Encrypted: i=1; AJvYcCUIQ/U9nEHnHUa/il/2tLLU1sQcpJzVPr/nAQXGPrn4AYMKwC6FpAUYEX16Zlc6G8vls3Ad2zX9yxIG9ftMVk6ma5S9DgYr
X-Gm-Message-State: AOJu0YxuZsHKVPNuW6GRExAFh9uP8yGfQS0S/XHlWev67ktalFmFNhlT
	XdY5/gC2fIniM9qS4xP7us2oXD9O08ru5lh5/KPGHPFnyUJCjXUeTNOBcRE1ggK3wnompfXnxqQ
	WzJmsZArs2KujioP/eMF0ru86nJYl9GNWgd8plbizGQ96eWe9vhUWK0633fKEBg==
X-Received: by 2002:a17:907:9692:b0:a46:2a8c:b9f0 with SMTP id hd18-20020a170907969200b00a462a8cb9f0mr9885555ejc.7.1710846043618;
        Tue, 19 Mar 2024 04:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCzbCbPq8i9yTAA7hdd2h1+jUc6Aojvd/jPB9OSydglrl61Bgs8mCWPJl4rl1BvIGtxnD+3A==
X-Received: by 2002:a17:907:9692:b0:a46:2a8c:b9f0 with SMTP id hd18-20020a170907969200b00a462a8cb9f0mr9885535ejc.7.1710846043182;
        Tue, 19 Mar 2024 04:00:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-202.dyn.eolo.it. [146.241.224.202])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a461a7ba686sm5930280ejo.75.2024.03.19.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:00:42 -0700 (PDT)
Message-ID: <5a27414c77ae0b0fc94981354fa6931031b3d6fc.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: phy: don't resume device not in use
From: Paolo Abeni <pabeni@redhat.com>
To: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, Andrew Lunn
 <andrew@lunn.ch>,  "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Mar 2024 12:00:41 +0100
In-Reply-To: <AM9PR04MB8506791F9A2A1EF4B33AAAF4E2282@AM9PR04MB8506.eurprd04.prod.outlook.com>
References: 
	<AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
	 <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
	 <AM9PR04MB8506A1FC6679E96B34F21E94E2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
	 <AM9PR04MB8506791F9A2A1EF4B33AAAF4E2282@AM9PR04MB8506.eurprd04.prod.outlook.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-15 at 07:55 +0000, Jan Petrous (OSS) wrote:
> In the case when an MDIO bus contains PHY device not attached to
> any netdev or is attached to the external netdev, controlled
> by another driver and the driver is disabled, the bus, when PM resume
> occurs, is trying to resume also the unattached phydev.
>=20
> /* Synopsys DWMAC built-in driver (stmmac) */
> gmac0: ethernet@4033c000 {
> 	compatible =3D "snps,dwc-qos-ethernet", "nxp,s32cc-dwmac";
>=20
> 	phy-handle =3D <&gmac0_mdio_c_phy4>;
> 	phy-mode =3D "rgmii-id";
>=20
> 	gmac0_mdio: mdio@0 {
> 		compatible =3D "snps,dwmac-mdio";
>=20
> 		/* AQR107 */
> 		gmac0_mdio_c_phy1: ethernet-phy@1 {
> 			compatible =3D "ethernet-phy-ieee802.3-c45";
> 			reg =3D <1>;
> 		};
>=20
> 		/* KSZ9031RNX */
> 		gmac0_mdio_c_phy4: ethernet-phy@4 {
> 			reg =3D <4>;
> 		};
> 	};
> };
>=20
> /* PFE controller, loadable driver pfeng.ko */
> pfe: pfe@46000000 {
> 	compatible =3D "nxp,s32g-pfe";
>=20
> 	/* Network interface 'pfe1' */
> 	pfe_netif1: ethernet@11 {
> 		compatible =3D "nxp,s32g-pfe-netif";
>=20
> 		phy-mode =3D "sgmii";
> 		phy-handle =3D <&gmac0_mdio_c_phy1>;
> 	};
> };
>=20
> Because such device didn't go through attach process, internal
> parameters like phy_dev->interface are set to default values, which
> can be incorrect for some drivers. Ie. Aquantia PHY AQR107 doesn't
> support PHY_INTERFACE_MODE_GMII and trying to use phy_init()
> in mdio_bus_phy_resume ends up with the following error caused
> by initial check of supported interfaces in aqr107_config_init():
>=20
> [   63.927708] Aquantia AQR113C stmmac-0:08: PM: failed to resume: error =
-19']
>=20
> The fix is intentionally assymetric to support PM suspend of the device.
>=20
> Signed-off-by: Jan Petrous <jan.petrous@oss.nxp.com>

Please note that the 'net-next' tree is closed for the merge window.
You will have to repost in when the tree will re-open in a week or so.

However this change could be suitable for the 'net' tree, if Andrew
agrees. If, please re-sent targeting such tree and including a
reasonable 'Fixes' tag.

Thanks,

Paolo


