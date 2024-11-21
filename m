Return-Path: <netdev+bounces-146626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010C9D49DC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EE3281A31
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB751CBEA3;
	Thu, 21 Nov 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AwCLovxi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDFA1A9B27;
	Thu, 21 Nov 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180963; cv=fail; b=E+M8n+v7a0u/7zPJZPRMJKwm8vZol6cUGrZs5HFcdlnVbjTyTaZY1kIULaYDvQmklx3/DvPWAl5l4ksTyKvf+b3OL8yWHZ0q2CzEyxkrW7RoTJnFopf8I4q4+HsOO6diyvjfOdCGIOpjEvlR+pr3oVfGHezKNVRAkAECThGXWT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180963; c=relaxed/simple;
	bh=uUdpJKZnnOZmKFRvhOlm7Lv2DRk7D0J47ocP+IwCV6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JKpmXNtNIwutkBl0PUKOMNzi6ANiR1dSLoA/RY2duIlXsRhci6+6q9ub6CvyAxQiTgtv55XndNFkvV4AntHaeHNJiNDjXEC/IfoJRbynOODJ4d59kft/xpGbVhln2JyPfz98iuZCtNF/qrY6IJ2jtA6J109Ci6CYzO9TVl0fCdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AwCLovxi; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs/0msjJwO3YriBwfskNsCuU4EtRCPWAHRGR3bgmmXea/wpOUmRZfquSXFWD8+P2utjvdVtr8GHjUEPFoFy2xEvVE1VBNzX6N+0exIPkAoBCw5navAx6denv/waE+mdFUwGJLIXXV6d4u31ICLUx4htiLuTEOWJprxoVf4w1wZwE29H79+vSohyrSLR+BnSDCWh1ljjI0LNUbkLRIP3FHF0vEYg4raHh42NbQjeQ24aHrnoswtxdKZuW4x4Vr9GdIdc62Q7lsk8fsLyEuqCVW5p7Utop2l3IfTgAWjnhPbyhbaZ2CvXJEVoXbgemYp7DHoI50OoVTh3QZLXF7Si/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZ0i7wD5wuu2CLq/y4SNyVE/qIUkeSVWLfC08A8H/hg=;
 b=ic8tvJMi2HM4FReHuEeHABvINGUATLwF6Os22ElByX0VlQPUo2q/pz1Z3PvSKqDZVpHrzxSBn4RlKXrgqMI3lIngGrj0lTDrdrOOHsiKxjJx3I7qCiDtOyik3iY0jVqzDf5ApuX1bkbEL+1N/7BWHzV4DiZd+lZdyN3xln1wKRkTXfWeWiRVN83LDGDV8UjvLdCdV0QVFsZC/AJQ7uhViQ66d4UItxSuKhHvO3GEGAiGfktGSgaUDH0ETPzaSreQmzkaxhlqLU5JF8VayAXkbMKmvt9ZXocHwbvwJ6X2AK5dpLJJP2hXZUL3iHBpRZlXqp2Be5ZysqVQYoyBBaa5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ0i7wD5wuu2CLq/y4SNyVE/qIUkeSVWLfC08A8H/hg=;
 b=AwCLovxiIkXCC+CQt3f6+/P8PhlolKHcWT+64lRQ0UBI0K7ZZwMIloFKntCcDESsDLwd00FCDEHhvn2XP33CUmnvHqkIoW3r1yDJulwNlJZcAzXK8MhhEfYLu7gABAVPBKFNCSKB62BLI8MEzJbtkZH7EUWa4EuyjK19TU+WTPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 09:22:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 09:22:38 +0000
