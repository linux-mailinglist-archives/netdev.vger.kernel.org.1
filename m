Return-Path: <netdev+bounces-109259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481C92797E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0746E28984B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9B1B143A;
	Thu,  4 Jul 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="k0kQeAjR"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA71B11E9;
	Thu,  4 Jul 2024 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105434; cv=fail; b=Ru3ZGlqsEFJ07henbp2yhHTbbRKw0XTGddm7csiu5AoH68jyBOixEF2fdVGBYtXL/tttWOWr7MbEly6deqoyQrf6zP2rBB8p35YmRlDdbxdcgmJnwWHn1rW81imSNCb0YBC+h4ZIuDTzdITXEtQOMQ40eZcSJBhEF8q4sHxhf+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105434; c=relaxed/simple;
	bh=TjqY5poStO6rZ9XUcYuW1uk2taLdDumd2hFUIavQPV4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Duy0yeITvdRbXCfsn9LUSOIFrxc8Ve3aInm7ej2QRQ0zd7Ffj5JnT7G+WH+Qs4G1adssrp8yY+l+aYZwpqWqlgq8UD+zV7snsuJZ4DfJyCGjPEPUQ5K2a6tC8LfMEolTiOpOXm3JgJNNFAlnQEsqVufozEa31Hjdgg4YzlFHDpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=k0kQeAjR; arc=fail smtp.client-ip=40.107.20.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3LH7LX+B4A/OCLklLHGtvH1LZTpZdBJSqGQ+Hoo1vgfHPvVKsPtvk5ffct8og8pvUS4saPI/Tp9AhzUaWv7hUlGoRFUybl+AJH46antARywQkIAjrnhFM0MkGG9ZDnB9IU7ZBMjrPDX+as7bmfYO5/QXX7i/V7VVqYkEEOnQwIurbcdSZreLrrfutJDgT1MFt0JzRjYSQSJ/cXLoUIpn0unfS1WM4tTtnv7LnT+8oPWt2DC6pmBlM+KVv4rKFAPfeYR7T6gFdxgtBA8QxgWzaSyGsjJDj2gtqVBwD1P2cv9udwpNjABROcrWtGxCGevhAt9fPStzIcr3xMXjASADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5UHay0sun3GYifzFmxig3whsD1MbfqU+nn+/IfF07g=;
 b=A1Tu2FQMN0RUHFIR6hcnFzGWz2q5aVLLVTAhSaM+3XwZ2AIoVe4nBpTg+awS3bKT7NaSys9hjF5ADmQCkZisuRtpZDtCJZru+Y8ehRq/rTVDU03WDG15uOcoIkZuJ8xXFxeCegszVZt0fHDcp5uesvKo8F/XjCSffnZ2xWHz/VfZH+0D5/rVACkGUw3qMZiiDa+R2W/zwzZEbF5yS1l0XOvH74eKRPPINaQwJavqaOB1tNln8DZU58+PW1KKMMWBTwsxatNB1W2b/gDZJnc1NHNfIOBvWtWXESx2b7337PxYq1VfHqDYsxGHJiMca6Cjkbh8f8bRGF+/MDZqAlpBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5UHay0sun3GYifzFmxig3whsD1MbfqU+nn+/IfF07g=;
 b=k0kQeAjRxaC2LgXWTN8B2vNTLJ0uZ+cpOosF824SzFMUXbSMO7DEgjzKklcG/PawopGtJ8Sa4tOJwkW2nc8AuG+aqfXkK1jc36CAR1EwreXinik0fUKFDnJbieBa/tiM8TJCdDoLnZI14FZzzgGxIo28xZBAoOgoDzL9QPh42DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI2PR04MB10714.eurprd04.prod.outlook.com (2603:10a6:800:26d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 15:03:46 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 15:03:46 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jul 2024 17:03:22 +0200
Subject: [PATCH v7 4/5] arm64: dts: add description for solidrun cn9131
 solidwan board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-cn9130-som-v7-4-eea606ba5faa@solid-run.com>
References: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
In-Reply-To: <20240704-cn9130-som-v7-0-eea606ba5faa@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::7) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|VI2PR04MB10714:EE_
X-MS-Office365-Filtering-Correlation-Id: d3255fc3-4af0-45ca-1ebc-08dc9c3a80f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXM2aTZheVVUMGFiYjc2WHRwTWNTV2QvZFZCTnpEV2NCSkhFRjhVTjc1MTAw?=
 =?utf-8?B?TUdFQmlJQ096R1pTTTlmaU00Y1NMU0tFSXFMempqRGsrdmlLeVlxTzBsRHY5?=
 =?utf-8?B?RXlEa0dQNmcvNTAyQ0xGZDRENm9UU09memVMVmdUSzg3TWRyWUttOG5Oc2t0?=
 =?utf-8?B?Y25qYTFpbDB5eVdCZVo3VFp0Z3M3OWZ3c1hrR09TaFZrR2ZlZi9jZkJYRkZJ?=
 =?utf-8?B?cjFwSGg0ek9yeE9VWVFDSldSUjYwWElxRXI1d1pabFNrSkZISTFSK3BoSHRp?=
 =?utf-8?B?cUcxa0xsdjNkMDBhYVFvQUJZMmdaTUM2SnFLNS90QXc2S09pZkJCSXUxanIw?=
 =?utf-8?B?aFFrOW9hdEQvQnFoWWJiWVNrZWhwbUdRekxLTk55a3pUT3lVTWR1b0tVTzg4?=
 =?utf-8?B?QzNQd2lUNEJuMS9zMGYrZktqa1FmbU1yNlVIS0tlR2d4ZVNsanpMbURFMk5O?=
 =?utf-8?B?Y0tiZnIwTmUxdmJ4emplQUhRU2hncElXS2diRzFNTDhvYUtEK2ZKR1dJcUIy?=
 =?utf-8?B?bWFOL1FYM1I3VkdSN2llUy9FTXpSYURFWHpwNnJXaG9KeVdXRGc4bnN1YzV3?=
 =?utf-8?B?UVdQeEhJQjJGdUhzUkVjNHE2SlZJai9ydExTckJuREpoOUR0aUdUc0lYdWQ5?=
 =?utf-8?B?WjZhMmlLVlBmT21ua3hhT1RsSVRNc0lzNkRnKzlGUTA3dVlyejlTTDd4VDlQ?=
 =?utf-8?B?am5XQk1HdFlpOGNRN242bUJLNDNncE1QTk12cEg2czBrTkJUcEtKZUozRVh1?=
 =?utf-8?B?eHd1T2VQTTVJZytLZkxmQ3V3eDl2dGJZWXRsRjdhb0E0K1dENXBYeUx4ZHpD?=
 =?utf-8?B?V25PcHNmalJSemxkMHJPbDAvQXRubk1Xdm1KZzZHS2IzK1BZMW9hUjZCeEVy?=
 =?utf-8?B?TitEb3VYbmVMaFRybDI3MzRMZzI2WGRFeTBxOWppUjJOcVdrUEpHVGttVDBw?=
 =?utf-8?B?WFpzQkNFWFhpUzZoNU94L0hUS2lqdGV3ZnltNmxyeGhVeWVuYnlnKzdzL0sy?=
 =?utf-8?B?V29JbFd5djBtMVlReGRsSDZGL2dhKzJGTG9vMUoybVYwSDBVTkFZL2tkVk11?=
 =?utf-8?B?V2J3SHNOOGNUL2NvRjN1Qlc0a2dkTUVvNUxzWWVTWlZncWZaZjJCWVdRWmJo?=
 =?utf-8?B?TW13Qlo4bklqY29jTUdDenJVSEtNMHo5N3RHNHY0cHpUdHdVWnRiQk9QRUpR?=
 =?utf-8?B?YnYxRWxQYmdYTXdLc25Famdzc2dROW1mazZpVm5JM2s5a2xLWkxMZ016WXFh?=
 =?utf-8?B?NXJTdVhrajB0U2hZTitOU3dZM0xLTlpmKzJQZWNNdDlFbGZYRU9DUDQ5b2dF?=
 =?utf-8?B?NXk3NUZ5MUhkWm1GLzNDRno4dHYwcGRyMDRHVTJzVi9XTy83M3RSeUhOeFpU?=
 =?utf-8?B?NmVnaHg4dGpxeSt1UEdVa1BTLzNhRjBla0drVmtPQ1dqQjdGeHdzVE12OS85?=
 =?utf-8?B?aGRSY2NiSzFGY0xUa2w3SEtUSGRwSmNmR0xJYmFsTGY1VHl6cnE0WWlKRWtv?=
 =?utf-8?B?dmdjb0tGTFdldkErenNITU9RTnhhdHBJMXFzc0NLK29rMmMvOTkrcGo2OUJs?=
 =?utf-8?B?TWxXdnd0cnVKMmEzcFd1T2NKaFl6NUJCQ2U1bWtFTy93SUNyK2VoNHI3TTdV?=
 =?utf-8?B?cmlSTTJMRWNRVkhrdkdvMzVjS052Q2hocGRlSS9MS2YrZmQ5ZXFkTVdLR084?=
 =?utf-8?B?emdINVgxQ0d6b3RBV3lka1Jpa2FSWHlmSUVBZ2F6U2lvWTR3OTQvcHFkVXU0?=
 =?utf-8?B?UzdWQzhYamV0RndJRHhQSGk2MEhyVUszMXNLK1MrL3p1bFZzZ1NacGl4a2c4?=
 =?utf-8?B?dG9OMTluekd0RGNYWGp0YlVyc21hdUMwSkFKaXp5V2tTS0FNMk9ORytpWDcx?=
 =?utf-8?B?T2poenZJK2lteXVBUTdkN1UzUzlsZTJCMDh6S3JwSjczaUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWVVWVdiOTZzbDBlWUtmblltcThjdjA4ZVlKRTdqUC9sRFdnK0dQaWx6VGgr?=
 =?utf-8?B?WEIwenB5N0JEekNnRDZzZ2xzbnI3K0xHNmZhSDZQaW1YNG5QMnNKOEI0VXVv?=
 =?utf-8?B?b3BFTGQ3ekx5aVpkQzMzVEIzWWduOXdNOHE1SG1YTTR2bENIRll1NnV6RUUz?=
 =?utf-8?B?ekp0aVZjcW5JM1hDMGFJWGxWaHZMZTdidGd2Tjc3ZE82MlFTN3FMQmQ1ek9J?=
 =?utf-8?B?SWFqYVNzSlVwaHJBSG9sR1hNYWYya3VmbUdlMTBaQmlSa3Z1VGdDZnVwbjUv?=
 =?utf-8?B?N2hQL252VUU5TWFsMVo2Z2NyWHZIKzBjaVlEQmpDTnY4VWNQb3ZzclZjVk5G?=
 =?utf-8?B?QmZSUWJJdk5MeTVVM0g0THRJS3VsaDRiSVlYYURhVGVhVDB4QmkraTJwMlBi?=
 =?utf-8?B?SCtxT1gyd2s2ODVwK3MrZEQvUC9YckhMc1BOekhVTE1QWDM4QzdPSVhkdys0?=
 =?utf-8?B?Q3FzZ1cwbzkreUxCeHVqdUtwUGswNW92WGs3Qk5QblVNUXVPb0pwMjZMeG55?=
 =?utf-8?B?ZXFQeFdCdDYzeUdxUG9JYzg3dnpQSmtaQjJvUXp2TlFCcTJFbDlkd3hSTkoz?=
 =?utf-8?B?V2MwMUVqNXNKbU80UmhxUzhCalpwaTlmV0Vwb1VyZ2pjRk02TFYzNVRBeWNP?=
 =?utf-8?B?b2J1L3M2cTNhb1NXNmpRZktkbEd5NktEWEttMjlmcjJFUUk1L2xEKzZVOEJn?=
 =?utf-8?B?MVhLNkJmSnpoajBhblcrZDhMQlg0VmtHUzRIbmhKRkwvdDR4NmFRS0szT3Jt?=
 =?utf-8?B?c21Qa0ErbE1kRi9xSi9rUG9WV2oxVkhKa2E4RG12c3lRMVp4dnFNUkxvaU52?=
 =?utf-8?B?NmZOUHE1R0ZXL3FrL0U4NHVKVkNXQXBBeFBudDRxWW1LWDkyQjB2MkRhc2sr?=
 =?utf-8?B?NU9keXBlbWRRZERPMEJUK1NIU2VvZy9nZmlJSytYTG03amhRQ1d5dkFxR1I2?=
 =?utf-8?B?bnlEdS9KSk1pemQ0OUZxdFM3ajc1VEszWGlQdU1FZG1ueDR6Y3lZOXljMURs?=
 =?utf-8?B?SUdSa3VVSEExTHZzcEt3enpWVEVTL2p6ZjBBSE1OT3h6YWhtRm1yWWJmTk5s?=
 =?utf-8?B?TmxhMWg5a0htd3J2bVlaT2ZoODdCakNJRmh1ZTNqN1ZVbjZaWjZsVk1rUkJO?=
 =?utf-8?B?TWRRSkRtbDlacE4zRE9YY21WY1FrcVc3MSs1WWl1OWc4NlpIVHJuVVBSS0JV?=
 =?utf-8?B?bEEyVjArY1M5eE40bGtOUVVBMyt2TU1oRE4xemE2TUhoWnFFVTBKbm9HbVJq?=
 =?utf-8?B?ZjY1Y2FvU0pnQmNVMk9OUVNrb1c4d2x0MkVwaUVOY1c1WS8wenBvUy9IY0ww?=
 =?utf-8?B?dEJEa3cvZHAzWjJzRFJBM0xaek40c3lxK0lOSFluUFRndjUwcklJeDNzM2pj?=
 =?utf-8?B?NE9nMDlPZWROaUhTMi9Xc2dOTkorSm9odlY1WVIzU00rOHFwNGpmL2J6V2FL?=
 =?utf-8?B?OFdHY2lDMGhsbmJNWkkrSW5KTFNUVVJLVmcvZTlwUDNlcjFMYldKYXRjOFJv?=
 =?utf-8?B?SW1WZ1VybFQzN3FLWDZITnNQdkFlQVRYenljRGhaRDh1YWFDS3FERTM1bkxV?=
 =?utf-8?B?b0hrMzhnM29rYW9IVlVEZHIzRHl5N2NKeEd2K3FsbzlDUWIzOENtVkRyRXZp?=
 =?utf-8?B?RDFMZGFVb01pa1crL29yWWp2VWs2UkZTRGhsS1BmVEhTVUp5Y0htV1lJZThQ?=
 =?utf-8?B?WTJWOWFkRGxDQ1VrZFJhaHF1UFVQeStyeTQvR1kxTG05YUhnay9sNmM4ODhS?=
 =?utf-8?B?RXVWOU1EbnpxUEZ3UGMvQ0ZLZUJHTHN3dHVSYlJZVjJqYjZoQ1c2TTVwR0lz?=
 =?utf-8?B?dmhiVHlRNHNvcmNDemtSdm9HOVkvR0FNaWxNVmI4emdtaUN0cU9KUE9hckJq?=
 =?utf-8?B?N3p1bVJaRXRNNUtDdG1DMEROZi92WklIUjN0anBnZTRITllwNXBxZDQ3WFhj?=
 =?utf-8?B?eDZVSjNTNHRDNDJOdjdsTlRFby9ydCtHQkJWQkx0aklQYVg0dVZqVTk4N1dO?=
 =?utf-8?B?TXQyZ0pFSjhwODVzb05UaUJWME5SZ3dRTk03bkxNTHVJZ1ZCYzlEOTdYR1J2?=
 =?utf-8?B?NWlWS2ZibXQwbVNyUlAvTUxqL2tyV29weTRwNmlpWlF6TWUwL2RkZGdmN2Vn?=
 =?utf-8?Q?gRdtAH3f//klyHT2+JCL+XYSK?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3255fc3-4af0-45ca-1ebc-08dc9c3a80f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 15:03:46.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr60tEqYvHw9WOH5V0sobKblhKHgTDE89pR9snXR6PAMB2NDnWdOhZUNSMDHd10pvNjgWaIfBMXVJQcHY+khcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10714

