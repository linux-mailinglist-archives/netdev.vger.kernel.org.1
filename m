Return-Path: <netdev+bounces-294427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ik4EM15NH2qAjwAAu9opvQ
	(envelope-from <netdev+bounces-294427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C336321F6
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 23:38:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BVwjolxZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294427-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294427-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30FA9302735B
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2028A3939B2;
	Tue,  2 Jun 2026 21:38:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329C39769A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 21:38:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436293; cv=none; b=M/BwQwzcUSWEz7tLE9SM8ZBN4ghXnQa+9y/PA1Vzz80HWeNJYXrNrjWnrv/M3T0RD6CLeKbPBrcYgWsBx/vbm0QvLwFb9s/dmfTxtlHdkse+TzTiAN2vv0oI4pgBsPagr56/8GAyTaJDVy8K1YONQu4IF1icU9yBFf6lkG7zWPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436293; c=relaxed/simple;
	bh=hftNYSMbSp1TuP7VpQO7lZ+O/m6etFx9lq2NRS3Ojp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyApyPlyAq8omDz+IvyTRuhNQ0wDeGx8NL1l/r/3sqMkWkXjvsPz0oYgPzU7AFuiDfJziogScdyS46UYyFBh5yC3mKmFatOTg484e+WSCi/dbMxSnAmYawLdH5le4CUuaOxGEqRkVC4wO9PRiirN7DNNjSQ/VD2UfiPdnYnmzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVwjolxZ; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ee6d32402so3215156f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780436290; x=1781041090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/ap9qia9JYLeOpELZTf6TGNRq7FqU62AdQC2ibLAXw=;
        b=BVwjolxZVO3PX6BW0zSnxud2oCM4P1Dd/OsATphXdpG7ly5mkf1eu3ZG6nOOQwnGh4
         vSa2It49zTfUXbv1exRMkgCBIgu6vbzFk85aTS4saZpYkpzHCskJyh2amkGMbx7pLkpr
         WIhxg2FJP/09enWYHow4FvTSaSfNkcmkWhPd/WXCspzLO98psoEngYsKKdH+7OFu/UYr
         N0WWsUn3lhfzl12C8MuLj8M960Nbw6tpP/4YMmNdvIPYJD7iheDtmXu88VDZa1wTlcSv
         u5xczpYUMjIzRDJF/LJ4omsVEqxo4TfJvrlyoXl+eB2bWXO0l1ECCxn+uMhjEDy1rA26
         wlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780436290; x=1781041090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g/ap9qia9JYLeOpELZTf6TGNRq7FqU62AdQC2ibLAXw=;
        b=K8nOYgv9CpQU2IEwaRWBNJEpXEv1aYrUJpi9IvCq/im3xOMtxB+PnoHUQ9debt5JCk
         GmFiYG9ilV3VfzNzDPELeYzjrK0kpLWzmLYu2GMGp1NL+QFFzMGhHrN5QFjAjMm1zNAI
         R4cTjUqY6aSD7rB0gwLK7XqIs3nk3zXTIWXJArMWTjl/AEfeoTKV6Zbz0TWRv8BI3mwd
         8SzJP228GRAoxPvK9PcOgakuGWZIXCKkG+rTYyLfmMWo6+g5m+nQieh8dY4HeYB8Sg0B
         clzz/XHNlAs3JoSb8SEUoNFcRbcm/b2/zJ3S+HgnXbcQRh1Bj8TXkdzMmePV0/SL+i4Q
         z1gA==
X-Forwarded-Encrypted: i=1; AFNElJ8vbbiG2vuar4zWU2IwaDLa4incF5TV3gmkZvEmvBRdacZpi57tHc0myI3p6Ny1eP3oUX3OfnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+X4nEbbijaUhBYjhH9BXdrrMN3aYf7FMYt02aQL+9uv+bveCt
	1AmjxRgbAqKKilNETb7Q/miHXxegChpjsceboZut2QPdQRGiU97suyYZ
X-Gm-Gg: Acq92OHhgg9b0vv0BG+uSAz2fksQF1nEXAzC0Vy/jhv0g75hdoAZrMct+sMAjCKt3gL
	dvHFayXwJt3DfqUZYP7WS78aPnPmWqsTASfvTXqOgyfvZpgo5qRjIhx3AO9JAGdjtmI0PYI8IXb
	WAXtnjDtUas9ln3d/h4ep1NoXp8jTywSP/e+owD9ZF+r24a32R/YZ/rc/Uw2vzlugT4b2lyCFIq
	nXfKNh/sdQtJuLEhVA7hbqf2NCLd1f9v5JxCoxmymq4cjZ6FMKwMRyVJLLyJC4o+5lm3xy8O37a
	iWauKFlUp7oJahfLzT5G2+zx1oP3Pui73DqeBTSxjLLcf4RnA5bJT8Tvx/2AS1b+umZ27SyPYff
	QfoHOIGdavk9SWjHM61Emm/AdRmm9LGUyxVb0p1iiBYQ/IqbPVVYO+Ih85Ua3RagYTQdLxKAsUo
	kxOYtTGwYa/+v1rmxAPsNm3cbdgNFsrUniLLkouMPN3eDDyjwQpfkJ7WtXJuXn416cNXj18Uw=
X-Received: by 2002:a05:6000:2905:b0:460:ff2:63e5 with SMTP id ffacd0b85a97d-4602181e60fmr331877f8f.18.1780436289783;
        Tue, 02 Jun 2026 14:38:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm2333502f8f.28.2026.06.02.14.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:38:09 -0700 (PDT)
Date: Tue, 2 Jun 2026 22:38:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Piergiorgio Beruto
 <Pier.Beruto@onsemi.com>, "parthiban.veerasooran@microchip.com"
 <parthiban.veerasooran@microchip.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS
 size in RX frame
Message-ID: <20260602223807.1ac76456@pumpkin>
In-Reply-To: <CY8PR02MB9249B26D4B4344064A582A3C83122@CY8PR02MB9249.namprd02.prod.outlook.com>
References: <CY8PR02MB9249644F900471DB8417134683162@CY8PR02MB9249.namprd02.prod.outlook.com>
	<cf87ad90-6ba4-4132-a1eb-beedd796c168@lunn.ch>
	<20260602150712.5b28d58b@pumpkin>
	<CY8PR02MB9249B26D4B4344064A582A3C83122@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:andrew@lunn.ch,m:Pier.Beruto@onsemi.com,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pumpkin:mid,onsemi.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48C336321F6

On Tue, 2 Jun 2026 15:37:06 +0000
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com> wrote:

> > Subject: Re: [PATCH net-next v3 08/14] net: ethernet: oa_tc6: Remove FCS size in RX
> > frame
> > 
> >   
> [..]
> 
>  
> > 
> > More of a question is why request the MAC append the FCS at all.
> > You can use it for error correction - but no one every does.
> > (A 2k frame has 32-14=18 crc bits for each bit offset which means
> > you have an 'average chance' of finding an 18bit error burst that
> > will fix every crc error. If you find an 8bit burst error that matches
> > the crc error there is a reasonable chance it is what caused the error.
> > Single error bursts are the most likely errors and easy to locate.)  
> 
> My understanding is that in TX side, MAC will pad FCS automatically.

TX pad is separate from the FCS.
The frames are padded to a minimum size so that collision detect works
on maximal length 10M coax segments.
(Or rather coax+link+coax+link+coax acting as a single collision domain.)
The same minimum frame length is used on modern networks which are all
physically point-to-point and all 'hubs' are store+forward where a minimum
packet length isn't strictly needed.

VLAN headers can give unexpected amounts of padding - VLAN didn't exist
when I was writing ethernet drivers! 

> RX side, MAC may or may not strip FCS
> before passing to the host. I believe our MAC doesn't strip FCS in RX side.
> 
> Here is what OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface specification says
> 
> 7.3 Data Transaction Protocol for Ethernet Frames 
> [..]
> Ethernet frames are typically transferred from the SPI host to the MAC-PHY without any padding or frame 
> check sequence (FCS). The MAC will automatically pad the Ethernet frame to the minimum frame size of 64 
> bytes and append a computed FCS
> [..]
> Similarly, the MAC-PHY will typically strip the FCS from received Ethernet frames prior to transfer to the SPI 
> host. However, the Ethernet specification allows the option for the Ethernet frame to be transferred to the 
> MAC client with the FCS.

Is this an SPI interface to the ethernet MAC?
You might want to pass the FCS over the SPI link and then verify in software
before treating the frame as valid, deleting the FCS, and passing the frame to
the protocol stack.
This would give extra protection for errors on the SPI link that might not
otherwise be detected.
(Although if you distrust the SPI link you'd what to pass the TX FCS as well.)

Unless you are doing IP checksum offload the IP checksum will pick up TCP/UDP errors.

But if you are running ISO transport (which we did 30 years ago) there is
no other checksum. So if/when you have a VMEbus card that suffers ground
bounce when, for example, passing a repeated 0xff, 0xff, 0x00 sequence you
get corrupted files from any files transfer request.

-- David

> 
> 
> > 
> > -- David
> >   
> > >
> > > Andrew
> > >  
> 


