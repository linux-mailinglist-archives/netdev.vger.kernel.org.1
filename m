Return-Path: <netdev+bounces-245331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB9CCBA67
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 12:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5429303ADED
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF94324B3E;
	Thu, 18 Dec 2025 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuM9u0fF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501931771B
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057978; cv=none; b=u3xnBMeK/2yFSH190BC35sgacVJ+84M+BsVgbOfv620vvZAF0SObYuBhxrsoAVKBeAvFRWRg1uC6xxzPEJ9/WJTt350Q6wEF757alH9Ud82bC8jbMbCijxszO2Vr5sLdneoBf9ELqhesFtrl5AVk+JW4/3eDrL3qKmMeueExupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057978; c=relaxed/simple;
	bh=E6XW8HAGKSL+N7vd+Tp+ttC+ur0sO/zZr5Sh9W5EomE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dFfYIH6VY3J1nM7hPlvg+AKROtNh/PlyEt1e6D5vETkQP8xzZbtEVZWMcBG9LnV184y1H/6NVD7BKhHxWYX2Ib5x2UXEW0Hql8myQSieDz4lbQJfdXt1jLC1icYxRAQfp1+lwF9nNEjr0L1hvoED2YYaihbL5GE+g6sLn/rU534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuM9u0fF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b735c1fe67aso9048266b.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766057975; x=1766662775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6XW8HAGKSL+N7vd+Tp+ttC+ur0sO/zZr5Sh9W5EomE=;
        b=CuM9u0fFghS16zJRSf4xcDv4V3DochaZB1RMrfseRzVhESpPJcFaKXZiP0FRAetGQq
         kJxB+jbcOVZWVwQ82eoBKgEQwHhl3HdY/qW/+6Tqqu75apZ/329RawWPL9TRqMrSy3N5
         lp3lzc2D7ZgHS8kBWW6v/AGHIM+zU1peiQA/l6w5VqvdNysn6aBL65lcGIkTAPFvg1wr
         n04Csi/w9eLwF/DxzbyqW9MtsyYa88OtsWvzlNhGnrURGsrEUcBo3JZHAedOliUYToRe
         a+HelguNi3URRh4NbzgYXOWP+IO8om0ft3zDf1yCmIYN9nmwjg0Vc2VdAtEiQ86Wc6N/
         AZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766057975; x=1766662775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E6XW8HAGKSL+N7vd+Tp+ttC+ur0sO/zZr5Sh9W5EomE=;
        b=GbalvurxVRc2dV6ilufz5Q9LmhDFARbwEXYT2sUtkp5u6xdZ/YoU6HS6xqu+mptPZO
         24lVzddHyeSe99irNQFdhu2SVe+kzMJMN73BwRvOjguLMCPY574106af3QgqjHTZrQtU
         ncQOEPXBhn0OS7SbjyndVBoybo+bbJN7SeuYUAJqiy5lx0AyKkVMkUBZYT8vrqE+i9lP
         r+WjPIobPaQGNIFTy9HP7e5Yivrr6FUMbDZTsVw7qfRsI4NvQQMpGqJShXpSnilgRkub
         R4ZMa9ScGwyDpDGAM97e779D69HxUFsruwwWPRJdeyToa/ZFAgybl9iwrCEL1WT9vh5h
         EuCw==
X-Forwarded-Encrypted: i=1; AJvYcCVNKmGKvHN/Dh+iBt3MeTzn6VJ8OK3cDXrRT7PUl6BPZL2DWaWpjAv8CK4pW4Mc7cJLqlzmQMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkOuVEMWEhT1IPGzbS1KO9yfq/zMh0JCyHeZ02wncI7IcoUeb2
	yAt0R6aVbG1VBG66rMtc3hIuMhr7HFcr9k0rjJk6bhxjJh6kDvMJSjj4xsJhfjrpdb2W3vc62KR
	kTTv4JxgH3t7IYhH3mBZ267nZHyB8KYg=
X-Gm-Gg: AY/fxX43vKi7CVnoc9fVrk2RaP9PFJraWlxINmythd1QSM7rrH/RZp1JYXOUmWLzpu5
	xdF4i+6nnjKqJrG9L8oLhmrrEFZEanNysxiM4GXiYzjYLmZ3zqQFTz2PdS2VvTgJRybowedZtPM
	XTk+RUT4205y8+vvTLUoVT7y0xTT8gjV5hvz7/TK/5WqnGOj9giPSZbWpQltlpEY34T3/rlPXsv
	6pWiyMK5OqFhqqKaO/GTEfYXTgfAK2dVa0n0ZBM2jcIlHL+9a8sK+82gWEnUp9qEsFczMam