Message-ID: <67a1ded1-c572-efe0-6ba3-d21f5c667aa8@amd.com>
Date: Thu, 21 Nov 2024 09:22:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 10/27] cxl: harden resource_contains checks to handle
 zero size resources
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-11-alejandro.lucero-palau@amd.com>
 <Zz6fI-EZYdS5Uw0S@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Zz6fI-EZYdS5Uw0S@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0035.eurprd04.prod.outlook.com
 (2603:10a6:10:234::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b006bc-592a-4b4c-b16a-08dd0a0e0a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1VpRzdWVVc3emNoaGNsQnRQUDEzZVVlaUFMUGZDVkJMQlA0bzBDdjcrZnBW?=
 =?utf-8?B?R1VLV3F0YkxtZEZFc25zWnp6SXp2a0I3Yi9KZEg4MVRqSUdWVmhoTnhDSklH?=
 =?utf-8?B?RUhnWVhkRnJoWHlUZUw0eFlINUVGQUFaem41STRIRGJGcGNncXZzYVZKaW5a?=
 =?utf-8?B?Z2hCZndpay9TdHQwcThycEJMZm9OWWxrOGwyeDgrempXaEc5VExjeTQweTIw?=
 =?utf-8?B?MEwxWmV5RUtsSjlxUUZkRlZQeHVvWFpDTjBwUmc5aGMyb0xIWDRlVDdqOUFM?=
 =?utf-8?B?ZUduWHNZNlNrMmlyV09jVjF6OWdoZ09EN3p2TWpmdERkSThMUHp4dlFHK0o5?=
 =?utf-8?B?M0Q0Y0Q0ZGtrZ0trZVphUGRKOGppVklaN1l5RmtNQXVlT2JhN1NoRFQ2MzY2?=
 =?utf-8?B?cCtsNVNtNWNlaWhkTUp3N1RzVEowQ0JZMUs5WjdQaTF6RVpnTnI3Z25HR2ho?=
 =?utf-8?B?U1oySnFBN0xGclpVWHpCOXRIazl1Q2gvRmxMUUo1NHJRNjdnb2JpU3huWXdT?=
 =?utf-8?B?ZVA0YzZiSEtjbUJHOUFWYmJXbUxQZ2hwMTdhVHZlRTArRTJBWWZrUVlpRUxC?=
 =?utf-8?B?Uk1hb0pTYzVqaXVRa1pHSEZDS1MxdHVReGc0aE9MQ3Y0eSs1SFQxZFpvYjV4?=
 =?utf-8?B?aGFZMWdhcThzQmVVVXdDbFAxM0pGNkxsUTBSV29wK1JZOEh2MEVTbHdtSVJ0?=
 =?utf-8?B?SmhOa1BxWlpHVjZ1UkZmSTd2ZENQbks2K1JkeFRyTVRTWFk3NUc4ODk2QTRR?=
 =?utf-8?B?QTRZMGZ1eE54MmNiazd4V1BVaFZqZ3FnZVIxblNxRHFHcllMV1JPRlNKcjdk?=
 =?utf-8?B?MDgrT1g2OG1BT3A4UkFJTURJTUlTZ2lSUXRjWFJPRFI2ajVQT2d3emMrVzh4?=
 =?utf-8?B?K3IxaEpqTXB0Zmp5ZDljQkZrWkhxYTA1YXkySFJWLzB1UHhRSkFDMVRwM0NH?=
 =?utf-8?B?V0FPeldMUjFzR2NEelQyOSttb0ZRcFhHbUJ3a21FUiswUjczZ1R0RDBTeGc4?=
 =?utf-8?B?SUJQMGJNWmt5TlV0Z0RYYVgwSUV6R1NrVU00TXUzNzJVTDZDOGpMNkZLdnFR?=
 =?utf-8?B?UWpDZy84OGRFRGJJanpvcllYNzQ4ZnJnaUd0MnBRZy9pa2dGTU12KzU4UHRt?=
 =?utf-8?B?aUFydjBxeWU5WEpnN1V3WFVHMlZ2Y2VkTXNncExwN3lhcVVPd3VYc3B1ZC93?=
 =?utf-8?B?WFlBWTI4MnBRQ1JNVjNoWlRNN2V1aVdseGd0L2dNYVllS3hCcHBYQ09NZ0Ew?=
 =?utf-8?B?SmFYNVlmbXZUUHF6cGN2ZnF1elFxZXpyVWlQcUt1ZDRpMW1ML0lpTDl4V0hm?=
 =?utf-8?B?TzJ4a1dCRlJOSGFnTERkRWJvUzFoMUlrWnIzUFhERU84ZmVaS3JzY1dxQzRJ?=
 =?utf-8?B?ZGNDRG5ibTVBUzAwQVVoeTE1NzhaY1M2SWQ2OUhVcnJRU3A2Z1l1ZmYzdnNS?=
 =?utf-8?B?Yk41MkZ2aCsxVjVva2dONDNGNjlOcnB0Yy8yblMxWjJHalRVcTZHMW5Bd0Q4?=
 =?utf-8?B?NGpVZjFBVmZlQS9FVWJ2TktzQkhTUGsvbkNYS3pYTjIrZDB2T2REVGF2bmZS?=
 =?utf-8?B?anJRdWQrY1JSWXFuUXAyb1kvdXJFWDVoUFVjMTBCSWJYVUl0Kzh3eHhWdVh5?=
 =?utf-8?B?d0RYOW5UQi9kSDZjeE0vMmRmSGw2MUFWQjJCdUVmQkJYVWVpZDBnRlhzRGRv?=
 =?utf-8?B?d0FvNndNczJJaEdiRmdYcFZvVzZWcHVFdVNYbHB3L01jME43bTNjVmlOdzFm?=
 =?utf-8?Q?VHnCTVevwm+/yriHHmY9k/VngCiOwqpphdkRlGD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3BOR3ZQSU43YzVHb0lHNCtPT1pCaVMvcWhmSkM1OGo0ZDh6VzU4ZExTbHBW?=
 =?utf-8?B?MTU1QnVnanpzbWtyRGFlZWNuOVdibXJFZ2tuMnJ3S21LYnlWcDdWS09KSGw1?=
 =?utf-8?B?UTJLQlNrUkVOMUsvR2EzRkcyODczTExwWWs2ZFhQS2l6N0o5UE9NcHJ1RXd5?=
 =?utf-8?B?anJ5b2p5MVhyTGd0K3BlcmF2N1h5VTlsbUR3K3JJdi9lejhPYUpNYXFtekk3?=
 =?utf-8?B?ZVYxSXZGdlgydkxQZ1RUUGJuckFmclZvaEExdkdLc01PNm1qRXNnSFRLcVpJ?=
 =?utf-8?B?OFo4NDFuQ3pKSmJudnA2YW10RHAybzBZWGJ6V1l4a0RzU2xBTitZWXRWMTFz?=
 =?utf-8?B?bVU2Z00xNlFndlFvYURlYzlqOGFYOWkxYkp0SitTeVNjS09LQzlDSjdTT1ds?=
 =?utf-8?B?VU1ZQ05YbGNGT2hBdlZmS1RRTVpYa3NxaUQzZkU3YkhUb0dWalUxYzNQNk9o?=
 =?utf-8?B?QTBQbnEwcEF5ZTlJb0NnZkllRDg4ZHU2UGV5MEpaTHFQb2NYN205REJKKy9u?=
 =?utf-8?B?aHc5NWJDMS9BdjRUbG52cFA5aGViU0w4a2VqcjZ4TGI1dlVSZFh6TEdLSU1a?=
 =?utf-8?B?UllEWW5OYWtFaXpyZk9Zd2VZU1NFTUE3WUZMaVNvcUZhVUVIZUUrWVF2L3pv?=
 =?utf-8?B?NlliVnBGVXpmbTV4c0FuT1RMR3RuK05KeWpFa3ZnS012Mm5BT2U4MHpFd2ZR?=
 =?utf-8?B?YUorVUhBNVR1YkZXMHFyNEFYN0txd0VRYlU2MlpXVG1YWFIyQi9VZ014U2NW?=
 =?utf-8?B?alcxWTRkU0liYTZuVWptelJOTHFXZXY0dU5aclhzeFAxTjgzdGtneXJBd1hs?=
 =?utf-8?B?bklKT2JTVjA1bklTTWNsWXUvUC9OMGYxT3VkdHErUU1mZ1lTYUwyeHBxTWlM?=
 =?utf-8?B?Ukh4YTVPR3pERFFhR1BtZ3JOdVFDTDh3cE5rRFlXOHR3endRMGhrbXVZbzJr?=
 =?utf-8?B?WkxIWmd5ZUN2elR0bk1FMVpETjVaVndxWjVSMExQdFN4V1l1L3l6UmVFVmkw?=
 =?utf-8?B?ZTVqQnpsQ2I1QUIvdWFSUExCUmNwbmZqbUdoY0phTFh0QXd2dExFTGhDM3lu?=
 =?utf-8?B?dmF0T2FaQ3gyb3dnT2RQMU51SXZrd2Rkc0hla2NkKzFxTjM1UFpVd3VzS1NC?=
 =?utf-8?B?eG4vNlhZVENOMXVtaEw1UlByZzNRSnVsbW1lenpkb1pHUzV1eGQxWTFWb0dz?=
 =?utf-8?B?WjdQaTAvS0FGc1gwbWQxU2ZRUWFUMkM0dVhGV2RTVitsL3hBSVNmeG1Dd01N?=
 =?utf-8?B?SjBwZE1saWFNWkdrc2c2cTFHRFpqc2NiY05HTGJhbzVDQWRxT2lJUXlKVzgr?=
 =?utf-8?B?b1h1anlFOG9tYmNjbnlHSUt2dlRMY25KSy83TUNtTVlzc1l2NEJCY3VVUEJK?=
 =?utf-8?B?TW1jdS95dDZrMEx6N0lkcjJlVzJIZmZwTlFMUEYvT043K1dTZGU5Q0N3dm9w?=
 =?utf-8?B?SUR0cGZKQ21QR2ZpZXBDSVFUdXo1bWhTb3grZkxHRHZVUkVxNDZiYmRNbElI?=
 =?utf-8?B?WWtrc2FCb29TSHM5YUp5S21GU2VEYVRIRzc3RElFSVVpM3M1SG5BU0RvQmFX?=
 =?utf-8?B?Z2N0OFFJTytVd2JYN2JkRFJNbmJPYTd2dW9zOW0vZ1huOUlMQnFjam1pdk13?=
 =?utf-8?B?M3RReUx2QXdKd1VxVldqMXJFQlZEeVVsOWVUQnh6N29QNmJkU1haajlMTDI4?=
 =?utf-8?B?cHI4bGRNd2s5ZjhFVmNVcG9zS29rbHBzR0FkeDRKZ2ZCaVlZeWNvL2p4Wk5i?=
 =?utf-8?B?eUFqanFoNkxFN2FyNE14V05PUGJ0M2dYTk5hdnpTcjh5cWNycHVocHRpb2l1?=
 =?utf-8?B?OFh6YjZGdG14T1NWSlh0VGdmaklpL1c4WXhpZXRRcFpJR0o1ODA1ZDVkd2d6?=
 =?utf-8?B?TFhnRkEzYmU2U3U2MUI5KzlLSTBkaU9EZEZuM1FZRmpHcGsrd0E2Y2RhY050?=
 =?utf-8?B?YW1lNW41SkdXM2RhaDNDMTJ0MHR1WE84TzhnRnZhOVdFY0UrUGZTN3d3bmxx?=
 =?utf-8?B?by91a2twU016S1J6L2Ixb3VFYytQUWdSRTZOdVl1Tk5NMlNaTzg3b05XV0x2?=
 =?utf-8?B?eE56V3hjbk04d1hlR1Y0eDhwZW1CZGI4NkJlZWRjbVZhRUtIeEZWL0hFaVN4?=
 =?utf-8?Q?fjJW2Qinydlm7Ug1NmX7iw6iB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b006bc-592a-4b4c-b16a-08dd0a0e0a72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 09:22:37.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTZgdbU03us3Ac9+a1vfqBBpRdQfNj1S4SA5r0qAbu1Rll/kQ6X/7z7fkbKrMIxIB4ucwQVOkj3JAgP78ax0fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818


On 11/21/24 02:46, Alison Schofield wrote:
> On Mon, Nov 18, 2024 at 04:44:17PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> For a resource defined with size zero, resource_contains returns
>> always true.
>>
> I'm not following the premise above -
>
> Looking at resource_contains() and the changes made below,
> it seems the concern is with &cxlds->ram_res or &cxlds->pmem_res
> being zero - because we already checked that the second param
> 'res' is not zero a few lines above.
>
> Looking at what happens when r1 is of size 0, I don't see how
> resource_contains() returns always true.
>
> In resource_contains(r1, r2), if r1 is of size 0, r1->start == r1->end.
> The func can only return true if r2 is also of size 0 and located at
> exactly r1->start. But, in this case, we are not going to get there
> because we never send an r2 of size 0.
>
> For any non-zero size r2 the func will always return false because
> the size 0 r1 cannot encompass any range.
>
> I could be misreading it all ;)


