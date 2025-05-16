Return-Path: <netdev+bounces-191055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B4AB9EAF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1780D172B0E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E22318DB03;
	Fri, 16 May 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGuVxTQI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914C18DF6D
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406060; cv=none; b=l2ObAeh6yx5ou4FSH5TUGTfLIUsEJU6mgaEVjw97/olUaAw9P4xj6WH90k4xoK06682x+gpP8V6LlyvX9fRpFjc+lLUp8q9L8kGNqw0jf6dUFkv/aStjDe4ZNB/B9+GpYDBeYqxyE5xQ/JXtGH36zdDBuSXYJ44WNSUe75SjgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406060; c=relaxed/simple;
	bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIryG5D4nPQrw8VYF5ynZB2otnwHATh0vtF/v7NKe1RwhKXuAKvjg3VW7px3ooUaV2YtLmXJzv5TngwZUdOB1GO8WZyOzJbMSPoTRqMwDq5FkuhjaS6sXuI+fFj2q5jZ5iApWUpefChyXjTVkxFNSXdBYJlS1/TTsxzNZVhgEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGuVxTQI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso12460a12.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747406057; x=1748010857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
        b=vGuVxTQIYGn+f+GPputS3WJ9uQtgpFnyZMc9zU0hVE3w1I4meBQumbC+zkmaj5pMWe
         /dZ/2GJ0+PzCZcZR/PQPexTMpxLls4XG1LTX8Mc3C/i8CG32oIFfgPxVGqdcwchU5zB4
         waLL9ogKl6fzdnTwNoLduMHTbuvTcTxKFViMrSAH36JaH9xcg8H+evngATmCjuUndS1Q
         AyBQSmOBIhMjyk8aWV4d+pWVovMq91xkrfFSjlI6R5pYhyDsP6ynrmFd1CfsBwzd71gm
         kNsReH4HvmeReUdPdQCbQt7EY6p3YBi3CeqZKPedRIR4RMFJfu1wO/izNHE/etK1p/JD
         YnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406057; x=1748010857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzl/I6bmaZHg+UPF2Q4+lk9TcQHEK2RBu6uj6QAfp48=;
        b=R7qbSlIefNtZI782rx434/jFV+TjdF/SkaeRbbiM6O+3fNKR44FCfFbw3P77f8C1fX
         Dj6wxjvpYUClwcSL/ZBjYxD5sF2U/zJs4VqV3RGgtuLisYkNy3YSXf/6z3uftpYAUSgr
         PMFKVtEPAOqnl1MwrjIKZUZZw7brjU6MqHwd4h4FXb7aOYPuoTrzo6xyTAAwbu1ATL8W
         SQJ8a8OV26iaow6GHhz832Ubapz1pDHay1zdcSSY7L5arZzH44lX8n8+Akc3Lad/6ZPq
         h3dIyzqFax+FaIz4xu7e9SONuq+Ua/zkgCloe9gwhJJyzXfG9ELaMH3zR5NCwxtJwZ0w
         s0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUPdiG1aCJ7LXWIrcHf5wtkOJLZv8lR9uTJwS1AaEzl+4R5QuodVYJor0cCoFpuTOm3FqKL8MU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPA+6SNeZbl0srylp94spiKojsGPr7BfARM/gNxKuF26LpDUl+
	dlHBcUrEhrq2UMbUGxwExqjTeKlqHvFds49e9Boz6teX6eaJEeLfrtURmQQJPtM93akAlBx3p3a
	H8MTYUf01DLRNTWgl9oo7wK8crUGtq2wg5KbsGn9x
X-Gm-Gg: ASbGncu99fL7C6sb7D1e1BsIy86CtITRnYIrXtSDdvuPJjysgyt4n+m5HzXxJsghirA
	QmxNxs0+cgDAvdUpMO+1TBzLeVb+R+gxW++WDw5TkMGgVNu7LqjnpLU3AxQvHELUHCrLjLmwtF0
	ll5H36VIk6qWTGUO1BnO40Spowq2BUTBQXTXDW13iJozsJ3THYaFghnRujz+YC
X-Google-Smtp-Source: AGHT+IGCSHxzW91C4A5f0hB+8GzPDiVXw/aNuBqA0vePJ7mSh5UedOWWbXq+/BmaUddB31Y12bkHvm3bpH51L/eGgVg=
X-Received: by 2002:a50:8e51:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5ffce29ea75mr210811a12.7.1747406056679; Fri, 16 May 2025
 07:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org> <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
In-Reply-To: <20250516-work-coredump-socket-v8-4-664f3caf2516@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 16:33:40 +0200
X-Gm-Features: AX0GCFtQVpgNrEjVFvdmdJYYDaEF3VTJ2Dm_tJFrdzJ22BVKOsDvuggvKcRma0U
Message-ID: <CAG48ez0e+-SdB6AWXFKBy4i2Dy8ducic4aH5=hKQDqpN_G-sRg@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 1:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Coredumping currently supports two modes:
[..]
> Acked-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

