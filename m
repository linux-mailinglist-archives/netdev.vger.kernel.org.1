Return-Path: <netdev+bounces-290733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAuED3AgEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:22:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458AB5B1137
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 016B03005306
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A54399889;
	Fri, 22 May 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bn1BW2iF"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11F3BB118;
	Fri, 22 May 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441729; cv=fail; b=ISIA7OjoeyIAv788MGE1YG1xMzEWOw00y3wvBjxPpOkngzunk1Nh+RahYrSBXcp3PCmXrxifaxyAn13oDSf29eYdChgJA7N/4kGn2uysEMVgvZ3jDoBJEGjZa2Zy+29fNV0ukxXIjviNnaLDHWAqmfknoml0SQyPLV20euNShkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441729; c=relaxed/simple;
	bh=1P6FFSBhpLwpuhf6jG420y5jXsAvGadEmSDe888qg7A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hPHJlqVR2lzSXZlUkKL1P+vPVSk8qysFE8O8aGMW+b68QKYppyx4ZWj2fMx66EboEsrQcWOF7g091sanCuXbDTFTLm27d8dr3CAd+UG2mi5YZzgK7YGCgFs4tV+vH10TLzkhAmKD0MB2gANin4CuS+vuilm7sc5Yd3XPv6o04ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bn1BW2iF; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIF6Xbwx8XA+qGuVejM3DcT3EQzMD2MGhGK/XkvmIR8wZgk18L/TotY+bv6K+jRHQhx0y4b1nsKRJb2NirCUKQEn7+karaUtA4D/wLtRHSN5bjLHc3wiHmnKWiyNqpWhjmfAQ2CfrlDMWlYqF/TWfz9Uhrywx3Av38G5A5UbbeBQS1lcN5qASF0ZDHQg/RnAw/yNW7SLPwW7oaPkB48zvqhFL0h3CwisYrbIYwh4Z2ZmkvMtK7sJhZC3KaK/Z6ZYF0YNO/ljOaFJftOLZ+RAs1Wms4zEuoEuljXMdMFUsABibvvHeKCWGu6EYQh4K8+GUU5C8Lud2Pk0Ly82CPu5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/nZZ8rek/N1xPpSIsnItqViEkZYUUVUT2lioofdwRU=;
 b=cRXQmahZpwMd/b5ePNVpygkc193+1hvoUNheYaQWjGj6yn8Wsfa1ogmJf+0Y23RHV/Lsscylq91rNuy+QAeO+8RBjwFK4H1ySZNVXdp1vBYyxu9znq048ANGkqqgYrJv55ChQHSJWC6bNxv89AYx/MvSrLNnMZgo6sv4j75lN4HcZBYHU+a97RamrGyJ3mmLfqCiveC4KQRD+7HGse5C05YYEePka6HTZNAUSellqmqsua0sSFyFOJOq4tGv05mlo+DbIzcVL/FKMUZGABmUj5sStAdo24m1dtWmcPVPN6kQYyj4ioMueqS1FMUY/fPir/pN2lOXw17g5uupNeNKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/nZZ8rek/N1xPpSIsnItqViEkZYUUVUT2lioofdwRU=;
 b=Bn1BW2iFXZHGQtoyj/c5TvIbsHHrLMyxtAPpFyBVjcxHKlLWxDgrpYz5FiX/M3bKWkTe/IxLAz6TzUxOYf1DExw014obwlI3jNs/twsAVIzizCaqusEIEzTOGfa1Smsfdgqir9W0nB8jvcVolJUi/8b+TcUUWoWTqWJxfX53DvF9VYAt5hYjuBNrhl1apkyWrpvNzLXITUOsV4nJH281wJQjd6SAAimX4CfSAqG6a+pd4joB0lBDNej9PyohmDVcAWRd4SqJtqepnlmvFyuko2He+k5376AgbhJPcTfM30KEkiwltt2T81Y9wc/AvrOoDl6ctPIAe9nrPqaXwWrAcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI0PR04MB10855.eurprd04.prod.outlook.com (2603:10a6:800:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:22:00 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 00/12] net: enetc: Prepare for ENETC v4 VF support
