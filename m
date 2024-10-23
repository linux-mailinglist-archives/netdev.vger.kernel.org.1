Return-Path: <netdev+bounces-138304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDB9ACEAC
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90F72865D2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A71BD50D;
	Wed, 23 Oct 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUC5cfUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7991ADFF5
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697121; cv=none; b=K9Ioc+kSuNWDxhLWS6wr6KSUVVmx8EPUquEKFwT0em0MJCt4TavzyzBvAVPmJFlbkG2qW7CN7fvWJQX4KqTH4PItaEBj0zwuhJFWHP4AmgZQWS0MR1UJCH8tUikZIf+owVxGUFiegR5SATdZ3h6fbYnY5IGr13KJlRj6B3jFz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697121; c=relaxed/simple;
	bh=PxOoVsRwr1GAmXjQt0cXjoAz7fpqKkRa5+7/o45wjic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTC1PC+lRyQxXhDDTqoL2Ob5MDudQucexeEYyFvqHuVzQa5ovCaRhVYYepmlykL/WVQ8IwBhkhL+2euLpbgKG6GjgIwVygFhVb+A3rf03JqyEAKPp0OulQFohka9sGu564VUq26QjMgC34y73wxXKz31J5P0gseZTTkiGWIf0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kUC5cfUl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5014e2daso72502581fa.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697118; x=1730301918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxOoVsRwr1GAmXjQt0cXjoAz7fpqKkRa5+7/o45wjic=;
        b=kUC5cfUlXo4jha7EEwU2mVfCA6wWirlIm9KcOrfEOW5tha0VTTQyCjmoows1iKLSSF
         /xm/8rk6MYxCcUmrYJI3TDlA5HTWqQm6rzxxGSF4SM48ClU/ZLBtqiNWBHgwIDQQBNKB
         124OLiighyZHCnCme0C9bW5EnNIoRvVLvs7DekO0GKwGWZRHSMqT9tfUd4F2BlyTysRB
         KmZ1l79HBzvy8AhrmaXr5u5bWX1/hpogWGrNJIltPml4NH5AbwBdDkyons8jHX2YopLy
         dyD8BhDzvy2y+S33fUnvzhMlCPh5f9MrKOngt1YajVpgeokarXhPHi6cWw5op+IFdyPu
         oWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697118; x=1730301918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxOoVsRwr1GAmXjQt0cXjoAz7fpqKkRa5+7/o45wjic=;
        b=vMaeYU5qac/mvUD352fpxtYIT5e3AxaHOQVGrhm182BBj5HI6m2tV8APbGJGQtGz8y
         rzFPi+Cza8v4A0Ux6n43VbYjKeKU357PJaVPYahF2n/1yd7Llc4KezAiEIchBjzRzaEn
         iu0HAiAP5/N5bOXrG3/P2v8IGMMDWkB0m4N5b8RqqC09hmpJE7LZNfhyW2hWlbMneWIl
         GBjULQz4XUQFhdZaAe4HlfhjoKDox6iEUtjQpxURXmvgi4ZQ4xgw0vEw3cW26NmrjOOe
         qfGjLvjuXQcDDzsisG72N/t3QJiPYNiq7z5sPiPPGlXkMUjHEr1/BGucTXuYmdfTtNTr
         yNEA==
X-Forwarded-Encrypted: i=1; AJvYcCUuDSfNrXxjVNEJ8X4meaO+oOEM+r8sTtxyGSQqOmUXagzWfkdfrh8KUKjzPS7qGxfqVfLID9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtne654wOy1abUX3hb4d7UrSxmm6/nlQfFM3dMlFE/+PvU/x4
	XMtDWjh7atOHILwPG9PCTmY33f/52ZvALqtQv/QH7QGHAWcnKix2ud6sfRgHIg4o8hW4ZNiCSWB
	1yj9LVYAeNsPJGW0sHdCsdHm4hB03hruGvjLA
X-Google-Smtp-Source: AGHT+IGYwlqQG8rghxw3df0DH+f388iiZEvTsNwpTr9bgKXluIjtjhILIWBDwO2S8lhxKnaP6/eyI5A6UwX0pdpE39w=
X-Received: by 2002:a2e:a991:0:b0:2fb:6057:e67e with SMTP id
 38308e7fff4ca-2fc9d375a1amr17435271fa.32.1729697117649; Wed, 23 Oct 2024
 08:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-3-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:25:06 +0200
Message-ID: <CANn89iLkm81TriM0Rp7=5YxA3LE=pqA-H3T7JXmXrQ=n1umsSg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/9] phonet: Pass net and ifindex to phonet_address_notify().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Currently, phonet_address_notify() fetches netns and ifindex from dev.
>
> Once addr_doit() is converted to RCU, phonet_address_notify() will be
> called outside of RCU due to GFP_KERNEL, and dev will be unavailable
> there.
>
> Let's pass net and ifindex to phonet_address_notify().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

