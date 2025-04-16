Return-Path: <netdev+bounces-183519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1372A90E86
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9AE445124
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50663200127;
	Wed, 16 Apr 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="FpC0n1JM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8617BD3
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841904; cv=none; b=cLbluaaX/UJ5bIA3duF2RgC+7GdzvjznNz2/cFfO8GRCZuOB1riux1Uisj0PLBRqIeMgdBj2C4V6o4zrBb9JWrr2eOQUxECJbdWL3sU5KDLHhac8DOU/PrKHRUhBbAks/eWEQMQVJsaAZ6L6+pfHRWQ1XrnpLvWKBZQjMUlYSpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841904; c=relaxed/simple;
	bh=VCemrEPNIoQEBU1oN0HmKJ3Q5kAFJTR/Ly4+yYEWwac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMm+D4DHFxi8KlAi44wFJ3PljEz9ajXhAOw5WqXemo4xjzV0dsyn/uZE2JwGPbcD7JjeDI8n0zH+juA8zmkDpIzNy//kf1rJRQor6W5Re4gN8OBfYMs0jCviSVhJdDxjQwCoskHAlZTumbnwXAG/U3l6uZVpK+8QUPGDMWhAjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=FpC0n1JM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736a7e126c7so72682b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744841900; x=1745446700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCemrEPNIoQEBU1oN0HmKJ3Q5kAFJTR/Ly4+yYEWwac=;
        b=FpC0n1JMIn8p84AyEmx/ZWODaN9FREKLsFE0WSfM5Siw4D0s98EA/BJABpvEPmoUEG
         0M///KvMwWY7QLh00CqgXF7zBz2ydceOYcz3FrF04sk/W60q2GzLY8Zv+4GO13i/N0dc
         iitWEswR8Si28zfU0Ib9ai9LsFVGBTgel/8n6PSxfzDbOEHMn4CnPTiOWiKLmtw67myg
         ia0WGIGC2xAKdiTT93Ga2an8cI2d6ItIpPijS8gzBtY9Es1KXyebI3oFhqEmoVRy3K5k
         0TlZVXdv66yE+0j7hre/xY12LL5h4T6u2E9jM9OBLElvntbt+DbUgjC7fFtjnTLpN3pz
         JugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841900; x=1745446700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCemrEPNIoQEBU1oN0HmKJ3Q5kAFJTR/Ly4+yYEWwac=;
        b=XhDh5V31UFionmOYnOUWvGFbf9HF/qYCeR8KKRiWhahL5InA6l6mv3Z/FRvu/77xvf
         rKXQvCEqphFwTe+51KlW33dv+q3SUkgqh962qt9xcvtSED6wNjYVJ7SnqlqKoYr8DnL7
         G6qTNtEBJkmSw0Vn2q8Il5v6+uqd9tP1P8uWK0cWA7LxuRnfZmYYaqAGNBuT9TzzlKpx
         onqW0c0xU2gAlfWKE8ExELpCeGi5xzmvuJQrjePO+jbkRcvHZELPHK9yYifCa6zd/OwK
         1inAuiYIrfuNYNAwGBpu0nau9yNDsB86UmisH70LvgvJyhSkt+zkehSgGl+wNp6oUZzH
         3wfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm+ZmmnptmeX0GGHYEXqZsGVJ/7r4EqIaNF9m4xrx9ksZlEQU2f4FG/E9x73n/ee7kMMK34MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPRLboZmIZjkszerFSx8dmopfY6OnYY70nPT+UOZ8PVpBPOII
	BCkwZuweBGfpeK9C39D4zujFLCi/2kw60O5HXalEFEx4qngqRu4FxGRDzpj0JD3TQOD7isIgjXB
	S96R6KVR9k7Fu630Hg2v9jEE6zvyHLqDHJjyp2b4ilSrp5vs=
X-Gm-Gg: ASbGncsvABp2JvYmFemRn7j0TB3ymdbdXTXjPwhWpql+rV+JbKEUHHrvzhVth0AjJto
	SQAOgOdgrCuVtbRiGG2LQhTRwZos41h2qGDE1wVtPxYhLTTMfJUtEyaP0Ne0dUbvn5lzhf+lDRk
	dQoLZrjsjgPZqILkhXDQWLWZXxLuRW5IvD
X-Google-Smtp-Source: AGHT+IE/Lk58kaacF4Jl2k/ZktHdR+pjI5AiitSqNs/IbSN2x/kpyvBkA3H9yrf2gCwfFfoLxbO1iTf7V+l006TtqUU=
X-Received: by 2002:a05:6a00:3920:b0:730:d5ca:aee with SMTP id
 d2e1a72fcca58-73c267ecd69mr4811210b3a.23.1744841900435; Wed, 16 Apr 2025
 15:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416200840.1338195-1-kuba@kernel.org>
In-Reply-To: <20250416200840.1338195-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 16 Apr 2025 18:18:09 -0400
X-Gm-Features: ATxdqUFCk9X7eO6fm5AsfXwDznBYAGl5MGiYl_NMSixm0W5n17kVp5sNrly34tM
Message-ID: <CAM0EoMnLaqZMaSqdH88GexEWYVhXFSD9_YyiteurUoWJAdvMjQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add UAPI to the header guard in various
 network headers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	m.grzeschik@pengutronix.de, jv@jvosburgh.net, willemdebruijn.kernel@gmail.com, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	nhorman@tuxdriver.com, kernelxing@tencent.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, idosch@nvidia.com, gnault@redhat.com, petrm@nvidia.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> fib_rule, ip6_tunnel, and a whole lot of if_* headers lack the customary
> _UAPI in the header guard. Without it YNL build can't protect from in tre=
e
> and system headers both getting included. YNL doesn't need most of these
> but it's annoying to have to fix them one by one.
>
> Note that header installation strips this _UAPI prefix so this should
> result in no change to the end user.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

For the tc bits..

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>


cheers,
jamal

