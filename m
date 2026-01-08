Return-Path: <netdev+bounces-248280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB7FD0674C
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 700CE3020490
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721A328613;
	Thu,  8 Jan 2026 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGQejxtf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7D2D0615
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912429; cv=pass; b=tO/fv+JWNKnVPXVl0cM7WOPlb0uavI6+yu1WXbFJxffUZSiVmjkHTtuishOj4Y5OC054xK/3aioxJGYkbo9POauboz/NUE6la5tNhbg63jTHODrUtmzZOU5Kalz7whAdOIqonLqpOGYI2US2sMV8AsyzYV/bSS4IXv3HBini7rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912429; c=relaxed/simple;
	bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIZxmHfdLnhEuvAsu3nMEdum0S8vCEa5irU/vcGRsxVsyOEopx3yT69NdMMTAlbYgqpXzPiwdZ/4KO5buzwpFMDZ9fQqph4fzUflz782/uu887ey/J2BsEGb+iychBW+BKMxmpdByjHNJ5Oek8yT13PDwNhoDgN2TkwhjaplA0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGQejxtf; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edb8d6e98aso180241cf.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 14:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912427; cv=none;
        d=google.com; s=arc-20240605;
        b=NYhG19lSbmvV5YnWqUrUcvRcIJ/WXDUG/f3td+hFPAmBItsO+rME4DanjrleVJVvcR
         xwTCD7StbGeplH4iU0KzwyFzhXbuAXbAHJfmI59EGYCf+HxQF6qamE+E8TaZbge4QqXG
         7yUl3UyvsD8kStu3dvcveAF4qMFNyo1n3oULs2Cwn+M6vGI9Nx70LCa+Mm0GCmMFRiPB
         W/zh2r+B+kLIBqsWQAcPJnAVRmxkfKwaS0CJUFdwCxLeGWMQ69NhDQkzUZk3YNLT+NH8
         zeDBHUw/00EOZ5nKPiEFG7KZp4Bz/gfnABnvRwi6b34aeNIHyJjvqz9r1pzVZS2Ld/uz
         FdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        fh=XDylHoCimzop9AAgTRuj0QeXQqbe/kd7huiScx40AF0=;
        b=eySXZMygE8GRwffuk3klhBd//Rke3ehMnxMOujBe7de1kcqh+zOqdRKH+mC+XUI1t+
         3amNVtHGUE6Atdi5ncJNJeqZ1DCqcLbQ5uQ23nVaL+uyxrcv0Cjibws6tuZp1rIRQBHw
         9vIjPGsHhJcGLXWvXET92+928ln/dBRmXgWWRhSxFw20BnPJr3tAtuUsqcv3CWs8jlvC
         tv50xthNIvIak/e28FSXMcxWkvpGVlhmmv60O/o6Zr+BK6IVk8RNvUCX/L8CFncZMFhe
         KaQD90FHPldZrxjIuT14K7pNLPlt7vWXzRlR6Mrs1uVJZUZluX8PNEqXY1egFSMW9Zf5
         Xpqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912427; x=1768517227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        b=NGQejxtf2Jaa+RGslgJRJN+JXurmKYzqnYxfVp8GPq3Zay9NOOR7eoF3Zscb/0kT6J
         BRXM3Koq5aNwJG6Xs9rIRhTbWIS1/1hmL4glbb95HoB6mT9RiMEOHNw6wIc1rTBTILlQ
         HwEosyqJ9ExuavMPnseG6vxblXkOSut6IYTp95WMS6rKmy+V0pF3ZDuR6+RlfSJf+XRg
         hUmJu81DWN5mH9KtOy99zamcPFbKZf+e4BVQIa3fw50k7Kazafz5+mfgGrzwZ+uMJwdU
         rsi1333NfXMsMETzrVe+4gUN7q86gY2CLx3o3Yzo5e/opPEzxJi1AQzEnFwZNeYNTgcs
         yE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912427; x=1768517227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05M7G+yD5bg2zpxfBRZSfkHw88GfIvX7aX3Dn7f4FHo=;
        b=U18XBGMErRkH28AQ5KK6V7nzoJt6vdpQMFekwuVk5Wxd1zM67iLBZSdvId+vHuX9th
         T3BMDccXlI/bA0BEj4V4Wq4C0P1lMypyQfW6eAreOLqPjjN0QJa7ICrizq0B+TrO+FBB
         MW8+bJ2Ieq+rVzR4NFWY7ep5WjFAXyN8IoSw8gPSsc+x92iu2QFlcxdn1GXmwr9MutCX
         2jWZ8TQYaK0GfHZb7+KhCeLYtQSEX40lTE52rB+IPu9dXUuqCpNuHQrVpyYkzH+iAvqi
         VEDHFco6jw7uqiL6S29+2z74IzmajZVyjUpPWGTAMt+pl4jWPAF49Sm2RPR2s7+v9fEL
         2FLg==
