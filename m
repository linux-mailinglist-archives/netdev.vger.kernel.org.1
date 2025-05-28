Return-Path: <netdev+bounces-193803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A524AC5ED0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE370189A765
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB0148838;
	Wed, 28 May 2025 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="RfqbIl8o"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C11531E3;
	Wed, 28 May 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748395867; cv=fail; b=SS9Fp+5T7a01/rYv3tAdosv0EYfwERz7GGnFTOnBPwF94gKHGA7ht0nsQrDixz7NWqIGQoPwoOJ5o6AhNlakNs28XSNbcxr+X/yoflEtnYBKfQUmGNHdGu7UvjiJNIMOg0mRE3sDX2nlAXl6zlobY0iha+wT6iF3Vb4vZZThWm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748395867; c=relaxed/simple;
	bh=P1rjTeJOyLA58J1xlwN/EzCOiUFmQFU2pIRW6+JzbBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VGwKeGPLm+lHK4xaEHQYC7oFKlWVn3rcjKoJgJNGJcobT/X84KNNgLfCh020PkS7wfau5J5wZdpyfoab6F3K5ixSRr4UceoRkfHVP3hJ+HY8stlU6ce1+ldvqOgnDq2ya71AiJLYoEHJXXKQcM1xzEae+pB6maW1fznaIJbqKXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=RfqbIl8o; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOqTbRNZK3DCvljvjChS47j3pr9YDgObPDa4fNcDwcMeKZxCAPUZepHXTAVryr/AFIr+imtuUFEjzGe2pg0Rh01mZL0yP/XbSdxnRUFAKJU2cx/uXCKgpGPyW+BU9Z0v46drYcuk0upZmLDUO0CNmrX7/3tv3j67TQCOvb54M7DJ9QxhJHglB82HGrd5A+IUVocBZBTpTT08eL3FOl2WjrNKG4W6wiKkKP47RDn4OPsn7AjUXcpDhURycYX+6lpzndT1HhdOI7CTQ9/ny3RXrvp38RrsEx3cgLvzB0Ctv6rB6j/A+dnN+l8FkAFmehe41vAFFETX5B2n5L9pAPmeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1rjTeJOyLA58J1xlwN/EzCOiUFmQFU2pIRW6+JzbBE=;
 b=TSMI66GJiYXhYyA0lb3GMd4w3EVq/AdvfqKEOnEVFv7telFMudDtszINlLZDwPcLrX9NbIcT1VQgQqjExgpQKfpKwkWhXcC8yfkuEI/l3LU0sM46mEvWRW7IVrcyfK6yIUNfCm9kWOMdAwKO5Hen2N2WdH1eNho6LkpT0DAK3jT4z48K9PPxd9D69mVkVMaoBG1MqYJgPxsWJrbxJJhCl+iT15gLHGXD4xA+bZ2rKNkoy3M6b6owlC6RmTNnp+PrzqRrJvBRXGGujnoJ8HyWutxxJhH2nlwcDeEuN9FXvSvYcMm5kjf04gWZ4+ievUbHpCuN/KWBDsZc7EimKgvSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1rjTeJOyLA58J1xlwN/EzCOiUFmQFU2pIRW6+JzbBE=;
 b=RfqbIl8o4D89Cx+gs5IeX9FGQ45r1bx9NFPmuFRlxX2L41oWFfMjM5Ju6Mv/jQvroWzEmKlnnN7H/SOmlgDZwH82i7HfXaPNzfZ3q7lxd2Wtm7AijVaCGdx2tYJPbudaI45eb8YLuCQbp13b61pWgP+Nk4k2CnKq02SnvBwhIpgf/f/FLiUyd1hmpJ/FSewo1SfAPe6GT4xfuRh9J0UYgs4O+DtFmN4lMLvqCIk/iPZ1aOjr5P2IXvmedpM8xsoVtkoBcAwU3wUhSTDbW7p89ly0LpZAnaAAKWC/wqCu4ChwFogsbfuh2Bt1KCzJArUEvB4tfFdwUWvWCr90H0drDA==
Received: from AM8P189MB1314.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:249::7)
 by DB3P189MB2329.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:43e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 01:30:57 +0000
