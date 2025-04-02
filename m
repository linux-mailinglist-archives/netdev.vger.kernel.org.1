Return-Path: <netdev+bounces-178756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1626A78BD6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A123B2614
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3520AF8B;
	Wed,  2 Apr 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz560xVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16C235BF0
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589179; cv=none; b=QWFE/zZUHkeUzXskErs3J6cZmcvx6umhZTq2LOoNaAdNmI8Faegy8wwF3y8kUkJ2dtQao/e852ujZUj7SxS2ehSq7bB3VcJI5Qejd446BdyScb44eKm2Z+5oWu5znJ7JjYdNFxhDmjDvBPryNJRNlo71dsEnBI4gXJ6nhCR/p0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589179; c=relaxed/simple;
	bh=ViF6iYhl2eB4eakbUbVzVkYCtwJo9oT+CjC8y0/1roI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=W/AFN1d0evhYbqKZSkE2ORoqILcp8DF7mn4qDAEaLwVjdSiV7ra/58jS0GLf5svH/gRC65M5SF+OsQEmclxsV8oZiwG7EEU+1XkdVeux2oynZVsbYez4ceP3tVkiBfMP4tdMS0MFbndXQc9guGCeVY/C6wo1D+t1r+lBID6Cly4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz560xVe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c266c1389so953444f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743589176; x=1744193976; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnL5OIZLveuNIEjHEdFTyGrn96dSw2ZkPFEeDjcMAqc=;
        b=Iz560xVeXcK44Zr3et4eOW1Hszp/Sx4uNIY9zHM8g5Uk0qqQqKVMaDPg1NtPVSjb+5
         5YSwufZWcFIoyL/k/UDhc22BLS4pmj0QbucmnVHDleOdoowcjCOC+3czLJLQL7BB2bKJ
         CkY/eLtPV1HX2Ag7PwL1/0J74ZymQTgvciO9Rcb413UovXkjgiFAXx05TUFvLwRk0MSb
         wAo3lbWYcCg/3uVg4TC6BNuo938TQK9WWhV7bKIBxIMwZmZ6JCOK0bK/h3kdvYigyE20
         iVVd8j5G8mq5yO1gA74T/vFT4S6k0lNB3rGypWOgm3nh92pEJAXzGFXe0K5Qxa6DQrmv
         BOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589176; x=1744193976;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnL5OIZLveuNIEjHEdFTyGrn96dSw2ZkPFEeDjcMAqc=;
        b=OFeLCsHLdavRp9dGDeH9xDCm4zUwgH1q2pfpmy5j34oGlEOt/gNBz+FAcCevDtwGyV
         XnMftiE8hRWIhcD4/OmK69UuayNU5i+/6gRaJKwNa/8YZzo07FYkKfWMpwTA2niQGq5z
         /D6yOFbscxHA7gmXJpz/Lw6PgdOneiPg5rT2gTKuI3Ho7uIKy1rThPpdaC4oDH38Erj4
         r2LL34QMlO6a4342rJ+/iOq+oe16peHQugxb0QKULjXaM93OCeORWWNyaRpq/FWVkRjf
         4wwxmh/DPQ8XtdsC7Gj1UTQFMfKvIhR4Qr0qr0o0FeH8SiQd9YZmu410tvdDAJauIHDC
         LT1w==
X-Forwarded-Encrypted: i=1; AJvYcCUVjCWXTEf/mKs6KXrigyQiZND2h3UIpvo054Wci2HajBFsI4mtyRiJ7rIlPV5IzjlQBrI1yWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOUfUH4R3GcoPAU7yeGWwKNsJjpXsvFiIgf9qsKiuPR6OS8t0V
	OFge6hR/h+t7yhQitEBrPwJTkSScYLHebyO6EMZdIp/NRfCayvvi
