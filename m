Return-Path: <netdev+bounces-227461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F377BB002B
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E673AA370
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55F299A81;
	Wed,  1 Oct 2025 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="A0oT3eK/"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA329E110;
	Wed,  1 Oct 2025 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314496; cv=fail; b=YWvjRiBK5Lokc5JipKKz2Onq+D4VaA+Fx390yKrOlVPBsQ8vAhzidV3/Zy53L4pnVGb08xvjhx4WyN/YPy/+UE6YEKhEzu5ngNKNRaSsSgtONSG2P/iqAOSclMusETOediRN7HDmWYZ3xN8e75vZuKVytDeqRWDyjC3tHlQQyYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314496; c=relaxed/simple;
	bh=TRF19tc3nCTFsi4BKUW3Bm6de3cZg5Q234MrDMLT1qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQYyc9oDyWDJ+PLnIrykyEYWupnhAVDuotueXxEKYkuudtlh4jSqFIrJf8h5SUsbs4NCJoCTQKFOB3yJ2WfQU6GC1Drcl7jnunTA6TgzJ9xP9e+ulXHaMo3ncLqwFGyWbPP5kVzG0Eb9jtZgDdl/c6khFH7OyS8TXvEO0YszgIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=A0oT3eK/; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOPRnjrrApGGTVNY9NhzDV5+fqcqwg4dKLdxgE3K+gP07zCspJNevG2xOqVuf/C/Xl9h0HgPSXBwGq/FnoEEWhUFYc3CE75+Xdavx2Qn0+kWoMzAaCdyGLgSi8BKz5f0BcHHs6bDf3U/aL6Lr8tm6NJ9Fo5nDfmaUzJ/5EniI/b3dg+vqirGJc3c/WS21eje+wZbK+fkOcNHIW9mf7vU91kfBhAceC5LnMWb4P18f88BbzaEeqbOAaNiDgAL1289agEFmmJ9gR+dLFjw3Uiw1/rR4GmM11Xd44yr7p3eQngz31iKDj2QH3Mr4l9dzm7fP1cUhaszHnpWtL/yjHFZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fNKRolXzxsTNulfxfYW3iTW0LaM41/a00kY0wHDGeQ=;
 b=XgzbXjUGv53o4i1DkB67mko6MoCIOsnA6nhyWzVsNIx56UBxQiZQJmDWLwQoy3dAE680YqgIKbk1OJ5VYn8AJiePlSCsa7iFqPFey3KtRQXKQBz1sswZLm5eP8pmyTXBXqkUNtWW1iXuk07FETpKxwX5celTr6Be/OjGn+JTwPt/69mswA7n64znQQcQJ5Lb1ViBuC1jeFV8/xKYS7gFPnSsltu4kxam7c8P7zRXv4yvxZfQCyp54Bhe10iODNNOGXosh76A5Ee5/FXOv1xWPE68OWKYgKaOaWE12CCIpNwavC1pKWEJTqsGKYAH2MqXsgi1vg3s+SIOoN9NQFJR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fNKRolXzxsTNulfxfYW3iTW0LaM41/a00kY0wHDGeQ=;
 b=A0oT3eK/8SG4vM3bh37NoLqbQEZ0dQM02XKceMeSHRPTHmGeQM/GAI2gDGQuVKGSTt8CWpAxWEUdbK7Dm2YfouTfqvu4XyJZ+vPmzHfLq8CRqGbNzKni1U2yYcghC0IXus4SQ+OuYw2DlbwWfNtb3rINE28hOYaMVpVoQ8e9Chra5Qcn0Ypy74qxdX8R7N6hm+KB7+3HN9UP+/8GP9fLN9UwglGNQe6pjAyUW3gyexc9raW/FLFulD9l3dssU2D0Cistm0rEsby1WHcc9ZvncsQzm2yrdCZxNgjVGMU2Y24dE5ZmqCFSPIw3mVyKVV08CijhknehpQrMah9IAL25Iw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV1P189MB2787.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1f0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Wed, 1 Oct 2025 10:28:09 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7%4]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 10:28:09 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
	"linux-kernel-mentees@lists.linuxfoundation.org"
	<linux-kernel-mentees@lists.linuxfoundation.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "david.hunter.linux@gmail.com"
	<david.hunter.linux@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Jon Maloy
	<jmaloy@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH] net: doc: Fix typos in docs
