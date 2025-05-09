Return-Path: <netdev+bounces-189243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15CFAB1432
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A8850480A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E9D2918E3;
	Fri,  9 May 2025 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS3sxEDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4F291176;
	Fri,  9 May 2025 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795399; cv=none; b=IaRMPFFfn99P3l2Yo/AmN8AhznHgVKBzBFTUa4b59etd+v6Y8tf596rIE7c8IpU+QajNBxSR5tF7W7vqswXkm6eCypAG1zKb3H1NEPp5iBdSvnwWNZdXDf2GAzBs7PW1IFsb0bOA3zdDAel7FC5TmXBWe8W47AixuSc3P2eOScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795399; c=relaxed/simple;
	bh=eEulgBiddSPX2RK7TdqXaa1VbtpWWvwEmnOnDQcmVnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUByqwgNRPblfSurUWfvdUgWpNF+l5MJdCUSYw4nUMG1jOnwc2D1buV38lwe+l9UXVqdc41+SCnMrG7P30z2aNUabh0UcjKaye8K6ZMa/gD2XlartktEx8ePWizz+DMHrujzCzmhHCaLS4HDWP1W2haMmF3q2DWa7YkVHrOvJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS3sxEDZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fa828b4836so334775a12.2;
        Fri, 09 May 2025 05:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746795396; x=1747400196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evkkZXoj/VhOqVAgoh4F9uXWFeC77YbHlW2Gg+VCwuE=;
        b=BS3sxEDZSAkyGPoQ7TcBXbUG86HvLcuQz6PkXU6rcQzXU+zIVAqmeHbWU7ZUHGgQ5R
         C0qtHi0VtT+BpA7MU/1Oa5LJwxyieLh+rWyq3xXJ5Xxtde5kiNrmSwYqBrVqAoaHtERN
         wMNN1lCKs3h6Kc/lJGjn+9/herVyvx5ZuIq+agtnzwITQ1/5dazcOYObIOYq5gK8ScgW
         iKt0yaKTDqkcavpRyjlv6RddOTS6gMH501GJqZmB+1J+7sfdJstt2PgAS37DOJQUpbg/
         qpdobg1cgWM33DqPVAjE7ZUVVr78XjtsVD/tsyFU4ZHSy5M0lG+P1IFP+dvcZ6w/AqJ/
         ebBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746795396; x=1747400196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evkkZXoj/VhOqVAgoh4F9uXWFeC77YbHlW2Gg+VCwuE=;
        b=I2oeU1jcTzpfGmqBTaqrOxLi8v4ar6GN27KYZpcKH/KHfGl2NZp5nvdm/hKMoU5Oed
         8r9NiJHmpXmPY6rwRRhFBsfKqNIQUafPEHMhouYMvsjSHKlorxKVR0N1oEzyH7S5w+NB
         JFC7zjraQbCPIcN/zLHW6dRl5oalJt62mIMjfKipO+XmAIqJeIAAmYQWq9uno3vJs/cz
         bnNVnTPh4lBHw1MxzJTzjFYK35LZuBLe5Hi16j1Ag2FPiLOpDCNdP+/dMsdMYH5FhAq7
         gXqq/mKLTR99UnAbZFK+ALBs7LFyf91F1rhVyVFqI9tRwxKdwuKrYLZLiwfXOM/RRg9A
         4u7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3+M1MwzGRWFvTUFZpd6GaCJ9ljc9XC5PReV7nSPhBDfiGOZM9x1KV3Zplq5htjf2T+0WdRpvzpZ328jA=@vger.kernel.org, AJvYcCXaDEqomnXNcLd/cpYHy86YeOKUb1yzEjn0dmLGKErCQOuwCaCUnuLLa5+m0D82yXGArvWTcMH0@vger.kernel.org
X-Gm-Message-State: AOJu0YzOvoivfszicpdG2ORvZV6b/wP7SfQtqvAkDaS8y0nPHzDd6ewt
	2qWjP4CfvJLupEv/nPHEqCvWyFEwaKbmJPgUnquJUYynGdORBOY9
X-Gm-Gg: ASbGncv8L6AUh8ZuxgyeEj4vbf9/sXCcg0WLDfnYIFIP1/GxtFpzt7VqsH9QKs6yoqD
	oo1mjyvK7UFbCsoLUQUbqil7njxtLxhGUhkxrZC7QGmOwvDsid6aMuLguywrbXg4k1AkoOwL5Tq
	qSZjwnaP3WPdfouY/oUIa97gQ7cuvNAaOyPBYfxcAewjdiCU9+fqG6csYhhblC2vKoT0d2aFXTj
	ZOsyMtOiqs7KvnetnR1j+8YSIgYuyZnabMGqH4n0wu34MfklpDGeV7wwnRVSMM7O7siVmK/sCfr
	3k7CW+53KMNev3/AuWtPFYL5kTYB
X-Google-Smtp-Source: AGHT+IETJc9VTIe+oklQHEE8vi1Z7BiidfOYztR4qgSvUyJTtTuPqagkaumWxFZ9cXcdOOfvW+M4Ag==
X-Received: by 2002:a05:6402:4309:b0:5e5:c5f5:f6a with SMTP id 4fb4d7f45d1cf-5fca0735f19mr1031091a12.2.1746795395582;
        Fri, 09 May 2025 05:56:35 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70f51esm1326234a12.79.2025.05.09.05.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 05:56:34 -0700 (PDT)
Date: Fri, 9 May 2025 15:56:31 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Jakob Unterwurzacher <jakobunt@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, quentin.schulz@cherry.de,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: linearize skb for tail-tagging
 switches
Message-ID: <20250509125631.cckfc2ychkyobqqo@skbuf>
References: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>
 <e76f230c-a513-4185-ae3f-72c033aeeb1e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e76f230c-a513-4185-ae3f-72c033aeeb1e@lunn.ch>

On Fri, May 09, 2025 at 02:31:00PM +0200, Andrew Lunn wrote:
> On Fri, May 09, 2025 at 09:18:19AM +0200, Jakob Unterwurzacher wrote:
> > The pointer arithmentic for accessing the tail tag does not
> > seem to handle nonlinear skbs.
> > 
> > For nonlinear skbs, it reads uninitialized memory inside the
> > skb headroom, essentially randomizing the tag, breaking user
> > traffic.
> 
> Both tag_rtl8_4.c & tag_trailer.c also linearize, so i would say this
> is correct.
> 
> What is interesting is that both xrs700x_rcv() and
> sja1110_rcv_inband_control_extension() also don't call
> skb_linearize().
> 
> Vladimir? George?

Yes, it should be a more widespread problem.

Have non-zero needed_tailroom:
trailer
ksz8795
ksz9477
ksz9893
lan937x
hellcreek
sja1110
xrs700x

Call skb_linearize():
trailer
rtl8_4t

It should be only a matter of chance that the other taggers haven't come
across non-linear skbs.

My opinion is that we should let taggers linearize when and if it is
necessary, rather than doing so in the core. For example, sja1110 only
needs to do so if (rx_header & SJA1110_RX_HEADER_HAS_TRAILER), which the
core obviously does not know. Thus, I agree with the proposed fix.

Jakob, when you resend v2 retargeted to "net" and with the Fixes: tag
added, could you also address xrs700x and sja1110, or should I?

