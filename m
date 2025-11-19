Return-Path: <netdev+bounces-240084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF93C704DD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDDEF3A50C3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ADF3019DE;
	Wed, 19 Nov 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bjv8Z6Xm"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E710230148C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571083; cv=fail; b=DmL7yvwjF1ZL0bzPv17MOKe5nN8FGoCU0vW/QABBm3K15pERfV+q7A9LnVbW3QQfTswnoIyQ+sWSj0Cpt7lazHztAuJ4OEEBAEczEDwoMAki+/UT3zg2tJ/LQ1UIVFNJotbD/M+mBJb13bvPj0bDqkzZatK8udgXTCTb+2OMcjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571083; c=relaxed/simple;
	bh=OxhOV7IetbfWKj/VDriPwZwPO/i+BkojEuKS+FRWugQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UlHbSP1YOSxtoa6YYKTi6xHl/mXb/WMirxB0hDKeJC5zDfiLZTYAhrY+JawEQzMH8Csjt4Fk6hO4RTl6bPxRMHytVd1TN26nEtLex9mAvbR0ZvAkeWjizFVcYCLUFFAOSfzTSqLV8spIey95N7UXHoh8jHu0ToTfM1TljxI5nGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bjv8Z6Xm; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi6/Oeo9Ea35fMWpKg//iNJ7ksEO+EPSSj3wdSYhMSHJLmukW0R77zf/SwhcLehSmicGHdkaiI30mDjgLAJ3k+7mbOTlMDfXAbdf6zci1yqd0foMETkNXWXhDruCTAIITUFVztiWye2Bt/Ux1Wj0OJsX9yBM6bJUHSU6hi5f73Si7KlHQScv8TD/fj8QqwRkgz28BHjKp2psMh9a5Vij8XRFOjVpLW/Q0aVaanHWZaAxOoE1dwsj+P//jRS+oaa4XeTR9oXx1I8CyysUXFzrJXCkM/q4VuFA7xOqUmqBbvTBY8FVsTIgVB40AlfWQ8AhwLBaXyxI2nxi5fqc543z1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA4Q4xDFQfz9ovBxXfSTHRG8+LTOdtB7BqwgsCWdQTw=;
 b=r0kymNGPcWCXaVs3S/nAckHz8U6qQaJUHBqChaDdT6holMG5uzw36y90dZXKOZkEZKmcMG8N1xS+3KtMSxf5MnN0BxeRBVHArstMEw/aA22L4z6GiQ+EPw/abfPLU22ASH1M8Eur8IpejgLuOXGmMMLYlApRKsaKUfarbd2+fJcuGBaETiN4e+uwcx2Uh2ZSeTmOnKkkVA2HQPKS8R5q4xA1XOr6pCosjkpJO1QLSdaq2XxYuHnMiwECz3CI3HfUgj8QO3Ljzxl/DJKEhPwJ9Yksi6PpGvL4DI5MyOfj1YUYUmZNdtKgC19m7eKuS+je2tDe+o+I/nNJURhulzyc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA4Q4xDFQfz9ovBxXfSTHRG8+LTOdtB7BqwgsCWdQTw=;
 b=Bjv8Z6XmttVkOhQ0W+9ik3ov85kHEjbl4OHzSy9AUNG35cROSlFkh4A7ZghNbCZ7iHd3agEGoSDtE4DQ0/T5eYKz0T6ZBwJno5ck7mJlvIBraI3f1StqwNOSvbi4WWXTrzshW4JJB+5MaFdNfBJRaAlxHOXsdfd5xTZ/GKilfdAIYr8nJpDMa8pvIdivzRqNxrskkwvP72I3q22HT5anVe9LDVYOpb7k9UlVy3LmYlWjk7pe1RFXBXxKkg65MB+Jf+/Kt9rI+AUAThlxktKowkfAtysQIbjwfYcT8feNRiat44MELzsnbB01KZVlY3xrPDQus3LT/8pkmKjhUh8J3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:51:17 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:51:17 +0000
