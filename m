Return-Path: <netdev+bounces-120255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F093958AFA
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D061C21573
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0183E192B81;
	Tue, 20 Aug 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="CLORaU1y"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9555FC11
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167164; cv=fail; b=Ita44cOZUhtqnqF6KXA5jh9eo1XKDnvE9MTn8/ubCyTCOSgAEevZBbHDwYzfhNZbKE9xVyTLeoRsZMHIPCzw+zpyWE8bUTk0RYQzztzVhdVLFH65S1vzwjPdRFmrO1ILuZ0kjmMlia9i3qAOvkdnPbMQcv361vxtG7nxfvYDFfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167164; c=relaxed/simple;
	bh=MydehMA4LhdrweSIBsJmgSHDCtsI+K55KBZ+0AO8Rpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ag9GYhG1wHNx8mAX5TG2HDDBnBY9SUPP8fFITNACJsgtvB1rbFXXjMfWfszu8BMdkw7OA3rX6GjxaSlqoA1iA1o0egRLD8rcIXYxcsMcl5RvcmSZ2iSyo3WTpagsRL8nb7ANGX2TNSsZjIr0Ffr5Ud29EmCfZo2Y73hBmw8BScM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=CLORaU1y; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymO37Q9CeKss+igVPzxXrA1MWGa2QYV8TOTsINcCrEvrbnReDJBHltLvb2MQAtPHE67qGvuae3zPu2lYAz3HBp1a3FNU+KkIzbcjqk3nuQZySbHOxfPBwcNnFdKQVS7pc3WDuC4byDr6TWRDAzNoPvdpArrdhgAXlKOMqJEYz3LkIsPpjBWsEVHNQs3ZwQ489rPK2bqiMRQFlq6kvxcOtMSnADaFi9rA9aSVTPbcUXxOquFD0WPb+EahuJnZ6PSiCDAUKm316niMxNaNNiGesa3zPXVWd8cP5HrZ02bVUU7Xjx9tlXaPDgCaJufVbXraGQQKkAVxycKkAYWDEcLUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyzh/0HJ4qIW1+SMGXJwkMYqpzTvOzDZ7R9QBt5cwC8=;
 b=KvdKowTCxRXz5lPuhpE8lCJz1FQzEhyO73KmxrEfG00bMRKy4saPcWYpQUaPsto5hCSktL2XrpWz3gMuVu9UjpiMfLHgTc0pSdfH5OgxsbkhKb4/NDIYM8eYAxv+Up2k7xaagqmWCnJkYtoGxB0nvHD8doEfR4OK6FaqGlJDfYJG9ssEQ/4mc3q+YidHShmLUgJgkshXm/9CNLvxPcqx+N5BVv7SscZnaDbK5GBaMeVISbBlpow3DsnSXd2A3AqrvR5QbjlB+3DuLV1hwVlPapIRtk0lZFxIObouJQhtjhqmgLdfQlL4G2depqYEiGSRCkGPQeXHBHOGbibjI6AkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyzh/0HJ4qIW1+SMGXJwkMYqpzTvOzDZ7R9QBt5cwC8=;
 b=CLORaU1y2ZR0KFAhAPiT8SdiLcrsvg+he1T82FIoOFsCIEipyk7ZD1iW1yGlw3716rPc6wr4oxrQIEoDmqsw+QDq64qFRyp+hmDQ7y7vsWULWA7KwPWrvYI8blNC++2DUgI8Yqjwexiuy76WrWfUliyhGCH6X1vQcg40QyHJGus=
