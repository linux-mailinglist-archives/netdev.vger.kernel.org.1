Return-Path: <netdev+bounces-177734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E48A717BB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C453B1D1F
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE81DED5F;
	Wed, 26 Mar 2025 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJHgr7JG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF57189919
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996813; cv=fail; b=Kyy8JUS6oh4A3Wpi4duStV9dTndaFDxgWmzqp8h0VACq2HW7B53AVCqBbxJiVJItfS1EW5Ss2XmoQmyoerq7z0difT3VSRPU0KmYdssXWAOUBYVyspApeiqXfWZtgqRNKjteWCtLS255hkBp6d+6wBxXn3X0qfLprDQGqMAY3x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996813; c=relaxed/simple;
	bh=5hHPSiqIB2SPy8oK3YgT4RHEGD8WlJ21yMfnHANb+0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LSWxbcVqDcsm63+CLWY4yvaBy+hSlhCq59RdOviVijW5gdqHMdK56fBGi8jbvvEXgIyZ/FJouN2pDB7RDvgBXWx9dGRnq5EVZJjfhyLQJaD7hPvvPoRORoJvkHIkZWx8wIeRN+MPADlFmEdEwG90dz/2Izm2EEPMCs+D/yRUoLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJHgr7JG; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+8ryAKzp8lY/mCcC0015Cc1DQOZtNzWhLlPdSaaCrazhdxTN30M/x1pYOX0IloW/SvEj3LBJ8Ov2blfqNYhbPhdTdxomQx+qOliakfb38U+uKnlwXydEPamW5wPxgsx4gJDvSEy9y8bdFpX5QXrKW4tRcSPOBO7WouvYY65dDpduOYrJhbJDcjKIRh9mMx6TyJtPvix5B8XV3H7z3o47AIvIRMkBFVep9jWRzt3dtBmpa7JM10LdEDvB0kMdaYPr9UIPMoaq2sKjO8goDktAzkRxLrWSmMYGzXtiU43TSNY2olny+Are1zeRpqHjDpWXQRUalKru64vDfop6HFB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zp/Z7KIilyZKwbjlvY8bi2FDaOUQwnjTYsQ9zjdMa8E=;
 b=FPI6jPH/JTiZjh3XUUBOvT9Sxa2Cymn5q6yrf7kGtI8xptmQprBYiKHzCQPCm3VBRp8z5asL3NxJhwBJnk7Pfy0PjXP9o+dMI7kCTkb4o5XH3KX/8qk4rR9y6mv9Ji5kmyAjCNeOKZZ02RRjj5CPwlNSxFSM/tod4RBu/0Yom8aOeVkVmu98f7rW7tdCmD8j2mzF7w5oPsFoQCgZT+lKeJxFnfa1ahM+P2Rqm+VFZyRNbh+qpimD8wTsKfeNgz9z/EU7BEpr6oX0mpVJD3pYrmQFJO/ZnFqjn5Pw6oE9fY4H+6dghxIuhT/Gyt3N7TjadYUNbNpLNCw/TnOvtU65fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zp/Z7KIilyZKwbjlvY8bi2FDaOUQwnjTYsQ9zjdMa8E=;
 b=LJHgr7JGyGlk88yRl8MTN9wtLFVxE2eS6Yzi5hW8rRBOtoJVQwLaLjjJbrQ3ZQpZvUHJ1YiHUhdS268I0SRvHw28F6ZLS7YlAs4vNTO8urWgbmGtJx0hEZZu5niiZG6l/zxTxgEiURtaj0MQ8sUV+EbCQcyMzeRYXaHUznrWBS6biQ9Pw0DrLAvPEkgSJXFvqfTqY/txeL4ZTn3zEcNzrzv6KdUxZfGOOpyqYXtvuy1o/8nPqfpA2TyHQ4NsfXnYqR7ReIvfgEjrLs8Tn6iJpU1w60GbDyqMxe74k7H55DUpkPrWZ6Q0CJe49jdoyhta32vx6P0Pg0X7CZflrsJ7jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:46:46 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 13:46:46 +0000
