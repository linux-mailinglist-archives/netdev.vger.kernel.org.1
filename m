Return-Path: <netdev+bounces-147217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD79D83DF
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 11:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BF11637D1
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90DA192B90;
	Mon, 25 Nov 2024 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IT1sTtnJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE551925A6
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532045; cv=none; b=I4zX/1O0rYEm428y0R1j5wq4UHXf+FLLm1GyKb4/9wuVdH+IsEsv8p2OjuxjBLjHbkVawXhQegPC5xpWmRKr6T39kwZY0iQman5gpFHT+X0DLsRxb6kNt7L1eOJV0/9KsaltygSuH6xSCU91NBcwLAXSXPCh2szKAumfgyUGmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532045; c=relaxed/simple;
	bh=8L9zH37PihLGH7oCVsrqFEdHfvi0SSNWFyXIKGqOkuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3797vuHxpCqZBsTI1D9heaWk5fkac0STSeijWcjg9hB5f7TQq673q8ZIFWvL9Ajzwlfko1N4GgXd0hYJmH7PGt5AANyipZsOux4ScU8wu0wh7WL7UVq98U9w5Fcdijyfi6pI+Ln+t2JqSgcdSFYhmwVzmRWb7PyaphB8SNhoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IT1sTtnJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724e113c821so2401848b3a.3
        for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 02:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732532043; x=1733136843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8L9zH37PihLGH7oCVsrqFEdHfvi0SSNWFyXIKGqOkuE=;
        b=IT1sTtnJu9EudPvG3HAY2qvKplFaruAKy0TH5gHu3XuBhyb8WFgL4P/W4q9izEQ4MA
         oCR+PgMNx+Kav849O0P4Txkn92w8zfdmcPoaI17qurUaPYYQJ2yGGvDP/3GOuiMjv9bH
         vR2R4pUwN8AOIpFgq2M0hdd3o/D247rmqNilcdvjbapG88tCUbWPchokF+THj6yZ2UlX
         LsWwaPtuuyk5DDLcXkNqJShMdyiHbVaS52JVMbPbSLo9SLeZjYbouUfzLMfTT6ytoi9M
         v2P71FmPTnpKFgx4HR+lMGhMoG8Aewrhly6NoEdEeUX3/Oa6G7ONB2XNpt70WZK1xcxD
         cQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732532043; x=1733136843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8L9zH37PihLGH7oCVsrqFEdHfvi0SSNWFyXIKGqOkuE=;
        b=k67Md8uAmpvH2HP2zHAwu+DoLk8fD4pBn1kdQ37+WgKTbH35gFaxMBH0rityoZ3eLG
         BfPvAtuZf1Voe9gJiqQupTzIPg8MpGQb0647A9mZIRayFmY/4hXijRT4YBKOWbNpvBGX
         6j+0ft3ujyaduU+PG/b9qw7EWCsdj1ZaurdtFrjHSFN4UP2FV9zd1e7u7IyPjphbjpvM
         ncqp2U4Jd9rA5KOrZ0vlV31gZ/ydwMVkK6jGXg9jSdg4eN2ggS94dSHbTMKGhokIY4lo
         PSvYV1LxQZvrb9wOWGGQby8msKsYm/T8pWKwvK7btbPPVPHzquI3nT8Zz//SHmDxiw4G
         p6oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBnnW7fq/mqB1XQjN/vPEmdQE7zpl1YFg4Ac2XImhCE6gWcyjlGNNuVAfCvfkzkiQ4kBDAM7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxfl5aNqfGS7sxnm+0OAqMWsUpgtcC8MvQx6fMwle0vfm8ghlJ
	GFiiKWSXy1rRXJf/GBUQsMBCfyvKzEN/q9A87aC0kanYs4BLodxejYN4n11+7e3h+E95yxLGL0P
	2Qcfqzgxn3x48mIwFZ8pEWgCAfDmCU8gc3HIA
X-Gm-Gg: ASbGnctgKPwzugTVeWPaD13OTW2KLVJuLMGBHCgJxlHCGdd5A/71+VgUw51En612MMT
	/m7nN9hwlTT9z6VpFCkUWbuMOy6k9c0P8e9XbPfXYJInKfNZYMDCED7oNyy5uLg==
X-Google-Smtp-Source: AGHT+IERuM0LZzY0dJqigKtZGi00mi+sHukvtCdMdPwQZlpvTeaerDdXvtmMA7QOtjNPpMI2MiK60GTpWsO+Prx5PLo=
X-Received: by 2002:a05:6a00:9a3:b0:71e:6ef2:6c11 with SMTP id
 d2e1a72fcca58-724df5eed58mr16441060b3a.9.1732532043443; Mon, 25 Nov 2024
 02:54:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67383db1.050a0220.85a0.000e.GAE@google.com> <CADUfDZqBUvm5vUgRHXKjvo=Kk4Ze8xU5tn-wG6J0wmUE6TTREA@mail.gmail.com>
 <20241118185323.37969bcd@kernel.org>
In-Reply-To: <20241118185323.37969bcd@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 25 Nov 2024 11:53:51 +0100
Message-ID: <CANp29Y7XjPwy3VxR-naQ-qjMZF63j9kh7fFmVH91HaSJ8i9ZMA@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in dev_prep_valid_name
To: Jakub Kicinski <kuba@kernel.org>
Cc: Caleb Sander <csander@purestorage.com>, 
	syzbot <syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com>, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	parav@nvidia.com, saeedm@nvidia.com, syzkaller-bugs@googlegroups.com, 
	tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 3:53=E2=80=AFAM 'Jakub Kicinski' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, 18 Nov 2024 18:19:23 -0800 Caleb Sander wrote:
> > Hmm, it seems very unlikely that "mlx5/core: Schedule EQ comp tasklet
> > only if necessary" could have caused this issue. The commit only
> > touches the mlx5 driver. Does the test machine have ConnectX NICs? The
> > commit itself simply moves where tasklet_schedule() is called for the
> > mlx5_cq_tasklet_cb() tasklet, making it so the tasklet will only be
> > scheduled to process userspace RDMA completions.
> > Is it possible that the failure is not consistently reproducible and
> > the bisection is landing on the wrong commit?
>
> Yes, most likely bad bisection, I looked at the syzbot docs but I don't
> see the command for invalidating the bisection results.
>

Thanks for analyzing the bisection!

It's indeed not possible to cancel the result via an email command.
I've marked it as invalid using other means and left a comment on the
corresponding backlog issue:
https://github.com/google/syzkaller/issues/5414#issuecomment-2497667350

--=20
Aleksandr