Add description for the SolidRun CN9131 SolidWAN, based on CN9130 SoM
with an extra communication  processor on the carrier board.

This board differentiates itself from CN9130 Clearfog by providing
additional SoC native network interfaces and pci buses:
2x 10Gbps SFP+
4x 1Gbps RJ45
1x miniPCI-E
1x m.2 b-key with sata, usb-2.0 and usb-3.0
1x m.2 m-key with pcie and usb-2.0
1x m.2 b-key with pcie, usb-2.0, usb-3.0 and 2x sim slots
1x mpcie with pcie only
2x type-a usb-2.0/3.0

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 637 +++++++++++++++++++++
 2 files changed, 638 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 019f2251d696..16f9d7156d9f 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -30,3 +30,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
new file mode 100644
index 000000000000..b1ea7dcaed17
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -0,0 +1,637 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Base.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+
+/*
+ * Instantiate the external CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/ {
+	model = "SolidRun CN9131 SolidWAN";
+	compatible = "solidrun,cn9131-solidwan",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp1_eth1;
+		ethernet1 = &cp1_eth2;
+		ethernet2 = &cp0_eth1;
+		ethernet3 = &cp0_eth2;
+		ethernet4 = &cp0_eth0;
+		ethernet5 = &cp1_eth0;
+		gpio0 = &ap_gpio;
+		gpio1 = &cp0_gpio1;
+		gpio2 = &cp0_gpio2;
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		gpio5 = &expander0;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		i2c2 = &cp1_i2c1;
+		mmc0 = &ap_sdhci0;
+		mmc1 = &cp0_sdhci0;
+		rtc0 = &cp0_rtc;
+		rtc1 = &carrier_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_led_pins &cp1_led_pins>;
+
+		/* for sfp-1 (J42) */
+		led-sfp1-activity {
+			label = "sfp1:green";
+			gpios = <&cp0_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* for sfp-1 (J42) */
+		led-sfp1-link {
+			label = "sfp1:yellow";
+			gpios = <&cp0_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-activity {
+			label = "sfp0:green";
+			gpios = <&cp1_gpio2 22 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-link {
+			label = "sfp0:yellow";
+			gpios = <&cp1_gpio2 23 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* Type-A port on J53 */
+	reg_usb_a_vbus0: regulator-usb-a-vbus0 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus0_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&cp0_gpio1 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_usb_a_vbus1: regulator-usb-a-vbus1 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus1_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpios = <&cp0_gpio1 28 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sfp0: sfp-0 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp0_sfp0_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpios = <&cp0_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&cp0_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&cp0_gpio1 31 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp1: sfp-1 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp1_sfp1_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp1_i2c1>;
+		los-gpios = <&cp1_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&cp1_gpio2 18 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&cp1_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&cp1_gpio2 17 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp0_comphy2 0>;
+	sfp = <&sfp0>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	/* Without mdio phy access rely on sgmii auto-negotiation. */
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #1 - SGMII */
+&cp0_eth2 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp0_phy1>;
+	phys = <&cp0_comphy1 2>;
+};
+
+&cp0_gpio1 {
+	pcie0-0-w-disable-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie0.0-w-disable";
+	};
+
+	/* J34 */
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp0_i2c0 {
+	/* assembly option */
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	expander0: gpio@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+
+		usb-a-vbus0-ilimit-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus0-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus0-enable-hog {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus0-enable";
+		};
+
+		usb-a-vbus1-ilimit-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus1-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus1-enable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus1-enable";
+		};
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+
+	/* usb-hub@60 */
+
+	/* assembly option */
+	carrier_rtc: rtc@68 {
+		compatible = "st,m41t83";
+		reg = <0x68>;
+		pinctrl-0 = <&cp1_rtc_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp1_gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&cp1_gpio1 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp0_mdio {
+	/*
+	 * SoM + Carrier each have a PHY at address 0.
+	 * Remove the SoM phy node, and skip adding the carrier node.
+	 * SGMII Auto-Negotation is enabled by bootloader for
+	 * autonomous operation without mdio control.
+	 */
+	/delete-node/ ethernet-phy@0;
+
+	/* U17016 */
+	cp0_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - miniPCIe */
+&cp0_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy0 0>;
+	status = "okay";
+};
+
+/* SRDS #5 - M.2 B-Key (J34) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&cp0_m2_0_shutdown_pins &cp0_mpcie_rfkill_pins>;
+	pinctrl-names = "default";
+
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_led_pins: cp0-led-pins {
+		marvell,pins = "mpp4", "mpp7";
+		marvell,function = "gpio";
+	};
+
+	cp0_m2_0_shutdown_pins: cp0-m2-0-shutdown-pins {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	cp0_mpcie_rfkill_pins: cp0-mpcie-rfkill-pins {
+		marvell,pins = "mpp6";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus0_pins: cp0-reg-usb-a-vbus0-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus1_pins: cp0-reg-usb-a-vbus1-pins {
+		marvell,pins = "mpp28";
+		marvell,function = "gpio";
+	};
+
+	cp0_sfp0_pins: cp0-sfp0-pins {
+		marvell,pins = "mpp31", "mpp32", "mpp33", "mpp34";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* add pin for chip-select 1 */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+/* USB-2.0 Host to USB-Hub */
+&cp0_usb3_0 {
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SRDS #4 - USB-3.0 Host to USB-Hub */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi1 {
+	status = "disabled";
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* SRDS #4 - SFP+ 10GE */
+&cp1_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp1_comphy4 0>;
+	sfp = <&sfp1>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp1_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy0>;
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - SGMII 1GE */
+&cp1_eth2 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp1_gpio1 {
+	status = "okay";
+
+	/* J30 */
+	m2-full-card-power-off-hog-0 {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	/* J44 */
+	m2-full-card-power-off-hog-1 {
+		gpio-hog;
+		gpios = <30 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp1_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp1_mdio {
+	pinctrl-0 = <&cp1_mdio_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	cp1_phy0: ethernet-phy@0 {
+		reg = <0>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+
+	cp1_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - M.2 (J30) */
+&cp1_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy0 0>;
+	status = "okay";
+};
+
+&cp1_rtc {
+	status = "disabled";
+};
+
+/* SRDS #1 - SATA on M.2 (J44) */
+&cp1_sata0 {
+	phys = <&cp1_comphy1 0>;
+	status = "okay";
+
+	/* only port 0 is available */
+	/delete-node/ sata-port@1;
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+		pinctrl-0 = <&cp1_m2_1_shutdown_pins &cp1_m2_2_shutdown_pins>;
+		pinctrl-names = "default";
+
+		cp1_i2c1_pins: cp0-i2c1-pins {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+
+		cp1_led_pins: cp1-led-pins {
+			marvell,pins = "mpp54", "mpp55";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_1_shutdown_pins: cp1-m2-1-shutdown-pins {
+			marvell,pins = "mpp29";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_2_shutdown_pins: cp1-m2-2-shutdown-pins {
+			marvell,pins = "mpp30";
+			marvell,function = "gpio";
+		};
+
+		cp1_mdio_pins: cp1-mdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "ge";
+		};
+
+		cp1_rtc_pins: cp1-rtc-pins {
+			marvell,pins = "mpp12", "mpp13";
+			marvell,function = "gpio";
+		};
+
+		cp1_sfp1_pins: cp1-sfp1-pins {
+			marvell,pins = "mpp33", "mpp34", "mpp49", "mpp50";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/*
+ * SRDS #2 - USB-3.0 Host to M.2 (J44)
+ * USB-2.0 Host to M.2 (J30)
+ */
+&cp1_usb3_0 {
+	phys = <&cp1_comphy2 0>, <&cp1_utmi0>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB-2.0 Host to M.2 (J44) */
+&cp1_usb3_1 {
+	phys = <&cp1_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp1_utmi {
+	status = "okay";
+};

-- 
2.35.3