Message-ID: <97a94886-1252-4004-9a88-13430da1d25d@nvidia.com>
Date: Wed, 26 Mar 2025 15:46:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250217191129.19967-1-kuniyu@amazon.com>
 <20250217191129.19967-3-kuniyu@amazon.com>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20250217191129.19967-3-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0093.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::8) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: e871b327-eb7b-4d9c-0042-08dd6c6ca66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzVmSzQwWVh1c3dPVWR0Ymd6WVpnQ0ZFS2FVNGpqQk1FMlJ2T2hYYll0dHhS?=
 =?utf-8?B?Vkg1U0p0R3FwTTVGNjZ1ZnFkR1E0QzVTTGtHT0pDeHdGdlZ0MUxLdXFCV1R5?=
 =?utf-8?B?OWJQN1dnZFR2b01aNnUzNVMxTE1ocWtCZXYwLzI5dXMrTFI4TTNBN2JCZEFt?=
 =?utf-8?B?Y1VrUVF4RjloTmZUSDF0cHcrcWRJdUF0VVVYQldTOHRpS1piWjVqM05Fc2JB?=
 =?utf-8?B?dW1uc29yT1RmZ1IwRmVFOFBidjY3dkVYN2kremlod0JvSFRsVHViNmtBTWpM?=
 =?utf-8?B?Zm5SaHRDdEpta29wVWtvOVFyblJnR1NxSmF2UktUZ0RsYVQ5QjJuUTZ4MElw?=
 =?utf-8?B?S2U4b2czdTlpZ3NMYlBHd0l2SmE4bmM4cVh4RmV0M2M5dUtWZGJTb1IxZ0dv?=
 =?utf-8?B?eVM2anQwaXczUmwxMW91S1lGNytWRHBGd2wvOWZGNmlZeFFwOC9xdjNBY1B3?=
 =?utf-8?B?NTlsK3NGelp6OFdKYU4zbjlGZjhKWlFtSmt3OTE2cGVWUzhSaFJWZGpsbzZV?=
 =?utf-8?B?RGs4cXJPL1dSbUlkZmNlK1hQMUZiYTZMUHZ0YTQ5T0VmbkU5V1dTODlkL0hi?=
 =?utf-8?B?MWRZMWNRMW85cDIwNG9WU3N3NHZ4YVVjTUtMWWFmSkVQbytud2NWeVhoaG5q?=
 =?utf-8?B?VUttMy9jZjF4d2lkbExYZElPYW5TYWdMUk5RaEhGSGhKQzAxTzdYaXo4SVJC?=
 =?utf-8?B?NFh3VVZoaDBhazBHS25rSG9QMEt6SnBHa2JMSk5oaGpYcjJ2b0VuNjhqMDQv?=
 =?utf-8?B?NTFBK3dPTmsxanZiTE5FYWx4UGUzME5QWkhFVloramJWWlA5SWphZHBxUCtE?=
 =?utf-8?B?QThjTDNTck9rNDVKS2R0clJ5UE1QaEw3RXZ1MXNqT3VYWTNrSDlYaEpwZGtH?=
 =?utf-8?B?VVErRUZPOTloWWx3eXZXV25jVUVLQjBXLzFKK3FqZVJvcFdHMW1WZTdyeGZF?=
 =?utf-8?B?YnJsVDBmYXpGQnVuaHRPS1UralREblVVVDBFbmdyVEl5dnFpU3ZWS1R4MzF3?=
 =?utf-8?B?V3hTdGMza3RVb29KUjhlSFg4Y0Jmd2FTcVYxUDcvN0l1bUloa3dqc3RUS1JZ?=
 =?utf-8?B?eVBKbVFYY1BHTDIrNjJLNWNmQW5FaE1vNXFFMzg5L25nKzhRNTJsWFFKVFFo?=
 =?utf-8?B?Z0ZlRHJlZmRtVzRXamFiWVdnbmYxUjljU3ZGSkRaZTE5aFY3VHBwc0ttVXBu?=
 =?utf-8?B?dUsxb25pWU9mdWNnZFhMVytmYnhFNkxXMjFhU1plUXRac0tPd1RIMVRQazVr?=
 =?utf-8?B?SVBPT1RyS1dScU5ERStmdG1pNUlWVG4vYm9OdXZIT0VoMk93MTFoVkRYR1J4?=
 =?utf-8?B?V1BrTUJUZmZubElCL2cwRERsaldiK0c4Ny9LcEgyQ2ZhZGY3M3V3eUN2QjhZ?=
 =?utf-8?B?c2pSVUtDb3V5MGttSmRCZ2NrZDFrenZxeS85cDkyZVdodTNjYk5lTURNTFhj?=
 =?utf-8?B?SE13dU9Sd211WlpTSS9ZQkw5Z3VCZ09DaHd2OWF6azRtc0ZIaXRwT2YrZE92?=
 =?utf-8?B?eG4vQ1VxWUpOSERzZTNCcTY3MFJkYVNpUVU2UDZjTlFrTVY4dndQZzEvcVVK?=
 =?utf-8?B?cDVkVWU0TjV6dCtaOERrdVVTNHY4b0UxVDRpVnp2dGpkcG9HTHNQWE1ueTNJ?=
 =?utf-8?B?Mk56TkVja0lSQTRGTW41emZOZTRiQlZyT01MSHdyZmt2Rno4RUVzOU5ndkNr?=
 =?utf-8?B?cUFLVWVwUW5GSG16N1FZcmFtYXBYRm1ud2ZlUXowQmdYQ25mbXQ3KzgyY2ow?=
 =?utf-8?B?bWxNT0kvR0Y4S3VCakdKd3RVREN2MjA2bFFnZmFsaEFOK0lQODdQT2NDVUNm?=
 =?utf-8?B?V1VUaDlhMSt1WDQwaWpaeEVEUFdVMTcyVVIybUpFdlpUTnBCbXhYUjlLQzAz?=
 =?utf-8?Q?W+xS3f/t3VM+J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVhhYlZDemE5VDZjcWxNcDZaL3BWZlJGV3RXNGNjTXlTQUQyRlIzZDFST2Ra?=
 =?utf-8?B?cjZhQ3A3YUNXMXBRWkduVUIranpaaU4xaThva2lvR01CaDZ1czhCbTZGYWxW?=
 =?utf-8?B?WTVTQmdpZlQ4L3p0K3B4eEhvNEwzNkZEaEdteTNzK0F2S1hpWDNhMjN4Z21u?=
 =?utf-8?B?YXpja3VrVEQrOHBsVkVNYngvZ0w0OVhKK0VmWjViYmR0QzNQQzd1MGdyaVFR?=
 =?utf-8?B?T2ZvUXBkTGw5NFNxRTZxSW1VTzhoQ3VKYVJXKzJ6alNwQzZIK3lXK011enh5?=
 =?utf-8?B?d01NS0RHK0tBU0RNdlQwNyttcWw4MWlzWC9uOXVqV3BnZ1BtQ1QyeStSQkFh?=
 =?utf-8?B?K0lDWW1BUnFKcDdvNVo5RjJxc0Rxbmk3MnFiQW1SRXJVejhHZzRuYTNvbEsr?=
 =?utf-8?B?dVR3Nk9GTUROeXh0WG1XZTFubkE0SmFmZFdpYUNYcng3NVhMYzlaaWNYSmIz?=
 =?utf-8?B?dEJzT2VxN2J6bS9EVVRrbUh0aDd4ODNEZWp0NkhLK1RSZFVlZjR3SU5ZelI3?=
 =?utf-8?B?aW1zVFhGVU9BQUV5Vkd6dDJqN3kwbjE2eTNZWTZ3T2Y4akN5RzZLYnlIWEx3?=
 =?utf-8?B?NkU1aWlCZWRTUG9UNDBqVDRpTHMrbU5PMFhpUVFRdDBMVjMyUHhpTndxczZT?=
 =?utf-8?B?SmV1T0VQSmtvYklHVTVHeVovdDdSK2src241R051OVF2VHBsNWhnWE12Qm9i?=
 =?utf-8?B?V0pQRURFZGZyRFRFblhCK3BlMEJ6RUVsVHdCaGhYOWc0NWl4QmdDSjdzbEto?=
 =?utf-8?B?VEV1djN2Y3hCb2E2ZWVlaE9sQzNYNE9WWXNSVnRRaS9ocThWSFFYWVpEZTBF?=
 =?utf-8?B?akdnS3E5dG5pYlJIS2lmYjZXYXNXbi9QSG5uSldBNVdrTmR3c01NdnVtTS9R?=
 =?utf-8?B?Z016MjJXa2pPV2s0ZFQ5M3J6N3hsNlhCRGtDZmFicjFMYTJaOXpZSDFzOU40?=
 =?utf-8?B?QmFIdTZjdUJQdjJTVmFSM2I2TzNFYnJrbnN6ZUs5QXBSY2JTYkF0aWhUZ2l6?=
 =?utf-8?B?Q1pSU3ovczF2emZsTFRHVzRZRzRCb3NIZ1hJcXJPUGozR24yNlUrdm83T0pI?=
 =?utf-8?B?ZlBKcUlndWkrUXRjamZuOENPREJaTHB2bUczNWlMbGRLeWsrRkJlY2Q5ZW9h?=
 =?utf-8?B?TnZ5djUzTUFuamE0ZC9GWHJVemZxU3FxcnJhMVQxL2RRYnRVeUNBdjcwK0ln?=
 =?utf-8?B?MEQvY1FOdjJLTTBmaHlDakZ6MzFJUEF4eVI3L3dkRmxzYzhpME1kNVpoVU1h?=
 =?utf-8?B?OEZmbGZTZzhmdSticFJBaVRRN0dSRG5FMWY4TkxGWHRIa0c4c3ZHOEcveXRK?=
 =?utf-8?B?cHFQSmxwNUp3WDZzMDFSVmNyNi9UYVhPWjJHYmZHUjlWanhEeTU0ZmN1NThU?=
 =?utf-8?B?L1RqTDN1UmZtUHNsRUFsR1o0bWNQTDNIbVdEaEpIWjMwekluNVV6L3lsMG9h?=
 =?utf-8?B?QUZYeS9ITjRuazFKeldXejdTVkNxY2NQM0JreENsbnlOaUYzTGEwbkxXVlJK?=
 =?utf-8?B?bzFhQVZvZ3oySjhYclhjTmpPNFA1OU91cldkNk1LVVNNTlcyY1F6VW85aTFn?=
 =?utf-8?B?aGNKWDBOYWpiTm1YRmV3VmNibE1lV3k4MTJXTEduaHNHR0FqajM0bkd5NmVy?=
 =?utf-8?B?QURjVVNrdldnR3IzcG9QN2g0WnNKMnY2ejhQVDJtekErM3BTcDc2eVVaZW9x?=
 =?utf-8?B?S3o2UVlMVHhoV1did3l5aStHSndWdDNZRmo3V2JCTmk0a2h4eHpxdmZPWEp0?=
 =?utf-8?B?eHZLZnk0bWZybFlXYXduWDRLbUtXOXc0UDV4QlNXUTVHMnNWTDErKzJpME5W?=
 =?utf-8?B?TkwwdTllcU9BR2tSUVA3L3psTzh3WWhBVHllQTlzZElsaWVEaGdKYStRSFFj?=
 =?utf-8?B?YTIvd1dpNGd4M0VhaWU1aGZ1c245ZWFFUGpiTkQ3ZnI3UktWMGlQQWlFNi94?=
 =?utf-8?B?VERGc2htaTlwSzFkd1A2N2tkUTBjN3N4ci9yWVVPSlFIRzQ1WkM5dW1BU2xv?=
 =?utf-8?B?d1FOU3VGdXpSYmZsamZrSzNmOFJxdlZHMzBBQ2dhQVR4T2I0TFNlc2Q2UWhJ?=
 =?utf-8?B?d1h5cjQyc1VtaUpUeGRjZ2JBcm5mbFVqL09ROG9vTGlVbmQyL0RCb0pIbGtR?=
 =?utf-8?Q?JJDOVS2dUMALAKNP/Sh6Kfxpt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e871b327-eb7b-4d9c-0042-08dd6c6ca66b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:46:46.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DuR+sOOKDqH81CP9dKJS1aRrffuVyjykacdsj6456SPwp/DNcqKGyM+gWO64bOkGYVmDvlYqhlbvNWbU3Ysqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240

