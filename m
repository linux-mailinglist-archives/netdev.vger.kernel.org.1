Return-Path: <netdev+bounces-289403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKGRCStDDGr/cAUAu9opvQ
	(envelope-from <netdev+bounces-289403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:02:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE7357D150
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF0DD3219ED9
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069103F660B;
	Tue, 19 May 2026 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UoxoKfc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130813F4DCA
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187955; cv=none; b=evYND68/z/RIaSHlw87pAjDhf4hxWFLoKii8bSOHnus9ovoaotvPeodrgCwYcLNUB0Wfy3zxyKNPJfQDx7TQ/fFBu7dsJlnX3a8/FJPGhA62KO/EFqG3I9A5wf2Jivu4e+VbBCpP0y0J1B789+Z5acUa8R0TefFOCE8CcBINey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187955; c=relaxed/simple;
	bh=7miayriHHeU5GK85YjQL+9pEs3gp2WQtHXqXlJCLImk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbrk6IDADX9shlZ+ooO209lP5ZQ5+cnA0yxlYRlHCvR1n/Xyvo2BxFoWZR0JgkGKLfNZqb2Vgj9Spx3RQAQDTfc+SuotXUNv/DDmWwZ9CrTsBpWv0u9Itkl8mrzg5WIHpQZWhyUkgy6Ip2HwPAyam1ABXtzQ13zcD359ksZUu6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UoxoKfc2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd3eb594960so429369966b.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779187945; x=1779792745; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3gCg+ANs7PR5sMiKuqTKIDJh5lnrthA2Gpe390HZRlY=;
        b=UoxoKfc2LD8Yt9goA1wHHpOVcYJ7bJVMPHE7bGr/5GFTQMRiNObHewSUNoytGnE42w
         iEgj9POKjte3cQBWgbEMIv6zo9ZwGW3zry5TqOdRsAOEelSQ/5KU5CRRr+F2rGyNSHKO
         SUrQlIff0mQr7T3vp8DFdZ7Gsl8jKoxfeHU4JMERBNQtyJoxAx75PdI54cPjNqC41DB/
         qRkdknO0jqRfZNrlrn3pKLN/+t26SCrn7NVi0FP6e/VT5ei8A+/DNNusM4sdvAG920jg
         bzUAQvELPtUv88Q3WqM3+MzbefHGBrQXOmvpdWn16W9fKJrFNH9lMq2FSv2gwqJ+Q7Bb
         8QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779187945; x=1779792745;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gCg+ANs7PR5sMiKuqTKIDJh5lnrthA2Gpe390HZRlY=;
        b=TDzo46UmciPZvxMS5ghrQkH+K4kRbaUndZqV/rw3GtOhGIMUw3VxoKmfwnfFT7rFjl
         5LzXBptvn5cA2mnl43KZOTADqFTXax2hw5vprO8IhHQxzhuJhgZHAahXE5vqg0DdjC1b
         ElbP77XywgHO4qYGpeb46PxorJ0AnPDj1nr0MX0D+1NU1t8FEi+6pQhsLb8xfABD3uMr
         55wsrthrXbtDQbLHTwH2KaBwtRV2jcv91Q39tI1mYKZHcuyEPf1+93Or89I4gU438pbb
         MMTWbFA0ssKZMU6yS04nG3lnl0BYIHnJ35Uva3mOvf1Zm2ti+i2lGroccl7pIboo/NxS
         gADw==
X-Forwarded-Encrypted: i=1; AFNElJ/+Np106zWExk4d26Q+DwkaHq/4BFpoxC4wbb31PO8gBcfv8DIOBz9eH9jfg2SCKMnTIEQGWCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLW1+OijMCkLeEgK1l5bP0ms4EhfPCs1YHLelTLmaBWhmypsWU
	5ABj7Ad8Ik/hhfiAg+5HQQhlHImjRdZTG0w6II3k0QNKMj9vrJGZ6vURlvw/NEzE+zs=
X-Gm-Gg: Acq92OH8PdGHYPZ0Iqr5Afu++IUo7GZroLbgkCzRjg9u7sIYB2OxvR1378pojDF1gqF
	y+Q7h/lCsYub5QcEnn6SV83nRXHTHqi5Fg/of82XCpPnwLhbs+6eBTe1fZGWb5RkEZ6qttjv1sW
	/PBsNZCLubVlqnhflSMYHBOgnkXLLwIS45r+wL+/BcNBB5Y4QThsbj7HNtjOVAr5UTiI+W2sIfv
	NgMKaeFb6Y4G3X+1p+VYH1KaamE3euMIDHU+Liuk2OsiaXl15UVoddNBdp5qjow7ycge63MFG2p
	NqSM8kk0sPelcpBietQM4A2VwDQ5c0JeUtLS8HMsxFT1wg0zyrfIuB20xXlz9pYIIsNOyw1iWxC
	wLiWpyIFuMAy6VsCPbbH9gnZlKunR5eEdb0lrcxvgio7IxmBUkczWFmtlv8+neZ/hN95bPBe/nW
	bc+LHLbrMuDa7xqaX6s1CqKeJZ9A==
X-Received: by 2002:a17:907:2da1:b0:bd5:b26:52d6 with SMTP id a640c23a62f3a-bd5177d78c9mr1070516866b.5.1779187944672;
        Tue, 19 May 2026 03:52:24 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e2d75bsm682961066b.45.2026.05.19.03.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:52:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  netdev@vger.kernel.org,  eric.dumazet@gmail.com,
  Nikolay Aleksandrov <razor@blackwall.org>,  Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH net-next] net: bridge: remove stale rcu_barrier() in
 br_multicast_dev_del()
