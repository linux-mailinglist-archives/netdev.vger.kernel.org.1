Return-Path: <netdev+bounces-101856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2A79004B6
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48B828F925
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0F0194AD0;
	Fri,  7 Jun 2024 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDztUcvS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE76C15DBC1;
	Fri,  7 Jun 2024 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766656; cv=none; b=f65E3s9GdLPLYDIydw+eiXPRUQ4/pFXJHpT5FSySjtBouf6Sd05JdxZ9Hkzfh9JJYElw25vbPGFeLOiJ1oODgQXbnRb4JpMZOiBhbOLNtcWL2vraU//JCAdGhUXBWUVDGYVxRdLSgEg/bdBNeObJEMiB4wIiVqQVTACLcOX9Pgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766656; c=relaxed/simple;
	bh=wVF9xY3bR+1qDUnVkTJXj/DMwKOX5LwldEXjp0TYtDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwF05p6O6cXdC4Q+fQmbfJJHNVnaESXBTMp1jGbxkKF92Fh8FFnn1wQileXXlPSpBdZHh+DWenfOFBaE2ES/VrGieF0FNxkCpg/bHuk7uU8GFGsgM6l1dPcmrPQATUQuQyNwszQm7k0e0fkKRi+hsF0zFGrBBeibA8aLzyC1djc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDztUcvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADDBC2BBFC;
	Fri,  7 Jun 2024 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717766655;
	bh=wVF9xY3bR+1qDUnVkTJXj/DMwKOX5LwldEXjp0TYtDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDztUcvSqeBno6dD439/MkH/PgooBhSCcTZVjiYHpsFpWmfNeoX2scsNssDX6HIkG
	 l2jMRQPa1pF3q7LZR+x7IzKWkHX8xcAyATahzkvIpG6yu+9K7x1hyBSV0PsOyQP0q2
	 UB9R008nUoymwDMzHbO81sqMz4Yyge07nFWVSrsjqZ0dycGf3lcMCweZIzzcf+WnHr
	 9s7rmcuZTGAJ5fgIcekeRw4RGq/Iiyba5tczELg4rQxmMd3F6GpFeLp140ZD7M1fTj
	 OLuE+ny06naCEXdldvseigo3p5l8be7lINsbl/n7wUVf18vNcULlYs3LvTOwMOcpAA
	 MrIoJktBF7/Gw==
Date: Fri, 7 Jun 2024 14:24:10 +0100
From: Simon Horman <horms@kernel.org>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v3] landlock: Add abstract unix socket connect restriction
Message-ID: <20240607132410.GC27689@kernel.org>
References: <ZmE8u1LV6aOWV9tB@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmE8u1LV6aOWV9tB@tahera-OptiPlex-5000>

On Wed, Jun 05, 2024 at 10:36:11PM -0600, Tahera Fahimi wrote:
> Abstract unix sockets are used for local inter-process communications
> without on a filesystem. Currently a sandboxed process can connect to a
> socket outside of the sandboxed environment, since landlock has no
> restriction for connecting to a unix socket in the abstract namespace.
> Access to such sockets for a sandboxed process should be scoped the same
> way ptrace is limited.
> 
> Because of compatibility reasons and since landlock should be flexible,
> we extend the user space interface by adding a new "scoped" field. This
> field optionally contains a "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET" to
> specify that the ruleset will deny any connection from within the
> sandbox to its parents(i.e. any parent sandbox or non-sandbox processes)
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>

...

> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 68625e728f43..1641aeb9eeaa 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -37,6 +37,12 @@ struct landlock_ruleset_attr {
>  	 * rule explicitly allow them.
>  	 */
>  	__u64 handled_access_net;
> +	/**
> +	 * scoped: Bitmask of actions (cf. `Scope access flags`_)

nit: s/scoped: /@scoped: / 

     Flagged by ./scripts/kernel-doc -none

> +	 * that is handled by this ruleset and should be permitted
> +	 * by default if no rule explicitly deny them.
> +	 */
> +	__u64 scoped;
>  };
>  
>  /*

...

