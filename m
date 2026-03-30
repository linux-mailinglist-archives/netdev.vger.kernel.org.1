Return-Path: <netdev+bounces-273274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJApKt2qymkx/AUAu9opvQ
	(envelope-from <netdev+bounces-273274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A3635F1A9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE23C30151E6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B62D387591;
	Mon, 30 Mar 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k2YIb5Wk"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011F3264FF;
	Mon, 30 Mar 2026 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889678; cv=fail; b=AzKG4CoPHVrliSFVBIm/4MAYRudWiTA79dyaarovKRMQeJSWDv2RFXBmAKWJMmVexI0cq5aY3mYFagioZMY0dCmM200vPWfFhnYXVqmJHQs83v48d3pKtBZqvCZJtIUPoerJl0NBkQQWz+XVsjsWXDksb959V4locKrvjoLTdBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889678; c=relaxed/simple;
	bh=MfhUiSmcSW9HeRvhelqhxD17GhN3EmB5ywCzeg9EBy4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NdbwpZDJUt5AVHpSedi4kYA514vp7abA4LWKb8iLj98comxRbyxabzx4+zzZDYMSkzzEddGHWLUd9eCqxzMBNmClEh1zoaODn2Ev8MTKH4a7PCUi3PuKCocwKy/sQNRXytdlBLjsBNNRuI21Fk02nQAaxvMS2Vj0sItM36/07HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k2YIb5Wk; arc=fail smtp.client-ip=52.101.56.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxJpk66vJLgYtdGb1jsa3q9/jLkiLzY01RyPDDNv8VsEIFkEJrq68fq+2tH2ym8RZ3FIfPO0mpWMAv08Jc2kE8T26PAVXa+tn8gmbRG/Fd+W268/XAq0/5cnPC3ndqgdLsUylRRqJkmaIVsCB8Nt63TX+8EBK66+MqbT0HTA5uAp+yP+SlJ+Fk7j4DAoIcAfXDgzNhfEkPb42ARpdD567xQZySxlNw03G6QqaKY45NOrsldQRQufs0nZKlAUGPx2I7DpZi3cIlnUAVHK8JadtCtw7OJWfUS+TVleYmN8q8O1cASCXTwCLzPVOi4yhi9mZ19DQU+VAWYV5rPuj0o06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0k+MFX43JV53HHVMovcw0N1viX5QHSy2Z+QjTVfzBg=;
 b=tle3KcaszNaGGt+U9/WllbWBgVSx6YdA2v/kFsYwlep/k12M2HH1jlfPhZp4yIo6zfo/bmw14nNG++ySqID9j6rvFBA8H5h+MlsPutHJcK4e/1iFv0u2Xy/gp0ZQVkac4Tg/XA7qJ7/6razN9NeTXpcJ0uw2M4hqdpLtEVmKTZWjmftjRK9Pk4WGTHmsfEULScFq9pHIa2BomUAjezBZ1/vuYe++a75SEIx17q0zVEc1zXG22JNNXfMX0E+yd+JbIs35bh8IrEQkAcYHD2N6RkseO66o2Utnlw1cviAQlGdwGBmZM8A6SrJOBkmEmlic7sVjX3C79IqdHvP8J+Bd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0k+MFX43JV53HHVMovcw0N1viX5QHSy2Z+QjTVfzBg=;
 b=k2YIb5WklZ4v9stvQXrwQ3ALtNl2pKad9obxIR4N7Tf9rC5tGCxS1Vt14o8lPaXNSdDk6RUxJcecmDX9IMqPe6FEHs08RnnCkCLN5dYOFz//zDCMzt4IVpsROSzDb3yl0iolPqtJomDmLnGP9zbqdWIntx6A72Z5UVJCtW//Lf7urVsbViutzAnNNQGraGsdXcU7y3CvtZztovSdm6KqHosAUaE+noydKK2kVEn/1s/+4uvdEGvpluLGcy4dZuE+KahcRSdRwsI1QZBDCiX0F0nO+e3uOUHyO6GeO/R3+Ij0aYxJE0NcNLHvhh2NoJJvxinrbNslAngkvE2DodLhNA==
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 30 Mar
 2026 16:54:32 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::93) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 16:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 16:54:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 09:54:17 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 09:54:11 -0700
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
 <20260330152933.2195885-3-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/9] selftests: net: extend lib.sh to parse
 drivers/net/net.config
