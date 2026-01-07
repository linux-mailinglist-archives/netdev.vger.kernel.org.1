Return-Path: <netdev+bounces-247827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AC7CFFB50
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 20:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C88323019365
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94878357704;
	Wed,  7 Jan 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNb+a3iI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8B3A0B05
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805078; cv=none; b=CYNRvj4CwSKKJNjPTNBqWcaWuW9JoFu3Kr3lQ4oejI2/mByao6owUWOjMzSnr9z26aGuPonKS14I1s1VP1SgTXzGh98gYHdS8PyTFMxLkfICvHWX5N5Rv3QIz7I06WJi09T51ZmSf71xte0A82gSt14uwZ4wMZL04lrAOKoIv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805078; c=relaxed/simple;
	bh=oTh/Bm7Bvc5pQDGtio2WHmCSYQcQfl+HLeQb6+ZuPa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCdqDpflgH8vz1SJbvcMAxH/OsF/RNw7ktcsj7j094jsRc4tjpd/dtqPCvIdwHNk8PMwnU9uaqYmOfmAOFhQaqTPcWKGoamDtAT0ZVd2BAw8aFqehz21JQHcSVHu92KiZuYVxTwPyHMyHcnMmO/d5J4nm55bVkAneh8zUqNfQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNb+a3iI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so24469645e9.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767805070; x=1768409870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cVSMIV0M1vHEkGoca4IYHePZY2mIben9Mxd1bnOl0g=;
        b=WNb+a3iI069+UVfkyi0mdxhz3UHcXoR2Dks6g/Zr5duayBmAFceV4VkycZSQSpNejh
         HLZlFMYjlGHuAd5pKPpyck8hVhyA2qdSQS6CJ0AFLDAqOnmDIgtA5UrRPi6TgeY3OBXb
         M7jL5UtGiyEB5/LAvkngUsdz8mpiVg5rAWbvbWb69JZ3mBVLfT4SVX43b32nfuvyPxDS
         oVaOjdXCtPvHyFZkhXo97/vde6t2f3pdnBRP4enQVaZtjMSYvHnmG3e3qQ/L9D7r8sEL
         vxr5lm3h5pey/t84dNgdBxUxJDBVt3m5XkrlodFszwtaV2LuITUgssDn6gLTPFbCNLb7
         sLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805070; x=1768409870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cVSMIV0M1vHEkGoca4IYHePZY2mIben9Mxd1bnOl0g=;
        b=wKIp60E2Bhl9LXrl/aHPoIuG+r4G5ncxhbF6hMHuxY1s3J2NGc1HvccpOt11crG+cb
         aOT40grPuBkQtTlXz6XaWg+5m4kgMB+Ju6LYphL4QPFYKwSeS3WKQZ2BVJXFyWm2gsuc
         H3OA8BVVLViooX51UmwBgLGZxx+Ot/IrV2hvvCShskZhrKu6G9eDOELcUKD3qGJyZOkN
         SNnNa0NUOG9S9r9dJGhSmdNgvNvzkkUftYVsl/6Z7uytSFScHQ9nIn5sDYgshyY+pnX5
         5fGP9T9kQmp87Alyux7dmhwSiV/IZ32hdqjHDeuvC2duv/i8RyEC5zp55z6YwMiqbpHF
         /Ezw==
X-Forwarded-Encrypted: i=1; AJvYcCW4WEZh2AySPNzrJLaA2g2dTGPzfWDwVqFFbLBmRIZzyWyG1qOrmQcI5LEaNamOn1FQ9V/XuVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKe7mNBry/OBHO/nDSo7ePIHhf+kblb1qd68P9gH/lkU13dad2
	t1XzB5EV5gV9NWj7TYzlDZpZWqzRQZp8r7O2vktfTUkAWsqT0SYK7tC5nHwbHN2wCg==
X-Gm-Gg: AY/fxX4gWqZuY9dOboIbqrA5dDVVC7j27rx93QPKM8g/z3wAUVqUDpnsuEBB5vvH7zx
	wpXlqO+bvtWS7YSuV6bSlUyWCcWipwdQi26pN92TnaFOpfmXJvOK63D3TdRUqFyxpDHDqiS0mzZ
	+WkblnDEEYUOQpuP9vhl2elOm8FUt8fgv/v11vDglZuTldNkyusceYHfOcAA3LvgnTsccwAiIvr
	zpQxLWTfHm2iSjRiZWaaw+QG6BHZ1b7lLC+VWV/06Bp6xViV856lDv/5ND3rGykhOfnQZ7epDbl
	6RCdQacvikHezUXsiLroSEP6veOLAoJliUZMGIoGdg8Hjj3RvuMhNL19ABQqLocZcA3QYXa2UtC
	uce5wpCgGnHJLyz0EigeIpPXwyNZiNmaTFy5ZffLOvkTppe5RGJJ/0kdnYX6hwcONnIvu3IHbYc
	kwzZNcMRXtkuyLT3wSRRa/vr0xEEDTKWU47wzUJ1nsCw==
