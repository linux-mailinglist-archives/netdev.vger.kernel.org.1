Return-Path: <netdev+bounces-140996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DBA9B905D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6007A28130E
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500E199238;
	Fri,  1 Nov 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MestVr0T"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E4152787;
	Fri,  1 Nov 2024 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461066; cv=fail; b=BRk9kW4KUT++LqsOQQzjbvQEYU94Oa+a/c0IVSyKVnVhEf4moNmIdgBXw2CFsqHEKmBjKpGuKefdjGJnLrg8CH2HoM1nUFPiR6YQVjZIccFZDf/mzBIGLC3IOJtN4+U3nqg8IyDbHB03XIf+SfTkWz3LW85NEs9n7MNh0z0+2yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461066; c=relaxed/simple;
	bh=I9wNHwDD+PQ07OITLUof7q8TPAWxbdZ7MuJNAdl0N6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JMZQ9+YGtNVW3zWYhw6TedpSNN+CFNpuTMZ5zrKKxF44Fs0tIHgFl7cQO64jL6en3/KjpIMgMF+VSLQ3sPhMKM09mcDdIxggaB1fBjOTk20JVXRH4V5aTIP4XWJDXVHbWcinxGGEgdtPPEDrbmC1O1RG0P21sn/VJEtT6cvpve4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MestVr0T; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGTgzTqZaVIZEmRINVtpB1Ow8DxUqrC587I8tTuh0X/6m1bCqy0Vgai1dS5B+afrPDGFKsSmqsG3AkmML/vd2R6JSNB7bF2v3qDOJrGOzMtqZAraLeYgOuImorIsM3qssHqfvOCjBsZUvp+++e7ZeiXvrmnPVGhUxXQjHxtO9ZfY/SpAp20f6yus/XsHi4lKebtyMEDKgIYPjzWwPfh8W3JPf6TWX1lINLtcWhAqzfJuN6KnYiqrwARx27DV9dpLX8YFlf6ogY2lLqJQr5Opmj59V5HxJ6hS15OySk7L6aJ60UYQ7+WHXZvD6H1mYA+eBq0epFD0AzOukrEIC2tvpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zf4VOHp1okd342i+8/yEI507BPHOa1qttyCqCUNSr5c=;
 b=UxtHmyZyw8a8wkj3JE/KTMCcnlLR07z7OOrF4WPHlVMDZYPOIIPM8hz9Nvom7hGj5pUWE6JKWNcvMu+79GZPZFjR7uekCjNkiKbSewPm2fl1AxksM7Vx8jMU7zqnn0HJHjdgxFCVev8PUDcVjHNubpDmsx7zrJkoDdPaVcwp8MH7W1Hrgvft8AXksfH0Qse/nXfmFCrS0lE5uQb4GWaQQVy0JN1DUFaLrSsY0FGVV/8xeRhv8hYIt84jYr4xGUsCiiLubzNsKdxXauAGsHofCu1Ni+W4yQeSTZe1uBTlbmD0i/g6mYbTPTBFAflRcgYUnn3ODsSSWbL3vC2MVS875Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zf4VOHp1okd342i+8/yEI507BPHOa1qttyCqCUNSr5c=;
 b=MestVr0TC09B5cllFxjDyOhbPRA85rXXQWhDRmlhN3rHpgyOBQ5YhJe3qWN3gu+Vd+RtpHVtiTEai9ZbRRgGXo8HaiKt4mT3tr0tBXt8Frji43OV1lDvasep0Ijx4qV10BL+ceY2KJpMhrSa/DvO7fXPZhSF2EFBKtIAtX/anug9T7qdMO1+y8i9tw7szbJBaxyO0OPVSIighOt+9O37egwHISIV4kGGm2viay+meetWE6LFtDy06XvTrxOOWLMjxkWhh/v0KaDkBGz5/knbzR4HgNYHbRW+N1NsSxnMb8gtS0QrMX1xHxTOKV4IjcHMrfVJLN/auVwIraAkSqh6bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB7573.eurprd04.prod.outlook.com (2603:10a6:20b:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 11:37:41 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:37:40 +0000
Date: Fri, 1 Nov 2024 13:37:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, claudiu.manoil@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net 1/2] net: enetc: allocate vf_state during PF probes
Message-ID: <20241101113737.dqrp3w2tjrnumyig@skbuf>
References: <20241031060247.1290941-1-wei.fang@nxp.com>
 <20241031060247.1290941-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031060247.1290941-2-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR06CA0122.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::15) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb0b0c1-458d-4aaa-8ff0-08dcfa6997f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIZ7ijnR4aMC8NSL92xL8DiSAPjxaolOta0hyO/0XJgxHomau7WoESPWkBo+?=
 =?us-ascii?Q?hQfb9kZqD8ap3nmMwXE3FANWuyxrno9Zuxs9OXzXNu8GnuclvKIjy8v4GAnO?=
 =?us-ascii?Q?1Jt7CSx0kWqW7fOSiOzXu7OhX/zF4Q26au27i5QGQGik8WIwsow5D4SvhmCj?=
 =?us-ascii?Q?uSa7Id4TOldC6yt/JbgBoDia75ESGWQqNyZHVqGm/HbMXJwmC7s17gFk6Cy8?=
 =?us-ascii?Q?jHsoVy0pvyoR7aJjbtGYFjz/+2PDy+9NfqbLfIUWM/kzEM2esnxVsaF8sM/Y?=
 =?us-ascii?Q?nw8Ubpap/tnqaIxTFmZe8p4M0XxBylTUCbC1mZmHm/WeOcNXA0+hHAIU/d5w?=
 =?us-ascii?Q?aMhp0UQw4LhhsZbDj+gWD3aBaRvSwsS7LaKEnCsstVC5bPMB99Ae/GIHu5JQ?=
 =?us-ascii?Q?IyRgnYYcz8BCKrh3vUzupVbcOkbJZ91fgStXoKVNR24UbsAEpQW4Yz5hZsVx?=
 =?us-ascii?Q?EIya3DBGqJfCm2rbsY5aHNgp1Rx/4EDXDPlfOOX/UldVcurPklT4/fdRI44S?=
 =?us-ascii?Q?bjMMIQr0alpqrgFlzz00n7rytK0wQBFpNsNTmZ0B7QpxP+Eizx3OaYYFY2aE?=
 =?us-ascii?Q?lMQ9UlNp9c62NADp81qSsqL7rfLcKvjyKphmwpsMkXziY/mxEG3/hibA070y?=
 =?us-ascii?Q?2kmecI3XlpqIeH4FYiGsFFExhGlqg+LK3JzXXqC4yErMmXYSe7vP98BrTcAg?=
 =?us-ascii?Q?y9LOfYioMjFSwyGvicDZTH9XyPWkB24WkGNdT6r7LE4Rd/01idQ3M4bwaB9P?=
 =?us-ascii?Q?7RLrs6tET6CDEBn9wmXbRUTOg/KrI5EezDi80Vqm2vXGzX2aeWXduiVKb//2?=
 =?us-ascii?Q?BRKmQINzvBB7uTVNXrur/+z61Zzm0iiZ69Y5EfAuFGiRyJ84C0nQrE0jNxH/?=
 =?us-ascii?Q?hcMQQcJVz0CuXbchgQkbiJzK4tFpZOiNUraJ1Hb5J2JwhX4arOgpIzl3rPBP?=
 =?us-ascii?Q?KwFs7ed18ULkYZwMteqxMTfthkjdcrWHVLMmrWnAA397ihzrPmaDUuGcmOtk?=
 =?us-ascii?Q?YdZCxnyL9C5eg3bD8pKlcExKQMJc5pH310vF29EtZebMoVcRMv+VSTecBIbM?=
 =?us-ascii?Q?utdr6wIJUoi83Hkp+1gnlqTxFqNOCM0hrTLQYwahoznIIZOhHn3JE8w/wqSU?=
 =?us-ascii?Q?LetagjtBfGk2FZp4ggW+VkN9JPZOa5i1sooElz0xhlTTRw8Q1sSsOeusYqf+?=
 =?us-ascii?Q?GyI2Flx2vzYwb8V6LinPbJInaARZ6cUYEe/oH3AobJ+d02M//W7t0sHMWS2S?=
 =?us-ascii?Q?7SJY9pOTWwRCxHCCABAoWmNnN0X/5dgxcPmR+iBtg/QLna6TDMz00VEnszMm?=
 =?us-ascii?Q?m4fLm9Nnqu3w9xEoTqvhlD2a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3kL/k9ByACePTf99ZWwZLLHHNBHuQ1s0vkDXxH6gbreB9HCjEXfdmyVUxhEN?=
 =?us-ascii?Q?y2Qh9c4nvI4cf0ufqsxwbKzz5FaGrMt1gBqNOF2uCk/SdkcVzDlYF5SAdhf+?=
 =?us-ascii?Q?WP10zHb4b7Yps8cx5Vc4YFK/b8yMT9XkAbRfb9YZmrqllDXagsZs612Y+UhM?=
 =?us-ascii?Q?zamgaYa8X+kyqZHq3FJoy/tIUOBeR9rlS4FzH+t4oydpabKLwe6OzC4moqNn?=
 =?us-ascii?Q?OIJK9HQOEzpdZEoC2JqWA9ZoR5U5cXMwzCddK2B0heg8eiTzV7OndGebF//s?=
 =?us-ascii?Q?0B4qUYG6veX4HP6ZzOs5kw5DXOUNZcekRixG2W+eGcyBV41+dIRtdr771kkg?=
 =?us-ascii?Q?o3aYR59rAJJ8xO1omoxQJJa5r9YowApawb3TWSy1/iTO7q/c2EinetGZW9R3?=
 =?us-ascii?Q?/m/hROWfSSjlaglYoWrrO9BHrF6KKnxH7dTMMWGpdODXAYw4l6UwHlVZRQqf?=
 =?us-ascii?Q?9QojnciloWwMUeyn+Mje3DYJWDJAymo4vn2//AqAqFCAVJmfFJuIvPmxSKbF?=
 =?us-ascii?Q?2stvsoxq426g4sMmBQbWN9q19n7AtXlY+ODGh2stNmdaFoI67oEvX1nlFLhe?=
 =?us-ascii?Q?UbsAJkVsufWw9sl/BD0KeCRKBPSDdD5TWHYaGqp/To5G9BiP8fIAYrIHiuCp?=
 =?us-ascii?Q?HgsJXPHyBybZcvqSG4glD54NK88boJIcBfYOxfqUSq1CBoLnFejYXqndmKdd?=
 =?us-ascii?Q?iv7Hv2/6KFrIAJRRTsjg1Ebm6E/zECFbMQXg2sFRrfpLLZEqwdWWoQuhKYdh?=
 =?us-ascii?Q?SdFI84/NL6JieX1iWujL33mPErYuWtoVcRDjBAxuw/DyIDDagJLg/WEo5rnS?=
 =?us-ascii?Q?whsLWhTmTlRH9m1IovsnxkR7aTyM3kDXGk9/OQ9oISE2B1T3PWX/uKKXhu/1?=
 =?us-ascii?Q?0jEq6PrrjowfLRWB2EEFtTwsj6sEx2VLbQoAd+P6Al8FP3F7n2h2zdcftfk7?=
 =?us-ascii?Q?H+yPYxpeyYO0xiTUHeAspm7JEP2I1b74cq7wR/TvE3ffJ5v0h6JjkYrGek5E?=
 =?us-ascii?Q?F21eeOZbwfWYRmeJU8e15MFFv2pYLPk45Gu5NkSYU5Dhk4BDTpev7CqXkZQm?=
 =?us-ascii?Q?CCX3eDRFDDmk58GD8KxnU+jr1QLsc/CHpUZXbJ8ezRL3ilwjBZVvflm4nAk6?=
 =?us-ascii?Q?rTfztQ9BdPVsfzRLxVkknAX7tPia3KriwBu2Mntsd2WLD6UWFKLbbSMLrMu9?=
 =?us-ascii?Q?alh4KYYwADDgckxLQECj91Gqpi+0J29RqxehXoanOE4Ms38q97tcMbuB2Vd6?=
 =?us-ascii?Q?oYl/SncCp6DRcbRMkQDqp5v8okwDZehLUEQeQ76Kp9YQcJgUiF3wwcd9ob2e?=
 =?us-ascii?Q?sj/PkeRDaD8v3b9u311owE6SXh9zhA4d6RhiRL7qIBEsN7nbl6CWEMeeFf6V?=
 =?us-ascii?Q?o7FYiHZ1zGzerLFZg+rIgPGi8WuF8gVbDxPr0ElV4kPMucwonQrdt71PiO/b?=
 =?us-ascii?Q?DfMdN2mjNstIM9Mw0BDavTuEGvhxdwD/D9CJ5POe5pmCeUSVkXaXuMJ31a5q?=
 =?us-ascii?Q?4eu9tOSI7m42z9Fw1te/4lVjuxAO3d8gCzihDgQSQjs6fgKHYmiiK5FlCDDi?=
 =?us-ascii?Q?KrqLBzgIWidFcUIev8ZUAvxJ/w+fTLk5NeP7jqf0hrRtNxs/18DCbcD3axqW?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb0b0c1-458d-4aaa-8ff0-08dcfa6997f1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:37:40.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5Ljn5b4+NDC/O5DSjhzrDsnyJta2X+u8BytsQJgqqLq090r8fwi36nlE5MoZ9rkSrbbYyYn1KRZNbyjnbnLrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7573

