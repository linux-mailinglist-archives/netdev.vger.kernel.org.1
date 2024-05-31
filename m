Return-Path: <netdev+bounces-99699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 148448D5EB9
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901F01F23474
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9B1422CF;
	Fri, 31 May 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XixqvIIV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D61422A2
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148746; cv=none; b=d5L4JljhWVX8eEyjvDrdjxanPb0muKJzXqXPAZXdc1zrRXon3yByOra5wl26sMQsLKaWxcUKIsPF1ys6DxnUDZzIaSet71DPuNuOo9Eq3pJJ58GEcaBLBMel5W5V3GAz6VApU/Yjo35C61RSOb+tzh3WW4IkWPrlFhBfAnkHhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148746; c=relaxed/simple;
	bh=/fNJjki3s+FiaWJi/pZfpB/oREdyo+P3mnzggQXSVFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXBVLS9uxt7/Arxf/LSwXr9PqwcLtSRvj7M0dXm2gY/J+x6E6KvOnYbSuviblAttLKtuLiPq5dSRyt2WfxV7dWWYwmFOvh1lHbm9VWd1U5xHs+03BmpPD7gVLpNx8bhcFUW2Lc6ksaYiY2r12z2DN8TOrpekL9MzTdEuDQJ7KRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XixqvIIV; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VrJ3l5mjBzR2;
	Fri, 31 May 2024 11:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1717148355;
	bh=PTdHv7fGQLwj9u1hLPUCBVWvG4NslAaAcaO2qrWkcQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XixqvIIVm/qoziDyjt+S7HOGZId9u2DzV2KjsxtPTjOy6QIx/+zd3xRNHQP7eVy8r
	 mfHLFGk0RtA6q5icg6c5+TLSgd/513l0BN1RlNVbg0e3m34uwxc+HOB+wJgC70KSr3
	 R8zPZ7hcAWFubneduokr8003QwG+fO2HwWvKxhCA=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VrJ3k0hfGzZk3;
	Fri, 31 May 2024 11:39:14 +0200 (CEST)
Date: Fri, 31 May 2024 11:39:12 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E.Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev, netdev@vger.kernel.org, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Jann Horn <jannh@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v2] landlock: Add abstract unix socket connect
 restrictions
Message-ID: <20240531.Ahg5aap6caeG@digikod.net>
References: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
 <20240401.ieC2uqua5sha@digikod.net>
 <ZhcRnhVKFUgCleDi@tahera-OptiPlex-5000>
 <20240411.ahgeefeiNg4i@digikod.net>
 <ZlkIAIpWG/l64Pl9@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlkIAIpWG/l64Pl9@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

