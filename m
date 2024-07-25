Return-Path: <netdev+bounces-113092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91E93CA3E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 23:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A71E1F2334D
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 21:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E9013CABC;
	Thu, 25 Jul 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QAt5klfK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C513C906
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943202; cv=none; b=LOPup4/G5h+GkqxEgQzClWVpSYY9gI3OrQzR2gY3CROwzmKhjfYJNm9A8fJmN7O4TUGtriB2BAapLk3u84QelK3VWxuKQgpukF/x9fHtqdYHGJfW2yX9HGNFLFZzzfjexXJQC8dk/0FVggNNd+Gb20CtVZsouNIc8z4zpdkVH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943202; c=relaxed/simple;
	bh=oGwYrvp8P5QF03oit1mtRcqKPil3j6i4YJQ15qjBmhE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU/WgmMVZlG8v0qS0Akpr18clVKrpw4z6M6em42u81katNspmyRv76VKLoh/TqV36eWPUSCgK2e8uVLnAYFs+ImrRJPdugxJL7IaXhRAfy4JxSq+PAYtOInqEz7RJ02xOsU6aMbByGgqBYF5x/crFMgj5785/6Rx9dUvSLofdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QAt5klfK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39a19fb5a18so4713655ab.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721943199; x=1722547999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1fE6JM00dEWDFqi14hn3iG7rF7lvidTL7Y9/FSB1RQ=;
        b=QAt5klfKubljd8m1LOqOIQrM7inILHO5bsztWzqWEocZtEpxgwg4AW4EaiUb1s8jhW
         G55jIyTV9jXWBCAmVZcvh7mEu1bBdrosJndjOsSO3LRTVXNoZw2hoH3S+uS76Qzd4rfy
         r1GVACm4InZ/ZjifwFEzeIufyKIj1ZAXCuHc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943199; x=1722547999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1fE6JM00dEWDFqi14hn3iG7rF7lvidTL7Y9/FSB1RQ=;
        b=E74qABVnl3/+0k++OZSK5o7K5I3okZWYMDoqEj2Rv/2ZdwFXu4NWfL/DV11lT3IkYo
         bLqsY3uhwHTYyk/kB/Pvjb7ILOZ9JLonfGosC9B1uppJDMbXypJkOo1klR5iBiMz1JWU
         /1QOp4qRxF1YSHobbpLXgzdwdnwBpJ/YZfnYK5hOp1m+s5uLzPVYnwcsTO8CcVDvRlCF
         x8TbS3QHu7R8aENG+fFY4/rZN+DyvSQEY6D3F0MVAGdQEa2x5k2wbK4DxoiFuKsG/OGq
         T3qL6AoBFTSA3NHsfao9Q9Q1LnlNOVb5uFfg7yFwqtnn/Efipv4GFhruuVfWyAfo0zI5
         0+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4w8nnq4L21NSO3M3NsFs8XkAkAxNWuoWA1zOIEV1/Q4/zx7RerlcIaftri2O5Ect956ceibXr5jXDy3VbA2xRmQeKZf68
X-Gm-Message-State: AOJu0Yx8fChN+546MmXduoK0HeuD1bct7PkZipity/YHsICXcgLURo6P
	yAXijTjd6UKDhvAgNfkcjDTn+UNLPDY+NODvgQjz9ugqAxQsxZT/aOcrq8BgdOiKVIkl2sNK5+U
	=
X-Google-Smtp-Source: AGHT+IFDDUkD9chPoM/JLNgwkr4RoyWAWzfbdgVKyq6r7iI4wPBq+RWnMeM3zMmuX0e3TR0MpkqK3w==
X-Received: by 2002:a05:6e02:1d81:b0:398:e585:7be4 with SMTP id e9e14a558f8ab-39a217c0dd5mr58818165ab.1.1721943199159;
        Thu, 25 Jul 2024 14:33:19 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9ec374bsm1605689a12.67.2024.07.25.14.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:33:18 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 25 Jul 2024 17:33:10 -0400
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH] bnxt_en: Fix RSS logic in __bnxt_reserve_rings()
Message-ID: <ZqLEfyNLtCy25g6w@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240724222106.147744-1-michael.chan@broadcom.com>
 <20240724172536.318fb6f8@kernel.org>
 <20240725111912.7bc17cf6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725111912.7bc17cf6@kernel.org>

