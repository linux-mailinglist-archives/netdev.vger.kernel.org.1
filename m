Return-Path: <netdev+bounces-175937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06935A68096
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63FC421CF0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2BD21B8F5;
	Tue, 18 Mar 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LQ6ScVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7221B19F
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339362; cv=none; b=rpvX2562G2wGz5h1+FZe5yQbSzfRXVeYSBghAyja666M9+M8Jj1VY8NwpmT8sEqmVDQ/dyFMQ3SSJAV7LYk0fmUlpIMNw4aiI6q64A/cYb1vqI+QpwGQva8UFP4CudbuEZRqew1l7eliuUQ3n+Eu96VErd7MGzr8m+BSnRupYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339362; c=relaxed/simple;
	bh=CjA4zOMD5+CMfB+wt6I9F9nAPXCgEkSwzGoXpCU7GQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N45AYWZQBp+pv7sGndWhrqrkOnpablHQtPhau+Y6l1d4ebhVJ7SuF0a7dhmA/32lH6MMhMZS8IQD2V1kLmhB9hyPDmpnZc/rgEHfvxAs/XseqtgGU9MipIaakluoMGlhDpXb4M8iDxm+Rlojk6tIz2RU9Gt0gnj4O67cnonxkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LQ6ScVA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso2126a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742339359; x=1742944159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CjA4zOMD5+CMfB+wt6I9F9nAPXCgEkSwzGoXpCU7GQQ=;
        b=1LQ6ScVAdyd4rbEFiHLne0XG0Juv9SuwjraC0cFjQAlxJbMeq+gVlVUIoiaXKbLzq0
         ngwlkQmnxEPT5fR3eqCY0QKgHQ/37fevs64Ls4svT11v9TqzSKahu7SXPdmBpSdiZS6z
         766Z4QIAvrt2x8hZOKQACfN1Hr+dv0fWfInNDjPqYtffHEqmBufvCXssi3Zvr6Diur0M
         ZHkP0yMNdypXNHTPGsJqGfTPdsANt4OOeIQ/BTRcLaz+PhJTIBVUPND5u455ThxoVdlW
         K6IQePQI2XjUc6iMAF01xixolsx3VIN3Kxkvx9OkNx24MHjMuLSLMuV6nsY92DHmSpbK
         XGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339359; x=1742944159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjA4zOMD5+CMfB+wt6I9F9nAPXCgEkSwzGoXpCU7GQQ=;
        b=RfSlSegaVdj8Bzvr3r5UlyIDpZQuN8RqnoVIEPEhJ3NvG/DkXjSCCg1GZutBaw8A+1
         olAqyskHRTm+x+7eh0j1Q0OMel+j7+w0Et1BVW9cJjpDeOBOBUyNBA5v2gSMCsaA7ydW
         zwv+idCCi8VaikBA/VXPLpdGWFavOy7FD4Crb4BmSk/iHMCyARuxxX61kTwh1+P63+JL
         ZUmUUYlabz/4MHeoJZ53o9gCkqdhWzKAZqaQtVNbTp83I7Jtoc8a5SpnqasTl2HnUmpB
         NLY85z/OASdG5G6Otq8EkobIdsxJO10ZLS3WEdcVmX7jfdjEyHlG4snjL852+5QqDZRt
         XRQQ==
X-Gm-Message-State: AOJu0YwCPyPLZB8Oj/4XcTrebiJe8iUnkAFYK1GhIGBXVOCBA7iwf1+T
	PWuAb7S4n4xS47wWvZpUl68wB87jy1Ob3Kg1xoVTSyD+vUKDgtQk5WGFcFC5VipEsp1wOgSPzN3
	uCTudDAjHZpMMg++3i1EoVIn/HNVG7/7bElGl
X-Gm-Gg: ASbGncsJ4L+ikv1RIe69EUfek2unDwLXMjEAFKC9HOBMYI7O7gdrkc98wRFtxz1USJs
	Ukoov8szjUX2J03SDSKOexL6E0AfwbzuM7t0uv1wIAfpvYRfGUjybeihZwFzULdniTAJp01HfJp
	giKToNAjfVh5pkepO1mGx9r3XPUgHfjWMxatZni3oDPpP5NU6hjfIbVpvvi/5YCJtymdszFQ==
X-Google-Smtp-Source: AGHT+IEsS9pm/A9P/V339kq6NeUBWm+ldWZJQGcdbNeUaYnUKDvIpT7RGPZFNexJOP13xEMNFsnOLbUAIuVUzdrZGq0=
X-Received: by 2002:a05:6402:1d35:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5eb7ed71195mr38522a12.4.1742339359123; Tue, 18 Mar 2025
 16:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
In-Reply-To: <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 18 Mar 2025 16:09:08 -0700
X-Gm-Features: AQ5f1Jo43ErVitqTSrfP6TrQUvNNw18_y7nhpcpHwmZNUAGOxPs9C8GthE5lCGI
Message-ID: <CADKFtnQyiz_r_vfyYfTvzi3MvNpRt62mDrNyEvp9tm82UcSFjQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

To add to this, I actually encountered some strange behavior today
where using bpf_sock_destroy actually /causes/ sockets to repeat
during iteration. In my environment, I just have one socket in a
network namespace with a socket iterator that destroys it. The
iterator visits the same socket twice and calls bpf_sock_destroy twice
as a result. In the UDP case (and maybe TCP, I haven't checked)
bpf_sock_destroy() can call udp_abort (sk->sk_prot->diag_destroy()) ->
__udp_disconnect() -> udp_v4_rehash() (sk->sk_prot->rehash(sk)) which
rehashes the socket and moves it to a new bucket. Depending on where a
socket lands, you may encounter it again as you progress through the
buckets. Doing some inspection with bpftrace seems to confirm this. As
opposed to the edge cases I described before, this is more likely. I
noticed this when I tried to use bpf_seq_write to write something for
every socket that got deleted for an accurate count at the end in
userspace which seems like a fairly valid use case.

Not sure the best way to avoid this. __udp_disconnect() sets
sk->sk_state to TCP_CLOSE, so filtering out sockets like that during
iteration would avoid repeating sockets you've destroyed, but may be a
bit course-grained; you could inadvertently skip other sockets that
you don't want to skip. The approach in the RFC would work, since you
could just avoid any sockets where abs(sk->sk_idx) > whatever the
table version was when you started iterating, basically iterating only
over what was in your initial "table snapshot", but maybe there's a
simpler approach.

-Jordan

