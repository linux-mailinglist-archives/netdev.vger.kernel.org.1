Return-Path: <netdev+bounces-189613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF35AB2D21
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F4316720A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02F7213E71;
	Mon, 12 May 2025 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="QYANk6lw";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="c8ayZtwP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D520E718;
	Mon, 12 May 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013307; cv=fail; b=iyP2WhTbpFUcioq4ny2FjkZBBYd/wTH+SjekO/mmGwapcZ7aIIAkXYz4jGR7NMSCPkuC24yDcsurFU7sDO1ZRm/QjTL4UphfIOcp/N0EqNE1OG6UG7HhIRFiSVcgXBJSqa6tTG9xQ7i0+MguXSldYMbBZa8/6cauQJmfJdOQRhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013307; c=relaxed/simple;
	bh=J5jZqqfqhMmRHBOqN+2/e6fmEgAlMc1/FlJT8cM195Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0N/eS9dDfk6tjIEcIN2ZXPG7faH8vWcG+CtujTgmKHgG4yPJbCl17AsXR0qiAX1VMGvizVquA8I+bmAVOdDK+uCGjS7td3UrXA1ArFhGO6xDcWAmisdt9iK3RUcSYhPCnCXlpTn93xygCGz7ceY1Xe9kS7sVHqu8kMwQcL4Ed0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=QYANk6lw; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=c8ayZtwP; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Rw027700;
	Sun, 11 May 2025 20:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=RWBCh0EhSmW+QtYQmugPztGTiGpOuaav1Vsd1G/u5SE=; b=QYANk6lwX0q0
	Pla2TXdym+V8aKnW7HQiX+iHC8j9nXBaVPAV/ilwGwEtxvf04AUPfQlE3+sMU2nb
	vzspOLuup7LfIC//shP0KTGM5QDLdYQ6JC7X6qbjQHWc7+O7QtvvDPyErBUIlE0M
	OeSXKceI53Eop2w7IdY8N4xrPHOVzHhXECb/rlAXkWs64qvTQu/1VxciJ/S0QY8J
	sUq5q95bkWlH72JjzyztTKA0K9yGYxyvQLMsG6E8cNC45YXYH6FH8X2BKDaEv2/r
	Hac18UKYbgOy2heFLFpzdCmGpPleYx+ncdscYBEDeiX72khAzKTekXuBM+VrSbuV
	dLdMtTO08A==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAo6dlmi3RaB6ErijkWIlsZzYz7D2On0jxurTbzfI9ZtWvLLYJ+1sxJGkQ1wXDqb92nwp3pzLsO9oDC33X8+qwQTVmQEupeMQQNve65o8/zXLunNiT0HeFTzUd7/cNvSdOWvSugoBsABxZUYhT+QKHPJyglqPq2k9XrpDYJd+kCA8wgYhArzkx+fL0rkQhkurAJptYcGkF7MMbJT1qTMsx05FT5DYfQ1QEwMzdwcX62K2HqXdIYr3Ov0K8EEdhB7p0G6TrnrMy66lSQ4Kj92Mgvb7guqaWKC2tzYud9ZLp9zO5b/xj0jItIEc9cW7hr7dpe/NikwlkSwauOnldBh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWBCh0EhSmW+QtYQmugPztGTiGpOuaav1Vsd1G/u5SE=;
 b=TI/EPhDnZ3JpVyv06Npacqy2CPZxMNYYffpnywTILkEcpkO1NrpE3ov589IcvIHL+5o4fVjFB532h2jotWPoZnA6PBjAPUVPplHNieUnYVKTbRs/DD6L4kIYyKksVLXl5nlMQMtlk2nqCy/Ciu4DWw50dJKfDKrwKlBf2ss15trGP+hH4YSN7MLixWs4tCqhtHJGT8lL+nn/x5cw9PdKKRDDWlq/mQdXU6SNH8CbF4JAfCh6FOS0NT5TA1fK2yMG7Q8tde6rw52ba2bvqVl6KwojgABjKgZ/ybSMB+YgbFMeYE0zQWqmpD5+aVdJsFXgPGk5W9Obdza+24lb3aNq9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWBCh0EhSmW+QtYQmugPztGTiGpOuaav1Vsd1G/u5SE=;
 b=c8ayZtwPQV89lWkTPkdc4wH2HyxWl2lqlwQ8HI1uNJI5icbKS5QMaQoC9ubQ5txgmyZ4NLw2eGFC7+ewF2Ipz1gpVUvcyDy+HyqUvxQjkjXHgmik3cb5mWXWqQVFVexCi3nq5Xx+scnJpIUuMePv90SxNfTPcHr2i2VJPDnMJ+M=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:08 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:08 +0000
