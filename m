Return-Path: <netdev+bounces-190849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02974AB910C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86973B4970
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E329B8CA;
	Thu, 15 May 2025 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiK4c5VK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4F29B8C4
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342632; cv=none; b=J8mI3oqazsyygXZgaTZOSH2vFYtk62kQFRLf1hSx96jWupD6hB3bGGnu5VZ3eRyUzNl2K5Ncy8G0/MoM7wrz0jUnYTz80urqjwOmeiaQuA1glAAN4ulWdRr5JylcGlZ1VJ4GtjuLsZAFrgA8MmzrjxZT3CmMJknyo7JTsuV5pq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342632; c=relaxed/simple;
	bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn75uhtEezcgzGrVPsIp3TUBnTSwG9UrcHiEe5LCF3JXZy+SLJFRJYG7DQOHFK2Q7Yl+l3x/XbxzIX4Ebs3JAhm0KRihTOmScJ+mot3B3HW3Jgpfj0mrjp4RdXfxpizHEUh8sPHqrMAOgJEhMVjXuwNcdIrqXaV1y1vtVyqIk2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiK4c5VK; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so1340a12.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342629; x=1747947429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
        b=NiK4c5VKp6uMSJjFMco2TAD5PtvZRm+/Nbty7oVQE3OaZnmKVU3RWdW2kJpwdm8WC1
         9w3+WoYcman57A0RL3v1OVsw2ok20PXL4KRfwkKPZ/DBIqDWy335+k02rAGSMrjKctKZ
         kIPgCvZ3G6k5tUmICjohmIP7Tqge+2ljZ4o6RWu5N7kW8TSzeumG31IpV+p7XfW+pjve
         tNqTL2N5jYN4W/2iw1ODL89i8TcXuy+J52rVziqY0RxKH46PaFD2vk6BytslHkn7eUuz
         WLvCrhCe6ppUBB17JifhmtoB2h3P99gvhohrMn5FM1oktQvi412X2dzVdFTWJaOheR3s
         XPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342629; x=1747947429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4S9xk7FkDGi8ZPRR5Krx9XPaCn53xUBcwh32O8sVhA=;
        b=b/0rXFlbMovF/EoVtTRbZJp7hJOMFrQeetsNlLsyNe4bcSpXn0p121sAl7xnWsO1Ju
         13y5HKmGX6Wj1IjoSzcN9TOIDivQSeskp8XUmDN1OX6v4TV+ey/eGUVkVOvZ9hlw1Q2h
         A94wfjep1fgOrL8yC8oGnm6xgKobE3XtLERlePRKZDl2x38HYC0JoSgEv372UkcKn/8R
         hyKqpENhvkqSAZgD5Dw22eT5Ygmxkxki7w6ZEx8tqAouJzp84l/avE/qOUSXs6sNljAM
         8pIjPqd2o02ndnmxZAfPs9kpUdB2efVv5gfbj4z9NIgM6lj5hPBMfOlREwwdrgWgdpXV
         NNWg==
X-Forwarded-Encrypted: i=1; AJvYcCWukbyMfLKip47Uf8KMDLE+FP1Km5DjXdtfdIqQ8ZzEl1FXAPjbYPfv/T7WaEgUovOuWsO/SSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6myVKw6cQHPyakCgvG5HfEpw/eWn+B3i/VXZb5lLY0lW+/f3
	eghYtvx4VpUMIfg5Qx72OhgHJthBLqOwD0NWDzOqiE5qOhBvJyXL2BWW5w78Nv1vv9ws/5pqT5c
	QyntFsbB8bf9qPg+3ZrU0jOG7g6oi3bc8pkPfa3kx
X-Gm-Gg: ASbGnctbOw3P0LRbE1amCxvQKsKGMPjUkfIzxTCabC7tkC7eeP4z2K3V8dHPSICRpQS
	7qGVoVAPvs3gOLPhxw8a5x34599RqqdBhP0RSYCpM9ZdjpqHNxsZbRL4ZOpZGXqTapN8Iyqwd7s
	+Gb2VXkE30z+pchjQjBzeD0k9GnEcZazuGcC1L8g5k5dzc34VeGohQSo2VK1/H
X-Google-Smtp-Source: AGHT+IHZOBTJlThJhcv/ZxHz/H+8QZlugn3sleQN3wcAGTU8hgAWjH2Njf0TmrGz0ZHIoDeXYKzWzlKfCbbNua8Uh/A=
X-Received: by 2002:a50:cd19:0:b0:5fc:a9f0:3d15 with SMTP id
 4fb4d7f45d1cf-5ffce28bb43mr138873a12.1.1747342629100; Thu, 15 May 2025
 13:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:56:33 +0200
X-Gm-Features: AX0GCFvCU69IQ16RRV7879LgqrtFsOSgJDh6k5Q76ICOqMSjVLU262TZzPZwqzY
Message-ID: <CAG48ez0dqyzT3k4-HC3UjhCncgnPk28c1Av-iV8c9hB5tcu2YA@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] coredump: show supported coredump modes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 12:04=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> Allow userspace to discover what coredump modes are supported.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

