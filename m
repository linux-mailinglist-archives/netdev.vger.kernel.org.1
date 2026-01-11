Return-Path: <netdev+bounces-248784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B1D0E7D8
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9D4300F9FC
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B3C330656;
	Sun, 11 Jan 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NaqSwQGD"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE749330D24;
	Sun, 11 Jan 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124474; cv=fail; b=rW7bzoFomZ06AkdGNZce6pztksN3XzGLiUSDtgGcjHlhEDE6reKpBkYzMnj+/wC2uuPcSe1/0Nts4sRMYXOwFw5sVrkPEtndFnRcKFGR3qDLxGKPW4aeI1nScFTJsUSmohdMATnmxeXdyN2eXDawUQ4Nm4ZXbIsdr0qJRNBAIaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124474; c=relaxed/simple;
	bh=9uYrVeNdlAl+2cMXH9HilTG7wZuEVXq4Hsv4KTRCsiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aAJRfuyr4UZgHvdzR/gOo8+b99rCNvTu3f3yKF5TPah0BywC7un7nyFKGtKG5nS/Zt0B7pObXM1gv4tm7Gp8kpIH5L6sy023+XA3yrkb1ZHwErsSheel/E+fODWknFUx5DP2esj+FvElqDjrXrILVFHSxt0l/jZIjQJn3sBkaFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NaqSwQGD; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRPWJsHgRrmlDS9MUy/pQ7wEm1zzazuB5cD2Hwu8GUEPCaKC6DyIJKyTMpkTQWedY3to96XnrBK9CvvazSpBO1dIY6Gc94U+sbzl7SByG6idrk5ObFQMlSkAd8OYBBZvx9XLRC1Ify1D2szN3yo4Q3VJ1uGEW6atZQza6rgHF+eMxkLLzmRkWW3drdNyrr/fb0bzCviZ6jDiqCKY64Z5vcP/BK9h9WDoFfTx2uCxqLB/G3qq+xnSuyxMJyhiraDZjqMWq4su7oEUgQbdMUuCXQzOhXlEAF1dMayCUrUEcnZt/b2A8faFEM0fDDAeGMRVxEUwZ/qJ72uo3Iy6Io6utA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYOLm7GSbuvgfoLUnJbrZGdPj50GkY5zgegZwR5nsQ4=;
 b=ndh8iAOlTCJfrpHHi5PK0nIpn5ShzCjdYuzu6zWSfuPXq7KCH1nuHxuqctTcFomSapy77J26nUrlbMhVCr9PIjIETzIEFGQmbymJglYqNXuE+mrcbH06TsjkvZFpkURgNc2Qz6u+QcRK2pI5uH2HjY4S+SFHhz6xpnZHJC+F+G+hKhyK3Ey0+51OGsX49T1KBlchMX9shSf7AMler9KFXgryeu22TzloRlA4kSjjgRp2FAwOnueFaDTRNKAlqvnneikUlO/pz6/6Ms78upi0wQJuE6lQ94h/9uJbxgJpUQ1sAK/tsB3/vsvIN5L+zL0Y4a3+LO9FAqPgaKYFCuUMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYOLm7GSbuvgfoLUnJbrZGdPj50GkY5zgegZwR5nsQ4=;
 b=NaqSwQGDp4+PuSv3cJmxLQwxL2Sioi1N2w8Rn+nBVv8slp2AoBro1Gh4jQXuhvdlv7dOu5+te7Jr75hwz4AfudqOAicZ696c3/vqlvXXHv/qSDVBBm3iwXZmBfs34njrhMkrqIHU/z+RDsg0EnUxlwFkGUozEWorM+Y7NERYi51uKE/hxxCvV7OfpQqRJsoyBAkErMSlfktz4cW2snX6YGAl9tP8j7jFxDw/hPa39ORI9BvQTyFGWXI98r8VaSpSrAQ7lDEk7oQY83QBsyFZiciiVdNeOuPbJPhY3VRmWXHd1Qc1ihPvz1Obr2YIBHb6pWBpTWCU7rGcXFp3cEQnXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 09:41:01 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 09:41:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 net-next 02/10] dt-bindings: phy-common-props: create a reusable "protocol-names" definition
