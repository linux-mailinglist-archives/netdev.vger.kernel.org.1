Return-Path: <netdev+bounces-269969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOcfAeRvvWmt9wIAu9opvQ
	(envelope-from <netdev+bounces-269969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:03:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037822DD06F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 109BD30095E7
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28A28A3F2;
	Fri, 20 Mar 2026 16:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CmYnN1It"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61894275B03;
	Fri, 20 Mar 2026 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022622; cv=fail; b=Vcrj3YNoYWC7itxi9KZ47vaO/mifPSaAZlSinu7E7LMzwrlMBpL0mbZWUdC7pKALlGV1qVUlUoLLZ00aPgnNAE4k20YWkN298egF09R3IGAGhwzs/hUKioo0J2DJHqDoeq6u1t8vv/yglZAmfDh39Pu8cMIcNiO5qWwO2/LZAhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022622; c=relaxed/simple;
	bh=Qszw9Hu/qCWCAjFVBv4oMcrctzYuhIwOmQ1ZAkP9AG8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Wqeho7mbWqvTwqlMqKTHciGqKFiue0zIpUbhEXwl0VO8jnzrUMJSmYbJ7qX/lpt2Y+qRfXGjdV2Vhlr4hJqv9NaU05Hx/PLiaWI5sIfrJV6JwgzhK5OlbnTD64sR5e/bwkXsRXXkd6iVEbp79cuInFF/MZYqVzLFyu2lnvade3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CmYnN1It; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVYnFX1hSwMy3uMLlcRVijL+CJFlCWK1Kv3qfz/rIlA4Tvm7aNF42zlAZ8YffcyWwxU6i2q/UB4FvVrGT1ux227pg1gLSD+IixWowZc1JYydWOFinYjvE1ENobwyjCRUf/u2s0AB3iKhE0vdGiirb+ynDHrakKxfTGvs+i04Gwn9NBkV9n3umuMs44Itx3pp6yjCQ2THCuIOpj3EIif82/VgoHWWofLozUmaV9seCRiTkGFFKIf8awLr4OC2nmb9u9AKsyM9i1mcawzpHjBkiXPNRIkONUsf9PaoNFWAXiRWQGrsKLVlWRt4P57HeEVR2yaVbffgeTmm1yhPUC/Lrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnVLym6mm9Dm7mv2Bvr6M2L6tJ2g70g71usEfO4EXNE=;
 b=Ry3cTVms8vTufjrvdLWa51lNlPiozWi8QEO99a9ksOR0yadoQHY8ptrV9Vu/66T3RdgnPhxO9TB3udff/+ZPKx5+lTA/RQUNfkmQFcRCztIv9xq0HpPy6rivdt0StjNJuGRRLQkMrpsuX/P0lXJXNGvznsNMR1IteFGZ4SlG213a7mVbf2QnDqOaWPvBIlIlX00ZFPl6SPFaerGf/WdhERHLIIMWRDDP+ty+chLiz9ml8HQXbuspDavWHYnmPgpw2l+KM/3EnRM8AXgfNHUAWJRl5s6ufTKstDOovWhTINywzfs3X2D9giOtQ9JrvUGfZaTULyD/snmKTgYuBEfqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnVLym6mm9Dm7mv2Bvr6M2L6tJ2g70g71usEfO4EXNE=;
 b=CmYnN1Itwx5wFeHuR+rE9a9mwzClvDLlQ2ocGWRNFGvLq3xB/7Efu+CvdxcNbLhg5QLJFbXLtHFH3cQ3I0R507EiEoiT6SJIAfkX2ZMv8L4ZNnorIbgUWo18a2UaRWGj9FORG6ekmIQIMoUXd34Zlj3rakBFexG0hHROo0ouglGDGVC5aLMYTekNPM3dPWCdrgWXlADBu7OngB8J6+rHFUxlfwfAY0gVOqB7imoj8yp9EeMiaKm5jlv1Xlnpc6+5bZAzP99bgm4BBp7yLYK7/zr/7opbD22xHSCrrgPU4Bxt5qZuJLsF6MJroE50H/MxReppumNIPSIlvEmONoj62A==
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 16:03:34 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::b) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 16:03:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:03:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:03:13 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:03:06 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-4-ioana.ciornei@nxp.com>
 <87ldfm91y5.fsf@nvidia.com>
 <7qkagj353ljtnn57ym24lqwma4uahu37zs435kevfqzhf4fijt@gpoc3wygxv7l>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <willemb@google.com>
