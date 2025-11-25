Return-Path: <netdev+bounces-241571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9BEC85E8D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97A304E9765
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4BC26ED48;
	Tue, 25 Nov 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMsAT1k+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC32673B7
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087294; cv=none; b=uqyx5m4aXi/kfGzQWZ4VliQnlH1OxEJke9j3TFmPzZHjGTD6Xk7qUUAfoeddk1kMFHzF/M3T+TT2hfFV1bI4yaFPKyT3Tir8a1wBr/4HeNJsmcTMWP7LAumsaI+nvJqqiIvURqQGewB8IbkaeuWQnxbSMMbT+0wlwmtoQ0Ecdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087294; c=relaxed/simple;
	bh=R/c+flV58muomrMmtU53qd47lYbsYHti807vgioeMVc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K4s1Raj3NljHtTGIsXavLqeeNsVSexN0H5OBHXtfuzR16oANwpSm3XuQUIYbzwxKYs/Rg4BAY8bfEJSGksnMdVmCwN7ZvD+SDMqumYcaiOG5/vuHzNrmXY4I32hB8k/uDBxg3GYOQEWa+vYpo0PDvYmY9h7AxkG98n1uVj4GDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMsAT1k+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78ab039ddb4so20777887b3.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764087292; x=1764692092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVmS8M56197Tx9BpV9mIjAisdUefrXPhKempHf2Fxfk=;
        b=fMsAT1k+3mEr5Py5F/el9qw9cKM2qagZKs2tTCVv/VueKLLjvKAjegNM/GRvVsyXrB
         64flQs4dyQdpRBG7SBOJbdlpWp7JU8MhHSuozqUiGdRtHMa7kMlklIXlMQOEcS+iy8hq
         9CYe1Nv2jeWLBA347zvSk9iOG8l5qRIJcT66jD1AkcI6CeUTvF3pluGlIOiQtgdjps7t
         cBNjZkP92yKMHTvFDqRSdczRBvwpDxdBIj0ub+PRleLli4ewA6IeoRAUXLvQiQ/Xo1Bu
         w/3Ko+gXSgE6hXgUzz2jypjsjIUKpCMD36Pu9fEDiKnyU2SGRuWty1tc41Yf6K1t0Y4d
         1s9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764087292; x=1764692092;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVmS8M56197Tx9BpV9mIjAisdUefrXPhKempHf2Fxfk=;
        b=sWy5lLI4EDrXwVKELlPuojxncAXAFMaLZaIEqArHx4UD1VmaXKgPeLo/hSD9jwXT0c
         cXt/GHk6KBlYRn4BFbxDyJcGio3w6KDv5UqIjbfdfcXmUHkUe/4oCcLT/eDFpMH4Ki84
         DhKW8paK+PwZd7Fy7GFEVufiypdGAB06n8iSeL1bqqGDOUeK3jc8dPqA0oy9lbBlAIKp
         gcB+Zm140tI+xsORf/S4EFqs/TY+lUiimMWjSaYbhIZuJifCk58eJK8230v0+Y1pV4nF
         bG9aAYhLAXAYRbYOvqXl8QAWel9nT/U9RiGhP03lWyWZcG6/HsveD0kgbLgU6g3cZjPi
         Ht8w==
X-Forwarded-Encrypted: i=1; AJvYcCWhbi2XsKH9+URnJ3QlfB4N+biHZetN/JENr1Nr5RjU9i4ECQVDxNoZXQVFrYB5riJ/l6J5h1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/LXa7EsxWltGjhcDNVVNvs2rmzoFZCxzll0V/bPwVom801IT
	ArM2BsvaVlDbcJz23kGlKBn4pbzHNrsxd2p2gCxdZxM6kqHhf9t9wIxS
X-Gm-Gg: ASbGncvQVzI0XSnDpN6kMxsVrvn4/Nt8ihCe/XG1pI6IF5+kiMjB/VoSnKE59r+FAUM
	kv8ld5wt8LfGfeKCWi0qLoegnv0MiINw6V/ZtgGh8nAtPUacg8b7PjIc1Q3pc5cq8TUfU9yxg4Q
	QjVozBLmNMNQA2d9swXCbf57Plz1DCc6iUa1uFqmU0WJ3SMwmyOZ6rYYfoy+sQk1B7mOcMj3I6/
	1fxeXmQu6V6ezwg1+fnC18qzBse01ddtsgiUleCMe9bzILNRZ7pCvcNQZBs8lYrPJuzhgtz8hh1
	/kAcKNhCzMzPHrh8vL7BD9SmLJc9T+xNdnevSww0r1guBqHWhMVbKp2c2M0ZT/IhBRJgc5XiMpt
	o2VAIyUwAyhaz01hrjK4hYYeRPa7iedDOsuaSxI74sQsP5ZHPunDqQ5uvgzzVTearmMDzV0TZPR
	xOVLLqhO3CliZzZ2AEFhAL+ZWmuvLZA024ADzA9DIScEOaO9WnuEmRd6k77Z2vGHbWHXw=
X-Google-Smtp-Source: AGHT+IGns59BnaijYD+D80rBffETQUdnkBAppOq3jxlYqt7u9mCa/2kNEHDwIJ/hkYPW9Yqvb0kGlA==
X-Received: by 2002:a05:690c:e1f:b0:786:4fd5:e5de with SMTP id 00721157ae682-78a8b56e89cmr138239077b3.67.1764087291625;
        Tue, 25 Nov 2025 08:14:51 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a7995a738sm56901637b3.57.2025.11.25.08.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:14:51 -0800 (PST)
Date: Tue, 25 Nov 2025 11:14:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2f2a6f8b32ff1@gmail.com>
In-Reply-To: <willemdebruijn.kernel.10c7edf4c3dd1@gmail.com>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
 <aSSdH58ozNT-zWLM@fedora>
 <willemdebruijn.kernel.1e69bae6de428@gmail.com>
 <aSUxhmqXmIPSdbHm@fedora>
 <willemdebruijn.kernel.10c7edf4c3dd1@gmail.com>
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Ankit Khushwaha wrote:
> > On Mon, Nov 24, 2025 at 01:15:33PM -0500, Willem de Bruijn wrote:
> > > This does not reproduce for me.
> > > 
> > > Can you share the full clang command that V=1 outputs, as well as the
> > > output oof clang --version.
> > 
> > Hi Willem,
> > I have added clang output in 
> > https://gist.github.com/ankitkhushwaha/8e93e3d37917b3571a7ce0e9c9806f18
> > 
> > Thanks,
> > Ankit
> 
> I see. This is with clang-21. It did not trigger for me with clang-19.
> 
> I was able to reproduce with Ubuntu 25.10.
> 
> Okay, good to suppress these false positives with normal builds.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> 

The patch status is already changes requested.

Please resubmit and target [PATCH net-next]


