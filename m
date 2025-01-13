Return-Path: <netdev+bounces-157742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C07A0B804
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22F816218D
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B7D27E;
	Mon, 13 Jan 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OlIBkFC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF528EC
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774429; cv=none; b=QO4t7y5MJWKG7E8TkAgMjfHfcPtmso4s9Y1yCQ9g76fvn7ZvQIi4Gz0rsgpafpuqShqXU/jVe8qwNGW2sGbpjEOQpt5I7VexasFgZ87ZmA7AyAEGZwOpTl64wfN7NhlFHlr5m8swtmVYfoFumBA2YPHLqJlDVhzXKyI56B3kxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774429; c=relaxed/simple;
	bh=VKCxlUp+rUU15QXBrPGBu4TiJufV/km8774LgpdslXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5QzyM+kkMirmcAcG+NEYzZ3ON6c6ObuQpD59D0suv5+A3AatExkHyAMVIKO56ZS3BJMvKgFcZGJs7ehH4LcA4fRRN3uZHpk3UyzRmVocOik3NuY4Nl/AoDC/eeqXdJw+1Tq6sxIJl3CT8B5OJHP2oZaA4WBjvyQh9F8mFwyvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OlIBkFC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d982bce8f9so8101610a12.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736774426; x=1737379226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysSAzHQtQnM/7TnWW6d9LQIizdTUCgGM5CXcsfHkzdY=;
        b=4OlIBkFC+KkQEvltoxRovtAJJVGHa1kTQ5Fd4NWUvqL764cGTkNBiz5gmsLJrvTOoz
         4qcU5bibumqYbmmiBvyWDpgbPnXojFsEoGPBvxjDpb2hXLWLVGFxB44A/jwGiN5HhcrB
         6H7/S7JfuKS2V6ssTmWCGkEP/Rn8imWyY3sBSugZKaO/u8KFbzzVHUgue3lUP9TaqgWA
         tc2DcMupaDBygLf3cV9E1WceNRZ4VaV+cc/dJKBgTIHDIq8+FzecTOdP+MTqd2mEPmNu
         Cj0brWoYG+lvzeM90zDsP9NubheIpUl1XB8gLOTQz4Aio4XIqvQJgge3Po/2WtYdKMQ2
         pNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736774426; x=1737379226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysSAzHQtQnM/7TnWW6d9LQIizdTUCgGM5CXcsfHkzdY=;
        b=AxuNTVeNhXX5Y6l4wQUR/hQhJ8ZZFuaUe5VanZQY0gBuXfVUa/9/JLe58x6XpEUoGw
         xIWXGqjls0+xk2STeJEHfzZeitnh2eZWMXKLJVZ3RZ9QTAKsgE7ROzYmrMiCu2cx29QX
         c02Ji50E03rPig2Da8qyg4a8qK/NN8CoPiw7oHdQszulmFo9fT9Jp9kPpqulNTn8Yd+/
         Qelmi6I4n8EXWQBHXqh1HmR18gD+/Xm0bmA6LOlKIPWGfOlo3Ob4MW/NdUaI9VE+EM8V
         iynREeES2JXG3y6x3qWGPX5N9jhd5xjfGDw8kQJRybLJ+Ns9mCfN40ooYnhCydfsYc0s
         nh0A==
X-Gm-Message-State: AOJu0YxGPolL5lyZ7zgAfOHLIp/dTmiAo9zPRDIyPaZ/wulSPuzuoByv
	SJ80PPBn01F8rlrBH0THpkEBTHw1PnzdbOOUmaNat5IbphS83KL/0f2icYKh17UHHC//10ID2dO
	u0H23S82Kg3eFYm8z8XMFYZL5yfIGdQpzjmg2
X-Gm-Gg: ASbGncsCsDQzu4672tnBTefk3TWYcNVm0XDwklu3H5sZDBL6ASl1ifq8yi8XivGS9kg
	ETRZp1LUjB5t1TdzMSm0ylrxtabXevQJwfg8Wvg==
X-Google-Smtp-Source: AGHT+IEwognTe8yMlWkavKkJiMjO26dzmXdf9xytrKhJOeMrzLPeDC7Aa3Q5JhuCmAO9piqVyr5dEKFkfw7I6BWmj+g=
X-Received: by 2002:a05:6402:540e:b0:5d0:b51c:8478 with SMTP id
 4fb4d7f45d1cf-5d972e0e274mr18679591a12.12.1736774425718; Mon, 13 Jan 2025
 05:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com>
In-Reply-To: <20250110143315.571872-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jan 2025 14:20:14 +0100
X-Gm-Features: AbW1kvYsg0uvWEPCfXRDz3KPOnIhvG8vifI_3ltIMZyO0vKjnE7p8BeyLfAHCQE
Message-ID: <CANn89iL8Q+11FOBZq-X3kJF-0i5R1zivERQCx-hGHM4CWAFa+w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] tcp: add a new PAWS_ACK drop reason
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 3:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Current TCP_RFC7323_PAWS drop reason is too generic and can
> cause confusion.
>
> One common source for these drops are ACK packets coming too late.
>
> A prior packet with payload already changed tp->rcv_nxt.
>
> Add TCP_RFC7323_PAWS_ACK new drop reason, and do not
> generate a DUPACK for such old ACK.
>
> Eric Dumazet (2):
>   tcp: add drop_reason support to tcp_disordered_ack()
>   tcp: add TCP_RFC7323_PAWS_ACK drop reason
>

I am sending a V2 :
- Adding one SNMP counter (Neal Cardwell suggestion)
- Fix one typo in changelog

