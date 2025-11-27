Return-Path: <netdev+bounces-242198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229EAC8D53F
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C63AEBA3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 08:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3E26462E;
	Thu, 27 Nov 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QGY7vfs6"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6041CEAA3;
	Thu, 27 Nov 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764231917; cv=fail; b=rgSxN5AvmZliBKCogNy2403eMKjn9eZ8bQvacGcMbP9qAdABHB5vcMHIHigF9Huj4CUBzw8ELl6+/E5+sS6/d+E/Iwq6UmLCsmkrEbBZ88JkQX9K2s42vx5w5Be8aj2IeqRpjWmrEZ/ECgoxPXrZymwmlAVTGhVyWsphqEl3nv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764231917; c=relaxed/simple;
	bh=9Uaaly+tPeY1uzPXyWmSOu5tTl6OIqdSRTxdpqM/QCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nh/FLcqNlH1tEW38CR46GEFzOx9pcgMFeoqPC/saSkQ59XURiTBIjMUPEEiqFrA9Xsj/LK2CfToP67+X4xRrQtK5vZkZV7ITEZbezOqRd7Mzra4E8qa9zzFEIc+T120n/UeIV2Vi6T/o8Wr9WBTj30+D+T385B+/a4KdF/bOelk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QGY7vfs6; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCFMLa897mAY/LlDDq+0I6y/YzrMCcSeko0Gv7sPVrVEzFMyInddVuSAqrbfgZDcdWCOGSXTUmq9eSYwDa9gSVCpYieB2uMEkZUGU4KiFAqsFLZRrxKk73v+C03bLK2rQf/KGc5+LzzSQI8dfpqxa+4NC16zMAiGYvbMlxj4T8IYR5z0J5W8J5wCN+wvWLjPtR+PLT4UbKdyij9eqFk9+yRVq6lrsg4v8glZibwwVqv1w2qdTg1YW7g4sb3pi1oc9GOBv52s3JOxtcJJhViGAvcyIu4DG+1l9qiCK9d1O7R9bSZ5Km0PNVjgnCx5taNRLZtxBmC3NEjWQuz00gDxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9fCFKJp6enbPISIqLwLEd+SiWZU5mEtM/Lma0OLCWE=;
 b=YOfh1X0KTQC0SZZTerjzm7BrRLSeDCnnSfXtqHPL/a28TWVe0/xrm+VaocL/d45ThzBFeh7iBfnZUffDqbeQ7M9UQOxOK3rZWVOt29pSsOQWZmgFHMgKNIKl+AB/HgYBpzJMUe3R6zc0hHUYx7aS0q9zzwj57zvzXOEbH47z8ZqQgpRT6/Tk0vAtfU1RuD/1u9HK8u77AKugTaUMv76ndXZiLczG6UsKz2DvWJ1BncH16d22q/Q1XBGRagxXgKveNSr0pwqbQbxHMtb+v7CjCJBRq9oWht2Nv6qXMwgik84q0MRTLOeSf97EjX1ieatm8JEohVwGpxTKfssvTTYcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9fCFKJp6enbPISIqLwLEd+SiWZU5mEtM/Lma0OLCWE=;
 b=QGY7vfs6fuhS8tKYE7Gmr3t3s4JutDcBP7GTvRC6DkU+0JMbEohN3WiygVDY1+Z8yf6GOZspRMVi3q7HiOo6/OrpTRxYUyV6HxLVdWzBJawB1Nl42tQBJDYJNGKn2Qln5rGh3j+5XiNsO5M+1xC+6Mh8xyA1HL2gC16667W3OyRl1mo1eGgsnjuieGwrLcEpMb7VbuMiqE3+NuV+3z0Kjo3s94BdHc7oi/aVo/PiRfSFGtaBepHbjrHxNkkkUqGzq4roW1+Azj+DKzzCX8Fmmesk+iVWXoswx3yw1KjZplYLpIDMeBHcnMPdshtgoeQz5fxOEfDl2L1DIXP2lgSQgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 27 Nov
 2025 08:25:08 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 08:25:08 +0000
Date: Thu, 27 Nov 2025 10:24:59 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jon Kohler <jon@nutanix.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jason Wang <jasowang@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] flow_dissector: save computed hash in
 __skb_get_hash_symmetric_net()
