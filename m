Return-Path: <netdev+bounces-242588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD5C925D0
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4D73AA6DE
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA90271448;
	Fri, 28 Nov 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="lgOaMWRx"
X-Original-To: netdev@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76E24DCF9
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341292; cv=none; b=M+qC1udz7zp3gVyPx498yyO4186oMXbYRSK9kAa7YZUEHyEvBPh+Kd5CRs0j/QapxcelR+qsKxuBJmTnuOctAXyo6mwGOODLh+eGiyA8+mvJnvh4eeyAhbn3EICooXiDmGBGiPNZqLgcTt8MLdqYN+gmNJd1vqUrMcW2fsZviZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341292; c=relaxed/simple;
	bh=wacQteaUJ6ooBwWTTcdeTU5Ra6xR8FUNO7WTjaFzNfY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l4u76z3dOyIiNAAfQAIsc92dEhchBprAdEXlBG9PIudKRkqp6W+tsytcM6dOGvJWoyDJzGj5y3wHo2VpXReLrp+29ZayABDKo5ru80izMyrSu/3L44oM830LtJFDPfWIJ3ZLkx+nfJg8A3h+JgBeRwzG2Uh62aqYDHCesgdE7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=lgOaMWRx; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id BB349211B3;
	Fri, 28 Nov 2025 16:47:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=cSrgG+iR6DQXW+O0CkFq0qTjQIx65QN4Sfm0KZrCWN0=; b=lgOaMWRxvp74
	5uyk+bjS3LeeZoRUG9qqzNooPjSUkqh/1mhG8KTzAOVjFbT1VdsU88MNQr697ys5
	P7idiEbPBckIjodXH9/IGinptwNtdFNAShtj+9/9ZvIALobEeDzJJBD+WvtShmLr
	9ABsrzIHftUqU1ZjNiUcP8qX8QSoOIcEJ1jZ65t6ojXyAaLaBeSheFDXx5MWXAAj
	GebhtKM4zaBFie+o22lfAC7QY8Erweb6D/viHxNl+eD4sgR53D4mUAKtOf3o61Dv
	HszPJKKz7ab5C78Hr44bDXvLHhG0pYLDSzksFTqKTIuXWW7f10W0MFsv25N+cBUk
	vHNPBJwYVsiuvMQP25KT4lfzpfzSNyDDXVHSPcAGUBFBexohxe4fiEmeSJqcaJts
	XYosI7i9D2ZRDfkQVo1R9KL1K/2mmB7muhBqXu3eX7rGF7Ow7SgbVrKdj/k8sBP5
	rPPksrslcKyME2+nkfpMLguuCjJAaTJK3/JeQeWjosSCCi+5TOKWyCiLhJ7Atwrp
	c6G0IezgdOyh5G7ffB5RG47jO8Eo8q7oau6l5T2Q79nB4NzGMbhBD0uHv3erwxvh
	lPaqxGaoUj420mvmOqgAmi2UoqnIaPrLWNONkQs6v9IWou1hWUrLrMFoIdcH8MAW
	m55NYoRJ+ID1vol8HLqqH8xDzoYFgjM=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Fri, 28 Nov 2025 16:47:54 +0200 (EET)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id DD06B61BAA;
	Fri, 28 Nov 2025 16:47:51 +0200 (EET)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 5ASEleOg025719;
	Fri, 28 Nov 2025 16:47:42 +0200
Date: Fri, 28 Nov 2025 16:47:40 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
To: Heiko Carstens <hca@linux.ibm.com>
cc: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove KMSG_COMPONENT macro
In-Reply-To: <20251126140705.1944278-1-hca@linux.ibm.com>
Message-ID: <f407105b-d43f-a31f-5782-c68767ed9688@ssi.bg>
References: <20251126140705.1944278-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


	Hello,

On Wed, 26 Nov 2025, Heiko Carstens wrote:

> The KMSG_COMPONENT macro is a leftover of the s390 specific "kernel message
> catalog" from 2008 [1] which never made it upstream.
> 
> The macro was added to s390 code to allow for an out-of-tree patch which
> used this to generate unique message ids. Also this out-of-tree patch
> doesn't exist anymore.
> 
> The pattern of how the KMSG_COMPONENT macro is used can also be found at
> some non s390 specific code, for whatever reasons. Besides adding an
> indirection it is unused.
> 
> Remove the macro in order to get rid of a pointless indirection. Replace
> all users with the string it defines. In all cases this leads to a simple
> replacement like this:
> 
>  - #define KMSG_COMPONENT "af_iucv"
>  - #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>  + #define pr_fmt(fmt) "af_iucv: " fmt
> 
> [1] https://lwn.net/Articles/292650/
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

	IPVS part looks good to me, thanks!