Message-ID: <50af344e-9a3b-4e07-966f-d44784ee0752@nvidia.com>
Date: Wed, 19 Nov 2025 10:51:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-8-danielj@nvidia.com>
 <20251119042245-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251119042245-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:806:122::19) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: fb31f842-5391-4d0c-ad0a-08de278bdb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHU1ZDI0L05oM3ZTeWk1NHoyWkJzZWZIWEh1SGlwSk0vUHQxb05pS2Jqemp5?=
 =?utf-8?B?TFFrbFlUSUM2R3loQVZ6OUpKa2x6RVNUUVVvcEt3OVM2Nms1YmU3K2JiVlBM?=
 =?utf-8?B?TnBLOVBveUFYVnZkaVQrdS9QV0xOckFuQ3RIMFVPY29TWGluTCt5elcwUlhU?=
 =?utf-8?B?Q3RodDR6WUhjUW5vK1k4SUg0bHZnanp2aWVlUnpOUmcvaUovdnhmZmR5WktC?=
 =?utf-8?B?M1MwdnU1SUpVU0h3dlBmeWlQcG9qemU1WlFSVk0rYURzc0VZaUN6OE5QWG5D?=
 =?utf-8?B?bGZ0Vzl5d0pUYVJqN2VJRkN3K0I1VWEwQnkxK2dmUi9sTTdMcWdSYXU1MkN4?=
 =?utf-8?B?MG9TZWVLUTJuQ0V6bTA3SEl3U0lSak1CblVUYVBqWExEOXh2aHdSbWp4ZWMy?=
 =?utf-8?B?RGNFeEpRRzc3MzZSRWdFMUlGdmhQT3QzK2xNb1o5Wkk4YnU3QTBPUk5tbFFF?=
 =?utf-8?B?SE0zRk00ZmZuMHFVMkVGNWg0UnJsaHdHVTJkc3ZiU3BqeXhmYVpkaC9ONXV0?=
 =?utf-8?B?Tm02emhCZVZuT052S2lVVzJwQ01aOG85S3lobzY5WUFWNTFHMk1hN2NQSTJa?=
 =?utf-8?B?YXpLa0pINTBWc1hOK1RKMC93ZEk0SlVVcHBSNzlHWlRKbTlVeC9OWE9VdDNI?=
 =?utf-8?B?Vy8vSFlaUXNXSEdtdERWbEdxSW5adHJMVVJ2bFlKOG42Y1Fybk56NDQrSm13?=
 =?utf-8?B?ZGJtTjVranlpUTcvWVI0KzJaQm5ad1Roc1FuVy9scVZ3NkN6cXRtYm9EUU1O?=
 =?utf-8?B?MlRtMzFtdTR0Y0pEYzFHVEQ5T1Q4elVONWMvd1dMaEhDWmY5dzEwZTZTUlVw?=
 =?utf-8?B?Z3VmaDVNbm5LdGVUcVBYQ3BCVHV2ZUlkVlYxM1lCemo1YTVDY1ViamJKeDlz?=
 =?utf-8?B?Kzk1ZGFkbGxLNXd3N2tWWUpQcm9pOUJvQnVRYXFrNUVHS1VJNjJ5S3BFNHI2?=
 =?utf-8?B?V3FhTDJ3S2wyL2dlcVQ3Y1pNRHhIcUFTN2dGZ0YvUFBBMmxQVU5nTEpVZktE?=
 =?utf-8?B?bFN2UVE2Y0ZURE96alVjYS8yOS81a3ZSb2JTRWR3VHBLMFRkQlpzR0VPM0gx?=
 =?utf-8?B?RldCUm5BUzZ6NVczbjNOTXRyTnhwSERERmo3ZldCME1OYzJjM2QrNUx6UG1r?=
 =?utf-8?B?MzhXQlBHQldsMks0WXlSejV0NTk1Q2JzeVM3THpqemU5MjA2d2x0ZEd6S0dZ?=
 =?utf-8?B?NWlScjhlSFF4S0dRbVBrSDc3QnFXVGtmeWVrVWc1c2FQK3lXUVlMMVJEVnZD?=
 =?utf-8?B?OVVBdUxYLyszTGQzRE00U1dSdTJBQUhzOU52SlgycFhOWUpvYzFVcjB1dFl3?=
 =?utf-8?B?SDJLSDVTa2JsRnNZV1NQR2s3SXkvVFZYNWE2aCtYcEVIOGFoWDJvRnlQd3dm?=
 =?utf-8?B?MVhKQlU0UzZYUWpudmEyLzdWRGxjWGZUU3N1S2Q2NTdhNjcrNkl1d09Vc0pP?=
 =?utf-8?B?UjlBcTBsNVpQUEwyZ2RSYmMwaTJxRTVzczg1QVpndWh2Y2ZwTGxRdkxlRVVG?=
 =?utf-8?B?UTVMaytNWGRodGQ1dGI1L3RUQzUvT3QxSE4rcTgyZUJRN3dTOWtVUFJHZWVn?=
 =?utf-8?B?NU56RUg1akh6aDErWkYySy91TENQMXNBTlk5bmc3azhoc2JHSHJ1QTVlZ2N5?=
 =?utf-8?B?UGNQelJYV0s4eXg4cDZjYjRpSmZzdk9nOU9MOXM0TjRZRXZrR0Zma3dvb0hR?=
 =?utf-8?B?OG5JUmRPZ0tNSkVmWFBvWTNtcklOYXRlTHlmTEZTZ0c2Sk5MajIrY25NcjR4?=
 =?utf-8?B?eFU5a2tWYTFja0xKVy9XM0lPS2FKb2FHaFpNNE1GMFhrajJHbkFiOE9WTy96?=
 =?utf-8?B?eG9kYXVMWEVZMXZlVjNFM0UyVlVaNmV3dXpKQ3JjOThVY2pVeDFsUzlNcEU5?=
 =?utf-8?B?eGRrUGZpaFlLOWRUREg3VVB6bmRRR2VxcnhheU9kSEcvS1lZYXdlZXB0MGZV?=
 =?utf-8?Q?qp8/Ng3N4EGYoWCyMUBAIklXIr7b6WYD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWdxL1dVRjFYWFVHSnV4RlZQQjQ1dzFsVzlNczhUbFM1NVk2aUtNLzRUdkxG?=
 =?utf-8?B?NmdxNU5ORWpsdHlSSlgyUmJheGRmRmZlUWNCNmlTRjFiV2NzTFdIell2YVRE?=
 =?utf-8?B?LzkwUGxqMmdYendod28wMlZITkYvbFlOSElCZ3Z3TDRVaDlwYWgydnNMeHB5?=
 =?utf-8?B?N2loQXJTMGE2V3ZLR01sL241THQxQk9ocWJOTDNDdUN1TjFoN1lLUmlhejhl?=
 =?utf-8?B?ajErQUx0TFMrUFA3VFZ6bVB3RDIybkxJMUFSa05aYklDNlNUU1g1aWZxbEdk?=
 =?utf-8?B?M0JSYzFPeC9DZFR4cTRBejVUWGVXeVU0RitrOEw1RDJlWlRUZXhQbVJrMnVX?=
 =?utf-8?B?RDBCeTUzZnpUNjFQZTA4QnExRzFabERBMUJnVUthV0ViUzhlOTRaOHFLMTU3?=
 =?utf-8?B?TTdvSEZLSWdURm1EN1l6RFlTNE5kdXdqTHpjL3czQXZ1ei9Dd3pTZGNrVWd3?=
 =?utf-8?B?UVp0dDN5aE4wNGx0WjB2djNWOFoxNlk1OHFIdXNESlY4WXR0Q29qd0ZiejFs?=
 =?utf-8?B?OG8vcHVqMFM5dXdVWDdJMWZDNUF3YnZSR0FQSUFvVXVOU1FZeXlveVQxVXda?=
 =?utf-8?B?UlFiS3FkcS9UMmNPU0dCQVBDZTE1TUxyMFQ4YXpUVGp3NmlnSXRQSy96UmhJ?=
 =?utf-8?B?Mm5GdzVZTjJlbHMzYkZXekFLdHluVDNaV0YwZE1tWGdBWXJ3enpKeHpjRTRk?=
 =?utf-8?B?dVdhNXU2WjhQUDVKc1FFMTNyMWtDRzZScmNkcm1FNHByWVBMYTRjU0ZMWktB?=
 =?utf-8?B?V3daVWh2U2dtMkxVODRLOUwrZHNUandIcHJlN2tYTG90ZnZUbWtzL1J1NzlD?=
 =?utf-8?B?VXlzcG9idWtYRzNtQ2M3Vm5kR01XSG5SOEl1VUpkTk5Yc2VTVWh3WDJYY2h5?=
 =?utf-8?B?WkF2RFk0em5MMGlyck5pK09IcjdVU3c1anQ0YnNNMDVGQ3NKY2QvbWc4dnJk?=
 =?utf-8?B?STJGRU44WTNPZDNxT3NTZmVrYkQ3K3pacDlIdmplWlBqZmkxZHB6S3FFd0cv?=
 =?utf-8?B?VnB3Vyt2YTA0L1UwS3NubVdSWmxEZXJEYlh2d3JKTk1xRkNSdTBYYTQyY0lj?=
 =?utf-8?B?TDNreDZ2cWk4aEZqRktab0tQRFQzeDhXeGV1MFpvUUdyUFN3eVdrUldQUHJ5?=
 =?utf-8?B?a2F6U0JzaEtVcGE4M3ZzR2U5WDZ2M3grT2xKOTgxZ21pK0p2eWwxbnEydmZ3?=
 =?utf-8?B?VUUxdWVXcjQzTUM3Z1hxa2dqaDN2TENaRmUvMlU2YmV3S1FTdmhpZEwzOXBN?=
 =?utf-8?B?WXUxam56RmJZdVJwcmc3YWdudTg1bFUxcnZvRndHZktLN1FzbXZ1SU9QWkxK?=
 =?utf-8?B?aS9rbUVNbnhxd3Vwak9IL21LVmpkenpDVktMVXh6OTVVQWlvQTYwcnhjWlhz?=
 =?utf-8?B?VGJ1VnU2SjMwRVpwSTBjZVlacmlXVUljVmVUbFZ5QnpCOGIvU3pFaEYxMnhC?=
 =?utf-8?B?aE9VaUFzSW94TEcrekNEYnNqS0w4eEZ6Sm9rOWltMS9mNmFqSFZOQ1ZYVFZv?=
 =?utf-8?B?RVpZMHZLelAzZ1FJWFBnYitOLzloZDlMZzMvUmxPQ3JGa09sOExMK2NqQWV3?=
 =?utf-8?B?czlxUGdMUzdXN3JITFhQcWsrMDBJNDVHUDgzU25OSlMyVk9KRXdndmh2aElo?=
 =?utf-8?B?OTBYVFljM2ZxaVU3NFJIWDlGM1djUGkwVUlVM2FQSjhISVQrSGQ2a1pCSi9C?=
 =?utf-8?B?SDl1TVNEc1lPbFhOaUcvZm5GbUh3UkhkUWxzTkNScGVOS1p0NEo0TktTS1hH?=
 =?utf-8?B?bjRRK3QzL2s3UlBTSnlpc2RoM0tSdEI0VmRKMnlrcGVkMGpJYnZTVnR5d2N4?=
 =?utf-8?B?b3lxa2psZ001ZEp6aURhM2tCckdkMHdvdThMV0RFWVVCY1NyclAzTG1UOGtx?=
 =?utf-8?B?eGJxQjZSY0FCN1pZcXNzZHZ0VDJ2VTFTREhQU1lNbkNObnRtck40OUUzRkVz?=
 =?utf-8?B?cUNSakNlcXBGRUVRVUNUejc1YkgxempuazZBL3BtOGJwellyZWZOSC82Y3Fs?=
 =?utf-8?B?elRadEpiK3VEdVFYSHJpTEIxOTJ6QS9Sd2U3RmE2MzVPZHRaaStYcTFKWDdh?=
 =?utf-8?B?MlRwTFBUZnE1L3RJMUhYTkx1S0hFOUx3TlA1dk5UdUhoeGN0a1Foc0x4cHVX?=
 =?utf-8?Q?U2qddOwsiuLLO3hIGYj+joZbC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb31f842-5391-4d0c-ad0a-08de278bdb5e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:51:16.9059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+7yJGCfFG0+g3NmcbSpwAMM+LQ1YLV8T2NoDqzQJQT+ZD2U75AvK7Qq2otaRQUNlkcUmYpH70TIjMFXv5mOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

