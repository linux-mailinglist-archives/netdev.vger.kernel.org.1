Return-Path: <netdev+bounces-215732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC636B300E8
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3EA27AAB96
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1757C9F;
	Thu, 21 Aug 2025 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaciyfwD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328852E7649
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796899; cv=none; b=hsFRirkN5HF3h0pRJ3dLOABzONTspAqCApuLVJ+sDRGUSWWhNh/eOnvh4Bp9P7EYS19iPQuPr5SnHk2gCYBAnQ2j/GnbZhmlc0cFeS7DXiolDco2hpkrM6hK+VKkwUYpDS1qIlTzpdNF0sajGjvWRbpwiuN6en7vYv5wUaScEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796899; c=relaxed/simple;
	bh=jhSdhfajMKWkH3Sx1/QMnwPaCNFX3aeh6F2oCsv0eRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ir7bXtosD5tVh3u1eGTTh7YgC9FhO4Of/brCD7XSRjN5kD/6GBkXf4n9uMySWOi3JJ9I5nAySYEGbwNJu1ivizXqi+ofnOqtlMcXv/+aIikL+2b7UP3E1h5GgrmLVGjJmP+c0Hc1Zmhn92i1Pz51qRCjnkQ8xOAWoEhl2cicWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaciyfwD; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-324fb2bb058so630671a91.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755796897; x=1756401697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsLelUz1X3m5/SwzdHJKElFJC7H+QlIB2zY1zPZbjuM=;
        b=kaciyfwD8QPxd73QQ/7M/en8rtKrj+CqmI56DK6rgHHD9XDruwXWIx3dvpQOTTb/Hi
         JOkUtGvBAWTfI19x5ICLE6HKpiF4zt+bYx5PQaiXMzqfUu2buFMA8VWoGWavSKHfgETq
         iUXUgGTRfw6a0UARUcMf/Ap1ismLR0VRWbOwP8hg4a+qLTymI4KlJcxFdJflfczhoBh5
         yKFSxmLLgv+kVahgMOEDQUxeGa+qlf53Y7ZqeimXNBgPovHxKeCka3cpmL/0ccuxi7wN
         youoN5dG+TW8OGZE1xrQQali3lJoqS6htQkbaz+Pp+TRhpGoO8Z3Uw+E4THu8k91tSln
         rY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755796897; x=1756401697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsLelUz1X3m5/SwzdHJKElFJC7H+QlIB2zY1zPZbjuM=;
        b=hHNDXRs6UCeo3ItIgrscWMe6vnYnHUR2Yv7qjyhbo/6csQkFwZLknXqBtIFtz/DRVX
         vskgHP5Col6IADWv3einmZqq1XeoSNMJjBlUboABFfwlHL+RlKUFHpdzoQ6pF/f6jk4E
         ufwjyTR0TuUxUHEz3jF/pEP6kL5qNcO1IY0CTC42XhBcFBukIKnJi6r8FVNmUFntzLwK
         GfjOjyKhLLhnTVkVPDM5478HKlFzHA98Kv5dvogoIxdMp57WfoV33Ct6nLvuZ2vM0Aaw
         tDI72r70H4c/fPvy8+L8C6VT7N3xGRGmmY3+2K3vbxIf+GTtQd3ZlPIEkttZj3ptUDsi
         6Z1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/yS+XIUh50lwbaGQwEmU3ykgF61WpQomUj+66HOBPLwcDymdsP3oauH6V9GUayrzZkTixRuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTL3rscHfJ6PYt2TxYCf0Q6DdII1wYqkRUE4cKJLxqhDcgt+8L
	OBDUWzh/Nr/t1hHWyqDHhRv48ZIJ82aNiK4mIMDuMkFVAnuKvS2QnP+baJZbWS4BJIOIkvqjynl
	UORUggBycnC4Wi9EocvEg5diRD7WDg3ISkQOYtb40
X-Gm-Gg: ASbGncsmWO1S81t6BRv1+qrsnwCu+c6DIHxXs5+FrPR5tBSeUYtJVZAElTLqN8i/0FT
	MEwQSPhyXrXzGUyCKKQQvNsZZXO2oDY2H0Ps+f45rwMFcfA3jAFIAu2wMbl67WaRkhvbQ9iCRu+
	khUVxiA7+AClHueb5TkaRxp33s+8/P7yzx/cFPqunxx/qXERI0DfgxV3fV5A1LFmObRsRVwEfMB
	1nNyoEdBf6MyTAJ+r1MNWorqk6xDJqtlQnoORoeUxsb
X-Google-Smtp-Source: AGHT+IE7ufW058LIqgbHPXYCW2wceqzM/UySLSMVNlKXvN/EAatlgsCbcbQPaUS2HM0W+S2HFJdILvQf24bFvuC5qmI=
X-Received: by 2002:a17:90b:1e04:b0:323:2722:fcb9 with SMTP id
 98e67ed59e1d1-32515e2f0e6mr399955a91.1.1755796897036; Thu, 21 Aug 2025
 10:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com> <20250821061540.2876953-2-kuniyu@google.com>
 <CANn89iLmj7vFhONUPGqCDZinBXy=q6kdG2bXVvsc5KmtTveGBg@mail.gmail.com>
In-Reply-To: <CANn89iLmj7vFhONUPGqCDZinBXy=q6kdG2bXVvsc5KmtTveGBg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 21 Aug 2025 10:21:25 -0700
X-Gm-Features: Ac12FXyHmE_XHgZVEweH5XXgutZITQqtsZ8tJO3hyvjrSB3hdqt_S8VxLb8SW0Y
Message-ID: <CAAVpQUCz6DSqDA_-fk=YEW21T_sDTQ0y-0SA6ActmDtOVXU9SQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/7] tcp: Remove sk_protocol test for tcp_twsk_unique().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:51=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 20, 2025 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > From: "Kuniyuki Iwashima <kuniyu@amazon.com>
>
> Oh well.
>
> >
> > Commit 383eed2de529 ("tcp: get rid of twsk_unique()") added
> > sk->sk_protocol test in  __inet_check_established() and
> > __inet6_check_established() to remove twsk_unique() and call
> > tcp_twsk_unique() directly.
> >
> > DCCP has gone, and the condition is always true.
> >
> > Let's remove the sk_protocol test.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Please fix the From:  because Kuniyuki Iwashima <kuniyu@amazon.com> is
> no longer a valid email address.

Oh sorry, I completely missed that due to mailmap.
WIl fix up the address for patch 1~3.

$ git log
...
commit 2e799f4dc4624c719ca17859c27f7314ff4165d6
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Mon Mar 17 04:18:11 2025

    tcp: Remove sk_protocol test for tcp_twsk_unique().

$ git log --no-use-mailmap
...
commit 2e799f4dc4624c719ca17859c27f7314ff4165d6
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Mon Mar 17 04:18:11 2025

