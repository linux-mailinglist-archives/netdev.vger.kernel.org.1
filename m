Return-Path: <netdev+bounces-198692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF75ADD0BB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2B402B86
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C2822759B;
	Tue, 17 Jun 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i1VTsP6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8A221FC8
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171973; cv=none; b=eZfPPZ4fCRS8eXYCHsXXH7T/mQAvjkk2ZTYGuM5yPeBQmH4ei9ijWmk7wKIuuBEZqxwY7o9unAxkFYeBxp3TlDL67ETOT/fc8093zHfLSEPXaCHSdaThvwHQN/OsqlnJblMlw9D8UgQJlGLePRhPfpP06r3ffWuYrzOwq7RlEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171973; c=relaxed/simple;
	bh=+NvMea6km87MjveuwCBoTgmlKe3HF+OcmW0grgm+Rms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtLMwLNTi2vYp2ZO7XM31g1pMAj4vsBIr7whFsZF3XZDTpG6KLGDC7N3phi1nyjLhAXaPKu0WqbwnbMlQTOocs5tVs7Zoh+HYWJkUzgZcEDHnCASkME5uQzlxuZWlROW5YX4SRbLPp2owKwzBQGgBDsc6ZxzmBXldDOG22z5X1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i1VTsP6n; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58d95ea53so59636221cf.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750171970; x=1750776770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NvMea6km87MjveuwCBoTgmlKe3HF+OcmW0grgm+Rms=;
        b=i1VTsP6n7ahjxDBpzFNFrlShW5Avlp5BSt4jH3x8yKhitxvnVUu9zi8a+hGvmu1tM6
         G8O5yCJiid5kAdzAiMSbq90rmg5rzE4bv9jVmtZz01LaGN/LBha41x2kfTQ1zTAG/WDT
         mt7zPlqDS9LflOnzGmkB5i8jN7Zsc6RL7FMsaLq8tiyzVB738nCGOytQrQIG+P9nimOb
         zEQFpdEUWnytdmmnNT01g8vXdsN4LgxRAPvB2RimuiJ8CWHnwxeCoUcYk3z38SXG9XFF
         SFmH3U4u1yrrDDONwNeCiwcRcg+DuAhsLyzllPruT4Uh24MCE5BEfZ8h+EScOVEHyLDL
         aoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171970; x=1750776770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NvMea6km87MjveuwCBoTgmlKe3HF+OcmW0grgm+Rms=;
        b=dQqZhedlEwOhg8N+SjCo9lK2HZEi9QxWHYkQINWnNac1IBCwlBbzCBojtkcQ9RBrvX
         SBaMXDfNlvmqFGSEPdkYcHdvbYO/u50jJ89IrTWE5eCTg6VKLoCHIji+XSK/i5VVeL4A
         vXDJ4s38bXq4OXpXCpDhbcAuuaoG7Uno4ywcLisAUnTQlmdt+pMxoDEXIPZ2/BXtBIzl
         czAPDCewToWkWEqoOX4JwLT75m8uwXGte2FzOJ+oh491F/v5EVVSXSISLO67ptNmfqov
         tl2YT7YiGqIdw6hvqvUOBn4BPdFbB1CPfq5Q6WdjzVFhIgXW6gyGHbkbNSzqAyMEBLYi
         BvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3L5HFK1ZUE52gVO7tevnjyF/iVq/MqcDfUV8sDzAJMv5zwAcTqCuQAX8sWJ3LPcw9RWZa3Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ELwkWIfHTcfyXXfTtY4hCkH10CMbtoJ49Jb2QjP41q3Cf7WA
	J/Pqhi1bPFT7TyEJx0gqlEUKsWCk2sF6yBN7FPwOD+INqXYh3dDzsGc4xj5J8xewZydO0zvHmCp
	G2ZiwTi1Y5s3oKBNfDAikpl5fxex+jXtiaq+fjrK9
X-Gm-Gg: ASbGncvpXUnH/46+CwGWIoTwRefRpWcXE8s/7tBWFXn1N2H0zijbk8D1y7FpZYExi8X
	uNf42tcR6MjubOQ+2VBq8AdhRXrgtfOE+xM+poe86s2TlofFsC3xouFrRslujjesPMVPPZrp92t
	Q2ipqPOfa67cIKbImehzcOLe4mZbBQLyqK4nez92yO+9o=
X-Google-Smtp-Source: AGHT+IEFVASPpu2QXODGMk0n1kc5onSpIw9qZNDnaXxXYRfe0VsO2kS9tX/W1oo9VNlxrhDuf+f8GGX4G0XKLe5QPSY=
X-Received: by 2002:ac8:5acc:0:b0:494:9072:e5bf with SMTP id
 d75a77b69052e-4a73b779b07mr207151041cf.18.1750171970337; Tue, 17 Jun 2025
 07:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617144017.82931-1-maxim@isovalent.com>
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Jun 2025 07:52:39 -0700
X-Gm-Features: AX0GCFsvvq62sQi4ARXNfiRr28Fhapr2YISoZFULLDQaQea5jEyPfSS2_YdGZRM
Message-ID: <CANn89i+ZhT9HWnzjCJepunumS4zLrwGBgGPq6mKiiaa21CKP=g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 00/17] BIG TCP for UDP tunnels
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, 
	Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 7:42=E2=80=AFAM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> This series consists of two parts that will be submitted separately:

> The only reason why we keep inserting HBH seems to be for the tools that
> parse the packets, but the above drawbacks seem to outweigh this, and
> the tools can be patched (like they need to, in order to be able to
> parse BIG TCP IPv4 now). I have a patch for tcpdump.

This came multiple times.

I want to see the patches coming in the tools, before patches landing in li=
nux.

Having the promise that it can be done is not enough, sorry !

