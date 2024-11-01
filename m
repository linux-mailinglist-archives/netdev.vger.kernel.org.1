Return-Path: <netdev+bounces-141069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C09B95AC
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 17:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1615D280C61
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6261C8785;
	Fri,  1 Nov 2024 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VYfqtx9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C21C2456
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479364; cv=none; b=sokiEe8B84jG9HsTprBkra10H6YmNofXSf3YPdKHCtU24nIS8BziKgegCnQRF2OJeydboMVAp90pKuXKWNtNUNex2jRfgRcl1JXvF84jLcjxf9zv2urTnTf3Xn8UAPh3W7TtKKPrx4kTJd4i7DGMiQSz0ZEAGExUaLZRZq6Emys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479364; c=relaxed/simple;
	bh=bdl1QU1TO9smfZlcjavKeh83DDahAr/viN7jpcXBk5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwNsiJ6N52WEXRhv7aoiGODpW5D5LoMR76+fVzDpUpDbN6ylTRT+eX6aZmm/hBZs4cySRyZ8LhB+WcZ/m8x4kC8Xg8kyblQ+LyMD/UEb0GH05wEPXu3NxD6iYrvttHappUZcvbdv90332vknnQhw9zNKiStD/z9n8gkyC9yMb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VYfqtx9n; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2e444e355fso2602437276.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730479361; x=1731084161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdl1QU1TO9smfZlcjavKeh83DDahAr/viN7jpcXBk5k=;
        b=VYfqtx9nPvwxjeNA2O+gya3m+TvMduWac+RbsuNMk22voUhZb7wMdf+xsxnfDZS3MP
         G7/QScRRGjcvFjhIsLiGKDytElrhns/2RnUJneUMzAoDe3b4uMxtxMmLs6Qa+AyQwbwn
         hFOXIZx+O4TdNyW/i9RCP/WLEYgf+qHjk2rglGBLuIVhyphy6ete2y6qou6+ZOzuKA4h
         GEBnu/qEarDy0rH8yeQQKtMBsqIm9hYHp0aLADN19qwJExWGNteC8HfumB8VYbqOasia
         YQ5TKINwYYkvzjqFEYeLqqN7NhY46d9dUPbGvSqB7zCYIrT94UynPJwoxEz3hryqbJfB
         RGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730479361; x=1731084161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdl1QU1TO9smfZlcjavKeh83DDahAr/viN7jpcXBk5k=;
        b=r8JKKw/z5JhoFIhjpeIN77UkMLTdjk8AGSnlkngxoRi5D/i9PwLM+GvpnrmxpjdtVW
         UIvQicM+FWdINCECZb2hBEI4LVfsLuv55vkfvYHsOSA5tNyHCSgDrvI691Mgded5M1hm
         bnKAscEipVoqzu38iXeumgCgDxK0b4AtZbq4WmYWz0xeFyY8kcKKCT5Pm/dK5NLX2+xS
         GDFoJAmKaBSSBOCq8svwDj16VA/5+RWSAJzGqQUJf+lABKUSxZdde6+mBKgUem35Buxz
         q6hQCSuI5o/XkJL06HOK7Fh7e6bdKVvxtKIdV9a/yEl7IfIMfw891qXgM6nW1V1WZEeK
         6t2w==
X-Forwarded-Encrypted: i=1; AJvYcCWM7sqNTSBbel8TpQtU0RDGcuQxnh+Wb+FV9K8zp3feFKJ1uW7IMko7914AFWhtpKqitm3NxTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcrPh+mYgP+L6E7PMuQFZZSkJEHMpXnEZsA/VPI3DGX8KUobq
	FxoSBlc8O44alALzpGmJMpwBphJL4uZrEefi0jEReSxUCpUY23UxXjW0GEHlmKfscoxAAPiVk1k
	zrVG6EEjjLgC3yQk3JkGsb7Vnyv3tLFUFRsf2
X-Google-Smtp-Source: AGHT+IG9mMz1RBUHXYHb/KKXWnOdSpX/tW+Owz4me+P1+nRvR/UjY6v7IpSbecbnAja/zhUSQpxNQyrM8+BVM9tybAM=
X-Received: by 2002:a05:6902:641:b0:e30:c97d:2fd9 with SMTP id
 3f1490d57ef6-e3301836be1mr3682602276.24.1730479361585; Fri, 01 Nov 2024
 09:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-3-casey@schaufler-ca.com>
 <68a956fa44249434dedf7d13cd949b35@paul-moore.com> <ZyQPfFvPD72rx4ME@calendula>
 <ZyQRgL_jWdvKgRl-@calendula> <dd727620-9823-4701-aaf1-080b03fb6ccd@schaufler-ca.com>
 <ZySCeoe3kVqKTyUh@calendula> <6a405591-40c5-4db6-bed5-8133a80b55f7@schaufler-ca.com>
 <CAHC9VhRZg5ODurJrXWbZ+DaAdEGVJYn9MhNi+bV0f4Di12P5xA@mail.gmail.com>
In-Reply-To: <CAHC9VhRZg5ODurJrXWbZ+DaAdEGVJYn9MhNi+bV0f4Di12P5xA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 12:42:30 -0400
Message-ID: <CAHC9VhQ+ig=GY1CeVGj1OrsyZtMAMBwst03b-oZ+eC2mLnqjNg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, mic@digikod.net, netdev@vger.kernel.org, 
	audit@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Nov 1, 2024 at 12:14=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 11/1/2024 12:25 AM, Pablo Neira Ayuso wrote:
> > > On Thu, Oct 31, 2024 at 04:58:13PM -0700, Casey Schaufler wrote:
> > >> On 10/31/2024 4:23 PM, Pablo Neira Ayuso wrote:
> > >>> On Fri, Nov 01, 2024 at 12:15:16AM +0100, Pablo Neira Ayuso wrote:
> > >>>> Hi Paul,
> > >>>>
> > >>>> This patch breaks nf_conntrack_netlink, Casey mentioned that he wi=
ll
> > >>>> post another series.
> > >> I have a fix, it is pretty simple. How about I send a 6/5 patch for =
it?
> > > No idea. I don't know what is the status of this series. I would
> > > suggest to repost a new series.
> >
> > I will post v4 shortly. Thanks for the feedback.
>
> Please just post a fix against v2 using lsm/dev as a base.

That should have been "against *v3* using lsm/dev as a base".

Also, since I didn't explicitly mention it, if I don't see a fix by
dinner time tonight (US East Coast), I'll revert this patchset, but
I'd like to avoid that if possible.

Sorry for the screw-up on my end folks, I was trying to get things
done before Halloween kicked off and it looks like I was a bit too
hasty in my review/merging.

--=20
paul-moore.com