On Thu, Jul 25, 2024 at 11:19:12AM -0700, Jakub Kicinski wrote:
> On Wed, 24 Jul 2024 17:25:36 -0700 Jakub Kicinski wrote:
> > On Wed, 24 Jul 2024 15:21:06 -0700 Michael Chan wrote:
> > > Now, with RSS contexts support, if the user has added or deleted RSS
> > > contexts, we may now enter this path to reserve the new number of VNICs.
> > > However, netif_is_rxfh_configured() will not return the correct state if
> > > we are still in the middle of set_rxfh().  So the existing code may
> > > set the indirection table of the default RSS context to default by
> > > mistake.  
> > 
> > I feel like my explanation was more clear :S
> > 
> > The key point is that ethtool::set_rxfh() calls the "reload" functions
> > and expects the scope of the "reload" to be quite narrow, because only
> > the RSS table has changed. Unfortunately the add / delete of additional
> > contexts de-sync the resource counts, so ethtool::set_rxfh() now ends
> > up "reloading" more than it intended. The "more than intended" includes
> > going down the RSS indir reset path, which calls netif_is_rxfh_configured().
> > Return value from netif_is_rxfh_configured() during ethtool::set_rxfh()
> > is undefined.
> > 
> > Reported tag would have been nice too..
> 

Agreed.  Sorry that was missed.

> Reported-and-tested-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/20240625010210.2002310-1-kuba@kernel.org
> 
> There's one more problem. It looks like changing queue count discards
> existing ntuple filters:
> 
> # Check| At /root/./ksft/drivers/net/hw/rss_ctx.py, line 387, in test_rss_context_queue_reconfigure:
> # Check|     test_rss_queue_reconfigure(cfg, main_ctx=False)
> # Check| At /root/./ksft/drivers/net/hw/rss_ctx.py, line 230, in test_rss_queue_reconfigure:
> # Check|     _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
> # Check| At /root/./ksft/drivers/net/hw/rss_ctx.py, line 92, in _send_traffic_check:
> # Check|     ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
> # Check failed 1045235 >= 405823.5 traffic on other queues (context 1)':[460068, 351995, 565970, 351579, 127270]
> # Exception while handling defer / cleanup (callback 1 of 3)!
> # Defer Exception| Traceback (most recent call last):
> # Defer Exception|   File "/root/ksft/net/lib/py/ksft.py", line 129, in ksft_flush_defer
> # Defer Exception|     entry.exec_only()
> # Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 93, in exec_only
> # Defer Exception|     self.func(*self.args, **self.kwargs)
> # Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 121, in ethtool
> # Defer Exception|     return tool('ethtool', args, json=json, ns=ns, host=host)
> # Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 108, in tool
> # Defer Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
> # Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 32, in __init__
> # Defer Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
> # Defer Exception|   File "/root/ksft/net/lib/py/utils.py", line 50, in process
> # Defer Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
> # Defer Exception| net.lib.py.utils.CmdExitFailure: Command failed: ethtool -N eth0 delete 0
> # Defer Exception| STDOUT: b''
> # Defer Exception| STDERR: b'rmgr: Cannot delete RX class rule: No such file or directory\nCannot delete classification rule\n'
> not ok 8 rss_ctx.test_rss_context_queue_reconfigure
> 
> This is from the following chunk of the test:
> 
>    225      # We should be able to increase queues, but table should be left untouched
>    226      ethtool(f"-L {cfg.ifname} combined 5")
>    227      data = get_rss(cfg, context=ctx_id)
>    228      ksft_eq({0, 3}, set(data['rss-indirection-table']))
>    229  
>    230      _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
>    231                                                other_key: (1, 2, 4) })
> 
> The Check failure tells us the traffic was sprayed.
> The Defer Exception, well, self-explanatory: 
>   "Cannot delete RX class rule: No such file or directory"

We can take a look at that, but we currently do this on purpose.


