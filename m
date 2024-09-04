Return-Path: <netdev+bounces-124893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D448B96B491
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8983C1F29171
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB801C7B93;
	Wed,  4 Sep 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l1R87CEE"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988A1C766A
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438681; cv=none; b=bXi0TL+nHN4X6v1YeB0fP4DOArS2Coa+JO11V3jry1Ye5/hByMPigKNPUhzVuToEdtGfzVPouhasrWp8RGVbbGMEUzUSs9cMUmuigQmWUpH9/J8RzHCa3EafCULYdii9sXpiyTdm53r4Lh7yELNk5/SRRqW4sn4hkEczc3ivlbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438681; c=relaxed/simple;
	bh=5pgjtpjUtnZoOwptDjPJigWHbMdNWv0GlE6gtoZvEbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WYlOYrGh1tfFWeuWbXBBK7zZkJmhKBCE7TFglm2RXT5HIZfDbL9SbSTwwEPZNI+a2F95zYJSHyOSXr0utNCF2J+O+FxDbGQsoiorLyPr8nJBKnT1+NREDC8N4SdJggWJ6ueDvOxIDXRdoypSZBd3dkGv0R5z1mmCJ5Rb4PntUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l1R87CEE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4848U4f2069537;
	Wed, 4 Sep 2024 03:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725438604;
	bh=G29POPG0UZlJhsuL6jpWjf2R42HdJqLCC+bXbslOwLE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=l1R87CEEMM9O486HHSXHUMRqAkdTNnXCAsY0+vd2eK1FFhF41kTo5KjYu0mL+wZrW
	 8ck1FE5DCI/qzDCHwDUUR0zv4nvgnuhcGAdCnse4hHQco9eoNgWmukXHaVdKxahI7o
	 b8nf+J9YrQ4NVOCxxE4qDkPP77Ja2SlUlqtnjbY4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4848U2fG017286
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Sep 2024 03:30:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 03:30:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 03:30:02 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4848TknC097916;
	Wed, 4 Sep 2024 03:29:47 -0500
Message-ID: <01ed7b16-4ba8-470f-bdab-75e1b83b1525@ti.com>
Date: Wed, 4 Sep 2024 13:59:43 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/15] net: ti: icssg-prueth: Remove setting of
 RX software timestamp
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
        Andy Gospodarek
	<andy@greyhouse.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra
	<manishc@marvell.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Pavan Chebbi
	<pavan.chebbi@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Christian
 Benvenuti <benve@cisco.com>,
        Satish Kharat <satishkh@cisco.com>,
        Claudiu
 Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang
	<xiaoning.wang@nxp.com>,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen
 Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jijie
 Shao <shaojijie@huawei.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Marcin Wojtas
	<marcin.s.wojtas@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Geetha
 sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
        Petr
 Machata <petrm@nvidia.com>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur
	<horatiu.vultur@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon
	<daniel.machon@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Edward
 Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>,
        Carolina Jubran <cjubran@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240904074922.256275-1-gal@nvidia.com>
 <20240904074922.256275-8-gal@nvidia.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240904074922.256275-8-gal@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 04/09/24 1:19 pm, Gal Pressman wrote:
> The responsibility for reporting of RX software timestamp has moved to
> the core layer (see __ethtool_get_ts_info()), remove usage from the
> device drivers.
> 
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

For TI ICSSG driver

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Danish

