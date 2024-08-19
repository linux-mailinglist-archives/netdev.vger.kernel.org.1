Return-Path: <netdev+bounces-119832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E5C9572FD
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383161F21C30
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3892189B94;
	Mon, 19 Aug 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t1CDGI75"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B2189B91;
	Mon, 19 Aug 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091522; cv=none; b=O9fER6l/FVITmqQ2MstWfaKV4a2yZ1xhwKg6gE+97Q83fyjaVyAMBGe5slB/ck1GARJb/n0YOtKoaZdnR1VtWRGSFao4ThiehxWFp+tEsm3lQSW2ZJMmdPocHGDkcGI/i/Xxz3d7FFjL0sVTt1+I/IoGDuXfNFha+DQxrHM7/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091522; c=relaxed/simple;
	bh=IaoHiIAs9FJHc1dS2if9+273kwrg4UuLYw3HFZPRPGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gq2OFzyPcAYR9uWYF0MlhZ0AG2VaKvVt46Zv4If1mCESUOEQtYmDH+G39H7TgRA8iDjc32mmoEXWGzADuuTIsrz17TOX8nQ4P8IhMe6Hd8EYMquPwkMCFDBcoNEHxjq4PPi0Ffy3/ykdllvVtZjNMPQBjlIEgRAqcn/Fcvvdrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t1CDGI75; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724091520; x=1755627520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=isht7YW7ehI9tqAWeR+zFWwS5kfDIoOLE644SuX9WYA=;
  b=t1CDGI75ib9qK4J7P7H9PKXQ+cybtmpFjBOvVnJ2eHXOq2Aelw7nXoXP
   JUT11/x9Mj8OM+FefBgLgshb7889VqXusUo2qQOA+ni++aKOh2v40NPQj
   onozarikaWq3rnOhJkJQRn7GDnFBdsTQjrTmhXmYSVvLAAOe2o5vuUjaV
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,159,1719878400"; 
   d="scan'208";a="116627922"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 18:18:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:46079]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.29:2525] with esmtp (Farcaster)
 id 79517f3d-a47f-4629-a733-a14a26110d03; Mon, 19 Aug 2024 18:18:38 +0000 (UTC)
X-Farcaster-Flow-ID: 79517f3d-a47f-4629-a733-a14a26110d03
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 18:18:38 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 19 Aug 2024 18:18:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <tze-nan.wu@mediatek.com>
CC: <angelogioacchino.delregno@collabora.com>, <bobule.chang@mediatek.com>,
	<cheng-jui.wang@mediatek.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
	<wsd_upstream@mediatek.com>, <yanghui.li@mediatek.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH v2] net/socket: Check cgroup_bpf_enabled() only once in  do_sock_getsockopt
Date: Mon, 19 Aug 2024 11:18:25 -0700
Message-ID: <20240819181825.18235-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240819155627.1367-1-Tze-nan.Wu@mediatek.com>
References: <20240819155627.1367-1-Tze-nan.Wu@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Date: Mon, 19 Aug 2024 23:56:27 +0800
> The return value from `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` can change
> between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`.
> 
> If `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` changes from "false" to
> "true" between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`, `BPF_CGROUP_RUN_PROG_GETSOCKOPT` will
> receive an -EFAULT from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`
> due to `get_user()` was not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`.
> 
> Scenario shown as below:
> 
>            `process A`                      `process B`
>            -----------                      ------------
>   BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
>                                             enable CGROUP_GETSOCKOPT
>   BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)
> 
> To prevent this, invoke `cgroup_bpf_enabled()` only once and cache the
> result in a newly added local variable `enabled`.
> Both `BPF_CGROUP_*` macros in `do_sock_getsockopt` will then check their
> condition using the same `enabled` variable as the condition variable,
> instead of using the return values from `cgroup_bpf_enabled` called by
> themselves as the condition variable(which could yield different results).
> This ensures that either both `BPF_CGROUP_*` macros pass the condition
> or neither does.
> 
> Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
> Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
> ---
> 
> Chagnes from v1 to v2: https://lore.kernel.org/all/20240819082513.27176-1-Tze-nan.Wu@mediatek.com/
>   Instead of using cgroup_lock in the fastpath, invoke cgroup_bpf_enabled
>   only once and cache the value in the variable `enabled`. `BPF_CGROUP_*`
>   macros in do_sock_getsockopt can then both check their condition with
>   the same variable, ensuring that either they both passing the condition
>   or both do not.
> 
> Appreciate for reviewing this!
> This patch should make cgroup_bpf_enabled() only using once,
> but not sure if "BPF_CGROUP_*" is modifiable?(not familiar with code here)
> 
> If it's not, then maybe I can come up another patch like below one:
> 	+++ b/net/socket.c
> 	  	int max_optlen __maybe_unused;
> 	 	const struct proto_ops *ops;
> 	 	int err;
> 	+	bool enabled;
> 	
> 	 	err = security_socket_getsockopt(sock, level, optname);
> 	 	if (err)
> 	 		return err;
> 	
> 	-	if (!compat)
> 	+	enabled = cgroup_bpf_enabled(CGROUP_GETSOCKOPT);
> 	+   if (!compat && enabled)
> 			max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> 
> But this will cause do_sock_getsockopt calling cgroup_bpf_enabled up to
> three times , Wondering which approach will be more acceptable?
> 
> ---
>  include/linux/bpf-cgroup.h | 13 ++++++-------
>  net/socket.c               |  9 ++++++---
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index fb3c3e7181e6..251632d52fa9 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -390,20 +390,19 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>  	__ret;								       \
>  })
>  
> -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)			       \
> +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled)			       \

Please keep \ aligned.  Same for other places.


>  ({									       \
>  	int __ret = 0;							       \
> -	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))			       \

Can you assign 'enabled' here to hide its usage in the macro ?


> +	if (enabled)			       \
>  		copy_from_sockptr(&__ret, optlen, sizeof(int));		       \
>  	__ret;								       \
>  })
>  
>  #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optlen,   \
> -				       max_optlen, retval)		       \
> +				       max_optlen, retval, enabled)		       \
>  ({									       \
>  	int __ret = retval;						       \
> -	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
> -	    cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		       \
> +	if (enabled && cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		    \
>  		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
>  		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
>  					tcp_bpf_bypass_getsockopt,	       \
> @@ -518,9 +517,9 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>  #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
> -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen) ({ 0; })
> +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled) ({ 0; })
>  #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
> -				       optlen, max_optlen, retval) ({ retval; })
> +				       optlen, max_optlen, retval, enabled) ({ retval; })
>  #define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, \
>  					    optlen, retval) ({ retval; })
>  #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
> diff --git a/net/socket.c b/net/socket.c
> index fcbdd5bc47ac..5336a2755bb4 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2365,13 +2365,16 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>  	int max_optlen __maybe_unused;
>  	const struct proto_ops *ops;
>  	int err;
> +	bool enabled;

Please keep reverse xmas tree order.
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs


>  
>  	err = security_socket_getsockopt(sock, level, optname);
>  	if (err)
>  		return err;
>  
> -	if (!compat)
> -		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> +	if (!compat) {
> +		enabled = cgroup_bpf_enabled(CGROUP_GETSOCKOPT);
> +		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled);
> +	}
>  
>  	ops = READ_ONCE(sock->ops);
>  	if (level == SOL_SOCKET) {
> @@ -2390,7 +2393,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>  	if (!compat)
>  		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
>  						     optval, optlen, max_optlen,
> -						     err);
> +						     err, enabled);
>  
>  	return err;
>  }
> -- 
> 2.45.2

