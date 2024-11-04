Return-Path: <netdev+bounces-141469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B89BB105
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 11:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE611F20F9D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE031B0F19;
	Mon,  4 Nov 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeflwQR7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068001AF0DD
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715920; cv=none; b=GPPKD0A1hNm+imQlfJIDO7JFdUvYNlU+2OSBOQF8+jh88Tm907IKi39va7ZPRnyAL1iFQKY4wMERgy9veR3bgv7X995IuNMX+YBUf9UE8+TBwLePZxEw1H/v+PDkE0X7Kj2lYy7Iwh/P/xcCl61e9aWmdUmPl7pJ+pWomJrs+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715920; c=relaxed/simple;
	bh=V/+/hlKh1rxbiBzy+p4y6Msa+GqpWouYUTGPR3WHGsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VH/PnyfPOqGq7DtaH2uyYAX0Mp0hWfV+FoX29WbRCGdYWWzTckdKYJ3DA8pnH1tVPHDUcdY3au27sZ+fFm286cIbnokTlyz9Id7X+2txyxDqmoluPuryP7LTEfHMhk+do+oxlUTUzAY1zeMUxApW0mEs5v/m5XXhogcUcu1aJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jeflwQR7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so2031185a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 02:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730715917; x=1731320717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/+/hlKh1rxbiBzy+p4y6Msa+GqpWouYUTGPR3WHGsg=;
        b=jeflwQR70EPlixlEa9MwqFVXmbEzr7jPD4RzPW4JWqp9JLFBE5Q7fNYzYKUukX4n2Y
         Y+YMBlkV1ULvpCioOwUi6hJDtk4OtAYe/q/76MbNabJU/a9r4P9EpOEeKZ1cj0YvngEz
         uIhCcy/1wc/VXdl54oPhj9HnQXVZqVdDbZ4X/VX6qR27Ure/WIi2wCj2tOqRBM4PK5cY
         LtBheMyUHfwKE9dFSqCWyjsIV8DorH4zbDFuhpOHZWvwDGdqGIKVEvkiipdWoSIxITPP
         6eiJdi0Dnw7c7hmYHlJ39kxdeiFds/S+6zHq7vI6HucEi9mkB7In252FMFCZNC3QoUrP
         58hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730715917; x=1731320717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/+/hlKh1rxbiBzy+p4y6Msa+GqpWouYUTGPR3WHGsg=;
        b=S5YIiF82X2jkErG8s6OwrPYSMs7D2oZRwDWY72NK+Tl8wfZIPyWY8HvGs4hUWWUGeY
         +od1oHQowx63rF6zoouIqTvth3PkkBInm19GHrEfTk0N0Fa72U0lS6DlwtCjmlb2/wDc
         BKmaH6gkLajIDQ46GX1FYgB/66TdLcs5GY0ZtfXJqRZsTG6BVxheaG3M+l0rcJ34T69P
         2sIBnI8aT6KxwAfkmL/dOoAfRP7WLM7CKgTvtp/6xiphgDen2GkA438fFlea+/BSSZsQ
         CycXA5m+2a/j9a868YX/2PmYdKhU2StL7cOcRlG7Y6VdFtABoAwnr9PG8zui25p+uFxp
         pTEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+S/ExRDfLhizCMMmy60Xv+pXJRj1V1rXg57BPVOiv9RtJ4C7T+ge4kMmItcQN8v1GCYK7CpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKIlH5PIi6B8kDT7FKXf5kY7Bsl27UATkhhmzYYkuxHBcIwg6
	ZRKk9y2VLUZAzuBlvAP/SJrvmvcl5gvJ7XKikj6F2f6pOQLEF9Hr0nFjxwvUVZHYVOlfJLcuys0
	DqKRjSlAL9DTO4hzd8+2RWuvIWXxBOj2TJeWd
X-Google-Smtp-Source: AGHT+IEk/VV8aixaYr6ZbWjdMvIQt+JsCmv/TNNMBKSlXTspef08ZiIotLJVmSIItnYQWjkfpFoAoy6ki4++u+3nu2c=
X-Received: by 2002:a05:6402:4316:b0:5ce:b82f:c4eb with SMTP id
 4fb4d7f45d1cf-5ceb82fcb42mr11804877a12.8.1730715917148; Mon, 04 Nov 2024
 02:25:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102200820.1423-1-03zouyi09.25@gmail.com>
In-Reply-To: <20241102200820.1423-1-03zouyi09.25@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Nov 2024 11:25:05 +0100
Message-ID: <CANn89iKzcsKRngJTTxdA96MbVSx4Y9f17ju9+Otf5axas_esjQ@mail.gmail.com>
Subject: Re: [PATCH] ipv6: ip6_fib: fix null-pointer dereference in ipv6_route_native_seq_show()
To: Yi Zou <03zouyi09.25@gmail.com>
Cc: davem@davemloft.net, 21210240012@m.fudan.edu.cn, 
	21302010073@m.fudan.edu.cn, dsahern@kernel.org, pabeni@redhat.com, 
	Markus.Elfring@web.de, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 9:08=E2=80=AFPM Yi Zou <03zouyi09.25@gmail.com> wrot=
e:
>
> Check if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
> in ipv6_route_native_seq_show() to prevent a null-pointer dereference.
> Assign dev as dev =3D fib6_nh ? fib6_nh->fib_nh_dev : NULL to ensure safe
> handling when nexthop_fib6_nh(rt->nh) returns NULL.
>
> Fixes: 0379e8e6a9ef ("ipv6: ip6_fib: avoid NPD in ipv6_route_native_seq_s=
how()")

I could not find this commit in upstream trees.

Please make sure to sort out the details before sending a patch.

