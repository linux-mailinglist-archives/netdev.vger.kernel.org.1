Return-Path: <netdev+bounces-112490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B1B9397CA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 03:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B59A1B21C53
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B9713213E;
	Tue, 23 Jul 2024 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEOs3Vha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F16F1311A3;
	Tue, 23 Jul 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697229; cv=none; b=tlIqn64VLQvBWgUuGLC0Y7XJ6W5h9LXVCwb6147FnlA0rEowPJBBO23MzVj91hdjVMcDawe7apjYPaLoja+7Sb//xT2vxwpNWVOWUjsu6d6pYZ+mT3eoRpG9qE7LF7vno+Vh//kj0P24pEXrMjftDXQe7Qi3Gjf+NWa1fPC8E7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697229; c=relaxed/simple;
	bh=xtWbZQ8b6f20b6fnqMWyqnFt+E/j4EHaLIGmaNiZX/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEUyFQSiocV58Lcs+t4+vNJmVkWIjo00FWYVcvYpOjXQZpNdYnB6bNyLTuIcLtXmRfZVuDaSNW5AqDMdkTW11JcBoOfNEKKkTtuSRBg0Pau1ifE/ZN55h6w1FLvzuqgePfqwQnXlUn3QUP8Cid3y2pNR70IoBqE0h3Wf5F8joXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEOs3Vha; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd78c165eeso20874535ad.2;
        Mon, 22 Jul 2024 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721697227; x=1722302027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/AKY3nAMwS+b4aSLVBXV1XRPEZHBZfsLIQOfnP+g8jk=;
        b=WEOs3Vha/C7I8C2yO4R7Lpssd1sKSW+HNfmlopMyAJATcguuC3oRR0xev7IywzqqCD
         jdZRugsw48hZhAqhcx3QOwbyl2lcjUR9nHa+VddrRUks/jp93e3hzbOxaJ71xFSRS2M+
         EXgJeS3x3Jz7QRxu8L6RmoPycRvIdorHnq+JgFOz2N+5UYoBySJFo+xKEE0tHCt7cCv6
         L0oO35d5p0F/aMx84Ug/I5xQ8FBOwMaeaVZuoqxs6Vzm5wYq8V3am0R7UMQ5T0m8OnJF
         vV7mKUxO1LNsxbV3qjn8Qs0TUNQbV2sCbiPAgGgic6RtGEPHHAxE21Nh0mljw3SFt4G6
         xeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721697227; x=1722302027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AKY3nAMwS+b4aSLVBXV1XRPEZHBZfsLIQOfnP+g8jk=;
        b=Ti0F1Ra4eeffDz0o16Z1ZuSfRjxrbZ8Ozh2CqmFyXCOCqr995tnmtzhHcBZzyDD9ZK
         pRE1ZwYDSEyOcTYAnLwa9HCp2fWFgpWpNl+bjC9HV4q0RRDBAvVsTlNyfTDcsVpCS17M
         ShH7Zucal/d8qy6x3za7CHBPHa3Nc5LdDUqBytiAMlyQaB1/6y0dt+DOe4Gc1paQT4cc
         y6TtKEm3n3ag3txcrRQuKHoTot0nA8OEXoSprgzgnmuX7OoD5Zb24FnGvWJV31jBoOoC
         yOeuok+GJs7IPzvGc5mHDf8a3x2YRxYlTtdRioEckgsKd3JJKCCZzFUndUB4govfQrBf
         uWQA==
X-Forwarded-Encrypted: i=1; AJvYcCXMe3A1q8SPGUGsxNd/GQvehOio++w3WjiVkQC6z+Qm3yRqEp/zwnn0MV+C1eYqSRjThbWk12MbA3lXPbMvcF+OqRyfO2OSgRKqX5lhCgN/gFNrR+ZGXEoNKstdsVyY0H7viVJbpfSeB15ZboA4Lhe3ZhP0ZJD+WMAiGf2PTvdS09uSbUYVl6WsyqyD
X-Gm-Message-State: AOJu0Yy10jawElkbIe7ZzN3YElzT5xKm/OhXGJ+ESibC1fW4W6kRqJus
	PJnjEwPrz2wVCuQbyjry3I4fpmXLzJFxKFQeZVlLRyWE6omLlKHo
X-Google-Smtp-Source: AGHT+IEIKtL1NeEYxCc+rvXe9hKQP3R/Ez+CkYyJHQqDKWPbSxOsjNTjA/iCsB20kUdupc8N9u0XLQ==
X-Received: by 2002:a17:902:dad1:b0:1fd:6c5b:afd4 with SMTP id d9443c01a7336-1fd74654427mr82054285ad.64.1721697227109;
        Mon, 22 Jul 2024 18:13:47 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f259f83sm61699915ad.58.2024.07.22.18.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 18:13:46 -0700 (PDT)
Date: Mon, 22 Jul 2024 19:13:44 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com,
	jannh@google.com, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <Zp8DyAUZaNKgancC@tahera-OptiPlex-5000>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
 <20240719.AepeeXeib7sh@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240719.AepeeXeib7sh@digikod.net>