On 17/02/2025 21:11, Kuniyuki Iwashima wrote:
> After the cited commit, dev_net(dev) is fetched before holding RTNL
> and passed to __unregister_netdevice_notifier_net().
> 
> However, dev_net(dev) might be different after holding RTNL.
> 
> In the reported case [0], while removing a VF device, its netns was
> being dismantled and the VF was moved to init_net.
> 
> So the following sequence is basically illegal when dev was fetched
> without lookup:
> 
>   net = dev_net(dev);
>   rtnl_net_lock(net);
> 
> Let's use a new helper rtnl_net_dev_lock() to fix the race.
> 
> It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
> dev_net_rcu(dev) is changed after rtnl_net_lock().
> 
> [0]:
> BUG: KASAN: slab-use-after-free in notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
> Read of size 8 at addr ffff88810cefb4c8 by task test-bridge-lag/21127
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl (lib/dump_stack.c:123)
>  print_report (mm/kasan/report.c:379 mm/kasan/report.c:489)
>  kasan_report (mm/kasan/report.c:604)
>  notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
>  call_netdevice_notifiers_info (net/core/dev.c:2011)
>  unregister_netdevice_many_notify (net/core/dev.c:11551)
>  unregister_netdevice_queue (net/core/dev.c:11487)
>  unregister_netdev (net/core/dev.c:11635)
>  mlx5e_remove (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6552 drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6579) mlx5_core
>  auxiliary_bus_remove (drivers/base/auxiliary.c:230)
>  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
>  bus_remove_device (./include/linux/kobject.h:193 drivers/base/base.h:73 drivers/base/bus.c:583)
>  device_del (drivers/base/power/power.h:142 drivers/base/core.c:3855)
>  mlx5_rescan_drivers_locked (./include/linux/auxiliary_bus.h:241 drivers/net/ethernet/mellanox/mlx5/core/dev.c:333 drivers/net/ethernet/mellanox/mlx5/core/dev.c:535 drivers/net/ethernet/mellanox/mlx5/core/dev.c:549) mlx5_core
>  mlx5_unregister_device (drivers/net/ethernet/mellanox/mlx5/core/dev.c:468) mlx5_core
>  mlx5_uninit_one (./include/linux/instrumented.h:68 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 drivers/net/ethernet/mellanox/mlx5/core/main.c:1563) mlx5_core
>  remove_one (drivers/net/ethernet/mellanox/mlx5/core/main.c:965 drivers/net/ethernet/mellanox/mlx5/core/main.c:2019) mlx5_core
>  pci_device_remove (./include/linux/pm_runtime.h:129 drivers/pci/pci-driver.c:475)
>  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
>  unbind_store (drivers/base/bus.c:245)
>  kernfs_fop_write_iter (fs/kernfs/file.c:338)
>  vfs_write (fs/read_write.c:587 (discriminator 1) fs/read_write.c:679 (discriminator 1))
>  ksys_write (fs/read_write.c:732)
>  do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> RIP: 0033:0x7f6a4d5018b7
> 
> Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
> Reported-by: Yael Chemla <ychemla@nvidia.com>
> Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> v5:
>   * Use do-while loop
> 
> v4:
>   * Fix build failure when !CONFIG_NET_NS
>   * Use net_passive_dec()
> 
> v3:
>   * Bump net->passive instead of maybe_get_net()
>   * Remove msleep(1) loop
>   * Use rcu_access_pointer() instead of rcu_read_lock().
> 
> v2:
>   * Use dev_net_rcu().
>   * Use msleep(1) instead of cond_resched() after maybe_get_net()
>   * Remove cond_resched() after net_eq() check
> 
> v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.com/
> ---
>  net/core/dev.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b91658e8aedb..19e268568282 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2070,6 +2070,42 @@ static void __move_netdevice_notifier_net(struct net *src_net,
>  	__register_netdevice_notifier_net(dst_net, nb, true);
>  }
>  
> +static void rtnl_net_dev_lock(struct net_device *dev)
> +{
> +	bool again;
> +
> +	do {
> +		struct net *net;
> +
> +		again = false;
> +
> +		/* netns might be being dismantled. */
> +		rcu_read_lock();
> +		net = dev_net_rcu(dev);
> +		net_passive_inc(net);

Hi Kuniyuki,
It seems we are still encountering the previously reorted issue,
even when running with your latest fix. However, the problem has become
less frequent, now requiring multiple test iterations to reproduce.

1) we identified the following warnings (each accompanied by a call
trace; only one is detailed below, though others are similar):

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 6 PID: 1105 at lib/refcount.c:25 refcount_warn_saturate
(/usr/work/linux/lib/refcount.c:25 (discriminator 1))

and also

refcount_t: underflow; use-after-free.
WARNING: CPU: 6 PID: 1105 at lib/refcount.c:28 refcount_warn_saturate
(/usr/work/linux/lib/refcount.c:28 (discriminator 1))


2) test scenario:
sets up a network topology of two VFs on different eSwitch, performs
ping tests between them, verifies traffic rules offloading, and cleans
up the environment afterward.

