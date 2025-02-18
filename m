Return-Path: <netdev+bounces-167348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E37A39DCD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6B188B998
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F8269883;
	Tue, 18 Feb 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxLRvodw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B593208
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886220; cv=none; b=jF5PfqsvmbVP9EO4P2Kz5erQ96LQYxKxZNR4zpTUDcVF0gtEeKjmwPdrEDHUxhvJEHoG1npfHC+VrpsXqACLfJVnpBzCJqluXBwcLZlhkZcsNngJY6QDedGwD2hoPQp97yZ6/S1X9e3+wrK/G8QAn8mUXqK0vlfyQbiOYGesTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886220; c=relaxed/simple;
	bh=IxeD4L8gNeShVHK/5CMPh0DZqaAtgTEhL42g7JbTpuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEVXU5l48k/QhdOFuEXHwlhU9nV9U2IvhYR4lK/uap/DotvpM3W29K+JizIrD4Anu/KjhGTgen35WQrln3BkBsMqhHbYX1UWdHLm+6VdSmLj4yNi+RosMAXefBWR0cJuoA7vYo7KFrRN1InjG4dYr9LBdkw0ms4/zdxS6lK+dwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxLRvodw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec111762bso1271148466b.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739886217; x=1740491017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1/5RtnU+j5CK2IuSl81hZ3mCVg47V+sW6achAvJI5k=;
        b=FxLRvodwQdSVpsdrZ5idH5E4qF226iNaP1HGPdSCrAc28HxZvsKNcDQ4wATyuNA/jA
         Uz2J0TsGA0a6z6/EcYjuvQzIKLVUScUU4SjTsEuU8qitRWlWUKHKUBzJ4gfJLWcKY5cA
         F3mQOfNA/rmKBIqsOR5TO7SXFgOQpQ8FWaf8QzQDtYV8VkttDKtxEE8bxm5YxWcO5kdD
         jRaopuXBkcsl2YPTXJsEei4iB3d/m+uzI7LtF2ZSCAz03G3gGZZnO38in0P+yru9qt3g
         iK4eD78dbt71IFaEyjWnlAR6QXXtZLn9T2gU7Wmytrp1uzL7fqUXJSkQC380MuH3fDY5
         aotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739886217; x=1740491017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1/5RtnU+j5CK2IuSl81hZ3mCVg47V+sW6achAvJI5k=;
        b=QzBPOSWWEI+OC7ra6AiGKT29hw7i9a0uVVcxqgjZDadiVXgmmvhi9k5Ivxd+AvBaZc
         i/foBqHYC5sqe0qgtXXrFt6UWKan4S07BlUOMBwzUesGuPqyvX8/vP7AKEdOmu98gbRB
         ydDTDuOMJUXX9diFx0NfYp3DC1/7fq5NzPEfO13kj/gO8j1aH6hvysts1Qsm76EEbfIm
         ND0OnxgEXAIh66bdazTXA3JiiwQmR0uhgt/KgS04i44Dq/6iIL3Hv14aFY23xZclMzE6
         taGBBWj8Aa+qU0oHfW3RHeEvvdZTthHTRg0ApCzYSnHd5REHBS1sXwYd/KmODc0AjlLE
         cTbA==
X-Gm-Message-State: AOJu0YyYW7PPLHC/qRUW7Xg0yF2nYHkuwcIgrCzRxYemzs3RlwOY9h9y
	/fogR1y3spIM8Q9ng42GW9ScW4zpRr6O5TcrJb3BRSdgNm0bZ5ehRzwvylG8QQ/0uZ8mJu1zaS3
	B2jV6Hssz0nmz0ZVXbbUiwC75nUxOtkgq7Yzo
X-Gm-Gg: ASbGnct43YesKbpeFIMZVePyVUnzfQslTHGPBQk9nk27beFgZfTqr6YrwiRXyHoxXZ4
	1xaJHGhbZ2YD8oUaUhCxQ1rrolFjHtA0EkQtc1DRugRF5m7myYqxAanJZbZkIgw+p5YWHOcX4
X-Google-Smtp-Source: AGHT+IFfZ64FWB55orJPQ8KKPZHQBZZKZ22prXQucjR2bGd4fLsm5omY0Bs8A514SjXKnBLd1gQwkqwYFCjSQJQRbJI=
X-Received: by 2002:a17:907:3687:b0:ab3:60eb:f8b6 with SMTP id
 a640c23a62f3a-abb7114d65cmr1429428366b.56.1739886216824; Tue, 18 Feb 2025
 05:43:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com> <41482213-e600-4024-9ca7-a085ac50f2db@redhat.com>
In-Reply-To: <41482213-e600-4024-9ca7-a085ac50f2db@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 14:43:25 +0100
X-Gm-Features: AWEUYZkGxt4bLc9916cFdr4GOmGOtE4imJ7v4CN2WPwIYUqBHlULjXAPjKLA_Qw
Message-ID: <CANn89iLbe2fpLUvMJk-0Keaz1yvWb7WUe9X-3Gd5wmNQn7DN9w@mail.gmail.com>
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:48=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/12/25 9:47 PM, Eric Dumazet wrote:
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 5b2b04835688f65daa25ca208e29775326520e1e..a14ab14c14f1bd6275ab2d1=
d93bf230b6be14f49
> > 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -56,7 +56,11 @@ DECLARE_PER_CPU(u32, tcp_tw_isn);
> >
> >  void tcp_time_wait(struct sock *sk, int state, int timeo);
> >
> > -#define MAX_TCP_HEADER L1_CACHE_ALIGN(128 + MAX_HEADER)
> > +#define MAX_TCP_HEADER L1_CACHE_ALIGN(64 + MAX_HEADER)
>
> I'm sorry for the latency following-up here, I really want to avoid
> another fiasco.
>
> If I read correctly, you see the warning on top of my patch because you
> have the above chunk in your local tree, am I correct?

Not at all, simply using upstream trees, perhaps a different .config
than yours ?

I think I suggested to change MAX_TCP_HEADER like this because max TCP
header is 60 bytes.

Add to this MAX_HEADER, and round to a cache line, this comes to :

#define MAX_TCP_HEADER L1_CACHE_ALIGN(64 + MAX_HEADER)

This standalone change certainly can be done much later in net-next


>
> If so, would you be ok to split the change in a 'net' patch doing the
> minimal fix (basically the initially posted patch) and following-up on
> net-next to adjust MAX_TCP_HEADER and SKB_SMALL_HEAD_SIZE as you suggest?
>
> I have a vague fear some encap scenario may suffer from the reduced TCP
> headroom, I would refrain from pushing such change on stable, if possible=
.

Then MAX_HEADER might be too small ?

