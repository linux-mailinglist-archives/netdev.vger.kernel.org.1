Return-Path: <netdev+bounces-191148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D1ABA3BD
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68E81679D3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 19:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD425224AEE;
	Fri, 16 May 2025 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2dfVMxB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D731CEAC2
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423672; cv=none; b=ol7mg5fmwAmx1DR5/4vz/uJsPyC2cZNSVUSQ4WU1FrXBY7Bca3asfLqrxoJLvswL87qY9MkpeIg4VqPJ2z5II0435xSeXMiphLMBwVB98ovCjWV4FfITqkT4deMThGmQVphpt0vW7MKndcidRmCKF8NMjCvZxPZYEnZEhujSGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423672; c=relaxed/simple;
	bh=wKaaColbEcWJp1iI6gHdJcyWNrEm6e8Xfk6mfl3yv10=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tJP0/IKh385RVzlrmhKZxQ3TUT1ROIcqPvtNSSol+NyInaGWoQkX4i6GvjgUiXz3RwHngt0/zGDbVgm1tS6YlUvW3tvmGPVnkgWPEE2MPPkOjglKgGPodAaI9CAmY7dYUAR19zHe7iKk0qtohRH8xW2iFtakCPn29Z3QSooeDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2dfVMxB; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c55500cf80so208215185a.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747423670; x=1748028470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBt7pP5qgNhsFSY4cETCuLcqJCydoSM5+pdHfG2aFwU=;
        b=h2dfVMxBIP9y/314Znfww5wzKXKz147V89dXlj9LzbekLlDeE3uq/XnZlu4M0KIhVj
         Mh/vJoi04p8U8V8p11YC14ohjbCdYX4UEszftu0IqIPlxtkOwFiMMagR8Ea6SpqfwdwB
         QLtxTsnfB4VzpN8LpHBh0ieAPQW5AP1mwBaJyaUG2vxkb450ulGwBTiXfS4gJ+R+hh62
         32wNfVezZ8iYTn60g5cMmJBgPp8S6DWTAUXZ/8UJk7ib+OxzEl2X+WSbw9lvrDi19oiZ
         LgsTGQ2j1bm/5Y87nJPM3G3K7lvOukqJOXRNQhVfAQoc0J3KNPoERsNIrnjl7//l4gS0
         IamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423670; x=1748028470;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KBt7pP5qgNhsFSY4cETCuLcqJCydoSM5+pdHfG2aFwU=;
        b=girgLkKdd32pTwzx9KDDJBmSdWtgyzzJsPrayb1FI+AbHEDPSTcwa40xYg7XAQXOdv
         xjAY+7Zr2nK0aj59iWJYfRUBPSwU7kJdfqb9bYJfxcbuxsiWVE/GrL1KHang0IaBnrVM
         OLJty+Ru6Y9qAVsUnxG3QKt2YX6Uun+TiMEJYFefRxiyIgydK5ee+HggxJnI3X+wcM6O
         H3VTtq7i79sMqmu2hZKillVVGhvYd3nSiPugkPBReqIL1ZxgcljOrtapgSwAqRZjIcYK
         FFel10ap0uHR+02mk/iXSbLnR4aBi2Fx2NDBaylo1Oy9M46kaPcJVirFySvgd4DITCvt
         OqkA==
X-Forwarded-Encrypted: i=1; AJvYcCVDIcczs1Pdf+1cSnYMJAWz/vOHzHu+hGIWQTdjHwkhEbKHCRBaE3QbvL8DWgYnOpU9etI9Ef8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfry8nHPEpSrMZBc8jaO9Z5Ul0Rgfl/HhN4UOj8z1UXM+UsfqQ
	qzCMzgdAU/hZ+ybk7iRuGUjvESoS0TDW7I5WM+WXIXNFmGi6v+WDNRF2