3) the warning is triggered upon reaching the
unregister_netdevice_notifier_dev_net when both net->ns.count and
net->passive reference counts are zero.

 Call Trace:
  <TASK>
 ? __warn (/usr/work/linux/kernel/panic.c:748)
 ? refcount_warn_saturate (/usr/work/linux/lib/refcount.c:25
(discriminator 1))
 ? report_bug (/usr/work/linux/lib/bug.c:180 /usr/work/linux/lib/bug.c:219)
 ? handle_bug (/usr/work/linux/arch/x86/kernel/traps.c:285)
 ? exc_invalid_op (/usr/work/linux/arch/x86/kernel/traps.c:309
(discriminator 1))
 ? asm_exc_invalid_op
(/usr/work/linux/./arch/x86/include/asm/idtentry.h:574)
 ? refcount_warn_saturate (/usr/work/linux/lib/refcount.c:25
(discriminator 1))
 ? refcount_warn_saturate (/usr/work/linux/lib/refcount.c:25
(discriminator 1))
 rtnl_net_dev_lock (/usr/work/linux/./include/linux/refcount.h:190
/usr/work/linux/./include/linux/refcount.h:241
/usr/work/linux/./include/linux/refcount.h:258
/usr/work/linux/./include/net/net_namespace.h:339
/usr/work/linux/net/core/dev.c:2076)
 unregister_netdevice_notifier_dev_net
