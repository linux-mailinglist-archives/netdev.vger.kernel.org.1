Return-Path: <netdev+bounces-281137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yD8MD5DI7WmengAAu9opvQ
	(envelope-from <netdev+bounces-281137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C250E46906D
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F31EA300363B
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 08:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF04C2E9757;
	Sun, 26 Apr 2026 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBeRvVt9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4BF20E702;
	Sun, 26 Apr 2026 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777191053; cv=none; b=UK5n0tmj8LBbalptgFb+fUir2raX+Vm3So6T5DCtOPmkZTY35aB/YDKt5Q9RJxd+zha0iiH3uyHGuMu3B+6Rpp6oe+p09ivVDh0dugB718prBr7mOCft30xrZLoIWYbHNqfsqi5kNa2S+r7eaAEEcTiPqnH2yoikqf2ax/c2Dxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777191053; c=relaxed/simple;
	bh=fVyCT+rptTO/oc+viWlIO2w/FiWPHVtVszQ7rI++iq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpi+5rbqD6uPrkx3//jdrKx6iWs6EHlHRjzYvDu9MEVFwfx3a3MNLyNgimCIaPMYSL9zWiyVqS42Mj/NNBsh9I5Yx/b4mODv9BNVAQKqvKoPkLiEvBX4RqW0+Wrg3uEiNhS0OjULYZQVdJCkBlU743nbmvLeWosOrn7oK2DwXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBeRvVt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5B3C2BCAF;
	Sun, 26 Apr 2026 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777191053;
	bh=fVyCT+rptTO/oc+viWlIO2w/FiWPHVtVszQ7rI++iq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBeRvVt9OsRl7gunB2Qhe7YNU4hYpMJFsJxoJ6Eb1HHqUSUBxJvJ7aVfSjrAreEQC
	 gGWFYm9kimZDIwJi5rX6ftH3T8tcdDpYSoXEjVLAH0fWJH6HOsPCnEx+moBZCjCqqv
	 4/tZTMaYs+CTy0SejnXgOWtj/QBlGUjmkZRQGrJTdpWZUzgZtuiLUIGJyvXf2rpJ/b
	 uCg8ZG9834gyRrf50YTFT2+v0zKBvub+BR44kFhYKBz5DbS7EPsruSC9p7vm9mX6JU
	 4+MMFqECUnzY3EJv1L7qG7L1Qv6Ig/evTY3EjAmfXcehh8NKqDSsSk3Ml/vNINEuI4
	 UU3y2IkaLQpCw==
Date: Sun, 26 Apr 2026 09:10:49 +0100
From: Simon Horman <horms@kernel.org>
To: Faicker Mo <faicker.mo@zenlayer.com>
Cc: "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: net_failover: Fix the deadlock in slave register
Message-ID: <20260426081049.GM900403@horms.kernel.org>
References: <PH0PR20MB435271FE3258110CE77261BBFA2A2@PH0PR20MB4352.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR20MB435271FE3258110CE77261BBFA2A2@PH0PR20MB4352.namprd20.prod.outlook.com>
X-Rspamd-Queue-Id: C250E46906D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281137-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zenlayer.com:email,horms.kernel.org:mid]

On Thu, Apr 23, 2026 at 07:59:43AM +0000, Faicker Mo wrote:
> There is netdev_lock_ops() before the NETDEV_REGISTER notifier
> in register_netdevice(), so use the non-locking functions
> in net_failover_slave_register().
> 
> Call Trace:
>  <TASK>
>  __schedule+0x30d/0x7a0
>  schedule+0x27/0x90
>  schedule_preempt_disabled+0x15/0x30
>  __mutex_lock.constprop.0+0x538/0x9e0
>  __mutex_lock_slowpath+0x13/0x20
>  mutex_lock+0x3b/0x50
>  dev_set_mtu+0x40/0xe0
>  net_failover_slave_register+0x24/0x280
>  failover_slave_register+0x103/0x1b0
>  failover_event+0x15e/0x210
>  ? dropmon_net_event+0xac/0xe0
>  notifier_call_chain+0x5e/0xe0
>  raw_notifier_call_chain+0x16/0x30
>  call_netdevice_notifiers_info+0x52/0xa0
>  register_netdevice+0x5f4/0x7c0
>  register_netdev+0x1e/0x40
>  _mlx5e_probe+0xe2/0x370 [mlx5_core]
>  mlx5e_probe+0x59/0x70 [mlx5_core]
>  ? __pfx_mlx5e_probe+0x10/0x10 [mlx5_core]
> 
> Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
> Signed-off-by: Faicker Mo <faicker.mo@zenlayer.com>

...

Unfortunately this patch does not apply: it seems that somehow all the tabs
were converted into spaces.

> @@ -565,7 +565,7 @@ static int net_failover_slave_register(struct net_device *slave_dev,
>         dev_close(slave_dev);

Claude Code flags that that this needs to be changed to netif_close()

>  err_dev_open:
>         dev_put(slave_dev);
> -       dev_set_mtu(slave_dev, orig_mtu);
> +       netif_set_mtu(slave_dev, orig_mtu);
>  done:
>         return err;
>  }

-- 
pw-bot: changes-requested