Subject: Re: [PATCH net-next v3 3/9] selftests: net: extend lib.sh to parse
 drivers/net/net.config
Date: Fri, 20 Mar 2026 16:35:18 +0100
In-Reply-To: <7qkagj353ljtnn57ym24lqwma4uahu37zs435kevfqzhf4fijt@gpoc3wygxv7l>
Message-ID: <87pl4y7akr.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f3201c-bb2d-420f-a77d-08de869a3d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kf77tnyhh/sA8LzWSS5oD+bELyYKFrHuyd6RKEaChazngTFHTNjZOSA5YgaUAwSzEes8ghODhG84dqiquno6Tz/kKPKp/sjawMOgYLVsOHZ259xGK3vj9PLQeVwjSZAIC65/CTLBv78z9KVQuIP04O6WgSPgKwT2JXCA3lGqKQ7HF0RmZgeD0cDRuxtuQWlh3eK8P+bCJbNNjLj5wCbzoqy7tp7XDn0DAsDxsPnj5bVBlByQXXCobt4uEaEzc8YVZQtNpnCQxnovYslwcDJtxoBkdachNpZAupK61+KtT6MIi8b9nsG5Bjh9Zwe+lLIYDFb704l0zvsAT0wyQIyRJb+Xmzxhy/EI4Yt7qm1rGsH1aP+rK+pjvx6P3NxW/lwCWcZjNshmfQsWk/bn1nDEhP8/JFbqxVAl1mY/R8PXOXGdw8Y74Vdkcte/Bi9HlvyTvGBn1TwQCID2Fiq7LJTBlJNV7CuJrUxlrw5On47NwLvSw8wd1as7Ofskq1wgNMQZtiniCmmXuYScXOwq0e2ct+kXjMxPCZYUxJeIbafrpkxY6ytvRNjbS6T8va9nnm/hDeqJYIJacjDbXS0w0guNp0qcLg4F3fPPwmeZuA4uVXuQRgsxb9d5j8e6HzEriOLXXHqqpLDgwj2fhi2gCeJw2U78RepvY9Q7Ouox2sAkeJKNuWtn4OuTa+UYXTuHAyjz0eLEcZ+4EVF23QkewajsAUdJtxLj7NORXE+ZArpaR37TiIWr4YN9NRoIFZXLSDh1e28lwayagpc4gd/DhtdVmg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1s9UYGIy6XdkSlw7ZmTWI3BwhptI89EGEd9NnYdIlOBSlaXFsFnhwy7ppeiHAgwKNxOxjJSnVtPZGlw7d0j0P52d6fKIAkopsyY+83VWKwhbpbm+XDLqsyrgv4qc47/c9simIPOxRvTfdeUQFjBi+4OXANdICuyo/Ev7P4GkMqBFEjRjKPnEutf9wEu9vs5wE9V08W2+PeUFXWre5226DPiPvdu63kYVB3Xgf8oEXJ3UGHbXzvXy0wtWKOWMm+EVcqU6+xTQ3jllDow5wCZFr97C9DvUnw1WxZgUyZUvA+W1Ht6GaKyu2gAfs6CxLX7RWJ9js5aQCOmYgUVNXUo6bcl1Uf5PXE5cRJz5PyGqpugUDIzeJ7Ld6ZW+Nicpc4LXi21XHk08q5+MxoinjPAg4fJPUq3/hvfosi5hUqO1AOk04LfOZ5yXM8OROGgn4uKb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:03:33.8777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f3201c-bb2d-420f-a77d-08de869a3d21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269969-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nxp.com:email];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.947];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 037822DD06F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> On Fri, Mar 20, 2026 at 11:19:18AM +0100, Petr Machata wrote:
>> 
>> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
>> 
>> > Extend lib.sh so that it's able to parse driver/net/net.config and
>> > environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
>> > in drivers/net/README.rst.
>> >
>> > In order to make the transition towards running with a single local
>> > interface smoother for the bash networking driver tests, beside sourcing
>> > the net.config file also translate the new env variables into the old
>> > style based on the NETIFS array. Since the NETIFS array only holds the
>> > network interface names, also add a new array - TARGETS - which keeps
>> > track of the target on which a specific interfaces resides - local,
>> > netns or accesible through an ssh command.
>> >
>> > For example, a net.config which looks like below:
>> >
>> > 	NETIF=eth0
>> > 	LOCAL_V4=192.168.1.1
>> > 	REMOTE_V4=192.168.1.2
>> > 	REMOTE_TYPE=ssh
>> > 	REMOTE_ARGS=root@192.168.1.2
>> >
>> > will generate the NETIFS and TARGETS arrays with the following data.
>> >
>> > 	NETIFS[p1]="eth0"
>> > 	NETIFS[p2]="eth2"
>> >
>> > 	TARGETS[eth0]="local:"
>> > 	TARGETS[eth2]="ssh:root@192.168.1.2"
>> >
>> > The above will be true if on the remote target, the interface which has
>> > the 192.168.1.2 address is named eth2.
>> >
>> > Since the TARGETS array is indexed by the network interface name,
>> > document a new restriction README.rst which states that the remote
>> > interface cannot have the same name as the local one.
>> 
>> Isn't this going to be a somewhat common scenario though?
>
> It could be if you the remote target is another system just like the
> DUT. But I couldn't find an easy representation for the relationship
> between interfaces and their targets that also removes this restriction.

