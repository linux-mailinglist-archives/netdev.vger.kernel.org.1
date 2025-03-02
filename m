Return-Path: <netdev+bounces-170988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25FA4AE96
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 01:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833251894272
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 00:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2AB79FD;
	Sun,  2 Mar 2025 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRP4kijC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1F1876
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740874640; cv=none; b=dSsKrxUHcmlH2A9/BAfyCa0O/etocEb2VfVWKLFBRMbE+O9AXyOsg/OmX9gq32degBMNnlUIQ8KGalu90Ramq/qkDsa5rmQA7CB8uGKwFb09vCkzJ+EM54+EesFt5kNrZSpzy5GOS8oNg3CpRnhkP3RwWDkWOS1ecN8Tsft6C0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740874640; c=relaxed/simple;
	bh=NCsYyW68hfXnq39+4mpgdXk7WxUfSx5NbM+VRqN9/Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kp1M335g6KLECKajnwss6D+bIonQwowWSZ/rCKm5DToHW9lKCuAuQoUdvjrTtzkRDBiAm0XqCluzsjah/L4b6V28axjNbmQDyCJuFQUJUM9tvyZ8wwReG1GX4BAfEw4f+r0MsU6M3mkhTv8m1CmkUX4A5wqbt0TEUir3nOUI+h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRP4kijC; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-855a8275758so102180039f.3
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 16:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740874638; x=1741479438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCsYyW68hfXnq39+4mpgdXk7WxUfSx5NbM+VRqN9/Tw=;
        b=cRP4kijCbxlhfQJ82Xomb68OFnYIJTdysp075ZQXGJBhnhKfzDMA1I/s/ZWcTHHfnz
         1M5xxvvEhg/hs50M1GkiC6MiMgxXeIwO4qhxfxz2dg8IPW9x5WY1DaOvNR4EBQeSAeVc
         M1yzJoYBGazsTTW7cgJFj0Obp4nXKD27m6g2Mt/GEcBTh438WjixbWRCcXxU+guIp/y3
         ZkTbt22r947EQKJv8sRxhp/D9LHtHPkMMrsLPRIAN7k0QUMKmALzzDdVvgUoQQS2jMGk
         mK/G3ztBBkxNeLUwl1sZwHpRuT4f3QTqj5t0yzVj41G70O7rVKm5qSYkCMeyvq/S8e4g
         1+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740874638; x=1741479438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCsYyW68hfXnq39+4mpgdXk7WxUfSx5NbM+VRqN9/Tw=;
        b=ZzVPyHZQqXKg3VA6F/IQUm1NqUgZfwruAsDxa+iEisOYjilkHPCDZCcqWXHe1K9Kkv
         FV/X1fpCl0d1MaYqPw/VpX+DCIKuFKEmhhZ5VRQgNz/e/4kU2481khU/PLH7p2vl4jTb
         I8ODC4Z5Sj382I2MGODNR4ArGKCEi0A15K6GmXs7VDe1xB+BYbRHEG2D1B3d1K3euA9+
         c9RDtIyh8pOBf9nCEaOOMyRVS5YNfLkAOJhyH4BuvoHwUGtX/fEU9zo8EspsnOLViWFM
         bUt1sKD2IvPu7iVHa/QLz9oHvthMoir3bdv4JG2omjibjASX7gtqb0TasI5n/pFmDtoC
         UzmA==
X-Forwarded-Encrypted: i=1; AJvYcCXE/p6O3/Hwt42/50cODaA/vkpBlP2tYyMyccso51MmXU/JyLuHwCp6rmnhyGEoFtF048hPDyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWp5yabF2/hjYu8XVbmm+wZUwWEc5Dx8PWVq3Sp70RXSZCSDVd
	EuUxDONHN9cQF1AscFWm/IEU6fOS6J/kcgScYwpHLRTN4Zgvhk437kil7yEonZHi7evgaQQl9gh
	ZsSHJguVm937XPIhKxYn48q6CfYk=
X-Gm-Gg: ASbGncsnr65s3J3EyVc+/3pM7hRXhVSTGp9HX+7mJtYGMX9pY+sBuXKNf4eZAG61o1K
	22SqVP30e+KPPQ2LPXvmcQ2v76DfXrNlxoBXthn8F3J1MlVmFh/0nyytiPHYDS1JikG28ymjGp3
	Iwd07Ps+rH88lxG/4Xo4Q20Ijxpw==
X-Google-Smtp-Source: AGHT+IF4CJTMgJ/5UVKy+Qiz5XbxLwTsz7Ah2OAqUt50zvnNtpfyMlv19OUorsoVJ0fh2k1WzxRLKuVmrIiyI5pQ1vA=
X-Received: by 2002:a05:6e02:320c:b0:3d1:883c:6e86 with SMTP id
 e9e14a558f8ab-3d3e6e39bf2mr88898335ab.8.1740874638109; Sat, 01 Mar 2025
 16:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301194624.1879919-1-edumazet@google.com>
In-Reply-To: <20250301194624.1879919-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 2 Mar 2025 08:16:41 +0800
X-Gm-Features: AQ5f1JrlI2H0PfRxblZVVbhk1QI6Oki9HXsYYlroK90j0VZ33QXB6px0Sd8nES0
Message-ID: <CAL+tcoAY1xKgdFzQDcU4LJ7wEZ7oFSaY_aqwtiw4MV-W1RMBWg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: use RCU in __inet{6}_check_established()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 3:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> When __inet_hash_connect() has to try many 4-tuples before
> finding an available one, we see a high spinlock cost from
> __inet_check_established() and/or __inet6_check_established().
>
> This patch adds an RCU lookup to avoid the spinlock
> acquisition if the 4-tuple is found in the hash table.
>
> Note that there are still spin_lock_bh() calls in
> __inet_hash_connect() to protect inet_bind_hashbucket,
> this will be fixed in a future patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

It can introduce extra system overhead in most cases because it takes
effect only when the socket is not unique in the hash table. I'm not
sure what the probability of seeing this case is in reality in
general. Considering performing a look-up seems not to consume much, I
think it looks good to me. Well, it's the only one I'm a bit worried
about.

As you said, it truly mitigates the huge contention in the earlier
mentioned case where the available port resources are becoming rare.
We've encountered this situation causing high cpu load before. Thanks
for the optimization!

Thanks,
Jason

