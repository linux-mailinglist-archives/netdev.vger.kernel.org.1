Return-Path: <netdev+bounces-45877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149D97DFFFD
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 10:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024BC1C20925
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 09:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79282CA51;
	Fri,  3 Nov 2023 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JSxjwIvb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="89sObo0r"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA78A1842
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 09:27:12 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC41AD
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 02:27:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id BE2CB21903;
	Fri,  3 Nov 2023 09:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1699003626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqMNQyNDwmaZC7l8pKL+xDFIiB0pHy0370I2O7TtWxg=;
	b=JSxjwIvbAI+rfBRqOdedxUOd4NuUgcYv+7a4wNUkYNoWKAOZ8/COK/OPNB2fLFWSvxiRIP
	KAHR0ZzSJ67PUq852u+yG86B/MwHkNuJBLJcZuRwCr2muj7lmeEvOwPoLjTwcsbfKGQCAM
	p8NCJPPClBxox2irIL7Ms0ynvWiPFOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1699003626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqMNQyNDwmaZC7l8pKL+xDFIiB0pHy0370I2O7TtWxg=;
	b=89sObo0roggOIvTRnPsiLw+U7xxzNhTdKl8rxvirgkL7v/mlwXbtOnABzmPglx67ybF39u
	WJaJW9MDpvecEEBg==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn1.prg.suse.de [10.100.225.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 635182C162;
	Fri,  3 Nov 2023 09:27:06 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 427162016B; Fri,  3 Nov 2023 10:27:06 +0100 (CET)
Date: Fri, 3 Nov 2023 10:27:06 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
Message-ID: <20231103092706.6rw2ehuigxfdvhlc@lion.mk-sys.cz>
References: <20230717152917.751987-1-edumazet@google.com>
 <738bb6a1-4e99-4113-9345-48eea11e2108@kernel.org>
 <c798f412-ac14-4997-9431-c98d1b8e16d8@kernel.org>
 <875400ba-58d8-44a0-8fe9-334e322bd1db@kernel.org>
 <CANn89iJOwQUwAVcofW+X_8srFcPnaWKyqOoM005L6Zgh8=OvpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJOwQUwAVcofW+X_8srFcPnaWKyqOoM005L6Zgh8=OvpA@mail.gmail.com>

On Fri, Nov 03, 2023 at 09:17:27AM +0100, Eric Dumazet wrote:
> 
> It seems the test had some expectations.
> 
> Setting a small (1 byte) RCVBUF/SNDBUF, and yet expecting to send
> 46080 bytes fast enough was not reasonable.
> It might have relied on the fact that tcp sendmsg() can cook large GSO
> packets, even if sk->sk_sndbuf is small.
> 
> With tight memory settings, it is possible TCP has to resort on RTO
> timers (200ms by default) to recover from dropped packets.

There seems to be one drop but somehow the sender does not recover from
it, even if the retransmit and following packets are acked quickly:

09:15:29.424017 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [S], seq 104649613, win 33280, options [mss 65495,sackOK,TS val 1319295278 ecr 0,nop,wscale 7], length 0
09:15:29.424024 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [S.], seq 1343383818, ack 104649614, win 585, options [mss 65495,sackOK,TS val 1319295278 ecr 1319295278,nop,wscale 0], length 0
09:15:29.424031 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 1, win 260, options [nop,nop,TS val 1319295278 ecr 1319295278], length 0
09:15:29.424155 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [.], seq 1:16641, ack 1, win 585, options [nop,nop,TS val 1319295279 ecr 1319295278], length 16640
09:15:29.424160 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 16641, win 130, options [nop,nop,TS val 1319295279 ecr 1319295279], length 0
09:15:29.424179 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 16641:33281, ack 1, win 585, options [nop,nop,TS val 1319295279 ecr 1319295279], length 16640
09:15:29.424183 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 16641, win 0, options [nop,nop,TS val 1319295279 ecr 1319295279], length 0
09:15:29.424280 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [P.], seq 1:12, ack 16641, win 16640, options [nop,nop,TS val 1319295279 ecr 1319295279], length 11
09:15:29.424284 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [.], ack 12, win 574, options [nop,nop,TS val 1319295279 ecr 1319295279], length 0
09:15:29.630272 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 16641:33281, ack 12, win 574, options [nop,nop,TS val 1319295485 ecr 1319295279], length 16640
09:15:29.630334 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 33281, win 2304, options [nop,nop,TS val 1319295485 ecr 1319295485], length 0
09:15:29.836938 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 33281:35585, ack 12, win 574, options [nop,nop,TS val 1319295691 ecr 1319295485], length 2304
09:15:29.836984 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 35585, win 2304, options [nop,nop,TS val 1319295691 ecr 1319295691], length 0
09:15:30.043606 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 35585:37889, ack 12, win 574, options [nop,nop,TS val 1319295898 ecr 1319295691], length 2304
09:15:30.043653 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 37889, win 2304, options [nop,nop,TS val 1319295898 ecr 1319295898], length 0
09:15:30.250270 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 37889:40193, ack 12, win 574, options [nop,nop,TS val 1319296105 ecr 1319295898], length 2304
09:15:30.250316 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 40193, win 2304, options [nop,nop,TS val 1319296105 ecr 1319296105], length 0
09:15:30.456932 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 40193:42497, ack 12, win 574, options [nop,nop,TS val 1319296311 ecr 1319296105], length 2304
09:15:30.456975 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 42497, win 2304, options [nop,nop,TS val 1319296311 ecr 1319296311], length 0
09:15:30.663598 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [P.], seq 42497:44801, ack 12, win 574, options [nop,nop,TS val 1319296518 ecr 1319296311], length 2304
09:15:30.663638 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [.], ack 44801, win 2304, options [nop,nop,TS val 1319296518 ecr 1319296518], length 0
09:15:30.663646 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [FP.], seq 44801:46081, ack 12, win 574, options [nop,nop,TS val 1319296518 ecr 1319296518], length 1280
09:15:30.663712 IP 127.0.0.1.40386 > 127.0.0.1.42483: Flags [F.], seq 12, ack 46082, win 2304, options [nop,nop,TS val 1319296518 ecr 1319296518], length 0
09:15:30.663724 IP 127.0.0.1.42483 > 127.0.0.1.40386: Flags [.], ack 13, win 573, options [nop,nop,TS val 1319296518 ecr 1319296518], length 0

(window size values are scaled here). Part of the problem is that the
receiver side sets SO_RCVBUF after connect() so that the window shrinks
after sender already sent more data; when I move the bufsized() calls
in the python script before listen() and connect(), the test runs
quickly.

Michal

