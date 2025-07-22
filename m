Return-Path: <netdev+bounces-209008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8FCB0DFCD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572E3173D43
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F882D8DCA;
	Tue, 22 Jul 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Y0GlSAr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8A42BF010
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196341; cv=none; b=F7WkFSh79gkN660/vMPiC/9sKrPL1pEcdZDDq244pJXv28j+W2vciL9EVe8FIkD2kMgIPxLRhFwRXO9ufRuR3GhJPJXIAy3DvnVzvEEcMPEv0fRDOfV676le+y0+CLbkxKD1L5oCXeECdFgqwCudAl+TwM/cjfea3SVhG2MYz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196341; c=relaxed/simple;
	bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/k4BuH7WoPA9ux8GOQbrw1b30NINkk0VUaK07SoHonldWzFeC0+gP5gGVWoPBe7kpow+CZRmKFDGfXPuAZ8n5otgKTCFzD0AT7J9XsjAqD+N4RFAkeiLZW1e0nOXts3aBThfMLOuRiDJ5FXXwHJTvxnkDh0EwYenaX4TdYT+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Y0GlSAr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab3802455eso72731651cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753196338; x=1753801138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
        b=3Y0GlSAr8a8utCCIcJujOzlyTHCc3LmLw52nYSunHLEXJW3H0KCe6LXQnN18Q2qilM
         6/tPJA9w2oTay3yufSueM1yH7kPgE0SSuYAUUONwcM9uUNXzoOmo20p7UB/m7F/WqAQc
         ZNFVAMOCjaXORWHLrrkXe5c7xaSGy2w6VZPn1Nx+s0EweEC6phi1rafoHMz5NqlQ6P1T
         +snaxOLkCIrsExxcnw37+iH8L4oKDd9e8s9qJ6mGMmqZGDukPrghTzRoMxzyylTwFdB4
         sN/uj2FW2Pm5B8LXYyshytNAVOZe/IoXBCASeyGh5CCsbnZQnK3Qkvt+hQurZuqC5sKo
         iBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753196338; x=1753801138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiqwsXqS9XffgcdUNt4OEyIxE8kyMoj+z790mtcu3ik=;
        b=YRvELjZQ95JhOj2CBw3YrtJbDL/VMZPdysjAQWFmMYIZ3nfwMQ+/tnm7PRoy5wKSQm
         +nKa4zqqsDGvv2kduB41FIGwdS6z7ISZbul3Wv17uw9N2r5nHzrYEu5LMWx1Ft8xDeNE
         ShN2dA1kXH9iEc69jR5odB2ke3oSgL3/AryQXzGy65RFU/MitzkoascIeMEotd2Sg0vZ
         GOJNgn+9+eHSSd+ezsLO7M6110wiB8JglFOFZyTlUBbNTxqrCBwO4SYgnHGdh8GCfo2y
         YtsPoj7uGkbxwPoa3hGmBH/eBUVg+idc20tyVI4y0ffHaVvo0IZSoj01wNt+v7h6USpv
         doQw==
X-Forwarded-Encrypted: i=1; AJvYcCVMG/MIavyA7dIOqQsYqs0vs9pm3Kq/VCDb4aKruS7v3GP6Pmtkm6EVmdpZesxrKVFm8Lcea4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroZMVeCevsKzDgGqJG8RnAmdET95da6ACQQu9/d0ROobqnL4v
	QbHJUXsWX0LIJ0BkBtHilzWCnjVW+bz8xhmppYvlm2pTUwkqQ31h9TgqUW13kuf+adNy9pAyiqL
	y2yJB0WTOE+jNixhXE3XXxM9WhcdyD6V0kvqmwr4/
X-Gm-Gg: ASbGncteOnJT/MnWDgUpsMmd3k2oGB8HvGERI0junNV6wB7QSJLYSXvAJuag18HHOEM
	MWtbIZgXE3W2wuTk/D6RUxS5yqp2jn3vlPCiEztDwmjiwICYivwagR/3F3lgvnhvehbHwFcHgSL
	I76LqHeMyHpYIqcaKKIrWECUd8gSRXjTXFMD++XjxSTKV9TpRtaYB6fdG8oFPp1tx6uVk4XAc/M
	0uqpQ==
X-Google-Smtp-Source: AGHT+IG2yg147JK4Oinx02ez69SdDMukiZsmWmT/iPx1WpvOc0p35m3lKJjL6O102z1pXoYruFzug+iTBIemqmhssxc=
X-Received: by 2002:ac8:7d12:0:b0:4ab:7125:99aa with SMTP id
 d75a77b69052e-4aba3e33f4bmr306580691cf.49.1753196338060; Tue, 22 Jul 2025
 07:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-11-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-11-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:58:46 -0700
X-Gm-Features: Ac12FXxT4R5nqDZoq6He5N2XHgjugFXTSeJd14lK7mmXsqA2ix7EK8BukOpBfNg
Message-ID: <CANn89iKo45xre19BCkTRQSym7WCWxAbXOD77+F35OJ0eubmdew@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/13] net: Define sk_memcg under CONFIG_MEMCG.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Except for sk_clone_lock(), all accesses to sk->sk_memcg
> is done under CONFIG_MEMCG.
>
> As a bonus, let's define sk->sk_memcg under CONFIG_MEMCG.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