X-Forwarded-Encrypted: i=1; AJvYcCUV8vYc3bWpIK46v7ALTsoCqOpo7sh5A5UwP5eE8xKEjg8KiuGVTTghnTlqNLNqknS9VjbJpCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmSr5Z+uDgh0QLzdRbfWwzgThtshXJP9O59bpBJZjLFYVwADM
	3Usfa2Yp8BgiUWg0udvULI4C2GdQFDDuRydlww5sDBmbbHyrrQFKNkGNQX+jnFWu99WIEvzXIaP
	GY5j6srxSSClNosl2LBvtz2uI3GCxo3h5oSCy4VGy
X-Gm-Gg: AY/fxX73KXsVlFcgn+LFKQ2++8W5hnegqB88OE1aanHKLVAXDiaj37VmaaEtiznOEOU
	sFaxrNmUiBtVTCrTpyd5tMJE3Z0AuUx2r1wrptY7Mbxz5b0cqFF/ru5U/ssZH8ROlgysRpI0Y8T
	a4S60IW6tOjU4xgOnZHxS0DZ7nKyKcnR7PxrB1RZyiph+wGc1OV/g36m0xjDCp7rL/K2RrJp3jB
	HE6cj6kuO+eg1bn58w0CkB9QVnqkT9PK3jY25cIeOX3GFiUo/ZrkIGkCaaKTyLsmsw5sjiCrvEK
	ruwNv8CQ5EhbtReXzvCUkxEh1Rz7CxDvw8KC6IBUurWNK4Y879jLp9TeBwBqIXTE7NMvQA==
X-Received: by 2002:ac8:5782:0:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-4ffca3ad29bmr3817721cf.18.1767912426910; Thu, 08 Jan 2026
 14:47:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com> <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:46:47 -0500
X-Gm-Features: AQt7F2ovG-v9G1YvqpyTasF2O1QIEJ_BUtc_E8UKj2kCrrVV8U2__Yy5KoIU4r0
Message-ID: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Linux Accurate ECN test sets using ACE counters and AccECN options to
> cover several scenarios: Connection teardown, different ACK conditions,
> counter wrapping, SACK space grabbing, fallback schemes, negotiation
> retransmission/reorder/loss, AccECN option drop/loss, different
> handshake reflectors, data with marking, and different sysctl values.
>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> ---

Chia-Yu, thank you for posting the packetdrill tests.

A couple thoughts:

(1) These tests are using the experimental AccECN packetdrill support
that is not in mainline packetdrill yet. Can you please share the
github URL for the version of packetdrill you used? I will work on
merging the appropriate experimental AccECN packetdrill support into
the Google packetdrill mainline branch.

(2) The last I heard, the tools/testing/selftests/net/packetdrill/
infrastructure does not run tests in subdirectories of that
packetdrill/ directory, and that is why all the tests in
tools/testing/selftests/net/packetdrill/ are in a single directory.
When you run these tests, do all the tests actually get run? Just
wanted to check this. :-)

Thanks!
neal

