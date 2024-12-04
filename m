Return-Path: <netdev+bounces-148841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FB9E3428
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22D616326A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6963F18A6C1;
	Wed,  4 Dec 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9CpjuPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBE4156243
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297718; cv=none; b=IL4Crb+kOms4mpxkfuuauxEhVZCYJ1ObcXMsj/osEltUdQqk0i4hEuYMFUUJpTJODyIQClAFS2a2oZ55ikN9jH8sgmzTbWNiEu5jJTmE6ZjMxOPUujvUIrEta8kuqolpHNRWIeliWhgxqELHc0M6ulUnFz3f79IwziGI4WGjhtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297718; c=relaxed/simple;
	bh=vd3MuS91TAivt2JKNjLBePhtBC64xpmWPU6qbD1fzok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=covhPCYC2Hew8vbh+wXcQODvGI0ruJerbEisOIZZCiqRP5jg/j+eJZtVrOtVi9OcRmAZOkeGdPNLs6gpfdtmrpsbfJA2tPClI+0oL/bCSVsuDS+co4N/sw3IowjYCNgNYOPKcknUns/7gD57fLXbxTAaFWYpOYQKoq+zcdcB9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9CpjuPS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa530a94c0eso1024642066b.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 23:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733297715; x=1733902515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kddNz+EPa1yRSBdVL8TYp+khXdU9NBlX6CaYSf/xfE8=;
        b=Z9CpjuPSK9tOXeHm/JdPduYly1TvSVEuP7vbbHUwctK8vfOP0+djrtk996GFM3HnWY
         8GmVOv3M6chuk1oZfVzHsdlK1GoNl99QeSlntoladf70mzsy4wLIoSmh0xZCShnKT0ZM
         GaRKrVgm+MEchPcQ/a+qJtkpUTwXwwXIMZzr2YNgOKSfFIOyqz67wq0FGdKdZlMuWxwq
         52/DHkkfXVqp09srmwCDEa98KkKUEZ/Rjre3DSEKtvwxJ0tl7GtHGSZpTz/Yc/jammfs
         lV2ULWoMN9iawYQLiUAMW5HuOU275VS80uPsyIcEpZHGN0SPO1DXbQvsqwFLZTu9MzcD
         Uv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733297715; x=1733902515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kddNz+EPa1yRSBdVL8TYp+khXdU9NBlX6CaYSf/xfE8=;
        b=gbUZUkeEDFjeCGf4A+MP4xNsUPinMn3kFDRpz4ZJpUN5d7JpCvU8DuKmlt7YNBwNQY
         9UbM4LM3n26RTPw2OeXIHL86y5Hzj5GGgPSKKzVkumxcnR/VRYkw1luwMyCxWay6/r7V
         Eslx19gLPV6SEcflhWl2xyXH0XJwLogo0QkglWVxjoreWP//SIFkmwwfC8+MPAseXhrw
         o75yW9PWavekulMVSM0rg3N9MLxEwP93gZeiRsrue2it1vrMaHbhO0/ovXU959aPFmdh
         VqpWAZJOwfCdkgjqyXpVSsJzU62gvc3x1ejrISiaWO5cNQbx5dAyj/3xhgPdBxvzG9qy
         3xhw==
X-Forwarded-Encrypted: i=1; AJvYcCVlJ6sRUmoMUfq+5QM3w9lnrua4nzLsIBsbzBtNgM5ffYTC1kOh+pmReWd70MiqcikMVej6LGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrd97IM8b4AI9iSEJKaf0ApnqE1KtGjeiaebfJEzJWpVQhEee8
	6pGIsj8EwGRRBG20hSYF8VpVEhS/NB1ANqw9apLmtcmOybT85M0SVLl1nc5GIRhjvu3lKsiz3EV
	OpAPxEylAzVWePjV2IY3th6xrxuYj9DYeDdFB
X-Gm-Gg: ASbGncvR1j25LqYJWQnS9Z9obfVziqRqI6oehvScMYXT7zj1ekFkIiIEHOP1qD6W4Sv
	4VK+GqpQ6q+UZqaWoDJCt5x3ZjVZZhDtx
X-Google-Smtp-Source: AGHT+IGDQSz5gUQRd/eo6Ne5990PaNCIXEezEaB4NMUB2/vH7XFA+AbXkM/wlka6PaXNoSgonFmvyWU/GLubjA6GZgI=
X-Received: by 2002:a17:906:23e9:b0:a9e:c881:80bd with SMTP id
 a640c23a62f3a-aa5f7ecd26cmr321185466b.37.1733297714956; Tue, 03 Dec 2024
 23:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204034946.10794-1-moyuanhao3676@163.com>
In-Reply-To: <20241204034946.10794-1-moyuanhao3676@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 08:35:04 +0100
Message-ID: <CANn89iJPTw6ANRriR1FHhSQ2aMPDP9PepSbm-+Y6S63aYZ1XLA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Check space before adding MPTCP options
To: MoYuanhao <moyuanhao3676@163.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 5:07=E2=80=AFAM MoYuanhao <moyuanhao3676@163.com> wr=
ote:
>
> Ensure enough space before adding MPTCP options in tcp_syn_options()
> Added a check to verify sufficient remaining space
> before inserting MPTCP options in SYN packets.
> This prevents issues when space is insufficient.
>
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> ---

If this is happening, then this would be a bug, and a Fixes: tag would
be needed.

If this is not yet happening, but would happen in the future, this
patch would hide a bug.

You forgot to CC MPTCP maintainers and reviewers ?

Matthieu Baerts <matttbe@kernel.org> (maintainer:NETWORKING [MPTCP])
Mat Martineau <martineau@kernel.org> (maintainer:NETWORKING [MPTCP])
Geliang Tang <geliang@kernel.org> (reviewer:NETWORKING [MPTCP])

In my  opinion, we should pass @remaining to mptcp_syn_options()
arguments to avoid side effects.

