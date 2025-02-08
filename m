Return-Path: <netdev+bounces-164295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7FA2D41C
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 06:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491BA7A2C31
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C021F18FC72;
	Sat,  8 Feb 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq/1jmj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5B17BA6
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738993040; cv=none; b=gJB0dtmMBMugpLFwtKoKYNftFZT5P8eR0jHuJHVKfdfw5X8xK5GJFbrapaK6LttrMWTFaCe8dn+EO/Gp41Yx03hPfM79bCr+qUZthQbtfqT7BhqERE00tqQUIloFvVVDC3Spz21EWe9bORN7tZqGNCpPfxqn5Vcdqw2B6T1UolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738993040; c=relaxed/simple;
	bh=Dmwik+s0LJLRCl42O5DNrcOmFaOZ6yrjfT/ldvSmIIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp0jHWUZXkKRxn0ytcuPbaHVMIjPicRpRJyqQ9IQ52vCICw7C1tpzN20x2gUIH4OLQvvtYdZTAKvJfr/39amQY0IvCdU6d9+tQA3UBLZ67FkUXzxnDaHZlz+I5wrK/c/zYTS2RRX2//g8am5Rep7j2PRFcrms0AuFJPmUQvNcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jq/1jmj8; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d149f4c64aso2324115ab.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 21:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738993038; x=1739597838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmwik+s0LJLRCl42O5DNrcOmFaOZ6yrjfT/ldvSmIIA=;
        b=Jq/1jmj8dP+q8DZ0SxUiSC0SPMk1Qz2u6JgvNaHExtlykqj106x2zvOwL4tjsCX+sG
         ZM4XUOmPYhGjaPPHa2+HVWAFhFSwDnPf10qfjbj9KT9cvsLwrWlwIqkIaCWLyLBIPK1q
         gMszwJyhkHMqDZ76FEmky3YaPvwC7/aphozs2bzYuh1sCvY4jt8FqMst0JKJXLSgrS+1
         ErRQeA0B6JXURRKXGi1KRf0UPLPdWiDeGy18+xF9obFowms8MLfUOLKb1DNHHKFI5mU8
         wqTGAP5Znf8c6wFLxttw9OJUuFLRmTkEAo3rtCE71M0t6zc4a63K0C2XRXgC90HgNB89
         17+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738993038; x=1739597838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dmwik+s0LJLRCl42O5DNrcOmFaOZ6yrjfT/ldvSmIIA=;
        b=s6sur2Oy2hUxD+mn3E2AoGncMfdJXFnQU3yADVkeTwTCYmI1c7r/b6Jf2DYgNFpHP1
         Wt8gsb1P/XLYHTbRf5aQgvOpAkdccZduIPEYb+kVmDX2uyEGXHN2cUIAx+rHmG0smZ5d
         fZiqCjE/w19kZJP9WJovuQSCzPx6YBE9fdU86vqWdbxgJxymY/BwmbAL1dr/PIOcM3wD
         V0FUIUbFdX7CA4I4r0eU6W0kt0+WxlnYLpq2xCDBwDbgj0iFLer8UfS31UPzvhACAQJS
         5mHZcRMZAlkBsXVaOGoHBGILOCpie6NzIho91+6EDkEPM3J94gY7K8r9yO8SusuDM9By
         6NKg==
X-Forwarded-Encrypted: i=1; AJvYcCXQSyELqjZageFSV2Ut4/QV0lozxYVcCD6BrArqc7WaZzMX1jv+33R6HjaB5XVsBvxYC2CJr5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRLL9MzdwdFr200hhmFgELyd5cnHQ9Fda6/bLSpySulxCvDwV
	PDOVx/fq2+6oI2SpxzxPhT/v3J2lRLhfEEl1jbRaDNz+We8vBNIuOHkrrsHunJ99AlI4PLmWZMS
	imRSzJm8TIWxsqW1sBtClEDzv3ww=
X-Gm-Gg: ASbGncuigEMo+Z5VZayihoq5GK8fwBLamJR/bhkUnZAjZERUowvST9JI7CfqeMpeuaF
	9g4sx9Ody3fJkZRFniS480QqocTGncnNDKu36zI6Y0hgne4RDCUAy40rg0q/beBbhQFSGA94=
X-Google-Smtp-Source: AGHT+IGcz5/pqE+zykUm3PmsqZwGcveNMO8gO07zSXkzTLURhWjlQNvGSROHICNYV2sJB58U5y5Cne7YgX4+i1/F+WU=
X-Received: by 2002:a05:6e02:20c8:b0:3d0:21aa:a752 with SMTP id
 e9e14a558f8ab-3d13dd2c035mr45966225ab.2.1738993038340; Fri, 07 Feb 2025
 21:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-5-edumazet@google.com>
In-Reply-To: <20250207152830.2527578-5-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Feb 2025 13:36:42 +0800
X-Gm-Features: AWEUYZl0asznsUFHb4Ou6CdnYftJ97llWEHZplw9ymb-_ZUVAO3it28RDcizvl8
Message-ID: <CAL+tcoD8FVYLqJnA0_h1Tc_OeY4eqmrDPQ7wJ22f0LHxSG+zBw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] tcp: add the ability to control max RTO
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:31=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Currently, TCP stack uses a constant (120 seconds)
> to limit the RTO value exponential growth.
>
> Some applications want to set a lower value.
>
> Add TCP_RTO_MAX_MS socket option to set a value (in ms)
> between 1 and 120 seconds.
>
> It is discouraged to change the socket rto max on a live
> socket, as it might lead to unexpected disconnects.
>
> Following patch is adding a netns sysctl to control the
> default value at socket creation time.

I assume a bpf extension could be considered as a follow up patch on
top of the series?

>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

