Return-Path: <netdev+bounces-115283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20681945BB1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85237B21783
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E711DAC78;
	Fri,  2 Aug 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="dRSLGB3s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2115.outbound.protection.outlook.com [40.107.244.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7214B940
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592813; cv=fail; b=DfVF1KZX8dY30XsIXDYO1VchxgEIMACvFu7jaeE5bJzOotDX3Tse4dcSq7wZ+fPtL1nLEsD+rYgy8jg3pn2R/ZivwuMeYtR5ipHeYDhFW02oEU5eU52AGCJhkb7Aq4BnqSmYq9jrwZICEbUblohYJ+Dkq5tVAz9Yjq5bkwc+vkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592813; c=relaxed/simple;
	bh=dodJQ6BWMSgX3MysqykAO2bUL5x3POejFwCx41GHSzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPAv5Yx9CpPwkxzCGQR0POfdXHIaIKc/DLJ1Z+X69OSBrSFcaNcrH+YqBytSowZoO28b3eDtQuaX+4TSj1RnLK/yiwOwnIFiBeiUQNqnmkj9QkJaD9zIOt9reeUMMAEykGYKOre0EVkz1dVZ5F9fcQc3Q0kRSHC3dyOujrrHjJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=dRSLGB3s; arc=fail smtp.client-ip=40.107.244.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIBVi8ee0iN9sEtyyDQTHO8BuNlVwT0wclFeXEDpD7xB1PxrXFQ6FafcxbqzyWy/OODlQBK3vwGxFA3EhTOlBAQAy9x0SkHin8KetnsptPy99ds1RFOCU/MOWPSpIYKvMnlBIZ7+3aZ/piF/IVPRVVtFNvPb1qU02fCiMJED3QdvvfvGGQ3HtNsJqpv0PgXGuxESX1LeFWxq428NXi04bjmV1y64v3aUoMH/uIn63EyTNdYSyOOkogMjSTmlLiB2nsHTV6ye5Tui5KQaidRJct20+wFhX47sR8EW9N8dGW6b3EWzwqE/DO5qCYLiEJHNwUfybBNncfkrDyf977z+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHjf2OykDfoE6ZX9aPTjRiWqumWeMpDJUjnEs6ypYuA=;
 b=cOC3FFDy58mVIH3EQcfIw+qdUj/OADcJvyhROubL00R6CYj/X1XGn/hVaaitUconk0HgIyuRWwLm/A3OLpaPkxpPtY1GjWIPFpAt4km0behJATCouDoYCmEvBflIbL+KD4bp9I2GKlIiigGvHGgsY8W5LJ9CXLuVrmSV7J0Syc3HrbHgzbJSNuUAMb60UMDYS3muI9ye2+CWiQ7Hi+O/NeWG44mxn7KIBK6Z3yubgt2BG6n7x4EWz2qITDGOuPhMlM36vs8fcZnmOuQh3eQIfZo4t6+5BqX7R5uNZh56oBlDRIdCpnYATn1XZOg02AIFpbWeYmk6mDtPkiwycEthsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHjf2OykDfoE6ZX9aPTjRiWqumWeMpDJUjnEs6ypYuA=;
 b=dRSLGB3sIWiKQcWvO7zwtFnJ61AImPQVMd4YP4gBXq0pPPw37NT7iUX0dsONEXAetu4szp/XzMq/Mw8UHWjSTfeovE2zOkmfuHMb2g0iCH8SMcVQXSndWC0DnACmzJIKpocHZ8vYKmGDWYDeMTWEjkCYS8lm47FsgEwLL+rYGfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by DS1PR13MB7169.namprd13.prod.outlook.com (2603:10b6:8:215::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 10:00:08 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::bbcb:1c13:7639:bdc0%5]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 10:00:08 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com,
	Kyle Xu <zhenbing.xu@corigine.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	oss-drivers@corigine.com
