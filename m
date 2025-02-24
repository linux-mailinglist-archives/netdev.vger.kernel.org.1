Return-Path: <netdev+bounces-169133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A88A42A73
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF3F3AA4FA
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C2B264A89;
	Mon, 24 Feb 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="URDcLzvS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F64264A99
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419772; cv=none; b=KRwWW1dKmH2r9QG3o+PjyKR1xVJ+q9SwhLdWJcPua7ZRUp3IIfO2JQoCD1dE7UmHTcDuPIJQ9jR0SkivA/HuCP74icVSnnzCMG/OwcjNjK025r3eKwXn7iq839fLtSg1dYxnCha8Rkdyxs7tYCjwkC6tMquTgjn6Z1whzx6ZyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419772; c=relaxed/simple;
	bh=JoNWtL4pjWX/dnrAeAErjeRxJjHFptmwjkCXxEap17U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da7W25QjYDVw5TyNI+62RriZfZPcqkrNojKHLssC4IPTl23qH/B4UEAt08PB24syf/z/Kdn+prVLFmUsQYD8UyeoYFnb8tVVqpi7RBl4q4t2jwg5kcQ1z0pN8P0D2CrXxwI1EnLvYWUcdE5TC9nbIf8BZ2Zu70WjHW1pO91M80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=URDcLzvS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so10376525a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740419769; x=1741024569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoNWtL4pjWX/dnrAeAErjeRxJjHFptmwjkCXxEap17U=;
        b=URDcLzvSoRMVdK/HfdIwbtHIkag4hGbbtiagn8hbiOvzRWSpfwF8deBBR8Eknl6uUt
         DYbU6J+eKRAmt7CQIzBPHwEIAFzyaHCBmBFyDvQYfxYI5OoskYTmR996aAkttkbbToKj
         PhVMWrE8WWIFNoTnBoWE3sYlpgsli1xoNmHm3M0kEdmrR0p3LIz8xehqE+9inBTvF+F8
         e5t7Z8PzzFmyyXgd9dn7N6mQWXCeeVgEXEV7eJjiSp6QdBGyOHloNfV/h97NzWywQh2t
         d0SgG7oLaucVeWQKdgVnFLroCC8dzDkgE52o3S3WLra9N+Lmx4/GIejnJ1irC6wLKHU5
         pqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419769; x=1741024569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoNWtL4pjWX/dnrAeAErjeRxJjHFptmwjkCXxEap17U=;
        b=mtYUIjsHJF7YcKuioivX8ZHVO+o5wcKoTgFPgLCgUXSFfRCBm5MPTVrtHxijcr+XHc
         8I75RxIQFr5IVReDKJpBJdnyZzA6c4HWHLrkqa4qS3RgdoBKICI0EnlmcS2gzRSQlDkS
         6kl+ZgJsEFtLnCsgHK9bN0OOHYiC6enmk1CMZbAFpmP1hZ8V0un5w9JY/4tjPo0I2Bv6
         dqCPTR10hP/yiaHkuVh6FqO9fJpwsoAnFicQDbkcLP2hX07IyM5WiHVMUJlM4+XqMayP
         RlCBY7pLhI15tdCxo7rcAv3OR4DUiyFMohmoYc6peRYTqj3bi7Hmo6qfd5n+MA2L0tmC
         g+nA==
X-Gm-Message-State: AOJu0Yy8WMBNsyqRGT0sLDTiogVlwEgL+fofbNidUOD3aOj1yG64ik2f
	a7TTFAmDqzWrV9QnG6PK5Ed5Eeo30HaaGWrj4xgu5yazZ8r3oJcm0feWuQYhPKGXgTTRimxxjuD
	JFkzb5f4EtGBCIP7YrFmThto6jH8lmga7+RXK
X-Gm-Gg: ASbGnctfu/NfEvJ+b09bnfqtagk2+YEW0Wz3HFxP6cF9GYSp5AUqTp1fyE+10kzFPc4
	2l+zeaNomoKqinzSoAS/sopA74c0VzuIceHXeoq+mxfX96e78Ok8pBg+MbUGyaSCn2MUi+2jNzV
	RJc+Upvw==
X-Google-Smtp-Source: AGHT+IGaLhJSnUk6JJPYNcD4K1LIcwSr5VkKBquNVpILC1vv7Bk4pjUDo4vsxTybF/r0/sUSF7fvfnRl+Fr2upaH6Dw=
X-Received: by 2002:a05:6402:90b:b0:5e0:6e6c:e2b5 with SMTP id
 4fb4d7f45d1cf-5e0a1261230mr17804954a12.9.1740419768613; Mon, 24 Feb 2025
 09:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174401.3582695-1-sdf@fomichev.me>
In-Reply-To: <20250224174401.3582695-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 18:55:57 +0100
X-Gm-Features: AWEUYZlUvE4b-BBWZ-vm5zRw92OkDPpOO9uIKEAgcKkVITAUNhFPql7JlFP6UIs
Message-ID: <CANn89iKSxQrEPs6nzuQ-4psxHnJODg0TLCHqbj2P0F9VfLtSUg@mail.gmail.com>
Subject: Re: [PATCH net v4] tcp: devmem: don't write truncated dmabuf CMSGs to userspace
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, kuniyu@amazon.com, 
	willemb@google.com, horms@kernel.org, ncardwell@google.com, 
	dsahern@kernel.org, kaiyuanz@google.com, asml.silence@gmail.com, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:44=E2=80=AFPM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> Currently, we report -ETOOSMALL (err) only on the first iteration
> (!sent). When we get put_cmsg error after a bunch of successful
> put_cmsg calls, we don't signal the error at all. This might be
> confusing on the userspace side which will see truncated CMSGs
> but no MSG_CTRUNC signal.
>
> Consider the following case:
> - sizeof(struct cmsghdr) =3D 16
> - sizeof(struct dmabuf_cmsg) =3D 24
> - total cmsg size (CMSG_LEN) =3D 40 (16+24)
>
> When calling recvmsg with msg_controllen=3D60, the userspace
> will receive two(!) dmabuf_cmsg(s), the first one will
> be a valid one and the second one will be silently truncated. There is no
> easy way to discover the truncation besides doing something like
> "cm->cmsg_len !=3D CMSG_LEN(sizeof(dmabuf_cmsg))".
>
> Introduce new put_devmem_cmsg wrapper that reports an error instead
> of doing the truncation. Mina suggests that it's the intended way
> this API should work.
>
> Note that we might now report MSG_CTRUNC when the users (incorrectly)
> call us with msg_control =3D=3D NULL.
>
> Fixes: 8f0b3cc9a4c1 ("tcp: RX path for devmem TCP")
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Eric Dumazet <edumazet@google.com>

