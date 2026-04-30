Return-Path: <netdev+bounces-282716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IYqCYUZ82nNxAEAu9opvQ
	(envelope-from <netdev+bounces-282716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:57:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445949F893
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4543F300A763
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5713FF8A6;
	Thu, 30 Apr 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="sG9T6KPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32713FD15E
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777539327; cv=none; b=DQbBCyC5fsA0Xj7l3l3zb+88EfMiRyfbCjuSpAzyJ9LP39fZ39ckNfD2MJ5NxT0xQjt7ESg+PjkY50xTHuqBB7shlwRA70IFgSuEsmonQFJILOBw1YKkOVxk9apczhAkyuN19PyjPGPIQzCQive7hNXprJ9GwsHXMZljTvQUlxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777539327; c=relaxed/simple;
	bh=Pqq8zSAcOFFR5+YaBlC+lfkekk7615G+YO4hKhKWJCU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f/C0L0WMwlL3ho7YC6lHLcjBdhU20blx9p92Jns2okucARxl8USdLBoO+RJ4NlSKEINl8VNVHzvzhse1apN3+/maY/DTeKP7c9QnB56atKHRKSfgRimo+/xuTZYYQ51A1tlVkEjL+AVbAfGU5RHwywHV2/NGotHGhJPhrhA4Ke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=sG9T6KPC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4486b5fcf3cso598709f8f.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777539323; x=1778144123; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:to:from:subject:cc
         :message-id:date:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTklDTNdxgMiOr8HV0Z6gDUQcK4MMB7dBQkYfU4NXYc=;
        b=sG9T6KPC866Z2GUGB8sKaxyruk7UrFIkcWncaHwiNWzI3GPtrpX2vLWbABrn1zff0C
         FBCLzqJU+iA18ZKv+bdPJq5sw4Dn6MoQc/5+JUngXqaw0KW4k/wR0EMQdYt1aYIVOurC
         v+45ReIUit/MbA+ap2CMIyYNoCqEHfO3eohN4LpbRwZTr8NmHUgERO4cbvrB1He995ip
         oiFRc9o7uAl4CPBh+toq6+zBVycPnPi1kGp+o/HKHsWIy0yMWRB1XekrXSoTl2uUuvm/
         KRHaaZVUHY7ijfFLaceAQh+Z54wAB1fT5XCgGkLmCWKvO4dpHRS6+zYGagcFmu4JCwTw
         R09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777539323; x=1778144123;
        h=in-reply-to:references:content-transfer-encoding:to:from:subject:cc
         :message-id:date:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTklDTNdxgMiOr8HV0Z6gDUQcK4MMB7dBQkYfU4NXYc=;
        b=JmUlpRh4J+Dv/r2Ky23ZhvZM6wH3JJOZgmpkxcXuB3CfIc66iQ7GFECOq5Qslhcx1H
         J0HMGQl0E+KVw35Ct3hDjVDl0HupTw3K8rQ/XbiXHubwj3K6xSPq5Q3qhPbhVeEoRjbb
         B8ao5LuvnXUJRT4VFHhgqGatIZxEq8YJBq67VPP9hFfsNtH2qYSIkPf+1UbCPDOfnv09
         mkwrotVOMIDIzG0k+MYIst8BkeR7uPSdFnC6fApq8nBfvgxOWOn6/+GBqO89KdccNPXx
         XgK2lsFX23cdSfEQ0kad5ztGsWztVq1l0KtHS/2bCVxSknWAlXx1WrPd8bfWy8xSzfP3
         Z7pQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IUdYKzTfDOTsV5QcefJx5MU3Wn9ujt6unx+N08JELNFp8pe3ay6KtXP4JPKOtvYzqP6FNNOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/yaQX04P+m+3F0QsuFfAKxDLI4KHvPY3KMI1KmXa8xSHgouyL
	3N3OvIqkXtVNt4sT4GAs5OdSTeW74SPxL1SJ+U/lzYZxUt5a8x34W5hyQP2FJ02W02k=
X-Gm-Gg: AeBDietCANYXu/tEHUAH67CCL7GILUJrAoFLSqtaGDjjL9nXv973vbTVu+uXHspCliI
	6ACpnDgj67FdIxHpcerQflzhdmVWAWCHDgajKU5VvpkosXzdBkHyu7m8QvztBytkC+0HzRasQxv
	2araT/qWLjer52AN5MY0xVWnaNJAFGFqinUvRxaqsEodlX4SSA3yFGivEcTynu8lWhJU8YJ777G
	0zTH/3ubtKUzKE0S+YgdS1tSc/LG4RPGKsnGAP9YWMd84IQHiR0w6/BsF3tXpKK8PCuNG/bwaKc
	vCt41c8RHGUUZNGMxUlMp6VQj3mMezWp3/Utjtrt/FTo5Rp6yieUdXrPKNMSqGyeD3OVF3cFWEG
	IzJCFNLImePZ1zitCggbBtW66jHX36riAU+vQQkwOLbx1G/XVAAVm9DELR5XRnjQI5+g+HnNhO3
	Bd1BN+FCD+LtzrxZUhlodPIMqLNHk=
X-Received: by 2002:a05:6000:26d1:b0:43e:a703:3665 with SMTP id ffacd0b85a97d-4493f42ced4mr3244142f8f.25.1777539322750;
        Thu, 30 Apr 2026 01:55:22 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:298c:ceb1:1a:f428])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca5fe6sm11988989f8f.32.2026.04.30.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 01:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=49f7733329a22fff4b83a1680bdebfd7a9830dc80234132c7fb08fa112fd;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 30 Apr 2026 10:55:14 +0200