Message-ID: <aSgK2wfLJurn2df5@shredder>
References: <20251125181930.1192165-1-jon@nutanix.com>
 <aSawDrVIMM4eHlAw@shredder>
 <8EA496BE-669B-44C1-A3D7-AF7BD7E866ED@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8EA496BE-669B-44C1-A3D7-AF7BD7E866ED@nutanix.com>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d903250-fb5b-4fb1-f122-08de2d8e79cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rt4qKNr7qJoUcn8QOOvhZ5qebbTWTMAEdhCjrkCT4zrCRyrTO4mM5Mf3811J?=
 =?us-ascii?Q?D+0W8oRFJ0aeheWiHV4jj5DlaJt0OFc4X/imchs+6nbMo5+B3OPlgvc9s5tg?=
 =?us-ascii?Q?xAxcLwYWP10HWvvrxvhqGzvxorv5ldj3ahbNLB2ktilE77d7J/H5LhtE0dL9?=
 =?us-ascii?Q?xLdwKVJGF4Qf9fKXocwJvVWOA78vKdOM1zUql7T/D2inXnZRY5CesqmoYuXL?=
 =?us-ascii?Q?ZWIFodt5rVrv1N/zEjUdAijyz6SHxt/9iCMpaqTNmf13KF+3SKaHsWGi0sP8?=
 =?us-ascii?Q?XuZQ11+MXOsLKtccNJLinVXOzojIYWQrp3ry8RzTgIDK10NX/1P6PHCoSTPt?=
 =?us-ascii?Q?lKNr15vJQiHzJxCEOtU94XlcBiUQ9tGN83EfsGe8IsRuUjAiwEw/wFREEHEJ?=
 =?us-ascii?Q?DMkT+acSMX92phoed4+tKzWNbjqtLCdVDSyzs69qP3CDC1+SnECR2sl30Oxd?=
 =?us-ascii?Q?AZ+B4XjLQwvJMGsLjaSoeo9Kz8Fn5LJ9G88l/k8ZJ9ITUq1Xxo0lQTcalIct?=
 =?us-ascii?Q?dFqH9oR0XFZ1/bk8ytGbgeExvEdatxOd6nqYXZ5HotAourEe3VaCiiYdVOm7?=
 =?us-ascii?Q?ugp9+63KrdvJg1CnVPGXVI8gq7tECfgW0wQbmQGU29+k78FQ3JCPL7LBm0IJ?=
 =?us-ascii?Q?06EvVz6/xcMcLVofYGo0DeLJvVIU9rlOhcTN7D8zV1Jr3sPNWQaEhQgNkp3x?=
 =?us-ascii?Q?dcYrpYnNutTexNVWFbH/M5nbuoDApD2ufcwgZvzpt0OQz7VWJPZSiqU+FJw0?=
 =?us-ascii?Q?HpYmoXtCFlbm0CLeGocPoYVqXc6iXhYjM0756QF0byU68suRrC98KmNrqNIS?=
 =?us-ascii?Q?E+Wk3jcciXueSsoQpXrnvspCbDjeTSRQqnpkj9bSbnMv7LVBqgJcKPDoBBi3?=
 =?us-ascii?Q?eGACWWYU9J63xioGovCa8GCA3fH5y2vvt10SkP8GdhY0HxojWUHM4GN/7NCB?=
 =?us-ascii?Q?wPcULDu4SCyYW+TBG/upNJULfJOSJCUTN2lr/Ieg9FY3PkIsU1HQupM+Bi1j?=
 =?us-ascii?Q?d0fB80NNN6GWZ3hn1jCUdxLQn2H5kYz1D2VWyUo0uyZ1qYpdYde1O8UqTNAi?=
 =?us-ascii?Q?T6Ji0UhccDDd258Hlc2aYG497ziccvJzT5f9UkEoTovoqgfBdEpLSCl9kSNA?=
 =?us-ascii?Q?T5tLRnCTO1Yt5b66QDOLwoEWDDHYKDNu/il5F4gBFTIw1g/utOOYEXqXNh1X?=
 =?us-ascii?Q?iCth2UeTJ/1IZyhdog/oXBcJyJElL9BWVoMuC6ulohItBDjQnbfbPZ4c24rg?=
 =?us-ascii?Q?IT/sRzuiCWGSE6ezn4hU5O3gIp9ZdGc6HyzcjdrG6+3ka/MSCgI4iIVJjCsM?=
 =?us-ascii?Q?+0e7CTYp0yFftAG4PT7biz7IdtyQqBp/5NXd8Qdx4JqC4c/OXJksdmN/VPlp?=
 =?us-ascii?Q?3qrKT70iv33wa7Je5jGt9JJvOoUFJLF1XmliO8sU9f4quhY6o4eh2AnwVLYS?=
 =?us-ascii?Q?2VHgRtUyXICjDHlQx6gOhgoiLKwY6fT2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7MWb0twNwfEW6A4Ag9vmNG3EhDvypgg4M6Whg0jVMB3jcV7NExjg4Q9X65O9?=
 =?us-ascii?Q?/By7kbCdBOwKBsxsJzeQvth9BwYWPK/f60ewAusj5QBoAzAMvsSv2ZKTcbeJ?=
 =?us-ascii?Q?0A3ILtT49B33G9Klk/qu0F2lB+7DWOByh8dmy617U1kf4/kNMEKR140TigVJ?=
 =?us-ascii?Q?TPXiiPIzJkvAspjbbbX5RWNxaVnY5yonaQQvCSQacJ6hYUjh7tXw2Yzhd/pd?=
 =?us-ascii?Q?lXICtsbdRYgdHe4MSnjciGcGO/fzHUPUOtGva/O9hS2jyWpw7K8dGiWjBg8S?=
 =?us-ascii?Q?bu1fHaIhjnkXtzUbPQuPBiGiNVoRSbTZTRpruYeHTkQCpYLQpOsS5uGwrxGB?=
 =?us-ascii?Q?jRD5oMswOfiZzTkW4lEUcu7OgVBj9IgyMyZXDgSULLHYLb6KpDWubuzJt/OB?=
 =?us-ascii?Q?pQakZI8J8ZN0HQslRXKLGyygIfe5Z7AtD2h/J5gazNd4rhIY5mE6HEhcJUiy?=
 =?us-ascii?Q?vr8t4YPqmLYKdjhFNgRIQD4wiPHjAXunv919VDixE9D4hKsO2vKsbg9S7jxc?=
 =?us-ascii?Q?P+DoKbbQKQUdKXRAZyg+IiuDaw2Tm+n4Xv03JhVM+xcUDcIo+CPXUHOQz3YL?=
 =?us-ascii?Q?muGUDLFj5c//nYVUcOC2Aa3SjEJXfWYcD+u8fCJ/YOFTlw5RWNPwkla5Rrq/?=
 =?us-ascii?Q?nhUzN0y+J9SNcMF+X+oJSJvVxMgO9qym1VmZ+FALWHpgPmXtl2uSGcHUkmnq?=
 =?us-ascii?Q?0sNd8WtRpRDG7xMLTHJpRmQ1K5txjfeynTmuXYWGbeyCOGxm5pa4bCM+JZux?=
 =?us-ascii?Q?IB9d5w1Z7LywFXnYOcKAJbolZyxYv2/AbLXY4PVE+ITi5SnXRGkXEexG7+du?=
 =?us-ascii?Q?ZUdSows6sMC9zaGNoeUCXJngZM6NyjAgx9Cxi0kx6w8jLyBwA8bM/plLdk1Y?=
 =?us-ascii?Q?vaI9k96eQo/+Zp3BZ1xKvDRwm7XDLOBVxTfepyghAzvk4yqqCKtJrDzESQz0?=
 =?us-ascii?Q?xCeRMmsnfNub5DHOPrKgZVwHugyRvGTHkvxP2W5KLaIXCxbcR9+VoDb18YDh?=
 =?us-ascii?Q?TO+sMECOqg6oQgSdWWRkoHBcs8dLelgQEZazERS3f9HeV2FsqbWcsSMLYGRL?=
 =?us-ascii?Q?Qk3Ns4Rqo4Hc+61jx9H00tiGJ2PyuPoRcLg7jEHLTXtjxto9/4xmC1MHWiYR?=
 =?us-ascii?Q?ps+UdThoUNiGnaeWlWZMoOreiUsUrcordgXkJaZecTvGYcmVUdCF3LSfE5kB?=
 =?us-ascii?Q?AX+jKf5QWs80X9RFeTBlA8VM2gD2f9o3CeuTPN3z7F8GwmdFc9npcrajE0Td?=
 =?us-ascii?Q?5lp8kOVLDS1u5z0cXtjnwug2hszr6XxlM6JjqZEB6Wg/oOGE4/1TwP/DH/7a?=
 =?us-ascii?Q?1JV19VIGF1lVFANn+5SQOb3LJY2pVbA7j8j9xaAbrNKYHtC+/qMGPh0TKoQW?=
 =?us-ascii?Q?o9unCO73b4dXTg8t/x8lwKYRbVOJqJ9nAX5nx5qQRDe8m7PfJpJi4M6r/16q?=
 =?us-ascii?Q?g7TGt1WzyWOtqi7GcEyvi9hINq+V/c5CVjx6ocetZQq5WEAWMGWTnrGzTf1F?=
 =?us-ascii?Q?4v/JRDgg8CUC1GaL5Svws4Tp25jCKs9dUAjEP3kq7tTZHDSmHS2HClBe7QiJ?=
 =?us-ascii?Q?2I704XG+t20FzTd9KmS33LG1dDjCWalDlHjfRFue?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d903250-fb5b-4fb1-f122-08de2d8e79cb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 08:25:08.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLnR/WBfXZahMCbQVLzjxVVOpigUjfPN8hBSMj0AD+ZBvfc7Yh192E94H0ItrIpjVxECisAPxGRI3qweHU8LIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768

On Wed, Nov 26, 2025 at 04:21:33PM +0000, Jon Kohler wrote:
> What about a variant of this patch that had an arg like:
> __skb_get_hash_symmetric(struct sk_buff *skb, bool save_hash)
> 
> Then we just make calls (like tun) opt in?

It will require changes in all the callers and I am not sure it's wise
to change a common function for a single user. Why not just patch tun to
call __skb_set_sw_hash(skb, hash, true)? IIUC, even in tun you only need
it in two out of the four callers of __skb_get_hash_symmetric():
tun_get_user() and tun_xdp_one() which both build an skb before
injecting it into the Rx path.

