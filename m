Return-Path: <netdev+bounces-179256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F11A7B95B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BA23B9BE3
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C01A01BF;
	Fri,  4 Apr 2025 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/nATDAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A950219E804
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756830; cv=none; b=TCniRSU9PEBK/dxNuZ9qbuB1Z5WtNsmmjwV3r8Z4vud6uvTqGIG791cqTlM78V8fNFX2caMZ3vgseD0Ylhne+gq5cmUshuGljBsZFGJNP2cPSpRVgWWQPaZou86C2j/ONw/D8ZvT7o5ckmlEE6kWimBTAaH7u7ZEy4j8ALoO+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756830; c=relaxed/simple;
	bh=ujMPWAnf1O+bgsUZ8iB+TMoPNAqGfSKZOUzSlaV5O/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BklIhObEUQQS1l2vYmAFKpIpwkA0vmJmqKV4THUTx1bGwMV6uFP8jO78xlz257yDj29+T/wteqjNZpUZb2HyQrDX/dF/GaTPAdeBfr13S4XXBMwQBIOB2T7W3625S24xMdcc5G+T42Q2y+SLshrNbVWtBmvDZMrwdrOLyLx16kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/nATDAD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4766cb762b6so18289691cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 01:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743756827; x=1744361627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujMPWAnf1O+bgsUZ8iB+TMoPNAqGfSKZOUzSlaV5O/s=;
        b=V/nATDADvlhYMGWhL6TB4FAfT6QqAXbN5VzqgzAVN+TAwFjUsZlP0rlqZaNXOiOIYY
         ccBeDPyvZhYmwz9DePK3mCqLnRlmYrDnSUjAIM0lhbIR8PgxHaGTnDEEJWlqqhhW6XIn
         3NQGD+PyTHbQ4SvlK00Dsod9O7oVbVuZQTjCZC0kXw71M5QTn5D5iuEZU8yiif4Tlg+n
         pQ0Gd4O2/JLW5gPngK6yyi2VN6o1mcBTWtFBA+PXYNOFyvb2OYpsp0R6F3CXO/T+wc+n
         dsgDYhCPGKcaYs4xouwbloDmyqb3+80P/dhpg+LwA0yZ7e6sukPHKCInjmK1545Ufymi
         5+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743756827; x=1744361627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujMPWAnf1O+bgsUZ8iB+TMoPNAqGfSKZOUzSlaV5O/s=;
        b=u4hHLVxz6Njkqr7CCOyQ2O7PyAmbJwZ+jWTAsNVCwLzwJH+UkoF+8X2jNr5BzhpUlM
         B7KLyXOmaFvHekc2ilGk+nn/w/JsGWiSCsCHq9eFYS6DBLALYJRVG+9e5Iu//mTqWQGG
         1qlIgtuYGPOkgszSwuYeZEwFLEjhoBwElcqafdIIyjEzCDxBpSuNQwdDB9KUbQLZvEht
         fP+BV+0Nsm9TWMEG3RgntvophI1lMSR3P8gKb3jau9BaaMgDYcYdtT+fe0FimADgezPv
         /kpGbnOuYho/rrextH22urlhFQfS5es9z6drz1NH8x2SHGo6RfBswKVv35uT+4PZuuk7
         BWtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWeCc6lfYpMDGm/udbC65eku9iSUIu0/9HhiE4ngJCkbtV4PGqQ/fseMeJ8siuNWXhg+VO7b8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tkHnIxkdAjtQBcY1wDzbCmvIDZPMGGYIBKZ/bcO4ZbSxAJIN
	73FzB7lVgTn3hqeORdqGKUre/Q0a9+GQDL/z2S1IiiN+7Y+QJUPHuIak6pCKMXGdvgL88psc7G7
	S0HrXQzxlR27lhFFS6c2rC6FIYWsSw6x2HbQr
X-Gm-Gg: ASbGncuE8gZX56L5rI+jpc++yavNfh3bbXZnAJNQHAbtQt/Auh24qISx3M52jypWl2R
	u2ess8J3/t/5UOAJDjGnsylQAgijiimiQ+/KguO+WbvLd05bBUNGaYjxKGbZ/t3i+reW8/u3LqK
	BrhmyhoW7RtUfwINcMDCe7Nj/CXoM=
X-Google-Smtp-Source: AGHT+IEDvlcZZb4tFOjewKa5T6ATIyDdRK4SGeqCi554xhUd6jIH4AI3nWrbMiUMVwr+yZJxTIpJVIPkAIzZLyWMSKc=
X-Received: by 2002:ac8:578c:0:b0:476:6df0:954f with SMTP id
 d75a77b69052e-47924c86329mr33561751cf.10.1743756827275; Fri, 04 Apr 2025
 01:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403113519.992462-1-i.abramov@mt-integration.ru>
 <Z-7N60DKIDLS2GXe@mini-arch> <20250404102919.8d08a70102d5200788d1f091@mt-integration.ru>
In-Reply-To: <20250404102919.8d08a70102d5200788d1f091@mt-integration.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Apr 2025 10:53:35 +0200
X-Gm-Features: AQ5f1JrJvO-P7srrVogKZHZUEQyOXnDzIFSrTNnEmr8jIXDbBAMV3uDIAoT6Pfs
Message-ID: <CANn89i+UQQ6GqhWisHQEL0ECNFoQqVrO+2Ee3oDzysdR7dh=Ag@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Avoid calling WARN_ON() on -ENOMEM in netif_change_net_namespace()
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Stanislav Fomichev <sdf@fomichev.me>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 9:29=E2=80=AFAM Ivan Abramov <i.abramov@mt-integrati=
on.ru> wrote:
>
> On Thu, 3 Apr 2025 11:05:31 -0700, Stanislav Fomichev wrote:
> > On 04/03, Ivan Abramov wrote:
> >> It's pointless to call WARN_ON() in case of an allocation failure in
> >> device_rename(), since it only leads to useless splats caused by delib=
erate
> >> fault injections, so avoid it.
>
> > What if this happens in a non-fault injection environment? Suppose
> > the user shows up and says that he's having an issue with device
> > changing its name after netns change. There will be no way to diagnose
> > it, right?
>
> Failure to allocate a few hundred bytes in kstrdup doesn't seem
> practically possible and happens only in fault injection scenarios. Other
> types of failures in device_rename will still trigger WARN_ON.

If you want to fix this, fix it properly.

Do not paper around the issue by silencing a warning.

