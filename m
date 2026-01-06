Return-Path: <netdev+bounces-247380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35FECF8FF8
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FBBD3012CE6
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BB338934;
	Tue,  6 Jan 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2QmD0pw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B1E280CE5
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712428; cv=none; b=gxXhIGsumea4IEKL+J8U/4ykYnNQ3oy2gTqNjQDWi14dlD3JSozX1JkPjKhXBNLp9QQRuzIl8U5L/zrrHMlHCQY955MH3k1XaTLQ4bGo+f7+PI8zn9U910NkMFO7sHrI4NAPxNcdo0euQ3t52bRq7rshY31EI15KrSXx+NdFs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712428; c=relaxed/simple;
	bh=8YMPPQK2AEC01ATxaI6pFFBCk/F1VR9hTkIqMFIOc1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BbD67Dige9EFvW36MfqL7uwHXs1gE+Hd0+BhoMSmXKxM3BgdxZ/YabiVG2HIK4t/dBplL0ldEffKkgfU+V5lhhdqZtt9QN5uJVd6bayq7IGU0mcyk+3DxmfenvdCG3jO/Mj05ObbM8NNn0YzQ0JMLkwdgGfx3WPM0nd6RJjf8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2QmD0pw; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a35a00506so13588606d6.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767712424; x=1768317224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YMPPQK2AEC01ATxaI6pFFBCk/F1VR9hTkIqMFIOc1E=;
        b=i2QmD0pwz2vHPkMyFvS10c/93FGlGHebmXiy8IKSAuH2uBcy8dS1Nn3yR/oaM/p1Fw
         g3DBn8l+ta9NiuJn2CqOXgdpgi6vamKGIRS4v8AawcO6p27vO1Mh+wDTL+1KThcISnls
         s3qSlDXydaQgeXPKAah0OkfmHjPHkEJbcDV9rBeTqFXib4dUO9wEE9ul9yZglvtxQyZp
         2YWAfatYy5r0SFqtWl4GCmdlUfTGm7nArhKmR6QmJsZf71qRkUZKjHhcOQLzKaowwgRf
         49GHQSJ73DBt1Eyi3cxNsTJnE5A1/tfeOxZd74/9U5rvLd53JVmYKRgHLpuxUcp63E92
         UDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712424; x=1768317224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8YMPPQK2AEC01ATxaI6pFFBCk/F1VR9hTkIqMFIOc1E=;
        b=i7GOCaF4UnI8TNdYWI81EDPZ8hoIPx/wGjJzOfCFCll2id4zjKSCjwWn2bvCx2EPW4
         6ISEeOUUJ6rtNZ6/FidlA6BnvFOd6sIRKhoDbuU0eMgdDAZmbrLbE+pZJJPxS0q9y4ft
         DM+Nj3S/7xEmxrIOTfHBZuPNJ17+9rliJxrTlhA7rC7tmJYzPfq7C8M/hsQmX/amV585
         Ne9rP+ENtPuq7HVclHpnfVngE16/3E5xWWaptJMtjanCx57T9ooBGorkN8IIVSNoRlKP
         Nwngp21NlMT2k6cTrBeUQlxnPK97DdbxhpUg9jA2D1J06UFclCFLyYI/Iyv686AJxFod
         tnfA==
X-Gm-Message-State: AOJu0Yy3iekuZMHqom18oNWRa5T+VAnjNuVkbQwW3id3gxOPmu4SdSoi
	urxcREcHhI+Uw/WcRij8g1NMNUwLPpXxzchJPSAr/Sl2jzF9tWxRRsyE8hOID8m2c83Y5PLNC1B
	FZgJUWDx5gQChoKsUvYdaVReXFQE3HQTZATyLKPBa/2Tz7pnqjLbuf+g5
X-Gm-Gg: AY/fxX7q3pMzA+wj9rLyi7PPf2dYSQnVbssNWJa8Lhi83Cl3FOL43c7hhZwR/oI82DL
	uM3hv8IX5YvLzXK61k8ZmfFsG8kdZlr8EJu4+7dVin09BjCGt0et+Qxc/eD/vksGI+ChQOApzA0
	vVJ7UGD6rA+lO3YFVkojaLNapqTWFOhuynER+PMnmvIRhwFbdkIUkdfhMnzh54I/gf6NJJaKQMK
	RaJy/DOqiZCr95a54RkQ7zAgMhTfFuZmvYdK5FxzRL7WTszgVp34DbyR0kASXwbRzXBOypc/NaL
	+rNI8Q==
X-Google-Smtp-Source: AGHT+IE5QJWD0yG0ephPKKctX/puC0yoA5N51JXbqQYsDIojgOXAhxFqK8fY0Nkvcx6A/4Rhbe39rz6vlWpzls2UUsk=
X-Received: by 2002:a05:6214:29cc:b0:890:36ef:80fa with SMTP id
 6a1803df08f44-89075d21945mr43086406d6.6.1767712424258; Tue, 06 Jan 2026
 07:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 6 Jan 2026 16:13:32 +0100
X-Gm-Features: AQt7F2qURt1-m0ouxrE3Rh_tUReZ8VILy-eEM52X9KAXc1236eunh7MazELiohA
Message-ID: <CANn89i+dqPTJSfqWFSXs=-79mmyhPeE1JTWFaJgdQvnvp5RDxQ@mail.gmail.com>
Subject: Re: [PATCH net] net: do not write to msg_get_inq in callee
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, axboe@kernel.dk, kuniyu@google.com, 
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:06=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> NULL pointer dereference fix.
>
> msg_get_inq is an input field from caller to callee. Don't set it in
> the callee, as the caller may not clear it on struct reuse.
>
> This is a kernel-internal variant of msghdr only, and the only user
> does reinitialize the field. So this is not critical for that reason.
> But it is more robust to avoid the write, and slightly simpler code.
> And it fixes a bug, see below.
>
> Callers set msg_get_inq to request the input queue length to be
> returned in msg_inq. This is equivalent to but independent from the
> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
> To reduce branching in the hot path the second also sets the msg_inq.
> That is WAI.
>
> This is a fix to commit 4d1442979e4a ("af_unix: don't post cmsg for
> SO_INQ unless explicitly asked for"), which fixed the inverse.
>
> Also avoid NULL pointer dereference in unix_stream_read_generic if
> state->msg is NULL and msg->msg_get_inq is written. A NULL state->msg
> can happen when splicing as of commit 2b514574f7e8 ("net: af_unix:
> implement splice for stream af_unix sockets").
>
> Also collapse two branches using a bitwise or.
>
> Cc: stable@vger.kernel.org
> Fixes: 4d1442979e4a ("af_unix: don't post cmsg for SO_INQ unless explicit=
ly asked for")
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@=
gmail.com/
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Willem.

