Return-Path: <netdev+bounces-82092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD488C4F1
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08BD31C3F52D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1806A12D20E;
	Tue, 26 Mar 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYpozZ5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B412BEB4
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462512; cv=none; b=ZWmaOBuarb1NsjFvA5bRylxgxBO0WLBLRHlVFg5wXOmKDookzrxD9soEfeoYVDKGtP+5YbindNbPhxfizeibtbgJHCEhnteewyRJjWawF6z18sLj5cP16u6284Zv+e05nCqUgbxnpZZSK4QLXli6NAwDdSzPAcFvTFkW61XtCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462512; c=relaxed/simple;
	bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvKYOpLXcnyWtB6J96v0e5cjRRH55SUhh1LRZeuvbP8B5E/MZ8zQVHP96STMa1iVMvQH1AdZ14aVSKhJgmXdXHSaP4iQZJ61c6SN5/U9DsnDor9W4zBg0rLN6DZCJishROO6FIksG5RHjtKsudSbOkJZhkUzMlroMxoEszfCLRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYpozZ5W; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so13343a12.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711462508; x=1712067308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
        b=oYpozZ5WtSu5jpwmjGNry233tkGvWmCZGnMTsXOshJg7f2xuyDkqX4ioUXEr/V5zi7
         Jkk/4rNN6PeQq0XaOrHfc6RCnnVVRPMMJ9J2deCTv1qTealooa3QBAbbRDqAZDTqAZqA
         kSyTg65m/J3E+6OfmFajm+gxeEJwppcY1tr+yAipufDVQjl4aq8Pc1r1mvt2zXfpXwyG
         q6Q+dUPbNG63Zk6/42yX4U7LjydeqSxgz+uumlvXleas3gjTNQjjrphDepTjrvuD7YMS
         coEzl7ohFFmpJMSI3kjyP9/iSaWbqW+ScUU+jh1xtRqSKAG5DIZdWnCqNjF5QvKJ98MP
         bb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711462508; x=1712067308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJfebqtXkl389SDeTD7YYtNydWpUFmx9bb86pDSusXM=;
        b=J9b9prMgvXJk49tLKIq/mz6I6ZbKDSj6EMb2cDKAjoQdieEGR5ZFrQOTRrWX0UWVdX
         cNhwA5BlHcijDMxVv50HlZxJchhinGicH3o3M88NENm/ZZkBtxye65tpSjfVzWj654Ap
         a46CIFLxXT2N+PdsYA1auwT46qVQ9XOqSAsSVLjBsaL8XmU00rFm2SeTwEyF9kRfxdFj
         CNKYSkIw+h14g8fTYTiF8mNZB6C5NrrpgUL5igLWa/KkxTq1yJNpX0x05Dap9EbydvtZ
         kw/PyH1bi+9wOd5qNYI8MJLHTEXe9A61JO7O8D41+EC9ADXDX8CV13IWYJOACWsTpOE/
         6GKw==
X-Forwarded-Encrypted: i=1; AJvYcCVVGiHUFA6iHkzUCHcQ+7gCyGE+QLmbmrtzdGCQkfTVmwZcc6SOlpi93Xsgrmve3vGoGJxAXN8F9yV9LgVpsbZAfl3ev8Ss
X-Gm-Message-State: AOJu0YxNuBlvrlmsIp9ABkGkPfKTIX+TlWYuoVcR7yGO9pvBMK/KOu19
	1PUp0LYA2w63bwOJesVGfIHr1qC3WYJ2tXzJ8+BK650IquywFDK/BPgWrKD/lJCgGiGntbkAbBC
	Lz6E+4JGEARDDnTECBa98hZOc3QPPRHQo9m3v
X-Google-Smtp-Source: AGHT+IG1Z+WPb5y1Nz3VMT4UqqtY4fpc8jx+h3qL2dywCVAyPOrhigIpDt4Vcw3QK9/kLtXuyctPdraZ6ZuleVPscws=
X-Received: by 2002:a05:6402:1a26:b0:568:ce1e:94e5 with SMTP id
 be6-20020a0564021a2600b00568ce1e94e5mr105879edb.5.1711462508403; Tue, 26 Mar
 2024 07:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325182543.87683-1-richardbgobert@gmail.com> <20240325182543.87683-5-richardbgobert@gmail.com>
In-Reply-To: <20240325182543.87683-5-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 26 Mar 2024 15:14:55 +0100
Message-ID: <CANn89iKzeTKuBA3NL0DQUmUHmmc0QzZ0X62DUarZ2Q7cKRZvSA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] net: gro: move L3 flush checks to tcp_gro_receive
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemdebruijn.kernel@gmail.com, dsahern@kernel.org, xeb@mail.ru, 
	shuah@kernel.org, idosch@nvidia.com, amcohen@nvidia.com, petrm@nvidia.com, 
	jbenc@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	liujian56@huawei.com, horms@kernel.org, linyunsheng@huawei.com, 
	therbert@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:27=E2=80=AFPM Richard Gobert <richardbgobert@gmai=
l.com> wrote:
>
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used
> currently only in tcp flows in GRO.

I think this is a bug.

GRO should not aggregate packets if their ttl/tos fields do not match.