X-Google-Smtp-Source: AGHT+IEHXd0fiMSjnFDB4sW5yUNgYnbuh38GdBTbfEbvDxs3crnqi6axr5mXlgkFPnLcSgXqx80Ns0LreHRiLKXCnEk=
X-Received: by 2002:a17:906:794b:b0:b7a:6e46:d5e3 with SMTP id
 a640c23a62f3a-b8024efa149mr107685466b.2.1766057974516; Thu, 18 Dec 2025
 03:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217124659.19274-1-pioooooooooip@gmail.com>
 <20251217124659.19274-2-pioooooooooip@gmail.com> <ebb7cb16-781b-4f33-b7c0-3c5dd383913c@kernel.org>
 <CAFgAp7gP_yk7nF_AN+B_DRDJW--ytCKKQToG2m6y4h_SLBBaLA@mail.gmail.com> <69a6d938-e576-44cf-bcac-e86f30f24cb2@kernel.org>
In-Reply-To: <69a6d938-e576-44cf-bcac-e86f30f24cb2@kernel.org>
From: =?UTF-8?B?44GP44GV44GC44GV?= <pioooooooooip@gmail.com>
Date: Thu, 18 Dec 2025 20:39:24 +0900
X-Gm-Features: AQt7F2rBrFOn1izDAsEPUAa81WzVwGVRKrQvAN3ZKm3crcbcOPzu6Hu7ZRDEYQ0
Message-ID: <CAFgAp7izWwmDQPXq0oWJW0a1TS6NLtvXUYqD3cygRgQ0KoSbsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED
 in nfc_llcp_recv_disc()
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-nfc@lists.01.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I ask why do you think your code is correct.

Because the current code can execute release_sock()/nfc_llcp_sock_put() twi=
ce
for the single ref acquired by nfc_llcp_sock_get(), and it can keep operati=
ng
on llcp_sock/sk after the first put/unlock. The fix ensures exactly one cle=
anup
(recv_disc) or exits immediately after the CLOSED cleanup (recv_hdlc), whil=
e
keeping the existing DM_DISC send behavior.

> The refcnt has imbalance only if you assume initial refcnt was 0.

No. Let baseline refcnt be N before nfc_llcp_sock_get(); sock_hold() makes =
N+1.
CLOSED path put -> N, common exit put -> N-1. So it drops one extra ref
regardless of N (whether it immediately frees depends on N). git blame show=
s
both cleanup sites trace back to d646960f7986.

I will not send a new revision until this discussion is resolved.

Best regards,
Qianchang

On Thu, Dec 18, 2025 at 7:22=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 17/12/2025 14:05, =E3=81=8F=E3=81=95=E3=81=82=E3=81=95 wrote:
> > Hi Krzysztof,
> >
> > Sorry about that =E2=80=94 my previous response might not have made it =
to the
> > list/thread.
> > Replying here to address your concerns before sending v3.
> >
> > 1) DM_DISC reply after LLCP_CLOSED
> > This is not a new behavior introduced by my change. In the old code, th=
e
> > LLCP_CLOSED branch did release_sock() and nfc_llcp_sock_put(), but it d=
id not
> > return/goto, so execution continued and still reached nfc_llcp_send_dm(=
...,
> > LLCP_DM_DISC) afterwards. The disc patch only removes the redundant
> > CLOSED-branch
> > cleanup so release_sock()/nfc_llcp_sock_put() are performed exactly onc=
e via the
> > common exit path, while keeping the existing DM_DISC reply behavior.
>
> I understand that you did not change the flow. I did not claim you did.
> I ask why do you think your code is correct.
>
> Do not top post and do not send new versions while the discussion is
> still going.
> >
> > 2) Initial refcount / double free concern
> > nfc_llcp_recv_disc()/recv_hdlc() take an extra reference via nfc_llcp_s=
ock_get()
> > (sock_hold()). The issue is the mismatched put/unlock: the CLOSED branc=
h drops
> > the reference and releases the lock, and then the common exit path does=
 the same
> > again. This is a refcount/locking imbalance regardless of whether it im=
mediately
> > frees the object, and it may become a UAF depending on timing/refcounti=
ng.
>
> You did not really address the problem. The refcnt has imbalance only if
> you assume initial refcnt was 0.
>
>
>
> Best regards,
> Krzysztof

