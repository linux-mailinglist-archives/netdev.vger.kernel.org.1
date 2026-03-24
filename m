Return-Path: <netdev+bounces-271152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LaoIca2wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:07:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0795318B37
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31C933008C9E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22EC344DA8;
	Tue, 24 Mar 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UReGpiaj"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461538A72C
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367761; cv=fail; b=ukw2vfe0z7x3dVGFzsBqIq08nOhx+5WlR9Q2QKLnZBaxNb8P2xK0G6NdZRqgNhzimnP7pUA+nQzg1R+Rtd30muSEva+H62RHB30XzR3YXG2GEwwOJyayLedziCr97lW+BfF+t+L5naa6ynXCGwbmjcf5S24qq40gLcMYxIeVAGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367761; c=relaxed/simple;
	bh=vmPVjPnPwHTf9WUX6Eu4qIqSZkTX9cfrY0Jb1HRFBLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IPnGj35X6in6/sBcvGoSXnQGZfdpcx1txmzC2NmTZYRhe3rFn4Q3d7txk04M3Ybzalo1RoLFCcaRlql2xMtjxYGkOmu0+GmlP9w19eNXJinAlwDvD1kVmABk2mrlRTlQWsrA90USZ4j3S0/Cal2jDb6f6ru/RyGIj00LPmG4g5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UReGpiaj; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaNP3geXbyOpd8mCZWbk+A8JJmBrNoHyLZdD5rn48B+j/3v4HlyICLxI5xM4BofhE0uwWHHk38NwrDc51bfqh5N7tfcvKFDwFPDp+MeMbM6qhOqesSK2Q8b7LCL09YvvwpS006BrckL08YA/sIa2J0R29iWPP4jxPMPDk+80eLQeuh9ULA6+fxZeS6KducRdUYE3U2kXfjO3ofXW3cxNX05qUa2hMkCNAIYCXAggY/cDvnqhiyAGwq19kAfyn6yt3z0FJJaMVV1Hyhz8CGBQ8kOFSsVR5KfvTeS24KpcHmak2wYOzLlRCtWoTW6laZq2TYnneabJaLnFj67HuC3xSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVzLZQXEP1GVWBzIFM00s5kqD7s7S6xBU90UUDfvWvg=;
 b=QIuWaTV+HTSmbmebTxc0Lq8FVrrHiPt3YfD4vz3+V7HUjSVUH3/cro/1nzG7BI3itztgBqVj5QU/dHx8HeBwB5CfmK7a6mT3VMVB0X6O0FH+iBVlSgYjbDZWRTd2TTfp9VDfAMiUbtKbh5/zdZEoQnV2VjoisittqNPN7pAcyJdHnZI40zeUoruDRaFvRjSbUjps6ZBaGi69v1mbJ2H1YktnvxvxpR6cxbctODJsnheiZ8Noq3+SoGK0dDD+zdHciozKu/W6Q1mHN7814g9/8tTt1QwyFo6KYTndKlBV3M8B7iK1ZszQ8vzt0CldLcN321mXDwJ4HtX1vQrUw0+fbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVzLZQXEP1GVWBzIFM00s5kqD7s7S6xBU90UUDfvWvg=;
 b=UReGpiaj1DDFQJymcbYvCloH/OGjKMpl41MdosUeToc3mJsZxhYcJPiaR23dL1ha216Se6XzzBPJ6a4OzVPXcipna4qV62+Nv2aErBA08KVrSfqe9kC4KYJiow/SYkQbc7JWxsrCwcMcGiWHTtMh3CMmUDspD4tgBPsSLrn84JcegQtqKiASclGbiHnFa+xV4UeRPa/FCVz2qh/cAS3Pz/AP+6XC4DZzX4yN086Tc2jOGXxOxsbb983MBRVru0e8M+UoiHNRQIDEQ33aTE2JXAn6g1IbS+CjzsrjQlhimRx+a44ne5ws2e7sJifYcIFDMReSKFcr8eoE7AgF9yl8xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:55:53 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 15:55:52 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/3] vrf: Remove unnecessary NULL check
