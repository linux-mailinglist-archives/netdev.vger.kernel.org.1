Return-Path: <netdev+bounces-273143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EdABhhlymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:57:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8881C35AB00
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A2AD3077D30
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9273C9ED0;
	Mon, 30 Mar 2026 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iRcEsjXc"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4763C3C19;
	Mon, 30 Mar 2026 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871465; cv=fail; b=h686DA2sL+Lh27eHX7ehZuRqTspr48Y2NeatDQhVfbzRxtN4YlSRQ5+Ok96/s6XuFfc6zLlPCey0CF1keDIoxKwCyoeMEsiEs2tR1PTmBxXJM1OsctrKOC/jHENfNBfrDKYaHYm1E4OjMcfX2kaUg36cNAXp7b63XB+fix/Cnvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871465; c=relaxed/simple;
	bh=x+2grrcfEzBe6x1uziJ1++FAID39FMbvJxOEKKVcU6Y=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QFwzRAyjwh1jb0IW9XdaG2kS4QUgnNIh1zvCTI4nZ0nT4TFbZZ4BD35v2INGiIdh3eHT2Z2yNPD6E5gpcYDhjlMLlFJexxlkCzkIKLwabwn91tRvnU8ldx/9rEbneX4LaAp7XMqRPpHr6GAK3TGnA900eA4K0U0pRrR/g4qB9kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iRcEsjXc; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMgeJYB1qFVpmaDKvbxfOhHFi/lPTlplDqBfiPvzB0BrjoCgZ3LbLVbJDZG25LyQTzIxBLHNG8cphNB25JKtu5SoOBICADQXOq8epjecvRZ1eZX3u4hrk62JXgafU1ZwzN1JucBRgT8S8dCoJZtTqMVvqCJJsq+dlMkO27L5W94QPBs6wmUvqf+Fkz7FFJKZ/JpsluhX1jH+LRjOdIT9zc2mhMUlMrmw9f6UGjz5E9qzlbm/NYHAm0dZ7WofttiOOqn6huJUh4ng+R+nffGorjV+xNKfTftFV7d5GaimrLiHBFUPZU/Eh1eutC2nP0i/VqjYdTGr2zY7X83qV0jsnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8owV15ME7ehGgqND5XAZ+0OL8/8nHFK2UEbyZgOtgjY=;
 b=HVCNs0vniuyGSab88clqgr2qNbHirPvLx6ZW55QDMZ+LAZkio/gNZbBHhYeP+ThumoUFXw//hoJCJbxHM05N2eB7A8kdZhmHdCj6M1s/PrSVAoYIKIraHC2AlKprdFXIpVjIcJN3ID4gMPnPsddUD6LIE0YccofC7EzFnXHRvWDwVbK4pSJLzT7I0qY9e55xAI+ucDfMsTFMGsaSAYFSJcBoglt4/4YkRFPwX0XWritFq2OAC5PKeqv7QGVRV3wnxX4EaX+ZoPLIBt++RVRF8R16wL0mvh6RG5Sr9gc0YS3k5RqsV0/ZzDxpzBCGLGXoxnVtkRGGjaRmE7V3vYRq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8owV15ME7ehGgqND5XAZ+0OL8/8nHFK2UEbyZgOtgjY=;
 b=iRcEsjXcESGjjUSJ6zDfAvOFEQT99NpWxSUu/t3zfBH9OiX7QM52va45u30zdgOY3+DVfcIoi1ZBiGzhUOvRy1OffJZhB3V9BhZWXzR2fjmjJgtEL2edWfee2NZm44BvhUNOZrNj0DUx9d7PwJHjeUgpe61X4ZBioQp6rYO08H8ZdqMb/p7Q8Y4ybEA3s334sn5TR03REWbRAEke1jlepZkizPKOVQ3uthI1jy1YVWoxEsPqydZGOlXDWcrU5Qy68nIyH1kQsk8i0j2Ok0rTREwFWfxT6J6vp73ahmTN6xmOw3A7XS/7ojeAiX2fwVbKmMpm9s7loIwbFAqDq+K4Zg==
Received: from CY5P221CA0069.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::32) by
 LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:51:00 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:4:cafe::99) by CY5P221CA0069.outlook.office365.com
 (2603:10b6:930:4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 11:51:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:50:42 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:50:36 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-3-ioana.ciornei@nxp.com>
 <871ph15zip.fsf@nvidia.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Ioana Ciornei <ioana.ciornei@nxp.com>, <netdev@vger.kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S.  Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <willemb@google.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 02/10] selftests: net: add helpers for
 running a command on other targets
