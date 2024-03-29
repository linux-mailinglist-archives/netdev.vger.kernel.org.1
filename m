Return-Path: <netdev+bounces-83389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9889219A
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515431C267E7
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9085942;
	Fri, 29 Mar 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MduQLk26"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A865E20;
	Fri, 29 Mar 2024 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729586; cv=none; b=BWZHz29TxTsasJtbxAZKdCjLNCjMM0SFaeE8oMbgBy+jHWjYkhIZsfnXOaotBef8p1UuSoo0Vn3tAAnVeChEdjqSXangX3673g6VzFtz6dN/Wu6Of74JVjj0ztrLEwIvDKXImysXU/3GgQ9rEnQZA82Me5rHTLKxJSGluYNCFkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729586; c=relaxed/simple;
	bh=ZfdeSDZyUoyVGZhWFDNiSHorbeTndK4UK53Mvf7uFo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etPLJxxWPjghCSQUnFLE6qkpx7JQx38e7ijSjWYzdp+Aezz10Rrlp4XG7cache3BWv3Lq3K2Qz82ezWyScXDkWxw0pqJSX8W5U0uXjfUhLMfjolKKElb7OO6urPvmEJyn4EPIGX9hBUtyDjRLVHhv1uyA1WUgFkLAOoYQMyz9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MduQLk26; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34175878e30so1568168f8f.3;
        Fri, 29 Mar 2024 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711729583; x=1712334383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfdeSDZyUoyVGZhWFDNiSHorbeTndK4UK53Mvf7uFo8=;
        b=MduQLk26YARYS5vFolAgHHGJM3iogT+OX+qF1PixWOD5lz/yDeUSsUq8N6sdlbwJhs
         csfUA0bnmDPriR47r62XWd2FxNFdzPyod+ugezvfk5ZT6JhL/N1zKvx0LZMIK4vh+Szr
         LlsdI69AT661MLVYnVue4BcLSB+EJn76bdV8S6N+k+7k8iPwuV3iypTENiQz7tWuur+m
         73oXFxpkDS/fKnAVdX4twAwfv74/bv+d09J6Lra0YUzGT32u9C9fGJ4z7tHBKHU+Q4K9
         3P+F3VJPkkjEFjGcUn02W1pgoM2vwKQlE0gpoEc+7gHUFFxEXxkNshTK4suLgi2NGqm1
         /UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729583; x=1712334383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfdeSDZyUoyVGZhWFDNiSHorbeTndK4UK53Mvf7uFo8=;
        b=M51reHGuX/Ad4Wl8Un4ycwX5eMOtjywUZU4sIG9hLR6xC3iuAPwJA39bWaLXFj1WRO
         HBYtE02kLfYbZ2TU56+3oKxVI0YOm0td5cIzETk4z5ePBfRHWiW7OEIxB40BSFMNtFR9
         ohgSvK1GRbgFpwaYD8QTtzh+LB1gXmoC27JgQNzF0E8F8akGKzynNnaXTH1UO2zuudba
         zFCpEB0UnTpZgoMmU5w/KYzQ0FGNwaCPmvdTr5zFD8AKjTV14MO9oETJsY8x7aEOSwqM
         fR93lf8DqhXNUa0IpJC02XOTsR4tlhv3uMTigv9DRRg27zVDwsd0SNCVKr+RRT7yEakg
         JZWA==
X-Forwarded-Encrypted: i=1; AJvYcCWBFnnfPxeu49/wdzUTNVwviUHxNiQxTfP2KTSYsRsfdhWtApFDhCJw7WDxrmoNZipwD7BAJwkpd/vZhX75wGq1VRgAtn++QYb7oXFPtEJw5E8Knvhk/eMilFi6
X-Gm-Message-State: AOJu0YxQiaLYa8NBcphMs7ae5+aVx0Y0OxesSOPetATVjQ515am2nUSQ
	7vQvMJa3LAqXSX4SoE+y7l7CenzK0TbcxvRYV5qixDcB4n3yiCHVomcDymqx5m7yIQmY7v/sKni
	gg+ff4mxV2Jc9qTYemQ5WrO0tpZk=
X-Google-Smtp-Source: AGHT+IETtvjx4NNWC3qw2df5n/klO6jKAlk9IS4rH7gLZXioeVYAxV8gaTkFtOQqbzf3O+r41Bw026nYdblS12KIRAY=
X-Received: by 2002:adf:fe12:0:b0:33e:7065:78f2 with SMTP id
 n18-20020adffe12000000b0033e706578f2mr2039828wrr.40.1711729582785; Fri, 29
 Mar 2024 09:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
 <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
 <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
 <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
 <CAADnVQKXcEhL680E85=rrYuu4eVvVTH60kYRY_VnAKzZo1qKYg@mail.gmail.com>
 <649dc1dc-ca80-4686-ae37-62d7c81dde8b@linux.dev> <5fe3398c-0ed6-48b8-a5b4-2cc7329b554a@kernel.org>
In-Reply-To: <5fe3398c-0ed6-48b8-a5b4-2cc7329b554a@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Mar 2024 09:26:11 -0700
Message-ID: <CAADnVQJxsqbJgu9K-ML2-1tRcgEmHY-UuQOCDxqv8_6iVkW7Tg@mail.gmail.com>
Subject: Re: mptcp splat
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Paolo Abeni <pabeni@redhat.com>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 10:35=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Martin,
>
> On 27/03/2024 23:16, Martin KaFai Lau wrote:
>
> (...)
>
> > Unrelated, is there a way to tell if a tcp_sock is a subflow?
>
> Yes, you can use "sk_is_mptcp(sk)". Please note that this 'sk' *has* to
> be a tcp_sock, this is not checked by the helper.
>
> That's what is used with bpf_mptcp_sock_from_subflow()
>
> https://elixir.bootlin.com/linux/latest/source/net/mptcp/bpf.c#L15
>
> > bpf prog
> > can use it to decide if it wants to setsockopt on a subflow or not.
> I think it is important to keep the possibility to set socket options
> per subflow. If the original issue discussed here is limited to
> set_rcvlowat(), best to address it there.


All makes sense to me.

Paolo,
could you send an official patch?

