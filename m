Return-Path: <netdev+bounces-263208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GwwCyTjpmlAYgAAu9opvQ
	(envelope-from <netdev+bounces-263208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:33:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F21F0512
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 14:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1F96304D480
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F843E483;
	Tue,  3 Mar 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t+iSD1TY"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010070.outbound.protection.outlook.com [52.101.56.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21709430BBC;
	Tue,  3 Mar 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544448; cv=fail; b=XyWani4i7tV1nXROuMLDMZzgf/cEoFfQdSS/UDc2OBbGclPcD1IB5UR6QuP+Ey3xAbXqZyJV0gL+1+YVA8Zi3iqQEkDSRk3/+7xVR8zMBdjgLjfNoZrOWFyhN++BL9CWu0erSI/sU3CeZPMAAMAj/hKGo0HMRwRidUZ1lvmp+8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544448; c=relaxed/simple;
	bh=eNYNqEHNNY/l73xaWLlN0ktc+19G7fp2+vO+JkDJre0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WdeN2CsjJ+f24tWUD8QLDecX/WyOsvok4rRh2kp8ybJrFs62c08BQT1QD95NUwQBbjdFMF5Hviy90kLAIAbpC0WfOHPnyWoqE2tP24l6MoSfSiddGjREik+fqAmx1W1g395eVAikhDbLvkZBUrNWiNug/uJryZLZckFze/E/JZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t+iSD1TY; arc=fail smtp.client-ip=52.101.56.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6KERX94G1ZSeyKnJ1v7GrgXGMomy/cQXLPVM2JC2emkwZ6NHgKd9m7r6o8ZAKAuopBaXUCsqX4nI3KMT7Sk8ofAtqnTv7spWVujCe0eQwn7R1CubmKavoWSkFRjZF+ZC9uYX4CzmDQjGdnwelyzoo/o/YSFse4JJ8+KBjbyO0Fj1VYexhJ/OHECs9qEv7dahJbKTStUF4SnqBjJwF5Fe9FbX/AJsUmiB9Su49pGG1FRU5Ck0HQygn9K+IQAcENiPw7bj1Y6xJh5L84IlJo0P52aMeTKFx3/btylOFoA+hKWrS/qUfqCKvHSRPBeJnueSjxiVvV0095+8SKqxR0ToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TClZdrWaJYnrubVFBTZKGyKjpIvmo2c/gg+jvV7xzo=;
 b=pO0phaQszUaZGAlT1k48ikHBcZb2iCky7Jq3cjQAZgvwDo9NwYSYY2/yXLuIsDXbDTEYuBAkoQyJ52SIW4KBSfB0H15g/4uzfveOGLlVhmk/PSTSKWXEMVWcsFnZlAk/aTLAX35tLDzCDOJs+1KXcUvQRugitj+9TPIOLHFitTmkRz029/6yOmkYlIx598/n6I+0A66MYdUn7IEV7oLtnlXtHH1jOBj/9g+LKcuVaPYH9PBo51tDEP8dBmBeOVIFb3cM/Y2lS3Y0XO/SDm2vjnUiQgymRrNHqClIq7tbZ5/H9ucyTp4fh/IMA1Ztc9jt5RfOqucLYQxbX4BOORwryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TClZdrWaJYnrubVFBTZKGyKjpIvmo2c/gg+jvV7xzo=;
 b=t+iSD1TYI18g5tQ7l+Qt+FiMLHq7dQruePlXEs7T9nX/VHaze4Mal0SnI4BXj1a8DRx/T51FMnJJp5ubbxv/VupQ/jyf/ZTc565WSqutYV6PG+5pAGwQKP9PwxmUAhMkFD334JoXHGTRrJlohwxAh/+qiQLhQTniJY+Ngluj4S/WSc2YuFlYPd1KHFvZDADf11rlpMy1IGZjITC9DFNvdUAkqmmrQlntbyZBfmUBnHddhwrriPJs9WgsU0Z+rREFKNxy/Tao5kGBg5e7TWqLb0+PHzUaGLlT7eheP644X5NQcmBDvYpQHTBHw8C2bke7ZwYd4Z11B74geeqVDznjVQ==
Received: from SJ0PR03CA0184.namprd03.prod.outlook.com (2603:10b6:a03:2ef::9)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:27:22 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::4a) by SJ0PR03CA0184.outlook.office365.com
 (2603:10b6:a03:2ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Tue,
 3 Mar 2026 13:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 13:27:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 05:27:09 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 05:27:04 -0800
References: <20260225150648.1542206-1-ioana.ciornei@nxp.com>
 <20260225150648.1542206-5-ioana.ciornei@nxp.com>
 <87bjhaf7d6.fsf@nvidia.com>
 <ffbxeysgshogwmtraatgh6vtrwo742fpzbgaiyjnmqwxxbzzua@mhsfkhmuiu45>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: forwarding: extend
 ethtool_std_stats_get with pause statistics
Date: Tue, 3 Mar 2026 14:06:29 +0100
In-Reply-To: <ffbxeysgshogwmtraatgh6vtrwo742fpzbgaiyjnmqwxxbzzua@mhsfkhmuiu45>
Message-ID: <87342hf3h7.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3024f7b5-78bc-4833-4d0c-08de792899d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	R37+tm4zve0Xuo4lD+HPFXqs9BYFro2rxVK5dYNIMImt/33wyd6sd54Tpl5m7jqWOBmWk7X6LnJZ+GbZOjN+LXjJAI4Dg0rqByeUl0pYl0N60NOxDIl6JpCjYj1D7XZ/w//drDOfm3Hk6FH5305HR65ezCI6YVNnG6FY6i1MslPUFU9VIOMdmr+vZNCWwbbDbTG6pMWWsZ0dJtwJL3FaQzHDJzFT/bQ3domoB+E8cuRBNXMwZJwYydDV7WNIuRHjIDO1OtA1fb12rrNUeiN73Vww69l7eR91IXRQwaoV0ouydLm/rL3HNXKgNh9RfOvT9Y2bjIycRcxLvpeeIOxb3TAJoXtjM6LHAv7J6ksEn1EKTVmWcepYfu+UUFmPH4Qtt18331yC0Qa+PZAdw2Dls44sHCvhHH4bv3Bj8SpTwFcdsFd565xWEO3EvYuiw3CpmSuxKkx+mK5gMm7aai9fEKY2tWV//uuzLwcLGPFJKupsndAtqXRcIun7e04zYN5v5QYxReBYvCsogElFz70+W1mjXyrm1xtLbWrU/QYaXwicZbM2zy1Ygcq7XpKZn5ilywQ/fAg31ehTe9YsEOt8e3eUIfHZcVanXeMBRGAvUryhaGr4IMrzfxtnjja46Dnq5E1w9fQFNavyJ957s4LMCboVI86R8VG5tk9OlpUCQrTKMya4tbnPjS+4TLDaXwFecOQx+o8gidNN9O5qxUd6RL5JBBMXu3XLYLax3I493fGuUmG8JK4YNXW+n7Wx3RmyZNrQgzKvcD7RuIXsQASQjPRn/Sp4KU1NKD5AW/dEGpNs3SZZTllAOq1rtN+0R2GuVEzeOwx9g3HqtzAFQJlEYQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/szgDRV+pSh9Y7/xYuJTi1soUK8MUh14A2OfI5kU5vGpipVgwiwXU3Aj8/SZ22SRLhNO6L5fKaMsaG/uAxT47WC+oX+CVGcBq3LB41+UN9eJUxFSHlIecn6z7TlC++lQAKF0HJf1Ob0Ha5kRdInWyQCPl1nggyi1J6XIVwS5VoFl1fdTC7sz6KtBRtJCVOyIv9F9b2i/fV6V7fP1JRCzdGtBHE7ygcIwbNSUCFLlRdO9rWobajd/AWUInEBTneCMlXXWpk8X2/Lx3IqyhL1GoupaFjLz97pNm2FcGuNlwnXWzPZIGtnJnD8L6BD2V+/p1VsQYMlqpBAtQF1b7jBC2tsPr9Elh2q4ir5lFugLmSN1CPyeLRzVWdZ6IL/O/2AF6dLd4Rt3IjL6DTzniYUUZMMN+sX9xORLpmcVj6AI2J8YCCfA/o80Dg95w6YzicL1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:27:21.9510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3024f7b5-78bc-4833-4d0c-08de792899d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
X-Rspamd-Queue-Id: 267F21F0512
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263208-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nxp.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> On Fri, Feb 27, 2026 at 05:38:40PM +0100, Petr Machata wrote:
>> 
>> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
>> 
>> > Even though pause frame statistics are not exported through the same
>> > ethtool command, there is no point in adding another helper just for
>> > them. Extent the ethtool_std_stats_get() function so that we are able to
>> > interrogate using the same helper all the standard statistics.
>> >
>> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>> > ---
>> >  tools/testing/selftests/net/forwarding/lib.sh | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> > index a9034f0bb58b..efd236ae1c28 100644
>> > --- a/tools/testing/selftests/net/forwarding/lib.sh
>> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> > @@ -831,8 +831,12 @@ ethtool_std_stats_get()
>> >  	local name=$1; shift
>> >  	local src=$1; shift
>> >  
>> > -	ethtool --json -S $dev --groups $grp -- --src $src | \
>> > -		jq '.[]."'"$grp"'"."'$name'"'
>> > +	if [[ "$grp" == "pause" ]]; then
>> > +		ethtool -I --json -a $dev | jq '.[].statistics.'$name
>> 
>> I think name needs to be quoted here? In fact, unless the pause group is
>> highly unlikely to ever get a key that contains a dash,
>
> I would expect that the pause group is pretty much set and will not get
> new counters but, sure, I can add the quotes just to be on the safe
> side.

Oh, don't get me wrong, I don't believe $name will contain whitespace.
But I would expect shellcheck to complain about the missing quotes.

>> it should either
>> be quoted in the horrible way the else branch does it, or do this much
>> more readable thing instead:
>> 
>>         jq --arg name "$name" '.[].statistics[$name]'
>> 
>
> Thanks! Wasn't aware of this type of jq variable usage but indeed it
> looks better.
>
>> > +	else
>> > +		ethtool --json -S $dev --groups $grp -- --src $src | \
>> 
>> Since you are touching this line -- can you fix the missing quoting,
>> please?
>
> Sure, I will add them.
>
>> 
>> > +			jq '.[]."'"$grp"'"."'$name'"'
>
> And I think $name above needs double quoting as well.

Oh yeah. That's just going to be an absolute confusion of quotes though.
Can you convert to the --arg form as well? I think it should be:

			jq --arg grp "$grp" --arg name "$name" \
				'.[][$grp][$name]'

