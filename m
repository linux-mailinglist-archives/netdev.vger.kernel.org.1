Return-Path: <netdev+bounces-170684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFDA498C1
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F84C168C06
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D626A1AC;
	Fri, 28 Feb 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lNCuR113"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC1B25DD1F;
	Fri, 28 Feb 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744375; cv=none; b=pFEffCoFwGqnhT+aJqsD4r1SZ6qmBf9KxD/vOdilSbOS4hmjY1O8l/LfW4vl48s0QqooalVTU5L4Dr+jO1aFIFTPqycrOmcBkWWJyfSq/de0G6MzpK3O9nL0ibAUyTsxJH9p+4wXQNCwdGuf3FHHVHRgJJhRNcTKCBrap2AA1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744375; c=relaxed/simple;
	bh=xCz6URh5N68y/Bpste8IV03k10jt1dkDzC1Mga/T9Mo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=XUBJXtHh9c5fCF5hv1yz7wj0mO5In41qI2kMd1pDou+JZTcPqRDp8FpwPIjMAWXj84i3U/I9iXZd84rB8XpPBdWk6hO3ZxUZfSFPDbkdQx+qwV+0rKiUQlvMSv3le/zdfD0D3uinhQRA+3hAH6NzZVaf6b4EjPGwgve0qPt0q8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lNCuR113; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXGg1031891;
	Fri, 28 Feb 2025 12:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m4TF+meqj9oO8mFRWmIHylEZzspy0l0qdWfcYcpeo3I=; b=lNCuR113SCfv9GSo
	u/TAnOEo+Zts0vh6DlkpfG3WxvCDiOAc21E3olFSCQoyjrmGIF/LE+omrklmHJX8
	NlmmubpzdgKlZjgtb2C5qhrbZqY/ezXp1eHHLqVf8e2ZWmzh1v3eh7b1EYtygpXu
	bsTWy8IFIdXi5etVacjRW6GuyDumWKtj+jsajT9EuGGdQPCuuhd9fFlZ250S57eB
	qYNWe86k6NEsJkZ5dOSUSIcZLS8fiTq+uO2GERk1a2wkqQ9YR85+9i+WqvWb8Qpc
	DeqyWZ9BvKP/gpV//DQE58HuHm1wExxtRZ1kiNsZgYIWT9LFwvJ6e6rT5aJ9nK2V
	H2Fdng==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prksafa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 12:05:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51SC5mvs008689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 12:05:48 GMT
Received: from [10.253.35.151] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Feb
 2025 04:05:42 -0800
Message-ID: <3376db36-ffc5-480e-960a-5d808e438ce4@quicinc.com>
Date: Fri, 28 Feb 2025 20:05:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/5] Add PCS support for Qualcomm IPQ9574 SoC
From: Lei Wei <quic_leiwei@quicinc.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Jakub Kicinski
	<kuba@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_luoj@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <bartosz.golaszewski@linaro.org>,
        <vsmuthu@qti.qualcomm.com>, <john@phrozen.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250207-ipq_pcs_6-14_rc1-v5-0-be2ebec32921@quicinc.com>
 <20250211195934.47943371@kernel.org> <Z6x1xD0krK0_eycB@shell.armlinux.org.uk>
 <71a69eb6-9e24-48ab-8301-93ec3ff43cc7@quicinc.com>
Content-Language: en-US
In-Reply-To: <71a69eb6-9e24-48ab-8301-93ec3ff43cc7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: iyewhzWLqWPW0sumEXL2RcB0hnzjKbZO
X-Proofpoint-ORIG-GUID: iyewhzWLqWPW0sumEXL2RcB0hnzjKbZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280087