X-Gm-Gg: ASbGncuv+eE59sXB0sQ+c7t4meYEztPnFr7r9flxQONsVyhZvAbt5EApQDBf2er1gSB
	vR/vPLVNuRKtIPCNBYGCcdwbJBFdMfpL2+EIcfBSQY355wxfR0PxIKp083lqB1yGFwRWiKsnl/p
	O6OQBNoMExLhnfSvgii/M8STkUpsxn6Zmd44aSQyiJ4niWN5KnjiCde2kp9nWPAVaHRTY1g0gsW
	lvvyDBjIkIO6ZwixAeVgrxcsYu65Tgd5GthUe3iuSwOgDKhVyVY/LXR94WKk/mqgaGQ8wtTVE/5
	3nMmTl4aM3Q0jZIa2sqZcB9S7S+yOSawddBoPCNAZmUr7MnoOPb6eikBn6hZuWq1vED1R5ToJfI
	tATE7Gh/3sy9tIyD6IHfGv9Y=
X-Google-Smtp-Source: AGHT+IHd9NoJ7xvMMKlkxt+CRVtSiDZbvmAhgjCBjj2DQ8zD/0g/2fba6q6Ohg22HIJasbth6AWfNA==
X-Received: by 2002:a05:620a:2802:b0:7c5:4348:183e with SMTP id af79cd13be357-7cd4672da1dmr557663585a.20.1747423669861;
        Fri, 16 May 2025 12:27:49 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468d220bsm152282185a.108.2025.05.16.12.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:27:49 -0700 (PDT)
Date: Fri, 16 May 2025 15:27:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: brauner@kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com
Message-ID: <682791b4dd9a1_2cca52294bd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250516172419.66673-1-kuniyu@amazon.com>
References: <68276c1118d32_2b92fe29428@willemb.c.googlers.com.notmuch>
 <20250516172419.66673-1-kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 7/9] af_unix: Inherit sk_flags at connect().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Fri, 16 May 2025 12:47:13 -0400
> > Kuniyuki Iwashima wrote:
> > > For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> > > are inherited from the parent listen()ing socket.
> > > 
> > > Currently, this inheritance happens at accept(), because these
> > > attributes were stored in sk->sk_socket->flags and the struct socket
> > > is not allocated until accept().
> > > 
> > > This leads to unintentional behaviour.
> > > 
> > > When a peer sends data to an embryo socket in the accept() queue,
> > > unix_maybe_add_creds() embeds credentials into the skb, even if
> > > neither the peer nor the listener has enabled these options.
> > > 
> > > If the option is enabled, the embryo socket receives the ancillary
> > > data after accept().  If not, the data is silently discarded.
> > > 
> > > This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
> > > would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
> > > descriptor was sent, it'd be game over.
> > 
> > Code LGTM, hence my Reviewed-by.
> > 
> > Just curious: could this case be handled in a way that does not
> > require receivers explicitly disabling a dangerous default mode?
> > 
> > IIUC the issue is the receiver taking a file reference using fget_raw
> > in scm_fp_copy from __scm_send, and if that is the last ref, it now
> > will hang the receiver process waiting to close this last ref?
> > 
> > If so, could the unwelcome ref be detected at accept, and taken from
> > the responsibility of this process? Worst case, assigned to some
> > zombie process.
> 
> I had the same idea and I think it's doable but complicated.
> 
> We can't detect such a hung fd until we actually do close() it (*), so
> the workaround at recvmsg() would be always call an extra fget_raw()
> and queue the fd to another task (kthread or workqueue?).
> 
> The task can't release the ref until it can ensure that the receiver
> of fd has close()d it, so the task will need to check ref == 1
> preodically.
> 
> But, once the task gets stuck, we need to add another task, or all
> fds will be leaked for a while.
> 
> 
> (*) With bpf lsm, we will be able to inspect such fd at sendmsg() but
> still can't know if it will really hang at close() especially if it's of
> NFS.
> https://github.com/q2ven/linux/commit/a9f03f88430242d231682bfe7c19623b7584505a

Thanks. Yeah, I had not thought it through as much, but this is
definitely complex. Not sure even what the is_hung condition would be
exactly.

Given that not wanting to receive untrusted FDs from untrusted peers
is quite common, perhaps a likely eventual follow-on to this series is
a per-netns sysctl to change the default.

