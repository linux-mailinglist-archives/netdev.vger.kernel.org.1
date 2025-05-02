Return-Path: <netdev+bounces-187472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2BDAA748B
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531D63BFFE5
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA372566DE;
	Fri,  2 May 2025 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YaG2OyDd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952A2561D7
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746195088; cv=none; b=ByoW8JA7qJff9duDlsaNGP25zM6ggEskHqRKxLCe/O1D5xdQS1PnBLf6KMVzUxggmBeonbNBa3Z7b0goH5v4UocMpBnTEJ624qOYMv4bRD/nsAm/m0NC/4gEnutYpAJOPWY5XbP79FW8d4t1/SGEZMWY+cLez0fODNGeC5V+sKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746195088; c=relaxed/simple;
	bh=Vt2jUIItSucYOFtSbIcXHATgjkrt7oAf8nrQ6pmlrbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKxiGXnQyeQXLEYe0UDdi9wCG4weIjBbz1UQ8O3HxID8Y6iM+YJOzRhC5s6W21Um2pRRNn0pqHUxV3aWxhKVkFfDpFgi6z7MTfJBQreFYXdWcbwon76hdDCOFLJ7DKT7dCo/nsSOfgN110SwnRpoi46F+HPnbJWHWB+ZJYvU1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YaG2OyDd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so11037a12.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746195085; x=1746799885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt2jUIItSucYOFtSbIcXHATgjkrt7oAf8nrQ6pmlrbo=;
        b=YaG2OyDdfxp6rWAfJEcX0jTBAp1bikRAEsb3RZ0sVY1Ci1V2Wssrwo01mcXZJQC6WU
         54g+QpeGj9ixHjP+K6GwtpMMFjA37mHJgEs/VhGrIO8v2DfLTnxnucVgZxd9EXz2DyCZ
         4aDbpLFVt6+opDL94J3CWeoXmHbWNYSOJ8lKhV0QPTCkp+v7vVUs11B+/vRqooR1IQl2
         PXHvLWRRElKm2AdKtUCg+P8gF/4x3gLwpKX5q77oSKh4QlC5gEGvnnlm+pjV5lMET0te
         b00baFbNlCj/haUM82JciErz1tJH3MeOH7qc1W27MnoBk8flsKSv+9un59puG8+t14J+
         CI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746195085; x=1746799885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt2jUIItSucYOFtSbIcXHATgjkrt7oAf8nrQ6pmlrbo=;
        b=aZvECWl/UwTj92R/yE+sFSrdiT13i4R++1zwKFkNko4mvRQ7/jG1R/O6geiIfTrG6y
         7JMqf/RIEBhdAs9Sg3fPoExonZPI4pM6in9P0yAMJBvZ0ekjaWGEJlmKZKHwbh+Tv7bD
         XEM5L0+JA476v6H3TVOSUGHLHXu0cedlojuzagOEaL/UT5r9cwMTYiS1RxNjCH/jlLyY
         fdG7/kQ4jw1Vt0ZhVAcgSIt5pZQfKAquTOXohctcceIjB8VO4i0F8C51BtQ1kXg0YOpI
         T/kM+X/1pnZeCf2xM1VMsdA/L/XRLL+Cusc7zphRksxCeZsz1yjyROoK/uv1OoAX7hXp
         IH5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1hMj1siPimgo18w7bldLmuu+W/EyRCwgg++VNIbwjsTk/3e1sDsMVfS6CHJUGmA2NIkCd6fU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4gsS9BMzQTayKGjMfmj0U4MBjRZAcUQuz4ns72EzhmBA4IkL
	zPEQD6ce0q3laV7Dy/xQoJMNQKrZxo0GxjMVqBha9F+C2lF73y+3SPyB/nkNj4ZD0lg47RuXvzl
	aiW/jVhvpBLUe2Y6NDI4r/WDOVzkZ2IWHIXu9
X-Gm-Gg: ASbGncvqhbo/H0STRhRc7APB5jZBorCVEeHzL0jV9Jwu5OllwugTXTncv7yVob1M04L
	E4dps/kCLsTZ9HA5wv7Yj7l0qyNWmLmIsAohT1cJ/t7YmiNXnBdNbmYW+w7H8SNfIvCKH2QXoPn
	G7U0omJqyVvEfBW88P5huwAIBIJIgaD3zRUYqJtF/nLmTGiyuNWw==
X-Google-Smtp-Source: AGHT+IEq4zZYwSq4JbP1XWIN3z7LZZH/ze1XMZW0I7CaF9AqWXRX3zQiHPa0jJanCkxNdcG6ojLB9VYf79HdE5YqMJ0=
X-Received: by 2002:a50:c018:0:b0:5f7:f888:4cb5 with SMTP id
 4fb4d7f45d1cf-5f918c08662mr174781a12.1.1746195084602; Fri, 02 May 2025
 07:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org> <20250502-work-coredump-socket-v2-5-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-5-43259042ffc7@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 16:10:48 +0200
X-Gm-Features: ATxdqUENxkugyPW7ElgtsxNZpy_Nh_FmjQSxMwJIlzlcl6CVeGfFkE7y7zUJP5s
Message-ID: <CAG48ez1x09k3neRXqZYtPwgcxN+8a9=HZCtUkok54bRwAk6BSA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/6] pidfs, coredump: add PIDFD_INFO_COREDUMP
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:43=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Let userspace know that the task coredumped and whether it was dumped as
> root or as regular user. The latter is needed so that access permissions
> to the executable are correctly handled.
>
> I don't think this requires any additional privileges checks. The
> missing exposure of the dumpability attribute of a given task is an
> issue we should fix given that we already expose whether a task is
> coredumping or not.

Yeah, it certainly isn't more sensitive than things like the exit code and =
UIDs.

