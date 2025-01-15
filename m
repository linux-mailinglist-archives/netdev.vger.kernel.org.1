Return-Path: <netdev+bounces-158348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475EAA1174D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B3F3A5FC8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D04206B;
	Wed, 15 Jan 2025 02:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8A/W02w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E286FB9
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908414; cv=none; b=WzsuIZWD7aaQjd7k7HM0qNY/qw+q1GUnA8QixdyKyGi/6K2VV6382nLq8umNEVRczW7N9C6LdZyefEWCF8+sYdaSfGNOQCq8daTzXVmc+LUpR4NtlcKs/zECkZq7y+n4WjzGbEDleF+XJ6imS0jD3Htacs7hwdVqDvbVyQgL+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908414; c=relaxed/simple;
	bh=bh8totm4Zm4sXlg935lfzlVZ2dXzuc4blVHVXkaWqwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvj9vw5iQoUhveCMIloL2nfnoEwAI7eDGzBNCXw1J1cEztwZ/wGViZD/rZAja5vlecK6n9xKqn2UQRZCNbXkR6R/PkA3AHUwuxPKDpxfObjkSsj4csswEAqAb6js9wCfT0yI/Ry6fhk4S7A8Jk4RgoO8XfbKpvwPMyx6QE2qtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8A/W02w; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce7a33ea70so7898115ab.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 18:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736908412; x=1737513212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh8totm4Zm4sXlg935lfzlVZ2dXzuc4blVHVXkaWqwg=;
        b=h8A/W02wGsBfGXahHxPSjjQLtk7mV9pGlklikoICVQH6UYJYP2hAw3rsnh+R8LIMIK
         btkD59GCfYL5H9GaYG63U0YLvHUqjuDUrUz8121K0vd1gimKcr+VHVLc6HQJcZcswMVe
         lwoQaiTT25Q6MRT6u8T0QEitLuJljGA8H+bhw0GQUOsToCWwIx5W99RaaZafp8YDMCbJ
         FhDWxfJhPxLsQWvkWSksXRBOQM9cEeE2K504oO12litOlDYxAdR5GXxtD9HNxff/RC60
         ECl80mEUJ6noyfmZT8bEN+kZtJz4xevV/oPloV6iqK86oBlIlUI1K8GnOUfo4H2gwH8G
         VK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908412; x=1737513212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh8totm4Zm4sXlg935lfzlVZ2dXzuc4blVHVXkaWqwg=;
        b=ScnycSuUNqKi3Bk1rCVWYX8Flh8bavAVriJ/7MiF+PRyUb29GRNKGWTWapvvUErdvN
         F1x+gwqLN47l9Icyg0A2OUBXqVBIcOBSm65pou7iwEgv4QZqqp462Oy8hczMWxvo2SZa
         Wy6sPFjFLaWQL+XNJv4/C3w3RDCI5Q7lhML2zqJhpN0VP6lZF6MGzyNYnXIYXRDRWsR7
         KDef4NfnEjKmFO97PdWaJcLgY02LbQJ3EPsmbbYU/Gt9JqAgZs6bYbHOp8a/uSOSs3f8
         hm6YzQTPtS184PDSv2ZrBWCXZyYnMLMWnacUAq6LlEms0kQrsoyxFU/Z7chmvXB0vT4L
         4P7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFTPVGH5ooSHysdsV1jWIUOHhF9regdOAP1VvK9Lp++Dzcf8409VNQvnH6kuEHMsxDO2ejIMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyiRWvCBrDNJivjzr92F4YF3xvTPEdrgzrcMtEEn+lAUvJHUf6
	ziIaqJBcoPlWIQtTZw6CnnSLbF+WFJTn+0X54o0ge/diGp/qYRY+tJi99ceznFbkWBg5fpBzV5C
	jblTMz7Ljp1I5vaib7vPEshLWv/s=
X-Gm-Gg: ASbGncsoYCJwlvJHxatJJ4XZhRoKhtK1bUkjnEgaLQ49I5i1M+w5W/yJ1U0PWsBuGIo
	hAbBCOh5k2tatuvRAUdDjc/rMIYphD59+dZfwGgpL
X-Google-Smtp-Source: AGHT+IF+5Auh1Gz8ZM2CsjXH7EbBF18lq3Uu5NboAXo7pwkQVcO1t2FKRB/uDWr8xx1jZ56M95WVsAkO/+EER33tX5A=
X-Received: by 2002:a05:6e02:1a82:b0:3a7:fe47:6228 with SMTP id
 e9e14a558f8ab-3ce3a9b5739mr207510435ab.6.1736908411650; Tue, 14 Jan 2025
 18:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <17d459487b61c5d0276a01a3bc1254c6432b5d12.1736793775.git.lucien.xin@gmail.com>
 <8cf44ce9-e117-46fe-8bef-21200db97d0f@fiberby.net> <CADvbK_dYKMvZ8iUS-CvzNYYue1qxTsWXDpvcETyBD+sWOJcaSA@mail.gmail.com>
 <b7b144d9-7099-42b1-b057-f6101b4580eb@fiberby.net>
In-Reply-To: <b7b144d9-7099-42b1-b057-f6101b4580eb@fiberby.net>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 14 Jan 2025 21:33:20 -0500
X-Gm-Features: AbW1kvaeadmeMju5a6E7qDWoJ7rAtgoJ1MA5iUjuy_J3upyxvcRdb44zlfAKjeM
Message-ID: <CADvbK_dq+uxtuH8H8jnPGQgzSSPMh50Q2fbkvhDPQ-O1OqgOCw@mail.gmail.com>
Subject: Re: [PATCHv2 net] net: sched: refine software bypass handling in tc_run
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Shuang Li <shuali@redhat.com>, 
	network dev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 12:33=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <=
ast@fiberby.net> wrote:
>
> On 1/14/25 2:30 AM, Xin Long wrote:
> > On Mon, Jan 13, 2025 at 4:41=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnese=
n <ast@fiberby.net> wrote:
> >> I will run it through some tests tomorrow with my patch applied.
> > That will be great. :-)
>
> Hi Xin,
>
> Given the already posted changes, when I rerun the benchmark tests from m=
y
> original patch last year, I don't see any significant differences in the
> forwarding performance. (single 8-core CPU, no parallel rule updates)
>
> The test code is linked in my original patch:
> https://lore.kernel.org/netdev/20240325204740.1393349-4-ast@fiberby.net/
Thanks!
I will post v3 on net-next.git tomorrow.