Subject: [RFC net-next 3/3] drivers/vdpa: add NFP devices vDPA driver
Date: Fri,  2 Aug 2024 11:59:31 +0200
Message-Id: <20240802095931.24376-4-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802095931.24376-1-louis.peens@corigine.com>
References: <20240802095931.24376-1-louis.peens@corigine.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JNXP275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::31)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|DS1PR13MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 348b7de0-699b-48e3-dc0f-08dcb2d9e41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEUwZi9RY3YrNlBnLzU4NXU5Mi9hM2NMVG94NyswWTJ6SzNwaDdsUXQ4ak1P?=
 =?utf-8?B?R2N2YW1ka2x2dWlDWlVHMGFaa0swRHJnZGRSdGsrcHlvWUFPdUtrdCtXbEl6?=
 =?utf-8?B?a2JQS3BPZW1FL0VXSnE2S0J4c2wvZVBDeERpVEd0TmZOaDdBeDB2TUo0a0hw?=
 =?utf-8?B?WG4rR25CMUhVU21heFl5WjBrVjhpYlRQRjFoaXg1dGdGaGxYTEdZTU9LQWZV?=
 =?utf-8?B?WmhkM0RvS3J5aWNhVXhYQngvUHhURFlwR2ROT3RQVXNjMWVTajdZV0NrNnlh?=
 =?utf-8?B?WTJEWWpjejFUUm4vYlYyWkVtMS9OSmtqREh5ZUVBSUw5Q0dBcmE1ZWI3S2VZ?=
 =?utf-8?B?TXZ6a3FXT3U3L0xXVHFBbmJMTjdlZHEzdG1zYk85SnMvZ0NnUUdrK1h6TGht?=
 =?utf-8?B?dlpyMlBHQ2pCejZaZlJuMWJlVUdqVWtnbWtrVmkyekdBUGl0Q052cDdqOVhO?=
 =?utf-8?B?T0RMYVNLTVBxakNBQitueVQxUklVYm5FWHhtTjFLZVI2ckxiUXZRdS9SWUxa?=
 =?utf-8?B?TTJrdkNnM0FYZzkvT0RTOE5DWjJpMW1ONmhIaGFDazVNM1BKNEtDTGcwUC9H?=
 =?utf-8?B?b1VRUmFaend5YzhoQmhIeXJ5VHZGQVhtdDkyRWJMeHpaUVpHOFY1MUtQbk9S?=
 =?utf-8?B?S3VmQ3JzMkRFcVFlanF3ZjlCbVJNTmxtcUhuYUNOeDZKVWJ6WUlpQTVoaUdi?=
 =?utf-8?B?L21UZExUdVozMzZLQ0cvSlNkVHZQNnlROHdJN0VodjY2am5UbGwweVNkNWVp?=
 =?utf-8?B?YmhKWE9PL3MvNVNyb2l1N0Rnd01nd0pZUVFmT3ZFYUcvbzUxelJxV1pFaHlQ?=
 =?utf-8?B?QS9KUGU1bXVNTDJpeFJUbEZTNVJlWXdkQUNTT0E3SW1KQU9mVlZRY2pYeGxr?=
 =?utf-8?B?UjFwMzlOTTdWR3YyTWluWUJERElwZG5jdGRDbnJEV1JWdzRGbDhESkJTTGN0?=
 =?utf-8?B?Zm9rdGxtY2p4WmZYaXN4ejhTMWgxNk9ZSG5OZG5BSVYwMTFjM01hRnc3Wkt1?=
 =?utf-8?B?NnJmMmNrWWhQS29WMkhWemtYcVhiWkw4YWJLOEFjZlg1RDdmQ2doV05NNUFD?=
 =?utf-8?B?dWZkakFhemNhcTdHdk02TS9uSFk0WkZHQ2VHYjRBWld3WVQzN3A5ZVFiNkFh?=
 =?utf-8?B?Tjk5ZXhJK0Q2bWl6UURsdk8vYzRLVG5iU3RjNEtWcVBvcVFCR0lHbnFPWlpX?=
 =?utf-8?B?eHZHeG8wcGhFbzUzcEh5OWJySTcxVXZJTW0wek52Y1NUeDdWbjVYYStIa2gv?=
 =?utf-8?B?V3U3cFc1eGRxcGhMWXcxNUhCMDBnRXFTN25HbkpnTU1Ud0lTTG1FdU5Vdjgw?=
 =?utf-8?B?cXZkYzNubWxGYmdyTGkyMUpqQ3RBQ2FoMjUvS0JIZm4yekNiY2w5bkloSU01?=
 =?utf-8?B?Sm1vRVUwNW5kamdyZHhVb2s4OUt0Q2MycE9rcm1peUV0YWtBSHBBT0tlQ2Vz?=
 =?utf-8?B?bWEra1RmT3cwSWdvYjE5cjNaa2lQQ0VCRjlBeVVRV0gxNHNzOFhRRVRuK2x1?=
 =?utf-8?B?WFRBaHVDSTR4Uk50Vm0vTzIycy9yc2dnaS9NMVRHcCt4KzZpSnRBenNqdU9H?=
 =?utf-8?B?d2QrS1d2WFp1M3paQk5leHRtbTl3VC92bWxhUTZwUFlnZVZ5MGZnaTd2WXhs?=
 =?utf-8?B?dUVOekpTK2xRZkhIRm5PQmoyNW0zT05tcXZTQ2NrUFl2ajROcjloL0daa3N4?=
 =?utf-8?B?amVrWkpnbWJUd0N2eW5wRFVUUnp0cHNLbzM5Wm5LYkpETUlwb056RDh5a0lF?=
 =?utf-8?B?cVRWT2gxVUlCZkNKOVRpSmltbFk0QTlwVHA0Y0FSZ09tQmMxVzdpcTBmWUhq?=
 =?utf-8?B?aXgzeW1sdTk2TzF2YVVONENBcFJleWxmb0ZyNjdsZEVzK2hNZDdLRFJYTmpr?=
 =?utf-8?B?M2Z3NU9TYWZaNU1pMEhncHNUV0xXNloyU1BodmVVa1NRRXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUlxUHdlUG1qNWNmaVN6N2JPNDhqT25VZ3NCZWUySWRENVkzSndVWjdwY0tz?=
 =?utf-8?B?eWtiem9oSll3Z3VuQzlSd0czdGFkVVJkYWNmcjVHbjZWTkFObzB5bHBoa2xG?=
 =?utf-8?B?TEtsbUZxQjNTM3FkemYxNkNXK2NFb2RrbWo0R1kwK2IxS2phK1VvY00yRGhs?=
 =?utf-8?B?T1l2eldNR3FQYUFNaFp3M2M3NDA3K0lMMDYrNXdMVzltV2M4MjhHZnc2R3gv?=
 =?utf-8?B?S1VpOXU3YVd0ektXbnF4MGpDeUNRcHUrQzE0NE0xNFpZWGZFRWpkTjVIOERI?=
 =?utf-8?B?Q3FWWUlZOUpRQU5wTWE2UHNYRktzYllnV3V3WTRDaGtyeTBPVGJUZUVuWjBi?=
 =?utf-8?B?VjdUbm5hTGRiTzZmZWp0b0d3VGZNUlAyWll4QXFFT25QaThZK0EwekFSeUJD?=
 =?utf-8?B?UlBMQWhVN3J0NnJ0RjBSaWx3ak9uSWg5VEVhZlU4V1VQRy9sUFJGc1RRK3F4?=
 =?utf-8?B?MDhyTTIwZGFNVm9ENGJvbGh4bVNYdGs5MzNLdDVGT25YQjlGWlVhamVuN2x2?=
 =?utf-8?B?aTl0ZHhjUmNQZ3E0cjVZODlDQVlqblUza3AwZk9VbHIzeFlvWjdGTUdoS3RI?=
 =?utf-8?B?RlNNT3NsaThhNTViRUh4QWtWbE51eGNoTW8rQkZjbjYyVEJ1aTRtd2VqQ1lO?=
 =?utf-8?B?bk9nMm9MMDZSNnc1dGxzclM1QWR0L2wwekFuQmJVQ2VOSTdXSGJzcVdpeHRw?=
 =?utf-8?B?dEFWRFdwRDVldnZLZ0YwMUgyYUpXRWl2TVBQM3NTMnFKOU4wREN1dXVTSVRq?=
 =?utf-8?B?Z2NLTGJzNlR1Um9jc1F4UDBWbS9acFlvS211aXdtSlVOdERhTEdDMy9Ecnll?=
 =?utf-8?B?RW8rajlJRGN5eEVsRXhmZ2x1QlFFazRMdGxTbE9yajNacVRtTnBhdlBzc0oy?=
 =?utf-8?B?K0NIN1lNbUxUUGNXa2RieWVaRHFEeDdicTNvNjJXcnhYVGw1QVZNUmk1bGR3?=
 =?utf-8?B?YXdaY3BlUUhOYWp4T3FUQ1lIUnExVjBQdFp0OFV6OXZHWXhqMEg1TzZ2elI2?=
 =?utf-8?B?TzV4bWw5dUdFVGJUOWtEZzZkQjBZUGhLQW94dFBLbUpubFBZUUJYTDluczYv?=
 =?utf-8?B?aXQ1R01iRHk5ZWpsc2tZTHcwangyeENiZXlocE1ORlFjdmVtdGlka0JLeDM0?=
 =?utf-8?B?Rnc5Q04rL25QUkF4N2RsNEo1T2tlZWVaTzlJbGtmbUNReHlTZE5UOHhsSW5E?=
 =?utf-8?B?QUpDQURsSTk1eUdsUU13QzJHNFpSY3ozYnlxSXp6QWlQbTlMZjlDOGltTEJG?=
 =?utf-8?B?T0ptcUJUMUZKQnIzOFFnbk5LUERycUdXbklPQmd1VnNmbDgvYTdNUG9Ba2ha?=
 =?utf-8?B?QWNDWUd5bzVFa25YL0sxU0FobEVYMGhkUklsUVh0aC94L1Z3c2tSK1FuRHBx?=
 =?utf-8?B?Y0FoK0hpMFQra2EzWXFPdlNPWm55T1BwWWl0OG5MTzdXSDloRk15em83TDBx?=
 =?utf-8?B?U2Ywd3N1b2pVd05OU0UyNW9wTStHa1pabUtzTG9VZ1hvMG5hYWs3ZmZkWm9D?=
 =?utf-8?B?NHE1ZUdpbWNrci9qN3ZDSmFOdTl4RDhjaFZPbDdrbUtDZ1Q2RGF0Q3JvbUto?=
 =?utf-8?B?WEtyYlBwVldGSVV5cmszaEFCR3EwZTM1Mjg0cUJVNjFiZjltWkowZGlnaUsw?=
 =?utf-8?B?OGpQQUhRTmc2WktmSUVuVVFKTWpIYUsxTGs5dWFvbUt4enJReTNuek9USFE2?=
 =?utf-8?B?ZmRYNWlML1NraVhENU1WWUVJV0VYZmdjR2pxL0hOcUoxQkJiZkY1aU4wV2hF?=
 =?utf-8?B?TE1rYUoyMDlFTk1aQlplRkV5cHBMcXF5MjVQTitIcGk3NlB2RFU3cW5iV2JH?=
 =?utf-8?B?OFhwK1lZSENWUVV2Q3ZSQUd0ZmlPTzMwbkljWVhZbkZiZ3VkSVJpWm84WWFy?=
 =?utf-8?B?TUc4bndnOXRZSnNiN1NSdG4vdUI3dUZUUWJpWWN4NFNZa0tjMThDUStYRUgz?=
 =?utf-8?B?MzdVQTJnOUF4OHlpdk8wMkFDNllYclZoMjZxSmVQWE9OMHR5czZFMWF6bXpR?=
 =?utf-8?B?NGJTbEx0Yk0ycDNNdUhGVkI1d0ZES2ZXaDBBZ0p5cElVZklQQ3F3RW54emdq?=
 =?utf-8?B?dzZ3QXZ2SmY3S0hOL045VlBaaGw5RnZoczA2RXA3blRacWtLVDhab21ubkJk?=
 =?utf-8?B?RW8zMlNlS1pkY2ROdHErUmNpMGdZMG9PYXdYOHhxZTFCKzQ1MHhCZlU5QjNT?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348b7de0-699b-48e3-dc0f-08dcb2d9e41d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 10:00:08.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xUYOqe4UstB8eni32EPdma7XkYb3iAcOaxS2NOojv3lnCTEUwgD7QzZzmAzgvp+SWke6fCdP+nefJJQN3wwzx90+QP9TZEuWIElSD2100So=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR13MB7169

