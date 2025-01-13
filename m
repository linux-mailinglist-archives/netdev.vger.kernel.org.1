Return-Path: <netdev+bounces-157786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D492A0BB65
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283AC188554B
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DB24332F;
	Mon, 13 Jan 2025 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbeZgAY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EBF243330
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780648; cv=none; b=AAIKsuW5G+GNeeorTK7yjBO/PsVU3yzezKc9tQClqM70qwkNTwUk7IX6PzMZHgxV69N9zO8GiYDeeDD16DKz1U+oxSWaGsQAH937iKQgW0hjsKWar27cslNtUvhlOIxmGbgWZUpa804iNIZHoh0KBqNLMl2VukuLbEHK9aMAVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780648; c=relaxed/simple;
	bh=RoDBWk6NIjOyIFdZRJEomC8gMqVD8TxovOxHaJuDgeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfNg0UfUJ2wkHdeKTBq+CGc3na2sA92UMaZxsE1d1ViSgmvSTKzecowg72rSwR4yWCEfHrd3+5csD7nmAD7LY58IrErRyOuQM6y/agc3EzI5phvvunJwqlbInVtSnIw2qYROZKRS1PYaWO4MjxeY0zQ/Upi20/t90UMZ6znU4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbeZgAY6; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a813899384so13304095ab.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736780646; x=1737385446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoDBWk6NIjOyIFdZRJEomC8gMqVD8TxovOxHaJuDgeM=;
        b=dbeZgAY6SkfTfmlah/FGDOsGxZVD8SmkDZ8ixS78/VOPV5iMgaiDanNqm2jRclVeMf
         9kWzJt7K4AbtPOoWTHIda0mQnbiQbD94nZry3x2Yu+Dn3qHveotytbvqB81rgMRZ8/kj
         nnuvFjurwS1QMI13xZ7IDeO28iSavPbNNfLTnyNOA2lFIYWE/kfhYvKcBQ8GuA2Ox9ux
         So82XfwfCi1yBeL+bF8R60rXO+rBDdNy2KYdbFXaBloyZxSf5dnhpuyWRSQ9MRKu7dq2
         P/McKSfDA41HUfNX++Hz3hKqAKXGWd0SCOGp5b927FQuveC6HWWJThYc8rcYjWTXLfZY
         cdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780646; x=1737385446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoDBWk6NIjOyIFdZRJEomC8gMqVD8TxovOxHaJuDgeM=;
        b=m++m8llTr05nhZx6R5ziu4OCN/nZ20KbMikFITEVTa0YE5NeFT6m9+/MnMzoSkalJ9
         kaI1oeDAEw5okfLwbK0ELWW4fn4PqWaqRoUc8hHG+RJQXPBeTvDzCkooxKHnl+9MwRRx
         EpBOCodR2Y+ge/ImE5SGtFIqLseLYph1YAYnHMbTV+7/Q0FP7Qx+z8LNK1e5d1uOd1M+
         IN4DCq/FbVHZ8GrFXo5+JNa7ja/mOKjDc1180yzmdQsjMMphncxlGKUj3KpsD3V0VFT8
         /tQPNGNP7gmMLV+E1gnlo/UmjA1olT3T3+1tZJIQTefkhZFdEd+mqa4NjxF3GGTN3H+S
         xPgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5PRlF/2UwFq7yP2H2Vt8NQsEkSyuROU0SUFCkt31pCYsv9q+5HKyzHZWeYr9n703/9eBv44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLzYJ74/bvkoIoZmUZxpyce4Iv8Blb6AJ6ZFKL0XG/sReShP/
	qUlOanf7urduWSFqbc3WahsOHhZw+WCpNE8xSafeuUtTlRwOtoP0NJvyRog2yNN8YE6n69Xr3We
	tITb49ziQNPFR4Di7IvibnE1y9VQ=
X-Gm-Gg: ASbGnctsOAKutGqrbqktlIMdOGKG2awP+TieylElEUChcH/Urm/B2Q7h+4eEI/waYVg
	tNptPRo1cWaoI9BzV9nLB9Vi2bzEqvwKZlI4MiQ==
X-Google-Smtp-Source: AGHT+IGWdqmJM9mEkBQruEeoAmqiY7Tjp2XYUGa5jzv9xUjOkyypOzKlfVLAaQzIhCx/kUwhQPusfSLbdPL0yp4cvHQ=
X-Received: by 2002:a05:6e02:1a4d:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3ce3a90ee90mr152287235ab.1.1736780644262; Mon, 13 Jan 2025
 07:04:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113135558.3180360-1-edumazet@google.com> <20250113135558.3180360-4-edumazet@google.com>
In-Reply-To: <20250113135558.3180360-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 23:03:28 +0800
X-Gm-Features: AbW1kvYSiacEpvLsL3tZSSwKAsIVWqLCG_VWoABbTtiSydBawzL6Tlb_G68vASM
Message-ID: <CAL+tcoB5HsydDEEt+YvCRn9+3H-NDa2bBH0Skp_ab4V+LpRf9g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Prior patch in the series added TCP_RFC7323_PAWS_ACK drop reason.
>
> This patch adds the corresponding SNMP counter, for folks
> using nstat instead of tracing for TCP diagnostics.
>
> nstat -az | grep PAWSOldAck
>
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Really good suggestion so that we'll not miss this one :)

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

