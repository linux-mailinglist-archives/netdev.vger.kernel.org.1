Return-Path: <netdev+bounces-169881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35072A46375
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B78D189E33E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1764227BB2;
	Wed, 26 Feb 2025 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZpyB00N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE64225A39
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581163; cv=none; b=Z/WV5KsoMJKgp1rQlzPQbl96LVcdGJlrd3fp9hzEbLXDyjfYr4gY2UM3Q4waSvvWKVUTNtifap7hqrCpVBTWPLLyXY9qkMXizwK2hxViH0B1lf0q5TAJRvCwQpzkitKS4GJYxqimHNsQKgIi1Sd1SHSw1TVRlKziwGBrW7Ixgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581163; c=relaxed/simple;
	bh=jihNo/Yw8tRh7h785qdoh+h8SMQMktrediGBai4SMhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naqPEcKfWfzjzbcOZ/evUsfkiWxNT8LrYRRZJagKrliO3a/Ndu8xL6rqQ98Uh86nqLVzxul/2XEZYWnIRFMxjyDDO1xJ7bF1IY3NWxEN3IcKpay6KKRYjnttLexHtj3ehipz1r8G/Rx/ct0GJoQ2V9C8pVFlGr3F1qqXytGOxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZpyB00N; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso691731a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740581160; x=1741185960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jihNo/Yw8tRh7h785qdoh+h8SMQMktrediGBai4SMhk=;
        b=2ZpyB00NtiQHWEH4V+MPPXfzzkRp79RnzfqpqqezD6dF4B4or2z+7MAxA5mbxFLEja
         jIHlzfYAHnVnH8mgdYGve7cQvGmQmRIGKv4sqN2tMWg3hFhEYZZiay4vumaqU4R+va0V
         IKpBq+UHtwbV3+KTs+53SHS1/skqMCYzGCwzM5skEtV2kLmIl2rfAR3StxFSqtPp7+4z
         OHWX9qlRacNgKf/F1RMYwacUDDT+EB56QKwEw5w/1UsipZGfrv3fY+uvBgWf+74qhokW
         GeGyGMsp0W56xrHahyxUaAUSIjCMKSwRIOBGlz1ChUJXUxv5M0jWYB6WKYXoMcnWqtSE
         ThaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581160; x=1741185960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jihNo/Yw8tRh7h785qdoh+h8SMQMktrediGBai4SMhk=;
        b=UE1GLcjzs2x1Pkcr7ghh8PfbrDJaMOhVB0QpKzCahwV43rBfqL2gY8b6yVfT5wD+Nk
         do+yIEgBbyD7xxPjFba8/jY1xbU6Pg4be8XR+UdGs3d4YmzUDQxVVFX8x86mfYvybk+f
         dY4fG63XKKck1jb8mWTAFnj9b7WrkcQOjDFoRXP5qja95uPSfy/s9CSK5OUj1oeHAKgo
         9ZIB7avPEvIDXM7oQFUHxMtewbQZrOGXlFtv0O8YxBbPPSTX/czQIgqv6HufkK4OtKme
         4PBYgyAYkP2badpB3xAXxRCnf7rTCidt82nVgtJ53e/yk2MQ/+4yTRQgibq+yrWFsBIH
         Pm2w==
X-Forwarded-Encrypted: i=1; AJvYcCWFW1MdHszrxc0kbGpBVEvFL0NQ0+oQ903r5gVMgwW8LVzQQJ4BgKQImqjXBGPC3A4IPjeZwBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2YPcVpX2NXhD4InnT0PucK7KN19MUSCFrguGCdMhPS7+iFtc
	Lfs+ncEzGYPHMBm7Z/fhxfuYcvwtAqOtTPMrXx865yJFFuWDmsQ5urjdv10Xcw7ew1K+G/OwFHG
	TbIs80WgY7fx1SpbQb9NuZ+HUUUmch68ypFKy
X-Gm-Gg: ASbGnctu0K4WDkWP0lhMvk2KYa5SzB3mkAFmVE0ZAShEk6fjK9rtN6M4ka4vCLdl0df
	EzvnVCiUM9MRNNZflRye/BO61e1vL2ojcxa4ggVh/ph3J6U+HrjTyBEzSdcw7IKg7KGFmpuTq2y
	rXr4CLaiA=
X-Google-Smtp-Source: AGHT+IGgrYEfSWpGqQaKhR9k+hBCb6H7SKyCMHhmEqNNBLgh5vItYiAfTDZOUsdtoJCuTwAUDiOA1XuTPqTaMF169pM=
X-Received: by 2002:a05:6402:4611:b0:5e4:a1e8:3f07 with SMTP id
 4fb4d7f45d1cf-5e4a1e8a318mr3059258a12.31.1740581160088; Wed, 26 Feb 2025
 06:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-13-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-13-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 15:45:48 +0100
X-Gm-Features: AQ5f1JrAJN4A41NddttMCwQ8Ya1Y2S4s8yz7wZ16DKKTTGOeluXDWdvAXTGV8n4
Message-ID: <CANn89i+5HnRqjJKt5VuSC_gkEuDW+3Dt=FWSeVTpXSOcYEp2iw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 12/12] ipv4: fib: Convert RTM_NEWROUTE and
 RTM_DELROUTE to per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We converted fib_info hash tables to per-netns one and now ready to
> convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
>
> Let's hold rtnl_net_lock() in inet_rtm_newroute() and inet_rtm_delroute()=
.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>


Reviewed-by: Eric Dumazet <edumazet@google.com>

