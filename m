Return-Path: <netdev+bounces-250091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DEAD23D70
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89432300981A
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE48357705;
	Thu, 15 Jan 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvvzsaPq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230C1346E7F
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471812; cv=none; b=fW2V9IfcwzoVQFZ+a8W9shQKaF296So5loM5+O+yD0awSQRKNti2jWcKzI4kJLqKUh3UvkfD7/gcEf3xMbGzC9Mi6Zy5rIjneo6XYTg003Ua8MPtXld3xJkB0SZjTJYjSYkTpdShKK8Op7ZpN+B0OVXR3pXy8eCjiEqL2a9zsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471812; c=relaxed/simple;
	bh=9k+hI8ee/XChzzMZqRaSR1BQU4YqamW09mjAmEnwWew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlzDh3lF7hvVIx6vuyeg3lbYFqFLriU8Hw+kewI96IjqW9N00c2WWGTGyWIH2OjjuMaCGcJ1oeOwzx+aW+sMftHe7+1Kws/noDxzytAYJSQbtqlvhhn2pbl5Y3ciJW81VfDLr5XrT2iLXwlbTszNPeTBEx1JaXu8so+WdtyNGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvvzsaPq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso99698066b.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 02:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768471809; x=1769076609; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2FkwmQ3JsIlKc/0pGdsmQ0lUazTKrfor6cVyG/d0vIo=;
        b=dvvzsaPqq3N6WofqzdwEaZevSR2x06v9DI8NYZ69IG5vkSyeSgiXt+UODKVz6H8xOb
         CwZvkC250alr07NNvVi/3FJhumpD1DVZjrLdRxSVY94dFmY8oGw6zubR+uEdntlybrWj
         Pi3ca4FULdM2WOMLdWdqMjtIb3NN/ohRCBqIoy+Q09UMhQhe25KonMwFhEx9RBj8/9AM
         R5lrhF8eMLaRpvGk+ZOOa2FenrtdZDcz2kmq7XEY7NUMQgoUiNKjral+69acWaUyn2wC
         Z0RouyhSIGwuovGFDVPtVeToVtF6Iy0Xk1rn260oyfDovNEs+GtaeoqeVbDPqP/gVNr7
         go7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768471809; x=1769076609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FkwmQ3JsIlKc/0pGdsmQ0lUazTKrfor6cVyG/d0vIo=;
        b=sxoGl8NqDgUUWxRYsO6ygqeRxFrT0NIrBz32UIuZ2g0VWtyCq/H9xqXWOBZVcs47xq
         pmOukRSMFIIXFsVptQyetakxkLFEVwTN03jThJJ8kFJb4vq8TfzCJ212LLZ72+RDTAxx
         eLBjrNS6lbDC+mQz3VE6zMtlMDHi3mRmnImxD9QTclqeYA4opimotAgu5HKHs3+h3FTC
         JaRiJ1AXo25dw3OWdXSt2qRvIyr1fLtmQxEgDDc8WCJfD5FtyT2o9RsSmNwFupAhZFiw
         M3Jbx6RQ1T5VBEFvXNvqu3zteHjrN+IZtNB1KW5HoarWwASnvKtBkTMIAX12Dx1kOO3x
         DlOA==
X-Forwarded-Encrypted: i=1; AJvYcCWkA/blqHK2wzw6ws7+xFdzy5ROVHXGeE9F8RK+Md4RUVudxGvBBWKK+8pG4wLGjG3Vpq3XV/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTY894bp+ifs0QsrowPrW2TmqdF2/XUO92ycMEJr2WJaIcWUBf
	dBjYtjGv+AKBGhLEo08PpcdhurtfAGbk/ASjXlyvBK1HB1QL41cMVwPT
