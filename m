Return-Path: <netdev+bounces-106891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F4E917F5E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306EA1F24B31
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F317DE1E;
	Wed, 26 Jun 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZwCi683o"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08E16078B
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400541; cv=fail; b=Ly6vWAE3Zy41YRTwOQgW4tykacgs6zmSNTbHxNdLcYtT6DU7KfTENQsgrnaOs6hGDmvApQ3ohAG8rK64V78bFCHSMY2PlRp12Cwx5no4wQK0+G8ZNFJ667J0gWlLdOUEC7G92/LkxGBHN1iqWde/21WiIeBzlYoWHNIhiqQU2g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400541; c=relaxed/simple;
	bh=b0nK7p5dkOqMKlpdGLzE/xbCkedhrgaHdYucFRq65yA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=t0lkfTqc/bWbi+w9v6KlXaFhfMSMptw85AtQ7kR7U9p7MFdi1ry8KcvWekSvCe2drJBqWy+C+vAuyMz12Acgd3uvJhtZp6HeSG8UNquX9RJFboTJ0Hl3CeoZAPV/AMIn38fpPWPsl3Pqr9uaoG3s574eWrjFG+cIiOFcKfrSymA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZwCi683o; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxmynO/DNgUJAzTbwES7HW/N/wmlSt/ncm+ou1sYR8UR/TxWOS0NW6/adeN5+MIvpFu4adJitfGuwJFbr3DNhTv1PeSqvtv2ZF/wyjP6l7BPtMTtKPYBf3dUW1dryr5j8lDCJIwSmYF4xWmb1Sm8fFgedz42VbhpzU1P7NvI77E0a7UfFXmctkQIJt4qLPNhA7KT0Z3Fj7SEYpACstdWcrv6+I/Up/Xz3u26c/HJ75obKO3oCqu7fx3MD6YQ7Xt9TJAztrvxCeJnKfbXZSKG4KOk9Q9/gA0bGnzE6kEsu92ejEeJlwh1haESSnyxTRazldsoV+4Rt18VPUTSl7NZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvdBNaFD+xmJGD8pyS084BB+0IWiJO4NTh7diZZXLUk=;
 b=gg/iQ+IVDvj5LMuWmGFXSZs9sRce/VTTsVuVKExZY4+mYBH57HvcUpAQkeCUNV6StO9cNALwxrEuB5rKfAufFYESGpATGvgO7rQRUFoBgS0wtOGk+unhP2kgZXYUIEfcy1sNWXxJFQ0a9CMAya3I9FtQj0UvopJ02bBc1VTLWEt0SMXLUHR1mR3B6TmNvqm1cX2ZZT3LdIw/VAC3CoaBxG5ZlVPuOLGsZ0DHUbYeqmfqgQ03trPgLBwd9Hmx7RFkCH5mGgd1O2TuYxonT+TW38zhOiTHA02IwEJ1SeyooFfeE+GnwD63aRoApY0veyi7AV5q1eNbAWUXtixEebDfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvdBNaFD+xmJGD8pyS084BB+0IWiJO4NTh7diZZXLUk=;
 b=ZwCi683oW1HviLeIJWcjNGT1x/Oz5X4q42C7/uZStJAJs9j65p4yF/XOoOPG7KoRP4r7D7Vh9OOHm5aW9ovuMO6PYzCKZkUoDzHMuQ+HW2HpdNwhIjri6XWj0xe9+PbhdIFSft3UhfpbA+18fTbJJ1R6nL+6FdGA61ZMzrk5pBWKWbpdtcZ3y/CngzL5JM1Dm/C70kBUCUG2QDNqQz4G3OUcNWW/h+dfG/ttRhS/7d2S5UaLE3l6OSnNY2Fkw8a3lj3UZZ3bEFOvLQKEQobs6fLY0F6OULa+ieLDkVZXejoilldK9B0ywwTvyx9vEBIaFj++pSYQbDeUYk+SEWLJ6g==
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Wed, 26 Jun
 2024 11:15:35 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::83) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 11:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 11:15:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 04:15:16 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 04:15:11 -0700
References: <20240626013611.2330979-1-kuba@kernel.org>
 <20240626013611.2330979-2-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<przemyslaw.kitszel@intel.com>, <leitao@debian.org>, <petrm@nvidia.com>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Date: Wed, 26 Jun 2024 12:18:58 +0200