(/usr/work/linux/./include/linux/list.h:218
/usr/work/linux/./include/linux/list.h:229
/usr/work/linux/net/core/dev.c:2125)
 mlx5e_tc_nic_cleanup
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:5352)
mlx5_core
 mlx5e_cleanup_nic_rx
(/usr/work/linux/./drivers/net/ethernet/mellanox/mlx5/core/en/fs.h:161
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5765)
mlx5_core
 mlx5e_detach_netdev
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6231)
mlx5_core
 _mlx5e_suspend
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6399)
mlx5_core
 mlx5e_remove
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6526
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6553)
mlx5_core
 auxiliary_bus_remove (/usr/work/linux/drivers/base/auxiliary.c:230)
 device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1275
/usr/work/linux/drivers/base/dd.c:1296)
 bus_remove_device (/usr/work/linux/./include/linux/kobject.h:193
/usr/work/linux/drivers/base/base.h:73
/usr/work/linux/drivers/base/bus.c:586)
 device_del (/usr/work/linux/drivers/base/power/power.h:142
/usr/work/linux/drivers/base/core.c:3856)
 ? devl_param_driverinit_value_get (/usr/work/linux/net/devlink/param.c:778)
 mlx5_rescan_drivers_locked
(/usr/work/linux/./include/linux/auxiliary_bus.h:242
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:333
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:535
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:549) mlx5_core
 mlx5_unregister_device
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:468)
mlx5_core
 mlx5_uninit_one (/usr/work/linux/./arch/x86/include/asm/bitops.h:206
/usr/work/linux/./arch/x86/include/asm/bitops.h:238
/usr/work/linux/./include/asm-generic/bitops/instrumented-non-atomic.h:142
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:1576)
mlx5_core
 remove_one
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:969
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:2034)
mlx5_core
 pci_device_remove (/usr/work/linux/./arch/x86/include/asm/atomic.h:23
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:457
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:2426
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:2456
/usr/work/linux/./include/linux/atomic/atomic-instrumented.h:1518
/usr/work/linux/./include/linux/pm_runtime.h:129
/usr/work/linux/drivers/pci/pci-driver.c:475)
 device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1275