In-Reply-To: <20260519095540.2643318-1-edumazet@google.com> (Eric Dumazet's
	message of "Tue, 19 May 2026 09:55:40 +0000")
References: <20260519095540.2643318-1-edumazet@google.com>
Date: Tue, 19 May 2026 12:52:23 +0200
Message-ID: <87cxyroemw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289403-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,blackwall.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: 7AE7357D150
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 09:55 AM GMT, Eric Dumazet wrote:
> This rcu_barrier() came from a time call_rcu() calls were used in
> net/bridge/br_multicast.c.
>
> Now kfree_rcu() is there, we can remove this problematic rcu_barrier()
> which causes extreme RTNL pressure in many syzbot reports.
>
> INFO: task syz-executor:77945 is blocked on a mutex likely owned by task kworker/u1024:5:36537.
> task:kworker/u1024:5 state:D stack:24616 pid:36537 tgid:36537 ppid:2      task_flags:0x4208060 flags:0x00080000 last_sleep:612797637337
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>   [<ffffffff81914eaa>] context_switch+0xf2a/0x1730 kernel/sched/core.c:6483
>   [<ffffffff81201143>] __schedule+0x1133/0x43a0 kernel/sched/core.c:8411
>   [<ffffffff8120446b>] __schedule_loop kernel/sched/core.c:8514 [inline]
>   [<ffffffff8120446b>] schedule+0xab/0x260 kernel/sched/core.c:8529
>   [<ffffffff8121a093>] schedule_timeout+0xc3/0x2b0 kernel/time/sleep_timeout.c:75
>   [<ffffffff81205347>] do_wait_for_common kernel/sched/completion.c:100 [inline]
>   [<ffffffff81205347>] __wait_for_common kernel/sched/completion.c:121 [inline]
>   [<ffffffff81205347>] wait_for_common kernel/sched/completion.c:132 [inline]
>   [<ffffffff81205347>] wait_for_completion+0x2c7/0x5d0 kernel/sched/completion.c:153
>   [<ffffffff81b8f27f>] rcu_barrier+0x49f/0x620 kernel/rcu/tree.c:3888
>   [<ffffffff860091b3>] br_multicast_dev_del+0x303/0x350 net/bridge/br_multicast.c:4459
>   [<ffffffff85fb5dbc>] br_dev_uninit+0x1c/0x40 net/bridge/br_device.c:157
>   [<ffffffff8568058c>] unregister_netdevice_many_notify+0x1c1c/0x2300 net/core/dev.c:12599
>   [<ffffffff8562be43>] ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
>   [<ffffffff8562be43>] ops_undo_list+0x3d3/0x940 net/core/net_namespace.c:248
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

