Return-Path: <netdev+bounces-156105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EACA04E94
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F181887DC9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AC249EB;
	Wed,  8 Jan 2025 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcg4NnXw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C31C6BE;
	Wed,  8 Jan 2025 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736298957; cv=none; b=genPxpA4qbcUNWsKdjrTpTd6VSmGEsCzseL60ymv2UjrdRO5exEPSIt7tYfIeZ2BlyT4ArPk1kxx5kCpZy1Jipg2kfARDsoAQSpN6iO6QYh8AgOXN92mP0YVXsUvdpNrxZdpWDrC0SbNCrnivGb4au1JwJU+J5vgpuCEXr8rL+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736298957; c=relaxed/simple;
	bh=wD43T99hnDZZ1TfHbAJqtofmnbYDVr8UZRA0UkUtU5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eT4sGUDjBtoLS5rcQvNN96xz+tYJ23D/nTkFa9W5bq83HtWQzizSO39fo1VVI63sjUHHr2MR6hk0DtfJ5Dmw+BoVoNMNWehSLrKn8PMzGKrBGBvcv2j72E2A5F3RtM6HVdq5RBVUsBGUeSWRUkJycRkPU7p25S+wfyd8aS1zEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcg4NnXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EF3C4CED6;
	Wed,  8 Jan 2025 01:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736298956;
	bh=wD43T99hnDZZ1TfHbAJqtofmnbYDVr8UZRA0UkUtU5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcg4NnXwiEXuFcjkYB8pZuCu8zfuJS4pk0Ujy8cn2d9JoYJHzvJ4ohPmdfDLpuN9+
	 07gtpiRwtD+/Sk+HHKUf1ngjvbwrYYjWEslQREbtfBghq65TnJb8HgN6+h1tFH2qC4
	 I4ShebvyqYgEV/tPK2kocK7ZaibLMUdmBMenWT0narbeFCtkqhTX4Ky/MthkO2RfVi
	 q/lf267bBDqm0vWg550khk91NDHNBlUsV16l573TpNuhJlZKSOiKRYdJXna4K1MNEv
	 Ua1j6pmfAilgeaOAo9YXYRQ8Uq7Jx1CKmRJmO7ho4YFbymjYu3gkBiUox/7527iv90
	 2sqcrywk2RJQQ==
Date: Tue, 7 Jan 2025 17:15:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 08/14] net: pse-pd: Split ethtool_get_status
 into multiple callbacks
Message-ID: <20250107171554.742dcf59@kernel.org>
In-Reply-To: <20250104-b4-feature_poe_arrange-v1-8-92f804bd74ed@bootlin.com>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
	<20250104-b4-feature_poe_arrange-v1-8-92f804bd74ed@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 04 Jan 2025 23:27:33 +0100 Kory Maincent wrote:
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index f711bfd75c4d..2bdf7e72ee50 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1323,4 +1323,40 @@ struct ethtool_c33_pse_pw_limit_range {
>  	u32 min;
>  	u32 max;
>  };
> +
> +/**
> + * struct ethtool_pse_control_status - PSE control/channel status.
> + *
> + * @podl_admin_state: operational state of the PoDL PSE
> + *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
> + * @podl_pw_status: power detection status of the PoDL PSE.
> + *	IEEE 802.3-2018 30.15.1.1.3 aPoDLPSEPowerDetectionStatus:
> + * @c33_admin_state: operational state of the PSE
> + *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
> + * @c33_pw_status: power detection status of the PSE.
> + *	IEEE 802.3-2022 30.9.1.1.5 aPSEPowerDetectionStatus:
> + * @c33_pw_class: detected class of a powered PD
> + *	IEEE 802.3-2022 30.9.1.1.8 aPSEPowerClassification
> + * @c33_actual_pw: power currently delivered by the PSE in mW
> + *	IEEE 802.3-2022 30.9.1.1.23 aPSEActualPower
> + * @c33_ext_state_info: extended state information of the PSE
> + * @c33_avail_pw_limit: available power limit of the PSE in mW
> + *	IEEE 802.3-2022 145.2.5.4 pse_avail_pwr
> + * @c33_pw_limit_ranges: supported power limit configuration range. The =
driver
> + *	is in charge of the memory allocation
> + * @c33_pw_limit_nb_ranges: number of supported power limit configuration
> + *	ranges
> + */

Is there a reason this is defined in ethtool.h?

I have a weak preference towards keeping it in pse-pd/pse.h
since touching ethtool.h rebuilds bulk of networking code.
=46rom that perspective it's also suboptimal that pse-pd/pse.h
pulls in ethtool.h.

