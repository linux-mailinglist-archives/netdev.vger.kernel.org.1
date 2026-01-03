Return-Path: <netdev+bounces-246685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A63CF05DA
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 22:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1121301E9B6
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE412BE639;
	Sat,  3 Jan 2026 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y2P3GZzB"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013007.outbound.protection.outlook.com [40.107.162.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF662BDC14;
	Sat,  3 Jan 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767474305; cv=fail; b=OwdUppkiBk0FhZTKDvGSFD2D2DvB4qZPoGRx22Vq6Y6qsGXjcglDjgcxkkby5LdQ7EnGwr11/zsmpEbpMnNxR4Ij4G1TTnST/d+nGqbvEHVMOjBFgp7eO78LJQfB7Lk1LUBb0H/rVeji0RAkuyi+egwS0rPtSTnMYIrR+2GMtlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767474305; c=relaxed/simple;
	bh=vdlrYNtMtg8ZbQI+Ylqtc0jl5mmI+5oBE7z2Eua2Qy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KvEis8AVYu/qQm2GSQn6uKx5ofMBfn1vn6JvcYfOXB2HdXHZIHH3+inraRwT2gEa+kg35M9Gvu2u00VOgBTyyTrZCq6VEV1VrJU2sgpNchtmnWfilYQF3L2/rD068flbFJIj6HRP8mPwXnWFfLbcqxO053lMzVCj86hlqnXCiwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y2P3GZzB; arc=fail smtp.client-ip=40.107.162.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzHQGsPhmzKRsz4vVFWKR14WPrcx2Q0oIJxV/Lek6z2NATVEoiFo1zK1Q3orE7r1FSqY5R7EaEuT/5lKpYwtmgDlNmIrLnhOsIx1ocT3CLKB0oAi8q5BaomD7dthUCWKfKyu+5laa+t/Otyhy4YmHym2Xa+/LqaMs5BcglzFX/808IBGSG5sWV46udc1b9vQorkNBrBj1NJh/i+8ZWBFmCs3XLOpnk1MwNCzWSgIXjSHyySY3HCRkKeeYnoITDGJDyu5Oc4DtFZ0AKdcp+HvBTgSIoZC7lMUZftps4B3jA/tBL9hS2gbCCbsYImy0Prxt/7GT99wqWds32B6jku2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kizdP4BCENVV8/NAIxnlypiuimzghBvo8wBQDDCP8ik=;
 b=tbRAS01nUzJ5A2/eMR4hZTM03yciUY9vxGPtIZ9+TiI+8nx64jZDF9hDPsBpK+Qqhto7JnaaMWivbHxkC18lekQO1ZxH5kjW2drLwPgUfNOoT/CfcWOiW7GRpytJtdWLK91OR1akdVdTYELpXhICXBoFF7iPGjK/M/FSupe19NXAdRkFsaDWUA59fv2ZYdi7DvMbyajMmoWddE9dPn/nhuTEhSU9GCPItwvxCdXNtblJ2gUY+mUPPccoXnLRgRhK0i182P+WKK/tK/+5KSgw4tAAhHJYSa9vsWUzZQtvGJzr4KNwIYZ/Y77Ks+r0rKkW8zEj7RV/6djufzlw17OIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kizdP4BCENVV8/NAIxnlypiuimzghBvo8wBQDDCP8ik=;
 b=Y2P3GZzBhXm+yU9Twfx7kyB6+uf7HVo9mnixa8LP2ZrHfZeTA/9/GnaoqY1IYqB2kD2wiQ9KDVl2RI8+mSfWh/PApDUN4CucZlQczZq0aoqRJuzPrqISAqwJQkfV+GhxY+4L7HkkuT1YlLxiq9SPLh+NaIM7HrPDspeRSSxbtRF8VBRx/5OlNrrUlr2t7TrWqs1fnIo+EZMJLdQmxpCdeN69V1K2k1nEIqPiijvY6vPnOLETppD63u3NonjHjUgbDBkXAPV72pgrki7TzdHOk2NkoSS8JraJ4FrjxPYe4ncwXy+gBgL4KbrGzA8CoXe8T0xI4j1VzVx1f7ia8Qt0NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com (2603:10a6:10:2db::24)
 by AS8PR04MB8088.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 21:04:55 +0000
