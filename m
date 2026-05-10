Return-Path: <netdev+bounces-286277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBaSIPlpAGoCIwEAu9opvQ
	(envelope-from <netdev+bounces-286277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:20:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9FF503C67
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6987C30068C3
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DAC35F603;
	Sun, 10 May 2026 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENYAcJS3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A07328611
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778412020; cv=none; b=GHEAls9Q/e8AAZAuj4oCA89lYm3uD3myjWdm2F/8BH55vSSvJ8B1PJT/2wDbtgKaM1echvC1UmyD4XohcLcLTqnyiYLdWiIfkbW/Z0hx5VVWHqdO5daEyw2ZrJ47uZW/NJBlu79+D+J9py1lllwdmEbO6EVnbvg+apT8EMrx6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778412020; c=relaxed/simple;
	bh=nvm3AGWDPV+UNAGaz5KLlAFgRc8pkUOk/5BTrLxe+SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eajCZwM5k/7wmWpE00clJCR+KLrTaXZQgCFkVOsRJLKJ/OQHfExQ73c73zth7psKydK98O83E4Pb/NDp6g+E7GNtR+TwmfVLEfjxrLQbQxzP11FfaK0PTIizOlj15HwJPQ/n+grdNIwxtnaZLmc5KLiShdcZ8Oc06ztkM9IjEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENYAcJS3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b150559bso26038425e9.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778412018; x=1779016818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMvPn4u6zeRq65oCGn37/qMCI8MF134n0488D6SWF2k=;
        b=ENYAcJS3NsBmbo2ScXqpGRhpnIUsZgp/Oi2h0fd9FF27xnDAvQOTQjNGcL/TjO2KFi
         PfHVQ/XY9EaPVzxCwSBmy9IbESZw8qObVvK6P0+/Rk75nFC8p9yjouLkAvn28s/vi8a/
         7MoctpNFiws3jmo6k/Q1HgPJq71sw02SlqLNxnmXPYRPtFbbPP2V9yAR5bFS1kWeX8uB
         6Pk1d98331Fo7yBDVH+aUXlaPzRxir3UJsbyOFnhthE4kF0EdH+lvy/mok4crXEYFYu8
         YSkBcGV06SEHSUdH84g05Jb4mMVVdg9wXQov86F4BsrDZeQLoPLLju2WMnsI3OJZlUvi
         OQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778412018; x=1779016818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMvPn4u6zeRq65oCGn37/qMCI8MF134n0488D6SWF2k=;
        b=itGCdAEuuvdPv7COvTXNbMA3as3ZoSw+OUr/9RMtyacx9hMlWb9fASpaKvgl5oj2dG
         nxhskRYskyh2d87VhfiqpHlgI8ZrXHwyZSRcsdIswU/3VYOc7EE6tfCSW3AMpMFZLvlj
         gzixl4iXlgo54A9moHNYu/hXPnRDrDhw4Ok6VZeLMnG6Yqe3q0qMnArNgxJMKFEqet47
         vnJdSHtgYPjzREosAnWdApoolys4ylSktG1+ERgi+/M3NHjBrPeqM41M4sT3VG1KkcFR
         mvJdBO0RHmXP0hbmBwoOH3Qo7K1s83VBT1kfprQX4VpDsUs3mvfp965B00O3HVxxBTbn
         8uqA==
X-Gm-Message-State: AOJu0Yziqnp8MZE53+4D4QKsaOFZNXSKFwH5fQhc4jSP2uE52F032rL2
	JkvlVhhxzvdh9aGLU6F/Y9v9KyuvJQLs6LmQ1acGOacf/r0Go+Jj40DXu2qut2hx
X-Gm-Gg: Acq92OHZbg5tErf0goDxIvhHfjnfui16FE4Zfl+07QfLRxeiuxsyqN/CTKzlTIwbEH7
	QkWjoLAPWOGMkZjIT88VzHx9bLYujAtSE6aZiVRQ4wPD7PsdwxpenrweVAI0xF8u1j2229soycX
	VIPcLD2f2B4w1GCmkQivJ6MZdPgtQ/cXZqIvRCcGy4KyreFfEXsp0sLRRVeg2ittteAshnG4kHR
	AHzsr74/v4gAYhgSLqu6e1dS9cC/hOrFylD6NjDVF8kolarkDEDIavaVcWrFaMuTYv/42Aul4bG
	6Hdfj92teM1MQ0BcZpYAUNvnQOdG65qRSq4hGe3YKcnMVpLKs85p73zlHiUr+JpAw/8Qmer48SM
	a29h7uX37n0uNqg6hVxlBsvv58SSfU6WZW9r7BHXpRejdP2Rx775vg1RWBCh1lzB2PH/En9tfzA
	cKHTI7QivFJ6CbMp/Ke+w68yIoYZ/v1F5Yih23AmmO88oLu3ibung2BDEliS0chT7h
X-Received: by 2002:a05:600c:8287:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48e706c0827mr86189685e9.11.1778412017612;
        Sun, 10 May 2026 04:20:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e74dc9a8fsm30510205e9.15.2026.05.10.04.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 04:20:17 -0700 (PDT)
Date: Sun, 10 May 2026 12:20:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Simon
 Horman <horms@kernel.org>, Tobias Brunner <tobias@strongswan.org>, Herbert
 Xu <herbert@gondor.apana.org.au>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec-next v2] esp: Consolidate esp4 and esp6
Message-ID: <20260510122015.02dcbf4d@pumpkin>
In-Reply-To: <afr4ipktV91sA8WU@secunet.com>
References: <afr4ipktV91sA8WU@secunet.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EA9FF503C67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286277-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Action: no action

On Wed, 6 May 2026 10:15:06 +0200
Steffen Klassert <steffen.klassert@secunet.com> wrote:

> This patch merges common code of esp4.c and esp6.c into
> xfrm_esp.c. This almost halves the size of the ESP
> implementation for the price of three indirect calls
> on UDP/TCP encapsulation. No functional changes.

Merging into a new file make it very difficult to see the changes
(both now and in the future).

It might be better to merge the changes into either esp4.c or esp6.c
and then rename the file afterwards.

Since there are only two possibilities (ipv4 and ipv6) conditional
calls would be better than indirect ones.
But it is pretty impossible to see where that happens in the changes.

-- David
 

