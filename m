Return-Path: <netdev+bounces-31877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9467910D1
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 07:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E528280F6A
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 05:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6765D;
	Mon,  4 Sep 2023 05:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490417FD
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 05:22:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04AB10E
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 22:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693804945; x=1725340945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2LYRZYJk/kOwMbdxoaax5tvWdPXR5387kO5X6wClVyk=;
  b=PeFIZTXF5Uvj2RiaXfRAGKJbBwx6GNozzW8f4Z1dBsHw5eoRj/FW32TF
   77+Zg8NhOEBCfGB5o56gv7jVVSayP0JANPbq8uuLSYJW4/uqU56+ZZmkF
   OgDv5k/pfWcsz8wj5zgASruslYtKF1+AXaBG/RHBR1wBgYwYGjJtPmjZN
   ArA+RGn47yK18MdWBJsXLvjFPlqfR/O9SKyzAwHsuKK8bUOBnepKEDfzL
   ExuYD0OA7Zho0ZakgJlCUp2qZS/8asKNN87mSNK+xSCfGQL2QEeYV7I0V
   4vtLkKZJqj2WTMvBf+U10NdjW3SQB/TnqbEA7LIJatxyEjw79W3ghai3I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380312114"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="380312114"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 22:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="987371988"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="987371988"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 22:22:21 -0700
Date: Mon, 4 Sep 2023 07:22:12 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v2 net] af_unix: Fix msg_controllen test in
 scm_pidfd_recv() for MSG_CMSG_COMPAT.
Message-ID: <ZPVphESLDd0NVfxa@localhost.localdomain>
References: <20230901234604.85191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901234604.85191-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 04:46:04PM -0700, Kuniyuki Iwashima wrote:
> Heiko Carstens reported that SCM_PIDFD does not work with MSG_CMSG_COMPAT
> because scm_pidfd_recv() always checks msg_controllen against sizeof(struct
> cmsghdr).
> 
> We need to use sizeof(struct compat_cmsghdr) for the compat case.
> 
> Fixes: 5e2ff6704a27 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/20230901200517.8742-A-hca@linux.ibm.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Tested-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
> v2:
>   * Correct `len` in compat/non-compat case
> 
> v1: https://lore.kernel.org/netdev/20230901222033.71400-1-kuniyu@amazon.com/T/#u
> ---
>  include/net/scm.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/scm.h b/include/net/scm.h
> index c5bcdf65f55c..e8c76b4be2fe 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -9,6 +9,7 @@
>  #include <linux/pid.h>
>  #include <linux/nsproxy.h>
>  #include <linux/sched/signal.h>
> +#include <net/compat.h>
>  
>  /* Well, we should have at least one descriptor open
>   * to accept passed FDs 8)
> @@ -123,14 +124,17 @@ static inline bool scm_has_secdata(struct socket *sock)
>  static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
>  {
>  	struct file *pidfd_file = NULL;
> -	int pidfd;
> +	int len, pidfd;
>  
> -	/*
> -	 * put_cmsg() doesn't return an error if CMSG is truncated,
> +	/* put_cmsg() doesn't return an error if CMSG is truncated,
>  	 * that's why we need to opencode these checks here.
>  	 */
> -	if ((msg->msg_controllen <= sizeof(struct cmsghdr)) ||
> -	    (msg->msg_controllen - sizeof(struct cmsghdr)) < sizeof(int)) {
> +	if (msg->msg_flags & MSG_CMSG_COMPAT)
> +		len = sizeof(struct compat_cmsghdr) + sizeof(int);
> +	else
> +		len = sizeof(struct cmsghdr) + sizeof(int);
> +
> +	if (msg->msg_controllen < len) {
>  		msg->msg_flags |= MSG_CTRUNC;
>  		return;
>  	}

Seems fine, you can point out in commit message that you are merging
both conditions into one (size comparation and this sizeof(int))

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks
> -- 
> 2.30.2

