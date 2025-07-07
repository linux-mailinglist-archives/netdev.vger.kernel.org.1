Return-Path: <netdev+bounces-204485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAB1AFACF5
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67A7176A0B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6F28641F;
	Mon,  7 Jul 2025 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0UyZRAt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979C21CA08
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872895; cv=none; b=IuD4IExp3FNrjTc21S7Qy3OhT3mCk391QUo2lxvV5bRJCEBADNczypR+Yu5uja8v8rIQTHTIMploSSOuofX5ozU21QXNRSEohvRUPaHt8UIYR6MStdtB8u6R1LeaPqzlVW1eBM7gfkkkxAbMnHs0ChcgPZa5UGSUjmxEcI2hg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872895; c=relaxed/simple;
	bh=qxc/X70pqNaJOhCIrlhit0fU5Btv3EL3u2/8T9VYUKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNBLuq1eUfTzMquTT6kzLqqzi5Z1mVwYiihELlqwYaRLD+kKgqlvzkxZ0BZ+i7yZ3X3QWXtYgK83/hGaH/oIj/Vu5vkOZs8C22bi1XlzdFkYkIysqLC1NJZ8lGVNWS3dCuHmMe0ypunuquJamkBBxn4b02zj8riWaMJQgYGQupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0UyZRAt; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a818ed5b51so20124831cf.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 00:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751872890; x=1752477690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxc/X70pqNaJOhCIrlhit0fU5Btv3EL3u2/8T9VYUKY=;
        b=D0UyZRAtT/QiYh5tgF46Ejr1kqfHQDLVm3ljY+k25/eUpYRPc+DFfhL5KvZrntoZLn
         bVyd6X8vg+tju5js82pIDEAKNYZgdJiFyUa9sDhqw3VZoML7Pn9hTA7N5UdwS6WxsxnU
         tU+rFOThkcGZgcBxKMqmexkRIMPynt9uf/ZrqO82heZNi2QYiHeqbstLPP0qvlth6xF+
         JGMnjlibnjcwskMY8t8hlG2dcvcsxN/Np7Qw6wfHklH9T/wz5i1ovWKP/0YTTFtTqMmV
         Cu9IQj682lnOg5SCowVIro0DCW8MU0itJSN2pa/wAlojDo/101kTDWtBR2P6lPDHwoYF
         bC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751872890; x=1752477690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxc/X70pqNaJOhCIrlhit0fU5Btv3EL3u2/8T9VYUKY=;
        b=YVLx2r8SU3yF2ASMHYRBvBQ8qYclsY3tAMleKjlRe5sj9sDgL653ioKg5CuCC80qjW
         xjbuw0eQHfwL3MChhS+Eb7RCRkza4+prgPAG4H+6OXdaSQKmmhjwNa30KqUvErw+rt+a
         70kZjSKjWjlk/7gcYfq9TzNvQaiskSXAhSqruxdou5AbFnSusZyiKaVqMO67UdB2Eox7
         M+J5pgTF3ocV23va5C98fJpykoIpFgXYco5bQCtXwZt+vB7ni1OnpLzbDjiyrfpWZP2H
         yAhDMtupJxhgfuDY0pc24Y2/cyvw3AYhcYEsJnzhXz12ZIgjR7B/SUH8OTSsNwR2AitM
         azEA==
X-Gm-Message-State: AOJu0YxEMly2ERJVusGMHymLW+nzczF3fZf7JhpS5i0mfTTxm6Po/klC
	ZLXc9PlLNM9WrZaOzqi/QFtC7pFCpHQx/npuA/rzh/qKqn0h9JQWTFnzDDj5Rtoq1qMwvhC86dQ
	aVD5N60QXWn9FlADwEqam9Bh8AFMCL/SLyxMb+14d
X-Gm-Gg: ASbGncs8mwBrhzuitdM5zr+RjgnehDGBU+hQ7SZWleoZJnEFJKbTTTwZtKYytYdKV+9
	nf8joPpQpUxXnpZemgZDbV85y8jONbd2o44gZsD1Zmsj3OAZSrtKTFtSflG9xbVQyyMPZTnDOAE
	S7CV6a9D5wrixhEF4pzXl11WcvwhzIYnzbJgvZoxDw+A==
X-Google-Smtp-Source: AGHT+IG7wr5dEGh6h9pfxfRWkI384hQypq8lNPyCGN36O3Fa3+8sw2G/22BonIyraYeaEv0BoxQTe/Ssj2U6AuOxCXo=
X-Received: by 2002:a05:622a:15cb:b0:4a7:6e64:a52b with SMTP id
 d75a77b69052e-4a9987f8adamr167676801cf.35.1751872889643; Mon, 07 Jul 2025
 00:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707054112.101081-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250707054112.101081-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Jul 2025 00:21:18 -0700
X-Gm-Features: Ac12FXxxeKN13WecyDKW9_C_Pkuorhiq_652hNh4S6bIhPzhaSIolIIPI1t4jqA
Message-ID: <CANn89iLRxmaj=Tc__BbK=AaauTKm0Mvb_SxQmaFb=xdj+kQu_A@mail.gmail.com>
Subject: Re: [PATCH net-next v4] tcp: Correct signedness in skb remaining
 space calculation
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, mrpre@163.com, 
	syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 6, 2025 at 10:41=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Syzkaller reported a bug [1] where sk->sk_forward_alloc can overflow.
>
> When we send data, if an skb exists at the tail of the write queue, the
> kernel will attempt to append the new data to that skb. However, the code
> that checks for available space in the skb is flawed:
> '''
> copy =3D size_goal - skb->len
> '''
>
> The types of the variables involved are:
> '''
> copy: ssize_t (s64 on 64-bit systems)
> size_goal: int
> skb->len: unsigned int
> '''
>
> Due to C's type promotion rules, the signed size_goal is converted to an
> unsigned int to match skb->len before the subtraction. The result is an
> unsigned int.
>
> When this unsigned int result is then assigned to the s64 copy variable,
> it is zero-extended, preserving its non-negative value. Consequently, cop=
y
> is always >=3D 0.
>
> Assume we are sending 2GB of data and size_goal has been adjusted to a
> value smaller than skb->len. The subtraction will result in copy holding =
a
> very large positive integer. In the subsequent logic, this large value is
> used to update sk->sk_forward_alloc, which can easily cause it to overflo=
w.
>
> The syzkaller reproducer uses TCP_REPAIR to reliably create this
> condition. However, this can also occur in real-world scenarios. The
> tcp_bound_to_half_wnd() function can also reduce size_goal to a small
> value. This would cause the subsequent tcp_wmem_schedule() to set
> sk->sk_forward_alloc to a value close to INT_MAX. Further memory
> allocation requests would then cause sk_forward_alloc to wrap around and
> become negative.
>
> [1]: https://syzkaller.appspot.com/bug?extid=3Dde6565462ab540f50e47
>
> Reported-by: syzbot+de6565462ab540f50e47@syzkaller.appspotmail.com
> Fixes: 270a1c3de47e ("tcp: Support MSG_SPLICE_PAGES")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by : Eric Dumazet <edumazet@google.com>

