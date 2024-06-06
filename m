Return-Path: <netdev+bounces-101343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A89AD8FE309
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1711C25B34
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443F1534F8;
	Thu,  6 Jun 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UtkMX31l"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B45152539
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666629; cv=none; b=VeYbZ3g0v75+I+Hst8JX0nH4Z4DP6DqsZ8bsq9lisSp5yemLx7LiRVQgc0LL52ACTl/8+xt7todPOMd6VX/VSUNPa1Qg28exFT2TQgunbY/ar/4MDmoXHHUP1Wz7Ke5Hc84rqvcFvGpwdhNJ7+AFoo/AhfVTnWLDkBdv72HOeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666629; c=relaxed/simple;
	bh=xTTIYixtLSx2m8xY+3KJpRqwGgYn0oT/i1dlhnCfkFw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ICfjYwXcxql1MRpPEOoOllvgLacr5k/Y16AB+lsM4c0GQjpZIMe0dyQeJHq/Fp2Pf0/dCpy6H4b8jCdE1Gu+G0cTxgFp9UI8+Edt5eVjSEiV80SsFpCeKQfgwVNQP9y76c5bKDl7oj6jQDZEwTyl0dE5EIktlsJEFMmMm6W7lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UtkMX31l; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240606093706epoutp0157874df8f049146441a6eb96b2e47aa6~WYLI110I43119031190epoutp01E
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240606093706epoutp0157874df8f049146441a6eb96b2e47aa6~WYLI110I43119031190epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717666626;
	bh=45WDpUR0X4DlKfKQr2X7lRg7DCBxZPhC8VOd7tCaDCs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=UtkMX31lO2tILFd5M0hYeYH/R0PW6Rn4Y+qy1KX7MddytdS9TpSgJWJYb0pxBzd3s
	 FjPuiEMfE4N0c/rEH6RUQP+Q5t6LGoozz/oCkFYwms5Q+nIygersMw6f0Ko0+2T41i
	 vZ7zuaQ0CiVMRa18Ks40cxUWg81s9Tk+pFR74X2Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240606093705epcas5p23be08ce067bed85f29b9565cf02cdbe6~WYLID_8os0694306943epcas5p2J;
	Thu,  6 Jun 2024 09:37:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VvzkR6FX8z4x9Q0; Thu,  6 Jun
	2024 09:37:03 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.9F.10035.F3381666; Thu,  6 Jun 2024 18:37:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240606091542epcas5p21d9386e9daa7b8096854ec90dab00641~WX4c_KYOw1406414064epcas5p2r;
	Thu,  6 Jun 2024 09:15:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240606091542epsmtrp2371cd3b597aca24f7fa1bfd403aa7c8d~WX4c9DwI62889428894epsmtrp2e;
	Thu,  6 Jun 2024 09:15:42 +0000 (GMT)
X-AuditID: b6c32a4b-b11fa70000002733-0a-6661833fa1dd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.79.08336.E3E71666; Thu,  6 Jun 2024 18:15:42 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240606091539epsmtip2e29edf6f3187c9291085f01af5427f60~WX4Z5pO_02115121151epsmtip2o;
	Thu,  6 Jun 2024 09:15:38 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "'Chandrasekar R'"
	<rcsekar@samsung.com>, "'Suresh Siddha'" <ssiddha@tesla.com>
