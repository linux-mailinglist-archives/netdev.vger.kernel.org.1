Return-Path: <netdev+bounces-144439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EAA9C749D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CE22843D4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D7D4C6C;
	Wed, 13 Nov 2024 14:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCR1StYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B391C695;
	Wed, 13 Nov 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508957; cv=none; b=dAbGiJKD4Wtjg98ItiaHpVfVf/daGhQQIIOrINN+7oVTwprHeXH/2BBamvQ0oOB0pyzygMk3hltgTlWwRYYFbzRNEkqIMaxOVjh1TfsS2c7sQT53oTVJQSnThrZm1zVIdrhf+D/6wCjUDW08qXEzwF2a4AyTQsAbjMLYc7SRHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508957; c=relaxed/simple;
	bh=4nJldl2tsb7DjNSPWlDcL1G4bRaAiP6fFFAhEZUMDz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxaal2ge+8yOy2dWM+3yGKrvAJhi1SfEr1hbPSq4kUA14eJ2EC9TzyGTIz/366YorywKzr1swsQxXMwcuS27CTYwBy+Hfcxc/C1rXELLt2j06gw4ps5mdLtu8w9YB4U1NjLnRVjuASy2Xmi8q0sYLMP33DypTyC6TVGVyR21jkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCR1StYq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4eac48d8so119034f8f.0;
        Wed, 13 Nov 2024 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731508953; x=1732113753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EXRuvdJJsDZqVJbSr1eZa+g0bNBPJGLJZmT9i05/bg=;
        b=DCR1StYqT9tSQaTg3av0Ywe6IJsS/E+7HOm4ys6A5uAspc6i90YqaT+lUppRAKE7i8
         asDpaISNdpad/mGgh/QvNiOwd27jO4XndI/M1GBlMqn9aWy2B1sUwXrKJC4bBqkIF//9
         3Ck6hZtRQsmVKzAj0sl3QgQodosnWb352s/05FRiZpDkytICvj4gDwyi3t5kBZY2ZD6Q
         Oka0BKFSa7CcpQdwgteXE9ZluFZ0vRcGhMphhgQea/470239Co3gkJ4D90LgAqK93V8Z
         0Ksnu2wjg52rBlKcI4o7xlombb7N6fCXalSlWErSd79ykQo204o36hUJ/n1WceMpocc6
         WKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731508953; x=1732113753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EXRuvdJJsDZqVJbSr1eZa+g0bNBPJGLJZmT9i05/bg=;
        b=gM6/zSB+O8H/mRZ7jfEpss4nVN2163QiB/Lq0Shb0Nkw846efhTCV4F01ICyRrDpUg
         k2WVcroBSBE/u8GUecAJk0xt+4P16D6yKVTUYOgIN53yLEs6jJGOOyGl+Dbc0HwcOinH
         dZLS8LZO6bYJE/KF1JBLeG9M0jxG6hOcykATQVcbF90bYNYCsj06vZfp23WGzuAH0S2W
         FXrFuaTyaxOpixzezIveX2yyIHMKxy9AG2ItSxlrsLbad2WY3XQ40mQysNoz3OlnIUNE
         rbuLBX+WUU/hZozG8OEUzPYtk8djBt57WPZXm3XF4M5oSu83xNSUAq5qpSy4jLQlJcuS
         ox8g==
X-Forwarded-Encrypted: i=1; AJvYcCUPtDTuvOKaA9Xi2/NRfaYcTLF6b6VIH8KgBpque2sdCXxmxetgTOjhCXUzLTyDTZgSGh9bh0TxVTBU@vger.kernel.org, AJvYcCUd/iBWRI48SAIrhdtYQHc7oyxliq+KXdCghliMaApUlgE2PoyFfloNx6ogyypQRd/Fvf1kOts4@vger.kernel.org, AJvYcCVGA3GFTV2t4einFsIMjXGt+KShrD+cgwWV+LZ1KCaxpFpI3xE56k0gaip8DfQNh6DwpifFz95vkuJxvgWl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqifhpb3q0jutrvWN8sIS449z2DngnmPZD1LWmOq77aNMCmC9S
	MQ15ctRWx89Td+FYsVdBZXsBQ2Eyuur6sLuRxKOu/Of9kDB91iZT