Date: Fri, 22 May 2026 17:24:26 +0800
Message-Id: <20260522092438.1264020-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI0PR04MB10855:EE_
X-MS-Office365-Filtering-Correlation-Id: 82484240-c8f5-444d-62a8-08deb7e39441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|18002099003|56012099003|38350700014|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	RZQ34+yoT4KVAmaKdHICn8bMkdHavgNW7T/leJZTHpzqheyIrG4kVou3eUMb7GOcDBwGZojZk8svOSBu3yKkIJqTlGh+tPCDXk7rbDczn2wZhBH/bVLlDo9cpC/ZeKstl4APkKamzzIun2qrVzXvbMRiEZY/XRmFKpF9Zj8Rebcbm5uosOrE6nRPIDoQ7EFqjhln9ubE8zK7VkqEntlaaQfS8DHdD8DWaGIiAYgTIVjq//NDwPlTt5Ae6PBanvjCa+EQA2FwIt96m84YYOxGmi1JMUDwGBaJv7zlV8KMZq840c5718LBAq2ssfw3YQCNZ8mBAf+ysQS7q4sRxiN5v1HzseYdDLNTss5vN55USmOSG37C6wqaJ34ADR7eT/bDNxgMol9KGTJGKci6LS992iE7T1i4B1wTYANnizyUYHzN/xe7n6XJOn5q3rC8duCzWKfiJS7ElaJYGafvK3RIbxq3TWLVYV9KJjLw8a3YK78dh1y0XaZKD+FV5HHQs+dxQYI11AbvRHivCVLWug2mhvDUMrKWSa41gjLPkX+Bk49zgw2FJfV8CAHE/AInpGY5PzghUxYAQ1Mh2pPersn0TIonmDBCf6jr75cupntBnGzrQf4j3NWHzejLJkf86cNkavrJrrb6DOxc2BBZqD/jV+7QCKBlR9rTIulEI5jMUu09/1PBY1Bg+ZRBEszGqyU+yJmJTNYf1/PYn17X3usS7uq+u/pHC7ViH4eJkXbzzPHH+nIkeU0TlJbPRpyi0jZ/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(18002099003)(56012099003)(38350700014)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6Gv0uVQ5BwDc5m0Nn8eIkFsQV8AKah/fypseZpeWrVjvzteaRZSFf1uwgnH?=
 =?us-ascii?Q?EfYG7JLoleJPpIW1JhRJvE4D5XfROaBGRhykRAn/vAJvZH2EvgLEYbvXUTv8?=
 =?us-ascii?Q?qasaHQIejm8QQ5RzLMbuuL617J7m1wQfcLMs0bmRPBlLg7a0c1hvqPGCvB2o?=
 =?us-ascii?Q?5NE3LCwaarJJX9DehxQ38OWLBoTpc0eFLguvKU1ZlH3jII2L/4BvO+elXvXC?=
 =?us-ascii?Q?dkO3FadDnDYjA9piFsYnqcJF1u6xWP5yePbgaLqqxYThCCQsZUg1+761jTBo?=
 =?us-ascii?Q?ZNJUudnqZs0amGtOGdNuAdZqf+66LOvBzb21Y7Px0vqz6KJyLPxcbElTN5oR?=
 =?us-ascii?Q?FKuNNwltxyYf/ev2bg8yvgo4kszFvr0esRZWLaPj0iJGaV2NbWo4nbH3vLyt?=
 =?us-ascii?Q?bWsQk0MP6Vc+NYDNTHzdbYPK0R2YV3OojjltIz5YT+Mj7lQPT/7EhqzgxNJu?=
 =?us-ascii?Q?NvcnY/nzSWlgznG8nwoUDeenfG6RfOAabPzcd6hBCal4NYRwak+yL1N1drz2?=
 =?us-ascii?Q?9jdvAmCmHa9R/FKsl1TrUeXz6d4Nyd6KwTgbhWFPhKOkQ8oyCVtU7fQgJu9l?=
 =?us-ascii?Q?r9gpozBQxW5KdmRaRRiQVIoPCGnNF3OcH6uKj+XO38Q7mYaGnzzzWJqLY2Ei?=
 =?us-ascii?Q?B3cZk6DmehnM2YwjUPxu3n0NqEEj6rGP79zYSp9N+ZkJFSsY3ubKS3WYKY4E?=
 =?us-ascii?Q?fBQx+a7Bte0Ab+0TelYQWjDgrtANhKOA7NLxYEdo9/btZodmvZ0uc+pMF8xl?=
 =?us-ascii?Q?SjJmKAq4CUTie03454qilX7441BRxt6XZj90Gg3yJQDgwBc6ey/JbSmsY6uc?=
 =?us-ascii?Q?fwygHwS1t/9xEyszAac5LGLd4OUV9OFODTtPRrGwzDK0fqOfGBwvCCsITe2c?=
 =?us-ascii?Q?lAWW4Hg1mvJhP60q+++2ZT0M9ZAcryqR5W7iE08eUvCLVWeRzXo25lIodpuJ?=
 =?us-ascii?Q?Vh2jpuf0CeQgI0CFki/p3saNNg8di4cm0z20SRTM1zr+4viEsf2MSsfyfhz1?=
 =?us-ascii?Q?ilsBe06PNMh9N0tKDDT3roXRVAl3SCcANnFMQ1txy3wV6toiV78x0R7ASfcY?=
 =?us-ascii?Q?U7BAn4B59m94ljgpiZj2xLBlEEAiexKPEjpQIlOTidF975Lo5y5kh9eVSYYj?=
 =?us-ascii?Q?dsqHStpJ3ksvbKmfZGIIu6IvPRaSRvviyfBM7EFyMqi19vt5KVG4IxrFV36D?=
 =?us-ascii?Q?yHhZOWwc+RLodWU0waPZbIzKkcZeg32pFZ5U/SRfLZXRDRknmurcnFUPVK7J?=
 =?us-ascii?Q?fF11RpRnOuREAfsewVJpQF+QFBcPO8ycMYYE7AyswmfaRP1mVcb6i6xZsNGA?=
 =?us-ascii?Q?u2o9cZblBvLDBexp4dG9/TSoa2jY/rnGxAc0QODFAXUo8d51Yqn4wkonyCXZ?=
 =?us-ascii?Q?C3A9TjWGS82VBBOn0q2Yjto/FvPa4Y9sEe1wwIxJ9qZt2VFyK8qG7K9M/b4A?=
 =?us-ascii?Q?Pk4dNYMkjz/p/Vv8J6TmiPIefhS6KSPKpKmsiZlwyHIdn4cYUE9+FyGSPmx1?=
 =?us-ascii?Q?XjI9/gXON3yISBNL5m4XCDKONUxiv0aesTayOhP4yUJYQRSaB4xfBxanOvW8?=
 =?us-ascii?Q?zwGdTJK3I5vmZja85y2XkNZWxE5xYooFmYOeE0SvQGSG+M0UI9qTlZR9FCf3?=
 =?us-ascii?Q?bs+c0RUnLt38TdtkT/tTesQ+n7HB7qrl/pG2kNVK9Hl54QYkI7OA1ZofVvqP?=
 =?us-ascii?Q?5NNBPeZ47QHFfp79GRofDKUlYLL6HzO3045wiwnBA7aoHmMw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82484240-c8f5-444d-62a8-08deb7e39441
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:00.7989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpxItybcwStasAqFZw/LNbhGxAAozEIbTewdooPueCjo7dHG7eVzpBQ6LXTqaIlW4wxpQg0nXDI5RrcPi21llA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10855
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290733-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: 458AB5B1137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series refactors and extends the ENETC driver infrastructure
to prepare for upcoming ENETC v4 Virtual Function (VF) support. The main
focus is on code commonization, improved VF-PF communication, and dynamic
resource allocation.

