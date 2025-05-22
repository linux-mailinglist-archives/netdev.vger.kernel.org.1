Return-Path: <netdev+bounces-192705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9BAC0DC9
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3050E188649C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11628C034;
	Thu, 22 May 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WvGo1x+/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8828C007
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923105; cv=none; b=SH6NmsK+NRLoTpT9sO4DLZiZS31I8IQvpMEQzv19JuFN84a3mIK11sCme46ph50vfrsmpy7ZBkKpDvUlLkIMc+AXkkQAU07OUwvf2qGuwQwT/EvYaPFtR4I2QjJFra521U9+Ado2GAfIW7lVUN1AUo43UrAnbPa/lA0s5ObT1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923105; c=relaxed/simple;
	bh=9o9A34eUdxJeOljfrvuz9xYArQx9lSn2ePvkdjIq0yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0mJi1VYKgQljO1QVpD46z+5EcCLGdF2YEd3ZzhOkTZUKvU2rowTscX79aEndobe3qUBrr9EeSOv3k6j919z+xASDbA11RZg+o8DiBtP2Cj2KAgjaEvA4n4902aMOtVzJ74XlRKWifjrAIA9AAO416GWovYmml2lXuxunJAkilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WvGo1x+/; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476ae781d21so77569441cf.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747923103; x=1748527903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o9A34eUdxJeOljfrvuz9xYArQx9lSn2ePvkdjIq0yE=;
        b=WvGo1x+/EMsUq12cDYkk0JM06fSuW+CEX2QYoWWJ7PBJSZqAmUpbpC2eeuoxI9yJgE
         pbfI7jMurcfJCLEqPgb178GwEkTzdk3ueaER3qZ4nCFy7cTnL4J1itPpT11sRxIijxgB
         xnrNCYYZ4thyA/cZ17mIE5PCmDrAZ6CylZ2PEtN6SQEkTECzG74koq/Ks9QkjnI6TsZZ
         z/KFP6iSOxzJcD7kj3PfN0ncg9shu4qGtsFqHRcdFO9vltYfEZvCQwyD9T0KXz2n/sIq
         DDyRkJLbWEIlCPYCrfDXzyOpnQtafRnJZ3TpwE36T1UUA8UloxXmMb2mHxo43e2HQ9Qr
         K6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747923103; x=1748527903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o9A34eUdxJeOljfrvuz9xYArQx9lSn2ePvkdjIq0yE=;
        b=mFaw8AfvsAfKG8TNBiDK/empHqeSbbewAKsN7R9qOp/1pptVNc7/rZbIfZCVAcqBlt
         UWTowalD8wr51oACrOLzAJIQwFTW9SxDbECHO2qU2rURZbWzlKMkh+wzIXOIKVqDm6fY
         9Pw3c8NLWxiJLBT/UMEemoq+YlE1i1idXvwbgVKtf8FBhlhLncqLTjVjdAw1iHGDa6rv
         M6KebJXU+RmLq1D2/DGnKNVVUGtD0T4+I02WgmaK0hykKF0L+eACP1ZaUNtAmn48g5f5
         J6vnf7rJI1pYBpmbnjKbfx/FSZgHAmLgAztpDLFXz69GJr81T/xRccmWU/ao0GToDFWR
         kxGw==
X-Forwarded-Encrypted: i=1; AJvYcCX+GHaRCUW0bFu1xunLuIo2yOAJnrw6zLQ+fj9DkdohsOL1UE/vrUJz5MuDg+Zfecct3+Grwck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZk4KOIDDoStImU+s1dFrAVskJrV8a0ExCuRmNKigOGEX6In1
	cj1Bzytpe+OIPTvnAy/Y2U3Z93GCAMhWs2IFV3qcQOXTpkbJ5CTQLXrxWldWLlE3dFFg5mHfkZ8
	1rRo75ZW5q+As4mmJZVH6n0OS/hWXcOjbPc0aEP+n
X-Gm-Gg: ASbGncs8nbW2rjiVVwoHREsvXkzASociFKaMJrq2YfhrvGEIHyl1IIRVgkbya5VIF69
	lNlGxaHPCrgq85VnSNaRR/ZyK+sjUf+5Mga77p8OwqsAu5OJ6R0FCymgy3k6mrUkfS/VYrgyH8B
	J15ea7tJXGIDT82uAGsTb4o6C6Q+nVYFvkjzDQ/LKW
X-Google-Smtp-Source: AGHT+IHhI5iyDGEQcFHHX9it5WxrV2JaYhCs2EqlKrCTIgf8cEfiWdwmYeFmCA5uHoRgVo3tWZEUAfaz0UtpOnqWG+U=
X-Received: by 2002:a05:622a:2619:b0:476:9ac6:2f6c with SMTP id
 d75a77b69052e-494b079cfc3mr473952991cf.18.1747923102870; Thu, 22 May 2025
 07:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com> <a7ff9548-ec75-40be-9770-e19308c5389e@iogearbox.net>
In-Reply-To: <a7ff9548-ec75-40be-9770-e19308c5389e@iogearbox.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 May 2025 07:11:31 -0700
X-Gm-Features: AX0GCFsIM3M5rM_GGIx085lnpZb9-w5iPSu0WVjb3gQ2g99hwmuHU4Q6mjmfPuE
Message-ID: <CANn89iJp1N-1NBrqg4WsjYJgXNTHdgi8PQkezaFGCgFt-c0jDw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/11] tcp: receive side improvements
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Rick Jones <jonesrick@google.com>, 
	Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 7:03=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Eric,
>
> On 5/13/25 9:39 PM, Eric Dumazet wrote:
> > We have set tcp_rmem[2] to 15 MB for about 8 years at Google,
> > but had some issues for high speed flows on very small RTT.
>
> Are there plans to bump/modernize the rmem_default and rmem_max defaults,
> too? Looks like last time it was done back in commit eaa72dc4748 ("neigh:
> increase queue_len_bytes to match wmem_default"). Fwiw, we've experienced
> deployments where vxlan/geneve is being used for E/W to be affected to hi=
t
> the distro default limits leading to UDP drops for TCP traffic. Would it
> make sense to move these e.g. to 4MB as well or do you have used another
> heuristic which worked well over the years?

Yes, I have a similar increase for send size, with tcp_notsent_lowat
set to avoid eating too much kernel memory for bulk senders.

Extract from Google server :

cat /proc/sys/net/ipv4/tcp_wmem
4096 262144 67108864
cat /proc/sys/net/ipv4/tcp_notsent_lowat
2097152

