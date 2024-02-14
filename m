Return-Path: <netdev+bounces-71817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5795885533C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154DB2818F5
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21CA13A87B;
	Wed, 14 Feb 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYwOkBmx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB91E4B7
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939123; cv=none; b=Fc5/PP9Wb/S0d0jChvgnOKMZxlhB3OmozQqyxcGPiAiydPf3xAM98568Bi0PGYlMCuoyVueC38gCcntFf3XMvOPWkkdvpFDvoxhVfirbOtrfMhr91WK4bEXxZGzkfhbtua+vF5S8Awb1kCf8Hp0VpTxVqrfxKkAOFXm0RneacIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939123; c=relaxed/simple;
	bh=Y3XGKY7dihZWrRr9u7N+33D68qk8fLvxf8LoyEwJtNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2AxOvhbBexC1XbAcJxAq7AOW9o+F739AQlPjahiIXbRJwNO+vlwviZv5iv3/9M+4y2H8N7LiZXEn3a1wvtOlkioeppN/dIZX4oW+WMniOQU+m9KBPH4hYPJK5zvPGHqgPLwxpPYODiFjKgqjHUG8Y+teRDXutRdkfYdUGWsbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYwOkBmx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso2273a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 11:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707939120; x=1708543920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeJAk6Zp6bPsfRxVidxHJKTPkNWhEasrEXb13lPpcs4=;
        b=aYwOkBmxUqjp7JjWKlrXqD/VY/yySq2Y6RIMtmEySGvQmFAgcMTT+b/a/0ke06cIzx
         cSQkfJTchSxjqWwPIAxix0Seh//wAHSNyQHZTFPtc7yGvOfWA/gMuQqCtAaKmmTw52T3
         Lt9ftKN6ryApTbTFehu+4U3sv/uGlDImfsKCZgx1zZHrJ9IZAMr9KAV600ihsrBAUvHt
         RpIMkfzAAgKoZI0cZ5kIHie2N8v+EZjn4z5QT7sXz0iXh/lgkQa7k3aMbD4KjkRQXg5l
         djMYN92Ju2Uyxkd7ROtdXQTVlnv01zqYbqV1HyET2OjhMOuuY856PfCWNTKQuE6sD4hK
         8D/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939120; x=1708543920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeJAk6Zp6bPsfRxVidxHJKTPkNWhEasrEXb13lPpcs4=;
        b=p+kavvUMSfFa8aMXoenbyFzj+1tq9Eu7bOFemtDZCEzHpoFBJ/RgyvkA0Yhn4hRG/Y
         CRiO55WYpTsbGHYpuwuYJRaaCfLdQyqd4teG3KzZx6IMWOE8HUXu8rPNAbG5E/uBC3Y5
         7ODdtcmRs1cWLwN2VQKyc9GP/WVa38NyAN9qt1HtQFIcGcEVvAC8sHIcWDZfVM8s3Vhb
         UNtVz5hh4/jTq57EPShnJQk9sFZOqJLr9jgWFUDhvKZeldjSIxBWbvWOnUpF1rWxuFNf
         HXvOM9Htt19gD+1u5xirVOGz2Vu2IPPTUBGlC3FUKtouywdlWIYMQXPV7uslZHVwTJFU
         uS/A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6xNkjdFS2HoNiuoYAFeQzTxZ9zGIzMbPP93WkuepcHLTe+lc+siAFsNeU+8d1+N70TUkRjoMu9jNDP30kNm9GgWkOh1n
X-Gm-Message-State: AOJu0YzCvdXpc9P1cNE2KKWVGrXvi+fyexhfTORZyJlip6IoXOWbJ+vB
	DsQ6Sf1FkWpUDqu0Va/ORF4YGvZT9XXONGYdAny6dGVdD0J3aHpyunYmiTERsdaeK++3F6RiZvB
	udmK1+d45E+OhJsOYgPUOYBLMD4mAXZr+Ll86
X-Google-Smtp-Source: AGHT+IENMomux6KIPUqN84rNKXooqQTOW8+AzALdtqGiYWL0fag3ORRcxEGlW6tJnqH87GQpxP+sgF1e18X6Dg+FX6k=
X-Received: by 2002:a50:9f08:0:b0:561:e7d8:50a8 with SMTP id
 b8-20020a509f08000000b00561e7d850a8mr338752edf.0.1707939120002; Wed, 14 Feb
 2024 11:32:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214191308.98504-1-kuniyu@amazon.com>
In-Reply-To: <20240214191308.98504-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 20:31:46 +0100
Message-ID: <CANn89i+Hg174E+stnX7dSb5PzYDk_07biqZL1FSrNFaT5BC2qw@mail.gmail.com>
Subject: Re: [PATCH v3 net] dccp/tcp: Unhash sk from ehash for tb2 alloc
 failure after check_estalblished().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Joanne Koong <joannelkoong@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 8:13=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> syzkaller reported a warning [0] in inet_csk_destroy_sock() with no
> repro.
>
>   WARN_ON(inet_sk(sk)->inet_num && !inet_csk(sk)->icsk_bind_hash);
>
> However, the syzkaller's log hinted that connect() failed just before
> the warning due to FAULT_INJECTION.  [1]
>
> When connect() is called for an unbound socket, we search for an
> available ephemeral port.  If a bhash bucket exists for the port, we
> call __inet_check_established() or __inet6_check_established() to check
> if the bucket is reusable.
>
> If reusable, we add the socket into ehash and set inet_sk(sk)->inet_num.
>
> Later, we look up the corresponding bhash2 bucket and try to allocate
> it if it does not exist.
>
> Although it rarely occurs in real use, if the allocation fails, we must
> revert the changes by check_established().  Otherwise, an unconnected
> socket could illegally occupy an ehash entry.
>
> Note that we do not put tw back into ehash because sk might have
> already responded to a packet for tw and it would be better to free
> tw earlier under such memory presure.
>
> [0]:
>
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address"=
)
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

