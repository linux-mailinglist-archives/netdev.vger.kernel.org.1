Return-Path: <netdev+bounces-258189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE1DMLkDjGnIegAAu9opvQ
	(envelope-from <netdev+bounces-258189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:21:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F6412128A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 230F13029262
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954CA350A2C;
	Wed, 11 Feb 2026 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRC+GWls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566471B81D3
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770783670; cv=none; b=jwGkaMXd7DKphRznUF+Tv4ZqNr7NQsJ2ag9n91uf4KUpwk9Ns5kd4Ta3CND6RZPgeK0QLkTthVy2jNiudN23bvBADpIbq57mwXrufUjxR+yPbg8b8n5TrcWllsFHNbMTFQbkg5kWJetROiVsjhRcxLSMk2/Cd7jZvhc8g9dfrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770783670; c=relaxed/simple;
	bh=tWxMhtRT84u3VNJXU9/WIGuq1dZw0DAZp76KD1xA1P0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NdLAeU/lh4slf56eBmIA14qinLxoiDN/poMuhb1uXuHPlxi2Ho164GdMANE5HWrUwrCWxIOoBWiiU3GflY1u+nCEOP9MXa0PY3EPsF+epF7gG1MCIgJokWYyKEcjw/PPLF7k3HSVbQms8yeYC50Gc7txELtbnOu2wuNx/x9WXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRC+GWls; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79456d5ebf9so49832397b3.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770783668; x=1771388468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynsPHl/BhzORZSWo5ytx1eDrV1MT7IM5pypfCFY/QtY=;
        b=IRC+GWlscMJ6wl+UmOznZyb3GUFg2EspjF8XTIfvaUNvurwNGIJncNQHAUrilYqi8d
         qvKM88tRhrpFKpZIXGbOlXv2tI25FwV3IQ8c6Xfa8UGMytgUhu9HM12A86gIigzf9WwA
         o/gZ1S61isPMi0SUfgFN8yj5MjEap5WSNboWMSktQhW2ocZzPSg8EqTCvTyRS2ltBsiY
         LLdZjrStT9B1TerZkYL+5Lv8P6Cl+BXG5Y0V98TaalX+XnIqJtVgex52V0QwfoplqMR8
         y9KDzy3Vy2DPMP7r8ZuGtMhFJ6Rx1MCjGCzw6yLqZ5uIBR8MF0leCPDUkYUeRi90BVpW
         hiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770783668; x=1771388468;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynsPHl/BhzORZSWo5ytx1eDrV1MT7IM5pypfCFY/QtY=;
        b=szIMH43n3deqCHm3BUlPXSuJTYgg5gAOIXDBdHtJaf/kJ9zAxtm/GEDH07jroW6wnT
         tJFvdvZKSBMZH+oXDkkTgpdwJqWFmW1MABQRLG9N1HC8PAcZp/zvdxYqWd+e1FTBIJIE
         OIO09CaR2Wsy2fOD2VCaGG/UKWS9bdOG5zYq2N+rCX5M+jjNZcNu4TNoQ01OIvesvip4
         1o7AME/lR4dRrqymojVhmgIgbEBcbCx/9pEbc/7Hjsgp/NUHeKaeh5vWQhxLbMCMdA/p
         gij4uzlLrKtKKNqWW+7GYsANICllKXB7NaSHDP6rKjQjx5VPn3/5GDybcFbcNxOGpwp/
         J11w==
X-Forwarded-Encrypted: i=1; AJvYcCVMvR+0U/eVMw6TLc4v/Es5PtHZduRbOzFsoym0F/OycMxRgu+Q2E2QbFpPmAD+t+kQ/t7HTEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69wwgdLNqBbdLsNEPPQ32+MQoqEjNgtRoTKbhXGqNy+WjwQQG
	9b7J57FbxqclxZGnr/mBYkCj2znp4nduKaHEzeM0TTFJCp0leYaVxWUi
X-Gm-Gg: AZuq6aIbMtjCdXEUUA86yOKoSSjlTFz1nLj92f98yQXrHkbFCIR6vAXag8HgB8yassR
	y9uaASSaa7Iqi9buNJZxJxjaFoGj/8Yoz1L0VHlJNklh95YTgaz2zV8/t+n6C9jFAsS1UzezoL2
	M3TbnMn3jKgIPW9Sh1xA2NAEm6G/kAtnlBBHkHFxsmLaXgQ7nSZqxEV0ffd5AqrgM12YkXfO2nN
	pIoWARMokurRSXmdCGCmypMr6QsGLcNZ5z6G+jKTWfjnWCSnq6s2xVvcRZ7qnDERblUxIoSfDsp
	rRHmLuCKhGhVrwEWQq0eqv381zIX6HnkEL56/NdRZqtKOOUQ487WKpuux3II4+gj+mxyTt7tUXQ
	HOvRZ8pf4JoxPVr5IGzZit1CKw9zl6qX0WCvm695mdbYQX/bD1rceG6B/EDx4ht6ZJ13w3leDXJ
	K13IvpNAqKCZAWOV2BW067AOVNRJXyAQUuLwcAHqrJ0CMA6xge3pX6Dlaf6+/UyLJLlCwuqZA=
X-Received: by 2002:a05:690c:6c91:b0:794:db37:5db4 with SMTP id 00721157ae682-7966a963196mr10126587b3.7.1770783668273;
        Tue, 10 Feb 2026 20:21:08 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7966c23e4bdsm5927647b3.32.2026.02.10.20.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 20:21:07 -0800 (PST)
Date: Tue, 10 Feb 2026 23:21:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 petrm@nvidia.com, 
 donald.hunter@gmail.com, 
 michael.chan@broadcom.com, 
 pavan.chebbi@broadcom.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.172899765680b@gmail.com>
In-Reply-To: <20260210194814.21a0c403@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
 <20260207003509.3927744-7-kuba@kernel.org>
 <willemdebruijn.kernel.743811e01cc@gmail.com>
 <20260210175638.123782b2@kernel.org>
 <willemdebruijn.kernel.503ed4ace7bf@gmail.com>
 <20260210194814.21a0c403@kernel.org>
Subject: Re: [PATCH net-next v2 6/9] selftests: drv-net: gro: use SO_TXTIME to
 schedule packets together
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258189-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28F6412128A
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> On Tue, 10 Feb 2026 22:15:25 -0500 Willem de Bruijn wrote:
> > > It's a bit of an opportunistic optimization.
> > > 
> > > I initially intended it for for the "long sequence of packets"
> > > test. But I failed to get AF_PACKET+FQ to cooperate sufficiently
> > > to queue all of the packets in the same bucket. Otherwise FQ "sorts"
> > > the packets, and breaks what the test is trying to do :(  
> > 
> > I wonder what's going wrong here.
> > 
> > fq_classify should pick the queue based on skb->sk also for packet
> > sockets.
> > 
> > And flow_queue_add should add the packets to the tail of the linear
> > list if the delivery time is identical to that of the tail.
> 
> It works but requires that we either modify the qdisc config to set
> a orphan_mask of 1, or somehow set the skb->hash on the AF_PACKET skbs.

Oh right, fq_classify does not use skb->sk for packet sockets because
they are in default sk_state TCP_CLOSE.

And this is by design, as clearly documented, as packet sockets should
not be assumed to be a single flow:

        } else if (sk->sk_state == TCP_CLOSE) {
                unsigned long hash = skb_get_hash(skb) & q->orphan_mask;
                /*
                 * Sockets in TCP_CLOSE are non connected.
                 * Typical use case is UDP sockets, they can send packets
                 * with sendto() to many different destinations.
                 * We probably could use a generic bit advertising
                 * non connected sockets, instead of sk_state == TCP_CLOSE,
                 * if we care enough.
                 */
                sk = (struct sock *)((hash << 1) | 1UL);
        }

An orphan_mask of 1 sounds like an effective workaround.

I don't see a way to force a specific skb_get_hash result across
flows, given hashrnd.

> The test sends out multiple flows (src ports) so if we let fq compute
> the real hash we end up in different buckets.



