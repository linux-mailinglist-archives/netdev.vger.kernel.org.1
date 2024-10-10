Return-Path: <netdev+bounces-134057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C7997BC8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E74A1C22325
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192F19D891;
	Thu, 10 Oct 2024 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mB+SIOp6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D635B190059
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534391; cv=none; b=dyS0hYDfrCOQ4th0RkyFho9HXvMetUSdZiFILMNBfy+i7U9yEEryi51jCourH5YCuBHJaWYyLT6t9xDIV+0j0dAdNe5XIQ+Zy0K4vT+6acJaMf0AJfYOaQTR7St7yFI3kzehXN4xcVWKZdz9M9s9h0XYGVJCMKOks70TlZpOjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534391; c=relaxed/simple;
	bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1kx4hpiD06XBQZC9X3qUAlJyJ+ChGbOVCYXn1ARtwyiC2Q51KeUu/HQ7zvnSquD6BalMrCeQH0kFtwyJpvKQfrNwA5ZVwPFJzm3NIc28oTV0YYhv4sRcT4qefdwL+udTqmyWM8/wyepCA64JEdb7SgvPJEttMHNrSWMdSsRv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mB+SIOp6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso117388a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 21:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728534388; x=1729139188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=mB+SIOp6S39zL02iNF05wi5izoaaIALmBI2NLp4GgKbrVkg2zVf2CC8dRLLTh8rMGN
         1MmGo0bDuqGLQU1bC/Peub2ylbJzV4fwHIVYftphbkZGWepLUkEXanaOE3ZlJCK5mmlU
         1+Ia92x+tk1tsIvYqhuDZWZlpzs/164gx8gmroj3TSx2nFZWWWmYM5LayIalJP+UPVlC
         nL62U9/UdCE+22Q7SgDxtb4l2CTlFE7c8q6J6PWtdpuJINuZfvNvmEc1/3kDaia/n4W8
         ruow9vjhW2KS0AusRSmZj4xR6ivLk8b0TG8pSlnezBsjuxwUL1KS3kebXv6MZvXSaoy7
         KDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534388; x=1729139188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=ac9eSjXy6fAGRdpaOJBA2hlRLhLsDXVEnU88nsBnUgMyOx65vbdtV7kIavYgZ66ucG
         mdPuYbzTftnVZbXJ6jH2oNDAVU4GMQLVc9axcgCbhIP7j5MDDHNkcLMb8TwY1tzn5iMK
         gYXqOek4fqj+RO7SeZBRqGtSetgkFY5axB8kzR6AyHetsl9ZIKBqcsAeuf7U/j0DSPAm
         5x8fiEGBM4wWPWShxo+xQ3qA4qHmFXI7fsp72Vce2AApcxe0D63fh6yRLlfDw+dLBQ5H
         0XHlj++mSHAsG+I0IWg6hbxqU08u7qjoiJEXdnNZg4nuT5Wbx67kw72yIuNbTDnpv/Vn
         2x0Q==
X-Gm-Message-State: AOJu0YxM3endwJRlnFo6hndCGy3nYs2LlFSbqe6fAFx4YjIgy/Hp/MuO
	zHo5tIwqmaH9NSLTI0RaJaTRMw8hB6Yy/fEjwbVgqRwL21CWUS1dHsmVvtvZWvHTd8A6Cq9P6zX
	jJMj/jCrD4J7Gdca43I3hqwKqjvyyWAxLVADSr1vJ72XgjCm+0Q==
X-Google-Smtp-Source: AGHT+IH3aOD+TQFzDcwLMz/etoxPu2lwsdb1UztvG+BDjyzY3bVpB/b+2U96a18G2jKJ4ZWK65RuI6uboYZeWwjSVZE=
X-Received: by 2002:a05:6402:248c:b0:5c5:b8bd:c873 with SMTP id
 4fb4d7f45d1cf-5c91d5a5531mr4672487a12.16.1728534388007; Wed, 09 Oct 2024
 21:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-9-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-9-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:26:17 +0200
Message-ID: <CANn89iKWPxBtDm=9+gUuMAnvQ6KF2RaXSyNHin5579AvcGKgYg@mail.gmail.com>
Subject: Re: [net-next v5 8/9] mlx5: Add support for persistent NAPI config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Use netif_napi_add_config to assign persistent per-NAPI config when
> initializing NAPIs.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

