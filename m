Return-Path: <netdev+bounces-267070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMKoHQ7EsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:47:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2A6272DF1
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E6763024BD7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B2452F8B;
	Thu, 12 Mar 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgcx3EKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8E347FCC
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323134; cv=none; b=pbJkNk94jkufzWzkeM0fP5SQ5fy7fGmXAzOOVxttQVAu9i5CCjRsSEgHcu+RZ+b3k8Xcs9GguuqEPWMzqtY+ZtUkHI56X1uI9Ovg3osZXSmbMpv+msO/1sowoIC9NRn94gkd8m2pjmkK5qNt8wmEMuIdrVAeuZEkpYBOzR8Y754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323134; c=relaxed/simple;
	bh=Wt5BATW6JvyK5BQ3QK1RfPkmw62Sl40rb+G06/QOfX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4mnb1AfG1QYdaVqLbuM2A2WwTOKrDKcLpyYhvRSCMgmqDYXtI9clBmtLZFBjKmkNtCGt9TzEyr4RQP1xiG3v1zjC3+I0EBgg1opFq3Dtl04aDxMl7IDbXZFP4ZCEkzCVjku7fpsnuCbnDiGszjfTpHXFjcUH0sTQxzeD32eBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgcx3EKQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439acc60f9dso142297f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773323131; x=1773927931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w8UmW8sQ2uXBuq6IRN63MLvpqvH9wjFOuNdu+RVv+6g=;
        b=Rgcx3EKQhUpx8rM4CG3s350Jj3KcYlzHCKAh0RAgepTqIUy3+dM2knes691/S/BRfX
         KF0McXLuepkEZ5x6nMOqDzcjMTcGRAYVaRA6mlpAm8jpFz7R82IynhVTAD4A08eDMA7r
         4s/qnRrYPmP83wqntAzt/TEd4w50ceSYz4R5gK9a3d/qodLQB40GkniZLrdbWGeQCAm/
         nbWxlv+yAhP5yS0VVWsX8cgn9JkEXU6g9dWaRBMmFyvRxqCLBURVbEogwnvvTXkhcRfo
         ++D6xGpZZiJzl4BYJyQysATYtnewIAfoRCZyihCu320415OGSY7FWgjoD+ii+m6+mqcZ
         Y6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323131; x=1773927931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8UmW8sQ2uXBuq6IRN63MLvpqvH9wjFOuNdu+RVv+6g=;
        b=WcPZxfQX6ehtgsStbimOnEvvjpdFEc9dG8UHFi7hdERyoPsYUoLvhU8DvLOWhnXO2m
         iIyaCBDnJdL/eaR0WXTddY6ZnrBTD6jnQUYBvl6pXU2eHyfgQ4uqukFSADXeEa+mRUfb
         u8W8jp7754BL5x+aevD+I6eKjykgFkYm5FmqfxdPALGx1M8Ph6seA9wnR0DnUd6QA6MF
         RoNq/nq3LOusZtOUubH/XSh06M3dGOXiIj+X8oZhGUyYBBtt9pRBjHgOzgwQd+n3Fsvr
         /PGdNPd56lAvEJm81WFxajxFepcOAFUx/Zu2D5BeeYHUnBu/m5PMtjMFM+87AVtiFSht
         Hlkg==
X-Forwarded-Encrypted: i=1; AJvYcCVqo+45/MSXACbKBUJw80pdTqkJFLdcMWaUkRgG+KTAnJeUfaCo3LpaoRLpDvrGTFkUixBv6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlABqsQc66ggVFSS0CUx1QCM3tR+r1xKdQ9sFPkicBS8+mXqp
	D+Cr9nCRHIdN7ZgYUb3XKOxXrBE29q/nUenA9iWE6edc0BRjG12Q2X82
X-Gm-Gg: ATEYQzzetMLGEqVuLlZdZ19jqjkql2z3I3l1D8VLh89q7Xme0BchY2Qc9NX6ARDGD1/
	ImD8Utp5w9+wOHlHNcPl7yO5wqOZ3/Gv6fd3Vqu+PhwLp2VdQqy6/OtcckXk0LGCj7XSKrEg6Kg
	6zR7x9ISXvrurSjoIb1pN0QIwbRciBht9umhsGEbEcO1ICuTrSpmk9yFZug2I60zH9zBSq11UsK
	IctBVCgTL03Se8fxpJE80npagNoCqj9w1omlnuFJZGQJwZRf5Mn98IhAj+zbgbdcmCG5GaIOLg/
	csMZPgmgjxgEg+gNeWxUufr4WGBmDmEtA2267jOtNL+NmMno41s3BIp1RUaW7lJRPqjqUGQg/ND
	Vau93TwreMXE95EVcL2hD/unprbE6uzylJ8ZNswcV/Zl7BFBeh/WtL6zZBZ2Q3U7ERbJNsBqTRu
	RnGW52QP4eJRxgYA==
X-Received: by 2002:a05:600c:37cc:b0:485:385f:674f with SMTP id 5b1f17b1804b1-4854b104a8bmr60267645e9.6.1773323130035;
        Thu, 12 Mar 2026 06:45:30 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00a:e00:e489:77c9:805a:398d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66e3f8sm132490065e9.14.2026.03.12.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:45:28 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:45:26 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tristram.Ha@microchip.com
Cc: bastien.curutchet@bootlin.com, Woojung.Huh@microchip.com,
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, horms@kernel.org, pascal.eberhard@se.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Message-ID: <20260312134526.3lnifstvb5dpghrg@skbuf>
References: <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267070-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B2A6272DF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:14:40AM +0000, Tristram.Ha@microchip.com wrote:
> I just tried the ks8995 driver and I do not think it is ready to do major
> DSA operation.  Actually I could not make it work if I registered it as a
> DSA switch.  DSA could not register the switch PHY.  If I removed the port
> information in the device tree there was no error message but still the
> MAC could not send out anything.  If I skipped the registration at least
> the MAC can communicate.
> 
> The driver is using DSA_TAG_PROTO_NONE so there is no tagging involved.
> But then I do not know how to define the device tree for the DSA to change
> the STP state of each port to allow communication.
> 
> The primary purpose of this driver in the old time was to enable the
> switch as the hardware default is disabled.
> 
> Even though KSZ8795 was added to this driver its register set is not a
> complete match to KSZ8895.  So some functions may not work correctly like
> the change_mtu one.  And I do not think KSZ8463/KSZ8863 can work at all.
> 
> Since we have a working KSZ8463 PTP driver we should stick with the
> Microchip KSZ DSA model and work from there.
> 
> Out of topic I found that the NAND driver is not started in the new 7.0
> kernel while 6.19 is still okay.  I do not think there is a major overhaul
> in that area, and the Atmel NAND driver code is about the same.  I thought
> the device name may be changed so the right driver is not picked up, but
> using the device tree in the 7.0 kernel still does not work.

Thanks for the comment. I took a deeper look at the ksz_switch common
driver and I've started working on some patches. I'll return when
they're more or less ready.

