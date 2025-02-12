Return-Path: <netdev+bounces-165551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C30A32797
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74FE3A2185
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF2C20E009;
	Wed, 12 Feb 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ez9AR5s2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BFE27181F
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368393; cv=none; b=Pt97HG5gnoiA7bwTzZZdffWEQbP0OcwTAJtnHCrDOGOEYxNp4coY77TVKuxSL96VDrlyvD5gsU1P+iPpoGt0KeyVfYeAS1lpzz7/CKu7E8UST+W64P9mQyAmMgVk0434pHc5nhJvK5gxG5uCbxQo4ATVvRXRfUrWvjkh+My6UXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368393; c=relaxed/simple;
	bh=duIGeCD7DQqBaSaKDgFs86FOwXOQSYFI2hjJ0M1RGhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfDwXuTcaCV/CtOXHnS+MNrc0+qZ6cgcjkvx9kwgYCq73KbQcH34tKfIQeTCH+Fn7skvxXWbcrpoQbXJ4ORP6+Lq7XU+H4NAnSpXMLUJRynH1/38yboHRkx/UA9myGQ3X2CVTpidn1x1X5c/jkMyn/3CMRdrV3fXOS3W16Vfwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ez9AR5s2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de6ff9643fso6899397a12.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739368390; x=1739973190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duIGeCD7DQqBaSaKDgFs86FOwXOQSYFI2hjJ0M1RGhk=;
        b=Ez9AR5s2eKWt37YZxlEFnSWYga466dELkDP0AM0ErnvdzkiZF6l0qZ4qfeJbD/CQCn
         QtfvMYUFxLppT5sH2IZjGC4RlxRLw1DdnrdO/uFMX23HH3jLMaRnmmM4k5tZNl+UJWrE
         YyZMQviqwfQMQVsqlz2LIdYsbDzbUa6kApvDEyWcAbXq6Io4OSSYeKYUEgGDRvlBAYMm
         hQetb9iDSAe99bKKUp89zXZeOGKMx9C5CetkxisNbVcuYnpSWkUGfQAzyUp1t2Qxpm3c
         kPFWwpQ3afYmHnSxfKCSPTQsaPTWFlWYSlj1qgphx2j6k8a8kJ0jHECHKnZHHbkojR5L
         dM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368390; x=1739973190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duIGeCD7DQqBaSaKDgFs86FOwXOQSYFI2hjJ0M1RGhk=;
        b=cHgDdvG7gmIkxLGCNPAw+Rkiqthl9Et9cUj110SEZzC8Zj6uNilfK1Ey1O8DsAEO4Z
         9DEEthVs0+mb8IkhoJCgP1HpSWmrta0mTTsK+BhSj1+UgfaX5oDxJnmTUIW15RJvW/q7
         D1G89zdeJjaTXg6czxa1CVAlmJe05E+TfGPiQs7awyGOtSfZXv5vCjlIh2hG9910Gw1E
         14aeyFdLhiFnoeQGaMAVe6S9e1IF4+FX3tl0l5e5wZk+1paSJTkxetg7DHgioEY7Ad47
         1Ovf5RkvbEvdMIeNkh8DFY6+1hSRi++BtJ+J9ZC9wWImGNSaePzcllQH4y2Smc4DlJoh
         2HoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWslttk8h0WuDdP1hoY4M7vNpfZzeypMr9HeuyLP/DUSS+Zp7qPgwgyU9JjYmmLflVAC6+q1IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLfcJbCIIDxKWvkqNv8GG585KxkDjNeoERTsjWxIlJOTdf0QA
	DXescfWyYyC0VRytvEIw6tb0izQukrKd2RJbOTDbsL1pip3Y8CXzAxjjg3uGkyNK1IiDsoQynvS
	P+i8F7B0CKR5mYvygyWLFiQAP3Oie1pBV2anVBoOdKntozbDgBQ==
X-Gm-Gg: ASbGncv74o/uaUUzQL2vfdjWruRTpVI2I58dZ1gZEf/Ut67GH9TINSemf6HTNS/KEhM
	ispfzMCpLYs9u5/INH6oCGmTWAPmgjCvQOTqu+HCfEB/GK9rQXjyLsQObDow57xIIjFK2vHIGFg
	==
X-Google-Smtp-Source: AGHT+IHWT3Fw99k8rmUsBupjchI529P8UaEs+qwtxt1zBa+t8emzveHsEDNtlwslxSSpDudwkGyUNsJVISQu3Jyz5Bs=
X-Received: by 2002:a05:6402:238d:b0:5de:a76c:9c7c with SMTP id
 4fb4d7f45d1cf-5deaddb918cmr2348294a12.17.1739368389961; Wed, 12 Feb 2025
 05:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212064206.18159-1-kuniyu@amazon.com> <20250212064206.18159-2-kuniyu@amazon.com>
In-Reply-To: <20250212064206.18159-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 14:52:59 +0100
X-Gm-Features: AWEUYZm5g-y54DjnKyJOkMPY7FLFaqe2F3rapksQifQzfxt3ZYRRGP9x2Krrhpk
Message-ID: <CANn89iL3kZ3e5peUwO8k=5mC5nzbzSA7QM8wUKBmc-RBmr6tng@mail.gmail.com>
Subject: Re: [PATCH v4 net 1/3] net: Add net_passive_inc() and net_passive_dec().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:42=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> net_drop_ns() is NULL when CONFIG_NET_NS is disabled.
>
> The next patch introduces a function that increments
> and decrements net->passive.
>
> As a prep, let's rename and export net_free() to
> net_passive_dec() and add net_passive_inc().
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/netdev/CANn89i+oUCt2VGvrbrweniTendZFEh+nwS=
=3Duonc004-aPkWy-Q@mail.gmail.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

