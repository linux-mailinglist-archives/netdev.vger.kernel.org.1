Return-Path: <netdev+bounces-33619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDB79EE46
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4166C1C21093
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA559466;
	Wed, 13 Sep 2023 16:32:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D0200B2
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 16:32:33 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51F19AC;
	Wed, 13 Sep 2023 09:32:32 -0700 (PDT)
Date: Wed, 13 Sep 2023 18:32:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694622750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4gwsCbtaC/KCP2BoXEK3NS8uDKgrnFzIZ7+loZXK6g=;
	b=F92ndIr+WDdrx4JuPNU0rZtELDMxoKPv8Nabki68NizO4Aou9gUF2WZN34yowN7COsgXGd
	dAKOfAyYDx9Mqduge5FKPnqSlELFHbes8kF69r4lVYba+3jWI+ymi39idi6HmUckHxfbs6
	t01BBoeDcqYHg7zbBUYQzoF8flrNdHpbIChvVOI4++6NOfT4K6a5o72g19+fKcBKAh4vj6
	xRuPHcU/eDgfor3KUSyOeUFD+HMfsDqqDv2VS73ojXty6c+prhZ/8RDp8nnNa4Nn+vgU8j
	ir+X3b8AL2fFqXKkD9esqBNCuMiO85tGm8cBJ9JhR/FxtUR13dYY7f7MqSDydw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694622750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4gwsCbtaC/KCP2BoXEK3NS8uDKgrnFzIZ7+loZXK6g=;
	b=j9bYN7ZwjbxQ1gOcDwGpUIQnOLQiDIeJMb+daOcEYVPYBnieDJNVTK0Kk6yAnIab7lMexa
	4QCJMJIwvLFLdSDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kristian Overskeid <koverskeid@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Oetken <ennoerlangen@gmail.com>
Subject: Re: [PATCH] net: hsr : Provide fix for HSRv1 supervisor frames
 decoding
Message-ID: <20230913163227.ysmJocR0@linutronix.de>
References: <20230825153111.228768-1-lukma@denx.de>
 <20230905080614.ImjTS6iw@linutronix.de>
 <20230905115512.3ac6649c@wsk>
 <20230911165708.0bc32e3c@wsk>
 <20230911150144.cG1ZHTCC@linutronix.de>
 <20230912101828.06cb403d@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912101828.06cb403d@wsk>

On 2023-09-12 10:18:28 [+0200], Lukasz Majewski wrote:
> Hi Sebastian,
Hi Lukasz,

> Ok. No problem. Thanks for the information.

So what happens if you try this:

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index b77f1189d19d1..6d14d935ee828 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -288,13 +288,13 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 
 	/* And leave the HSR tag. */
 	if (ethhdr->h_proto == htons(ETH_P_HSR)) {
-		pull_size = sizeof(struct ethhdr);
+		pull_size = sizeof(struct hsr_tag);
 		skb_pull(skb, pull_size);
 		total_pull_size += pull_size;
 	}
 
 	/* And leave the HSR sup tag. */
-	pull_size = sizeof(struct hsr_tag);
+	pull_size = sizeof(struct hsr_sup_tag);
 	skb_pull(skb, pull_size);
 	total_pull_size += pull_size;
 

Sebastian

