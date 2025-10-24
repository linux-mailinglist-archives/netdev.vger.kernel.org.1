Return-Path: <netdev+bounces-232620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 671CBC075D7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800531A635B7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDC283686;
	Fri, 24 Oct 2025 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAGp3pVD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68327FD52
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324169; cv=none; b=RqurKnrAX/pM3dsrwzyqMCmQyDDc/6kokGT8uA8CLZRqaFOgdwC6XEcrf4JqjYyB9ZeiJOkQqGGVDqp6WD6FIgArtidc7nJdK128ly9a/73M1nVdqvh2t+nLoApeDNFurYM1DaSXdsRMrMZPAQ9/lZshQj8wekzO3MqClkqBm/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324169; c=relaxed/simple;
	bh=/blf/azS5NEQNvNlO3JBJPajNsZb+Sbs7B77kxrnl7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHNYyck1h7Z/razrNTvpiS8EQN6oCCFUrbQ9MEVVdCNKEHn1tdsf3vV9E4rZmYZDBZGUD+3xWsW1XdiFt9Cc5TXzJxlyPQp+BcO0UgoE6ZW2Us6h/y6/AFGgNlqck9+d5kdFDryk57GB3+UGeptzU4vL97uh9J78dagCyhvTQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAGp3pVD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-292fd52d527so25262135ad.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761324168; x=1761928968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/blf/azS5NEQNvNlO3JBJPajNsZb+Sbs7B77kxrnl7U=;
        b=bAGp3pVDkboELtC5bvodpi+jgo1LU7vfLp/ihi5rsLTVQLxBNbjg8Wy1swpMhN+O6t
         ZW7CWICV+ZPkYY8Ts215tpoy+vl75oYGLYjhE6VG2Z9xRWJ9cmsGZMWxmgU3Q0zaAOoI
         IHzqO2N8qCVaHTmA1ZV82+vZsad3GXTifaWuM/YLGJeBqjc7fzltLd6i6RyCGBasMhNk
         2c4gqnZzQ6YJRkxsUHGSy7iNG+itU/85PWTD9CXAF11BTz9uPEv4tjwgwqdYxZsPcYhN
         h6NBK3Mgg/tW5XI5V0xE0rllwmvkR3PTqTkvkCIwR/FFfsdBnzjuNkNBgX/wbQWKuyqw
         zktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324168; x=1761928968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/blf/azS5NEQNvNlO3JBJPajNsZb+Sbs7B77kxrnl7U=;
        b=S+UpGgxtd4HyZkebYfORXUCO9ymcLkYjSxId+6DI+TT8PwTgGbDp7PIjd0CNzk/e5I
         6VCSD+veDkmn6Yygz+TRbc22nBatJxbQXPvC3DmJ1OVDCzLwn09pJumBvF0eH/0dad04
         5mBkanZWxFKt8eHURvgG/WvPUytaIev3K71z18eHB3C9B7oMkxDdefIJTTHZeVjulNLV
         dFBifT9rxvmeW88hpP768PcrrKPeiAlmDviY+/wSqDxOOukam8PR1E8tXNZcpx5NXPhW
         CWgVDgqhuVfvFlK7QqdXAGBhBMnZOjCfYwWlvZtYwmwnX4q/dL/hqBwgLvBb9t0h4a69
         VhKA==
X-Forwarded-Encrypted: i=1; AJvYcCUHDeWgQxEUT3TXM2w3QXZiqewJRS4vFpcWBJginTaqqkyDUSAk6yJcaVjuZMQ0Sq+r0ZNHzSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUvrFXU5PprOP0vHYzKFbWST8RTAYRlBKxEZkCqjaSTygBzvB
	WhFzUnzUSpvXXTCKwTjpIbJ7xfUVbBxpoUQeTQ6KXlFJYMauhvHjOkbMH4jpApfjy5KxK3oBrX5
	0jBLoAsKr2BSDOE/vv2Xg6/+0tyh+triVV/tsrlbK
X-Gm-Gg: ASbGncuaXhznVeBUWs9U/6huKRs+qWG7jV2yyRb4/RP8KSfhVnrr7quL6kJDI53jH/V
	93nmvjgoHqSfgdTexJRpu3AIjxHjSaeL2DCVMFZMBpstH0qo6cAzc/+CJpK5cmqAEyaDgk4Ntcg
	gYV/2Ajh/F3GLMnW+y92BkFC7sOXgiwP+S/vzRZsyzJbDlu77+IdMZSy/y55ItefGX8mUgwoPWo
	AHPh4mm7+tLkSByrPH0yjoWF/lP14kZFXZjfrDYmVu50Gw+mNhwDNHdmRbMyTa9Bz1+trjpApG5
	U4k0ybrepF9rsZNeuLbRz+dZ9g==
X-Google-Smtp-Source: AGHT+IGPy7KhvL+Vh9CdntT6E5HwvFrlqr3eklQ4VeiTiQyrrF2uZXnNDAVhZcP6OhhXKtoX14Y4jlCdlHSqJRwPh+Y=
X-Received: by 2002:a17:902:c411:b0:276:305b:14a7 with SMTP id
 d9443c01a7336-2948ba0d467mr37007185ad.33.1761324167479; Fri, 24 Oct 2025
 09:42:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com> <20251022054004.2514876-6-kuniyu@google.com>
 <CANn89i+Wv_tzq7LR64bN=x76=HBBmtR+GG5nDEi4fX8zokj71A@mail.gmail.com>
In-Reply-To: <CANn89i+Wv_tzq7LR64bN=x76=HBBmtR+GG5nDEi4fX8zokj71A@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 24 Oct 2025 09:42:36 -0700
X-Gm-Features: AS18NWDGHdOsctcREgMajhYcpopFJDWJv4Lws-fZ97Ld370tVIR0Rdqj4OTYlhk
Message-ID: <CAAVpQUBd8ZW1BZMN0FAPbr=MzP7drSN8YsxdJLmQVeTfmvNqVw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] neighbour: Convert rwlock of struct
 neigh_table to spinlock.
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 5:31=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 21, 2025 at 10:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google=
.com> wrote:
> >
> > Only neigh_for_each() and neigh_seq_start/stop() are on the
> > reader side of neigh_table.lock.
> >
> > Let's convert rwlock to the plain spinlock.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> >
>
> Do we still need _bh prefix ?

Yes, I think _bh is just for IPv6 ndisc calling neigh_update().