From: =?UTF-8?q?Damien=20Ri=C3=A9gel?= <damien.riegel@silabs.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Silicon Labs Kernel Team <linux-devel@silabs.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC net-next 15/15] net: cpc: add Bluetooth HCI driver
Date: Sun, 11 May 2025 21:27:48 -0400
Message-ID: <20250512012748.79749-16-damien.riegel@silabs.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512012748.79749-1-damien.riegel@silabs.com>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7402ee25-f5c5-40f5-6d85-08dd90f4409f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ui9rV085OU1nNXNyK2ZLMEtLV05Qam91dEo0OWRsTFZ6K3FWRmdSY3A0UWQw?=
 =?utf-8?B?TERhL2l1Y2lJMGx5VmRPSnFRMXR5Z0hTd0luSUwvZjQ0OFBpOUFIU1lYa1VI?=
 =?utf-8?B?QmNQemEzK1NpVUJneUpXdUdsUW5yV1NIRVV0dXdQcE1rSlBxU2VyZlRPVlpt?=
 =?utf-8?B?UVQ0aXpWRGJmTkdENThEWXhCNklzZmc1Rmp3eHpmRmlXa1ZzbG8rU3dmcHp4?=
 =?utf-8?B?NExsalpyRmRQdnp3YmlIcEx0eHJvWTV4d1RwMVAvK1hadjVzNG9sREFma0Zj?=
 =?utf-8?B?M3QvLzFaU2pkNDJ6dU1OeFF3L2lPcXdoRXBabHJsV0ZBZyt6M005b3I5TkRa?=
 =?utf-8?B?TXVEZ1lBdDgyS0gwd3ZNa1lnVW5ISmxoMEdodUFDZXE0M0xwcXRVYXFXYk00?=
 =?utf-8?B?d2VsUXVpdmtxdGZCbVp5SE5aZWE2WW1JaUZWK1JRZFR3QjBKYW9JZW9laFpo?=
 =?utf-8?B?Q3pyaUZFOVV0UEpKQ2hacEZUY0FadUdxbEJLRytFMUdLS0FUNXZRM2IzSW55?=
 =?utf-8?B?ckxZMm1Cam9aRmV2eTc3cU9ENjg5a2YyYlhQSm5zcy9mYUhvSzRTMFFsOHpN?=
 =?utf-8?B?NUEzYjVGQ0g3QlNkRFFjVFhBejN3TW1NcytUajFmeDhGczRWYjBhTVJTM1My?=
 =?utf-8?B?UHIxWUt3d3B6T3QvRzhieVN4VnZXbXVJZlFrek1kQXB5RmhpK3JjeGVDVXJI?=
 =?utf-8?B?RXJnSXh1cHhXcjRBSSt0TkhTbUNmaHU1djJiZ2tyV2xxWElFRjJ4bEhFaG5T?=
 =?utf-8?B?bWhiQVR1b2ZHUEczMDlBQWVaRmdzbmMyKzlTNS9oSzRIc1hBNDhBaTkxQjV5?=
 =?utf-8?B?RzNwaFFsVkVWeEtHdnpXaTBvSU1NTFhickRPcC85THY5UVdyWm5zUksxRlBZ?=
 =?utf-8?B?cWM3cnBIaDZ1NG00TXZncUxGRnZMZ0RxeVEvRHZUQ3krTmdDSkNTUmkyNW41?=
 =?utf-8?B?Rm5FMG9lMUNRTDRERmVmZXlrNWpwbGtXU1Z6eTlrNjNxL0tyR0pZTGszdmpS?=
 =?utf-8?B?cDdWbGhVOHpySXRVYTJFdUN4OVlwMEJaanNlTjJ0VnNSNlY1aHFrVDdHQmw0?=
 =?utf-8?B?NVVhaGdvMlQwSGwzdytkcVdFWUd3RzVoVlkxOVhjajlLeEVDOUlnbUVpSVFs?=
 =?utf-8?B?Y3lXSm82THQ5OWJnTDR0WmY1alZnVHkwb2pFVXI1MFZPcERvVGtXN2o0ZC8v?=
 =?utf-8?B?NDVwUS9PUnVrOUtaMzR0Y0lHdE0wemNDT2FrdnM2ZEdubllGWmFxRjBscytE?=
 =?utf-8?B?STRraWdwTEY2QUExK0duZkIyd2hPWGw2bnJUS2NjcTdxcjUweHlpUXJOZkpE?=
 =?utf-8?B?d2pNWDYwZ21JOWNSYVd1NmJ0QUdBenZhWVhlSDIyYjRJRjdua2dGNUt0TVRu?=
 =?utf-8?B?WStweDc3dzV2MWY1cnVTbkhaNEwwbGpmVmFLZDZ1MmlGVW5vOHB2VlVaWUhQ?=
 =?utf-8?B?eisrY0QrNUFrdHRNWTRTMEFKb2xVVWFKenlBaW53SkxmWVBMRFZzdVQ5OWpB?=
 =?utf-8?B?MW9KQitpZ0hRWVlrTDZrNWpMSU9lclFoVUNyaFovam1IRUN0VHlCaTBrdVdq?=
 =?utf-8?B?TThWTTRBOWN0T3NmblNRK3pPdWRiWElCOG5rNCszRWlNMVp0ejk1cDI3by9s?=
 =?utf-8?B?U0NrRm1JZHNFY2dFdmhwRC9qOHRNUnBUVlc0VkF6MUgwV3FJc3JoUW9DUHFD?=
 =?utf-8?B?MjhOV0J1UFFncGFQZ3ZjbldVbkNaUEduRlhRL0d5clVxWFh0amY0ZVkyY0FY?=
 =?utf-8?B?S1FQZDc0Q3B5VHA4S0NRclE4aFY5WDNaN0h3dGpmTzFEbFpHTDBNbWlWSVFN?=
 =?utf-8?B?Mmk1dlVOREhLZjJTY1RXbkVMWmVBajRGUjhYazJ1alRTaHNZRWtoRDVGcXhu?=
 =?utf-8?B?YmNLYTN1Y1hDdE5MUklXbmZLNHdvbzNXc0RwNDVseVlYMXhwNk5KZ3FuZGpa?=
 =?utf-8?B?eU96Y0NBN3J3cllBVEpQT0xWVnRnR0xqY0VmWUI0V2QvMzI3aWg4akpzc2Yz?=
 =?utf-8?Q?LGB3iIeg7lKZQtglrk05fXlUFGWkA4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjNiaHdSVmt1eHUyYk9pSElRSCtFSXNmVHVReXpoQURNT2Zma0d4MmRBUmQ3?=
 =?utf-8?B?UkR1YVlSdEpwbWh5aHNkWTREZXFPSDRhNTJHNkNiMHJlNThxYjN1WVZ6QlYx?=
 =?utf-8?B?RThmd0JzKzJybWl4SHlPOXZCc2haMEpwdTczd2ZCNnRTdmd3clFWdHU1YjN5?=
 =?utf-8?B?REllVmRabFJUNVptbDBWbG1Ya1BPMmU0MkNobStYSDc5ejFTUWl2QnhEb3Yx?=
 =?utf-8?B?S1lHOCtMaEJocnVQV25kdnp3OHVoN00yc2VzTHlMNnNqQkMvSkhmeUhaMWtQ?=
 =?utf-8?B?NWFuN2s2U21Fc3hEWVVkQUxaWlNXTVkwcVpJSlErS0o2SGcxME90cnRsZWw1?=
 =?utf-8?B?a0V4ZXJUdGNZYmgxS1pBNEZ4ZkFPSFh3RURORDJkM3ZDTjJmVFFEbWIrQk9F?=
 =?utf-8?B?bTF4YUpQdFdUVHN3QWMzZ0lZNEQ0ZFUzbzJyTks5TThPallIcjVhOUFOYkY4?=
 =?utf-8?B?dFd0MC9OZFhWVDRBSDRUVHlyQXAxTExTcGlxZlZHdzExT0dkTkxzRVQ1VVJ4?=
 =?utf-8?B?UVJITGhla3ZiblB0RTA3bTNBRE1TbnJBWC9MYy9iUUM5ckREckpqR0dCck1u?=
 =?utf-8?B?SnhUL2R0ck5kNHJ0MURGRzZ5N3FuQ2J5THFRUWlwelRVRWdRZmRoV1lyUGNi?=
 =?utf-8?B?QXdBRWUyajhxRGVOMW1HUU93MEdDdDUrZGRKdFB6TitJRjRsN1llK1U4L21Y?=
 =?utf-8?B?LzBJd3ppbGdXbms2N1dRMzVRWVQ4MGJEbGVjV016YnUwZFNSemFIaDFUWXBv?=
 =?utf-8?B?UjVRUG1UcDVQNS9qSVhhN0hJUHIxekN5c3lidmx6TjZmRHJvMjJQbGNTRkVK?=
 =?utf-8?B?T3EyTmFKMkxVaW1hTWVBWHdwaGRmZ01IdjJlSkxKc21Sb3pxRmJERkkreGd4?=
 =?utf-8?B?bnJxQXl2Znh0RC90YzV5aWdzRzNhYmZqL0V5Tk1UYVJjZzhJRDF3RzNMaHFx?=
 =?utf-8?B?VytkYjdPbGpEakR1V1BpS2J3TFhjZy8vS09UZGNQbm5JNExWS01BZXdCUW00?=
 =?utf-8?B?RDFFVGs1MXkzY1RQYXk2R202UUNwbnlkZ3pvNE1GNEVhTW1ZNnJweGFDZWRG?=
 =?utf-8?B?SmFyTzBZK1M3bk8xUE94dmZXcGg4WkZZOEZyd01kcTE4ZXo5VDl6UWxBVzJB?=
 =?utf-8?B?N3UxZGJFVFEvOEs3R0JWemp1eXRxQjN0Ymw2RXpZYS9OY2ZJQXZqVzZta3Zo?=
 =?utf-8?B?WWFKNWpJazUwYVJRUHFUaTR6OW1OSUJhbkxNZzhmNjlHdm1HTWFMQnEwNFdv?=
 =?utf-8?B?eUMzZFF4Uy9VUXh4Qk9ZMVQ4WTJWZG9YNjFNWkxKVTBla2Z4L0VldytodlE2?=
 =?utf-8?B?NlJPcllSOWo0WDZXS3RvM3pqNGJiSitFcWpqandZOTcyS0RIM1ptZ0Y3Uk4y?=
 =?utf-8?B?dFZONTg2SVl1enpEcXNGMjJZVEhwQm51Z2NQRFlybExvUWh4ZlMrZDNqMlFx?=
 =?utf-8?B?SHhOYXovOTI4K05ZS0xyRmV2TzBINFo5TjF0bVppbE84dGRhM3daTlI0NjEw?=
 =?utf-8?B?QkFJbWpvd0J4SWNPY3lKSnI4cXNjaXFtOTZkZnJMaGFGUFRGNkRaUVJHc2Vx?=
 =?utf-8?B?KzU3RDgrN05YR2JlWjlkeEpQZ2k1TnFIQndRYlNNVUFEWW15WDN0MU12RmZL?=
 =?utf-8?B?c2twbEJhSnRxdGl3aFVJalQ4UStnMElQdGd5RzlLTmpPWDZCcTNRemdvUlQw?=
 =?utf-8?B?UzdmQnY2YVI3Z0dHWExQczhIZmhIZjJsd29ycTBtbndFVHoxRHBpUmt5czd2?=
 =?utf-8?B?VitWUmJRRlI3cFBwYVNzUnE5RytQSkNYRmMxdjJCdWo4WXhFSWpFYmZFQW8y?=
 =?utf-8?B?M1ZKM2pmNlg3TWlkTkJjd3Rnb3dOUXpQTGFsMVA1RGF2aHlvVW5pWE9zcmlN?=
 =?utf-8?B?L1B6ZXhmbVNJemJXSHlUTzJtQzFFM0VBZExNYjBVL1RWWmRIWWlZcTdmMUt6?=
 =?utf-8?B?NjB4amppdlVEQzVjMnE1RWJaQS9ybGFxS1FLd0g2SHp2Uy83YXdrNXF1UFY0?=
 =?utf-8?B?M0N3TXovRHBFa25vQ2lTcjY1QTExUWIzZTF0SmlJbUtLVSt2WFBEY1ZVWmVy?=
 =?utf-8?B?ZEY2aGx4R00zWGFJMkNKNVJreXVyMWhOTURPRVZvV0tXbFFGRjdZL0ZrUDd0?=
 =?utf-8?Q?KGoLcEngyZ9V3H6CucgV2oXlf?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7402ee25-f5c5-40f5-6d85-08dd90f4409f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:08.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4L6nBYMGU6g4/teV0sCpJtEQtPXTFRWXT2e1bLsK2nc2o1IMyZV3qYJNJ6qQRSwzrIkuAQpU/rVUzYjCmkJcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: 5nqPBLum36HYNw2ky0pK_kBkJAiJtO3-