X-Gm-Gg: AY/fxX7RMQ+EOmHi5Dkyv5kqlvTuV+swu9h9vo3nCVD95Q1Y7NyreidC5DukdEOEUiw
	ZPzxbTivvRHGbPQ+pumx4iZasvm56JTlZ5a6FLstWHrIEvQ/LebfMiaK7UMSYafjntHYlt+1tNQ
	hK6JCSivrNGlaEfbhaeeE9kBfhJNjEXJFxdZXkqn53oo9YuvnslGw5PiV4gtgn+DKjmk9hz2nEB
	Z8B4UCVGmWvLJGs4Yr+jEoZKExh9pJJ9BsVDXyXIp4lUybEpvwXaJKtS/KNZ9iJOKF3nsGLdBxu
	yEtRJXNZD6lhDxppsNjSiJ41D89+bWRSdBE8j3CsRbhTUbpebAzV4GvQ5FSPzgD7V1GGCAP7PGS
	wKTGmPM5IqpFLniWb7lK+PeIlMUWMgtEEY7E7SZLijS8yOs+R9qltgHvGfjCNS5sw4P3U0kAtEi
	MY2SXTf29keIGZuySBqi02/2P0ox1gywUqRGFm
X-Received: by 2002:a17:907:3a12:b0:b87:35fc:ae5f with SMTP id a640c23a62f3a-b87678c36d9mr303953666b.52.1768471809054;
        Thu, 15 Jan 2026 02:10:09 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5180bdsm2659833866b.57.2026.01.15.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:10:08 -0800 (PST)
Date: Thu, 15 Jan 2026 11:10:02 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
Message-ID: <20260115.b5977d57d52d@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-4-gnoack3000@gmail.com>
 <20260113-kerngesund-etage-86de4a21da24@brauner>
 <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>

On Tue, Jan 13, 2026 at 06:27:15PM -0500, Paul Moore wrote:
> On Tue, Jan 13, 2026 at 4:34 AM Christian Brauner <brauner@kernel.org> wrote:
> > On Sat, Jan 10, 2026 at 03:32:57PM +0100, Günther Noack wrote:
> > > From: Justin Suess <utilityemal77@gmail.com>
> > >
> > > Adds an LSM hook unix_path_connect.
> > >
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated.
> > >
> > > Cc: Günther Noack <gnoack3000@gmail.com>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  4 ++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            |  9 +++++++++
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 44 insertions(+)
> 
> ...
> 
> > > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > > index 55cdebfa0da0..3aabe2d489ae 100644
> > > --- a/net/unix/af_unix.c
> > > +++ b/net/unix/af_unix.c
> > > @@ -1226,6 +1226,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
> > >       if (!S_ISSOCK(inode->i_mode))
> > >               goto path_put;
> > >
> > > +     /*
> > > +      * We call the hook because we know that the inode is a socket
> > > +      * and we hold a valid reference to it via the path.
> > > +      */
> > > +     err = security_unix_path_connect(&path, type, flags);
> > > +     if (err)
> > > +             goto path_put;
> >
> > Couldn't we try reflowing the code here so the path is passed ...
> 
> It would be good if you could be a bit more specific about your
> desires here.  Are you talking about changing the
> unix_find_other()/unix_find_bsd() code path such that the path is
> available to unix_find_other() callers and not limited to the
> unix_find_bsd() scope?
> 
> > ... to
> > security_unix_stream_connect() and security_unix_may_send() so that all
> > LSMs get the same data and we don't have to have different LSMs hooks
> > into different callpaths that effectively do the same thing.
> >
> > I mean the objects are even in two completely different states between
> > those hooks. Even what type of sockets get a call to the LSM is
> > different between those two hooks.
> 
> I'm working on the assumption that you are talking about changing the
> UNIX socket code so that the path info is available to the existing
> _may_send() and _stream_connect() hooks.  If that isn't the case, and
> you're thinking of something different, disregard my comments below.
> 
> In both the unix_dgram_{connect(),sendmsg()}, aka
> security_unix_may_send(), cases and the unix_stream_connect(), aka
> security_unix_stream_connect(), case the call to unix_find_other() is
> done to lookup the other end of the communication channel, which does
> seem reasonably consistent to me.  Yes, of course, once you start
> getting into the specifics of the UNIX socket handling the unix_dgram_
> and unix_stream_ cases are very different, including their
> corresponding existing LSM hooks, but that doesn't mean in the context
> of unix_find_bsd() that security_unix_path_connect() doesn't have
> value.
> 
> The alternative would be some rather serious surgery in af_unix.c to
> persist the path struct from unix_find_bsd() until the later LSM hooks
> are executed.  It's certainly not impossible, but I'm not sure it is
> necessary or desirable at this point in time.  LSMs that wish to
> connect the information from _unix_path_connect() to either
> _unix_stream_connect() or _unix_may_send() can do so today without
> needing to substantially change af_unix.c.

