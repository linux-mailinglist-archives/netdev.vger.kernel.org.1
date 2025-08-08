Return-Path: <netdev+bounces-212135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EC5B1E3EA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23E4725B08
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 07:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F49424EABC;
	Fri,  8 Aug 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pA07gkxg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhlU5wGj"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B032165E2;
	Fri,  8 Aug 2025 07:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639589; cv=none; b=feRrpc90X1so6reWKeAi1DAczIYtIvA1AFJED4G5RoGLZxCXFAKkT5w8BEec7nEECiN9f2VJmT06hY+9OUaULzpZw7miL0ar0ZhHN7SUal3x3JFusqqFMX5g6U0kz8mbVtLTSxIsn8+RzDS3ajMXfjzHWPcve1+yJf38215KmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639589; c=relaxed/simple;
	bh=/7ClYfMiSxAa1wTucVb/CJkSZIYnrq/mU6F7bRSsfVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SMiq0F/y71lGT7K35PsSxXV031x5LtVOSbcm1qx/3XZQLPXV4XAgkwWE4ygXJN5m6nBjCMUs+F5Rp1Yat/NTQkeZNFaopFP0EouX3C14AOS/ziVQDlU2uyG6MLU4n4j2T0HkEWzDCAnGtQgkoP2b77AWIDESaXI5tojHIigkhy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pA07gkxg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhlU5wGj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754639585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgvQLFtkKGmmjE3l2Crv/yMEwEOMbKI3kuWlY+rtSxg=;
	b=pA07gkxguS3KtmYy7DLtM3wOXtdxVrciLNp/FtkZahkbj6Kf7LF2NUuVKjMnnI+hqxPs7e
	LewPqsAecVNYzcK3HOixoJVeBSWrhwMA6GrAkyYOs+9XI6QwpNHGFehO/ZAVteWr3IsRBt
	zlfySEeLabBq8kgLjnRvwOKldUsyHI3lWAy+jaoadoYMXQJ4rYCyPFaKwBBdintNF8qMoG
	SDhZ1MygrIkyTk8UG7FOFVzsKWHOxTAHwjF7PJSTQRbpbF9GuXyRob1Y76tNy88yojNa2h
	8YmU4MH4jCJlQG8jUn5ZY7a8cmqCZhiaH+thf9ZRHHSeWBuXg+XUKxgSXTdsBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754639585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgvQLFtkKGmmjE3l2Crv/yMEwEOMbKI3kuWlY+rtSxg=;
	b=VhlU5wGjtK/wzDzetlc9swBMxQ6cBYQO3ymCTc+Zh76HQkZDdEyYZS43X9ClrJyprKJicG
	E6TwEJT4BCySPVDg==
To: kernel test robot <oliver.sang@intel.com>, Gabriele Monaco
 <gmonaco@redhat.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Peter
 Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org,
 aubrey.li@linux.intel.com, yu.c.chen@intel.com, oliver.sang@intel.com,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linus:master] [sched]  adcc3bfa88:
 kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail
In-Reply-To: <202508070739.4c6e0633-lkp@intel.com>
References: <202508070739.4c6e0633-lkp@intel.com>
Date: Fri, 08 Aug 2025 09:52:53 +0200
Message-ID: <87a54ap7vu.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Cc: netdev folks

I don't see any connection between the reported commit and the
problem. This looks like the driver's problem.

kernel test robot <oliver.sang@intel.com> writes:

> Hello,
>
> kernel test robot noticed "kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail" on:
>
> commit: adcc3bfa8806761ac21aa271f78454113ec6936e ("sched: Adapt sched tracepoints for RV task model")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master      6a68cec16b647791d448102376a7eec2820e874f]
> [test failed on linux-next/master 84b92a499e7eca54ba1df6f6c6e01766025943f1]
>
> in testcase: kunit
> version: 
> with following parameters:
>
> 	group: group-03
>
>
>
> config: x86_64-rhel-9.4-kunit
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508070739.4c6e0633-lkp@intel.com
>
>
> [   80.925851]     # vcap_api_show_admin_raw_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c:377
>                    Expected test_expected == test_pr_buffer[0], but
>                        test_expected == "  addr: 786, X6 rule, keysets: VCAP_KFS_MAC_ETYPE
>                "
>                        test_pr_buffer[0] == ""
> [   80.926182]     not ok 2 vcap_api_show_admin_raw_test
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250807/202508070739.4c6e0633-lkp@intel.com
>
>
>
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

