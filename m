Return-Path: <netdev+bounces-189615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC9AB2D1B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 03:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FBE189D9B3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 01:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7567D2147E7;
	Mon, 12 May 2025 01:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="PFzBfLGl";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Mi5A959m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223882101A0;
	Mon, 12 May 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747013308; cv=fail; b=mnZd1b0td+5/BecnbUwLxHwRTylAW0d19ZBfe8N2n236eZ5KQk1LsGCa6bk6qpDg1dDmGR70D5/nGeKN6h8ZnfO+aqB2zdn8P7vUoaM4oz66H/rS3/TDMfCA43HhIecdrZqyUYWi7z7CHCcZB7gxxP1npa/SQLQEekhgLgoo/yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747013308; c=relaxed/simple;
	bh=eOVq661l8gpp2FeBA9ADn5tu4JJnCo1TtL8AVMR0GFA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gwG9WubKc3jXV+NuVDoWrOrNJWykAqVZL6SuFAqcXCTRLgd2rzRJ2D8ZsuSIDXa8VXYCO7rg8511wWKuJIaj1g3GpN1TtrVAyH4VPYBPwkiDZuz+rEB3yoAqHlbjvY2Z7h0GQjWMfytp24x/Jl1iR5U9DV2s4nkU/qK1M1/dJUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=PFzBfLGl; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=Mi5A959m; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BMe1Ro027700;
	Sun, 11 May 2025 20:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=7u7C0lpSYz9RVO7RNG6CAYIQXWebGd0f2fTr9WKVL3U=; b=PFzBfLGlGgV2
	7e6q/rnp19e6miD6o/HrL04wdd5W6+ymliBV7/6IF6brLBlHagkLplSWzHxGjnxA
	aCZrHef3NP7/yXakwkv2zPuI2I9W6ERupHFLQIa3c0iTWplxrMn+R/mHJNt75FX+
	XYccicGdiFPzaSoo4sg6mukjtkuYjuK23yTsfvEw81BR/8i64jOCEbheln1yEnRU
	IV0Jlj1SF2z0z4TH5MjuiBYyXmnG0Cji/m+NnHxo7lJy2FQl79KdWWXOSmRJl99j
	xP6Q1B9/4Yh0aY1SmyhCKNYo4bgfexQY5I0iZG9R3CUp8YT2jNXzwVrEVIJzQSR6
	I15Zo+AcZg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46j34csvw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 May 2025 20:28:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krhMgvIFes1hCk6fhbxE5s4YPEiDEkHro4H8xRc3X3D+CRsvSLRyjpqjaVWNTN5tS4r8OOteR4teC5nhnVx0s3gQltuJMZXs0hFF4TFgXWht6lQCu8t5OddG7EgpbY6I/tZPmF8b4uNCRKKHDRrak1gw19t96Gz4H4D/3eDXOFkJCDfrzotfQHvtN9eSdULvvlDgxqZ0c5eAnwE65KZTQClr27+tYX1/6JFabOCUdFrjpZSxt2ZPsMkYbTJJyS67nKTmoCSHB2/HSYMMro9L/dAIdIggJ5B2sb1WYrGkqWkHAQapFrG4oBD/VilIM5zHAsgka8LzPuOrQzW3xxP+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u7C0lpSYz9RVO7RNG6CAYIQXWebGd0f2fTr9WKVL3U=;
 b=Cotxz3mJMHbSIz+1yv40Kg0/qjLTZLBPisD9qjCqGTDRSbN8Re1CNofrLRVPEdNkQWb312SgiGS4ZUM2t8Rqd5dB10esd8rcQXe5ECE//aHswHx6a6+E5/zNU83Z6htAuE8g5Xm8jppTFJByer6rQo4ApfM91Msbp97GOdqvTNrzKlDKi7uEXhMdhPe9t8a7nfEvFzWqPEabcCidezbQsaRNpMWZbXmyLgaOYBDnV/HzkvSke9tX3/6ZHwfaavy/roHq8XOMHunVLT2cRFFcorZN1aifCqYBdfDtdaSXeZJl6peCgt9gX1TqPD4MXmnqG5UADkoVFmL9i+iwi/euZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u7C0lpSYz9RVO7RNG6CAYIQXWebGd0f2fTr9WKVL3U=;
 b=Mi5A959mxyqIj3OP4JHKB4Bni2szeMdiEiQvYpOdBVSWObkS8DZr2G2pt3+u/JaCwxZ8QXqTmJSpVwqPIyS+JuPUo5panr2oGdswaQQ9j9q/yI+YtmSGb9EEXWG/wHZVvNb+I4OnaozQ4hEtZOlQc5tf01MBjWXakKkr0qBzD6U=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 01:28:05 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Mon, 12 May 2025
 01:28:05 +0000
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
Subject: [RFC net-next 10/15] net: cpc: make disconnect blocking
Date: Sun, 11 May 2025 21:27:43 -0400
Message-ID: <20250512012748.79749-11-damien.riegel@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: e8f10ca9-896a-4790-5614-08dd90f43e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0hqemdRbThNeEc5Tmd6OWc3ZER3QzhyUDY4V21aTlhVQUUyZDBuZ3ZoM1ZC?=
 =?utf-8?B?b2psQnJXRmVoV1hkRHpIRkx4cEhrTnhEWWdWSVdMVjUvQlduUU1ZMUVXR3Zh?=
 =?utf-8?B?cWpRMnZVVlpVQmtoMmdTNGNhMEJpTTVCNSs4OW0wdGZ4M1QreTlZbWptNTBU?=
 =?utf-8?B?M3pMYm8xMkxxZG43V1pYbEdOTGdXUFRWd3JEc2F0K0VKaXgrdkljYkZVeVdX?=
 =?utf-8?B?ZXVTa3Q4Z09mVUJLVm03U2owc0FNUCtCcTl4NE5xcllGblNiWVhtNXU3YTBy?=
 =?utf-8?B?S0VjQTVUbDB4U2ZOU3hIbGdqUUs5K3VDZmxSNGtyakpBbHZic3lrNXFVVHBv?=
 =?utf-8?B?MThzWlIzYzl4djJqYnlNeTYzSnMrYkVRYldBMFNNeEh2L3pxQ0FCUFhIUWVi?=
 =?utf-8?B?M0RtNFdHZXVmM1FnZGJxcDg0ZGNRZTZQQkh2TlhCS0F1UlhlMzVOcHZPVitY?=
 =?utf-8?B?VUVsS1R2RW5nOEp3c21XcVFkY0UyU1RrZ2NEeEtmamxYQlQwRFJZeFdkREJQ?=
 =?utf-8?B?OUtSTWo4NlRDMUU2czRSZlNpTmw5V3pHYlk2NkJXM3pmTWpYdlJNVzJqVnVW?=
 =?utf-8?B?alp1dzlWV0RmQkl5SkRHWStzMmZtL3M1MmExOGJwZSt1UGZia3htbE95UFJ0?=
 =?utf-8?B?R2NVUk1XVGRZZlhyak13aDkrTWpRZmdYQVNUZDNvTFRIbk9qdFdqSTNHY2xx?=
 =?utf-8?B?K3lEeUovODMwR2k2QzhJK1NRcWppMzlPODZwZUlLRjhzSFlkZzBSZnlHaFRv?=
 =?utf-8?B?cE0yUlQ1Z2k2OStXdGVxT3QzZlRhbGNZTVZFZ2hCVVZoeGIrZ3lwZThmMFhI?=
 =?utf-8?B?VnA1eGRibGxnbzMyR01tYWxmSnFJSGdpb2NSdEw1QkFHZjdwN0RNNVhXQ1pZ?=
 =?utf-8?B?ajZEaWNXWFFCMmN4cUNlMHJ3bkkyeC8yVlJRWnY5VjFiUUpBWjZpMTJCY1Jm?=
 =?utf-8?B?eWdQYVI5RVFlb2pmT1VRU1lHSmhSRzBNcW5ydVVUaHMzZ3RiWWdvaVhBTXdw?=
 =?utf-8?B?WEh5Y3ViRmZmZ09SamRqRHVwRTVYaFI1RUUya3VhSklsMmZCbHJnOGpZdWt0?=
 =?utf-8?B?Y0hyS01lOG5RRXRYcFZMb3o0RTlHWHcwYjRCSDZOWXc1U2hPZUxBWHh0Snho?=
 =?utf-8?B?ellEV0JmcVpNTmdpWjNBOThKdmx5aEF5Nkt2S3JsanF5SDNRVlloL2hpQ0E0?=
 =?utf-8?B?YXluZXBYUWpZQ3RkbUpuUlQyYmUxcHR0bC9SYVZ1TEJ6dno0ekJGOFEwejJ2?=
 =?utf-8?B?RlBpUDZ1NkQzSnMvTHhqZkhkYXNuTURrNjRvSDJhTUptZ2ZnazdwekE1ZU0y?=
 =?utf-8?B?WWt1NUlROTVxaG01NWFtdFJSNzZaQ0phQ0N3czRZOUc5L0xBMWVnOHZjRUYz?=
 =?utf-8?B?OFBFQ0tsblM4M1ZjYmZIR3JBaFRhNSs0WFZadHFnY21kT3oxK2NsNmNMQyt6?=
 =?utf-8?B?d1N3UHZJdnhRMUpIQUNYRWZBSko3S0RTYkp5MzJ6T1pneUtrd0M4UWZvZGla?=
 =?utf-8?B?QmZEemFlWXdvR3UyNzNCWFdlZFR0NXp5c1c2eVMxOTdHcnZHcjZJZDZlcThj?=
 =?utf-8?B?MnlXSlNTeEVkTm0yRktRUWUvZ1pBTDVxc2ZmQTB3ekl4cUZ3VGJVQXpDZTRO?=
 =?utf-8?B?M3Bxdks3Slp0cEo2dk56RkJUejBDSEJBald5Ym5iTWYvT0hjQ2pqMmNXMUpU?=
 =?utf-8?B?NTJqSGRCWkoxaE9YdDhlSkV6MmM3RkhxWDZTc1RmbzNNYmJZcWY2NEU5dEpu?=
 =?utf-8?B?MkxEdFREbjl1RE9OSlZtWEg5dXNKYjdoc3JIVW4zNjU1VmxXVW41Z0E5OVJl?=
 =?utf-8?B?ZjVLTUpRZTRCS3pTMWYzUUN3NGpudWZUWTZJc3drcW1EYnRyTmFVWlhLQlNN?=
 =?utf-8?B?WnNlSS91dDlyWFV4NWNPWUZhckRoNVlZUXVFNWxMYWsweEU2L3F6TFlwTGpW?=
 =?utf-8?B?VTdDQVI0bWdIcllneVpzWG1LYmhKWlQ2aG8wMFNrL0psTTh2azVFZzVBWVBV?=
 =?utf-8?Q?DKqbUssXNFlZVS7PIehPY1hkHqlfuE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjFYQ0dSVElVWGJ2VWp5SDErdnZpa24wZU1OdTJrL3Vxd1UvYmdtM3RQQXd5?=
 =?utf-8?B?ai9hRUtpVGRvNmcxbml6NzlZaTVNSStMcVdpWk5ZZTIrbHJNOVVSTi9FUXM4?=
 =?utf-8?B?RFp1RnVxUzg1SWtEbC8zUlFOVytzZ3I3ckprMXhvL3dHVExka25oWGFMSWpD?=
 =?utf-8?B?TkhyQ1g5RnNEODE0L3YrNXNtRjVaZmtWUFRxVy9HbndwSXU5YzhaN3pKU3Nz?=
 =?utf-8?B?bHZYNVQ4K2pmTkdtbnBXSjhERDNWQzBkNXdyK285NEhyMWhGMlVnWUxsZFly?=
 =?utf-8?B?RVB1OTBDdnpWMVZHZXVBZnNGWks0cVdQYjdqbFRTMTdYVmlqd2ZNQ2YyQ2Ja?=
 =?utf-8?B?WU1nWGFTYWtuaWRoVTl4Wm5jbGk2bHJodXNjYS84RmxiMVlVRm9QQXFUek5a?=
 =?utf-8?B?cmxiTVlyenJqTjFTZjhIQUtNMkU3eFJCNnFmV1hLTWR1NHE3aCtiaGkzbC9E?=
 =?utf-8?B?TG9xWUJJVndBS09GYXZ4UGNlUG14NzhBZG9xQ3B4Q3pPT3Jua3FUMmczeXht?=
 =?utf-8?B?TXN6cjVPZi9mZTc5c1czRlc4ajZzY1lYaXZjRmtjREFOK215WlI3Mk85K3pR?=
 =?utf-8?B?UTk2QkRPQUUrd0lJdjI3S3BHQktXVTBZOWFiK3pPWEI5akFPekNkZVdKZUM3?=
 =?utf-8?B?TUpWNUwxNkVKR3Q3QUM4eGU1bTRzeWQ4TVFuT3VTeHBodThNQ3NrNkt2Ly9L?=
 =?utf-8?B?Ylo5azVWTUo2Nm9INkpQR0djUElpeFhGU2FoNG54SEZxTTRWakdSejFUREJC?=
 =?utf-8?B?QWJmU0l2VWUyQU10YjRmeWc1Q21oOGJjUFR6QWxHWStpek11TkNqY0UxZWZk?=
 =?utf-8?B?WGZTb3N1Y0FWeWVyOUcyc2kvYktPdjNQcVVkL09uK0ttdjlQUWZmTFV4ek5k?=
 =?utf-8?B?Q29GK091RmhkRUF6REZUK0hNR0d1QWdTU2VHeHAxUFg1ekx5WFlyWXpRSHda?=
 =?utf-8?B?bzlhWVJqZHZVdVVGTHR2MzBzSjJqWEhZL3pqWDg2bFNFUzA0TWphK3doT3pm?=
 =?utf-8?B?RWdFWmI0dXNMWkR2RzlBeGJhSVZkdzl6cmluYk5tNmVXM2paM2E5S3NTVEVN?=
 =?utf-8?B?YklQU244c2dEN25WUkI5cTFsZ1BLdVlMYU5YWHZhdUsrc211Z3hwbWJlODZQ?=
 =?utf-8?B?K3QxQzJidER5enNFT2k2TWl5Wm5ncGhRSzZNci8yU2VJTGpRL0NiOUYxdlNy?=
 =?utf-8?B?REd0ckNNVzkyMWtpblNCRU84WW1IOVFoazdvWjAzMmN1b0NNRktiUVJuUXB1?=
 =?utf-8?B?ZlZ3WkhpUmRqREdWaVU2dXhlOFJXS21qZWFXWXFtenB0bzc1dnB5U0I1R3lq?=
 =?utf-8?B?aDhCaDBrNXRhWFY5RzRadXJnSXU4akRJdDFRTTRGNWIyQTF4bVRhbTFtWkhj?=
 =?utf-8?B?Q1FaT3V6ajE4RTc1QUZ4bndRQi9XNjRFZzFlcnkzM3FpL1FSUzdJR0hjcFd4?=
 =?utf-8?B?WXFkTUJiaEViZlZkOXZjaitIMFdvamtUcmVLeFc1RU5yOU50TS9qQW1FOXV4?=
 =?utf-8?B?UGwxS0lEZXgyMDk3MTg1bkdTL0lsUlNiZDQxNXFGRGdUSWlHLzlqOW82N2sw?=
 =?utf-8?B?SkZBMVFwZlJHY05rbmNDUVRUS0NjUTVhRkhLOXk0MnV0MWpkd1ZaeGRZMnZD?=
 =?utf-8?B?T0MybGNHUjdGck1qRzJHWmtXU1l1TitYelhadnQ1dzJLaVAwRVFvTVM4ZXZO?=
 =?utf-8?B?eDQyOEV2Qmd0eTBWeXZHUkZoN0JVNHFCM0xERFBOS2VaSWxLQ3c5VVlCSGwv?=
 =?utf-8?B?K1BrUmVDOU4yRkl6NG1SRHd0aVAvdTNvakFQRWgrekpNeEZDanRnbndEcWcr?=
 =?utf-8?B?TGVnM1ZjVlk2Q0crSVpWaW4xeFdScFdXRmlPSklMR05NblpWYmhDWDVZYUdt?=
 =?utf-8?B?ZGYvQTFUcmNXM2lOUk9TZUhTNlZKZ3kxSEgzcmo5YW9mUXBqZXBva1NyTjd3?=
 =?utf-8?B?UE5IcXVveTlGRThEUU9rTlZWaWRJak5NR04vL1ZzN21vZDh5bFFSRDF5S3Bs?=
 =?utf-8?B?azBTeWJPTnYwek91RVRQb3VjTUcxU2RGeEkwVDZVcFY0VFhaSHcwVzB0ZUZF?=
 =?utf-8?B?UllWRmQvN2JBRmFoSWNQemIxcU5mSEhqY2RKSmlKT1Vza2xWdEFsS01WUzEx?=
 =?utf-8?Q?S1FRTO34Q46tykRR9Q7JPnuLr?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f10ca9-896a-4790-5614-08dd90f43e62
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:28:05.0908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO+haYBxbD+8WNU2lLzySvz3e0J5lA5TEL3F62LhL99hkcjnhZlY6hKFi5jXj9PCbjpaquJd4JCuGa/vtwhgng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-Proofpoint-GUID: _XyYAn7_z-G793oMIXQEp602CdkeN8hS
X-Proofpoint-ORIG-GUID: _XyYAn7_z-G793oMIXQEp602CdkeN8hS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDAxMyBTYWx0ZWRfX9IviIZXgTOVE bz9e2J58OeO2LHhCk2fTvfRv1PRXrG4pGmn4m8LIIugn0PVN5VFBqPFuOr8Xo3x+5GdjyySrAfI QNkYWdf4m8kIb3D4Hk0hk8q9KYf/B6dq3fUBWSANs2fvIOyHX7OCdlMVg73PNbD5FcTNCLDqtIE
 hIyUp7lwI3ZOqg78Qg1ClEkXQ7vf34twrw82vnROM6GH3u0PSK2mGq3HbHaom0cm/4dH730yIDo h1bzc7yrbYXx/b7zdGea3evemGVzi+21ZjvrYLZpeU6xTwI1ZQmvBl++RVnnAbM6vaUvtMx0Rfq RqgwltAL+Phx8nu/weUGBBocxIocP1X0R+0XiIkfxgTcp6yV9ld6LYUTVB3JF8U5ZLRwfPBkXJ1
 iXN8ii9KrexcSayblKGSDi1R2yxFwQpMpLLCjxH6+Z3H5kXr7V2pCJmhx3CS59TKaLUTr2hQ