The ENETC IP has evolved across different revisions, and the existing
driver architecture was primarily designed around v1 hardware. To support
v4 VFs efficiently, we need to share common code between PF drivers of
different IP versions while maintaining compatibility.

Key changes in this series:

1. VF-PF Messaging Infrastructure:
   - Convert mailbox messages to new formats
   - Use read_poll_timeout() for simplifying VF mailbox polling
   - Add support for IP minor revision query via messaging

2. Code Commonization:
   - Relocate SR-IOV configuration helpers to common PF code
   - Move VF message handlers to dedicated enetc_msg.c
   - Integrate enetc_msg.c into enetc-pf-common driver

3. CBDR (Control Buffer Descriptor Ring) Improvements:
   - Align v1 CBDR API with v4 for VF driver sharing
   - Add CBDR setup/teardown hooks to enetc_si_ops

4. Dynamic Resource Management:
   - Dynamically allocate rxmsg based on actual VF count
   - Use MADDR_TYPE constant for MAC filter array sizing

5. Generic SR-IOV Initialization:
   - Add generic helper to initialize SR-IOV resources

This refactoring lays the groundwork for cleanly integrating ENETC v4 VF
support in subsequent patch series, allowing code reuse between v1 and v4
PF drivers while maintaining a clean separation of version-specific
logic.

---
v2:
1. Drop patch 3, 14 and 15 in v1.
2. Use enetc_set_si_hw_addr() instead of pf->ops->set_si_primary_mac()
   in patch 1, update title and commit message
3. Refine the implementation of patch 6, such as remove bitfields from
   the message structure (struct enetc_msg_header), remove union
   enetc_pf_msg, change the prototypes of some functions, add a generic
   error code (ENETC_MSG_CLASS_ID_CMD_FAIL) for PF message, and update
   the commit message
4. Remove class_code from struct enetc_msg_swbd. enetc_msg_vsi_send()
   directly returns the message code for 'get' messages, as the message
   code is >= 0
5. Update commit messages of some other patches
v1 link: https://lore.kernel.org/imx/20260511080805.2052495-1-wei.fang@nxp.com/
---

Wei Fang (12):
  net: enetc: use enetc_set_si_hw_addr() for setting MAC address
  net: enetc: move VF message handlers to enetc_msg.c
  net: enetc: relocate SR-IOV configuration helper for common PF support
  net: enetc: integrate enetc_msg.c into enetc-pf-common driver
  net: enetc: use read_poll_timeout() for VF mailbox polling
  net: enetc: convert mailbox messages to new formats
  net: enetc: add VF-PF messaging support for IP minor revision query
  net: enetc: align v1 CBDR API with v4 for VF driver sharing
  net: enetc: add CBDR setup/teardown hooks to enetc_si_ops for VF
    support
  net: enetc: add generic helper to initialize SR-IOV resources
  net: enetc: use MADDR_TYPE for MAC filter array size
  net: enetc: dynamically allocate rxmsg based on VF count

 drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
 drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  22 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   4 -
 .../net/ethernet/freescale/enetc/enetc_cbdr.c |  16 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 -
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 170 ++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 209 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 142 +-----------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  10 +-
 .../freescale/enetc/enetc_pf_common.c         |  31 ++-
 .../freescale/enetc/enetc_pf_common.h         |  11 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 175 +++++++++++----
 13 files changed, 581 insertions(+), 214 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mailbox.h

-- 
2.34.1


