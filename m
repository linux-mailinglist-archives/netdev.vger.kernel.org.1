Return-Path: <netdev+bounces-38018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0977B8624
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 22C08B20806
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AABE1CA95;
	Wed,  4 Oct 2023 17:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7551C2BF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 17:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE56C433C8;
	Wed,  4 Oct 2023 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696439396;
	bh=EejapxRAgzw+TAYKfTQScOAAgVEo1P7QSBw6SBgbl0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ien6Kfh8QrpLdbtZd/84HBk4hJcAVbWO4B9tT1IHnB8HiSZkRqG/4G4HyPjC+V6nC
	 r2rrjQbcNaNRW/luHjanjXTAjjDFM9ssYAbsV1W/a+fxikguz9MPnUYz/MwV5742Zc
	 PMXucSW8D5dB4yYFEY43ytaZi0JF8W1QQ5QXpnlLhiESD08WKWsQJ7h5zzI1KVDjSE
	 NtXxCDaNJ1+SmPq20YwQwUNirS8n2zGrM8jpBzTAdmyva/adGSSd1JdGCfjLciIIng
	 TXaLjK9MksYoYdUytDhL5UKMmjeOW7OXGFEW1uDoG5tF7rt8Y6gecyxtyzVcdmDx4/
	 pCBe691JRHiBg==
Date: Wed, 4 Oct 2023 10:09:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
 jlayton@kernel.org, neilb@suse.de, chuck.lever@oracle.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3] NFSD: convert write_threads, write_maxblksize and
 write_maxconn to netlink commands
Message-ID: <20231004100955.32417c33@kernel.org>
In-Reply-To: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
References: <27646a34a3ddac3e0b0ad9b49aaf66b3cee5844f.1695766257.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 00:13:15 +0200 Lorenzo Bianconi wrote:
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	u32 nthreads;
> +	int ret;
> +
> +	if (!info->attrs[NFSD_A_CONTROL_PLANE_THREADS])
> +		return -EINVAL;

Consider using GENL_REQ_ATTR_CHECK(), it will auto-add nice error
message to the reply on error.

> +	nthreads = nla_get_u32(info->attrs[NFSD_A_CONTROL_PLANE_THREADS]);
> +
> +	ret = nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> +	return ret == nthreads ? 0 : ret;
> +}
> +
> +static int nfsd_nl_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
> +			    int cmd, int attr, u32 val)

YNL will dutifully return a list for every dump. If you're only getting
a single reply 'do' will be much better.