X-Google-Smtp-Source: AGHT+IFNWlJitUC1NSOuwXl+nF0iGIoib1vo+UR+IFwK8+8wYGCEbPSdCgCOi3fSLDFCBKtQyHctnQ==
X-Received: by 2002:a05:600c:8b2c:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d84b3ea06mr36754095e9.33.1767805069507;
        Wed, 07 Jan 2026 08:57:49 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:aaba:e2c1:29df:3e24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41f5e0sm104518655e9.8.2026.01.07.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:57:48 -0800 (PST)
Date: Wed, 7 Jan 2026 17:57:43 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <aV6Qh39jVg8trMlg@google.com>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
 <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
 <2da3f1ae-1fe1-40c4-8748-9fb371e696f0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da3f1ae-1fe1-40c4-8748-9fb371e696f0@gmail.com>

On Wed, Jan 07, 2026 at 07:19:02AM -0500, Justin Suess wrote:
> On 1/7/26 02:33, Kuniyuki Iwashima wrote:
> > +VFS maintainers
> >
> > On Mon, Jan 5, 2026 at 3:04 AM Günther Noack <gnoack@google.com> wrote:
> >> Hello!
> >>
> >> On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> >>> On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >>>> Motivation
> >>>> ---
> >>>>
> >>>> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> >>>> identifying object from a policy perspective is the path passed to
> >>>> connect(2). However, this operation currently restricts LSMs that rely
> >>>> on VFS-based mediation, because the pathname resolved during connect()
> >>>> is not preserved in a form visible to existing hooks before connection
> >>>> establishment.
> >>> Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
> >>> and security_unix_may_send() ?
> >> Thanks for bringing it up!
> >>
> >> That path is set by the process that acts as the listening side for
> >> the socket.  The listening and the connecting process might not live
> >> in the same mount namespace, and in that case, it would not match the
> >> path which is passed by the client in the struct sockaddr_un.
> > Thanks for the explanation !
> >
> > So basically what you need is resolving unix_sk(sk)->addr.name
> > by kern_path() and comparing its d_backing_inode(path.dentry)
> > with d_backing_inode (unix_sk(sk)->path.dendtry).
> >
> > If the new hook is only used by Landlock, I'd prefer doing that on
> > the existing connect() hooks.
> I see. Did you have a particular hook in mind to extend?
> 
> One complication I see is whatever hook this gets added to
> would also need CONFIG_SECURITY_PATH, since logically this restriction
> would fall under it:
> 
> From security/Kconfig:
> 
> config SECURITY_PATH
>     bool "Security hooks for pathname based access control"
>     depends on SECURITY
>     help
>       This enables the security hooks for pathname based access control.
>       If enabled, a security module can use these hooks to
>       implement pathname based access controls.
>       If you are unsure how to answer this question, answer N.
> 
> config SECURITY_NETWORK
>     bool "Socket and Networking Security Hooks"
>     depends on SECURITY
>     help
>       This enables the socket and networking security hooks.
>       If enabled, a security module can use these hooks to
>       implement socket and networking access controls.
>       If you are unsure how to answer this question, answer N.
> 
> Logically, this type of access control falls under both categories, so must be
> gated by both features. No existing LSM hooks are gated by both afaik, so
> there is not really an existing logical place to extend an existing hook without
> changing what features are required to be enabled for existing users.
> 
> I do see more uses for this hook that just landlock, bpf lsm hooks
> or other non-labeling LSMs like apparmor or TOMOYO could take advantage
> of this as well.

Apologies, I overlooked your reply earlier today.

The existing hooks that are called from af_unix.c are:

- security_unix_stream_connect() for SOCK_STREAM unix(7) sockets
- security_unix_may_send() for SOCK_DGRAM unix(7) sockets

Apart from that, at a higher level, there are also

- security_socket_connect()
- security_socket_sendmsg() and security_socket_recvmsg()

These are used from net/socket.c.

For the connectionless dgram Unix sockets, we would need to tell apart the cases
where sendmsg()/recvmsg() are used with and without a sockaddr.  (Dgram sockets
can be either connected with connect() and then have a fixed sockaddr, or they
can be passed a remote sockaddr with each message send and receive operation.)
This can told apart in security_socket_sendmsg() from the msg argument, but it
doesn't look like we could tell it apart from security_unix_may_send().

Landlock already depends on CONFIG_SECURITY_NETWORK and CONFIG_SECURITY_PATH,
so we would not need to have further #ifdefs to use one of these hooks.

There are other difficulties I found which worry me and which I listed in the
other mail at https://lore.kernel.org/all/aV5WTGvQB0XI8Q_N@google.com/.

—Günther

