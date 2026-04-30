Return-Path: <netdev+bounces-282814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL81OrVB82kGywEAu9opvQ
	(envelope-from <netdev+bounces-282814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:49:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 309744A2570
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7038C3001001
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE2E3FD123;
	Thu, 30 Apr 2026 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="ssVfO4DR";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="ssVfO4DR"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59613FA5E9;
	Thu, 30 Apr 2026 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.74
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549745; cv=fail; b=f0AIYaMMkLYBy46X0BcWhMNXU9RctLa2n3fjnTGHJvI/rkd2gaC7uI3duivV+wcPhrFDr9nKbAW50gy1hmIDA1BO/+yxzIxAgYAmwpssd968RAzjwUtc8HzRWXUVDoUoytrgnMSwKl82+rgI6YgcQ9oqWDq7LaEWoqlTyK1DgB0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549745; c=relaxed/simple;
	bh=cCbZLnZL2DcvI3LDKPd/r5EDS57KFeQZJr07Sz9hNWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9bk8gggZCOiMwrEu87LbIY4gJcJNk+Gr+081Y6UK+/f0LYbOeKxraGIt9qEtAKrxb3o+ZpPAnqxBK52YLuaqCvQGQzt7vsiDMKlduJ/dnw4okeBqfHUyeDFQUk44XSRhcJevpgMuAwPnMqhsn74dRMApwNuj1xGyLGrKdEVbMQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=ssVfO4DR; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b=ssVfO4DR; arc=fail smtp.client-ip=40.107.130.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=q3t17CUtErJlPqgXXTO4DwzQCJvWci/8F+6jbZON4lxliPqGCQCPyNbAKIaUHFSC/4PkyDOXQQJ8qTMShFX87z1z243VKwOgoTNRc5C1Gt70Nz3//5qwzb95hTJuTJme9PhTKL1cSelTv1hIZTei5AWmZfD9yHqVWn9ZosYvxVZv0KaV9DSk7KGIsa8qcCltfRBMjygKWR8Eq8wjxuP8a2od0UKFFvlfkE60eAlP5xKIlKIz6Dy2r+YFYkwlbScqX3lTfsaE9dB7W0ZaHn4Hc2rBTKIZOmeX2EfFm3sGx1of4ZR6XgOSYZWeRJHsKD/68c6Tw83xMXQ7WBrrGefgQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCbZLnZL2DcvI3LDKPd/r5EDS57KFeQZJr07Sz9hNWc=;
 b=X2ERl7PSrzx+W46cBZcFINiDvTs1rz8jvEEFoi7+UwDPvvTq4OrBcvQFJDJWWkw/3Up4Ee8l8BSGSxvuH2FzicXy0tcAOf9Kx4BBr3YDf9400PJ0HB3shfbrJKDRtlo5BeilGJQCZwZsZpbIQNYkh1n1eZU932vOnZKW4XnVO2selIQdu+KXzDHcNSC7ruwc/ba2Il5X2zZ8bICo5d7OIrRYYD3TfuTtyi+nfSF32GywvrHkKMz1hLl1OfDGcrrOeRSF2zvBV1oJ4pX8VB0RzBTWqwQbPOAHUp9kpI9AY0qgH5IL8KAra+2UnS2XI27fLxWtJ7bZVk0cfYOFGxLymg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=davemloft.net smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCbZLnZL2DcvI3LDKPd/r5EDS57KFeQZJr07Sz9hNWc=;
 b=ssVfO4DR393Vbu/81tZWoePyGG95H2iH6zVkKu1ut3eZeozACiK3NxAoEZf0aGBNQTwOhjzvU0Wvpc2BBmsjhuwGs4OWKxrxry2OmFjXNOwCaX3hhZEuMn0aFqveykKHdFmECsQVPBXeHCPTSdGFtUitcHuSH3JMn2cVMOp33DSwX9+njmo/6xAUpn1ADiCtr4NIhVQo02ijghr7N/nbU12ojybSzJ2FZ5Lmt/hQ7QPLzKTji+4dmhFzyXdu2YOWavPRxb1Pinz0R2aZNmLNtHRs6aLNWJTYFeWyl24UhQNNCJqUipmDrj56+W4qG4PwpEzRQSDJERew7svIvnNehg==
Received: from AS8P189CA0034.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:458::15)
 by GVXPR04MB10136.eurprd04.prod.outlook.com (2603:10a6:150:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:48:57 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:458:cafe::30) by AS8P189CA0034.outlook.office365.com
 (2603:10a6:20b:458::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 11:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 11:48:55 +0000
Received: from emails-6144212-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-243.eu-west-1.compute.internal [10.20.5.243])
	by mta-outgoing-dlp-291-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 973F380430;
	Thu, 30 Apr 2026 11:48:55 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Thu Apr 30 11:48:49 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQtDqVEn/C7RkdMYvsPDy/IC5swyAUMpBpLLFKfA4HxhwnFw0j2n+mS/S1G15qjP9RKcDWZS2Kjyy3B8r8Ql41pFgfy6FBnh5KhFJyOGR39vq7HU6yg+Wo/675JXHRfSdT0NIIUacsZf2GdZJNjFvGn75D9+fFDvDZ9R58xcdrIRwAEFY8kYTJayMXHP3PHG43SCpkWa7e+3w0O5r7duxp0WCcAYMrv53KZKk7IFM6otYnKuf8D5ZLY0mRQYxxPy2RfMV2BKxmojy0EQ6UQvWO6XGvoE6cw+k3nQyXOuNs6f1oE/52UIGUl6wR4lSkokceInvl8PDFHNCzchA0s0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCbZLnZL2DcvI3LDKPd/r5EDS57KFeQZJr07Sz9hNWc=;
 b=wddE1DMMO7jzVfSVVFyFyBBM9J64QsxNfJyapbFUqT54ZZIyUupaKAb/Phiqtfxy9I3BVgPGMn4zFfss78rGlqmK1kFStYlx1sLNi6U6Ny82+Dy8/qXsitrhWZ5GbzL6ZmhJ9JkFIANxECRt8sKpmXnJMEO5MLHEb0b3bN32sVq2Xgk3O1B8x6hmz8cv+Bp3FDqj8611Nnb9J6ZZCKb+70AF+VjypU/aKUoHWME4Yv2a17c4OhGe2U33Ob4RWaGsKAqzxEzRlX4aTfm+Do4bcI0nU482UiPZGFYUGxyyZqxxMsp5x6OwyBjnAHZpGdi3QJFUQwSdiX/Yf5BbrIRs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCbZLnZL2DcvI3LDKPd/r5EDS57KFeQZJr07Sz9hNWc=;
 b=ssVfO4DR393Vbu/81tZWoePyGG95H2iH6zVkKu1ut3eZeozACiK3NxAoEZf0aGBNQTwOhjzvU0Wvpc2BBmsjhuwGs4OWKxrxry2OmFjXNOwCaX3hhZEuMn0aFqveykKHdFmECsQVPBXeHCPTSdGFtUitcHuSH3JMn2cVMOp33DSwX9+njmo/6xAUpn1ADiCtr4NIhVQo02ijghr7N/nbU12ojybSzJ2FZ5Lmt/hQ7QPLzKTji+4dmhFzyXdu2YOWavPRxb1Pinz0R2aZNmLNtHRs6aLNWJTYFeWyl24UhQNNCJqUipmDrj56+W4qG4PwpEzRQSDJERew7svIvnNehg==
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 (2603:10a6:150:313::24) by DB8PR04MB7081.eurprd04.prod.outlook.com
 (2603:10a6:10:fe::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:48:45 +0000
Received: from GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b]) by GVXPR04MB12057.eurprd04.prod.outlook.com
 ([fe80::14f1:a127:2988:de5b%2]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 11:48:45 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yazan
 Shhady <yazan.shhady@solid-run.com>, Mikhail Anikin
	<mikhail.anikin@solid-run.com>, Alexander Dahl <ada@thorsis.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8dxl: Add SolidRun SoM and
 HummingBoard
Thread-Index: AQHcyB1El0M7TqUrrEi06prfauJkr7XWrZoAgCDoD4CAAACCAIAACDOA
Date: Thu, 30 Apr 2026 11:48:45 +0000
Message-ID: <75e338eb-afd2-4e2e-9b93-e9fc36871854@solid-run.com>
References: <20260409-imx8dxl-sr-som-v2-0-83ff20629ba0@solid-run.com>
 <20260409-imx8dxl-sr-som-v2-3-83ff20629ba0@solid-run.com>
 <8efbafe3-0a8a-4005-960c-e8fe62cee719@lunn.ch>
 <bd2e73c5-2e61-4ea1-ab3b-42a6573b31f8@solid-run.com>
 <20260430111924.nvwohy4nexzyiyyl@skbuf>
In-Reply-To: <20260430111924.nvwohy4nexzyiyyl@skbuf>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	GVXPR04MB12057:EE_|DB8PR04MB7081:EE_|AM4PEPF00027A5F:EE_|GVXPR04MB10136:EE_
X-MS-Office365-Filtering-Correlation-Id: 114522ae-bb98-4dd9-0142-08dea6ae7590
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 pLlWZkEmjSCwqN+PC233EG8UjIqmUBslhuat8aEvQ+G0jiBDtWUDdc4lo9xRLdhlb096lHpI1ClucmO7UTOmx/cAYAtwqfKWVUHI7WsK5+cg0ub+YakJjzAdKTsvRVmhtEE4qILZEGkCaF5oog9NI5NNAev2M2yFXi+C5aNREyAAurRI51eVgdODWlJ+RR5Xod7WYkN0oAjkh5f1cwayW8zqRh3qsEt+WLaqJFBvTi/ATRuMkZmxAysuXCiP5ydoqMQOd3RS54ImaHvLrtuoefcKXkGkUYEhsEBjfibVsND51yIqIeI9hfm/ZnMs6LshaEIOZ5Fpx74IksjBnoTUd0qsnHELqE3w2dkTMlhhZ9yH7G67HFfepk1kCIDSIV6Jc+6Tm2LeCYvZHG1WZCxJXe8m+loqPlKchNXdR3a3YHtADXPTQrhj/cPLP4j+dHvfzCzCxeL2/SZ+bIEnpvwQmQ5AiVMybx/K2Ozdt0dHAoNqhv+fOfZLsplX33fiGQ7stzlbndAwRcQtJR8qxltl51+DpdKF2rV1KOVL45pBaqvG926ABLe74xmaaNixEYqPRlhzokvVnJCiEmmpm4jJ2On6DA2Kk9Q3pHh5ej/9ByF+HDbcDfhEgIIw8cS5+lvOT7CC+kwiN3eVqRL6ID/rF0xqqI0hrCDpwSZ+LswnHUhkW6EnBGj8ankCYI4DsXPwrvQ7H88EXc6SOEuTzGgQ0qgjpU8JTM7zP4ZhzhVMiYlFTsydn2ElYXc+vk8A/cy4WJ3Flcig7CLmyud34m3XTWGIIOAGZ/Kfsn0kLE3eJzI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12057.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <307C1A4027A79848A6360CB2180F2B06@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 qUjaBeUUPXJEcJCE5QwCHn7ryPBW/Qg5W09HqFCtXEqla9xRfLknH5JhcfeemQhNhLmnhMRTMkq4otV+XZ56+CnCq4AMwwJT2ByMpfxOpfY8N0w3IB8zuCuh5GfZxe5TeSHpxUWdYIduBZoYU/54lR4b2tQTdIsii2qmt8+uWUEpkBBYHibL8o0ckZg1+sUPDiUUMpHjEpEtDejUFhE4ZtsHeSy2LUrQSiJkN+3iOvOhdaumv5H9mE5rF+nWk/K0OVPg18pVKvk8SQS7Fp1nxSOnEDr7g1VlgDzHV1m3nnWFTPYqcmehm/p1WCdBCMMdRVtmIYqf6C81vOtMDyKUeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2-6.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: ce507b75bce94c6bb1b1c032a678ff56:solidrun,office365_emails,sent,inline:32512691e92b3a6b496d43564ee1f81e
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8993b199-6f2c-4ea5-82ab-08dea6ae6f43
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|14060799003|82310400026|35042699022|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IE75ZrpB05u9QBe+OxxlTHmhsmgSvojgml8s7/P5+PrYVbsOp9VJ0raPmnpBRoigXZYtnNARx28qUMWKfRwQhKqYMPzuuOcVBOHeGhQLemGwTPZ8d8l9xiwxetJ3ixjvIsZ/YGIEfskzNRlFblPZoOST6omMXZAPkNQ6pQkljmIDdt8plcS9h++yvVCzg+Coj8XcDwR4xjewQabMi3jTLaennhxL6jbOh4ONkrYwj4UNN3bivfLxixBMcRZKJAU+EBGFn+p7+gY46WBb12qikE4Rmh8iF6eCWr6H3c+6qGYHIvzyToDObUn+zD7YgF3D0n6IeAF8vFUHWmhvB0cvE1T263G3AeOoPzZILFBeRw3rmewbgF1Ea6eu9ddlmPd7m4QIvGsNEfeTCvZ76AtVbivf9gHlIZ6ldWC2nWC1XBSE0z9/3y28sNOd99kz7ivxHV6ljfUTeaT4p8sZU4BJXj9FoGFTpWOheRbZEmh1qW9et3B4pvOJ6QJbXwi+XNYCJ7JlFqqQtZVKb2wmF6PTsIsghyLymDKYhGSB83aFq2gXdSqLR5/fi3R4Fx4fp8siOzmxEH76Xbkf1BHM2TRbOKh3e3zz4pzmj2+tjX0KtOJ2cA99Nu8TepZcMGQUFigJdbq68L4R9xeerY3m7+wSV7wxf3hUwjT7qvKZOFVL+aLxNVg87PCQyk23XudTemlW9WTPxf3pY7dM15AZzAQFf++daCYHgkNJ/8xzbfm0XWhvFWiwPIcOTonnZ4tWtusbiCTe4UNSTvMrsw6IlZ8wgw==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(14060799003)(82310400026)(35042699022)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UQLcazI9bZWWC1eybT8j9q1cVyVP7J+HlOK1X3QNorNQk0Tn87v16N79mTw6S3clUSXX+yMkdcW/ryidLjXkYKUQ6c9hZS6kFGU5csSYeqYUkglAiV2Ftq9c0YmVVcwR8oI0syBFM0ACMvALkbSbR5ljfYK39fyMAjn8huetWWU0DCfV9l2PPH4cNTCfXi1lu9z4Yjg/IdkRiA6R5kTEwmMF/N62GPGa+ax4Ku/PO2XdpWto34HpWygelkYQscizQicdtYOrEMHvnCG+I0YEFPJfxrIfzPAkcTisbmtlcwAIlxZm3tT3m6ngXLjfbs8YIKLlv6VXroNqmpSYnXTXMkjGNxMrIDK/q3W+6ip1SxJ2ngcl1G00+1hNnmw3aaLTuZ8CkE6q0pRrBJyBSMd3oGmu6UaBzSpqGROx4XxHB33Dj9qVL18JJngFf7aRBnxz
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:48:55.9139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114522ae-bb98-4dd9-0142-08dea6ae7590
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10136
X-Rspamd-Queue-Id: 309744A2570
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.94 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282814-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[25];
	R_DKIM_ALLOW(0.00)[solid-run.com:s=selector1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,nxp.com,pengutronix.de,gmail.com,davemloft.net,google.com,redhat.com,solid-run.com,thorsis.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com];
	DKIM_TRACE(0.00)[solid-run.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.511];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[solid-run.com,reject];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Spam: Yes

QW0gMzAuMDQuMjYgdW0gMTM6MTkgc2NocmllYiBWbGFkaW1pciBPbHRlYW46DQo+IE9uIFRodSwg
QXByIDMwLCAyMDI2IGF0IDExOjE3OjM2QU0gKzAwMDAsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4g
QW0gMDkuMDQuMjYgdW0gMTQ6NDYgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+Pj4gKyZlcW9zIHsN
Cj4+Pj4gKwkvKiBkZWxheXMgYXJlIGFkZGVkIGJ5IGNvbm5lY3RlZCBldGhlcm5ldC1zd2l0Y2gg
Y3B1IHBvcnQgKi8NCj4+Pj4gKwlwaHktbW9kZSA9ICJyZ21paSI7DQo+Pj4+ICsJcGluY3RybC0w
ID0gPCZlcW9zX3BpbnM+Ow0KPj4+PiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4+PiArDQo+Pj4+ICsJZml4ZWQtbGluayB7DQo+Pj4+ICsJ
CWZ1bGwtZHVwbGV4Ow0KPj4+PiArCQlzcGVlZCA9IDwxMDAwPjsNCj4+Pj4gKwl9Ow0KPj4+PiAr
fTsNCj4+Pj4gKwlldGhlcm5ldC1zd2l0Y2hAMCB7DQo+Pj4+ICsJCWNvbXBhdGlibGUgPSAibnhw
LHNqYTExMTBhIjsNCj4+Pj4gKwkJcmVnID0gPDA+Ow0KPj4+PiArCQlyZXNldC1ncGlvcyA9IDwm
bHNpb19ncGlvNCAzIEdQSU9fQUNUSVZFX0xPVz47DQo+Pj4+ICsJCXNwaS1tYXgtZnJlcXVlbmN5
ID0gPDQwMDAwMDA+Ow0KPj4+PiArDQo+Pj4+ICsJCWV0aGVybmV0LXBvcnRzIHsNCj4+Pj4gKwkJ
CSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4+PiArCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+Pj4+
ICsNCj4+Pj4gKwkJCS8qIDEwMEJhc2UtVFggb24gY29ubmVjdG9yIEoyNiAqLw0KPj4+PiArCQkJ
cG9ydEAxIHsNCj4+Pj4gKwkJCQlyZWcgPSA8MHgxPjsNCj4+Pj4gKwkJCQlsYWJlbCA9ICJsYW4x
IjsNCj4+Pj4gKwkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2hfcG9ydDFfYmFzZV90eF9waHk+Ow0K
Pj4+PiArCQkJCXBoeS1tb2RlID0gImludGVybmFsIjsNCj4+Pj4gKwkJCQlzdGF0dXMgPSAib2th
eSI7DQo+PiBkcm9wcGluZyB1bm5lY2Vzc2FyeSBzdGF0dXMgb2theSBmb3IgdjMNCj4+Pj4gKwkJ
CX07DQo+Pj4+ICsNCj4+Pj4gKwkJCS8qIENQVSAqLw0KPj4+PiArCQkJcG9ydEAyIHsNCj4+Pj4g
KwkJCQlyZWcgPSA8MHgyPjsNCj4+Pj4gKwkJCQlldGhlcm5ldCA9IDwmZXFvcz47DQo+Pj4+ICsJ
CQkJbGFiZWwgPSAiY3B1IjsNCj4gUGxlYXNlIGRyb3AgdW51c2VkIGxhYmVsID0gImNwdSIuDQpP
a2F5Lg0KPiBBbHNvLCBjYW4geW91IHVzZSB1ZGV2IGZvciB1c2VyDQo+IGludGVyZmFjZSBuYW1p
bmc/DQpQb3NzaWJseSAuLi4uIEkgYW0gYXdhcmUgb2Ygc3lzdGVtZCAodWRldikgYmFzZWQgZGVm
YXVsdCBiZWhhdmlvdXINCmZvciBuZXR3b3JrIGludGVyZmFjZSBhbGlhc2VzIChldGgwLCBldGgx
LCAuLi4pLg0KDQpIb3dldmVyIEkgaGF2ZSBub3Qgc2VlbiBpdCBmb3IgZHNhIHN3aXRjaCBwb3J0
cy4NCg0KSXQgaGFzIGJlZW4gY29tbW9uIHByYWN0aWNlIGZvciBzd2l0Y2ggcG9ydHMgdG8gYmUg
bmFtZWQgbGFuWzAtOV0rLA0KYW5kIEknZCBwcmVmZXIgdG8ga2VlcCBpdCB0aGF0IHdheSBoZXJl
IHRvby4NClByZWRpY3RhYmxlIG5hbWVzIGFyZSBpbXBvcnRhbnQgZm9yIHVzZXJzIGluIHBhcnRp
Y3VsYXIgd2hlbiBpbnRlcmZhY2VzDQphcmUgb2YgZGlmZmVyZW50IHR5cGVzIGFuZCBhdCBkaWZm
ZXJlbnQgY29ubmVjdG9ycy4NCg0KUmUuIHRoZSBUMSBwb3J0cyBuYW1lcyBJIGRpZG4ndCBrbm93
IHdoZXRoZXIgdG8gdXNlICJsYW4iIG9yICJ0cngiLg0KRm9yIHRob3NlIGlmICJsYW4iIGlzIHBy
ZWZlcnJlZCwgSSBjYW4gY2hhbmdlIHRoZW0uDQoNCj4NCj4+Pj4gKwkJCQlwaHktbW9kZSA9ICJy
Z21paS1pZCI7DQo+Pj4+ICsJCQkJcngtaW50ZXJuYWwtZGVsYXktcHMgPSA8MjAwMD47DQo+Pj4+
ICsJCQkJdHgtaW50ZXJuYWwtZGVsYXktcHMgPSA8MjAwMD47DQo+Pj4+ICsJCQkJc3RhdHVzID0g
Im9rYXkiOw0KPj4gZHJvcHBpbmcgdW5uZWNlc3Nhcnkgc3RhdHVzIG9rYXkgZm9yIHYzDQo+Pj4+
ICsNCj4+Pj4gKwkJCQlmaXhlZC1saW5rIHsNCj4+Pj4gKwkJCQkJZnVsbC1kdXBsZXg7DQo+Pj4+
ICsJCQkJCXNwZWVkID0gPDEwMDA+Ow0KPj4+PiArCQkJCX07DQo+Pj4+ICsJCQl9Ow0KPj4+PiAr
DQo+Pj4+ICsJCQkvKiBzZ21paSBvbiBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+Pj4+
ICsJCQlwb3J0QDMgew0KPj4+PiArCQkJCXJlZyA9IDwweDM+Ow0KPj4+PiArCQkJCWxhYmVsID0g
ImxhbjMiOw0KPj4+PiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+Pj4+ICsJCQl9Ow0KPj4+
PiArDQo+Pj4+ICsJCQkvKiBzZ21paSBvbiBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+
Pj4+ICsJCQlwb3J0QDQgew0KPj4+PiArCQkJCXJlZyA9IDwweDQ+Ow0KPj4+PiArCQkJCWxhYmVs
ID0gImxhbjQiOw0KPj4+PiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+Pj4+ICsJCQl9Ow0K
Pj4+PiArDQo+Pj4+ICsJCQkvKiAxMDBiYXNlLXQxIG9uIGFkZG9uIGJvYXJkIGNvbm5lY3RvciBK
MjEgKi8NCj4+Pj4gKwkJCXBvcnRANSB7DQo+Pj4+ICsJCQkJcmVnID0gPDB4NT47DQo+Pj4+ICsJ
CQkJbGFiZWwgPSAidHJ4MSI7DQo+Pj4+ICsJCQkJcGh5LWhhbmRsZSA9IDwmc3dpdGNoX3BvcnQ1
X2Jhc2VfdDFfcGh5PjsNCj4+Pj4gKwkJCQlwaHktbW9kZSA9ICJpbnRlcm5hbCI7DQo+Pj4+ICsJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+Pj4gKwkJCX07DQo+Pj4+ICsNCj4+Pj4gKwkJCS8q
IDEwMGJhc2UtdDEgb24gYWRkb24gYm9hcmQgY29ubmVjdG9yIEoyMSAqLw0KPj4+PiArCQkJcG9y
dEA2IHsNCj4+Pj4gKwkJCQlyZWcgPSA8MHg2PjsNCj4+Pj4gKwkJCQlsYWJlbCA9ICJ0cngyIjsN
Cj4+Pj4gKwkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2hfcG9ydDZfYmFzZV90MV9waHk+Ow0KPj4+
PiArCQkJCXBoeS1tb2RlID0gImludGVybmFsIjsNCj4+Pj4gKwkJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPj4+PiArCQkJfTsNCj4+Pj4gKw0KPj4+PiArCQkJLyogMTAwYmFzZS10MSBvbiBhZGRv
biBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+Pj4+ICsJCQlwb3J0QDcgew0KPj4+PiArCQkJCXJl
ZyA9IDwweDc+Ow0KPj4+PiArCQkJCWxhYmVsID0gInRyeDMiOw0KPj4+PiArCQkJCXBoeS1oYW5k
bGUgPSA8JnN3aXRjaF9wb3J0N19iYXNlX3QxX3BoeT47DQo+Pj4+ICsJCQkJcGh5LW1vZGUgPSAi
aW50ZXJuYWwiOw0KPj4+PiArCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+Pj4+ICsJCQl9Ow0K
Pj4+PiArDQo+Pj4+ICsJCQkvKiAxMDBiYXNlLXQxIG9uIGFkZG9uIGJvYXJkIGNvbm5lY3RvciBK
MjEgKi8NCj4+Pj4gKwkJCXBvcnRAOCB7DQo+Pj4+ICsJCQkJcmVnID0gPDB4OD47DQo+Pj4+ICsJ
CQkJbGFiZWwgPSAidHJ4NCI7DQo+Pj4+ICsJCQkJcGh5LWhhbmRsZSA9IDwmc3dpdGNoX3BvcnQ4
X2Jhc2VfdDFfcGh5PjsNCj4+Pj4gKwkJCQlwaHktbW9kZSA9ICJpbnRlcm5hbCI7DQo+Pj4+ICsJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+Pj4gKwkJCX07DQo+Pj4+ICsNCj4+Pj4gKwkJCS8q
IDEwMGJhc2UtdDEgb24gYWRkb24gYm9hcmQgY29ubmVjdG9yIEoyMSAqLw0KPj4+PiArCQkJcG9y
dEA5IHsNCj4+Pj4gKwkJCQlyZWcgPSA8MHg5PjsNCj4+Pj4gKwkJCQlsYWJlbCA9ICJ0cng1IjsN
Cj4+Pj4gKwkJCQlwaHktaGFuZGxlID0gPCZzd2l0Y2hfcG9ydDlfYmFzZV90MV9waHk+Ow0KPj4+
PiArCQkJCXBoeS1tb2RlID0gImludGVybmFsIjsNCj4+Pj4gKwkJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPj4+PiArCQkJfTsNCj4+Pj4gKw0KPj4+PiArCQkJLyogMTAwQmFzZS1UMSBvbiBjb25u
ZWN0b3IgSjI2ICovDQo+Pj4+ICsJCQlwb3J0QGEgew0KPj4+PiArCQkJCXJlZyA9IDwweGE+Ow0K
Pj4+PiArCQkJCWxhYmVsID0gInRyeDYiOw0KPj4+PiArCQkJCXBoeS1oYW5kbGUgPSA8JnN3aXRj
aF9wb3J0MTBfYmFzZV90MV9waHk+Ow0KPj4+PiArCQkJCXBoeS1tb2RlID0gImludGVybmFsIjsN
Cj4+Pj4gKwkJCQlzdGF0dXMgPSAib2theSI7DQo+PiBkcm9wcGluZyB1bm5lY2Vzc2FyeSBzdGF0
dXMgb2theSBmb3IgdjMNCj4+Pj4gKwkJCX07DQo+Pj4+ICsJCX07DQo+Pj4+ICsNCj4+Pj4gKwkJ
bWRpb3Mgew0KPj4+PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+Pj4+ICsJCQkjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4+Pj4gKw0KPj4+PiArCQkJbWRpb0AwIHsNCj4+Pj4gKwkJCQljb21wYXRp
YmxlID0gIm54cCxzamExMTEwLWJhc2UtdDEtbWRpbyI7DQo+Pj4+ICsJCQkJcmVnID0gPDA+Ow0K
Pj4+PiArCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4+PiArCQkJCSNzaXplLWNlbGxzID0g
PDA+Ow0KPj4+PiArDQo+Pj4+ICsJCQkJLyogMTAwYmFzZS10MSBvbiBhZGRvbiBib2FyZCBjb25u
ZWN0b3IgSjIxICovDQo+Pj4+ICsJCQkJc3dpdGNoX3BvcnQ1X2Jhc2VfdDFfcGh5OiBldGhlcm5l
dC1waHlAMSB7DQo+Pj4+ICsJCQkJCWNvbXBhdGlibGUgPSAiZXRoZXJuZXQtcGh5LWllZWU4MDIu
My1jNDUiOw0KPj4+PiArCQkJCQlyZWcgPSA8MHgxPjsNCj4+Pj4gKwkJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCj4+Pj4gKwkJCQl9Ow0KPj4+PiArDQo+Pj4+ICsJCQkJLyogMTAwYmFzZS10MSBv
biBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+Pj4+ICsJCQkJc3dpdGNoX3BvcnQ2X2Jh
c2VfdDFfcGh5OiBldGhlcm5ldC1waHlAMiB7DQo+Pj4+ICsJCQkJCWNvbXBhdGlibGUgPSAiZXRo
ZXJuZXQtcGh5LWllZWU4MDIuMy1jNDUiOw0KPj4+PiArCQkJCQlyZWcgPSA8MHgyPjsNCj4+Pj4g
KwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+Pj4gKwkJCQl9Ow0KPj4+PiArDQo+Pj4+ICsJ
CQkJLyogMTAwYmFzZS10MSBvbiBhZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+Pj4+ICsJ
CQkJc3dpdGNoX3BvcnQ3X2Jhc2VfdDFfcGh5OiBldGhlcm5ldC1waHlAMyB7DQo+Pj4+ICsJCQkJ
CWNvbXBhdGlibGUgPSAiZXRoZXJuZXQtcGh5LWllZWU4MDIuMy1jNDUiOw0KPj4+PiArCQkJCQly
ZWcgPSA8MHgzPjsNCj4+Pj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+Pj4gKwkJCQl9
Ow0KPj4+PiArDQo+Pj4+ICsJCQkJLyogMTAwYmFzZS10MSBvbiBhZGRvbiBib2FyZCBjb25uZWN0
b3IgSjIxICovDQo+Pj4+ICsJCQkJc3dpdGNoX3BvcnQ4X2Jhc2VfdDFfcGh5OiBldGhlcm5ldC1w
aHlANCB7DQo+Pj4+ICsJCQkJCWNvbXBhdGlibGUgPSAiZXRoZXJuZXQtcGh5LWllZWU4MDIuMy1j
NDUiOw0KPj4+PiArCQkJCQlyZWcgPSA8MHg0PjsNCj4+Pj4gKwkJCQkJc3RhdHVzID0gImRpc2Fi
bGVkIjsNCj4+Pj4gKwkJCQl9Ow0KPj4+PiArDQo+Pj4+ICsJCQkJLyogMTAwYmFzZS10MSBvbiBh
ZGRvbiBib2FyZCBjb25uZWN0b3IgSjIxICovDQo+Pj4+ICsJCQkJc3dpdGNoX3BvcnQ5X2Jhc2Vf
dDFfcGh5OiBldGhlcm5ldC1waHlANSB7DQo+Pj4+ICsJCQkJCWNvbXBhdGlibGUgPSAiZXRoZXJu
ZXQtcGh5LWllZWU4MDIuMy1jNDUiOw0KPj4+PiArCQkJCQlyZWcgPSA8MHg1PjsNCj4+Pj4gKwkJ
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+Pj4gKwkJCQl9Ow0KPj4+PiArDQo+Pj4+ICsJCQkJ
LyogMTAwQmFzZS1UMSBvbiBjb25uZWN0b3IgSjI2ICovDQo+Pj4+ICsJCQkJc3dpdGNoX3BvcnQx
MF9iYXNlX3QxX3BoeTogZXRoZXJuZXQtcGh5QDYgew0KPj4+PiArCQkJCQljb21wYXRpYmxlID0g
ImV0aGVybmV0LXBoeS1pZWVlODAyLjMtYzQ1IjsNCj4+Pj4gKwkJCQkJcmVnID0gPDB4Nj47DQo+
Pj4+ICsJCQkJfTsNCj4+Pj4gKwkJCX07DQo+Pj4+ICsNCj4+Pj4gKwkJCW1kaW9AMSB7DQo+Pj4+
ICsJCQkJY29tcGF0aWJsZSA9ICJueHAsc2phMTExMC1iYXNlLXR4LW1kaW8iOw0KPj4+PiArCQkJ
CXJlZyA9IDwxPjsNCj4+Pj4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+Pj4gKwkJCQkj
c2l6ZS1jZWxscyA9IDwwPjsNCj4+Pj4gKw0KPj4+PiArCQkJCS8qIDEwMEJhc2UtVFggb24gY29u
bmVjdG9yIEoyNiAqLw0KPj4+PiArCQkJCXN3aXRjaF9wb3J0MV9iYXNlX3R4X3BoeTogZXRoZXJu
ZXQtcGh5QDEgew0KPj4+PiArCQkJCQlyZWcgPSA8MHgxPjsNCj4+Pj4gKwkJCQl9Ow0KPj4+PiAr
CQkJfTsNCj4+PiBGb3IgdGhlc2Ugbm9kZXMgb25seToNCj4+Pg0KPj4+IFJldmlld2VkLWJ5OiBB
bmRyZXcgTHVubiA8YW5kcmV3QGx1bm4uY2g+DQo+Pj4NCj4+PiAgICAgQW5kcmV3DQo+PiBUaGFu
a3MhDQo+Pg0KPj4gSSBkb24ndCBrbm93IGhvdyB0byBrZWVwIHRoaXMgcGFydGlhbCByZXZpZXcg
Zm9yIHYzLCBzbyBJIHdpbGwgc2VuZCBpdCB3aXRob3V0Lg==

