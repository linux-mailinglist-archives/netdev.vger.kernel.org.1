Return-Path: <netdev+bounces-247628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D7CFC8A1
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59A2630021D1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C1284B3B;
	Wed,  7 Jan 2026 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="ankoLIDO"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F3275B15;
	Wed,  7 Jan 2026 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773609; cv=none; b=hZr8sT6cSA0YmKMzX7B3fs6NXxoOLmZOjhwiqkvqOgGR54W29PYSSBdezRJpP9Zl8NpN2RbPYQKBqQlOSiqbXDWEWf4/lkLY2cW3ZUzLeqNFc/cdaqMa6O553DDlGhXAwAmLyGPr+dDn84+7lsyWToA44GobxaqaHuzglnfDHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773609; c=relaxed/simple;
	bh=fQ+XNO/PFxHDKCqaH5FA98OR+dK9zecdjBQiDuPaCes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r8EFRcDdTn20S1evroWK7RfUqXazdHUPmlM6sUuKoZ6J8QQCrQFJa0pxomzSZCXOYLgE8ep+m/dfXyta/QIN2lA4j9Ll6Oig1s9p2oK8yc8VDntruI95o0jWE9G6CfiYNOxc1STRAM7rrkyVWUDau6fxSyXgKe5GaGBKvO4/i70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=ankoLIDO; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=ankoLIDO;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 6078CTcF325307
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 08:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1767773549; bh=GMHhwOjApnNmIM/IGLBoV1hrqPEAl7/n8Dd5Zu2tbRI=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=ankoLIDOlBbWRMEwsPRzbCSIiwL+79ngKEnXu1Sw/jG25R6BG0iCcr78w5FCqaLGe
	 qL/S5kvI5XRfoQJA0iBOuWGsaC+rhmo2TMFDiqI9zl8XQfc9y9CM/Fniri9jDTFzTJ
	 IVvvoNkkDHUzvcXmdsNBSxYtQTJfH5vU5ssD3dH4=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 6078CTBl1975768
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 7 Jan 2026 09:12:29 +0100
Received: (nullmailer pid 651874 invoked by uid 1000);
	Wed, 07 Jan 2026 08:12:28 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Eric Woudstra <ericwouds@gmail.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: Re: [PATCH v2 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
In-Reply-To: <20260103210403.438687-6-vladimir.oltean@nxp.com> (Vladimir
	Oltean's message of "Sat, 3 Jan 2026 23:03:58 +0200")
Organization: m
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
	<20260103210403.438687-6-vladimir.oltean@nxp.com>
Date: Wed, 07 Jan 2026 09:12:28 +0100
Message-ID: <87jyxtaljn.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> +static int fwnode_get_u32_prop_for_name(struct fwnode_handle *fwnode,
> +					const char *name,
> +					const char *props_title,
> +					const char *names_title,
> +					unsigned int default_val,
> +					unsigned int *val)
> +{
> +	int err, n_props, n_names, idx =3D -1;
> +	u32 *props;
> +
> +	if (!name) {
> +		pr_err("Lookup key inside \"%s\" is mandatory\n", names_title);
> +		return -EINVAL;
> +	}
> +
> +	if (!fwnode) {
> +		*val =3D default_val;
> +		return 0;
> +	}
> +
> +	err =3D fwnode_property_count_u32(fwnode, props_title);
> +	if (err < 0)
> +		return err;
> +	if (err =3D=3D 0) {
> +		*val =3D default_val;
> +		return 0;
> +	}
> +	n_props =3D err;

I tried using this in the air_en8811h driver and started wondering if I
have misunderstood something.

The problem I have is that fwnode_property_count_u32() returns -EINVAL
if props_title is missing.  So if you have a node with the legacy
"airoha,pnswap-rx" property instead of "rx-polarity", or more common: no
polariy property at all, then we see -EINVAL returned from
phy_get_rx_polarity().  Which is propagated back to config_init() and
the phy fails to attach.  That can't be the intention?

The behaviour I expected is described by this test:


/* Test: tx-polarity property is missing */
static void phy_test_tx_polarity_is_missing(struct kunit *test)
{
	static const struct property_entry entries[] =3D {
		{}
	};
	struct fwnode_handle *node;
	unsigned int val;
	int ret;

	node =3D fwnode_create_software_node(entries, NULL);
	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, node);

	ret =3D phy_get_manual_tx_polarity(node, "sgmi", &val);
	KUNIT_EXPECT_EQ(test, ret, 0);
	KUNIT_EXPECT_EQ(test, val, PHY_POL_NORMAL);

	fwnode_remove_software_node(node);
}



Bj=C3=B8rn

