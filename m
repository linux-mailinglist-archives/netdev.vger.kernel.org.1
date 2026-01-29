Return-Path: <netdev+bounces-254892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wqw+F5ive2l3HwIAu9opvQ
	(envelope-from <netdev+bounces-254892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:06:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2FB3C73
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82EF73006693
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00A3093AB;
	Thu, 29 Jan 2026 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6To8ZK5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E82D838B
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713551; cv=none; b=OUJpJOtRQfsgyDPQblcsNVWtJLciDUIHQJgYzXpKvLEquBWq7eRNB2gP7jnsfk0cf4Jhb27TbR/YQFC516LFFpMJw8R47TiDMifHWm8sUMsccZzXnT98tFY8l3Xsk3tKz6U0bQrrxypZ7xqINWUgK2+KLPOThYVFz+J80Hcu0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713551; c=relaxed/simple;
	bh=bjB1pwOy+phSeyvaKUZTiehO0b4ucXfSGrqVGBLW9Sc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LybNz4cjmg7nrEuQkD4mMkc3MH2GcgRnmOwcvoE44aOf+lMBYk7zB/4zxDH1FongjWbCW4bE56lkFuFTgkekM9mn8btLWNVHQ0iX/d6M03kltwvya7A+gC4o0F1sVPyR6gcRYmZmmPk8qlMBvHiDpwZLGj7DGul5Uld3epxtqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6To8ZK5; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7946a1f2430so13549077b3.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769713549; x=1770318349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6hUhoo3mEshhJHXnbrxVpVomoBMzPO0Ks+buV8Hgl8=;
        b=k6To8ZK5bP+MBv/Kp15EczkrsHXy2Y6pdGYAAIOASvWYDF9lOGyUTxdgZstUmkdJj8
         /0unr+lKqSRqs/F9O0SRctBc++vLlb5p8n0OQ/5FNJxfIc078/aGvyxeeaacj3ZqhbK0
         UAH0votMBX/HyjdFebiRoXDs5HcZ2+XeLthXXKUcqQvp04uNJryQtRtraX1Kz+TVesTw
         5NCwVsi+BBkIuGeN3ruOD8S9pHubwsMvoDPqZ6xv8RquP40WqNyW56fu2cc73Awu05B/
         FWxInSwAZAyQkkiFepUeG2s2b8i5105DKNpItUejjAJYT87Thj+z++5sG1MpYA71bdO5
         iOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769713549; x=1770318349;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6hUhoo3mEshhJHXnbrxVpVomoBMzPO0Ks+buV8Hgl8=;
        b=HEk1blo3Aeov2F3ugf2WRvsWhgwMNm4WoLRJqQfK9C6cLPD/Z1dqRf8mvSjUIQ6leS
         2DDvSpo068rURluL4PmF39Wehcir+/0aJB0nMQMyUx2UArSDbquMogzpL+2cr4me+ZZ5
         WlxuOsIKHRmarxRuoDJfgdySf5ygXrkTVS94kJZJnE0ejJJ6Rq1UdnxVHCEKq5BvJ0bP
         IeXCzf40olFbgCHNcCEQ+TrhOfBnvBgIPpdItaPeamHrkUfQmGLrKtV5u1YcGy5b7vi+
         VnPnt00gv6FLLzz9q5HC9HZ3srQUxyzxIgMrZJw9XHfozDddNqHyYSeZu7YaE3PBMGAN
         GPwA==
X-Forwarded-Encrypted: i=1; AJvYcCUmW0EZJeMpLrs05chV29l7OTZR7mIFLUed0lEkk2yF0T7sCrbV38+oA60kRAlRKs94WPiKBZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9RZD5peNQ6YcbWELkPTAZY8o7O4ZcYeoHA6dBTnm4MSrOh7M
	nRJFORvl7+zXsbU7Kx8xWcuiOSRhk8Sp0ldr+pP6Ke4kTdsRy/a6AIk7
X-Gm-Gg: AZuq6aIv7yNFMJ1eL0fz6CDxjzVuekwB/PURjFReoHOQi2d9RdPutSZA4J4YliYcEpu
	qUotyTCTHXw/MVJBLL9414KbK+k7L8MA6ssGmH+DbHt2dXDeNXJgsFAOQzXLm45VrgMQHkIRw7J
	LWgMzKPRzRNJEDMiK0DPoj1ySg1D8qPEIP24t2CB/gqN5MfHVG2xwyevRROJv3BWmlrTYhYCwI1
	VnYwADKOvL1IoBmjrmQm7IQ8N0pOPe9s7an/wOJ59SNGl6jO22rG7OqVeQYhJKePh7wSicFA2hl
	PG368jjYT6w3uQOoppyEJO29Iax6Ygk9SZzIToxoP0Rtpw9/vET3xARpOb+4uU6meWrk6H2lC9U
	ZByGctNPZ2ZlHwGYzSxwtBbsKvUyctQjy679Pz7C5MjrNfYhQrcRtDhJDxsi/4feM2j4U+/uuux
	tH+wvu1nZ5tA+ywST1pskHNS0s1bO+5D367HsYLGBBbyQvWqirfbNb/yI5JQJSMr+3qma+Yg==
X-Received: by 2002:a05:690c:d84:b0:78d:b1e9:85f0 with SMTP id 00721157ae682-7949dff9e2cmr6071867b3.47.1769713549267;
        Thu, 29 Jan 2026 11:05:49 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794961a22e8sm9682217b3.17.2026.01.29.11.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 11:05:48 -0800 (PST)
Date: Thu, 29 Jan 2026 14:05:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.8e46b721f5ed@gmail.com>
In-Reply-To: <31232399-4cf4-49ea-b769-84aceca61dc9@gmail.com>
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-7-tom@herbertland.com>
 <willemdebruijn.kernel.19061eebdb902@gmail.com>
 <31232399-4cf4-49ea-b769-84aceca61dc9@gmail.com>
Subject: Re: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254892-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,herbertland.com,davemloft.net,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48B2FB3C73
X-Rspamd-Action: no action

Justin Iurman wrote:
> On 1/29/26 06:18, Willem de Bruijn wrote:
> > Tom Herbert wrote:
> >> RFC8200 highly recommends that different Extension Headers be send in
> >> a prescibed order and all Extension Header types occur at most once
> >> in a packet with the exception of Destination Options that may
> >> occur twice. This patch enforces the ordering be folowed in received
> >> packets.
> >>
> >> The allowed order of Extension Headers is:
> >>
> >>      IPv6 header
> >>      Hop-by-Hop Options header
> >>      Destination Options before the Routing Header
> >>      Routing header
> >>      Fragment header
> >>      Authentication header
> >>      Encapsulating Security Payload header
> >>      Destination Options header
> >>      Upper-Layer header
> >>
> >> Each Extension Header may be present only once in a packet.
> >>
> >> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> >> enforcement of xtension Header order. If it is set to zero then
> > 
> > [e]xtension. There are a few more typos in the various commit
> > messages.
> > 
> >> Extension Header order and number of occurences is not checked
> >> in receive processeing (except for Hop-by-Hop Options that
> >> must be the first Extension Header and can only occur once in
> >> a packet.
> > 
> > RFC 8200 also states
> > 
> >     "IPv6 nodes must accept and attempt to process extension headers in
> >     any order and occurring any number of times in the same packet,
> >     except for the Hop-by-Hop Options header, which is restricted to
> >     appear immediately after an IPv6 header only. Nonetheless, it is
> >     strongly advised that sources of IPv6 packets adhere to the above
> >     recommended order until and unless subsequent specifications revise
> >     that recommendation."
> > 
> > A case of be strict in what you send, liberal in what you accept.
> > 
> > This new sysctl has a chance of breaking existing users.
> 
> Willem,
> 
> Note that RFC8200 does not use normative language, which is part of the 
> problem. It could theoretically break existing users, but I don't think 
> it will in reality. For that, you would need users to beginning with 
> (joke aside, I like EHs). Anyway, if the order is enforced at sending, 
> why would any receiver accept a different order? In this case, being 
> liberal in what we accept might be a security risk (see below).
> 
> > The series as a whole is framed as a security improvement. Does
> > enforcing order help with that?
> 
> IMHO, any packet with EHs in a different order than the one specified in 
> RFC8200 looks suspicious. So, yes.

Looks suspicious. But does not introduce concrete new risks?

The main risk I understand around IPv6 extension headers is the risk
common to all untrusted network input: bugs in parsing code. Bugs can
cause crashes, infinite loops, or worse subtle effects. This is why we
introduced the BPF flow dissector, for instance.

I don't immediately see how different order of headers increases
parsing risk. Nor, btw, that reducing max number of headers from 8 to
2 significantly mitigates a real risk.

No objections necessarily. But I don't fully understand the argument.

