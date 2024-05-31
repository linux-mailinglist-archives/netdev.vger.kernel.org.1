Return-Path: <netdev+bounces-99837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8E78D6A47
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 22:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218DB1F2AF89
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646CF17B51D;
	Fri, 31 May 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkTRkpqY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03DEAE7;
	Fri, 31 May 2024 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185890; cv=none; b=EYc8GbrK738VJ1DTItrT7EXVv9vY5Llddr77xBnIg6rJgg9WFDVi8ITYkyD3htQH4MSQqWxkgI3NA2ujjJ9vaKnbOufbz/BX0zARfS+J0KRkjU37lUOouFGHYluUGAT9ElHaWpiwzFibDwdnHLAXu83Gz1Zl02UOr7GyykpxVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185890; c=relaxed/simple;
	bh=GCXeSlPBSz9f+Fmf6JZAEn9fxkAD47NmqX2HVIhOo8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsBJQlFOZSzb/de/zzTy7FKy6KrbwRXUS9j9xxzzpS3NlChesucYk4i7CcEEBznD35gxV19tHnHYiJe1D+i3ERw9OG3iVQKM6b23QleicCtimstOOBkT7heDyGpD863YK2KCgOAbCRSOyd5uL6BAdqM4v21u4gECqiMnvrs1PI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkTRkpqY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4a52b9413so20363975ad.2;
        Fri, 31 May 2024 13:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717185888; x=1717790688; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qkl854xbR87XQad2EmWVc2cBMlNnfzqpxOQ9r8FlVSU=;
        b=JkTRkpqYDd9GwPG/CWc4Aio7f0PQWw8Zl5MAQQLwbfn5UB2v368e4MRodIxFScTqPq
         tn4oBwun5vNwS+qyAT81mnYOcM14Rom9UwghD0DNRGZ0zxtiDu9C9dczAPqCKQtrFpNz
         0SDjt6Z4UAhQFLd1mxo6knsIRJKnuc86XKnKPEVLn+fcvEz9WAezpfiWbWsX9OzzE1mG
         Qzwl5eUjzPdA2IGu21qy52tIcuN2QCwqlEplMtZeUX1OQ7VbjRa7+mn0OpAHbXZMdNYN
         z0gFUvzurCGFRDeo6WisN7Fga4lmX3bchKNCRRYqBBiBeHCAyl5PtlXuS1z8yIWwlm7Y
         ov/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717185888; x=1717790688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkl854xbR87XQad2EmWVc2cBMlNnfzqpxOQ9r8FlVSU=;
        b=gwUehA4E0INDC/EPiduwR199tu4K+hVtAt6QKZ2mVG9YbWw98tL4GsLobc7ycg397/
         LKueqGoWDCGRnZmgURkZ8iADCSsJUXiwz/a4BU8fYecngOzmkjG/Q1f3fBffkxtzLc+W
         sJ0kj9t+htDmkAtRTUT0TkdK7CaVoJBtnOtG8F0L1GyMC48QlrhpA8kgLKNa66VvoqIz
         5LmlNnAfXC1EIGt2OExyhH37M4RH/9Y2E3KsTxXFbO29qDx0rJ8OzKesyrDyp/dDklFs
         59/pgxktzJMbsYXjq/NnGJ5hz6frFgYS4OzjygNGmHhKgwY2eitcjL6aemJ28iTGHGGc
         x/bA==
X-Forwarded-Encrypted: i=1; AJvYcCWQZnXJhEHWPdqBYpyjwB0OEW8qcG3PGCac1hx70DHdAOWgHImRNta858twUJEjAJKlps1/VjykivZm+ti1ECJvYQDV2NBpLN81UMrJcpp/MKz7L4eNxEOCLcKtZe5/pUq3+YRuZtaHTqS4bh6XTvBxQiqwl8+U3c/XXm/qZC9lGTxWeAZBR0WcdtAx
X-Gm-Message-State: AOJu0YxJZV7F9tox57MV8I7geJKlJYPHdOLhY2v2WA3ZLtChH4vHLrj4
	KvcY0BIh3whpbsj23yBm0ePIsaZa00tF/BACMRw6Wo064RCuGSHc
