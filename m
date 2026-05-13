Return-Path: <netdev+bounces-287542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN/BOTxeBGqiHQIAu9opvQ
	(envelope-from <netdev+bounces-287542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:19:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E7532104
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E42730A0EAD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0359339A074;
	Wed, 13 May 2026 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LoL6I7uf"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021075.outbound.protection.outlook.com [52.101.70.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7120389E07;
	Wed, 13 May 2026 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671108; cv=fail; b=EtjULUR/58iFB3eTU2/01SJ7eW2amF5ZWBEdoZRVJ4iOKHrkngto1ODAU+CnON2gWHQB9cxMwytsqtwgHcjsQEn8rKV5ks5IapIts0oBJcS/LYjodjEsLJrkQFM+bQ38eOHxkL9LrwsxrfaGo2UF9/9X6vcwH6QvgrVbQ/GNMPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671108; c=relaxed/simple;
	bh=87CYnuTuQuwZKrXGFjIKWjXEUHpNxZHZlRddQawlOtU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lhRJpE0sRvO21gmVYBVefuFxpD0iCZNIo0jvD/zDTuoO2Iv5w/poHrAaIruUUun0iYZe1C8l6GejNApCNHk4jDcL58l2KuWTS5m9a2YsZ+1nN5Lgr+st4x6n7LrecGz1G+E3FYltsyQluSDuekwo00wIiRLw+pT+OJ0h5m0nYoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=LoL6I7uf; arc=fail smtp.client-ip=52.101.70.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VptB99e+q5ki/CsCqTKNGLFLxAYdi2MXABcPq8Ro22gf0JeJRRQIGHnqelK7eakAorSNoQ8p1dzJcw64W3KbUlGbwXYirXmmcdikBw6pyCZCRG6o/TKin27HgVVFtjuq5RbXTYFz/kZocLc8TO1dNzMyyT+XogUYrIEaO3uLKvoYeWdavpNWUA0073sJZlpti0pk5gOGEIAJ3BFaWra51jof5oN06thHu7SGfn+Z9LkmoET3WOVjG3H73DfJlIzo3sJgWb1KXMKHbfRhNhHSk27883UxdnT+KDgoCNCIeSHjp+YStCYJYXTf027HeAPAJIUaSXKhH1AEpSrRM3cUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87CYnuTuQuwZKrXGFjIKWjXEUHpNxZHZlRddQawlOtU=;
 b=kDjHfsrcLktYxrvOPq12n2mmNGrjmtS04rrsbMBtDlCCE8tkmE/Mzy0acZ+o+Qce4pvkypJ1pwo8jeJRnVva3aPSw/bmn34Q3Mzsba+X1Kw4/pySt3eqIYDK5vC/VOsp7ERLeWKVVFAu80hlmTWQeSFsj0rBVCs3cC8oGQu/1NkI6mcN3ZsFvB8/dfdpdy6Sxcf60Ma5mD2dMgy4UVfyKFMJ6he6eth0+obBhsie8vV8VDKWF1fnWLcl8da0zjm1BMQ+/UUJ8DfNBfJJuPT5DZdYSXlaIjyjtmQ3qfgYvVo1Qt9FCLl4oCOwwqG/SErwtv1Lzd/0XL3yXVuzXIxr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87CYnuTuQuwZKrXGFjIKWjXEUHpNxZHZlRddQawlOtU=;
 b=LoL6I7ufeOCzXUoQ0UmZj+raih7IZHo/1YvU8cJXiwL0dsNdFtAuYIvs6kQc5dqyjzxevVx2+4XKTw/zprAjquaI1r/dI1OJ/hSS8yrT8ZxYfZfVeSg68P+IaPJoCI0DM4bS9pe5Rb6uazBMMNzm1usWiUsqaVRdKxj1tUchpDZRahXGe3Pm/GfB5OeqGlQrompgZ3kE6tauLSxSltkswx1DWnOF5wXJ3v0zpSGQOwXAVx296VFGYoOqsbRIaNENxI8Eoj/7ewYIuJfFfdlkWmd+1OTwgjFuN7JG7K0BOJrtl7NOIcqPBL6Ml3LbEfEqGvjmZl14oTNKGi3idPi+Gw==
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 (2603:10a6:800:204::20) by AS2PR08MB9593.eurprd08.prod.outlook.com
 (2603:10a6:20b:60b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 11:18:20 +0000
Received: from VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774]) by VI0PR08MB10828.eurprd08.prod.outlook.com
 ([fe80::2a8a:fe48:6ba2:f774%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 11:18:19 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "sgarzare@redhat.com" <sgarzare@redhat.com>
CC: "den@openvz.org" <den@openvz.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when guest
 isn't ready
Thread-Topic: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Thread-Index: AQHc4VZbvXFbdjip3UaqAROOt5MiVbYI+teAgAF6vACAABLhAIABSUUA
Date: Wed, 13 May 2026 11:18:19 +0000
Message-ID: <ca028fde24e6548274ef8e2aaa364dd725b51b91.camel@virtuozzo.com>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
	 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
	 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
	 <agM8cxqUCJNjBDlm@sgarzare-redhat>
In-Reply-To: <agM8cxqUCJNjBDlm@sgarzare-redhat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR08MB10828:EE_|AS2PR08MB9593:EE_
x-ms-office365-filtering-correlation-id: 124c90f9-017e-4079-9a65-08deb0e15669
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 jxtUsab283s8rga+e3wKlZ/5NNlL/KUqjWnKhKkTaWssVBhxibmAHKlpkzl71IrFJbowPWZfmTyZ3rQCjkKN2S8JlkTKdM78UphvA9bls9eSNciXFtHe/YQO9nRsCIYnE3pmNwxG7GGn+t9EDIOy6jWo2DAPOOUHLgqmCk7jxAA1fLTfHngPo6lr5baHum+ZUKKqLpVtaJP7V/DTNU2wcY4pBhtyZpblTx87MsbF+NzCmMbSLOSU8ZGLM/KvWtnOjL5W1Nshunmh5Vs9045VrXGRvPF3rmiISbYgiGZLsR9D46Hdo5ENRqV60rPab0bV1EFQkbXN4w9umzq+S/D+ps0svp2/GxAmpJeSSCp/wcrG5vQtt3nV0JoCGcRM7XGznlHuRZ3bgEvTFOaBWaw09EtR04I2ge7WHeZVS3eejk+fzZwEJrLjpg58cBsJo4XToi6nomvnkGb2PUiY4OPPJ6e7h6tzPcry9nMIcQwtKYtPEGxBmmgbljfD7c5rtV99pK5vDvJVnEUmuCD7pcd1Jfu9QOwgBuiZ/DBF7SO4ZyXR298kkniV9I6UJgpkZLEfNRNrIhxIuu9Y+UiA1Dkoa4kPZnQZlRpWz0tHt93r4dS9zBJqcuKbAEEuLg4IicLXsfkWTaFTflCK0MLMHGwnjSlRn8bwZ0CAhXkz+pSiKcB+j3Fg7Z9Iji0lRd9fYkMJFoj2VjyjbO6Zvut4kqd/vJRMGPTqJcjntJQ36dtZ2/s2EeSpit8usl3QQIDupOsr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10828.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2Qvb05SZVpNUWFtY3lSa1NrTkpoNHp4My9mUTNKaGhnMmM1SDBabzhobUZu?=
 =?utf-8?B?QTR5Q1BPVUJBRzlMZ1czTjhiSmZldWNpSWxTUFM2V2YwREhiSFhkdXk1eWlB?=
 =?utf-8?B?YUt6NFJyK3JabGIrZzFqR2sxQ1VDQVl6SThrV29RK1hHd1ZHUmtDdzNGbUpG?=
 =?utf-8?B?REgvMWhHdnlzU2dMd2RTUHZoRm4rblF2QVRDUmI3cjRwZVhjcDdNcGNySTI4?=
 =?utf-8?B?RXh3Vi9GRlk3L1ZQMXZPdWdadUJJekNKV1RtbUxER29OZW5WOE9hYUZXM253?=
 =?utf-8?B?N1RCdjl1aFVJWFNGNGhWZ0VKV2ZDSStTdVoxRllIWTdDN1U3NW1oa3ljeTFu?=
 =?utf-8?B?TW82ejJLa2lndGlQaXQzQmR5d2srYmMzekxESFdlRTVGK0cyYjkrNWx0N1Ns?=
 =?utf-8?B?N0w1ejZWMmYrUjBlazRiYUF5TnZnNlRXOU41SFN1QzZIRGNtS0hTOW9Ccjd6?=
 =?utf-8?B?ZDRwTVExSUFaN2pNUDc4YUFGV3NlejdQVlRydkp2QlpIRlNlNlNDVUxVZS9H?=
 =?utf-8?B?Vkx0bDVrK29mZE9DL0xicmw0dzljVUh5Q3Fjc0VFbFA3QUZqOTcvQzF6WUdt?=
 =?utf-8?B?dnBnTno3NlFVbDBWUUhtemlaNnVBZC9mZE9ycFRrN2N1RFZNWHg4VUlTWUFE?=
 =?utf-8?B?cm1sRUlEVFE2RFg0REFQYlpaNEZHWEhzQ0M3aDRCalJWdEVicjlZbW1qMzhG?=
 =?utf-8?B?Y1ZIMlBzOGRLTEpLa09YRkViZnhRZ2dMeFM5azhCK2hZRFppZ2FENURVTFNm?=
 =?utf-8?B?c2ZHWWllVnh2UW9qMmdrQlEwRnFiS3doakNPWE9mTzl2eGdHZGdibG43c0or?=
 =?utf-8?B?WHFUblNub0hIa295UnF6ZHJ1eERTd2wvSkpZdkNwenRONjBMRTBNK08wSmdx?=
 =?utf-8?B?WHJJUXBIM2NxR2QwV1hSRVB0cDZPQVJDampqcXFFcmRRR2NUUW0rRndFNVJp?=
 =?utf-8?B?RWRMbHZoeUdrVlJGVVRuN2JRT2d4WnBLbDE1SEUzT3RCMXB5N3dsSG9xWXlR?=
 =?utf-8?B?UHpFQkRvMVVvdldMVU0vMXVKNStpMFNSV1JQeGg1L0NoTGRycStvUUIwemVq?=
 =?utf-8?B?engvR1FuK1dZV3A1MkJSbm1KZ1dhb21vK1BIQnhOTXAvVFBWTEorYjZRZ2dx?=
 =?utf-8?B?SzAyM0ovYUc4S25FYm9uTVRLZ1JsRkNYUXRqalpqZDduUFk4WjJYUGxXNHlx?=
 =?utf-8?B?ZStGb0FhdTJRbU9pT293QnoyUnliMitRMVpvK1dMdGk5a3BzS2ZzVFltOVlQ?=
 =?utf-8?B?U0xVcGMyMFR0bnR3SXJmYy9CS2NQcmNFdS9jTjYwdDIvNVR3bzNpUkR1K0x3?=
 =?utf-8?B?Zk0rR29qcUFjY0E3ZkN5VG5MM1JLN3BFek5ENUF0SGFzSzZzRTg2RTd0ZjNs?=
 =?utf-8?B?NFViQ3ZZMit0RmY0aGlsYUp6RUhrbEVTa2I3akNEalF2Y3psajNLYzJnR3dU?=
 =?utf-8?B?cFFmVDhIakRwdUE4K2YzRWxWZVQxOEFLYUkvZTlRUGZpMTRid2dVSkVKR3JJ?=
 =?utf-8?B?R1lJdGNnRi91ZTlSN0tHMEJuT0ExL1JEWTE5Y1ZEUmx5SWJyT2padWs3VFlp?=
 =?utf-8?B?bkQ4cXFSU1JCSlFBVjJFQXBEaFJFK082SG1ZNHlNSGxSNnAzaE9jU0hvQWpX?=
 =?utf-8?B?WlBlblRrc3pyWmhTeklzdG8yVTI4aTAyKzNLTTVoR1E1czBZVnR0dzMzUGtn?=
 =?utf-8?B?bm1Rbk5LVXpZd0FNUGk5V094ZTF6YWRXWmhwOUdWMjE1MlhFQ2gyWTFxNGFt?=
 =?utf-8?B?MkI2T2d2RWUrV3JBa28vSUJrOER0V3pnUVJOSE53YjBnZFp0cVRhK2ZtM1I4?=
 =?utf-8?B?U1JwVzdjWnovTVZiczJYYnliSVpxMElFK1dJamUwa3FOYVhieWZhTVNDZGdQ?=
 =?utf-8?B?L24wWjB1Nkp4ZUVMOEJyOU9xSXdNT0duaUUxbnlST1Bzb3dKRGxYT3BzblVD?=
 =?utf-8?B?cDZ1ajJsdUZLeUxoTmdlL05uaGxqWDZpQjBQVzdSaFZoQjhySHBVUUdKc0ZD?=
 =?utf-8?B?QVBxaWZ6ZHNOeGNxWUxDdzdnL25GYjVYRUhtZTdaQW9nWVFnd0YzZS9OODNa?=
 =?utf-8?B?eXFDSkUyWUtrV1Y4QnlIRFYwSDU4M2IwbGpmam8rZ3Y4a0lBdnI3UzNFSGl0?=
 =?utf-8?B?QWZFa2JJVDloRmdmSHVJaHJva0xFRUZyd1BCc1BSVlZZWWVJS2VRMjF5VmRn?=
 =?utf-8?B?RTVWOWpxUEFwRVk1THRUdzMrV2FjZmdBWlRsZlBMVDJIVUFxK1ovdVFIVkky?=
 =?utf-8?B?NzZNUk5nbmxjSVh2M25HRVlpN2l5c0YyMjAraVNLam1zN0xSWEhaaG8zUG1C?=
 =?utf-8?B?Vmc3eXQ3SVVwWEt1cXlLNTF3UGhJWmdTUlVnU0RkcW5LY1FGTWxSVWxzZGZy?=
 =?utf-8?Q?DlbqWardpIuxRgks=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <046BB572736D0241B4CEC4976A61B9AA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10828.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124c90f9-017e-4079-9a65-08deb0e15669
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 11:18:19.6940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IfWYh+zPFxzMLXGD+ythKA4aS7HNMc2Oimv7hRyslXVJW9ot4htiBRwyvleBjndKZvbAKMKJWVX+YMrliueCks5Bx/eLbqsC2snQrpCRZxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9593
X-Rspamd-Queue-Id: 4F3E7532104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[virtuozzo.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[virtuozzo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287542-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[virtuozzo.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[polina.vishneva@virtuozzo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,virtuozzo.com:email,virtuozzo.com:mid,virtuozzo.com:dkim]
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDE3OjM5ICswMjAwLCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6DQo+IE9uIFR1ZSwgTWF5IDEyLCAyMDI2IGF0IDAyOjMyOjE0UE0gKzAwMDAsIFBvbGluYSBW
aXNobmV2YSB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjYtMDUtMTEgYXQgMTc6NTYgKzAyMDAsIFN0
ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgTWF5IDExLCAyMDI2IGF0IDA0
OjU2OjEwUE0gKzAyMDAsIFBvbGluYSBWaXNobmV2YSB3cm90ZToNCj4gPiA+ID4gRnJvbTogIkRl
bmlzIFYuIEx1bmV2IiA8ZGVuQG9wZW52ei5vcmc+DQo+ID4gPiA+IA0KPiA+ID4gPiBXaGVuIHRo
ZSBob3N0IGluaXRpYXRlcyBhbiBBRl9WU09DSyBjb25uZWN0KCkgdG8gYSBndWVzdCB0aGF0IGhh
cyBub3QNCj4gPiA+ID4geWV0IGxvYWRlZCB0aGUgdmlydGlvLXZzb2NrIHRyYW5zcG9ydCAoaS5l
LiBzdGlsbCBib290aW5nKSwgdGhlIGNhbGxlcg0KPiA+ID4gPiBibG9ja3MgZm9yIFZTT0NLX0RF
RkFVTFRfQ09OTkVDVF9USU1FT1VUICgyIHNlY29uZHMpLCBiZWNhdXNlDQo+ID4gPiA+IHZob3N0
X3RyYW5zcG9ydF9kb19zZW5kX3BrdCgpIHNpbGVudGx5IGV4aXRzIHdoZW4NCj4gPiA+ID4gdmhv
c3RfdnFfZ2V0X2JhY2tlbmQodnEpIHJldHVybnMgTlVMTC4NCj4gPiA+IA0KPiA+ID4gQ2FuIFNP
X1ZNX1NPQ0tFVFNfQ09OTkVDVF9USU1FT1VUIGhlbHBzIG9uIHRoaXM/DQo+ID4gDQo+ID4gSXQg
Y2FuLCBidXQgaXQgbWlnaHQgYmUgZGlmZmljdWx0IHRvIGZpbmQgYSBjb3JyZWN0IHRpbWVvdXQu
DQo+ID4gDQo+ID4gQW5kLCBnZW5lcmFsbHksIHRoZXJlJ3Mgbm8gd2F5IHRvIGRpc3Rpbmd1aXNo
ICJ0aGUgZ3Vlc3QgaGFzbid0IHlldCBpbml0aWFsaXplZA0KPiA+IHRoZSB2cSIgZnJvbSAidGhl
IGd1ZXN0IGlzIHVwIGFuZCBydW5uaW5nLCBidXQgZGlkbid0IHJlcGx5IHRvIGNvbm5lY3QoKSBp
bg0KPiA+IHRpbWUiLiBUaGF0J3MgZXhhY3RseSB3aGF0IHRoaXMgcGF0Y2ggaXMgYXR0ZW1wdGlu
ZyB0byBmaXguDQo+IA0KPiBPa2F5LCBzbyBwbGVhc2UgbWVudGlvbiB0aGlzIGluIHRoZSBjb21t
aXQgbWVzc2FnZSwgSSBtZWFuIHdoeSANCj4gU09fVk1fU09DS0VUU19DT05ORUNUX1RJTUVPVVQg
Y2FuJ3QgcmVhbGx5IGhlbHAuDQoNCldpbGwgZG8uDQoNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IElmIHRoZSBndWVzdCBkb2Vzbid0IHN0YXJ0IGxpc3RlbmluZyB3aXRoaW4g
dGhpcyB0aW1lb3V0LCBjb25uZWN0KCkNCj4gPiA+ID4gcmV0dXJucyBFVElNRURPVVQuDQo+ID4g
PiA+IA0KPiA+ID4gPiBUaGlzIGRlbGF5IGlzIHVzdWFsbHkgcG9pbnRsZXNzIGFuZCBpdCBkb2Vz
bid0IHdlbGwgYWxpZ24gd2l0aCBvdXINCj4gDQo+IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkgdGhpcyBpcyBwb2ludGxlc3MuIElmIGFuIGFwcGxpY2F0aW9uIHdhbnRzIA0KPiB0byB3YWl0
IHdoaWxlIHNsZWVwaW5nLCBpdCBjYW4gc2ltcGx5IGluY3JlYXNlIHRoZSB0aW1lb3V0IGxvbmcg
ZW5vdWdoIA0KPiB0byB3YWl0IGZvciB0aGUgVk0gdG8gc3RhcnQgdXAgYW5kIHVzZSBhIHNpbmds
ZSBgY29ubmVjdCgpYCBjYWxsLCANCj4gaW5zdGVhZCBvZiBjb250aW51aW5nIHRvIHRyeSBhbmQg
d2FzdGluZyBDUFUgY3ljbGVzIHVubmVjZXNzYXJpbHkuDQo+IA0KPiBIbW0sIG9yIG1heWJlIG5v
dCwgYmVjYXVzZSB0aGUgZHJpdmVyIHdpbGwgZGVmaW5pdGVseSBiZSBpbml0aWFsaXplZCANCj4g
YmVmb3JlIHRoZSBhcHBsaWNhdGlvbiB0aGF0IHdhbnRzIHRvIGxpc3RlbiBvbiB0aGF0IHBvcnQs
IHNvIGl0IHdpbGwgDQo+IHJlc3BvbmQgdGhhdCBubyBvbmUgaXMgbGlzdGVuaW5nLCBhbmQgdGhl
IGBjb25uZWN0KClgIGNhbGwgd2lsbCBmYWlsIA0KPiB3aXRoIGFuIGBFQ09OTlJFU0VUYCBlcnJv
ciBpbiBhbnkgY2FzZS4gUmlnaHQ/DQoNClRoYXQncyB0aGUgY2FzZSBpbmRlZWQuDQoNCj4gDQo+
IElmIGl0IGlzIHRoZSBjYXNlLCBpcyB0aGUgZm9sbG93aW5nIGxpbmUgaW4gdGhlIGNvbW1pdCBk
ZXNjcmlwdGlvbiANCj4gY29ycmVjdD8NCj4gDQo+ICAgICAgSWYgdGhlIGd1ZXN0IGRvZXNuJ3Qg
c3RhcnQgbGlzdGVuaW5nIHdpdGhpbiB0aGlzIHRpbWVvdXQsIGNvbm5lY3QoKQ0KPiAgICAgIHJl
dHVybnMgRVRJTUVET1VULg0KPiANCj4gSSBtZWFuLCBhbHNvIGlmIHRoZSBhcHBsaWNhdGlvbiBz
dGFydHMgdG8gbGlzdGVuIHdpdGhpbiB0aGUgdGltZW91dCwgSSANCj4gdGhpbmsgdGhlIGNvbm5l
Y3QoKSB3aWxsIGZhaWwgaW4gYW55IGNhc2UgYXMgSSBwb2ludGVkIG91dCBhYm92ZSAodGhpcyAN
Cj4gc2hvdWxkIGJlIGFub3RoZXIgcG9pbnQgaW4gZmF2b3VyIG9mIHRoaXMgY2hhbmdlKQ0KDQpZ
ZXMsIHRoZSBjb21taXQgbWVzc2FnZSBzaG91bGQgYmUgdXBkYXRlZCwgYXMgd2VsbCBhcyB0aGUg
Y29kZSBjb21tZW50Lg0KDQo+IA0KPiANCj4gQlRXLCBJIHRoaW5rIHdlIHNob3VsZCBleHBsYWlu
IHRoaXMgbW9yZSBjbGVhcmx5IGJvdGggaGVyZSBhbmQgYnJpZWZseSANCj4gaW4gdGhlIGNvZGUg
YXMgd2VsbC4NCg0KRGVmaW5pdGVseS4NCg0KPiANCj4gPiA+ID4gYmVoYXZpb3IgYXQgb3RoZXIg
aW5pdGlhbGl6YXRpb24gc3RhZ2VzOiBmb3IgZXhhbXBsZSwgaWYgYSBjb25uZWN0aW9uIGlzDQo+
ID4gPiA+IGF0dGVtcHRlZCB3aGVuIHRoZSBndWVzdCBkcml2ZXIgaXMgYWxyZWFkeSBsb2FkZWQs
IGJ1dCB3aGVuIG5vdGhpbmcgaXMNCj4gPiA+ID4gbGlzdGVuaW5nIHlldCwgaXQgcmV0dXJucyBF
Q09OTlJFU0VUIGltbWVkaWF0ZWx5IHdpdGhvdXQgYW55IHdhaXQuDQo+ID4gPiA+IA0KPiA+ID4g
PiBGaXggdGhpcyBieSBjaGVja2luZyB0aGUgUlggdmlydHF1ZXVlIGJhY2tlbmQgaW4NCj4gPiA+
ID4gdmhvc3RfdHJhbnNwb3J0X3NlbmRfcGt0KCkgYmVmb3JlIHF1ZXVpbmcuIElmIHRoZSBiYWNr
ZW5kIGlzIE5VTEwsDQo+ID4gPiA+IHJldHVybiAtRUNPTk5SRUZVU0VEIGltbWVkaWF0ZWx5Lg0K
PiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGVuaXMgVi4gTHVuZXYgPGRlbkBvcGVu
dnoub3JnPg0KPiA+ID4gPiBDby1kZXZlbG9wZWQtYnk6IFBvbGluYSBWaXNobmV2YSA8cG9saW5h
LnZpc2huZXZhQHZpcnR1b3p6by5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBvbGluYSBW
aXNobmV2YSA8cG9saW5hLnZpc2huZXZhQHZpcnR1b3p6by5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiBkcml2ZXJzL3Zob3N0L3Zzb2NrLmMgfCAxMCArKysrKysrKysrDQo+ID4gPiA+IDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aG9zdC92c29jay5jIGIvZHJpdmVycy92aG9zdC92c29jay5jDQo+ID4gPiA+
IGluZGV4IDFkOGVjNmJlZDUzZS4uYTNmMjE4MjkyYzNhIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL3Zob3N0L3Zzb2NrLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy92aG9zdC92c29jay5j
DQo+ID4gPiA+IEBAIC0zMDIsNiArMzAyLDE2IEBAIHZob3N0X3RyYW5zcG9ydF9zZW5kX3BrdChz
dHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0ICpuZXQpDQo+ID4gPiA+IAkJcmV0dXJuIC1F
Tk9ERVY7DQo+ID4gPiA+IAl9DQo+ID4gPiA+IA0KPiA+ID4gPiArCS8qIEZhc3QtZmFpbCBpZiB0
aGUgZ3Vlc3QgaGFzbid0IGVuYWJsZWQgdGhlIFJYIHZxIHlldC4gUmVhZGluZw0KPiA+ID4gPiAr
CSAqIHByaXZhdGVfZGF0YSB3aXRob3V0IHZxLT5tdXRleCBpcyBkZWxpYmVyYXRlOiBldmVuIGlm
IHRoZSBiYWNrZW5kIGJlY29tZXMNCj4gPiA+ID4gKwkgKiBOVUxMIHJpZ2h0IGFmdGVyIHRoYXQg
Y2hlY2ssIGRvX3NlbmRfcGt0KCkgY2hlY2tzIGl0IHVuZGVyIHRoZSBtdXRleC4NCj4gPiA+ID4g
KwkgKi8NCj4gPiA+ID4gKwlpZiAoIWRhdGFfcmFjZShSRUFEX09OQ0UodnNvY2stPnZxc1tWU09D
S19WUV9SWF0ucHJpdmF0ZV9kYXRhKSkpDQo+ID4gPiANCj4gPiA+IFdoeSBub3QgdXNpbmcgdmhv
c3RfdnFfZ2V0X2JhY2tlbmQoKSA/DQo+ID4gDQo+ID4gQmVjYXVzZSBpdCBsb2NrcyB0aGUgbXV0
ZXgsIHdoaWNoIGlzIHNsb3cgYW5kIHVuYWNjZXB0YWJsZSBpbiB0aGlzIGhvdCANCj4gPiBwYXRo
Lg0KPiANCj4gZWhtLCBzb3JyeSwgd2hpY2ggbXV0ZXggYXJlIHlvdSB0YWxraW5nIGFib3V0Pw0K
PiANCj4gSSBzZWUganVzdCBhIGNvbW1lbnQgYWJvdXQgdGhlIG11dGV4IHRvIGJlIGFjcXVpcmVk
IGJ5IHRoZSBjYWxsZXIsIGJ1dCBJIA0KPiBkb24ndCBzZWUgYW55IGxvY2sgdGhlcmUuDQoNCkFw
cGFyZW50bHkgdGhlIGNvbW1lbnQgaW4gdmhvc3QuaCBzYXlzICJDb250ZXh0OiBOZWVkIHRvIGNh
bGwgd2l0aCB2cS0+bXV0ZXgNCmFjcXVpcmVkLiIsIGJ1dCBJIGd1ZXNzIHdlJ3JlIHNhZmUgdG8g
aWdub3JlIHRoaXMgYW5kIHVzZSBpdCBpbnN0ZWFkIG9mDQphY2Nlc3NpbmcgcHJpdmF0ZV9kYXRh
IG1hbnVhbGx5LCB0aGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0Lg0KDQo+IA0KPiA+IA0KPiA+
ID4gDQo+ID4gPiBBbHNvIGlzIFJFQURfT05DRSgpIG9rYXkgd2l0aG91dCBXUklURV9PTkNFKCkg
d2hlcmUgaXQgaXMgc2V0ID8NCj4gPiANCj4gPiBJdCdzIHJhY3ksIGJ1dCBhcyBkZXNjcmliZWQg
aGVyZSBpbiB0aGUgY29tbWVudCBhbmQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLA0KPiA+IGFueSBw
b3NzaWJsZSByYWNlIG91dGNvbWUgaXMgY292ZXJlZCBieSB0aGUgc3Vic2VxdWVudCBjaGVja3Mu
DQo+IA0KPiBPa2F5LCBzbyB3aGF0IGlzIHRoZSBwb2ludCB0byBjYWxsIFJFQURfT05DRSgpPw0K
DQpQcm9iYWJseSBub25lLCBpdCB3YXMganVzdCB0aGVyZSBpbiB0aGUgaW5pdGlhbCBwYXRjaCB2
ZXJzaW9uLCBhbmQgSSd2ZSBkZWNpZGVkDQpub3QgdG8gZHJvcCBpdCB3aGVuIGFkZGluZyBkYXRh
X3JhY2UoKS4gV2lsbCBkcm9wLg0KDQo+IA0KPiA+IA0KPiA+ID4gPiB7DQo+ID4gPiA+ICsJCXJj
dV9yZWFkX3VubG9jaygpOw0KPiA+ID4gPiArCQlrZnJlZV9za2Ioc2tiKTsNCj4gPiA+ID4gKwkJ
cmV0dXJuIC1FQ09OTlJFRlVTRUQ7DQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgYSBnZW5lcmljIHNl
bmRfcGt0LCBpcyBpdCBva2F5IHRvIHJldHVybiBFQ09OTlJFRlVTRUQgaW4gYW55DQo+ID4gPiBj
YXNlPw0KPiA+IA0KPiA+IEVIT1NUVU5SRUFDSCB3b3VsZCBwcm9iYWJseSBiZSBiZXR0ZXIuDQo+
ID4gQWxsIHRoZSBjdXJyZW50IHNlbmRfcGt0IGZ1bmN0aW9ucyBvbmx5IHJldHVybiBFTk9ERVYs
IGJ1dCBpdCBoYXMgZGlmZmVyZW50DQo+ID4gc2VtYW50aWNzOiB0aGV5IG1lYW4gdGhhdCB0aGUg
bG9jYWwgZGV2aWNlIGlzbid0IHlldCByZWFkeSwgd2hpbGUgdGhlcmUgd2UncmUNCj4gPiBkZWFs
aW5nIHdpdGggdGhlIG9wcG9zaXRlIGVuZCBub3QgYmVpbmcgcmVhZHkuDQo+IA0KPiBJbiB0aGUg
QUZfVlNPQ0sgcHJlc3BlY3RpdmUsIEkgc2VlIEVOT0RFViBsaWtlIHRoZSB0cmFuc3BvcnQgaXMg
bm90IA0KPiByZWFkeSwgc28gSSB0aGluayBpdCBjYW4gZXZlbnR1YWxseSBmaXQgaGVyZSB0b28s
IGJ1dCBhbHNvIEVIT1NUVU5SRUFDSCANCj4gaXMgZmluZSwgZm9yIHN1cmUgYmV0dGVyIHRoYW4g
RUNPTk5SRUZVU0VELg0KDQpFSE9TVFVOUkVBQ0ggaXMgaW5kZWVkIGEgYmV0dGVyIGZpdCwgYWdy
ZWVkLg0KDQo+IA0KPiBUaGFua3MsDQo+IFN0ZWZhbm8NCj4gDQo+ID4gDQo+ID4gQmVzdCByZWdh
cmRzLCBQb2xpbmEuDQo+ID4gDQo+ID4gPiANCj4gPiA+IFRoYW5rcywNCj4gPiA+IFN0ZWZhbm8N
Cj4gPiA+IA0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiAJaWYgKHZpcnRpb192c29j
a19za2JfcmVwbHkoc2tiKSkNCj4gPiA+ID4gCQlhdG9taWNfaW5jKCZ2c29jay0+cXVldWVkX3Jl
cGxpZXMpOw0KPiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IGJhc2UtY29tbWl0OiA4YWI5OTJm
ODE1ZDY3MzZiNWM3YTZmNWZkN2JmZTdiYzEwNmJiM2RjDQo+ID4gPiA+IC0tDQo+ID4gPiA+IDIu
NTMuMA0KPiA+ID4gPiANCg==

