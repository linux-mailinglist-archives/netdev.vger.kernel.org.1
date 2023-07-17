Return-Path: <netdev+bounces-18254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0665A756107
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F021C20AC6
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA2947B;
	Mon, 17 Jul 2023 11:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AE8498
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:03:02 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497DC1B9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:03:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992b27e1c55so574463666b.2
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689591780; x=1692183780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgoLYWaSKc2mbAcixOIMOql0Fl6CCq9h3fuNBhDrdPg=;
        b=XUxpqRCgP/QfEE5+50rfgUmLVgZppyg9rz0TkOxGieyUshAyRkFbDqkNXKJDCdDLLT
         euUbmohRIQ7icRB8r1gVXhuzfJeHaP6THVx/AME0rn5UVI1vhvI31amlkBZKPPxZIuqa
         cUwCnQXN41ZeoHRT/7bfDeEst3TQnSeThiQrxiAe+1YS7+vDpqPRvTaWxbnnZn/Rjm+4
         MjLtGESJeOu8jueZlMYJ9GIsZIaOm8ONOUj+mjlc4WBe66pmN1cYdcFt4dS3Evzn4H62
         il+5jE92OU+jMZLgl2iRW0twbVSLj5IXEriX7/6cqSy+OxOH56taRUWv9fE1jVK5c6Id
         AfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689591780; x=1692183780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgoLYWaSKc2mbAcixOIMOql0Fl6CCq9h3fuNBhDrdPg=;
        b=RMyimbpzFjkhUQtlqKDrKIy7nClQ1A0vYPzs/ckLclseN1G3Jai0iCJpMO8TeCDfEe
         bK1q3rmbcCIdFxTlh9qAyon1Swd6buJmYX2So16+/MrH+JKnXPdSWxzlpBYxrsWrAaHr
         AMr+ilJdMpc8rxdbT2ugErpOzgkc8CPQBtC7mmANKsgY/7zU8rLjVrBLCKI2zcpmWWI+
         Djgtgy46rUf+TSjep0m03B8yi4ft+CV8QQeTsEnVbNzGYKjXBMCqojdRJYrd1n6zm6jK
         wIccfghqVPfmrnkPq5PQBLImkcuvx9nFyNg3DgIUYzezbZHU5YvJMpyFb0b5jMmLjZRm
         i6YQ==
X-Gm-Message-State: ABy/qLYidJQuRVwJLEaH9ce8JxPnnfEyq3O8SPudtVjM5YDIQeB2VgW4
	T98Ruo/XRcfBhrysQmr8XCo=
X-Google-Smtp-Source: APBJJlHlHarpF4IuMtrcAMRtfhpy8PmbKvPeiMdETpUQtEV3g1Tzpi+YzId6TLJWkVldviyiFIol3A==
X-Received: by 2002:a17:906:256:b0:993:fe68:569c with SMTP id 22-20020a170906025600b00993fe68569cmr10924522ejl.6.1689591779554;
        Mon, 17 Jul 2023 04:02:59 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906151a00b00997b6696072sm2410346ejd.206.2023.07.17.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:02:59 -0700 (PDT)
Date: Mon, 17 Jul 2023 14:02:56 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ar__n__ __NAL <arinc.unal@arinc9.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sean Wang <sean.wang@mediatek.com>,
	UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>
Subject: Re: [PATCH net-next 1/3] net: dsa: remove legacy_pre_march2020
 detection
Message-ID: <20230717110256.k6oebdhkoq5fvfvp@skbuf>
References: <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
 <ZLERQ2OBrv44Ppyc@shell.armlinux.org.uk>
 <E1qKEqN-00H0xV-Aw@rmk-PC.armlinux.org.uk>
 <E1qKEqN-00H0xV-Aw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qKEqN-00H0xV-Aw@rmk-PC.armlinux.org.uk>
 <E1qKEqN-00H0xV-Aw@rmk-PC.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 10:12:07AM +0100, Russell King (Oracle) wrote:
> All drivers are now updated for the March 2020 changes, and no longer
> make use of the mac_pcs_get_state() or mac_an_restart() operations,
> which are now NULL across all DSA drivers. All DSA drivers don't look
> at speed, duplex, pause or advertisement in their phylink_mac_config()
> method either.
> 
> Remove support for these operations from DSA, and stop marking DSA as
> a legacy driver by default.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

