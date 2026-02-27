Return-Path: <netdev+bounces-261788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEIDOaZnoWkUsgQAu9opvQ
	(envelope-from <netdev+bounces-261788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:45:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3381B5826
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B27CA300BE86
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD173D1CD7;
	Fri, 27 Feb 2026 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b="ZEXE3aq+"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023075.outbound.protection.outlook.com [52.101.83.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B253B9605;
	Fri, 27 Feb 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772185501; cv=fail; b=cKiMpIiUc56ikjEe/WuuV+PiceJzSOy6TV8zJ8Zcf3ztqMEq3fAlURZBh3/sWY0i92aPk2GCyhaqHD1MQPZ5g4Vn7ACi9npLSm1pq0ezuH+YdRUzNHvCaWrTS7YvLw3efr58tMk2X0nCGddyqY1D7dvvOwV9wQbiBs3CVplRm5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772185501; c=relaxed/simple;
	bh=ou10EaKuLhOdIOYOms2dbfXcedSXXsQmqX6fW+tkwjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gHYJUJtaxPYqDt4E+ZSNMrJ4hUfoVgwgZ5ikOALpXp08gWXsnZziM1kJMSa0Fg2bI9RQ94E9s1Ob8HX1Ufmo9AP9L8IRyEtDtAC8v4mx4ZgmrPtjLQFRRp+w0h2XWRcX77V6mUoP4A0UmAEvcjKdtpgdq5D+uKLuWz6waLCoAlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be; spf=pass smtp.mailfrom=luminex.be; dkim=pass (1024-bit key) header.d=luminex.be header.i=@luminex.be header.b=ZEXE3aq+; arc=fail smtp.client-ip=52.101.83.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luminex.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luminex.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pyw03JSBDBhyYnzSarVh44HBW3eZ+3Eo20t/sM5MCzFiiKgMpRV7BF+ueYdf8OpEny2jlNF1eJENBY+rcgmkwC9lD1Oq7avBACx2x5/LeBIrDecZ2OQp2YFYmL2v8JV4IyRrUCVf41z3znwftueW4leya/fAmWmttyqzI21Zq9fa6EsoZ9AiFaNi8EyEAquOO7JbxJ2xFkokW7Tk1mZQMQfcdB4sg+y49yRDfQeUm8ZUNJltuWJCfDbw7hye834bue2kfim/5x5ybeTaSItTLUB0gBr8Np/Z4MxY1OKjmtXRtTiAG1LurQ+R623RnoZJwHzjNwn1cM1cwA6sK9cEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiF7dplOWql3qOdzO5XZCxkve5s6bAt9NUa8HDl7DxE=;
 b=yViESFqXwUFOXAY1oMR10Xth4iPzh8JkmOvQ4kVNGOhipFbKv1FgqjAXvhYRXfzUo9W5QwC+ZKLWETdNjbfKlmG5yoTnyJRFhIYA/Vry7AgW+PDMlab+vAOlETGqpxoteLoVX1jbGISuHzNqUsFL72EqxKWbCjnAXibvuhh6azvmKGd4WItiQhWqAlvRwHLiB/18iMtqtV4j7PwMpVH9eMNf7ugbrCrMIbsWOXFEod2KgiNBJkl9IUvu2ZsaoQPkpB1lD7wCYFqzkHIvIGd6n150wefcD/Y0YEuk1EI9IwUDM1HxXC1DFook/L/jaN1hDjW0MPQr7TB/HA3KoG+0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=luminex.be; dmarc=pass action=none header.from=luminex.be;
 dkim=pass header.d=luminex.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luminex.be;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiF7dplOWql3qOdzO5XZCxkve5s6bAt9NUa8HDl7DxE=;
 b=ZEXE3aq+X3LpMJBXVbWQk3yreXzu20G+4R3i87U0E5s3QSwTyfl159SanLUnXE7KFtFswwL8TB/kWxsRh2cXVf39zPOHqiAUOzy7dLU+VhYvDzDYtShEqY0iI5h53+0FPeLktza+YG4dJDxP56iBDYgV8cyZJfXYF8EltU5fXVk=
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:14c::14)
 by AM7P194MB0883.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 09:44:54 +0000
Received: from PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5]) by PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
 ([fe80::b6ba:9288:de68:5c5%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 09:44:54 +0000
From: Cedric Jehasse <cedric.jehasse@luminex.be>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Thread-Topic: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Thread-Index: AQHcp5zyx+4GfmuhREGBPWCwSSMc37WWS6UV
Date: Fri, 27 Feb 2026 09:44:54 +0000
Message-ID:
 <PR3P194MB15055DDD60A57C6D9023A277EA73A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
 <20260227035537.2630823-1-kuba@kernel.org>
In-Reply-To: <20260227035537.2630823-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-codetwoprocessed: true
x-codetwo-clientsignature-inserted: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminex.be;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P194MB1505:EE_|AM7P194MB0883:EE_
x-ms-office365-filtering-correlation-id: 5d5acd39-41cb-489c-304b-08de75e4dc41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 lomEZpRKpPZ0mqUcXw6+3m2ZT9UuXyc/B5WyYsHWVJqY2AokJl84voqzQLLsKsxaWW6FbbGCMWGF2T72sfymQk0DbOqTP6+193H7uWXXgyqdFS2EC7Scz9WQSNvdoYxm7XLgVPdhWEIRvpUtMJsMwYOdg1miBYRgg07n6GSlsXob3GyZDNDomnSsnGvfc4z81XM4x8IeY+0rh/XTArUZrAijIHAXXvNuQCDHmNvwhmfWZOpr2aeND13dOZScW5wzWoWm7qSw89G05QcvrM9xhst8GMaC3rEYUd59yCqUxPSCco1JGb+dmHBYg/mwEGHaSkVqMJ0MoZ4vJufoDIP2+J2TJxUHjbmViVk+lFB5ogMYM2QRp4GKjqbHpPzDsna0MSbaPIAbkGSpmcmAWgsK8O9amlESNYsU7KKL24OsX8aRYi/JH7nCfu3HDnyhRyzkRygOHXEhVwHb8eCsxBbFcRQGkddAl9dZBSuQlbULVmUbPdEB5Ad8ysuLCeO7wbwqhcFT24HwVy6CbsJBkZjh3GgenQR/6Ymbpq4SfyUsA3/KqNP+MRl+DG/u/hsmDnEu2NpReCmyKMRjAMRGFOCgYBLDubyi606jss1AQ15XZSN9uYeTBZDOAg1Iboqxe59gW+qTItE7QJee9Oixpd/1SvyosiGqQyAd8rBsv56P747YxG1y1veQh6gA6du11MdzR5ihWW3ymb9W5kOi3bYpB6Wf9pS0v9xbWkTRlOBlhBUzR9q8PfGCMs5WVWS3a3QuE9ednsiA4RjYAtgTmv7gO/KGZ5dtn6wW2gEbQROPAFY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB1505.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Atvx3zstQB9UKxEzqyR2cSbmDzr2reg+vyCWVowwBq0+oenTIkfcL1vQbz?=
 =?iso-8859-1?Q?dMwWKKX/wYhCjy2xrpAp+Gi2ppW+NAn6yCGnpBcwkPoDSI8+WciZWGQKx+?=
 =?iso-8859-1?Q?1kQgJ+D1LVxal/IeIdDXVhoIaZABCBhLx4JspIoaXNGkR9PqQ7q9dv7cUn?=
 =?iso-8859-1?Q?LlvL4i08qfSPhB3g+b8T4zJWHorb+Qr2EUyP6R7MjTu+o5TsLfYLWakVLN?=
 =?iso-8859-1?Q?llSmrss/Q2FPCNJQiaAPge6uwnwkyGMsYKUwdI5BLaOmHVNfA96TZR/sMs?=
 =?iso-8859-1?Q?vT15/Yku7P/9BXOJLDrE1UaIq9dy3B73/y3thCTR2Ohj3bnctJtHGNHeAH?=
 =?iso-8859-1?Q?s81hrbzyAPFFkBJcsM71PZDHVbZJcOOUE+tUqo9KuXpUqgHMEaV/rY5MEe?=
 =?iso-8859-1?Q?GVOHuusu0HlAZiJ6bqZIOI8sEDE8p2vt42lcJks5TiRR6CrlDVrMNE6a5j?=
 =?iso-8859-1?Q?aHGGB3tCFAK7Sa4rTYkXkHAeyD373ZPxQzmJiVTfrJkxx2mC7eMzZF0mJv?=
 =?iso-8859-1?Q?sAgYbAKC0r2jihlFuO038vqD55ApV8E3Ke5VwFhGv5VF9OdHQMnliY8ffJ?=
 =?iso-8859-1?Q?SxBNQSKkrJoK3+ElxaJMXgzvvNibcakpk7v4pAo673ty+EeeX2UMrwzA/s?=
 =?iso-8859-1?Q?LEt3pQZz7w91N4DlCCHJgPIuG18jpc4dlXdste9iuB39jhCg4LnS0lFzBV?=
 =?iso-8859-1?Q?1k3Y+nPBKpqZ6wZ8zzwNeb3RhN4fMqTAilGw+MPRkgGZUo2GrKY0/uES5k?=
 =?iso-8859-1?Q?ILPz1qpOBgDyC57U37kY/jm0E4OOgeVL//Oei/s1q2wL0quSpU0XAahgX3?=
 =?iso-8859-1?Q?u/bamk1Rxtma9Oj3tQc7X73qLETmAE+NnTSo/Fywockaet9TwDUjg0DnTg?=
 =?iso-8859-1?Q?lzx8Ns3135InpDUIeb+MUt9Hbtcp0hohjq4AEKJFhF2i6V8TWU30+xHu3C?=
 =?iso-8859-1?Q?kZhdSAK2+vWpP9leo2mjyJdik/fZp4ExAnRjJIVrZQiaMU5ZfXscAq3UJR?=
 =?iso-8859-1?Q?46D/vO4gtQVJ2ZSyujLjBRk0YCIKVW6WEs+W15KyjQazfUo6Uvh8Q1sxig?=
 =?iso-8859-1?Q?g3cC97d+Isol937uIMuE7C3dParMMdvahQXvnGcU+Sia/B2sjBJ9qjiI9a?=
 =?iso-8859-1?Q?pKBSDlrs1u9HtRYAPQvkIEz1cGWec0U6H07aZ4dzkQYtVKorcgNVwUgslV?=
 =?iso-8859-1?Q?YRwRcba7dTUq0abXmiumfK73o97F9eZ01pl57P2ZJryRbtAnT9hpRal5ot?=
 =?iso-8859-1?Q?7N7Rz6nIOdnJlT1I2IfwABbGc6MrurtmZsgwwpYAfSgmV3Rwz1YmzahMQk?=
 =?iso-8859-1?Q?m1HhYYnKxWXyl7QpvnNHuSVLhuI71h4umImfaDy+s+1GOOQyjCiU/+/ipu?=
 =?iso-8859-1?Q?wtoniX+cptX1fxvd9ACehdp5KxBILehWQe3GN0SDqX9fHKP5PNDvyt9fh6?=
 =?iso-8859-1?Q?UairGPhbrgShg8f/jLudzifdCQEvv6yjSFmlMda0OxXbD64CfaxYr+QxPK?=
 =?iso-8859-1?Q?YsI7mYjvhGQpOrjtRwC30RYxX8NJMTRDceiek6RHqHjQ+IFGOLgllPejpM?=
 =?iso-8859-1?Q?+wdA3qrYVQemTRms1zrzNe6k0EU0Y3Q64KkChn6YkBv9F+fKP8IuYjx43e?=
 =?iso-8859-1?Q?ZrFyAhjseahwXHZaybCAiHN9xSiNN7LxDPcm4QEOXZIMT/sys51lurn8mM?=
 =?iso-8859-1?Q?NHouSHd7TRX8xrjz0ck8j3SIk4xL6L15mD1yYp5vvE2yBuUcw9+tiSrI1N?=
 =?iso-8859-1?Q?5ZnHGO0QhPLGVEjF1nLWqzSclgas6hmiEC9ZaPNQOjvYraygNlby7jK+n3?=
 =?iso-8859-1?Q?XxOzS3Np0A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: luminex.be
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB1505.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5acd39-41cb-489c-304b-08de75e4dc41
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:44:54.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ca3018c-58f1-4333-afa9-a8744cbe7fc2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6A5+mOxGYFrUKhTnPdZYksHJ6hDD5LsXhXFMsDPiHHlUwtzMzAaYppzp4sLzHFaN3Ge9npn+59KGl3Iz1zE2Vc5SumLVqG3F0N9hVYag4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P194MB0883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[luminex.be,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[luminex.be:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,google.com,davemloft.net,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-261788-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[luminex.be:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedric.jehasse@luminex.be,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,PR3P194MB1505.EURP194.PROD.OUTLOOK.COM:mid,luminex.be:dkim]
X-Rspamd-Queue-Id: 0A3381B5826
X-Rspamd-Action: no action

>> +/* insert tcam entry in ordered list and move existing entries if neces=
sary */=0A=
>> +static int mv88e6xxx_tcam_insert_entry(struct mv88e6xxx_chip *chip,=0A=
>> +                                    struct mv88e6xxx_tcam_entry *entry)=
=0A=
>> +{=0A=
>> +     struct mv88e6xxx_tcam_entry *elem;=0A=
>> +     struct list_head *hpos;=0A=
>> +     int err;=0A=
>> +=0A=
>> +     list_for_each_prev(hpos, &chip->tcam.entries) {=0A=
>> +             u8 move_idx;=0A=
>> +=0A=
>> +             elem =3D list_entry(hpos, struct mv88e6xxx_tcam_entry, lis=
t);=0A=
>> +             if (entry->prio >=3D elem->prio)=0A=
>> +                     break;=0A=
>> +=0A=
>> +             move_idx =3D elem->hw_idx + 1;=0A=
>> +=0A=
>> +             err =3D mv88e6xxx_tcam_flush_entry(chip, move_idx);=0A=
>> +             if (err)=0A=
>> +                     return err;=0A=
>> +=0A=
>> +             err =3D chip->info->ops->tcam_ops->entry_add(chip, elem,=
=0A=
>> +                                                        move_idx);=0A=
>> +             if (err)=0A=
>> +                     return err;=0A=
>> +=0A=
>> +             elem->hw_idx =3D move_idx;=0A=
>> +     }=0A=
>=0A=
>If entry_add() fails after some entries have already been moved to new=0A=
>hardware positions with their hw_idx updated, doesn't the function return=
=0A=
>without rolling back those partial moves?=0A=
>=0A=
>The software list would then have some entries pointing to their new=0A=
>positions while the gap for the new entry is only partially created.=0A=
>This could leave the TCAM in an inconsistent state for subsequent=0A=
>operations.=0A=
>=0A=
>Is there error handling to ensure the TCAM state remains consistent when=
=0A=
>insertion partially succeeds?=0A=
=0A=
Here's the reply i gave to the ai-review on the v3 version of the patch:=0A=
I don't think this is an issue. For entries that are successfully moved the=
=0A=
hw_idx points to the new index. And for entries that haven't successfully=
=0A=
moved it's still pointing to the old index. Hence the hw_idx field for ever=
y=0A=
list entry should still point to the correct TCAM index. There will be a ga=
p=0A=
in the TCAM entries in the hardware, but that's not an issue.=0A=
If moving an existing entry returns an error. The rollback moving of entrie=
s=0A=
is as likely to return an error, and potentially leave the TCAM in an=0A=
inconsistent state.=0A=
=0A=
>=0A=
>[ ... ]=0A=
>=0A=
>> diff --git a/drivers/net/dsa/mv88e6xxx/tcflower.c b/drivers/net/dsa/mv88=
e6xxx/tcflower.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..05b289463834=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/net/dsa/mv88e6xxx/tcflower.c=0A=
>> @@ -0,0 +1,164 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
>> +/*=0A=
>> + * Marvell 88E6xxx Switch flower support=0A=
>> + *=0A=
>> + * Copyright (c) 2026 Luminex Network Intelligence=0A=
>> + */=0A=
>> +=0A=
>> +#include "chip.h"=0A=
>> +#include "tcflower.h"=0A=
>> +#include "tcam.h"=0A=
>> +=0A=
>> +#define MV88E6XXX_ETHTYPE_OFFSET 16=0A=
>> +#define MV88E6XXX_IP_PROTO_OFFSET 27=0A=
>> +#define MV88E6XXX_IPV4_SRC_OFFSET 30=0A=
>> +#define MV88E6XXX_IPV4_DST_OFFSET 34=0A=
>> +=0A=
>> +static int mv88e6xx_flower_parse_key(struct mv88e6xxx_chip *chip,=0A=
>> +                                  struct netlink_ext_ack *extack,=0A=
>> +                                  struct flow_cls_offload *cls,=0A=
>> +                                  struct mv88e6xxx_tcam_key *key)=0A=
>> +{=0A=
>> +     struct flow_rule *rule =3D flow_cls_offload_flow_rule(cls);=0A=
>> +     struct flow_dissector *dissector =3D rule->match.dissector;=0A=
>> +     u16 addr_type =3D 0;=0A=
>> +=0A=
>> +     if (dissector->used_keys &=0A=
>> +         ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |=0A=
>> +           BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL) |=0A=
>> +           BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |=0A=
>> +           BIT_ULL(FLOW_DISSECTOR_KEY_IPV6_ADDRS))) {=0A=
>> +             NL_SET_ERR_MSG_MOD(extack,=0A=
>> +                                "Unsupported keys used");=0A=
>> +             return -EOPNOTSUPP;=0A=
>> +     }=0A=
>=0A=
>FLOW_DISSECTOR_KEY_IPV6_ADDRS is included in the allowed keys bitmask,=0A=
>but there is no code below to parse IPv6 addresses into the TCAM key.=0A=
>=0A=
>If a user creates a tc flower rule with IPv6 addresses, the rule passes=0A=
>this validation check but the addresses are never programmed into the=0A=
>TCAM. This would cause the hardware entry to match broader traffic than=0A=
>intended.=0A=
>=0A=
>Looking at the code further down:=0A=
>=0A=
>> +     if (addr_type =3D=3D FLOW_DISSECTOR_KEY_IPV4_ADDRS) {=0A=
>> +             struct flow_match_ipv4_addrs match;=0A=
>> +=0A=
>> +             flow_rule_match_ipv4_addrs(cls->rule, &match);=0A=
>> +             mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_SRC_OFFSET,=
=0A=
>> +                                      match.key->src,=0A=
>> +                                      match.mask->src);=0A=
>> +             mv88e6xxx_tcam_match_set(key, MV88E6XXX_IPV4_DST_OFFSET,=
=0A=
>> +                                      match.key->dst,=0A=
>> +                                      match.mask->dst);=0A=
>> +     } else {=0A=
>> +             NL_SET_ERR_MSG_MOD(extack,=0A=
>> +                                "Unsupported address type");=0A=
>> +             return -EOPNOTSUPP;=0A=
>> +     }=0A=
>=0A=
>The check at line 68-72 rejects non-IPv4 address types, but the IPv6 key=
=0A=
>is still in the allowed keys bitmask at line 30. This creates a confusing=
=0A=
>situation where IPv6 is both 'allowed' and 'unsupported'.=0A=
>=0A=
>Should FLOW_DISSECTOR_KEY_IPV6_ADDRS be removed from the allowed keys=0A=
>until IPv6 parsing is implemented?=0A=
=0A=
At first FLOW_DISSECTOR_KEY_IPV6_ADDRS wasn't in the allowed keys bitmask, =
but=0A=
creating ipv4 filter entries failed with -EOPNOTSUPP.=0A=
Eg. when using the following tc command, the FLOW_DISSECTOR_KEY_IPV6_ADDRS =
bit=0A=
is set in dissector->used_keys:=0A=
tc filter add dev p1 ingress protocol ip flower skip_sw dst_ip 224.0.1.100 =
\=0A=
    action trap=0A=
    =0A=
To make ipv4 filter entries work i had to add FLOW_DISSECTOR_KEY_IPV6_ADDRS=
 to=0A=
the allowed keys bitmask and check the addr_type instead.=0A=
=0A=
thanks,=0A=
Cedric=0A=

