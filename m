Return-Path: <netdev+bounces-219736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B0CB42D45
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 01:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B090A3B36EF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C4259C98;
	Wed,  3 Sep 2025 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dybKmvnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436B32F775
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941468; cv=none; b=DiN5ufIEXmutYBrNHr9uqmmK1s8NonZoZOLsS05dVGN8MLQA454aYmaBW4vwJQZ0cTeLV5kj4oFgi1+2VhpakZbnLGRTuNgR9tXv/lRhzf7ORQ5ZNjtmfJM8Cx9td4saKYMi6gqkAQzF5ssopFse7vUuyTM+Mvv6BytHJq1uSoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941468; c=relaxed/simple;
	bh=CL0UQKHeFAeKYytwKaMnrKI/oiLvCPtOmNdScKbzt5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3gx3NgmRXFf1kdIJJhh6TB49qPAEejXL7eFJ7QXz2Q3tKIDaBPiZQeI/U0CgwIEMt11E5fBXOxsoKAGtIO+sACKs0KCCRmmO3K/4u9xTcAPWY8MuxqMJmk1l7IA0zzT79g3NCt+ihu0BmRzeyf0Nv3ulxPbG0rlfiHxTSzOpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=dybKmvnx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47173749dbso239064a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756941466; x=1757546266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkLytKk0F+mcrLFLoKny4gT/DGyLbmcZKBHsU7/uGGI=;
        b=dybKmvnxdxNBBOyMC6A1Hg928KpZTIE8FS4GjsV5xF4rVob6kdHnyYxIIdfKflaAeZ
         GUhc6ZPbNzr6Bv6FhT2qULIeH3jrUkUdZUTELApN2CXMA1veHyRNuCmPiJhChk6R8xs/
         dikYHtUbIG8EPerpFqqsvmyPj2t4mB2Tvw6qNA9YbRFSXJ3W/xDGiKW6VhEAKuubu/zB
         VJckxONvXU3rdZSGedzCNVw/ZcIH47LSnapPSKRbtS65VAiehKYJ5D1W/BysPdPrTKBZ
         9FBPcu1PAOxUcPODP4J1jSZOhsp+0nFFeN8GiwSDmEJMyA+2hX8s2/Ui/kC1T67C9nR9
         1qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941466; x=1757546266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkLytKk0F+mcrLFLoKny4gT/DGyLbmcZKBHsU7/uGGI=;
        b=vsSBaO8DgZVClPgFtpTS3cq+6UJsXuY22Ep5ifexPuh/IEm/QJFoLpJWmqRO1yi8fX
         9yVp+ZGVPqdCzBhY3Oy3bc8qgihPU6F6YDqNv9K5zZpNZ9Amhg125gRtXMJvPX5Zgw3E
         UVMcsh7K1Kman2iYr+8s5IkQ8hKeB9tVvpkHpvDg81+WIXEXbEjDI9CMF3ZsJlHRoEyp
         uSvd3wAW89Caxb1f908EYu0UnhasXdbQv3Fin2o+6f3eVE/bZy5cwn7kNU/1OIIfrSNt
         1bEatk98V2MQOnh8nxLjPJj3e1zylF3mq7nuwa0XK/oULdPD9OZKyshYRYo/enTUJRTL
         qkDw==
X-Forwarded-Encrypted: i=1; AJvYcCW6FEa2r3Y8JbrOc9kpmfGza2uaGQjiAVqahSKp4aDqXgzwwuDSRxWEpIV6bAH0Cqt2vjYdygw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnvndtq0VciNIV5jMLYzvP0Nds5yqBFTDdhsRpNsOQUKUnzkRu
	aPGHryb6Fl10e0FihHo4HymBvFmJdVrJxQajh4rjaXI78dZgNcweg1qeljSAXbLupAQJfC5AWSt
	ptds0eZryBKMf8Gooivs14Jfm8BQGZH9UmW8S2VdE
X-Gm-Gg: ASbGncsXr8JLN9SixXabHxXVK4n0q+t+aVo8sMVg7JI3JJ0J/dQJNIg8xNYwSMCY95U
	ZnP1on51sf0kqFbwjw5D3lu01MsA5txFocdF4tPui/lRqllsz0yJG6NouVzOM3k4lMpgcwC4Dmq
	LMnQp4n78sSq3RzpKwqWYUsjsNwb5hGtnb7GPSgzXQXqs4UZGLrH+3rJpan8yb2q47ehU8JxI8Q
	5/VY9dRYHFRImiNIT3dFzyn28wTBFuYgy1jT7f9SOaZHn4FphCw+eCY93FgwiN6WxqLrouRWeJg
	953nGBryhWTZ86xdPPDYnQ==
X-Google-Smtp-Source: AGHT+IFhxtDQVDa6LZXo7J9DiC/8b0oih5DuwHzcLELXLnzuGVPULslhDSQUy7MKs9lywPezWpqkyjhkghnqW1y2cL4=
X-Received: by 2002:a17:903:1ab0:b0:246:76ed:e25d with SMTP id
 d9443c01a7336-24944b15b8cmr209598675ad.50.1756941466531; Wed, 03 Sep 2025
 16:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
 <20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
 <20250902160858.0b237301@kernel.org> <CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
 <20250903152331.2e31b3cf@kernel.org>
In-Reply-To: <20250903152331.2e31b3cf@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Thu, 4 Sep 2025 00:17:34 +0100
X-Gm-Features: Ac12FXyyy_gj7FyaNK9Ji_76uhk24Wy2vOB8JA_2EMYfRrYXPoL-9MEPDggYIDA
Message-ID: <CAGrbwDTT-T=v672DR4wJU0qw_yO2QCMQ4OyuLjw+6Y=zSu5xfw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan <gilligan@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:23=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Wed, 3 Sep 2025 18:41:39 +0100 Dmitry Safonov wrote:
> > > On Sat, 30 Aug 2025 05:31:47 +0100 Dmitry Safonov via B4 Relay wrote:
> > > > Now that the destruction of info/keys is delayed until the socket
> > > > destructor, it's safe to use kfree() without an RCU callback.
> > > > As either socket was yet in TCP_CLOSE state or the socket refcounte=
r is
> > > > zero and no one can discover it anymore, it's safe to release memor=
y
> > > > straight away.
> > > > Similar thing was possible for twsk already.
> > >
> > > After this patch the rcu members of struct tcp_ao* seem to no longer
> > > be used?
> >
> > Right. I'll remove tcp_ao_info::rcu in v4.
> > For tcp_ao_key it's needed for the regular key rotation, as well as
> > for tcp_md5sig_key.
>
> Hm, maybe I missed something. I did a test allmodconfig build yesterday
> and while the md5sig_key rcu was still needed, removing the ao_key
> didn't cause issues. But it was just a quick test I didn't even config
> kconfig is sane.

Hmm, probably CONFIG_TCP_AO was off?
tcp_ao_delete_key() does call_rcu(&key->rcu, tcp_ao_key_free_rcu).

Looking at the code now, I guess what I could have done even more is
migrating tcp_sock::ao_info (and tcp_timewait_sock::ao_info) from
rcu_*() helpers to acquire/release ones. Somewhat feeling uneasy about
going that far just yet. Should I do it with another cleanup on the
top, what do you think?

Thanks,
           Dmitry

