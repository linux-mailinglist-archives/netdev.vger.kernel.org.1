Return-Path: <netdev+bounces-18609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F516757EFD
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F452811BB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05BD53A;
	Tue, 18 Jul 2023 14:07:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD00D532
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:07:13 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5161995;
	Tue, 18 Jul 2023 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689689229; x=1721225229;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iwfQy+D3lFiClOhmhcONxSk2bmidb43y8zeZMhjVWhU=;
  b=zWqIbSNysrpknBi1xi0rQvQS1MDH9QIVQq3m+UiT6Q5cPluB6MVj411A
   aVMbyla+gVeZHyk+kxhKOO4LatDpP0vFQZVl3wqtpuWo/SYlPtwudkzeI
   1IatbRXVRiGiIAMLGjnac7sroyw0h8hjwGOTdyHEvUOF8ketpRtsjsVuW
   nljyKvoGJ6UR9+0zK+/GI4yHeIlYoeig8U/A0Tu45OfqO2n6tg1ht9ml2
   yFPzjtz3G6h/zJ3qfMNwm2PH+5qZesX5I280kOGTRo7nJZ8WuRAdGKxy+
   kMxpXE4qDiQtA1A2JUcmQNX8d4OKk2Tct+LOMwPfu/RpyWnBWQANyV2OT
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="225243545"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2023 07:07:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 18 Jul 2023 07:07:05 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 18 Jul 2023 07:06:59 -0700
Message-ID: <ed54b9213e698872fb862efb43c3cd2b8852baba.camel@microchip.com>
Subject: Re: [PATCH v8 net-next 08/12] net: sparx5: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Maxim Georgiev <glipus@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, =?ISO-8859-1?Q?K=F6ry?= Maincent
	<kory.maincent@bootlin.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Gerhard Engleder
	<gerhard@engleder-embedded.com>, Hangbin Liu <liuhangbin@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Jay Vosburgh <j.vosburgh@gmail.com>,
	"Andy Gospodarek" <andy@greyhouse.net>, Wei Fang <wei.fang@nxp.com>, Shenwei
 Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux
 Team <linux-imx@nxp.com>, <UNGLinuxDriver@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	Simon Horman <simon.horman@corigine.com>, Casper Andersson
	<casper.casan@gmail.com>, Sergey Organov <sorganov@gmail.com>, Michal Kubecek
	<mkubecek@suse.cz>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Date: Tue, 18 Jul 2023 16:06:58 +0200
In-Reply-To: <20230717152709.574773-9-vladimir.oltean@nxp.com>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
	 <20230717152709.574773-9-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Vladimir,

On Mon, 2023-07-17 at 18:27 +0300, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> The hardware timestamping through ndo_eth_ioctl() is going away.
> Convert the sparx5 driver to the new API before that can be removed.
>=20
> After removing the timestamping logic from sparx5_port_ioctl(), the rest
> is equivalent to phy_do_ioctl().
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes in v8:
> - Use phy_do_ioctl()
> Changes in v7:
> - Patch is new
>=20
>=20

...[snip]...

> =C2=A0static void sparx5_ptp_classify(struct sparx5_port *port, struct sk=
_buff
> *skb,
> --
> 2.34.1
>=20

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

BR
Steen