X-Google-Smtp-Source: AGHT+IEJDvRremBKoTR1ZOi9N+3QkBcHAbiDyl9awlI6Q/15YHWwNRdjivOSZB0PURFmXf1IbY4Yyg==
X-Received: by 2002:a17:902:ecc5:b0:1f4:8a69:dab8 with SMTP id d9443c01a7336-1f6370b123bmr31784905ad.56.1717185887801;
        Fri, 31 May 2024 13:04:47 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ec184sm20559545ad.209.2024.05.31.13.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:04:47 -0700 (PDT)
Date: Fri, 31 May 2024 14:04:44 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: aul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E.Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev, netdev@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Jann Horn <jannh@google.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v2] landlock: Add abstract unix socket connect
 restrictions
Message-ID: <ZlotXL4sfY5Ez3I5@tahera-OptiPlex-5000>
References: <ZgX5TRTrSDPrJFfF@tahera-OptiPlex-5000>
 <20240401.ieC2uqua5sha@digikod.net>
 <ZhcRnhVKFUgCleDi@tahera-OptiPlex-5000>
 <20240411.ahgeefeiNg4i@digikod.net>
 <ZlkIAIpWG/l64Pl9@tahera-OptiPlex-5000>
 <20240531.Ahg5aap6caeG@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531.Ahg5aap6caeG@digikod.net>

