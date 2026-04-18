Return-Path: <netdev+bounces-279475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN+aJpwb42lrCAEAu9opvQ
	(envelope-from <netdev+bounces-279475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:50:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB742011E
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3FF3025D09
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95C2741B5;
	Sat, 18 Apr 2026 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNQB5Mwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2732A1BF
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776491387; cv=pass; b=cU7mZjgsSsaT5pZIFZi87XseSHG94FR7jMEU0TkLx88GHFNeISvSAAN0M8aT+GuPx0ELApgOIIPK/pUE+WpAT1jwi7yrO6GVwJ+G8g0xkkGzOJls4KOxxvD5H2E2l+5JjcdY9XkapMZGsLkPzRha86UhsD4TEjAWR8cZo5zWSNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776491387; c=relaxed/simple;
	bh=4cUsPrtKob+EBhv1tXknCqThrrPrur29uuXg8Y8HPyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9d53Jwce6h0dQkaFPkGfnneELKT0qJWnfLQsHwW35kVzXIOFXhisxTV7wCq0bDxUFqCY7h2nP0P9Zn/1hMsGfxJwIk1E6emiNKDBCvFIt1yvyCSOVCiJBBIzW93wxtjrtbFidVaBmAOLAdVtlKP3XoiJregou2ZABiLPlArVDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNQB5Mwf; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b3488fb31so29825041cf.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 22:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776491384; cv=none;
        d=google.com; s=arc-20240605;
        b=RryTkjUFK7MAQwhl2OAEgoLCgMJZDZbvrcVRwit00f193/bIp6y8kkd3Q13RmJ09Jw
         5jWeghCIM0BbnBsIuo/Gcs6B4HT9iTs7UFs16FrMsrl8k9cTnsAoWd8zsO5yHgCzomwY
         dv148TfwKJIEvnS8s3WouJhnvP64T9pdsUefRagRyTNLqCVhWkV1pDLO9SRJZn7gCSoI
         5fvmPLTtRUQS+miaLZwdB7+gVfGn1v5woSon/VS7E//0zIhhURQj/99CS3TeWCV05EoV
         0sPc/Sbl1UvDpK8VSwACAEzi6YIML1BgKtYuSjBt8AhXY/uN88ehHmLUtSqFJeS8xelh
         gLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4cUsPrtKob+EBhv1tXknCqThrrPrur29uuXg8Y8HPyk=;
        fh=dd1BK9tVnOzScPmFYs+53vJ7Ol+zPglMW3wYVmRIFE0=;
        b=CkjSeNs9ajfHUziBXU/Yd+citeAibVB+blJx+ieDnoyFGi98gSKwfcnQpqHxr8L52+
         fOQB+MvIZYkB1mnWyicz7wqbxERAZRn38r6NV+NV77BoZgmUCOqmsskkF7l0hFANmPUq
         hOXWam1mhnAb9C1/qNqO6h0USe2Y14ea77QJ8GKBZImQP3NAHYSvkd0KbJrGDntBZi4E
         WPW2fGgxpBHVCxzNi8YMZOrM4PHihRdvcz/6zYBz+zAETAxVSasc7KZMQH4kHInbU6T1
         kq2sbOjG3ZLm9FnQyoy0BQw5q/xGizMAngZjXJCcKfdbvyeQsGVPdiNkIO/d8pf3Ywa7
         F3hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776491384; x=1777096184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cUsPrtKob+EBhv1tXknCqThrrPrur29uuXg8Y8HPyk=;
        b=CNQB5MwfGkj5Xg70mQ0G4zuW9K0TcyGJZybVlE/hmpr2aYbQS2xpm/E15K0sV0fVB6
         lz/whZP5Yo5UFSwBDkgSeZIstYsp1GwxN/kwfUtUYkbeccmrccQrDPHR0VDwUbQKgsze
         kzvsTARgGhaTJRJfIsNQdw8qFFylL9kazFAyU+Fmzt92CLorD3W+JssNYw6qi9e6ntqt
         GGXpumpDs6KdjTje137g0AXMXnofizZ9IW6IBGNdtVfXHt0m9TPdIacGhjMO4dGAu8l+
         x1jerRYXwDArZ0yfR/lgXHGSyCjaG4Us6xH8X5WhxwEYrUzNhREyigqGM+BZocxdxJGg
         dLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776491384; x=1777096184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cUsPrtKob+EBhv1tXknCqThrrPrur29uuXg8Y8HPyk=;
        b=aDLgerPYHEnBwGqzuP9Xx+bpv3OOYqZDiYgYOneH1+hdYvyl9ZJXdNcEyVC+hqDS9N
         XLkzlFUKg9SXrpV523bwCjGdkN4JDwrUVJHhC5Kq88aBdPy+CJNESs4iwAcew27cQYsG
         pfFuPoWkxzIf8BzTT22FBMACMC6sDflykFfjs2OZbQpLUSYSShZg/x75VmVW4mKnl6gU
         XFgRojTHWQPC0/kEJsMVN7EH0MplSkhDki9SjPaHQnbqyWImnnsCiHGFo+8enqEJWxXV
         0HuUsdh+5kHLXSDgT4UmnMJ9cOMkESvhDNxY5cewn3hpgiEWnDJ79I6w4mWeDhslfTXz
         NrvA==
X-Forwarded-Encrypted: i=1; AFNElJ+2L7Y6xYZ3UDFjC/DTw961Jn1+l5HcpViOI8pGk3+UrJhnqtqaFBY0k3vdNY0URF0y6/h9FJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH2A3+WeCGpNAgw5OLlNhPdG8L3AyKYmj7FYAumJcNzTHlQQYH
	om7JIfNyeVVJjkvUxeZ4k2uqj2CZFpz53isQ9TGQR1rQ7Qxxzf0qW8wARH8Yfzc+gqJv6EtWNmO
	UGxC9dKpz6D4I1ZFflWdDpvI8C7meRcuFNIqOSxxK
X-Gm-Gg: AeBDietWt0gZIuUmLOXWy7S0oP/cLcdp4V6GS0QmhGAekrTReUVxoRFd2uouABK1r9T
	hq9G8vOKNr5oAkgKy9gUsgRkz+1CTi0++mrfSeEQeRUnvxI3vYbhLkz//MbqbJoCtC33EEtUgjL
	/Gl3ip/T0DFHMsqftPaIWB0P+JtwDDiWMVC7g2CLZaJq/4Eq/eGafCM1DWfXeTLV7F4L9nyDLbD
	ZPDzEvjzF/21+xggaZ1XrzDY/zsL1tBFujPmV7m2YC1aVcoTev18qt/ACgakVC06daJjuZt0f0u
	UAWQI4CAx74jYB1o1EbGgMTRfAsTYwmdbXIfIsq7UiFFqRTsHa/2H5S0dtqzz7bCHjk2jmhYX05
	uQwfvoeHQ
X-Received: by 2002:ac8:590f:0:b0:4ff:b32b:cdf9 with SMTP id
 d75a77b69052e-50e367442e0mr73284961cf.14.1776491384164; Fri, 17 Apr 2026
 22:49:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418024957.2669737-1-kuniyu@google.com> <CANn89iLL0iWoU-jh=Nk+0fsGWNOeuwQ8DP=dVUT=LjBGHR_2FA@mail.gmail.com>
 <CAAVpQUA8+eibr_0CcdKEWUhzyn6SNE8MA5uzYCJhNmWstq2OAQ@mail.gmail.com>
In-Reply-To: <CAAVpQUA8+eibr_0CcdKEWUhzyn6SNE8MA5uzYCJhNmWstq2OAQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 22:49:32 -0700
X-Gm-Features: AQROBzA25lmkfmaFT9u9PsiblNtVoKE7b_NDFqM4H3dTr3hFddbIJKJ9YjZSYjk
Message-ID: <CANn89iKxWwcqhVJz2YNHqqnwn=eqV89+qxAKGOBHrDP=2PT2iA@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Disable usec TS for SYN Cookie.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279475-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BAB742011E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> On Fri, Apr 17, 2026 at 9:59=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Fri, Apr 17, 2026 at 7:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > cookie_tcp_reqsk_alloc() sets tcp_rsk(req)->req_usec_ts to false
> > > unconditionally.
> > >
> > > If want_cookie is true in tcp_conn_request(), we should not set
> > > tcp_rsk(req)->req_usec_ts.
> > >
> > > Let's not call dst_tcp_usec_ts() for SYN Cookie.
> >
> > May I ask why ?
>
> Sorry, I missed tcp_skb_timestamp_ts() properly restores the
> cookie TS generated by cookie_init_timestamp() to ms unit.
>
> Still we don't need to call dst_tcp_usec_ts() for SYN cookie,
> but this was more like a cleanup patch.

Okay, but consider the standard path (or fast path) has to call it.
dst_tcp_usec_ts() is a mere dst_feature(dst,
RTAX_FEATURE_TCP_USEC_TS), which is pretty fast.
Adding a conditional branch won't help.