In-Reply-To: <baa64cff-885a-2ecb-8a0f-3b820e55e1b8@linaro.org>
Subject: RE: [PATCH v3 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Thu, 6 Jun 2024 14:44:40 +0530
Message-ID: <000101dab7f2$1aa41320$4fec3960$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAI1Xm+tAnXeS/UBtEgXlQItlRKeAfep2IOxp2VR0A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVAbVRzH3WySDYV0tinHAyzGpdqCAyEQ4gsW6GVnHVqHGbUdazVuyXJI
	SGI2XB4VWxhKbdMyg9hEiimjxdIDDcdgaAADbREQ8AhCpRRoGa4KKKVDcEATQrX/fX7f9/u+
	3/Hm8VBBIRbAS1PpaK2KUhLcdez61pAtYfHHqOSIDnsYdEyWInC4vJ4LL1u7WbCsJ58Nv2jr
	5sCxG6MYHKqY4UD9xAgKrdN1GOyt13Og+W4fB45MHYC/WMq48GxPEwuWL1/hwBsmX/iw8z4C
	K+oeYHBk7hoGjb0NHNjWNYHCAmsbBiuGTZztfmTtxQEWOXa6DiO/M97GSJM5kzRXFXHJwb5r
	XLLmy4/I2SY7l9TXViFkbfM8Qq4cPYeR8+agRK+D6dtSaUpBa4W0KkmtSFOlxBIJr8h3yaOl
	EeIwsQw+TwhVVAYdS+zemxi2J03pnJoQZlHKTKeUSDEMIYrbplVn6mhhqprRxRK0RqHUSDTh
	DJXBZKpSwlW0LkYcEREZ7Ux8Oz21/egkpmmJyakaTclDbopOIDwewCWgZNTrBLKOJ8AbETDY
	b2C5g78QMHZ6ei14iIA/5xzOwGPVsXx1YJUFuBUBs+Phbp5AQPfyqs7FQ0GFvglzmb3xThQs
	9F5CXAcovoKAyp/fdLEHHgdOFdhWDRvxPcDUW8p2MRvfDDp+MqOu9vi4DEzU+bhkPr4B/GC4
	x3Zf8xy4cH4adfcjBI6xCxwXe+P7wUp5Nded4weuO06irh4A3ugBlgzfcNyG3WCxy4y5eSOY
	ulm7xgFgfsbKdbMcXNLb2W5OBbeXitf0eNDyaxnb1RuKh4Bqi8gtbwKfdlxlueuuB6f+vre2
	Kz5oKH/EwWB5um/tSn9Q/9UsdgYhjI+NZnxsNONjIxj/r2ZC2FWIP61hMlJoJloTpaKz/3vt
	JHWGGVn9EaEJDcjo8Fy4DWHxEBsCeCjhzX+ZkScL+Aoq9z1aq5ZrM5U0Y0OinesuRgN8ktTO
	L6XSycUSWYREKpVKZFFSMeHHny44pxDgKZSOTqdpDa195GPxPALyWKJ0wuIVnB0ozy3a8kcg
	bsxiqcYX4oMLxDtrgj7eO/NtIeF7J/qNBUN7VOR2wy2RMNdeJN3kL1Cq+zrjnq3dEXfcx6zo
	DkpbFK3/+rBfF9kY13yo+aIm57cS/f0Pl6go2aH0+NJQWPhZq+b7gYL9n8hqks4IhVMs5e+2
	l7b2+1QNGk6+u4+gtvrme3meX0wefqG/svKfD3Kmzx6Z22d/J0u/OWb8yaFC21si0665vPeZ
	wOr2FwlJSPyGkhC0LvHuU6N3nvB5uvh6U83yq8GX+a/nZzsGLDbm8GsOzQPrcc2RFsux/s4S
	u+ek0OI1cMVzZ37bgVvGyGeWPscSpoYSeloPsn8k2EwqJQ5FtQz1L0mh746aBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7bCSvK5dXWKaQd9CXoufL6cxWjyYt43N
	Ys3ec0wWc863sFjMP3KO1eLpsUfsFvcWvWO16HvxkNli7+ut7BYXtvWxWmx6fI3V4uGrcIvL
	u+awWcw4v4/JYt7ftawWxxaIWXw7/YbRYtHWL+wWDz/sYbeYdWEHq8WRMy+YLVr3HmG3WPRg
	AauDuMeWlTeZPJ72b2X32DnrLrvHgk2lHptWdbJ53Lm2h81j85J6j/f7rrJ59G1ZxeixZf9n
	Ro9/TXPZPT5vkgvgieKySUnNySxLLdK3S+DKuPnKuqDNsmJiUy9rA2OjXhcjJ4eEgInE33U3
	mboYuTiEBHYzSmy69IkdIiEp8al5KiuELSyx8t9zdoiiZ4wSB1sXsYAk2AS0JBb17QNLiAjc
	Zpb4s343G4jDLNDCJNFw4BgzRMtlJonjh/+xgbRwCthJ9LYeYgKxhQXcJBZcmAY2ikVAReLU
	xU1ADRwcvAKWEi+2ioKEeQUEJU7OfAJWwiygLfH05lM4e9nC18wQ5ylI/Hy6DOxUEYEwiX/z
	1rNB1IhLHP3ZwzyBUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al
	6yXn525iBKcLLc0djNtXfdA7xMjEwXiIUYKDWUmE1684Pk2INyWxsiq1KD++qDQntfgQozQH
	i5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDU5sSU0jE71vnJWPD1n9Uc460iur0kv+st+d4
	nIz9pQWWtgubLtiwMv9deTNyTWhR+oLN9c0MiY9Mnj5tSLnz8p/X8zMczt/kKldEp5+cmt3h
	cOGoKesJh7sRWrriJm90rrS/7+zes6mx0yBWN+zHuScJi8++a/ESPKd3iev0K2sG6W/tb9i1
	HsXXWuSGLHEr4kzNVzI5U5Un8DJq+teahX+lphT2s+jNtHja5i4dPvf0kTcFFr9eSeVqx7dO
	fZ9zsvLU1dSloeW5asc42h7X1fofqrFWeWLod6l8g9qDzjm6Is/L/wtKWIp9c/r3V9NLd4f2
	VTH94snb3Z+kbUxl3HRV6URXYoGxx/9GDnUlluKMREMt5qLiRACASreIhgMAAA==
X-CMS-MailID: 20240606091542epcas5p21d9386e9daa7b8096854ec90dab00641
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
	<CGME20230814112612epcas5p275cffb4d3dae86c6090ca246083631c4@epcas5p2.samsung.com>
	<20230814112539.70453-3-sriranjani.p@samsung.com>
	<b224ccaf-d70f-8f65-4b2f-6f4798841558@linaro.org>
	<001201d9d00c$5413a9a0$fc3afce0$@samsung.com>
	<baa64cff-885a-2ecb-8a0f-3b820e55e1b8@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 18 August 2023 14:57
> To: Sriranjani P <sriranjani.p=40samsung.com>; davem=40davemloft.net;
> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> conor+dt=40kernel.org; richardcochran=40gmail.com;
> alexandre.torgue=40foss.st.com; joabreu=40synopsys.com;
> mcoquelin.stm32=40gmail.com; alim.akhtar=40samsung.com; linux-
> fsd=40tesla.com; pankaj.dubey=40samsung.com; swathi.ks=40samsung.com;
> ravi.patel=40samsung.com
> Cc: netdev=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; 'Chandrasekar R' <rcsekar=40samsung.com>;
> 'Suresh Siddha' <ssiddha=40tesla.com>
> Subject: Re: =5BPATCH v3 2/4=5D net: stmmac: dwc-qos: Add FSD EQoS suppor=
t
>=20
> On 16/08/2023 08:38, Sriranjani P wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=
=5D
> >> Sent: 15 August 2023 01:21
> >> To: Sriranjani P <sriranjani.p=40samsung.com>; davem=40davemloft.net;
> >> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> >> robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> >> conor+dt=40kernel.org; richardcochran=40gmail.com;
> >> alexandre.torgue=40foss.st.com; joabreu=40synopsys.com;
> >> mcoquelin.stm32=40gmail.com; alim.akhtar=40samsung.com; linux-
> >> fsd=40tesla.com; pankaj.dubey=40samsung.com; swathi.ks=40samsung.com;
> >> ravi.patel=40samsung.com
> >> Cc: netdev=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> >> kernel=40vger.kernel.org; linux-samsung-soc=40vger.kernel.org; linux-a=
rm-
> >> kernel=40lists.infradead.org; Chandrasekar R <rcsekar=40samsung.com>;
> >> Suresh Siddha <ssiddha=40tesla.com>
> >> Subject: Re: =5BPATCH v3 2/4=5D net: stmmac: dwc-qos: Add FSD EQoS
> >> support
> >>
> >> On 14/08/2023 13:25, Sriranjani P wrote:
> >>> The FSD SoC contains two instance of the Synopsys DWC ethernet QOS
> >>> IP
> >> core.
> >>> The binding that it uses is slightly different from existing ones
> >>> because of the integration (clocks, resets).
> >>>
> >>> For FSD SoC, a mux switch is needed between internal and external
> clocks.
> >>> By default after reset internal clock is used but for receiving
> >>> packets properly, external clock is needed. Mux switch to external
> >>> clock happens only when the external clock is present.
> >>>
> >>> Signed-off-by: Chandrasekar R <rcsekar=40samsung.com>
> >>> Signed-off-by: Suresh Siddha <ssiddha=40tesla.com>
> >>> Signed-off-by: Swathi K S <swathi.ks=40samsung.com>
> >>> Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> >>> ---
> >>
> >>
> >>> +static int dwc_eqos_setup_rxclock(struct platform_device *pdev, int
> >>> +ins_num) =7B
> >>> +	struct device_node *np =3D pdev->dev.of_node;
> >>> +	struct regmap *syscon;
> >>> +	unsigned int reg;
> >>> +
> >>> +	if (np && of_property_read_bool(np, =22fsd-rx-clock-skew=22)) =7B
> >>> +		syscon =3D syscon_regmap_lookup_by_phandle_args(np,
> >>> +							      =22fsd-rx-clock-
> >> skew=22,
> >>> +							      1, &reg);
> >>> +		if (IS_ERR(syscon)) =7B
> >>> +			dev_err(&pdev->dev,
> >>> +				=22couldn't get the rx-clock-skew syscon=21=5Cn=22);
> >>> +			return PTR_ERR(syscon);
> >>> +		=7D
> >>> +
> >>> +		regmap_write(syscon, reg, rx_clock_skew_val=5Bins_num=5D);
> >>> +	=7D
> >>> +
> >>> +	return 0;
> >>> +=7D
> >>> +
> >>> +static int fsd_eqos_clk_init(struct fsd_eqos_plat_data *plat,
> >>> +			     struct plat_stmmacenet_data *data) =7B
> >>> +	int ret =3D 0, i;
> >>> +
> >>> +	const struct fsd_eqos_variant *fsd_eqos_v_data =3D
> >>> +						plat->fsd_eqos_inst_var;
> >>> +
> >>> +	plat->clks =3D devm_kcalloc(plat->dev, fsd_eqos_v_data->num_clks,
> >>> +				  sizeof(*plat->clks), GFP_KERNEL);
> >>> +	if (=21plat->clks)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	for (i =3D 0; i < fsd_eqos_v_data->num_clks; i++)
> >>> +		plat->clks=5Bi=5D.id =3D fsd_eqos_v_data->clk_list=5Bi=5D;
> >>> +
> >>> +	ret =3D devm_clk_bulk_get(plat->dev, fsd_eqos_v_data->num_clks,
> >>> +				plat->clks);
> >>
> >> Instead of duplicating entire clock management with existing code,
> >> you should extend/rework existing one.
> >>
> >> This code is unfortunately great example how not to stuff vendor code
> >> into upstream project. :(
> >
> > I will check again if I can extend existing one to support FSD platform
> specific requirement.
> >
> >>
> >>> +
> >>> +	return ret;
> >>> +=7D
> >>> +
> >>> +static int fsd_clks_endisable(void *priv, bool enabled) =7B
> >>> +	int ret, num_clks;
> >>> +	struct fsd_eqos_plat_data *plat =3D priv;
> >>> +
> >>> +	num_clks =3D plat->fsd_eqos_inst_var->num_clks;
> >>> +
> >>> +	if (enabled) =7B
> >>> +		ret =3D clk_bulk_prepare_enable(num_clks, plat->clks);
> >>> +		if (ret) =7B
> >>> +			dev_err(plat->dev, =22Clock enable failed, err =3D %d=5Cn=22,
> >> ret);
> >>> +			return ret;
> >>> +		=7D
> >>> +	=7D else =7B
> >>> +		clk_bulk_disable_unprepare(num_clks, plat->clks);
> >>> +	=7D
> >>> +
> >>> +	return 0;
> >>> +=7D
> >>> +
> >>> +static int fsd_eqos_probe(struct platform_device *pdev,
> >>> +			  struct plat_stmmacenet_data *data,
> >>> +			  struct stmmac_resources *res)
> >>> +=7B
> >>> +	struct fsd_eqos_plat_data *priv_plat;
> >>> +	struct device_node *np =3D pdev->dev.of_node;
> >>> +	int ret =3D 0;
> >>> +
> >>> +	priv_plat =3D devm_kzalloc(&pdev->dev, sizeof(*priv_plat),
> >> GFP_KERNEL);
> >>> +	if (=21priv_plat) =7B
> >>> +		ret =3D -ENOMEM;
> >>
> >> return -ENOMEM
> >
> > Will fix this in v4.
> >
> >>
> >>> +		goto error;
> >>> +	=7D
> >>> +
> >>> +	priv_plat->dev =3D &pdev->dev;
> >>> +	data->bus_id =3D of_alias_get_id(np, =22eth=22);
> >>
> >> No, you cannot do like this. Aliases are board specific and are based
> >> on labeling on the board.
> >
> > So if I understood this correctly, I need to move alias in the board
> > specific DTS file
>=20
> This part: yes
>=20
> > and I can use this, because we have to handle rx-clock-skew differently=
 for
> the two instances in the FSD platform.
>=20
> Not really. Do you expect it to work correctly if given EQoS instance rec=
eives
> different alias, e.g. 5?
>=20
> > Another approach we took in v1, by specifying the value to be programme=
d
> in rx-clock-skew property itself, but it seems it is not a preferred appr=
oach.
> > I can see that in drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +436 common code is already using this API and getting alias id, so I can
> probably use the same rather getting same again here, but I have to speci=
fy
> alias in DTS file.
>=20
> Getting alias ID is okay in general. It is used to provide user-visible I=
D of the
> devices (see mmc). Using such alias to configure hardware is abuse of the
> alias, because of the reasons I said - how is it supposed to work if alia=
s is 5
> (this is perfectly valid alias)?
>=20
> I suspect that all this is to substitute missing abstractions, like clock=
s, phys or
> resets...

Will avoid using the API to get alias id to configure the HW. Will share th=
e new implementation in v4.

>=20
> Best regards,
> Krzysztof


Regards,
Swathi