On 2/19/2025 6:46 PM, Lei Wei wrote:
> 
> 
> On 2/12/2025 6:19 PM, Russell King (Oracle) wrote:
>> On Tue, Feb 11, 2025 at 07:59:34PM -0800, Jakub Kicinski wrote:
>>> On Fri, 7 Feb 2025 23:53:11 +0800 Lei Wei wrote:
>>>> The 'UNIPHY' PCS block in the Qualcomm IPQ9574 SoC provides Ethernet
>>>> PCS and SerDes functions. It supports 1Gbps mode PCS and 10-Gigabit
>>>> mode PCS (XPCS) functions, and supports various interface modes for
>>>> the connectivity between the Ethernet MAC and the external PHYs/Switch.
>>>> There are three UNIPHY (PCS) instances in IPQ9574, supporting the six
>>>> Ethernet ports.
>>>>
>>>> This patch series adds base driver support for initializing the PCS,
>>>> and PCS phylink ops for managing the PCS modes/states. Support for
>>>> SGMII/QSGMII (PCS) and USXGMII (XPCS) modes is being added initially.
>>>>
>>>> The Ethernet driver which handles the MAC operations will create the
>>>> PCS instances and phylink for the MAC, by utilizing the API exported
>>>> by this driver.
>>>>
>>>> While support is being added initially for IPQ9574, the driver is
>>>> expected to be easily extendable later for other SoCs in the IPQ
>>>> family such as IPQ5332.
>>>
>>> Could someone with PHY, or even, dare I say, phylink expertise
>>> take a look here?
>>
>> I've not had the time, sorry. Looking at it now, I have lots of
>> questions over this.
>>
>> 1) clocks.
>>
>> - Patch 2 provides clocks from this driver which are exported to the
>>    NSCCC block that are then used to provide the MII clocks.
>> - Patch 3 consumes clocks from the NSCCC block for use with each PCS.
>>
>> Surely this leads to a circular dependency, where the MSCCC driver
>> can't get the clocks it needs until this driver has initialised, but
>> this driver can't get the clocks it needs for each PCS from the NSCCC
>> because the MSCCC driver needs this driver to initialise.
>>
> 
> Sorry for the delay in response. Below is a description of the 
> dependencies between the PCS/NSSCC drivers during initialization time 
> and how the clock relationships are set up. Based on this, there should 
> not any issue due to circular dependency, but please let me know if any 
> improvement is possible here given the hardware clock dependency. The 
> module loading order is as follows:
> 
> Step 1.) NSCC driver module
> Step 2.) PCS driver module
> Step 3.) Ethernet driver module
> 
> The 'UNIPHY' PCS clocks (from Serdes to NSSCC) are not needed to be 
> available at the time of registration of PCS MII clocks (NSSCC to PCS 
> MII) by the NSSCC driver (Step 1). The PCS MII clocks is registered 
> before 'UNIPHY' PCS clock is registered, since by default the parent is 
> initialized to 'xo' clock. Below is the output of clock tree on the 
> board before the PCS driver is loaded.
> 
> xo-board-clk
>      nss_cc_port1_rx_clk_src
>          nss_cc_port1_rx_div_clk_src
>              nss_cc_uniphy_port1_rx_clk
>              nss_cc_port1_rx_clk
> 
> The 'UNIPHY' PCS clock is later configured as a parent to the PCS MII 
> clock at the time when the Ethernet and PCS drivers are enabled (step3) 
> and the MAC links up. At link up time, the NSSCC driver sets the NSSCC 
> port clock rate (by configuring the divider) based on the link speed, 
> during which time the NSSCC port clock's parent is switched to 'UNIPHY' 
> PCS clock. Below is the clock tree dump after this step.
> 
> 7a00000.ethernet-pcs::rx_clk
>      nss_cc_port1_rx_clk_src
>          nss_cc_port1_rx_div_clk_src
>              nss_cc_uniphy_port1_rx_clk
>              nss_cc_port1_rx_clk
> 
>> 2) there's yet another open coded "_get" function for getting the
>> PCS given a DT node which is different from every other "_get"
>> function - this one checks the parent DT node has an appropriate
>> compatible whereas others don't. The whole poliferation of "_get"
>> methods that are specific to each PCS still needs solving, and I
>> still have the big question around what happens when the PCS driver
>> gets unbound - and whether that causes the kernel to oops. I'm also
>> not a fan of "look up the struct device and then get its driver data".
>> There is *no* locking over accessing the driver data.
>>
> 
> The PCS device in IPQ9574 chipset is built into the SoC chip and is not 
> pluggable. Also, the PCS driver module is not unloadable until the MAC 
> driver that depends on it is unloaded. Therefore, marking the driver 
> '.suppress_bind_attrs = true' to disable user unbind action may be good 
> enough to cover all possible scenarios of device going away for IPQ9574 
> PCS driver.
> 
> To avoid looking up the device and getting its driver data (which is 
> also seen in other PCS device drivers currently), a common 
> infrastructure is certainly preferable for the longer term to have a 
> consistent lookup. As far as I understand, the urgency for the common 
> infrastructure for lookup is perhaps more to resolve the issue of hot- 
> pluggable devices going away, and less for devices that do not support it.
> 
> Also, the _get() API is only called once during MAC port initialization 
> and never later, so if the device is not pluggable and unbind is not 
> possible, there may not be any race concerns when accessing the driver 
> data using the _get() API. Please let me know if this understanding is 
> incorrect.
> 
>> 3) doesn't populate supported_interfaces for the PCS - which would
>> make ipq_pcs_validate() unnecessary until patch 4 (but see 6 below.)
>>
> 
> Agree, we will update the patch to advertise 'supported interfaces' and 
> use the 'pcs_validate' op only for patch4 as you pointed (for filtering 
> half duplex modes for USXGMII.).
> [The 'pcs_validate()' was suggested by you and added in the version 3 of 
> this driver, and at that time, the pcs supported_interfaces is not 
> introduced.]
> 
>> 4)
>> "+       /* Nothing to do here as in-band autoneg mode is enabled
>> +        * by default for each PCS MII port."
>>
>> "by default" doesn't matter - what if in-band is disabled and then
>> subsequently enabled.
>>
> 
> OK, I will fix this function to handle both in-band neg enabled and 
> disabled cases in next update.
> 
>> 5) there seems to be an open-coded decision about the clock rate but
>> there's also ipq_pcs_clk_rate_get() which seems to make the same
>> decision.
>>
> 
> I think you may be referring to both ipq_pcs_config_mode() and 
> ipq_pcs_clk_rate_get() functions having the similar switch case to 
> decide the clock rate based on the interface mode. I do agree, we can 
> simplify this by saving the clock rate in ipq_pcs_config_mode() before 
> the clk_set_rate() is called, and then simply returning this clock rate 
> from the recalc_rate() op.
> 
> 
>> 6) it seems this block has N PCS, but all PCS must operate in the same
>> mode (e.g. one PCS can't operate in SGMII mode, another in USXGMII
>> mode.) Currently, the last "config" wins over previous configs across
>> all interfaces. Is this the best solution? Should we be detecting
>> conflicting configurations? Unfortunately, pcs->supported_interfaces
>> can't really be changed after the PCS is being used, so I guess
>> any such restrictions would need to go in ipq_pcs_validate() which
>> should work fine - although it would mean that a MAC populating
>> its phylink_config->supported_interfaces using pcs->supported_interfaces
>> may end up with too many interface bits set.
>>
> 
> I would like to clarify on the hardware supported configurations for the
> UNIPHY PCS hardware instances. [Note: There are three instances of 
> 'UNIPHY PCS' in IPQ9574. However we take the example here for PCS0]
> 
> UNIPHY PCS0 --> pcs0_mii0..pcs0_mii4 (5 PCS MII channels maximum).
> Possible combinations: QSGMII (4x 1 SGMII)
>              PSGMII (5 x 1 SGMII),
>              SGMII (1 x 1 SGMII)
>              USXGMII (1 x 1 USXGMII)
> 
> As we can see above, different PCS channels in a 'UNIPHY' PCS block 
> working in different PHY interface modes is not supported by the 
> hardware. So, it might not be necessary to detect that conflict. If the 
> interface mode changes from one to another, the same interface mode is 
> applicable to all the PCS channels that are associated with the UNIPHY 
> PCS block.
> 
> Below is an example of a DTS configuration which depicts one board 
> configuration where one 'UNIPHY' (PCS0) is connected with a QCA8075 Quad 
> PHY, it has 4 MII channels enabled and connected with 4 PPE MAC ports, 
> and all the PCS MII channels are in QSGMII mode. For the 'UNIPHY' 
> connected with single SGMII or USXGMII PHY (PCS1), only one MII channel 
> is enabled and connected with one PPE MAC port.
> 
> PHY:
> &mdio {
>      ethernet-phy-package@0 {
>                  compatible = "qcom,qca8075-package";
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  reg = <0x10>;
>                  qcom,package-mode = "qsgmii";
> 
>                  phy0: ethernet-phy@10 {
>                          reg = <0x10>;
>                  };
> 
>                  phy1: ethernet-phy@11 {
>                          reg = <0x11>;
>                  };
> 
>                  phy2: ethernet-phy@12 {
>                          reg = <0x12>;
>                  };
> 
>                  phy3: ethernet-phy@13 {
>                          reg = <0x13>;
>                  };
>      };
>      phy4: ethernet-phy@8 {
>                  compatible ="ethernet-phy-ieee802.3-c45";
>                  reg = <8>;
>          };
> }
> 
> PCS:
> pcs0: ethernet-pcs@7a00000 {
>      ......
>      pcs0_mii0: pcs-mii@0 {
>          reg = <0>;
>          status = "enabled";
>      };
> 
>      ......
> 
>      pcs0_mii3: pcs-mii@3 {
>          reg = <3>;
>          status = "enabled";
>      };
> };
> 
> pcs1: ethernet-pcs@7a10000 {
>      ......
> 
>      pcs1_mii0: pcs-mii@0 {
>          reg = <0>;
>          status = "enabled";
>      };
> };
> 
> MAC:
> port@1 {
>      phy-mode = "qsgmii";
>      phy-handle = <&phy0>;
>      pcs-handle = <&pcs0_mii0>;
> }
> 
> port@2 {
>      phy-mode = "qsgmii";
>      phy-handle = <&phy1>;
>      pcs-handle = <&pcs0_mii1>;
> }
> port@3 {
>      phy-mode = "qsgmii";
>      phy-handle = <&phy2>;
>      pcs-handle = <&pcs0_mii2>;
> }
> port@4 {
>      phy-mode = "qsgmii";
>      phy-handle = <&phy3>;
>      pcs-handle = <&pcs0_mii3>;
> }
> port@5 {
>          phy-mode = "usxgmii";
>          phy-handle = <&phy4>;
>          pcs-handle = <&pcs1_mii0>;
> }
> 
>> (1), (2) and (6) are probably the major issues at the moment, and (2)
>> has been around for a while.
>>
>> Given (1), I'm just left wondering whether this has been runtime
>> tested, and how the driver model's driver dependencies cope with it
>> if the NSCCC driver is both a clock consumer of/provider to this
>> driver.
>>
> 
> Yes, I have tested the PCS driver along with NSSCC driver and PPE 
> Ethernet driver.

Hi Russell,
Gentle reminder, to review my responses and provide your comments. Thank 
you in advance.