On Fri, May 31, 2024 at 11:39:12AM +0200, Mickaël Salaün wrote:
> On Thu, May 30, 2024 at 05:13:04PM -0600, Tahera Fahimi wrote:
> > On Tue, Apr 30, 2024 at 05:24:45PM +0200, Mickaël Salaün wrote:
> > > On Wed, Apr 10, 2024 at 04:24:30PM -0600, Tahera Fahimi wrote:
> > > > On Tue, Apr 02, 2024 at 11:53:09AM +0200, Mickaël Salaün wrote:
> > > > > Thanks for this patch.  Please CC the netdev mailing list too, they may
> > > > > be interested by this feature. I also added a few folks that previously
> > > > > showed their interest for this feature.
> > > > > 
> > > > > On Thu, Mar 28, 2024 at 05:12:13PM -0600, TaheraFahimi wrote:
> > > > > > Abstract unix sockets are used for local interprocess communication without
> > > > > > relying on filesystem. Since landlock has no restriction for connecting to
> > > > > > a UNIX socket in the abstract namespace, a sandboxed process can connect to
> > > > > > a socket outside the sandboxed environment. Access to such sockets should
> > > > > > be scoped the same way ptrace access is limited.
> > > > > 
> > > > > This is good but it would be better to explain that Landlock doesn't
> > > > > currently control abstract unix sockets and that it would make sense for
> > > > > a sandbox.
> > > > > 
> > > > > 
> > > > > > 
> > > > > > For a landlocked process to be allowed to connect to a target process, it
> > > > > > must have a subset of the target process’s rules (the connecting socket
> > > > > > must be in a sub-domain of the listening socket). This patch adds a new
> > > > > > LSM hook for connect function in unix socket with the related access rights.
> > > > > 
> > > > > Because of compatibility reasons, and because Landlock should be
> > > > > flexible, we need to extend the user space interface.  As explained in
> > > > > the GitHub issue, we need to add a new "scoped" field to the
> > > > > landlock_ruleset_attr struct. This field will optionally contain a
> > > > > LANDLOCK_RULESET_SCOPED_ABSTRACT_UNIX_SOCKET flag to specify that this
> > > > > ruleset will deny any connection from within the sandbox to its parents
> > > > > (i.e. any parent sandbox or not-sandboxed processes).
> > > 
> > > > Thanks for the feedback. Here is what I understood, please correct me if
> > > > I am wrong. First, I should add another field to the
> > > > landlock_ruleset_attr (a field like handled_access_net, but for the unix
> > > > sockets) with a flag LANDLOCK_ACCESS_UNIX_CONNECT (it is a flag like
> > > > LANDLOCK_ACCESS_NET_CONNECT_TCP but fot the unix sockets connect).
> > > 
> > > That was the initial idea, but after thinking more about it and talking
> > > with some users, I now think we can get a more generic interface.
> > > 
> > > Because unix sockets, signals, and other IPCs are fully controlled by
> > > the kernel (contrary to inet sockets that get out of the system), we can
> > > add ingress and egress control according to the source and the
> > > destination.
> > > 
> > > To control the direction we could add an
> > > LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE and a
> > > LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND rights (these names are a bit
> > > long but at least explicit).  To control the source and destination, it
> > > makes sense to use Landlock domain (i.e. sandboxes):
> > > LANDLOCK_DOMAIN_HIERARCHY_PARENT, LANDLOCK_DOMAIN_HIERARCHY_SELF, and
> > > LANDLOCK_DOMAIN_HIERARCHY_CHILD.  This could be used by extending the
> > > landlock_ruleset_attr type and adding a new
> > > landlock_domain_hierarchy_attr type:
> > > 
> > > struct landlock_ruleset_attr ruleset_attr = {
> > >   .handled_access_dom = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
> > >                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> > > }
> > > 
> > > // Allows sending data to and receiving data from processes in the same
> > > // domain or a child domain, through abstract unix sockets.
> > > struct landlock_domain_hierarchy_attr dom_attr = {
> > >   .allowed_access = LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | \
> > >                     LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> > >   .relationship = LANDLOCK_DOMAIN_HIERARCHY_SELF | \
> > >                   LANDLOCK_DOMAIN_HIERARCHY_CHILD,
> > > };
> > > 
> > > It should also work with other kind of IPCs:
> > > * LANDLOCK_ACCESS_DOM_UNIX_PATHNAME_RECEIVE/SEND (signal)
> > > * LANDLOCK_ACCESS_DOM_SIGNAL_RECEIVE/SEND (signal)
> > > * LANDLOCK_ACCESS_DOM_XSI_RECEIVE/SEND (XSI message queue)
> > > * LANDLOCK_ACCESS_DOM_MQ_RECEIVE/SEND (POSIX message queue)
> > > * LANDLOCK_ACCESS_DOM_PTRACE_RECEIVE/SEND (ptrace, which would be
> > >   limited)
> > > 
> > > What do you think?
> > 
> > I was wondering if you expand your idea on the following example. 
> > 
> > Considering P1 with the rights that you mentioned in your email, forks a
> > new process (P2). Now both P1 and P2 are on the same domain and are
> > allowed to send data to and receive data from processes in the same
> > domain or a child domain. 
> > /*
> >  *         Same domain (inherited)
> >  * .-------------.
> >  * | P1----.     |      P1 -> P2 : allow
> >  * |        \    |      P2 -> P1 : allow
> >  * |         '   |
> >  * |         P2  |
> >  * '-------------'
> >  */
> > (P1 domain) = (P2 domain) = {
> > 		.allowed_access =
> > 			LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE | 
> > 			LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> > 		.relationship = 
> > 			LANDLOCK_DOMAIN_HIERARCHY_SELF | 
> > 			LANDLOCK_DOMAIN_HIERARCHY_CHILD,
> 
> In this case LANDLOCK_DOMAIN_HIERARCHY_CHILD would not be required
> because P1 and P2 are on the same domain.
> 
> > 		}
> > 
> > In another example, if P1 has the same domain as before but P2 has
> > LANDLOCK_DOMAIN_HIERARCHY_PARENT in their domain, so P1 still can 
> > connect to P2. 
> > /*
> >  *        Parent domain
> >  * .------.
> >  * |  P1  --.           P1 -> P2 : allow
> >  * '------'  \          P2 -> P1 : allow
> >  *            '
> >  *            P2
> >  */
> > 
> > (P1 domain) = {
> >                 .allowed_access =
> >                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE |
> >                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> >                 .relationship = 
> >                         LANDLOCK_DOMAIN_HIERARCHY_SELF |
> >                         LANDLOCK_DOMAIN_HIERARCHY_CHILD,
> 
> Hmm, in this case P2 doesn't have a domain, so
> LANDLOCK_DOMAIN_HIERARCHY_CHILD doesn't make sense.
> 
> >                 }
> > (P2 domain) = {
> >                 .allowed_access =
> >                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE |
> >                         LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND,
> >                 .relationship = 
> >                         LANDLOCK_DOMAIN_HIERARCHY_SELF |
> >                         LANDLOCK_DOMAIN_HIERARCHY_CHILD |
> > 			LANDLOCK_DOMAIN_HIERARCHY_PARENT,
> > 		}
> 
> I think you wanted to use the "Inherited + child domain" example here,
> in which case the domain policies make sense.
> 
> I was maybe too enthusiastic with the "relationship" field.  Let's
> rename landlock_domain_hierarchy_attr to landlock_domain_attr and remove
> the "relationship" field.  We'll always consider that
> LANDLOCK_DOMAIN_HIERARCHY_SELF is set as well as
> LANDLOCK_DOMAIN_HIERARCHY_CHILD (i.e. no restriction to send/received
> to/from a child domain or our own domain).  In a nutshell, please only
> keep the LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_{RECEIVE,SEND} rights and
> follow the same logic as with ptrace restrictions.  It will be easier to
> reason about and will be useful for most cases.  We could later extend
> that with more features.
> 
> LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_RECEIVE will then translates to "allow
> to receive from the parent domain".
> LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_SEND will then translates to "allow to
> send to the parent domain".
If we consider LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_* shows the
ability to send/recieve data to/from the parent domain, different
scenarios would be as follow(again using your drawings from the
ptrace_test):

