Return-Path: <netdev+bounces-267780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCT3FPiVtWnL2AAAu9opvQ
	(envelope-from <netdev+bounces-267780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:08:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B5528E173
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DF3E301C944
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438432AAD6;
	Sat, 14 Mar 2026 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWFty480"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCC32D42B
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773508030; cv=none; b=f2LG4gXcK6wt+GckD31GQxhKz5wOLQMzAtP7PSHK8z1qXxRhWCRJmRBswGWdUvbWvqKjc7dtMSRPFhd+HXa5xC6+xKd5V18wHOwoSVdgbiO36tzp1/6PfHfvGZCicJC0piTYAESntnJfbVKhN18kzUs+D93bMqsqpxnmbmeXegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773508030; c=relaxed/simple;
	bh=JmwWTR8tdLBqN2ZJaJyR7rVbXUX1qdfFYCxVt/hEa7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbMpaXNyLXHK/tszCcOHfTKzEqcmn2BFQLigNjN9FhZT5hHc3N8SwYE+wiCY6B+/FDSKwSK97XUB9Kf5UkdnHAK3HXuDs9UgSrdSHDUViHA7MN5OtJ4Qm1BfqRwCHG1k+foDNH9b3xMEXE/KdDxmNEGtXcv1jeiKh4p7RB4jPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWFty480; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b7c2788dso2015700f8f.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773508027; x=1774112827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n5sXk7QR4yMzNPBEKkRLre6dWWa+kcD2gx8NHV2qKsY=;
        b=BWFty480jywnAD/7ZFee5N8T62z2IE/FjH743p1sW3j17wAr5gxT5uOk0v5dUt8eAF
         0aMnMQfCtlSFyPr5Wc+933PTvHAujBjbejXVa56t7DE6aIdKUeHOCnfmoWEpmUkKvu1b
         gzePfN+a4Wz3urK9FgP6GEm1Ou8oZYWfPDpcxZhr3jdFc0ScCLv0B6Tn+iAm6PZO+vP3
         kMHCTQZTZsWrdjrXfoHySO5b4H2ataeyA7TVJNNgh1mCLq8mgPxqa541+tnsSc2Du6+c
         6Rdd0LvkvOjGXb6kVP92TTUgYYD9yXJgujIHdlf0gn7+JmZ2tLY106r/y3H8AOvgq4FD
         +enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773508027; x=1774112827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5sXk7QR4yMzNPBEKkRLre6dWWa+kcD2gx8NHV2qKsY=;
        b=EWG6RUn0vOygTuRkRWpUxvGMJiR+Rjl7OL7qEQ73SfpNUvUy8eJPEbBJap32WyTnjd
         Z4/dCbu8cWin1PKcqsYG53wN3dtaL2t3DQkxqzaFjudEOe2sEyBopjWGSCUh20bHk+lr
         73o9T5lWTHEnZJahQwRLaO5GlgmRh7GEaBERtbM2FvTiSGfb67AdywxBR5i9vkImd9nX
         kAlDqd50ePZNRuZwbEzcR73frCrErr60qveGKz5eZf7o+RPNVARGXeu2Jgodm3KlYApt
         /vgnRYeHhuCkdfL4iVf4Z3kZdYn7H/6qqwItcfl9pMTIhuaBNSPT5WUr0w1ZlhCRFYNY
         HOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAFzwVwQL2XqWhYT2zgHyPTuVMhAhVO3aLtfK0+iDtIUl9aWxq3huUpa4j7GUv90qA0cKLpjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3bVHwRev5a3/1ORHrsccnbvluXCIp06ypb+QQq3OV2jKt8tbT
	oDYTXLpj50VH/+r0CTjewwHWHq6pyv+T0eucnVRmhKpizP58i0NEE/YD
X-Gm-Gg: ATEYQzzm8L1iTtpIkAXaltSsH5z0dL0T5uKcuSyDN0D4IwkmQZa/UEo54CFmcjhSmrI
	bOuRIulAeoppfH18dFP5USyW1FIYWN77Th7EreKz6rId1GbRmyp3uUJGn8uUHpr5SC22aYtJbiC
	cCyTXXZCCilz84Qx5U3YofzlOLo9x4agund1rUOxNkHWmIFYTPvJ+U9vAY9UFr3Flhzm6EJVmxY
	oGao4i1HxJCJr5j21Se/QsBz9TL6CgvjFnwHcEUpNjM+SHhkhs+tq3nMKLo/JlzuXVzjgRd77mB
	l+EpfycOYnQK5XD3/IqFMQLWE3MJW+fYVxGMeJ0s4DMUNPt/AwCl+RAd+Y3+Xd0/vgqctj4MRR7
	7zkXh8xUEM6339eXNM48ScK7LHBgWJNxUgCchAh7ij7PtnI0F1uzB1xiB+SaFN12Xivv7Zkyxu3
	XCwjA3HEa2WxLwdaAx0Xgl/CQag8jMaxlQdNiRVc9HX5/TcW8qALbAjyXTzdKosUUvwo4nPO9/m
	w/BSdmlFjj50Qu0For/LGs=
X-Received: by 2002:a05:6000:2dc2:b0:439:d74f:2109 with SMTP id ffacd0b85a97d-43a04dc36c8mr12532240f8f.49.1773508026649;
        Sat, 14 Mar 2026 10:07:06 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2186e3sm31604155f8f.26.2026.03.14.10.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:07:06 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id A232730395F4; Sat, 14 Mar 2026 18:07:05 +0100 (CET)
Date: Sat, 14 Mar 2026 18:07:05 +0100
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
Message-ID: <abWVuS1XJaKrndJw@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
 <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
 <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267780-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 07B5528E173
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

On Sat, Mar 14, 2026 at 04:58:28AM +0100, Eric Dumazet wrote:
> On Wed, Mar 11, 2026 at 12:09???AM Simon Baatz <gmbnomis@gmail.com> wrote:
> >
> > Hi Eric,
> >
> > On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> > > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > > >
> > > > From: Simon Baatz <gmbnomis@gmail.com>
> > > >
> > > > The test ensures we correctly apply the maximum advertised window limit
> > > > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > > > is properly clamped to zero rather than becoming negative.
> > > >
> > > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > > ---
> > > >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++++++++
> > > >  1 file changed, 26 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd192ed2b59b0a4399
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > @@ -0,0 +1,26 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +--mss=1000
> > > > +
> > > > +`./defaults.sh`
> > > > +
> > > > +// Establish a connection.
> > > > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> > > > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> > > > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
> > > > +   +0 bind(3, ..., ...) = 0
> > > > +   +0 listen(3, 1) = 0
> > > > +
> > > > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > > > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > > > +  +.1 < . 1:1(0) ack 1 win 257
> > > > +
> > > > +   +0 accept(3, ..., ...) = 4
> > > > +
> > > > +// A too big packet is accepted if the receive queue is empty
> > > > +   +0 < P. 1:20001(20000) ack 1 win 257
> > >
> > > We do not see the answer, it seems this test is not complete ?
> >
> > Actually we do not want to see an answer.  The packet won't trigger
> > an immediate ACK (it is larger than the advertised window, but does
> > not cause immediate memory pressure).
> >
> > When we then send a RST before the delayed ACK would be generated:
> >
> > > > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
> > > > +   +0 < R. 20001:20001(0) ack 1 win 257
> >
> > We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
> > been updated yet, but we must still accept the RST
> > (rcv_nxt == 20001 > rcv_mwnd_seq, tcp_max_receive_window() == 0)
> >
> > > > +
> > > > +  +.1 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
> >
> > And we verify that we accepted the RST here.
> >
> > Given how subtle this sequence is, and considering the limited value
> > of this test, I am also fine with dropping it if it is too fragile or
> > confusing.
> 
> Sorry I missed your answer.
> 
> Ok then please use :
> 
> // A too big packet is accepted if the receive queue is empty
>    +0 < P. 1:20001(20000) ack 1 win 257
>    +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received;
> assert tcpi_bytes_acked == 0, tcpi_bytes_acked }%

Unfortunately, tcpi_bytes_acked is the TX direction, it will always
be 0 here.

Instead, we can still test that the oversized packet is accepted and
indirectly verify that no immediate ACK is sent by eliciting and
checking a RST:

// A too big packet is accepted if the receive queue is empty, but does not trigger
// an immediate ACK.
   +0 < P. 1:20001(20000) ack 1 win 257
   +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received; }%

// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
   +0 < R. 20001:20001(0) ack 1 win 257

// Verify that the RST was accepted. Indirectly this also verifies that no immediate
// ACK was sent for the data packet above.
   +0 < . 20001:20001(0) ack 1 win 257
    * > R 1:1(0)

As the series is merged now (thank you!), I will send this
separately, as suggested.

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>