X-Authority-Analysis: v=2.4 cv=L/gdQ/T8 c=1 sm=1 tr=0 ts=68214ea7 cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2AEO0YjSAAAA:8 a=ejdkOH3wlQVQteUC5O0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_10,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505120013

In order to make life easier for consumer drivers, make
cpc_endpoint_disconnect() blocking. Once the call returns, it guarantees
that endpoint's rx callback won't be called anymore, making driver's
teardown simpler to implement.

Signed-off-by: Damien Riégel <damien.riegel@silabs.com>
---
 drivers/net/cpc/cpc.h       |  1 +
 drivers/net/cpc/endpoint.c  | 19 ++++++++++++++++++-
 drivers/net/cpc/interface.c |  4 ++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/cpc/cpc.h b/drivers/net/cpc/cpc.h
index 34ee519d907..8a761856deb 100644
--- a/drivers/net/cpc/cpc.h
+++ b/drivers/net/cpc/cpc.h
@@ -21,6 +21,7 @@ extern const struct bus_type cpc_bus;
 /* CPC endpoint flags */
 enum {
 	CPC_ENDPOINT_UP,	/* Connection is established with remote counterpart. */
+	CPC_ENDPOINT_RECEIVING,	/* Interface RX work is processing a frame for this endpoint. */
 };
 
 /**
diff --git a/drivers/net/cpc/endpoint.c b/drivers/net/cpc/endpoint.c
index 7e2f623fb8e..f953e4cb7ab 100644
--- a/drivers/net/cpc/endpoint.c
+++ b/drivers/net/cpc/endpoint.c
@@ -260,8 +260,25 @@ void __cpc_endpoint_disconnect(struct cpc_endpoint *ep, bool send_rst)
 
 	cpc_interface_remove_rx_endpoint(ep);
 
-	if (send_rst)
+	if (send_rst) {
+		/*
+		 * It makes sense to wait on the RECEIVING bit only when send_rst is true as this
+		 * means the operation was initiated by the user and can happen concurrently with
+		 * the RX work function. If a RST is received from the remote and
+		 * __cpc_endpoint_disconnect from the RX work function, then it's safe to assume
+		 * that this frame won't trigger a call to ep->ops->rx function.
+		 */
+		int err;
+
+		err = wait_on_bit_timeout(&ep->flags,
+					  CPC_ENDPOINT_RECEIVING,
+					  TASK_INTERRUPTIBLE,
+					  msecs_to_jiffies(1000));
+		if (!err)
+			dev_warn(&ep->dev, "Timeout when disconnecting.\n");
+
 		cpc_protocol_send_rst(ep->intf, ep->id);
+	}
 }
 
 /**
diff --git a/drivers/net/cpc/interface.c b/drivers/net/cpc/interface.c
index 30e7976355c..13b52cdc357 100644
--- a/drivers/net/cpc/interface.c
+++ b/drivers/net/cpc/interface.c
@@ -36,6 +36,8 @@ static void cpc_interface_rx_work(struct work_struct *work)
 			continue;
 		}
 
+		set_bit(CPC_ENDPOINT_RECEIVING, &ep->flags);
+
 		switch (type) {
 		case CPC_FRAME_TYPE_DATA:
 			cpc_protocol_on_data(ep, skb);
@@ -50,6 +52,8 @@ static void cpc_interface_rx_work(struct work_struct *work)
 			break;
 		}
 
+		clear_and_wake_up_bit(CPC_ENDPOINT_RECEIVING, &ep->flags);
+
 		cpc_endpoint_put(ep);
 	}
 }
-- 
2.49.0