Message-Id: <DI6D3JVJ6JG6.8V4XUVGJA2D4@baylibre.com>
Cc: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Steffen Klassert"
 <klassert@kernel.org>, "David Dillow" <dave@thedillows.org>, "Ion
 Badulescu" <ionut@badula.org>, "Mark Einon" <mark.einon@gmail.com>, "Rasesh
 Mody" <rmody@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>, "Sudarsana
 Kalluru" <skalluru@marvell.com>, "Manish Chopra" <manishc@marvell.com>,
 "Potnuri Bharat Teja" <bharat@chelsio.com>, "Denis Kirjanov"
 <kirjanov@gmail.com>, "Jijie Shao" <shaojijie@huawei.com>, "Jian Shen"
 <shenjian15@huawei.com>, "Cai Huoqing" <cai.huoqing@linux.dev>, "Fan Gong"
 <gongfan1@huawei.com>, "Tony Nguyen" <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, "Tariq Toukan"
 <tariqt@nvidia.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Mark Bloch" <mbloch@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>, "Yibo
 Dong" <dong100@mucse.com>, "Simon Horman" <horms@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, "Jiri Pirko"
 <jiri@resnulli.us>, "Francois Romieu" <romieu@fr.zoreil.com>, "Daniele
 Venzano" <venza@brownhat.org>, "Samuel Chessman" <chessman@tux.org>,
 "Jiawen Wu" <jiawenwu@trustnetic.com>, "Mengyuan Lou"
 <mengyuanlou@net-swift.com>, "Kevin Curtis" <kevin.curtis@farsite.co.uk>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>, "Stanislav Yakovlev"
 <stas.yakovlev@gmail.com>, "Richard Cochran" <richardcochran@gmail.com>,
 "Kees Cook" <kees@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Thomas
 Fourier" <fourier.thomas@gmail.com>, "Ingo Molnar" <mingo@kernel.org>,
 "Kory Maincent" <kory.maincent@bootlin.com>, "Zilin Guan"
 <zilin@seu.edu.cn>, "Marco Crivellari" <marco.crivellari@suse.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>, "Jacob Keller"
 <jacob.e.keller@intel.com>, "Philipp Stanner" <phasta@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Yeounsu Moon" <yyyynoom@gmail.com>, "Denis
 Benato" <benato.denis96@gmail.com>, "Peiyang Wang"
 <wangpeiyang1@huawei.com>, "Yonglong Liu" <liuyonglong@huawei.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>, "Yicong Hui"
 <yiconghui@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, "MD Danish
 Anwar" <danishanwar@ti.com>, "Nathan Chancellor" <nathan@kernel.org>, "Sai
 Krishna" <saikrishnag@marvell.com>, "Ethan Nelson-Moore"
 <enelsonmoore@gmail.com>, "Larysa Zaremba" <larysa.zaremba@intel.com>, "Joe
 Damato" <joe@dama.to>, "Double Lo" <double.lo@cypress.com>, "Chi-hsien Lin"
 <chi-hsien.lin@cypress.com>, "Colin Ian King" <colin.i.king@gmail.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-can@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>,
 <oss-drivers@corigine.com>, <linux-wireless@vger.kernel.org>,
 <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
 <u.kleine-koenig@baylibre.com>, "Michael Grzeschik"
 <m.grzeschik@pengutronix.de>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol"
 <mailhol@kernel.org>, "Krzysztof Halasa" <khc@pm.waw.pl>, "Johannes Berg"
 <johannes@sipsolutions.net>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: 8445949F893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,google.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[85];
	NEURAL_HAM(-0.00)[-0.989];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:mid,baylibre.com:email]

