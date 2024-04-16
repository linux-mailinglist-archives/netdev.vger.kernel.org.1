Return-Path: <netdev+bounces-88464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2138A7541
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CDF283E45
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964B139CF1;
	Tue, 16 Apr 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JRRoxpF1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JghH/Iv0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42BF139CE7
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298287; cv=fail; b=KcyrdvvC0qWFApHlBjjJIiNB4C36AjRMBNTT3etWzxShsKj/aTh50vp9pP4sPmFweHKXqlDLfY7heQzXnw7HzrH8AunC8WzLzB7CfwYCo7iS0IdCa9ryTulPTJP+Q5AYNhepTGTbq30Uc9hnBMPiRQeq5dzUA9GIQhLDHudorbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298287; c=relaxed/simple;
	bh=ySCn2+ttZ68hJVGl3RgQyDLS09VLjgAXIJNHYU2kqIg=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=Q/O5L5V69y+KVk6DlvGrecpAENlTMCMkIp0dY0PKf7YZuANk68jweZfnmFBpdc3hVWx+1779T+oAcA2GO2zJ8NG75Dx7eL/Npw+c5qRWmosTBphHIOibLYLs2iffngQIs8Xb6wYUbOCmgN18tivyDaT8weYEWFqEUloCgB50Gz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JRRoxpF1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JghH/Iv0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GJjhXJ027157;
	Tue, 16 Apr 2024 20:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=NMslz+NSip2fmE3cbJmcXLycjlvLXMTpXMUOqn4Qj4c=;
 b=JRRoxpF14ofpr/Yd6ZIUkzu9FR0X1AI4VGZiS1qsKysuiB83h1L1k+SF1ppgQxav1+9m
 wGdEjRaA2NHNmIWKMNgKhZ8vtKYCyPcBu2NlzF5T1zOISE6qh8GrStYm6M+leKP2Ursw
 prJKy+gGUUjBAOzQ92KPBCX2Eg6bnp2SWnPU4t8bg2PXw70WropEnUFwSIZYN+CcH4+P
 oeDJs0C2QdIv32rf6Wwrwqvia/34WrRoVWV7ZFMwy7o3mUJTfrOkOrRuRpxDi2SA8eHu
 PWE33lNHg7zzPv1NQkbgRcWJaXphcYLe3mRBYvMe6oVvO/JncaM344JWJ9p84CC6K3dK 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgujpbnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 20:11:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GJKmuR004332;
	Tue, 16 Apr 2024 20:11:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgge1red-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 20:11:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+7tdSWwV4xnChzXRd+sCvoTxseEaqjrVrbP028922uLWf3Pan5D8ImbM8DDVdq5tSg8icCVovuhB9bjuKub7YhP7991oV5ywotKC3fh7q2epo9DHqqPD2IRt3I9Vq6V/aFChGuQk/3P+3t5i7dt/xgD0E9yjn0w0t9F+V5f1uMt6qC4uPTOlnjFvC9TfW2L7k84rI12r74h1JPtdtwLdM/Qr/eHkOWpCM7WrTAFIURhsKmRn/VjIocfBlB0ydKbse0+4V8VcN1GdU8TD78LiIMXlczSv+UezAwg9nvvoSsW9twXNDhTjowoqQiaJeaKFLloUf68iJ3Zl2hzb6pm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMslz+NSip2fmE3cbJmcXLycjlvLXMTpXMUOqn4Qj4c=;
 b=I4OtuSaMo0DELc+Byfvp4W4ByY+Vc1+MyMa0oh6SOyvKQluU/qZxhSwfCIE3IzSi0kFbkQVDHeo4Q7kt1WeRawnQ7Uz83Y4A7vfvDrxirUlfbREBYbihtFGOrD7cFKTQe/Ly0zwouPoGsPE2f9dt4aVux+6ZNetJDr8+1ENwCPn9A/vE1VfaoHcdjMbgz4/eEG08cHJicm/wZ7vgCccy+z6tDNDLerp2E4HdwuWkIEN4rIjVUDqoNfQNoLaDJb++9fwvgDwsH0YnnYF8ViHc++caixBBjld3GlP7j98UhJQmOVvkEh5+nu8p28IcChF+0QvLI1eKFLaxEZQTOJA90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMslz+NSip2fmE3cbJmcXLycjlvLXMTpXMUOqn4Qj4c=;
 b=JghH/Iv0VqGDNrgcfAqT+CNc0r0nm24HkoybYfD3NS3ivVXQeU3fzbPNw5DSSiKJEx/85ELo1ocPVQVEH9cLU8mxsCeQRj+LZQvbsFltTuzE43Dp3H2tPaYGnAei3EDPTK7vPYCsV7uwhjakv49VPoSQRth63V6CWsoNd1TChn4=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DS0PR10MB7320.namprd10.prod.outlook.com (2603:10b6:8:fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 20:11:11 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%4]) with mapi id 15.20.7409.053; Tue, 16 Apr 2024
 20:11:11 +0000
