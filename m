Return-Path: <netdev+bounces-275474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YsBODP2k0mmmZQcAu9opvQ
	(envelope-from <netdev+bounces-275474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 20:07:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E09639F41B
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38CB2300678E
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F692777F3;
	Sun,  5 Apr 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mJmsv/0N"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021082.outbound.protection.outlook.com [52.101.57.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8414884C;
	Sun,  5 Apr 2026 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775412473; cv=fail; b=TC9dNVfTU4bjzwxIn5xaS500iD/WOYm9N2MaW5Ao/6+Mp/Cpls8S7Gq1IONTp3l7A2n3n3ayEsZVorhKEgAFGTVIeeFm1wDg0WStKr2iPk7EPIKxWbOj1W7pddgFQoPy0D9BWYw0ukkOuM4WzoYR4+Xi19BiTtKcPq6Q1HjoPWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775412473; c=relaxed/simple;
	bh=E6CpPRWYyIfkzMYQY6/0lrwURZZU8yO/f0S9IuFHn54=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pYgbJDJmDOGRwDv7jlcRQuXMfWKbhMMlGVfeRFvZMSV5K+LP4ZcA3JNZUdtclZcn5/kpPWpzeIKdQO6N59B/K8wn+fxrG1FoA6bfcRtaIEzEq/nbSyXOPIZ88uZp+HZb9j+4Q1zbVOLDb4qLygXiPSv9PpJxlti95d3hhyoCzYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mJmsv/0N; arc=fail smtp.client-ip=52.101.57.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w13uF7BCgfTkl7QE/Hl0YIgSq+Dk/2lw+W2ojJxXzmwTTjWTX0lMWyCAyXneCOq0xzaObzRNVj8qciKaqyC5fYjxEtyXLU+PVIxM/96ckHQlud6frYec+YtoGy9QbY498XNuJUwpSRP0+6t++4GMwaA/NnC8TUVbFNIIv+FNn0otCgbaTBY2wpQKHIcq6EcvJyxyAAYpJCdZgsKKAOKAwxQhYjCE0rgTNYb6N5OWdsUzRt465j7C6Bn35MsecgblgHCDbPjk5PrxG7+D2ntnGZ1qR/K8Lel962lY0cqriObB5NkBd8CTGJSCXr4QXIUXbqtgwQ/kxQn4HQX1DrjTGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAPZtF+N/vuYyh/FSZnZtHj1jlVjLuO5nnf9R8SHAd8=;
 b=f5TzOT/fhkBae7ADS7u37+7NzBCCq+ERl/w9VybPiF7Aw9OY+grHmO15b/yI1gj1T81/aXkMjc18PQzyV9si9fe+PnC3JXrbC5sCwSzi6Lm6SBr1ST2HTFy9bwjenIji4XnxbU+B9+XQ27s7nRo2+hWP50zIA7gNKMbSgS3UPmYccdo5DpHgWmFunO2EcYwGdu0lhPKhPntppfX5SyoWrzAXXfs+k9FkoVoH5vg9qeHQfFDispRqAogaKRJDDhHLZfePjEto6xMJEdpCKcdtSzo59aE574IvWSVqM8+wt8vgU6oHUT0RXqIOIdTtR0rbS3XIVqSjrnoDVxy0Lk2vfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAPZtF+N/vuYyh/FSZnZtHj1jlVjLuO5nnf9R8SHAd8=;
 b=mJmsv/0N13gPJ02EYwxfrsPOWjPX6kVaHlmVCXFQcZdDel/XAJauWZjO3C809AZRDoMHbVWeyiMzllFoOCOsKKLDJJa3QE84xHoLnSnAt5AqnPo0X8hZNPUVVEWIazfaldySvHsEOqDGTKse2CZbxEEqs5sORllnwJcpoo3EOyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH2PR01MB9184.prod.exchangelabs.com (2603:10b6:610:27e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Sun, 5 Apr 2026 18:07:45 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.20.9769.016; Sun, 5 Apr 2026
 18:07:44 +0000
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
Subject: [net-next v38] mctp pcc: Implement MCTP over PCC Transport
Date: Sun,  5 Apr 2026 14:07:40 -0400
Message-ID: <20260405180741.1496198-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH2PR01MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: e840ef4a-45c8-4745-67fc-08de933e3ca7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|55112099003|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	B5Oe5vyOW8S7H+fNSnC5eynM96TW9AQt9NUpfkdfDKNZU3zLasKecgsHDmWK/0gMsVX9RGZeTgyQjIAbHatVADLvKmLY4PQ04O4P0teZYSP0gGcCPYPlXxBvdx5xb7U0XPP3hC/Sc7PYxeNlBQj1TJiBmstrxyrXWJOsMRlPmiQZBiB5z2wrfbLfSmrlDImdbhkqRaDwfs9y1zJ/OIEmMHFegAMeunxWaWK1QRWLsoB6jTcdxI5Skvs/8bf+bwK+vmxKOVvkCLxp5mdqqzNgcO4n6uGeQ7F3NqsG5tINDAlkmfcoZld8VKLOUPdnJyXEH8bZJDERudVKarsaW1V99bwddpfb76xxMvEO9h3SPKcyBY90MVFb7672d3EQiMRFjVk4+9JBYlqFbh+Xp6+j+BVEg+IIIXiCA22ey9ItP0BFxYkGh/PdO/rrM4gB1LrmLg6cev+tzTpXnuMnRmsrlzjBeNCxSeGrGFBGP/XH/NOOG/nuI21y0eTfLN5bmj8KRs13yOsGCVBngF9Gw56+g4w3lW3JarxFVv4k8zbnYiHERVwLYY/8xz3pKBa8HDzM2FDtnhyzWaPljaTNIEIoYRLH7Ocne4woSBxNcqdTXvEeyEDIlBv0O4ULkpUEWe0Ig14/onXadkl/us5TURJiSONDrX7pRPtHsqkogmqLZV/XqnpBWLr/61oPLDu4vFK5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(55112099003)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AT+x+8RjeyaRiEHWPCD89gNH3Y4z03v8N+URfyRv8rt9ttytFjQ6bmStWy1U?=
 =?us-ascii?Q?T5lTWL0Fcia7RsohHN2UbGXybpFFqneLhC/VJOFypVxncaXgkx33ABc51QqL?=
 =?us-ascii?Q?IbLpwozTitW207hseDv7qB6LgB6N6ekiothKCJszv0xkKy01zy9g8gApTtqU?=
 =?us-ascii?Q?FgkFcsknax/FglHdAfEScNNaIDaSpUV3OCeAc8qtP7xzNRon2L/XVh5kqQaO?=
 =?us-ascii?Q?YCpoGCZZ1b7XcqXd3HIqUE+N+6PNm4W0/YJHAAr1LukfL4ixE19yYGM8uP/K?=
 =?us-ascii?Q?agALzdBLrszGqW7BIJers54ik3bwhdF1/BfhWHvNix1bwq0dHNqISiZ9TUtu?=
 =?us-ascii?Q?2c0slFcu+MT05FBoFWwYkY49fzsz49Q1zVFk5Pe2JxigUy0+udyTvE5d/FOx?=
 =?us-ascii?Q?PSX4HIj3XkNvCZp1uCsSfxn+0v9RJpsCiql+LmTHRrKIIkl30/lv0EfHqhSE?=
 =?us-ascii?Q?4pS+ZPA2j5gLYzcpRU6czwzdL/3OxtGPW3dwbXS/w+klr82ckyhWu3wnEMLC?=
 =?us-ascii?Q?wblz3bTx4r5f+l+ITZydpHv6cm7a4UJnGfJggAO+rIMfiaoDGcYVtK0KpsWs?=
 =?us-ascii?Q?FWfeBCxhTO87ilmo3nRjhicB4MO0clhatnEXjt7H4RBdPagiw533YzuP4AKv?=
 =?us-ascii?Q?x0+KB+GSNe89hyUdp98yC7uEFmullgUjEx/PuxPX5vvk2gElptanwwr8TjyY?=
 =?us-ascii?Q?AWZx0UG6xJ3yeNgM+cclgz4yAEA948YijV/7hAdJiJc3n3KXnBa8Z82iELKo?=
 =?us-ascii?Q?dBxeCKyGsH0wFUmPs1dpjLjeJ0n39j/1Z5ugNLAQDDUMZzNNc5INz2WBp1G+?=
 =?us-ascii?Q?dDyfdXn7QAFTtnn1JiLMr+bVQtf8kKNSrpwjlGTEFeeHrU5F89aWntCGSjbP?=
 =?us-ascii?Q?M8q7SJeZqu9AKo1bt5kIAFsxQyvsYNk59vxQAmA0ZxDgwcHYQq61tv9dcfx9?=
 =?us-ascii?Q?xf9KTN6GQNwpZhLwJSctBJDMGjxSnzed3GYp/lqlduUSRW1sxsa3ysLQzXJw?=
 =?us-ascii?Q?eueRmTlE7+6yQIoVpvnoy5FSK2mSUAcE+4BBkpPFT67uGY1aLnIpvvqOyueM?=
 =?us-ascii?Q?ZeucOJBR+CEqOpqye61CtRAkBc+/456oRIBKBTFcFVij3b8BKM43S6iXr5mn?=
 =?us-ascii?Q?3VLxVQw0F+tIGEAuOICvfKVzs4raj+hnyh2LIw8jmhQXVc4Ps9IdCm4HdQIm?=
 =?us-ascii?Q?Vgg0ELYBGy0iLmASABBHj3k7WqLKnh+YTdDSEGwmHH77/G5oFmh2nrcAKVIJ?=
 =?us-ascii?Q?+o6ChX1gZHu18qMWVvipBS4rLu4ICLoWBpB0M8SZW4Cv598+9nZ4lR9VOn01?=
 =?us-ascii?Q?28apRGU8Y2D41w9nd/7/sI72Gy0gGauc18qO+jjuN+R4qYQ2UnHVLn6vVnxm?=
 =?us-ascii?Q?k+8nKEHi1vaK20mS/iB89ieF6ZI7/Q/mo+pbFx2F7AcFBvJIVQPz+uS9aPlh?=
 =?us-ascii?Q?SLPaAsq6M3J+6nQIshujE/UowKLa0Lym/zNGxiUxrckOnOGkiO0VF9Cp3+/n?=
 =?us-ascii?Q?yMPuJW0xco8ebDyVRZgVko3IxKhAeHqpCEeNTbJBk+j+SWOBrh6dB6aWwsfd?=
 =?us-ascii?Q?K9y6V8R74yKtBfaMbPZMrLT+ueDvgmUlz/j438n6yO8i6mt/VgSB6swVwR8d?=
 =?us-ascii?Q?jo1CTWI2xPvdrEDe1nEbXD8QQDMXUzE44dnD5Jvvpjb0kE2TcfjZs6w3ZPKK?=
 =?us-ascii?Q?Fitf7nGfbjFKtOf1aNCngu+s4d9Kab3INuygxwUkM3sI+Sok90qf+AwX5r81?=
 =?us-ascii?Q?2YLC1jdcxGl/IicYJLn0du+Naup6N5jsTM+8it3v/1Dhrt3dZtMhsP1wdpax?=
X-MS-Exchange-AntiSpam-MessageData-1:
	hel/Y3D6PuWxrhrpzh387CqrfUwC2ldypmhDMjNtC9IwmNWl5A9GxMzF
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e840ef4a-45c8-4745-67fc-08de933e3ca7
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 18:07:44.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u09Qrf4OXT96SqWBjzfvj63LEFRFtR10KF/cZBr0/CUomlvK/172Ql16SfXYGayw8sjqTFOE+aQnEur1/8ITEvHRFScy9O9g5I2asjk/tXfbXQKpLYhMStzxbgUkxXx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB9184
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275474-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dmtf.org:url,amperecomputing.com:email,oracle.com:email,uefi.org:url]
X-Rspamd-Queue-Id: 5E09639F41B
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

Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

---

Previous Version: https://lore.kernel.org/lkml/20260402212314.1364249-1-admiyo@os.amperecomputing.com/

Changes in V38:
- Release all struct sk_buff messages in Mailbox ring buffer when Network device is stopped

Changes in V37:

- Free Channel in error case during init MTU.
- Ensure Shared Buffer is > min-MTU + PCC Header

Changes in V36:

- added the CONFIG_PCC dependency
- altered the RX min length check to include at least the command and a MCTP header
- added a RX max-length check
- added a minimum MTU check
- altered the commit message to reflect PCC mailbox free behaviour.

Changes in V35:
- Removed spurious lines from commit
- Added context to commit message that was only in cover pages

Changes in V34:
- when checking size of the rx message, make sure it is not negative
- add size of the PCC header to skb bytes

Changes in V33:
-  Removed Helper functions in mailbox/pcc.c.
-  Used static helper function for writing to buffer
-  Inlined code to read from buffer
-  Corrected Copyright date
-  Moved networks stats to the end of prepare_tx
-  pull PCC header in MCTP sk_buff on error so not duplicated

Changed in V32:
- removed unused outbox variable in mctp_pcc_tx_done
- formatted mailbox/pcc.c kernel-docs IAW script

Changed in V31:
- Use predefined Header structure for pcc Extended buffers
- Rebased on top of changes for PCC to handle ACK interrupt and tx_complete
- Fixed formatting in mctp_pcc
- use netdev specific log function
- removed condition around dev_consume_skb_any(skb);
- initialized ndev->hard_header_len with sizeof PCC header
- removed spurious mctp_pcc_ndev = netdev_priv(ndev);
- Rebased on 6.19

Changed in V30:
- rebased on revert of mailbox/pcc.c code
- Explicit patch for dealing with PCC Type 3 ACK Interrupts
- PCC buffer management moved to helper functions
- PCC helper functions are explicitly called from Network Driver
- Removal of sk_buff queues
-

Changed in V29:
- Added a callback function for the mailbox API to allocate the rx_buffer
- The PCC mailbox to uses the Mailbox API callback instead of the PCC specific one
- The MCTP-PCC driver uses the Mailbox API callback instead of the PCC specific one
- Code review fixes for language in comments
- Removed PCC specific callback

Changes in V28:
- ndo open and ndo start create and free channels
- Max MTU is set in create
- Reverse XMass tree rules complied with
- Driver no longer has any auto-cleanup on registration functions
- Tested with KASAN

Changes in V27:
- Stop and restart packet Queues to deal with a full ring buffer
- drop the 'i' from the middle of the link name
- restore the allocation and freeing of the channel to the driver add/remove functions
  leaving only the queue draining in the ndo stop function

Changes in V26:
-  Remove the addition net-device spinlock and use the spinlock already present in skb lists
-  Use temporary variables to check for success finding the skb in the lists
-  Remove comment that is no longer relevant

Changes in V25:
- Use spin lock to control access to queues of sk_buffs
- removed unused constants
- added ndo_open and ndo_stop functions.  These two functions do
  channel creation and cleanup, to remove packets from the mailbox.
  They do queue cleanup as well.
- No longer cleans up the channel from the device.

Changes in V24:
- Removed endianess for PCC header values
- Kept Column width to under 80 chars
- Typo in commit message
- Prereqisite patch for PCC buffer management was merged late in 6.17.
  See "mailbox/pcc: support mailbox management of the shared buffer"

Changes in V23:
- Trigger for direct management of shared buffer based on flag in pcc channel
- Only initialize rx_alloc for inbox, not outbox.
- Read value for requested IRQ flag out of channel's current_req
- unqueue an sk_buff that failed to send
- Move error handling for skb resize error inline instead of goto

Changes in V22:
- Direct management of the shared buffer in the mailbox layer.
- Proper checking of command complete flag prior to writing to the buffer.

Changes in V21:
- Use existing constants PCC_SIGNATURE and PCC_CMD_COMPLETION_NOTIFY
- Check return code on call to send_data and drop packet if failed
- use sizeof(*mctp_pcc_header) etc,  instead of structs for resizing buffers
- simplify check for ares->type != PCC_DWORD_TYPE
- simply return result devm_add_action_or_reset
- reduce initializer for  mctp_pcc_lookup_context context = {};
- move initialization of mbox dev into mctp_pcc_initialize_mailbox
- minor spacing changes

Changes in V20:
- corrected typo in RFC version
- removed spurious space
- tx spin lock only controls access to shared memory buffer
- tx spin lock not eheld on error condition
- tx returns OK if skb can't be expanded

Changes in V19:
- Rebased on changes to PCC mailbox handling
- checks for cloned SKB prior to transmission
- converted doulbe slash comments to C comments

Changes in V18:
- Added Acked-By
- Fix minor spacing issue

Changes in V17:
- No new changes. Rebased on net-next post 6.13 release.

Changes in V16:
- do not duplicate cleanup after devm_add_action_or_reset calls

Changes in V15:
- corrected indentation formatting error
- Corrected TABS issue in MAINTAINER entry

Changes in V14:
- Do not attempt to unregister a netdev that is never registered
- Added MAINTAINER entry

Changes in V13:
- Explicitly Convert PCC header from little endian to machine native

Changes in V12:
- Explicitly use little endian conversion for PCC header signature
- Builds clean with make C=1

Changes in V11:
- Explicitly use little endian types for PCC header

Changes in V10:
- sync with net-next branch
- use dstats helper functions
- remove duplicate drop stat
- remove more double spaces

Changes in V9:
- Prerequisite patch for PCC mailbox has been merged
- Stats collection now use helper functions
- many double spaces reduced to single

Changes in V8:
- change 0 to NULL for pointer check of shmem
- add semi for static version of pcc_mbox_ioremap
- convert pcc_mbox_ioremap function to static inline when client code is not being built
- remove shmem comment from struct pcc_chan_info descriptor
- copy rx_dropped in mctp_pcc_net_stats
- removed trailing newline on error message
- removed double space in dev_dbg string
- use big endian for header members
- Fix use full spec ID in description
- Fix typo in file description
- Form the complete outbound message in the sk_buff

Changes in V7:
- Removed the Hardware address as specification is not published.
- Map the shared buffer in the mailbox and share the mapped region with the driver
- Use the sk_buff memory to prepare the message before copying to shared region

Changes in V6:
- Removed patch for ACPICA code that has merged
- Includes the hardware address in the network device
- Converted all device resources to devm resources
- Removed mctp_pcc_driver_remove function
- uses acpi_driver_module for initialization
- created helper structure for in and out mailboxes
- Consolidated code for initializing mailboxes in the add_device function
- Added specification references
- Removed duplicate constant PCC_ACK_FLAG_MASK
- Use the MCTP_SIGNATURE_LENGTH define
- made naming of header structs consistent
- use sizeof local variables for offset calculations
- prefix structure name to avoid potential clash
- removed unnecessary null initialization from acpi_device_id

Changes in V5
- Removed Owner field from ACPI module declaration
- removed unused next field from struct mctp_pcc_ndev
- Corrected logic reading  RX ACK flag.
- Added comment for struct pcc_chan_info field shmem_base_addr
- check against current mtu instead of max mtu for packet length\
- removed unnecessary lookups of pnd->mdev.dev

Changes in V4
- Read flags out of shared buffer to trigger ACK for Type 4 RX
- Remove list of netdevs and cleanup from devices only
- tag PCCT protocol headers as little endian
- Remove unused constants

Changes in V3
- removed unused header
- removed spurious space
- removed spurious semis after functiomns
- removed null assignment for init
- remove redundant set of device on skb
- tabify constant declarations
- added  rtnl_link_stats64 function
- set MTU to minimum to start
- clean up logic on driver removal
- remove cast on void * assignment
- call cleanup function directly
- check received length before allocating skb
- introduce symbolic constatn for ACK FLAG MASK
- symbolic constant for PCC header flag.
- Add namespace ID to PCC magic
- replaced readls with copy from io of PCC header
- replaced custom modules init and cleanup with ACPI version

Changes in V2

- All Variable Declarations are in reverse Xmass Tree Format
- All Checkpatch Warnings Are Fixed
- Removed Dead code
- Added packet tx/rx stats
- Removed network physical address.  This is still in
  disucssion in the spec, and will be added once there
  is consensus. The protocol can be used with out it.
  This also lead to the removal of the Big Endian
  conversions.
- Avoided using non volatile pointers in copy to and from io space
- Reorderd the patches to put the ACK check for the PCC Mailbox
  as a pre-requisite.  The corresponding change for the MCTP
  driver has been inlined in the main patch.
- Replaced magic numbers with constants, fixed typos, and other
  minor changes from code review.
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  14 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 367 ++++++++++++++++++++++++++++++++++++
 4 files changed, 387 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2ffd9d37d5..1813a2126cc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15288,6 +15288,11 @@ F:	include/net/mctpdevice.h
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
index cf325ab0b1ef..4503152c70bc 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -47,6 +47,20 @@ config MCTP_TRANSPORT_I3C
 	  A MCTP protocol network device is created for each I3C bus
 	  having a "mctp-controller" devicetree property.
 
+config MCTP_TRANSPORT_PCC
+	tristate "MCTP PCC transport"
+	depends on ACPI
+	depends on PCC
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
index 000000000000..e62f572d066c
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,367 @@
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
+#define PCC_DWORD_TYPE          0x0c
+
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
+	int size;
+
+	mctp_pcc_ndev = container_of(cl, struct mctp_pcc_ndev, inbox.client);
+	inbox = &mctp_pcc_ndev->inbox;
+	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
+
+	// The message must at least have the PCC command indicating it is an MCTP
+	// message followed by the MCTP header, or we have a malformed message.
+	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr)) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	size = pcc_header.length - sizeof(pcc_header.command) + sizeof(pcc_header);
+	// If the reported size is larger than the shared memory, something is wrong
+	// and the best we can do is treat it as corrupted data.
+	if (size > inbox->chan->shmem_size) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0) {
+		dev_dstats_rx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+
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
+	int rc;
+
+	rc = skb_cow_head(skb, sizeof(*pcc_header));
+	if (rc) {
+		dev_dstats_tx_dropped(ndev);
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	pcc_header = skb_push(skb, sizeof(*pcc_header));
+	pcc_header->signature = PCC_SIGNATURE | mpnd->outbox.index;
+	pcc_header->flags = PCC_CMD_COMPLETION_NOTIFY;
+	memcpy(&pcc_header->command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH);
+	pcc_header->length = len + MCTP_SIGNATURE_LENGTH;
+
+	rc = mbox_send_message(mpnd->outbox.chan->mchan, skb);
+	if (rc < 0) {
+		//Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		netif_stop_queue(ndev);
+		return NETDEV_TX_BUSY;
+	}
+
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
+	if (!skb)
+		return;
+
+	if (skb->len > outbox->chan->shmem_size) {
+		dev_dstats_tx_dropped(mctp_pcc_ndev->ndev);
+		return;
+	}
+	memcpy_toio(outbox->chan->shmem,  skb->data, skb->len);
+}
+
+static void mctp_pcc_tx_done(struct mbox_client *c, void *mssg, int r)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	struct sk_buff *skb = mssg;
+
+	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, outbox.client);
+	dev_dstats_tx_add(mctp_pcc_ndev->ndev, skb->len);
+	dev_consume_skb_any(skb);
+	netif_wake_queue(mctp_pcc_ndev->ndev);
+}
+
+static int mctp_pcc_ndo_open(struct net_device *ndev)
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
+	inbox->client.rx_callback = mctp_pcc_client_rx_callback;
+	inbox->chan = pcc_mbox_request_channel(&inbox->client, inbox->index);
+	if (IS_ERR(inbox->chan)) {
+		pcc_mbox_free_channel(outbox->chan);
+		return PTR_ERR(inbox->chan);
+	}
+	return 0;
+}
+
+static int mctp_pcc_ndo_stop(struct net_device *ndev)
+{
+	struct mctp_pcc_ndev *mctp_pcc_ndev;
+	unsigned int count, idx;
+	struct mbox_chan *chan;
+	struct sk_buff *skb;
+
+	mctp_pcc_ndev = netdev_priv(ndev);
+	chan = mctp_pcc_ndev->outbox.chan->mchan;
+
+	scoped_guard(spinlock_irqsave, &chan->lock) {
+		chan->active_req = NULL;
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
+			chan->msg_free++;
+		}
+	}
+
+	pcc_mbox_free_channel(mctp_pcc_ndev->outbox.chan);
+	pcc_mbox_free_channel(mctp_pcc_ndev->inbox.chan);
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcc_netdev_ops = {
+	.ndo_open = mctp_pcc_ndo_open,
+	.ndo_stop = mctp_pcc_ndo_stop,
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
+	if (ares->type != PCC_DWORD_TYPE)
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
+static int initialize_MTU(struct net_device *ndev)
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
+		return -1;
+	if (pchan->shmem_size < MCTP_MIN_MTU + sizeof(struct acpi_pcct_ext_pcc_shared_memory)) {
+		pcc_mbox_free_channel(pchan);
+		return -1;
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
+	rc = initialize_MTU(ndev);
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


