Return-Path: <netdev+bounces-160930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635AA1C52B
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 21:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D9D1675DB
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3D18B47D;
	Sat, 25 Jan 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnxmSLcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DA134AC;
	Sat, 25 Jan 2025 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737836512; cv=none; b=eB/aK9Wvfpd2QLIw83LB8UWlHErkYDhoR6e+cIzCFP+U52aQ0dpW3kxPtolKpE+xmOTbzqNFDLS6xzxF0zq7F9KLImnXUK7VcL2R/m2JdeYnkQsru9xoVP5hekBUQd0oWmyjSbsor9F+/JgmGFzSQTtD/nVDfU3cuIY8Rw/0r0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737836512; c=relaxed/simple;
	bh=xQtEtXHDwj+CtoO0cytWM+JNXD+v6nYs7hAuXzOZgLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck13QBGuN31pHaCq5KbnuKTdwe0bvQKXv/l8ETtMB8cq76lsRYoEgof6OClsH+/sOV1waUDBUYqHCYy2YISqXvQlj3tzvGHLQM5DaeazjOk1w2kWReLTZNdzY009RX83gAKpCDKsXcabiEUyEt2V0v9iU8JwjQfvUMXfQQRU0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnxmSLcs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so57332035ad.1;
        Sat, 25 Jan 2025 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737836510; x=1738441310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yEuxof+C2lk26TkQV71ogV9KtBG5KsWWZmkpoOptf3s=;
        b=cnxmSLcs0wZRum6sbk6J1+blCs+BA+3sNmSViG0APvVLLDP5JBpXJJA5PP2/JEuHOr
         fGWXchbdXp7cz9eK9HfzsFmnnqt09PtY38pJJWHCZw0mPz5WGHmg+i2lQAAmrNskWpXe
         bTnvRTaMqHMtUQMdFomMf2/J7wWHfy/uy1BW5GxFc3LwZ3100hK7axhKV6kGUd8mRk8i
         sx+VMS7JFhFfDiF9bgd4TWrgHVLy3oQA+pQdSVaoYl0FSSzkrC9Cc6lrAxPGXvjTwtqO
         AUlpf5OA5mwm8n4po0BHUAdgw2NQe41magnlrohwxhg3P5zqp4NwVUSgXz0PzndDbnXN
         k3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737836510; x=1738441310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yEuxof+C2lk26TkQV71ogV9KtBG5KsWWZmkpoOptf3s=;
        b=SYW0CIx+QspJCf5SWaduOmcjrUCWCDMTr3LCAckn7+TS7pZW3iMAgXJPoELL9/1Toj
         bZe44CbPaqoy3y8c9SNDKWwCBX6fkepwGClXhhpYF/0XefMZOL1cB4zp7wQwlZ1WAHjQ
         JX2qvguWjURHx4dbdRR1h/c+FkeyJ7kPFcuZLwUF1LN0hqj/w/xGcen4kWdaGKDOkdCB
         GUr+J2AEPqHuL5xMhpp9uhXkRtOJ/GarbFzEx1DH7UbRT2+9Ka3ZriRcFPO1KRJmmoCu
         0WH5Lr1BXvRRVxZk3i0MZ66UhNHrhqWfnD41XyUZnhubXm0C2Do9gf5gBGy0o1M1xOzl
         sd7A==
X-Forwarded-Encrypted: i=1; AJvYcCUGudEAqOkTKjidTSYtSi8nM2aF+wj7UMDdl0LquqMHH3WrBVewsclWW6tALF0PbYe5Xns3XZwytBWRUcc=@vger.kernel.org, AJvYcCUeGAcHbzoUxDpUQFyfch9H76KWea1n8tiuEx8JqTvUO3IRqltdkcWNNvnt8TD0s9nla/7Qp8QS@vger.kernel.org
X-Gm-Message-State: AOJu0YzpG0lo1STEK+/SpZLXZhhqxLFg2stm2RmedU/RzWyOxj7RNW3T
	wGSthRQ3onKRY+AOwBJOaU5WcdrFbte3gDcv6aEm7fZMi72MNjb7aPxjvQ==
X-Gm-Gg: ASbGncu+tsBZUAaO1EWMe8N3uPMC1t5gzxBcgzBE8PvPmqAKmpe0kNDrQ+6oyKzr2ts
	Kwf4fH9+MBxNzQXuqBlW42jQZewmLB8vUIU1wEZeWGF/wYM334S9T0jlZw7Ed0jYoMtNBSPbwdc
	SfbMlY9GhkJTueurVXJNPvFR4n38Q4GP6+9w7u3bUwwIaU3Gn4hYwxbvjh4pJmri32BJwna7sVQ
	JA25fztrQltx71i32oEIAEmUhgw1vzL6fiX7SuY+Co7OSKCBf4U5Y9mjvlVmQk0fmto9QsBrYEK
	PyUlKblI4Vtb+q0at+PL00ns
X-Google-Smtp-Source: AGHT+IFZo4hK+5HjLM9c7v/0ePuJ5+JkTYFIQMb9Idxed66xGPtck0tOABqdXHdI6e9OApJTlnX7sA==
X-Received: by 2002:a17:903:990:b0:216:6ef9:60d with SMTP id d9443c01a7336-21da4ab4f3amr136710925ad.23.1737836509935;
        Sat, 25 Jan 2025 12:21:49 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3076sm36275585ad.68.2025.01.25.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 12:21:49 -0800 (PST)
Date: Sat, 25 Jan 2025 12:21:47 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Arnd Bergmann <arnd@arndb.de>,
	John Stultz <john.stultz@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH net v2] ptp: Properly handle compat ioctls
Message-ID: <Z5VH2zW0t_elr9J8@hoboy.vegasvil.org>
References: <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250125-posix-clock-compat_ioctl-v2-1-11c865c500eb@weissschuh.net>

On Sat, Jan 25, 2025 at 10:28:38AM +0100, Thomas Weiﬂschuh wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
> Detect compat mode at runtime and call compat_ptr() for those commands
> which do take pointer arguments.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/lkml/1ba5d3a4-7931-455b-a3ce-85a968a7cb10@app.fastmail.com/
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Richard Cochran <richardcochran@gmail.com>