Content-Type: multipart/mixed; boundary="------------hCBOwucJASqZdeOUCp7ikYhI"
Message-ID: <3e4ba1b4-ded8-4dd9-9112-a4fb354e1f55@oracle.com>
Date: Tue, 16 Apr 2024 13:11:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20240410171016.7621-1-kuniyu@amazon.com>
 <20240410171016.7621-3-kuniyu@amazon.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <20240410171016.7621-3-kuniyu@amazon.com>
X-ClientProxiedBy: SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::28) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 104e6b04-899b-4d96-2413-08dc5e515c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9/T6GTDWE1FPpefVYXgFisjGhj2O8fbsrcifxdJOmgUarTpj4v940g2zEk970tATFBrQqjJJP8Dp9fixHIddLIusOUGKXVoqjcbnhEjGWsyDZohtlF1o3JY5GjnaxCHrAQCB4PL+3gme6GcX4Kgm2gR7j+PbscR9DBUPzlOxmVpHuJlFpf8ZYi1xGloFS4kePlwHlcvkr/EYhQFUyiMB8JuFBmeldS8rjmA2vN1AiOzd38QE2gX+s4G2WF+CKZkRFu5brCUzS/7iGgJDsnEpoRnK8xxfFhkTVUt/QknQRhvdopkEa+/1f3sWQsOvjgghehTmYIvJzXAYVBxddC8EwLBbsHTGczdg+NOcSTxUCfcGpZDpiUG5+ug8UdvTpcA/Qq++ZL+y0klQBZU+bvIP5u0/QScUzUPkxcUVe/j/YMfDNvTZsabv07N+2CkJMuY6Suz8M6v4gitQZeZg2X8JPVFDunmoh3Mvg73QOHNSpAQAyq1oPr1Var/NDrt6HXt52ovtDU8wujd2wWC5svtdGk7WRd6M+68oO/LeZ3XoSyIf0o7SDyfh7UabTIu5VcYDwSf6Lx7DwR5GO9kEaqMnCa9fxxvpRrd2I9frsZdR5iCGPDv4DNpFp5XF4cdIi3zB/Abw0upYTgHGGA1uT9X7bySc01dKY133Vj3WCckLeB0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0ZYK1RFMWpVK1hBNWlrWFZleWpLT3ZwemdqbXRuWTFUdHBxbjFLTytSdUxi?=
 =?utf-8?B?SnhQbC82aEFvc2p1NjZQWWswTjNRSkxxT05Ib3pIREZkOENzNTJ4SzlNY0Fu?=
 =?utf-8?B?SHQ5LzIyY1VUOGJac3VVU0x6NCtzRys4UVFseEdQRHBIdWVwSnZKSk1JSEhQ?=
 =?utf-8?B?QWpZd05YTUxQRVBFK1lLRmkwZnBVaXBuUGswT25pMDNYaHFYWXZ6cTJKOGpi?=
 =?utf-8?B?Y25kRlp6ZE0zN2l5UEhUSG5VM1g4YWhOTHVDajdPV1B2U0hzRlNqSDgwaVVP?=
 =?utf-8?B?eXFGZmF6b2lXd2xPNlB0L2tTRnI5d1Q0V016ZWlDYXFPZmNTbkhjcFdaR056?=
 =?utf-8?B?VzVPVWVLK1BVanI3VmswVVlndUxDSlNWbG43WnJvNWlFdk5Fd1o0clFtMVQv?=
 =?utf-8?B?RG1lMXE2dzdiVkV1VU9WT2Fhem1US1lIUlg3YitaZ3hKRHlaOHRNY0RTUmRn?=
 =?utf-8?B?d1JzNWtyQVhJTXUwaGpHT0x1NUZWZXFpdEk5MDBtM3FabXN6NEpZZE00ZHQ2?=
 =?utf-8?B?VWk1d083S01ldzI5OTdIQTNabzlwdm5YRHJiWC82RWFTUjVBM3E5SXczV1Vl?=
 =?utf-8?B?d3IyOHk0TTBVd0MxekxFRzZ0NHRvdENxNkZ4dWNscEJXSzBBNG9KRWJ6MGxL?=
 =?utf-8?B?dVRLTjh0ZUo3UUpwUDBJalh5ZnhBZEFxUHZiM044T3Y1REZDMGR2Uk5CZFV5?=
 =?utf-8?B?M29PQVZjSUo4M0xRWVNreitGbzZuWG5CSmR5dDJhWTdGUkRaNUFiZjUxN0lO?=
 =?utf-8?B?RmJGTFExY1Y5Q1NSL3FqMVhMNE9tR1c4R1MyNjZQYU9qeDE1TnhVaHhhb2M0?=
 =?utf-8?B?S3R3SmhsYU12KzlIUUNjNCtWK1h0SkRkWms0cG43QVgvckc2QkJoSUVWQ2Ey?=
 =?utf-8?B?M3RIdm50dFVFVTFnR2szbHJ0dXpVWXJscU1QR0lXd1BWOVR1ZXIwUm5qbGZr?=
 =?utf-8?B?R0hQMlVZKzU0bXlBQ2dvQ0JEUEVxWHpONmpzOURwL3U5aGdkRElYZXRJRXVy?=
 =?utf-8?B?c2ZnV01USG5wS1phaEhBVWdhbVA2alNTVkRLN2szODFCL3NDUitpdEsyZEJu?=
 =?utf-8?B?Ym1HR3ZuYjEwQWVZc2poWjcvS1M1dVhrak9sTExBdUhqa3RwU2hiRjlnSCt1?=
 =?utf-8?B?N3Rkc2l6UXBRY1BWayt0eklkZUp2ZW9CQ1FyR3lKOXFqYXJCSC9FYjNWVTUy?=
 =?utf-8?B?Q2RPQkZMamxmUHJKS1VlbE1hdFdsR2JnZGtWVjk0OWluMCtWNWtWZEhVZjVD?=
 =?utf-8?B?WDlXV29XNWNqNjBEUWpZcVZ1MndUeGM2dHhyRi82RzdtNk1MY3FFa3JBKzd5?=
 =?utf-8?B?MGxXOTRXZ2I4aVdnQkZwY1ZXSnFQZm5rbDRZZ1FXTklQVEs2Y1BoQkd5K3I4?=
 =?utf-8?B?M3hLZWxOOWVMcnhaSWFDTXJMVGRpbDRJOWJRVllNYzEyaTF5dnU3NWIwMEhN?=
 =?utf-8?B?ZUEreWxXeU5oQkNZZDNDTUZibmZxQXN0OWtSaUJqelZWRDJVUitNRGo0NEQr?=
 =?utf-8?B?QUV2eGlMNVduNXBYWVpjUDBEbnRJWGM5SElnL2RLSDFhRHF3aE5ES2pkWUhQ?=
 =?utf-8?B?K1B0ektxU3l3REZjSDkyTmNDaWJ1VGJFeUdxV25jb1lCUTJEVkUvMnZQRmpo?=
 =?utf-8?B?NEp0TlNKd2kxcjVHR20weEU3OHVnWUhRdU1PU1ZGSWxYTFlXbkNoYmJKeEZV?=
 =?utf-8?B?eFozTlF3VDk5elFtUDJzTE5USWhhMnhpVmM0WU5kbVhna25pTWxzb3JLQjNo?=
 =?utf-8?B?dlg0bFRBWk1NMXZldmNrekFmc0JpQkxlN3hJZGxVb1pSVVNUaWk4c2c4N01D?=
 =?utf-8?B?d1o5S2p6SGhaS1lHc2Y3OEZ6K2lkN2dSK3VtSEpOa1drZW9LVUs3bW1OK1F5?=
 =?utf-8?B?TW4yMVhqd21ndElVTVZsZjk1ZmNQWWRIY2E2Uk11WnBnNE9oblQ4UUpQQnls?=
 =?utf-8?B?ZnJrbGpQTHdleVRpNDFxZTdCSnNUZTBoQUhYS1IxWmI3S1pKNE1iZGJpZVhS?=
 =?utf-8?B?QmlINVhaSUZGdG91OExXQTBKTE11RWJqZVRyMVozN1NtODMwZHRRVVFFNjFo?=
 =?utf-8?B?KytDK0xQN3d0NlNUTzZmdVg0VTdiZXUxazJSZ1ArcndaUXF3WU1ucUQzUFk4?=
 =?utf-8?Q?nR7n+3Fzq8L8WjxXd5neUnOlm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wVB1VwhuaE+DtMTfocm+TXFBeJ+hL/RFVbNd2vBhrZQpaq5kNJGp4grLQFbKoQDDPt2zABPJxhm0IgIl7n3ZalbNAX5tTFIo0X0qA8p9uWbMrYOz96Ka7IyhMOD71tFPGq8NegImgpIP9omcjdJF0NFNVyPWn0iQEZ9I49IKbu52Z3fcJ7tmf/pQ0JjxrsHfU0Pa1WWKx9Chq+E3rEE/ZeIvYqdIj05gT9XJ4IRLmowH8+iP0zyUv5eDTdahBtVgp3ccZKsndICg7Qo/x5JkAyyb9gARhYJJYIjHLBcDhhmjTWhy/kO3EN+lZj3WFJzt6I8voZJ6RG7ff4uAdVVaVnSmVcvzvd3qbmwqL6sNaYgFIQlmt7A00G3roh0Oi7l0pZ5v82ZH5UaUo0xdJkWrqsonjMKoH4/wvyKQ0pdvYFpdvwuq338EBnPziP7zhvXeA49ZhyBPpWxTQ4IaG7PQ2xaqydY+qieVcKSGS/XE6QNnztCAuUt8QkbyLZYTKfzN4yTL+2yTKg1YG9nveYNp2v3+RT6kZT443SUr0wkSeXAbIOyypKwO60ifc9E2lxnOTyPXVwRS3CSCQHR3lHVJxwS7voXMXooQ9xy3n5bqtFQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104e6b04-899b-4d96-2413-08dc5e515c32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 20:11:11.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl6EIuuGozPoZc78PYPfYX1JCbAQoYgHSeyfYI7LwkgZgfZVR81zhWi7Yy1tHTxJFqetXwth9HxUZ+N16xwGaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_18,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160128
