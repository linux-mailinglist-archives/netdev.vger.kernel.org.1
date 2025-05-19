Return-Path: <netdev+bounces-191398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB92ABB631
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B113B2867
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91133266B6C;
	Mon, 19 May 2025 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbx3n6Sa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9F266B59;
	Mon, 19 May 2025 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639943; cv=none; b=BV83TyfCS8AE8iEKv2NBpbPYX/TZfRkdzDbQloXxni4VY8PMSEOOggM6hD6aQWjwh5oRNUhL/WYxmHwedhABVxrnZWtiXNJlAE/pCJKe2q7UbKp855Xv4UKSZaO8JBThlcDJqlj6AnQqsLBjtR/Qy/i/S5IUon5jYUWdeBwJocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639943; c=relaxed/simple;
	bh=96b/+gZjEWbZAwxxSeXGnmei3SFYh9dxnC7SD1C4LvI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e0pNWlPRNRedyCniofSpOUE/1aTPgw/Jm9g15tuIxnupLWsdDnX4//iQepRafbW0fyV1fLuH626OyRJ8VzJjtYV9Kj6ebG8ej8dDW2T0zMl2Ujnqpr9jUB6nakN9LAKM2ZUPxC+RSkbwJ7icRiZBi8VCtz39/C2B15HvMKW0v1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbx3n6Sa; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e7b3178473eso3678626276.2;
        Mon, 19 May 2025 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747639941; x=1748244741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=96b/+gZjEWbZAwxxSeXGnmei3SFYh9dxnC7SD1C4LvI=;
        b=Vbx3n6Sa5qRJEV00YNYnJWnMMSmAjGvRYecJGfglrP9YyFvITzfGcbi+1/BR/1verB
         8rDD7TG7Y4yzALWQ7UgIfTxEd7GhFFMGkC4hZdLuWr3XcZYkiZ4+elw4L4Jx766snnZu
         5U75qQnLnVNB9U815vjBjpHkhPzOKZinqJ37Jl0nF0eXSwuCPu4yZwz76/XXjmu5XcOR
         SfXz8vEjKgIRiD9AolXEEEVUNPgtdru86fluGx65Ncv4ocOL3k8iFpA4SDMT2yGTgpyL
         ythAgP+DqA95FGIGz/n6B2U/kxH8U5fofGhXsJ1GBwpCjIF3SOr+28q41A34OyCoxJDg
         afPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747639941; x=1748244741;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96b/+gZjEWbZAwxxSeXGnmei3SFYh9dxnC7SD1C4LvI=;
        b=oGtcxoMD6XtssBJPEABLJGCVYNeSr2UA2gQglhwtzOrpSUYBfO7hpEOLGyPcP5LtRP
         1ehJvtwIVr96tkXRD9vg8cN2VTY1eJ3kr8TmYP86NMIZ0ciCpQNXrtBY+w8ak20+DIxd
         M9PEcDl2bih/rRXzJYULwW5ugxTyqWuNI5M7kZJU5kwxUeBiTgsyGJXHkgvC1TPNeYTf
         anR92Cq+LCY5ECqcZO558FPX6UlrcJWf/LziHe/18bWfKNwpTGN7DzwpX2GKmojGnf3v
         pgOQfMCrnwnQSTEC1BENIj66DMwPNudxszGNQCcGBjtemLABuuDa5JtpN4a/bfd8wXOM
         cfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6JcP6ZZQ/b6CV04WZGV1c8UGy6PVKxrsbRyxHIjekXvI/13SNN7B5CVh0edWNrHnR69SdkAhP@vger.kernel.org, AJvYcCWSZSgyz7hwE+edKHGT6ulQ/tTjn3UhCFLFKBxDaaOj80zVrtdtLR50IWZkCz2I9zPEWstSqWaI8RJ+wFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCSmRJUs516QvAV3ytjlHF/m186ZIqEEEYfF1tM15MDK0p1xi
	HJK8KOBp8OGAlxA6ZaupLhHprK3Dna+XP+6alQYo/e316K+yQ5Tug6CvZzfOPxzH92LN/vnv1ZS
	ZuVtUQNcLw2cSMM/7TxrqFyKlX0hsBRo=
X-Gm-Gg: ASbGncvrEL8P2/InXoJDCljp+czpBF/xrkYVG3um8zAjCe5WVvE4Db+eGu5WkYY+a+N
	QAky5PaUYUkicEs5CjBRw6CeLvYBdPeC1FcfZeFzNu8J+y+PR/LjU1o+qxtTeBK940GGbjQBspz
	jnZzmlkJdQTAkdrSDbCwsMw9qtJnOo8FdrgA==
X-Google-Smtp-Source: AGHT+IH8ja8mMa1DJ8eUfwKcRUSAp7Q8MTrscZJXEv2jtQjY+qPuL/aAU/1Qj8qv6WH4Fx5b6CTIfAyd0TUKSkPCtzc=
X-Received: by 2002:a05:6902:13c6:b0:e74:b106:ec71 with SMTP id
 3f1490d57ef6-e7b6a317681mr14809130276.46.1747639940918; Mon, 19 May 2025
 00:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Mon, 19 May 2025 15:32:09 +0800
X-Gm-Features: AX0GCFvPRz8wTXAThKRh8EyzFGc5WQK6Ra5SDhUFbzT_Rz4DWOvJOM4iMn5gEWQ
Message-ID: <CAJNGr6s2u+8tUvHzNCWAqweHD23ijRQoFzJE4kR0xouAFsRj5A@mail.gmail.com>
Subject: [BUG] INFO: rcu detected stall in unix_seqpacket_sendmsg
To: pabeni@redhat.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a crash related to unix_seqpacket_sendmsg. The kernel reports
an RCU stall in unix_seqpacket_sendmsg.

From my analysis, the stall occurs when user space calls
unix_seqpacket_sendmsg (via sendfile or similar syscalls) with crafted
parameters, causing the kernel to enter unix_dgram_sendmsg and
eventually get stuck in sock_alloc_send_pskb or related memory
allocation routines. This leads to long-lasting blocking in memory
allocation, triggering an RCU stall.

The root cause seems to be insufficient validation of the message
length or socket state in unix_seqpacket_sendmsg/unix_dgram_sendmsg,
allowing user space to trigger resource exhaustion or deadlock
scenarios.

I recommend investigating:
The behavior of Unix domain socket send logic (unix_dgram_sendmsg and
unix_seqpacket_sendmsg) under abnormal conditions.

This can be reproduced on:

HEAD commit:

fac04efc5c793dccbd07e2d59af9f90b7fc0dca4

report: https://pastebin.com/raw/JJyvCmCn

console output : https://pastebin.com/raw/TUPGLzqh

kernel config: https://pastebin.com/raw/zrj9jd1V

C reproducer : https://pastebin.com/raw/ZzAVZ1ua

Best regards,

Guoyu

