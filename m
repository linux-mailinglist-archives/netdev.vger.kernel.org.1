Return-Path: <netdev+bounces-268290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNIxN6l7uGlVewEAu9opvQ
	(envelope-from <netdev+bounces-268290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:52:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3622A12B2
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCB85305A5D3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BDA36AB56;
	Mon, 16 Mar 2026 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD0AnySI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44C9359703
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697901; cv=none; b=UjPCuyjY7zxCCLoKhy8UlWVSpIOxNE0byK2SOWMRGglLkIxm7GrX1PaM+r9iCTUrtkEg/9aMHcsL7iNamn/jotP2iyA6WgsTcqHtG6W91TuhqR0iu8UFQWpNNNIvoAY2PuywdN4AKUFfFJnj57b8yd2Wny5xGouYL9PHisE9cGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697901; c=relaxed/simple;
	bh=22FQQziovkybfpoEgGEar4XKtg0Elmc86WdBJzgy3AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGAEks3YszJGOdtmgLyeqzCpc+EmnkZlgBfhnG1m+C7HlJXhX5W2BDlnU1GbwQi1Vrko9dxirERielfCG/4Vhmcc2UwRayuqoiSPrNTZdg+8Osu8DJM0Kx2bblJYR5XT8izyfrKjxUJARwIBouxlrbMkxWVrPPOCKqjoWZOwv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD0AnySI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48538c5956bso1424375e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697897; x=1774302697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj1cmcN77XR2dLCOZTKXheeb7KLeaY6rrHsbkVnSpso=;
        b=RD0AnySIyW2JLlyg7kNXl182x2dz/yCOKiV8rMCNirdvIxNN//NbP5veoW6pRZAjMc
         VMNNx0e+j9nYXfS29C/+e9D96vDDDn/yiOIH1EQfXQ0kYdIHkEA54StylbnMud08dKf3
         hfWsoCeGFIiVmAJsn4K/BA3NIBfmYWNZEuvdYRk+AmefdaoU9dlTMatvzUxBHxTAEWG6
         tx9oxN/7gvvwIaQ6sRwrWvGSp+OxO6IzG5fV0sgGZuV2Fvw4OzYovZhTvKRvFEOkjfKT
         f184BTCR1W7vw32vW7CGApplGLqpd/1aU9rIiG17+SvxQ4//R7iJZRXBRpwA530ZOiSa
         HIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697897; x=1774302697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sj1cmcN77XR2dLCOZTKXheeb7KLeaY6rrHsbkVnSpso=;
        b=M3OFoAEWYJMph3lbiW2JuPHRbhrfu7hu2M1nRTApXA9fiZ31Xni/YVxEFs8MSSiaf3
         1WU4BtHDlDhqwnr5wUb5Un9kxsDVU7m80dqmw95kFRaSabvVYOuADtCHk2vLCAABjCi/
         2etcJQ36PdTYnETauUSnRegeRkHx3XIMrRqPTISAscsMhvPZvN84egMPw0X1D+Kr04Rr
         phYq9O/G82bbC+B0wYSlHvEKg3HpAFD++KIEX1mHkFkPYmaptAkEoADiEIA+Dakg5Rkj
         Aq5rxKhczvX2Wv7CZCLYW65RQbsHhgEE+u/hkESdc8/gtMC5zwgYnGcSZGMg9ydiwwVW
         fLGw==
X-Forwarded-Encrypted: i=1; AJvYcCUG5eMwWCNEIwYlSjKK8kU9/K2+SoeMvHGJ/1YTcXFGeUDttev/nHpNfkVQd2ftO93q54DUThQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHv4dohJ0/OM3Wy69Um4XvQxEz2YHcSRtBZ/kYzzxs05aJBT1
	1gNBPgYSD6Qr5ZwiQeHJk2Ci61F8gx9MKVXELsR8/1lqUPSEqSDKEgUc
X-Gm-Gg: ATEYQzzxMcd7ZirAgPv0xqGz4yxEoxRQgHLMsWTZRpn/1AILxayZQKnq2nsJlDOA52u
	bcD+B0WEa4a7qH2Yw7FsP4wX/YlsRJZrjOtk8UUs2sIhXfNnZCZ9KezUcujjp8wQgUDHEfOhuh9
	spHEEtUZ1NOGUvH2GB8ZJlI4w92LTwNCgwVbVEXxwETBFj4GeLaB8SaJehRcf9MRkCTcVIj6Ps5
	UMu1U5G1iCItvueSPdQa6m6DhnZkz1s/buJheXGwqt3tl+VYNU6VkAzAKHUoDuuzCfSk/oT2vw8
	o0OmDVzkC+YyYwNbM9m7G6/973DsHHmk34zrndPBwm/gXTGRMexUQJH6i/0/TMyGpg/tP2v3oB8
	1mP4U/1avKtfnxQDfh6e7otsrBo9P4Y+PxsOhUCiEe70STbqCxPkjjf0/zowASKAWuNybop6YQr
	UCzUJJKosAj92NjjDaOhzwNUDROZ2X53CRY9Jp/bme+MMWFr9p8/fSQPMwliqe4KmU0uTcA+5yz
	MTMl33vBPvklDdOnT8dAZg=
X-Received: by 2002:a05:600c:3e1a:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4856eab522emr17811775e9.4.1773697896899;
        Mon, 16 Mar 2026 14:51:36 -0700 (PDT)
Received: from gandalf.schnuecks.de (p200300c14f1996009e6b00fffe39b8a7.dip0.t-ipconnect.de. [2003:c1:4f19:9600:9e6b:ff:fe39:b8a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3037sm20082795e9.11.2026.03.16.14.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:51:36 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 903633040F3A; Mon, 16 Mar 2026 22:51:35 +0100 (CET)
Date: Mon, 16 Mar 2026 22:51:35 +0100
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
Message-ID: <abh7Z5GEhEzty18d@gandalf.schnuecks.de>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-6-4c7f96b1ec69@gmail.com>
 <CANn89i+PypF1cK4mnp8L_eCG_z+3Aj6uxJoohm_=DwGfR1=4FA@mail.gmail.com>
 <abCkmiCSPkmxzECa@gandalf.schnuecks.de>
 <CANn89iKYxs644ardFFSKo8d0EXL_2A5eUQjWZ3yp9-Q4tVLKzQ@mail.gmail.com>
 <abWVuS1XJaKrndJw@gandalf.schnuecks.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abWVuS1XJaKrndJw@gandalf.schnuecks.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268290-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 8A3622A12B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 06:07:05PM +0100, Simon Baatz wrote:
> Hi Eric,
> 
> On Sat, Mar 14, 2026 at 04:58:28AM +0100, Eric Dumazet wrote:
> > On Wed, Mar 11, 2026 at 12:09???AM Simon Baatz <gmbnomis@gmail.com> wrote:
> > >
> > > Hi Eric,
> > >
> > > On Tue, Mar 10, 2026 at 09:54:58AM +0100, Eric Dumazet wrote:
> > > > On Mon, Mar 9, 2026 at 9:03???AM Simon Baatz via B4 Relay
> > > > <devnull+gmbnomis.gmail.com@kernel.org> wrote:
> > > > >
> > > > > From: Simon Baatz <gmbnomis@gmail.com>
> > > > >
> > > > > The test ensures we correctly apply the maximum advertised window limit
> > > > > when rcv_nxt advances past rcv_mwnd_seq, so that the "usable window"
> > > > > is properly clamped to zero rather than becoming negative.
> > > > >
> > > > > Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> > > > > ---
> > > > >  .../net/packetdrill/tcp_rcv_neg_window.pkt         | 26 ++++++++++++++++++++++
> > > > >  1 file changed, 26 insertions(+)
> > > > >
> > > > > diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > > new file mode 100644
> > > > > index 0000000000000000000000000000000000000000..15a9b4938f16d175ac54f3fd192ed2b59b0a4399
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
> > > > > @@ -0,0 +1,26 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +--mss=1000
> > > > > +
> > > > > +`./defaults.sh`
> > > > > +
> > > > > +// Establish a connection.
> > > > > +   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> > > > > +   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> > > > > +   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [20000], 4) = 0
> > > > > +   +0 bind(3, ..., ...) = 0
> > > > > +   +0 listen(3, 1) = 0
> > > > > +
> > > > > +   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
> > > > > +   +0 > S. 0:0(0) ack 1 win 18980 <mss 1460,nop,wscale 0>
> > > > > +  +.1 < . 1:1(0) ack 1 win 257
> > > > > +
> > > > > +   +0 accept(3, ..., ...) = 4
> > > > > +
> > > > > +// A too big packet is accepted if the receive queue is empty
> > > > > +   +0 < P. 1:20001(20000) ack 1 win 257
> > > >
> > > > We do not see the answer, it seems this test is not complete ?
> > >
> > > Actually we do not want to see an answer.  The packet won't trigger
> > > an immediate ACK (it is larger than the advertised window, but does
> > > not cause immediate memory pressure).
> > >
> > > When we then send a RST before the delayed ACK would be generated:
> > >
> > > > > +// Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
> > > > > +   +0 < R. 20001:20001(0) ack 1 win 257
> > >
> > > We are in a state where rcv_wup, rcv_wnd, and rcv_mwnd_seq have not
> > > been updated yet, but we must still accept the RST
> > > (rcv_nxt == 20001 > rcv_mwnd_seq, tcp_max_receive_window() == 0)
> > >
> > > > > +
> > > > > +  +.1 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
> > >
> > > And we verify that we accepted the RST here.
> > >
> > > Given how subtle this sequence is, and considering the limited value
> > > of this test, I am also fine with dropping it if it is too fragile or
> > > confusing.
> > 
> > Sorry I missed your answer.
> > 
> > Ok then please use :
> > 
> > // A too big packet is accepted if the receive queue is empty
> >    +0 < P. 1:20001(20000) ack 1 win 257
> >    +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received;
> > assert tcpi_bytes_acked == 0, tcpi_bytes_acked }%
> 
> Unfortunately, tcpi_bytes_acked is the TX direction, it will always
> be 0 here.
> 
> Instead, we can still test that the oversized packet is accepted and
> indirectly verify that no immediate ACK is sent by eliciting and
> checking a RST:
> 
> // A too big packet is accepted if the receive queue is empty, but does not trigger
> // an immediate ACK.
>    +0 < P. 1:20001(20000) ack 1 win 257
>    +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received; }%
> 
> // Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
>    +0 < R. 20001:20001(0) ack 1 win 257
> 
> // Verify that the RST was accepted. Indirectly this also verifies that no immediate
> // ACK was sent for the data packet above.
>    +0 < . 20001:20001(0) ack 1 win 257
>     * > R 1:1(0)
> 
> As the series is merged now (thank you!), I will send this
> separately, as suggested.

Patch is at: https://lore.kernel.org/netdev/20260316-improve_tcp_neg_usable_wnd_test-v1-1-f16d5e365107@gmail.com/

-- 
Simon Baatz <gmbnomis@gmail.com>

