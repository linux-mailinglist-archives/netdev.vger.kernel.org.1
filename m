Return-Path: <netdev+bounces-72547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A066858802
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E052829E7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACD145328;
	Fri, 16 Feb 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmVWs447"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15351E865
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118908; cv=none; b=NFZ74fo/NfT+82thmz21HQAuSme4T4MH07dzB19jT9pglak/T/gzxOtj6x7PHHkE5rBEtq/3ZaZfWezcsA7G0a6SDRteVW+BpaoJeGGKOwQ7OKFy5iS28t2yfAE52onHuUakcwX4pn6utpYGhEPcZuI3eMXgY+ia4LeRVrGaoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118908; c=relaxed/simple;
	bh=v7v60Ty/5b4Zz6hT4BrUQaiAwThbMI/RiuVRUFCDA+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHa3pv4iX9MfRwmLYNZpOIf8xZ/iF1CZKH1I1g8J6H2XQzTBR2W0ODmFmbAdaT/i04NyzdhCxXfPXyQ6Smf9AUo1PqHJDwElE3fYE0x774B/9duh81sFJyo8Xjv6JQIzTRF9MFj9Rjau9H2JtE2paezPrIthSWvEjb9v00TtG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmVWs447; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-410c9f17c9eso8515e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 13:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708118905; x=1708723705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdLHtQ6CWH/fioH68sO6XOGnLk4Xe7fros588zVgkHo=;
        b=ZmVWs447KqWVrsVqud/tRzTgMTMsNYFLbS3EBUN6xmfdccz2Fv80SlNzfeV/3S59XT
         Q/WK4lwLLHnDRD6Jd9P5H0SUsFv4CSiUIRNen229PMDsGPEJ5PMVFy7cACAqPE7OMb08
         OWQe8vCoYP1yzSzpV824ieZQkcck4MCvgCQiwF5aW4gcYlbnVwPCQgRQoNeExAPkCFww
         3galk7A4SpJXgEay1vYoe1KAndTxMhJF8NWQ6qj1T6EZcYRdrvf6n/WgbftFI0qDgZ3K
         YxM3IbJjCf8mwzyZRFWFd4zZmJyqoeoPtYHT8HtT+/wYHhP8+LTy+NT0LFB0TL5Fvp0J
         g2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118905; x=1708723705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdLHtQ6CWH/fioH68sO6XOGnLk4Xe7fros588zVgkHo=;
        b=C9MGcQqdfykTqOL9shVcB3nyvC2eZrvWaK07Ugog/wuz1cicYQ1egYp74tYy6tPHll
         hKTHGJnfYDhCvuJX7qZfJs64dky66KakVt1Tij4k4vvLxRLNS/UQ126SJwJrEDv5aS4K
         jTt51amVgrRn3kdwHI0nvjYV4WnFE3OFtvV6Wk4sjRgOA/5wtTk+xgOXzU1AJZDwZrmk
         aSaOhskgkGvk6NowNKsMdk3JJkJ/045DW5ML250lZWnvaFSmN0f7t4j9IM0ScO6Gz3mJ
         atB0t4RbwWpAZp+MnkrVJSm8A94jI5Iyst9fvvXQE7wa7uX5OiiMyp1S19WSu/YH+z8C
         i1EA==
X-Forwarded-Encrypted: i=1; AJvYcCVIb2MLgE4B6P/RB1keLsGjgnLeGftrduuYmpZeH9oXptz8pO6TFnk5pjYYyyJ2hUk72lqD188qPnfhVKeG1jhhW3L8KrVQ
X-Gm-Message-State: AOJu0YxbtCvHmNEjf2cAGWU54pmLt/Nc4pg/0nJb/mOGEt0c7Cfk/PbC
	K1B3tgmIIB2wBkmCXlxMi9FpCcYlU7Lpim2mggwdKSFywhnjfxy5GpZS0vAupeTzJ7G2t9NTqg7
	+LaiAj7zQGIdNxPlWb1xyFvIGokmPO8P6blN1
X-Google-Smtp-Source: AGHT+IG30b66wJqqJmDMWB2glk4NHHnxw+lrj49jntnXLdpfJSp44N12EpErIdcErjSR4gZRbEIslo2X5HayR4+tyiE=
X-Received: by 2002:a05:600c:6025:b0:412:40fc:51a7 with SMTP id
 az37-20020a05600c602500b0041240fc51a7mr61152wmb.7.1708118904870; Fri, 16 Feb
 2024 13:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216210556.65913-1-kuniyu@amazon.com>
In-Reply-To: <20240216210556.65913-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 22:28:11 +0100
Message-ID: <CANn89i+oURrHhvODH0U9gzR869r_3EK5zuRBNYAV_Frrj_3GRA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/14] af_unix: Rework GC.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> When we pass a file descriptor to an AF_UNIX socket via SCM_RIGTHS,
> the underlying struct file of the inflight fd gets its refcount bumped.
> If the fd is of an AF_UNIX socket, we need to track it in case it forms
> cyclic references.
>
> Let's say we send a fd of AF_UNIX socket A to B and vice versa and
> close() both sockets.
>
> When created, each socket's struct file initially has one reference.
> After the fd exchange, both refcounts are bumped up to 2.  Then, close()
> decreases both to 1.  From this point on, no one can touch the file/socke=
t.

Note that I have pending syzbot reports about af_unix. (apparently
syzbot found its way with SO_PEEK_OFF)

I would prefer we wait a bit before reworking the whole thing.

