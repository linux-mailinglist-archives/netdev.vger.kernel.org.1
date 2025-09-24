Return-Path: <netdev+bounces-226021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88196B9AE51
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4DA4C6889
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D213148C6;
	Wed, 24 Sep 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km+Sa/R3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88A3148AF
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731920; cv=none; b=RZo6K6GpolFJOLHuJIYOLYnz+ZkxESoJhh/k7z4TFa5vfuLM9kOkXIgz6wYRfdVLJ0V2io+zMPghnx+TpNmGoex4kK2X4ghTYWZbG6bcNHK9dVX6QxufKZzkkIhAKNi1DJ479YND7yxxK9CsvodeBPF38b3HyLBUXAy3S/2R2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731920; c=relaxed/simple;
	bh=LBWmdlRRsliTPSJo/06NkfCz4StlFstbl1kmLgDU9pw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tG8yhL6Id3pC6i9BFcGqBhkTfz5X/yzoElZFXF+h/0ADDCplGS3xNTS5Y5u8eDj/lSAjKmWbS3uSfOxLAn1vZFZlr4H+PPt+dEcED2pLOV7jaEjPzYWSqJKnVR4i/c9ted7M+TOIjTLRFl7VqcdRJYUeZ6EL44/iqSNXJFIgWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km+Sa/R3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b555b0fb839so2231349a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758731918; x=1759336718; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuRVdTonBUKmN2+tmLzpdal2LL/xlsz4RbTHj+o5eb0=;
        b=Km+Sa/R3Zrf7XaGgQ+TJk0Eqw9jZZwGwkUVTCuW2P8MTCyOymckz+096LdSJJZSG7i
         I90auf1/amGhSZIgteowCFQfjM91nEFn8tVDVh3Q/CWn5SPvRZ//jhFHHm7jKXlT/a4r
         Ms/J9+A4RfhdfnIo3NZ95AgkJXjAfKkX9ZSJUF1DG/7e8ZIihxB2wuU1aLf8QM3eo9xo
         tpnQ+IvNtP8dKyWpFfIKBjhEuwnQQcdZL2oSTCn7OLE7QbIlnO3iytYNA6mYX6Lkk3mB
         p0frxQb2nd9a4R1t8W9qs8DRsfPGQQxsVyNlX4MxrDj7g3eYwIESrgEPHfYo/HiAI18F
         2AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758731918; x=1759336718;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xuRVdTonBUKmN2+tmLzpdal2LL/xlsz4RbTHj+o5eb0=;
        b=DgX1t5nyJxhNsWzyLIEX6p1FGqbvpUs1OKljrI4FTY+r0XOTCo+Y+LuZAwIhrbGSi1
         8rugPKq7iESIlRMBIpv9ztjMTmq9/FMiKQ/cBE2Q8UdZYsEj4RwLQHG/guN3nuFAMnAY
         aGkJYpvapf8M4uyZHvK61xQtjnuweeZnKEqyEgobdE0d8OJpG6MYM40w2m/c54lEm1aD
         JnbPVJi212tBUOO8nY6CKJvxOo00rJQB+H3OGt2Rhpv3x5U29ZguIShDuryKJWz7Bl1/
         Y1oQ8b2QkBQCyxwbhEw15JkWeKsNXQ2KrSWqTQZnLe+KUK/T/Kb8DG17RiK7rkc/xl/w
         tOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkHHPTYt7fskNf/koL2AxUN9tlW8KCTNp5vxqw9YZg8o1YRz7fhCxEtkO8ve1Vcjg52eD66Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdxCsMjhRZ0QIZZsWw4afXd6syA7ZM9d7PrbMBpJE4NXkJl9C
	5p5G/eBmbshJ04SNI/H9iAEokdC54Aif7yc+f+8uXJ3INnY7QMeSdJi2
