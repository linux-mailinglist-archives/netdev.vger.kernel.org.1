Return-Path: <netdev+bounces-142866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC19C0802
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379B0288663
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A26212D15;
	Thu,  7 Nov 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIBMQem5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AF212642
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987320; cv=none; b=JvsryEqBHjif3RV/8jtt96+ec+tG1d0CCfvvE4ySgqjx1KRwU3WxFzYch2+XXgqCk8RQYabJidKcscOm3pfahOuCNjyWELLAYbrLKlcr1gEMw+ps3MSh+hRcYGOgl5VhIrWFK/ICOafQYir4Jm3YGmpP12UalN7mGQinOObRDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987320; c=relaxed/simple;
	bh=laJEKeeEOXw6OEqyzWbtv83/H2n8AhPE5GsCE0/eU60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTjWv0BM0BpPCrSCrYEOld9EoVWdk5gUK1sjK+mnNcEXzSdCmWRmXiz3wuD59PXZbD58Y+Hsc6Wu1fhF+FWpCHupVsTuOFK1huBA9k6PyrgQ5ZxInxtIAKaL/nXgXQ4/RPZ3OqdoATC5Jd7TQKj8XQGp1rCl30K2JeBlNkT/aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIBMQem5; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so33393339f.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730987317; x=1731592117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laJEKeeEOXw6OEqyzWbtv83/H2n8AhPE5GsCE0/eU60=;
        b=dIBMQem5itfiGyGv4uMiA3zED529HIMbu8vPukHtJsRYdY2jXkDhbM/iQwobXtKMvW
         +qU4+VX3cJ3pdBq0WCZZ0uQ5NKdS5ucYcIcgU7cYQlWjTI7qA8Gpy22nZuVAFDKZF2hu
         O3rnP+/d7P6RMbiu0VMEDV+XlWK0hIJZgGKNIx2e69Ch6IbzXF6vE8IBmRo9r7p5G7rj
         VjRDe8MlmY++PkGbgtd9QgxsOxDl5suI8pI7WAwWEtYFT7ihbnT9fYD0yARehWzTtP9r
         BP7KRBoTXfJgJHYsOIA/kHL13R4xUlvWNH3KkNHF4PdO72wxJOJqB7CH8xDQk6eeH3YD
         lCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987317; x=1731592117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laJEKeeEOXw6OEqyzWbtv83/H2n8AhPE5GsCE0/eU60=;
        b=L4LqWZuB+ZAs8p0XQk9rxRNp1bXDQSDkIAvM9Ryn5IhruWsUpmQGCLqrNSDkL+JzQE
         ZB28RYLLQFMuwy7ZE3pT2j7cM807Z17fspyOy8RDBiJ42SGolbtc7MJg9W2lJU6b5CQG
         AdJLoRcN9gyMpTpKxe+oxmUOQ8JZcTQRDX0XgKLZtN0xPZLxKmKULut/4YB3hHJtKrHR
         M2HEkEhygQHZP5Rus7W+nJjyOJLIf8qT/RiNVV21wRY3mrjFUvVbqEn9slg/jzaf2vDQ
         SOV9nm1DS6zFU5KbCO/zFTAkUavnap2LEYbtgKM6Fzub9SJRuLzf4lVAtD4kA32v7jR9
         TXOA==
X-Gm-Message-State: AOJu0YywfkDc0qWwjetAmNIDS1EkNBf4FCOil1cwJCtfi6RTawu6k/6H
	OoNcTyawWGohXNOmix1va1ydDHhsQzpsiHSM+r8505eie9VQcqN6LITA5SyInDclU1so/NrsoIB
	N/lUHlx0YH54lrdjGRxICA6gltg1SZSQq0Hro
X-Google-Smtp-Source: AGHT+IE9lVL6r92ov61s6WtwaIuY9wzLBxF6URxkqNSsgNlymuQETb1eBMN6V7cE3y3y35rIs9W9QHgksCCApHO2i7g=
X-Received: by 2002:a05:6e02:188c:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-3a4ed2944dbmr457287935ab.12.1730987316050; Thu, 07 Nov 2024
 05:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107132231.9271-1-annaemesenyiri@gmail.com> <20241107132231.9271-2-annaemesenyiri@gmail.com>
In-Reply-To: <20241107132231.9271-2-annaemesenyiri@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 14:48:23 +0100
Message-ID: <CANn89iJbw449hwA8zPy1B_auUq=fibc6B1rvn1BOwf6Hr08t2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: Introduce sk_set_prio_allowed helper function
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:23=E2=80=AFPM Anna Emese Nyiri
<annaemesenyiri@gmail.com> wrote:
>
> Simplify priority setting permissions with the `sk_set_prio_allowed`
> function, centralizing the validation logic. This change is made in
> anticipation of a second caller in a following patch.
> No functional changes.
>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

