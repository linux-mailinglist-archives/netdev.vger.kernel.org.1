Return-Path: <netdev+bounces-204035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F700AF881B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E199A7B7A7B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8067B2609C3;
	Fri,  4 Jul 2025 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywvWQp6I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A21DE2DE
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751611091; cv=none; b=hJfmEQDV0MUfQP9d1RnwSfdZ+ErbwRbyc+rJjNxWXsTttI2Ts9drmDExlMlz5debbsCJLYNSesnsRCUiq+e+E27UbYngIi36onNPti1L8jbrk3FgSwHm7bZFUNHL/TKQGtTvKn4tqVHgh2EycSXF8Y7PFAtdeHA5JCnu5oDDAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751611091; c=relaxed/simple;
	bh=vAlKMziY97tQDFNI6wEVL+T7PwCEQ8z9jOG1JX0Q9Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lT8lnvMoiXvrW/fYxOPPl4CKRax31bcYAnVKvZJe3YV0VHH458SFvJ1KYpiyQW/eGyA9UkrUmIcmx6T5KVR5z827mKQH21i3YW7tq63wVze1ue85yCN4mFocPZ4SpSHyXzEb2FhOujFe592RriRBwPudKvix+kpXkPI8un8BnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywvWQp6I; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so1469729a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751611088; x=1752215888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAlKMziY97tQDFNI6wEVL+T7PwCEQ8z9jOG1JX0Q9Lk=;
        b=ywvWQp6IpfBP/i9GRXd82KuAojHzn1K8zy9RQuUZb5aEbFb4glbjGxjXm9OvZ4Iqgv
         7KMC38OiOqbcthAXKfCn1xNriXMD1x5BWPKBbPZrSVFNJOYgJG+rPkHuuuEem4QtXvWt
         YLNaNjc4XVFDnGe52VTIA6fjQ6Yn78zCTmLYeCsKeOH6uavYITYmJqJtLQ5UpVBpdpZ8
         +IqEXnKyCk7DXQ3Geu5+g3E31sGzT78uwBfiX4QBIkACVTFbR1VIqR4RQmYJ9xJfHBxR
         U883sEWfKMA84tLAJoL9q40b92jaRt9GZVLzKiQQzEHyQQvjAlwFXqB6GODg6dTlqFIp
         zB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751611088; x=1752215888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAlKMziY97tQDFNI6wEVL+T7PwCEQ8z9jOG1JX0Q9Lk=;
        b=BnVdw6EkM+KxHWlFLcTM9DZ47sOG5pVXFyUNWELFMNkcI5gZ782XaTjElJeNmqpkJG
         PxEM7lZwhC5iq6G5+ww4YyXd1blo1fdC9MuXNGu5x23TcujMJsIAYXTIDMsXvm3Iu67A
         WZ5+9GdooKN4GevSnNLJtVkaqatJcAwJFjLod7Dyh7ULMO8hyEUwomp6igVEGbxWe5bn
         NBnb/jXBxdwjrl3nZMuEYJrgV3o58PhJtdcZYF4yJTihL6XK4VqhYNulZApl8p80UxwJ
         3ijBojVzJsp/2+T+lRHCogzfkXSuK502tk1MLx++a7D4zO0B+sdODKG9CRKmyroG95KZ
         UEAA==
X-Forwarded-Encrypted: i=1; AJvYcCWSd1uM+w4Ms9nfCn9AouU6KZ3bxexMWZrtEI+sqPRsoOV/HGyC4okX9wC04iB0/rl1rzJt9zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvvGUTUAnPgIEj/zcmcjnzXrTKNzQm87CAECKwguYl6SEEG4a
	FM2SejNhHyKMVdE5T6dP36kNC1RQ7Ecth0T7CiZBCftcObV1/h0RYmybH9O3ei4/aMfd5JE3WqA
	jXIGizSMPR9KQN7zGwNYMuaqIoZGKq7WNS+9tfsaq
X-Gm-Gg: ASbGnctgc+A0zXjWSp3aKv5chvM0MvsghLr2ZBf6MAodaIVye87mFmgHWseKonpl34b
	/d12yYurn9u47NtK4vDPg5cMPxa+QJjo9YcTBC1E5xrh0whzZbkRVd7nmAF8hROLE6bDHR+jT/V
	x7I7A4PKR3e3nTocMVMpy8BywI2XLas7G7xwQkQmsOA9ELmhL4k5n5XiPvRWLQ6xJo5uasTBYJ/
	g==
X-Google-Smtp-Source: AGHT+IFMCdF8tTp7y1tnqm5p+NZdaM89rR7Ng9JYCVKhOuaHRvzY9V4rVI8evYgKl1FApkbd8ERvKt4XsGHdXsQz8hg=
X-Received: by 2002:a17:90a:c2d0:b0:30e:6a9d:d78b with SMTP id
 98e67ed59e1d1-31aab8cc9d7mr2586494a91.12.1751611088395; Thu, 03 Jul 2025
 23:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com> <20250703222314.309967-7-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250703222314.309967-7-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Jul 2025 23:37:56 -0700
X-Gm-Features: Ac12FXyjUGL9req4-D1NwQM5jn8O2JvTQBZh9oyXfeZy7QyRI7yyeuci7HH_Aj8
Message-ID: <CAAVpQUDn6vjd2SpwZj8v9KM=yzmC6ZjB1sf3xO4fc=sr4s367g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] af_unix: enable handing out pidfds for
 reaped tasks in SCM_PIDFD
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:24=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Now everything is ready to pass PIDFD_STALE to pidfd_prepare().
> This will allow opening pidfd for reaped tasks.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> Reviewed-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Overall looks good, thanks!

