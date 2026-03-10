Return-Path: <netdev+bounces-266373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 30vCG6GksGlalgIAu9opvQ
	(envelope-from <netdev+bounces-266373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:09:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1342592A2
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 00:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EABB230240AF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C797137267D;
	Tue, 10 Mar 2026 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxKoj/ko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB1371053
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 23:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184158; cv=none; b=Ci36IhfAULR7xumGjfESx8aM6P1/nWjAQlO2UbawNrbRp7CPDQbK6uxT9bCt64OO/UaDx9Xnw20n2W5op0Ql+8eVFR00eiMxd5yDGka3rXPmB5MSeJlXiwvQotzj5nnGJ1uadwm4tGaSHZaWrKQ/J9aqhy1lsKb6ZSaowHJfMSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184158; c=relaxed/simple;
	bh=pZ58cNGp7FiVPONqDxgEYxZYyOKBMFQVjpjV6yX9SsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=da6xsAbqZCUrMJUp97dkuXWkmKJNBdGg9aIc0n6tDNtpoB+4SpzPwRHzg8dOvyUzPkbjOacWHT1U16jMiGvFp4i3usdANnbrTvglMAdLSyDtayDNa7vuvll+bIdakjaFjBYH0NOisVDle9T/mhmTUKSiOV1o54LIB4yYXA4wwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxKoj/ko; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso22970855e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 16:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773184156; x=1773788956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbJBr0HEiXYCW71Jk8MuoGm/RlPukS0X9H3Qzzqpl0U=;
        b=PxKoj/koMG1EKEnLP8c4P1pMUdx6ABVSrlNJzSuUyQyTpQBwzVebz1TdWympwqvPCF
         Zi+tpSjUGkRoaPVyHE+wmrFxwSETTO8tqCdg2jNljYPCxKa8Mm8pnkbupVJLQTtfcfe2
         UPUZ7lzp7D1Y47TK4tS6gIVChDgrgwjOJb08+b93BQADN5ECHK2FTdu+WrD0LpnRZ9HR
         JlQliJ7asZ9NzQRh1B9LlwvYOHZU0r/mStlWzu+rpoOx4eLMUybHit5q/u+Ld2VwhTdH
         eezWmVHjvFiuKQylEQvEVLMFN2qeOfVL8GpNLvTmHt5tjpANQyD/Q6io9EQ+d0Q1R5zP
         mz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773184156; x=1773788956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbJBr0HEiXYCW71Jk8MuoGm/RlPukS0X9H3Qzzqpl0U=;
        b=FUoFOUYKUTw2g6kb/Sd/36D/E8EC1OtNM0zaia3K1+cD/yqsARSD5M0z6X98FR2kw0
         s4MekouOGG089uJtnuugeYJId9VykJnumDCg+75fKr+fqSBP15y5yU8ytH/LKcmmnuZY
         OXlJxG5OpLdg0qOxi1JH6e92gB62Px8VGLvFXb9FNRyx1+vos+v2RrSNAFWMn6mXtOxS
         6V1nOc1hPHOhmPQl/m9gZ8GfxpliRPNE/tgeqkV3Mngcy2Y/2RH7LLPTZP5q6+aAH68X
         NEtH020WGHTAdcC/uQKOxwt+jBAI2Qf0GRePJ8blfqF0z1IvOdDFuhRqjD5U0shG9zEO
         AJQA==
X-Forwarded-Encrypted: i=1; AJvYcCWhKNjvhaLwgkEATL61OnIzJXuyuJHt8ZFn7ZRhBDB82xSJJLJeIaeFOF4OFcz6g9ioHF/leSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWNuCCLd9zXwMvALjetaaOzPbIxHrR0YYsRnkSaRCC3X1FlBf
	nC5Qu2o+UNxllXfCbpndY/X/ULrJ9P95Dim+vYA4ohsV/upuht0YFxiy
X-Gm-Gg: ATEYQzzmpK1vB2DCQxS1M8OWzPTyZFEL+3AsPSaapm4fbdh60qSreoH62XkoVJ5rAj1
	LvIxUKjUPL6aYTfaYJcpLfA3L81SsSfLEzBS5wYUEO9jHJUecidS/B9A+dNAD6qEU8WZ1O+zFzd
	iaLxP2qstJybVokc2/F71V/54wK4Yw9K7MVP5kLw6ogsDSTqJBK+loHg07gOnw9ZM6COug1C5L1
	1PevDcg3Fjb4AKTzdopwPq0zYGfR0G+YK6rwYiXgFcJG8zqsYNotIQv8vwx1o7bnGfc2e0mxbhf
	6UEbXwpTHTv0UKbX95c8f9neRPf157HGNOyAKpnQHTkl6IsXOTfNo/iC/6b+FxGOisv8+hTtvGy
	Z1rC5MY35S9PsV22OrmlpB+JHYJfaFRBpspPWMTd/KBB5gnvIxu2ulwSZCHXvIuzZLSpsy9I5g7
	AJSN4gNX824qGJbPpxVtDuZvV2KjIlXStAp7e3WcWG3TK3ETuWwc2TbUJ0wJS+Dg==
X-Received: by 2002:a05:600c:4710:b0:485:3b00:f939 with SMTP id 5b1f17b1804b1-4854b0bafa5mr8549225e9.8.1773184155268;
        Tue, 10 Mar 2026 16:09:15 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2ef5.dip0.t-ipconnect.de. [91.46.46.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a18bcf4sm11438625e9.0.2026.03.10.16.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:09:14 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 390E7302C898; Wed, 11 Mar 2026 00:09:14 +0100 (CET)
Date: Wed, 11 Mar 2026 00:09:14 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next v3 6/6] selftests/net: packetdrill: add
 tcp_rcv_neg_window.pkt
Message-ID: <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
X-Rspamd-Queue-Id: ED1342592A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-266373-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gandalf.schnuecks.de:mid]
X-Rspamd-Action: no action

Hi Eric,

On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> >
> > From: Simon Baatz <gmbnomis@gmail.com>
> >
> > The test ensures we correctly apply the maximum advertised window limit
> > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > is properly clamped to zero rather than becoming negative.
> >
> > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > ---
> >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd192ed2b59b0a4399
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +--mss=1000
> > +
> > +`./defaults.sh`
> > +
> > +// Establish a connection.
> > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
> > +   +0 bind(3, ..., ...) = 0
> > +   +0 listen(3, 1) = 0
> > +
> > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > +  +.1 < . 1:1(0) ack 1 win 257
> > +
> > +   +0 accept(3, ..., ...) = 4
> > +
> > +// A too big packet is accepted if the receive queue is empty
> > +   +0 < P. 1:20001(20000) ack 1 win 257
> 
> We do not see the answer, it seems this test is not complete ?

Actually we do not want to see an answer.  The packet won't trigger
an immediate ACK (it is larger than the advertised window, but does
not cause immediate memory pressure).

When we then send a RST before the delayed ACK would be generated:
 
> > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
> > +   +0 < R. 20001:20001(0) ack 1 win 257

We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
been updated yet, but we must still accept the RST 
(rcv_nxt == 20001 > rcv_mwnd_seq, tcp_max_receive_window() == 0)

> > +
> > +  +.1 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%

And we verify that we accepted the RST here.

Given how subtle this sequence is, and considering the limited value
of this test, I am also fine with dropping it if it is too fragile or
confusing.

