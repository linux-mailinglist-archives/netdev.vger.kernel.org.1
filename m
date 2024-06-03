Return-Path: <netdev+bounces-100233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 795BB8D8464
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52FAB21419
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2159212D767;
	Mon,  3 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g2htDENF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226FB839FC;
	Mon,  3 Jun 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422673; cv=fail; b=OhN/YzmH95XXiohlCePd68BCQdsT0spZdK/8t7jBdr+XUGVVLwt8Q2ttikK+kN8kbr/iwpVEem/LhYipJACtR7cC/Kb19eDO+GGgX3gNKqLCGxrmVFRvQRnRGxegXkGEeP1UrcWPTKt5h5S6mSKTzJ1RI2fWxEpqy8doQjbq9d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422673; c=relaxed/simple;
	bh=c60rLxi8Wa4pmQnUcMoZqdUug22HELlwrjDlxGV9qVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tpfuo+cLvR5OaOjME8KbIG447OnK4zqaxWwmqUExxcqtSJpz8E+dgvudFOILb4Vyp+LaxUIvucDdTdBoJrQT6O0AmJj7GTM9Ou3rL0wUNIn/e7QOpoKKiY4Rd+rE9ZAGTkAZ3YS2Hx/DpNvTbwEbx8cSIzGxFVCzA5nnf61kRGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g2htDENF; arc=fail smtp.client-ip=40.107.21.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMBihkdL7mVEg1PCnC/hHxU+G3xbXb5sI+3a1rVgTWXdAkHUwtAsJx1XSpLF0Yb2J1IaSKUP1NPXYM13D3C+1kITcRuPVk9Qauk+5BYqu7loAHuKs6osM9ix1fTSS6HsYVNMktXKFEsdcJyXHHZGdVaHHDrB7SJDUSnPFqONZYhwU0oenNUZmjDekEYmwQDrLEa0UZuC5fL0eKmOfT0B58qpL1z5gixq7dqRtPr5IZ50LcKOWHqsDSolu7wPVHftxZXIuY8Af3mqPsS3oGevrBPTHMcj0qM6/4zDkzy45Z8+wEHc1EVRxuxLVZOvcsl4UFwBo+fyPL28qx7AeGcncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Oj60PQoJPFJgvBGF0Gwb8i/S1BehBult6ohDT2uC/8=;
 b=fvrh4H0h3x0ZGtWvDmCJwOb7aoMOeGD1RQEipwofsmnwfvtF/CqfVGUGJxg/ElNj2dmSe5WLZXOC3ySybSTCsGc2dLx+VHgIbm4kGk2uofAcwJAqoLk7pMBR27xHzpyqgyP/HI620R8Cr34ZpLFbpPYjWj/4m0NCkMHZvHipeTfb7MZdxYcj5LcLU+U2/GkR0iXKx/ycTJb3mfvuER526fYoUsy3Xk2e8a1GafN/vmyQwe7sIY4WUTa2R1g1/5c/eIZndJGA+oV6BjGag4upLgcL3xPMUuOEoSZ9V3iVGBkAepg4RLKxgclYpZ4BDkRybKavNen3Y33V+LIfe6hSPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Oj60PQoJPFJgvBGF0Gwb8i/S1BehBult6ohDT2uC/8=;
 b=g2htDENFjLUZ57d0rLDbRG9DE71xbVdGQikLtpyAS7KaWU6DBAxoj2cVgH/ed8faPH19T95AVZvp+ar4Lu19hjkgFAIUKdK9WMNZOk4M/hRLMOEUNQxUEB162Km0IBvY18LcP6GRqvmsgv/qGZxB73/TBLp1tpZvkrFn0Z12EkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4551.eurprd04.prod.outlook.com (2603:10a6:20b:1a::24)
 by DBAPR04MB7317.eurprd04.prod.outlook.com (2603:10a6:10:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 13:51:05 +0000
Received: from AM6PR04MB4551.eurprd04.prod.outlook.com
 ([fe80::5b1c:9249:b225:f6fa]) by AM6PR04MB4551.eurprd04.prod.outlook.com
 ([fe80::5b1c:9249:b225:f6fa%5]) with mapi id 15.20.7611.030; Mon, 3 Jun 2024
 13:51:05 +0000
Date: Mon, 3 Jun 2024 16:51:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v9 2/2] net: ti: icssg_prueth: add TAPRIO
 offload support