Date: Sun, 11 Jan 2026 11:39:31 +0200
Message-ID: <20260111093940.975359-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260111093940.975359-1-vladimir.oltean@nxp.com>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 59149fab-ffbc-4f50-bbfa-08de50f587d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzdwSzdnZHIwV0E5TkFocHR6NlNWWWZ5WFJIMFJ1WG1IUVpQa3NyM3dlMzlz?=
 =?utf-8?B?OG5uVjZEd0liYUZaK3djMGVJaXQ5eDhYMWx6ZC9hMFpGR0t1NEQ5RDdpTE5B?=
 =?utf-8?B?bnl2MWtNZ2ZmSk5LK1F3QkNJK1E1Zzk5UlBvb1UwRkpwVld6T3VPcjRWWGF5?=
 =?utf-8?B?by84QU52WnUyNGp4SG04YkxYZ3dqdVFBMk5TbXB3L0ZDbkw0U081WnJwS2Iz?=
 =?utf-8?B?VXNUODhDbGJCaFNJVSsyVnovLzcrZnNiUVh4QSs0YlBKQzlFWXU1azFBQ2w4?=
 =?utf-8?B?ZitwQUsxSzR6T2JDT1M5d2Vka0RtQ0RHK0tEdXNYWUxjWXExTUM0emRaaSt2?=
 =?utf-8?B?TzdjdklHV04wRlNMRktpQkVaSWtPT2Ryd1JkWU4xQWhUMVRFTzlRb3g5T2pP?=
 =?utf-8?B?RjdFVnVMSERnaUJlVEw3bnpNNTBiRjNRUForVDFscUYvQ1BKK09BSXNvdW0r?=
 =?utf-8?B?aGlLeVpaQWJHSnk0NTU2bW1pWEdSZDYvY1d0Ui9QQUJRTU5laytzT1lNTWly?=
 =?utf-8?B?emMxM1FMeG5wQVNNZDFxQ0VDVSs0emEycHlRQjRmRWdHOC9HMnlSbGFnN0NL?=
 =?utf-8?B?dGxndWIxMzdCcC9EY1VXQ3pSL0xxc1ZscHJIT1BZeTZOcyt5Ry9rQVU4bzRh?=
 =?utf-8?B?TVVsWmp1SWdqMXRSUjBnWjIra2hISlFuSUI4VlZVTGpCc3JUQktEcEpSNk9U?=
 =?utf-8?B?YW1mWnpwTnYveENXWC9RQXV4V3c1cGtsblU4WnNpOFNSSnRCK3YvbGVyaE9r?=
 =?utf-8?B?czJhQWNhcTgraE5ZK1JWMUZSRzBKQlZqcFRtdktEM0ZtQi84NDNTU1pZdHpW?=
 =?utf-8?B?QlpGS2NmUk1TbFNmaXJQTDJUT3dPTzFqV2U5ZXdPN1k4aEwvS3lDSk5LaUNL?=
 =?utf-8?B?SUY1ZnNJeUlCN2tZMnNnZHhhVzFLZlRjdDVKbnA2OUNXNmtIejBLL09ueE5v?=
 =?utf-8?B?TWdaTnAzRVpCaEZMdDMxUkRIbWdzelp1Nkg0UEJ0VktjSHVKaDBpRFJwQ0Rk?=
 =?utf-8?B?U0lIZjRmeWFtR3pxbXE5QjZOSFVxTjYzSExiTGk3bFJhMkhkV004ekd2R3ph?=
 =?utf-8?B?MkxBM3JoY0NXNG9pVUsvaEtjRjB6VU8zQ2V2WERBQ0NVMGVBRFk1Z3ByVGVL?=
 =?utf-8?B?SS9SaXlpMldaWEZ1SVA4YVQzTTMrSGlEbXBIMnkxalgrbWtOU1pLVmYzVXMv?=
 =?utf-8?B?TTFkK1FkZE1TY3JvT1d3NUljWjBWQlhqSlVSeXplSElpNzgxcUdMODlTTFFk?=
 =?utf-8?B?czluSzJvQ1J1ZzZpL0lTNmtGMS96dEFmRUs0UUIrMjJpV053dzBWUFNxT3RG?=
 =?utf-8?B?Zy9vOVFsVlV2TjNjc0NqWHBMZHZWUFRZUGdaL0UxaUpyWWlKV2JSaUNudFVm?=
 =?utf-8?B?OGZCOC9BQTkxQkNtUVhJSXBsUkVlQnhOb011bmJaMTdlRHk2TzZCK2FoSmND?=
 =?utf-8?B?c21NYzVubmhVWnlweFBKdmoySk1wNUhjWWE5Lzd1RnF6dU80RE01Y21JNUJV?=
 =?utf-8?B?b3pCVzFuOG1vZGZRL2IyNmxCMVFvWERYOWpHNUVOZTJqSlI3Tmpjbm1XcFVQ?=
 =?utf-8?B?MkREZVRYc05RWi9qU2JpZjdJMEl1ZkZ4dVg4WTlIMFBtS1NFaDNIY0YwSWJK?=
 =?utf-8?B?Z01zRzBoWXozUHBlZU9BSmRVbkdMbDBjTGFyT3FEaWduQ2hUUmVvK1NJRisw?=
 =?utf-8?B?dWMrR0dYUFVVZXJOdW52NTM2Y2pyZWdMNWhWTU5lUm4xTnE1MXhNbGtaZ2xK?=
 =?utf-8?B?UktyaXVpME9pWmV1ano3c2ZrVU5sMHZvMDF0VmNIaTdEU1JlUUE5WnJiWFdv?=
 =?utf-8?B?MitkdXRsc1NLVTlpR0p2TlR2UG5vTlI1a2tvWHlOam5PZmt0ZVowdlk4RmtR?=
 =?utf-8?B?THN6RUJtS0lPZ05GZzl4T3pJNDRCQWdMVlIrS3VCOVJLeWlPNUVHYTNneUpK?=
 =?utf-8?Q?YKZcqN4nQd0AappAN7u00/v+S9XnN2tu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkYwTmx4cnJmd21pQzJsalJsbGsyOWxEaFNuQUN3OXFVbWZ5N1l0MHRaV1pB?=
 =?utf-8?B?SGEvOWwrZ1NNWlhraU15NFFkS29scFpRczRpdVpVUW1CbnBnU1BrKzhPNkQ2?=
 =?utf-8?B?bGhSK3pOQ1BNN29kZkZNcmwrc1htTmd4OEVzQzgxWkNGTFhnbGlnaWJGN1lC?=
 =?utf-8?B?TFZMZDRXVmdBZEExWFdhNDEzTlFIMTBHQnlya1hXekYxVXZxSmVzSlh3VWZ1?=
 =?utf-8?B?amJmTXVHVTlISWRIRnU4aFhPbTdtd1hrUEJ6ZmRGdk5aUTdlVnFQSEwvU0hK?=
 =?utf-8?B?TFllS2tVM0F2NFpWTVlPbFltZnMzc0ZOTkJHemgzYVM4c0M3TTFic21kblNU?=
 =?utf-8?B?RFZ4c3V3RlVDeFBaSm9EZmovejU3b0JBdkgrTFVBbENQYWg3V1lObGljOFl0?=
 =?utf-8?B?dXo0amZCdktBWHpNSDNvK1VvczU3YUNNOU1lMEN2cmxDTW42Rys3alRnalpU?=
 =?utf-8?B?NEs4V2UzQ25UcVBqcjFIV0NxRG96djNWR1hYRFFoUnpNZ3R5a2RXK2J3ekJW?=
 =?utf-8?B?VVRxd2NCVDBQcllxZ2VzWVpLYjl3VnFGelJhQnhabytKRUI1M2ZWMlg4cmFP?=
 =?utf-8?B?SHowczRQdDVPUFE5OWIvKzRwSFFGaUs2bkVqZTJlUGtYbENKSnJ0UFk2QWZw?=
 =?utf-8?B?ZDBQaHNlWU85QkcydVV5akpSVy9PNWVSVTdJS2pJdGMrc2ZrdDN6NFBnU2VV?=
 =?utf-8?B?VGdZZHJkTzArRXEyTEorNGNCenlHdldaV1BObk4xSEwzY0FhOXQrcmZTUEUr?=
 =?utf-8?B?dDBPdVRqV3JOSlY3eloxQlF0dzNRUzYwenQvTU0ybVB5YUxZdTFVNStSTTcy?=
 =?utf-8?B?T2VkL3U5aFhndVk4dUpSbDVocEJ6RjVyODJpa0pWOUQ4YTlTUEd1NUllTTZX?=
 =?utf-8?B?VkVwbTljRVR4Wnl2cDV5bXhJei9MQnl2dDVGK1lqVVQ3dlh5YXNBeFZsZG5F?=
 =?utf-8?B?NUZ5cEFHOEhHSVdGWjdCK0VaWllvVnhhVTBLZy9HeE1xS0FyNkxTeG90VGlP?=
 =?utf-8?B?YVZaREVvb0ljZ2duS3kvZ1FEVjNSeUxQeExRV3FhQklySXA4Vk9telZXL2xq?=
 =?utf-8?B?M2tsNTNDUmdZMDNVd0IraUpsWDBlb200QmsyQitxb0x1elBCK0ZoNjFINFFm?=
 =?utf-8?B?Q1ltTWdrSmZGeGt5OEpTOXFBcTY2Ymp6WmZic3hSSTJFM29Jby9zQjRDTStI?=
 =?utf-8?B?eVk2NGdpcXRsbUtpMmtDNWVGeTF4L0VHK1VYb0dySzNSVEJsNWVNR0RSVm5G?=
 =?utf-8?B?cWJUTUlRTnhiMDdCVXZvM0hMa0Fsby9VS1RtN3F0dk15QitCSm82bWRMRGhM?=
 =?utf-8?B?WHZtVTJrUUpvQkdHRS9mR2orb3U2NVhuNlgrbTFxSjBuNUxhazMvc0VFamt2?=
 =?utf-8?B?QW1oLzJrQ1ZCMjdXYXZUamFnaCs3OUg2TTZCSDZqMndGNU5iT2VhSzAwVCt2?=
 =?utf-8?B?UHdMU3pBUGRWSnJhSHZOd1lvdnY2NnFDWk1lRmdTTHc3cGZ1Nit6NFc4TUY5?=
 =?utf-8?B?KzQ0UnQ0WkNiVUIvTkhlRFVOWTNlclZrSWtHWE9Tc2JBV2IyWFJjRzN1dVpD?=
 =?utf-8?B?YlJiR0d6bkJkdlVBZnhCNmZONndCOGlNYXlMbGxiS2UrVmQyREpZQ216QVNq?=
 =?utf-8?B?b3lrN1c4aTFLNkVzYWdSR0I5TE55bWU2RUVHc3ovc01oWWZPSGF2TnZNTEhU?=
 =?utf-8?B?NE8rbXBTcThWRVRXR3ZTL0JUL3lxZ1Fpcm9SdEdoYkpNdFg1Z21FTEthc25a?=
 =?utf-8?B?bXFYRDA2ZEdCM3htSVlMajdoZDRiU2J4V3FzMGlNREdtMk85dmVtT3BqMmhj?=
 =?utf-8?B?ZGZaelpscXRPajFRb2NOMDViSFVHN3p4Tm5xUnEybUFNZkxuaW8ybXQ3RkZI?=
 =?utf-8?B?b01hcmJ4aTd2MVcxa0k3dTdKellKalFFTmlMUFFNZ2orT2ZXYzJkMHNnMnlu?=
 =?utf-8?B?blRHUlQ4QktxU29VcVVQaDFPZnpmb2F3QndRL2RnOHd6ckFaNE0rUTV1eGVL?=
 =?utf-8?B?ejdyNE5DV2ZNTk5TVDh2WklxVDRVMnJBN0hCUXdvb1lFZUZTeXhHVERZRzRi?=
 =?utf-8?B?b1ZMZFR4YllTVDZxUXhlU2RwNC95b3hVQW5JU3FHSHYraWxNdEttVjU3Uy9F?=
 =?utf-8?B?UDdicWVxWEs4VHEveE1Eb3FuanhOQmpydHBxMDd6STFXcHNDbmpIQmdUaXhU?=
 =?utf-8?B?Ny9pTyt0eEo3Z25OOGdyd1VyOENxU0M4TTMvOFQrOGs0VHBqVFoycVVMUWs5?=
 =?utf-8?B?R0tkbXlvb1llR3RXYmtpTHRyRkpZYmE2ZmVFMkV5UU5DL0hQbmhTem9zbGhx?=
 =?utf-8?B?QVJ2S2ZtckFoOFdNUkNWYUtlYjltOTdKZWpmY3BPMmc5ZVRsdDc2QWZPU044?=
 =?utf-8?Q?CN95N31yiAnajCIJ/kE4r0uE2AU1a7wt+koHKKwd44aTd?=
