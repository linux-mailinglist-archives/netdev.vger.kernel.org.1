Return-Path: <netdev+bounces-290112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKZECe0pDmpq6gUAu9opvQ
	(envelope-from <netdev+bounces-290112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A979559B26D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04D453026599
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC063909B7;
	Wed, 20 May 2026 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="K0ZRn/vw"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020078.outbound.protection.outlook.com [52.101.46.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF93793B0;
	Wed, 20 May 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313129; cv=fail; b=IGsOzvlTl+GutwBrWT9EWo1S2t+4EC2nuYdDjmPkQXxAoTiT5VFRWe3xjrKhb0O+RPNAm2HYo00K3GMBKFgzvMl1zCEX3oNqQcEQDmnl/Hr6FGhfXfaGbLe4xpkxeeJfdxCLY/xTI8tZTLtrLqME99LYmRpAywiHCJ/eKskxiBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313129; c=relaxed/simple;
	bh=HOfg5XJje6uQH7BLz097YOEy4NqvSbPl0vWIGzK5Tck=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hjSDMx7S1v+oT0WD4E7JlLxIJoA3JPMjVlvPqUP3syncQxQqrICEXpm54fMkOlI0rxodswOCgy8/ktnTJ14Q6tiKpege743YLIhPsXzT/Ui8A0rXONE074pAAzuAr7txYW9/Z/5VGFIJJckPhs6+jyeQk/a056CdzVV+9I+4F6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=K0ZRn/vw; arc=fail smtp.client-ip=52.101.46.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGUH2qaaWpYlcqItxXKfhEL4atC92vtWmwvYsNKp6v4MiRaOD0SFH6awG/ap8fn5C/jCSp/jfiEmZ2QfmPWhdzyE0YvrIB+y4pp8YzRDCq0gZTZz3S1e3mAeVBAcbQz3KJNWD++2e6XgiXX23zXggBv5IqV61k0rJ8nipHTw26BAnpASiPHXHsTm8oQm1qR90ueIFx96u++gMeDIKIX4KOqUFQ5ue0gcmCUd2EILJ+aaayKQ1H328vNopl0MlgUxjS9UcYUD37BBC6W756MBnBL50M4MUmAXHdyXSXDosvHMUC4uYefeofjnYiL4daTe0k6PaUaZCaJKYc6QAn8HqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfT+3G1QgcLywNvO80Hsaz6UpuzcTckMGYefN+IotGs=;
 b=O8TrJqYCv+SRP/TYIbmRjKeThREafrY1zfiCgQ5Hlk0qtz0a1Aqpkb+klU8t/EILhBb8QnS/qz32+6Ot0l1RDITp7jv+gSxXK5W68NzWFdeB/l67LV2mF4pS11J+MkN1i10CrU7zjS3QfzhC4/fKCCkEfbk0ZBP8sJIj4jKw2I75n4SQmd2IAp4gMXzdy5rC9Uxjf+iziKeW3cAYvI/H6jL7ReIz1uIzKrfS97OV0IT67sgEA5km460lTgPnRWvGj1NKQ9022VtJdJcYux+U9dRQETHTmZZV/lPeL7vILmVNwCkyPeAvWoD8voOfUGmyokwBhIhYW//irOrTvpuRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfT+3G1QgcLywNvO80Hsaz6UpuzcTckMGYefN+IotGs=;
 b=K0ZRn/vwBSA81RUD3MThlQhp2sx4O1/WgOR5SptqJIpl53Q+79U0pRFUUrFz97p0E/jf6+MBrAH3UJZh5ysaLeO06DRGBOLwVM+2k+gILR/qSes9BnvlBIUzTVlxgY8scKTBVN/GJ6ZUpdcZEFwwf2nlzw0YJm+t/+ZXYEVFJM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB8108.prod.exchangelabs.com (2603:10b6:a03:4e1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 21:38:38 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0025.023; Wed, 20 May 2026
 21:38:38 +0000
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
Subject: [net-next v43] mctp pcc: Implement MCTP over PCC Transport
Date: Wed, 20 May 2026 17:38:30 -0400
Message-ID: <20260520213831.118082-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0197.namprd15.prod.outlook.com
 (2603:10b6:930:82::24) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1ab1e1-3343-41b7-9fa7-08deb6b82736
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|55112099003|13003099007|56012099003|18002099003|11063799006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	9ufOdEeuVdOdei0eO2UWICyduEx2VSE+tou1ALQGPtcuxj3YgvskzIZsOIa5StRUQE9LSPiPhjPrNvXt80oNW/2/EhZfUk50R/sCA/SOZPdAwuLvAkIwSh/zolyeVUISgLjNWjMata/Y5P3DVAow1my5L5pznTFo4Skc8ph8HhmLoSyT7ig/XYcK6QXUHvvH8LuV+DRhTIGp/lnhehVe5ukfPJ8iA8WwQDfBfIsXxSs/wUh8BmhwmZVb8FaC+1xccuvBR407kBVVdeDQ1hq1yzvAcUE3xZcZEJl1VTZl4KNG2XQQWB6foxB0Ktf2B/oHFGLQ+0cmXRH7xYsEK0jzpPHTaHdL4n8A/4/L/d917y1PItahLY4kTQ3djEcmEVpit8npgmN7w3J3DPBCEE5SupgCv2a+BF+5yq9zn4v4mHLgXMnRlRv0eyJ/icvvyUVsLfblRHRI0NFJMQCYExHhxNgUfk4bDZoAJfdy+JB58kb3Z0kr9ZH72cQMHzAJdl83gwm8wdYuUizqzAqm/C8CuQqR4vEWvd+xsoHoPMShprcQrc7no4ztyuxNPJVduY/B6VSEu7Xyqu/JC0BBO/ynEl+HcGfDMRVhWZ3xtEKzG6ReBxFJkdOeWWNfwHNFXvV9Bfa7QLfIblOsN0Ycy/KWujZYT7x47oBT0HNOe5qn0aRSPqA19zFwfRzEZGwXXYRuRB8tG1S82saUd9nSE6jLwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(55112099003)(13003099007)(56012099003)(18002099003)(11063799006)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kD4irG9XYRw/ettUA1r/mnRVGsvCSYGf/M4b9nODc1BPlmuV+7OTXXa2+YxD?=
 =?us-ascii?Q?excItntBcUHO7iJHXO+xtfw7xvtXvqegePV2HhwwlbG6Fq/6prnHtOzubj3e?=
 =?us-ascii?Q?6kFUOmYmP4BxUIbbkaHBmU14hafXBU4OtHzivaeeXrtbWacuCt93iIVqgQQi?=
 =?us-ascii?Q?HGdqAwNsernVjpF7OMcndoNHhwjcB0StlzOth/43yV/vOxwwxNf9HQXDhAy6?=
 =?us-ascii?Q?fcA2DV4hZTM6ylZC9vR2xbAo7v83A2A1py0mbhyUkCAi/Ku7cf1C5soPoYWT?=
 =?us-ascii?Q?7ai0hC4PbbWBIfa5twQqMy2sOezNcQhL48VtZK1uabZMrLdH7FIyjIr7v24f?=
 =?us-ascii?Q?PLASArsrG3euldbsIH1S5CsI+cwYB7ifzIv7UdhL6WS00SjKARJKBUYKleXL?=
 =?us-ascii?Q?Fxrn5SkH3WCC+Qlhav8qqxZ3KocOd99ulZxd49GJGiMeLBlbDrzTj2nb4kaC?=
 =?us-ascii?Q?UG8Tc6VWbAjg7FhNmb7OY9LSQ/24QRSuCwTjyxQdyLY4Adcw59Ib8tczc9v0?=
 =?us-ascii?Q?n8uFg1oCRr7ISt1Lb4J0lFqR+B4o0ZAvCAggzU2l7/DNrkEjCzURotvVa2JY?=
 =?us-ascii?Q?xaqjZ15iJkAyLhT0y9qg01X9Alqg/SMWLHKAtWrrMj2xSoERtAj5vkiMbKOs?=
 =?us-ascii?Q?QSz7bOjWtgbGzwXqZwg5KAjgjy3xeh1EG+CI9kxAHR5qsS3KQpUIG/SNnvil?=
 =?us-ascii?Q?mXHoLZwR9LoOEmoW1z5hmUxokffVnoiO6FAqXkA2OgXzF1pEweeAqPCHtIRI?=
 =?us-ascii?Q?OmLV/WULkUEHsLQKw7FtbCl305IIFcNN0bweEW3f48vsdLGuwpNWv1A2NIff?=
 =?us-ascii?Q?+3DnWWC9SqER3TrMYyNwMG5JDiUEPI+OA1i1KgDLkGbbz2gOBGiviAP5SQRJ?=
 =?us-ascii?Q?tf9O5JvEWEghxtz/oC5/oplZ01YL72W3rn0RyCzePMviBvdjYgeIW6dt/5ES?=
 =?us-ascii?Q?BDjA/R/w209cq/pnFbIm7aEzApBQTdU+nONAFzg/gVnT3uuRl/0Tf6KJqCBT?=
 =?us-ascii?Q?beW5ZJntd5NvahMfBd+++QanpOv//Bl2lhyC92b/+A5Ca5GcPfaQF3G4csFY?=
 =?us-ascii?Q?N3NASF3Ty1o9Ln2Pfqb6k9USVzJg3Vk3Pm08qFxsOwC+i3pxBHx0ufjDGTqq?=
 =?us-ascii?Q?yop6S9Gil8JHMh8a0drG46bYnOTA1Qdm5E31jM2a8Mu5SLtRPsPcTdIBwEMn?=
 =?us-ascii?Q?/RBBbTDOMNrl7E6T+qjLkVvsRDRLluLzTygIcYsEBFCIpVbS7SiNyxTnUtCw?=
 =?us-ascii?Q?TB6FtuH5G/201BUyy2eATTmA42dEZJkR0vUIocv6lHESzjhjc7RNimBnaeHw?=
 =?us-ascii?Q?ARb8tzb/OySSRS4YFMeyll02Y6GDDGHmsAIkpFDK4lE9OknKAsrsXcFGpa52?=
 =?us-ascii?Q?GjxyPs1fPfE27/qZy8fC9ThSxPV2RhU3EMg7j27WsfQcR/YeeSk49pDxFHyk?=
 =?us-ascii?Q?iBxc3yiYOt02yYRandCVIQU3jZO57XqUK2jCQ4LAmTo96x69y48SI0N6LP0Z?=
 =?us-ascii?Q?xSSxGeQdez5JqSlaI9TwIx3TE5V1GaptMxyaNTHQKiJfpcNLln4rvXKQMYqq?=
 =?us-ascii?Q?CbBJ183dPLA4U94LN2l4o9UR5m1NcaTkqVb/MHoPaBxwnN5Dg+0cEq9kewOy?=
 =?us-ascii?Q?HsqebBWY5NCrWy0cWrops5KZPdlqM//RCQe+NRAzRAL5K+B21gjLBSn3wZv/?=
 =?us-ascii?Q?jPOqqLqhb+k3I+eME+C7U+BHhVIa2rLT1xkAUkS1nH4/h/07mcIficATTWp7?=
 =?us-ascii?Q?7cRyqj0aoQIuZMKpLUtHfS2VL3lUIhwJtJ35bTs8mpL0+abT1pdHdP56wr2U?=
X-MS-Exchange-AntiSpam-MessageData-1: ZfM77cuw1ZZi9Q==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1ab1e1-3343-41b7-9fa7-08deb6b82736
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 21:38:38.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6Awfhc1yY0J4meuU65VcdLQol3z4KEmPfe3wg5tQMiSzTmzTIbJuNkR80CqSXQ6Yuetw808e+fIqzuWsVIGZVEmjhuY/XaePkztz64S1elAw1I3+h+a/4Epl3pOQ0K3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8108
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290112-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amperecomputing.com:email,dmtf.org:url]
X-Rspamd-Queue-Id: A979559B26D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Previous Version:
https://lore.kernel.org/lkml/20260510163228.443778-1-admiyo@os.amperecomputing.com/

(Version 42 was identical to this version but had a spurious extra file)

Changes from Previous version

Remove call to skb_linearize(skb)
Spacing changes after gotos
move final check of packet length to tx function
use irq safe stats update in tx_done for sent and dropped
mctp-pcc retry send_message to avoid permanent network stall
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  16 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 426 ++++++++++++++++++++++++++++++++++++
 4 files changed, 448 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5db1a2923dd2..f6df8dce41f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15415,6 +15415,11 @@ F:	include/net/mctpdevice.h
 F:	include/net/netns/mctp.h
 F:	net/mctp/
 
+MANAGEMENT COMPONENT TRANSPORT PROTOCOL (MCTP) over PCC (MCTP-PCC) Driver
+M:	Adam Young <admiyo@os.amperecomputing.com>
+S:	Maintained
+F:	drivers/net/mctp/mctp-pcc.c
+
 MAPLE TREE
 M:	Liam R. Howlett <liam@infradead.org>
 R:	Alice Ryhl <aliceryhl@google.com>
diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..e68d23794a80 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,22 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	depends on PCC
+	depends on 64BIT
+	depends on CPU_LITTLE_ENDIAN
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
index 000000000000..2570cd379966
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,426 @@
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
+
+	if (header_length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
+		goto error;
+
+	// If the reported size is larger than the shared memory minus headers,
+	// something is wrong and treat the buffer as corrupted data.
+	if (header_length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
+		goto error;
+
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
+		goto error;
+
+	size = header_length + PCC_EXTRA_LEN;
+	skb = netdev_alloc_skb(mctp_pcc_ndev->ndev, size);
+	if (!skb)
+		goto error;
+
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
+	return;
+
+error:
+	dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+}
+
+static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_header;
+	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
+	int len = skb->len;
+
+	if (skb_cow_head(skb, sizeof(*pcc_header)))
+		goto error;
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	if (skb->len > mpnd->outbox.chan->shmem_size)
+		goto error;
+
+	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) < 0) {
+		netif_stop_queue(ndev);
+		/*
+		 * There is a possibility that the mailbox was cleared on
+		 * another thread between the failed send attempt and
+		 * stopping the queue.  If that is the case, and we don't restart
+		 * the queue, it will remain permanently stopped.  To test,
+		 * try submitting the message again. If successful, restart the
+		 * queue.
+		 */
+		if (mbox_send_message(mpnd->outbox.chan->mchan, skb) >= 0) {
+			netif_wake_queue(ndev);
+		} else {
+			// Remove the header in case it gets sent again
+			skb_pull(skb, sizeof(*pcc_header));
+			return NETDEV_TX_BUSY;
+		}
+	}
+	return NETDEV_TX_OK;
+
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
+		netdev_warn_once(mctp_pcc_ndev->ndev,
+				 "%s called with null message.\n", __func__);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem, skb->data, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int rc)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct pcpu_dstats *dstats;
+	struct sk_buff *skb = mssg;
+	unsigned long flags;
+
+	/*
+	 * If there is a packet in flight during driver cleanup
+	 * It may have been freed already.
+	 */
+	if (!mssg)
+		return;
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+
+	/* Use an IRQ safe update as this is called from HARD IRQ instead of
+	 * dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
+	 */
+	dstats = this_cpu_ptr(mctp_pcc_ndev->ndev->dstats);
+	flags = u64_stats_update_begin_irqsave(&dstats->syncp);
+
+	if (rc) {
+		u64_stats_inc(&dstats->tx_drops);
+	} else {
+		u64_stats_inc(&dstats->tx_packets);
+		u64_stats_add(&dstats->tx_bytes, skb->len);
+	}
+	u64_stats_update_end_irqrestore(&dstats->syncp, flags);
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
+	if (outbox->chan->shmem_size < MCTP_PCC_MIN_SIZE) {
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
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_open,
+	.ndo_stop = mctp_pcc_stop,
+	.ndo_start_xmit = mctp_pcc_tx,
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


