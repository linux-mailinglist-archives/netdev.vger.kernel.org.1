Return-Path: <netdev+bounces-213817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E21B26E79
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 20:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFCE168A1E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B8729D26D;
	Thu, 14 Aug 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="6zZDmdkd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2123.outbound.protection.outlook.com [40.107.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3129D267;
	Thu, 14 Aug 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194208; cv=fail; b=SDiDQOrJhn1c3ZxQvdS9rY/hVALyYm/9vRrnnCL84tnJhvj9ahSbCcTkaooenxLYMM+ngINbgrs/njRZLWS8wH1gaKkvfQdeLcwRySnK0vLzIsA0LiARP5JimogEw1OxRIG5nt6pB16kWsgdPE48Lbi56VCAVrDkaeZ/H8P1/uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194208; c=relaxed/simple;
	bh=VafESgj0x6ifkY81RdqSj0J4VyxQWlBItOHpMOnYrXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uZp/YcH8wHeBor9evR40rwy5ntmClWZmotdZ+ztes6Mwn1YLHWXMtALxtjydJIrBAOmxpiXbO3qsp3BtRSzQYNaQ/xny+bFho5xz0xti9UQgN3MeVsni4kdbjSG4K5Lzb0PBorJugd2K2vhKzzgymiY9m0NvknC5ohcnPIFrFYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=6zZDmdkd reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.223.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwTLDO4SXIseujpz2FveVKAb85eBme/469QkM1AD6hM+1bMieRz2amz0NQP8ico/RUpmR3vb9sD/dWMSXBpmKWgezJzkACHiafmAm1k6WZru8iqLF69/56qmvjfa8a704CsBe1TFb43pMAISFlC/41Da+b8pNY/ZrcZU24NWQ43RfnrqiiUg8Pdm4fg2onT5ND+pADSSEWKVf3Nc1x1pgMJx509PyoyTHVBTnkagQN9T+HjcWoCIZBpvaxG0HXI7Ok1cNQ45eE7eH96lms/TJDBZQXhZPvWsSWvvEwGb9oPybSkLN/asqT6J0mL9slT+xdZP1SPLgHo/NuplAARxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krJC271QgUMxoipWalXGzOeZzFLBooBsrqVEHucAepU=;
 b=kVdpkuN+OMEhSrgSanfEC3UB14Z9DpJLukubVjVqcN9KABG6XPagdc/jVlmL3R6UnPEVAcaANPqHzInedq+LInE25gzTPfQwfvPTU78/hB02vFbBTR9dMMvUmkNMBiZ3e1+JJyKU8HR3lORrVJhPZQv0CSV7UKcMSSCvtLzMmYropK6n8aAZlyZ1VdQyLIUaU3DgTmRpYCY4Kycgi9xUks7PjwLya+ZGwy1F9SF+leoh4GPO1PBZjOyE4wTUFJ7WxviXv4DWxzcjphxtHyJwZHgM1Puv3yfjQ7RTusKoOMWwU/02zXEhtaFffYCb3EFwce0094V3PY1+TcCRJi087A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krJC271QgUMxoipWalXGzOeZzFLBooBsrqVEHucAepU=;
 b=6zZDmdkdbOHw0vGQlW1Td+UJM8tJMf62X86GcMYvbQEThuc29V/PNf4bJcuqouPny0GPhrZ0Ak+yGumRvwAojMHdjLUDP0iyZEI3FGE/CSgsaRrNi+WVa2NMW/VdjEW0DPj/X75C6S4mH0naufVVrEtJt8bDXDtB4pcWvRfAuGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS4PR01MB9434.prod.exchangelabs.com (2603:10b6:8:29b::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.15; Thu, 14 Aug 2025 17:56:44 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 17:56:44 +0000
Message-ID: <5a061bbd-637b-41c1-a6a7-5a14e479e572@amperemail.onmicrosoft.com>
Date: Thu, 14 Aug 2025 13:56:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 1/1] mctp pcc: Implement MCTP over PCC Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250811153804.96850-1-admiyo@os.amperecomputing.com>
 <20250811153804.96850-2-admiyo@os.amperecomputing.com>
 <42643918b686206c97076cf9fd2f02718e85b108.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <42643918b686206c97076cf9fd2f02718e85b108.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS4PR01MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6f2742-636d-4e69-a31e-08dddb5bedd9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnprWCs1VkhpN1Fvc3hyUjNtQUdZMlRKbitLdlErNkhzYlA2cWNNWDhESHVO?=
 =?utf-8?B?U09JOGY4aHJQcjZ3WDRYSTJCM2w1c1AvR21wQ2g0MGp0SHdZN0NLK0xPZ0Rs?=
 =?utf-8?B?czdyT1J5UW9MU0F3d3Jnay8wc1p6dzdxcXBvUDlOWC9rTVkrT3JHdWZrZDJE?=
 =?utf-8?B?L2NTOTUwSDl4OU1JTFd5RFk3aTBDRUVVV1dURi9RMnlBTzR5N09DdE5Uc2Fz?=
 =?utf-8?B?M2k1Q0xnNFJ1ZnoyS241QmxXcGVkdHZQcnY1Yk5NekJCQXkrR3B2OEF5ZEN3?=
 =?utf-8?B?M0V5THhhLzlGQTRZZktvaklpVFgxTTVmeVdud29pdFIwbFd1dzRjQlJYdWhG?=
 =?utf-8?B?cVlNKzRPcU4vdHhhUEdKMzFwSS85NHM3QmRvYmtnWW90bGVDYU1Wb1JYcnhh?=
 =?utf-8?B?T3dFUzJWUnljWVlab2pLTTJLZ2sxU3BiNk16dmlKRmx3R291S0NTVDNySWsx?=
 =?utf-8?B?L3BLNXkrdW84ZUZzeGdQbFBQZTZva3VTMmZvQTl1NzJHZTBrSDBVajA5N1Nw?=
 =?utf-8?B?ZjB3STJzWW5rdUh6a21oTlVZTzJEbTVZYzZoTzdMblVsQ2IzUXpGSmVqdHBH?=
 =?utf-8?B?ZFBoNGFkUzZCOW5WM0ZZaExySVQzazQxVEZ2aDVrazBpNVByUEhxQlhwaFYz?=
 =?utf-8?B?UUJZRGRSekJGK2taSXFIY3ZVM2RncUFiOXNKTlYvTTJ5SitqV0c0dWF5Wis0?=
 =?utf-8?B?RGljQzRKSDlBRXMvaWxiTFRFZFlkMjc2RW9NRGJIdG9SSW5LTmkrcldhOVhZ?=
 =?utf-8?B?c3JGM1N2UG9VMXFjeXB1eWNmU21jcmp2Y2RhcE44aWZZb3Y5Zms5dnpZb0pH?=
 =?utf-8?B?UEIrd1BWaDd3Y1I0VlBJS2h3cTRlSzkxcmtpb3BCL1JXZ2RUaWg4cHdMS1ly?=
 =?utf-8?B?WnhkdlcraXVTbnlWV3BvT0hHN2Nid2lxckM1d2NJRWtCRFF6dXFtUXVuRlZJ?=
 =?utf-8?B?a0J3MVkvSU82Z2xEZm1VMExZNFpOa0pUdDkrNmhveHZhZWdhMU9kblhJVDhX?=
 =?utf-8?B?WHAzYm0vSFBxN2x1ZTRSc3RkaSs3VVc0aU53Z2xvNjdWQ1hxUmhjVVZBc0JY?=
 =?utf-8?B?Njk3WkVPdXRSdEltWDBPa1F6WEFtU0hVNlJDOERVZXA1M1ZDcmtEMWNoNkYy?=
 =?utf-8?B?dzJzejgvSHNldEFrdnliNUFYalhPa3NtMUdKVWM2bytvRlErQy9pWDZPeWNv?=
 =?utf-8?B?UWdBTURsbE4yVWF2eUU1QWk3V1lHM2pjMGQrdkpJWXo3a0N4enh2UEFvWDF2?=
 =?utf-8?B?d3R2V0VOZnZGU09UM2laN0U5blRGZERxbS85ZmF5alp1Z3F6YnhjV1pyMWZ0?=
 =?utf-8?B?WVBhbThhU1dtK01sN1g1bUFyMVV2SkNxZWdKaHMzaUQrWUF3ZEZnWmxDT3c0?=
 =?utf-8?B?a0IxS0dncVdUazRvSXlvME5UTGp3Y0JIdXAvVVVYK0ZIR2VzaldrTlQrZjVo?=
 =?utf-8?B?aDAzRG1CV01Cam9HeTdicUdzMjROR05OTXExQW9qZ0tZaWQzK2JrVkdrbUFR?=
 =?utf-8?B?T3IrWVAxTUc3L0tLakZkRThiaE5lbFZyVVhzeGRoNDhVRVViMmlibkk2aTNj?=
 =?utf-8?B?M0d2OW1CZUJzTndmK1hTWVp3SWxPN3ZtZnpLb3BoOU9mTW5ySTUxU1ZhT0xa?=
 =?utf-8?B?aSsrak1yb294OUhmcGFSdC9aQUhzb2UzYUt3MDVBKzROMzEwbE5aS1BHQmdD?=
 =?utf-8?B?d2xhS0lUSXA5NWJpVFJZSExTZExURVMzMDQ1S28yME03ZEJwN0p6TVE0cXZu?=
 =?utf-8?B?NmtiTXpBUGJwV0w4dW1aUGlOcGhESU9YTExXZk9YdW9zaEZIcDQyNkdnOWxW?=
 =?utf-8?B?a1d5RkxlMG9rcWNNNGdTU3d1NVJGbWhtamFVZXBrUFFIamx0UkNtcjJXUmlC?=
 =?utf-8?B?NEtiaDQzcW40dUhSV1ljOWw2dEpNQnpLUTJIQ29lSHU5TGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGpqRTdMZFNoMVRrQkY4YkRIVHRHRDhhS3cyMXMzUFlva2V4WXVXNU5XQ282?=
 =?utf-8?B?eDg4M2dBQVVDQ1UvbjJaMFpPcHNlMEtsTm8zbWRHOUFmSEJCQnhnUUkxVmZT?=
 =?utf-8?B?YXNkNGUzWkptRUwzSG92MVM3Q1pBWWtlZXZVWkk0TGNSeVdHTXQ1VVJUV2R5?=
 =?utf-8?B?MWpFdTBNbERYSXZidE84L05nMVFjT3p3N3ZEZnRHUXFMRVkxVVUzOFdkV2No?=
 =?utf-8?B?NEVMWGVvREZIZENOeWN2VVVWUUVRY3lOTEo2UzRUOHF6UnhiTnVGV3lSTlZa?=
 =?utf-8?B?bGhpZ1hQOTl1eW0zSERSZDR5R2xwcU55aGtqS3BCTmRGSEpSSlBoNGQrSDd1?=
 =?utf-8?B?ekNSdlRwclBWbVNWUnA2ZHdobmp0K2IwN3BJVUFOeUxNY0VITDB2aVkwWFda?=
 =?utf-8?B?dTVhTURFMSsyQ3FKa3Qzem5zRElvM0tQbDJ3aEU1RmRXbzVxbCtaWU9saStt?=
 =?utf-8?B?dGw5MVJ3RXdieEFzUlFSNHNadUVVUENDd1ZNTDN3eWFZY09nQVhPbXkzUmUv?=
 =?utf-8?B?MUdQM3RqaE1sMWZ4Z1FwdHVGZlRWc0swWUcwVURjeE5kTWppMzJQTyt0VVgv?=
 =?utf-8?B?T0dURjkrM1RWMnMxSW5GVW9CZ21uM2lLZUsyMU1RcFFmQlpJaDhKNFpiTUNI?=
 =?utf-8?B?b3ZkK3E3blhVU0kwcGdsVGZIOWRxL05EVXIyekdteGRxb0h6T3k5MWF0Ynk1?=
 =?utf-8?B?elQ3MjAwejlGbG1ZU0MxTHcxSlVZSWpCaGRKdXNISHRxSlVaaGpUbkJHbFI4?=
 =?utf-8?B?NGNmTkxGbWFhMVpMRmtnTVdBa1FRa012dlppM0V1NnZCMXZhazlMdjB2UnNo?=
 =?utf-8?B?VW40blZDOXhOZERtbWh4NU51Q05YdTJIdnpSUCt1eHJkRlNyOFNpRWxCM3Nx?=
 =?utf-8?B?MzR0M2dzWkR4TW5PSUZEMlhLTFRac2pCRDhVMWZtOE5ralg4K29qS3lmVXFV?=
 =?utf-8?B?VnZ4TE11QXI3Nk1lV01tWm1sUmFpalFlUDFCcWUva2g0T0lNN2NvUEV6SmUx?=
 =?utf-8?B?QTVGZ0t6YURSQkpGN0ZMVE9yai9OOWVnSkYxYlpEZXoxSlJGQVRpWDNGd0FZ?=
 =?utf-8?B?WENmM1ZibGQ2aWY3aUVQRjhjeE9udVAzNmFkcHJBTGRaaCtPbW0rd3hSUWJH?=
 =?utf-8?B?aFJSVmU3VXkwUFpxN2xld1NGNVU4T3pya0VJZ3NVSjU4WkNaNHlPLzRJTjlZ?=
 =?utf-8?B?WW5kR045YU5SY3FUQmtDdE9GSStTcktQczVwOUpRdFQ5VnVteWdKaWZOcHdV?=
 =?utf-8?B?cHRLVlN3THFRRUJwSzRnZnZXYUYwc3plUUZIdTQ3RXFBZFM4d3Y0Q2dDV3N5?=
 =?utf-8?B?WXUzQ05hMU14S2RTS2t1d0dxeW9IR1VzNkhIQ2xkTUhzSHlUdXg4VHVEdjVv?=
 =?utf-8?B?Q2JHZUJnelV3NzVNODAwbHhWOGYrUXp2cjVMN1V4VFdvcEdSS05PcTNVMW94?=
 =?utf-8?B?cXp1OEZhMWk4MzRiQjB3TUFvcVpwMjdjayt0Nm5kc3JXQzFSbVd0dG5Ncjlv?=
 =?utf-8?B?VlMydEw4cERuSCtZZWdWYXBYUno3SnJZZ2tPSkJsYlFBUmNmNHNxYTQ4WTdy?=
 =?utf-8?B?VmI3SFFkRllvSUJsWGEyaFA4akd3M0wrT0NLV0p0eCs5aHFHSkgzcUhBTHV6?=
 =?utf-8?B?ekdubGNSMWRYTU0yQ2Y1QXJNak1WcGJEVjVIRXJwaXpLakVic2ZTbUZkalR2?=
 =?utf-8?B?amthbFIxMEVWazlwalhTQVdLZ2lqVHB1ZEw5NjlCTUR0Vmx3NVE0ZDdmT0RN?=
 =?utf-8?B?UDBPMnhLUlN3RGRkUTdqT1lVVU5xaExMNkJ3dS8ycXpoV0JzSmtndTdTaWUr?=
 =?utf-8?B?OXJDYzVLUWlCeFBBbGcwVW9Ya2pEOTdMVHRINDU4T1RIRU5BSTBQempsKzlz?=
 =?utf-8?B?dkhRanM0dmJpVWNoQmZMZlRwVmZ3aWoxMGNSUjFNWTZET3VuQU9GUGVPREN1?=
 =?utf-8?B?ZUQ2ZmN4czA5M2NidVF3RURkUDN6WkU4bTQvUWR2R3dnMkI4a1dwRWlVNGxK?=
 =?utf-8?B?ZkhiVE12ZzN6UGRid2tIVHN5c21QZEFzNFNPZ2w1YzJQQ0tnTmxYNHlTaSsv?=
 =?utf-8?B?K1E2RzVxS3B1eE5QbUJPMWF2aTY1TE9sdUplS0M4UHh5NGM0MnZqRWZTNmJ4?=
 =?utf-8?B?MDRSNnI1RXdsVHpGT2d5SHNXRWd5dGI3VFVhRElxTDdETGNBY0dCWGl6MFdW?=
 =?utf-8?B?U2ZOQ0xPRTNkSVpxSGdzZXl3Tm8vNkp6QnB3VVNsSVd1TW00eGpaZFBtYzJt?=
 =?utf-8?Q?WbwD7eBPC3revVWH8dc9RqRfzw7M/zz5IKGlLPH29s=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6f2742-636d-4e69-a31e-08dddb5bedd9
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:56:43.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+PHFngBrYpJfslB11C7bxvcwe8AfvQ9fS9xKXTn/S8+7rF0Vgtw7V5xcrW9GcmPrDgED3ukJEvlvLXfSLUMVS2Mv8Co9EWhvhMtdNZ2qDc3kK7p8ldK4uUZSkAs0/aD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB9434


On 8/13/25 00:46, Jeremy Kerr wrote:
> And just confirming: the pcc header format is now all host-endian - or
> is that a firmware-specified endianness? (what happens if the OS may
> boot in either BE or LE? is that at all possible for any PCC-capable
> hardware, or are we otherwise guaranteed that we're the same endianness
> as the consumer?)

The specification does not specify endianess.  It is not addressed in 
the ACPI  PCC spec nor the MCTP over PCC spec. There does not seem  to 
be any endianess modifiers in any of the ACPI code base.  Thus I have 
removed any references to it.  Since PCC is on a single SOC with a 
shared memory setup, the endianess would have to be matched between both 
ends of the system or you would have memory corruption.