Received: from DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d]) by DU2PR04MB8584.eurprd04.prod.outlook.com
 ([fe80::3f9d:4a01:f53c:952d%3]) with mapi id 15.20.9456.013; Sat, 3 Jan 2026
 21:04:55 +0000
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
Subject: [PATCH v2 net-next 02/10] dt-bindings: phy-common-props: create a reusable "protocol-names" definition
Date: Sat,  3 Jan 2026 23:03:55 +0200
Message-Id: <20260103210403.438687-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103210403.438687-1-vladimir.oltean@nxp.com>
References: <20260103210403.438687-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0027.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::16) To DU2PR04MB8584.eurprd04.prod.outlook.com
 (2603:10a6:10:2db::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8584:EE_|AS8PR04MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: a495f86a-af8e-46ad-88d0-08de4b0bbea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b08rS2tmWXE4cllvZHlLV2IrcitaQlptZi83RGI5SGozRHJBdSs0d01TTmtU?=
 =?utf-8?B?TjM1WUljc0NyVDFtT0FoSWVrSFMwN2FVRStCTnVvTnJ4VW5JTEV4UTA2UHBF?=
 =?utf-8?B?TGNZdUhXVTF2bFBJeDhqUVpocEZuaXRPNEYxS3VRU2VNUkhySldnWndPUDF5?=
 =?utf-8?B?VEpYaXZ0RGt2UmRGWXBOYmpmYytpc09ueWtXT1gxZmpCL3ExbzlFRjgyRHNR?=
 =?utf-8?B?Qkg4V1FnS3JjdGJnODYyNUh4QzZnQllIRnlScXJLSXZ2K1dLYlZTbUNuUTlG?=
 =?utf-8?B?dWJReHJ3U0JCSFEyQysveXc1UnVRREhGWGlNNkdOMlF2ZnJjRjNTR1hwZGZU?=
 =?utf-8?B?MnZwb2JMM3lxMjd3cXRhUzhraWFKYnJndVdGWVpudEIrVVZwTndYb2tJZEtw?=
 =?utf-8?B?WmVYWWk0Mmp3bXN0VGtyOXlFUzNHazN3RmdHbDJUM3c1M3AzeUFoU20zaUpq?=
 =?utf-8?B?TWhUMVIxR0F3UFRxS2RYMmpERktFRy94VS8yakRMSHlKU0xXbEJvSXlFaDFp?=
 =?utf-8?B?Wnp4NWNsY0YrNldSZkZBZnoxbzdTWU1ua01ldVhRb3hoL2c4SmRVWU5mSlpv?=
 =?utf-8?B?aE9EVFhqTDR4MFV0bzkrYTRIN2xFeGJXZ1VpYXlhQ0x1RUJxVzFJb2lETEVV?=
 =?utf-8?B?OGo0Z2dpNmtNMW50cjc0Vmg5c1JxVXVTencvQk5SUm1nVVdTaXlNZ1Z1NjZB?=
 =?utf-8?B?NHRTNEYzVVJ6Mk1Wd1ZhOFVJZkF6Vi9IeUwzVDF4QVl0QTFQZTkxNDRyYW9F?=
 =?utf-8?B?Qzl3QTIzVkYveUpOZGM5TEw1V0VNang0dFhQZUFqSStnR2Nvb1N1K0pzcEp5?=
 =?utf-8?B?alBsSUR6VzRlS0U1OURQcVUwUkJBNi9PbWVTZXhZaFdkTGFscWVmbTR0dUZT?=
 =?utf-8?B?WXh1Yy9pSEpUb2NBbVN6SW00cjcvbUxYOFkraUZINWYyUFF3ejFhT1JrWmtS?=
 =?utf-8?B?UWJQUlpMaTBvY2xyY3hTMVBoSmgyR00yME1BdzdROUVrRHJWSGhkZjVFYzJl?=
 =?utf-8?B?TERTZlgxdnBqOUlHRHRiVjBpei9zS0RYdmt2NFoxeWRJZTNQMzVkK2wwQk0v?=
 =?utf-8?B?cFQzaGNuTVh0MG5seWxRUGVTbXRWM3cxVWZ0QTdzZTI3SlhRaHBkUEFRVzRD?=
 =?utf-8?B?NTVYdlVLYVlYeWJ4dDhGYkNGR1R5bi8xZ3RCSXN1VHU0enRlVENuME5LWnda?=
 =?utf-8?B?anYxcXNCc0JSQUZDTGFaS05Cd0lwMmsySlR5Q3hCUm1aTmU0TTF2UExhalRS?=
 =?utf-8?B?WTI0NWl5T0tyc1Z1MmlWVmhKTktUQVBqcUhpYmF6TmN3aW1NV0szcVJzODVN?=
 =?utf-8?B?bnBxVHNISExxa0dTMzlKR0hZQitPM2paRTlmelRDR0k3cXhUWGd6SEFVVlRG?=
 =?utf-8?B?T3Q2Y25jdlUvL2FaR3VEWVYzcHQxekdqcHgvTDFyY2FQb1NVUnkydGZhMkRx?=
 =?utf-8?B?YktOM0RrK1ZWNDRQNWRCQkp1WmxwRitCV09pcXBHNnliZzlBUDRHU28yWm93?=
 =?utf-8?B?T1VxUWNKWFh4UGxmdHdWeG1UdTlROFB6NXFCZnlUa3JmbDUxbTN1eGVSMjc0?=
 =?utf-8?B?R0ZXMFRBb3BZY3lNOEgyTUQ4aksxV1Z1amsxeGtzbHVSazZDRDVTZ25FTkoz?=
 =?utf-8?B?TEpmMTM3aWpxSjdaclkrQUpiaG1nc1Q1ejdudGFrRVR0OGQwNFMyM1g3RVFq?=
 =?utf-8?B?M25Vak54Zk5KVjhmR2hKRDliOEljcE9sQ0ptZjQzMmhoMGhoM1kzRUV6bmcr?=
 =?utf-8?B?emQraisrNW04YjNXMEc3YWxieS9hWUNsTjFuVmliUVVCcXp2bTFmNEtOWUMy?=
 =?utf-8?B?a2Y1WStiU0lrV2FWbXQzMStBZmh1OFBka0QzczMzckFzcHdTUGQrZjUza2Nn?=
 =?utf-8?B?VjdlMEt5ZVE4STlZTDFHcU01N0xvcThRUlFuOXdIQ0Q0UzZGcFVjdC90YjlS?=
 =?utf-8?B?MnFnMnNQeXh2WVkxdVBOT0x1MzFQMnF1SDdhbWJua3JucHlFdG5BVjhxdWpR?=
 =?utf-8?B?UTY4L1Z2RmRRRGVONmRxS2R0VU1IK3Z2SVMvMW54S0pzNFEyU1NuaWkra3pF?=
 =?utf-8?Q?gLI7ld?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8584.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTAzSVNzVHJvQWh2NVd4WGdJMiswWW5FdklkM3lFYnRYN2tLdzFGUXZrWUZG?=
 =?utf-8?B?RnltYXRDbjZaZnFjZ0lTdUEzVlRzVitIKzRQVVk3YUFUZWZER1dDSTZkT2gw?=
 =?utf-8?B?aGNobkIzU2p3NmxDbktueFpQYm82WGlHZ0R0bWhwajVYNnlSNURZMGhEV2R0?=
 =?utf-8?B?WVRsTHE2OUtEQmcxUmpneTFqZnZvRWdyZjBvSitqdlM0VXEwNS9vcjY3Y29U?=
 =?utf-8?B?dTBYenJZUG1IQlpWM3F4dlFSTTB1dytKSVVqWCtualpWUkRGazI1aEJvR2dG?=
 =?utf-8?B?WFE2c05xKyttMkN2T012NHFoZDhzM1BTK0tIWnErN0V3SWgzRzBrOXY4am9W?=
 =?utf-8?B?YkkyL3h5d1NzMGJnUlUzUS9mdTlCSUtvaU1LRGNKYW5uRXlpVSt0c0orcm9i?=
 =?utf-8?B?L0tVZHZvQUU2bkt5OHN0SGw5WG9ZZm9ac0J2blFlanhHbTV1bW53NHdMblVE?=
 =?utf-8?B?U3FOUzBaZDZxNGcyS0htZUwzY2lTV0tGcm5oRHZaVXQ0TUVmdUYzbFhxWEdy?=
 =?utf-8?B?OHR2M2svZHhFU0Y4L3VkY29jZGtZNE50Z1BOWUx5ZWloYTlkSzdUcks0ZEFj?=
 =?utf-8?B?YWdqSGwxSFJLeWJHZ1VGMjB5Ti84TjdMY2FVYU82SlUyQVBuT0VCaGhwd0JX?=
 =?utf-8?B?TVN1eWxwY1JHWndsaWV2M0dqRm92VXpqaTBPVFZSWTFaR1NZelcxZmNJYk4x?=
 =?utf-8?B?QUdyNmQ1RWRRYWxVaTBzT2FiSUUwbWpZU3plcGd5SnEwUHpLcDlLTjBTWklK?=
 =?utf-8?B?UXRCSE9TWjBXV09vWGNOWWNrNkZrVXJLWlp3eVBpanJ2VXlvMHBCZjZpb1hG?=
 =?utf-8?B?S1dGQTk1SnBFV0YzUFhXbmc1NHVNTEFwYW1pOWRoQTVSeDhDU0F4TExzb2l2?=
 =?utf-8?B?WExYODc2K0Ywd05XQ1Nzazloa1dpd0k4VGJlTkY0Zmc1VnRwZk1HU29nWnlq?=
 =?utf-8?B?a09CN3QxVFFpclErMlpCbzRwREhsdy9NQ0k5d1EyVDJPNXF6VzJjUzRhbmdK?=
 =?utf-8?B?NlBRUWxsS3hjL2tMZmdxRCtYODYzdi9Sa2dCUVptMG5IZklGbkpERjVVc3E3?=
 =?utf-8?B?cXR3bmVueW5FNFBtUXhuQno0eXlXaW9MZDlTUE8zR2x3MzJjK2t3Ny9jckxa?=
 =?utf-8?B?QkdlUWlNZEFRZHBmMCtKQTJBTWJXWHFVYUxBeEZlSlRnTnB4NHpYaElNbUcy?=
 =?utf-8?B?UHFYVm1QczY5ektFcXNJbDBDMGFUaVNBS3hkNnFoQU8xNzlZTEdXaVNGSW12?=
 =?utf-8?B?OUhlNFBmdjZwSmp4NXgyWTZkcXg2KzFqandPSHkrb21qeTEyaTRxZ0MvdHhq?=
 =?utf-8?B?OWtWdVlWV2QrMkFwKzhYSWRrc3BiSGtzWE5ReHR1c21DSHZneGJwNUR0MDI3?=
 =?utf-8?B?NjZ1bFBxNmt5VFJLWCtDMFE4ZE1adjYxYWtFMlZVdlNibUE3Zkp4S1RnbnEx?=
 =?utf-8?B?Z0FQRFBpWWlrQzFmRGRxei9VNUJHbjRLeE9CUllsaVlxYkxyUHl1Y0owSHY1?=
 =?utf-8?B?ZXdiRzNXcVBObE9xbCtsVDZEMkZrYU5reXRkQjF0TTE5NlJLa1BlR3ZJU3Vi?=
 =?utf-8?B?L0pZSnZKc1RSU0p2R3orSERLYWt1WEtYeUUwMUMzcWI5NWlXc0p3ZmxEZ25x?=
 =?utf-8?B?T29ENnd3VGNEUDdxRzc5b2N5bCtoUndraW1VV2ZmaG5VNms3MEcwMDNCZGtC?=
 =?utf-8?B?dGpWZlFvQ0ZFNFVZTC9jbVFsS3ppVkNxejZSMHJPSWhmY0lRTDhLMzFvVnpT?=
 =?utf-8?B?b1BDZ0xnWFRmSnVVZ1FWV3UxQTNwMlB6WTkyTUJxRjVwMDBNejFTcHljOFBV?=
 =?utf-8?B?ejlMKzArOGd1MUZIcTFzRWNOQlY0UktQbXAwSi9wejlFSXdMY0l2WmRHTHNO?=
 =?utf-8?B?dm5DeFlvNGFMUDlKNFZJd3FWWXRMYUx5cHN1RnhKWGo0U2dGYVg4MFFXNWxR?=
 =?utf-8?B?cWFVVWh3V1RIR3ozREN0THU5N256SEE1czdTckNFaG9rZmZJM3hqRUNiU0Vh?=
 =?utf-8?B?RUJtdEpnRC9rOUV4U2FOSVFrNmVoeDk1eXk4Y3NFKzdSWXB3OTVLUlNGWnlx?=
 =?utf-8?B?d3pQRmdwSGV6K1ZPTkFNbWNlZ3Q3TnRKWVRpd0tZc3JDZzdSVzZvcnErVFY5?=
 =?utf-8?B?Y3JETXRSeE42cmtGcTUxQTc3bFkzVFJVVm4xajNqMUhsTmQraEdXQUJRS1Yz?=
 =?utf-8?B?Z0F0Y2ZOcTQ0U2dmWFVQT09BYldJRjc1dUhLbFEzWGdGeGJ6V0Nrc2g2d2J0?=
 =?utf-8?B?aU91RkdtV2I1UkREOGpjVnpwOTl3Mm9PdWI2SWFiLzdrNHhkeEwyMDFPbTZD?=
 =?utf-8?B?c0xialB2Wk5kYjgzcGp3dEpZWDV0K1dLQkpGSkRKMlE4K1V2Tk1od1pSWG5p?=
 =?utf-8?Q?nOM2iN3PAUc8ISdQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a495f86a-af8e-46ad-88d0-08de4b0bbea4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8584.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 21:04:55.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KfKj++SkE1flgiVIPLygAVJ2FW1nJiyP7uaGiZ9BtnuihzjQbBuYN01QXI68cB1OAGpOBA6OLQxpcikc1Sk/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8088

Other properties also need to be defined per protocol than just
tx-p2p-microvolt-names. Create a common definition to avoid copying a 55
line property.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

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
2.34.1


