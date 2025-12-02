Return-Path: <netdev+bounces-243306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7BC9CBEB
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 20:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0194A34A5E1
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 19:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286F2D836D;
	Tue,  2 Dec 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="oYjALpAb"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023109.outbound.protection.outlook.com [40.93.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA55A2D8372;
	Tue,  2 Dec 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703194; cv=fail; b=qIpntVA/AM4p6/baI3/512yplnHF/AyOaecsoHvKg5wNcEtS7AZyg4sE9klHMtnDq0pI4PfAuyJ+/H82e7PSRPdY2Z+UM3n9ns8Rld1wT1pp/Ml+lpZDCX3yIvfGkWfZe1lGQ4G2Aav5bJ2PTrsNv7+TSG7FK61OtqOT3aX0gJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703194; c=relaxed/simple;
	bh=UlL5Ndm2dUnd9q+1NfHYUV/FRKN22HulExj7BDoxupA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlYUrg9TzHB+P9hfXinaH5TFmrd0PwHuIEh40EvrjKpgqKaT17JpGDpiTMVdYLeuWq0uz8Mkw9DXA5lZYaxjrXk4YQzPgiP/UacKjsNgxKVtEyI2glYRrT+HOaQCJ9K/sXjGAiB8hFcZGxs/x1Ni69+ZWmBS/Q2wKfNaRvenO3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=oYjALpAb reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpmh1yOrpiEobUjuVJFH6JinIWEKHkHmJm3j8gYcxjBmFplF2HK9ibyy2yyqC5Pge60Zvq8ucfM6RADc+VLt/AldZmJz4H2fnp/QygI3Am4JfY9PriSmPhe4b1tWzy9XQ8flF8ArSeKsUFx25uIgf4B7jq2YCLOuLJV8EMkXVYlGVUo0RwE23VqHikyUrn38V3+LfDjgQGNioS5ZGocWkLKmnTQe7r2WHQPlcNpBSWD4UgTGBfdJmbJBxN18eKgMpppuiIf4VD8V/fJ3p28oI1RRxvUVvA+4xhlYNE7yz4brP0hQ1G+fw4yomJSYCdc/Y/BIfGHuTp0SRIrpWxyRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV/0ukPoHgh0TCib4pGGTuiPzQlRTt3gtJVGRpgVMY4=;
 b=jrFJ8fJKdIObv7xIxo3scZYRxZKWd0dMQkEF64yf+9l5b/eMb28UroMmikBSfScfNZtKbvA7YVU7nQBQb0aoOQyaCTLuvquqXk40Z0Wz6G45Ipt8gTMgCMPgZeauqdRoOjjDUBqHgrN6Hq0nzlhGSBngqvOzfuVOPZ/SJFLTt9ZOuvXn4+SJzF/52kCZmbxCvKDgdG/V/jqxOyL6rm4+AZ3HtulrJ7ldhnWYRLw9OLg09cUKuzE/dPh/+QM9OOnlB3oXbiPIam3n4k4CqTX6Bps81B0PMtPqvhpQ3KyNoOc+sqGjXdvq4RUw2+2HoDNUkR6E1Bn1/gJnly0dNoemjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV/0ukPoHgh0TCib4pGGTuiPzQlRTt3gtJVGRpgVMY4=;
 b=oYjALpAbV/yaRCetl8DI0zaPrrhdRbRvAYVlbzG+d0rGFB4CWAdoGHdwqP+Rt7wKdBnxy84rlj5h3HfsK82nRFUcRbgA41bjtD1M+ESLMBCVXNN55GUrAU67saG95gBHr4I/5IL6plPU80mNI+NYr1tDE/9WNtegGqyoXBKOl9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH7PR01MB8809.prod.exchangelabs.com (2603:10b6:610:24e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Tue, 2 Dec 2025 19:19:45 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 19:19:45 +0000
Message-ID: <ebf95db6-432e-4912-958b-d90f92c635f5@amperemail.onmicrosoft.com>
Date: Tue, 2 Dec 2025 14:19:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <2ef6360e-834f-474d-ac4d-540b8f0c0f79@amperemail.onmicrosoft.com>
 <CABb+yY2Uap0ePDmsy7x14mBJO9BnTcCKZ7EXFPdwigt5SO1LwQ@mail.gmail.com>
 <0f48a2b3-50c4-4f67-a8f6-853ad545bb00@amperemail.onmicrosoft.com>
 <CABb+yY1w-e3+s6WT2b7Ro9x9mUbtMajQOL0-Q+EHvAYAttmyaA@mail.gmail.com>
 <3c3d61f2-a754-4a44-a04d-54167b313aec@amperemail.onmicrosoft.com>
 <CABb+yY2-CQj=S6FYaOq=78EuQCnpKFUqFSJV+NHdLBjS-txnAw@mail.gmail.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <CABb+yY2-CQj=S6FYaOq=78EuQCnpKFUqFSJV+NHdLBjS-txnAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:930:5::31) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH7PR01MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e90440-9e51-4ba3-b374-08de31d7c0a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0hUVDU0QzhRZHo4cTNzam9XWnB4cGhOL1BOYlJ1Rk5qVUNTcUVvSEl2WjRV?=
 =?utf-8?B?RnlBZ1BZSXBGbGN2aWh3eUJOR1hjdDduTDVlb1o1WEl6ME4yZ0NXWVNQamNj?=
 =?utf-8?B?cDFaVzVKeHR3OGE3cmEwdGdEZ0x2MWpSdDUxRmg4WTdKUXFEakRMZ1Nqd3lp?=
 =?utf-8?B?WXBDY2FMcjNPbzB0aDRiRWJJZ1paRHV5L2g3ay9aSFVNV0ZEUWJ2dzBwOTVG?=
 =?utf-8?B?cXJBYTQzZnV4bUNMcEF1blZiUmFNYy9DRUh5ZGtwU2RSY29ZdllGaTFENFdi?=
 =?utf-8?B?b1d0NTJTUGttNmlQa3V5UDNwdzFlVzNHSlB4SG1KUER2bU5QaGpCdXV6NHFR?=
 =?utf-8?B?OGRTRk5jdVcxbTRxa2RDZWxyV2dHeHdZUmI0ZnpMcEJJakpXbncwRm1QU0Zz?=
 =?utf-8?B?MTBKeTRwL0U0dHVUNEZoMFRnNVlTbm14UDkxNHI1eW9rM3pPclIxU0hyVThY?=
 =?utf-8?B?OElPNTBWU042aUhJcFdkWDBwRlRsUG5abkxxUlEzdzJyMmlGMVdrOW5vUG0r?=
 =?utf-8?B?UDJBbnErdFVBTXJlTXcxTTRmd1dOc0pWU3FUSHFHSXNlOFVWdVN4ZFZtZmov?=
 =?utf-8?B?MlJPTlY2Szh2Z0tkRVNpTEdKeHovbzVTZ2I4T0kxQ1E0NzVCUi9DNmh5aU9T?=
 =?utf-8?B?YWQ2WnpLWVhuUHZQRVFIREFBK3pEdmRDNmV2NjcxQmdCRUFkYXZFWU9KdDlZ?=
 =?utf-8?B?emwzRHNqM1J6Q1U2L1llK1ZyS2tac1RWeGwrU1pNZ3RMQVJpMklqRWVQZHBr?=
 =?utf-8?B?V0k3MDBSOWF5U3pJenV5b1VJSnM3UXZGM1pabHZrbmQwV1E2Tk8xelYyK08v?=
 =?utf-8?B?ZzJ6cFhJTVhWUFFCZnBaZkFueTJmdzVaQ0pQWXcyTkQwcjRSYTg3THp1OXAx?=
 =?utf-8?B?cXZ3V1gycTVrUXdHMUFreUNnZlV0ZTgxcnhwWkpNang0bTRlWGEvVXZnWDN4?=
 =?utf-8?B?ZFU5MkRFOWNBcTMyS0YwcUFzbG1KTXhTUkVIeTVpeGFtNHJTNHI4bmZFaVd2?=
 =?utf-8?B?WjJ0ZTRJNVhZblJ2bDFnQTQwMzlRNUN3UWtiMWRtOTNNRDlRRGVtUURoK0ph?=
 =?utf-8?B?SHFFQjlYd1VVdWdKZ1lyVDV4YVpjemlsQk1Cc2FyYVgxUEZuaEVrdXg3ck9T?=
 =?utf-8?B?TkRPanZWY2I0cVVXd3AyUGNTRzZNMFdGcW5zbWlXS0JlQVpiaDBjY0J4RmVM?=
 =?utf-8?B?cnhZS3RSWnZwd3JyMVlaUVlxMWo5cHh3Vk1rWW5od0N2M3dkQjdpTmQ0QzJV?=
 =?utf-8?B?UnNEdlJoMmVhZU1DOWlta3M4TThqVEVhL0NEVTRmQnRqbmtnSTUrN0hqN2xu?=
 =?utf-8?B?dm50QXdMWTVDK1Jid2ZDRmozODE2bzcyK3lBZzhmemRFcHV5NzBWTlV4blZt?=
 =?utf-8?B?L1A0OXNSUDNtOFVyQVo4Z2dNRTQ0SHhpM2haZFNsdTZEVlorQ296UHFBYW0r?=
 =?utf-8?B?ZE4xVWlZUEl6TEo3T0p4Rlg3Vlk1dElEZkVUNWRYYmp3Y0pSRzljaVpjR1Vv?=
 =?utf-8?B?R1NRTkw5MHVZTm1TTjlSV202a0RyQi9yQjlWZ3duQ2xzUVQ3dkd5NUtrNU81?=
 =?utf-8?B?cmRPZUVEc1VxZUdmd2c4RVFWczRDWU50V2F2Q28xRkFYTkdGdFhuM25NR01L?=
 =?utf-8?B?aHp1NlBhQ0cwMjNHR3U3TS9PMnJJTzNOREhuRlNNT0JXSmplemRUK3JKMjJY?=
 =?utf-8?B?cm5DaFdRZXZ1Ym5XT3hlV2t3K0l0RVI3ejJxY09Lc0FHalhqTlNXYlpsaXls?=
 =?utf-8?B?UDFCdzBzdnQweUE2VXkrS3ZYZ3p3VDlJTzNQQ0VsQk81YmtEeVhGcG55UUJa?=
 =?utf-8?B?UXI4dGRjbFY3b1ZSOTlDRk01U2cwN0lzUVFocWE1cnlLbG85aU5Ua1RRQ2ZN?=
 =?utf-8?B?ejFyRm14REhvTlVOeDk4UUd4aTBuMXdLYWpDeUREVllWSUFMenArRlljUm9I?=
 =?utf-8?Q?XLcMVmmeIOatb17Wq95Rdu5id4ne4kGo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1RkQW5TRVRIbmhTN3E3M2ZZQ1JOOTh2VXkyV05DQ1F5V3pVRjJxanpZWXNl?=
 =?utf-8?B?bzRNN3hzNEp4SFFTOHVGWlltWDVrZEljQ3EyeFB1c0dCcXBlY0VMRTJxTHRy?=
 =?utf-8?B?QWpvSlpVVUFRZER2OEszL05VNmRsNlpZSk9aSDBFb3dEMHlLOXcwTmNpa081?=
 =?utf-8?B?VGpyZ0hocnBRYml0dmhoRW1tcmd6R1UzaFhlSXpoQ2dDUzNQTlFxem1jSEMx?=
 =?utf-8?B?aVEzS1N3Zld2eUlyRnp1MWRyTUcrc2RSS0NnbGQ5TWUrbTlTZGNFeFZTa3Ar?=
 =?utf-8?B?dE9KckpHNHBybXNzbWlIVmFwZEl0bXFEZzNDZ0lSWDN4MHN5dVlPQ25CN25v?=
 =?utf-8?B?UEpDLzBpam15bWtNUGpzM0JwdHhWVjJsbHE4Q0FkY3plL29jbm5QVFFVTFFT?=
 =?utf-8?B?L0dTeEZLNm5qS1QrS1ZSUlhRVmFLQTdmbGFqSVpPQjk3UVJLWkZIRVZ1NzlM?=
 =?utf-8?B?U1JLTUtHYkFoWTlRbGRQNllVRWpEWWNlTkNPQ1QzV3NhY0NlUlB4K3ZWMDQ3?=
 =?utf-8?B?NGxqR2tCdmxxd3RwUGdoRHNMQ0pQT2tmOVpiMk1wRE9pT0JTdWlxdjl6MEp5?=
 =?utf-8?B?V1J6RXh6TG81T2N0NTlRM2FNV3RuRUtmMEFKZmoweHlzdVVKUGl2dTI1UnN3?=
 =?utf-8?B?RXlQTyttb2JDbjROZHNueHN1T0VUcHduRGRVTCtMZ0Q0MkJGeVYyUGVPV21s?=
 =?utf-8?B?U2xkSmZZTW9WZmRaMFlwRHBDbGJPZkxHZlc5RmhNU05pRDJBUVZOVWhrVk5u?=
 =?utf-8?B?UUVJOGFRTzFsUUl5dVdjNGpoK2tOZlU5ai9EZDNHY2RFTFI4MGRzQzJXbkpa?=
 =?utf-8?B?YzdSZHhFUVpHa28xVXZQVG93Zk1IeWtTMEtTbXQzUVYvRXNXRGo2NVZSU3A5?=
 =?utf-8?B?SWtEeTQ5NHJ5ejJVaVJWcEw2K09GREc4SStWdys1d29pTUtBKytmQ2dFOEhP?=
 =?utf-8?B?UGh5clRHWElwTHFsTFZKOXRUVERTSjlqLzBUUTJRclB3bzROOVM1RGRRQkZR?=
 =?utf-8?B?Nk5aUEczTElZRnRwNm1YeFhDTEdReTBNUTBkYk5mY2NCV0YzNmxJSTB0VlZY?=
 =?utf-8?B?aDV1VjlLa3Y3YTVhUnJmM1AyMU5OcXRsZkFPSUdNT2tXaUtLV3Y4K005ZjYy?=
 =?utf-8?B?ZDVaNC9MT2Nmc2pmK0VJSzBCT2lZMmFmK1lVSzFLRzNGem9aYXpiZ2l2Y1po?=
 =?utf-8?B?bVBsTkFHbjllZHljSjlNWGRqY0h2Y0xuc1BvVmhlMU5NNWxCRGhnbEpoVk1q?=
 =?utf-8?B?L1lnMUZLYlhUNXVZUkFWMHdBaTJyYXorNWhCSXNobkZkUytNWjAxclF3QlhS?=
 =?utf-8?B?akNXc1ZyQVhxNjNxM2V3UDcyeHpSUTFrUmg4MUgwOXFLdXdNQVZ3OTJUUnF2?=
 =?utf-8?B?K2FSdmVDZ3E4clRzLzB6ZVg5dUdmUkpVRGdzcU1qZnBQcGgzVGczb25ac1dR?=
 =?utf-8?B?OUhVRnZsN3p6eHE0anE4RFp0c0p3Ny9QMlduRWVPeWNQeXdQUzl1bHVqNlFZ?=
 =?utf-8?B?VUZZYW5TQkFoM1pNQ1l3cU42ZU0yLzhiK1ZkczNRUG9ERWhtRFVFSnppUU9B?=
 =?utf-8?B?cEZaQU1sbnJJRFJLSG1OVk11OEQ2YjdabUYvaWREeUg3NGNVeEVNSEFzVlJo?=
 =?utf-8?B?NktBVjlOd1ZJd0ZDSkVjbEkwTm5DNGFvTUQ3R0tlWVhPT1Z1ajF0TmorSjcy?=
 =?utf-8?B?SEdtWldyME5oMExEMWFrcjAyZjZycXJMRUV5cFgrSzZveTFldHFqeUNJNXNI?=
 =?utf-8?B?WUdGQjlpMGRsT0VNYzBRVmZQTWJURjF2UXZRaThSWUZDUTNzVXBhV3owWGNy?=
 =?utf-8?B?UUVIeW91UWpodkZGU3MyejhLUmtKZFd0TW1pL09ZaXFtWkkyaVNrN25nWG5o?=
 =?utf-8?B?bUdCcnNqUFdpTjdidGtwZ0dObDlqdk9uSTBTbUhDdlp6dHZoS041SklLQkJs?=
 =?utf-8?B?c20wUklBcVBXaDFjNXU2UDRpcUFFbDBrUWdrOW5IUGVONnlTeFVIcHlRVVFw?=
 =?utf-8?B?c1hqQmd5MVRZdXdCMWtRNTdnS2M5YlNOU3ROUkZzbGhWSXZJY3FhT3llR1l6?=
 =?utf-8?B?VG5jUnZtY3ZLTjhKNHFaREJGYVNzdXZKYlo4azFHcXVoV1ExaUFmMzh0Yitp?=
 =?utf-8?B?MGQ3aUpGMmdHQ3V3Nkhzb2J1OFZYanFLLzdSNEJHUVVWUnBKblp0SVM0b3kw?=
 =?utf-8?B?K1hXTjBEWnc1Q2RwZm4yczh5bUtieXpLU28veU5IVVlGb0duaEswYnpxQ1d5?=
 =?utf-8?Q?AybcedV/5C9z2pv/zHMvjV4qpYNRO1yBLS428DfckQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e90440-9e51-4ba3-b374-08de31d7c0a6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 19:19:45.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNdu980KqpTeP4GBB+AY4+r9/RAV2SPMKwKuP6nbo59bceKV9yPtevo2ufkTI4UqUCh/B+oX4qgvVIeGcab6u/YtvIdS7xfhEsYyqM4BwuE+LiV67X7LUVOzwhU+ioQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8809

Can we get this and the corresponding follow on changes by Sudeep merged?

On 10/5/25 17:29, Jassi Brar wrote:
> On Thu, Oct 2, 2025 at 6:17 PM Adam Young
> <admiyo@amperemail.onmicrosoft.com> wrote:
>>
>> On 10/1/25 16:32, Jassi Brar wrote:
>>> On Wed, Oct 1, 2025 at 12:25 AM Adam Young
>>> <admiyo@amperemail.onmicrosoft.com> wrote:
>>>> On 9/29/25 20:19, Jassi Brar wrote:
>>>>> On Mon, Sep 29, 2025 at 12:11 PM Adam Young
>>>>> <admiyo@amperemail.onmicrosoft.com> wrote:
>>>>>> I posted a patch that addresses a few of these issues.  Here is a top
>>>>>> level description of the isse
>>>>>>
>>>>>>
>>>>>> The correct way to use the mailbox API would be to allocate a buffer for
>>>>>> the message,write the message to that buffer, and pass it in to
>>>>>> mbox_send_message.  The abstraction is designed to then provide
>>>>>> sequential access to the shared resource in order to send the messages
>>>>>> in order.  The existing PCC Mailbox implementation violated this
>>>>>> abstraction.  It requires each individual driver re-implement all of the
>>>>>> sequential ordering to access the shared buffer.
>>>>>>
>>>>>> Why? Because they are all type 2 drivers, and the shared buffer is
>>>>>> 64bits in length:  32bits for signature, 16 bits for command, 16 bits
>>>>>> for status.  It would be execessive to kmalloc a buffer of this size.
>>>>>>
>>>>>> This shows the shortcoming of the mailbox API.  The mailbox API assumes
>>>>>> that there is a large enough buffer passed in to only provide a void *
>>>>>> pointer to the message.  Since the value is small enough to fit into a
>>>>>> single register, it the mailbox abstraction could provide an
>>>>>> implementation that stored a union of a void * and word.
>>>>>>
>>>>> Mailbox api does not make assumptions about the format of message
>>>>> hence it simply asks for void*.
>>>>> Probably I don't understand your requirement, but why can't you pass the pointer
>>>>> to the 'word' you want to use otherwise?
>>>>>
>>>> The mbox_send_message call will then take the pointer value that you
>>>> give it and put it in a ring buffer.  The function then returns, and the
>>>> value may be popped off the stack before the message is actually sent.
>>>> In practice we don't see this because much of the code that calls it is
>>>> blocking code, so the value stays on the stack until it is read.  Or, in
>>>> the case of the PCC mailbox, the value is never read or used.  But, as
>>>> the API is designed, the memory passed into to the function should
>>>> expect to live longer than the function call, and should not be
>>>> allocated on the stack.
>>>>
>>> Mailbox api doesn't dictate the message format, so it simply accepts the message
>>> pointer from the client and passes that to the controller driver. The
>>> message, pointed
>>> to by the submitted pointer, should be available to the controller
>>> driver until transmitted.
>>> So yes, the message should be allocated either not on stack or, if on stack, not
>>> popped until tx_done. You see it as a "shortcoming" because your
>>> message is simply
>>> a word that you want to submit and be done with.
>> Yes.  There seems to be little value in doing a kmalloc for a single
>> word, but without that, the pointer needs to point to memory that lives
>> until the mailbox API is done with it, and that forces it to be a
>> blocking call.
>>
>> This is a  real shortcoming, as it means the that the driver must
>> completely deal with one message before the next one comes in, forcing
>> it to implement its own locking, and reducing the benefit of  the
>> Mailbox API.  the CPPC code in particular suffers from the  need to keep
>> track if reads and writes are  interleaved: this is where an API like
>> Mailbox should provide a big benefit.
>>
>> If the mailbox API could  deal with single words of data (whatever fits
>> in a register) you could instead store that value in the ring buffer,
>> and then the mailbox API could be fire-and-forget for small messages.
>>
>> I was able to get a prototype working that casts the  uint64 to void *
>> before calling mbox_send_message, and casts the  void * mssg to uint64
>> inside a modified  send_data function.  This is kinda gross, but it does
>> work. Nothing checks if these are valid pointers.
>>
> Even if you pass a pointer to data, what validates that it points to
> the correct message?
>
> API doesn't care what you submit to the controller driver - it may be a pointer
> to data or data itself.  Some drivers (ex MHU) do that, and that is
> how you could do it.
>
> -jassi

