Return-Path: <netdev+bounces-235228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73462C2DEC3
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 20:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1713A719C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 19:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15FF32038B;
	Mon,  3 Nov 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAdLwYPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E97314D1A
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198919; cv=none; b=tY52ryltYvXEpMUmpZ9mJcvgeLss5jH0TTjz0Dik06KpBlNGxMxGm5BQDgSbcDG+aqmFEJ1nyUxM2ALmvCKmhzBC99/+d1vZr9U1HX/s9EOQJ/FzFxbBLD1GShshT6pZBW3grzvQxeShsE3IxTNL/5srOKiYmCN5UJ3Chu4BH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198919; c=relaxed/simple;
	bh=ytOAUmNRkyNrb+8SNM2LQjWX8qc1SfKmf5XVP7jIKcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw+P3W1ci82kOHvXHjqPoPqoseQE7577ibUbqiUFnern7L72fJMEIfRqPcpcss4vS86OOHtGYlx/rhP/qyONxVtfmxjxXKrLGdl5zD6Qa8cGRjOlt5EqURNcBCnbPMam921/dXtQ1WCv0b1yTBG1YOq7pWHcln3NVCLKj/Mg+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAdLwYPM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3402942e79cso6733048a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762198917; x=1762803717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RbFOj80zs/7n03tE8N1wEZb2vM09ZvVsc7QoNx1ezY=;
        b=SAdLwYPMVlamNqGleD5GADzeZti3STqcp1hg3KPkwHcWqbWRmapVv1qUphJv4+chTe
         IsqapZOkAYB8wg/emd8YLxsHAyweMz+h0mfCLmgqUpjWw+x1qeAsEj9D6D2GxIbr6BYC
         s6fOmVFOdTpv7qYbBWR6uTXPB+sB6N8vcBnjgPIj8ilLW0McyHdtHwmY276gwBLvSfFM
         4KFow4Kqi3sGYcrnIRmzo0Gv08mjwMI7+8U/Wngr8xGgKte4EwbNkBZK7GlHJWv+8iW/
         6JnUH3wz/9dJhFTYD4eD57SNrKAqYIKC+rrqdLK+75G+8K5vduiHp8Ebc0i4qVnO/bTV
         qpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762198917; x=1762803717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RbFOj80zs/7n03tE8N1wEZb2vM09ZvVsc7QoNx1ezY=;
        b=nIRH75g1y4fN7kpsG5H6fGERM49tUk07NRCI8NNKvTyFsfCVwDyveNaM/01ZWkSoKI
         +jsiilOv+Syb336//7pFjpfp3frVSlN/0NsTusCkliwoQAAvHTDTVSMWzUgJVj1g78am
         cC4bNadmZoikNd/ATbtxSlRxILSB669qdhYUcmDs6dqNhI6tjr2/biU7etTl7Q0UVup6
         yndRAD7beSefIUuL2VDwIAbYOFPXuejkd9lUXuyHukEVBb9qquiVFX448/LB8JKdkKD8
         sJb0ospR6QBHHZovqlp/ljvTZIsAfY+YSiAKfQptOskYS5yKLlz8/4mfAXlrBeMJqbtT
         6P6A==
X-Forwarded-Encrypted: i=1; AJvYcCWLX/okW6BAHUdGMhbqMtMlbkb2Qy7UzGjtZDxud3iC83OppGqK1wYJeyCvuOt4irimfhwV60g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUpT1NpVZ2c6ntR5su3ugWE05WHMOO3t+humd8N3FU+UudDIB
	cwL0lO4euzaknrv4lnMfgaWLmY0Zx2YxpZhpKDVAzv+HoRvblQnu349MoaOWhdfxZSq4HcGF6qL
	YDchckerexJ9ZsT7fHPzPL3Pragdm2sY=
X-Gm-Gg: ASbGncuD0Cj7G1L5RJGh285mtw3Imc/h9QYkJvxEPrvFzUBwrcP3zp4LHWb3Ex+ejQq
	nevrOT+fcVBYtojj3pjOie/7YBOUBQamW61uJ8sRFIGhdDVFeDU+YcWmGS9mCqopLlYztw8RaX3
	RggyFAE9y4Aqd3pBwqONwMRl8U3aeKdTgbGoVtAWqhqhT/8a915r5pD7XJ3Qa18zeBml5mc/h0m
	P27FHEEXvdLryS4lDs7VmYVGOeHsSr2sJAM5E4VCD5nqy+V90qUGq+E6rxVfYGCv2Fi0r0=
X-Google-Smtp-Source: AGHT+IFF702hXzMq3F2a8uGm8E60svn1HEyf0oLw6pQ2hliT+hDxZq38YemBD8AMk5LJLMgs3f8KaJ09KIEXyWShNJM=
X-Received: by 2002:a17:90b:38d0:b0:341:25a:ad4 with SMTP id
 98e67ed59e1d1-341025a122fmr7788990a91.37.1762198917347; Mon, 03 Nov 2025
 11:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Nov 2025 14:41:45 -0500
X-Gm-Features: AWmQ_bnY9CHWjDcwZC0Iq3uTXqVqXa1nB6j2AnO1OSN-u6hNqbFa3oymkdmy2U4
Message-ID: <CADvbK_cFoj7Y81dGTmBzY4BOyZrkdoSa37zkeavRy4gaMEKRwg@mail.gmail.com>
Subject: Re: [PATCH net v3 0/3] Fix SCTP diag locking issues
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:15=E2=80=AFPM Stefan Wiehler
<stefan.wiehler@nokia.com> wrote:
>
> - Hold RCU read lock while iterating over address list in
>   inet_diag_msg_sctpaddrs_fill()
> - Prevent TOCTOU out-of-bounds write
> - Hold sock lock while iterating over address list in sctp_sock_dump_one(=
)
>
> v3:
> - Elaborate on TOCTOU call path
> - Merge 3 patches into series
> v2:
> - Add changelog and credit, release sock lock in ENOMEM error path:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027102541.232=
0627-2-stefan.wiehler@nokia.com/
> - Add changelog and credit:
>   https://patchwork.kernel.org/project/netdevbpf/patch/20251027101328.231=
2025-2-stefan.wiehler@nokia.com/
> v1:
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251023191807.740=
06-2-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027084835.225=
7860-1-stefan.wiehler@nokia.com/
> - https://patchwork.kernel.org/project/netdevbpf/patch/20251027085007.225=
9265-1-stefan.wiehler@nokia.com/
>
> Stefan Wiehler (3):
>   sctp: Hold RCU read lock while iterating over address list
>   sctp: Prevent TOCTOU out-of-bounds write
>   sctp: Hold sock lock while iterating over address list
>
Series
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks.