Thread-Topic: [PATCH] net: doc: Fix typos in docs
Thread-Index: AQHcMp5rXqenrtMrRUCifh9z+PayL7StFk7Q
Date: Wed, 1 Oct 2025 10:28:09 +0000
Message-ID:
 <GV1P189MB198840D92F47A423791FF803C6E6A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20251001064102.42296-1-bhanuseshukumar@gmail.com>
In-Reply-To: <20251001064102.42296-1-bhanuseshukumar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV1P189MB2787:EE_
x-ms-office365-filtering-correlation-id: 68d862e9-1fcd-46d1-5b60-08de00d5379b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b5Z5y8l6cOJb32p2RAjNZputTRNdMBF2/UQgyYu0wNynWuMIV/S9eQTZVwWn?=
 =?us-ascii?Q?mFTja63K3LFnX2D6f8IvtALjl88VqcRDeOzHR6fXWJJWj9+0np7lfaTAJcCZ?=
 =?us-ascii?Q?Vx8Bk0OxYxkJZfSi4z6gii5yj71sSndmkzY51CwckQqRVArBbSB8wWyAb8CM?=
 =?us-ascii?Q?o7VP1CPawo6ZYneAm0/DrQ3xNt+V//Glk1274sDm30jYSXr9KJbRwq2R05BU?=
 =?us-ascii?Q?vOIU80EuKozkseaKHfdz9e4u1+9efask2Th5b5eSOt6A/SasvJLSYcN3EAmh?=
 =?us-ascii?Q?imABNFFKjSC45Ul2gEu1OBnfn8JYKsve2yj2bB5FTA0oG9JrvYVn57x5lbwH?=
 =?us-ascii?Q?+SKSddrSbnAVkpNLTzFmT76ebE6dSr4vnawVKP8YNxIRC+9G6HyVjWS60Ov7?=
 =?us-ascii?Q?2zZXXs8dY+Cxxy9ddDnsJ3JshOAglyfzbahbOy8X7iuhQ6gp49NYiMQOp41v?=
 =?us-ascii?Q?J4WAlIq0vV1vfNuAnZYHDsB/BWt4vFQ9zHa/hhC9+uajkax9NLIYSwYcAaIj?=
 =?us-ascii?Q?2k6E+o4T8OZYCng/Lw8yxY/E2Ae1pUj85ISgi0gghz68wentik+iXGhMRjiA?=
 =?us-ascii?Q?yOoB7ME4LbGiZloaDI+Qm18ngWDttXviuAWmSJKq/2vbt+iYeajxbPypTo4m?=
 =?us-ascii?Q?tajGephbgnJjclQOsgslArTSBRa77bVZCA6JHXk2DALarUH3Y7zN4L1oVpkI?=
 =?us-ascii?Q?IJSITLkeEB8TXZ92edXYEsCNmQEe3dZ43UWvDwlWkKJ+A3QlqGqGCHzz6agu?=
 =?us-ascii?Q?3e0utg+KC7vJjhxHUpLQ9cvF+3+zwh+XnokSKJ5yLwOze1UyqKKpEd2+5uns?=
 =?us-ascii?Q?EdrTIu0Snr3e1jqugUoNor0rGhj111Bg5NqtyEWW1ExTb6xyR0yRPZPspHgt?=
 =?us-ascii?Q?pVO37jG2itTuvxhpkdrVLK07dQC+eJh094+W7bX9v4wSrYL/zm4r13Xh3oeK?=
 =?us-ascii?Q?puplsDyfgnMYYe+PyU5lrJ+tQfV0OZ+vTmXIn7XaMDMUAEHXJYfwgm+FFedE?=
 =?us-ascii?Q?HNSw2TIe98ldPbj8auXrKL/lQSu/TylnCKtI6KooXLO6B85AwXnNoLPLADAS?=
 =?us-ascii?Q?+QSDqzEmFGVALHKCkZQ5Ls+uPZdlMh4laukFxqejAhHrLGZ4r9fG2ilM+cT8?=
 =?us-ascii?Q?qvdSIScQfyRFgDeT5V8Gn9vOdXJ1oaBJngbzRCAZyyvXbLQORl+FD/Je62aZ?=
 =?us-ascii?Q?hhupgaYvFYJLwzNMGojTfIFXJvojtUpcNC6Pt6Yo7iqRaqZ7UymiihwJOVHI?=
 =?us-ascii?Q?2Eww1z4OSZOkN6PMr+bGoL4n8pzn+7VauzLmV/euvHd4rn7toQpvb5lQtdSs?=
 =?us-ascii?Q?t2CxdcF1zLLCZtQiJJmK4AFUFgATAW6EWai1NOCBu8WTHVFDbbkJoU3rpkQg?=
 =?us-ascii?Q?ckOpQTBDv9z6mu5Gt/M4kLd/ANznEKNRL1iMnXJ2Wy47+J2tn6kW6qFL+ypv?=
 =?us-ascii?Q?Tzc4k2SorajzZePqa4ehgX3bFS7r8PsD4DIbp1yedzkoQKb4nTPPPncenp58?=
 =?us-ascii?Q?EmKqzhMRr9GBV/VBmA8HONsHJKiyhuTaTI1r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lsF9ALLdkK6kT+JBEUU+kKUA/7tnf5IkQxCfnVqEPyZVsHv8VDoT8hx9u/sK?=
 =?us-ascii?Q?eRynPANa7Iy8GLdQH4d/CpMmAdYyGaclRkFxLgBFx95n+mvt27DshWDG9z0V?=
 =?us-ascii?Q?B+LJFzRRsp0LEk97/36mTBPBFZh7gYraj7+/oPuHcyFXBDI1vRBcTueYkm0i?=
 =?us-ascii?Q?58oLU5LXhFprznVHb9Ijmo6TKal9gDrg/ZNadnI3Us1+OgLonhczcvIbRWXx?=
 =?us-ascii?Q?ydQMJBpLO8ltCgFf3l3SjWeAKjZvzV6FT6jI4du+FqnCjyHqC9Ra5RbOy1Hw?=
 =?us-ascii?Q?3XS9Dj+4lpK/xfxUL5Pp2kDFgGddn+JTb1UhbdY+2eAIVAIyUqIjDGR82ZfA?=
 =?us-ascii?Q?cyvw8K2KBpDLMcNSPGXHgpfh451k/wM0xCtEgXheGgenqcwjr7zkhTY5Pl05?=
 =?us-ascii?Q?4JbcwlILJmvGKkjvR6Lnfneb+N0QYo8QzGg61P9wPu/0vvo0c9Kpojb9beRC?=
 =?us-ascii?Q?7AqsjFCGNADMRLKsn4s6h056M75VTNjptN7JIr9Yz6yiXK8eyv8tUKk3Ejbh?=
 =?us-ascii?Q?PYMBu9F99LjY4MBzZBH1JTqwlCX9wcUe75hfZy6nsY8oSFDpPzY4JsbiZ+cV?=
 =?us-ascii?Q?90bFt9GfjYile2uHxFnzwJeeb7qHIqkYBhKxMBV1cZQ2kHppcWLzYgLAGQVE?=
 =?us-ascii?Q?SnSdwb2sEJ3dRNI/26kMRQZ0qmsYDrIGMTqmLfOb/ys39TF4OSKlIJstxHle?=
 =?us-ascii?Q?2DaZ6YevUv7oX82tGJ7S1VzT3WwZ7Cd1w3uEaX4MxfACqQovA3GNAh396lC+?=
 =?us-ascii?Q?XX6PZEtwCob8PL0Da1oDb5A5rQ5aW10GChgsWc79G7FML9XmPnifcH40l7in?=
 =?us-ascii?Q?ZW4rWE9sDh/BfsNPpi4hCCr8dEXA/lNGWYDAWzKpixifMTHkkzdRxyL7Ihes?=
 =?us-ascii?Q?8cXZjeqrpdeJ2aWCfsOCafg7pR2nWOg+YmDpQUi9EzGEfRMFrEdbsJnSYtX1?=
 =?us-ascii?Q?3pgGWeBCS5eKcqmWOhLbk8VzsyIht6WwSeCqqWutRt0oaEGN2kbXfXawIItA?=
 =?us-ascii?Q?4ki0htKA51i1U199/E3oZ0OYPqbWZPxz6UkMPk36oSF/GC8gMFxZ7tW7Yvz+?=
 =?us-ascii?Q?uCxF7rXsxHHjCZQQCO3t0bU45lZwRLC28KkgSYyK0CYAKICgJ671bdPHXnG8?=
 =?us-ascii?Q?9d8xw1o4MUhj6SPVojXxC/mgsFuJND06mgkhtJWZv0ghICIzdA+pnhUQ1N9U?=
 =?us-ascii?Q?9m60I+rHHt0xDjjTWS/rTAR9c6eGf8+AuEyCfVZN1oAssqvmE5DYlGIhUqKG?=
 =?us-ascii?Q?nBVNvo9V33YekIY/DrDCNHm6NkzUI4UkzCPl2c6LH/MBGEIy/6MgDjTBOo1Z?=
 =?us-ascii?Q?MqQd5Se95TmceWjHQVNErQmNRwf9MAcEjX5KaChCZMskZnnfdSLCUw8Y9Bgc?=
 =?us-ascii?Q?npUxmvhZ7Uw8MVQeWCJF3iedBsObHI6HT0Ic5exYISWmi1tqPn2JhxckyJY0?=
 =?us-ascii?Q?d5uxM2KHYm1vRmXZomuoUKddMEvwU/qD9q2yP/pmh37FD19kGTJWb1HqdwRz?=
 =?us-ascii?Q?6nDSV5r7RWlajTr8yxgZUO0OxufXjmX+9g84BNtrJJSJMUz6T2R7URn0FzbO?=
 =?us-ascii?Q?KifKYRNm6JegDuDwwHJsCzRLfyy0xP/hqx88X+22?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d862e9-1fcd-46d1-5b60-08de00d5379b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 10:28:09.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +S8eqhWarMQMlBTjF3Ku/ZOayq5G4loqEmvNJPXtvPvZ6yLJLNoTJKEQoSn64i0vSdzEsYu4GVKwcypJBFQc9UXTCATGPjOPzt61193dkbI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2787