In-Reply-To: <20240626013611.2330979-2-kuba@kernel.org>
Message-ID: <878qys9cqt.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: f19abfdb-1fc8-448a-45d6-08dc95d14d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIetViwJrZn7PtDQdPOCHEdZ+37aeY4hrkydL2kj1iZxgLFP8l3H2X0AhDqD?=
 =?us-ascii?Q?1Rw/yEZiR3sue/yKunwPzfnwXfQcoTNiLCWnobsJanyqgDR3lL6gouBCYgZt?=
 =?us-ascii?Q?QhW0IXyq857eBQdGyA9XZVagmiZbU+xQnVOUEJ6I980UKQTOwxZjUJOEIYml?=
 =?us-ascii?Q?5zaSJDsS/HSh0MB9P9Xl7CyWsz5q/9iNeEk+abGsQE+1+MmJSL2WqjzVQGHY?=
 =?us-ascii?Q?Ph7FhVQ/dgLLj/TwJ1iXGxgyH+6QrfUg5DabjDvL6cPIDx+4XBiGK5UxCMnL?=
 =?us-ascii?Q?z057kfrUXu8G0rDKKYSOMGFPo5sWyG1veqv/NSKxx7S1oR6mPPnTQ3Fcfs5Q?=
 =?us-ascii?Q?zfcK/G4Kl0W6YO9mExt02rv+Eas/TV7AADa6n2j8hbs3Qmk3wsupQEfEQVdK?=
 =?us-ascii?Q?5wFvur7B8wpQL4JfHP8zxyAtubrGATo8wgYkYs2ZiAHH8zFjziRL0CXP5kyI?=
 =?us-ascii?Q?ty+S18M0OU9GeI5f0N3GlHARUSOd6nPM1P72kcsZv/XrTy7Z0273awNz3hoP?=
 =?us-ascii?Q?9GCyjWLqgHSFf31LY2DP57N7f5jLJ7ZF7GmswXHzb2dDo5zRavXC3E1Eg2qP?=
 =?us-ascii?Q?9xhmqlg+h17G4pNCr5EDi1lYJycFwdAguxokI3vaZb9Hr4UkrbLluk812fL0?=
 =?us-ascii?Q?RvJgwoFauS5MY43KqAZH4r9NjNiHxCO6lOxQMfp3OExzcsdx+4lnXqSHkAdd?=
 =?us-ascii?Q?dv9d7ng+I6RwjhEEGHnLeGj2MLPvWC2owKYZiN3Pymmq0tt37aIf5mlaI6PY?=
 =?us-ascii?Q?DBrwjjSpbk/dBcNO9c1SbRAFoRoBpcBhVS1oTvQXXfuOjmG6eJzPdcL9nwqG?=
 =?us-ascii?Q?aEyPB15Zn34MRLXeZGGGGMiKKeFXr8HDH22brLg6knQA2Pqiy75GfdF2ZA1l?=
 =?us-ascii?Q?wOn4HUekBAtCn4mrb07O8QCJ159wVyvr1dCs/BLNowB4t+QFwgb6q3ULz4Lk?=
 =?us-ascii?Q?tjSadxcj4bXUJF16JOtlACGWX/uZ5fDJ4Z1EPc3zghNjBY5sZYpcVqv5jrTz?=
 =?us-ascii?Q?Y+VA8FoSuUj2iKgm/tY6Rept2mgBqnEBeVRmwtkgRaHX2CDOVti/dk5tMJ6e?=
 =?us-ascii?Q?3JAZiFR016jtWABoibWAKK4DLE++eHzIgj6peEbSHME5RocAYwEfIkYMLKZj?=
 =?us-ascii?Q?wFWYTXrOFuo1rCfRyXG/g7Yaq4NYHz7LTGVd07FFf/ALatBz4+AgppAeSUHT?=
 =?us-ascii?Q?ib3GyVVYK+tEm9OfPCBMA40dBzaxR6n11GCLE4Rus01YXF6XKl3SLm8MxFXT?=
 =?us-ascii?Q?rAm3opOubWxtyvp5KMiBE7/Bdb99gnbf/obBR/+BDWEGWKgpp0kGlFULwfxw?=
 =?us-ascii?Q?nyNdeJ+wHsyzrDiWHqX9UboR8NHYLuU11vRXRMhw8GthVywwuumYVPWCXdht?=
 =?us-ascii?Q?xEHotHCLH+MCAk+F79ko4Nuej/KF0IJQ08/uwYDK4sqnUFSMVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 11:15:35.4301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19abfdb-1fc8-448a-45d6-08dc95d14d3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213


Jakub Kicinski <kuba@kernel.org> writes:

> This implements what I was describing in [1]. When writing a test
> author can schedule cleanup / undo actions right after the creation
> completes, eg:
>
>   cmd("touch /tmp/file")
>   defer(cmd, "rm /tmp/file")
>
> defer() takes the function name as first argument, and the rest are
> arguments for that function. defer()red functions are called in
> inverse order after test exits. It's also possible to capture them
> and execute earlier (in which case they get automatically de-queued).
>
>   undo = defer(cmd, "rm /tmp/file")
>   # ... some unsafe code ...
>   undo.exec()
>
> As a nice safety all exceptions from defer()ed calls are captured,
> printed, and ignored (they do make the test fail, however).
> This addresses the common problem of exceptions in cleanup paths
> often being unhandled, leading to potential leaks.
>
> There is a global action queue, flushed by ksft_run(). We could support
> function level defers too, I guess, but there's no immediate need..
>
> Link: https://lore.kernel.org/all/877cedb2ki.fsf@nvidia.com/ # [1]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/ksft.py  | 49 +++++++++++++++------
>  tools/testing/selftests/net/lib/py/utils.py | 41 +++++++++++++++++
>  2 files changed, 76 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 45ffe277d94a..4a72b9cbb27d 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -6,6 +6,7 @@ import sys
>  import time
>  import traceback
>  from .consts import KSFT_MAIN_NAME
> +from .utils import global_defer_queue
>  
>  KSFT_RESULT = None
>  KSFT_RESULT_ALL = True
> @@ -108,6 +109,24 @@ KSFT_RESULT_ALL = True
>      print(res)
>  
>  
> +def ksft_flush_defer():
> +    global KSFT_RESULT
> +
> +    while global_defer_queue:
> +        entry = global_defer_queue[-1]
> +        try:
> +            entry.exec()

