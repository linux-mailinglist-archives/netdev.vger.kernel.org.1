Return-Path: <netdev+bounces-113053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCF93C83A
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC87281850
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C111F959;
	Thu, 25 Jul 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nInXA8zd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6251E528
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931554; cv=none; b=ZuizpJeidzKIumdUl8EiynBcKHoubu5jEws4K+Hia48lfwWPnfqp0G6oJXGSywsOx4VWNSu8IegbZR0JX6T364KKxGgmSeV+m433sztW4YyHl2F8XcPIvjJWpsw5w0xw5GfHYagDMw71cYgxAejAQjjuTiLtozCklPvKCnlweyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931554; c=relaxed/simple;
	bh=Sjct5TAjY5FlYdhQmgNLN2aMt1YOGv7hkWfUNlxRXj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4beJaF+ZgRYLVEFmPiHMByN2LWKcZT8Tcgs1p1fV5XVoQAnLYFvelTpt+CLWwRDIF4udXJvplI00rjPBMLFJSq7rrDDLh5nbFthPZEI5H1ilA5oI+jTy2vVPVnu/r9hBV22vNR6HLv4Yl5WWu1FVe5xL/U0+Mwlmz9Ok/9Va28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nInXA8zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4680C116B1;
	Thu, 25 Jul 2024 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721931554;
	bh=Sjct5TAjY5FlYdhQmgNLN2aMt1YOGv7hkWfUNlxRXj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nInXA8zdnC78bm3JMZtw35vN1h97VihbWcM0guCMs00TctXfGIuV1UOuTGqaCRaAp
	 oJBkrFaGJd9NOCoRGSzhTS1fRYXketUpjoOscYtvuERNfru9B77tjF3exg+LbYxuYv
	 Ca4fUVziTiPa/qJb4L54WcDR7aMKLKxyZWUl9yWqilnVk+2QsHxs2u2G8wo/j+SnpX
	 SbiWobPKsI1oJoJVsXF8IpRFDEL/ksU7naztKsNlFRBA0yyWan0YSd1CgSvHRydgb3
	 H5F42kOfseGe/EX2QoOoQYGtnSfKj8wsojMd48byxrYmp01fs3nvVdSe5tUa5ck8mW
	 U3B9dmPGYh05A==
Date: Thu, 25 Jul 2024 11:19:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
Subject: Re: [PATCH] bnxt_en: Fix RSS logic in __bnxt_reserve_rings()
Message-ID: <20240725111912.7bc17cf6@kernel.org>
In-Reply-To: <20240724172536.318fb6f8@kernel.org>
References: <20240724222106.147744-1-michael.chan@broadcom.com>
	<20240724172536.318fb6f8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 17:25:36 -0700 Jakub Kicinski wrote:
> On Wed, 24 Jul 2024 15:21:06 -0700 Michael Chan wrote:
> > Now, with RSS contexts support, if the user has added or deleted RSS
> > contexts, we may now enter this path to reserve the new number of VNICs.
> > However, netif_is_rxfh_configured() will not return the correct state if
> > we are still in the middle of set_rxfh().  So the existing code may
> > set the indirection table of the default RSS context to default by
> > mistake.  
> 
> I feel like my explanation was more clear :S
> 
> The key point is that ethtool::set_rxfh() calls the "reload" functions
> and expects the scope of the "reload" to be quite narrow, because only
> the RSS table has changed. Unfortunately the add / delete of additional
> contexts de-sync the resource counts, so ethtool::set_rxfh() now ends
> up "reloading" more than it intended. The "more than intended" includes
> going down the RSS indir reset path, which calls netif_is_rxfh_configured().
> Return value from netif_is_rxfh_configured() during ethtool::set_rxfh()
> is undefined.
> 
> Reported tag would have been nice too..

Reported-and-tested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/20240625010210.2002310-1-kuba@kernel.org

There's one more problem. It looks like changing queue count discards
existing ntuple filters:

# Check| At /root/./ksft/drivers/net/hw/rss_ctx.py, line 387, in test_rss_context_queue_reconfigure:
# Check|     test_rss_queue_reconfigure(cfg, main_ctx=False)
# Check| At /root/./ksft/drivers/net/hw/rss_ctx.py, line 230, in test_rss_queue_reconfigure:
# Check|     _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
# Check| At /root/./ksft/drivers/net/hw/rss_ctx.py, line 92, in _send_traffic_check:
# Check|     ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
# Check failed 1045235 >= 405823.5 traffic on other queues (context 1)':[460068, 351995, 565970, 351579, 127270]
# Exception while handling defer / cleanup (callback 1 of 3)!
# Defer Exception| Traceback (most recent call last):
# Defer Exception|   File "/root/ksft/net/lib/py/ksft.py", line 129, in ksft_flush_defer
# Defer Exception|     entry.exec_only()
# Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 93, in exec_only
# Defer Exception|     self.func(*self.args, **self.kwargs)
# Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 121, in ethtool
# Defer Exception|     return tool('ethtool', args, json=json, ns=ns, host=host)
# Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 108, in tool
# Defer Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
# Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 32, in __init__
# Defer Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 50, in process
# Defer Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# Defer Exception| net.lib.py.utils.CmdExitFailure: Command failed: ethtool -N eth0 delete 0
# Defer Exception| STDOUT: b''
# Defer Exception| STDERR: b'rmgr: Cannot delete RX class rule: No such file or directory\nCannot delete classification rule\n'
not ok 8 rss_ctx.test_rss_context_queue_reconfigure

This is from the following chunk of the test:

   225      # We should be able to increase queues, but table should be left untouched
   226      ethtool(f"-L {cfg.ifname} combined 5")
   227      data = get_rss(cfg, context=ctx_id)
   228      ksft_eq({0, 3}, set(data['rss-indirection-table']))
   229  
   230      _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
   231                                                other_key: (1, 2, 4) })

The Check failure tells us the traffic was sprayed.
The Defer Exception, well, self-explanatory: 
  "Cannot delete RX class rule: No such file or directory"

