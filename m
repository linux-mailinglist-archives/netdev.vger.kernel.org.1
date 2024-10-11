Return-Path: <netdev+bounces-134661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28599AB77
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9821C223E5
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BA1C8FB3;
	Fri, 11 Oct 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpH9bbT2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F01C6899
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672493; cv=none; b=WE6nLR+kwXgXrlRZwZELWR/dWy4aXtpos26St18s0VdscuXC08TjV0n1uw0h6AgJs/jvczTHhuP74tdSpUurg7mM2SYrpI3c+ryUWgiCzIHQaYDB4APZfquPFlQjFtceab1s/UUxlUzamm1phmz8H7GtnBBnyyxhfCcWQ/NPCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672493; c=relaxed/simple;
	bh=/WXF8ywGydHx0WiB37b6O/fpmF9qA/TvxazmXWqa77A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOLC3ihitKtQErsDGfyUGa8mVeXYMI2dnwW9mOQO1F9XY5J1VfZHKXeVSzeAtzcNaBTaCcFQR7ik81hJ4BwgYnCfld24eGWU7ALEj+vyt2iI7gaEjbdYi+Ko8Q12CiNJSJLK2Wyy0tZ8QVwDTsOX1bflrFcrL23Xc25+8IL+8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpH9bbT2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso184701a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728672490; x=1729277290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WXF8ywGydHx0WiB37b6O/fpmF9qA/TvxazmXWqa77A=;
        b=EpH9bbT2f9/S+bX6uK88mBiG/ps8KaXCWu6WinEQwNVx4aUEYw24N8XWOBHVaJxQ0O
         rrY7A64xZVsyX00y7m1DqKiWNi1ZLZsihXZqTCSvpZTG1GqkGiGSNauQ0h2nSKOY46dl
         fC3M74IY9p9HkR8yTmGxWpHaKEsZq4UilJL3AOmM3lzx7u4b7KpvIRyJWdKZoXvjba/V
         bV7dqzZIdW6A38b1NEGvxEs6rg3I2TSCAqlH3oSjCML1jwFKJl3fo83shakr2duIVmEd
         ysMC+jKCSJSYhBxYZE2s8wiRUev/1LKvlgg+I2Sljs7nkJbboi2y0YTGVwSPwiPuNe9n
         Cj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672490; x=1729277290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WXF8ywGydHx0WiB37b6O/fpmF9qA/TvxazmXWqa77A=;
        b=foGny1OJCLzeXABa3fdbooZm+zeDWSz6NXnQznV7nDP31/nPSqBFKObh6kFO5NxzCF
         idVqtF+ITFqwjyvAQnURgXWNtla05Vm1TrY1tPfyfVPSaFowf0rYEtpY5ywERiIytMXq
         sjOP8JksrLjoYB8yPTrdv0nZ6wHEYs0uisjuaw+SgA9SPiKQIHOxol2HrAIEEG1qFXB6
         +Q47cXBe3QCTKXgNCyvArmqWWlwi2jDXk/D9vGBwbLst1sfJDhaKUgLsGC6aGi2BM5KS
         YUVfwdE/rZlU2iv3z4O5gqbs+msgIw2o/lLye4HSZs8WHgD+wz9KoshZPNK975zuuX5n
         ZAwg==
X-Gm-Message-State: AOJu0YywZeLRO6/s0EOS8QaMqCyLkKxmGJRUDIik11h7ZYGS3SIlfAgT
	vcB82c6/Tyk7ZNGsrUtsF2jifIecBojvIS7RGRG4SzxkobvOmxiIUVdYXvFX6KWlBh8JWh1rBTH
	622d90lIBJF8Nn4VBNNTueYBZRHpCr7cXVc3VYcZlYJbiBYJgVA==
X-Google-Smtp-Source: AGHT+IEz/lBU2GZ9xwlZTrdnZv3ZQdzJDcUiZTrqwcDl1i3U5frB2lq45o0d9ImcfnGIN2qRwOV61WFsBapzXVvrWFw=
X-Received: by 2002:a05:6402:1e8a:b0:5c8:957a:b1e2 with SMTP id
 4fb4d7f45d1cf-5c948adff84mr2181285a12.0.1728672490288; Fri, 11 Oct 2024
 11:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011184527.16393-1-jdamato@fastly.com> <20241011184527.16393-5-jdamato@fastly.com>
In-Reply-To: <20241011184527.16393-5-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 20:47:57 +0200
Message-ID: <CANn89iL=Nf7sYN4w2vhVPGn-WRkHpRdhav6UaZQP6DE_4Cq+Dw@mail.gmail.com>
Subject: Re: [net-next v6 4/9] netdev-genl: Dump gro_flush_timeout
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:46=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Support dumping gro_flush_timeout for a NAPI ID.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

