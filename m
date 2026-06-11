Return-Path: <netdev+bounces-298110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id miD5HMmoKmoougMAu9opvQ
	(envelope-from <netdev+bounces-298110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:23:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DBB671C87
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:23:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rDMyA0To;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298110-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298110-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B7253003837
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88332D73BC;
	Thu, 11 Jun 2026 12:23:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998F355F5C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:23:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781180611; cv=none; b=B+kq99XLQn+Hs50q99/XmajTSbQpoTwG3jejiHgLIho3DJd/2+BmAKDUXCth8sDSEAl6DVm1j3THVIuiQ1IXPFCqVdoIk+94QH+J8Up5zY91i4TFcKd71CBvfEfMts0fENm8lRCqfDHoBX5fdpyMZ2/UzKyoZXm8CuiJTfnNP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781180611; c=relaxed/simple;
	bh=5o4uZfIewxYg8nMi5ai68NOliBQBC5fgwexMfo7Y0Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZhsCVy3kuCvlXPkoeqtkGWDEMNQlxDsdQe76fqsn/pFEyr+4LRKWDF2jlXjqrNaAoUgAtp5CzqH2ojYKB+JmUmkntiR0JPXm6EP4+tEJkYC1GsxjWgAXqt+rKPqqXRLIHxQ7T3kqWM1x3peeBoc3EOczSPJ8GnooPDMhzQ0Ay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDMyA0To; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso6776059a91.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781180610; x=1781785410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWWde8oTiwpIrCzHwuGTBaaddX/30yZJJn3ORVLoQD4=;
        b=rDMyA0To7eYCGKdkD0X1hvFeSWK3dK1uJej6aK5E6la/0LYWBBMuh44DuxHEztONY+
         YpaNPMZP9micyD4LIG5bP+vxSxX+N6LIEd90f9ZpbsdTcksPtX/HJAPbe2Lt+XaZLdgV
         FAoHhuGV/8Efx3rRn7JqEZcj/KcnAPgmDicH0/SpD+V0yl/VjC5DWuX3PhxWWrdRBHKe
         Y59GlYJI9M3uyuBBL14k1YVjOq6cFqshbXbIsc0J77R2kaUz5AJY4meFRazr7+MfpoNF
         DRsA2Z+fM8PXfIatGLImrFpICNfQtrMGp1qL/7wjIoDIo17wbhPdSpa/QQXdGmprOulY
         jbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781180610; x=1781785410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWWde8oTiwpIrCzHwuGTBaaddX/30yZJJn3ORVLoQD4=;
        b=lCuXLz4MBbDjJoYSD4hJsflAkLYMphZ8Z9zKJ0WR1BFvqoQ4Likg8499R/STVB0jhB
         mKDemEyeiDwo5yQV7N892qX9XPeBVJJMfUFR2KppxN+Y3S1rQ3Avb5JZpHCSkqi6OFOa
         XB9Uy5nsf+Z2eY8xhv4hR9CAVbt6SF0qoEKuOio464V4e4n0fKXFVVn5QwhjzIVjjHNg
         ENx5OdJtZdE7edFkMayy8ezMPB1Cv9D7iA+iuplmuB8O/cNmSsPa1OW4rT3fmD5d0ME/
         cr/3kwG43HEZaTrTETKgRg9XmaQJQ2EFV3HZe+VPjUj5nXdyhPwyLmM3pE1cMXnNJRu6
         SD6A==
X-Forwarded-Encrypted: i=1; AFNElJ+QQa1doUhhZCPMRLWTl+Wj3bmg/8Ozzj58O06/VvGlDiFZ3pOoFm9ebC0FkT/e0FncleiIFfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1uq2ID6dum5bANe5ceivpMPLKaC9zb6jhmdpYw2Hyv45XTRM
	88hKxniLsfcbM2daZ537IY2614i6YpkDoB4ssfNzp0znOMEau4DyOHJJ
X-Gm-Gg: Acq92OGrjFznwp7DBPtnTSUpzfoNG/QhpzevEUwj0v/m+fcAtteTcFUhL72nPktRJG9
	sBjFTc/SgtRtEA32R0G/aWGWMbGK2qLHdXm831wVMunzxA29wp2ENiVxYNpzogdNHIFuaFdHIO8
	sg2GNaGkarJym6sUiYFtlj3HTtSy34LaXjBLFCFkOnBUWm0YG0RQtKRWYDOUHxVTUL1Es8pPytC
	00DIF41GN5inyPGZKrNrj1EiOHGAl/ume3Qu/dAlwXXQPqkd54imkFl8NcI5gpxb1CLMlm4ZCM+
	OsNbQX2EvogW8SUfJEISA2ltjeRn56W9ekgvqntA+CxgWBVdVSD/dzGausz+0cjrd5rEKuJ5QWa
	wBUIHsap3Mnl1WNB4M5lNF0MHcRpA+BzUhWlZ7pfvC7PkfVUfCe05UywyYL7TYlkCPPtMr/CwQB
	nzblx0VVANjR2PC9DYYvMdqZHnQGNtR6KeYxvPlrBMOA==
X-Received: by 2002:a17:90b:3a05:b0:36d:b12f:613c with SMTP id 98e67ed59e1d1-3779f186dcfmr2904451a91.10.1781180609829;
        Thu, 11 Jun 2026 05:23:29 -0700 (PDT)
Received: from [192.168.89.2] ([27.232.220.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3774f4c2e5asm2564395a91.0.2026.06.11.05.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 05:23:29 -0700 (PDT)
Message-ID: <61bf60fd-2ccb-4d23-be5e-041c7c312510@gmail.com>
Date: Thu, 11 Jun 2026 21:23:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] xfrm: extend ESP offload infrastructure for packet
 engines
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Antoine Tenart <atenart@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260523121522.3023992-1-hurryman2212@gmail.com>
 <20260523121522.3023992-2-hurryman2212@gmail.com>
 <20260611115646.GN327369@unreal>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260611115646.GN327369@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298110-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:ansuelsmth@gmail.com,m:atenart@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,lunn.ch,google.com,redhat.com,secunet.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69DBB671C87



On 6/11/26 20:56, Leon Romanovsky wrote:
> On Sat, May 23, 2026 at 09:15:20PM +0900, Jihong Min wrote:
>> Some ESP offload engines operate on whole ESP packets rather than the
>> generic software trailer layout. They can generate outbound ESP padding,
>> next-header and ICV bytes in hardware, and inbound decapsulation can
>> return an already-trimmed packet with the recovered next-header value.
> 
> How does this differ from the existing IPsec packet‑offload support in the
> Linux kernel?
> 
> Thanks

Hi Leon,

The short answer is that the series did not explain the relationship
with the existing XFRM packet-offload model clearly enough.

Existing XFRM_DEV_OFFLOAD_PACKET already represents the high-level model
where hardware handles ESP packet processing instead of only crypto
transforms. What I was trying to handle in this series was a narrower
case: EIP93 is a look-aside crypto/IPsec engine, not the netdev itself,
so the Airoha netdev had to attach that engine into its TX/RX path and
let it generate or consume the ESP packet framing. The extra hooks in
this series were meant for that look-aside integration, but looking
back, the split between the existing packet-offload model and the new
plumbing was not clean enough.

At this point, though, I think the right thing is to withdraw this
EIP93/Airoha series.

The reason is related to the SOE work I mentioned in the other patch
thread. Many Airoha SoCs also have a higher-performance IP block called
SOE (Secure Offload Engine). I recently wrote and tested a driver for
that block, and I am currently carrying it here: [kernel: add bonding
LAG XFRM offload infrastructure and Airoha
support](https://github.com/hurryman2212/OpenW1700k-test/commit/fbfe8f919f836bb62b3849f803865a4d9b8dc76f).
With the EIP93 path I could get around 1 Gbps, while the SOE path can
reach about 5 Gbps in my current setup. Because of that, integrating
this EIP93 ESP packet path directly into `airoha_eth` is no longer the
most useful direction for Airoha Ethernet.

That said, SOE exists only on some Airoha SoCs. EIP93 can still be
useful on other platforms as a look-aside ESP packet offloader, but I
think that needs a cleaner infrastructure than this series had. The
look-aside offloader should be able to live as a separate module, not be
tied directly to one specific netdev driver, while still allowing
compatible netdevs to attach it into the XFRM path. I think that needs a
more general infrastructure extension, so I would rather revisit the
EIP93 work later on top of that kind of model.


Sincerely,
Jihong Min



