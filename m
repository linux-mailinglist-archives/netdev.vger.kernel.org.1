Return-Path: <netdev+bounces-205011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC742AFCDD6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE01188FDE4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2A32E06F8;
	Tue,  8 Jul 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XPMe5JTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F852E03E0
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985307; cv=none; b=D4IY/xwQW1ITJfrewvjMXiC3sWd66yMym7TwCqvkVcIQDDVGYuF/SFKZm9WJtVnIyTY0oLPOl2umrNTFnc/9dZphDg6waD5astDMCLy4pW9t0NfP/Zi1YR4x8v1g5O1szIAZ8Zav4FvP8e2VAtVe/Ulbq3vVknW/FOzryQH1wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985307; c=relaxed/simple;
	bh=7frYhm6hNHHaV+KsH5p0Qn6S4lh/W0BUcifzlnaxQvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XCRqcvk5/ULLHVJErLQdN1j0QejP+OuWqcKyxLNcebY33FeC28Z7PTsWMCIHE0r19YD7ZHbFTQDBVtrYC6YrLuIxxAtL88r4SR8IFWHFXAevlm9eM4ciYkHC/swEPG7iCGquazBB0Rd8smtFlsCyd9/WqESRNF6Ll5qZf/azY+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XPMe5JTP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0b6532345so1004687666b.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751985303; x=1752590103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxwpTC4pjKEwraXDworePX6nm0pYbDVXaWFr1fnQfIg=;
        b=XPMe5JTPDrv8TrmjIOiVEOcNeGfJdeEiNXkjDOiqYtdQThNqKCykHnfXYlntQmcnI9
         PpvIzU5yOt2W7zStZtirYISkYrPLcyl71mNzRq/YyFiJZA/hOmdmFW4GzYXMVXRmw620
         1Tk9CCKm6MZ5O/yGWrsHBlgrNhXoRndj/xMJd7PH0ctaEZ94b3aOjipW6aYn39tU3gcX
         Y3cEvfXw/Ef8MhpuQbXPbHbtiEuG8jHRwv8x9I5he76kzU3urSmN0C2H5jD498ilp4KT
         oXoNZ8OA2fayzxDo/oVpcWbbWhz8Hhc/yo6rQDk1A7qk9bCyoDEl6CzM6C5rsM+PyzVi
         hpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985303; x=1752590103;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxwpTC4pjKEwraXDworePX6nm0pYbDVXaWFr1fnQfIg=;
        b=SXxnk6CxvlxX09F36WvTAiuTLJTz7SEyFjoU+ApaP1V7ilnZnyOYN24rUx8uYIHswx
         fJnuFzpKC9lFim4WBGO+/H/fBd5pU20qt9TU7FaqwBm1KlcWlWrfNB20ccHGKqZy4Q5S
         F4TEI+n9XqBVlYlJd6ioC+2dDcGRuj5QKtlztITaBwLA8JwrfIiu+yLKfV8Qcfj0RLnk
         9iWQQGF6QUtefYcmXdwFyAdTEqP4BJx6n5TG3wJI36QegtezT7pFGx2XIrH8Rf7RyqQn
         kHR7aZYMgysk54Ki/tIGeIevioDa+xI2ltTP9U9rV1AHnlzKv3xLOFNyawRQqbC/dKKO
         uOOw==
X-Gm-Message-State: AOJu0YwpvZxQrlE9rM9Gr1oolkwi6yN+bVOhhWz6y9KHxtdSyU8OBoJf
	aWlXCTJojzb0DDSb0lB/7uaWak4UnMf0zrsWH1tu+6vU8XrgJfEAGdeQNxHTRKkYqg0=
X-Gm-Gg: ASbGncuMVAr2+I98IdKimRWQRVm6GS2//UCn+uVyfQlJUnFCd/vGUcMHDtimJ7LHUA+
	j2jtHcRq54wfz+o3dVvxLUgyqZG7sXcbmx/0OB8HnnoQ7wG+GMzL38MuE8c4NJbCvvJqW5RNUnz
	R2HbaysBUidJy1vFJJWJNqf9cTEy14yiJUXuXkJvGM1o9ZrQybhxtLRfEGKQ2mZGppezaWXKBAO
	JvxIW4itYHibEEIkDCgV9tfpjj0adsiGYA0oI2XngMZEhKIGMZ6dmVbAdXpurXX+X6t1OjKYNjY
	Fcz4WnQA1WUKjq97RqUcdJwEcralj2H4oVA9yz7Yrezh03y550HQ88usxIIBpRQQMw==
X-Google-Smtp-Source: AGHT+IGrXyge7FfOVN23iefvx++vUMDnJdYknk8QF22LCGBDXXJ6noAno8D8tYkciBmeZoIqRAR5RA==
X-Received: by 2002:a17:907:3f0a:b0:ad8:91e4:a931 with SMTP id a640c23a62f3a-ae6b2b34160mr314160266b.26.1751985302632;
        Tue, 08 Jul 2025 07:35:02 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02c6dsm898889066b.127.2025.07.08.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:35:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,  Paolo Abeni <pabeni@redhat.com>,  "David S.
 Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Neal
 Cardwell <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  kernel-team@cloudflare.com,  Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Consider every port when
 connecting with IP_LOCAL_PORT_RANGE
In-Reply-To: <CANn89iLm_hRW3+MHsP8p5aTUStohz0nvWbKTGZU6K3EdRadrYw@mail.gmail.com>
	(Eric Dumazet's message of "Tue, 8 Jul 2025 04:38:39 -0700")
References: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
	<CANn89iLm_hRW3+MHsP8p5aTUStohz0nvWbKTGZU6K3EdRadrYw@mail.gmail.com>
Date: Tue, 08 Jul 2025 16:35:00 +0200
Message-ID: <874ivmhht7.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2025 at 04:38 AM -07, Eric Dumazet wrote:
> On Thu, Jul 3, 2025 at 8:59=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:

[...]

>> @@ -1070,6 +1107,8 @@ int __inet_hash_connect(struct inet_timewait_death=
_row *death_row,
>>                         if (!inet_bind_bucket_match(tb, net, port, l3mde=
v))
>>                                 continue;
>>                         if (tb->fastreuse >=3D 0 || tb->fastreuseport >=
=3D 0) {
>> +                               if (unlikely(local_ports))
>> +                                       break; /* optimistic assumption =
*/
>
> I find this quite pessimistic :/
>
> It seems you had some internal code before my recent change (86c2bc293b81=
30
> "tcp: use RCU lookup in __inet_hash_connect()") ?
>
> Instead, make the RCU changes so that check_bound() can be called from RC=
U,
> and call it here before taking the decision to break off this loop.

Thanks for taking a look. I appreciate it.

That was intentional. Perhaps a bad call on my side.

My thinking here was that since we're already short on ephemeral ports
when these "blocked buckets" become an issue, then I wouldn't want to
dismiss a potential port in case the socket blocking it from reuse due
to src (IP, port) conflict goes away before we get to the second
(locked) phase of the search.

But then again, in hindsight, if we run into ephemeral port depletion,
then we must be under pressure from outgoing connections, so it seems
like a bad idea to put more stress on the bucket lock.

I will rework it as suggested.

>>                                 rcu_read_unlock();
>>                                 goto next_port;
>>                         }

[...]

