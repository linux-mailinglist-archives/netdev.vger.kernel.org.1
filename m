Return-Path: <netdev+bounces-133994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A3997A55
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312C0B22E49
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D62374FF;
	Thu, 10 Oct 2024 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KEg7IOtA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD282A1D3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525790; cv=none; b=QZNobVm5MEja9x9Qj2MI6rNZ/aZwWT5QHNrth0bqQH5LVmePyChdcWB7GI1pJ4s9rnehXMDb8ictqOiBAdCiZb9Z2t5nI/tKgvb3ZPSIYfSSkjms8laIG68f+/+8wel4dkUihRlxR+0ouESDxddZJoRP+KVHbTJhcsQT+/yQXA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525790; c=relaxed/simple;
	bh=lm9yALyuk4sK7mcT+xBoNNcgiB4rCPycPd5ZLkZn/J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t26XC653i+RB63Y4mIV46VNRaAAIlV8GnvrJg0HmOpABpD28xl7aXbg9BaA5LBm+JMuBdE9OPHKtBjvMR2dbymdfOFAa9xIVfM7iqC7wWu8CF91IcbKI1z6H3DDG/lwz9Ixc2wz0/GWTf/WjJXx4q4xAr4BcpniljQcNd+pB7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KEg7IOtA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e290333a62cso336654276.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728525788; x=1729130588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tI22F1lPDInL5Y+wCwfLKOYihiyc18G36615UsHfNM=;
        b=KEg7IOtAjmr3rX6vTID3q7KhZUTrH0V+V6MX9u2LfgNg5GkKDHQ36VPZ4DFpUEw0jy
         +gtBLvfSly0lo25ObxQI72jZEFE4Kpgmdg+9fDqxQeibmZX+FqCl+6FTz02j0LMFC3R5
         y+6e+wBdpoUAVycs+aKLvmIHZzoJvHN91doJaremPYgImn0JdX/bBCAIV9hgBBhd76nK
         Il9CLcBufHeyDzhLh+jR4PWzQJDrEoM3S2NnPBvSu2QNcP6jyEdxsTyaMgTTxQ9nFpZA
         o6/oSL2iMxawNjc65RcuZ9uwICNElIXVrbaOxX6CV3whmYI1wjgpIIGs9vFZgv886SaT
         GSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728525788; x=1729130588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tI22F1lPDInL5Y+wCwfLKOYihiyc18G36615UsHfNM=;
        b=r1/gAjLMokPQiQ5OmDVG6PKUZDoF+vO2qYvyYEKwi4fVQWWrPiYDjc4kLQ3RA9P2Gv
         PFIqWwk/EaT/OUrksDeiP1VnaDu96WIjGH3HME049QscUB93G3oAImW1tTVAP0+C8BzW
         9Sf6iCE5dWIO2V/BtOD+72bdVyx+01MyqCFGWnl2Zw94uqhig9+KleWeAXYQSioCHa8z
         e8t+Gx5KAG1GWqFKQa0HqA73+3rK49EAA+WlPUJojAClEEFf9mJJxJx7PZxN5Y+JvK1K
         22p9GatdgAz4kzCHOO/ltTsGX/aqGc2KT65wS3hcZMB83G8vqQHKStzJajVteNdGPubz
         RbOw==
X-Forwarded-Encrypted: i=1; AJvYcCVoI4u2upsjTJ9Z/ZagrI/ASpOkOkNP4hLDwMiSfeTcVdYDiuraadWuEt5uTFTlHIO0LRZiz7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqeecm11NCoBzahN3JVKhbU2I2OGaat2aFN9JUI9mpWzn0s1i5
	MfVZYUseq0ZJ+hPZCe4I9gBL4jB7n4AhUQKKoKcgYZSWqiJHPSlDi142o5+3+Pw1ycEpy+k5LJi
	c/lawW4wyuW6nDJ0LTK0MCuWvRiReCXzXsbCd
X-Google-Smtp-Source: AGHT+IEyeMjrAkKGzbUK/00w0l1RMo2D/Rz84dGLbkxfIaBrFu50KXvg+JrSoF/LLGZHMQ5Qfg+g/KPmdvAxhFISkbQ=
X-Received: by 2002:a05:690c:397:b0:6b1:8834:1588 with SMTP id
 00721157ae682-6e3224d1ecdmr47971387b3.35.1728525787839; Wed, 09 Oct 2024
 19:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009203218.26329-1-richard@nod.at> <20241009213345.GC3714@breakpoint.cc>
 <CAHC9VhSFHQtg357WLoLrkN8wpPxDRmD_qA55NHOUEwFpE_pbrg@mail.gmail.com> <20241009223409.GE3714@breakpoint.cc>
In-Reply-To: <20241009223409.GE3714@breakpoint.cc>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 22:02:57 -0400
Message-ID: <CAHC9VhTC=KAXe6w9xTG_rY4zAnNvPv-brQ7cTYftcty866inCw@mail.gmail.com>
Subject: Re: [PATCH] netfilter: Record uid and gid in xt_AUDIT
To: Florian Westphal <fw@strlen.de>
Cc: Richard Weinberger <richard@nod.at>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, 
	kadlec@netfilter.org, pablo@netfilter.org, rgb@redhat.com, 
	upstream+net@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:34=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
> Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 9, 2024 at 5:34=E2=80=AFPM Florian Westphal <fw@strlen.de> =
wrote:
> > > Richard Weinberger <richard@nod.at> wrote:
> > > > When recording audit events for new outgoing connections,
> > > > it is helpful to log the user info of the associated socket,
> > > > if available.
> > > > Therefore, check if the skb has a socket, and if it does,
> > > > log the owning fsuid/fsgid.
> > >
> > > AFAIK audit isn't namespace aware at all (neither netns nor userns), =
so I
> > > wonder how to handle this.
> > >
> > > We can't reject adding a -j AUDIT rule for non-init-net (we could, bu=
t I'm sure
> > > it'll break some setups...).
> > >
> > > But I wonder if we should at least skip the uid if the user namespace=
 is
> > > 'something else'.
> >
> > This isn't unique to netfilter and the approach we take in the rest of
> > audit is to always display UIDs/GIDs in the context of the
> > init_user_ns; grep for from_kuid() in kernel/audit*.c.
>
> Hmm, audit_netlink_ok() bails with -ECONNREFUSED for current_user_ns()
> !=3D &init_user_ns, so audit_log_common_recv_msg() won't be called from
> tasks that reside in a different userns.

We have a requirement that the audit daemon and audit management tools
run in the initial user namespace, but these are the audit collection
and configuration mechanisms, not the audit record generation
mechanisms.  Regardless of the namespace limitations on auditd and
auditctl, we want to collect audit records across the system, which is
what we are doing in audit_tg().

> If you say its fine and audit can figure out that the retuned
> uid is not related to the initial user namespace, then ok.
>
> I was worried audit records could blame wrong/bogus user id.

Correct me if I'm wrong, but by using from_kXid(&init_user_ns, Xid) we
get the ID number that is correct for the init namespace, yes?  If so,
that's what we want as right now all of the audit records, filters,
etc. are intended to be set from the context of the initial namespace.

--=20
paul-moore.com