On Thu, May 30, 2024 at 05:13:04PM -0600, Tahera Fahimi wrote:
> On Tue, Apr 30, 2024 at 05:24:45PM +0200, Mickaël Salaün wrote:
> > On Wed, Apr 10, 2024 at 04:24:30PM -0600, Tahera Fahimi wrote:
> > > On Tue, Apr 02, 2024 at 11:53:09AM +0200, Mickaël Salaün wrote:
> > > > Thanks for this patch.  Please CC the netdev mailing list too, they may
> > > > be interested by this feature. I also added a few folks that previously
> > > > showed their interest for this feature.
> > > > 
> > > > On Thu, Mar 28, 2024 at 05:12:13PM -0600, TaheraFahimi wrote:
> > > > > Abstract unix sockets are used for local interprocess communication without
> > > > > relying on filesystem. Since landlock has no restriction for connecting to
> > > > > a UNIX socket in the abstract namespace, a sandboxed process can connect to
> > > > > a socket outside the sandboxed environment. Access to such sockets should
> > > > > be scoped the same way ptrace access is limited.
> > > > 
> > > > This is good but it would be better to explain that Landlock doesn't
> > > > currently control abstract unix sockets and that it would make sense for
> > > > a sandbox.
> > > > 
> > > > 
> > > > > 
> > > > > For a landlocked process to be allowed to connect to a target process, it
> > > > > must have a subset of the target process’s rules (the connecting socket
> > > > > must be in a sub-domain of the listening socket). This patch adds a new
> > > > > LSM hook for connect function in unix socket with the related access rights.
> > > > 
> > > > Because of compatibility reasons, and because Landlock should be
> > > > flexible, we need to extend the user space interface.  As explained in
> > > > the GitHub issue, we need to add a new "scoped" field to the
> > > > landlock_ruleset_attr struct. This field will optionally contain a
> > > > LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET flag to specify that this
> > > > ruleset will deny any connection from within the sandbox to its parents
> > > > (i.e. any parent sandbox or not-sandboxed processes).
> > 
> > > Thanks for the feedback. Here is what I understood, please correct me if
> > > I am wrong. First, I should add another field to the
> > > landlock_ruleset_attr (a field like handled_access_net, but for the unix
> > > sockets) with a flag LANDLOCK_ACCESS_UNIX_CONNECT (it is a flag like
> > > LANDLOCK_ACCESS_NET_CONNECT_TCP but fot the unix sockets connect).
> > 
> > That was the initial idea, but after thinking more about it and talking
> > with some users, I now think we can get a more generic interface.
> > 
> > Because unix sockets, signals, and other IPCs are fully controlled by
> > the kernel (contrary to inet sockets that get out of the system), we can
> > add ingress and egress control according to the source and the
> > destination.
> > 
> > To control the direction we could add an
> > LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE and a
> > LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND rights (these names are a bit
> > long but at least explicit).  To control the source and destination, it
> > makes sense to use Landlock domain (i.e. sandboxes):
> > LANDLOCK_DOMAIN_HIERARCHY_PARENT, LANDLOCK_DOMAIN_HIERARCHY_SELF, and
> > LANDLOCK_DOMAIN_HIERARCHY_CHILD.  This could be used by extending the
> > landlock_ruleset_attr type and adding a new
> > landlock_domain_hierarchy_attr type:
> > 
> > struct landlock_ruleset_attr ruleset_attr = {
> >   .handled_access_dom = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
> >                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> > }
> > 
> > // Allows sending data to and receiving data from processes in the same
> > // domain or a child domain, through abstract unix sockets.
> > struct landlock_domain_hierarchy_attr dom_attr = {
> >   .allowed_access = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
> >                     LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> >   .relationship = LANDLOCK_DOMAIN_HIERARCHY_SELF | \
> >                   LANDLOCK_DOMAIN_HIERARCHY_CHILD,
> > };
> > 
> > It should also work with other kind of IPCs:
> > * LANDLOCK_ACCESS_DOM_UNIX_PATHNAME_RECEIVE/SEND (signal)
> > * LANDLOCK_ACCESS_DOM_SIGNAL_RECEIVE/SEND (signal)
> > * LANDLOCK_ACCESS_DOM_XSI_RECEIVE/SEND (XSI message queue)
> > * LANDLOCK_ACCESS_DOM_MQ_RECEIVE/SEND (POSIX message queue)
> > * LANDLOCK_ACCESS_DOM_PTRACE_RECEIVE/SEND (ptrace, which would be
> >   limited)
> > 
> > What do you think?
> 
> I was wondering if you expand your idea on the following example. 
> 
> Considering P1 with the rights that you mentioned in your email, forks a
> new process (P2). Now both P1 and P2 are on the same domain and are
> allowed to send data to and receive data from processes in the same
> domain or a child domain. 
> /*
>  *         Same domain (inherited)
>  * .-------------.
>  * | P1----.     |      P1 -> P2 : allow
>  * |        \    |      P2 -> P1 : allow
>  * |         '   |
>  * |         P2  |
>  * '-------------'
>  */
> (P1 domain) = (P2 domain) = {
> 		.allowed_access =
> 			LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | 
> 			LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> 		.relationship = 
> 			LANDLOCK_DOMAIN_HIERARCHY_SELF | 
> 			LANDLOCK_DOMAIN_HIERARCHY_CHILD,

In this case LANDLOCK_DOMAIN_HIERARCHY_CHILD would not be required
because P1 and P2 are on the same domain.

> 		}
> 
> In another example, if P1 has the same domain as before but P2 has
> LANDLOCK_DOMAIN_HIERARCHY_PARENT in their domain, so P1 still can 
> connect to P2. 
> /*
>  *        Parent domain
>  * .------.
>  * |  P1  --.           P1 -> P2 : allow
>  * '------'  \          P2 -> P1 : allow
>  *            '
>  *            P2
>  */
> 
> (P1 domain) = {
>                 .allowed_access =
>                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE |
>                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
>                 .relationship = 
>                         LANDLOCK_DOMAIN_HIERARCHY_SELF |
>                         LANDLOCK_DOMAIN_HIERARCHY_CHILD,

Hmm, in this case P2 doesn't have a domain, so
LANDLOCK_DOMAIN_HIERARCHY_CHILD doesn't make sense.

>                 }
> (P2 domain) = {
>                 .allowed_access =
>                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE |
>                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
>                 .relationship = 
>                         LANDLOCK_DOMAIN_HIERARCHY_SELF |
>                         LANDLOCK_DOMAIN_HIERARCHY_CHILD |
> 			LANDLOCK_DOMAIN_HIERARCHY_PARENT,
> 		}

I think you wanted to use the "Inherited + child domain" example here,
in which case the domain policies make sense.

I was maybe too enthusiastic with the "relationship" field.  Let's
rename landlock_domain_hierarchy_attr to landlock_domain_attr and remove
the "relationship" field.  We'll always consider that
LANDLOCK_DOMAIN_HIERARCHY_SELF is set as well as
LANDLOCK_DOMAIN_HIERARCHY_CHILD (i.e. no restriction to send/received
to/from a child domain or our own domain).  In a nutshell, please only
keep the LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_{RECEIVE,SEND} rights and
follow the same logic as with ptrace restrictions.  It will be easier to
reason about and will be useful for most cases.  We could later extend
that with more features.

LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE will then translates to "allow
to receive from the parent domain".
LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND will then translates to "allow to
send to the parent domain".

As for other Landlock access rights, the restrictions of domains should
only be changed if LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_* is "handled" by
the ruleset/domain.