On 11/19/25 3:26 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:57AM -0600, Daniel Jurgens wrote:
> 
> ...
> 
>> +static int insert_rule(struct virtnet_ff *ff,
>> +		       struct virtnet_ethtool_rule *eth_rule,
>> +		       u32 classifier_id,
>> +		       const u8 *key,
>> +		       size_t key_size)
>> +{
>> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
>> +	struct virtio_net_resource_obj_ff_rule *ff_rule;
>> +	int err;
>> +
>> +	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
>> +	if (!ff_rule)
>> +		return -ENOMEM;
>> +
>> +	/* Intentionally leave the priority as 0. All rules have the same
>> +	 * priority.
>> +	 */
>> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
>> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
>> +	ff_rule->key_length = (u8)key_size;
>> +	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
>> +					     VIRTIO_NET_FF_ACTION_DROP :
>> +					     VIRTIO_NET_FF_ACTION_RX_VQ;
>> +	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
>> +					       cpu_to_le16(fs->ring_cookie) : 0;
>> +	memcpy(&ff_rule->keys, key, key_size);
>> +
>> +	err = virtio_admin_obj_create(ff->vdev,
>> +				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
>> +				      fs->location,
>> +				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
>> +				      0,
>> +				      ff_rule,
>> +				      sizeof(*ff_rule) + key_size);
>> +	if (err)
>> +		goto err_ff_rule;
>> +
>> +	eth_rule->classifier_id = classifier_id;
>> +	ff->ethtool.num_rules++;
>> +	kfree(ff_rule);
>> +
>> +	return 0;
>> +
>> +err_ff_rule:
>> +	kfree(ff_rule);
>> +
>> +	return err;
>> +}
> 
> 
> ...
> 
>> +static int build_and_insert(struct virtnet_ff *ff,
>> +			    struct virtnet_ethtool_rule *eth_rule)
>> +{
>> +	struct virtio_net_resource_obj_ff_classifier *classifier;
>> +	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
>> +	struct virtio_net_ff_selector *selector;
>> +	struct virtnet_classifier *c;
>> +	size_t classifier_size;
>> +	size_t key_size;
>> +	int num_hdrs;
>> +	u8 *key;
>> +	int err;
>> +
>> +	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
>> +
>> +	key = kzalloc(key_size, GFP_KERNEL);
>> +	if (!key)
>> +		return -ENOMEM;
> 
> So key is allocated here ...
> 
> 
>> +
>> +	/*
>> +	 * virtio_net_ff_obj_ff_classifier is already included in the
>> +	 * classifier_size.
>> +	 */

>> +
>> +	err = insert_rule(ff, eth_rule, c->id, key, key_size);
> 
> 
> ... copied by insert_rule
> 
> 
>> +	if (err) {
>> +		/* destroy_classifier will free the classifier */
>> +		destroy_classifier(ff, c->id);
>> +		goto err_key;
>> +	}
>> +
> 
> 
> ... and apparently never freed?
> 
> 
> I think it's because the API of insert_rule is confusing...
> 

Nice catch. I changed insert_rule to free key when it's successful.

build_and_insert will handle freeing it when it fails.

>> +	return 0;
>> +
>> +err_classifier:
>> +	kfree(c);
>> +err_key:
>> +	kfree(key);
>> +
>> +	return err;
>> +}
>> +
> 


