Return-Path: <netdev+bounces-178141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3EA74E2D
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF153AB021
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8BB1CCB40;
	Fri, 28 Mar 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HR+uczkC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F6C2FA
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743177733; cv=none; b=nlHRr4IvQy22CLNAjRt5PHOU63teY7dZttF6uKhDKdmSDa5Z21iitOcLQyAnuPb/sne15Sw5nvNz4FY4zrJw1MQrczpRzuJYRVwadNyMvBHbc9V58N3KDYeTAm6gidjLDvG8SkA6VjImeUZfgAmcmWOs55SB8oaCWu1PH1eOsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743177733; c=relaxed/simple;
	bh=qYBYMvjeXDPAYzY2e1Wu2w4F6bkztqDcKffiaC3Wj8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btwaymhByCfbte8uIQ7ht+CyFfS636mYgOSUTPovQuz+tz9bd935nyp3DGyO8wLogNHhwVe4JMjI37IewqwmQ9m72LHC8MYEm4LqwC1tSPjpx4zBHbqyUdL6myOdRkCuXnKcIb3h9m8+eamOoU0Bo/3oKcbtBXQN0FPP0HZVZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HR+uczkC; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c13802133so663122a34.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1743177731; x=1743782531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6G0qiJQGXC3AXOvDxr6xdkIUMr8b4TCV0bYMLRr8pk=;
        b=HR+uczkCjcBhqkTsBjBMKLMrmLDnxMpSsY2TEEBlKitDM/BLljW6QT8zPtiZz37/2H
         VXHI0n8RYgX6Nlesm36cGpY/Ficrur33L/oWuSo5VDRAEoZgJm2MOTH5tKHlp/pKdiUZ
         HFW4mVOIGO+9uZ7VMuFAfP/eeTTIqqls9KBW+QYKZSoozeEWOJz6XFoDbRK1u5BoVB2i
         PNFgD1fVFQvzhqNYuan9lbfxWGWc3SXBEGbrEbEeOmtwjnw9Iy4B7c5wD51Gaam5f/Lf
         E5PVMojyI3jek3yE3Mau1D/y3oTdC6iavN18idHENbLHQGLsnS7xk1QewQKv+niHCWNw
         SkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743177731; x=1743782531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6G0qiJQGXC3AXOvDxr6xdkIUMr8b4TCV0bYMLRr8pk=;
        b=L6x1KVOSHPdCbRGugeBYLKpqfRjb7xmtfVSPm5Ca5JbvBEOc79fgZp9C9SnKXqjiHL
         H7BVhr5Uvu51cZlSH+8vLvwQSMUdSVC/PAI8GZtdpUodwpv3QuRPAOzzkch/7TZVorIt
         L0BFJQJx44umi8SKDMJRB4Hj8wqoh4tB/r4srmMyfc0hc+t302xh7JK4zplJclbBxJE5
         jSY6FOrQuFbLj20wm5R+duQEKZL6hUidUdPnLzy567YRLd/6lgyTVoYV/V133unFOEX9
         5NHRdj2rjCZUv5N8c7FeL+DUIVhTDm0ziL0udHOTizOwQX4XjncvpeRY6Q0GIrpeqiiv
         G/Vg==
X-Gm-Message-State: AOJu0YyLMUWvi5ZkWzRfuhZMveCEH16P7CODpviz1YesIEx1nNPZbZZE
	tL12GrMWWuVklJZmAwh3T40oyiqjXNxYdj7NpyEGBJU4Zgfj1UqKwL0NGJdTNFZsYjG6Dirle2T
	sHgFv/fbnTHOi0fm2fYeizdI5Ugksx3QJ1D7uB87SU+kjOj9gjQ==
X-Gm-Gg: ASbGncuC9FGpmwaXPp9udCyhZckm88r6HsOeQN4+Qt5izCbaATtfMLZII4jzvIJZVhf
	i226p+JudiR9u0ShA1J4xhZOSeZiDZnC5PK6VfYWOPSXqwVYwguxm4kMPwM+x0ma6mYMed09MpB
	0l2iBVxJF83HTqHM6R3piaVkhdVw==
X-Google-Smtp-Source: AGHT+IFADzNU03cXbAbhHDbtnSsdcn7VfjDVFkPBYFpuag6zZCgoVTX+CDLsqNcb7YZJQ58Ma4O68Ya7pCE48hLZl6k=
X-Received: by 2002:a05:6830:4389:b0:727:3a2e:2132 with SMTP id
 46e09a7af769-72c4ca57a45mr7687987a34.21.1743177731160; Fri, 28 Mar 2025
 09:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326074355.24016-1-mowenroot@163.com> <CAHC9VhRUq0yjGLhGf=GstDb8h5uC_Hh8W9zXkJRMXAgbNXQTZA@mail.gmail.com>
 <20250328050242.7bec73be@kernel.org>
In-Reply-To: <20250328050242.7bec73be@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Mar 2025 12:02:00 -0400
X-Gm-Features: AQ5f1JqR6F0XsVs30PNGrh2y9naOsg1JHm34kVbGEXFksP6pfuXuFw3UH1I7hgE
Message-ID: <CAHC9VhRvrOCqBT-2xRF5zrkeDN3EvShUggOF=Uh47TXFc5Uu1w@mail.gmail.com>
Subject: Re: [PATCH] netlabel: Fix NULL pointer exception caused by CALIPSO on
 IPv4 sockets
To: Jakub Kicinski <kuba@kernel.org>, Debin Zhu <mowenroot@163.com>, Bitao Ouyang <1985755126@qq.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 8:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> On Wed, 26 Mar 2025 15:38:25 -0400 Paul Moore wrote:
> > For all three function, I'd probably add a single blank line between
> > the local variable declarations and the code below for the sake of
> > readability.  I'd probably also drop the comment as the code seems
> > reasonably obvious (inet6_sk() can return NULL, we can't do anything
> > with a NULL ptr so bail), but neither are reasons for not applying
> > this patch, if anything they can be fixed up during the merge assuming
> > the patch author agrees.
> >
> > Anyway, this looks good to me, Jakub and/or other netdev folks, we
> > should get this marked for stable and sent up to Linus, do you want to
> > do that or should I?
>
> Thanks for the CC! Feel free to take it to Linus if you're happy with
> it. We don't have the posting on the list so it'd be minor pain to apply.

Will do.  As long as it gets up to Linus somehow I'm happy.

> As you say the safety check is probably okay, tho, it's unclear from
> the commit message and comment how we get here with a v4 socket or
> perhaps not a fullsock..

Good point about the root-cause/reproducer; there was some discussion
about this issue on a separate private list and I think we lost some
of the information along the way.  The initial report was for the
connect() case, but while looking into the problem I noticed a few
instances with a similar pattern and since we're only talking about
one additional NULL check during socket-level ops on a CALIPSO marked
socket (nothing per-packet), I figured to err on the side of safety.

Debin Zhu and Bitao Ouyang, considering the other suggested changes to
the code, would you be able to submit a second revision to the patch
that incorporates the suggested changes as well as an improved patch
description which includes your reproducer and notes on testing?  You
can send the email to the LSM <linux-security-module@vger.kernel.org>
list while CC'ing the netdev <netdev@vger.kernel.org> list, the
SELinux <selinux@vger.kernel.org> list, and me directly (just in case
there is another issue with the mailing lists).  This should also give
you an opportunity to try posting to the mailing lists again ;)

--=20
paul-moore.com

