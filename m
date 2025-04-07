Return-Path: <netdev+bounces-179495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4BA7D19F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 03:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D5FA7A1A30
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F51FBE9E;
	Mon,  7 Apr 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGCtePT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781A1FBEA8
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743988305; cv=none; b=pcosmqZ7e0E7ASEVUcEJAcKfA5ps2nv7vpTSs3iroV0ngl6nNBZNv0ReXznMQOJ3AkeW8XNMCtGGW1scwJXhSDAsntyUJ6ePLNyPtC5GhEHksgxtwcqB5c/TfyIQm93yhdBylLhe6BDhnZtV/w8zXaOLcEEwlEypueBAWJJcWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743988305; c=relaxed/simple;
	bh=6b5C0yS82GnVrznvolAwn8l1b8H/CRxMsq+36B/ssdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INeTklUsdYkAEJmgnxj6OxExtkI4sVMuPOymSGjmIuv1K2mAWkZr/LlBz/sgznA7uOKYOL1E/DYv1KocciZpE3dnAuu9x/4Fu7mLjYD+/13P7R08vCapewaHFkax/XsSejaTCUpIwQ/DIEl7G7kL6e//MqLpzySKUSUniZE+Fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGCtePT9; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d5eb0ec2bdso11015375ab.2
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 18:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743988303; x=1744593103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b5C0yS82GnVrznvolAwn8l1b8H/CRxMsq+36B/ssdk=;
        b=IGCtePT97s1kY5FGIe0DsMpyDbc3kfkeZW7N0x8vyFxU6ssv/5oXW1/p0bs6+GZjiA
         lIxEyDQsj0CeodLCPbBEHejxuShVhKf3oYJHCgotb1KbjPHQ0M2nxETFQ/NSUh06jJz8
         VhoaLnc4bfYt6k83htgmBv5/b31MpEi6KgDUgba9bqUb3jR8Bz6YtQe1vhNMyCY8kptw
         BOWZdaFDJAf5TBbFJH56pwUKh3YJPk6nEUaDTKHj8ZkDLKS8WkkdC+SAI1mG8RUV8tJm
         54hlvUmwPOh9s/NDJ9Gi1WXbDJ3SANsgq4GBlPcbMkW5NH8DCokptKvMEV2n5bfG1PMP
         yXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743988303; x=1744593103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b5C0yS82GnVrznvolAwn8l1b8H/CRxMsq+36B/ssdk=;
        b=KLvvT+5hhdoJ4Ei8W3EQp0IXW/L5sSoH2/6H9EiBNN03Y8yBBXThJJFT8Xc32Q0aQC
         CRq0iDaSzuqiAa23NkyavNlgQjZAy1wtgXu503ddot5+PRaHYGV7wL4+SrWDUyekAg33
         LC0rjaswlyw2EWKzOdn/FR+2DJCZVXqqiYHvMPa1oPaiVyKmKJ6H2iaPDRLixf9l2Mm/
         MlgzD5jaBx0BjeJL8o2RlQ7MxqVlu9bbuOjjmW9uTl3OnsoihFd4/KwiX5tKZ0TeH6Tv
         /8B2dD1W8kifNq5/MWJdfX49AlSIaGvO9Rge4FjcFs8G79hrS+Re5r/OuJFo23GP1Q65
         FBVA==
X-Gm-Message-State: AOJu0YxtBuURbFOIgZIxiag7u0FHTqJ7lFa8K5D7x/K/QrGSq9VPv3Bg
	8XMgErY9eILe2CSjB+SMtjXv8LHKHfbSYm8ySwBDIygWLJpmTts0Dvg8s1OM8lH7Zf1gFWzqNHq
	w7TgkZJUg3fiMwiQs76Y2o3iSJP8=
X-Gm-Gg: ASbGncsTMYOkmv7cuCnrPcuSx5z9spK3xwu5OUyKTrgClCL7sWbG0OcMBFh1x7CV0Ek
	okK2T2mUKf5oMr5qpskHxsOWr+Jdjt+9QJ+2l4bBXNT4/xORSXwqUn3nMFJQN7aq6RgjSmto/K/
	4YMSPcqd21QuJvT4kJZ7wkw0TRlA==
X-Google-Smtp-Source: AGHT+IFbr6IHWfNfD2dnWRlL3NC0HtIs+BZPyo1aq1zhbz/lEZaLGA0VyKwJt0cucREhrtKbRt9cbIe+u/FLvXXy5YE=
X-Received: by 2002:a05:6e02:2785:b0:3d3:d965:62c4 with SMTP id
 e9e14a558f8ab-3d6e5329212mr97347755ab.10.1743988302733; Sun, 06 Apr 2025
 18:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328151633.30007-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250328151633.30007-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 7 Apr 2025 09:11:06 +0800
X-Gm-Features: ATxdqUGc4tZWfoyemMVd3b4_7ZDWu2L3MdMynXf5IsuC-uC1tC4ujqMgseYY2Rs
Message-ID: <CAL+tcoBhuKj5QBNdfA-vHYydUAxLmwL6f7zGwADNhgBWKeCY7g@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] tcp: support initcwnd adjustment
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, kuniyu@amazon.com, 
	ncardwell@google.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:16=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Patch 1 introduces a normal set/getsockopt for initcwnd.
>
> Patch 2 introduces a dynamic adjustment for initcwnd to contribute to
> small data transfer in data center.

After having a few rounds of discussion in IETF, I think I will
postpone resending this series probably a few months later, because I
will keep collecting enough numbers in production and then consider
this small data acceleration feature more comprehensively :)

Thanks,
Jason

