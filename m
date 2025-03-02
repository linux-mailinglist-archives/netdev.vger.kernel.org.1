Return-Path: <netdev+bounces-171038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E8BA4B409
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 19:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2FF7A4305
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 18:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C41E9B38;
	Sun,  2 Mar 2025 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCQ6PmkS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6B21E9B18
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740939854; cv=none; b=qsfIkMDNI/xUFDkgXkvAnhUilQ1iglIFPqQgbM26dfO3PI94YmUIfNYEnC+l303ZkEB77mmN1ajaTmHbWSqBAVkfTtNwotGhEgVz6ExoqohDX1Hai0CvOJqfHsHNIy673ZMSvYTMAORAonRbLkCvR6BV1e82Es7YPIZwfXNdB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740939854; c=relaxed/simple;
	bh=C9zY6t1+EC2nhlm1/e9Yr9bkvfNrm/Ne0NMCOeDtcDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+xuWiUDPYDOBowp+4b5vFocq327AXyokIxt2UFsW+cVMX1lzBJyu1F5N9/9IDAX+4lJacEa3QZGe0iAqMeD29AtOe8kX6I3TlkGgNe9XR5Dkpca0IMpxZpMc2+Qn2Q7C7BDTH3QMm3vi98cFJS7nJgh1Brrh/HijeIw96njQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rCQ6PmkS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46c8474d8f6so33625631cf.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740939852; x=1741544652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eplFgMaQsQyB+/Zy+raMLdi8B0lOyb9eqEbr6SEobIY=;
        b=rCQ6PmkSDgFk7OK6BOiESAekxK25VytSdURbdetsk1sqZkw7H7E+F8NXNmPzCfNzFt
         jnppyguQneGEone8CZ3NEhbWy6BA+9kt0B//H69zEptAJRT2s6xaOyU2XqXQxiSjGD9+
         cxuhUuea79Le694SIhtkTJ3CffW3FU5dYYGpWGgYvsNDQXAAZWD5SWZgV1GrffwFZ1q4
         jqJgL+x8eMk9Kwp9jYQkLZFqPebRZPYvz99qus93puLILKAy82gD/8CfSeNtEcSmjDYc
         gANNTmXb+nhu40igd3jTnSYXWX/4OH0g+S4BCMbXrOR48Kk+Jqr/HeSJVZX9gE/4JuwB
         whWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740939852; x=1741544652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eplFgMaQsQyB+/Zy+raMLdi8B0lOyb9eqEbr6SEobIY=;
        b=vEC6CGkTI9XkOzDcCYk/yreEed215FJftO+/50ZcTPnqskZKwDpT5F26OCDGbP1fqw
         Vc3yh6mHcxYpggo4LQhwoRmpcoMPTTBJnfEdx3ShrJTwV2yxGFNX2d4uPHRPvomYI5N6
         +hpYtfMZHDiT82wBvF12xj1psBVrWdKMmagoKLfbD5MkYUVtgQB6p/qHTgJhLaSAn8yt
         bCK9XX5aEITiR0skaJpBPpAuHDNgoawjiDSSeXdQiffd9CYTDSbb6PhQYpb2Th088RSx
         NrQ28iS0muEP1OQf/8xq4BEwjmjAnFYFPdvCA2kTRCKKdyPzZl1FApAR8EMXcicnXRKS
         hQIg==
X-Forwarded-Encrypted: i=1; AJvYcCVoAe8CTMLWNM9Xmb5UIzPh7wMvMjswcQ8FRLxGag4b3Qy8Yk8mr0JWMW62w0xf7hPBkTqOm7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpizC961n6CwDomWHnuk3dSqQR5cxMLtaJYTN5bCYtdvgICwc
	8QQ2v16OigGXCGWDijO+9vZPX1lLjcQ2dfraFEjIvpP2Rgof9hP1itEIKZP0Q5G5as0wgxhtY4A
	re6p979EHpJ08XF1ZyC0SFKKqTb/Q268OUEg7
X-Gm-Gg: ASbGncvB6OXAn4o1oBP8znLZIM8vlGHkf7CgUj0etTj8HSeQqiVLq2XEvv/09gHTAfd
	9ALkLZTnl5mXtrsHh2aqWDZmp7O84RCSt0hnUle1yn9m1CpZOAfJ2c51bHa9K+ADMTPv98dbBhp
	tBR2/tsVajn7MSUsUHn+rMNGxA
X-Google-Smtp-Source: AGHT+IHoUp0qt690gXNPlU7guXUDhkYKEDbwO5J8amkbaeQJ9dEnWaV7+9NCNo2WRt5tUi1lg142+lTNChtitwgUcIo=
X-Received: by 2002:a05:622a:293:b0:472:3f6:92a2 with SMTP id
 d75a77b69052e-474bc0ee7d8mr177701781cf.38.1740939851650; Sun, 02 Mar 2025
 10:24:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302160657.127253-1-cgoettsche@seltendoof.de> <20250302160657.127253-7-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-7-cgoettsche@seltendoof.de>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 2 Mar 2025 19:24:00 +0100
X-Gm-Features: AQ5f1Jr0FDOQ9D4KLNOprqJYo7eUxi0ui0k4VkgLi_xZ_6fJwr97NMU8vRrNx1Q
Message-ID: <CANn89iLDDfWJqtxnC463t5aM_p4-4iUjVNfvuxZs=_DXeThGww@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] ipv4: reorder capability check last
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	cocci@inria.fr, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 5:07=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