X-Proofpoint-ORIG-GUID: 5nqPBLum36HYNw2ky0pK_kBkJAiJtO3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX3KyM5IxF8ezH fUZhMtiizerpja8frg5PCv3WJqrgkySufuONI6xxIEFAnCgsAdCaiXdF7AN9e7ahi9uqc+TJsGs 8NLpKG9LD5lk48kvQemVrvY0Vdw7nZ0dmXhodi2MrYb39+kMm7I7cpVLtr+CDX2ff8kMitgPWr9
 0aEOFsc65dZWHfO4NV3l5Id9oTzPwm7f/oJBr0GfO38SN0e5tO2YCF78cF4euCUcde0so5lRhD9 PPuF9FMHNNi9ANCIOrY4ACtjWAVi15FjDrN43gIVsN3zUSao2dwOOX2ng0/R6ucclBUjIHTniR6 d9nuIuKxzvO9WqUU8FculOHP1txlURuXfpS64PfvvsfVau9UanLXvq496sttlLY91ou/z5pXJ/2
 gDsx7tKUBBWJhSjClUS5qqEbmMfCmP77nK3ly848lQNxLEzxU1ikbcndYwkBukGoMA9ufiYi
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214eac cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=KeReSjn5avopcc9GsFcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

Add support for Bluetooth HCI driver. As most of the protocol is already
handled by the remote endpoint, this driver is just doing some glue to
plug into CPC.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/Kconfig  |   2 +-
 drivers/net/cpc/Makefile |   2 +-
 drivers/net/cpc/ble.c    | 147 +++++++++++++++++++++++++++++++++++++++
 drivers/net/cpc/ble.h    |  14 ++++
 drivers/net/cpc/main.c   |  23 ++++--
 5 files changed, 181 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/cpc/ble.c
 create mode 100644 drivers/net/cpc/ble.h

