Return-Path: <netdev+bounces-224157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6468FB81516
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447DB7B71BE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35083002C7;
	Wed, 17 Sep 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oohYncwJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F93009F2
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132925; cv=none; b=vGojLcJ6Nhtpz9cP1UWClpcwMHSscK3D5rChc8F2UaNN/SoRGiQVWofPCEQpcUECgue3VcSpT1ywjw7RH0Ua1ndR0/3umdCZh7YKk+E/feXbNt7j+uXg2fw/Zn7SbLUalSfUH+8AuFszINKke4bgcJdahCtfxf4ZOMSeOVr23ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132925; c=relaxed/simple;
	bh=DVjuYB/N7iWTxMLFDN3D7DenJVzTOvW/I6Cz2f1ytf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9IuS93PS59tkZIkkZfEnx6OesICIU8+4aQzFTQcb3i4Fh9neiSig6vUGl8IJhXoQ5TmjG5avHCj11W9yQQpOVTy9dcKIOp4Ui/sigiHwRBgAjRo+9iXfj8pZdBmsyZzi2lv9/gQthWR0dvbEPT0TMxFF7vm2sJJH/EV5yL76Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oohYncwJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26060bcc5c8so1013575ad.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758132923; x=1758737723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVjuYB/N7iWTxMLFDN3D7DenJVzTOvW/I6Cz2f1ytf4=;
        b=oohYncwJa/lmxjyYb13Hr0IqULyUwZxyrUdkATk+XIxYg/8nokZKfiOsXIgWXVz/cj
         j8G1nWLR+oczOX4axBt2mf5PBm0/kpv1I50eSiMzJ3VsUo++Lzv57iBqS5Y/iKOOoePF
         /CMeo8mz+/8oWVjCqQlyFW7zRSqWLrTkmJdWVBNL/JFzR76o9PfLuH1yjdLTNjwJHnMO
         HrW2t7cn1T3+cYk2yqRL6mO+TyxGF6KHGqbXjBbl6aKf5pDHP2fjpiI6Em+VT/Hkz3hL
         eRLF0+D3esX8Puh7MIISQR/yF3kw/YJRizEIRRQMXx0gXjw3fHX6o5fGyS+1sqaS0bCM
         YqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132923; x=1758737723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVjuYB/N7iWTxMLFDN3D7DenJVzTOvW/I6Cz2f1ytf4=;
        b=DVHrzkVMC9wuWCoJRp9yvqYYFeHavTdNYvWlDDHemHaBRxWLPwE44lGUzUNES76nuY
         Aw6hcPELe9vFBWAEx2Vtlrp/5yGNPhvTDJ3Spl67an8Jsf+1+w8uOlG/dhPcx5pDi/ii
         ThP7zGzEcNKosX0AduwUh3b1uhyBF5426vMj8My2av0T9S+3A8oHtYzyoqKBhgtQ3nxK
         FfmGb6XqpwqyebZp7KLgpMT0bU7pLp+nk+FypUiM23vkC7lNuwE3SJ+yB2X69uPyXPds
         z+dcOjSjE+8I6wuJ6yljHkULo4o9mYZwFrJhkxKbEn/PldYClpJ/XZgzlOlb3RMOaWex
         8/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRIa3XzCi3cbRA2AFWGub884S4lsakZY6FHPkQIHhmc4Y+XbYyb42/yHiOhXE9ePejSU+q1kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkEgqICwG+W44aP08GNuXyHk0ENZrUTbLzK7/MJPngPb/uM7T
	pu4McfkFzSfytaNmqmqTgjwxV2zv6N10O+JjuVZXZRTFsKZszEENz/aFFgvbQGZBUvbffb9vBlc
	7xXgyeBZT32y+XVCfh44rOAKv5aL88F1OemU+g+Xg
X-Gm-Gg: ASbGnct2pa1n4YP+l0cOCAbLrzJ4qw5pmEA+y04skxICsWM96eQLyvEZdT2aXsyOC8h
	DiaAG8NQ7t5TULv4++eoQiyzUK2HHtxIbvrR8kVruQXWolYKToe2rwWv4wWxbkZScOTQSG+YZ5c
	O/zZH82Nb4MA++iLgSO6R0uPUmXt4iwosX1sR9PLlYetUURitPpZhMoShmGI6DxYcKH8aaIV1U0
	ooCSNz0DpI2484IAJqCrrYIJJYzAiQncIyCAIhXqOWjtQqQ3zdPx7s=
X-Google-Smtp-Source: AGHT+IGmmK8CTuDphAXtPFbDoKnGXSBVwVMDJVsOZTUDgRdXJck8eE6s+AepyQ44rx9mqfao3qAyaErWWrW8MycKArY=
X-Received: by 2002:a17:902:f786:b0:24c:99bd:52bb with SMTP id
 d9443c01a7336-268137f2882mr40139505ad.30.1758132923201; Wed, 17 Sep 2025
 11:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-10-edumazet@google.com>
In-Reply-To: <20250916160951.541279-10-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 11:15:12 -0700
X-Gm-Features: AS18NWDxZV_xSoCu1qhdiiyTiUPF-7DusJHrrC2cl1n9TULQ19KRtEKCR-BUIEw
Message-ID: <CAAVpQUDhcqmw=-sVOdw5Bc7kPkFm2OdfVD_9EgQ_LHVhmWZfUQ@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] udp: make busylock per socket
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> While having all spinlocks packed into an array was a space saver,
> this also caused NUMA imbalance and hash collisions.
>
> UDPv6 socket size becomes 1600 after this patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

