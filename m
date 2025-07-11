Return-Path: <netdev+bounces-206258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B6B0256B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1531CC457E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C629A2F2C4A;
	Fri, 11 Jul 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReTJTguX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367892F2726;
	Fri, 11 Jul 2025 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263497; cv=none; b=SRS1TzjfMWI1yATzBcoU5R6sN+ZU9eLQtdxNSgSeMbF5tBaScJ6heNIGpbt40BhDsbyrMbe+akDW7JIZn5HvVFVUosNAGz5DnZ8VE4IYXqUa60pCM/eqUcbXmq4U5/IY5ko9MOdsvYVEE5SDVH/sQvEKui+niRxwH3zOgolOmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263497; c=relaxed/simple;
	bh=QhVb3awfavrGOAP8/pfLZ+IvqDGTKuAPGBc8v/zl9so=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EEdX47ylsYmJqeEWsiuTaud8ZwmMi8Od9MgZ6AZCOMHlEj9LdsFO2QBDWKhOpE0ZSfcKBdwQD3W4SKzO6Oi3KPbMozTnYvfXBRiNsI7rGCipWfcWdIl6FoAoMYMTlK7Am+F7x7NUw4rx8+/vUNfbFzqsvMJ0arNbYF7Vh9rPGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReTJTguX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e1d8c2dc2so23943317b3.3;
        Fri, 11 Jul 2025 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752263495; x=1752868295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhZ+HB499X8gL39AisVLojvyee+mqlvf6jpJvUlF+p8=;
        b=ReTJTguXlv5A3rv38D+nBlEUe5WI/6NdZfM+bJHM1B503UhvdOuBzgBHcueYCzOQl+
         L78Kxe13/51kk4w5YKWayL/daYhW87WmTjAnnW0FSH3BiIF5S3/RwA8COmdo6BaNb2cq
         f8l4Nx9Ewi9loJkA54uhloc27o9bJtZ9Qt/u9wJfLs4yYrrr+OJz1ZnCD2b3VCC+b+PM
         gG22ZGekt4OHW6fuPu3nmDhzz43wifsC2kEpXLGWeEzEgPJyNuBpkM2BNeWRklywyu1y
         dMiJXk0MbMXsFjexB4OmjOeLykTHirtMVyl9zwaKIWCx8XLSrri08r+qQvd69LOt2sVu
         lheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263495; x=1752868295;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YhZ+HB499X8gL39AisVLojvyee+mqlvf6jpJvUlF+p8=;
        b=ajHobtk2W1mX4L+ZfSGDXKFCi6Bd9Qe/UX/dmhKonSdfLKUYyypmz9v4bRM/oOEaLi
         nVHHod2dw55pijX3LMGhvDWB3YpgBDCjOuPUMjNPPnT8EsGR5VEeXRWTiiithuRAGhhy
         HzdzaRY2rkItQi0TBqWSd+vwLpr4e9DAgn6yUAN30IONjV8tNeUhBJ5VpzCWUqgAXzeM
         SB2eJgvWwW6oSi6+vvZbgwPnm5zGFQWzYAf9KXbboWllyGBuwnLj7BmLcjVfnfkUDAIn
         FJetowU+CrrJL6mfbAcSlxPa7q296hvamoMbEsp/NsTz2GoxEayX/fOnv8baVDwIjS+a
         f1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSd6UPTvEUVeuNeUB3yd7LlI1/re96VrOysbq45ERqVzwjzhgX74XgT2MlyY1dnIEaGFnnxDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMBKYqvSwlD7v3XZqRcuQBQLVLh0ThTVzBbHj7Ce8XJvjJzPX
	Wc7yWXMlxjBs3iQPBczpEK3FHUmJQ1Su/kLVt3G8BoUEdAbuOeSTLk5F
X-Gm-Gg: ASbGnctV1o/6zCbqEH7Z+hqaHq6OpFxdjwNN4m4CZ4D5/r5mpEXB5wRiTZfhAuN+dry
	JkJu1364lLXBdB/JNV4uAlsWdNrxdZIQ52WLZcZC5QoEv3UWzpbkZDHB4dDpevtQ1eq+RbqFJlL
	0jUJPw3JAeN8sJBb5HObee3n6X+JHTaUM+X3Gwj+Re8S30eJBWIIbUN/o7W2rPOV2E+o7LM+MLP
	mfvdG+TY0a91jX/GrkKtELq3OhxRCC3nOfflWhK85nkQafrh5anaaj7PmS7V2jws2h0W9PRbbnE
	loye35JfyK9UtdfZjR1tb8TyE4glEKHSG85M5ZxrRgfcMV+8PS1JxZ7uVfdDcGWDZYy//4KrBhQ
	KJQbKQ3miSMvShd3RP8EY2X/s0AF0ZcE/S0z3RtlOzk5+gfPINMyxHYiloUu5f+G2g5FHEdveVv
	I=
X-Google-Smtp-Source: AGHT+IGaRIPGbkptovhOL1sc0wpqdhiexsEWcFe2ZOkbXgAKyg0s/QTsWWPVLMKhz/WxFiVpiYpkEg==
X-Received: by 2002:a05:690c:730a:b0:70e:7882:ea8e with SMTP id 00721157ae682-717d7a619b4mr74604077b3.31.1752263495077;
        Fri, 11 Jul 2025 12:51:35 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c61ea4b8sm8809557b3.105.2025.07.11.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:51:34 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:51:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Gobert <richardbgobert@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <68716b45c8b0d_1682652947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <2c84bde8-5d5a-467f-a7ac-791207e7903a@nbd.name>
References: <20250705150622.10699-1-nbd@nbd.name>
 <686a7e07728fc_3aa654294f9@willemb.c.googlers.com.notmuch>
 <2c84bde8-5d5a-467f-a7ac-791207e7903a@nbd.name>
Subject: Re: [PATCH net] net: fix segmentation after TCP/UDP fraglist GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> On 06.07.25 15:45, Willem de Bruijn wrote:
> > Felix Fietkau wrote:
> >> Since "net: gro: use cb instead of skb->network_header", the skb network
> >> header is no longer set in the GRO path.
> >> This breaks fraglist segmentation, which relies on ip_hdr()/tcp_hdr()
> > 
> > Only ip_hdr is in scope.
> > 
> > Reviewing TCP and UDP GSO, tcp_hdr/transport header is used also
> > outside segment list. Non segment list GSO also uses ip_hdr in case
> > pseudo checksum needs to be set.
> Will change that in v2, thanks.
> > The GSO code is called with skb->data at the relevant header, so L4
> > helpers are not strictly needed. The main issue is that data will be
> > at the L4 header, and some GSO code also needs to see the IP header
> > (e.g., for aforementioned pseudo checksum calculation).
> > 
> >> to check for address/port changes.
> > 
> > If in GSO, then the headers are probably more correctly set at the end
> > of GRO, in gro_complete.
> 
> Just to clarify, in inet/ipv6_gro_complete you want me to iterate over 
> all fragment skbs, calculate the header offset based on the first skb, 
> and set it?

If that is the best way to fix this without causing regressions.

There may be a better solution. I just don't have a good suggestion
off the top of my head.

The blamed commit itself fixed an issue, where GRO code incorrectly
used the network header in GRO complete when it should be using the
inner network header.

Perhaps with moving that access to the CB, it is still safe to also
set the original network header. Perhaps Richard has an opinion.

If we want to be exact, these should still be updated to the inner
fields for encapsulated inner L4 protocols. Similar to what
tcp_gro_complete does for the transport header.