diff --git a/drivers/net/cpc/Kconfig b/drivers/net/cpc/Kconfig
index f5159390a82..e8faa351bf7 100644
--- a/drivers/net/cpc/Kconfig
+++ b/drivers/net/cpc/Kconfig
@@ -2,7 +2,7 @@
 
 menuconfig CPC
 	tristate "Silicon Labs Co-Processor Communication (CPC) Protocol"
-	depends on NET && SPI
+	depends on NET && SPI && BT
 	select CRC_ITU_T
 	help
 	  Provide support for the CPC protocol to Silicon Labs EFR32 devices.
diff --git a/drivers/net/cpc/Makefile b/drivers/net/cpc/Makefile
index 195cdf4ad62..cee40aec412 100644
--- a/drivers/net/cpc/Makefile
+++ b/drivers/net/cpc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-cpc-y := endpoint.o header.o interface.o main.o protocol.o spi.o system.o
+cpc-y := ble.o endpoint.o header.o interface.o main.o protocol.o spi.o system.o
 
 obj-$(CONFIG_CPC)	+= cpc.o
diff --git a/drivers/net/cpc/ble.c b/drivers/net/cpc/ble.c
new file mode 100644
index 00000000000..2b7aec4dbdf
--- /dev/null
+++ b/drivers/net/cpc/ble.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Bluetooth HCI over CPC.
+ *
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#include <linux/skbuff.h>
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "ble.h"
+#include "cpc.h"
+
+struct cpc_ble {
+	struct cpc_endpoint *ep;
+	struct hci_dev *hdev;
+	struct sk_buff_head txq;
+};
+
+static int cpc_ble_open(struct hci_dev *hdev)
+{
+	struct cpc_ble *ble = hci_get_drvdata(hdev);
+
+	skb_queue_head_init(&ble->txq);
+
+	return cpc_endpoint_connect(ble->ep);
+}
+
+static int cpc_ble_close(struct hci_dev *hdev)
+{
+	struct cpc_ble *ble = hci_get_drvdata(hdev);
+
+	cpc_endpoint_disconnect(ble->ep);
+
+	skb_queue_purge(&ble->txq);
+
+	return 0;
+}
+
+static int cpc_ble_flush(struct hci_dev *hdev)
+{
+	struct cpc_ble *ble = hci_get_drvdata(hdev);
+
+	skb_queue_purge(&ble->txq);
+
+	return 0;
+}
+
+static int cpc_ble_send(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct cpc_ble *ble = hci_get_drvdata(hdev);
+
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+
+	return cpc_endpoint_write(ble->ep, skb);
+}
+
+static void cpc_ble_rx_frame(struct cpc_endpoint *ep, struct sk_buff *skb)
+{
+	struct cpc_ble *ble = cpc_endpoint_get_drvdata(ep);
+
+	hci_skb_pkt_type(skb) = *((u8 *)skb_pull_data(skb, 1));
+	hci_skb_expect(skb) = skb->len;
+
+	hci_recv_frame(ble->hdev, skb);
+}
+
+static struct cpc_endpoint_ops cpc_ble_ops = {
+	.rx = cpc_ble_rx_frame,
+};
+
+static int cpc_ble_probe(struct cpc_endpoint *ep)
+{
+	struct cpc_ble *ble;
+	int err;
+
+	ble = kzalloc(sizeof(*ble), GFP_KERNEL);
+	if (!ble) {
+		err = -ENOMEM;
+		goto alloc_ble_fail;
+	}
+
+	cpc_endpoint_set_ops(ep, &cpc_ble_ops);
+	cpc_endpoint_set_drvdata(ep, ble);
+
+	ble->ep = ep;
+	ble->hdev = hci_alloc_dev();
+	if (!ble->hdev) {
+		err = -ENOMEM;
+		goto alloc_hdev_fail;
+	}
+
+	hci_set_drvdata(ble->hdev, ble);
+	ble->hdev->open = cpc_ble_open;
+	ble->hdev->close = cpc_ble_close;
+	ble->hdev->flush = cpc_ble_flush;
+	ble->hdev->send = cpc_ble_send;
+
+	err = hci_register_dev(ble->hdev);
+	if (err)
+		goto register_hdev_fail;
+
+	return 0;
+
+register_hdev_fail:
+	hci_free_dev(ble->hdev);
+alloc_hdev_fail:
+	kfree(ble);
+alloc_ble_fail:
+	return err;
+}
+
+static void cpc_ble_remove(struct cpc_endpoint *ep)
+{
+	struct cpc_ble *ble = cpc_endpoint_get_drvdata(ep);
+
+	hci_unregister_dev(ble->hdev);
+	hci_free_dev(ble->hdev);
+	kfree(ble);
+}
+
+static struct cpc_driver ble_driver = {
+	.driver = {
+		.name = CPC_BLUETOOTH_ENDPOINT_NAME,
+	},
+	.probe = cpc_ble_probe,
+	.remove = cpc_ble_remove,
+};
+
+/**
+ * cpc_ble_drv_register - Register the ble endpoint driver.
+ *
+ * @return: 0 on success, otherwise a negative error code.
+ */
+int cpc_ble_drv_register(void)
+{
+	return cpc_driver_register(&ble_driver);
+}
+
+/**
+ * cpc_ble_drv_unregister - Unregister the ble endpoint driver.
+ */
+void cpc_ble_drv_unregister(void)
+{
+	cpc_driver_unregister(&ble_driver);
+}
diff --git a/drivers/net/cpc/ble.h b/drivers/net/cpc/ble.h
new file mode 100644
index 00000000000..ae1cac4e7e8
--- /dev/null
+++ b/drivers/net/cpc/ble.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Silicon Laboratories, Inc.
+ */
+
+#ifndef __CPC_BLE_H
+#define __CPC_BLE_H
+
+#define CPC_BLUETOOTH_ENDPOINT_NAME "silabs,cpc-ble"
+
+int cpc_ble_drv_register(void);
+void cpc_ble_drv_unregister(void);
+
+#endif
diff --git a/drivers/net/cpc/main.c b/drivers/net/cpc/main.c
index b4e73145ac2..e5636207d5d 100644
--- a/drivers/net/cpc/main.c
+++ b/drivers/net/cpc/main.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 
 #include "cpc.h"
+#include "ble.h"
 #include "header.h"
 #include "spi.h"
 #include "system.h"
@@ -125,13 +126,24 @@ static int __init cpc_init(void)
 
 	err = cpc_system_drv_register();
 	if (err)
-		bus_unregister(&cpc_bus);
+		goto unregister_bus;
+
+	err = cpc_ble_drv_register();
+	if (err)
+		goto unregister_system_driver;
 
 	err = cpc_spi_register_driver();
-	if (err) {
-		cpc_system_drv_unregister();
-		bus_unregister(&cpc_bus);
-	}
+	if (err)
+		goto unregister_ble_driver;
+
+	return 0;
+
+unregister_ble_driver:
+	cpc_ble_drv_unregister();
+unregister_system_driver:
+	cpc_system_drv_unregister();
+unregister_bus:
+	bus_unregister(&cpc_bus);
 
 	return err;
 }
@@ -140,6 +152,7 @@ module_init(cpc_init);
 static void __exit cpc_exit(void)
 {
 	cpc_spi_unregister_driver();
+	cpc_ble_drv_unregister();
 	cpc_system_drv_unregister();
 	bus_unregister(&cpc_bus);
 }
-- 
2.49.0


