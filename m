Return-Path: <netdev+bounces-84946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE0898C13
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A59282758
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63D12AAD4;
	Thu,  4 Apr 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iPUSjhl5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98F1BDCD
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247956; cv=fail; b=HHUf6iLetUprwUsOtZyJfIIAOtEGNNbdfc8+80qjWHpLTizDxgQWPCi+7ApnGhyL2oPpTcRiO/K723jJzsqxnIVmDwLXHbitEG3uyM2oZVZc+a9+pt3vTL3kdxe8ZMuzvty5ZlAkZmXjX70YUhCnkZop2V/wQP2zjUy0mDiyYoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247956; c=relaxed/simple;
	bh=nLGjj0ReCXMlyp9CzB5By3ABgRbLb62MP0clCIvXd5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FAr7bnkuie/d7+5SM6rMc55UzNcFhKI3Ri2Oc9owxUqPAvRMmhYy4VVDbFUhJfB4Padn2H6E5ZPNSKqAV0VtrSRsVBxuDISBRpQ+beX7T8MKcbBgQd0kJKE1WjGvZsUEptEBwvIqgjI4fmkESlmTH6b4BkJh5DHI+4a+Sv7VUWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iPUSjhl5; arc=fail smtp.client-ip=40.107.93.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFCMbKbwxtfFiZLTieLkW6NH/lbLHp+RpZbbHs1s86V3vq9MpO/q6n8pyJpyHWsPlxDPsm7cXty4Hil77BJi0UWhG8TygIgP5hVloIsJFIEj2/cufiGmWoMO4nSzLLG7WBRJSnj6MJRni5fotfUPZFuaLGJqW1vEcgR6XfmHRHhuMgUUi1tF0CG5Qe/zqTU1UuNQ4nBDCyyH7U6CWl6ptW4++sqBsf20RdyIk7Owrxnv/ryd3BPqrZCEHbdkplQ9EoooAGzynwUDS5mh9v+6GzChnut1rwzwnpm/giDcX6jc2/lbp0yodhdEAfYgitXkc3tw1SUkHQGQx+7BA8Ydmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbqGwm5vmh+PNeq2LGBmmror/RcyFoD8sSogGOnGcck=;
 b=fCUr8dRP9Ub8fRnt7OgMlJmcluBzgKCBBjpHj8CHms3GDOyjeDEBGKvacwphMaIWFid2Y2spru51uoAxj9QU6JLKsgzGYjy9lJMj5M20xNZg68uUZ7wadRt1JdakLIVemRwlZ/6DPtKHgOE6/Sox312N1x/aYk2Su/3nPG5LdmzkV3wWPG4heI0w81kkR9HM9ibWvE2iY52+L8edJt8JXHXEnUs8o20gofKUPX1khLiZw2Wu116os3C8K0m5aSBgeAjR3ypcD4Yx05k2Y/rbG6clWE1DOkUR55y8d7d+DSUIs25OGl7UT3hhchTFZuZSElXKVx1lyffMf/6BqDqT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbqGwm5vmh+PNeq2LGBmmror/RcyFoD8sSogGOnGcck=;
 b=iPUSjhl5KrdxA/it4gY9euG6J5ZS5J+JQ0qKdm/TF8NmdY5hzC7jgMgjq6ljV/81CxqfLlgLqPsa3MpDzdMXNPllKcYsEHO4d4RsKXIdGj+eV//TlTRlg7EQNvHKXAKbWdl4vRRsk1wNuQw80yA5dboqxIUezXXUdBoh8R7bJ7AeSyDM8JrvmPx1CF+kb6peRftYke3MQLzqOkpXfJvjxqclsmJRnYJaNSNUaVHgoM8Z6HyKlptow8AO/T1/4cxYPCIZi8/lTKlBrUsgtWDb7r49wPf7qkvzIJPJ8nYzvvS9gWlQtosbB9yeiH8DJaRpXte0I/9B9FQQOG7iDL35eQ==
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 16:25:43 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 16:25:43 +0000
Date: Thu, 4 Apr 2024 19:25:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: David Bauer <mail@david-bauer.net>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	amcohen@nvidia.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vxlan: drop packets from invalid src-address
Message-ID: <Zg7Ug080-7o0wiWD@shredder>
References: <20240331211434.61100-1-mail@david-bauer.net>
 <20240402180848.GT26556@kernel.org>
 <Zg1PYMUh6FCT5FQ2@shredder>
 <c4f2c217-b2bd-4716-be17-3c6097873061@david-bauer.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f2c217-b2bd-4716-be17-3c6097873061@david-bauer.net>