Date: Mon, 30 Mar 2026 13:32:41 +0200
In-Reply-To: <871ph15zip.fsf@nvidia.com>
Message-ID: <87se9h4juh.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: a8559dcc-13e9-4df3-362a-08de8e529ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1RoNM7XJQVB81dyxWsRwi+3O7VJb/HGqlmg//JrE4wjPqaJpW/MQCTnYinq1+xjJMbM3JHm/WAXZxqPQvDkFmmjkLsaOL9kVHhIVP9ROO9ROwejdIMmv/rbb6HnGYduKbbfJ8aw72DvEXtawy6lT9zeLfjrHzHq46rkdmRK7P+ts6kRXhTaHIXsYg+FqE1DCJMqVNf6+gBwxT3b2Mhmy2wDwNXRVJS4/nIakLddmcSpCcsbsBfcrP89TzYmLjn48ElhUfOB8464h2uv86Xmqihw3mCo9kwcBW23l2pWLYCnAVFjS4sI2JcvaWmwkbtri9Vh/XwHm8x944iEtGz7eb4xJf6RN/WdZCLS5wC39fw8zjv6zP39imgCzDw7PyQqdta/q2SsEqOK8Z3XmR5VzQ1v0esPYLLxAeQ7mT5J57G51zVx5zo/cehIFAlWwZQgVNtsDMfKNtKzvALa/E6VmZyfY79RxTi+EVuQJcisYqwQGK+d1w1gSxeeZZpKagy01CJrtqC2xurhNUzsjaQaur3zwe6TSDk8J6ZTLzhinvxVgA6pGdePA3TWB0mG0IsVwlNzQk9jxRW29Zbn2YDdcAb/6HVAlG7Jw+WcLk4DJ5B/49lNyFcjnsnL1zg4WsnI7SVywf1fAQCLkCxn28Ev2Tl5ECP3zk2V5IIJ+X2+ksA05rrn+n18oUozPubIxlvGGJvZhdU/st7HHYbbI+VDTh3wv69ugDKNX1GZ3Urf/sw/fQ1Gwa2Mkc4CK1aZKHWVtcEyFdRnpKkgY2sHQxc+q8g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IfzAPPM3CfhF0I1X5lCQp8b0Fk3H+0aJCsYXe6/BEplKRob8qLNaSa+ZP/nDAs41d6YMsIciCQnCYpgkl8e9M8tOfAMl8Ur/3fRqRRA6RFM6YeHcG7oJHUKT1Bw+HzN6BkyxYrZjuYk2mDOpJ5iaQ3CsoW0yAFbMDPDND5lkHJNFcDKCoieMOvpju8Tdp2Ec6YbdNzlLuRTBgKTZPut1HTuldd55TGZ+V6E/lQlRLBO/QrAlEin8x+VtrboS7CIWwhFQh0AQiID1F/pLkA3uVnbw+DeAZwdIF84sw0L2+eDzYe7A4+SKa1IZj/rGooAWxIWNoJ9SGG78xryYwGq5f3mvG/lMUAs5cLyk2GyMqCIaQ4X6i1Z+qGKDrpy6isIH03qZCdeQkw63I5pk7UKSkS3j4sHJDkojhUNgpKyL5L+TWj5m6AQ4n52JWuh0Ngbt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:51:00.1164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8559dcc-13e9-4df3-362a-08de8e529ccb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273143-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,host:email,nxp.com:email,lib.sh:url,nvidia.com:email,nvidia.com:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8881C35AB00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Petr Machata <petrm@nvidia.com> writes:

> Ioana Ciornei <ioana.ciornei@nxp.com> writes:
>
>> Add a couple of helpers which can be used by tests which need to run a
>> specific bash command on a different target than the local system, be it
>> either another netns or a remote system accessible through ssh.
>>
>> The __run_on() function is passed through $1 the target on which the
>> command should be executed while run_on() is passed the name of the
>> interface that is then used to retrieve the target from the TARGETS
>> array.
>>
>> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
>> ---
>> Changes in v4:
>> - reworked the helpers so that no global variable is used and
>>   information is passed only through parameters
>> Changes in v3:
>> - s/TARGET/CUR_TARGET
>> - always fallback on running a command locally when either TARGETS is
>>   not declared or there is no entry for a specific interface
>> Changes in v2:
>> - patch is new
>>
>>  tools/testing/selftests/net/lib.sh | 38 ++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
>> index b40694573f4c..6c0d613a4de5 100644
>> --- a/tools/testing/selftests/net/lib.sh
>> +++ b/tools/testing/selftests/net/lib.sh
>> @@ -670,3 +670,41 @@ cmd_jq()
>>  	# return success only in case of non-empty output
>>  	[ ! -z "$output" ]
>>  }
>> +
>> +__run_on()
>> +{
>> +	local target=$1; shift
>> +	local type args
>> +
>> +	IFS=':' read -r type args <<< "$target"
>> +
>> +	case "$type" in
>> +	netns)
>> +		# Execute command in network namespace
>> +		# args contains the namespace name
>> +		ip netns exec "$args" "$@"
>> +		;;
>> +	ssh)
>> +		# Execute command via SSH args contains user@host
>> +		ssh -n "$args" "$@"
>> +		;;
>> +	local|*)
>> +		# Execute command locally. This is also the fallback
>> +		# case for when the interface's target is not found in
>> +		# the TARGETS array.
>> +		"$@"
>> +		;;
>> +	esac
>> +}
>> +
>> +run_on()
>> +{
>> +	local iface=$1; shift
>> +	local target="local:"
>> +
>> +	if declare -p TARGETS &>/dev/null; then
>> +		target="${TARGETS[$iface]}"
>
> So I think Jakub's runs fail because there's a shell export somewhere
> that gets inherited through make to the launched test. I guess it would
> be enough for the test to validate that TARGETS is an array, because
> those don't get inherited.
>
> Is there a reason not to reuse DRIVER_TEST_CONFORMANT as a tell though?
>
>> +	fi
>> +
>> +	__run_on "$target" "$@"
>> +}
>
> Does the latter helper need to be in net/lib.sh? Since it uses TARGETS,
> which are a forwarding/lib.sh concept, it seems misplaced there.

Oh, I see, there's an invocation from mac_get() in net/lib.sh itself.
Hummm. Not sure how to tackle this.

I think lib.sh might unset TARGETS explicitly? Or declare -A, but leave
empty? Since it's now an API, net/lib.sh needs to set it to a reasonable
value (or erase). Then forwarding/lib.sh might in theory rely on
existence of that variable and not have to declare it at all.

Or, maybe have a stub run_on() like this to satisfy the run_on() API:

run_on()
{
	"$@"
}

And have the full-blown thing in forward/lib.sh. All the magic with
TARGETS really belongs to forwarding/lib.sh. Bash allows function
redefinition just fine, so a user importing just net/lib.sh would get
the stub, and forwarding/lib.sh users would get the full thing.