From: Kyle Xu <zhenbing.xu@corigine.com>

Add a new kernel module ‘nfp_vdpa’ for the NFP vDPA networking driver.

The vDPA driver initializes the necessary resources on the VF and the
data path will be offloaded. It also implements the ‘vdpa_config_ops’
and the corresponding callback interfaces according to the requirement
of kernel vDPA framework.

Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 MAINTAINERS                            |   1 +
 drivers/vdpa/Kconfig                   |  10 +
 drivers/vdpa/Makefile                  |   1 +
 drivers/vdpa/netronome/Makefile        |   5 +
 drivers/vdpa/netronome/nfp_vdpa_main.c | 821 +++++++++++++++++++++++++
 5 files changed, 838 insertions(+)
 create mode 100644 drivers/vdpa/netronome/Makefile
 create mode 100644 drivers/vdpa/netronome/nfp_vdpa_main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a3d9e93689..3231b80af331 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15836,6 +15836,7 @@ R:	Jakub Kicinski <kuba@kernel.org>
 L:	oss-drivers@corigine.com
 S:	Maintained
 F:	drivers/net/ethernet/netronome/
+F:	drivers/vdpa/netronome/
 
 NETWORK BLOCK DEVICE (NBD)
 M:	Josef Bacik <josef@toxicpanda.com>
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 5265d09fc1c4..da5a8461359e 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -137,4 +137,14 @@ config OCTEONEP_VDPA
 	  Please note that this driver must be built as a module and it
 	  cannot be loaded until the Octeon emulation software is running.
 
+config NFP_VDPA
+	tristate "vDPA driver for NFP devices"
+	depends on NFP
+	help
+	  VDPA network driver for NFP4000 NFP5000 NFP6000 and newer. Provides
+	  offloading of virtio_net datapath such that descriptors put on the
+	  ring will be executed by the hardware. It also supports a variety
+	  of stateless offloads depending on the actual device used and
+	  firmware version.
+
 endif # VDPA
diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
index 5654d36707af..a8e335756829 100644
--- a/drivers/vdpa/Makefile
+++ b/drivers/vdpa/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_ALIBABA_ENI_VDPA) += alibaba/
 obj-$(CONFIG_SNET_VDPA) += solidrun/
 obj-$(CONFIG_PDS_VDPA) += pds/
 obj-$(CONFIG_OCTEONEP_VDPA) += octeon_ep/