X-Gm-Gg: ASbGnctH9Y3ft2QZZX4vrwpqwMtyDSuzwtP/4+WgORQxOmR+ZVOF5t05SIXNi+f6uFk
	KAzu3lpzMi83hrr+DnZk9meXmIZuN/mPyIvJWXWgKtCJ2koX+r3P3ld3fJ8b2QdvNvA2jcwoI+J
	YQA2ZOMSj7fhDUicGIsUqk8ahdPlwgNy3gAwdat8E0iMoW8saEhc/By7NbcaXAYl0JWrnlub9Dg
	WuusVjfbWoKfqE7lWkrtPbVKxwXT+9ApylKxsBMby1G43uw5yrcW9KbOczangY1WNuQbFF06dfH
	ZCdXkJF8qyL9bNanh+BrmnGjSPtSyyad+7hOVK/1cWKIx6zxCVMD1KkjnzG0kQ21WL8NyKBqGQw
	WCxFHJmLVJUPY887EFhdwEGjFONA+qOAgviN6daXeZUv49RAPaDOE
X-Google-Smtp-Source: AGHT+IHZyDfZjdxh3zJ5q/UDM5QqQ2dQtT0K3iG9NjmSnwQzqyL/uchSyYM8Xuz9Z3dNuqQuz12vag==
X-Received: by 2002:a17:903:3c26:b0:24c:e9b8:c07 with SMTP id d9443c01a7336-27ed4ac323bmr4154655ad.43.1758731918258;
        Wed, 24 Sep 2025 09:38:38 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053090sm195689415ad.23.2025.09.24.09.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 01:38:34 +0900
Message-Id: <DD16FJFQ33HG.7IJCUH79LHN8@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: dlink: fix whitespace around function
 call
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>
To: "Jakub Kicinski" <kuba@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250916183305.2808-1-yyyynoom@gmail.com>
 <20250916183305.2808-2-yyyynoom@gmail.com>
 <20250917160642.2d21b529@kernel.org>
In-Reply-To: <20250917160642.2d21b529@kernel.org>

On Thu Sep 18, 2025 at 8:06 AM KST, Jakub Kicinski wrote:
> On Wed, 17 Sep 2025 03:33:04 +0900 Yeounsu Moon wrote:
>> Remove unnecessary whitespace between function names and the opening
>> parenthesis to follow kernel coding style.
>>=20
>> No functional change intended.
>
> please dont mix whitespace changes with fixes

Now that some time has passed, let me recap the situation,
(I initially wanted to summerize the message, but I'm concerned that my
English might cause misunderstanding. So I'll just quote the full
message instead. Sorry about that.)

------------

> > Please don't include white space changes with other changes. It makes
> > the patch harder to review.
> >
> >     Andrew
> Thank you for reviewing!
>
> As you mentioned, it indeed becomes harder to see what the real changes
> are. I have a few questions related to that:
>
> 1. If I remove the whitespace between the funciton name and the
> parenthesis, `checkpatch.pl` will warn about it. Of course, I understand
> that we don't need to follow such rules in a mindessly robotic way.
>
> 2. However, I also read in the netdev FAQ that cleanup-only patches are
> discouraged. So I thought it would be better to include the cleanup
> together with the patch. But I see your point, and I'll be more careful
> not to send patches that cause such confusion in the future.
>
> 3. This is more of a personal curiosity: in that case, what would be the
> proper way to handle cleanup patches?

The problem with cleanup patches is that they are often done by
developers who don't have the hardware, and so don't do any
testing. White space changes like this a low risk, but other cleanup
patches are much more risky. So some cleanup patches end up breaking
stuff. We reviewers know this, and so put in more time looking at such
patches and try to make sure they are correct. But cleanup is
generally lower priority than new code. So to some extent, we prefer
the code is left 'dirty but working'.

In this case, you have the hardware. You are testing your change, so
we are much happier to accept such a cleanup patch as part of a
patchset fixing a real problem.

Please submit two patches in a patchset. The first patch fixes the
whitespace. The second fixes the memory problem with copy break. That
should be checkpatch clean. And mention in the commit message that
this has been tested on hardware.

------------

You and Andrew seems to share a similar point of view, and both are
quite reasonable. What do you think about this approach?

	Yeousu Moon

