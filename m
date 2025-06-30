Return-Path: <netdev+bounces-202643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40C1AEE715
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BA93E01B7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFB299957;
	Mon, 30 Jun 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNcGMPnf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613B291C30
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309961; cv=none; b=Xg48Y3DuC9WnciHM/rbl6iJXaHs6HqxAw3O1vYCk5FZaQsBDVCOfRMfJhKG8dofbPXiuCamxNX2xbOHynxMXkIaY1OB30ac5LQBog9Wp51X0nTobeNLaXbJ5OlNaVjkMosctXRTQe+2VoLDh6iN/tSxIX49jjEbGYfzTLUE6ZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309961; c=relaxed/simple;
	bh=jiu0+hMEGOVBbPvfArelw7aUGG6y6JNsAsa0sxGu4qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj9AGpQVW5VoaQDejvaYX5f38bNIlz8NDCMVqG44PZ0HapurYB6d9SXVucfFIaFr8xvSjC5lgpdmDT8H307S1m22wm5WV6OXRvXBWLe187DcQRtDwvmvchnJvhoSZfKQQjSY53J2v3G9Y8R0jvTdBhwsueoqWdrxMxyUx+Uap1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNcGMPnf; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313a188174fso4767006a91.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751309959; x=1751914759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiu0+hMEGOVBbPvfArelw7aUGG6y6JNsAsa0sxGu4qE=;
        b=vNcGMPnffJnhjm3fRDaHSDYxYoAWrEo4yKxYmFJZcAf5fUELU2C7u1j19aCQwAVSV4
         BNKQ5zkh9mKdJshesoPr4cCJLL+IB4E8Vo/Qx+PfHDa7zChlA6VZ/0rjGboggA/J9uwT
         IvwkUA2cj4gNcjFjYHCLNx6v9W4QUfE5AqUJj1BT2eZERyoP+5oKV7wyIGTYDpOkiAq7
         f6ogmf35XFKqiSDESLbsOJ4jI/sWAYcZ9la8ycxdQnOckFJVeGFJ3k4A5tAOipYsXAV/
         jhwvo/GfFDqNn2bOGzEYFFj16nIDWW21rdIAYBdx7HtPLuhUjWiW4sryUU9dWf7RwZLU
         V+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309959; x=1751914759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiu0+hMEGOVBbPvfArelw7aUGG6y6JNsAsa0sxGu4qE=;
        b=a+DNkrVXHwzGUAgSnkE4gdLbxv2OpiKmaYtoF0GSS+mybDYdxskepX2WfD7yY9JxdM
         u3l0PSBzT60EwZRKkESyHBBFUsVt6T5RXAgbifmzHgP25IXEM9DqpiYx1EdtEmbha2eH
         tPzJqKLH3BLqn+n4lB8NIux9fMZlynjSXoB21KNdRY7Z9NJ6pmmE8W4EjWztJdArvI7Y
         JzkXKMW/hkPNINLsY3FBx7M4G1I97jJ9egxCQ2YzCRXaZhlVtyogqhX2Irla85KGZ87h
         gdP2Fsp6poEwwqrxn8BrLiXXt6wAu26O4mwxWyC3a/BlvwNf0e8tIu/eIu7PsaWYIrcK
         tNhA==
X-Forwarded-Encrypted: i=1; AJvYcCUDJmHn5kpF8D/FL6rQVq8G/QmdQgQFant2gNMR/vkKhqbBVf4Bp9EZ6JNivtDOHc448trL7VI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UfF8HZyTiEd/QmcG7RR+gk0ozXGU51donZBT8uYCZ45/NC3c
	R2bcHMcTYa4S3zjcA7XwmycVHnOH1q4RnwIONCm3ceA89JdrA3tGZT0LcrJKKJ3tB0zCjCefd7J
	rPsOpEmkB6tz7sbkFelErupkzfwSYknzrdWa+HqTD
X-Gm-Gg: ASbGncvPpKNI4eoUlQxJa+3qvNtpTX9RHmEQULgMVsvOzMUEDBth/3Q2f0LyGRrKbKv
	GShije/4To2Ws0qCmDXkNpuwRe/GAREDHtC/ycNJhk10euCgv4SRPwjBErCw3r5i0R7v4ozxeo6
	aeQrcuwnAo4Igw3zrXjsdQDtygzC6zjzyrfG/ye+M7dhIJwblndOcnrLMOteu00v7/ca+mM2Ze2
	w==
X-Google-Smtp-Source: AGHT+IEHeRuWilp8GcPNmBTSkqpOEL9X9afdNRP8SzPgcgvaVfsEoIRowf7+dqoEoXi5E8+rYSgYulvRYGYg8UIREt4=
X-Received: by 2002:a17:90b:2e4a:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-31939ad7d19mr832328a91.6.1751309958529; Mon, 30 Jun 2025
 11:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com> <20250629214449.14462-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250629214449.14462-3-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 30 Jun 2025 11:59:06 -0700
X-Gm-Features: Ac12FXx8h6qFKS4tZCgWPmiRsjQA12jiJH52womORS_f6_CKqpkkAAOXlUIFp3c
Message-ID: <CAAVpQUAOwF5a63hZ6hK9ffLixpYN18PzaGjquNgNnG5++iNhqA@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next 2/6] af_unix: introduce unix_skb_to_scm helper
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 2:45=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Instead of open-coding let's consolidate this logic in a separate
> helper. This will simplify further changes.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

