Return-Path: <netdev+bounces-192014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC8EABE3B0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 21:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646D57AA18A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6E26D4E3;
	Tue, 20 May 2025 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="jhTEBsgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5025C70B
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769327; cv=none; b=HHPkcNCnKUUKjkxd8Zb4ikchHQ+EFEaV9PKDyHjGM5JYQpiojXMm6XKBrsmNLj5NUKjKK3M1CECerhnQTS/5Xlx1EzqICx0dZhgQnftXmnxDgl3u0/3v3hVULi//DXTb6xh/Mql+5qfMcN0sOqJBzOneDsmMre5Ny0liKnYFopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769327; c=relaxed/simple;
	bh=VDO3T/W1YczuPEGQTj+B/DwdwmAGf+sUsv2s865z87w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKwo2+/TKpl1K4FGJEWqRY5kB4tyaiLpoVIh3XEi9+ScrpYrZOu5g+vkaSyyML3vtfQ5RdOTrXnJ2zLXn6iXvxmqR3JO0NShXUz6xoxiQGjmFGqevrHhRcodv5ABI36s5siN8n8xhXukoNdnHoWzTcuumCySGGK1fTC06aECt30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=jhTEBsgU; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8b9c72045so57667676d6.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747769325; x=1748374125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSq28DpagvGJS4EtTRrUgm0EArBYqtzS+oqfIhFoB8s=;
        b=jhTEBsgUQidpFVnE5qLU4pKv1nO0I3DDJyO/CWdXlDVk2gHDOscqqAzWn7+/FF39en
         lxYNaWQm5QZ4DMclGefY/P+xGhIY2b6PoFItz65MxCZwhaqQ6QX6H1B+9O1fhi1qhnRL
         qRqE6HP6qrB0PiCETsG03zm04CNW5LAOqjMzZ46geJbg/LfI5dqlqeERuC4LMdvHF/ky
         wmRKoyiL8u+h4sm71CqoDz/lY5dEgoauNUd/BxyJ31CUMMVIflS0cu4zy3naIas+MxPf
         yRN3TH8CzU59pCMzKQ81NzUX9w3A47wnO8cDF/nyaOFtYsvDS+AnBzXRT+jPb87UFK93
         TKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769325; x=1748374125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSq28DpagvGJS4EtTRrUgm0EArBYqtzS+oqfIhFoB8s=;
        b=U0DljlDy8N+xfnlX6Vu0Ruzz16wpBYjQFnM9qblbjNcesPKwNnt5ZXK5r5GQGcPiFH
         Loz4MxVyEil0n9mPgW/W8mzS8NXbHW1NAjNO/1LwIKGsj0CEOq1ZwOym+x9PVj2i1wxK
         WwxsUQh+lgTWe0G6SxfR+Uf9XVBviGRdaspHrjuMKGkNhQvAQVubdH6mNPPW1VtvKDtD
         AVeCnyQE/P+BCCj5aWcxnwroaCWzvfgOBLSuq0o0sOm/bhl+QA54DpM2xPEYdC2W25QB
         O5qKIrE5dguziUTEdHu44ncEUfnKmni10HuaR98AvtqW5EqEnVfkxPHvVTmUgAI2zm0Q
         HyMw==
X-Forwarded-Encrypted: i=1; AJvYcCXWMglaOAA1FRjwjCt2wDVstF4XKhF/XsmZhv3O5nICQP2CCP8vQflNUSsyyfQaz6UNp2vMbH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhtz2mCZR7yqW1XGsMsxkftHCeg2IN48W2M6bJf2iXsQS+Iilx
	hdV5uY58GDBNuTyh43B7U4EFnPZ4rZBo5o5ScgS1Xyepco7/lfgelkcVME+/lONJyqM=
X-Gm-Gg: ASbGnctmz1jOJw2np9XCjHBQ5MIs0EMMxx3j+agVb2gcUNhTJxklNTGAnKTIF4siWa9
	nCMGmnE/y71yuoW9qjVL9FhkNo0bwilhbRiD8uXI2YxtYWtamHgu8jGV2fPzGyAAOV0Lom/L/lZ
	KDYFP53S9y82DnzsZFcaW+yOy0miTYFV6laiT4m1kMz1YKTZH1jxNOpUs6M0ihyq+C3Ko78WHAp
	+7lkxC9iuO+iKaO0Y2SaqO/g6BxMHBOsR8UBj7DYdIVA7d0o5gN7L06JCRDR/x3zG01gio0BBCZ
	C1ddp6oJ8xhQsUU3hr71ScQcg0qbB44bKaOiNFgUcQi4VGYv0k+rHnjyC7Hhfo76h9p4dG8kFNB
	POQBwloqXZIYWAQsqnlRmLfW53hr+
X-Google-Smtp-Source: AGHT+IF2atiktvD9wDULfPXZekAoh4vnDwU+9Pt1AMawvaALaKAT6Zl+DIgg+N+z4H74uEanAqqEQQ==
X-Received: by 2002:a05:6214:2027:b0:6f5:3811:cc67 with SMTP id 6a1803df08f44-6f8b0842b16mr287390866d6.12.1747769324713;
        Tue, 20 May 2025 12:28:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b8778237sm67169206d6.17.2025.05.20.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:28:44 -0700 (PDT)
Date: Tue, 20 May 2025 12:28:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg
 <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara
 <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Luca Boccassi
 <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Zbigniew
 =?UTF-8?B?SsSZZHJ6ZWpld3NraS1Tem1law==?= <zbyszek@in.waw.pl>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, Alexander Mikhalitsyn
 <alexander@mihalicyn.com>, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v8 0/9] coredump: add coredump socket
Message-ID: <20250520122838.29131f04@hermes.local>
In-Reply-To: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
References: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2025 13:25:27 +0200
Christian Brauner <brauner@kernel.org> wrote:

> Coredumping currently supports two modes:
> 
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
> 
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
> 
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
> 
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> 
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
> 
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
> 
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
> 
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
> 
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
> 
> - A new usermode helper has to be spawned for each crashing process.
> 
> This series adds a new mode:
> 
> (3) Dumping into an AF_UNIX socket.
> 
> Userspace can set /proc/sys/kernel/core_pattern to:
> 
>         @/path/to/coredump.socket
> 
> The "@" at the beginning indicates to the kernel that an AF_UNIX
> coredump socket will be used to process coredumps.
> 
> The coredump socket must be located in the initial mount namespace.
> When a task coredumps it opens a client socket in the initial network
> namespace and connects to the coredump socket.


There is a problem with using @ as naming convention.
The starting character of @ is already used to indicate abstract
unix domain sockets in some programs like ss.
And will the new coredump socekt allow use of abstrace unix
domain sockets?