Date: Mon, 30 Mar 2026 18:42:23 +0200
In-Reply-To: <20260330152933.2195885-3-ioana.ciornei@nxp.com>
Message-ID: <87zf3p2r81.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3d2031-a258-411a-9064-08de8e7d039f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2f40rNonHlE1qtd+4GuUJ00/bkO2IseK2Ups1/je59qa0sKQPqWZstXdqDAG/MNp2db2wHw247Qj1+JhzJg2CWW37h+tzf4V4Rwpdhbtf5E5xVy2MGdT7WJqayNdQhZzo7WsubuslXNtb4Bw72t7QiQEQurTsMnefGJcGUaUqgnNfuzzBdr/S9hWHr1aqKYZ2j+9xeACoGWZR4FRCyZu+2rTMKmbAvpeSsl6v5G0yj2Ud3+jkRdTeZgpu1LcQucIAjhL92D/aHfuJ+Gqn0K5hEl0AtvAzVB85yMN332vj/qWMokyNJgsq/suHQ0oOMAbeN6tJaFQAj40Nkn6jMslLEf++F9g3CfuQP7rR7p2Bitu0jzMrYh9jdAA8pzMeqYNFv9b5eM2JciXEOtzyvXOLAuKciHCzFRfMIw7vUxi5tGKhP2YpJkDHe5GpjS+9NjvkTatlA1xvzqAzWdkEVGGQ/P5J44bcJ9xnFpqpLkF+jMFW4iWHclaV+W2hhqF8+GtEsTY1sp+piDGgItTIgCQC2dmN8kkH6i9qVBCnD44z8Daqn/+q7vcQfUrSXGkaShCADNvnhMoPRUv3cyzEUrSn/8dTMyFsKiVIEbsTGYMoVSLxBrLhwBqt6KLylxufy/+KACFcHtAx9hZvopmz2vPoGuunQW/fCGNhwZqlFPxyWFijAXkXwTTKEp4vEhZ3D04Mh9DjJ/QFVuxnS0Yp3xZH/SYFhPEUatE2cbsFGbfQcyXFaxwqVL0f4t4NF7BGqxSlFN9bSA0yrsnvI1JRWFhTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GiFkHi3LT3AUODoI0+Ir52sUwQOIHJRWiy0XeogIZMV4uDUyQeEHap945bBaPLyiCPmNtKSGpYn3KHxS50cqIuKwpTMnXrtemNTN6AjJmVww9Hx/LIBjiV1FLNvCUsiHBRYE/4RrpH0HskZoK/Cs3IGo/zyUGeg8FZglmZ7B+juBVfItHn7VeczBs3T6jmBk+HCDcqGJAj0IuR9EYIZOT/0hTQGASqe4w0vMYvvhdc/5pNjCnWYsKc9XdyI+27nkT7Up7yuLDx59gcWjQT7U3gIXCMHs4uOXNhWAcbBJx2Fl+a4S53iN+PIdFRYBOSzdTurtTFSTsxFvZfjhcago3y13OhcxyTzK+9NAd6MLBx/pfAWg/JhELaltwiprJNNsRGdMSfnZGt/OzKy3Vytyda0BK8nmvtjp2oTbOQhPq6jbWcjOh4oxthdI5vepy6Hb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:54:31.4670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3d2031-a258-411a-9064-08de8e7d039f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273274-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 47A3635F1A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Extend lib.sh so that it's able to parse driver/net/net.config and
> environment variables such as NETIF, REMOTE_TYPE, LOCAL_V4 etc described
> in drivers/net/README.rst.
>
> In order to make the transition towards running with a single local
> interface smoother for the bash networking driver tests, beside sourcing
> the net.config file also translate the new env variables into the old
> style based on the NETIFS array. Since the NETIFS array only holds the
> network interface names, also add a new array - TARGETS - which keeps
> track of the target on which a specific interfaces resides - local,
> netns or accesible through an ssh command.
>
> For example, a net.config which looks like below:
>
> 	NETIF=eth0
> 	LOCAL_V4=192.168.1.1
> 	REMOTE_V4=192.168.1.2
> 	REMOTE_TYPE=ssh
> 	REMOTE_ARGS=root@192.168.1.2
>
> will generate the NETIFS and TARGETS arrays with the following data.
>
> 	NETIFS[p1]="eth0"
> 	NETIFS[p2]="eth2"
>
> 	TARGETS[eth0]="local:"
> 	TARGETS[eth2]="ssh:root@192.168.1.2"
>
> The above will be true if on the remote target, the interface which has
> the 192.168.1.2 address is named eth2.
>
> Since the TARGETS array is indexed by the network interface name,
> document a new restriction README.rst which states that the remote
> interface cannot have the same name as the local one. Keep the old way
> of populating the NETIFS variable based on the command line arguments.
> This will be invoked in case DRIVER_TEST_CONFORMANT = "no".
>
> Also add a couple of helpers which can be used by tests which need to
> run a specific bash command on a different target than the local system,
> be it either another netns or a remote system accessible through ssh.
> The __run_on() function is passed through $1 the target on which the
> command should be executed while run_on() is passed the name of the
> interface that is then used to retrieve the target from the TARGETS
> array.
>
> Also add a stub run_on() function in net/lib.sh so that users of the
> net/lib.sh are going through the stub only since neither NETIFS nor
> TARGETS are valid in that circumstance.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> +else
> +	count=0
> +
> +	while [[ $# -gt 0 ]]; do
> +		if [[ "$count" -eq "0" ]]; then
> +			unset NETIFS
> +			declare -A NETIFS
> +		fi
> +		count=$((count + 1))

This is coming from the original as well, but I find the piece of code
really unobvious. I'm not going to block the patchset over this, but
this would IMHO be a better way to express the intent:

	# Prime NETIFS from the command line, but retain if none given.
	if [[ $# -gt 0 ]]; then
		unset NETIFS
		declare -A NETIFS

		while [[ $# -gt 0 ]]; do
			((count++))
			etc
		done
	fi

If there is a v6, please roll it in.

> +		NETIFS[p$count]="$1"
> +		TARGETS[$1]="local:"
> +		shift
> +	done
> +fi

