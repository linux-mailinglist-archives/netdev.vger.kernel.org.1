Return-Path: <netdev+bounces-148789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB449E3239
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8A0B271E1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7914F155747;
	Wed,  4 Dec 2024 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UIvrkUQv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58615573F
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283853; cv=none; b=FpfVvozsdiZOLG2bPLNDLXqldeW1hNxrhZU7MiwapPBqQ449MJiCkx447Hy0yTVHvqH9exCqeQnESlqi3SsKAjiezI7veOofCjtaLjGpnx7BnWSA+ZFX60cbJZZgn95eObBDrY5UW+/3eRSBk8PWnLxLBUU96Ar5QE5tl3YrIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283853; c=relaxed/simple;
	bh=sSOfX/VJkWpJudyMdwZbnqRn3MPlXSopwU2F416vkiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHGye3j+Om4n3T9prL89wddcFtt/UVp02OlJzWLRJK+UZ7dfFKB6ZLbe4bxz4Nso5+kc+wQbz1zLR2yuB7GrW41cVWx0G+vzUpE+A4vw94O5LuwutQstddSUkjb9VFAXWM9JMVmI2uomQKOHJTAuC1IoVLefFcaPBluCooop+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UIvrkUQv; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e38df4166c7so5317039276.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 19:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733283851; x=1733888651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSOfX/VJkWpJudyMdwZbnqRn3MPlXSopwU2F416vkiY=;
        b=UIvrkUQvCbBdnBxYE1xsHl5ao9zOa5/gt4pzRn0okLYXQbQtrbXnvhR9jpiDbK1nXH
         JmLFoC505gagmLHxS+yNV/xyiAL3Da0oeEwHpIAWtL40AZBvv/0feLNFJerPZigcN7m6
         tXkPHlboHl/9lMhW+QlrXo6VBdoC8Pb+jII7AfhlRswGU1VUWLuc39s//ZVyKY2iwFyw
         U+z4H4lsi2fJZ0FHs800rYIjRjAQHq3S5eGBvf/GIwIJFpyXZ3WmYH+oEn2xsn1QAdBC
         ns35Pz7YMEmcb5V9UpHGZn3UPSpYWxiIXw9vGQvTNES+HsJYZCNIr1u1R0nPGdZ5ou2W
         /OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733283851; x=1733888651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSOfX/VJkWpJudyMdwZbnqRn3MPlXSopwU2F416vkiY=;
        b=I/kEaxPmqri/6zKAYSQg9g2SeHwEjPoBLpRz0VlKrwlvINCj8g+QvaAhhEZjj3ar+6
         E8PdUJ0pOx0zB74AbXNRANEcb19SxXrYa4jt1cjxQa53bHxU1jarSj4J+WPitoVKfMJX
         3tcnl4TDsna6sYdF962lcPLzjgmF1enKrksgEKsx6uH4CZNcc1RSz9FoSSjEfuBmHURV
         Het2WKR6DSdgYbYllLW/i8aZFsr3YfRK/F8UW5qKL+3BE8qufkbi9dh7gSO1zFG8x56A
         7PfxAyIdtlR/mUngJDkBfK1BtDXkW9u7SSYiVXl6JxDXKQ0PmLo2h2sdyvLjvjXidNqj
         YWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV51e61dkngb93E0auL5Led7bOLrRMaSEFC53giPmT58mqRxE6TfgYv6n4pXQHXkixU64VGUyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHeL8ghErr9gqemMF8AS4xWeJyIYOBHvbWTQlx4mFEanUo5WG
	TpIjMlkgOnVWuZgQ3XLVtq7BX7zfZrUF6IWKyN3z/vWpTHZNV4yOw5lmDCq3I3yQ5wQwXNLlULM
	d19ImzFiHHhhOO3wxNPUijo8vO5UfJDhXtTGR
X-Gm-Gg: ASbGnctzqWOE3z803BdJpBn+quW7/lqzJq2JkiHouOZ8UqRVAVHQloeK9LWYcQ2nezG
	+RuMSlH3hrOuJQTLpZ68C+Heo56onDQ==
X-Google-Smtp-Source: AGHT+IHegUUBo1xF0JACvyh6HPUnWPYgI5rSYqQsByt8khZRn6ygnWTVW10hnY5SDDp01LxjUmTWNgUuz86mybiFo2A=
X-Received: by 2002:a05:6902:2d86:b0:e38:8749:815e with SMTP id
 3f1490d57ef6-e39d3e1c716mr3895579276.30.1733283850958; Tue, 03 Dec 2024
 19:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126145911.4187198-1-edumazet@google.com> <173300343374.2487269.7082262124805020262.git-patchwork-notify@kernel.org>
 <CAHC9VhQFEsPfAZ2MLw7mB7xwOFHPA+TXf9fv9JQDMEFfsZDWJQ@mail.gmail.com> <20241203165552.07ba0619@kernel.org>
In-Reply-To: <20241203165552.07ba0619@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 22:44:00 -0500
Message-ID: <CAHC9VhQpRa4nOunEpz2tc9G2yiO08o+EJPHs_uZhqCVbXw7C-Q@mail.gmail.com>
Subject: Re: [PATCH net] selinux: use sk_to_full_sk() in selinux_ip_output()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+2d9f5f948c31dcb7745e@syzkaller.appspotmail.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, selinux@vger.kernel.org, 
	kuniyu@amazon.com, brianvv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 3 Dec 2024 15:50:46 -0500 Paul Moore wrote:
> > > This patch was applied to netdev/net.git (main)
> > > by Jakub Kicinski <kuba@kernel.org>:
> >
> > Jakub, do you know when we can expect to see this sent up to Linus?
>
> If I'm looking at our schedule right - Thursday (5th) evening EU time.

Thanks.

--=20
paul-moore.com