I wonder if you added _exec() to invoke it here. Because then you could
just do entry = global_defer_queue.pop() and entry._exec(), and in the
except branch you would just have the test-related business, without the
queue management.

> +        except Exception:

I think this should be either an unqualified except: or except
BaseException:.

> +            if global_defer_queue and global_defer_queue[-1] == entry:
> +                global_defer_queue.pop()
> +
> +            ksft_pr("Exception while handling defer / cleanup!")

Hmm, I was thinking about adding defer.__str__ and using it here to
give more clue as to where it went wrong, but the traceback is IMHO
plenty good enough.

> +            tb = traceback.format_exc()
> +            for line in tb.strip().split('\n'):
> +                ksft_pr("Defer Exception|", line)
> +            KSFT_RESULT = False
> +
> +
>  def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
>      cases = cases or []
>  
> @@ -130,29 +149,31 @@ KSFT_RESULT_ALL = True
>      for case in cases:
>          KSFT_RESULT = True
>          cnt += 1
> +        comment = ""
> +        cnt_key = ""
> +
>          try:
>              case(*args)
>          except KsftSkipEx as e:
> -            ktap_result(True, cnt, case, comment="SKIP " + str(e))
> -            totals['skip'] += 1
> -            continue
> +            comment = "SKIP " + str(e)
> +            cnt_key = 'skip'
>          except KsftXfailEx as e:
> -            ktap_result(True, cnt, case, comment="XFAIL " + str(e))
> -            totals['xfail'] += 1
> -            continue
> +            comment = "XFAIL " + str(e)
> +            cnt_key = 'xfail'
>          except Exception as e:
>              tb = traceback.format_exc()
>              for line in tb.strip().split('\n'):
>                  ksft_pr("Exception|", line)
> -            ktap_result(False, cnt, case)
> -            totals['fail'] += 1
> -            continue
> +            KSFT_RESULT = False
> +            cnt_key = 'fail'
>  
> -        ktap_result(KSFT_RESULT, cnt, case)
> -        if KSFT_RESULT:
> -            totals['pass'] += 1
> -        else:
> -            totals['fail'] += 1
> +        ksft_flush_defer()
> +
> +        if not cnt_key:
> +            cnt_key = 'pass' if KSFT_RESULT else 'fail'
> +
> +        ktap_result(KSFT_RESULT, cnt, case, comment=comment)
> +        totals[cnt_key] += 1
>  
>      print(
>          f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"

Majority of this hunk is just preparatory and should be in a patch of
its own. Then in this patch it should just introduce the flush.

> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 405aa510aaf2..1ef6ebaa369e 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -66,6 +66,47 @@ import time
>          return self.process(terminate=self.terminate, fail=self.check_fail)
>  
>  
> +global_defer_queue = []
> +
> +
> +class defer:
> +    def __init__(self, func, *args, **kwargs):
> +        global global_defer_queue
> +        if global_defer_queue is None:
> +            raise Exception("defer environment has not been set up")
> +
> +        if not callable(func):
> +            raise Exception("defer created with un-callable object, did you call the function instead of passing its name?")
> +
> +        self.func = func
> +        self.args = args
> +        self.kwargs = kwargs
> +
> +        self.queued = True
> +        self.executed = False
> +
> +        self._queue =  global_defer_queue
> +        self._queue.append(self)
> +
> +    def __enter__(self):
> +        return self
> +
> +    def __exit__(self, ex_type, ex_value, ex_tb):
> +        return self.exec()
> +
> +    def _exec(self):
> +        self.func(*self.args, **self.kwargs)
> +
> +    def cancel(self):

This shouldn't dequeue if not self.queued.

> +        self._queue.remove(self)
> +        self.queued = False
> +
> +    def exec(self):

This shouldn't exec if self.executed.

But I actually wonder if we need two flags at all. Whether the defer
entry is resolved through exec(), cancel() or __exit__(), it's "done".
It could be left in the queue, in which case the "done" flag is going to
disable future exec requests. Or it can just be dropped from the queue
when done, in which case we don't even need the "done" flag as such.

> +        self._exec()
> +        self.cancel()
> +        self.executed = True
> +
> +
>  def tool(name, args, json=None, ns=None, host=None):
>      cmd_str = name + ' '
>      if json:

