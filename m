Return-Path: <netdev+bounces-120168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B095879F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5231F2292F
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B545A190064;
	Tue, 20 Aug 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7yxTLBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF618E039
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159472; cv=none; b=E4Vxy/f2Q+7x+EnGg7r12L3MxDMtVt+kzuh6m7+K2syw7pzqHvDpv981NeulhEgwZJcBCUV/ZZjD16ML45U41DFJVEwdWy0yn9dxPRmovLpAiUlDJ/g34UWPF9SkrYgW1gr59lYJ+zNyC6uTv2+6RJo6xCnyqjv2RNDRfl9kOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159472; c=relaxed/simple;
	bh=3qafc2OtfbKMD67zdtCMW7d/5pfl70D+vhA8CVrXaco=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDTgZ8TWmie9dxxlI+Jzszmm1ORXTdYCAHWU80E2BOhBF/09hlioZNOOoMmpVdzkxAMgOBolufahw3KfJUIH8UaWodnkeVamTOBeJQwb9trcdIwT5NYDalyHFmQDCQvEFeJDf9TMy+7UO9mvkmBLdiPFiFeDg6olC89kIRt39bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7yxTLBa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6adcb88da08so108665877b3.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724159470; x=1724764270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN3Gj5I1BDXWTy6NzwpPJel+5B5UpY04jbUUblrWOvE=;
        b=I7yxTLBa830HckJCV1o92/ReyjfJkaSKi8RV3ynL4Hnz/vSrY+u5sFo+mIeyW9JJ5f
         Tew/WjTqx0DajkvBuSFkBIciDXCRnTgK7YoH9dCIgeBUYPiZ5dmqmHeqm7EHfBj4sKe1
         eeMXkl9yzW9ZMkoLGgTrCd3OE6sYS941HoZ5wo9xw8nA5QLL+1Oo7CDkH+7VsxldDinG
         5ymRd+ZVaGcVVllc9j4Hyb79UGoCPi3PHjcNoe510Ph1asxvCXpUzu1rvLababm6H5Js
         7HDmW+djbkl+x5EfRq9TjwbIMTSrQcF/uMWo+sd/Zlten+20g9CYiMglUHz/fSBmJBdQ
         9ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724159470; x=1724764270;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lN3Gj5I1BDXWTy6NzwpPJel+5B5UpY04jbUUblrWOvE=;
        b=sjcJ0Uovl+wg9YRgdSX5djlKyxlHEDctZBbSz5z8BOgHRXCggeMsj+7MukAgIrCYbv
         eVKfPbzGa4yvySDTfUBZbWcs4+An0Sbc+pw01x+hh0UGnMQFnaJZTB9AQXkDbdqFw+5B
         nQfKHDGOMGhzjuxBmW9T0WnZ+ZpkyQ23RKh77Sf5WhbvrPuhl97Hqu5kE9VFrWK6ZtH6
         Ctr8sfM2sIBvaXhjOAm4kl6fbWlOwnhtTiphS2ZWNcNhJhLiWeKctJh4TdJkWZC4U+fD
         FXXAkUYRn8qMGTzCE0lUasDplDugjWcHYjfqBp6ewyR/jOMIAYOqstMGdK+xvSXFrYtM
         pmlg==
X-Forwarded-Encrypted: i=1; AJvYcCVeuqcOAbR1sDMAIUixJJF17yqbyhmYXfwR7U1o4H5hODrO8e3UFMhmjLjZbQq3FS4J3g9U8yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyayGhiW5/qkGWK27RumqkDx8KTM8lPMUJr2+y9eZXejkLjFeUL
	H460/CgcpYSDgSqO7nCNPgbnuH5ovQIzY0vSHv/bbF6yBDd/1M3xa28/1T9WaTLvLVTBO6rZESn
	vNA==
X-Google-Smtp-Source: AGHT+IGd0tHf+ddVWWyu0feS9WCvfyhikk3VUfmkmDZIVdINwxfp8bFrvgSQd145+65vuI0fKXQsQlsYiX0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:4e0e:b0:64a:d1b0:4f24 with SMTP id
 00721157ae682-6b1bba55dd5mr2667257b3.7.1724159470085; Tue, 20 Aug 2024
 06:11:10 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:11:07 +0200
In-Reply-To: <20240814030151.2380280-1-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814030151.2380280-1-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZsSV6-o1guJdpPfu@google.com>
Subject: Re: [RFC PATCH v2 0/9] Support TCP listen access-control
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Thanks for sending v2 of this patchset!

On Wed, Aug 14, 2024 at 11:01:42AM +0800, Mikhail Ivanov wrote:
> Hello! This is v2 RFC patch dedicated to restriction of listening sockets=
.
>=20
> It is based on the landlock's mic-next branch on top of 6.11-rc1 kernel
> version.
>=20
> Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> LANDLOCK_ACCESS_NET_BIND_TCP is useful to limit the scope of "bindable"
> ports to forbid a malicious sandboxed process to impersonate a legitimate
> server process. However, bind(2) might be used by (TCP) clients to set th=
e
> source port to a (legitimate) value. Controlling the ports that can be
> used for listening would allow (TCP) clients to explicitly bind to ports
> that are forbidden for listening.
>=20
> Such control is implemented with a new LANDLOCK_ACCESS_NET_LISTEN_TCP
> access right that restricts listening on undesired ports with listen(2).
>=20
> It's worth noticing that this access right doesn't affect changing=20
> backlog value using listen(2) on already listening socket. For this case
> test ipv4_tcp.double_listen is provided.

This is a good catch, btw, that seems like the right thing to do. =F0=9F=91=
=8D


I am overall happy with this patch set, but left a few remarks in the tests=
 so
far.  There are a few style nits here and there.

A thing that makes me uneasy is that the tests have a lot of logic in
test_restricted_net_fixture(), where instead of the test logic being
straightforward, there are conditionals to tell apart different scenarios a=
nd
expect different results.  I wish that the style of these tests was more li=
near.
This patch set is making it a little bit worse, because the logic in
test_restricted_net_fixture() increases.

I have also made some restructuring suggestions for the kernel code, in the=
 hope
that they simplify things.  If they don't because I overlooked something, w=
e can
skip that though.

=E2=80=94G=C3=BCnther

