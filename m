Return-Path: <netdev+bounces-285042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H/MbLA+2+2nmDgAAu9opvQ
	(envelope-from <netdev+bounces-285042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:43:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101064E0B0F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 23:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E25300421E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808C3B3898;
	Wed,  6 May 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZL4uI0Ve"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023112.outbound.protection.outlook.com [40.93.196.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24393B2FE7;
	Wed,  6 May 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103820; cv=fail; b=ftHjiyPAA2EmduPOM4047/zxm2+hn351gkXsIgFDBP29UVgz+vlddBYdfOXKKq/vqDM83JJ3vr/kUzDu2ieT9KsRSKa/IzqzHDEarRAfBat9qBM7WOSGBRnWBfH5LKNr/oevkNJkN+Uf/j0zyvNY93iaMT8Y633z0asgk4F/ThU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103820; c=relaxed/simple;
	bh=CAj/YC0cm5miOsYKrp2Hch0ABj3dF4S90in1a+V3X6k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X9yMO4A2PsDGGRddZ+/bqxarcW79BK5Qjofj1i/R94PBiTTiu5SyvIgr+SImv2gS3hClLWMqGIbwthgjOrLRIFw8GXoouMV0F6OdfZPr5sSFl5J2C6UADOSDdpZlc1T8OlSJytm37lwwC9GGvq6abpwjxCdmNJxFx7+SDDssrA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZL4uI0Ve; arc=fail smtp.client-ip=40.93.196.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQLhtUgYPvz4tNBZ5LElm+s1eeRkG9Q8E/M24k5MEwt7g+vK7C1ocJ/hUBD+W9x6HSz9ipODjbsPdHaIE/y/cpGxwZ4zV2SiPS3DOrycLsELedBjwb/T4gY2xue13eKf7RAjkU7pp/e4V6qIQ73deV/b0UjpvVO+nDxmchrHcLcHWDFHjQ9Pu3gPx1VkoDiEyFkjM08lqzBUbfKfserJ6htvw6DQH4Iq7CA1HQrVqhq/3ojDO6m10oY+k9Ka+q0Y4DtDIS/hGcUApPd+gNjHNPTSkVBuOoHb+wgXLeC4m7SWXSlQGVXrlCix7YaShhVbcMrv9H7FJos0x3FDJqjyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK/jpYPIS/hkJyDVFvW9zbDN1VcAdc6yUnciLtGcdRE=;
 b=Y//Kw3gKBQny3QTxrLQKj9WfpgZBE+7JlG70LUHeHG48brB0T9mERkKHwcaMKGYle0wSdvrRcB7mZNMr0EOCamj9hor9FB03vqe1Sw4IavP4g8GrgxhifNPYlfXhLJ0wyGQwLpf3I5WlegMe2k2kH9pntImUMjKnVJSHR0CGpE5bXZHrLASBxD6hdCxDy2CryMjA5SamwdI2KwJQ3d2tdXKxbCAozPchL0LEWUTWarWUa+eXBXPZkDan/0tMm/A6cjOFb8CzGmJ4XY37xdkmKdDsnuPSswzzeS2JCXTsOhjFtLPkks/Htp8ZQxinioR25+0lSJBPOSZm8ucfaMrDDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK/jpYPIS/hkJyDVFvW9zbDN1VcAdc6yUnciLtGcdRE=;
 b=ZL4uI0Vem6R4hRPp0DvhopNI1VpsC6EXLMCqesjfgkx8s+vS0zcpl1fslvMhs0PlNKljMNElHPbxDZ/sIWxvN+UhorOWKs5vAdUOJWG9TWHca+IdeqwxINGxP7BiNelhNRt9Tsb+4WiawSwivp5l74whVOeI5F7nRi7xAIHHeyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CY3PR01MB9194.prod.exchangelabs.com (2603:10b6:930:109::7) by
 PH0PR01MB6151.prod.exchangelabs.com (2603:10b6:510:18::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.27; Wed, 6 May 2026 21:43:32 +0000
Received: from CY3PR01MB9194.prod.exchangelabs.com
 ([fe80::4005:a1db:71b8:dc8c]) by CY3PR01MB9194.prod.exchangelabs.com
 ([fe80::4005:a1db:71b8:dc8c%5]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 21:43:32 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [net-next v39] mctp pcc: Implement MCTP over PCC Transport
Date: Wed,  6 May 2026 17:43:26 -0400
Message-ID: <20260506214327.276069-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:930:4c::14) To CY3PR01MB9194.prod.exchangelabs.com
 (2603:10b6:930:109::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR01MB9194:EE_|PH0PR01MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 45834f9a-9ef4-4acd-184b-08deabb884b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|1800799024|376014|13003099007|56012099003|18002099003|55112099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	5/7wtTYJo1wQSIDGAL+9a5wwlmKrGebV2pz5rLGqrTOlFc8AXI/mtKK00OxSidxFLEpoFcdCCcQt9+SW0g7CM/3jUdR3yP+Lti7MRbsojpWCXZ6v6657PN1aqbZfgcAj4hYKiZKEBL7ctYNrnK0pHLFTFEkRXj1fKIa9WNlDkIKpKfASrgBBjDowb9CVWbFftPmJN2SftktQB8S+i2Y8tJEGcj1Eq6yewDWYpMjRfg3KSebZ46/bqirFxVZZ/Zd0XnL72A8fyfxHAXxL+11H1tmhQWryPKJZE7YiaPhDOINRyZbzDKOgUZPh0n2KFGP5cycWDJgCKhZqk8r8hpy5kWAtELuJ1+X37lLM3GSuxowHkTQXxXTj5/A7gqt+Mie+JYXNc8TVubA0F8ZKCipZ3mBMVxkdpNqNRb2CuU6HF6NulBf9JCMJsVwwYPNj+F+PbZvy2mYNmXTUW0gJdZ2UbIC8PKZn0qJOH+fZyKvca6huAQugreowNT5cCWN5Vs6Q2SXxXc2q9KJ24R6q/o39qPl/iZhZOTwN+wsBZZ7d+k6jegHijgfCyF+TDX5EXbpc4I7TQEehjVDTrK+Cgot/6rnE4wVvOwffygsijwOb2zjo9ZLapx34qC9huh3KbgzsG5T+XiPlVXlJ4ahDNd/3FmHI5OrRyylaBBZkZpmxW4HDIcKXdfShmNQG8yN8k3vA1AGCabJZBHAqGKDKWeGCeA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY3PR01MB9194.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(13003099007)(56012099003)(18002099003)(55112099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UKkFz80v9KswjSsn1a3ExHXuD3UniJ2rv9muNYcBuWojT488tf8I+vvOCyMQ?=
 =?us-ascii?Q?I2onOqIt7trAfTVevEEHiwI7SwNSuMsrpKz+4JHnQYCDWBwYAT3AU3eZyXq9?=
 =?us-ascii?Q?5t14CwZ0Impaj+UDU3R+fUvZ+sWDN0LGPR5i24XoR6nxIdoZs0Ra34a9L3mZ?=
 =?us-ascii?Q?k92EYjjRd1eAvFOMjRHO6SJ+aG8LWd9dUDEuGaP+O8zzMbrAKCD/w4/Hyhqa?=
 =?us-ascii?Q?sQKuM8xneBFddFAFgWZYYq9tn954NyA0yd61ubJLqZcDBt/rtykpUdY8e5Co?=
 =?us-ascii?Q?q2Iw4ar3HVNjR7TbWWWxOxoIqjxKBccQtCD1c5AbXe+9X9NHWx+qZudrmzyA?=
 =?us-ascii?Q?QSbr1P2tg5L1gAytim1SxJLqwcDxczh0+5FhPluaSwuXiVaDlDywShoNvLlc?=
 =?us-ascii?Q?+9Jpa3mqaO+UIlXPvrxL56nb13i0NnwAiibLUVWuGTAOQkXo+q0XB8ZZV6Ok?=
 =?us-ascii?Q?lgbLGs1c8SRsgnHqAINXHDQau3oP8ETSic5lvtr85GmAkVJcuNyrCq+4Zv4q?=
 =?us-ascii?Q?ytO9vqT3O6nws9k8OZ6bgk4mnTfdbDCpUaRACrGlYO5Z/QdjXNBFpvNDVrpx?=
 =?us-ascii?Q?JUkV4whUI1vKcmycjyorXqhObSThrsHj1P+aWVvRrSXbbip4bMg3IB8LNGQ6?=
 =?us-ascii?Q?kDPlZAsh4FwT6hV2Onq+bJgodcLAu/E0N+KNTsiDdKz7/4o/kz3c73Q3hGUP?=
 =?us-ascii?Q?qbD9+Xx9ZH9INw6B4CsflLEtTZxmDDwqjL9vgZtUsvUkHfS4619nbzih8XxK?=
 =?us-ascii?Q?ySzr0q++CiY6QLSuFEIUj2aNwwACF119/DhAgVb/Y+5FuApdKcpf5ZbYyeCM?=
 =?us-ascii?Q?FOc6wy8PKCdvnqFuakT/Rg3eJiMDyxAgcb4Qbo3IJuSrYeGHWAe5bctBOaDx?=
 =?us-ascii?Q?yj0qmhecQG2uxMggD1rTV+tTDYZ3vNp66woqRLUGqHZAoNkVwa7YDA7fh3Hc?=
 =?us-ascii?Q?lspcpL4tEF7d5v/Zs9QXaUdjH0jzHsdaVhglGvZanmVF91389J1pu4AQNvyp?=
 =?us-ascii?Q?zvB2jfZAVW+B9M/RP3j6FPrJFgasSDGT/9lsL9mXn2LhkQFjQ2Dp4CDK/c2u?=
 =?us-ascii?Q?4J3PIvJSViNVdY7TZHiSWXZZYPeVl6sShI08kllo3NSe77uCg3B+g0l4ekEB?=
 =?us-ascii?Q?MnntdCGimqtOcDIsjvmhfgPjSYIb7BeQl5LmvT47T9CbfcTs6dmYZT9hU3Pt?=
 =?us-ascii?Q?BJOxXWIJizyy6+eq/piMMatuarNdVLOmWJh9NJHRYdjOyJhG2NnWon3IIZyf?=
 =?us-ascii?Q?wIaN5XVwYJYq2dzDY9GMXQyk2IcIvAXxhPH6mRrIWWrYhKXtBmQYtqwI+v1U?=
 =?us-ascii?Q?ns7C2ddFW5KclmeYzrUKJzy3MZ9eA7CNEMucboNYcrJi3Qd1i4Upld9AD1Qq?=
 =?us-ascii?Q?xUYwdaTj50MS/s9Lr3vIcZGr4BlQmWY2V16jcdY+IYSEDEdmsli75Brr9YyK?=
 =?us-ascii?Q?x202X/5igUwBMj+eg/nQCsaNQ2epHq++G8ZuDvG8Tm36w/dYSktGsyDALrM8?=
 =?us-ascii?Q?XK8mlUyf4MO3oBDg0JKjxsgbjyPPlR+wET6syOteaJppgZLdHJyPS3xcckTs?=
 =?us-ascii?Q?qum84u0xkNio+rI3ZBcIE1XWJK8VojxEyDjCbLvOtrUqie5t2VwY0VTXMysQ?=
 =?us-ascii?Q?kvH7jAb8X2imEprWpMMYVJ7uqYd0dEs9BK3uEixZdiECK0tlwl8pWBGvML7q?=
 =?us-ascii?Q?ZoDvlh0CuaNGuL7EB+SyLAQpZPsw20r6DtvsPUVfP8uSCdeNByKFbvTNhlUn?=
 =?us-ascii?Q?fuo1QeCjGko4lU0thG/THYs2i7szUHtm6IxboUJe1l9pJ/zTjQs2O7JrS52N?=
X-MS-Exchange-AntiSpam-MessageData-1:
	3ZZlmAJCCmw5eWUMMsqVNX1UN2Rv0iFlfT/72/AVVlWPbsE+acKdO/ht
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45834f9a-9ef4-4acd-184b-08deabb884b0
X-MS-Exchange-CrossTenant-AuthSource: CY3PR01MB9194.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 21:43:32.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6gg929UUZyLgQTqTkzrJaMmhgCzR1jQyroKPQdm52xJNmJYG89cqt6hXuBZ0UqXtmBbBBL6y+zOjNYQQIpJgzLtOkVKMUTqc9lYi+gWnGJafsxKFTEnYwArD+nefwXS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6151
X-Rspamd-Queue-Id: 101064E0B0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285042-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,amperecomputing.com:email]
X-Rspamd-Action: no action

Implementation of network driver for
Management Component Transport Protocol(MCTP)
over Platform Communication Channel(PCC)

DMTF DSP:0292
Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf

The transport mechanism is called Platform Communication Channels (PCC)
is part of the ACPI spec:

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html

The PCC mechanism is managed via a mailbox implemented at
drivers/mailbox/pcc.c

MCTP devices are specified via ACPI by entries in DSDT/SSDT and
reference channels specified in the PCCT. Messages are sent on a type
3 and received on a type 4 channel.  Communication with other devices
use the PCC based doorbell mechanism; a shared memory segment with a
corresponding interrupt and a memory register used to trigger remote
interrupts.

The shared buffer must be at least 68 bytes long as that is the minimum
MTU as defined by the MCTP specification.

Unlike the existing PCC Type 2 based drivers, the mssg parameter to
mbox_send_msg is actively used. The data section of the struct sk_buff
that contains the outgoing packet is sent to the mailbox, already
properly formatted as a PCC exctended message.

If the mailbox ring buffer is full, the driver stops the incoming
packet queues until a message has been sent, freeing space in the
ring buffer.

When the Type 3 channel outbox receives a txdone response interrupt,
it consumes the outgoing sk_buff, allowing it to be freed.

Bringing up an interface creates the channel between the network driver
and the mailbox driver. This enables communication with the remote
endpoint, to include the receipt of new messages. Bringing down an
interface removes the channel, and no new messages can be delivered.
Stopping the interface will leave any packets that are cached in the
mailbox ringbuffer. They cannot safely be freed until the PCC mailbox
attempts to deliver them and has removed them from the ring buffer.

PCC is based on a shared buffer and a set of I/O mapped memory locations
that the Spec calls registers.  This mechanism exists regardless of the
existence of the driver. If the user has the ability to map these
physical location to virtual locations, they have the ability to drive the
hardware.  Thus, there is a security aspect to this mechanism that extends
beyond the responsibilities of the operating system.

If the hardware does not expose the PCC in the ACPI table, this device
will never be enabled. Thus it is only an issue on hardware that does
support PCC. In that case, it is up to the remote controller to sanitize
communication; MCTP will be exposed as a socket interface, and userland
can send any crafted packet it wants. It would also be incumbent on
the hardware manufacturer to allow the end user to disable MCTP over PCC
communication if they did not want to expose it.

Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communications_Channel/Platform_Comm_Channel.html
Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

---

Several rounds of code review have gone into this update.  The changes
are listed roughly in the order they were made.  Additional issues have
been found but require changes in the mailbox/pcc.c and the
corresponding header file.  These will be submitted in a separate series
of reviews.  The driver works without those changes, and any issues are
pre-existing in all PCC extended memory drivers.

Previous Version: https://lore.kernel.org/lkml/20260405180741.1496198-1-admiyo@os.amperecomputing.com/

Changes from Previous version

check that returned message length is smaller than the size of the shared buffer.
remove space after // in mctp_pcc_tx
don't say ndo in function names
don't use capital letter in MTU function name

move dev_dstats_tx_add outside of irq processing
Note AI Generated Code Review comment which seems legit:
        mctp_pcc_tx() runs in process or softirq context and calls
        dev_dstats_tx_dropped(). mctp_pcc_tx_done() runs in the controller's hardirq
        context and calls dev_dstats_tx_add().
        The generic dev_dstats_* macros use u64_stats_update_begin(), which does not
        disable interrupts. If a hardware interrupt fires while the softirq path is
        inside u64_stats_update_begin(), the hardirq path will re-enter the lock.

while technically there are still possible ways that the SKB send might fail
	we cannot report them any later than prep_tx.  In tx complete,
	we are in interupt context and it is not safe to update the stats then.

mctp-pcc use little-endian conversion for shared buffer header values
explain why we test for a null SKB in mctp_pcc_tx_prepare and warn once
Deal with fragmented outbound packets
Cleanup the active message when tearing down the driver
        the active message may have been sent to the backend just prior to clean up
        we want to free it during cleanup, and thus make sure that the null pointer
        set as the active message is not passed to the callback if the message
        response interrupt gets triggered.

return PTR_ERR and EINVAL for initialization error cases
Fail initialization if there are not exactly 2 channels: an outbox and an inbox
don't advance msg_free when freeing skbs
use PCC_EXTRA_LEN  to clarify and standardize length comparisons between value from buffer and size of shmem.
ensure the shared buffer is large enough to hold MCTP-PCC messages
ensure there is an active message when clearing the ring buffer
start teardown process by disabling rx
        Avoid a race condition where the teardown
        process frees the active req, but an interupt
        resets it, leaking memory.  Ensure active_req
        stays clear By closing the channel first.

CONFIG option to ensure mctp is 64bit only
compare inbox MTU with Outbox MTU and take the smaller value
add mctp_pcc_change_mtu
use ACPI constant for u32 data type
default case for switch in testing PCC channels
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  15 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 427 ++++++++++++++++++++++++++++++++++++
 4 files changed, 448 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cb0f2bf6fe2e..7a064e326f0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15398,6 +15398,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..9c1d228e5ad7 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,21 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	depends on PCC
+	depends on 64BIT
+	help
+	  Provides a driver to access MCTP devices over PCC transport,
+	  A MCTP protocol network device is created via ACPI for each
+	  entry in the DSDT/SSDT that matches the identifier. The Platform
+	  communication channels are selected from the corresponding
+	  entries in the PCCT.
+
+	  Say y here if you need to connect to MCTP endpoints over PCC. To
+	  compile as a module, use m; the module will be called mctp-pcc.
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..0a591299ffa9 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
+obj-$(CONFIG_MCTP_TRANSPORT_PCC) += mctp-pcc.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
diff --git a/drivers/net/mctp/mctp-pcc.c b/drivers/net/mctp/mctp-pcc.c
new file mode 100644
index 000000000000..de644c188f3e
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcc.c - Driver for MCTP over PCC.
+ * Copyright (c) 2024-2026, Ampere Computing LLC
+ *
+ */
+
+/* Implementation of MCTP over PCC DMTF Specification DSP0256
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
+ */
+
+#include <linux/acpi.h>
+#include <linux/hrtimer.h>
+#include <linux/if_arp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/skbuff.h>
+#include <linux/string.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <acpi/acrestyp.h>
+#include <acpi/actbl.h>
+#include <acpi/pcc.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
+#define MCTP_SIGNATURE          "MCTP"
+#define MCTP_SIGNATURE_LENGTH   (sizeof(MCTP_SIGNATURE) - 1)
+#define MCTP_MIN_MTU            68
+#define PCC_HEADER_SIZE         sizeof(struct acpi_pcct_ext_pcc_shared_memory)
+#define MCTP_PCC_MIN_SIZE       (PCC_HEADER_SIZE + MCTP_MIN_MTU)
+#define PCC_EXTRA_LEN           (PCC_HEADER_SIZE - sizeof(pcc_header.command))
+struct mctp_pcc_mailbox {
+	u32 index;
+	struct pcc_mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/* The netdev structure. One of these per PCC adapter. */
+struct mctp_pcc_ndev {
+	struct net_device *ndev;
+	struct acpi_device *acpi_device;
+	struct mctp_pcc_mailbox inbox;
+	struct mctp_pcc_mailbox outbox;
+};
+
+static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void *mssg)
+{
+	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *inbox;
+	struct mctp_skb_cb *cb;
+	struct sk_buff *skb;
+	u32 header_length;
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+
+	// The message must at least have the PCC command indicating it is an MCTP
+	// message followed by the MCTP header, or we have a malformed message.
+	// This may be run on big endian system, but the data in the buffer is
+	// explicitly little endian.
+	header_length = le32_to_cpu(pcc_header.length);
+	if (header_length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr)) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	// If the reported size is larger than the shared memory minus headers,
+	// something is wrong and treat the buffer as corrupted data.
+	if (header_length > inbox->chan->shmem_size - PCC_EXTRA_LEN) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	size = header_length + PCC_EXTRA_LEN;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	skb_put(skb, size);
+	skb->protocol = htons(ETH_P_MCTP);
+	memcpy_fromio(skb->data, inbox->chan->shmem, size);
+	dev_dstats_rx_add(mctp_pcc_ndev->ndev, size);
+	skb_pull(skb, sizeof(pcc_header));
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	cb = __mctp_cb(skb);
+	cb->halen = 0;
+	netif_rx(skb);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+
+	/* Consolidated a fragmented packet into contiguous memory */
+	if (skb_is_nonlinear(skb)) {
+		if (skb_linearize(skb))
+			goto error;
+	}
+
+	if (skb_cow_head(skb, sizeof(*pcc_header)))
+		goto error;
+
+	/**
+	 * This code could potentially be run on A Big Endian
+	 * System.  The ACPI specification requires that values
+	 * in the shared buffer be little endian.
+	 */
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = cpu_to_le32(PCC_SIGNATURE | mpnd->outbox.index);
+	pcc_header->flags = cpu_to_le32(PCC_CMD_COMPLETION_NOTIFY);
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length =  cpu_to_le32(len + MCTP_SIGNATURE_LENGTH);
+
+	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
+		// Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+error:
+	dev_dstats_tx_dropped(ndev);
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static void mctp_pcc_tx_prepare(struct mbox_client *cl, void *mssg)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, outbox.client);
+	outbox = &mctp_pcc_ndev->outbox;
+
+	/* The PCC Mailbox typically does not make use of the mssg pointer
+	 * The mctp-over pcc driver is the only client that uses it.
+	 * This value should always be non-null; it is possible
+	 * that a change in the Mailbox level will break that assumption.
+	 */
+	if (!skb) {
+		WARN_ONCE(!skb, "%s called with null message.\n", __func__);
+		return;
+	}
+
+	if (skb->len > outbox->chan->shmem_size) {
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem,  skb->data, skb->len);
+	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	/*
+	 * If there is a packet in flight during driver cleanup
+	 * It may have been freed already.
+	 */
+	if (!mssg)
+		return;
+	/*
+	 * If the return code is non-zero, we should not report the packet
+	 * as transmitted.  However, we are in IRQ context right now, and we
+	 * cannot safely write transmission statistics.
+	 */
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_open(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
+	struct mctp_pcc_mailbox *outbox, *inbox;
+
+	outbox = &mctp_pcc_ndev->outbox;
+	inbox = &mctp_pcc_ndev->inbox;
+
+	outbox->chan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(outbox->chan))
+		return PTR_ERR(outbox->chan);
+
+	if (outbox->chan->shmem_size  <  MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		return -EINVAL;
+	}
+
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	if (inbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
+		pcc_mbox_free_channel(outbox->chan);
+		pcc_mbox_free_channel(inbox->chan);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mctp_pcc_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	unsigned int count, idx;
+	struct mbox_chan *chan;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	chan = mctp_pcc_ndev->outbox.chan->mchan;
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	scoped_guard(spinlock_irqsave, &chan->lock) {
+		skb = chan->active_req;
+		chan->active_req = NULL;
+		if (skb) {
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+		}
+		while (chan->msg_count > 0) {
+			count = chan->msg_count;
+			idx = chan->msg_free;
+			if (idx >= count)
+				idx -= count;
+			else
+				idx += MBOX_TX_QUEUE_LEN - count;
+			skb = chan->msg_data[idx];
+			dev_dstats_tx_dropped(ndev);
+			dev_consume_skb_any(skb);
+			chan->msg_count--;
+		}
+	}
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	return 0;
+}
+
+static int mctp_pcc_change_mtu(struct net_device *dev, int new_mtu)
+{
+	if (new_mtu > dev->max_mtu)
+		return -EINVAL;
+	if (new_mtu < MCTP_MIN_MTU)
+		return -EINVAL;
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_open,
+	.ndo_stop = mctp_pcc_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
+	.ndo_change_mtu = mctp_pcc_change_mtu,
+};
+
+static void mctp_pcc_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->hard_header_len = sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	ndev->tx_queue_len = 0;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_pcc_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+struct mctp_pcc_lookup_context {
+	int index;
+	u32 inbox_index;
+	u32 outbox_index;
+};
+
+static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
+				       void *context)
+{
+	struct mctp_pcc_lookup_context *luc = context;
+	struct acpi_resource_address32 *addr;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_ADDRESS32)
+		return AE_OK;
+
+	addr = ACPI_CAST_PTR(struct acpi_resource_address32, &ares->data);
+	switch (luc->index) {
+	case 0:
+		luc->outbox_index = addr[0].address.minimum;
+		break;
+	case 1:
+		luc->inbox_index = addr[0].address.minimum;
+		break;
+	default:
+		return AE_ERROR;
+	}
+	luc->index++;
+	return AE_OK;
+}
+
+static void mctp_cleanup_netdev(void *data)
+{
+	struct net_device *ndev = data;
+
+	mctp_unregister_netdev(ndev);
+}
+
+static int initialize_mtu(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct mctp_pcc_mailbox *outbox;
+	struct pcc_mbox_chan *pchan;
+	int mctp_pcc_max_mtu;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	outbox = &mctp_pcc_ndev->outbox;
+	pchan = pcc_mbox_request_channel(&outbox->client, outbox->index);
+	if (IS_ERR(pchan))
+		return PTR_ERR(pchan);
+	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
+		pcc_mbox_free_channel(pchan);
+		return -EINVAL;
+	}
+	mctp_pcc_max_mtu = pchan->shmem_size - sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+	pcc_mbox_free_channel(pchan);
+
+	ndev->mtu = MCTP_MIN_MTU;
+	ndev->max_mtu = mctp_pcc_max_mtu;
+	ndev->min_mtu = MCTP_MIN_MTU;
+
+	return 0;
+}
+
+static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
+{
+	struct mctp_pcc_lookup_context context = {0};
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct device *dev = &acpi_dev->dev;
+	struct net_device *ndev;
+	acpi_handle dev_handle;
+	acpi_status status;
+	char name[32];
+	int rc;
+
+	dev_dbg(dev, "Adding mctp_pcc device for HID %s\n",
+		acpi_device_hid(acpi_dev));
+	dev_handle = acpi_device_handle(acpi_dev);
+	status = acpi_walk_resources(dev_handle, "_CRS", lookup_pcct_indices,
+				     &context);
+	if (!ACPI_SUCCESS(status)) {
+		dev_err(dev, "FAILED to lookup PCC indexes from CRS\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Ensure we have exactly 2 channels: an outbox and an inbox.
+	 */
+	if (context.index != 2)
+		return -EINVAL;
+
+	snprintf(name, sizeof(name), "mctppcc%d", context.inbox_index);
+	ndev = alloc_netdev(sizeof(*mctp_pcc_ndev), name, NET_NAME_PREDICTABLE,
+			    mctp_pcc_setup);
+	if (!ndev)
+		return -ENOMEM;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+
+	mctp_pcc_ndev->inbox.index = context.inbox_index;
+	mctp_pcc_ndev->inbox.client.dev = dev;
+	mctp_pcc_ndev->outbox.index = context.outbox_index;
+	mctp_pcc_ndev->outbox.client.dev = dev;
+
+	mctp_pcc_ndev->outbox.client.tx_prepare = mctp_pcc_tx_prepare;
+	mctp_pcc_ndev->outbox.client.tx_done = mctp_pcc_tx_done;
+	mctp_pcc_ndev->acpi_device = acpi_dev;
+	mctp_pcc_ndev->ndev = ndev;
+	acpi_dev->driver_data = mctp_pcc_ndev;
+
+	rc = initialize_mtu(ndev);
+	if (rc)
+		goto free_netdev;
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCC);
+	if (rc)
+		goto free_netdev;
+
+	return devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
+free_netdev:
+	free_netdev(ndev);
+	return rc;
+}
+
+static const struct acpi_device_id mctp_pcc_device_ids[] = {
+	{ "DMT0001" },
+	{}
+};
+
+static struct acpi_driver mctp_pcc_driver = {
+	.name = "mctp_pcc",
+	.class = "Unknown",
+	.ids = mctp_pcc_device_ids,
+	.ops = {
+		.add = mctp_pcc_driver_add,
+	},
+};
+
+module_acpi_driver(mctp_pcc_driver);
+
+MODULE_DEVICE_TABLE(acpi, mctp_pcc_device_ids);
+
+MODULE_DESCRIPTION("MCTP PCC ACPI device");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Adam Young <admiyo@os.amperecomputing.com>");
-- 
2.43.0


