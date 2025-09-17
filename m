Return-Path: <netdev+bounces-224152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513DB8144D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA285627F15
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F5E2E7BDE;
	Wed, 17 Sep 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cgDDiawS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495D34BA24
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131975; cv=none; b=NKWmw9+HI7eMnOPolHuXh+ir0IpOxUY/HkZOMLAPpsIoqnW8RtUFKaSGmVvHCpjQ4V8IvBlY/EfZ4bwFQ57RjOQwIr0bJdBA1zUcQwJU2dbnKxWIykcBdKTt9lKZsPi8O3tCCJu1s9NH03z5yiuTYYc6ZkZ3/VfrxUWUiM2CajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131975; c=relaxed/simple;
	bh=oOF/xkag7i6IYWLA5Xg00ZHCpYg8rHUP6h6Kf/pcCzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2C6lF5iDDNV+TcTfVfRnP/GaD+6qcXve/ihx5ZYiAZVy+nfF6LmbmgAU/jjlX99zqsp4h4MT3YkWkaCfUPpKyr4PhR0G1fm2ExWMBz+OFlUXfMua/GkksltL+OIeS67e5u+iLkpAA1Sc3ZhN2xLIswM405dO+JdIbaUGVDGSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cgDDiawS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so52166a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758131972; x=1758736772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOF/xkag7i6IYWLA5Xg00ZHCpYg8rHUP6h6Kf/pcCzU=;
        b=cgDDiawSAgM52y/WNjEpwwlhm3IANmbl8HeJJNzdIHKkdE486x72GJCEciMYEFxUlD
         D3I6Y0AtSLryFiW7qWUtC+2fOXEI4rgtAyM5LR6H5kHXV/JjfS1lXDfiJxsmrOp4k2RZ
         q4nBRGZqBWfmfXq6N4Afk/U6wzjWTH5YpWJzida6d8Mz3yQNZ5V31O2tmjxf5NcnBcv3
         crpviwZpYwkfOeNpd0Mck2z0T9nCKrjotA+72CQbwy9MpmCLP8HEsue5a5k9f/gCThKM
         zIcwGo6LpJco2ciHcHY/7ZyUA6862++/dhvO+WOIkv3A25kXkerXIhVsCX9izdN3vYg0
         3CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131972; x=1758736772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOF/xkag7i6IYWLA5Xg00ZHCpYg8rHUP6h6Kf/pcCzU=;
        b=VGQ0DU6OqqQ9NnJOHRU6EfHKFAyoFO8AguTFD3Y849w48r4LMcVadpdj5pauF/pRai
         mWI1ajsqOp/86yIAsrB2LSPaTuenkHkK0zx78fVaffJYz3t825kQ7ZB7HWZcjwMNxMn7
         xdM6rk1l1qxkSb7VX4C54XeZOAIhsjmeA6GEsKuKOR1pmpk1kMAfyuo2ESTL4rhi7mQ7
         qs4qtmkXzKZDBFqGToZgjLJe83g75jPLk+MzfBTrTB3nu5XANBfe9OiJd0lqPHYGG1fE
         Fa6ehxqT1DluOgFrRjkXhSm3aR57HCwez7mW/K/+PWH7I93QEpBOV1i6mh7YDf0cO+uD
         c+UA==
X-Forwarded-Encrypted: i=1; AJvYcCWdo053iLI5opu+vGrA+7b2+peEoM/4RSAolgo342ap/WZmYS9HiigybyhPuI7xldXO64CvtK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpD3BphopFZzInt83BwRfi+dHhHZKPMRgjo48JcAc9vubIF2hI
	Ef4BmiBTGb9WVGCdmsHnO7YTyRk4HMBDH6nKVzja9/6q1zUg3qf6pwxThBG+JTmZ7jtISV4JUe8
	LXkMVsRP/B91Jox60MLPNQGS5FzZu5howEpntsTYk
X-Gm-Gg: ASbGncvEC/LFUUlJnyl4R4bNUI84Ckq3VO9XvjZUfzuHxA+/VkDfewoKG2kF9WR0vbI
	Xuyb1tvLVpU+muPsIR9wKlxuNbHKJhjHa/JtOF4FLHlUdWRjhHwR9ikKZyoun/TmKcZXhjIzKG8
	hTlK+4tDUYpxR9O5PRSO2lcrdHi055ExmTZ4xoblv/5s162wQTnc0BGxo78AkcKaYBKHzzMZ2yQ
	boJPG3kmwQ53PoEgF44YqMqncZPXjZr2ziFfIfMnXR9
X-Google-Smtp-Source: AGHT+IFVFwpvcyBZgf6ljf7tkqiwuq+/3I2KYi/m1tGu8hX/oF+f1Y08QoreZnk9n2HJ0ydDmskORAbCmJXghIwjX14=
X-Received: by 2002:a17:903:1986:b0:260:c48c:3fba with SMTP id
 d9443c01a7336-26813cfebfcmr38155445ad.47.1758131971626; Wed, 17 Sep 2025
 10:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-4-edumazet@google.com>
In-Reply-To: <20250916160951.541279-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 10:59:20 -0700
X-Gm-Features: AS18NWAjFm_EYaA8JeUS80IxryZhgc6ZfmLYqhZJA_Dm76SqbLtP3ISY5b02kYo
Message-ID: <CAAVpQUDYQtiKr3QovZ6UN_u0XH=RqefYnAaoDZi0pvNhOY5tvA@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] ipv6: np->rxpmtu race annotation
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add READ_ONCE() annotations because np->rxpmtu can be changed
> while udpv6_recvmsg() and rawv6_recvmsg() read it.
>
> Since this is a very rarely used feature, and that udpv6_recvmsg()
> and rawv6_recvmsg() read np->rxopt anyway, change the test order
> so that np->rxpmtu does not need to be in a hot cache line.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

