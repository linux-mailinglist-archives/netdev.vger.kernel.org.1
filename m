Return-Path: <netdev+bounces-278222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B1+G/Jx3WkgeQkAu9opvQ
	(envelope-from <netdev+bounces-278222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88553F403C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46FE530488F5
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD1037B007;
	Mon, 13 Apr 2026 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gtlzsJK+"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023088.outbound.protection.outlook.com [40.93.201.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A421CFEF
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120230; cv=fail; b=SJR6UTlP4XAlZLgnkXx7OAgkyxL4uWGxT0IaOrX2NQaJRlwxcjI1Cx07lNOkjdk/FXSlaWHKz2pIMdGCkcsfOSNbNt78tn3ZTYKKPls++K4CvlZmx4Jj1UJhSj/YYIegKuu66/7kLpzuEDAIEwClyOz6fUlu16cw4pkhERqqbUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120230; c=relaxed/simple;
	bh=Q56yZWNdiY4/1GygkDFk4tsRLODUNRQ9DU63Y0s5Etc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wfwr9HbxAEiSZBtOmGZjjcSSByUnlP4tk/vn27HmU8bqVpTXNosE3vJVTv2HAS1fL7nsYM3OEFtgDQ3+dneLvBp9RQfALD2dZ9ROgMprUNlz083rbho7mHf7oplYJaNyeVKMMjv3P76/Kv67A2FR4VjiKRqi53CZTTTCu7xjJ2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=gtlzsJK+; arc=fail smtp.client-ip=40.93.201.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2KafSQp0BkIHqGvfoInpZGlDrVjatkgIMUQXdadtLtNH+6Kf0Q9gyzEp3wYxUFKzcqdOlTB0O0wffhAma39iWEmdnJPBArFry/E6/LlbWzah9peUFsQxM3o3P4LFVqvYC/HX+QMTjOJ3j4Uw42N0gyj+CV4uAC+V+eNVCqvayqZ3PdORSHh9iDjIAwTt1IEjKUw+dUuJmHUyfgKH+wpf1kz8mGeL3g1jo0C67MMLGa/mIAPgicopL3mxv/LLbsAYV5q0zP0azd6tkBn9h9IQ8kWccQgeV4DK0VtmGJiSZkvF9itL0RU6XAFNX/Pp4tG2bJ+uFI05BAfhBFEhtryTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/g17ek4EsBAiglPijfLOsenTMHQWNIzStL6GGvBdtw=;
 b=m8yIPZF9AYaQBgWdZrTK+YKyKzMORsdxgS3NP6s7D4P6G4LrsYrs8syFQguhNnJFULyK9nMHsS5R9ARhhsStLjbnK0eAUVNIcZO0kJZNROX9qzaCh747qj1JNS9eKP0jNFiOtC7hspIP6RyUtLfrMSE+lQIPjZdBt1boCuA/+xFz1T5TfvD32N6hcwOQJr7gZDmBPpL8asgTcj8bl3beADMJXe85RE5Ue2hJ+5NPyV7JTf17kK6D55KcOUk4rYiG1NLDaYO8yEi4i5dsuWXwKF4otRm+nC0i49155DP+47cMXjjWdJMI8dpMuxF7nA6esDTgbjxNLvaNetLWwy+I0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/g17ek4EsBAiglPijfLOsenTMHQWNIzStL6GGvBdtw=;
 b=gtlzsJK+5k6OLcaA8B/euEiF1B2Z2i1c0O3xYPBkY1NWAnGNgd40J6CA7UyG1wQEDuzBHNSiitUzuMPywTLDfAqJb06GsN4YPN/mMkBKftCvzCwCbUoguQ7X31PR1t8FDxUTm6sQBntlfvXd7dcCMHm2FuGaIsrM59Yp6x3WkVQ=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA1PR21MB6801.namprd21.prod.outlook.com (2603:10b6:806:4ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 22:43:45 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 22:43:45 +0000
From: Long Li <longli@microsoft.com>
To: Ao Zhou <n05ec@lzu.edu.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ernis@linux.microsoft.com" <ernis@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"dipayanroy@linux.microsoft.com" <dipayanroy@linux.microsoft.com>,
	"gargaditya@linux.microsoft.com" <gargaditya@linux.microsoft.com>, Shiraz
 Saleem <shirazsaleem@microsoft.com>, "kees@kernel.org" <kees@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, Yifan Wu <yifanwucs@gmail.com>, Juefei
 Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>, Xin Liu
	<bird@lzu.edu.cn>, "ruijieli51@gmail.com" <ruijieli51@gmail.com>
Subject: RE: [EXTERNAL] [PATCH 1/1] net: mana: fix use-after-free in
 add_adev() error path
Thread-Topic: [EXTERNAL] [PATCH 1/1] net: mana: fix use-after-free in
 add_adev() error path
Thread-Index: AQHcylQjZTFczecGNU+UuCG8rX3VE7XbE56AgAKFPLA=
Date: Mon, 13 Apr 2026 22:43:44 +0000
Message-ID:
 <SA1PR21MB668319232041B8F513C31AD2CE242@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <cover.1774942606.git.623701471@qq.com>
 <c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f.1774942606.git.623701471@qq.com>
In-Reply-To:
 <c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f.1774942606.git.623701471@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=153c0e75-3da5-4580-9c12-876c5a6d8677;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-13T22:42:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA1PR21MB6801:EE_
x-ms-office365-filtering-correlation-id: 51b04f61-c52c-479b-cafe-08de99ae1e89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 YTj/sHPvXw+2lxGi1R+zX4cBVH80Va+bgc/23spVg84zt7y7Ryg6/TffsleFl1mYIxQXC9Iy3p1I+O3RvTKGaAR1IJt7o/m4yqgJ47m11pCjR7YaDipDuneyQQFKHe/kXbleMX6c1hwn/LEE+s+oUygz9zJYsJ8ws3z4Fwz9qH8JOfsLk541NtXRPVn9IdIiL+0MhBPYe5UfKyl0g6irTwEv2g9RD5eoLfbHbIKIpAXbVAALnBk7m3LsBlw52C7IPgK9n+N5T4NTkOMTKwl+yOIv3pi/Ifx9e2uIoTNZjIp1Mm+JSpFExYjsFHz7SQiu+YF1M76uHaVxwkPo6psXLXW3yQ7xj3DXv03qkstBumjbaRzeaz0DuBu8tjpYqeZou4R0E2uERNtabi8lq4KkryzGbSlrxqIl5IYXTAumiTRShbCYBquh6Ta0WUf4w0r9ROnOnFJHX2yDnFn39d4ZMxVJLnlwijx8i5I0H2VupUcFC6uM83PogyF1/MFNuGKNgmp0hkYfp9/7EVBN2N3MhivLIPW2BgNP7x8INM0dave1Wm5IL3BYjJVQhdJIf4PLOJD6yChM/eBghUd5KDW6BHpq+AmbAGXfOs+Re6D+LDmxVG6y6AqgriZf8ruupqyckhm3j7Wvq0ELie3gQi2z3DwJf6UsFscEZXY182fnd4wOkwIQaF0Ts9F71QygoyPup25Pz0gQ7wDKenEIBQ3QwXDzf4SeyaPKIQEkwkgMY9EVeJSCelOdAp4jbEdRdEjrXs/CKkGIQpiAglhk8hwMW02/jl/PHCJxbORTq+PWKXY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sJUKVEvvOSPw2k6rzWFGC05HZ8eZX0N1ST+xDoQ/d0UOLd6nHJ0Fb3PRavKG?=
 =?us-ascii?Q?42hpbIAWdfeQJWc6KfhBcBAu8zhNg3+CjAi22dcONhTuWBOJNFHKNNtb0Md4?=
 =?us-ascii?Q?xYR7ZRznvjCnWl1++C71Z55qlGTDsr/rw6epaD0lBDVJVqv03Dg2RqA7ma0F?=
 =?us-ascii?Q?OFfBMEd3VntAj06hZqsN+03WXG/NeSnKuIKqK9qpzp7eXIBxWI+YCvuD/EOc?=
 =?us-ascii?Q?hSNMjXcGLXv9Vse9WRUoF6BzdKeYm05I01xDwKAeSL3hPQQfh77ksKFqnTT5?=
 =?us-ascii?Q?ViTCfNcnBVtTxWjJFsYC0xxq9e39hCk87L6bXm9Jo0zkFM9q3bKFy2BfYu6Q?=
 =?us-ascii?Q?kbHnxx/iu2uDXcYj99UpqyMVH+fGBRohXA/cAkGtCJu7raEK54h8zfQMkZbv?=
 =?us-ascii?Q?/BIZCbd+RNvnP3VaAPt4vKiyzJrPhHSoCHsu0+OzjetF3Mv+nNxQhMXx0C8O?=
 =?us-ascii?Q?iSgsUbMiiQISy5lxHCpGYj0A2JIxcQmFpiuzOnmyH0eBu5/CvvjdQ85yVA41?=
 =?us-ascii?Q?EVg4CrjZ3ZiH/r7AGkJ54aSWu49iM/6eqndj6pjQAFSoOFsPPPV92mlqa7gs?=
 =?us-ascii?Q?2ZZ/nLsEecxwGcBdS6dt3wDHWnKGCD46ENZf7Z8HqldIV7Bee7/C2I1/8sEG?=
 =?us-ascii?Q?kOPV30ZB+b08dTQ5YqHT36GxMedDJWq5usdUyH1Bhy82ztQpgfCXyPZmvk/K?=
 =?us-ascii?Q?CjQJESaJ809mEDJvHTcRJSHVlyqSG3l1ADi5HowXxQaz4W0HBAF8jcxJNlrU?=
 =?us-ascii?Q?DQodRCz8kinT3fa2oeMWx5HzyP64R4/e9ikvp7eeB+Z3m66pknTPvAl0hMlR?=
 =?us-ascii?Q?9l+05SN/R02OIK5fPQsKg+YAzRpVwXXFlyypWWDy+HtjYsULVZRqRaY/cqDg?=
 =?us-ascii?Q?AqQlTF8YCm9DMqJf4LS7ldWHobDpjEBO67TnYyH+tGWtoALhVQcKURgxCpfv?=
 =?us-ascii?Q?7YFBDFXRwpguBb6YDE9WkSqGxQFNraXFcDg/BTYPwlIHlGDkV0uepiJ1cDCf?=
 =?us-ascii?Q?24NTNmbq7zD54LHZol1ooC5g6s9bqLD5dsa1CwkcmhGDkM6Wp3FEBBGlt9Rd?=
 =?us-ascii?Q?4+8+wK/6RCPhJVF4QKdrs09p8CH+fnsn9eW574+9A1fu3yrs8qVAC3dnaIGv?=
 =?us-ascii?Q?0YrdrUkVLa10+8GQeSOnpdNM19+MGAhvM+kNb8oBsUNzChoxLZQgd4xT24vw?=
 =?us-ascii?Q?TIrzeFznSrdZMnxTIYQ5x8afVDD88AG2gc0VBRov3Z56UxNQ8ujzbbO2BI/K?=
 =?us-ascii?Q?kuqeTQQ0OCa1DHljRqROjEJGvVoLgSPlwwsJkdd1QKzGOZluxkXPria54SZk?=
 =?us-ascii?Q?SrWPkQlOpvxOR376afPGq/sPUPbzWQj1VOAvExVN8HeK9Ww/B2gwF+O2l5DC?=
 =?us-ascii?Q?LyC2Uzd80SvWHKzHkkUc7b78oy9t/AWT9wjWkXwzDHT5ULFoQVe/cuMa95ER?=
 =?us-ascii?Q?Sox0z3QvlLaimFg0sF5xeqYDsowGOIOjSxU4ThTLpxIK+7W4yheEZGjdfI+c?=
 =?us-ascii?Q?lk24eHTb4Yxh4KJPwSdK95PV30SPjUx5uchjMlnVpK9g2gF4O8wCkw0z7DxC?=
 =?us-ascii?Q?Db4MtzygaE9lWFKL2lvTp3sMZbxKsXoPTiDuxdAIhka+LQNuNvxSFCM2yaSY?=
 =?us-ascii?Q?rjfdsPe7jK7Dv64DnM9rbZZvYQO2yy/xJHDSFbdq5LCBb0lQGhYlK3kPvHGJ?=
 =?us-ascii?Q?xCvrhDQEWkAougXC09AycpAXx1Xlhx8o/4g925saV109P6cr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b04f61-c52c-479b-cafe-08de99ae1e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 22:43:44.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZiBu6nmQzySZCp3HYh8mUGj0mq4Fmq3bS04JIjPGaDszGpG7feKifZcSIjUaQIixesFQDUPXe9jfCgt/NhRQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB6801
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278222-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,lzu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email,SA1PR21MB6683.namprd21.prod.outlook.com:mid]
X-Rspamd-Queue-Id: A88553F403C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Ruijie Li <ruijieli51@gmail.com>
>=20
> If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
> auxiliary_device_uninit(adev).
>=20
> The auxiliary device has its release callback set to adev_release(), whic=
h frees
> the containing struct mana_adev. Since adev is embedded in struct mana_ad=
ev,
> the subsequent fall-through to init_fail and access to adev->id may resul=
t in a
> use-after-free.
>=20
> Fix this by saving the allocated auxiliary device id in a local variable =
before
> calling auxiliary_device_add(), and use that saved id in the cleanup path=
 after
> auxiliary_device_uninit().
>=20
> Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
> Cc: <stable@kernel.org>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Yuqi Xu<xuyuqiabc@gmail.com>
> Signed-off-by: LI Ruijie <ruijieli51@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>

This has been fixed in this earlier commit:
https://lore.kernel.org/all/20260323165730.945365-1-lgs201920130244@gmail.c=
om/

Thanks for helping

Long

>=20
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9017e806ecda..dca62fb9a3a9 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3425,6 +3425,7 @@ static int add_adev(struct gdma_dev *gd, const char
> *name)
>         struct auxiliary_device *adev;
>         struct mana_adev *madev;
>         int ret;
> +       int id;
>=20
>         madev =3D kzalloc_obj(*madev);
>         if (!madev)
> @@ -3434,7 +3435,8 @@ static int add_adev(struct gdma_dev *gd, const char
> *name)
>         ret =3D mana_adev_idx_alloc();
>         if (ret < 0)
>                 goto idx_fail;
> -       adev->id =3D ret;
> +       id =3D ret;
> +       adev->id =3D id;
>=20
>         adev->name =3D name;
>         adev->dev.parent =3D gd->gdma_context->dev; @@ -3460,7 +3462,7 @@
> static int add_adev(struct gdma_dev *gd, const char *name)
>         auxiliary_device_uninit(adev);
>=20
>  init_fail:
> -       mana_adev_idx_free(adev->id);
> +       mana_adev_idx_free(id);
>=20
>  idx_fail:
>         kfree(madev);
> --