Acked-by: Julian Anastasov <ja@ssi.bg>

> ---
>  net/iucv/af_iucv.c                      | 3 +--
>  net/iucv/iucv.c                         | 3 +--
>  net/netfilter/ipvs/ip_vs_app.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_conn.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_core.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_ctl.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_dh.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_est.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_fo.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_ftp.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_lblc.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_lblcr.c        | 3 +--
>  net/netfilter/ipvs/ip_vs_lc.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_mh.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_nfct.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_nq.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_ovf.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_pe.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_pe_sip.c       | 3 +--
>  net/netfilter/ipvs/ip_vs_proto.c        | 3 +--
>  net/netfilter/ipvs/ip_vs_proto_ah_esp.c | 3 +--
>  net/netfilter/ipvs/ip_vs_proto_tcp.c    | 3 +--
>  net/netfilter/ipvs/ip_vs_proto_udp.c    | 3 +--
>  net/netfilter/ipvs/ip_vs_rr.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_sched.c        | 3 +--
>  net/netfilter/ipvs/ip_vs_sed.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_sh.c           | 3 +--
>  net/netfilter/ipvs/ip_vs_sync.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_twos.c         | 3 +--
>  net/netfilter/ipvs/ip_vs_wlc.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_wrr.c          | 3 +--
>  net/netfilter/ipvs/ip_vs_xmit.c         | 3 +--
>  net/smc/af_smc.c                        | 3 +--
>  33 files changed, 33 insertions(+), 66 deletions(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index a4f1df92417d..1e62fbc22cb7 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -10,8 +10,7 @@
>   *		Ursula Braun <ursula.braun@de.ibm.com>
>   */
>  
> -#define KMSG_COMPONENT "af_iucv"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "af_iucv: " fmt
>  
>  #include <linux/filter.h>
>  #include <linux/module.h>
> diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> index 008be0abe3a5..da2af413c89d 100644
> --- a/net/iucv/iucv.c
> +++ b/net/iucv/iucv.c
> @@ -20,8 +20,7 @@
>   *    CP Programming Service, IBM document # SC24-5760
>   */
>  
> -#define KMSG_COMPONENT "iucv"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "iucv: " fmt
>  
>  #include <linux/kernel_stat.h>
>  #include <linux/export.h>
> diff --git a/net/netfilter/ipvs/ip_vs_app.c b/net/netfilter/ipvs/ip_vs_app.c
> index fdacbc3c15be..d54d7da58334 100644
> --- a/net/netfilter/ipvs/ip_vs_app.c
> +++ b/net/netfilter/ipvs/ip_vs_app.c
> @@ -13,8 +13,7 @@
>   * Author:	Juan Jose Ciarlante, <jjciarla@raiz.uncu.edu.ar>
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
> index 37ebb0cb62b8..50cc492c7553 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -17,8 +17,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/interrupt.h>
>  #include <linux/in.h>
> diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
> index 5ea7ab8bf4dc..90d56f92c0f6 100644
> --- a/net/netfilter/ipvs/ip_vs_core.c
> +++ b/net/netfilter/ipvs/ip_vs_core.c
> @@ -19,8 +19,7 @@
>   *	Harald Welte			don't use nfcache
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 4c8fa22be88a..068702894377 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -13,8 +13,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/init.h>
> diff --git a/net/netfilter/ipvs/ip_vs_dh.c b/net/netfilter/ipvs/ip_vs_dh.c
> index 75f4c231f4a0..bb7aca4601ff 100644
> --- a/net/netfilter/ipvs/ip_vs_dh.c
> +++ b/net/netfilter/ipvs/ip_vs_dh.c
> @@ -30,8 +30,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
> index 93a925f1ed9b..77f4f637ff67 100644
> --- a/net/netfilter/ipvs/ip_vs_est.c
> +++ b/net/netfilter/ipvs/ip_vs_est.c
> @@ -12,8 +12,7 @@
>   *              get_stats()) do the per cpu summing.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/jiffies.h>
> diff --git a/net/netfilter/ipvs/ip_vs_fo.c b/net/netfilter/ipvs/ip_vs_fo.c
> index ab117e5bc34e..d657b47c6511 100644
> --- a/net/netfilter/ipvs/ip_vs_fo.c
> +++ b/net/netfilter/ipvs/ip_vs_fo.c
> @@ -8,8 +8,7 @@
>   *     Kenny Mathis            :     added initial functionality based on weight
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
> index 206c6700e200..b315c608fda4 100644
> --- a/net/netfilter/ipvs/ip_vs_ftp.c
> +++ b/net/netfilter/ipvs/ip_vs_ftp.c
> @@ -16,8 +16,7 @@
>   * Author:	Wouter Gadeyne
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
> index 156181a3bacd..e6c8ed0c92f6 100644
> --- a/net/netfilter/ipvs/ip_vs_lblc.c
> +++ b/net/netfilter/ipvs/ip_vs_lblc.c
> @@ -34,8 +34,7 @@
>   * me to write this module.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
> index a021e6aba3d7..a25cf7bb6185 100644
> --- a/net/netfilter/ipvs/ip_vs_lblcr.c
> +++ b/net/netfilter/ipvs/ip_vs_lblcr.c
> @@ -32,8 +32,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/module.h>
> diff --git a/net/netfilter/ipvs/ip_vs_lc.c b/net/netfilter/ipvs/ip_vs_lc.c
> index c2764505e380..38cc38c5d8bb 100644
> --- a/net/netfilter/ipvs/ip_vs_lc.c
> +++ b/net/netfilter/ipvs/ip_vs_lc.c
> @@ -9,8 +9,7 @@
>   *     Wensong Zhang            :     added any dest with weight=0 is quiesced
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_mh.c b/net/netfilter/ipvs/ip_vs_mh.c
> index e3d7f5c879ce..f61f54004c9e 100644
> --- a/net/netfilter/ipvs/ip_vs_mh.c
> +++ b/net/netfilter/ipvs/ip_vs_mh.c
> @@ -17,8 +17,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_nfct.c b/net/netfilter/ipvs/ip_vs_nfct.c
> index 08adcb222986..81974f69e5bb 100644
> --- a/net/netfilter/ipvs/ip_vs_nfct.c
> +++ b/net/netfilter/ipvs/ip_vs_nfct.c
> @@ -30,8 +30,7 @@
>   * PASV response can not be NAT-ed) but Active FTP should work
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/types.h>
> diff --git a/net/netfilter/ipvs/ip_vs_nq.c b/net/netfilter/ipvs/ip_vs_nq.c
> index ed7f5c889b41..ada158c610ce 100644
> --- a/net/netfilter/ipvs/ip_vs_nq.c
> +++ b/net/netfilter/ipvs/ip_vs_nq.c
> @@ -26,8 +26,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_ovf.c b/net/netfilter/ipvs/ip_vs_ovf.c
> index c7708b809700..c5c67df80a0b 100644
> --- a/net/netfilter/ipvs/ip_vs_ovf.c
> +++ b/net/netfilter/ipvs/ip_vs_ovf.c
> @@ -12,8 +12,7 @@
>   * active connections
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_pe.c b/net/netfilter/ipvs/ip_vs_pe.c
> index 166c669f0763..3035079ebd99 100644
> --- a/net/netfilter/ipvs/ip_vs_pe.c
> +++ b/net/netfilter/ipvs/ip_vs_pe.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
> diff --git a/net/netfilter/ipvs/ip_vs_pe_sip.c b/net/netfilter/ipvs/ip_vs_pe_sip.c
> index e4ce1d9a63f9..85f31d71e29a 100644
> --- a/net/netfilter/ipvs/ip_vs_pe_sip.c
> +++ b/net/netfilter/ipvs/ip_vs_pe_sip.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto.c b/net/netfilter/ipvs/ip_vs_proto.c
> index a9fd1d3fc2cb..fd9dbca24c85 100644
> --- a/net/netfilter/ipvs/ip_vs_proto.c
> +++ b/net/netfilter/ipvs/ip_vs_proto.c
> @@ -8,8 +8,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto_ah_esp.c b/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
> index 89602c16f6b6..44e14acc187e 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_ah_esp.c
> @@ -6,8 +6,7 @@
>   *		Wensong Zhang <wensong@linuxvirtualserver.org>
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/in.h>
>  #include <linux/ip.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto_tcp.c b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> index 7da51390cea6..f68a1533ee45 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_tcp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_tcp.c
> @@ -13,8 +13,7 @@
>   *              protocol ip_vs_proto_data and is handled by netns
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/ip.h>
> diff --git a/net/netfilter/ipvs/ip_vs_proto_udp.c b/net/netfilter/ipvs/ip_vs_proto_udp.c
> index 68260d91c988..0f0107c80dd2 100644
> --- a/net/netfilter/ipvs/ip_vs_proto_udp.c
> +++ b/net/netfilter/ipvs/ip_vs_proto_udp.c
> @@ -9,8 +9,7 @@
>   *              Network name space (netns) aware.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/in.h>
>  #include <linux/ip.h>
> diff --git a/net/netfilter/ipvs/ip_vs_rr.c b/net/netfilter/ipvs/ip_vs_rr.c
> index 6baa34dff9f0..4125ee561cdc 100644
> --- a/net/netfilter/ipvs/ip_vs_rr.c
> +++ b/net/netfilter/ipvs/ip_vs_rr.c
> @@ -14,8 +14,7 @@
>   *     Wensong Zhang            :     added any dest with weight=0 is quiesced
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sched.c b/net/netfilter/ipvs/ip_vs_sched.c
> index d4903723be7e..c6e421c4e299 100644
> --- a/net/netfilter/ipvs/ip_vs_sched.c
> +++ b/net/netfilter/ipvs/ip_vs_sched.c
> @@ -12,8 +12,7 @@
>   * Changes:
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/spinlock.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sed.c b/net/netfilter/ipvs/ip_vs_sed.c
> index a46f99a56618..245a323c84cd 100644
> --- a/net/netfilter/ipvs/ip_vs_sed.c
> +++ b/net/netfilter/ipvs/ip_vs_sed.c
> @@ -30,8 +30,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sh.c b/net/netfilter/ipvs/ip_vs_sh.c
> index 92e77d7a6b50..0e85e07e23b9 100644
> --- a/net/netfilter/ipvs/ip_vs_sh.c
> +++ b/net/netfilter/ipvs/ip_vs_sh.c
> @@ -32,8 +32,7 @@
>   *
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
> index 5a0c6f42bd8f..54dd1514ac45 100644
> --- a/net/netfilter/ipvs/ip_vs_sync.c
> +++ b/net/netfilter/ipvs/ip_vs_sync.c
> @@ -32,8 +32,7 @@
>   *					Persistence support, fwmark and time-out.
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/slab.h>
> diff --git a/net/netfilter/ipvs/ip_vs_twos.c b/net/netfilter/ipvs/ip_vs_twos.c
> index 8d5419edde50..dbb7f5fd4688 100644
> --- a/net/netfilter/ipvs/ip_vs_twos.c
> +++ b/net/netfilter/ipvs/ip_vs_twos.c
> @@ -4,8 +4,7 @@
>   * Authors:     Darby Payne <darby.payne@applovin.com>
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> diff --git a/net/netfilter/ipvs/ip_vs_wlc.c b/net/netfilter/ipvs/ip_vs_wlc.c
> index 9fa500927c0a..9da445ca09a1 100644
> --- a/net/netfilter/ipvs/ip_vs_wlc.c
> +++ b/net/netfilter/ipvs/ip_vs_wlc.c
> @@ -14,8 +14,7 @@
>   *     Wensong Zhang            :     added any dest with weight=0 is quiesced
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_wrr.c b/net/netfilter/ipvs/ip_vs_wrr.c
> index 85ce0d04afac..99f09cbf2d9b 100644
> --- a/net/netfilter/ipvs/ip_vs_wrr.c
> +++ b/net/netfilter/ipvs/ip_vs_wrr.c
> @@ -13,8 +13,7 @@
>   *                                    with weight 0 when all weights are zero
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
> index 95af252b2939..3162ce3c2640 100644
> --- a/net/netfilter/ipvs/ip_vs_xmit.c
> +++ b/net/netfilter/ipvs/ip_vs_xmit.c
> @@ -21,8 +21,7 @@
>   * - the only place where we can see skb->sk != NULL
>   */
>  
> -#define KMSG_COMPONENT "IPVS"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "IPVS: " fmt
>  
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index e388de8dca09..f97f77b041d9 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -16,8 +16,7 @@
>   *              based on prototype from Frank Blaschka
>   */
>  
> -#define KMSG_COMPONENT "smc"
> -#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
> +#define pr_fmt(fmt) "smc: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/socket.h>
> -- 
> 2.51.0

Regards

--
Julian Anastasov <ja@ssi.bg>


