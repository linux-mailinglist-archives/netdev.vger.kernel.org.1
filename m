Return-Path: <netdev+bounces-272692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LhdDWcDx2lORgUAu9opvQ
	(envelope-from <netdev+bounces-272692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:23:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2DB34BF46
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 23:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39F943034B07
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 22:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB473939AE;
	Fri, 27 Mar 2026 22:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6c7u+YV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8438CFF5
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774650141; cv=pass; b=HDwbTZCaNWFs1gdqsugNIGZPPM4aCv+vqjslpU7om05XM+bU3kRYjTDDxSQXhJq7p+rm3IQku0Ib4Voa1ChlyukEqYhJqdRG6o27GZ8XiPSD577nYHNQwqooHNN8bQwGxILpQ3ni0qw5qUvhCb44dITsx3D4+tMCGLkn84srIQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774650141; c=relaxed/simple;
	bh=9BaAILRBSnp4b51n3HuXWC7Okzpny7id/wWi2vQ7Zhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gv92zGhY9/e89nIcH9TWN2OSPnRAiKVUv4PgWon442JIb+dlySBU6hq12pibtvseJLSM2il9H6UtIofeYorJBbHbI8BNpWuA4xXnED/3GP3OeHMUhR9IgwES3ApEuFys2OykBIb/ri5qZNxhcN5ZWD4EoR6Kq+eT4fyGgIFyKOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6c7u+YV; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1279eced0b9so3974932c88.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774650139; cv=none;
        d=google.com; s=arc-20240605;
        b=NZ77s7IUb7YHPATD0eXB+BN/FtrXAgLc0ZNBW1SpDAV9TJZVJAeHZ4r4YbfuV9KVs/
         5QJg0yorXSue4ZquuKc4yQiuTPwwu780t9fcR3APi0UoQRdyVCxw3HdNwoqeEqNKiHWZ
         FQeEFLzpUTHilNwPl4qoLlZdpMR2wAvZs3yEKaT3ZnHx5QfzPyfGE0wE+VOqV+IUGUj2
         bIDmwIFHBlwKIATxLj7pcn1Ns4xv08sXjYVUXw0KXZQL0boN0/E2Z+9bfxo19FjL24vo
         b00KuNnZfN2mZjhcWd4SQgbu/owiG+ACj3UcqrNPneaG50ibw8Y1/fw2ZlM4xoP1YM3J
         9cEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9BaAILRBSnp4b51n3HuXWC7Okzpny7id/wWi2vQ7Zhw=;
        fh=utOqsb0Q5dybq12q1NqxON/nrPKUs+Lf8FuIYVZANxc=;
        b=fGICje74r4uhGQnFd/PwNIIG8hBoXusSmGIXT/RP3aBhB22j/CAS3alILhbOMzMQUH
         2Hm6OSVx8xOzrTblpnhGXQFwcmwofIWpp7ShnqQaCzh3AUgNspdPahVvBE3EMakUpO5R
         +albTOl8T6G7qYxjt0Rtw51FwRMGrYuSYEdZC2DntLmYVbjOnV6Rdyws+sQZN3bY+Osc
         TOedEkegm0quZel2A92uZ2l1OiFHRAkgUrWveR8onq7RZ8mJopzPg1+w2eXElk0OwWTu
         jhZT6Zrg2WpVP5fNarBUx6kn8wjTl6E33GzsHxyRnzukQTqlOZXoYkQiLjj7/e1bq8E8
         HmyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774650139; x=1775254939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BaAILRBSnp4b51n3HuXWC7Okzpny7id/wWi2vQ7Zhw=;
        b=X6c7u+YVYGuUpB/LoVwD5Kbt69rA2zv6Xtd19WiYzQzRdLKGBx2t+aukV0Nz5v1gDD
         OWJV0sb3ugOjnszS/47gCZlP1L6RJk0oMmNh9V0HG3uf2wuv2/QkzD+miAc5t94N/8xd
         PGwz/XKNH8JOdwP5OVwLhtqIj7bO5sD40zJUP0OglNgfBU4a+VEgXOZexm1Y/R5hLyRd
         0V9ofBXhxauYyellVsDpAH4oXreU74pCjzo2FBFAjYtz3mvp2Uft/ToVGv/9lAbAphQv
         XSqflViLgrUuQeIxjiMT0Jww3hwRDZ/FNYok953PE50kPgmtmFzt2MbdEyFg4dmFNXdN
         xKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774650139; x=1775254939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9BaAILRBSnp4b51n3HuXWC7Okzpny7id/wWi2vQ7Zhw=;
        b=YLylyX5XR5gHEkbuoiMbYwAomyU57A6JrbrvSAGLtKQVXLU6rTGgssgy0jHuZI8kE1
         +KDmnuSl9ID6XueZyhUl00VVL31td39xDGhc/8/iwEnaPTPp8QScLYHOsedtZrjtjLYI
         inOhmjM13YvI48TOQ1f/G5lhd99RfbjAkj2K8NuwqL4bYhvP6Ly/1Lf0/ayWrweB2efi
         6p8mz3Y/OffVWsDXXTdCGF+zPcp3WuQAfFVTHnP4PIaHRxzNaAe7BNYcbhr1J7tGazcM
         8tNtZw5o5ETlvSOIkW7p0qhL6foN2f0NJ2J2wQtS7izhyBLysu3OM98OQEl4n89Bm/Fd
         x7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUUSceREG/UmYuXA+oLQehpG7CMPVuMJLZa5TBqh1eDdT2b2L+CJDrNKZDEvQfSkCY82Xv19Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlE0rZEaWeW32HRbVFrev2iLVd3JWL2SgVG8+Z2ZUedWpj25y
	xbkkgZuD0f84984qLcluSj0Dlkurf6gS9b7XPBLYbXc6GNMhwqSEO8yxeezMdf09GQla9I+KMHl
	AbCK1itnCIO0JJDMjw5eMVVbKcO0dko9cOhrp4jzz
X-Gm-Gg: ATEYQzxjHgkKI3QiiCCYww93CnUuIT/mYMLIYQ5EsaijABNLmK4/YeDxUIP1eYkqv5C
	RyFG1Px8lPUT9IzGioxnuHHYCf7/XXgvbSqbW0roqAAkeHb7wILBJ78XhojkmT5LzDImqX55EQh
	Pyx1ILudnExTzCLBP6sGk2Xx/qixrL+fMBu2MVQH+gjCKme5k0ZprFDeNa4GGd9sclUEDEAGp7J
	DmEqmqilsbPHqgUaXWqIhAzqU9ZrtbH67quaGeIFFxHSW8gYCIadRN7urHXYw+6c6VlfCcHPLQe
	EtReInl6RjgT6V1R0S48xiGy03IVZGZCzmkHSdIfwjZH3DRXtdNAwLQi8acsBkhy3JzSqQ==
X-Received: by 2002:a05:7022:6085:b0:123:345b:ba05 with SMTP id
 a92af1059eb24-12ab28cb38cmr2409465c88.22.1774650138929; Fri, 27 Mar 2026
 15:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327213441.3781433-1-kuniyu@google.com> <CANn89iLshTzN95t+GV0Tk97n_BCDzjAGDNTb=vSyF1rQNqwe_A@mail.gmail.com>
In-Reply-To: <CANn89iLshTzN95t+GV0Tk97n_BCDzjAGDNTb=vSyF1rQNqwe_A@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Mar 2026 15:22:07 -0700
X-Gm-Features: AQROBzAQZlXGa8C-pWE7b5fzoSlmNZ3IUKsWxZoToS41YLshVIAMr2yWo8ICr8A
Message-ID: <CAAVpQUB=LtWXq_bzET2DOkyw_y5qRsuUf_fNCRE+TtiVHFktZw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tun: Ignore tun in netdev_lock_pos().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,lunn.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272692-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE2DB34BF46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 2:48=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Mar 27, 2026 at 2:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > dev->type could be any value on tun due to TUNSETLINK.
> >
> > Let's not warn about it in netdev_lock_pos().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Hmmm... should we instead have a list of supported types ?
>
> And reject user space requests for unsupported ones ?

I chose a safer way but maybe we could reuse tun_get_addr_len()
and define the default case there as unsupported ?

I guess it's okay even if it breaks userspace because we can
just add a single line to restore the support.