On Fri, Jul 19, 2024 at 08:14:02PM +0200, Mickaël Salaün wrote:
> On Wed, Jul 17, 2024 at 10:15:19PM -0600, Tahera Fahimi wrote:
> > The patch introduces a new "scoped" attribute to the
> > landlock_ruleset_attr that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET"
> > to scope abstract unix sockets from connecting to a process outside of
> > the same landlock domain.
> > 
> > This patch implement two hooks, "unix_stream_connect" and "unix_may_send" to
> > enforce this restriction.
> > 
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> > 
> > -------
Hello Mickaël, 
Thanks for the feedback.
> Only "---"
> 
> > v7:
> 
> Thanks for the detailed changelog, it helps!
> 
> >  - Using socket's file credentials for both connected(STREAM) and
> >    non-connected(DGRAM) sockets.
> >  - Adding "domain_sock_scope" instead of the domain scoping mechanism used in
> >    ptrace ensures that if a server's domain is accessible from the client's
> >    domain (where the client is more privileged than the server), the client
> >    can connect to the server in all edge cases.
> >  - Removing debug codes.
> > v6:
> >  - Removing curr_ruleset from landlock_hierarchy, and switching back to use
> >    the same domain scoping as ptrace.
> >  - code clean up.
> > v5:
> >  - Renaming "LANDLOCK_*_ACCESS_SCOPE" to "LANDLOCK_*_SCOPE"
> >  - Adding curr_ruleset to hierarachy_ruleset structure to have access from
> >    landlock_hierarchy to its respective landlock_ruleset.
> >  - Using curr_ruleset to check if a domain is scoped while walking in the
> >    hierarchy of domains.
> >  - Modifying inline comments.
> > V4:
> >  - Rebased on Günther's Patch:
> >    https://lore.kernel.org/all/20240610082115.1693267-1-gnoack@google.com/
> >    so there is no need for "LANDLOCK_SHIFT_ACCESS_SCOPE", then it is removed.
> >  - Adding get_scope_accesses function to check all scoped access masks in a ruleset.
> >  - Using file's FD credentials instead of credentials stored in peer_cred
> >    for datagram sockets. (see discussion in [1])
> >  - Modifying inline comments.
> > V3:
> >  - Improving commit description.
> >  - Introducing "scoped" attribute to landlock_ruleset_attr for IPC scoping
> >    purpose, and adding related functions.
> >  - Changing structure of ruleset based on "scoped".
> >  - Removing rcu lock and using unix_sk lock instead.
> >  - Introducing scoping for datagram sockets in unix_may_send.
> > V2:
> >  - Removing wrapper functions
> > 
> > [1]https://lore.kernel.org/outreachy/Zmi8Ydz4Z6tYtpY1@tahera-OptiPlex-5000/T/#m8cdf33180d86c7ec22932e2eb4ef7dd4fc94c792
> 
> 
> > -------
> > 
> > Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> No need for this hunk.
> 
> 
> > ---
> >  include/uapi/linux/landlock.h |  29 +++++++++
> >  security/landlock/limits.h    |   3 +
> >  security/landlock/ruleset.c   |   7 ++-
> >  security/landlock/ruleset.h   |  23 ++++++-
> >  security/landlock/syscalls.c  |  14 +++--
> >  security/landlock/task.c      | 112 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 181 insertions(+), 7 deletions(-)
> 
> > diff --git a/security/landlock/task.c b/security/landlock/task.c
> > index 849f5123610b..597d89e54aae 100644
> > --- a/security/landlock/task.c
> > +++ b/security/landlock/task.c
> > @@ -13,6 +13,8 @@
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/sched.h>
> > +#include <net/sock.h>
> > +#include <net/af_unix.h>
> >  
> >  #include "common.h"
> >  #include "cred.h"
> > @@ -108,9 +110,119 @@ static int hook_ptrace_traceme(struct task_struct *const parent)
> >  	return task_ptrace(parent, current);
> >  }
> >  
> > +static int walk_and_check(const struct landlock_ruleset *const child,
> > +			  struct landlock_hierarchy **walker, int i, int j,
> 
> We don't know what are "i" and "j" are while reading this function's
> signature.  They need a better name.
> 
> Also, they are ingegers (signed), whereas l1 and l2 are size_t (unsigned).
> 
> > +			  bool check)
> > +{
> > +	if (!child || i < 0)
> > +		return -1;
> > +
> > +	while (i < j && *walker) {
> 
> This would be more readable with a for() loop.
> 
> > +		if (check && landlock_get_scope_mask(child, j))
> 
> This is correct now but it will be a bug when we'll have other scope.
> Instead, you can replace the "check" boolean with a variable containing
> LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET.
> 
> > +			return -1;
> > +		*walker = (*walker)->parent;
> > +		j--;
> > +	}
> > +	if (!*walker)
> > +		pr_warn_once("inconsistency in landlock hierarchy and layers");
> 
> This must indeed never happen, but WARN_ON_ONCE(!*walker) would be
> better than this check+pr_warn.
> 
> Anyway, if this happen this pointer will still be dereferenced in
> domain_sock_scope() right?  This must not be possible.
> 
> 
> > +	return j;
> 
> Because j is now equal to i, no need to return it.  This function can
> return a boolean instead, or a struct landlock_ruleset pointer/NULL to
> avoid the pointer of pointer?
corret, in the next version, this function will return a boolean that
shows chcking the hierarchy of domain is successful or not. 

> > +}
> > +
> > +/**
> > + * domain_sock_scope - Checks if client domain is scoped in the same
> > + *			domain as server.
> > + *
> > + * @client: Connecting socket domain.
> > + * @server: Listening socket domain.
> > + *
> > + * Checks if the @client domain is scoped, then the server should be
> > + * in the same domain to connect. If not, @client can connect to @server.
> > + */
> > +static bool domain_sock_scope(const struct landlock_ruleset *const client,
> 
> This function can have a more generic name if
> LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET is passed as argument.  This could
> be reused as-is for other kind of scope.
> 
> > +			      const struct landlock_ruleset *const server)
> > +{
> > +	size_t l1, l2;
> > +	int scope_layer;
> > +	struct landlock_hierarchy *cli_walker, *srv_walker;
> 
> We have some room for a bit more characters ;)
> client_walker, server_walker;
> 
> > +
> > +	if (!client)
> > +		return true;
> > +
> > +	l1 = client->num_layers - 1;
> 
> Please rename variables in a consistent way, in this case something like
> client_layer?
done 
> > +	cli_walker = client->hierarchy;
> > +	if (server) {
> > +		l2 = server->num_layers - 1;
> > +		srv_walker = server->hierarchy;
> > +	} else
> > +		l2 = 0;
> > +
> > +	if (l1 > l2)
> > +		scope_layer = walk_and_check(client, &cli_walker, l2, l1, true);
> 
> Instead of mixing the layer number with an error code, walk_and_check()
> can return a boolean, take as argument &scope_layer, and update it.
> 
> > +	else if (l2 > l1)
> > +		scope_layer =
> > +			walk_and_check(server, &srv_walker, l1, l2, false);
> > +	else
> > +		scope_layer = l1;
> > +
> > +	if (scope_layer == -1)
> > +		return false;
> 
> All these domains and layers checks are difficult to review. It needs at
> least some comments, and preferably also some code refactoring to avoid
> potential inconsistencies (checks).
> 
> > +
> > +	while (scope_layer >= 0 && cli_walker) {
> 
> Why srv_walker is not checked?  Could this happen?  What would be the
> result?
This is the same scenario as "walk_and_check". If the loop breaks
because of cli_walker is null, then there is an inconsistency between
num_layers and landlock_hierarchy. In normal scenario, we expect the
loop breaks with condition(scope_layer>=0).

> Please also use a for() loop here.
> 
> > +		if (landlock_get_scope_mask(client, scope_layer) &
> > +		    LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET) {
> 
> The logic needs to be explained.
> 
> > +			if (!server)
> > +				return false;
> > +
> > +			if (srv_walker == cli_walker)
> > +				return true;
> > +
> > +			return false;
> > +		}
> > +		cli_walker = cli_walker->parent;
> > +		srv_walker = srv_walker->parent;
> > +		scope_layer--;
> > +	}
> > +	return true;
> > +}
> > +
> > +static bool sock_is_scoped(struct sock *const other)
> > +{
> > +	const struct landlock_ruleset *dom_other;
> > +	const struct landlock_ruleset *const dom =
> > +		landlock_get_current_domain();
> > +
> > +	/* the credentials will not change */
> > +	lockdep_assert_held(&unix_sk(other)->lock);
> > +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > +
> > +	/* other is scoped, they connect if they are in the same domain */
> > +	return domain_sock_scope(dom, dom_other);
> > +}
> > +
> > +static int hook_unix_stream_connect(struct sock *const sock,
> > +				    struct sock *const other,
> > +				    struct sock *const newsk)
> > +{
> > +	if (sock_is_scoped(other))
> > +		return 0;
> > +
> > +	return -EPERM;
> > +}
> > +
> > +static int hook_unix_may_send(struct socket *const sock,
> > +			      struct socket *const other)
> > +{
> > +	if (sock_is_scoped(other->sk))
> > +		return 0;
> > +
> > +	return -EPERM;
> > +}
> > +
> >  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> >  	LSM_HOOK_INIT(ptrace_access_check, hook_ptrace_access_check),
> >  	LSM_HOOK_INIT(ptrace_traceme, hook_ptrace_traceme),
> > +	LSM_HOOK_INIT(unix_stream_connect, hook_unix_stream_connect),
> > +	LSM_HOOK_INIT(unix_may_send, hook_unix_may_send),
> >  };
> >  
> >  __init void landlock_add_task_hooks(void)
> > -- 
> > 2.34.1
> > 
> > 