/usr/work/linux/drivers/base/dd.c:1296)
 pci_stop_bus_device (/usr/work/linux/drivers/pci/remove.c:46
/usr/work/linux/drivers/pci/remove.c:106)
 pci_stop_and_remove_bus_device (/usr/work/linux/drivers/pci/remove.c:141)
 pci_iov_remove_virtfn (/usr/work/linux/drivers/pci/iov.c:377)
 sriov_disable (/usr/work/linux/drivers/pci/iov.c:712 (discriminator 1)
/usr/work/linux/drivers/pci/iov.c:723 (discriminator 1))
 mlx5_sriov_disable
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:208)
mlx5_core
 mlx5_core_sriov_configure
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:229)
mlx5_core
 sriov_numvfs_store (/usr/work/linux/./include/linux/device.h:1045
/usr/work/linux/drivers/pci/iov.c:471)
 kernfs_fop_write_iter (/usr/work/linux/fs/kernfs/file.c:338)
 vfs_write (/usr/work/linux/fs/read_write.c:587 (discriminator 1)
/usr/work/linux/fs/read_write.c:679 (discriminator 1))
 ksys_write (/usr/work/linux/fs/read_write.c:732)
 do_syscall_64 (/usr/work/linux/arch/x86/entry/common.c:52
(discriminator 1) /usr/work/linux/arch/x86/entry/common.c:83
(discriminator 1))
 entry_SYSCALL_64_after_hwframe
