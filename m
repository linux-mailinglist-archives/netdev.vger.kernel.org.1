Return-Path: <netdev+bounces-211773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B6B1BA67
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 20:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631D018A7242
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE6299943;
	Tue,  5 Aug 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S4QUFLqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC0298CDE
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419377; cv=none; b=lhn2d5LSaKtGju5vSWhqucVAOcfTJ9d/Nc+UMz8j/6juxeyNidG+bffoKSpd09T+tfB26IiwiFgneAl1fitLLJFNsgEsXBvdyDE0ZQwvE5aqA6PAsyNdgQZsibz5kBMr8D7D3otZvkd0vnFi6ickSVLTOlQJF/CXBfTK6r4tSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419377; c=relaxed/simple;
	bh=ARKkRGwhJ+dVBpPJqKX4g9GOAA86TLzqcF5Rq4U+i0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuxVb+j/0GQ/iw9edRtEr8eAQclQBXlqoJt7K4dSSv4n3S1lWu8ToYaPPGocTkHpZ104etvncFS+YwddNSb5U4FlmQWC8EYZtZu7q+q2ahGdYSxiC3eq8tltdfw9b2K8Q01lfPAIfAfUaQX76hcPdyPMZsPon2eHN/CRw82nxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S4QUFLqD; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61530559887so8022085a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754419373; x=1755024173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DaXmlHuPY83XfFKjcCzkYdyqwopXmurXMD0RTxSEhdg=;
        b=S4QUFLqDSURl7OOflQIFWPlCInsVQXS9hGTFROP4uxtNN8XX8QGEESLHYh0HUB5Gmo
         LDG2T2nUlIAV5GBbmajePjt7P0K+WX0Kl39WTBfViLM/YPtR0DEqDJS+L1akLp3jnCHU
         c2prwsVWx60r4QdO62fbvTYMC7dmSt3ZK+8vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754419373; x=1755024173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaXmlHuPY83XfFKjcCzkYdyqwopXmurXMD0RTxSEhdg=;
        b=tmXt+Fn+UXuYKVBMa7xwrc8sKJVCzR5shNnit0LK6BE5zJmdkW1FEtir2zNGkcxlWH
         xHUsroPoH4tn4ao+77c3u3GLrkRZrofZ1eIWfPt3ywOKXGbu7yf6xp85ZwzfFIlL+TIz
         WP/oOOx3CFuJGe0PlNk1htb4sWh69dCY+KsXyQjXLWhXkgfoXCijKTy/FdbjdNXgTSJJ
         dbPlMOMmN1jhq09PAtMeZheF1eU9sp5pw22FR3jgbNBwpZnofImjHEqxjIwtYxFPciY/
         mjSSCac1ovh7DhpSh3XNDAR3QBsVCtd7uCyCriRK93TO9o/m625xyO1b6RKbKU2hT8WB
         43Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXFyRZwm56ngYvDwkO7K5PN15f9nxy0bJAnp86FoMd+Fccp5YFhiu7ex36na3eYqtSjcTbJHl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpiCsv2WvLQUnHYqcx+acambjRtqP7MesZl171JWyjldUuW7Ll
	NaJ2xJWtYYcWQj53IObHUhveJr9i9TTaOu977GWBRHkyOv4pjLixjSxYdSjYUDE39gxKvPAmC7x
	Keas5YXniDw==
X-Gm-Gg: ASbGnctgAyERycLdhpOnVNcvXWqfjob/h1FbAUyvDwWgXo8dVeg196sscuQCbpTkAat
	gxHRXS0HvvipdC5tNfOsgePzEsUhi5znkDV2t3VT94np6bS+K8C9PUYVFb3YLvdjMoj0KoweS2C
	97s8D+f5dtRbXgmRhaAr1z29pnD5o5o1mcmRehlKHWTXIvgBRSd5XtjH6kHaK1QpwMUPR1CZLI9
	B9fPvfmZNfN4mw1u2n9gnpJK8tWAxww+LKj9GyBHtXnfQD4o4uFQk67eqf+GB2QOQT/OFMT1rDa
	n+123hDmtrGeLvcoGfw1bvpneGX4B1NfodPdUrRUHn75bB+sU8C8iaM6NLJVEVMHVvCA0wB7Qf3
	g13REHhIrjNSJQmoLwOliA4qt0XA7630glpjEj8UU31qhLlObqJk5sVdKQLwvZE03KQkNXWSN
X-Google-Smtp-Source: AGHT+IEA3q1zsJGwOPdVN9gBLzAfYkaq+QYa7MSQ6ku3Xczx0Ee740/P01KynuZ/c5e4EpfDpHb/uQ==
X-Received: by 2002:a05:6402:84e:b0:614:a23b:4959 with SMTP id 4fb4d7f45d1cf-617960f5742mr89732a12.10.1754419373550;
        Tue, 05 Aug 2025 11:42:53 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7970sm8614757a12.31.2025.08.05.11.42.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 11:42:52 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso8684227a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 11:42:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsS7XOGAhi7BpdUjDgHyQJ/Eu42vZniof1B1JuiSc5TVk3cT5lWxhrU3XalDF/l7Vn1Gb49RQ=@vger.kernel.org
X-Received: by 2002:a05:6402:4558:b0:612:d3cf:d1e4 with SMTP id
 4fb4d7f45d1cf-617960d5308mr64129a12.8.1754419372469; Tue, 05 Aug 2025
 11:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org> <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
 <CAHk-=wiQ0p09UvRVZ3tGqmRgstgZ75o7ppcaPfCa6oVJOEEzeQ@mail.gmail.com> <da6a2585-daa3-4dd7-bc42-5a78a24b29c2@broadcom.com>
In-Reply-To: <da6a2585-daa3-4dd7-bc42-5a78a24b29c2@broadcom.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 21:42:36 +0300
X-Gmail-Original-Message-ID: <CAHk-=wgkvNuGCDUMMs9bW9Mz5o=LcMhcDK_b2ThO6_T7cquoEQ@mail.gmail.com>
X-Gm-Features: Ac12FXybB_ATEobBuTHBVMqqU6GCkvzrxccVRNBP0IuHBzVPItQ6ykQsu8_xU1E
Message-ID: <CAHk-=wgkvNuGCDUMMs9bW9Mz5o=LcMhcDK_b2ThO6_T7cquoEQ@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jakub Kicinski <kuba@kernel.org>, John Ernberg <john.ernberg@actia.se>, davem@davemloft.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 21:26, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> Looks like someone posted a fix a few days ago:
>
> https://lore.kernel.org/all/20250801190310.58443-1-ammarfaizi2@gnuweeb.org/
>
> though it does not appear to be in this pull request. Can you test it?

Yup, that fixes it for me too.

             Linus

