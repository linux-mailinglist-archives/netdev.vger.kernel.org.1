Return-Path: <netdev+bounces-184813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721C3A97482
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 20:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06F04412D3
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65622B8CE;
	Tue, 22 Apr 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilxjxbXO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB71F150A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346671; cv=none; b=qvU4cMDPd4eEbCLyFc/IfsC9YE8ndAikqxZ9x8T52pDlWFso9+HLGGaoNSiDn1mwe+1SwBkJU7STZbfBV3QhpO+4auipunmCapQf9BH0VQD4khegt+h8O/TvNZ1Rg8LFhOOGr/ziM855CIxSescuw7OgCpjF8FyrcLdiCwl4IXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346671; c=relaxed/simple;
	bh=sP2y8V4iFyPf2hZIH31J/Re3lgO9Dig+sImIP/b6z6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOWXUHWg56vS3zZ5SX7qxjbiolc59ymFW+SjptT67yKaZSprKen0J32G1/I0CIUMH2gTqK2VdXoIYFZ7SpZRyYBCKO4icxeN7fZdhhZHTWZoNvGQ2wSlMihISPgjggJU5Xa+YwWKQAoZO9QCbDxYW7agnGqqU18Ftftt8glkfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ilxjxbXO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240aad70f2so35315ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745346667; x=1745951467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sP2y8V4iFyPf2hZIH31J/Re3lgO9Dig+sImIP/b6z6w=;
        b=ilxjxbXOuTQ4UDhuo6Q/I+1zouv0bSU55lQhUHxDPuA7AZNMRYntEOowSBwr8/Jbsw
         0hZ77Fk/1qrdqG5O469IBNdO8p7ZonY6u1QfAoAYcrg/xLXRyNX8un6mLOFf5UY4p4Zr
         E6YR9ZTOE+n3oDApVroPf190ZvHoc5bR02KRgcJcUtU5YyC+X1tBQsNz1kqroovRqJK9
         T527qXOmL158uUcjLEyjTn4bMEX0Z2sNWmcDp6D7ecyl6vk7S0a/XVo06y3vfcXel33/
         qVHNIUBn0NAkq4wIlgHf2D8rjRJUnaIDXLj0g3SqInbCwjVI+dtsEeiH45GYRG8r9tmZ
         GTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745346667; x=1745951467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP2y8V4iFyPf2hZIH31J/Re3lgO9Dig+sImIP/b6z6w=;
        b=TYtWIMILVRazzUTve6XzGQ87es65Bfw87lWujag76Y8C/nT8x8S67fAUu+vMX/6tOj
         bZsmwpcOlDAFBQGx2De6xt1C4LtSIQ/ZeJ4MLDF3ptgVCdKqK7EEdx4WoptcFiFX7Wnu
         0AC924NbHM9b+rjcyRVlbSN+vUiqBhAgOOScmnNyNepgrjyodLppLbRbs8REDrakTSx2
         ajlgB/bln2D7E3iJotokk3/vv29tjemarwJY3OOfAMa/Z1mfVheS0PFzCKVcyY1SCYiv
         2534y5FZAOE5sZorYrskgKFMShf5db1E5RbUOkCL3h2Nqg+aOysgSLskniYT+6vpNu55
         TebA==
X-Gm-Message-State: AOJu0Yyu7bnrYKdGImEwBhsId5UtxW0cDBd3RCK1/Idhe8r/Xw/XYGdW
	0Dp0WGcm/TjcMpt453lV4YM5M/JaC6cwbya3ifAr8/g8Ut7KUZ2Wm4NrhY+qeYRXMcpTA3Cez3H
	pmYJQ1HhpVek1L4QqdD67qYrtNYP/vVF7nTko
X-Gm-Gg: ASbGncuLgLZXkhM6m8uPMzF+vZifL+gs45oR36RTffXingxHt3SgNJMHGXTjCPR2IVh
	rPsai7Xd5pMXCBOGyg4GqJ3eddxx9tRwMSTmDGtE1+biI9nT1p67XKOUWaab5CYHQFVnlOHtjiV
	yr27FlefnnTTSkr02/AJ7FE2gzckI3nJiiEwoKqpkNqXtQvRwXHLpd
X-Google-Smtp-Source: AGHT+IHwBVYqmkFHBIkZqvpRm8yJ+UXOUekkq6sAIy3oK50GRp6r1rxb5Xt4sDCK8GoLsViDZQiuddnPCapKhvr8aTg=
X-Received: by 2002:a17:902:8c82:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-22da2e9587cmr103215ad.25.1745346667017; Tue, 22 Apr 2025
 11:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417231540.2780723-1-almasrymina@google.com>
 <20250417231540.2780723-3-almasrymina@google.com> <484ecaad-56de-4c0d-b7fa-a3337557b0bf@gmail.com>
 <CAHS8izPw9maOMqLALTLc22eOKnutyLK9azOs4FzO1pfaY8xE6g@mail.gmail.com> <957b74ed-f29c-4bb8-b819-af4e1168d6c1@gmail.com>
In-Reply-To: <957b74ed-f29c-4bb8-b819-af4e1168d6c1@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 22 Apr 2025 11:30:54 -0700
X-Gm-Features: ATxdqUGAYmhnej_FvEeRx5rp6OZSN2G5JXdVv0CxCE5OSvY5qcT3QiMIj5aAdEw
Message-ID: <CAHS8izM8+zG6KOhV7ysTsCj_PEty5eL+P+uUxTZhdsOSZTwmow@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/9] net: add get_netmem/put_netmem support
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:19=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 4/22/25 14:56, Mina Almasry wrote:
> > On Tue, Apr 22, 2025 at 1:43=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 4/18/25 00:15, Mina Almasry wrote:
> >>> Currently net_iovs support only pp ref counts, and do not support a
> >>> page ref equivalent.
> >>
> >> Makes me wonder why it's needed. In theory, nobody should ever be
> >> taking page references without going through struct ubuf_info
> >> handling first, all in kernel users of these pages should always
> >> be paired with ubuf_info, as it's user memory, it's not stable,
> >> and without ubuf_info the user is allowed to overwrite it.
> >>
> >
> > The concern about the stability of the from-userspace data is already
> > called out in the MSG_ZEROCOPY documentation that we're piggybacking
> > devmem TX onto:
>
> Sure, I didn't object that. There is no problem as long as the
> ubuf_info semantics is followed, which by extension mean that
> any ref manipulation should already be gated on ubuf_info, and
> there should be no need in changing generic paths.
>

I'm sorry I'm not following. skb_frag_ref is how the net stack obtains
references on an skb_frag, regardless on whether the frag is a
MSG_ZEROCOPY one with ubuf info, or a regular tx frag without a
ubuf_info, or even an io_uring frag which I think have the
msg->ubuf_info like we discussed previously. I don't see the net stack
in the current code special casing how it obtains refs on frags, and I
don't see the need to add special casing. Can you elaborate in more
detail what is the gating you expect, and why? Are you asking that I
check the skb has a ubuf_info before allowing to grab the reference on
the dmabuf binding? Or something else?


--=20
Thanks,
Mina

