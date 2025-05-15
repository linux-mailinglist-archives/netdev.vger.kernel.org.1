Return-Path: <netdev+bounces-190845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D136AB90FC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5DE4A83AC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919FE29B78D;
	Thu, 15 May 2025 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgMIKSY7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15022A1E5
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342413; cv=none; b=q8H76tKc6H2hAPexUoUF+0uKod1XBBdBmCuLzvgAbc1Doa1/hdZavun0fe7HayLg+O2TjcAHtBHF+IlG6vEQHPjBTYmXa70OQP2lNHerSpO6+d7PRU+yoiJ0pFhUfPE+gPkVckR9bkiE+1QOM1kpqLM7x6cFgNUEGsS1ieno570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342413; c=relaxed/simple;
	bh=XMok27LeyvPMVk1wsLnM/8/aHhDw0CNgdmZ28O9DrS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cu217KfNbVG8bdjsBuyZIVq8RFWx2q1veofk2Mqg1UArh9U6H6kLkNpGsW406XeRH8OOqRaqFXTsZLbQWOoWtmbBmoiAHeH5xLlSJLNo1nwuL/rB5COEt5cozSBQA4VAj8ghAzCjrvKVx8myjIsQPs20Q1bO0MZDWke8b32fcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgMIKSY7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso1450a12.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747342410; x=1747947210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMok27LeyvPMVk1wsLnM/8/aHhDw0CNgdmZ28O9DrS0=;
        b=dgMIKSY7qCR1OgW5sBb03YdJPEHN5kAbtkaWQVcH9WAE6tvRKU0b5McF0GAeW3i8Uu
         TE8jbF2GWjNVROICmloT9YchArTuGtOJzbxD+xoHm4xIT8CZFxNzjQ/jdzBh193hsnCt
         BR+5IQnWqWuc3yOF0d78xp1JlCN1zRAS2HjDMYEvaAGQH8ImRdcfr//cwhGs7YLtBxxk
         E4KsoHt7mMgD4GYCoyfD4lScnqrAw7KKzbQSTJrYD/mxKjKRDzSZSYi3EKZQhVT4mVU2
         PfW7PXj7jh7RZs7LM2QYR6pcfB4FIIHa6/cOA9h02RsBaLoBl8EtzulbNM19ve4q6QmD
         aqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747342410; x=1747947210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMok27LeyvPMVk1wsLnM/8/aHhDw0CNgdmZ28O9DrS0=;
        b=Kp3xSWfWwzJ+nazlPvGOTXB7xrtWr1QUTvSzDi8XXYZfh0JDUuU2v0D7dzEPnfwG16
         2qw5uI+pVetiEwodVZSJAdBNujdd2H7YWYASihwtmR52iVzC4t9LiLZiDw2Z5suQdjy1
         ZzFzPLJToFa4WvPUt9wVI/v4vY3rA+Xmr3a+Oaex5Ikf2qBYC7GHSehmy26qjbVsZscA
         bn0pQAeqxeKSxlGEoUi01lssqd5IPMYHSiFfWlz3h4ZWt10eP58p9Q57/ZAoYgLjPbLx
         RFqUexmWjBzzD2zrK60lCtkeL5yy6UVaNUoxzgZLAfnB635kaZtAXonLFZk+zy39UaiB
         d40g==
X-Forwarded-Encrypted: i=1; AJvYcCX+yOeRaF09hGz+tCG3COnzBJ4WjjgHOezFAjNlOcDc4Zr0kdU0CzxuquD4NlVEn9q7VCm9r0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DhjVwrJn6I5DmJ+pqt2N97iZP5QzjbqLy1fgk2VIot41j+6z
	sYw8xEtnn17z0UQxFeZgl2YfXiDgA28ZGVR+tIJmca/JyEr+9JSmxjs50ES9h+4PGvabf9tj2Ay
	Rjg5nZM0yZXBBVjw6X2AKG5baToVDZcUTekce0+3l
X-Gm-Gg: ASbGnctC+YsyFPr9BKxyX1VpQjxILqgX4MYwQDT2uvh2pkhOuzshug0gq1S69tqYw7A
	kRgqiTPaZ9N8p0jZbiNn3XPuM5gnb9SyX+EE0/Q6C3LhYrR3JpcFEt5SB2uumlEY/wWXWdR6F0e
	IwpFUlUAgPimKiK47VoKUBN0yUKSmUFCrrkMyMGnpj6yTBYDMmBrP32guNM0pm2sJ1/XQG73k=
X-Google-Smtp-Source: AGHT+IECLHFWIrRiZUC7O4hqEBDUksv17PKckJK1rnL5QMtfgaSKVKKd7QPmPRV/LqJk6d0BzJrKKJ5nDtiVXyuVaB4=
X-Received: by 2002:a50:fa8e:0:b0:600:77b:5a5a with SMTP id
 4fb4d7f45d1cf-600077b6b0dmr89509a12.1.1747342410107; Thu, 15 May 2025
 13:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-2-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-2-0a1329496c31@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 15 May 2025 22:52:54 +0200
X-Gm-Features: AX0GCFvZyxY7ct4_THeym5x5LEYv3lsYRODqj4j24boe3WIKlaAJKd5VKjymUt4
Message-ID: <CAG48ez2HPOmWgY1riBJbt6tFzAJbJv_N5XnPwhAbVBfA1-sRBA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] coredump: massage do_coredump()
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
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

