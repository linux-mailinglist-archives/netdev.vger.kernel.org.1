Return-Path: <netdev+bounces-112901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A493BB17
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 05:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E07285322
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 03:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B089D2FA;
	Thu, 25 Jul 2024 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUncKkGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ACE81E
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721876930; cv=none; b=gFqTwxOxWL06DeQTQIrgToNuLhdqyyOcUUMq73MP1mNw6ICN/hH8UmsaXa4llBLI8vD1LgrdwjAAPKvxeI/0yKSdvNGml/pR448HjMQxb4Co1RFhpacbEnGZgrpqMyUp61m6H62lU4szc+MpFKWxyVrFwoHyUifJQtL+XlXeyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721876930; c=relaxed/simple;
	bh=Bmm5JZgZ+/fpFhwgupfkC5k/YZVPe5KtZuixmfXZ9e4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iMaDvK5RjQk5vgqh1lliFF+ELu5bPqWPpY1MYmArwYwy75/hYwhzyws5bqZiOVz+wFz1D6TVH2qgdgSAkez+goPWudR+rDfniI4HazeKSE63Llo/hY94AX1ly/unDrvyFYlMPJEkkr0f1LoEqxOpJWkCcuLMdl8iHJCf0r/cKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUncKkGY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so405087276.2
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 20:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721876928; x=1722481728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bmm5JZgZ+/fpFhwgupfkC5k/YZVPe5KtZuixmfXZ9e4=;
        b=IUncKkGYR+2/34/+2Mc6Jnlv5coIJbc97RHy+WCAWYPFdAnqRjpIxM1bZIj7vYY7Se
         aYMPgSKaJgrdkChEV7kKulBHy8RbcR4Y65EA+vNMrcSM1SicdWUbxkyoNyqp7UvjnlfI
         J5r3VtDmlQO24sC4a334OVvbVyTSUXnHXJWEyH5qNbsAH/jmIfZxqQISDeC/tqPsaIRe
         B2uxvJH1mvRA0OSxcQbbl0govaC8xj14+IZIjQpsLpz/B+MndNPGZWpDVnWhZ79vWR40
         fEjXvsm/+CW4R20oG76SJspaljCmsh08Qy+5RyFp2DLk/01tIchQ8WsgCweXHJgOWTM1
         82Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721876928; x=1722481728;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bmm5JZgZ+/fpFhwgupfkC5k/YZVPe5KtZuixmfXZ9e4=;
        b=dC2NY+1dYLMcvGx9lsB9U58ui4ELgSze8VkxGLLSMQbD+Sj7B08314RwQO9mPFriOz
         Co/GgZh2sG2dzAaHhX2yD6w6IoygR9dmBmsKLzG9pXds9RLEGR2ljvWiPzzT/2rn1FQb
         bUFpZF6GNWcnGVTWdcIKnycE0dLL0bac8tSYHjekY6/NNg6CAQrq7y5RTj23ZiZbXssG
         M62sBdnHBYjSqFReuFoof8DgFVKLhW85KYD8Nb6esjJhBcjs4r8JlbTwLbjSiOHcKzaJ
         WClvRK4d119bxJhmsSKDq0aNNm0AmRXeXwJmEqHh+hnMue3AAMP3P5iAGclCfKAExjea
         6cHw==
X-Forwarded-Encrypted: i=1; AJvYcCXzsoH2hbSgRC0719PBeQ+jr/mF82Ho+ZD9jbeRMfDyivR0nOF2/+PtqVJYXnsB5sGn05J6wQo2N86gW4//Wb/9kvunXR2u
X-Gm-Message-State: AOJu0YykZvZ126DIKZyPIeRfw/NKuPKr4xAF/DA/GwA3O2KUIqEk7UqZ
	y0+v1iJ5V5yRYgFaUPp2t0MMkhVqlVnGkDN++g1iseH5HWwaOdwz
X-Google-Smtp-Source: AGHT+IHLgCjxuHtpot7F0bOnfiQ2hYLhBnKKTRs+0LfRukHdtNM489+jtv72a0CKNvNTevXT62zpJA==
X-Received: by 2002:a05:6902:dca:b0:e05:68c7:bcd4 with SMTP id 3f1490d57ef6-e0b2cab609emr575072276.26.1721876927756;
        Wed, 24 Jul 2024 20:08:47 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81238f4sm2251201cf.4.2024.07.24.20.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:08:47 -0700 (PDT)
Date: Wed, 24 Jul 2024 23:08:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com
Message-ID: <66a1c1bee3fc4_85f9929439@willemb.c.googlers.com.notmuch>
In-Reply-To: <d53adec9-10d5-41e2-8065-3826029f6134@bytedance.com>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-2-zijianzhang@bytedance.com>
 <668d680cc7cfc_1c18c329414@willemb.c.googlers.com.notmuch>
 <d53adec9-10d5-41e2-8065-3826029f6134@bytedance.com>
Subject: Re: [PATCH net-next v7 1/3] sock: support copying cmsgs to the user
 space in sendmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zijian Zhang wrote:
> On 7/9/24 9:40 AM, Willem de Bruijn wrote:
> > zijianzhang@ wrote:
> >> From: Zijian Zhang <zijianzhang@bytedance.com>
> >>
> >> Users can pass msg_control as a placeholder to recvmsg, and get some=
 info
> >> from the kernel upon returning of it, but it's not available for sen=
dmsg.
> >> Recvmsg uses put_cmsg to copy info back to the user, while ____sys_s=
endmsg
> >> creates a kernel copy of msg_control and passes that to the callees,=

> >> put_cmsg in sendmsg path will write into this kernel buffer.
> >>
> >> If users want to get info after returning of sendmsg, they typically=
 have
> >> to call recvmsg on the ERRMSG_QUEUE of the socket, incurring extra s=
ystem
> > =

> > nit: error queue or MSG_ERRQUEUE
> > =

> >> call overhead. This commit supports copying cmsg from the kernel spa=
ce to
> >> the user space upon returning of sendmsg to mitigate this overhead.
> >>
> >> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> >> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> > =

> > Overall this approach follows what I had in mind, thanks.
> > =

> > Looking forward to the discussion with a wider audience at netdevconf=

> > next week.
> =

> =

> After wider exposure to netdev, besides the comments in this email
> series, I want to align the next step with you :)
> =

> Shall I also make this a config and add conditional compilation in the
> hot path=EF=BC=9F

At netdev there appeared to be some support for your original approach
of the application passing a user address as CMSG_DATA and the kernel
writing directly there.

That has the benefit of no modifications to net/socket.c and lower
overhead.

But there evidently hasn't been much other feedback on either approach.
Since this is an ABI change, SubmittingPatches suggests "User-space
API changes should also be copied to linux-api@vger.kernel.org." That
might give you more opinions, and is probably a good idea for
something this invasive.

If you choose to go with the current approach, a static_branch in
____sys_sendmsg would make the branch a noop in the common case.
Could be enabled on first setsockopt SO_ZEROCOPY. And never
disabled: no need for refcounting it.

Either way, no need for a CONFIG. Distros ship with defaults, so that
is what matters. And you would not want this default off.




