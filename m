Return-Path: <netdev+bounces-222051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A4B52EBE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB14E188C731
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C3430E857;
	Thu, 11 Sep 2025 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/vy/uXH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD830C354
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587169; cv=none; b=HcxEC+2scYXKVElgbUzLHAx1+xHIbm4ePwGTT2cyGl4YK+QXFGk9LiKYUCrq7p9JaiqlK81kduEUALGmnTXHO8lb5YpTgz+7z5Rph0FrO7MWoCat0ice9ukIinf4eW0WiCpLMU5eUtPYs24szHP5p2SyCQRzUombK5mlK7ZscFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587169; c=relaxed/simple;
	bh=i3K4Fxf7hfpTZXUakuir9VBvWZAWa30Q3SjDrMBWzpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2lveYK23RHfjlo6HGPAUGMWJDKl6PR+GycJ9q+YXCrc3pj73co7mRMD4FerOLhLDuxni1AtgyvCtRhVqlZ/HWHRFKjPr5DlDwh9yFObv4U3g4WF0swjR3Gmst6NGTWquf4Do/U9D3OgtuS6jGP/e7J2tNwjh5PdL7VdLixQz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/vy/uXH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-80a6937c99bso51730485a.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757587167; x=1758191967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/5NZRakXMPSefxzoUTWOFF7jXrb0Qk67PQkNmcLMfM=;
        b=G/vy/uXH4hHaInZrUtcu+gbfF2UZyccQx4XnA3wTYLPdasbltn7qXFSemjaE8ktMAa
         TeWwTnYowdTL3bHAjQ8IlQJmJl8R+4HKZgVnQNCl4VBz0j7FAdZtNkMYOTFZyagPJmII
         mxzM4xeJ/OA8vH4kq6taAJaboA08DoDCA09qxRFP4/WpS/ibDfDYKtrC1MZLWVeTLajV
         1YMRyBRe1TIUYzz3mReZALnmrUdiWDCX/zcZbK87z2J/exJDSOGk9ouZSux9etq21L9K
         pwKow4u2vwEgcuB697KarH8VZcWnv8LVW0WqRkYv4W0wSkUKGd3dvQPC0m1NSHNZdETo
         JY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587167; x=1758191967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/5NZRakXMPSefxzoUTWOFF7jXrb0Qk67PQkNmcLMfM=;
        b=VmL7e/0ND0oeJ3FSg/YONSswQdkoR5oFItSlzKTeo+tzx40+zZftgDSoqTNXombN6Z
         wgNP9mqJ5bsO49tugT9RHIBUyYySDSYTxmt2JeqgUGOQTN1No+8nHIRmJ0U1F5c9sWPV
         fEshvCFmdSZe0J59F6yNZqw78ppyXU0MU1XqMZlriF74HDfZb8q/79v73zSeICEdPo+e
         uMfQudxUfJWfr6F0ADRNu1lreBBJTcl3t9TVfzPABn1X/MOxkLBCO4MvQIcCWlcWmwOd
         iIbVu12hm8cVHdr4HWrtAWYNwgukULwIfhNmLXAK6nrkhXm1wXOYLOySS8ERJmIJEFLK
         aa4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFk9PdqcLDa1LKYDQFW7iC2VDJvSIW7fsYvTfDdHbYawE/Otk3vdfziIlIDXyOFUzwC+zcYvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHmTsRlwbIEIQHErP2+bAE22lrkCW8jMq4Do6BxAptajIbRuW
	YIIOgGsOiCduj4eKA53jarA8ETsYpcYH2PcYXujdXGsB2OLBW3mVvd1Wy3ZrJyD623iB9qJ/Pra
	leMFN3PQ0MOuegtYAMHHQ2rjPAMuktrcB14VezNrf
X-Gm-Gg: ASbGncuEmdoaCjiqX3yhccscefsBZg3e59qAWAwktfJcaAyfDmiZaHq9R5qlpnL0q3F
	GDZDZ6axmfnzTzDodpewsBNNBWaMIAnsVYp6NXxUDFvNEeVMSfk6Vwyu5A+Um63eXHD0siWv0Pz
	17ngvIGYrHbLPJa1vzUy9TaAoLo6iQV2o+Bj8A5C8qFVOOVwOGG908eywqSm1D/GNIyZ5+dRhmr
	yF2WiOtdnMDjyHmAnTrlnnZ
X-Google-Smtp-Source: AGHT+IF13RHUxixDCnJaQJD5HYKG53fEjs1UREQfhmAQiVkkh3Z8KzpXFO+znykAoH6YQe4Wu+wBZD5IVHQdxauw0gI=
X-Received: by 2002:a05:620a:191a:b0:812:693c:bce4 with SMTP id
 af79cd13be357-813c596ff46mr2299523985a.39.1757587166519; Thu, 11 Sep 2025
 03:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:39:14 -0700
X-Gm-Features: Ac12FXwjNGPxnTzV9uOkde1KbfezAZ4pzyFGGkehM4wIScw1o9g0Jk-pKtQTlfw
Message-ID: <CANn89iJzdnwtJcEwdyAzNF206bYzmHKqNGoBF7G2pR101ZWS+Q@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 14/14] tcp: accecn: try to fit AccECN option
 with SACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and attempt to fit the AccECN option
> there by reducing the number of SACK blocks. However, it will
> never go below two SACK blocks because of the AccECN option.
>
> As the AccECN option is often not put to every ACK, the space
> hijack is usually only temporary. Depending on the reuqired
> AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
> AccECN spec) and the NOPs used for alignment of other
> TCP options, up to two SACK blocks will be reduced. Please
> find below tables for more details:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | Number of | Required | Remaining |  Number of  |    Final    |
> |   SACK    |  AccECN  |  option   |  reduced    |  number of  |
> |  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |  x (<=3D2)  |  0 to 3  |    any    |      0      |      x      |
> +-----------+----------+-----------+-------------+-------------+
> |     3     |    0     |    any    |      0      |      3      |
> |     3     |    1     |    <4     |      1      |      2      |
> |     3     |    1     |    >=3D4    |      0      |      3      |
> |     3     |    2     |    <8     |      1      |      2      |
> |     3     |    2     |    >=3D8    |      0      |      3      |
> |     3     |    3     |    <12    |      1      |      2      |
> |     3     |    3     |    >=3D12   |      0      |      3      |
> +-----------+----------+-----------+-------------+-------------+
> |  y (>=3D4)  |    0     |    any    |      0      |      y      |
> |  y (>=3D4)  |    1     |    <4     |      1      |     y-1     |
> |  y (>=3D4)  |    1     |    >=3D4    |      0      |      y      |
> |  y (>=3D4)  |    2     |    <8     |      1      |     y-1     |
> |  y (>=3D4)  |    2     |    >=3D8    |      0      |      y      |
> |  y (>=3D4)  |    3     |    <4     |      2      |     y-2     |
> |  y (>=3D4)  |    3     |    <12    |      1      |     y-1     |
> |  y (>=3D4)  |    3     |    >=3D12   |      0      |      y      |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

