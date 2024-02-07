Return-Path: <netdev+bounces-69922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D6984D0E7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080AF1F21876
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0682D73;
	Wed,  7 Feb 2024 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lz2hSV7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDAC128816
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329193; cv=none; b=jh9PCtMqc0Z9Hp4o2emaQ+8ML7fOq3xRhqlT185mCB2JvTf7Wb4nunRIkUc3+GZfU/MUyRPiozUp9ASIY7gxrHpnL1i9TwrgYKXlxlItmn4tUfn06+YSBHVVynpi6jzfzBMwvZfEDbGu1mYkwHD4NO5CgqrIF9J23FUpuyi4W80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329193; c=relaxed/simple;
	bh=FbPnNAGdA+Z4vkIjVqGfUek4LBzvBXvj6UQfxJdNe4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcrOvDz/iPgf7litvit4j2EJhn4U14r19FdQgnI9nuKrrsKgjB9TSpyW3oTPGOkp9qUjecFNu5AumoZ4AMfNsr8ZYnWekkjVlFRZXeej+33F59pG4ydi6BfqzeU6+z/7z5c/MIXk48P4Nd3++XhPPecmGNMfulLt8LuU0Mqargc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lz2hSV7a; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc7319a07a2so1057009276.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 10:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707329191; x=1707933991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbPnNAGdA+Z4vkIjVqGfUek4LBzvBXvj6UQfxJdNe4k=;
        b=lz2hSV7aH1YH9XsTdpNFeWTQl+l6HC9/gjk2lpVcY9+4+wnJkAn6G/6QXS5zYA/2I+
         MSk57tMpMHQkDpCnte8zb/drmSw+5lDPXBd2m/NJx78Y13wZGP4Q2tjbFGlbttIbZV+5
         qBKYuP4SOPgWk7uEEjzb96ZxZxHymSC0ZL94kWRbffhRodJN1MEKU4YTBN9kOR2oEi+X
         b1Mp9WIcgk2zOgf7DQCfXCLUeXSIOCtMJ5Ga8O+x3PAPPzKKN510MQ27ENqcDAUnkAeW
         RFeAK3mBhMXjEzsLmElwZxYKICfi6CIeRaFMX1sBeNuuhUm9sjPoU8Gq3AALZziK/7Mh
         vcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329191; x=1707933991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbPnNAGdA+Z4vkIjVqGfUek4LBzvBXvj6UQfxJdNe4k=;
        b=mSLS3RW/gq7zce1QhrxSeI0ZIQL4BicxzO8E4TLQVgLhPBDL5g0Q654Y18t0PnFe7U
         41hXXWHcwV+JT9BDW6aQEkbB7Pi1Av4zTf/JwcYvhvwVWNjZhCRbYRqU3JKTCfa/ka/T
         wqFZlMRBYHUNy3qg8AphFSiTfiZpLYLcKc4R6ueeQixmClNR4TYAFSy69CHhvlur53JY
         tesKXTm8oidFBejScFdwTEPAfuMEthFn8k7RF+sdLMwFbCUeq2BI5G01cIjdFBXxyAvw
         I2NRWTbFtg4oa3GDLPeutjSYQzNuin2eZLk/0+WCsKdO5WlFDdziTP41s5HU1Wb0Mo6K
         NJbQ==
X-Gm-Message-State: AOJu0YzXeJBrGV2fmcxkBJK0huKcEhSFFfMeAG7e3wpo26qPRSAOOac7
	cWay5DTYmbvt0bqGhUVVDdG+oixB4lHbQmxd7V68WOq3xnqBS5/3t0UgDiCsOqu7vpz43iP7aEC
	Qtw80oe+GAhCOuWgGKloa3he2TjvE93LJZyPykwKlcP3gv/Iyumcv
X-Google-Smtp-Source: AGHT+IHiHfdXSidG+UIo+maPrsvLOXJqVcz2vALelw+WT2KPbSH1zbreoW7LTGliN0/tbJJTyJ1mg6NwB8XOFhC8Kl8=
X-Received: by 2002:a5b:609:0:b0:dc2:1d13:2f4c with SMTP id
 d9-20020a5b0609000000b00dc21d132f4cmr1820152ybq.46.1707329190680; Wed, 07 Feb
 2024 10:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
In-Reply-To: <e2871686-ea25-4cdb-b29d-ddeb33338a21@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 7 Feb 2024 19:05:31 +0100
Message-ID: <CANpmjNP==CANQi4_qFV_VVFDMsj1wHROxt3RKzwJBqo8_McCTg@mail.gmail.com>
Subject: Re: KFENCE: included in x86 defconfig?
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[Cc'ing a bunch more people to get input]

Hi Matt,

On Wed, 7 Feb 2024 at 17:16, Matthieu Baerts <matttbe@kernel.org> wrote:
[...]
> When talking to Jakub about the kernel config used by the new CI for the
> net tree [1], Jakub suggested [2] to check if KFENCE could not be
> enabled by default for x86 architecture.
>
> As KFENCE maintainers, what do you think about that? Do you see some
> blocking points? Do you plan to add it in x86_64_defconfig?

We have no concrete plans to add it to x86 defconfig. I don't think
there'd be anything wrong with that from a technical point of view,
but I think defconfig should remain relatively minimal.

I guess different groups of people will disagree here: as kernel
maintainers, it'd be a good thing because we get more coverage and
higher probability of catching memory-safety bugs; as a user, I think
having defconfig enable KFENCE seems unintuitive.

I think this would belong into some "hardening" config - while KFENCE
is not a mitigation (due to sampling) it has the performance
characteristics of unintrusive hardening techniques, so I think it
would be a good fit. I think that'd be
"kernel/configs/hardening.config".

Preferences?

Thanks,
-- Marco

