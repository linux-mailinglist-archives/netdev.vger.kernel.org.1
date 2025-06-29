Return-Path: <netdev+bounces-202304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6DFAED167
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD6A17447E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F422FDE8;
	Sun, 29 Jun 2025 21:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="P9BKVx8e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8FF12B71
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233853; cv=none; b=iZgXxsNdTp3e0zAnJmhrLhntUL5pSjHlTNx2eFz5Kmrxj3+DrfjTOOcnhpDt0NlMHFSWSxJccj7JJlSt1GCzBYSZ8LRM8HiqXvFze5HSCNJHa6wHPF/9X4svoDqm0nZjF9zAqN664JtZmxnhRVIK2iYmpGmA8QE3j0+bOM/xB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233853; c=relaxed/simple;
	bh=qO0rik26FBneJbzsa9ayRMc6c8wrTlvCm/fCbU3rTj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBcLJ8W6eB6FPr6SGCNcOsELQeQQdyJ2kNIsyK4X2qjH1r1+WDIZHjy/ObeYoibvBgQ+HXPVRsAoropHtq7UX4LBvJT1ytsOr4XRDcFUrMn7T6qm3B+yumAVW1kAfr9ZRgrMf/Bt9SP7nJfrofqp00RFsOKCfv51B5wxF8t5oTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=P9BKVx8e; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 574503F657
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233850;
	bh=vxyvHsvR7bghBFrXwsxkgXknmV7/aeenDIgq9okrCzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=P9BKVx8eW9ksbAAaFN/FQ7Cu45/DjCnezcqz94z0g7nPZpyT60QRpvDMAZtLCtkvP
	 vLe08C3kuHmGq1F3++Aj32xS3RRoghQy0QctYWPYVZPMJgkeqNnDLnPrsRqio2Txpz
	 MkD3OrbyjLcvEQfNB5PZZfbZRidLoLMoCbDDNdrcX948q++nXlauI8Azk6AKxQM1Me
	 Vf15eaNevi86u7CyVbTBMIZb0znQn2E/Adln8Mm1FeFHhKS6FjG9aa+WUFZ3q1ZYKV
	 22gsTFaQaVjp7Kb5Rs+IY0604KKS9pIgsblHvwiE1F+hBLP0L/43hQaBfdPIZEZfsD
	 EqoRrvyjmcG8Q==
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4e7f9901894so287510137.2
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233849; x=1751838649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxyvHsvR7bghBFrXwsxkgXknmV7/aeenDIgq9okrCzk=;
        b=JfrIkOiGuKlJACfNZB9a7XGnbEF5UhvMHJgpuOfVkFzO6hDCVSRvULvGxBaVR2M4GZ
         0xPVJupGODvyL9eV4dWMpNNXyQKaod90UfLC0ve1jT9QIDxcea0yJtqzXagSIn0ln9bV
         XfTP9AvPbiKTC1ZS/2gkLM6nOHY9760OmUaMZhTA7v2vQW7smnOcFyU2PjQIDxUpiHN5
         hC9E+TqCfrxd0hkWgsokHK0NCHvqRD7ouVzwk94wXLvvyHorW+5UzdNUyJ/wqFSsYG8e
         EzZFZIzharnIca9grlMVEw8mE6ATtgkPyA9Iw3WcedTsFO9bBzYjn/xn8/+cmkz/5SaT
         lkLw==
X-Forwarded-Encrypted: i=1; AJvYcCX+2yh5nuHvBKoKRFS7ymjeza1e0qDr5LEgSwpe5yMVL8s+naC8ybEm0OyRUQmxowmrVcj+fPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuZuv9I17mpvo5qQeAnkAmhg2s7/WmuQu7R5OrXlmBFO0DTIl
	Lsc8yVXi5F+ntuo2Oo1KsoYQW4tPrWqbuoqLqGZsWc+S740APFNPX+ha3k6HFRKLcpZ+XESaXnW
	2n8fXwDCfxjYw8yiQnlZOrA64nMjKTu5hA/Wt9uJSaY4MeY2kuMECVKAfWukH1jTAKTZ0XkVr1d
	R7W/CRwmiybraNcNJbLINs/ojC6Vb/J+dRwLFda7TrPcHETDIM
