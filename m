Return-Path: <netdev+bounces-137011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EE9A405E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE91B1C20A64
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E541A84;
	Fri, 18 Oct 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjU2TgOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F63134AC
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259353; cv=none; b=Nar4u2vmGyLJvm9e/qWtwQtMCOrrxYoUmCxWER2W7uaNbq0Ld6VcPCv7j48rygneQfz5v4zI2drwKBJ3eUnXB54X5O6e3xs+eG9DMq/r7ugzKsEbyLk/vo2T25/9EMxGOp4xyj483VObw7TuHSfCoGakLfZmpocD23O357FidhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259353; c=relaxed/simple;
	bh=N/RmjZ4ezOAyIDaJmd1SPbCikgtKVO1rW0n7JykEYjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caR6c5AS77cauFLoUMthwiBQVyWtQAisRl1bGAtGRtJWDnjYWtkA8vsk/okTI+ALSDipWntMeDnLK6oKzjDNmCOp+aOOi6tx0C6/bTziqPBeyw6F6HnZj1xKldaiFgKn40N+R5muTRRqx/EW+0b2nW8zMjvGxFwnx/ILiLDOIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjU2TgOo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99f646ff1bso264187366b.2
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259350; x=1729864150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/RmjZ4ezOAyIDaJmd1SPbCikgtKVO1rW0n7JykEYjA=;
        b=TjU2TgOo13q6OneQauGPNoGW8bOLqiBAdVH+2CN87Wc+W8k+KkJR7qw6Hc6/HbCP+B
         K5qr0bJy/sSQ47vDif2OjSAfnbHtI6bOZVi4xwSLLKvCeW5eqoycyo6cBNm7C5DHtzmR
         8FZdD7v/C4WEjWZh06cq215PpvWF4R5N0cIWoYmNRguU1+PYzSNU96PMlPEKmmDKEHnS
         LmntN/LZW+TWJJa/pl5hpMJfiS6ruub95nGe+6CMTWBWTNRqmPJHopvXStZTAWX5iZNl
         CGNZvfln4uc9S3icmZqLOHLJ7sLZj6ZhUpLV7ZVP6jbqf1IPwKr+DBp1j+FFwbkpMx4l
         K00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259350; x=1729864150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/RmjZ4ezOAyIDaJmd1SPbCikgtKVO1rW0n7JykEYjA=;
        b=FTzd2bsWza7PB5L/tzoK54z5Sq7X7fpbYZ+5aZChfOd/u3DXFJSev2Ga9TE2MMOh81
         lX1yjdzfOKFqIrZ0T9XVbW5zEsRWy8EkIVeM7Pdpa4e81pi8wkiBiQSWLXob0yRLmzx/
         RHjiUKwEFbtnjZjhICwdAfx7qy9Lng8O2bGARrEUMUG9VFmGA6Q49mQD78dSplm2ieAD
         bl68swJW7QFPABvmg35EwAveebye39OODxzYb7iv+R7zZbTHjOkpOxuy3+vzKSYzagU4
         Bj2C6yjVtlKCMNXfDrUx54o71WJHUDIDdylD2KX2Sw0gU5BVrpJUW3Tsk87w73S5kG+i
         cSoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP/Rna47ykLVuSHw5lKA81BxQKWL7eB4PGMXVrNePLTbOftfG0pnVbqG635jMV4CugYSndQgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdnn2inYMOTwWvekf6aw0JIt0dgfPr5liVLc5CMGQUjHeMpO8Q
	mcV9i9bVxsbehll7USOmLvzIhdNmZfvcYvnedys4ejF82kUrbtgmaroJ4IEgdjmMy6g25os8gVD
	pO/8Z0U2zMsQYA+N5Gs08Eq3KdiM5n5j36qOQu7+Gr+7cXf5ppQ==
X-Google-Smtp-Source: AGHT+IFkSWwqMPMBJYyViyvpBEkI96q4ms4njy5Qos8G6M6E9M4mydrGq6ApHxqo8PIRtZ46emxefqN3Mi8Z7UYYs9g=
X-Received: by 2002:a17:907:940b:b0:a99:f746:385 with SMTP id
 a640c23a62f3a-a9a69a622f1mr230541466b.1.1729259349414; Fri, 18 Oct 2024
 06:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-2-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:48:56 +0200
Message-ID: <CANn89i+uNM6eznPH0Z8Z4BXG+2a2X84GLCvkyJSd9n3znsedzQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 01/11] rtnetlink: Define RTNL_FLAG_DOIT_PERNET
 for per-netns RTNL doit().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:23=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will push RTNL down to each doit() as rtnl_net_lock().
>
> We can use RTNL_FLAG_DOIT_UNLOCKED to call doit() without RTNL, but doit(=
)
> will still hold RTNL.
>
> Let's define RTNL_FLAG_DOIT_PERNET as an alias of RTNL_FLAG_DOIT_UNLOCKED=
.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