>Subject: [PATCH] net: doc: Fix typos in docs
>
>Fix typos in doc comments.
>
>Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
>---
> include/linux/phy.h | 4 ++--
> net/tipc/crypto.c   | 2 +-
> net/tipc/topsrv.c   | 4 ++--
> 3 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>ea5bb131ebd0..751904f10aab 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -1797,7 +1797,7 @@ int tipc_crypto_xmit(struct net *net, struct sk_buff
>**skb,
>  * @b: bearer where the message has been received
>  *
>  * If the decryption is successful, the decrypted skb is returned directl=
y or
>- * as the callback, the encryption header and auth tag will be trimed out
>+ * as the callback, the encryption header and auth tag will be trimmed
>+ out
>  * before forwarding to tipc_rcv() via the tipc_crypto_rcv_complete().
>  * Otherwise, the skb will be freed!
>  * Note: RX key(s) can be re-aligned, or in case of no key suitable, TX d=
iff --git
>a/net/tipc/topsrv.c b/net/tipc/topsrv.c index ffe577bf6b51..ebe993ebcd48
>100644
>--- a/net/tipc/topsrv.c
>+++ b/net/tipc/topsrv.c
>@@ -57,7 +57,7 @@
>  * @conn_idr: identifier set of connection
>  * @idr_lock: protect the connection identifier set
>  * @idr_in_use: amount of allocated identifier entry
>- * @net: network namspace instance
>+ * @net: network namespace instance
>  * @awork: accept work item
>  * @rcv_wq: receive workqueue
>  * @send_wq: send workqueue
>@@ -83,7 +83,7 @@ struct tipc_topsrv {
>  * @sock: socket handler associated with connection
>  * @flags: indicates connection state
>  * @server: pointer to connected server
>- * @sub_list: lsit to all pertaing subscriptions
>+ * @sub_list: list to all pertaing subscriptions
Replace "pertaing" with "pertaining"

>  * @sub_lock: lock protecting the subscription list
>  * @rwork: receive work item
>  * @outqueue: pointer to first outbound message in queue
>--
>2.34.1
>