On Thu, Oct 31, 2024 at 02:02:46PM +0800, Wei Fang wrote:
> In the previous implementation, vf_state is allocated memory only when VF
> is enabled. However, net_device_ops::ndo_set_vf_mac() may be called before
> VF is enabled to configure the MAC address of VF. If this is the case,
> enetc_pf_set_vf_mac() will access vf_state, resulting in access to a null
> pointer. The simplified error log is as follows.
> 
> root@ls1028ardb:~# ip link set eno0 vf 1 mac 00:0c:e7:66:77:89
> [  173.543315] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
> [  173.637254] pc : enetc_pf_set_vf_mac+0x3c/0x80 Message from sy
> [  173.641973] lr : do_setlink+0x4a8/0xec8
> [  173.732292] Call trace:
> [  173.734740]  enetc_pf_set_vf_mac+0x3c/0x80
> [  173.738847]  __rtnl_newlink+0x530/0x89c
> [  173.742692]  rtnl_newlink+0x50/0x7c
> [  173.746189]  rtnetlink_rcv_msg+0x128/0x390
> [  173.750298]  netlink_rcv_skb+0x60/0x130
> [  173.754145]  rtnetlink_rcv+0x18/0x24
> [  173.757731]  netlink_unicast+0x318/0x380
> [  173.761665]  netlink_sendmsg+0x17c/0x3c8
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

