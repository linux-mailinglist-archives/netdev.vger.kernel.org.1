Return-Path: <netdev+bounces-225433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B566CB939B3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDA47B33A7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FC3019D6;
	Mon, 22 Sep 2025 23:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WT10l3YF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CB2FE05D
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584206; cv=none; b=giAXzTTIiw6WEY/jicZ5gTWNFA/6XhoHlSuY/VhG9Ls03WCUXZFY+iDNf0wPthzAOh53wxvYw7FT5lGDUM6b0qNdDMzGfYh5oI4RGmmfwV/XkBeYE2h5Pz02srjlX5TBvFHOTWh7cU3fRZeyuRZ2YOqMqBGamITMYisdvF5RRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584206; c=relaxed/simple;
	bh=aVDdjVSSiIJf40SA5z8rNbhXyIKVDGt4lBs55+Wmxxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZqqs0TljN4EYTGHcAxsHlEmj08ec53FtR4NVbtHhRUSE5pjColBvRJzDNrYQpqj9wfG+zJJginj0Q9G4xjVXX3Nf9XZ72Xf2Y5hyAMXM7K6JXrk8vGkqYm7pk8i9oLp2JVRT/D1xv43+aMHqPfAXjwn9MBaRYYePPv0jX9Y5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WT10l3YF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so5261381a91.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758584204; x=1759189004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVDdjVSSiIJf40SA5z8rNbhXyIKVDGt4lBs55+Wmxxw=;
        b=WT10l3YFJsYvpedO1bG1NC+OFeRFywdJqo5oaqIGjZ8W5ztivdQSux6UHp7MbR9xUB
         65v6pTptmWFVsZSuOhKrxCMcRjE0JA12wCHP2JpEj/6Hy/zD1465gg9wIDAUDY7I4dt/
         FtakK7nHz9PSjDLX2pPvt0h+eBBnBucjM2Z7mbocZbeFktzxorWdY5uWMv3OMnRD7SWL
         Mfuwo3v1sIkinSKcJ+gVBeai1S07jLWmLinFFfIrrRipDbAuv4/oM+6QQDQy/vDsGqYq
         c6IJpL+Pyx6yO/BGSBhImTXRm6ZUuzL2VPuUjiqrLv1XdFLbo2hrHDqhZ1ijTq9jcund
         f9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584204; x=1759189004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVDdjVSSiIJf40SA5z8rNbhXyIKVDGt4lBs55+Wmxxw=;
        b=v7EVVKm+2tO5yRSEgJkdOFv/sun6E06w6fGkI/ED4YSD/hngeiuOON4vCe6Dge6hru
         H75BKz6LHfsIPE7WCXEY/X+ucmLUqu6nNHnwwaqVFCCQzosX0TckgCayH2MM/dNlfI/S
         JNCeIz7wzTd8P/12+AkEfAY9iSPr1gMPOQCtZ9Xn3i1BTEjZAS399aExSzuJnio/6ccI
         I5kKRGV0xlQQpR1ckfiXJFXNJh1uwB8va+hX4YVhVUfn+AYDjT2DJJ488SRmJJaz3hZx
         ykgRBO8FQveLpEhVxAoXKdoO6LF3zvPxDJ0dslmBsZv6jYKVdepZxfbLZjrLU4VpDTKK
         yiVA==
X-Forwarded-Encrypted: i=1; AJvYcCXUvQmd+FZk73MEVJTfGAAaCSl0l8P/ZUqRLCc71B9T0cyfASuD0YlWMGNdnAQdpEypZXzAaqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xnpaOjyyOijesXkc34hEYNhHGWosO5Hi/5SElzHY+OADZ4E4
	tfFlkKF7ifLQpN7l8jdG7Reb8D9KFbeeDWaMOdgmerDjuYctadYipL2kE8FhTd4jiceCp1bA7LZ
	tISYd9BopZPBAPOVze47bINB1hvozYYxO7oiNzFfE
X-Gm-Gg: ASbGnctOcI1yMiK0GeA/17n4Jvfk7OEL2wHZa2nLwHzz1uh2RzUryE1kXkD/AP4U2t1
	6cPDVxmSWiNxcKLNXVNCZwc0RNhFqBHuwyiUm50GyVQMsF/kTen1lA3EGmXwkjXWLYUexF8B/Ok
	yUoXYQCo3rzDiepWRGrVnExS7zlktRZvTXKyInIdY+csWNLi9CZ4gfWktJo7nYIx1gMz2BT0GJs
	0fOIBV5CyRwokYt0krfeqUuRy+uEHgPv8mYxwba046Zqrr4
X-Google-Smtp-Source: AGHT+IE4bwsP4p3dz0R93UsAI0wu/zjWg4pu+ncLFowyX7nhU1SNJqvKhR9VV1axHvv/8M8/RQM+C2nSK1mrMuyqd9c=
X-Received: by 2002:a17:90b:51:b0:329:f535:6e4b with SMTP id
 98e67ed59e1d1-332a96fb7admr762973a91.37.1758584204190; Mon, 22 Sep 2025
 16:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com> <20250919204856.2977245-4-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 16:36:32 -0700
X-Gm-Features: AS18NWBcASMdvh8EY26T7TquBKDBk8TxGXLzIc_hooDwu8NB669qjJdJAe_-jR0
Message-ID: <CAAVpQUB3HKBcbCs03Lg9r3BcLSmiksnkm+z3GOkt9xnc+ikZLg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/8] tcp: remove CACHELINE_ASSERT_GROUP_SIZE() uses
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Maintaining the CACHELINE_ASSERT_GROUP_SIZE() uses
> for struct tcp_sock has been painful.
>
> This had little benefit, so remove them.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