X-ClientProxiedBy: LO2P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::29) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SJ2PR12MB8739:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r3JhOi1JtLWKS298iEc6CSu91jA/aCEBMddYEzFUWZJ+OdQN17eG6u1EMsq0FERdIy55zJGuZ7OZW4f1u0Bz5vuZLKXx//CN+z6H6g3H/bkVGo4advj60vunPBJZIuhSQKtlDVooUKXdNULZabHcWehHchJYlskGPM8Mg7dhhsSf7RzGULx44OGWFLbFv0elDgWv/5jSuPkuXYIv8wqL+ioes8WZ5NWdjRa+EIoUJUeXpcM6zlgGW5IXTQshcUnn6hvE/V+Z3TMp5fHB0P+SvnUtTdnLZu826hwpj6PAJKEb9i7rLm0gEgZrKsU3snx+Gp4glA2xFO822i1gXWSos/+o9bmVlFO3Crej+MTdh2p2vSPt1pgyHiKI2yJmmiLwE8yJkg5G9L7Ydm/sgEOVWP6bxa0eFXJwd6lY3KBa82ddDJLKURuAqk0n1z4lb1ak7naUdasB1amYbatQt+f9hPIJwQ6RxGTkMtg2D7nI7JQ9bVsflSCo18oxzQkmSgZVHIpv2cCtnI2lzcqvpwmr4WoHmSL/huESJdVL9CG2nZbb3vHM9e12INBU6F22iCmJI1ux5BCZZS2rBM4Bp7H5bzaWy3gUtQV/Z7+48uDSK30cIgRT4M9pHLFD0vGaR8jWcCjZdg2+E3yE57/Pj2Xpfv71fwy+suv2KvsW3yR6Eio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HFEzg61RYOgjdhdWHEnJg8Rmx8Yc/110aje4nX3oE7f2JRyRHIsoSyqi9TrU?=
 =?us-ascii?Q?G0FKdlA+Zy+JHLY8yr4uIavAgMafD+ZRrBpxb/xHUIs9sHt6e+srVWOtRzKx?=
 =?us-ascii?Q?mk1B3xResOBY6G4cB21rjDAfQ7f4OqTJigD/kKBQKAT1HOQELPeEoac/Qmg4?=
 =?us-ascii?Q?cY6nk6S+FUZnKP4b0h4nlHJTW/zW//xpYJY1isbFkiW6otHXvhS22ZCz1Kuk?=
 =?us-ascii?Q?7UOwRki1Ka/SWDcV3k3H9mqiWeZswIwO25/g8sP2R+dtps9KGkklE7qSJx3p?=
 =?us-ascii?Q?MLbQX8RTS+1woWVq7s0yTTJIDCFeO5nBAP4dQY37rCey8a++XNz94Bw4MuQi?=
 =?us-ascii?Q?jUtCHiy4guT1PQySIKgyc760gLuRqnWZuA49vxBzUlMEI+C1DWttQTLVqz7Z?=
 =?us-ascii?Q?5bR31SFscVUmqhY4KKLztcOc/U54NP7N8XwTFFchYgvfm4H3dZ22Bi8gvIgL?=
 =?us-ascii?Q?VOx19M17c/FpfEn2wZNoZUSlEqGymm54ZgRfnZg5e66A0MDOtuqf3/fJDxav?=
 =?us-ascii?Q?+allbJnguCI+8EF6NNxasPbsWtBoIcrf5GSrQbM+m7L3PJiFUJgdXv87+YZ5?=
 =?us-ascii?Q?MXG4UK0o0PNMmXbpekjTix6gQjeggELv5U8K9Mq1KqrsMuvNiqykQF4Ncs44?=
 =?us-ascii?Q?yASbYwJP6wR7hqKnw36QMe86Hb3bxpLtyA1pc2Uv2ToieYBSznELCef1tZmB?=
 =?us-ascii?Q?SLbtk7d4VFOEvJ1IBSonEK2uR4vMaFsTYwRO43SpVE8Dof5uhYN5CvOcR9lE?=
 =?us-ascii?Q?3RdyuEto7tMdiPnDRDtq10Y26tT+RKPl7hkvMq9LLvlaz63yUyGORi553982?=
 =?us-ascii?Q?+rxripqh8crrrlK+hGSOrMB4vOMPxvRWN+/tI3GitxoOwmsZkmW+ILBW3ADF?=
 =?us-ascii?Q?dvUSsuzhnr8LYMVv5weoSedFZKGUPKCrVbk8u8rL7smY+Q3i8y1O/gDaDEry?=
 =?us-ascii?Q?W1OpRvr+CteVRa4SNlei43WpIpD4LjXDcgowE5S14JNZrdKmD1lkM6lFW5v0?=
 =?us-ascii?Q?TV/DiHDwcIUE8KIp3DsVbA9085i7VOEufXNdeoAmKmPquyup1w+zWQ4PhVoZ?=
 =?us-ascii?Q?el3C59wXI4VBpLw4vHWo61F/IxCB4I+wCuQkT3/3wxfIH7zDC8uPedub4yhv?=
 =?us-ascii?Q?RcU0vQ2uDZN0rXWDkmnYwbuW3wNWyC69jg4p0LkeMiN6CD0hUovKnHookcid?=
 =?us-ascii?Q?ZwstfiEljd4LLu5dX2kjLTJ+wgR5jRAxYo2jxuKhYknW75ouEP1qFNEw1Khd?=
 =?us-ascii?Q?+bzVos0UPLnfuWWiC88YLKHkvBFu/9OvqTJ3GL57bh/lEUWwpPnL5z7Z7JJG?=
 =?us-ascii?Q?Rmnj/jY95uroyuWl5PDF5Ecc3QhhjVLu9webiKTGqBcoZz4Nqn5w8XJWPujh?=
 =?us-ascii?Q?JkPlel/TpvwfgyCBCkAMUWmdmdJBpxVdEkNjeRkzX3b4hNxMuPkUUW7EAQAW?=
 =?us-ascii?Q?xnLkwVvG02kHiN6UPv9C/Xvk2TYTT0GdzwgDwiZTKM7dZP2r6J2FWA2OX9Ts?=
 =?us-ascii?Q?dJGEzr55K4raNhzxJXXK8IpIBLv6nTC3sccLedzkVVmlR0EwJoFVdZjo8Cx+?=
 =?us-ascii?Q?eORrSTwuwnfTP0yMrUN2v4p2AwjXe91gRsJmBvID?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c6825d-8dec-45ac-363e-08dc54c3dfe2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 16:25:43.3223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9fcSNCJ7m0qyrpitxSwlWNHTk6ZH2mmKUf+ZWVZzwuElo/6Rs+VgM6EOhI2wa1vpiFL+KvQFt14XigXMajW1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

On Wed, Apr 03, 2024 at 07:14:14PM +0200, David Bauer wrote:
> I can take care of that. Thanks for analyzing the situation.
> 
> One thing i still have in my head when looking at this:
> 
> From my understanding, when i manage to send out such a packet from e.g. a
> VM connected to a vxlan overlay network and manage to send out such malformed
> packet, this would allow me to break the overlay network created with vxlan doesn't it?
> 
> Can you comment on my assumption there?

I'm not sure which assumption you are referring to, but I did verify
that before your patch the VXLAN driver will learn an FDB entry with a
broadcast MAC if a malformed packet with a broadcast source MAC was
processed by it. This will cause the driver to send broadcast packets to
the VTEP that sent the malformed packet instead of flooding such packets
to all the VTEPs via the all-zeroes FDB entry. This behavior is
obviously wrong and I tested that it doesn't happen with your patch.

