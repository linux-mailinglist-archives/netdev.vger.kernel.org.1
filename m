Return-Path: <netdev+bounces-115675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5714B947779
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002B31F21015
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9430214B975;
	Mon,  5 Aug 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nFcFYrmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707F13D628
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847206; cv=none; b=npvxshyy4uWYYi+4WVJrpPcMxP8vdJlEw3/Sj6rNQbYBetdG/brk3UDK+anC7MLCvPhOyewEwi7qV/ef5oTyIfkeIDRNN9vtR3qdsHyFMDjOwka9vdqO+dcra87j0i+2Ewqtp0vEAfnUhcNPibMMyzsYVvF23i47dvAdOs7OJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847206; c=relaxed/simple;
	bh=+QeAcYgwZWfrituWGwqVmeQsadpHXzGektiodHZjf84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khZVki7LJHm3C8b3Zcv8+UhinvjKxs4JQjVIUxchca8htEriinxxuJMOmy9Fc8yEWBb62YCZN9pwdaE+LwKTmgqHXSRinUMHgz1hQr6qDZAr26gc0dxElC45qcAdeJRXyj9xfcXEbjdDvzmL1SCDuJ0m0L8oOH6Se+hG9SYduZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nFcFYrmy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so5709a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722847203; x=1723452003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=entCZfiVHBFVDEWOeIthEZ96rKxsZnXZCzUJ55LPSZs=;
        b=nFcFYrmyqSFGntClCMY3XY0jvB4Tt/f1vGDgbxSa1S+bXPXik9gEdUcQVpWEXKn2pn
         wSWBN0hMe9jMYOjIj4gHnImpAgjDOz5yzGDZtPRGuvIQw/s3Et0eC4w9rsUw0v/P60iC
         Tigfsd6ErP+NpMKqG2GoSflq46YI9Qvj/C1vhSH4MwHBDGJdG18rB+c00eCHn+2sjQaV
         ca7Wp6wq9atkZeUzWoRlri3UhEZ25c5Jx5RyXv9d5dvU5jDIzPQDbsBTFbU31E/3v6+0
         51bhxWK1f2Tl8dxFunJoUwkkeEB12wu0EbcsoTNHcGN5/pLJUkUpr8ChChWJOkHCjs6R
         Sjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847203; x=1723452003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=entCZfiVHBFVDEWOeIthEZ96rKxsZnXZCzUJ55LPSZs=;
        b=lTUKhjAo+W5M/rkZddfsH9cmHUfYapTx2SP4daX1xZgeRc7LKqS28FgxiFNC5eJHQh
         ABaEKGzDpqi4NReoBkqwgwrSzqqOU4ssvt+W4MnGbe8vbcTkfvKaFz9CL3hNdbR8X1dR
         Zr8OvLan1qj/NdJpzTSSpDHN4pi29ujWqJGtuHt+CONPFWEcEgZcxE5LKbB+8fIMb2SX
         UdFkf4lif8J3x49NaNLEzZIHxjoWJdYrgGcxE53BCCSHqa1DyqDT3fMfUWAf8UqQ+fvT
         75pp3vwxCKaAaGu3XP7VXalDkq+pJA/dviXfIt1SpHyJ+1DZGSIkKDuyUXVAn0Nz9wIu
         b4sg==
X-Forwarded-Encrypted: i=1; AJvYcCU1yHj2zOUpKiPv6Xgmo+NZ1VAta99tEGQrsfngx7SqaZyUFfctJrJuAzKvD1G7OKszidtB4Lc/4aekRakV8BwnKKfjyLZ/
X-Gm-Message-State: AOJu0Yz7XJq30fiqeNJIEi5SsAKb5MvbcDCMXcOJJ+sGDcUKXf+z+9Ia
	SlvK4ObjoX3NfEsXgdbRVCJ69szHsygW5mAacDR54gOrVh/TP9MIZLx3V0m+6i0wYIAR7zbVT3L
	3HVPzxBdE+NneQP//akj/Xaj5w8m8SR2C45Wo
X-Google-Smtp-Source: AGHT+IFdJr10J60UQVpdLncVN9PxgFluZr8MnNc+pMVhjD4N1bAEOas0ed5HkbYf/F1Ugm/6XTXOS9gIYlX+9dp/Zc0=
X-Received: by 2002:a05:6402:26cb:b0:57d:436b:68d6 with SMTP id
 4fb4d7f45d1cf-5b9caf072d4mr183817a12.7.1722847202752; Mon, 05 Aug 2024
 01:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <561bb4974499a328ac39aff31858465d9bd12b1c.1722752370.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <561bb4974499a328ac39aff31858465d9bd12b1c.1722752370.git.christophe.jaillet@wanadoo.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Aug 2024 10:39:49 +0200
Message-ID: <CANn89iLaPXXNv1NC3+XyVLfX+0VVX5XQB0xobf8zAY2b95HX+g@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Use clamp() in htcp_alpha_update()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 8:20=E2=80=AFAM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Using clamp instead of min(max()) is easier to read and it matches even
> better the comment just above it.
>
> It also reduces the size of the preprocessed files by ~ 2.5 ko.
> (see [1] for a discussion about it)
>
> $ ls -l net/ipv4/tcp_htcp*.i
>  5576024 27 juil. 10:19 net/ipv4/tcp_htcp.old.i
>  5573550 27 juil. 10:21 net/ipv4/tcp_htcp.new.i
>
> [1]: https://lore.kernel.org/all/23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.a=
culab.com/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Eric Dumazet <edumazet@google.com>