Received: from AM8P189MB1314.EURP189.PROD.OUTLOOK.COM
 ([fe80::4123:5ff7:5d38:8900]) by AM8P189MB1314.EURP189.PROD.OUTLOOK.COM
 ([fe80::4123:5ff7:5d38:8900%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 01:30:57 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Charalampos Mitrodimas <charmitro@posteo.net>, Jon Maloy
	<jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Wang Liang
	<wangliang74@huawei.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com"
	<syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com>
Subject: RE: [PATCH net v2] net: tipc: fix refcount warning in
 tipc_aead_encrypt
Thread-Topic: [PATCH net v2] net: tipc: fix refcount warning in
 tipc_aead_encrypt
Thread-Index: AQHbzyV6p6WEHAHp7kyrbRdsJYXIS7PnQO7w
Date: Wed, 28 May 2025 01:30:57 +0000
Message-ID:
 <AM8P189MB1314EBE3549E2962C6EB728BC667A@AM8P189MB1314.EURP189.PROD.OUTLOOK.COM>
References: <20250527-net-tipc-warning-v2-1-df3dc398a047@posteo.net>
In-Reply-To: <20250527-net-tipc-warning-v2-1-df3dc398a047@posteo.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P189MB1314:EE_|DB3P189MB2329:EE_
x-ms-office365-filtering-correlation-id: fefff3bc-34e8-46d8-c155-08dd9d874baf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjBkeE04blZSaW8wOXQ2MHM5eTZnSGpVTTBuNkNiWVpNZ2VpSTlmSWVZem56?=
 =?utf-8?B?VXRjaDIwR0pEU1JrZm01S090OGtLYnUybkdLa2RBeHhRVnh1STFreFdLVndW?=
 =?utf-8?B?RnZRd1VORVpNSUk3T1RLV095SmlHNGpDRmxzRFdJNVNaQi9oVzZTYVBDenMx?=
 =?utf-8?B?TE1QN1BxamQzTXBwK3pzditlM3MvbG5pMElUZFhNTmdiSTdmV1prWHdmMXlo?=
 =?utf-8?B?MnZPZTRKNGMxS2xkRkdSTVQzdDRJUkhNNHY2TWs0d0VJVnFwN2JjWUIwcis5?=
 =?utf-8?B?VDU1QWFDUHN1SXRQU3ZTVnVIajJ5TDVoUFRCR2ZUMTFmK0VXakM2SnVhcnZE?=
 =?utf-8?B?S2lIVE5aTVB6RTFwaC9oSTlmbWpzZGNPQUxOcElQdlJiNmxXTVVabmtZd1BP?=
 =?utf-8?B?cm9LUkZSMGpRQjRkYkVpb1dqZGZEdG5lSDM1Tk85aDZXTVBDL1JGVjJtZDdS?=
 =?utf-8?B?UGc3clJhdnZQS2sxNnZZYjRYbHdUdUhqVnczeGZ1MW9YbXYzUXhhUVdTSW1O?=
 =?utf-8?B?NUdoeVZGR3N3cTVIRmZJaHZockp5WXRKTVJoT0MyVEdvV0FWRU10cXp5eFZ2?=
 =?utf-8?B?aGlHUkhuMGt5NzZsR0JDcHRwRGJ2cVhJSDIyT2lOd21DRUJBSC9Ybm5JQzho?=
 =?utf-8?B?RmMvclhvL2FKZi9oSVU4aWxtSzNPeGJaNzQxQTJkMkJRUjFvaktxVU9LTDBX?=
 =?utf-8?B?WlVjdUVaT2RNVDdFUThzQmlzVTVoUVRacmNGbEE3cEJZQ2F3R1pINzBFUXRT?=
 =?utf-8?B?V0RrekhaSzlLL2N5WHJjY1dwamtqTVhLa2Y4TzN1ZXRjY3l5b1VxQlQxU0NK?=
 =?utf-8?B?Sk9BS3RoM3dzeHlsUjhXQ2xraytUSFJBUlBuemlQMWI4UXFLVFFVY0QzRWxL?=
 =?utf-8?B?TGNMaThVZTVCckVQSHJkVW9TM2tjUGRHSVN4YlZDa1NsVUFsb29xRVpmSUx3?=
 =?utf-8?B?M3M4M3lMY0F3cFpzZW94eVlSVm83V0RVZUVaK0pCUmJaSlJPWkVRczY3Smcz?=
 =?utf-8?B?aFVKZ1FJdzYrbzVnOTNraGdQRlRMZGF5NCtCUVNmNytGM09SNXhLUDRwOGpm?=
 =?utf-8?B?WlZ6L3ZPMVJLZm9iNU1vd1NabkdmUFE5NzlNYy9qZDdhcno0QVJVRW1vU1dJ?=
 =?utf-8?B?S0RKWjg3aVNjbm1XamM5RUNKM2ZMUXRCekNuWE5abmdhNmJsZXBKcjl1OU5D?=
 =?utf-8?B?Ull4K293cW9vaGNhc3Uzd3g4eURXRm9yNVRXdWxlUE5WcWw2SXpMR2FNS1d4?=
 =?utf-8?B?ZVdEbUh6di9jZ3A2cFJKWEVNcHNnbCtUL0MxWFhpcDROQWFiMVlGTFdKOVo4?=
 =?utf-8?B?bGQ0MzV5RzBXN1VGNms0UkhaS25qUXJBTVZjcXMyWGtrQWt1allhOHJCRnYw?=
 =?utf-8?B?bGJOU1BuMVdqU1JWQ1p3NExaZVU4bkVjemJSZ2ZiQlpUUndwRnk3ei93NUNn?=
 =?utf-8?B?S1E3UGl3LytkV21nNUJKWXA1RjljTlhPRGtSRHhHWTFhT3RmYzN1NGRBMlpW?=
 =?utf-8?B?UWJnNHdHazJlOEVYTWxOaFRGaTNibG1ScXVRMUp0R3h6YldCTnRxVkdIeWMz?=
 =?utf-8?B?VmUyRzArd0lXdWxCdE1qNDk4SHNQa2dlN21JaDR2QUpGdmVoZExHa2VKNDJR?=
 =?utf-8?B?MlZIL3Q0a1B4cWV6SHJZMEVHelhUa3hGb2J4a0hlRXNEejEzT0ovM1BoRTJ5?=
 =?utf-8?B?UGVtODNINnhFc3lGUTVsTDBtVWh1VFEwQ2hsVkZ1UDVzQjcrNGNTc3JhUkVU?=
 =?utf-8?B?azB6ZDM1a001YkNHeWxtemtpUEd6aWdjdlJWQURGWnVhUlBsV1FJdnRnUCtt?=
 =?utf-8?B?QW9wNDZPK2JSNXhUK3JISExLNUhGWThrOWFxWUYxNFpLcDA4RkJTU1BEdHRr?=
 =?utf-8?B?bHRDb2VSeCtzY2JNZ1k5OVNnUDRjdXpCS0lkQXBob0ZRbkhuUGlCMzhHWmoz?=
 =?utf-8?B?bXpJY2VuM0Y3Vzc2aDVQWjFwR0FwSjVmT25Nb05hKzdnQkd6K3lVZVErcklz?=
 =?utf-8?Q?YsjHzO9pam8dVudVN0DTsla4WlRdo8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8P189MB1314.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVRWSFFxaDZWVnM4M3lxV2tPVDJzeFdjRnYvSUY3UFFXQ3gwQm03NnlJbXpU?=
 =?utf-8?B?ZnRqSFNWV29BOGlaZE5CVC9uNmFhd2s2bEE0Y1h1b2o4NHc0c3F5LytLclpw?=
 =?utf-8?B?RzZqOW04UmdGUGs4K0xjYlVpVitEaTBCcWNGWEo2c1V0Q1gwbVJiOVpQeURD?=
 =?utf-8?B?UDJtMWlyU0dBYWNkVGkxMVVqaThCNU1kS3oxR2gyS0NaTXNyV1A4YnJxMkRl?=
 =?utf-8?B?eVpuZGdnTVlWUVUzV04zbFdOWDZnL2dNTHBUS1RNekxjZURJY0lOcFEvRGM5?=
 =?utf-8?B?M0JRQ2NxUUovZnF3cS9VSWViOWVDWXFsNzhMVFZ0dnorRW5uLzM1MkJ1Y3JW?=
 =?utf-8?B?SkZWQlhKQWlETjR0V0EraHFqcXNmNGxxc1ZnM2lsYUd2NXh5b21lcFJPb0tL?=
 =?utf-8?B?anlHMDhodjY5YWFvV3ZwY0FaNG8rWWcyRExVc2ZkQmlGcWJQR0R2SGJvV21o?=
 =?utf-8?B?cWJsR2NvV0F5ME4yYnd3Z2MrWkFocE9XSDF1OVYyUEh0ZkdDYlJNMVpNdkNJ?=
 =?utf-8?B?Wlg4cmlGUE9WLzhOZ1V4RUhkUFFUOVJRdEdGcUtQdzU2c0dvYm56RHJyWmg1?=
 =?utf-8?B?MXRIOFVtek9qKzFvdGplTFBDWUlqajZ5MGtQVWxEWU1rVnZ1eDIxc01MbW0v?=
 =?utf-8?B?Q3B1S1ZENzhaOFNWUXVDTXB5bjE1UkVSVkFuT2pvTWhQU2MwcjFsN0pEekVN?=
 =?utf-8?B?ajRBVDNhd0NCRWRrWW02YUJNYSsrZ3VqMDVLcEFlUUNyWTM4UTdBRnBhcHJs?=
 =?utf-8?B?L0R3ZDN5T2N2WVA0NWxMY3pjMWo2ek45U3R6U3MvbHFpOE1veDYxbUd4bWR5?=
 =?utf-8?B?T3p1bDBwdjc1S0VibGVGRHhBdEVFeG9HZnFnYm9ab3Z5TXRNc09keDd5QUdp?=
 =?utf-8?B?bGZSSVZjL0F1SFpqTmJyTWJab3NTVmlpeTNwTW5aZmU3dWk1T0ZSR0NkWWVN?=
 =?utf-8?B?Z1VxWlVWYldZSzliSVRtdTRHc2ErdmYvUWlPS3U5UFFCRVJ2bG81dUNBVWJM?=
 =?utf-8?B?blRQc1hYUE9jQzhvTVFidldZSklORHZURmVsRnkzRE5DbDdHQUhFbVhaNm9z?=
 =?utf-8?B?VldTVWwyTWN5bDdGZm5YWHBrTkVVTHVUaHE1RUl3cEgxODA5dHdxUUZrQzhU?=
 =?utf-8?B?Y1gvVnIxR00rUnNiS1NDRnBsMFFMUk4yVncwZWkwL2gvQzZUQkJTRXNoZ2x5?=
 =?utf-8?B?N1BrTzRXekdBU0RRYitjcUQ1RE93VTBCU0Q3NE9pOFFoSVA4blphbndvTGtF?=
 =?utf-8?B?dFlFeGJadThKcGY1cjRoeGVxZHFyb2JIVU5ja2xiRDk3cEw2TDkzUnd6M1Jh?=
 =?utf-8?B?L0ZPT3doQVpjRlFJNk5OYmxDMjJ5VVgrNWlxZEFKWUhpRVNMekpmZ2dPSUt2?=
 =?utf-8?B?enByVVlnNk5sbkt6cGNha0dEUUU5cTJERG5FYVB2elZiNEdhRG1BWDl5YU5D?=
 =?utf-8?B?UEE4VWN0Nnp2ajNHMkhqM3lqSk5wSUF2K0dvbDZYVFBTZG1PaU1kNDVnREFa?=
 =?utf-8?B?RlpLMEJIYTVzY2I3akxFN3FwVm9tMzNWWCt4ZjlpYm10VkJHNmM0a1JQc0tZ?=
 =?utf-8?B?Q3lFaVEreWM4MXRTemQ4Tk1WSTBaV2tETkY4Sk9tMDdRU0JMZVJyQlpmYzFC?=
 =?utf-8?B?RmcyK1I3RXB1NFhLN1c0RXdaMmdUM1MwOU9UeGJ6RkJnb2JRR0hmKzRNVlhJ?=
 =?utf-8?B?Sjl3TUhmNk56aFZOV1l1V2NXWTRrU3RwbHJmZGl2WUZTcUh6bS9tR3RZZWlt?=
 =?utf-8?B?eC9yU2NQenVaTXRVakZJVVA3SGdIekVQcG50aUJFNCtuTDhvUk54STd2OXMr?=
 =?utf-8?B?bU5IN0M2TmRZMElWY2I3Wmd1Zld0SmtYSWpzb01ya1dvbFYvMXdHa0hJeGhy?=
 =?utf-8?B?RzdVQTUxUFB0dlB3T0M3NEQ5a2RTRVJIaXlMT2pidC83UUlMR09GR1dmWGE3?=
 =?utf-8?B?NXFGVllqMkxqUDBPdFo2OVVlY0crdzc0RXVxN2EwTXJLenhOQkVyS1RIaktB?=
 =?utf-8?B?Y2xSRzA2YzB3emc0QlJwWEh1bHF5RC9IQ1lRNEs2MmxOejVYNEFNVWl5Z3U4?=
 =?utf-8?B?eEorZkRpRGNrNWl2NFFLVm1UejJ6R1E1WVl0V2dmR1R0UnpBa1dUM0J2dEpW?=
 =?utf-8?Q?hl/TkMGGmZ0sXYVBRCD2/De2O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P189MB1314.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fefff3bc-34e8-46d8-c155-08dd9d874baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 01:30:57.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rC7ncqq0EzM7aInYhcVcs7zW+FHir2CKgeN3rw0Xawg4OdnMgjRF5seV01c2B2P8G7AdXpZQeP7E4kSiTWYx4VvFz+CMR07zUANyNaSb30Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P189MB2329

PlN1YmplY3Q6IFtQQVRDSCBuZXQgdjJdIG5ldDogdGlwYzogZml4IHJlZmNvdW50IHdhcm5pbmcg
aW4gdGlwY19hZWFkX2VuY3J5cHQNCj4NCj5zeXpib3QgcmVwb3J0ZWQgYSByZWZjb3VudCB3YXJu
aW5nIFsxXSBjYXVzZWQgYnkgY2FsbGluZyBnZXRfbmV0KCkgb24gYQ0KPm5ldHdvcmsgbmFtZXNw
YWNlIHRoYXQgaXMgYmVpbmcgZGVzdHJveWVkIChyZWZjb3VudD0wKS4gVGhpcyBoYXBwZW5zIHdo
ZW4gYQ0KPlRJUEMgZGlzY292ZXJ5IHRpbWVyIGZpcmVzIGR1cmluZyBuZXR3b3JrIG5hbWVzcGFj
ZSBjbGVhbnVwLg0KPg0KPlRoZSByZWNlbnRseSBhZGRlZCBnZXRfbmV0KCkgY2FsbCBpbiBjb21t
aXQgZTI3OTAyNDYxNzEzNCAoIm5ldC90aXBjOg0KPmZpeCBzbGFiLXVzZS1hZnRlci1mcmVlIFJl
YWQgaW4gdGlwY19hZWFkX2VuY3J5cHRfZG9uZSIpIGF0dGVtcHRzIHRvIGhvbGQgYQ0KPnJlZmVy
ZW5jZSB0byB0aGUgbmV0d29yayBuYW1lc3BhY2UuIEhvd2V2ZXIsIGlmIHRoZSBuYW1lc3BhY2Ug
aXMgYWxyZWFkeQ0KPmJlaW5nIGRlc3Ryb3llZCwgaXRzIHJlZmNvdW50IG1pZ2h0IGJlIHplcm8s
IGxlYWRpbmcgdG8gdGhlIHVzZS1hZnRlci1mcmVlDQo+d2FybmluZy4NCj4NCj5SZXBsYWNlIGdl
dF9uZXQoKSB3aXRoIG1heWJlX2dldF9uZXQoKSwgd2hpY2ggc2FmZWx5IGNoZWNrcyBpZiB0aGUg
cmVmY291bnQgaXMNCj5ub24temVybyBiZWZvcmUgaW5jcmVtZW50aW5nIGl0LiBJZiB0aGUgbmFt
ZXNwYWNlIGlzIGJlaW5nIGRlc3Ryb3llZCwgcmV0dXJuIC0NCj5FTk9ERVYgZWFybHksIGFmdGVy
IHJlbGVhc2luZyB0aGUgYmVhcmVyIHJlZmVyZW5jZS4NCj4NCj5bMV06DQo+aHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzY4MzQyYjU1LmE3MGEwMjIwLjI1M2JjMi4wMDkxLkdBRUBnb29nbGUu
Y29tDQo+L1QvI20xMjAxOWNmOWFlNzdlMTk1NGY2NjY5MTQ2NDBlZmEzNmQ1MjcwNGEyDQo+DQo+
UmVwb3J0ZWQtYnk6IHN5emJvdCtmMGM0YTRhYmE3NTc1NDlhZTI2Y0BzeXprYWxsZXIuYXBwc3Bv
dG1haWwuY29tDQo+Q2xvc2VzOg0KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC82ODM0MmI1
NS5hNzBhMDIyMC4yNTNiYzIuMDA5MS5HQUVAZ29vZ2xlLmNvbQ0KPi9ULyNtMTIwMTljZjlhZTc3
ZTE5NTRmNjY2OTE0NjQwZWZhMzZkNTI3MDRhMg0KPkZpeGVzOiBlMjc5MDI0NjE3MTMgKCJuZXQv
dGlwYzogZml4IHNsYWItdXNlLWFmdGVyLWZyZWUgUmVhZCBpbg0KPnRpcGNfYWVhZF9lbmNyeXB0
X2RvbmUiKQ0KPlNpZ25lZC1vZmYtYnk6IENoYXJhbGFtcG9zIE1pdHJvZGltYXMgPGNoYXJtaXRy
b0Bwb3N0ZW8ubmV0Pg0KPi0tLQ0KPkNoYW5nZXMgaW4gdjI6DQo+LSBSZXR1cm4gIi1FTk9ERVYi
IGluc3RlYWQgb2YgIi1FTlhJTyIuDQo+LSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjUwNTI2LW5ldC10aXBjLXdhcm5pbmctdjEtMS0NCj40NzJmM2FhOWRkOWZAcG9z
dGVvLm5ldA0KPi0tLQ0KPiBuZXQvdGlwYy9jcnlwdG8uYyB8IDYgKysrKystDQo+IDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4NCj5kaWZmIC0tZ2l0IGEv
bmV0L3RpcGMvY3J5cHRvLmMgYi9uZXQvdGlwYy9jcnlwdG8uYyBpbmRleA0KPjg1ODQ4OTNiNDc4
NTEwZGMxZGRkYTMyMWVkMDYwNTRkZTMyNzYwOWIuLjc5ZjkxYjZjYThjODQ3NzIwOGYxM2Q0MQ0K
PmEzN2FmMjRlN2FhOTQ1NzcgMTAwNjQ0DQo+LS0tIGEvbmV0L3RpcGMvY3J5cHRvLmMNCj4rKysg
Yi9uZXQvdGlwYy9jcnlwdG8uYw0KPkBAIC04MTgsNyArODE4LDExIEBAIHN0YXRpYyBpbnQgdGlw
Y19hZWFkX2VuY3J5cHQoc3RydWN0IHRpcGNfYWVhZCAqYWVhZCwNCj5zdHJ1Y3Qgc2tfYnVmZiAq
c2tiLA0KPiAJfQ0KPg0KPiAJLyogR2V0IG5ldCB0byBhdm9pZCBmcmVlZCB0aXBjX2NyeXB0byB3
aGVuIGRlbGV0ZSBuYW1lc3BhY2UgKi8NCj4tCWdldF9uZXQoYWVhZC0+Y3J5cHRvLT5uZXQpOw0K
PisJaWYgKCFtYXliZV9nZXRfbmV0KGFlYWQtPmNyeXB0by0+bmV0KSkgew0KPisJCXRpcGNfYmVh
cmVyX3B1dChiKTsNCj4rCQlyYyA9IC1FTk9ERVY7DQo+KwkJZ290byBleGl0Ow0KPisJfQ0KPg0K
PiAJLyogTm93LCBkbyBlbmNyeXB0ICovDQo+IAlyYyA9IGNyeXB0b19hZWFkX2VuY3J5cHQocmVx
KTsNCj4NCj4tLS0NClJldmlld2VkLWJ5OiBUdW5nIE5ndXllbiA8dHVuZy5xdWFuZy5uZ3V5ZW5A
ZXN0LnRlY2g+DQo=

