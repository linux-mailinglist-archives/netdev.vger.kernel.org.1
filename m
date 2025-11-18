Return-Path: <netdev+bounces-239351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DDC67191
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6753355693
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8600325739;
	Tue, 18 Nov 2025 03:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c02o6LWy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D261F0E25
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763435269; cv=none; b=FxTH17TaAQmaUZC55GEtUNi//3jkb4kt7mioyFRGukAQovSI5Ip0yZ9KQwQAsEeue9MfMydpo96TA8PNtf8Rhh+kLieTSyf8OVCEmtNd/AluQGNzK+gL7eX3XSjGAdsveTIqshjUVfHWZxvt9sIjR42mm+clp5Ndkhh7UapHnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763435269; c=relaxed/simple;
	bh=NX6U8f00q+VcZ95+loQ0jHEcHnIl69DhBUz85HU4M/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSsr6mYDf87WvBE16azDAV/ocLyMskMbP3cSb4HTYUrJZTHOVayQtkXfUWZWknTtFS8y6pfWHRUZKBW0/giEUjUz34AKyLfPnDsvlak6M83eMlXeFsYzJYdzLrUvAUHZQTEzHRrz01gutZk8dTa9uNT0i/OPOZHow6bfpCMOj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c02o6LWy; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b9387df58cso1086937b3a.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 19:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763435266; x=1764040066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdGrmOw/Xgr1cOfHjdhcnsFYof9VRqzEVKZDxxLslIg=;
        b=c02o6LWy3O92iFPjwnOK0DgOLygl79pU2GLNao2kVZtVcbshz/IsP5QVcpzZ2gnVQ9
         aszdmM3ReTKJhg6jqPu2XCgffh6bxeciSxwlF+YhbAzNpRXIRwxFbF9zVitlazH8T2ox
         UM+ZBmz1nCAu6aMXRRceRDPpnq+wfobcrAJx8S/d6zL72zerqZ2SW7NdufTLqkmBzdMN
         FbWcKUd0GoD4krR1tTx7tNlIqKIaHulC9TFAiZAlDKqOheqSbbnwZ4uM8OkP3u74TLjT
         f46oh6V2PfLXyjYdr3gaAkeKBMYYu8d6RCJuvuYaddylGX/8Gs7LdwkPU4+4EctVKMFp
         5Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763435266; x=1764040066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdGrmOw/Xgr1cOfHjdhcnsFYof9VRqzEVKZDxxLslIg=;
        b=juvQqzqH5tIL05wKiuxXSa2Rwi0o96purNkSG37yMWCiTp5xBxmiHe6Bp35JL7KEBD
         luc20yKYtOcHuvwYqw7u44yFCVhUq8L1+C4O0uPxJmmaxy+kOfDZdKI1yQkA8KZhJNgz
         oxr3c+3lyBva3bQjNMUYcKushd5nrxBaiHwW/IJeExQ6qyd8wpm+uVsY7haNyENXhRvW
         l38IF+AiYAtj0uwLOg3KW0CKAb3PsV63tioOYSOOKvG5jDrOSQDnlHlA3RkE9IGWQitp
         uKYND6xmrzQrh6us33uMHct6gbSlbqOdWbgTxWl0RU1CI1MI3MAxENN3HVpRWlHpNgFg
         3R7A==
X-Forwarded-Encrypted: i=1; AJvYcCU0mPr/PSgiugTEPxf+gLCEi0VPT5/tQvil8CsHz8BZ60aqUwwBW0wVYgdEONpOEy1nLJtQuo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fnyDr01EFF65pjPXhlw78z9OhiH37YYO9l7fKedRYevkW0Qm
	HuOyxqRP+W9goUQ+mLLOL4l2OoE+I3klLeBWxsAQjv9du2U/VFdxCR7RIZGgj3kVLZ6ONaXKHt5
	3qX57r33IKv6eDu8d+3Q9q9dQ+vGcfXNGV8TkAfx4
X-Gm-Gg: ASbGncuFlBOQC7dJcOuEypXVdqef1MgfxMbsufzBcNWAY3VV7v3T1JN4GtXDx4l7S9S
	RVcgBiRpLq4uD8bx5D4hSQ9SHFPQv82BVOtHb2U3riEXoap4hyHYC9//4OYUvrAZJfyhUARqogW
	0BNrXORwa+QmpBg1FVkC3vVcDDAq/ldpZFyrioOJ5bG/B/S/enkQg2a2WQUyWAabxVzI8q9AJIQ
	AffS7lJUpjKYPAvHt/zkgVipESfQBqEATzM65V+z7hSGrNjYrn3mQVfK4F35yQ5wbwLKe24w4zj
	s/RYjKLYOeAuqdXcg4e+EdgfZV0=
X-Google-Smtp-Source: AGHT+IEUi1zkZSdTsVlYkJmnDd46UIPamMywbLYW1WxeXM9KlLNw8MiPaYRnG/9hXYw5AiaBiE9Jtq9jtUu4/cCqEpE=
X-Received: by 2002:a05:7022:3c0d:b0:11b:8278:9f3a with SMTP id
 a92af1059eb24-11b82789fd2mr3703974c88.8.1763435266055; Mon, 17 Nov 2025
 19:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117174740.3684604-1-kuniyu@google.com> <20251117174740.3684604-3-kuniyu@google.com>
 <20251117172628.784c23a4@kernel.org>
In-Reply-To: <20251117172628.784c23a4@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 17 Nov 2025 19:07:34 -0800
X-Gm-Features: AWmQ_blZoiOpeEzA4iPMDJlIX7_zwdb1CIEIM2IK7oQKUEezYxpwdwe5vU_ifD4
Message-ID: <CAAVpQUCMxSnJ=mt3R3Prkrtc=tqQm1QMRzcCJVFJXJiOtYKJNg@mail.gmail.com>
Subject: Re: [PATCH v1 net 2/2] selftest: af_unix: Add test for SO_PEEK_OFF.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Aaron Conole <aconole@bytheb.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 17 Nov 2025 17:47:11 +0000 Kuniyuki Iwashima wrote:
> > diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/sel=
ftests/net/.gitignore
> > index 439101b518ee..8f9850a71f54 100644
> > --- a/tools/testing/selftests/net/.gitignore
> > +++ b/tools/testing/selftests/net/.gitignore
> > @@ -45,6 +45,7 @@ skf_net_off
> >  socket
> >  so_incoming_cpu
> >  so_netns_cookie
> > +so_peek_off
>
> NIPA is complaining that we're missing the binary name in gitignore.
> Probably not worth respinning for this but in the future let's start
> using af_unix/.gitignore rather than the parent's .gitignore?

Sure, I'll move all of them under af_unix in net-next, including
this one.

https://patchwork.kernel.org/project/netdevbpf/patch/20251113112802.44657-1=
-adelodunolaoluwa@yahoo.com/

Thanks!