Date: Tue, 24 Mar 2026 17:55:19 +0200
Message-ID: <20260324155521.525292-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324155521.525292-1-idosch@nvidia.com>
References: <20260324155521.525292-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ca30d5-1329-4f7a-4981-08de89bdd3bd
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wvhuL7KHKFIxnJ7uYb6B0wNihvPy+P8Lg47FjABPO26mns+/ZMn49OXTz2NhST78ABs2zvSgVl5Y5ho5MHKTJqHLVWGXMcUKndJbUkXucZzMvBShziLIhV3cwv/Pnswm9gob0i20+eJlfeqXGMR6qea+fWT3HSiB+e+296Px2eYie+pgDe8ClzGCUloWAO77DhRHf183cbOGIhv9CPckhqNXyoFbbenkv7ehfcAKrxq84nW5vY6FpmQ93JcmzIsiV1S5dHyk9+1TI5e58xii5uuppP8CRybZzGX8rX+dQ5/OVMojDZ7ImBPM3uL1AHjNVp2DJ3f+67jdvkbjQFRD8yy7dW/oNDmDCmlgeMH6GEwrCCRqwHHV7zIeDOUj/AeC7cNaNpK/6oc3LkJW4ieTbGK8hpG+iogxuL/r8V0Vjd3aLGEG4LCU9JNUeCeZsV7M3zmCv2528x1V/0ThW/4Ul4COIFPpc/9VRGVwWwDLAgr4lBZ/SoPN35B0Qhq6cwIdWliC2FY18bqdab8SyEPZxfhLzSp6jOYfTtHGctzj7O+h4qisJcI/24/KTkPR000KrhHt1kBn1bf5cdSkE59Q9bEkoFhBaYVxgDahEZ2Z4lHNADl6qLvxNfD556QgKoMGwyTI98z3whZqEpVZn8ZGPi+J8bxXQCjn+4sr9QUT+wZx2SCOCjfsSLLI52lvoF7DPkBKfCxidbKbLsyu0EBSKCQ7H1uHVwWwKJjq3OHwiac=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v7o+sydikwJhG65Hcj3pjo8mo2Qca6Pb4CjAw98iUL/5x+5btjr6ePBpO0tP?=
 =?us-ascii?Q?ONMruCe9dO4q6eON2Q35iFARHSsNJy/7OMYXejU9sLmxEqFc4X16abLy5Nif?=
 =?us-ascii?Q?UZW9vEkz+T2Fn2qcLyo+p4WEvDR2Y4UiN22IXqGRU+I3YMstpkonqkdfZNWV?=
 =?us-ascii?Q?zVMe66p7FvQ81k10cJVn3CKtmmDEMowHGen7ot/kBmgxCF3ypz0tDH9+E3P9?=
 =?us-ascii?Q?87Jyvj8OBJjk16uwogD7hEuZyMRL6xn7M64knqUG6ANJjL0oHXYN6gt3GTqD?=
 =?us-ascii?Q?dnylAGbtBIYt0+1QqFScw4RtxYsyUGD0ofHey7mZc2wJJg0EUnPosmM2UKW+?=
 =?us-ascii?Q?A0+BG09CHz2qaGEc8ZYFE1nXHNUairTR+NG9ByQTEjoNsYGbH2CJqJb/V4Cj?=
 =?us-ascii?Q?9eCEO8EJfmp+8i2wRvsygN9cgPFUtbMOYxUToLQjKflHthQrV+iMFhMqXIOm?=
 =?us-ascii?Q?ipcyXgqMrRbIsOLgtfkVt582EAxvlU7J8qfp0D34mnLIAzP6mXSfsv5lHCaN?=
 =?us-ascii?Q?9nMkHO7Vw8Nh1eUx+RpUQZKnIu/L2fIEIwUMETNSMJFym82yYdoQV9urQ6rf?=
 =?us-ascii?Q?3KL2rJ6d0Uf0hwGX61QOtL6KmAc5sbZaH3XK/Oo0sCi0VteTkfZJ34/8WCuw?=
 =?us-ascii?Q?vpTCOJ60TUI3Ngvw+9AEanOOScWwMhwcDa+3h3wUb3mDSZva5uxZt2yWOGsx?=
 =?us-ascii?Q?Gg+v7EPghWlt5OeHesRkQv2OzEDbI/OyWyfc51MKEG9BZSnOhxfCwyVTz7hq?=
 =?us-ascii?Q?vndTWn1c+R/unIZOkh3OLnwbEKiq/jNvYlJmVN3FC2S+zAJnN7VnSnNhLO09?=
 =?us-ascii?Q?WevxBdv1H+Gsr+c9CNmAVz+L3VXlUfhxpMRoCPJlkeAMkft5Rs7R8JP1zNiJ?=
 =?us-ascii?Q?yfpHPVgPXxDs5XNzGG4QGhoA8gsscU3f9a2XWPSam+/PrEl6jLD32b3cEI1l?=
 =?us-ascii?Q?OPrglf96EX3uu/B9BSOIfXNeIn5SySYtSHxOn3khIABx8c9e1PT8kA6F8PDd?=
 =?us-ascii?Q?Z34phU+zffR5C27Cm2zvZ4N+SuIXfkFQPRA5p574j6kKfn51KgUxs3hS1l1d?=
 =?us-ascii?Q?zIMc3FGKNqMfwU9zqqpG262rISoYqlpfGjhTT2rNBmyU7aqsxZ28M0xITC/r?=
 =?us-ascii?Q?Ln2JlRQtCLw4/6R4rsCHTxXsnuv72gTztRp7rb1W3l4TSBHac7q4WYzBDrQz?=
 =?us-ascii?Q?ulKnkDVEVrrt2eOw2d9BGKF0UyilEXqc9XQqlfq5tvc+JS7MNtxZykFv+60S?=
 =?us-ascii?Q?V4ZcKh0Ja3R+LXpnCIsrhKmxUx1VWEydMAa7qid4MV29JroEtXogkjxuLZyu?=
 =?us-ascii?Q?QX/kG62ALHP4HZojHu6jNwk6ISQUSBSS3mW3+czndW2/69H4/1lmltI+6rcy?=
 =?us-ascii?Q?oLTyb8lUifqvkfhWdK+Oeq05OHdVdtwdp2Wz8cY5zpTXGJXGe92meEkUcSlG?=
 =?us-ascii?Q?rKQ1hBjnrlW8pwjT5B6anfcqkADPiFdqWeaFjOqy3zFbxZqNajJYqdK8tIRC?=
 =?us-ascii?Q?1F1YMQmG5ThxN527222pwWLTN1QoBzRoDRefLAkG3qlPJwqhOBFyd/lNdGZd?=
 =?us-ascii?Q?R0cj29o+4tkQDPIUJfJnNZHc5jl21qjfXwFQVXAx8rI/R5EkRr92CTlXfRiy?=
 =?us-ascii?Q?ZDiAnND1dAwMbqxbUFDXlMRGohaS4PAwp5HhwOwkoDF3CVFeQmhaUsEH+V99?=
 =?us-ascii?Q?xob1ol3APcddKAAvVQCATlEgfUrrz+RsW99s9YjOp5oA8BgP7MQxhEkPfZJo?=
 =?us-ascii?Q?V8s5kK5QwA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca30d5-1329-4f7a-4981-08de89bdd3bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:55:52.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kanv8U6iqidNSSpDd3Gu+jh1DNfSy97Ge97EwzYLfkiP5h6rDH4NlRYbH8uB7/ny6ZA9rUm8n/n+KkmOXqo0hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271152-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0795318B37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The VRF driver always allocates an IPv4 dst entry for a VRF device and
prevents the device from being registered if the allocation fails.

Therefore, there is no need to check if the entry exists when tearing
down a VRF device. Remove the check.

Note that the same is not true for the IPv6 dst entry. Its creation can
be skipped if IPv6 is administratively disabled (i.e.,
'ipv6.disable=1').

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 8c009bcaa8e7..0952ab6a2571 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1007,13 +1007,11 @@ static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 	/* move dev in dst's to loopback so this VRF device can be deleted
 	 * - based on dst_ifdown
 	 */
-	if (rth) {
-		dst = &rth->dst;
-		netdev_ref_replace(dst->dev, net->loopback_dev,
-				   &dst->dev_tracker, GFP_KERNEL);
-		dst->dev = net->loopback_dev;
-		dst_release(dst);
-	}
+	dst = &rth->dst;
+	netdev_ref_replace(dst->dev, net->loopback_dev,
+			   &dst->dev_tracker, GFP_KERNEL);
+	dst->dev = net->loopback_dev;
+	dst_release(dst);
 }
 
 static int vrf_rtable_create(struct net_device *dev)
-- 
2.53.0