(/usr/work/linux/arch/x86/entry/entry_64.S:130)
 RIP: 0033:0x7fbe3e9018b7

let me know if you need more information
Yael

> +		rcu_read_unlock();
> +
> +		rtnl_net_lock(net);
> +
> +#ifdef CONFIG_NET_NS
> +		/* dev might have been moved to another netns. */
> +		if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> +			rtnl_net_unlock(net);
> +			net_passive_dec(net);
> +			again = true;
> +		}
> +#endif
> +	} while (again);
> +}
> +
> +static void rtnl_net_dev_unlock(struct net_device *dev)
> +{
> +	struct net *net = dev_net(dev);
> +
> +	rtnl_net_unlock(net);
> +	net_passive_dec(net);
> +}
> +
>  int register_netdevice_notifier_dev_net(struct net_device *dev,
>  					struct notifier_block *nb,
>  					struct netdev_net_notifier *nn)
> @@ -2077,6 +2113,11 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
>  	struct net *net = dev_net(dev);
>  	int err;
>  
> +	/* rtnl_net_lock() assumes dev is not yet published by
> +	 * register_netdevice().
> +	 */
> +	DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->dev_list));
> +
>  	rtnl_net_lock(net);
>  	err = __register_netdevice_notifier_net(net, nb, false);
>  	if (!err) {
> @@ -2093,13 +2134,12 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
>  					  struct notifier_block *nb,
>  					  struct netdev_net_notifier *nn)
>  {
> -	struct net *net = dev_net(dev);
>  	int err;
>  
> -	rtnl_net_lock(net);
> +	rtnl_net_dev_lock(dev);
>  	list_del(&nn->list);
> -	err = __unregister_netdevice_notifier_net(net, nb);
> -	rtnl_net_unlock(net);
> +	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
> +	rtnl_net_dev_unlock(dev);
>  
>  	return err;
>  }