The key is to know how a resource with size 0 is initialized, what can 
be understood looking at DEFINE_RES_NAMED macro. The end field is set 
as  size - 1.

With unsigned variables, as it is the case here, it means to have a 
resource as big as possible ... if you do not check first the size is 
not 0.

The pmem resource is explicitly initialized inside 
cxl_accel_state_create in the previous patch, so it has:

pmem_res->start = 0, pmem_res.end = 0xffffffffffffffff

the resource checked against is defined with, for example, a 256MB size:

res.start =0, res.end = 0xfffffff


if you then use resource_contains(pmem_res, res), that implies always 
true, whatever the res range defined.


All this confused me as well when facing it initially. I hope this 
explanation makes sense.


>
> --Alison
>
>
>> Add resource size check before using it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 223c273c0cd1..c58d6b8f9b58 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   	cxled->dpa_res = res;
>>   	cxled->skip = skipped;
>>   
>> -	if (resource_contains(&cxlds->pmem_res, res))
>> +	if (resource_size(&cxlds->pmem_res) &&
>> +	    resource_contains(&cxlds->pmem_res, res)) {
>>   		cxled->mode = CXL_DECODER_PMEM;
>> -	else if (resource_contains(&cxlds->ram_res, res))
>> +	} else if (resource_size(&cxlds->ram_res) &&
>> +		   resource_contains(&cxlds->ram_res, res)) {
>>   		cxled->mode = CXL_DECODER_RAM;
>> +	}
>>   	else {
>>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>>   			 port->id, cxled->cxld.id, cxled->dpa_res);
>> -- 
>> 2.17.1
>>
>>