X-Gm-Gg: ASbGncsgkxZIKfYPrcLhvPyxtHM/xNmwVttLeSHnNPIIRMb+5Pg1GZUfs2atQQNqLE1
	w03javHIuCeQiN1kAQicyivKMAWaGFlO1q0Z33qVeSauhMtOzWL9KK0ok5N7ILGa71XeMpugn34
	VnlU1za9m/IwANYe6v/iVvlp675nOLPmZXoQJSnUKgimi1ZjTmqFM395tGJhfyzH3H3MCBVH9Pb
	F0CKsZ/xYIkR8NRHjynR9ggmS3LPCnlt6FIJB6+NbHOQhWQ4DGFyDlYXOjt7T3nujkicblXxh0U
	RZJYoZeRKIYKxx+OaDTHcfjWX6FJzBlTlGMu3Dx58K9J+Fh810ZnQu3TCQ==
X-Google-Smtp-Source: AGHT+IFVGNp11J+YdHOamu0DFZ1P3NGwuXw5RndMZ+h1Ucy6JdSgZDyEkFqa2MoClxpA/fZk5rrq5w==
X-Received: by 2002:a5d:6d85:0:b0:391:2dea:c984 with SMTP id ffacd0b85a97d-39c120ca4a0mr12789435f8f.11.1743589176352;
        Wed, 02 Apr 2025 03:19:36 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:15dc:40df:e712:c569])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb60cd354sm16066225e9.18.2025.04.02.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 03:19:35 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  yuyanghuang@google.com,  jacob.e.keller@intel.com
Subject: Re: [PATCH net v2 3/3] netlink: specs: rt_addr: pull the ifa-
 prefix out of the names
In-Reply-To: <20250402010300.2399363-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Tue, 1 Apr 2025 18:03:00 -0700")
Date: Wed, 02 Apr 2025 11:17:57 +0100
Message-ID: <m2tt76hnoq.fsf@gmail.com>
References: <20250402010300.2399363-1-kuba@kernel.org>
	<20250402010300.2399363-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> YAML specs don't normally include the C prefix name in the name
> of the YAML attr. Remove the ifa- prefix from all attributes
> in addr-attrs and specify name-prefix instead.
>
> This is a bit risky, hopefully there aren't many users out there.
>
> Fixes: dfb0f7d9d979 ("doc/netlink: Add spec for rt addr messages")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/rt_addr.yaml | 41 ++++++++++++------------
>  tools/testing/selftests/net/rtnetlink.py |  2 +-
>  2 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/netlink/specs/rt_addr.yaml b/Documentation/netlink/specs/rt_addr.yaml
> index 1650dc3f091a..d032562d1240 100644
> --- a/Documentation/netlink/specs/rt_addr.yaml
> +++ b/Documentation/netlink/specs/rt_addr.yaml
> @@ -78,45 +78,46 @@ protonum: 0
>  attribute-sets:
>    -
>      name: addr-attrs
> +    name-prefix: ifa-
>      attributes:
>        -
> -        name: ifa-address
> +        name: address
>          type: binary
>          display-hint: ipv4
>        -
> -        name: ifa-local
> +        name: local
>          type: binary
>          display-hint: ipv4
>        -
> -        name: ifa-label
> +        name: label
>          type: string
>        -
> -        name: ifa-broadcast
> +        name: broadcast
>          type: binary
>          display-hint: ipv4
>        -
> -        name: ifa-anycast
> +        name: anycast
>          type: binary
>        -
> -        name: ifa-cacheinfo
> +        name: cacheinfo
>          type: binary
> -        struct: ifa-cacheinfo
> +        struct: cacheinfo

The struct is still called ifa-cacheinfo so this breaks:

Error decoding 'cacheinfo' from 'addr-attrs'
Traceback (most recent call last):
...
  File "/home/donaldh/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 846, in _decode_struct
    members = self.consts[name].members
              ~~~~~~~~~~~^^^^^^
KeyError: 'cacheinfo'

