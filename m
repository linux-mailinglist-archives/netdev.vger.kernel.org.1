Return-Path: <netdev+bounces-267130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KIkM2zesmmtQQAAu9opvQ
	(envelope-from <netdev+bounces-267130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:40:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E68A274B78
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 437FB301BA79
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844803CBE9A;
	Thu, 12 Mar 2026 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/MZ6IGF"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E8358391
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329760; cv=fail; b=fsnsOPkuSF34qBB3urILKvy1XnRa+5t55oCje3BmWCwjqEDoubTCoIYJlMf785gRlkBkDevjZMdRiww8ZtIWJftxvGbdAcqntPGhlyLrfJNdTWP5OW1kBVhTCQmKCOQuJGhOE6ibkQ7Nm2vXFxu0iIOTiTkQn8QhKdtkBqOEFQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329760; c=relaxed/simple;
	bh=tBPq2CAQufIzBlz1aD+hs6tsL/1pyzlHfxokmXjzZ3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sm07caJVxPGvwEbCBoUq5dJ5GxQ2vL2KMI3MmSyk9PhloAfQwoM4NrQfXyZvfUzw2fRVVEs/25V8Lix86uJfsb5XzEot3GCoR4gRZ/FfcfS179lCJiGS2V+Cf1mlo+riJAvMMFedO8slR9NF8OP5cvXOLtGmrCr7DoZzKe8Vo0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/MZ6IGF; arc=fail smtp.client-ip=52.101.57.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhHWAyDN1RgTIhKNDbT0I8kymZ5PEihFbDQFdjeluBd5h2SLkGJpEHmyqFnDTi+DqmvYNESntD+ccK1TSqBr/JcvVqqJztNVjWr/ddM/s6ty7dBdsLAOQl4I/MCPIqhhoS5BIDU29pfsa4UToH5p0JXA66PIPbkfU06anL/JHOCcVn8ofp9wZhGWJrU0o1F04Q8D+N8QYBdpiqh9hg2dLfA1oEEt9W4HALHIMqn9jkchqk2sYAM8/tMZCxDyuUkW5PIAgqGbleG3Iv3cV2lw5MhTJ0ejX6kFFoGG6fDUYmuecWt45nN94O9Sei/GdL8Rq+ftjVnAXZbujc+KMCD1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUhxhUSM5QwBcMbHyDoNK+WJ6rtdblXJvHHTj4QCxRE=;
 b=Hq/XHpxHWDhM/OWGgR0T+aV32AcoyLYJ6hQB9LgGDFM1VNqw53ElVJFvq4UxaZ0Dh112N3HSPRn+F9PsPMCRJqy7ntz1EUuYy2azwvXOAPfIbZEdM778dQt9PaYJubc5fYHpUyiIby9XaXiLkhBuLc+4gXrb3P4gVEnnNiHYIHbNGI9mfullbATAO2V+dbQLR07sCU/0NwBxm5WEU2eITq31DDl/JxanIHKT2lN2tZ5wPYA+nFK+RojRdzBEyLHRFJ6zwFjhJSmEa+1PNt+8ljE55/TdF0hrxUOpb1B0WTMPO0Nk+C9Y0mU+ZPmu25l4PBBeJGHpi3xikj3ECJa9/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUhxhUSM5QwBcMbHyDoNK+WJ6rtdblXJvHHTj4QCxRE=;
 b=F/MZ6IGFPrMHkJSqopWyFM7FdFAAEXIVy0bLzZ/njDzfWgGkSpVDs/2HxOljxfMhOAWrdFCWlArvHTZq/XqZuWLPl8PhgBogQZy0e7uxujeTPyt33x+HoHfYiE1TfTme3CwelxHsUA5bB3Zr+i5uMFbMihsgwpy+GZ0a9IAvklQpSyyUacXDOwwgtzoIza2o0+pnzPVA3n4eDSqcxzYAn9Q6y+hxpVr8NuymuATQkCcdNpYUTZ+P9poQN9kT2Qdebjxzqx38a/7135YIHGePItgDMCTsJxS6+zWBTSYBxQEh39TKzVd5vFHfRfqDoN+L6u8OxrUDv8jgxWFT6mie0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 15:35:49 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9700.003; Thu, 12 Mar 2026
 15:35:48 +0000
Date: Thu, 12 Mar 2026 17:35:37 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: razor@blackwall.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH net] bridge: cfm: Fix race condition in peer_mep deletion
Message-ID: <20260312153537.GA2654271@shredder>
References: <abBgYT5K_FI9rD1a@v4bel>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBgYT5K_FI9rD1a@v4bel>
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bcf48e-f911-476e-4058-08de804d0880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	6nsLBhR4KPsGE+7gCRsz73Aa2K6eZayWB++uSqEbJI6/ZhVgxqttBphY4iIeuhCUszF6RsK5awMJp9zciXx2e4tVfbZWuEcR3V//qKPnqhBFW80WOuGnHUVKVA0Pode9e+b5sHzjSh55NHNuib9b37iDV9bgxUyc9PPaHJ0JkTLll28YVCOh8hqFkf9lA/2JoMGRWVayc57wevzUdvF2s5tNTAq5VwjwfVkV8egW/66txcBSIGXyo4IOah/Qe6G5QzVBqBp+Pu5C9/MUOvGcdtkrG+RAq8yduSYqMNVlDqSAKNjr+jzTHvcJX0gbJuf8E8TWp9TF6w0X3O2/mr0Oc/+/zLtnMcqadrUn2F7Ku6Kzf9WgW5CLeGZEL38vNjhJjATL1N4yqjIBSm2PxTdXC88x+i9wkInBOMWq/KpoIAF+pNv49oT2Con0pt+rrLP4VoInw11g30XDzDxSeYVrdzUE37caebpxwHhMXpQH1epvuct+5rzMyTTBXz8QwLEqUWdM0BvmSS0/Hx7uEYI3JBs1i6zxR70Jyd7MHMpCyVINN3ZgjhL6t5udQE5sfYyDgHV8x6xwKTNe2B0aGUhOAhNH853NmLieJA6QYQjvRMtRYH95zZbADbHl6hIjydZJaSaWV6C/77UHpIyCFx1RETlEtC972gak53mcYHJBVp+uSmdpPDO3KsHXeK4x9t0B5Cyn68fpxZNT0Ov4UH+79tzhBBU0Hq/vfX+aBBOvYr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Li8yXQcd+aKq9m86yqM2ubD9cojAW45jeggGHY0p9YiYmduocsCYrWhjYD9U?=
 =?us-ascii?Q?yL5RgFJsOGenHs9j7SW30z6G/1zlvjKDqVa1UcLTGCRsH9gv9dOQkIRombFa?=
 =?us-ascii?Q?TK2ML1T7LWgaSyL4i/PXkqxVvDZ4W1mnVC12JQuzCHKa23Me5xglUlx3p5pw?=
 =?us-ascii?Q?VDPP1iy3Ztqvspw8Qdat3ePyxnLCZQGT1LnCBefXUKTglObr3EzXBUPVKa/A?=
 =?us-ascii?Q?2z9p7zCqdkA+TEtTxzWOQlY88aUN7W8ScKNut7xaZH7BaE0VMM8XEi3CBUsW?=
 =?us-ascii?Q?YC0QOGhM8XCeVqTZHpe3ROA1yGW3Sle4rwl0uUdKSyf70e58/mZ2r0Zn6RF1?=
 =?us-ascii?Q?OZQAxqIsXjLBsw4EhoUJ7kPfgYFbRI5tX8VOCOASjbJ0UtFKzy96dIoCq9ld?=
 =?us-ascii?Q?AkN2iC6el3Ce76Z5ZmEMxKnGiUlK8kiWdn1X0+gV1G/9zzp2XXkqmytlXeqS?=
 =?us-ascii?Q?A7TxZn0r6w+zIDbaT3QJmS7CJU/WCNyTWWiyQfjapteSIiYvkEJ/sObZtFeT?=
 =?us-ascii?Q?mpUhV5PQeqgdbs17tCy5FNxJexq3XLHJAp2X7g7/MdW7Y+G31oZhXqc5lmoj?=
 =?us-ascii?Q?182pJ/AkNY0gaJ2FSU5lfPfhTz5putlf0pY8/gXoV9C8zL5lyWSHWzzgIS/H?=
 =?us-ascii?Q?9xlGhn4FHf7PjOWPNM3plJAxBE0bPakN9aT3G88/AcWTlSL2moxVyRuQm8cZ?=
 =?us-ascii?Q?S2P0Cx922CK7G2Lawn6A5SQSI6NgG9qTDwTfmgOz+6OHGqKTue3wZCrQEyfe?=
 =?us-ascii?Q?iKV4kYMwRqm8dYBor10J3FcdRUnz7PHcpjy3tWtwiKrIRZg0zlxJMf0ivFUM?=
 =?us-ascii?Q?1u3XETXmzao9Sr/Pp6NJa6priCHWj2l1DMOnqIc+FTM+hbBKA1Kx6qXKD84U?=
 =?us-ascii?Q?vP7ELVKALuz4MHvIN2q9jErn63C9wlMyDt4b66S4km07BXknBR34gruQPL8U?=
 =?us-ascii?Q?4gC+7JktdXmMPQu10nYD6zuabM8w0oO32axQdqn//SP37++baI0tHcbeBrFY?=
 =?us-ascii?Q?SpwQqkjHdoGqTD3DaexvnLC+D+HBuQQ/pwcXk+HJDZYE0+MqCPUVrHmOj0N1?=
 =?us-ascii?Q?qzn7sYEk04YCX16FJgrJQTO63S5Uvav44u8x+umc8455ZWguDwNCg9VvihzJ?=
 =?us-ascii?Q?289H0UuvA2+20n05wR+KOaORAbMjVqJwHf85s4C3JuRxw2C82hUMWXQmIYwi?=
 =?us-ascii?Q?+GAepZ3WvlvTdNhYZEtXdq6svG+XW8j60vAgGw34nYQ5caLhd093aeABtRJt?=
 =?us-ascii?Q?1ZNn/7Fn/B7qY9gJErVdKUYaHESoe+l8KCVeTwr+mW9/uj6ay8RI7Le7Jk7B?=
 =?us-ascii?Q?j97RQNBmfz1S4wdGAlqelr+1/kf3+D1fPjczGX218Ltocbii/duXWmo4qwmg?=
 =?us-ascii?Q?oE71IRYDfySutVmDZn+v0C12E/dveyK1IuIYytiMhdikpnm74PfeG2ER0MZh?=
 =?us-ascii?Q?3ajJ+GVW1eIRns60GBSXYdoI5FuRo1uaOLg7MiEXcOytySsbwhNxiXWi3p2Z?=
 =?us-ascii?Q?H8sGR6T6gcUUs90yVXkmshzVgU8kbUyxUtrHFUvd9OoPYXyAMzxFPpGfj3P3?=
 =?us-ascii?Q?ivzqKnmbJ3nfiYNr8qgvYdjaLSYZdmWeVDaBkCgvwZRNqSLYImePogo6gbp9?=
 =?us-ascii?Q?Oi/EU8pqX4HZ+GF4E8zdWNZzD5JZ0U68fTmhoLkO/ZkWlKBKpUAzrWunP/5R?=
 =?us-ascii?Q?46X4Rm5e1ZiANDxkZB/TB2uUmpLNNFFLnzWdbRDCMK6JTKgW9E7/pixHcMey?=
 =?us-ascii?Q?2tgePiagGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bcf48e-f911-476e-4058-08de804d0880
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 15:35:47.9783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJDOJBVLpcYLigz1QkNqtU0vs+vgbhoLCmTV8DQQ+Zd7bILqEmhIYUJguSO4Ak8gKQcpOQq5XHX8NcSFlTL+KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267130-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 9E68A274B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 03:18:09AM +0900, Hyunwoo Kim wrote:
> When a peer MEP is being deleted, cancel_delayed_work_sync() is called
> on ccm_rx_dwork before freeing. However, br_cfm_frame_rx() runs in
> softirq context under rcu_read_lock (without RTNL) and can re-schedule
> ccm_rx_dwork via ccm_rx_timer_start() between cancel_delayed_work_sync()
> returning and kfree_rcu() being called.
> 
> The following is a simple race scenario:
> 
>            cpu0                                     cpu1
> 
> mep_delete_implementation()
>   cancel_delayed_work_sync(ccm_rx_dwork);
>                                            br_cfm_frame_rx()
>                                              // peer_mep still in hlist
>                                              if (peer_mep->ccm_defect)
>                                                ccm_rx_timer_start()
>                                                  queue_delayed_work(ccm_rx_dwork)
>   hlist_del_rcu(&peer_mep->head);
>   kfree_rcu(peer_mep, rcu);
>                                            ccm_rx_work_expired()
>                                              // on freed peer_mep
> 
> To prevent this, cancel_delayed_work_sync() is replaced with
> disable_delayed_work_sync() in both peer MEP deletion paths, so
> that subsequent queue_delayed_work() calls from br_cfm_frame_rx()
> are silently rejected.
> 
> The cc_peer_disable() helper retains cancel_delayed_work_sync()
> because it is also used for the CC enable/disable toggle path where
> the work must remain re-schedulable.
> 
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Not familiar with CFM, but your explanation makes sense.

AFAICT it's not needed for ccm_tx_dwork since the delayed work re-queues
itself.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

