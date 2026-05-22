Return-Path: <netdev+bounces-290915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHpyF0GwEGoycgYAu9opvQ
	(envelope-from <netdev+bounces-290915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:36:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A02BA5B9757
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 21:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31C9A300F9F8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB336729D;
	Fri, 22 May 2026 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OhEyrqhG"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022128.outbound.protection.outlook.com [40.107.209.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819E349CCB;
	Fri, 22 May 2026 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779478590; cv=fail; b=pdxGRqK4gU/RUN5rniNWesSjBaaJryad0Wl8WFPr4rR0gYeYrzjRM+yjV511/He7KlZsG8e8x36YNw597iTvi6G6LNwJjO3v7cnpoVBz8d7kFXYr+HvkUe5tbnaNhnemumpV+ZNZd6U4b20X78zlJdMiOTw8+j8KbjwJd9rEFHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779478590; c=relaxed/simple;
	bh=SLB8KldDkINriLdmLf0hix7z6jhfmX2ASX5MM/I7nF8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rrDCTo/HUDrqtMPezZ7h8Tyl8hAW2bbUCOKSKOQ/T6M3KSNtWStdDa0Ut/Y4WXoTVhAc6moODMWbqW7ldpLntmiRPAz43Te2IFJiN/zxMlOMTZXO23K6BfiSWvvu+ert2mBV5wF3gRBw18gRbLKd2U+6tE0g/90ey19CKtNlKG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OhEyrqhG; arc=fail smtp.client-ip=40.107.209.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGDHMYPbtZG8yFMkeHxtCMPqI5/wOmoVTVqhHKXmm6c1fjQx4edcLMLctvQAyuCkSgWKGSCUu21cm20bvclEeI8pE6UOLaSkbrJj+hVKCHDLwKUwyuaAHxkP1yWG6+UIlz1zLT0zv648NiARI/0h/vYlnaQXROi/+WdhlLShBwfvuI+/gmLtjunDC2rObT0gpjTmMPD3FlodcKiuVTP1iWGvnOe9oGv88XLZNjTK7GKCUucghdEtLYiTccgbMMvOHWagso2Arg6hUyUhhrNm8BBCKrbMEHGENFqf/d5gkdebMSSJnmc7pxKTzNfiDJ4uk1wIfL9qudf6vwPC4VAIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haRR5HY1kkE6L7sSHRMhJBLgmiptuauiTc5rWOmZQzo=;
 b=CDdZ9+BXmMcAdto2A7ykOYxdeUn+gzfHnyRFnwFeSNUKMD+Y93w8mYWJSItLAGgS6SprCht/7/pNjaW3tTXj5FUtIehI4H3D4c+hRHsOk+KD0zSwS47WRTzd9zQ6ZBJV3FkFMYqXAXtvG2OEgkmeJb+WhCuY58dBlC+FQn0jy/kStaXJT395fLTX/EZK7iRXXgabQUA0m/+IAJwDe7xPCHboJRX7x/eBpt/3Gsf+KkIkyeWMV48S69zcnOnJezRzLlHJHz2ON0qprG3s+/F9TBe+4uGTKKuUnB+UreZk1H/ThPYSsNhjQazo7u+L2whgw9CEeoseL9ieohojfxNd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haRR5HY1kkE6L7sSHRMhJBLgmiptuauiTc5rWOmZQzo=;
 b=OhEyrqhGs+6/B7Di7kWVGZ4OBPTmz6Yz9PIErXGuRcMovuvzcYLu6aepIl8x/h1ZFyrPcPSlANlXHBt1zuTgIYfuWYd/4266Zc083Sul/x4L8QFzmspSWiW85CqMe80J2QAPtY5UZ19o0FR+vW7r67jL80R84FL9M7J1IOgcXM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 DS2PR01MB9328.prod.exchangelabs.com (2603:10b6:8:275::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 19:36:16 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 19:36:15 +0000
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
Subject: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
Date: Fri, 22 May 2026 15:36:09 -0400
Message-ID: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0026.namprd14.prod.outlook.com
 (2603:10b6:930:a0::8) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|DS2PR01MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d922dc8-83c6-4a68-2b4a-08deb8396387
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|10070799003|376014|6133799003|13003099007|18002099003|56012099003|3023799007|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	15KguGlIyprhfGblZgVXQMtzjQfiitIvvQuAChIdanTBDpa0ltCqe/Xzd129smmV6gdDfvX1k7Nl1SDls7x0ObfpvirnavU0IPk5ZLuTgzkyhtgj4kQll3Il46mJNyubYmtAQiL+E5vlGDzIJjKHN4xhUY5UmF+IjSvsF6xx1c1xMcF8zgFmOtua96RmaNxo2ofUcggjI92tbZTWvjvvCwL5fRHwgEay19XwWBthSDyJ75mMm4dYPN5x413lyhG9Xhpu7G1ZhxqhgScnhAM9jODzNYV6lVxP2cwqmLVHm8xL51k3B/J+4Buk5wNjbSlFyT2/oI7RiRjZq7uxk2RFE4QGVWpq9c0zotBQjlDrybd95h6ocA0kCJPgDwpngMLQq/He+3GI3Uo7McMyleaVDgryAqFJnqQSXG7pofIiM9Gd44ICKcjkgFcJ1k/IULNR+3cBfrCJMJLkSkWvdo1dbGj+n8/WK9zUVq4tlLIPvRBJquWPGSobobrDKMexGwXfkpI4nNGxIBuXW0vcmfxOwNn8VwIxWye9JGPmS0K8lgwbPI2NvlfK1Fum0DkAchKJmnkULC/nRdHRAfhyX+j0F99TyhWAgJaFxGfTAyg6v2wJRJ6hXcNNhf1TR0kS+ZGxpbRKJzwn96RevMUIix3fisEp1t6gPtacs3vpsaQXaIjG51efSjtU4gsQ1qCMwkevd7kY9YCzc3CCbhRkVKlr5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(10070799003)(376014)(6133799003)(13003099007)(18002099003)(56012099003)(3023799007)(11063799006)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SVmkJa7EDSBsbOlRS3iO5gXcx/KAuEdCwEfjHPc9VHdLvbPb+kBLZxyyAFkY?=
 =?us-ascii?Q?PIYLQt+qAK/GN0XfHbKZsomuHbbFRJMElgqZMoCDoMJ5wp0U6UeP1ykfnzCu?=
 =?us-ascii?Q?DP/jfJKbbVAFs/re46Bvu3A6s64ReeX85vfSXRu1oWj3+iqKWn5vB/zX6L0f?=
 =?us-ascii?Q?/fvTZawWKLktC4tS9yQ4hSmG72vf7HjAu9zzOvsB50TSempHMqaBtsE43u1u?=
 =?us-ascii?Q?rYvc7T1yit+t/aLkuhCHERjIOxez7yZperYEfSUehP9KpYGTB4SbsXj72oaW?=
 =?us-ascii?Q?eKpzU4Xmed0+YTD4LiwZHTk5/IFFqQ2ReoH6dXQ5qAPCu+4/MECq+X6YPghZ?=
 =?us-ascii?Q?rIsk8yXPX/DbgLNWLMbgGF+EYCkbSDqi+iVH/994afX+mJUj8QRyP59Xp8gF?=
 =?us-ascii?Q?FLckyJpdoYxdbju5LB4j/DzVCZMuiY5WkDedWHV5ZNeEeDerFb6kN4eKtAN7?=
 =?us-ascii?Q?QqASZ059SWTX8HpA6LBASNCtAGB3PJWi6HGreY0e/wRRK1BeIEYfQs0nOf2N?=
 =?us-ascii?Q?2nQwP6BNJtH3Tk2HtVk1a/8l1IYdrJjrDl89lNFJNgb835Uj3Fl8yvRnyXI1?=
 =?us-ascii?Q?QUBN1FLaCPLXoAaszdVSTu/qRMzsX7jbjj5opVBd1BtrI+XqqR9yLaK7XpV4?=
 =?us-ascii?Q?mx6+BQa/cHYtNJnUrGOKmO2cDAeRwJDZyqiBNdr0I8JL57BhicINsXoBvsvf?=
 =?us-ascii?Q?0innLs4k2v8SNR2hLwQ7/i21eQiygThXjBJXUhrrJPM36r/jS3ahk1DehbXM?=
 =?us-ascii?Q?NjUgJBrYimpkfy/VlCYV1PMWl/d8vAIVNE76reYzB6L1JAv/KEJAEEjBDz97?=
 =?us-ascii?Q?ENsprwYw6N/CQb6u5xXpek8llM9MpYtD6NQuLXvkwQmycLIFP/AifyXljUq/?=
 =?us-ascii?Q?EjpC7Ck6b8lOfJa5A7efY56boNvWhsuHx9yYjTNW0E2Tul2vpkt7d1qBokiT?=
 =?us-ascii?Q?13+kN82HSbAJgvTtRPH6VZxwU3xLhH/m5Hhr4GyNhu+Q31XRMyEOnTDfwKED?=
 =?us-ascii?Q?HD1OxJ2isXmXwhcTgJfSBGdRteuYNjruqgnZP7k/NqSQld2+IZljhJBalEQB?=
 =?us-ascii?Q?VwcwJqGcH6Honej8PXM3EgbBjHvFfiR1MXdd7WFuOWOK/SV8toxIK6R2iIzA?=
 =?us-ascii?Q?RzzahnKTjkQBA06gNwQUzT5HK1n/kLXKFC2go/oOpJ5O6CozzDddI7MC/EA7?=
 =?us-ascii?Q?e5neTJITGEPcH24wHc1DiLrWlTqQMcMNU98cxLGMMI5NSbGNOUp3h2FBSNl3?=
 =?us-ascii?Q?Krv2KkN+gF73CyFEIFUFmUAUItl67RX06xC/4FAC5i+4ODfo3QxghOYVxCFL?=
 =?us-ascii?Q?IZa7RmMmsU5hPcHXfGwepsjmy17rfloDRFvV7gTy9UrVWYtLoeVhNJqiYLx1?=
 =?us-ascii?Q?PfKbC/h3//SHT6ZPyjo+dpJSeES2wkBWosgU1Tc2gUmn2AUscldGIUqANEY8?=
 =?us-ascii?Q?Bj8S3Ts0OswY6zkWBpkd+R0/WzaUOnN3ys/MeP5iHcTAUCDjN4O/6kVJk6Ag?=
 =?us-ascii?Q?MVginc89ZPAWaFC7psMBuJZtKmUgDptYDN1vjej//T/dAPhdRb6VK3sdhzUk?=
 =?us-ascii?Q?zUExfIIenwBNoahhV6ORST9LMclgwBHDh0B2BBKKx5E0PFlVg8HCEDcQgl/y?=
 =?us-ascii?Q?eOhH5GNeTnbHrCpevJjcKNtIJmtTGVPaaJeHBeUYJGJ4YM5a/Ox7LOsaUjVw?=
 =?us-ascii?Q?62ghFXS5CTsjUOdoXeTAcfpJQDUEPiSsJ1H/0u2uP8SGLatpdg8mtunzcoZo?=
 =?us-ascii?Q?Ajuo6LREjLbvHO8SMAplcLugZz+voc/UaRMGawJEmM0r7k11dlXTGWJu1AWq?=
X-MS-Exchange-AntiSpam-MessageData-1: cSdvopnUC/zxHA==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d922dc8-83c6-4a68-2b4a-08deb8396387
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 19:36:15.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1ij/Oz4TfVtRNxQsdyiimPHsR1OVAXCL91a/YJCo5yb4ZmouSazmaMZWvztbwDsTTSAjoXq8HPFHLvG83HIxM3avQ5oZZ6E6gHwso9e4ty1a+1MVW989itNXFbHeseR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9328
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290915-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admiyo@os.amperecomputing.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amperecomputing.com:email,uefi.org:url,infradead.org:email,dmtf.org:url]
X-Rspamd-Queue-Id: A02BA5B9757
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
https://lore.kernel.org/lkml/20260520213831.118082-1-admiyo@os.amperecomputing.com/

Changes from Previous version

- Removed unnecessarty little endian conversion
- Replaced double call to send_message with pessimistic stop of queue and
single send.
- Set clilent to NULL after close to avoid dangling pointers on reopen
- restart queue after draining the ring buffer
- USE Symbolic constant to check.indicate RBuf is empty
---
 MAINTAINERS                 |   5 +
 drivers/net/mctp/Kconfig    |  16 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 429 ++++++++++++++++++++++++++++++++++++
 4 files changed, 451 insertions(+)
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
index 000000000000..f2dd5286efa7
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcc.c
@@ -0,0 +1,429 @@
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
+	if (pcc_header.length < sizeof(pcc_header.command) + sizeof(struct mctp_hdr))
+		goto error;
+
+	// If the reported size is larger than the shared memory minus headers,
+	// something is wrong and treat the buffer as corrupted data.
+	if (pcc_header.length > inbox->chan->shmem_size - PCC_EXTRA_LEN)
+		goto error;
+
+	if (memcmp(&pcc_header.command, MCTP_SIGNATURE, MCTP_SIGNATURE_LENGTH) != 0)
+		goto error;
+
+	size = pcc_header.length + PCC_EXTRA_LEN;
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
+	/*
+	 * There is a possibility that the mailbox can be cleared on
+	 * another thread. If that is the case, and we don't restart
+	 * the queue, it will remain permanently stopped.
+	 * Stopping the queue before attempting to send the message
+	 * allows us to always restart it if mbox_send_message succeeds.
+	 */
+	netif_stop_queue(ndev);
+	if (mbox_send_message(mpnd->outbox.chan->mchan, skb) >= 0) {
+		netif_wake_queue(ndev);
+	} else {
+		// Remove the header in case it gets sent again
+		skb_pull(skb, sizeof(*pcc_header));
+		return NETDEV_TX_BUSY;
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
+	mctp_pcc_ndev->inbox.chan = NULL;
+	scoped_guard(spinlock_irqsave, &chan->lock) {
+		if (chan->active_req !=  MBOX_NO_MSG) {
+			skb = chan->active_req;
+			chan->active_req = MBOX_NO_MSG;
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
+	mctp_pcc_ndev->outbox.chan = NULL;
+	/*
+	 * If the queue was stopped because the ring buffer was full
+	 * we can restart it here as we now know the ring buffer has
+	 * been emptied and the queue can be used again if the
+	 * netdev is re-opened.
+	 */
+	netif_wake_queue(mctp_pcc_ndev->ndev);
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