--49f7733329a22fff4b83a1680bdebfd7a9830dc80234132c7fb08fa112fd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Uwe,

On Tue Apr 28, 2026 at 7:18 PM CEST, Uwe Kleine-K=C3=B6nig (The Capable Hub=
) wrote:
> ... and PCI device helpers.
>
> The various struct pci_device_id arrays were initialized mostly by one
> the PCI_DEVICE macros and then list expressions. The latter isn't easily
> readable if you're not into PCI. Using named initializers is more
> explicit and thus easier to parse.
>
> Also use PCI_DEVICE* helper macros to assign .vendor, .device,
> .subvendor and .subdevice where appropriate and skip explicit
> assignments of 0 (which the compiler takes care of).
>
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
.com/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
>
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
> Hello,
>
> the mentioned follow-up quest allows to do
>
> 			PCI_DEVICE(0x1571, 0xa203),
> 	+		.driver_data =3D (kernel_ulong_t)&card_info_10mbit,
> 	-		.driver_data_ptr =3D &card_info_10mbit,
>
> which gets rid of a bunch of casts and so brings a little bit more type
> safety. This patch is a preparation for that.
>
> I handled all of drivers/net/ in a single patch, please tell me if I
> should split by subsystem.
>
> Best regards
> Uwe
> ---

[...]

> diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_=
can_pci.c
> index eb31ed1f9644..cb9335c1d3ea 100644
> --- a/drivers/net/can/m_can/m_can_pci.c
> +++ b/drivers/net/can/m_can/m_can_pci.c
> @@ -183,9 +183,9 @@ static SIMPLE_DEV_PM_OPS(m_can_pci_pm_ops,
>  			 m_can_pci_suspend, m_can_pci_resume);
> =20
>  static const struct pci_device_id m_can_pci_id_table[] =3D {
> -	{ PCI_VDEVICE(INTEL, 0x4bc1), M_CAN_CLOCK_FREQ_EHL, },
> -	{ PCI_VDEVICE(INTEL, 0x4bc2), M_CAN_CLOCK_FREQ_EHL, },
> -	{  }	/* Terminating Entry */
> +	{ PCI_VDEVICE(INTEL, 0x4bc1), .driver_data =3D M_CAN_CLOCK_FREQ_EHL, },
> +	{ PCI_VDEVICE(INTEL, 0x4bc2), .driver_data =3D M_CAN_CLOCK_FREQ_EHL, },
> +	{ }	/* terminating entry */

M_CAN_CLOCK_FREQ_EHL is basically hardcoded for all PCI devices since
2020. I don't think we need this driver data at all and can just drop it
and use M_CAN_CLOCK_FREQ_EHL directly in the code for the frequency.
Once a real new PCI device gets added we can see if and what driver_data
is needed.

Best
Markus

--49f7733329a22fff4b83a1680bdebfd7a9830dc80234132c7fb08fa112fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCafMY8hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPG
LAD/fzJVNBHtKblmZr7CitXNgE0iUthbQCQShJJb37V4mMgA/2HCptgFXjEqdTdF
h7pcmno1RbnSKnZ/TDh+JQ7CnAwN
=RRmw
-----END PGP SIGNATURE-----

--49f7733329a22fff4b83a1680bdebfd7a9830dc80234132c7fb08fa112fd--

