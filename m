Return-Path: <netdev+bounces-216038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA54B31A4D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D58189D093
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10EA2D7DC6;
	Fri, 22 Aug 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NBIoQOh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCD284B4E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870719; cv=none; b=u+0QSR9yMqHN9eSas4STJ+qO9VUEgmZq3J2jF9sxpsxdn4uBqJDIMgQ8m71kDhBeEp/Rsf7gsPrkI/pEjQpihvOhO46rlB/lHS1sKnft5F2PgEhVVR8dUnsgfe4eHomLLTFlGof9bL2mJA+QfnH1wsfUcnd1XmYy8sTY3phOG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870719; c=relaxed/simple;
	bh=Cf1ZcmbInpTJH8367sd6Tu2DGzrZ/JQfIODMtKJQUK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK4BSkm9sMohZXesXzSc3lrOW0OuV3J+mVclr4rTL5Ad/+XxjwlWJgeEUPcqEBY/K/Nbd5c1UGFTj5X/VOqOGLboXOAsSW4LSrEPZD2xCeQGsMPOb3UmG3a26Hc5/jJCa6M/6FUGyUrAsIPSnGWphfrI8oKsb0Pb//gUzeCR/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NBIoQOh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b29b714f8cso273851cf.1
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755870717; x=1756475517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf1ZcmbInpTJH8367sd6Tu2DGzrZ/JQfIODMtKJQUK8=;
        b=2NBIoQOh9N9t8VjEKphY/IpECOrsEZbYmZS0b6QPWnITGv/6cKKjBwy1W8eJSb5Yue
         BE0rUJu7QjLwQb1lIeLvtIxef1MFd4KxRP/00UdUTjDc4OGRmicLB9s9dQW+MryVh/tV
         CZ4vwor/kgHOlfcyf6nUjcBCR6sn14pqHtI7o3XjSaDIBz69cwk5ESfepbRIR4vYqMIn
         xgRXnnCIsgfeijQlQSB6adi7br4pKQ+fzIFq2fUx4zAiUVn8hMvS0vxIMRm7vN1H1RWJ
         1tNg8U4tcknHOLJ7m1BOklKptydm6uwkJOLQRNpX9HWHuWOvUwhZ0gab7LT8HvMlkC1N
         fOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755870717; x=1756475517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf1ZcmbInpTJH8367sd6Tu2DGzrZ/JQfIODMtKJQUK8=;
        b=nz5Z4u1ufAu25A+fgUY2rVV7JfcIzzcS4fHYZvk67IPNXChBePYn6jvwh+SqoiuhbX
         vkWuL6UzL5XJ5XsQgMbJlTNxHoS6JWjcGpupl/VmesVICB2jPTk639OSO8VLO1lbIZs6
         0HWCG1ff8zyWgpumbBG7dM45jOPlOAxqYqW6x0YGf5zDQQTOfiyjk8UjpY7Nc7+GORQS
         hXnBF8EANQh9Cccqc0AkCiJUT0slAbKrRufmVPhdJEeJ8nA4en8bVlHwm/5f6QFQlTZj
         F4ImM8UAjvkMy4tekj+cPbzBQKHZ8LZx34WiE3zomsSDL5Dm4VLNPtBp7o59b30Bm8DZ
         a4/w==
X-Forwarded-Encrypted: i=1; AJvYcCXR48uqmz+Cnko++SZLuznkz4cmUQpiIfhKSXUtp9AjK8vWK/mezpkNErvTQqhJ6/CpZEtwYf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mLs7do35vweE50StIJSMp/kmHXON1Vl09EKt2lYjgMVO41XE
	E/QCILx7zJe2fryIoBUhT6rO/bcgy1msmkNx047JQ+W109bCp+z6QM2UHE0JxsdIGBFikEVBmmX
	3wdyQ1Oj7fSWInmpVmrZr0Fv5rHjSJ/bqWF1ZFhin
X-Gm-Gg: ASbGncu+kZMIANjpuWb6Gb0D+Zrj6C43JBbqsjMuDhdMJcd5g7zypLkCz7GyOeMGWZL
	n6DGxBhfcOlbG6vpATbMaEbvMygUGd7+3mq91SYrBHdJJvJoJrpIMKsjxKJ4XYJ6tbRWc5VIxRB
	39Eij/XMFF8KWs/OMjWXX9hDkinoUL9drSnDKO7m2tqdcpQhd5nKWWqvCnDSaJJvY+3hiQwaDkw
	PBYp0TVtt0zKA==
X-Google-Smtp-Source: AGHT+IGu1ycjiuNUi1uNsxrSmly/Ob+YVOkAEljPpRoDNUBJ9M9Kxol0DtTMbBrl4Nuq/FoyNvqg4MEqa5kPhvLuoxs=
X-Received: by 2002:ac8:5a12:0:b0:4ae:d2cc:ad51 with SMTP id
 d75a77b69052e-4b2ac480b09mr4918191cf.1.1755870716728; Fri, 22 Aug 2025
 06:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822091727.835869-1-edumazet@google.com> <20250822091727.835869-2-edumazet@google.com>
In-Reply-To: <20250822091727.835869-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 22 Aug 2025 09:51:39 -0400
X-Gm-Features: Ac12FXwIANL-DxhSXaNRcl81kEURWycsjKWIZ3O4ZSZX5GhUrQzOU_n02e2xG5A
Message-ID: <CADVnQyn68JCe4cqRpXjHg4jKV285JAReZEqxtc+_vuT-248y5A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: annotate data-races around icsk->icsk_retransmits
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:17=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> icsk->icsk_retransmits is read locklessly from inet_sk_diag_fill(),
> tcp_get_timestamping_opt_stats, get_tcp4_sock() and get_tcp6_sock().
>
> Add corresponding READ_ONCE()/WRITE_ONCE() annotations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

