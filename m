Return-Path: <netdev+bounces-259912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDjFGEiam2nU3AMAu9opvQ
	(envelope-from <netdev+bounces-259912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:07:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F17F2170E32
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D27333017DF1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 00:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B44F7478;
	Mon, 23 Feb 2026 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6+/6xFa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDB191
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771805253; cv=none; b=Q4gCnIcUZVO5mwtymnD8Nq/48+S25fVaaVeTRZeiPacrEb9CFxzm9vkXUybhup5Kr852YhJl2SBv9j+foT0pyDYWFGITD92Q5THmvgZLzhuiP5WslJzO0l72MSalDkcbZtOjUVTbEEpJL+EhWsryRMdhnOJBZ1Tt/cEXp7jCQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771805253; c=relaxed/simple;
	bh=XL3GK1srBYNctAMCr4LIXYb0AmtCQmrv6sjvkBGn/ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRAz2pEv6k3GSYsaJWu26Ep8zft8sfLvCbmjup3eF/SG7faMmNGwNPaJ6hAYb3ymLgyaoh3iXBYFZBsI6R1wcg6PE96FaTbNkbdgo/nxNO5lgoXyW/4EqtTCjyTI4GpPvbbpsg0j8bQ3kJs9CdFsjTVvdzCWue/S2+pK15yf2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6+/6xFa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso31774095e9.2
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 16:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771805251; x=1772410051; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WOqNCHYi5/n2sZSN3I12xrG8kdOz0JTtrUngqbnvPM4=;
        b=I6+/6xFabuflN1j6IDRGaaAVtNwTj4IWYSrFztIldfykNe7DpIrLOeAVVsws+Pmx1X
         u6Wnw2MNoDH5HH9gK3vXJaDkva5sJVirUn5ZpiGm9E9hrE1imDiDudpv8BkKU2hqVjgc
         iTNysnOheIjIRlJHFkywNC+0PH9RRVL2JV9qTXf9QzG1BAcNIQ6r9Kp1947b0Emh46Cu
         WRcvIUJQKC61ZRxAZR44E9V5Cbg4XBYHfU/Uudkwb7tGPWmqV/EiCZtnpMNSk8DVyJek
         pVKZGzFFqFlUeuhOjyDXec7SAzIlI04xxI8h3G5AX97QS5NjcnAyxbdnjc2vuYq+yxX0
         8b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771805251; x=1772410051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOqNCHYi5/n2sZSN3I12xrG8kdOz0JTtrUngqbnvPM4=;
        b=NpajcpfhN0YvAS9O4OKUxdlzMuYEHtL7+a02LMxV8Y0YelMjJrkntG7DWyNVdXFhAj
         8pZFQa2Ix885GGt2sgPqQyP1lKisywSD1HG9k0RKlUcRBAtvL/UUuWMNLAsKq3XH2CsW
         LvJ8Svg3zLrMXbJLgMpsHi/eSwzvqAPK+w2gz/6EwdoSIDYWJxKArqR41VPKRYAfEYfu
         DPimgS8hx6qsatrgiTZSQh5hnLUsq0a8MH268rghQn1AJSNR8z0mC8kHzKFEu/1+feun
         E7QbGCEO9qoL9TSt0OIgJoqwj2UBdi7XEx4NqC5amPCWTur81pnqmsU+LZ61XtveyPv5
         QGsA==
X-Forwarded-Encrypted: i=1; AJvYcCWvwe1vCxYv5+NGmIAWzEigB5bVLr5iMveT6RL9gxwiNu0UyO32qAOcjpIlBU3yxb/Tqj+rYwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy92OzID6WfmFgp7LL+Y0GemzXTVCicc//L0OOEQTxBIkm/vgRP
	C+2ZYhqvwKP+nuX2dmp5OFuBqXL8Amqk8sbhp61Yc1bP+SxmThGTvKTW
X-Gm-Gg: AZuq6aIWc0eJ78h8WpNyzqIB2lBqEauUjYapnhZ5lvsisTJOSAwHUJ1l9yK+uFkRJdw
	MyblbHZB36Fvue9JlzD3qRhWYtyN+YLwuuraQZpjoxlUooK2L7cq2azmPP06BgxJJCojCXPmxAH
	iQh+meTA+MSW3NkS0RIoZa3Au8IAKEL43xpXrS0BH8ER/x9+lHsYxcWBtnjBOQCkvxNZZatgep1
	qyYQSVn2i1citS4IMxlH+Eed3ste3qBjI+DlTg0uQ7Rtn4vITPv7kG/y2DJ0AYSvFBuihw2eaUV
	+YJ8I7s8qHFK7gm+CECCMfzWxOG5sJPORvS6f3UZhsauktNrrYj/DFF+8cItqq+WoRZqLaiL3mh
	/ZvLKF0gnGqYKMaMS+OpeuHeaHBfzAkYZui5W1/WTRaUUFT7Nm1GDMcW8AZPcAuYCbM7TVNmfSw
	HjdscT7ziPlFHhkGnPBrHYv4xUsaRDde6n5jTobGsGUfr3m73E27VgMO9KSmtzjw==
X-Received: by 2002:a05:600c:450c:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-483a963d656mr119551865e9.31.1771805250470;
        Sun, 22 Feb 2026 16:07:30 -0800 (PST)
Received: from gandalf.schnuecks.de (p5b2e2ef5.dip0.t-ipconnect.de. [91.46.46.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3deb73bsm71630745e9.3.2026.02.22.16.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 16:07:29 -0800 (PST)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id 451FC2FD757A; Mon, 23 Feb 2026 01:07:29 +0100 (CET)
Date: Mon, 23 Feb 2026 01:07:29 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Ahern <dsahern@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>, Jon Maloy <jmaloy@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com,
	Shuah Khan <shuah@kernel.org>,
	Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] tcp: RFC 7323-compliant window
 retraction handling
Message-ID: <aZuaQSdsuWaAZza8@gandalf.schnuecks.de>
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
 <CANn89iLd=P2nftdMReVkc+d-8+0PGi1ACxhrhnVCxFVxNOhvJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLd=P2nftdMReVkc+d-8+0PGi1ACxhrhnVCxFVxNOhvJg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,proxmox.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259912-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F17F2170E32
X-Rspamd-Action: no action

Hi Eric,

On Fri, Feb 20, 2026 at 09:58:00AM +0100, Eric Dumazet wrote:
> Hi Simon, thanks for the clean series.
> 
> I would guess you use some AI ? This is fine, just curious.

Thank you!  Yes, I’ve found AI helpful for getting familiar with a
new code base.  I also use it to refine or clean up the wording of
bigger commit messages.  Code generation works quite well for quick,
throw‑away code (like reproducers).
 
> Can you add more tests, in memory stress situations ?
> 
> Like :
> 
> A receiver grew the RWIN over time up to 8 MB.
> 
> Then the application (or the kernel under stress) used SO_RCVBUF to 16K.
> 
> I want to make sure the socket wont accept packets to fill the prior
> window and consume 8MB

I suspect generating 8 MB worth of RX data in packetdrill won't be
fun (unless there’s a trick I’m missing).  And using regular TCP
sockets on both ends would probably be rather uninteresting (no
packets sent once RWIN = 0)

It might be more practical to extend one of the tests to create two
situations in packetdrill:

1. Zero window:  0 == RWIN < 2 * squeezed SO_RCVBUF < tracked max. RWIN < 2 * original SO_RCVBUF
2. Small window: 0  < RWIN < 2 * squeezed SO_RCVBUF < tracked max. RWIN < 2 * original SO_RCVBUF

If these limits are sufficiently distinct, we could probe tcp_sequence() and
tcp_data_queue() paths in detail using:
  
* pure ACK or data packet
* in-order or out-of order
* within, partially within, or beyond (max) window

If we can show that we can't use more memory than expected for the
squeezed buffer, then the original max window size shouldn’t really
matter.

wdyt?

- Simon

-- 
Simon Baatz <gmbnomis@gmail.com>

