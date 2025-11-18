Return-Path: <netdev+bounces-239379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC19C6749F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7F8C367A53
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFAD27511A;
	Tue, 18 Nov 2025 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHBOi+LR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868EA26B0A9
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440772; cv=none; b=OyuaCofzB6KwxoENosWzuxBSXo0MG27KDBKpmESihi1muM7hUObFbtNbzTDh/oghJif8jGPqBfogsOSNlYqs5gewRnrhMIbsjshNYHqbiIJeQUhmH104MWzFd6ak690gmpaxbayJ4lQqffL2GqXimEImwmVpnsDF2VoCXQci4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440772; c=relaxed/simple;
	bh=sht+6c+eyM2WHyrmniBSSqWA8VcFptmw94EOHWE4Q2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ5Sug/W3UNWBVuUvwvXCirBu8xgUqcxfg5a6jmlzwwW5S4pw7V2eoe3uc8syAObvNy0XFStQfGkygvY8pnVZWTtI69+j65A3trG+kkqCF2XLf9w8Dzqe7N/lhCnOpdmyr6kbZUL/+CQObKYCxDZDQxjy2kmoWkOKJDebmKJNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHBOi+LR; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b55517e74e3so4008048a12.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 20:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763440771; x=1764045571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sht+6c+eyM2WHyrmniBSSqWA8VcFptmw94EOHWE4Q2Q=;
        b=jHBOi+LRd7x7dYkydrB4/ND9QDAP9QQmx993nYbMppmLKsu2b0zs9YdTKCfbxSY07O
         8dqgV+9yzeVxohQhNfVEe9LLWak/cMI4kKOkmtoGzKQNcb7zQX0LPNscC4tPrvIQXQj6
         dWWI4Xyj9uvtcQGZWBICGsRFuhSO9MTvK8BlEl9XTyD3N7AnjAX5BgL8fChATHGpRPI9
         LBkg5Yuf5id+5dujDxd0EXaiLrzHFqZWfjZgPm0JSZV+uwE5WSc0GVLgBaVCxO6lcDfR
         +vkt7IRL7sBiqiOk2/FaKCPLOHMR7e2K6Yx9xcckAKHqIZRINpA00+5pz62tRxZV5u3f
         ltfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763440771; x=1764045571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sht+6c+eyM2WHyrmniBSSqWA8VcFptmw94EOHWE4Q2Q=;
        b=VwzDjjRYRD7ziu2y8A5D0rGLqR3Ahu50RAwDShX21MaXz5L8QjXaL4NNBrp2V/kogp
         o81K74pDIf79LHb+kt56tjdG3WIhNmErBIzhJKgPN6N5UyvJbGljE7K2RdJlALP1p0Ki
         sJzMPX2OUFOS3vYAMdrcgkx0SlrHiF86gD+oVh70UjlstgI3Rx1FwMT/iJ32RGybluyK
         De2w7h8WdB+K+jyeBawKfuOqyXNQLFUj0rfQyBIpRqvtNfRTUTgvTSEtq87ySJuZuwP+
         sU1UwmEr7PIB7rUNcPllBsWgtBquJf0cMAW+YuEDpjMRLiVDpu3DFeaig+F5bZnfpjrC
         AJzg==
X-Forwarded-Encrypted: i=1; AJvYcCVbWi6iFOwTc1+5ByxYPxP2/Yf0wioaEJbFTSFOXsZi8waTKMCZzZBO4Orgs0fMjyvKNsaLPME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9ZIENqeMgQGPZYJmhflUvHTpalUjjQ2edhMkQRbnD+oROiij
	Dj9G+GCgubvd2Ydb1LprNJjncyHE/IA/T7Jecb0xh3yWCtyfY6Q9ZB9R09OvWNrctrKPOv0ibeR
	ItBGDrsIbov9CAog762rCz82+VT+Sn++ZBs95fvgY
X-Gm-Gg: ASbGnctzwDptFEn4VOtoatBW4UYYRe4hVAphavMzDngvc5DtqCPWBL0X9vM824zdN84
	d1hyPfdJ6DxJC3RrODtQvnW5PFyoRTA4XC/NDfBTGug1CEee7fsxJaWsenMa7s695hzBHjK6b4D
	UL457TYIodEcRLD6+1c9cgax+H+6mnldQNpTtEieiYsfnzHczpvCYZvb+6cloeyhFpD2GBqQBxL
	0aegt4AyRxV5AInXZA/ju36BvYWjR+CQF/iZv6SijP0mSx7MYzDHBwFIBS+X18Y0AMZlmbagD0L
	3jZ1Un/oo55THmOyHJGc9UM95Uoc4rb9Ln7XUQ==
X-Google-Smtp-Source: AGHT+IELkacdFuqAIIdL/ogR4ZRbNK9ouk7ZKrQXfCqqu2U0IjNMABkYgSvcRtcJ/M81kRPiqzOU/3oFeFVpBRBk3K8=
X-Received: by 2002:a05:7022:e2a:b0:11b:a892:80b4 with SMTP id
 a92af1059eb24-11ba89283e7mr4588494c88.5.1763440770383; Mon, 17 Nov 2025
 20:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117132802.2083206-1-edumazet@google.com> <20251117132802.2083206-3-edumazet@google.com>
In-Reply-To: <20251117132802.2083206-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 17 Nov 2025 20:39:18 -0800
X-Gm-Features: AWmQ_bnzQPU60YztqI_DwCtL9ioUwBYJ3SUafRTqpBwFcXUDJNS3bjcEfJU4Y-E
Message-ID: <CAAVpQUBCCfzip0tgzu4Mc6MNiH6J-9aKk0dchC1Ox6NRarq_pw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add net.ipv4.tcp_rtt_threshold sysctl
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:28=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This is a follow up of commit aa251c84636c ("tcp: fix too slow
> tcp_rcvbuf_grow() action") which brought again the issue that I tried
> to fix in commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot")
>
> We also recently increased tcp_rmem[2] to 32 MB in commit 572be9bf9d0d
> ("tcp: increase tcp_rmem[2] to 32 MB")
>
> Idea of this patch is to not let tcp_rcvbuf_grow() grow sk->sk_rcvbuf
> too fast for small RTT flows. If sk->sk_rcvbuf is too big, this can
> force NIC driver to not recycle pages from the page pool, and also
> can cause cache evictions for DDIO enabled cpus/NIC, as receivers
> are usually slower than senders.
>
> Add net.ipv4.tcp_rtt_threshold sysctl, set by default to 1000 usec (1 ms)
> If RTT if smaller than the sysctl value, use the RTT/tcp_rtt_threshold
> ratio to control sk_rcvbuf inflation.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

