Return-Path: <netdev+bounces-267185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FZwCEkNs2nURwAAu9opvQ
	(envelope-from <netdev+bounces-267185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C7B2776E3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25B2D302633A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357835A390;
	Thu, 12 Mar 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awzFKQ82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D62306D3F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773342023; cv=none; b=dDtpI5ANmJn3owa/wJBbiMRNXNeF8p5B2trdDezd9PPCSWxtY7Js5zvLP+cpuCekVNZbTWtXRkAlEk15nP5q9Kesy12SoAU1KX2dHlIQacgW1etMsaSkHQPzw0jFLZ4DYhbvNZho4HZgDAjjPzvUJ5RiIB+sLpD8EzRtyGPCb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773342023; c=relaxed/simple;
	bh=WykRGsrwCIPfykCk/wqlIrJwdiF4UsbW2+nJIdhQj8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwqiRuz8P7KezB6RUwWnI6cM+d4jVV7+nV/B4dmFYtllwg83V7rfkgm+mtZA1SlrmXp7EiJulk4Zkt0Q0wCI3S8Oc86uW5yf1r02x9pAjwQFkVjVtwTxw2QUIMbl3th+kdeAiMs4finFkMZZ1L5ziS+u3A2uU7A5KdcpyE6olTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awzFKQ82; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so11633555e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773342020; x=1773946820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uRNP8sj9zOHORQvbyaXxs4QwcaBwFw81kautX3rWdo=;
        b=awzFKQ82jg1yDHKSgiorB6aK8MlRCdyAmz2scVWDoAujEzEIHgLL2HJnxYLgKL5q+s
         PKyNm8o9wYUodAgpJWpilmEOoh9xkc7zfsEeodythjV9wsbY5z7IyJtx9GGe/YbuPg65
         Mg2w4oj2WV+u/8Ks1ut56jHccYANQCRpVaEr3OuCZlzp/RvF1q1VqIwy+lCAyYBGZKJT
         WRoNvn2Qmo6niNXcQHmq0aOtL+0hUNvAeWnuvRLC/FQnvEzSHaarrZn3zyjiOrX7HtWe
         H0iAoYUjAb4dFq5yvbg9B8Hgd2FIWQ0EDBvKPLlpfbw6R0jAD504PYyptMvRDOHBYANZ
         UkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773342020; x=1773946820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1uRNP8sj9zOHORQvbyaXxs4QwcaBwFw81kautX3rWdo=;
        b=CIZWKZGbY/RsD+g7G7/NjFEqha6tPYvh/j5dlKrtG2CYGaLlA1vU0DLaJKiRig+QCJ
         TO3O1Qmlx5PstwoI1yiB/M8laz9DSsvR7NXpLqwXZm+E6BVmm+NHgn9tSmnrMxYvK0iG
         esm11qklYgHGRhIk8JwtBs+TKilaAxJNMeqF1g63oJSAP3knyGtHXqMWe8cdUQpGQ0Mu
         /YOFV7nsk2ZcvJGq9y2CWK1hErNXsKtqVwT0NGGu04L+SY9lzqWyuvrtboO8Er95d/f+
         tk4n/HBlWdRhX+gj4XnATgXBLp8C3xop5HuXAiBZniyhoZwYj0lncVfTobGqA85hjmFt
         qK6g==
X-Forwarded-Encrypted: i=1; AJvYcCV7LPqZi92uWFdUzRmxGgddhdMjNnUNRVeMLD45J7Go9EtmaeCRZbqUBoZXCP+QEKYswOF7pwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJ4Brm8t5fEzh0R3mAXQ9diK8gD3P0ziVFu9JHGMGluwVAj6y
	SKcf/dfIxuGplW9f8cpQclMlacQDidn+M8nUZFxiw51AH0s0i/71RFVs
X-Gm-Gg: ATEYQzwTWCYU0g+BFxekBG6A21xkM6CYdJrhzLjhZ6ljMqj2JTYXjRRcmzzmSvjv3Fp
	T73ZD5APW41UUprefDbqxTmKSTKEYuux8OTsXmrRaiyXvyosLvAhc1Pe00My1MVfAS88oqmQ5V4
	+8G2/RpU8yviqrKlud+iDdZ5kl/owbWF60FN9KeLFcfMCDRZnYL5G/lCluuX4OBy3KC7Rw8JDYI
	enahiDtBTe/j1YFXMXgNHJAeyRdJZw+wb11LfWYprGoLGyQK4UKowwRr5o9gFMRrnIsFVxVzv16
	q5HfgWOFaOv6CpKDq74gkk5/saO74nZu6j+IkZdaOeINYZkJGFKwglfdbg/ddLUL/uqjuFNoDEA
	79lAFmjJfyjdlx44+JDxvZKGUnrFN+LmoLaUBjmEYaYDHqGJqzxSLMmpCGRnWGzyZQEKYVwpsiD
	X1XAcT3Hfh1Xv3tjxTTwR7ZpFusBrxbYh5jl1mkfaMpEh/ZBHcSFTFnsued8NFSM9oBvywGIIt6
	HU=
X-Received: by 2002:a05:600c:8286:b0:485:34b3:8585 with SMTP id 5b1f17b1804b1-485566d6dffmr6984515e9.8.1773342019666;
        Thu, 12 Mar 2026 12:00:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ac5fsm10964630f8f.1.2026.03.12.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:00:19 -0700 (PDT)
Date: Thu, 12 Mar 2026 19:00:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Zink <j.zink@pengutronix.de>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Bartosz
 Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gatien
 Chevallier <gatien.chevallier@foss.st.com>, Jakub Kicinski
 <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Richard Cochran
 <richardcochran@gmail.com>
Subject: Re: [PATCH resend net-next 1/1] net: stmmac: actually error
 requests to change the auxiliary snapshot capture channel
Message-ID: <20260312190018.15e6310e@pumpkin>
In-Reply-To: <09528d3a-e08a-4942-aff7-b59610f6b13e@redhat.com>
References: <20260310140155.3359-1-david.laight.linux@gmail.com>
	<09528d3a-e08a-4942-aff7-b59610f6b13e@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267185-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[pengutronix.de,foss.st.com,bootlin.com,lunn.ch,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5C7B2776E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 15:07:49 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 3/10/26 3:01 PM, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Commit 2ddd05d1d5ed ("net: stmmac: do not silently change auxiliary snapshot capture channel")
> > added code that attempted to return -EBUSY to a PTP_CLK_REQ_EXTTS
> > request whan a snapshot was already enabled.
> > However it tested bits in 'acr_value' after they had been masked off
> > so the check would never return an error.
> > 
> > Change the code so that the test actually works.
> > Note that when the commit message says:
> >     Previously in case of a PTP_CLK_REQ_EXTTS request, previously active
> >     auxiliary snapshot capture channels were silently dropped and the new
> >     channel was activated.
> > this only refers to two commits earlier (a few minutes earlier).
> > Prior to that only a single fixed snapshot channel could be enabled.
> > 
> > Note that the check will reject requests to re-enable the currently
> > enabled channel.
> > Plausibly the best fix is just to delete the check completely.  
> 
> I agree with this last statement. Enforcing the check could potentially
> break the user-space.

I did wonder why the 'half hearted' support for multiple snapshots
was added at all.
Either it is needed and should be done properly or always using a fixed
snapshot bit is fine.
Not that I've any idea what this code is for...

	David

> 
> /P
> 
> 


