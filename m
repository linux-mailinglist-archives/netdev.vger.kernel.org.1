Return-Path: <netdev+bounces-111506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE6C931666
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF171F21DB8
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C7518E774;
	Mon, 15 Jul 2024 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRXkSC9t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBD18E76D;
	Mon, 15 Jul 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052617; cv=none; b=oru8Wm4pZvgiPH/8l3ahXbdkLuF0YtyFHpmjG4ZDVMAM39z5S06UFExDzG2QUjgnu9JV69/2T5b4s0i7c436x/vO7Xq6x1/02FYkULNyZSfdvom3d24TjASgE6d4pFU/OXZqttjmoFcZiNNTr5w09nONUdeRaPEb/vRW9xYm5o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052617; c=relaxed/simple;
	bh=u5b0ub2VwLry+AXt7LnUxK290f3uLSPjW34khDg5Msg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StrvqmM3a/0ygnGxQQYBSjWhtbXzQyUuHEVj5HgxAXFTIHpkb933xHOxcMKZnbtpVOvbCawT/Fs0mGBnIiYy3XoPP7Iai0Y7yEw9jR2ppaWjKlcV8nJ4dodY8C8jTck7nN/PpK2auwBaY+rFEMtPIYmAwAjianY3sNps4B4URcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRXkSC9t; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c96f037145so3529155a91.3;
        Mon, 15 Jul 2024 07:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721052615; x=1721657415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5b0ub2VwLry+AXt7LnUxK290f3uLSPjW34khDg5Msg=;
        b=GRXkSC9tLC9okJ1c11Cd8alEoYfSmY6FlJ00UZoeom8InwRLM9uhBBQucMM0Hdst23
         xDVO868cDGZma+3xZmiCG0n0z4Cpc4awnI+SyjUabXNdCr7L5kHOTZmfv1TaEpdFwmN8
         B4AlFyN3J14uhaebE/Sy6HZjA0J6dubbPvLGo7U+EGirQZVVKXVVSlfZmw6c1A9kAE49
         JuMq+UMSmFjw5/+WtS9ZmdlplKEd6VHAgTrHV8Hd8+lwkSyPwz7R1QioWcMBF519pr4E
         UxUI0g61+dK8Op5Qa0OxdUz79jq4cIEG5gYkKFaJwGuicn6iTC+zCEtlpgroDzX1576k
         1vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052615; x=1721657415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5b0ub2VwLry+AXt7LnUxK290f3uLSPjW34khDg5Msg=;
        b=wzYJ6DPaT8nZaJdAh/6YrECilMLcoEa3cguKtoIh4emK6HZOHkfivSH/eqfOWy0Kv1
         xxpJDYoDE2qmcpRHauhbtnCOlDQ8UCXmKk2Y2JxrYCXdQUCmUHehZUMUNcorU+FW2275
         6ZbDI/DZNwwTMzeXkOI9mLXO1QF+2YHpSjnt90c+66sDxNS+8w/OJAKy19D+fgZMwGc9
         N9ELNt4vi9jfQMIjD5e9hGkN6WF2OyBFlk8rZBAZofb8R2CCuRQSnLmgEdJrT9+xbHXK
         Zb2NU4Q1OZZhX5W2Y8f+1Q/fkq5+wYlHUjotKJmU5FTSrBr3Gwjxs2PoFjYTWPaIa22G
         k4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWwJpeHZvlOrbb2b858LhrKi8XytAa5HCLgjWwIO1DfvT92VTwL5EiA3XmKbjTPyuhfLTQOigkOKpwIbLfm+W9kSI8zAGJr7kSptJmNvfEJU+JoSQ4vqMpM2RbhqfetHtV0Rgcc0n2D
X-Gm-Message-State: AOJu0YyoO2LChNOLINKKybYtwJjSi4PW6ku/qiGjn+kO8civcHUWexgm
	YPAyTtDXzci/ybxTqKVAM/Mo7qZoGX/i4skHnlebRcfAD1tRr4gkVUxxZ46RJOTPTP8MDfTTDzW
	d9TLQwNWRdACoRZlkoGRO44ZHSmo=
X-Google-Smtp-Source: AGHT+IEx/KlnqJy9Xt5PK/eBX6iSAtkD4hLoxq/wXnNwnE/BOmkr78SurHONH8cJ0Bs5pQmXGIle2t6wgLlqLx/csko=
X-Received: by 2002:a17:90b:1989:b0:2c9:7aa6:e15d with SMTP id
 98e67ed59e1d1-2ca35c304d2mr16025754a91.20.1721052615466; Mon, 15 Jul 2024
 07:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
 <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com> <20240715070555.64c2773c@kernel.org>
In-Reply-To: <20240715070555.64c2773c@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jul 2024 10:10:01 -0400
Message-ID: <CABBYNZLAEmadeQPn3WNcqeCrozDJWM=aHYApvhn+2MSYV-7NTQ@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, Jul 15, 2024 at 10:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 15 Jul 2024 09:59:57 -0400 Luiz Augusto von Dentz wrote:
> > > Luiz pulled the immutable branch I provided (on which my PR to Linus
> > > is based) but I no longer see the Merge commit in the bluetooth-next
> > > tree[1]. Most likely a bad rebase.
> > >
> > > Luiz: please make sure to let Linus (or whomever your upstream is)
> > > know about this. I'm afraid there's not much we can do now, the
> > > commits will appear twice in mainline. :(
> >
> > My bad, didn't you send a separate pull request though? I assumed it
> > is already in net-next,
>
> unless we pull it ourselves we only get overall linux-next material
> during the merge window
>
> > but apparently it is not, doesn't git skip if already applied?
>
> Sort of.. it may be clever enough to not show a conflict but it doesn't
> fully skip, both will appear in history (somewhat confusingly).
> It's better to rebase back into order, if you can.

Ok, then let me rebase and do a git pull again so it appears as a
merge rather than individual commits.

--=20
Luiz Augusto von Dentz

