Return-Path: <netdev+bounces-47134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F07E8268
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53803B20D17
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AA43AC3C;
	Fri, 10 Nov 2023 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRbvLugB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CF61C6BD
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 19:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34D3C433C9;
	Fri, 10 Nov 2023 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699644099;
	bh=tOtzaRQLsJvnfZ7UqmGNb2QeZ1z06qMZKiPOphdQXwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vRbvLugBu+AoKaoscCVoKFqIYhjTRknEgGLjT1U+zsZeS2flAIQ4D8NIF6G3Qz+pj
	 XPk/78cHsQ6mH2oeoC2/8wbKIyO8A5RD5extpzYmVaLA9NsB1C5Q9EocedVDyWamfv
	 oi2ZlTnxWBNfapvuR8lf6dX8gDglkqN4jk3C2Tu+wAFEE53YAxAckDfibbMu68z2Rv
	 20tct17CzhL0bbASB85wjYw3MsbMC9EXog+XeGT06rIJGLyni0MdSm4A/SKw0F0GIV
	 6CD8adg+xeGWrn5mJs6aBOQVJLImCQEoGnYthXo4p5pOlQzPihtFMnqC87ddT/yeU5
	 PgGEjWiwbpVZQ==
Date: Fri, 10 Nov 2023 11:21:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [RFC net-next] net: don't dump stack on queue timeout
Message-ID: <20231110112137.20930a9c@kernel.org>
In-Reply-To: <CAGRyCJFLytO-k1ekbQE5Z3LN7RVJciB_4Yh9PUVYA3EZeWMG5A@mail.gmail.com>
References: <20231109000901.949152-1-kuba@kernel.org>
	<CAGRyCJHiPcKnBkkCDxbannmJYLwZevvz8cnx88PcvnCeYULDaA@mail.gmail.com>
	<20231109071850.053f04a7@kernel.org>
	<CAGRyCJFLytO-k1ekbQE5Z3LN7RVJciB_4Yh9PUVYA3EZeWMG5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 09:01:29 +0100 Daniele Palmas wrote:
> The problem is that the MBIM standard does not define the
> CDC_NOTIFY_NETWORK_CONNECTION, so carrier loss detection is managed
> through the indications on the control channel.
> 
> But the kernel is not aware of what's passing through the control
> channel, so it's the userspace tool that should detect carrier loss,
> disconnect the bearers and set the network interface down.
> 
> For example, ModemManager is capable of doing that, but the problem is
> that usually the standard modem notifications on the control channel
> arrive later than the splat: increasing watchdog_timeo does not seem
> to me a good option, since the notification could arrive much later.
> 
> One possible solution is to have some proprietary notifications on the
> control channel that detect RLF early and trigger the above described
> process before the warn happens: by coincidence, I wrote a custom
> ModemManager patch for this a few days ago
> https://gitlab.freedesktop.org/dnlplm/ModemManager/-/commit/89ba8ab65d4bfbd4cf1ff11ed58c08b112aca80f

I see, thanks for the extra info!

