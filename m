Return-Path: <netdev+bounces-251412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B1AD3C3EE
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34FA454535D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434743D1CBC;
	Tue, 20 Jan 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfLiBtRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B553AE703
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901501; cv=pass; b=LKJcCRmwYYOwvaUj6nmPQxQVZcczyCdbJAkn25Ll44sZmDHZJUrSphQoJfuVkAeq4gzShCRy6kj533jbnP1Grh5+aYhSIV9qep8m3HCiFeLiUvaxGfDYfNDCcAHatq9NdxjYFkRj6gPzdXwU7yQKZkvg+SYpi577SOieQ7GlAr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901501; c=relaxed/simple;
	bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6zfhRlfJgRcDkMZK0pxEDCxj9W6pb7eilaIFnr8ofYQkEN8I7e04dd7Zamz/mfhA6dRupbXhuAYYMM76L7btzgA1ZleBVm6Z7PJeEakMqgGg4PzX8lFx9fxMp5ssRZBMfmEnFxLBooN0p93DhRvLlOP7o92yZmLtTWk4Xx+fmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfLiBtRU; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5014453a0faso46610031cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 01:31:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901498; cv=none;
        d=google.com; s=arc-20240605;
        b=bOxh5DIC82+4mAyP31s2t2l3z7U63iSZy+ahxtcdavhlbdaU2EIRfTIEVdzwfz/lzz
         FhkoNikkPfr/meF9LmWGZXPO5RDBvE8djK0zLJzSXxytMUH4efahOn3mpGxF+Unbpc0X
         ACJfTtV1Kv8NFFv3cNvaXTExIt7ygEtc7XuopJji1ds0Wdyu09TFxUjUgHa+GCWVswbo
         k1F2OrSEp7jkBW0iw4WENRlb9w6me19woNAB718I3uB56tIk3bvbEOReEPv6qGAp84jF
         HSKAM3bVkJfzBef7IGNZDLGLt1JhY3nWDSwjuxFl+2d22cJ9AS2TFjOQh3iBLLz/3Brs
         3j5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        fh=cKZN4CB2LVnZ5qiJTyKg7DMPLYgEbS0BuVvN+yE3yBA=;
        b=jq8NJJO1ZvJIacG8k00RAFZoQ+ZaLzsZt7SgAAPLJ3PVbdKibjVtuGYkGZa+A6dVOp
         cQHShGgY1isb938y/IUJjGaJX0y7moVSwgnhfIkMuDyZRhe+eqgtrUrxc3/5joIVMkuW
         b7RfX65pfSe9UyYxIfGBnDpUHxWYqvGY+/4XtttutuvCG1rJuOrQUn3HgvlQELQN3rJR
         ktKnxfVIjCPd5Zu8XsMUgG0G4MwCoCZ1S1YkXCWWzIB92uN+9gdY1/+NBQ7Pp8F82cqs
         e3PKhlz+su4H3qrS+zC+cwhcUfN1+NSrUbhWQjYjjk3+3omKGbwMBWHxapeHnhkq1P46
         D+Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768901498; x=1769506298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        b=cfLiBtRUY91o1o/2kdjpF6ig7LYi7EPEZBSDpd6sW+a+YUXfBhjr2fEpeJHr/015Cc
         y3f+JrmBg1mKHTe05WzmWcYGC03H178P2oJgzcw/O9Fm6NRXwFO8u2bWbUpEkHP9mLvp
         t+xAIGzN4zaDvXk1aK93G4QDnyRb3DLhJ73yFixua2wxE32One8eS93fCOLb+uiNxmAy
         BScqEPXqiiXneMfSKZwiWmSonyS3UrrWuGo6aNOAzDakMSUK85syqFqGfWFLiWPXPyVH
         Ze4Q3kxWmFwXuahQBxI7ix6gS2n5U+Jn5xmg1ALoVlYeiXEz5IVEQq/KSULpY1uXg2cQ
         u3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901498; x=1769506298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r2OPr/mJb/5L9shYQDg8Js1LfKdBpkN1T6SX5DgIz24=;
        b=rtcINhsD5T20KUbrcCMd3IkXO0R5pYq4wqQrOTWuB1LDQSonFZ0IVdz97/kLGtFq/Y
         ISh2vEPfAhY12pOmMknobNIJ/vRLpKrFtXfqZBhwerEvWDjBSviryUeZyZ8X4rXV6aoH
         c8I+JKxCNm8/97rsSn3v+NsqDqfGo0C8mTTE6nxi0aR5zrtmZeYmfUGw5SfASFYDpLr9
         Kg8j09BywVyQyMSffCOVzjpd19bCE1zqD0NsKwwSo3GE5jf7QBfsG1wcG1+NZPqAA/64
         9BcQQM9TC0seUrdsCp2CVPrLws3kNiR28waMqEOgom3/rNSfXWrRT61f7rJFPebhXfXJ
         pbLw==
X-Forwarded-Encrypted: i=1; AJvYcCWM9Wi2vVf9Ok6WN7PB/mJWh4ZQ3k38Rr3ujjDYAzwHnUX032Vh4ax5jKEGsLqx6opfTQS+i5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZicczcubgK0WtBl1mTVG9JDG2wEEeWMCBG+MkA9lDxDz53zyy
	AnEAM5xzOd4GgzMvurU1tG3pvGImj7JajesTsnDl7oXgz3+xeLTt6hngMx1gK03M22hvdV2vTiF
	I8anYlg6P3N2wnfM4PhNNc4bUWOAvGVJEOBvmTEBX
X-Gm-Gg: AY/fxX6qqmh0uDGo+TRD8TH91HgufafTJOQ1we8lMU0vYjCnj63m2vEBinLP8KlNXah
	haTXwn5ZZxJUhaXVvXpizbmUPiq2Z2TIY4KgqCcsNtKzN7xkEPBlvR8fPxTgNn9Roqe1cjTMFGq
	dvqa8zFQ/syinBiIekTvEecYlAMdw7CzaM8Kyxz/8lrZR/8RV0lFZVpsbKvsHvUJ5miUxvRhhkS
	dG3YuEUMqQMfFh+4Scrf9or5zZw57haAVGABT1pAF05S7zcz9F1uH9B27rw1VRZKfIg4Gc=
X-Received: by 2002:a05:622a:c8:b0:501:51b6:cd3e with SMTP id
 d75a77b69052e-502d84eabe5mr13635181cf.29.1768901497982; Tue, 20 Jan 2026
 01:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-3-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:31:26 +0100
X-Gm-Features: AZwV_Qj1Jnn01ns8cO1Mwqdo9iNbvBF-noKKnseassUVD5Rb4EGhtZz-4l3C_i8
Message-ID: <CANn89i++X8hRu5nc4ChyYxf=J1kT0QF0sMOW8BLkwpNWi+bkiw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 02/15] gro: flushing when CWR is set
 negatively affects AccECN
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
>
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.

Reviewed-by: Eric Dumazet <edumazet@google.com>