+obj-$(CONFIG_NFP_VDPA) += netronome/
diff --git a/drivers/vdpa/netronome/Makefile b/drivers/vdpa/netronome/Makefile
new file mode 100644
index 000000000000..ccba4ead3e4f
--- /dev/null
+++ b/drivers/vdpa/netronome/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+ccflags-y += -I$(srctree)/drivers/net/ethernet/netronome/nfp
+ccflags-y += -I$(srctree)/drivers/net/ethernet/netronome/nfp/nfpcore
+obj-$(CONFIG_NFP_VDPA) += nfp_vdpa.o
+nfp_vdpa-$(CONFIG_NFP_VDPA) += nfp_vdpa_main.o
diff --git a/drivers/vdpa/netronome/nfp_vdpa_main.c b/drivers/vdpa/netronome/nfp_vdpa_main.c
new file mode 100644
index 000000000000..a60905848094
--- /dev/null
+++ b/drivers/vdpa/netronome/nfp_vdpa_main.c
@@ -0,0 +1,821 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (C) 2023 Corigine, Inc. */
+/*
+ * nfp_vdpa_main.c
+ * Main entry point for vDPA device driver.
+ * Author: Xinying Yu <xinying.yu@corigine.com>
+ *         Zhenbing Xu <zhenbing.xu@corigine.com>
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/vdpa.h>
+
+#include <uapi/linux/virtio_config.h>
+#include <uapi/linux/virtio_ids.h>
+#include <uapi/linux/virtio_net.h>
+#include <uapi/linux/virtio_ring.h>
+
+#include "nfp_net.h"
+#include "nfp_dev.h"
+
+/* Only one queue pair for now. */
+#define NFP_VDPA_NUM_QUEUES 2
+
+/* RX queue index in queue pair */
+#define NFP_VDPA_RX_QUEUE 0
+
+/* TX queue index in queue pair */
+#define NFP_VDPA_TX_QUEUE 1
+
+/* Max MTU supported */
+#define NFP_VDPA_MTU_MAX 9216
+
+/* Default freelist buffer size */
+#define NFP_VDPA_FL_BUF_SZ 10240
+
+/* Max queue supported */
+#define NFP_VDPA_QUEUE_MAX 256
+
+/* Queue space stride */
+#define NFP_VDPA_QUEUE_SPACE_STRIDE 4
+
+/* Notification area base on VF CFG BAR */
+#define NFP_VDPA_NOTIFY_AREA_BASE 0x4000
+
+/* Notification area offset of each queue */
+#define NFP_VDPA_QUEUE_NOTIFY_OFFSET 0x1000
+
+/* Maximum number of rings supported */
+#define NFP_VDPA_QUEUE_RING_MAX 1
+
+/* VF auxiliary device name */
+#define NFP_NET_VF_ADEV_NAME "nfp"
+
+#define NFP_NET_SUPPORTED_FEATURES \
+		((1ULL << VIRTIO_F_ANY_LAYOUT)			| \
+		 (1ULL << VIRTIO_F_VERSION_1)			| \
+		 (1ULL << VIRTIO_F_ACCESS_PLATFORM)		| \
+		 (1ULL << VIRTIO_NET_F_MTU)			| \
+		 (1ULL << VIRTIO_NET_F_MAC)			| \
+		 (1ULL << VIRTIO_NET_F_STATUS))
+
+struct nfp_vdpa_virtqueue {
+	u64 desc;
+	u64 avail;
+	u64 used;
+	u16 size;
+	u16 last_avail_idx;
+	u16 last_used_idx;
+	bool ready;
+
+	void __iomem *kick_addr;
+	struct vdpa_callback cb;
+};
+
+struct nfp_vdpa_net {
+	struct vdpa_device vdpa;
+
+	void __iomem *ctrl_bar;
+	void __iomem *q_bar;
+	void __iomem *qcp_cfg;
+
+	struct nfp_vdpa_virtqueue vring[NFP_VDPA_NUM_QUEUES];
+
+	u32 ctrl;
+	u32 ctrl_w1;
+
+	u32 reconfig_in_progress_update;
+	struct semaphore bar_lock;
+
+	u8 status;
+	u64 features;
+	struct virtio_net_config config;
+
+	struct msix_entry vdpa_rx_irq;
+	struct nfp_net_r_vector vdpa_rx_vec;
+
+	struct msix_entry vdpa_tx_irq;
+	struct nfp_net_r_vector vdpa_tx_vec;
+};
+
+struct nfp_vdpa_mgmt_dev {
+	struct vdpa_mgmt_dev mdev;
+	struct nfp_vdpa_net *ndev;
+	struct pci_dev *pdev;
+	const struct nfp_dev_info *dev_info;
+};
+
+static uint16_t vdpa_cfg_readw(struct nfp_vdpa_net *ndev, int off)
+{
+	return readw(ndev->ctrl_bar + off);
+}
+
+static u32 vdpa_cfg_readl(struct nfp_vdpa_net *ndev, int off)
+{
+	return readl(ndev->ctrl_bar + off);
+}
+
+static void vdpa_cfg_writeb(struct nfp_vdpa_net *ndev, int off, uint8_t val)
+{
+	writeb(val, ndev->ctrl_bar + off);
+}
+
+static void vdpa_cfg_writel(struct nfp_vdpa_net *ndev, int off, u32 val)
+{
+	writel(val, ndev->ctrl_bar + off);
+}
+
+static void vdpa_cfg_writeq(struct nfp_vdpa_net *ndev, int off, u64 val)
+{
+	writeq(val, ndev->ctrl_bar + off);
+}
+
+static bool nfp_vdpa_is_little_endian(struct nfp_vdpa_net *ndev)
+{
+	return virtio_legacy_is_little_endian() ||
+		(ndev->features & BIT_ULL(VIRTIO_F_VERSION_1));
+}
+
+static __virtio16 cpu_to_nfpvdpa16(struct nfp_vdpa_net *ndev, u16 val)
+{
+	return __cpu_to_virtio16(nfp_vdpa_is_little_endian(ndev), val);
+}
+
+static void nfp_vdpa_net_reconfig_start(struct nfp_vdpa_net *ndev, u32 update)
+{
+	vdpa_cfg_writel(ndev, NFP_NET_CFG_UPDATE, update);
+	/* Flush posted PCI writes by reading something without side effects */
+	vdpa_cfg_readl(ndev, NFP_NET_CFG_VERSION);
+	/* Write a none-zero value to the QCP pointer for configuration notification */
+	writel(1, ndev->qcp_cfg + NFP_QCP_QUEUE_ADD_WPTR);
+	ndev->reconfig_in_progress_update |= update;
+}
+
+static bool nfp_vdpa_net_reconfig_check_done(struct nfp_vdpa_net *ndev, bool last_check)
+{
+	u32 reg;
+
+	reg = vdpa_cfg_readl(ndev, NFP_NET_CFG_UPDATE);
+	if (reg == 0)
+		return true;
+	if (reg & NFP_NET_CFG_UPDATE_ERR) {
+		dev_err(ndev->vdpa.dma_dev, "Reconfig error (status: 0x%08x update: 0x%08x ctrl: 0x%08x)\n",
+			reg, ndev->reconfig_in_progress_update,
+			vdpa_cfg_readl(ndev, NFP_NET_CFG_CTRL));
+		return true;
+	} else if (last_check) {
+		dev_err(ndev->vdpa.dma_dev, "Reconfig timeout (status: 0x%08x update: 0x%08x ctrl: 0x%08x)\n",
+			reg, ndev->reconfig_in_progress_update,
+			vdpa_cfg_readl(ndev, NFP_NET_CFG_CTRL));
+		return true;
+	}
+
+	return false;
+}
+
+static bool __nfp_vdpa_net_reconfig_wait(struct nfp_vdpa_net *ndev, unsigned long deadline)
+{
+	bool timed_out = false;
+	int i;
+
+	/* Poll update field, waiting for NFP to ack the config.
+	 * Do an opportunistic wait-busy loop, afterward sleep.
+	 */
+	for (i = 0; i < 50; i++) {
+		if (nfp_vdpa_net_reconfig_check_done(ndev, false))
+			return false;
+		udelay(4);
+	}
+
+	while (!nfp_vdpa_net_reconfig_check_done(ndev, timed_out)) {
+		usleep_range(250, 500);
+		timed_out = time_is_before_eq_jiffies(deadline);
+	}
+
+	return timed_out;
+}
+
+static int nfp_vdpa_net_reconfig_wait(struct nfp_vdpa_net *ndev, unsigned long deadline)
+{
+	if (__nfp_vdpa_net_reconfig_wait(ndev, deadline))
+		return -EIO;
+
+	if (vdpa_cfg_readl(ndev, NFP_NET_CFG_UPDATE) & NFP_NET_CFG_UPDATE_ERR)
+		return -EIO;
+
+	return 0;
+}
+
+static int nfp_vdpa_net_reconfig(struct nfp_vdpa_net *ndev, u32 update)
+{
+	int ret;
+
+	down(&ndev->bar_lock);
+
+	nfp_vdpa_net_reconfig_start(ndev, update);
+	ret = nfp_vdpa_net_reconfig_wait(ndev, jiffies + HZ * NFP_NET_POLL_TIMEOUT);
+	ndev->reconfig_in_progress_update = 0;
+
+	up(&ndev->bar_lock);
+	return ret;
+}
+
+static irqreturn_t nfp_vdpa_irq_rx(int irq, void *data)
+{
+	struct nfp_net_r_vector *r_vec = data;
+	struct nfp_vdpa_net      *ndev;
+
+	ndev = container_of(r_vec, struct nfp_vdpa_net, vdpa_rx_vec);
+
+	ndev->vring[NFP_VDPA_RX_QUEUE].cb.callback(ndev->vring[NFP_VDPA_RX_QUEUE].cb.private);
+
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_ICR(ndev->vdpa_rx_irq.entry), NFP_NET_CFG_ICR_UNMASKED);
+
+	/* The FW auto-masks any interrupt, either via the MASK bit in
+	 * the MSI-X table or via the per entry ICR field. So there
+	 * is no need to disable interrupts here.
+	 */
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nfp_vdpa_irq_tx(int irq, void *data)
+{
+	struct nfp_net_r_vector *r_vec = data;
+	struct nfp_vdpa_net      *ndev;
+
+	ndev = container_of(r_vec, struct nfp_vdpa_net, vdpa_tx_vec);
+
+	/* This memory barrier is needed to make sure the used ring and index
+	 * has been written back before we notify the frontend driver.
+	 */
+	dma_rmb();
+
+	ndev->vring[NFP_VDPA_TX_QUEUE].cb.callback(ndev->vring[NFP_VDPA_TX_QUEUE].cb.private);
+
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_ICR(ndev->vdpa_tx_irq.entry), NFP_NET_CFG_ICR_UNMASKED);
+
+	/* The FW auto-masks any interrupt, either via the MASK bit in
+	 * the MSI-X table or via the per entry ICR field. So there
+	 * is no need to disable interrupts here.
+	 */
+	return IRQ_HANDLED;
+}
+
+static struct nfp_vdpa_net *vdpa_to_ndev(struct vdpa_device *vdpa_dev)
+{
+	return container_of(vdpa_dev, struct nfp_vdpa_net, vdpa);
+}
+
+static void nfp_vdpa_ring_addr_cfg(struct nfp_vdpa_net *ndev)
+{
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXR_ADDR(0), ndev->vring[NFP_VDPA_TX_QUEUE].desc);
+	vdpa_cfg_writeb(ndev, NFP_NET_CFG_TXR_SZ(0), ilog2(ndev->vring[NFP_VDPA_TX_QUEUE].size));
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXR_ADDR(1), ndev->vring[NFP_VDPA_TX_QUEUE].avail);
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXR_ADDR(2), ndev->vring[NFP_VDPA_TX_QUEUE].used);
+
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXR_ADDR(0), ndev->vring[NFP_VDPA_RX_QUEUE].desc);
+	vdpa_cfg_writeb(ndev, NFP_NET_CFG_RXR_SZ(0), ilog2(ndev->vring[NFP_VDPA_RX_QUEUE].size));
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXR_ADDR(1), ndev->vring[NFP_VDPA_RX_QUEUE].avail);
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXR_ADDR(2), ndev->vring[NFP_VDPA_RX_QUEUE].used);
+}
+
+static int nfp_vdpa_setup_driver(struct vdpa_device *vdpa_dev)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+	u32 new_ctrl, new_ctrl_w1, update = 0;
+
+	nfp_vdpa_ring_addr_cfg(ndev);
+
+	vdpa_cfg_writeb(ndev, NFP_NET_CFG_TXR_VEC(1), ndev->vdpa_tx_vec.irq_entry);
+	vdpa_cfg_writeb(ndev, NFP_NET_CFG_RXR_VEC(0), ndev->vdpa_rx_vec.irq_entry);
+
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXRS_ENABLE, 1);
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXRS_ENABLE, 1);
+
+	vdpa_cfg_writel(ndev, NFP_NET_CFG_MTU, NFP_VDPA_MTU_MAX);
+	vdpa_cfg_writel(ndev, NFP_NET_CFG_FLBUFSZ, NFP_VDPA_FL_BUF_SZ);
+
+	/* Enable device */
+	new_ctrl = NFP_NET_CFG_CTRL_ENABLE;
+	new_ctrl_w1 = NFP_NET_CFG_CTRL_VIRTIO | NFP_NET_CFG_CTRL_ENABLE_VNET;
+	update |= NFP_NET_CFG_UPDATE_GEN | NFP_NET_CFG_UPDATE_RING | NFP_NET_CFG_UPDATE_MSIX;
+
+	vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL, new_ctrl);
+	vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL_WORD1, new_ctrl_w1);
+	if (nfp_vdpa_net_reconfig(ndev, update) < 0)
+		return -EINVAL;
+
+	ndev->ctrl = new_ctrl;
+	ndev->ctrl_w1 = new_ctrl_w1;
+	return 0;
+}
+
+static void nfp_reset_vring(struct nfp_vdpa_net *ndev)
+{
+	unsigned int i;
+
+	for (i = 0; i < NFP_VDPA_NUM_QUEUES; i++) {
+		ndev->vring[i].last_avail_idx = 0;
+		ndev->vring[i].desc = 0;
+		ndev->vring[i].avail = 0;
+		ndev->vring[i].used = 0;
+		ndev->vring[i].ready = 0;
+		ndev->vring[i].cb.callback = NULL;
+		ndev->vring[i].cb.private = NULL;
+	}
+}
+
+static int nfp_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16 qid,
+				   u64 desc_area, u64 driver_area,
+				   u64 device_area)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	ndev->vring[qid].desc = desc_area;
+	ndev->vring[qid].avail = driver_area;
+	ndev->vring[qid].used = device_area;
+
+	return 0;
+}
+
+static void nfp_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid, u32 num)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	ndev->vring[qid].size = num;
+}
+
+static void nfp_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	if (!ndev->vring[qid].ready)
+		return;
+
+	writel(qid, ndev->vring[qid].kick_addr);
+}
+
+static void nfp_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 qid,
+			       struct vdpa_callback *cb)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	ndev->vring[qid].cb = *cb;
+}
+
+static void nfp_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev, u16 qid,
+				  bool ready)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	ndev->vring[qid].ready = ready;
+}
+
+static bool nfp_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16 qid)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	return ndev->vring[qid].ready;
+}
+
+static int nfp_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
+				 const struct vdpa_vq_state *state)
+{
+	/* Required by live migration, leave for future work */
+	return 0;
+}
+
+static int nfp_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx,
+				 struct vdpa_vq_state *state)
+{
+	/* Required by live migration, leave for future work */
+	return 0;
+}
+
+static u32 nfp_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
+{
+	return PAGE_SIZE;
+}
+
+static u64 nfp_vdpa_get_features(struct vdpa_device *vdpa_dev)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	return ndev->features;
+}
+
+static int nfp_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	/* DMA mapping must be done by driver */
+	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
+		return -EINVAL;
+
+	ndev->features = features & NFP_NET_SUPPORTED_FEATURES;
+
+	return 0;
+}
+
+static void nfp_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
+				   struct vdpa_callback *cb)
+{
+	/* Don't support config interrupt yet */
+}
+
+static u16 nfp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+{
+	/* Currently the firmware for kernel vDPA only support ring size 256 */
+	return NFP_VDPA_QUEUE_MAX;
+}
+
+static u32 nfp_vdpa_get_device_id(struct vdpa_device *vdpa_dev)
+{
+	return VIRTIO_ID_NET;
+}
+
+static u32 nfp_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
+{
+	struct nfp_vdpa_mgmt_dev *mgmt;
+
+	mgmt = container_of(vdpa_dev->mdev, struct nfp_vdpa_mgmt_dev, mdev);
+	return mgmt->pdev->vendor;
+}
+
+static u8 nfp_vdpa_get_status(struct vdpa_device *vdpa_dev)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	return ndev->status;
+}
+
+static void nfp_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+
+	if ((status ^ ndev->status) & VIRTIO_CONFIG_S_DRIVER_OK) {
+		if ((status & VIRTIO_CONFIG_S_DRIVER_OK) == 0) {
+			dev_err(ndev->vdpa.dma_dev,
+				"Did not expect DRIVER_OK to be cleared\n");
+			return;
+		}
+
+		if (nfp_vdpa_setup_driver(vdpa_dev)) {
+			ndev->status |= VIRTIO_CONFIG_S_FAILED;
+			dev_err(ndev->vdpa.dma_dev,
+				"Failed to setup driver\n");
+			return;
+		}
+	}
+
+	ndev->status = status;
+}
+
+static int nfp_vdpa_reset(struct vdpa_device *vdpa_dev)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdpa_dev);
+	u32 new_ctrl, new_ctrl_w1, update = 0;
+
+	if (ndev->status == 0)
+		return 0;
+
+	vdpa_cfg_writeb(ndev, NFP_NET_CFG_TXR_VEC(1), 0);
+	vdpa_cfg_writeb(ndev, NFP_NET_CFG_RXR_VEC(0), 0);
+
+	nfp_vdpa_ring_addr_cfg(ndev);
+
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_TXRS_ENABLE, 0);
+	vdpa_cfg_writeq(ndev, NFP_NET_CFG_RXRS_ENABLE, 0);
+
+	new_ctrl = ndev->ctrl & ~NFP_NET_CFG_CTRL_ENABLE;
+	update = NFP_NET_CFG_UPDATE_GEN | NFP_NET_CFG_UPDATE_RING | NFP_NET_CFG_UPDATE_MSIX;
+	vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL, new_ctrl);
+
+	new_ctrl_w1 = ndev->ctrl_w1 & ~NFP_NET_CFG_CTRL_VIRTIO;
+	vdpa_cfg_writel(ndev, NFP_NET_CFG_CTRL_WORD1, new_ctrl_w1);
+
+	if (nfp_vdpa_net_reconfig(ndev, update) < 0)
+		return -EINVAL;
+
+	nfp_reset_vring(ndev);
+
+	ndev->ctrl = new_ctrl;
+	ndev->ctrl_w1 = new_ctrl_w1;
+
+	ndev->status = 0;
+	return 0;
+}
+
+static size_t nfp_vdpa_get_config_size(struct vdpa_device *vdev)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdev);
+
+	return sizeof(ndev->config);
+}
+
+static void nfp_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
+				void *buf, unsigned int len)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdev);
+
+	if (offset + len > sizeof(ndev->config))
+		return;
+
+	memcpy(buf, (void *)&ndev->config + offset, len);
+}
+
+static void nfp_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
+				const void *buf, unsigned int len)
+{
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(vdev);
+
+	if (offset + len > sizeof(ndev->config))
+		return;
+
+	memcpy((void *)&ndev->config + offset, buf, len);
+}
+
+static const struct vdpa_config_ops nfp_vdpa_ops = {
+	.set_vq_address         = nfp_vdpa_set_vq_address,
+	.set_vq_num             = nfp_vdpa_set_vq_num,
+	.kick_vq                = nfp_vdpa_kick_vq,
+	.set_vq_cb              = nfp_vdpa_set_vq_cb,
+	.set_vq_ready           = nfp_vdpa_set_vq_ready,
+	.get_vq_ready           = nfp_vdpa_get_vq_ready,
+	.set_vq_state           = nfp_vdpa_set_vq_state,
+	.get_vq_state		= nfp_vdpa_get_vq_state,
+	.get_vq_align           = nfp_vdpa_get_vq_align,
+	.get_device_features    = nfp_vdpa_get_features,
+	.get_driver_features    = nfp_vdpa_get_features,
+	.set_driver_features    = nfp_vdpa_set_features,
+	.set_config_cb          = nfp_vdpa_set_config_cb,
+	.get_vq_num_max         = nfp_vdpa_get_vq_num_max,
+	.get_device_id          = nfp_vdpa_get_device_id,
+	.get_vendor_id          = nfp_vdpa_get_vendor_id,
+	.get_status             = nfp_vdpa_get_status,
+	.set_status             = nfp_vdpa_set_status,
+	.reset                  = nfp_vdpa_reset,
+	.get_config_size	= nfp_vdpa_get_config_size,
+	.get_config             = nfp_vdpa_get_config,
+	.set_config             = nfp_vdpa_set_config,
+};
+
+static int nfp_vdpa_map_resources(struct nfp_vdpa_net *ndev,
+				  struct pci_dev *pdev,
+				  const struct nfp_dev_info *dev_info)
+{
+	unsigned int bar_off, bar_sz, tx_bar_sz, rx_bar_sz;
+	unsigned int max_tx_rings, max_rx_rings, txq, rxq;
+	u64 tx_bar_off, rx_bar_off;
+	resource_size_t map_addr;
+	void __iomem  *tx_bar;
+	void __iomem  *rx_bar;
+	int err;
+
+	/* Map CTRL BAR */
+	ndev->ctrl_bar = ioremap(pci_resource_start(pdev, NFP_NET_CTRL_BAR),
+				 NFP_NET_CFG_BAR_SZ);
+	if (!ndev->ctrl_bar)
+		return -EIO;
+
+	/* Find out how many rings are supported */
+	max_tx_rings = readl(ndev->ctrl_bar + NFP_NET_CFG_MAX_TXRINGS);
+	max_rx_rings = readl(ndev->ctrl_bar + NFP_NET_CFG_MAX_RXRINGS);
+	/* Currently, only one ring is supported */
+	if (max_tx_rings != NFP_VDPA_QUEUE_RING_MAX || max_rx_rings != NFP_VDPA_QUEUE_RING_MAX) {
+		err = -EINVAL;
+		goto ctrl_bar_unmap;
+	}
+
+	/* Map Q0_BAR as a single overlapping BAR mapping */
+	tx_bar_sz = NFP_QCP_QUEUE_ADDR_SZ * max_tx_rings * NFP_VDPA_QUEUE_SPACE_STRIDE;
+	rx_bar_sz = NFP_QCP_QUEUE_ADDR_SZ * max_rx_rings * NFP_VDPA_QUEUE_SPACE_STRIDE;
+
+	txq = readl(ndev->ctrl_bar + NFP_NET_CFG_START_TXQ);
+	tx_bar_off = nfp_qcp_queue_offset(dev_info, txq);
+	rxq = readl(ndev->ctrl_bar + NFP_NET_CFG_START_RXQ);
+	rx_bar_off = nfp_qcp_queue_offset(dev_info, rxq);
+
+	bar_off = min(tx_bar_off, rx_bar_off);
+	bar_sz = max(tx_bar_off + tx_bar_sz, rx_bar_off + rx_bar_sz);
+	bar_sz -= bar_off;
+
+	map_addr = pci_resource_start(pdev, NFP_NET_Q0_BAR) + bar_off;
+	ndev->q_bar = ioremap(map_addr, bar_sz);
+	if (!ndev->q_bar) {
+		err = -EIO;
+		goto ctrl_bar_unmap;
+	}
+
+	tx_bar = ndev->q_bar + (tx_bar_off - bar_off);
+	rx_bar = ndev->q_bar + (rx_bar_off - bar_off);
+
+	/* TX queues */
+	ndev->vring[txq].kick_addr = ndev->ctrl_bar + NFP_VDPA_NOTIFY_AREA_BASE
+				     + txq * NFP_VDPA_QUEUE_NOTIFY_OFFSET;
+	/* RX queues */
+	ndev->vring[rxq].kick_addr = ndev->ctrl_bar + NFP_VDPA_NOTIFY_AREA_BASE
+				     + rxq * NFP_VDPA_QUEUE_NOTIFY_OFFSET;
+	/* Stash the re-configuration queue away. First odd queue in TX Bar */
+	ndev->qcp_cfg = tx_bar + NFP_QCP_QUEUE_ADDR_SZ;
+
+	return 0;
+
+ctrl_bar_unmap:
+	iounmap(ndev->ctrl_bar);
+	return err;
+}
+
+static int nfp_vdpa_init_ndev(struct nfp_vdpa_net *ndev)
+{
+	ndev->features = NFP_NET_SUPPORTED_FEATURES;
+
+	ndev->config.mtu = cpu_to_nfpvdpa16(ndev, NFP_NET_DEFAULT_MTU);
+	ndev->config.status = cpu_to_nfpvdpa16(ndev, VIRTIO_NET_S_LINK_UP);
+
+	put_unaligned_be32(vdpa_cfg_readl(ndev, NFP_NET_CFG_MACADDR + 0), &ndev->config.mac[0]);
+	put_unaligned_be16(vdpa_cfg_readw(ndev, NFP_NET_CFG_MACADDR + 6), &ndev->config.mac[4]);
+
+	return 0;
+}
+
+static int nfp_vdpa_mgmt_dev_add(struct vdpa_mgmt_dev *mdev,
+				 const char *name,
+				 const struct vdpa_dev_set_config *add_config)
+{
+	struct nfp_vdpa_mgmt_dev *mgmt = container_of(mdev, struct nfp_vdpa_mgmt_dev, mdev);
+	struct msix_entry vdpa_irq[NFP_VDPA_NUM_QUEUES];
+	struct device *dev = &mgmt->pdev->dev;
+	struct nfp_vdpa_net *ndev;
+	int ret;
+
+	/* Only allow one ndev at a time. */
+	if (mgmt->ndev)
+		return -EOPNOTSUPP;
+
+	ndev = vdpa_alloc_device(struct nfp_vdpa_net, vdpa, dev, &nfp_vdpa_ops, 1, 1, name, false);
+
+	if (IS_ERR(ndev))
+		return PTR_ERR(ndev);
+
+	mgmt->ndev = ndev;
+
+	ret = nfp_net_irqs_alloc(mgmt->pdev, (struct msix_entry *)&vdpa_irq, 2, 2);
+	if (!ret) {
+		ret = -ENOMEM;
+		goto free_dev;
+	}
+
+	ndev->vdpa_rx_irq.entry = vdpa_irq[NFP_VDPA_RX_QUEUE].entry;
+	ndev->vdpa_rx_irq.vector = vdpa_irq[NFP_VDPA_RX_QUEUE].vector;
+
+	snprintf(ndev->vdpa_rx_vec.name, sizeof(ndev->vdpa_rx_vec.name), "nfp-vdpa-rx0");
+	ndev->vdpa_rx_vec.irq_entry = ndev->vdpa_rx_irq.entry;
+	ndev->vdpa_rx_vec.irq_vector = ndev->vdpa_rx_irq.vector;
+
+	ndev->vdpa_tx_irq.entry = vdpa_irq[NFP_VDPA_TX_QUEUE].entry;
+	ndev->vdpa_tx_irq.vector = vdpa_irq[NFP_VDPA_TX_QUEUE].vector;
+
+	snprintf(ndev->vdpa_tx_vec.name, sizeof(ndev->vdpa_tx_vec.name), "nfp-vdpa-tx0");
+	ndev->vdpa_tx_vec.irq_entry = ndev->vdpa_tx_irq.entry;
+	ndev->vdpa_tx_vec.irq_vector = ndev->vdpa_tx_irq.vector;
+
+	ret = request_irq(ndev->vdpa_tx_vec.irq_vector, nfp_vdpa_irq_tx,
+			  0, ndev->vdpa_tx_vec.name, &ndev->vdpa_tx_vec);
+	if (ret)
+		goto disable_irq;
+
+	ret = request_irq(ndev->vdpa_rx_vec.irq_vector, nfp_vdpa_irq_rx,
+			  0, ndev->vdpa_rx_vec.name, &ndev->vdpa_rx_vec);
+	if (ret)
+		goto free_tx_irq;
+
+	ret = nfp_vdpa_map_resources(mgmt->ndev, mgmt->pdev, mgmt->dev_info);
+	if (ret)
+		goto free_rx_irq;
+
+	ret = nfp_vdpa_init_ndev(mgmt->ndev);
+	if (ret)
+		goto unmap_resources;
+
+	sema_init(&ndev->bar_lock, 1);
+
+	ndev->vdpa.dma_dev = dev;
+	ndev->vdpa.mdev = &mgmt->mdev;
+
+	mdev->supported_features = NFP_NET_SUPPORTED_FEATURES;
+	mdev->max_supported_vqs = NFP_VDPA_QUEUE_MAX;
+
+	ret = _vdpa_register_device(&ndev->vdpa, NFP_VDPA_NUM_QUEUES);
+	if (ret)
+		goto unmap_resources;
+
+	return 0;
+
+unmap_resources:
+	iounmap(ndev->ctrl_bar);
+	iounmap(ndev->q_bar);
+free_rx_irq:
+	free_irq(ndev->vdpa_rx_vec.irq_vector, &ndev->vdpa_rx_vec);
+free_tx_irq:
+	free_irq(ndev->vdpa_tx_vec.irq_vector, &ndev->vdpa_tx_vec);
+disable_irq:
+	nfp_net_irqs_disable(mgmt->pdev);
+free_dev:
+	put_device(&ndev->vdpa.dev);
+	return ret;
+}
+
+static void nfp_vdpa_mgmt_dev_del(struct vdpa_mgmt_dev *mdev,
+				  struct vdpa_device *dev)
+{
+	struct nfp_vdpa_mgmt_dev *mgmt = container_of(mdev, struct nfp_vdpa_mgmt_dev, mdev);
+	struct nfp_vdpa_net *ndev = vdpa_to_ndev(dev);
+
+	free_irq(ndev->vdpa_rx_vec.irq_vector, &ndev->vdpa_rx_vec);
+	free_irq(ndev->vdpa_tx_vec.irq_vector, &ndev->vdpa_tx_vec);
+	nfp_net_irqs_disable(mgmt->pdev);
+	_vdpa_unregister_device(dev);
+
+	iounmap(ndev->ctrl_bar);
+	iounmap(ndev->q_bar);
+
+	mgmt->ndev = NULL;
+}
+
+static const struct vdpa_mgmtdev_ops nfp_vdpa_mgmt_dev_ops = {
+	.dev_add = nfp_vdpa_mgmt_dev_add,
+	.dev_del = nfp_vdpa_mgmt_dev_del,
+};
+
+static struct virtio_device_id nfp_vdpa_mgmt_id_table[] = {
+	{ VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static int nfp_vdpa_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
+{
+	struct nfp_net_vf_aux_dev *nfp_vf_aux_dev;
+	struct nfp_vdpa_mgmt_dev *mgmt;
+	int ret;
+
+	nfp_vf_aux_dev = container_of(adev, struct nfp_net_vf_aux_dev, aux_dev);
+
+	mgmt = kzalloc(sizeof(*mgmt), GFP_KERNEL);
+	if (!mgmt)
+		return -ENOMEM;
+
+	mgmt->pdev = nfp_vf_aux_dev->pdev;
+
+	mgmt->mdev.device = &nfp_vf_aux_dev->pdev->dev;
+	mgmt->mdev.ops = &nfp_vdpa_mgmt_dev_ops;
+	mgmt->mdev.id_table = nfp_vdpa_mgmt_id_table;
+	mgmt->dev_info = nfp_vf_aux_dev->dev_info;
+
+	ret = vdpa_mgmtdev_register(&mgmt->mdev);
+	if (ret)
+		goto err_free_mgmt;
+
+	auxiliary_set_drvdata(adev, mgmt);
+
+	return 0;
+
+err_free_mgmt:
+	kfree(mgmt);
+
+	return ret;
+}
+
+static void nfp_vdpa_remove(struct auxiliary_device *adev)
+{
+	struct nfp_vdpa_mgmt_dev *mgmt;
+
+	mgmt = auxiliary_get_drvdata(adev);
+	if (!mgmt)
+		return;
+
+	vdpa_mgmtdev_unregister(&mgmt->mdev);
+	kfree(mgmt);
+
+	auxiliary_set_drvdata(adev, NULL);
+}
+
+static const struct auxiliary_device_id nfp_vdpa_id_table[] = {
+	{ .name = NFP_NET_VF_ADEV_NAME "." NFP_NET_VF_ADEV_DRV_MATCH_NAME, },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, nfp_vdpa_id_table);
+
+static struct auxiliary_driver nfp_vdpa_driver = {
+	.name = NFP_NET_VF_ADEV_DRV_MATCH_NAME,
+	.probe = nfp_vdpa_probe,
+	.remove = nfp_vdpa_remove,
+	.id_table = nfp_vdpa_id_table,
+};
+
+module_auxiliary_driver(nfp_vdpa_driver);
+
+MODULE_AUTHOR("Corigine, Inc. <oss-drivers@corigine.com>");
+MODULE_DESCRIPTION("NFP vDPA driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


