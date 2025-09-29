Return-Path: <netdev+bounces-227109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05ABBA868B
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8407A8B87
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC923958A;
	Mon, 29 Sep 2025 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtvnSds9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07E171CD
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134970; cv=none; b=IlFq4DrRWYB6SjhQ/7VtL9j9m/QBrkVqF09XkUqku/Po3cDwHD3FxqgHSQXnregIwNkAQDMkRMWAWFkakGQJCbFVwcZrftgNSjTl77Pwpip8DN4jnuMQDaJTdH4NZeQFY2gSkHPo04xfbfDX/ZL3FWovEMPxcR45dn+ErtqFmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134970; c=relaxed/simple;
	bh=1tJsthNTFxuulixaTwySRyl9aKQCA8pi83MgtzQQI0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q62Y9HYcvscSraeBV6wx3dhUMciIWOfF2wjn3oDWWTJLAno1gwPoKP9GtiskSAoPtUOCtPZfpcifAhP2uUfj1lX5V/oSbt1056bhDUh2FvIdC6r3qGIO+vDZe0gq6jUntgImDitdBXOH8vRvl1uLrLHPQElo+bJY4zQtnZlQNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtvnSds9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f67ba775aso5210728b3a.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759134968; x=1759739768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RIGzfdB+V9pyAns690pgb5kkLaM1R48k/DR5PXW0P3s=;
        b=UtvnSds9oABPbuSmuSqASf1k3+Ejtb1K27Pfmn14chq1IWrTTjRtPsm8yhcQh4MQ5C
         yvc4r4MwqkTYUI1nqstpsHFzB93M1xR1ZhcsdjkNM2s/2h9WzXBjlQkIGXxbcd0L97MW
         x4+SxdYHTywxvdyPthKfrZRWqx1U7kTHAe/2UcV6I/JkpYXDlBDYjorurLoXhRiGsNCM
         wncNsOs1BgSWe2B26HQi6E569vmLDTsPQVUcKbMiftp78pAaId4/pPJ+YW+feW1+eidr
         HvkPwnrSsNJzhkfZMr5Mf5ydAWYsClGX5Y8owSZ9bq6473kvJgYk2/Sb71//WYcNj/X3
         Mekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134968; x=1759739768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIGzfdB+V9pyAns690pgb5kkLaM1R48k/DR5PXW0P3s=;
        b=fSBHmcXSHIk6Ykguvo3VVl18Tkr+Uu6IfPuyg6HMGviGwJ+FUrIr6XLFAn1Gd47FCp
         EjkM0CTknItJghTUWHdTokytHiDKlMV3ypkO/D2cbfo9tvUsAEFoZX5VPl5T8N+Mtamx
         2FplWgbpOpeXnsTdLvhoxiIejAHChvzF3jaPIeVzHU5lT1oOT5zmTWAOBQnBeKfh8eEb
         3pGUIW6vP/4FjyZss1MFvjDeOfbr4igMT0K3jyfCOneFjgM71LZ4qwRfmXsNQsyZqUEi
         qKqFpJOc14Zfbwofqk4Z6+kBP3e3Kluvnxe1dVWRscp01qieUZLgWtlhFufxNpZ3vLyg
         vwYw==
X-Gm-Message-State: AOJu0YzGP5O1rQeB9NuLT2cEDR50e3AVwVxvIEm20uBDe0jgOJxTv4HH
	fPfA1z5/NhQk22oErtvIG5RI5PI4pCfjAVhSCCY33MPHGBa8k+8NYDI/MftOhb97
X-Gm-Gg: ASbGncszcMmXpKgxXNOfSxQz4cAmobLRJS/UzX40Y4u0mFcb4BPhLC+7T6HAL4Mxl/p
	Z1GSRPZE+hF/cu1IqMHhUUrpRqZzZKr2iJam8AszueqKftDDNYymnEPwr+Gn5Eh85eH/xAjbbVf
	cWAKzEFRryjIGf8AovUVkVT8IlQMjOWx7bauYF3Smi8GX+PKBvd16dhuJWIfIzWR7cVAIsfA1Ve
	GyHOCU3/ptIDkK3KT6CUq2d2NkhuPNKIW02Jt97dOYVCep8TdpI4f7fgXY8BtwzlZ6dEguH3ieM
	7C2Er+5RfSDW0MpmioqWZBN3rav4g1Rxe7w8p5HEalrtgAOkKNArpyW2L5OTmeLrngvs/81K/9o
	kr2O4rMnsWagLYV/jqfpUJiSqk+CcBMXUXJLZqwSo4is410MG
X-Google-Smtp-Source: AGHT+IEBXeC8QChdhKkFQSOA23Do47Xl2rsDmjO7Rcbucm3kuxVzlun+rAn62Em+CesP1FVaFf+3Cw==
X-Received: by 2002:a05:6a00:170b:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-7811b4c7931mr12954083b3a.18.1759134968131;
        Mon, 29 Sep 2025 01:36:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b22f5fsm10661729b3a.53.2025.09.29.01.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:36:07 -0700 (PDT)
Date: Mon, 29 Sep 2025 08:35:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>,
	Liang Li <liali@redhat.com>
Subject: Re: [net-next v8 0/3] add broadcast_neighbor for no-stacking
 networking arch
Message-ID: <aNpE74KD9jxSo4Ei@fedora>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
 <aNNWDcvO6aCG94Qe@fedora>
 <9409D921-76FA-4A49-9E39-7F47DCB2B486@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9409D921-76FA-4A49-9E39-7F47DCB2B486@bamaicloud.com>

On Sun, Sep 28, 2025 at 12:11:49PM +0800, Tonghao Zhang wrote:
> 
> 
> > On Sep 24, 2025, at 10:23, Hangbin Liu <liuhangbin@gmail.com> wrote:
> > 
> > On Fri, Jun 27, 2025 at 09:49:27PM +0800, Tonghao Zhang wrote:
> >> For no-stacking networking arch, and enable the bond mode 4(lacp) in
> >> datacenter, the switch require arp/nd packets as session synchronization.
> >> More details please see patch.
> > 
> > Hi Tonghao,
> > 
> > Our engineer has a question about this feature. Since the switch requires
> > ARP/ND packets for session synchronization, do we also need to send IGMP
> > join/leave messages to the switch for synchronization?
> Hello, I'm very sorry for replying to your question so late. In fact, the non-stacking network architecture disables the multicast function to prevent the server from learning other server real mac addresses. This architecture uses the arp proxy. To better answer your question, I post a blog:
> https://huatuo.tech/blog/2025-09-26-some-thoughts-on-non-stacking-network-architecture/

Thanks for your explanation.

Regards
Hangbin