Thanks for the review, Christan and Paul!

I am also unconvinced by the approach. It has also crossed my mind
before though, and my reasoning is as follows:

For reference, the function call hierarchy in af_unix.c is:

* unix_dgram_connect()   (*)
  * unix_find_other()
    * unix_find_bsd()
  * security_unix_may_send()

* unix_dgram_sendmsg()   (*)
  * unix_find_other()
    * unix_find_bsd()
  * security_unix_may_send()

* unix_stream_connect()  (*)
  * unix_find_other()
    * unix_find_bsd()
  * security_unix_stream_connect()

In my understanding, the hypothetical implementation would be:

* allocate a struct path on the stack of these proto_ops hook
  functions (marked with (*) above)
* pass a pointer to that path down to unix_find_other(), only to be
  filled out in the case that this is a pathname UNIX socket (not an
  abstract UNIX socket)
* pass a const pointer to that path to the LSM hooks

and then the LSM hooks would have to check whether the struct path has
non-zero pointers and could do the check.

This has the upside that it does not introduce a new LSM hook, but
only adds a "path" parameter to two existing LSM hooks.

On the other side, I see the following drawbacks:

* The more serious surgery in af_unix, which Paul also discussed:

  The function interface to unix_find_other() would need additional
  parameters for the sole purpose of supporting these LSM hooks and
  the refcounting of the struct path would have to be done in three
  functions instead of just in one.  That would complicate the
  af_unix.c logic, even when CONFIG_SECURITY_PATH is not set.

* The cases in which we pass a non-zero path argument to the LSM hooks
  would have surprising semantics IMHO, because it is not always set:

  * If a UNIX dgram user uses connect(2) and then calls sendmsg(2)
    without explicit recipient address, unix_dgram_sendmsg() would
    *not* do the look up any more and we can not provide the path to
    the security_unix_may_send() hook.
  * For abstract UNIX sockets it is not set either, of course.

  The path argument to the LSM hook would be present in the exact same
  cases where we now call the new UNIX path lookup LSM hook, but it
  would be invoked with a delay.

* Some properties of the resolved socket are still observable to
  userspace:

  When we only pass the path to a later LSM hook, there are a variety
  of additional error case checks in af_unix.c which are based on the
  "other" socket which we looked up through the path.  Examples:

  * was other shutdown(2)? (ECONNREFUSED on connect or EPIPE on dgram_sendmsg)
  * does other support SO_PASSRIGHTS (fd passing)? (EPERM on dgram_sendmsg)
  * would sendmsg pass sk_filter() (on dgram_sendmsg)

  For a LSM policy that is supposed to restrict the resolution of a
  UNIX socket by path, I would not expect such properties of the
  resolved socket to be observable?

  (And we also can't fix this up in the LSM by returning a matching
  error code, because at least unix_dgram_sendmsg() returns multiple
  different error codes in these error cases.)

  I would prefer if the correctness of our LSM did not depend on
  keeping track of the error scenarios in af_unix.c.  This seems
  brittle.

Overall, I am not convinced that using pre-existing hooks is the right
way and I would prefer the approach where we have a more dedicated LSM
hook for the path lookup.

Does that seem reasonable?  Let me know what you think.

–Günther

