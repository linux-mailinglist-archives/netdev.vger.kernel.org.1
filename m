Return-Path: <netdev+bounces-202222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80616AECC43
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AE11708B3
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 11:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026AC20B803;
	Sun, 29 Jun 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zexm7QXo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18501A23A5;
	Sun, 29 Jun 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751196824; cv=none; b=E33LcE6W9/KfAvHiWdd/ynTgTf2LhpEzG1/DEiKCETubLq55FZyUUfT5P8ZRnwkW/O6DUhHnPPnrNn7DTsRvMAogs72OHXXUedcIgJtImdFB1a92F7UKElYzHTKDgyol0AJVpUUCL8KlE07XHkvMf5FSZeW0XcSAN5p99VMstUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751196824; c=relaxed/simple;
	bh=YHfuDLvO4s+WTz6EfY7tnxhIr+USyFtrndUNLdi1SL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbLLfNOsZHAYVIzrEJopdtPU8+R7A/BvfNPO++vXLrAq6dCMMuJpT/4h9zrNjiUigoDcStCVYbd+dl+/QeM1tszolitkBZ2SyPTUmsbQ/JJciP3ht1RLHhqyi0TjhcC3N28JNvi6N29gesbGX6RqCKg3alSfqVD3rk28eXUSuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zexm7QXo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a5257748e1so645287f8f.2;
        Sun, 29 Jun 2025 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751196821; x=1751801621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+LkISIMbaVcGxPRbaMpu9zKtZWHbrQEmpzC/1l+yXo=;
        b=Zexm7QXoac9pUrye+MKOohS6DTDCzvlamr1gxV1189X42Xlu71JxKwj6wxHGO6Lt58
         mwMycBaWqvsn+pggKmjFZhgsanUt0Ru2DRylVDVGLw6nBzKGC3A93ht71mxfvhiMH7p6
         5zIr46D+bp06CRhnXGJTINFLu+Y0Z9euBdtJFgopTIS0obqoIjq2r64buLOhZL/nc7Pg
         4u6I/ZADr7ZffV0TXSULjmo6U0T5/ciz9TPIOcgG0fYcFAboAspN8TKSjy0+qlWAjitg
         fDYrtDc/+sg6wksm8eyV6Q3KtXWegPkd6mKbPIhtSzF5R2Ww998wghM9QrkAKXh2vb8K
         rUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751196821; x=1751801621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+LkISIMbaVcGxPRbaMpu9zKtZWHbrQEmpzC/1l+yXo=;
        b=t+gk9yz7AWprfplMg2edkF4py3vd4w9uYvo6XbVO8OVswI35nnH6RQmkYYsl/qGuo8
         PHNLSIPYsI3E3PpE4CPFtmKB7kZvfzgBhODNCQXOh0y1rSVvJ6dlIOKRjdsYaxVOrXSU
         +lLWwlDN5vCxp/bTTf8kafiKciq1UdawdtuQVUXCALWRGbUXySQ3VyHCWuRPPeF2sGpa
         Efulh9qtYyCXU1l0DNH2vqhkx3beMyh+FDIBk52iZhp2LkQTnZXCkya15KRVMZMMKzZp
         v0R9ccCDFRypOMsOzwA+A+EcuYTVk09AhqEimJdxRpBB+snRATxwQllqGZ98ZDzUbtjL
         U5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmLCo93mptE8o53KujfkKHFqJEmGyWNgqubUwNzctBybjXNhoRXX9NzdLkTOFGa3iVBMv/8ttf@vger.kernel.org, AJvYcCWAgjuMJbFEI7u15tBF9mJSdLhs5Xx/rMT5f9zb/wqctLJPTOMNg7Kh0ureqAAZ+xqRQmyVcOoyRiR4QBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/TFncr+CWxEIXBadwbnrbQuAxj+I2K1T3SBNI9E8bjRSt5Op
	VMGRz7LRToYHzWgydb4WKBCIqI8otYJ4N9ienpNvlwvaQidYBn8el66H
X-Gm-Gg: ASbGncs39jnReEHFjXucAHXcsVCSCoVwCghCRb/D0Uzqjoz0eseQy/jDpxVvv3G7Fb5
	Ccd/hT87plyXGwVbLtre1WpNMyhWWbhiAaPcHTqQ110MhvPCMX+2W2qAjJB0McCSOQBU9ewn3EA
	/jrO0hK1ZvFO/x1BssXJJgx/YhJ0nqnKA5Al2cM8O2SW8b1usOhfGXqSKdKfSKpNq1m+IvxVNtS
	C3JHmjVhPr/Wjsv/jVfoAI/ZIzGaZKSTYNPjhk4DVdJNjjgT+09Z9h6H5MGOzFoqMYmoXh9eK09
	dHoaDSWQmB7SLtb6pAAt8e8LjPp0K1nyFX1aMeWp+6dS4oiHb2p1K6GaKRpVjcZt+lfGELYBACq
	0en+iUsyxvZ/zqRFTNFloZr4Qd4S6
X-Google-Smtp-Source: AGHT+IGE75g6V87wkzQVyW/Ax6z+G8qUEo0lNj0G6+hEMVZHNVZ+KgauIPpgpvDCx+kHzrwpKnPHFA==
X-Received: by 2002:a05:6000:2103:b0:3a4:f70d:8673 with SMTP id ffacd0b85a97d-3a8fdff4360mr6235015f8f.25.1751196821096;
        Sun, 29 Jun 2025 04:33:41 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5aesm7443504f8f.44.2025.06.29.04.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 04:33:40 -0700 (PDT)
Date: Sun, 29 Jun 2025 12:33:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 almasrymina@google.com, kerneljasonxing@gmail.com, ebiggers@google.com,
 asml.silence@gmail.com, aleksander.lobakin@intel.com, stfomichev@gmail.com,
 yangfeng@kylinos.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] skbuff: Improve the sending efficiency of
 __skb_send_sock
Message-ID: <20250629123339.0dd73fb1@pumpkin>
In-Reply-To: <CANn89i+JziB6-WTqyK47=Otn8i6jShTz=kzTJbJdJgC0=Kfw6A@mail.gmail.com>
References: <20250627094406.100919-1-yangfeng59949@163.com>
	<CANn89i+JziB6-WTqyK47=Otn8i6jShTz=kzTJbJdJgC0=Kfw6A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2025 03:19:27 -0700
Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jun 27, 2025 at 2:44=E2=80=AFAM Feng Yang <yangfeng59949@163.com>=
 wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > By aggregating skb data into a bvec array for transmission, when using =
sockmap to forward large packets,
> > what previously required multiple transmissions now only needs a single=
 transmission, which significantly enhances performance.
> > For small packets, the performance remains comparable to the original l=
evel.
> >
> > When using sockmap for forwarding, the average latency for different pa=
cket sizes
> > after sending 10,000 packets is as follows:
> > size    old(us)         new(us)
> > 512     56              55
> > 1472    58              58
> > 1600    106             79
> > 3000    145             108
> > 5000    182             123
> >
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn> =20
>=20
> Instead of changing everything, have you tried strategically adding
> MSG_MORE in this function ?
>=20

Does (could) this code ever be used for protocols other than TCP?
For UDP setting MSG_MORE will generate a single datagram.
For SCTP all the data actually has to be sent as a single sendmsg()
in order to generate a single DATA chunk.

Prior to 6.5 the code used sock->ops->sendpage_locked() so had to do
a separate call per page.
But if all the overheads of 'ioc_iter' are being added it does seen
appropriate to make use of its features!

	David
=20