So after the review of I think v1, I sat down and hacked up a PoC of a
way to specify location of remote interfaces. I didn't really have time
to work it all out, it was largely an experiment, but it seemed to work
even in some unmodified tests. But I hit the same issue: for backward
compatibility the interface names themselves serve as identifiers, and
sometimes that's the only thing you have to look up the access method,
so they have to be unique. So I understand how this comes up.

I don't think it is OK to state this as a general requirement though,
because the Python tests do not have this problem. And with a proper
library support that is not purely a backward compatible tweak, used by
a green-field test, the support could work in Bash as well.

So -- maybe the documentation should just be different? That Bash tests
have this limitation, and bail out in lib.sh giving a reason that using
the same name here and there is currently not supported.

>> > Also keep the old way of populating the NETIFS variable based on the
>> > command line arguments. This will be invoked in case NETIF is not
>> > defined.
>> >
>> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>> > ---
>> > Changes in v3:
>> > - s/TARGET/CUR_TARGET
>> > - this used to be patch #2/9 in v2. Swapped the two patches so that the
>> >   run_cmd used in this patch is defined earlier, not later.
>> > Changes in v2:
>> > - patch is new
>> >
>> >  .../testing/selftests/drivers/net/README.rst  |   3 +
>> >  tools/testing/selftests/net/forwarding/lib.sh | 130 ++++++++++++++++--
>> >  2 files changed, 124 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
>> > index c94992acf10b..8d8d9d62e763 100644
>> > --- a/tools/testing/selftests/drivers/net/README.rst
>> > +++ b/tools/testing/selftests/drivers/net/README.rst
>> > @@ -26,6 +26,9 @@ The netdevice against which tests will be run must exist, be running
>> >  Refer to list of :ref:`Variables` later in this file to set up running
>> >  the tests against a real device.
>> >  
>> > +Also, make sure that if you are using a remote machine for traffic injection,
>> > +the local and remote interfaces have different names.
>> > +
>> >  Both modes required
>> >  ~~~~~~~~~~~~~~~~~~~
>> >  
>> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> > index cf40cb766c68..fb5aa56343e1 100644
>> > --- a/tools/testing/selftests/net/forwarding/lib.sh
>> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> > @@ -3,6 +3,7 @@
>> >  
>> >  ##############################################################################
>> >  # Topology description. p1 looped back to p2, p3 to p4 and so on.
>> > +#shellcheck disable=SC2034 # SC doesn't see our uses of global variables
>> >  
>> >  declare -A NETIFS=(
>> >      [p1]=veth0
>> > @@ -17,6 +18,26 @@ declare -A NETIFS=(
>> >      [p10]=veth9
>> >  )
>> >  
>> > +# Array indexed by the network interface name keeping track of the target on
>> > +# which the interface resides. Values will be strings of the following format -
>> > +# <type>:<args>.
>> > +# TARGETS[eth0]="local:" - meaning that the eth0 interface is accessible locally
>> > +# TARGETS[eth1]="netns:foo" - eth1 is in the foo netns
>> > +# TARGETS[eth2]="ssh:root@10.0.0.2" - eth2 is accessible through running the
>> > +# 'ssh root@10.0.0.2' command.
>> > +declare -A TARGETS=(
>> 
>> This is a helper array for internal use only, not a user interface. It
>> should just be declared suitably close to where it's actually
>> initialized. It doesn't even need its own initialization, there's code
>> down there to initialize it accordingly.
>
> Ok. In v3 I added the fallback to run on the local system in case either
> TARGETS is not declared or the entry is not valid so I can safely remove
> this now. Thanks!

It's fine for what it is, I just don't want it to be an API.

>> > +    [veth0]="local:"
>> > +    [veth1]="local:"
>> > +    [veth2]="local:"
>> > +    [veth3]="local:"
>> > +    [veth4]="local:"
>> > +    [veth5]="local:"
>> > +    [veth6]="local:"
>> > +    [veth7]="local:"
>> > +    [veth8]="local:"
>> > +    [veth9]="local:"
>> > +)

>> > +	if [[ (-n "${LOCAL_V4}" && -z "${REMOTE_V4}") || \
>> > +	      (-z "${LOCAL_V4}" && -n "${REMOTE_V4}") ]]; then
>> > +		missing+=("LOCAL_V4,REMOTE_V4")
>> > +	fi
>> > +
>> > +	if [[ ${#missing[@]} -gt 0 ]]; then
>> > +		echo "SKIP: Invalid environment, missing configuration: ${missing[*]}"
>> > +		echo "Please see tools/testing/selftests/drivers/net/README.rst"
>> > +		exit "$ksft_skip"
>> > +	fi
>> > +}
>> > +
>> > +get_ifname_by_ip()
>> > +{
>> > +	local ip_addr=$1; shift
>> > +
>> > +	run_cmd ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
>> > +}
>> > +
>> > +# If there is a configuration file, source it
>> > +if [[ -f $net_forwarding_dir/../../drivers/net/net.config ]]; then
>> > +	source "$net_forwarding_dir/../../drivers/net/net.config"
>> > +fi
>> 
>> This is going to impact all tests though, not just those that are meant
>> to work with this. If I have this file, it sets NETIF, and all my
>> forwarding tests (presumably) break, because NETIFS doesn't get
>> configured correctly.
>> 
>> The requirements for driver tests are different from forwarding tests.
>> In particular, interfaces do not belong to driver tests, the test can't
>> bring them up or down, reassign addresses etc., merely to use them for
>> traffic. (Which you know, I'm just stating it for context.) So I think
>> there needs to be an opt-in variable for this stuff. Like setting
>> DRIVER_TEST_CONFORMANT=yes before sourcing the library or whatever.
>
> I had this kind of approach initially but thought that it might be
> desirable to also maintain the possibility to run the driver tests as
> ./test.sh eth0 eth1 as before, so I changed it.
> I can move back to that approach.

Hmm, interesting. Maybe this could work then?

: "${DRIVER_TEST_CONFORMANT:=yes}"

Then the user can override it on the command line:

DRIVER_TEST_CONFORMANT=no ./whatever.sh swp1 swp2