Message-ID: <20240603135100.t57lr4u3j6h6zszd@skbuf>
References: <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-1-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531044512.981587-3-danishanwar@ti.com>
 <20240531135157.aaxgslyur5br6zkb@skbuf>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
 <9bcc04a9-645a-4571-a679-ffe67300877a@ti.com>
X-ClientProxiedBy: VI1PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::31) To AM6PR04MB4551.eurprd04.prod.outlook.com
 (2603:10a6:20b:1a::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4551:EE_|DBAPR04MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4b9204-a0fb-43bd-e03e-08dc83d435f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZnpuelRWaGwvcFE1VllSUWVKeEoza2tmZXlGU3djMzI0SC9OQXdETHQxZVRY?=
 =?utf-8?B?VzdRRmU3c1luSFlZVDJ3T3ZxL2VtaUdEemFOOWpXUG5henlYTHQvbHdxQWtK?=
 =?utf-8?B?TTVvTnNtOW9sMENTUFJ6UlVGT28yTXZHaE9zbU9DNVNMRVFNZ1lOREhXcUJZ?=
 =?utf-8?B?Zm9tOU8rWmlTR09MUEdhZEt4WHZ2eG1WWmJwYjhTbmhKeFpaQkFkODIwUU82?=
 =?utf-8?B?NHova3JMbyt3UkMxekdNdUw5blV0aEQ4d2ZYczErUWpCQVlBcUFtZnZybGtS?=
 =?utf-8?B?aUtDWEJOTm5GU05SV1hIZTlDY1ZMdm9SRUFzZS9PeDZOcGhzbTM2dFJKeWFY?=
 =?utf-8?B?TjU2OWlaa1ltN3llODYrdktkY2tlQzd2Wm8veXExZDRtMlgzZFVqQVhUajlp?=
 =?utf-8?B?WjlRMnNGU3N0bmxMNmZKeEtaby8rMkpaZDhxaTFlMklvdzRzNCtod2txNWsz?=
 =?utf-8?B?Z08rUmZSeUtobFBGWndrS3dlWWwxSVVPWkwrMEpZTGVRV1BnSjhqN0JXNXBR?=
 =?utf-8?B?d0ZKM1VLWlVuTE5IQ0FlQitKYTR2Vi9raUZTa3g2ZTBhYlBKQXVaRGtXcjhj?=
 =?utf-8?B?WkxrdS9UOUxycGdSZ21TNFFPL3NHdEpNT3NSeGVlUnkxTEJBb25LQys3YnRO?=
 =?utf-8?B?a0JWRVpUbHI4Uk9QcHA3S1hreWZCWTNEd3JaTGxJN05ZTFEvV25wK3ZCU1Fh?=
 =?utf-8?B?bVlDOHN3LzdPQkpiT1hHd01uMVVQb2VzdjVZdmZQMzF1U2RBc0xPL3ZpOXdT?=
 =?utf-8?B?WkZvQlQ1dm5zUUxydHoxMEVMcmROeGp6d3FqY3hoK3RoVkh4VWJqRzZqVW5K?=
 =?utf-8?B?Q3ZjbEhPOC9rdU1vQWo5aklqT05BcitTdFFzaVJFNGhoVDE0TFF6WnhNK3Ns?=
 =?utf-8?B?ODI1OVdUQXhVcXdUSFBjVVhNUUNOQkdLT3pkYVg3eG1ia2g5Z1hibUVlSWhw?=
 =?utf-8?B?TmFTQ1E1K2ZGZGlYRUwyK1g5dC9LK3E4TnhONUlvdU5QWldhOHU1SllRVzda?=
 =?utf-8?B?Mk8zczNNQ0Y0TVlDSm5OQ1Y1SWFGRjRrZEJsNU9GaW9CVWp6TzlkU2ZiQUxX?=
 =?utf-8?B?L2pRaitudURrcGRMbVJXK3JQMGtBR3dhUi9vbGlacGZEMS9iQWVXdWFRWm5a?=
 =?utf-8?B?TXgza1FnSk9ZaGxUV0x5dFFFRzN0RjRnYzFlQ0hLMTdPdVZnQ0gwMUZtVFZN?=
 =?utf-8?B?eCtteHIxeGxwS0M3MFl5N2ZYYWN1OHphZUtmYmhyamtGSE1OK0R6MVdEUmx0?=
 =?utf-8?B?ZTJGVTlpcWt2UFJmUXB6bGFWblptVEdMZGlzMEw1R3VwL3NIakp6a1N2ejAr?=
 =?utf-8?B?MTdnNVpzQTVBczk1RElid2FreXVNcnlsTHYwUUNmRXJ3cThjcGFpR0NZamVS?=
 =?utf-8?B?ampTdlhIMXMvbWI1cXVBc2UwenllOXo5MUxDYWFnaCt0R1Z4MU4raVhPWUd6?=
 =?utf-8?B?Wk1lRkRtd3E1Mm9MVk9iYTVQZTJVUVNxOExtMkZlV2E2M0JqM0tZT1VuV3Vu?=
 =?utf-8?B?VUh0RFNUSjEzZzhiaS9RZlprWi9aZVJhdVNUSHkraGNUdmhGUHZWb3R1dWtJ?=
 =?utf-8?B?Z21PV3JoeTRQeTE3Rk9FZ0puSTV6YTZKQUltUnZTOWtiLy9NNkdTWmVPL2ts?=
 =?utf-8?B?eUVlN09xeHRVYW85NFUranBlaThzc2RvVWV6alZGNXN1c1g0K3hHcmxJaHQ2?=
 =?utf-8?B?MXFuMFMyLzdmTFBObGNLbG9hUFpYdm1TOURUbmpqNVNYQzI3WnFWOW9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4551.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enZrdmxsMGg1N3QyMW5JaXJ6aGE0ems0RE1xdVVJelByQStQYThBVHpjWHVI?=
 =?utf-8?B?SUFvV0lSdmd2Q0JvUzhIWHVlS3RxcHZocER1cmdLdkFsOE4rUFhYaTJlT0RF?=
 =?utf-8?B?dmx2cEFXc0gzeXpHQkxsdmh3WjVhTW5sNkNmcEFrd0pVbHpBc1RkaW5hQlVD?=
 =?utf-8?B?THRXZEw4NkIvc2ZyaFFjSGd4OTBlQlNOS214V3BBZ2JyZ0VsMVZKSkd4MTAv?=
 =?utf-8?B?d3VTczFwTkVGOW1uYkFvNjJoRk50M0JSalBBOFJ0bU04dXIxLzlvTEl3bTky?=
 =?utf-8?B?dmR2RXNoVGc3NTFUVWxvRjN6d2JCRGVpZjJZSUcvYzNTckdSLzRVQ04rbEkw?=
 =?utf-8?B?bno3cWtKVkhzYUxFZEJidjBCL2JubUFnTGFaUXBWdTVFbXgxcGpheW5Vb2dk?=
 =?utf-8?B?RmQ4QW1vQkUzYmJUSWJyV3A3TGROeGYwL3BYOTFYb3BZOUdNSDVNRHJMYzda?=
 =?utf-8?B?d1JsdzFjd1lITlZTLzhYTXhFclF0MGNrUmhhaEkzWEhZdkJSdjVrQkFRRllV?=
 =?utf-8?B?V08yT0xWSEpBNmYrd1lrY2Z3cGhnU3dNQ0dIaHBPTGp3UE9ibGVLZ09XZERN?=
 =?utf-8?B?OTM5U3JFaHE0S0FIVHh3VWRBYnNJb0lSYTd2N3dIM0gyaHN4R1lBMlJQbW1Y?=
 =?utf-8?B?ZThmeE9YQ3BvWXhJdkNOSXJVNDNpellONXVycDEvcXBnSXMvOG9qOVNOaDNj?=
 =?utf-8?B?MTBFWmNhTlFYUzJhVFlUUDNuKzZCekpkY2JDZmtPc0NEenpGTldXdXN4dlVa?=
 =?utf-8?B?ZXZUY0Ywbyt3VDRxVG5MbXdLU0d1WllNVkdnR1JoVFJPRE5sN1RKVGYwdFlh?=
 =?utf-8?B?WG1GdXJocGxsdUJCNExib2cwbGNhNWs4TmE5UmV0Q05wbnA3RHBsemRWTVNk?=
 =?utf-8?B?Z2hXQ042YnpXMFk0NzlTOEQrRlRyU0xIb25rU3NlWFVlT2dBSkdKMjRKdWtW?=
 =?utf-8?B?ZFJnVDB2SjlRNGlweGtMS1hBSHZPanp1eVYzc0FyVHJnWjFkbTFZMU15YmdV?=
 =?utf-8?B?QnN6VXNFR2tFSjJzL29CL2loQWE2aWFZSzRjZzRYdW45b0lzd3FTZTN1Tllh?=
 =?utf-8?B?cmZnY2NVWnE4ajVnTFNha2hQaDVnU2p5MU9hN1RwUU1KN0hMNEN5UTBGOC9s?=
 =?utf-8?B?bEFiN1pGckMwSDliNGcwbE5INEJxUmR2TE9BZmFUd2MwSzF6RGZqZllCVU1l?=
 =?utf-8?B?Zy8xSmVnWER4aGp2SVdLUDMxSHNKQ0tWNmFNUmlnYXFOVUEyWFc0d2gyTlNn?=
 =?utf-8?B?S3RQeDJ5b2VEb1BTQjhDdDZYYUpmSkdhSkNGYnFpNWJWSG5tT0RnTW5nT1hp?=
 =?utf-8?B?dWtrY2pKN1BQOHVyb0N0VVpWWVNPRXMxQkYxR1hQdS8xU09MOFV6RURXdmtT?=
 =?utf-8?B?eGFaNXRpTWt2L3llSXNCcFpGWkF1VUthekFhM05KbG1EL3ZXdUhkKzRyYi8r?=
 =?utf-8?B?bGRhMzhqeUpvUW5RNGxKcXRHcUVidkRodS9IeEp1Uk45alZJaGlHNURINnNh?=
 =?utf-8?B?bnFYRWVuL2hza1o3c3VEMm9QSXZTallhU3Axamc3M2FtYjhpZGRIRnRPeFlS?=
 =?utf-8?B?M2ZtRUMyNmtCL0RxdjBoMS9FUUlxV0w4ajBDWFFOTTJBL3NUdy9id2dUc0c3?=
 =?utf-8?B?WHhRSzlFcmZ5cGtqOFdwUU8rOVFaSFdPMVJTT3FzVnVIRWJRdjNzeVhMQU5E?=
 =?utf-8?B?K0w3ZmkvSm13OXFWWkVyMjlzSmxIZ0x1ZWVlNkpxQkJ3bjM5bEYyMTZncEpw?=
 =?utf-8?B?NlZKczM1d3RkbjVpbGpSNHQrWWNNd3dzSGx4K3hkVTA3Y2JhczJibUVudGYz?=
 =?utf-8?B?TjFmNFE0TFJrckRKcm85T3JKTVhEeUJSRkFZUkt1QnR0NzlqWHJTOWROSFo4?=
 =?utf-8?B?SjVwdy8xVkdmdkNRSTFpZVlGNk9ReG82WWpRamZmaW1QdTZ6UGU0UlUzMzVk?=
 =?utf-8?B?YVJ2citoaWZTWUtCWkVNR2NPd3pWVWJPUHZCbGxVRG9palhSTXZtRDA2aUY1?=
 =?utf-8?B?WC91eU1meDZaZmxiRTlVa1UyRytuYmRYWTlGTXQxVjdsNFJOY21Xb2pPdUpZ?=
 =?utf-8?B?b0lRK2daRFFNT3NmK1hoOEJ3Mm9RbHY0V3lKR3VUWUFNcXB5Zm5yaFo0U0c2?=
 =?utf-8?B?aERjZ3ljUTF1blRVekZaaWx1SVZhcVhYY01CWUR5Mm5ZdmcxVzlHN2VMekZC?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4b9204-a0fb-43bd-e03e-08dc83d435f8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4551.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:51:05.7419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmNnbpgd9c4d1qCkBCFuoa0SqiLyZGY/yTpEVDU5MVwg4q0a0oKvpnsP+WR9uYPTZiqkCT1t5ReJHKqnQNxH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7317

Hi Danish,

On Mon, Jun 03, 2024 at 05:42:06PM +0530, MD Danish Anwar wrote:
> >> diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> >> new file mode 100644
> >> index 000000000000..5e93b1b9ca43
> >> --- /dev/null
> >> +++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
> >> @@ -0,0 +1,288 @@
> >> +static void tas_update_fw_list_pointers(struct prueth_emac *emac)
> >> +{
> >> +	struct tas_config *tas = &emac->qos.tas.config;
> >> +
> >> +	if ((readb(tas->active_list)) == TAS_LIST0) {
> > 
> > Who and when updates tas->active_list from TAS_LIST0 to TAS_LIST1?
> >
> 
> ->emac_taprio_replace()
> 	-> tas_update_oper_list()
> 		-> tas_set_trigger_list_change()
> 
> This API send a r30 command to firmware to trigger the list change
> `emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);`
> 
> This once firmware recives this command, it swaps the active and shadow
> list.
> 
> emac_taprio_replace() calls tas_update_oper_list()
> 
> In tas_update_oper_list() in the beginning active_list is 0 i.e.
> TAS_LIST0, tas_update_fw_list_pointers() is called which configures the
> active and shadow list pointers. TAS_LIST0 becomes the active_list and
> TAS_LIST1 becomes the shadow list.
> 
> Let's say before this API was called, active_list is TAS_LIST0 (0) and
> shadow_list is TAS_LIST1.
> 
> After getting the shadow_list we fill three different arrays,
> 1. gate_mask_list[]
> 2. win_end_time_list[]
> 3. gate_close_time_list[][] - 2D array with size = num_entries * num_queues
> 
> Driver only updates the shadow_list. Once shadow list is filled, we call
> tas_set_trigger_list_change() and ask firmware to change the active
> list. Now the shadow_list that we had filled (TAS_LIST1) will become
> active list and vice versa. We will again update our pointers
> 
> This is how list is changed by calling tas_update_fw_list_pointers.
> 
> >> +	tas_update_fw_list_pointers(emac);
> > 
> > Calling this twice in the same function? Explanation?
> > 
> 
> As explained earlier tas_update_fw_list_pointers() is called in the
> beginning to set the active and shadow_list. After that we fill the
> shadow list and then send commmand to swap the active and shadow list.
> As the list are swapped we will call tas_update_fw_list_pointers() to
> update the list pointers.

Ok, but if icssg_qos_tas_init() already calls tas_update_fw_list_pointers()
initially, I don't understand why the first tas_update_oper_list() call
of tas_update_oper_list() is necessary, if only tas_set_trigger_list_change()
swaps the active with the shadow list. There was no unaccounted list
swap prior to the tas_update_oper_list() call, was there?

> >> +static void tas_reset(struct prueth_emac *emac)
> >> +{
> >> +	struct tas_config *tas = &emac->qos.tas.config;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
> >> +		tas->max_sdu_table.max_sdu[i] = 2048;
> > 
> > Macro + short comment for the magic number, please.
> > 
> 
> Sure I will add it. Each elements in this array is a 2 byte value
> showing the maximum length of frame to be allowed through each gate.

Is the queueMaxSDU[] array active even with the TAS being in the reset
state? Does this configuration have any impact upon the device MTU?
I don't know why 2048 was chosen.

> >> +static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
> >> +{
> >> +	struct tas_config *tas = &emac->qos.tas.config;
> >> +	int ret;
> >> +
> >> +	if (tas->state == state)
> >> +		return 0;
> >> +
> >> +	switch (state) {
> >> +	case TAS_STATE_RESET:
> >> +		tas_reset(emac);
> >> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
> >> +		tas->state = TAS_STATE_RESET;
> >> +		break;
> >> +	case TAS_STATE_ENABLE:
> >> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
> >> +		tas->state = TAS_STATE_ENABLE;
> >> +		break;
> >> +	case TAS_STATE_DISABLE:
> >> +		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
> >> +		tas->state = TAS_STATE_DISABLE;
> > 
> > This can be expressed as just "tas->state = state" outside the switch statement.
> > But probably shouldn't be, if "ret != 0".
> 
> Yes we shouldn't do that as we are sending the r30 command to firmware
> in each case.

I was saying that if there's a firmware error, we probably shouldn't
update our tas->state as if there wasn't.

And that the tas->state = state assignment is common across all switch
cases, so it's simpler to move it out.

> > 
> >> +		break;
> >> +	default:
> >> +		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
> > 
> > There are two levels of logging for this error, and this particular one
> > isn't useful. We can infer it went through the "default" case when the
> > printk below returned -EINVAL, because if that -EINVAL came from
> > emac_set_port_state(), that would have printed, in turn, "invalid port command".
> > 
> 
> But, the enum tas_state and enum icssg_port_state_cmd are not 1-1 mapped.

Correct, but you aren't printing the tas_state anyway, and there's no
code path possible with a tas_state outside the well-defined values.

> emac_set_port_state() will only return -EINVAL when `cmd >=
> ICSSG_EMAC_PORT_MAX_COMMANDS` which is 19. But a tas_state value of 3 is
> also invalid as we only support value of 0,1 and 2 so I think this print
> shoudl be okay
> 
> enum tas_state {
> 	TAS_STATE_DISABLE = 0,
> 	TAS_STATE_ENABLE = 1,
> 	TAS_STATE_RESET = 2,
> };
> 
> > I don't think that a "default" case is needed here, as long as all enum
> > values are handled, and the input is sanitized everywhere (which it is).
> > 
> 
> I think the default case should remain. Without default case the
> function will return 0 even for invalid sates. By default ret = 0, in
> the tas_state passed to API is not valid, none of the case will be
> called, ret will remaing zero. No error will be printed and the function
> will return 0. Keeping default case makes sure that the wrong state was
> requested.
> 

Dead code is what it is. If a new enum tas_state value is added and it's
not handled there, the _compiler_ will warn, rather than the Linux runtime.
So it's actually easier for the developer to catch it, rather than the user.
You don't need to protect against your own shadow.

> >> +static int tas_set_trigger_list_change(struct prueth_emac *emac)
> >> +{
> >> +	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
> >> +	struct tas_config *tas = &emac->qos.tas.config;
> >> +	struct ptp_system_timestamp sts;
> >> +	u32 change_cycle_count;
> >> +	u32 cycle_time;
> >> +	u64 base_time;
> >> +	u64 cur_time;
> >> +
> >> +	/* IEP clock has a hardware errata due to which it wraps around exactly
> >> +	 * once every taprio cycle. To compensate for that, adjust cycle time
> >> +	 * by the wrap around time which is stored in emac->iep->def_inc
> >> +	 */
> >> +	cycle_time = admin_list->cycle_time - emac->iep->def_inc;
> >> +	base_time = admin_list->base_time;
> >> +	cur_time = prueth_iep_gettime(emac, &sts);
> >> +
> >> +	if (base_time > cur_time)
> >> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
> >> +	else
> >> +		change_cycle_count = 1;
> >> +
> >> +	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
> >> +	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
> >> +	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
> >> +
> >> +	/* config_change cleared by f/w to ack reception of new shadow list */
> >> +	writeb(1, &tas->config_list->config_change);
> >> +	/* config_pending cleared by f/w when new shadow list is copied to active list */
> >> +	writeb(1, &tas->config_list->config_pending);
> >> +
> >> +	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
> > 
> > The call path here is:
> > 
> > emac_taprio_replace()
> > -> tas_update_oper_list()
> >    -> tas_set_trigger_list_change()
> >       -> emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
> > -> tas_set_state(emac, TAS_STATE_ENABLE);
> >    -> emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
> > 
> > I'm surprised by the calls to emac_set_port_state() in such a quick
> > succession? Is there any firmware requirement for how much should the
> > port stay in the TAS_TRIGGER state? Or is it not really a state, despite
> > it being an argument to a function named emac_set_port_state()?
> > 
> 
> ICSSG_EMAC_PORT_TAS_TRIGGER is not a state. emac_set_port_state() sends
> a command to firmware, we call it r30 command. Driver then waits for the
> response for some time. If a successfull response is recived the
> function return 0 otherwise error.
> 
> Here first `emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER)` is
> called which will ask firmware to swap the active_list and shadow_list
> as explained above.
> 
> After that ICSSG_EMAC_PORT_TAS_ENABLE cmd is sent. Upon recievinig this
> command firmware will Enable TAS for the particular port. (port is part
> of emac structure).
> 
> I can see how that can be confusing given the API name is
> emac_set_port_state(). Some of the cmds infact triggers a state change
> eg. ICSSG_EMAC_PORT_DISABLE, ICSSG_EMAC_PORT_BLOCK,
> ICSSG_EMAC_PORT_FORWARD but some of the commands just triggers some
> action on the firmware side. Based on the command firmware does some
> actions.

If you're replacing an existing active schedule with a shadow one, the
ICSSG_EMAC_PORT_TAS_ENABLE command isn't needed because the TAS is
already enabled on the port, right? In fact it will be suppressed by
tas_set_state() without even generating an emac_set_port_state() call,
right?

> >> +}
> > 
> > There's something extremely elementary about this function which I still
> > don't understand.
> > 
> > When does the schedule actually _start_? Can that be controlled by the
> > driver with the high (nanosecond) precision necessary in order for the
> > ICSSG to synchronize with the schedule of other equipment in the LAN?
> > 
> > You never pass the base time per se to the firmware. Just a number of
> > cycles from now. I guess that number of cycles decides when the schedule
> > starts, but what are those cycles relative to?
> >
> 
> Once the shadow list is updated, the trigger is set in the firmware and
> for that API tas_set_trigger_list_change() is called.
> 
> The following three offsets are configured in this function,
> 1. TAS_ADMIN_CYCLE_TIME → admin cycle time
> 2. TAS_CONFIG_CHANGE_CYCLE_COUNT → number of cycles after which the
> admin list is taken as operating list.
> This parameter is calculated based on the base_time, cur_time and
> cycle_time. If the base_time is in past (already passed) the
> TAS_CONFIG_CHANGE_CYCLE_COUNT is set to 1. If the base_time is in
> future, TAS_CONFIG_CHANGE_CYCLE_COUNT is calculated using
> DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time)
> 3. TAS_ADMIN_LIST_LENGTH → Number of window entries in the admin list.
> 
> After configuring the above three parameters, the driver gives the
> trigger signal to the firmware using the R30 command interface with
> ICSSG_EMAC_PORT_TAS_TRIGGER command.
> 
> The schedule starts based on TAS_CONFIG_CHANGE_CYCLE_COUNT. Those cycles
> are relative to time remaining in the base_time from now i.e. base_time
> - cur_time.

So you're saying that the firmware executes the schedule switch at

	now                  +      TAS_ADMIN_CYCLE_TIME * TAS_CONFIG_CHANGE_CYCLE_COUNT ns
	~~~
	time of reception of
	ICSSG_EMAC_PORT_TAS_TRIGGER
	R30 command

?

I'm not really interested in how the driver calculates the cycle count,
just in what are the primitives that the firmware ABI wants.

Does the readb_poll_timeout() call from tas_update_oper_list() actually
wait until this whole time elapses? It is user space input, so it can
keep a task waiting in the kernel, with rtnl_lock() acquired, for a very
long time if the base_time is far away in the future.

If my understanding is correct, then there are 2 things you cannot do
(which IMO are very important) with the current firmware ABI:

1. You cannot synchronize the schedules on two ICSSG devices to one
another.

You are supposed to be able to run the same taprio command on the egress
port of 2 chained switches in a LAN:

tc qdisc replace dev swp0 parent root taprio \
	num_tc 8 \
	map 0 1 2 3 4 5 6 7 \
	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	base-time 0 \
	sched-entry S 0x81 100000 \
	sched-entry S 0x01 900000 \
	flags 0x2 \
	max-sdu 0 0 0 0 0 0 0 79

and, assuming that the switches are synchronized by PTP, the gate events
will be synchronized on the 2 switches.

But if the schedule change formula in the firmware is fundamentally
dependant on a "now" that depends on when the Linux driver performed the
TAS_TRIGGER action, the gate events will never be precisely synchronized.

Here, "base-time 0" means that the driver/firmware/hardware should
advance the schedule start time into the closest moment in PTP time
which is a multiple of the cycle-time (100000+900000=1000000). So for
example, if the current PTP time is 1000.123456789, the closest start
time would be 100.124000000.

2. You cannot apply a phase offset between the schedules on two ICSSG
devices in the same network.

Since there is a PHY-dependent propagation delay on each link, network
engineers typically delay the schedules on switch ports along the path
of a stream.

Say for example there is a propagation delay of 800 ns on a switch with
base-time 0. On the next switch, you could add the schedule like this:

tc qdisc replace dev swp0 parent root taprio \
	num_tc 8 \
	map 0 1 2 3 4 5 6 7 \
	queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	base-time 800 \
	sched-entry S 0x81 100000 \
	sched-entry S 0x01 900000 \
	flags 0x2 \
	max-sdu 0 0 0 0 0 0 0 79

Same schedule, phase-shifted by 800 ns, so that if the packet goes
through an open gate in the first switch, it will also go through an
open gate through the second.

According to your own calculations and explanations, the firmware ABI
makes no difference between base-time 0 and base-time 800.

In this case they are probably both smaller than the current time, so
TAS_CONFIG_CHANGE_CYCLE_COUNT will be set to the same "1" in both cases.

But even assuming a future base-time, it still will make no difference.
The firmware seems to operate only on integer multiples of a cycle-time
(here 1000000).

Summarized, the blocking problems I see are:

- For issue #2, the driver should not lie to the user space that it
  applied a schedule with a base-time that isn't a precise multiple of
  the cycle-time, because it doesn't do that.

- For issue #1, the bigger problem is that there is always a
  software-induced jitter which makes whatever the user space has
  requested irrelevant.

This is sufficiently bad that I don't think it's worth spending any more
time on anything else until it is clear how you can make the firmware
actually obey the requested base-time.

> >> +static int emac_taprio_replace(struct net_device *ndev,
> >> +			       struct tc_taprio_qopt_offload *taprio)
> >> +{
> >> +	struct prueth_emac *emac = netdev_priv(ndev);
> >> +	int ret;
> >> +
> >> +	if (taprio->cycle_time_extension) {
> >> +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
> >> +		return -EOPNOTSUPP;
> >> +	}
> >> +
> >> +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
> >> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
> >> +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
> >> +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
> >> +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (emac->qos.tas.taprio_admin)
> >> +		taprio_offload_free(emac->qos.tas.taprio_admin);
> >> +
> >> +	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
> >> +	ret = tas_update_oper_list(emac);
> > 
> > If this fails and there was a previous emac->qos.tas.taprio_admin
> > schedule present, you just broke it. In particular, the
> > "if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)" bounds check really
> > doesn't belong there; it should have been done much earlier, to avoid a
> > complete offload breakage for such a silly thing (replacing a working
> > taprio schedule with a new one that has too large cycle breaks the old
> > schedule).
> > 
> 
> Will adding the check "if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)"
> in emac_taprio_replace() along with the all the checks be OK?

Yes, but "it will be ok" needs to be put in proper context (this small
thing is OK doesn't mean everything is OK).

