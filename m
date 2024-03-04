Return-Path: <netdev+bounces-76975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8E86FBC2
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 09:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E5B21E1C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37EC17583;
	Mon,  4 Mar 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/VsbF9A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6317589
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540526; cv=none; b=dudiJw8u13lZZ4NOYZE/6NrpKm5XQj2Vc5lyYRvZEl0BacmNss0iVlvt+kMqxPxrLGTRwBdpsxDlwAbft1wrQSfGExCv3GvEZnBfHP1FW4rjckMMr5RDN4xZI1CDioqSwIz5KEe/VlFkIdlrd3IlLI1kPv7r6Bno7OiGX7EWPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540526; c=relaxed/simple;
	bh=EoyygbLnI6vV+Uw7w1G/Xr29iq0XsQRIh4eFJ1Yd/oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqUTMJX5uXGsDFxhjJHJS3MBqnT0VgYn4rCPACptXHEBeJGxZe/8/SGoocZmkdIumeQoadt8jjUc0ADNrVqj+e5lv8H3Hc/E3wjtArMCVSZbvRwv8+rHDTWhIIdwcmGtXU0j50LUAEOKn4+MlsPJb55C+ZvKh3d+usVXOBfO2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/VsbF9A; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso21825a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709540523; x=1710145323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoyygbLnI6vV+Uw7w1G/Xr29iq0XsQRIh4eFJ1Yd/oE=;
        b=Y/VsbF9A20ihAkwV8YKT3c/nx5nd59ScEMev+9d154lp71rI4A8qDgt9z3YNmPTnzO
         o/bIl3trMlhXfFjKIbM2F7Clrb3qenuWSMTsG0SrSlfY6n97zqfdz7D4wHLTXP4fvdev
         L9zBI3epAjzJXtAuw1hJEOSonunXv+mxPinRiNK+Ce5aNsYmyVuPyuPJ4M6Vu4Co8b6E
         PW28UYTXrMo03YeXn4hYuDaO5TVSub+EkWAaUBBWurX5omeSjrGjlSp6u3vQYgHA3DCn
         7DXPjqVXClE4RePbvZX/ekm7BXUcjUYFX4XRMHcqvN5Xce+Tna1S38PUU+4BnU9oKgTy
         rSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540523; x=1710145323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoyygbLnI6vV+Uw7w1G/Xr29iq0XsQRIh4eFJ1Yd/oE=;
        b=fJEKms0kv5tcUhAx3OxI/sgxsdk+eZKh79B83XZD1hUp2kiu7Ae3RBhkF+PeHnPHid
         ICMYEpN4OEei5UL6hYtM2QsjrOJNweWECnQQBMZAWDj0nhLpeV/iiGtLIS7Ho8k5a/mx
         arUgRkHcDD7evBZOcU4HX8DSECZdTCoORgHy+EDEKhRnKbErdckUbq3Grvso+bWw68a/
         l3PD+3QPd1LgsU8k5ekwIPDsaRH+mUx8kRZoSExwyy6C7E6U0ZdRW/9QeIG5t0tsX+4s
         smxkNDcrrgOP48//f73WhYVobTeL6Ryh1dRwcYUXoSH+z4qwCMYO8wk+YHrBjXulqtMJ
         /VKA==
X-Forwarded-Encrypted: i=1; AJvYcCXavccUKN2WR8j3hcMkADvzs/xqx9PWFM0yodZ3lVmV5pdvXcZ6lz6wNj/T/L8NILLUIvdbac52bKeq0GqhYvyWV0zf1nCd
X-Gm-Message-State: AOJu0YzzfUe+Q+G0Yi4dPlde8fPH/lFL8jC5XZgH8ackP4XfTAtmui+Q
	U+3Lu7g0Z/tFDB8oy6pqqAvi8K01df6wCpeUTqhQhuehO91Pf7eLekaJupMH0ZDvp+3JQR/NvsB
	2Owqz3aXb81OL/BCBACxJ8GdeMfBLaM3R/CIQ
X-Google-Smtp-Source: AGHT+IHIYRhnnjPqqmA79sgEwxplLI7CJumeOF9au9GyycW28mXDL31rveCzHd+JVDxCrDIYk4Vm2YGD+UM4CRz+Dh8=
X-Received: by 2002:a05:6402:291:b0:566:b5f5:48cc with SMTP id
 l17-20020a056402029100b00566b5f548ccmr295449edv.5.1709540523254; Mon, 04 Mar
 2024 00:22:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229170956.87290-1-kerneljasonxing@gmail.com> <CAL+tcoBJy4a_wBQbwmvWZWZP7mwaby3xHy+45x-PTEbHsGAH6A@mail.gmail.com>
In-Reply-To: <CAL+tcoBJy4a_wBQbwmvWZWZP7mwaby3xHy+45x-PTEbHsGAH6A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 09:21:51 +0100
Message-ID: <CANn89iJPZ-B5yQeNbgxeW94OSL1XTacLgfbJTu8janT8qjWSvQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] add two missing addresses when using trace
To: Jason Xing <kerneljasonxing@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:01=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Fri, Mar 1, 2024 at 1:10=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When I reviewed other people's patch [1], I noticed that similar thing
> > also happens in tcp_event_skb class and tcp_event_sk_skb class. They
> > don't print those two addrs of skb/sk which already exist.
> >
> > They are probably forgotten by the original authors, so this time I
> > finish the work. Also, adding more trace about the socket/skb addr can
> > help us sometime even though the chance is minor.
> >
> > I don't consider it is a bug, thus I chose to target net-next tree.
>
> Gentle ping...No rush. Just in case this simple patchset was lost for
> some reason.

This was a conscious choice I think.

https://yhbt.net/lore/all/20171010173821.6djxyvrggvaivqec@ast-mbp.dhcp.thef=
acebook.com/