X-Google-Smtp-Source: AGHT+IF+IlngJBPGAB2mC/yn8u49IUvMkQZXPfKAehjzVLI/VB8YSaJsCxHx1adTzRqz9wjT6Wnx2A==
X-Received: by 2002:a05:6000:1445:b0:37d:4864:397f with SMTP id ffacd0b85a97d-381f1714445mr7188030f8f.3.1731508953202;
        Wed, 13 Nov 2024 06:42:33 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97fe9bsm18392883f8f.35.2024.11.13.06.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:42:31 -0800 (PST)
Date: Wed, 13 Nov 2024 16:42:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: andrew@lunn.ch, Woojung.Huh@microchip.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	marex@denx.de, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Message-ID: <20241113144229.3ff4bgsalvj7spb7@skbuf>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
 <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
 <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>

On Wed, Nov 13, 2024 at 02:12:36AM +0000, Tristram.Ha@microchip.com wrote:
> When the SFP says it supports 1000Base-T sfp_add_phy() is called by the
> SFP state machine and phylink_sfp_connect_phy() and
> phylink_sfp_config_phy() are run.  It is in the last function that the
> validation fails as the just created phy device does not initialize its
> supported and advertising fields yet.  The phy device has the
> opportunity later to fill them up if the phylink creation goes through,
> but that never happens.
> 
> A fix is to fill those fields with sfp_support like this:
> 
> @@ -3228,6 +3228,11 @@ static int phylink_sfp_config_phy(struct
>     struct phylink_link_state config;
>     int ret;
> 
> +    /* The newly created PHY device has empty settings. */
> +    if (linkmode_empty(phy->supported)) {
> +        linkmode_copy(phy->supported, pl->sfp_support);
> +        linkmode_copy(phy->advertising, pl->sfp_support);
> +    }
>     linkmode_copy(support, phy->supported);
> 
>     memset(&config, 0, sizeof(config));
> 
> The provided PCS driver from the DSA driver has an opportunity to change
> support with its validation check, but that does not look right as
> generally those checks remove certain bits from the link mode, but this
> requires completely copying new ones.  And this still does not work as
> the advertising field passed to the PCS driver has a const modifier.

I think I know what's happening, it's unfortunate it pushed you towards
wrong conclusions.

The "fix" you posted is wrong, and no, the PCS driver should not expand
the supported mask, just restrict it as you said. The phydev->supported
mask normally comes from the phy_probe() logic:

	/* Start out supporting everything. Eventually,
	 * a controller will attach, and may modify one
	 * or both of these values
	 */
	if (phydrv->features) {
		linkmode_copy(phydev->supported, phydrv->features);
		genphy_c45_read_eee_abilities(phydev);
	}
	else if (phydrv->get_features)
		err = phydrv->get_features(phydev);
	else if (phydev->is_c45)
		err = genphy_c45_pma_read_abilities(phydev);
	else
		err = genphy_read_abilities(phydev);

The SFP bus code depends strictly on sfp_sm_probe_phy() -> phy_device_register()
actually loading a precise device driver for the PHY synchronously via
phy_bus_match(). There is another lazy loading mechanism later in
phy_attach_direct(), for the Generic PHY driver:

	/* Assume that if there is no driver, that it doesn't
	 * exist, and we should use the genphy driver.
	 */

but that is too late for this code path, because as you say,
phylink_sfp_config_phy() is coded up to only call phylink_attach_phy()
if phylink_validate() succeeds. But phylink_validate() will only see a
valid phydev->supported mask with the Generic PHY driver if we let that
driver attach in phylink_attach_phy() in the first place.

Personally, I think SFP modules with embedded PHYs strictly require the
matching driver to be available to the kernel, due to that odd way in
which the Generic PHY driver is loaded, but I will let the PHY library
experts share their opinion as well.

You would be better off improving the error message, see what PHY ID you
get, then find and load the driver for it:

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7dbcbf0a4ee2..8be473a7d262 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1817,9 +1817,12 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int addr, bool is_c45)
 
 	err = sfp_add_phy(sfp->sfp_bus, phy);
 	if (err) {
+		dev_err(sfp->dev,
+			"sfp_add_phy() for PHY %s (ID 0x%.8lx) failed: %pe, maybe PHY driver not loaded?\n",
+			phydev_name(phy), (unsigned long)phy->phy_id,
+			ERR_PTR(err));
 		phy_device_remove(phy);
 		phy_device_free(phy);
-		dev_err(sfp->dev, "sfp_add_phy failed: %pe\n", ERR_PTR(err));
 		return err;
 	}
 

Chances are it's one of CONFIG_MARVELL_PHY or CONFIG_AQUANTIA_PHY.

