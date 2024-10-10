Return-Path: <netdev+bounces-134392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E99991FE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904A41C2699B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B111CF28E;
	Thu, 10 Oct 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M1+xncv2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B791CDFD3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587652; cv=none; b=J0C/sxqUBX8PZYdyyBvGnZcbUyoOczUwYm8JZgS6+tfz/PSRmw52nujPijEjX7AxOUBsrIJJv0G7rA8XivAdIYGyPJ8k6nQVDUrAQjQeNG06jDEQSfyiRNvxmyh7u+naawRfAsGmXTyzux7Yn2IfyeOFiO0Nr4gLjdz/0b5tmm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587652; c=relaxed/simple;
	bh=9J2YZOewo+gdC+S01tNmNL+06a41vIYYBHxKTP6AoZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rtgo8uyUUG6XMjwB/o7Tiv/IZH97ZIJbRD5+68gAhJG3Wi601FswnVxxX/5MuTRqUx/XQTjfQqKJkeJCTNCAoQBhvdNkPfNyNwrb8HG78rkYm4xiTqYNwE5ng4u5HN124ExHxxC1Zc+j/4fSHwstWnaG4eWGBYUcxEBRH/pojAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M1+xncv2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e2e427b07dso10514657b3.1
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728587650; x=1729192450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Pg6F94tMjt4Hzd0hbiOJ9IN5nlvNjG3qJM+Incf8Y=;
        b=M1+xncv2b0E6e1amM7U3ZuPbA7r9Iqh3YGPqXg79nKJTppswu5Ar1d7dDyHsvcR9H6
         9kEApomQqMlwwd/qGWB2eC339+sFkcpz45hp4lX3Z0inJcwy8fET7AoSm+ZpOVKBmY9/
         w52SfAfYDdE16n6Ve8abZMXWexhlqz/GVccUaDuYcPBJEBr7zIYDlrx2x7PpxjeHuqmL
         FBPpgULGwWpjXCJ7z1JCmSIOGC5aKDRrn2JpKKuuQLdnELpgYkByYxVQuC2rXVJz+V8p
         Mg9ujGmLpd+EqRLzxANQyl0hFsCl6qxm6+4IKOaDc66VputxU2vKxvDLyiqkZymiFBJ5
         xvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587650; x=1729192450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Pg6F94tMjt4Hzd0hbiOJ9IN5nlvNjG3qJM+Incf8Y=;
        b=fRlnzSrIijocVKAdJoCiShtOcTf/Lvj7LDRnHaGyqsSqxpME31KpYexf8Hg5l12vIC
         JhiVHJVqUxJpEWk+uijfWlhtzwJfbDbwloHP03NXuXnaRMKb5STGFKmXj1JAsLpT52Ij
         FolECSWnQH2oUFAEWLsSxqxWzYiYtfQ+dnHBbyKgVpvozzjV6XfB27HwX5tMjR3OHN8L
         jockruZxHdvhZZsBv8TdUopIvzcTbn7MnmrILpbHRa9ghyG05W/b2OV4l+RJpuVXdH8B
         d4Y89h5fiHXGltRDaQh9EXTmrD261qvbxSOKGCNDHVT6mlA6CVdZr7Z4hz/1ytMwhfkk
         UzIw==
X-Forwarded-Encrypted: i=1; AJvYcCUCPDft9+rqMsctvrfYNF+pk8/INpbv+yuUSLJqI68K/KOVP1gmacMOoxQ+HIQSgONKIuv7eHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOV2Mh70nftHkP+14XHd9SDUnSUQmx24r8QQ749Ym4UOxmbsi1
	B9lKF/gbjrZtuWfpDwf2aLA7O+ew4iK5JzfWhfZNo3ao7Y9hNbzEqemyWivH0MmkV/BZCR6+A2L
	3W4vUO1kUiVjjkPuMAaHwO9i4rF/P0yq60/iE
X-Google-Smtp-Source: AGHT+IHnv4orDez7mVyaCamNo5riXD5so7ejl6e+p+Fw01YmHomhmfIG+INttnHTWDIYhyHZKQAoeiK3WGnlHJxdHNw=
X-Received: by 2002:a05:690c:7602:b0:6dd:fb47:2184 with SMTP id
 00721157ae682-6e322121ac1mr65921917b3.13.1728587649945; Thu, 10 Oct 2024
 12:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009203218.26329-1-richard@nod.at> <20241009213345.GC3714@breakpoint.cc>
 <CAHC9VhSFHQtg357WLoLrkN8wpPxDRmD_qA55NHOUEwFpE_pbrg@mail.gmail.com>
 <20241009223409.GE3714@breakpoint.cc> <CAHC9VhTC=KAXe6w9xTG_rY4zAnNvPv-brQ7cTYftcty866inCw@mail.gmail.com>
 <20241010175925.GA11964@breakpoint.cc>
In-Reply-To: <20241010175925.GA11964@breakpoint.cc>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 10 Oct 2024 15:13:59 -0400
Message-ID: <CAHC9VhTW0nsoZk3bkfLU5WaGoJhK544+35Cap6=dzv=td_+OPA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
To: Florian Westphal <fw@strlen.de>
Cc: Richard Weinberger <richard@nod.at>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, 
	upstream+net@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:59=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
> Paul Moore <paul@paul-moore.com> wrote:
> > Correct me if I'm wrong, but by using from_kXid(&init_user_ns, Xid) we
> > get the ID number that is correct for the init namespace, yes?  If so,
> > that's what we want as right now all of the audit records, filters,
> > etc. are intended to be set from the context of the initial namespace.
>
> Seems to be the case, from_kuid() kdoc says
> 'There is always a mapping into the initial user_namespace.'.
>
> I'm confused because of the various means of dealing with this:
> 9847371a84b0 ("netfilter: Allow xt_owner in any user namespace")
>
> Does: make_kgid(net->user_ns, ... and also rejects rule-add if
> net->user_ns !=3D current_user_ns().  As this is for matching userids,
> this makes sense to me, any userns will 'just work' for normal uid/gid
> matching.
>
> a6c6796c7127 ("userns: Convert cls_flow to work with user namespaces enab=
led")
> Does: from_kuid(&init_user_ns, ... and rejects rule adds if sk_user_ns(NE=
TLINK_CB(in_skb).ssk) !=3D &init_user_ns)
>
> Seems just a more conservative solution to the former one.
>
> 8c6e2a941ae7 ("userns: Convert xt_LOG to print socket kuids and kgids as =
uids and gids")
> ... which looks like the proposed xt_AUDIT change.
>
> As I do not know what the use case is for xt_AUDIT rules residing in
> another, possibly unprivileged network namespace not managed by root-root=
 user,
> I can't say if its right, but it should do the right thing.
>
> Sorry for the noise.

No worries, it was a fair question and discussion about this is rarely
a bad thing as it can get rather complicated somewhat quickly.  With
audit our current philosophy is that we try to do our logging and run
the filters within the context of the host/initial namespace for the
sake of consistency.  Of course this introduces some limitations and
"hide" some details specific to a child namespace, but it's the only
solution we could think of that allows the current kernel audit
implementation to behave in a comprehensive and sane manner across all
the various namespace/container solutions.

--=20
paul-moore.com

