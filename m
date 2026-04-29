Return-Path: <netdev+bounces-282149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFkJJulM8Wk0fwEAu9opvQ
	(envelope-from <netdev+bounces-282149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:12:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170DF48DB7E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A3AA3013726
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5C4C81;
	Wed, 29 Apr 2026 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOJ6kWr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57110F2
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421541; cv=pass; b=JlV4+GBcroBEMb1YC4lNgmHyWMgj1M/plxBH3l5aX6x7+PQgs0F3Hai9d/T76/M9GJ18L6OdKnM3ciE0AZR8jZchST9P1P0Getm8A+ltC4ZoNhaOUQe0EBYSdEhbAoiyVhnUnt3eh2z10v0O6/Eg0Ohar9+V44gh9Zr9sR2o590=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421541; c=relaxed/simple;
	bh=jfazfgT1k9Ptk0iCQuYriau5Q4HbmvQBJbxmOH+gozk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jioD097QZdgkuPGgdoimWrVY0Yp2rURpQbmvqbEOoeLJWon08jpzRTtjfcwEDZ+l90obOEX9C+J5Xwba85qqDkdMi2exD/1MY2qQ6TieOvyLa++HeDSYSXaDh3RPfGNOuahy6zpTz08mlRu7rXGCvvMnOMNVbapDzWdct96eV04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOJ6kWr4; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d880e6fbbso3746411cf.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777421539; cv=none;
        d=google.com; s=arc-20240605;
        b=Ipk+WWdVZNEbjIQiJuJyO4LPiiq8V/oKF4tN/+plcHIAkorEi3NfYh2wUzpOdnr04S
         SLo7SReAdVtpM4V7GtEAhhePI1SNI5LWt7EdQPzL8GCx3H0vXWigpd8ixG0VjG9IVLjH
         UACMhTi5T+TaqjG8DXv3xzeH+XH4g+wv5LwdqymSugxpdrKu2NTK/tXMkiev4Pa731wD
         agwLccL/twQujekNnouj0gtXW+O0TLn+TMz9eqaVAUuZAtGNcwVB992w/LLgdJAKo6o6
         v3jsUTZR3TJE7S/LTtmtb3H7+Xo8c8oW9rHEzNfLrWUa7CHpyrWQob4/Rrjywr4Pp4HY
         PZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jfazfgT1k9Ptk0iCQuYriau5Q4HbmvQBJbxmOH+gozk=;
        fh=n2fHE/ISac2yF/O1QaVlCFOwbY9zoVJEuEZDxTMuDj8=;
        b=VFsBYNwjSmdNbDoaLcHqqIxEuh/f25Kee93BYooyXdru9LmE2AHZ2n/JAoZQzbA6f+
         I0cnlFJqOz0vgg8zyLTgqpbZrJfTPLZ91ryn+Dq1sGWZ8g/w6najd3SMxK2xPvA0faVx
         Ds1sH1hNbwNkOSelSR8GNkfLiU6XvvTIbbuB54+065fmuX8HETmm+heEtb0JU/Y8Q2Pk
         Hf6SBSiss4A7kX+Lkp1ccM8NfHceNPygra7LtU1HhIFc31NARVChpdxndlfyq8Uy1bkq
         biQmqgPN5Nux4HYrTKjIbCvjdxUWGJrI2UXN8ZHyxcoTb8oNLNisdO5mCFx4appzwGeZ
         PsZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777421539; x=1778026339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfazfgT1k9Ptk0iCQuYriau5Q4HbmvQBJbxmOH+gozk=;
        b=GOJ6kWr4NB4bxJ4vRtQXv+xtWlmv4xDouoVUhEyfn0wT4lPHPO8qgw3Ws6JhDjKVKY
         vtVdhRLno+T9pGIRTXi0BYvjh6VZqrQVykt0HhTzsCDB5WZyFS6lT3J9kSugxO9tFng/
         T0JFgTqdFzpOS6gR4gJVE/V2ghpblfBBLxnnsPFyIqbc1cDmlZTBVqEfmWySWSDBGwB+
         Vc10pXhSg47CYjfQNXFVicIYpugIylevjY1uwX/R5orga773Pl46pf2646b6nmMq7qeq
         vwg+KN84E4/filKeUlkvrpUI0MoziwS4JIIeMlRnumwu4gPWfm1g14a97YFy8IelwhJn
         SljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421539; x=1778026339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jfazfgT1k9Ptk0iCQuYriau5Q4HbmvQBJbxmOH+gozk=;
        b=a9SztGYcP9ewYIDKCtkyABndc47DGYjWfhqDpk4OgEuc613OiJ16QYPIUZOzSfO6R8
         LFX3joH4J9GrZgp06vKJ7Glpn/spt8OKRLptJs2Doy3Z6y38GQsB/uTEGXnUj9HW5Dnh
         78sA2/q3k0fT9uVZYeRHbelCsvI8MY5ceMlz0DRsB/9wvotxu6bi41oo8/OdRXyClz4d
         Es+Zp6W9vJsMZsbaWpJWJS3Gs5kzT5oIm2jQl98tb7Jux/ttmpkEwGxF02wQm3N4m9lu
         KwIUMNlLQ5T6pFDNMZTUI2N2Ob0u2nfLaEYaftRhFBeJyA9SFdB2+0hsx3XOWPPfxk4A
         Qb+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/g/owbEZLd/t0owxkvr9adjhNnFz5BepByP2GsQXZnBkCBQW5oDvlba+7p+1ndhrW4P8KWgwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7iniTtq/T4pLAAeK228j510Y3OAvyQBdMeWG7eUP4O8Z5Pk/
	3oLzv7Z2L8jksA1ZPOHlZTv0GzfyaFCeWFWhsk2MX5aiYqVEOSpHBjjPfJaFQKWHbnm8X5b+h2s
	vjEedHEtJVseHo4znI/mtdPKjwzUoPfDKYq3jjs6z
X-Gm-Gg: AeBDievEQwfXRVVbid6BpUSYbVhHcWEGudoWFtIoUkbNePUDfqXU67IM71pgtHe8sa2
	f+w70a52wQ+JYK3AO8UjYHrYUczJvPcS68rBEzjyYqgeMqd/tMaviBAr/VnIw/LObaAcNWUUTKo
	qa9+4t3q3oGXVk1K+br4fTkZRm8+lt4rcBIQpn0+HzJN7b57oh/eN5Rh9u+iSrOvsH1qmyodB9o
	3TN2gRK/z3qZaHQmfOzWCgDzUd4vQ8y1Q5z1mm0zqlSnY4kddj2XDuQpfwTK8VodWSKse78EyzB
	pjup0pyNS+U9M/NAsH1ho32EXB/tKSaPKuu76Vpkzely1ZgbWiZrCPJWNEEdugId6UhkV5wDhAx
	PgioRsZtyHpncVgexJ+mD
X-Received: by 2002:a05:622a:1482:b0:50f:39f4:3a2b with SMTP id
 d75a77b69052e-51019b982f1mr15563501cf.41.1777421538474; Tue, 28 Apr 2026
 17:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428205352.1247325-1-kuba@kernel.org> <20260428205352.1247325-2-kuba@kernel.org>
In-Reply-To: <20260428205352.1247325-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 17:12:05 -0700
X-Gm-Features: AVHnY4IAH2MiQPqRWJ1S2ucBreMK_rZLTO4Pn1TEOOfKs_HFSXe-aq2r5Mwwr48
Message-ID: <CANn89i+UV--tk2Jf0TF31uyU6yow-8YZASU7xFRe=oXj6MmyRw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] psp: validate protocol before mutating skb
 in psp_dev_encapsulate()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, willemdebruijn.kernel@gmail.com, 
	daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 170DF48DB7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282149-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 1:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Code checkers / AI scans will complain that we have already modified
> the packet by the time we realize that protocol is not IP.
>
> Move the skb->protocol check to before skb_push()/memmove() so that
> the skb is not left in a corrupted state when the function returns
> false for an unsupported protocol. psp_dev_rcv() follows similar
> pattern.
>
> Today this path is unreachable because both in-tree callers (mlx5 and
> netdevsim) only reach psp_dev_encapsulate() from TCP socket TX paths
> where skb->protocol is always ETH_P_IP or ETH_P_IPV6, and both drop
> the skb on a false return, anyway.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

