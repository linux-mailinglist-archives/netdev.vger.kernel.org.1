Return-Path: <netdev+bounces-224150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70074B81432
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7263A0340
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A42882B2;
	Wed, 17 Sep 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNvIB9Iw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B01C84C0
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131851; cv=none; b=s2O9/KKztWmkGXlJ6TYG33CmTQP3aJr6AEpQg9zC+PmhnRZpRxNnZ2YwGJ83xl+pW8LoVt9XxzVmL014k1vcOHyVUXXNtj0/nCl/puCKey0q2TkFp2W7QiHemSXXjLxRbseeptzkb1B73dtzowfg1sBuxSzMJ/y5cE/twy7ItlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131851; c=relaxed/simple;
	bh=h1s4eAITv1xfGNdaV4ivqleRvG8t6ZtrMq1KFDs99yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML6iPRltDRTkv6VZf2lM4xlRq36WuhI2vwQJlkNX5NnOm7ERVII64xY2UmJIY2USS+Ap8TKuYAql74wJDEq2+RfDfu43C4OKguoVaqB8mC2XelbtTrrzOH0GUFa3tfK6sdJzSsgQos9QAhSkJWfeZdr4HnHA8L68FFl6ZqC7sYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNvIB9Iw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54ff31192aso55118a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758131849; x=1758736649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1s4eAITv1xfGNdaV4ivqleRvG8t6ZtrMq1KFDs99yQ=;
        b=BNvIB9Iwk4pdRNxdya09wyIaPHPDsCfaRAxqo6wFW4Su1+cmeaHfTdXtENY/lO9xsv
         ALjwEMdOSipM8YeS0xwxblTYJP2i40V10A6D7AD6X1qe5A+htReuMZ5e6HWaie2TYxbF
         KaSdarpA8FxRoawA+uX4vzeo2dPW3Zl5Nr5AM3gEi65l3sPvRHO1+Ozz4yQDxzxY95HY
         VXUc02PHPFashe705JMAiM93UEo+XEFTNZIT79cpKIazPDGtOEuPvhpjlJpTJpO2HhCS
         +Pt4ujhamUkgFpw2avrd+KFQ92aMKWW/vy/t2lN21d40c9x7Pnh2FfBdXKDvAEBbqCtX
         /wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758131849; x=1758736649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1s4eAITv1xfGNdaV4ivqleRvG8t6ZtrMq1KFDs99yQ=;
        b=AeL0bICSR8X1JIrWR8hJY8I8NsoRxrhqGDwKBzHhz23QNU+mvqI2SAnmFNeben9+k8
         6olilbetB8e8YBj5CL6ATGvz8l2xsVnBxwBWSmmRzpE57F6xTWcE1UyL+xZj+W1MRpSx
         Z3kLs0J4l45q7n/4rzNs5mKfZskwaOKIi/J4l2goHJ8NNAJXb3O2g6vUZIuS+esFawYS
         PCxUXH7U26dgLWu4ar1WflECW+a2CB+ZUG09G7BfmGzTV0ug9I8zcIAVZxAMsZPQmvM6
         /g9duUiTUl9HVU2cWjOqggf36ZF98rYMXtXg2NNkJ8ArrBfmIXONQzu0beDNhpqpR7Sn
         GJmg==
X-Forwarded-Encrypted: i=1; AJvYcCX1i3jyIQauG2iEqk7C/BBVNUvRXPotCx2zPrXZBweoWorRgIfRz2Wal5K9VDgSHzTrzpKbXkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcILZIunz4QKg5r7s0wlbUCdEXTfiGqM28R+szOwv0Su1AMcsZ
	v5Y+EFXpbSfBrjRORlNXabrm+zFzyMJN+H2NlCuqmvYIXatDZpYlXy6loEhj3LEeCBm2fhZrums
	wie2n9K9vlch2aOydeIqQKrf8ByTpaFNq4MbhYtNQ
X-Gm-Gg: ASbGncvKcCWKIi4S4gYs214MlI/N24x44QCweKaFT7Kc+vCMqQDPGj9li9rs0D+e6q9
	s1w96LJI51d7+DmXnu9XVvPO+iuQW/c5DqtGj+Ug5pPUypT9dayhmTnb7AsUaRBef0gsyuvoNYt
	TEn2T3qHR9swq5qxFt0nDrTOYQ1as5tA6TKKoL/o0dIIMyiNiqBjr7VshH0tjjOrQv+ianTUJn0
	7RDtkIuH0N0CS3f9RMCHoXzFHSHXcAzmaObGWsbnpRK
X-Google-Smtp-Source: AGHT+IFBdmJBb3RFilH5jPEFbL26M2EMQydr1O77fOiKxgpSFSHLRDJFRg0MW2Tcs5Uax72AG43klc9Yj4YiIr5qSMI=
X-Received: by 2002:a17:903:990:b0:24c:829a:ee4a with SMTP id
 d9443c01a7336-268121944femr50190615ad.17.1758131848923; Wed, 17 Sep 2025
 10:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-3-edumazet@google.com>
In-Reply-To: <20250916160951.541279-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 10:57:17 -0700
X-Gm-Features: AS18NWBsqgkbZWLx8-0okFM0k6j3TkJOC1o9-17b0Ho_SGJS-_HgqvHJWO9NWD8
Message-ID: <CAAVpQUBQ2t2c8Zuw+NznbN4BcLDQM_qqnc2k48WHafEyxXfY-A@mail.gmail.com>
Subject: Re: [PATCH net-next 02/10] ipv6: make ipv6_pinfo.daddr_cache a boolean
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:09=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> ipv6_pinfo.daddr_cache is either NULL or &sk->sk_v6_daddr
>
> We do not need 8 bytes, a boolean is enough.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

