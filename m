Return-Path: <netdev+bounces-284837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D6iKg1B+2lPYgMAu9opvQ
	(envelope-from <netdev+bounces-284837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:24:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FEF4DAE98
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD77930075E7
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123F3F65EB;
	Wed,  6 May 2026 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOLZ3cQs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312D636405E
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073645; cv=none; b=MEPD5Db0OJmyYASAJxfcC7JEni3FD5yaWDGOHb9NF7NEu9u4qRdCeIHFf2Eyf1VPyXyXcTL/QRntMjBHl22hoNiYu9bGT+fY3yiXJfjUaygyzhXcRg3yGDSu8UHbWfcTTHrTiJ6a4LcCx1PS069cWVQ39Ng8tTPht+V+VAnrRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073645; c=relaxed/simple;
	bh=f4qI1HnRSrCJ0gyE3xQbeXLVu4tMvNsOgwG6DEf1w0Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=f0yHuEYM914MoJBJSmvXQUgHJfBWwFDSxhAqgo4nD699NhOmRRDNS48jdOGCqAzzx4Wp7opesbsCZFiciZ2BOnOBVquzL+2ksqrkRWMGOvj2rMqDEEZW6x2HlLtLxuF6Q2eMy6xSNLCDN5Ynyns3KMpqRVyAS201cMTyFjSRWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qOLZ3cQs; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79885f4a8ffso61818267b3.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073643; x=1778678443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOFUa+pTryMGHy3DzUaJrzcZH0mpKNqsNoKrNDnAedQ=;
        b=qOLZ3cQsnusst8p18gZ8yg0BjmmYLmrEV/YIu/X+eGrh5QinjbjTCdVL0EV3v/EoNR
         7YHRkvxLcCP640IZ8JDJtPS2G2rRlWxfsaCl+BKQR8cDAxjCbXr9aHNwLzpiXuIBtNUq
         LjaBA48SwUlUBTt8eSwkOkCGpokaTMuvM4KYVKgGiGVY2RLtg8jy0U4S0tF1Qa7WsXRp
         2EYylX1fLMxS12Vp+AD9Aqy7JXpjIl4GU/lUonA7R2fcR1mvHXJJSj/y4paaSymZ7SYf
         7FDysvNcIPR0vrr3iZSueRXfWgjDZV3k0ZHT1kZHPEvEzyTifMgLSIOIOQSbFYMu2TLZ
         3YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073643; x=1778678443;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOFUa+pTryMGHy3DzUaJrzcZH0mpKNqsNoKrNDnAedQ=;
        b=DFwmnw9jIypx1vYIdEMe9ILo4JykWdazd6pVD8NoIqi1IEJwpvDRHSY+OOH+D1UyZs
         iu6Kxz6eNO/dw/a9IthrGGot1WkCUaPCd+H8FYjpxXC5uA9D3DmJWQFAa3B6zu/Iy6kT
         uUFHjJsGixOY5AZIXWavILWktYSeyCZG6UqTCLVAhINqs57ZckF5Ze7pyB53H+JltpqI
         AdcAkLQ5GFewr/cp01Gyod2Q7S3A7VGgVXQR4chGTBWRoPmLOMVNSLy/Z74/p8PmgKaf
         bOl9MCANOyOeABhJtPPzZp7zcH2RiWJOZk64jePeyjB2oYmwDz9TOccW/9BPsrYtyFUc
         YJcg==
X-Gm-Message-State: AOJu0Yz8G8yU5Ucygnjdpl/OpxpVo8LZrVKPvRsUEA6AUQx7wDZlU/md
	0V7wDDyZzvJRhR2RjLOl/WlmTEZJA4jSgkd7MZdW6zDb/MMnUs4cusMX
X-Gm-Gg: AeBDiev0XaeASX2qlPZkW4SmNpEA3kaDz8HUtlskHDbUj5icP6cbEQP9PfsLIs8cpcw
	du7bBJPC72mEvbTb8d7RATb7ZhkTPNdN3OQu3C9UiMqumt3kbBN3j0AII5M/ikZdI+6NvTrDkHt
	jBuG2/0kNKNfunIhuDLB0TkjI8sK9+GmtoN0kihAnOfO1uvO+tFVO1e4H4kH5Q+QNFXQOHV2mB1
	MTkfsc2MZWosJUH8wYDNf6R0QoE5+n2fIZ04UcfbkEFrFnxxQ+jtM48Nc0g64dGq2v+LdD72AkV
	ezT3+1s5h7oxoML06s79gE65/ByrSg8YfSLbWTXgeGZWmhm2wGBukP9db7G4FA11ypTqLTWqMvf
	AhlbpTf1BJwYhDHJS1V4hnzVrlvUlh5ImxP1N+p65rupXHFn65Cl0JjNasOLiZtMiZWf86tyz57
	hAZywgD+3+vbvOXrf25lAREGMe6xZWdk4MmU5WyzMSfZ5qPkVu7BLGQj5bkxmqEeHWEwOSOlNT4
	JWwInvr3K7Ip9M=
X-Received: by 2002:a05:690c:c4f1:b0:7b2:1bf1:800d with SMTP id 00721157ae682-7bdf5d7e353mr37246767b3.4.1778073643045;
        Wed, 06 May 2026 06:20:43 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66896398sm77476297b3.48.2026.05.06.06.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:20:41 -0700 (PDT)
Date: Wed, 06 May 2026 09:20:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Neelima Muralidharan <neelima@ti.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, 
 Pratheesh Gangadhar TK <pratheesh@ti.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <willemdebruijn.kernel.b7832f991167@gmail.com>
In-Reply-To: <20260506070928.hr8uavhJ@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
 <willemdebruijn.kernel.31592d82701e5@gmail.com>
 <20260504085911.nLZLRjPF@linutronix.de>
 <willemdebruijn.kernel.22897601ad5fe@gmail.com>
 <20260505095216.T02Z4R1T@linutronix.de>
 <willemdebruijn.kernel.8d257bcbe351@gmail.com>
 <20260506070928.hr8uavhJ@linutronix.de>
Subject: Re: [PATCH RFC net-next v3] hsr: Allow to send a specific port and
 with HSR header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 11FEF4DAE98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284837-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Sebastian Andrzej Siewior wrote:
> On 2026-05-05 12:14:58 [-0400], Willem de Bruijn wrote:
> > > But I can't expect that the header is always there. A random ping/ arp
> > > packet goes via the same flow. At the same time I don't want to make it
> > > mandatory for all AF_PACKET users by checking the skb's socket.
> > 
> > I thought skb->protocol is the unambiguous signal whether this custom
> > header is present?
> 
> No, I parse the header. As far as I can tell this set based on the
> header bits from data passed to af_packet. Even if I could change this
> to something else, these 16bit should better not collide with anything
> else so I think used the eth-type and expecting nobody sending a PTP
> packet is good.

Is that more fragile than a specific protocol? And introduces that
dependency on mirroring the Ethernet format. But your call.

Ethernet does have requirements on MAC address format, so a layout
that corresponds to an invalid address could be a signal.