X-MS-Exchange-AntiSpam-MessageData-1: BrNBU5zvODkjzSKlaakcP9ONPnYTmyjrStk=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59149fab-ffbc-4f50-bbfa-08de50f587d4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:41:01.0292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hacXbvOzg32NmUw9zhEG+HF8wdLGcg6tbrqqvSuOqBaqXZ6NHtbfsHiKexijPGOtKMoIme3O0SGMN9ffjG89Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592

Other properties also need to be defined per protocol than just
tx-p2p-microvolt-names. Create a common definition to avoid copying a 55
line property.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v1->v3: none

 .../bindings/phy/phy-common-props.yaml        | 34 +++++++++++--------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-common-props.yaml b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
index 255205ac09cd..775f4dfe3cc3 100644
--- a/Documentation/devicetree/bindings/phy/phy-common-props.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-common-props.yaml
@@ -13,22 +13,12 @@ description:
 maintainers:
   - Marek Behún <kabel@kernel.org>
 
-properties:
-  tx-p2p-microvolt:
+$defs:
+  protocol-names:
     description:
-      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
-      contains multiple values for various PHY modes, the
-      'tx-p2p-microvolt-names' property must be provided and contain
-      corresponding mode names.
-
-  tx-p2p-microvolt-names:
-    description: |
-      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
-      property. Required only if multiple voltages are provided.
-
-      If a value of 'default' is provided, the system should use it for any PHY
-      mode that is otherwise not defined here. If 'default' is not provided, the
-      system should use manufacturer default value.
+      Names of the PHY modes. If a value of 'default' is provided, the system
+      should use it for any PHY mode that is otherwise not defined here. If
+      'default' is not provided, the system should use manufacturer default value.
     minItems: 1
     maxItems: 16
     items:
@@ -89,6 +79,20 @@ properties:
         - mipi-dphy-univ
         - mipi-dphy-v2.5-univ
 
+properties:
+  tx-p2p-microvolt:
+    description:
+      Transmit amplitude voltages in microvolts, peak-to-peak. If this property
+      contains multiple values for various PHY modes, the
+      'tx-p2p-microvolt-names' property must be provided and contain
+      corresponding mode names.
+
+  tx-p2p-microvolt-names:
+    description:
+      Names of the modes corresponding to voltages in the 'tx-p2p-microvolt'
+      property. Required only if multiple voltages are provided.
+    $ref: "#/$defs/protocol-names"
+
 dependencies:
   tx-p2p-microvolt-names: [ tx-p2p-microvolt ]
 
-- 
2.43.0