X-Gm-Gg: ASbGnctli6kk2ZJP+EI8TrGEo8Dlx+Ojbx4WO0C6rV9v2KmzjALTiKmT3FqFSNGI3zy
	0QLm2CQ02Sm0FR97uw5dofNh1uR1IHpGN97h17unC9FtHaFmuP+X4NtCoVVvU0h447f5QklGbAQ
	P83udY
X-Received: by 2002:a05:6102:3586:b0:4ec:c53f:bd10 with SMTP id ada2fe7eead31-4ee4f71e193mr6111400137.16.1751233849173;
        Sun, 29 Jun 2025 14:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3putHMCnjEhjB4xKrKlaxAT+T0n2581zYJq5hWZq+70KQno6CFRHk1W0b4NAbY4BvechoGFe9nlB5GwpCag4=
X-Received: by 2002:a05:6102:3586:b0:4ec:c53f:bd10 with SMTP id
 ada2fe7eead31-4ee4f71e193mr6111395137.16.1751233848849; Sun, 29 Jun 2025
 14:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Sun, 29 Jun 2025 23:50:37 +0200
X-Gm-Features: Ac12FXyuOv83FzEnLL7pcPZHj9NI8wpeuDQ4Pk25uk-jiPgsNBgmrOk7LgpucO8
Message-ID: <CAEivzxfLCdv1H6ye8pazG1jw5qiBvtCf2zxE1nom=ziNtwuNiA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] allow reaped pidfds receive in SCM_PIDFD
To: kuniyu@amazon.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Lennart Poettering <mzxreary@0pointer.de>, 
	Luca Boccassi <bluca@debian.org>, David Rheinsberg <david@readahead.eu>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear friends,

Please, ignore. I had to resent [1] the series because Kuniyuki
Iwashima's email in @amazon.com is no longer valid.

[1] https://lore.kernel.org/netdev/20250629214449.14462-1-aleksandr.mikhali=
tsyn@canonical.com/

Sorry for the inconvenience and extra noise.

Kind regards,
Alex

On Sun, Jun 29, 2025 at 11:40=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> This is a logical continuation of a story from [1], where Christian
> extented SO_PEERPIDFD to allow getting pidfds for a reaped tasks.
>
> Git tree:
> https://github.com/mihalicyn/linux/commits/scm_pidfd_stale
>
> Series based on https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.g=
it/log/?h=3Dvfs-6.17.pidfs
>
> It does not use pidfs_get_pid()/pidfs_put_pid() API as these were removed=
 in a scope of [2].
> I've checked that net-next branch currently (still) has these obsolete fu=
nctions, but it
> will eventually include changes from [2], so it's not a big problem.
>
> Link: https://lore.kernel.org/all/20250425-work-pidfs-net-v2-0-450a19461e=
75@kernel.org/ [1]
> Link: https://lore.kernel.org/all/20250618-work-pidfs-persistent-v2-0-98f=
3456fd552@kernel.org/ [2]
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
>
> Alexander Mikhalitsyn (6):
>   af_unix: rework unix_maybe_add_creds() to allow sleep
>   af_unix: introduce unix_skb_to_scm helper
>   af_unix: introduce and use __scm_replace_pid() helper
>   af_unix: stash pidfs dentry when needed
>   af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
>   selftests: net: extend SCM_PIDFD test to cover stale pidfds
>
>  include/net/scm.h                             |  46 +++-
>  net/core/scm.c                                |  13 +-
>  net/unix/af_unix.c                            |  76 ++++--
>  .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
>  4 files changed, 285 insertions(+), 67 deletions(-)
>
> --
> 2.43.0
>