X-Proofpoint-ORIG-GUID: HysIvEseSo6p_lX2kdbKHAML3M5yG4Jd
X-Proofpoint-GUID: HysIvEseSo6p_lX2kdbKHAML3M5yG4Jd

--------------hCBOwucJASqZdeOUCp7ikYhI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The proposed fix is not the correct fix as among other things it does 
not allow going pass the OOB if data is present. TCP allows that.

I have attached a patch that fixes this issue and other issues that I 
encountered in my testing. I compared TCP.

Shoaib

On 4/10/24 10:10, Kuniyuki Iwashima wrote:
> Currently, we can read OOB data without MSG_OOB by using MSG_PEEK
> when OOB data is sitting on the front row, which is apparently
> wrong.
> 
>    >>> from socket import *
>    >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>    >>> c1.send(b'a', MSG_OOB)
>    1
>    >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
>    b'a'
> 
> If manage_oob() is called when no data has been copied, we only
> check if the socket enables SO_OOBINLINE or MSG_PEEK is not used.
> Otherwise, the skb is returned as is.
> 
> However, here we should return NULL if MSG_PEEK is set and no data
> has been copied.
> 
> Also, in such a case, we should not jump to the redo label because
> we will be caught in the loop and hog the CPU until normal data
> comes in.
> 
> Then, we need to handle skb == NULL case with the if-clause below
> the manage_oob() block.
> 
> With this patch:
> 
>    >>> from socket import *
>    >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>    >>> c1.send(b'a', MSG_OOB)
>    1
>    >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
>    Traceback (most recent call last):
>      File "<stdin>", line 1, in <module>
>    BlockingIOError: [Errno 11] Resource temporarily unavailable
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   net/unix/af_unix.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f297320438bf..9a6ad5974dff 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2663,7 +2663,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>   					WRITE_ONCE(u->oob_skb, NULL);
>   					consume_skb(skb);
>   				}
> -			} else if (!(flags & MSG_PEEK)) {
> +			} else if (flags & MSG_PEEK) {
> +				skb = NULL;
> +			} else {
>   				skb_unlink(skb, &sk->sk_receive_queue);
>   				WRITE_ONCE(u->oob_skb, NULL);
>   				if (!WARN_ON_ONCE(skb_unref(skb)))
> @@ -2745,11 +2747,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>   #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>   		if (skb) {
>   			skb = manage_oob(skb, sk, flags, copied);
> -			if (!skb) {
> +			if (!skb && copied) {
>   				unix_state_unlock(sk);
> -				if (copied)
> -					break;
> -				goto redo;
> +				break;
>   			}
>   		}
>   #endif
--------------hCBOwucJASqZdeOUCp7ikYhI
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-AF_UNIX-Fix-handling-of-OOB-Data.patch"
Content-Disposition: attachment;
 filename="0001-AF_UNIX-Fix-handling-of-OOB-Data.patch"
Content-Transfer-Encoding: base64

RnJvbSBiZjU0MTQyM2I3ODVhZTE0ZWUyYzcwMTVkOTZkYmE2YWMzNjgzNThjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW8gU2hvYWliIDxSYW8uU2hvYWliQG9yYWNsZS5jb20+CkRh
dGU6IFR1ZSwgMTYgQXByIDIwMjQgMTI6Mzk6NTQgLTA3MDAKU3ViamVjdDogW1BBVENIXSBBRl9V
TklYOiBGaXggaGFuZGxpbmcgb2YgT09CIERhdGEKClRoaXMgcGF0Y2ggZml4ZXMgY29ybmVyIGNh
c2VzIGluIHJlYWRpbmcgd2hlbiB0aGVyZSBpcyBhCnBlbmRpbmcgT09CIGFuZCBNU0dfUEVFSyBm
bGFnIGlzIHNldC4KU2luY2UgdGhlcmUgaXMgbm8gc3RhbmRhcmQgZm9yIGhhbmRsaW5nIE1TR19P
T0IgYW5kIE1TR19QRUVLLApiZWhhdmlvciBvZiBUQ1AgaXMgdXNlZCBhcyBhIHJlZmVyZW5jZS4K
CkZpcnN0IGJ5dGUgaW4gdGhlIHJlYWQgcXVldWUgaXMgT09CIGJ5dGUKRmlyc3QgYnl0ZSBpbiB0
aGUgcmVhZCBxdWV1ZSBpcyBPT0IgYnl0ZSBmb2xsb3dlZCBieSBub3JtYWwgZGF0YQpOZXcgT09C
IGFycml2ZXMgYmVmb3JlIHRoZSBwcmV2aW91cyBvbmUgd2FzIGNvbnN1bWVkCgpTaWduZWQtb2Zm
LWJ5OiBSYW8gU2hvYWliIDxSYW8uU2hvYWliQG9yYWNsZS5jb20+Ci0tLQogbmV0L3VuaXgvYWZf
dW5peC5jIHwgMzIgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQv
dW5peC9hZl91bml4LmMgYi9uZXQvdW5peC9hZl91bml4LmMKaW5kZXggZDAzMmViNWZhNmRmLi41
MGNhZTAzYTFmOTggMTAwNjQ0Ci0tLSBhL25ldC91bml4L2FmX3VuaXguYworKysgYi9uZXQvdW5p
eC9hZl91bml4LmMKQEAgLTIyMTcsOCArMjIxNywxMyBAQCBzdGF0aWMgaW50IHF1ZXVlX29vYihz
dHJ1Y3Qgc29ja2V0ICpzb2NrLCBzdHJ1Y3QgbXNnaGRyICptc2csIHN0cnVjdCBzb2NrICpvdGhl
cgogCW1heWJlX2FkZF9jcmVkcyhza2IsIHNvY2ssIG90aGVyKTsKIAlza2JfZ2V0KHNrYik7CiAK
LQlpZiAob3Vzay0+b29iX3NrYikKLQkJY29uc3VtZV9za2Iob3Vzay0+b29iX3NrYik7CisJaWYg
KG91c2stPm9vYl9za2IpIHsKKwkJc2tiX3VucmVmKG91c2stPm9vYl9za2IpOworCQlpZiAoIXNv
Y2tfZmxhZyhvdGhlciwgU09DS19VUkdJTkxJTkUpKSB7CisJCQlza2JfdW5saW5rKG91c2stPm9v
Yl9za2IsICZvdGhlci0+c2tfcmVjZWl2ZV9xdWV1ZSk7CisJCQljb25zdW1lX3NrYihvdXNrLT5v
b2Jfc2tiKTsKKwkJfQorCX0KIAogCVdSSVRFX09OQ0Uob3Vzay0+b29iX3NrYiwgc2tiKTsKIApA
QCAtMjY1OCwxNyArMjY2MywyMCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKm1hbmFnZV9vb2Io
c3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IHNvY2sgKnNrLAogCQlpZiAoc2tiID09IHUtPm9v
Yl9za2IpIHsKIAkJCWlmIChjb3BpZWQpIHsKIAkJCQlza2IgPSBOVUxMOwotCQkJfSBlbHNlIGlm
IChzb2NrX2ZsYWcoc2ssIFNPQ0tfVVJHSU5MSU5FKSkgewotCQkJCWlmICghKGZsYWdzICYgTVNH
X1BFRUspKSB7CisJCQl9IGVsc2UgaWYgKCEoZmxhZ3MgJiBNU0dfUEVFSykpIHsKKwkJCQlpZiAo
c29ja19mbGFnKHNrLCBTT0NLX1VSR0lOTElORSkpIHsKIAkJCQkJV1JJVEVfT05DRSh1LT5vb2Jf
c2tiLCBOVUxMKTsKIAkJCQkJY29uc3VtZV9za2Ioc2tiKTsKKwkJCQl9IGVsc2UgeworCQkJCQlz
a2JfdW5saW5rKHNrYiwgJnNrLT5za19yZWNlaXZlX3F1ZXVlKTsKKwkJCQkJV1JJVEVfT05DRSh1
LT5vb2Jfc2tiLCBOVUxMKTsKKwkJCQkJaWYgKCFXQVJOX09OX09OQ0Uoc2tiX3VucmVmKHNrYikp
KQorCQkJCQkJa2ZyZWVfc2tiKHNrYik7CisJCQkJCXNrYiA9IHNrYl9wZWVrKCZzay0+c2tfcmVj
ZWl2ZV9xdWV1ZSk7CiAJCQkJfQotCQkJfSBlbHNlIGlmICghKGZsYWdzICYgTVNHX1BFRUspKSB7
Ci0JCQkJc2tiX3VubGluayhza2IsICZzay0+c2tfcmVjZWl2ZV9xdWV1ZSk7Ci0JCQkJV1JJVEVf
T05DRSh1LT5vb2Jfc2tiLCBOVUxMKTsKLQkJCQlpZiAoIVdBUk5fT05fT05DRShza2JfdW5yZWYo
c2tiKSkpCi0JCQkJCWtmcmVlX3NrYihza2IpOwotCQkJCXNrYiA9IHNrYl9wZWVrKCZzay0+c2tf
cmVjZWl2ZV9xdWV1ZSk7CisJCQl9IGVsc2UgeworCQkJCWlmICghc29ja19mbGFnKHNrLCBTT0NL
X1VSR0lOTElORSkpCisJCQkJCXNrYiA9IHNrYl9wZWVrX25leHQoc2tiLCAmc2stPnNrX3JlY2Vp
dmVfcXVldWUpOwogCQkJfQogCQl9CiAJfQpAQCAtMjc0MSwxOCArMjc0OSwxOCBAQCBzdGF0aWMg
aW50IHVuaXhfc3RyZWFtX3JlYWRfZ2VuZXJpYyhzdHJ1Y3QgdW5peF9zdHJlYW1fcmVhZF9zdGF0
ZSAqc3RhdGUsCiAJCWxhc3QgPSBza2IgPSBza2JfcGVlaygmc2stPnNrX3JlY2VpdmVfcXVldWUp
OwogCQlsYXN0X2xlbiA9IGxhc3QgPyBsYXN0LT5sZW4gOiAwOwogCithZ2FpbjoKICNpZiBJU19F
TkFCTEVEKENPTkZJR19BRl9VTklYX09PQikKIAkJaWYgKHNrYikgewogCQkJc2tiID0gbWFuYWdl
X29vYihza2IsIHNrLCBmbGFncywgY29waWVkKTsKIAkJCWlmICghc2tiKSB7CiAJCQkJdW5peF9z
dGF0ZV91bmxvY2soc2spOwotCQkJCWlmIChjb3BpZWQpCisJCQkJaWYgKGNvcGllZCB8fCAoZmxh
Z3MgJiBNU0dfUEVFSykpCiAJCQkJCWJyZWFrOwogCQkJCWdvdG8gcmVkbzsKIAkJCX0KIAkJfQog
I2VuZGlmCi1hZ2FpbjoKIAkJaWYgKHNrYiA9PSBOVUxMKSB7CiAJCQlpZiAoY29waWVkID49IHRh
cmdldCkKIAkJCQlnb3RvIHVubG9jazsKLS0gCjIuMzkuMwoK

--------------hCBOwucJASqZdeOUCp7ikYhI--

