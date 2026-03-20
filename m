Return-Path: <netdev+bounces-269972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PjqN1J2vWmt9wIAu9opvQ
	(envelope-from <netdev+bounces-269972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:31:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD6F2DD680
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF0E030A0363
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904939F16D;
	Fri, 20 Mar 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kz+w8Yla"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449602D3739;
	Fri, 20 Mar 2026 16:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024031; cv=fail; b=k5rNWgHNTonxyhcJCfjsWQM9MFyQRMkRxiqMGwmltwTYtFzViImJD/i/IBqxNwfT8z9oTj23w3fkdoHVMuuttPd2sA6HjDb7L5EymCtrU/gYSKLfC4jEZivbbY7w3FU0/q0nWUXJR38tGIL1Zh6hK39Tn4XJUQSXipHn/NU9thY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024031; c=relaxed/simple;
	bh=0CZMUri9wlI5b/2NFh/iQiFJt0CIs8THHAPzZkpFk08=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PmsjDvESJojXx1HpmyW71k6A3gzOP8ijjqVhYZ89eUWXEgPy0yUOFmHVIwvMS32Ogcby56x/HMBsxvAHFhOhJPfOUkVzchyXaubPjZR1xISwFjOe0KmeLmos0F1vwiFuU1zHqo0B52D4pHFRq4/NG13Dr3O9xgHXRdxhDpXAya4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kz+w8Yla; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNZ0+1lUyo/Ct+X0kNcJmaYgsCLMwqqhQRQA3WQUJemiYmFqM4E1lFhJjYcw6QktBQHuRxTHunHIrBCbCc+BjJt00gjrJPvsAENpUrlQeWNqMOFHG2rple7iujbXVbR5HGW2iyqlplAhmHxYSLapEreool12DaShle0MdUtYtfC1iRnI7d8swHf4daqnZBitn++D5ndK+oUjBLeHW/dDXCtQbJO36gJd/bCmKTIeRnO6gSHlr49PsdA2U7Nj/uWMEvRuCOdg6Oevk2FQCcstBZcD7xpNzGi7WQYhN7EvKZDvuDYgsRmso4qyVFk5wl9k/tqLPYGOueWp+hLGlZlafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV9OrShD9697AgSSAtoQdLUIvcVLDAumbicdHe+n9EM=;
 b=J/EBNuGM+NbhEqta3g7NisCgDSqebkSx/DJN1pYgUGa5N6RXs31pktcbUJ8i0QSPkIvj/s7f7AAdcrSC4+SchlXZiujsvmN6NHkE+KIuIS7W0yPfrFHuVGqyRFzj++XtcLUDhGyC6kgUG34NLa5CR6hadrXlLAGciWqUDd64TxNkYuDM+EvG0Rr6b52eis9yYRIAiVCJ7TIGOLauiv0yPhnWbUTiAI1b+doOmdz5MXlAMdBpDSmWlSxzn2akjnvnRaU0LwKIZ5QwjZEkg0hWcQH1XHVVGhyKcdt7IMBGQ5zpt6Bl7CzpIz3SKQAQYRz9m9HaGasUDyDDBuu1B5mVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV9OrShD9697AgSSAtoQdLUIvcVLDAumbicdHe+n9EM=;
 b=Kz+w8YlaSZipoITOuQeDJxEzIzO1I+oaJiLaIB/Y6U4FTZCud03V9gQbwc05olOAGiMi5bPG4BbZneH7Xy6R6Cb4Lgu7HXwu/2vgZ8InNKj550tx0pwn0cgDxa6TmC20hUtmf9tmbXD4nIteH5dc/LUEdbM83mhP6ZVjhCP1Hf9HSQ+HPz4kwAC2tgn41gADq21yFwXVwqLxKAGJ37ajPAGUVPzdZjiUPFbgyFtzh0uEsfMVXtZTPEn5/5XU7i9TD6hk6LS0Xo5e82ygr7O3r0xe5maQ7ClrKnk5ZTl8TXQ0x+P4ptLedFz6334j/gAd6K/0pVP7na16Z/hps0MfBg==
Received: from BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::8)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 16:27:04 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::2) by BY1P220CA0018.outlook.office365.com
 (2603:10b6:a03:5c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 16:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:27:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:26:45 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:26:40 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-3-ioana.ciornei@nxp.com>
 <87y0jm92fz.fsf@nvidia.com>
 <tpycmjloogv5uisvy54nl5k5v222jq272lp4sbsbiq444yrc6x@yf43qc74lag3>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: Petr Machata <petrm@nvidia.com>, <netdev@vger.kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <willemb@google.com>
Subject: Re: [PATCH net-next v3 2/9] selftests: net: add helpers for running
 a command on other targets
Date: Fri, 20 Mar 2026 17:05:58 +0100
In-Reply-To: <tpycmjloogv5uisvy54nl5k5v222jq272lp4sbsbiq444yrc6x@yf43qc74lag3>
Message-ID: <87ldfm79hf.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: f3035820-e0cd-4e87-5205-08de869d8570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fPevV1b6bocZY/nDWq/5zhNzGsbmv8VPKBisXBfslMxkZiYX7uU3DwXYdpuDbOjlkGS+O7vDtd3Xmo1vBlIe2ubBvtI4X0v23WaVs6Xk/z1IczC6HIa5Xs1SfmrFW/b9T+94yl24nQpzUGeW8lNieJbm7PUgO1/GiZnxWwePXPVdwWLcxI74pwapuRfzVB6glifTVMWotOwqTsq03eXWyTd08D50aXiIljWpFs3WwhWz0G+92fueLlQdyRyaikDKYI5/i18ByxXS3BI9/VZLGQfA9PcrjPojzjhKy64FDOw2zq5unFba/Yy9So7CO2KBPl3TbXumfB7BQoo4a0F8iobEObUWhr79gsB7+TMvO4Zg/SpaCKOuHESurJZ/rkCaBORZM5QdvUHFoNHKMHaD8i1FBU7/SyuqjM8xUgH/sfhFtB4hnkzls7mIhxI3xc9WjCRDzm3Ul8LNtkt2DqTjmDHT0MeYfibopVyrGX45d0lM/lytN9W98Ubbrm8YCyhf+A6np6RDmo345MWEzNQVO00B9pcYMQzUtZl8qn6NTdtkdLy5SYMmaBa8KipUH25hjZ2vA0Xg9Tg50w4pBtSY4uoZ6Za7oUWjdBnwygsf8VbsTIDA/cVwRvs9ekDEO7nN7Ff4G7tr2pjo2DD9sWP5l0dmu7mZvtRz0nBUhnRu/HUyp+UzuErMEyQ7uUMHvjSzAC7gAsSERrS213Vsnu4s5O/v7KAklsiX0KkpdRMi6qyxQE+tnYQZwfQuK8//jeaDP0Jsx9fCumEHOli3G/pZ0A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L4GBi+jNkFp3Dh3Vy79z+evTA0HsbJs4hJ9og9Md9Ucx1CqVjA2KqX0sdfxBLNlmJ443BCMeRI0czdAHOA/em2WzJQRveGu+6Rr3vKywAGatryuYnOKr32COExOsAXeP0wZbqEpoG7AgRR7BxJfJfnv4jZoTU0n1HMFkjqKcXZP0oXzJRHpUfWG8y8YZm/43+YPlprijVI++8u1TrYtPDKwVRtL7rgMmSOuuBMWsOQyqk1SK6SXtbfzSza6TlAjq69RzKzlFMzv650p697AH3RiyuyZHbP3YEPdcDC9HoBtDrfnt/Z06R4VEFPxpg56KF3rb5Sc6+b9q1A3ZodzqUXWtUBPYugQ4un1OoIorFdu5Q1pJ+8shtqNAQwDfqxXHKQo+E6kgHtXnlb1VoEqcz2+123q4mDAiK43wTA0F1fnQKjpCPzKdq3yzkHYGTDm7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:27:03.8510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3035820-e0cd-4e87-5205-08de869d8570
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269972-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim,nxp.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.970];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5DD6F2DD680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> On Fri, Mar 20, 2026 at 11:58:42AM +0100, Petr Machata wrote:
>> 
>> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
>> 
>> > Add a couple of helpers which can be used by tests which need to run a
>> > specific bash command on a different target than the local system, be it
>> > either another netns or a remote system accessible through ssh.
>> >
>> > The run_cmd() function decides where to execute the command passed
>> > through $@ based on the env variable TARGET value while run_on() will
>> > receive the target through its first argument.
>> >
>> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>> > ---
>> > Changes in v3:
>> > - s/TARGET/CUR_TARGET
>> > - always fallback on running a command locally when either TARGETS is
>> >   not declared or there is no entry for a specific interface
>> > Changes in v2:
>> > - patch is new
>> >
>> >  tools/testing/selftests/net/lib.sh | 39 ++++++++++++++++++++++++++++++
>> >  1 file changed, 39 insertions(+)
>> >
>> > diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
>> > index b40694573f4c..f7c54d05758e 100644
>> > --- a/tools/testing/selftests/net/lib.sh
>> > +++ b/tools/testing/selftests/net/lib.sh
>> > @@ -28,6 +28,10 @@ EXIT_STATUS=0
>> >  # Per-test return value. Clear at the beginning of each test.
>> >  RET=0
>> >  
>> > +# If a specific command needs to be executed on another target than local, set
>> > +# this appropriately before calling run_cmd
>> > +CUR_TARGET="local:"
>> > +
>> 
>> These are new functions, they should just expose these parameters as
>> actual function parameters, not as hidden environment. If it is
>> desirable that run_cmd() can run local commands, maybe it makes sense to
>> make the current run_cmd() a helper like __run_cmd(), which takes the
>> remote-config parameter, and have run_cmd() be a wrapper:
>> 
>> run_cmd()
>> {
>> 	__run_cmd local: "$@"
>> }
>
> Why I chose to also add a function like run_cmd that makes use of an
> environment variable is to support cases such as the following.
>
> get_ifname_by_ip()
> {
> 	local ip_addr=$1; shift
>
> 	run_cmd ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
> }

Oh, I see, this didn't even occur to me. run_cmd() remembering the last
used target like this is... unobvious. I can't promise you it would bite
us in the ass in the future, but stuff like this tends to bite one in
their ass. If get_ifname_by_ip() needs to know where it should run, well
then that's just the way it is.

> Helpers such as get_ifname_by_ip() (added in patch #3) that don't have
> access to an interface name so that they can directly call run_on.
>
> Do you mean that for any helpers such as the one above that need to be
> run both on the local system and the remote it's better just to add a
> new parameter to it that it's indeed the target on which it should be
> run and get rid of the run_cmd all together?

run_cmd() is fine I think. It just needs to be honest about its
requirements.

> get_ifname_by_ip()
> {
> 	local target=$1; shift
> 	local ip_addr=$1; shift
>
> 	run_on "$target" ip -j addr show to "$ip_addr" | jq -r '.[].ifname'
> }

Yep.

