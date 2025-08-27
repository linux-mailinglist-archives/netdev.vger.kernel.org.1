Return-Path: <netdev+bounces-217159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2974DB379E9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF105178B7C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C9426A08C;
	Wed, 27 Aug 2025 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Qx6gLpn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728038DEC
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272883; cv=none; b=f0NevRkVEXh2I8eZ0x0VZSO1PvZAAmKQHHRbjpzUhGYTDEmHtNU+j75xk1oQewn1mf9vvfPP0KGQqJkG26fc1enA/ZhwQahuUexstmVqW3uCnNeaDS0gfRaDkdRe8zYAJhnHs8iWNbKrw98sLzbOh6m2jecOzrrerLE9ipBZBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272883; c=relaxed/simple;
	bh=w4SmnV3o7FEuEzstGX6u0LiNO1WiMA7yc55CJXGItCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/RJKT8PY5DcypkMw7AQBYkfrj2K9o0dJPpubH0vv1qFTO6Enzhgz1pTrC2Kj+YCM0jzdNsPgurazCC50H98Z+S+/tYGyUmmYDJuyPMWMVvkxEtytKCyGAg7fpi7+MCsTsAVkXYaTEiToOLW2Jq6Yw5agiF/tkXkRfFp67MQSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Qx6gLpn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47052620a6so436421a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 22:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756272881; x=1756877681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4SmnV3o7FEuEzstGX6u0LiNO1WiMA7yc55CJXGItCc=;
        b=2Qx6gLpnVcHU4DYchuMEvgxz5LI1T+HAlkOziS4zm5nbyI+V6DvQ4ZYUVTgp8FIM0p
         GPcitwIpBAH9QMz/NcZR9U9ac8h5BeCFVMII6EWnu1PKgrmeAE5P0P/E26ckJ4KSkvDY
         LeGPHIL443eFp4sJaiDho795VR5WvCiO1FpO4PF5YTZD2qXS/o4O0DOQ944mvJb46D+F
         mWJ+fY7HDFck2rnR43B7QfPqp3CjwzjSrmqkylvDxn79HkLxOkHmDyaarW6UN78PED8m
         mARnBrHyLJ6QrTkr9tiY4Pd1xmpoi4ShPGc4CJWW4VTyT11sKQSEDqInIuwF2LhgD2Hk
         FVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756272881; x=1756877681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4SmnV3o7FEuEzstGX6u0LiNO1WiMA7yc55CJXGItCc=;
        b=q14tRtype58N1xyunswvNeEiiNLibWQgpSfdHD1iaLu9Wpmh5xK1Je9zhMC9725epR
         ywu/hj9x/IQqESR3GE8DCGpTAVGVd+wzxIg8WN/FBeUU1x1TktaQ0VWyzO5bsHgmcIoZ
         JtMER9TuwsdtgK/1OTpc3STvOb/OU7+mtCpSvGohopTdxrbYzAnj3+C0Hu5VeCcsltYc
         RkcSt9t1N9sbBHaY61qGJAkRG1DdOTMh9D9scnTcRJIogY8+Mpio07falLlsMdP8YUHX
         wfh4VhyDEp+uDoKJKMo3b1pLoewryNTjBcSP4dREQWHqrda3oRXFgeyxwgXTEqojDuTb
         PFrw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6W23dIVta2wPK5L467HnSAN9w2g+1O6xpraXMHIu+ahVBhplJYBU67XIrJ7F4bZaw82HKbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHiVtupmbdTYkTjgEeDC5soMYKpOu1diALjgd78WgQcXkb0+h0
	uxy1DGLhRzlKUHnCPj7UO9z01sWu1c105Mtyy5syFNAdnCFgmvd59/GrYLzwe4XRpX78lof83aK
	A6UVV2JIfNkk5b5nDrYwaOgAfPEXlyzSnc4tmKvFi
X-Gm-Gg: ASbGncvg120qcHtS7CjqbkWISYLwJhSNWCOfYbcTqMD0xZ9V5VXGPWqjx0kqDdUM18S
	1BBJhcjJ6NUb01ava1rkPy8ox2r6xj4eq7pWb3RUS2EeI7csFWu8vv9mOL09Lx6TKRl2POdfD67
	ny7inEL08Soc0aEJRsPzh+48geGKU1wdmlHy/5wcH69fA/94F3lmmTcx/scGAe+aleyHZTxuwEE
	zM+42G+6mqRIgmMsCZTbhj4ErA6lnqgdeGaYM3aFYOnd9WTI3Edete79WOXARA/C0OGbHMSaMPR
	Gf+FqBaTJAduCg==
X-Google-Smtp-Source: AGHT+IFcst9jUSDcU24ETZK4vGROUrdI3e8uWMvoIgKhox+xB5SegWOGtf53fZKermWdypvJemd2seR6ZOBD2hTwd2c=
X-Received: by 2002:a17:902:ce90:b0:246:d769:3018 with SMTP id
 d9443c01a7336-248753a2757mr55525995ad.12.1756272881063; Tue, 26 Aug 2025
 22:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com> <20250826125031.1578842-6-edumazet@google.com>
In-Reply-To: <20250826125031.1578842-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 22:34:29 -0700
X-Gm-Features: Ac12FXyQk78HkHsVDf6CkHabGpL2gf1VMArm_QSCtVuPhza1g_aqi54z_BhnkAM
Message-ID: <CAAVpQUBVBQ63nMTYBwhUiBU2=tiyBdHE9cnnajEH2UpY7dc=mg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/5] inet: raw: add drop_counters to raw sockets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:50=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When a packet flood hits one or more RAW sockets, many cpus
> have to update sk->sk_drops.
>
> This slows down other cpus, because currently
> sk_drops is in sock_write_rx group.
>
> Add a socket_drop_counters structure to raw sockets.
>
> Using dedicated cache lines to hold drop counters
> makes sure that consumers no longer suffer from
> false sharing if/when producers only change sk->sk_drops.
>
> This adds 128 bytes per RAW socket.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thank you, Eric !