Received: from AM6PR0502CA0052.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::29) by DBAPR07MB6680.eurprd07.prod.outlook.com
 (2603:10a6:10:182::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 15:19:14 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::d0) by AM6PR0502CA0052.outlook.office365.com
 (2603:10a6:20b:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Tue, 20 Aug 2024 15:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 15:19:13 +0000
Received: from n9w6sw14.localnet (10.30.5.13) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 17:19:13 +0200
From: Christian Eggers <ceggers@arri.de>
To: <netdev@vger.kernel.org>, Martin Whitaker <foss@martin-whitaker.me.uk>
CC: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<arun.ramadoss@microchip.com>
Subject: Re: net: dsa: microchip: issues when using PTP between KSZ9567 devices
Date: Tue, 20 Aug 2024 17:19:13 +0200
Message-ID: <2295236.vFx2qVVIhK@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <7aae307a-35ca-4209-a850-7b2749d40f90@martin-whitaker.me.uk>
References: <7aae307a-35ca-4209-a850-7b2749d40f90@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AA:EE_|DBAPR07MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c66a9b2-ea87-4b33-58bf-08dcc12b730a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grdGq+0YY/toZHUaQ4FRvptcE+XHzzOejb4bjC1bO6G7GK9PYj2eOFk3yNka?=
 =?us-ascii?Q?/JPMx4wN7Vgzy1W3w8HeACUyf/n5UleEFyXUpRfzlzCUZvixRPOy5E1gwXA4?=
 =?us-ascii?Q?3q2/U4SlG5Vqr1toICdxLVMzBZUXsn+XSlQr8KWC2oVB4i2cTjmOK/ESeoLo?=
 =?us-ascii?Q?xdwTFpwtJc3kI8OCelFFxJTKWqST+9N/kUNHf09HhNwM8nnji6+VUe9MEFKF?=
 =?us-ascii?Q?bfVRma106APQd2S/wTw6Nmr/pM93mRvRtilFcSWDBknml3TyZ2AW2c5TqSAs?=
 =?us-ascii?Q?uP1U1geaS49bQn7p7XvV0ofsnuoruvFl3Ul4CPGERgkjDEmPE8ep6xGBvQ0d?=
 =?us-ascii?Q?w5L/29YheuW82CE4hyS/7NIiOp45QxySwqeKndvaqBUXZ/g24mBjPXf1YTCR?=
 =?us-ascii?Q?t6et6elgm5uK4hX+XN19Equssm22KcQHMBtOAtsmRjTJUO1EwetJnpMhA+8n?=
 =?us-ascii?Q?v/t0y2p22sookTGyFJadLGgHoUFagGh6f8bOs5/LtsB0pHuz0PswGaob1FJj?=
 =?us-ascii?Q?aIumETWBKjXAkvMI7nUMG6x61Y7IlOLMDsZzoMF+fmOcZZUSfbeO+zHUSI9I?=
 =?us-ascii?Q?fr5vGPSTQ5IwMxzscUYSSW/mfJ8Ubu8a37is1c5xSMkoe7ch5yvudUTmvsZS?=
 =?us-ascii?Q?kBHcJ0wfbL3nd7m2T2n7hZAj1XczoYNWnkIP24tyrlb979ZWpGw20vTgz5Cn?=
 =?us-ascii?Q?xFGU8L9ghqozHS9JGd4b3008upUXYGPBfjb4mzCprKKZr+3HCrkYmq0e+jta?=
 =?us-ascii?Q?ePdZ8G8MUjxjN5V46LcEXtQ9I5EAB+rSj1Ux5qtVK1AumLecHLoMwwivnVSP?=
 =?us-ascii?Q?AvzpWDPcWVg1pfr+pROx/ufat7Ip2WQ39Q1GKAjobbcfRoJGgX42TcyyWulf?=
 =?us-ascii?Q?Y+Qjr9HrJxVJRlcPw0ahsnUQHAwZm/v0NcErK4U4HCPGHnzLNrGNdl5Brxuu?=
 =?us-ascii?Q?uw51KeFe/ox8CKLSsyOCAtd5P5c6E63NtfhyTN/8VHkJFxWD51ByQ6ZwsBpX?=
 =?us-ascii?Q?9k0sn/UxZBSrgToHc6rAtrmcOBgBppcSEjMDaXbBNcTVG2REUK9mPdQwAZ82?=
 =?us-ascii?Q?UzwlpP/d7e3Y/4sRF4c/6ubku3MNSlmilNIA87VYrRvIXHgwKcyOe6LH5LnG?=
 =?us-ascii?Q?zmr0pFDJ3MTcUo8zLX0rzrn7vluj5FQ4Y6r5lIVAIlc7VJET06JC/osEjo2v?=
 =?us-ascii?Q?xoClVVkDTAZYPY2pnNJi7+KfYaYIHpkh3jEQFhNB9UlgBWFiZrEhquUx5hKw?=
 =?us-ascii?Q?HSLElQDhG3xJUwfj+sarQ6Z5fvlNOekqwJnEW8Y6Ef/ORrfhPvU9GBok4cC1?=
 =?us-ascii?Q?HA4IsH7jkUGf4AONvhSks6yuwSi80oPFCewVulUkeHUFUTljBLTq7pm62Om6?=
 =?us-ascii?Q?5EhPiK+77aW8rRtshmMAc842R69fFBh83vtK8MDlqzmYls1sqcxBvbBXh7Wq?=
 =?us-ascii?Q?fWkSGDG//P0IF7d1tYsNMTNEIhUaQJRi?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:19:13.7267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c66a9b2-ea87-4b33-58bf-08dcc12b730a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6680

Hi Martin,

On Tuesday, 13 August 2024, 12:04:59 CEST, Martin Whitaker wrote:
> Three issues. The first two look like hardware bugs. The third is a
> driver bug.
> 
> I have an embedded processor board running Linux that incorporates a
> KSZ9567 ethernet switch. The first port of the switch is used as a WAN
> port. The second and third ports are used as two LAN ports. The aim is
> to daisy-chain multiple boards via the LAN ports and synchronise their
> clocks using PTP, with one board acting as the PTP grand master.
> Currently I am testing this with only two boards and one active LAN
> connection. My basic linuxptp configuration is
> 
>    [global]
>    gmCapable               1
>    network_transport       L2
>    delay_mechanism         P2P
>    time_stamping           p2p1step
> 
>    [lan1]
> 
>    [lan2]
> 
> 
> Issue 1
> -------
> PTP messages sent to address 01:80:C2:00:00:0E are not being received.
> tshark displays the messages on the transmitting device, but not on the
> receiving device. I don't know how close to the wire tshark gets in the
> DSA architecture, but this suggests that the hardware is filtering the
> messages.
> 
> I can work around this issue by adding
> 
>    p2p_dst_mac            01:1B:19:00:00:00
> 
> to the linuxptp configuration.

I use a KSZ9563 in a similar (daisy-chained) configuration. As non-PTP messages
must be forwarded (like a non-DSA switch would do), I have configured a bridge
above lan1 and lan2. If you also have such a bridged setup, you may need to add
extra ebtables rules, so that PTP traffic received on the lan1/lan2 ports is not
internally forwarded to the bridge interface. Otherwise ptp4l can probably not
receive any messages.

> Issue 2
> -------
> The source port ID field in the peer delay request messages is being
> modified. linuxptp sets it to 1 for the first port it uses (lan1 in my
> example) and 2 for the second port (lan2). tshark shows these IDs on the
> transmitting device, but on the receiving device shows the IDs have been
> changed to the switch physical port number (so 2 and 3 in my case).
> Again this suggests the hardware is changing the IDs on the fly. This
> only happens for peer delay request messages - the other PTP messages
> retain the linuxptp source port IDs.

I also remember that I saw such a behavior when I developed the initial PTP
support. In my case this wasn't a big issue as the port IDs from ptp4l matched
the physical port numbers of the switch. I guess that the hw developers of the
switch consider this as a feature and not a bug.

> 
> I have checked that the "Enable IEEE 802.1AS Mode" bit is being set in
> the KSZ9567 "Global PTP Message Config 1" register. According to the
> datasheet
> 
>    When this mode is enabled, it modifies the IEEE 1588
>    mode behavior. Primarily it causes all PTP messages to
>    be forwarded to the host port, and the switch will not
>    modify PTP message headers.
> 
> so if the hardware is responsible, both this and issue 1 look to be
> device bugs.
> 
> I am currently working round this issue by patching linuxptp to use the
> physical port numbers as the source port IDs. I can't think of a general
> solution to this issue.
> 
> Issue 3
> -------
> When performing the port_hwtstamp_set operation, ptp_schedule_worker()
> will be called if hardware timestamoing is enabled on any of the ports.
> When using multiple ports for PTP, port_hwtstamp_set is executed for
> each port. When called for the first time ptp_schedule_worker() returns
> 0. On subsequent calls it returns 1, indicating the worker is already
> scheduled. Currently the ksz_ptp module treats 1 as an error and fails
> to complete the port_hwtstamp_set operation, thus leaving the
> timestamping configuration for those ports unchanged.
> 
> (note that the documentation of ptp_schedule_worker refers you to
> kthread_queue_delayed_work rather than documenting the return values,
> but kthread_queue_delayed_work returns a bool, not an int)
> 
> I fixed this issue by
> 
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c
> b/drivers/net/dsa/microchip/ksz_ptp.c
> index 4e22a695a64c..7ef5fac69657 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -266,7 +266,6 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
>          struct ksz_port *prt;
>          struct dsa_port *dp;
>          bool tag_en = false;
> -       int ret;
> 
>          dsa_switch_for_each_user_port(dp, dev->ds) {
>                  prt = &dev->ports[dp->index];
> @@ -277,9 +276,7 @@ static int ksz_ptp_enable_mode(struct ksz_device *dev)
>          }
> 
>          if (tag_en) {
> -               ret = ptp_schedule_worker(ptp_data->clock, 0);
> -               if (ret)
> -                       return ret;
> +               ptp_schedule_worker(ptp_data->clock, 0);
>          } else {
>                  ptp_cancel_worker_sync(ptp_data->clock);
>          }
> 
> CC'ing the authors of the ksz_ptp module as well as the ksz9477 driver
> maintainers.
> 

regards,
Christian