/*
 *        No domain
 *
 *   P1-.               P1 -> P2 : allow
 *       \              P2 -> P1 : allow
 *        'P2
 */

(Child domain): Since child can not send/recieve data to/from parent,the
connection of both direction is banned.
/*
 *        Child domain:
 *
 *   P1--.              P1 -> P2 : deny
 *        \             P2 -> P1 : deny
 *        .'-----.
 *        |  P2  |
 *        '------'
 */

(Parent domain): The parent's access to its parent is restricted, so the
child and parent can establish connection.
/*
 *        Parent domain
 * .------.
 * |  P1  --.           P1 -> P2 : allow
 * '------'  \          P2 -> P1 : allow
 *            '
 *            P2
 */

(Parent + child domain): Same as (child domain) scenario
/*
 *        Parent + child domain(inherited)
 * .------.
 * |  P1  ---.          P1 -> P2 : deny
 * '------'   \         P2 -> P1 : deny
 *         .---'--.
 *         |  P2  |
 *         '------'
 */

(Same domain): An example is when a process fork two child processes and
they inherit the parent's access. In this case, children proccess can
send/recieve data to/from each other since they are in the same domain.
/*
 *         Same domain (sibling)
 * .-------------.
 * | P1----.     |      P1 -> P2 : allow
 * |        \    |      P2 -> P1 : allow
 * |         '   |
 * |         P2  |
 * '-------------'
 */

/*
 *         Inherited + child domain
 * .-----------------.
 * |  P1----.        |  P1 -> P2 : deny
 * |         \       |  P2 -> P1 : deny
 * |        .-'----. |
 * |        |  P2  | |
 * |        '------' |
 * '-----------------'
 */

/*
 *         Inherited + parent domain
 * .-----------------.
 * |.------.         |  P1 -> P2 : allow
 * ||  P1  ----.     |  P2 -> P1 : allow
 * |'------'    \    |
 * |             '   |
 * |             P2  |
 * '-----------------'
 */

/*
 *         Inherited + parent and child domain
 * .-----------------.
 * | .------.        |  P1 -> P2 : deny
 * | |  P1  .        |  P2 -> P1 : deny
 * | '------'\       |
 * |          \      |
 * |        .--'---. |
 * |        |  P2  | |
 * |        '------' |
 * '-----------------'
 */
Any feedback on this logic is appreciated.

> As for other Landlock access rights, the restrictions of domains should
> only be changed if LANDLOCK_ACCESS_DOM_UNIX_ABSTRACT_* is "handled" by
> the ruleset/domain.

