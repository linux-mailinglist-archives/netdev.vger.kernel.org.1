Return-Path: <netdev+bounces-94261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB04A8BEDF3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 22:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE9E1C249B4
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2518732D;
	Tue,  7 May 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiOgVkHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42C18732F
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715113114; cv=none; b=bXnoWqqE1GcfHhBPo55gqlub7MRe7BcJ1NqjecjMgxVyGapAymzXbxtiM8TvaZKuBIP82/VKse1BSbH7m9uhg6MO58EGxSBRWvHGmb4I73mrRcM1lNtx6tECsRs/8nY8i5XyC2EYLgEtFMeOAlSO9/qSGJOaV3At91uNJZlKXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715113114; c=relaxed/simple;
	bh=s10fq0i/1/vfb3NM85GYl4x8eCpYjhD60EaCqglXgZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giJxSoA7/EE/kYXiBoXKVAw2QUlGXF/Mzniyic7RF7qPcigjGCBfQWJOgPnxBzhkCoPsxhI8rHeaEw+ZHBH8NOezcZ6Ko3B2j9jYxbqsnd1JNHtUDMOLEYsn5NzLD48lY/5hi5CvkRR3Uy99CWHnYFcK1K22DBknOd8detEZDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiOgVkHG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34d8d11a523so1704582f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715113111; x=1715717911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B6So+DGiZgC2V2cZpOxR71KKi8ra9fJLwLed5Ku2Q2I=;
        b=fiOgVkHGnohSQllY17B0H1bNY0RYjLiGS1vqBU3KJRzAJTmijiA/507FpCVG74Dtio
         JfAWPI6jDRBd3f4jncVXojNCKfpIv1Qzb1FU5oBf7cFi1evGuU9IGVGK02KBqlgy+h+Q
         E9b7Oi446iZ4YdaaCV/v2gFcvUkXiHq2XHFzYF2bGBr7TYZNiwcXqLdpdhmvXofHlBxn
         58O0NSfzZktwS7bdTgZjEhtrrvMkYR/vri4K9RU26OnPjau9jFqnwxQdCqPd5fCj28dv
         aY9ViHbfGOuCTcVks0ME5XfMouyFkFnEpXYC+Y/MaYe2kCr32sHpgTHiZ/ohBBCafSet
         w3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715113111; x=1715717911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6So+DGiZgC2V2cZpOxR71KKi8ra9fJLwLed5Ku2Q2I=;
        b=mA5PXlEPZsnCLwYbkcpYlnwb+5js/EeYmL/5ZWaVeLH37qpBHRRWtyIjCYRqoHZdc3
         oC8N/Mfihcd3PuUIP/DahVaW5zlmNtpGWfnUck10VhVJ/aqGxw8HFwlODyY7jD2K7/22
         Qxlg6Os0D7bHxslAOmxZhhdFQpSnw10K5egYioN+PvUcR8BITFkUNVkYONML8KtLcMEY
         NXKsBNX7uo2F75qboqPdV5yO6zYE4nQyxRRA+cN59dA1AxOBgjdmgi5sacVQm9g466B6
         tDA5M/lR8gn7hVshrgiANt3cKuQ2o0jULDBaR65GtmHxCdzWmUDpCSYKDn6707m/n4bJ
         QygA==
X-Gm-Message-State: AOJu0Yz0Ukz4Nzp/40wEnY9ihgk4rPBzC6kVbmO55BfXwJ1AcmFaU96o
	IjKvKOjScKDvSadFwSAcEY8n2QmPB4xWh2//zr/1ZfES5JizXO4b
X-Google-Smtp-Source: AGHT+IGVZI2uzuK1YcUweWxNV1/FnYmOT7Tn00wt1SGP3yMIVlXHnUVAKBy75Poo2p/xlPgToEJWfw==
X-Received: by 2002:a05:600c:4f56:b0:41a:a5ff:ea3a with SMTP id 5b1f17b1804b1-41f714f6eb3mr6452915e9.19.1715113110989;
        Tue, 07 May 2024 13:18:30 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d505:8900::b2c])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b00419f572671dsm20647554wmo.20.2024.05.07.13.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 13:18:29 -0700 (PDT)
Date: Tue, 7 May 2024 23:18:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: dsa: update the unicast MAC address
 when changing conduit
Message-ID: <20240507201827.47suw4fwcjrbungy@skbuf>
References: <20240502122922.28139-1-kabel@kernel.org>
 <20240502122922.28139-1-kabel@kernel.org>
 <20240502122922.28139-3-kabel@kernel.org>
 <20240502122922.28139-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502122922.28139-3-kabel@kernel.org>
 <20240502122922.28139-3-kabel@kernel.org>

Hi Marek,

On Thu, May 02, 2024 at 02:29:22PM +0200, Marek Behún wrote:
> When changing DSA user interface conduit while the user interface is up,
> DSA exhibits different behavior in comparison to when the interface is
> down. This different behavior concers the primary unicast MAC address

nitpick: concerns

> stored in the port standalone FDB and in the conduit device UC database.
> 
> If we put a switch port down while changing the conduit with
>   ip link set sw0p0 down
>   ip link set sw0p0 type dsa conduit conduit1
>   ip link set sw0p0 up
> we delete the address in dsa_user_close() and install the (possibly
> different) address in dsa_user_open().
> 
> But when changing the conduit on the fly, the old address is not
> deleted and the new one is not installed.
> 
> Since we explicitly want to support live-changing the conduit, uninstall
> the old address before calling dsa_port_assign_conduit() and install the
> (possibly different) new address after the call.
> 
> Because conduit change might also trigger address change (the user
> interface is supposed to inherit the conudit interface MAC address if no

nitpick: conduit

> address is defined in hardware (dp->mac is a zero address)), move the
> eth_hw_addr_inherit() call from dsa_user_change_conduit() to
> dsa_port_change_conduit(), just before installing the new address.
> 
> Fixes: 95f510d0b792 ("net: dsa: allow the DSA master to be seen and changed through rtnetlink")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---

Sorry for the delay. I've tested this change and basically, while there
is clearly a bug, that bug produces no adverse effects / cannot be
reproduced with felix (the only mainline driver with the feature to
change conduits). So it could be sent to 'net-next' rather that 'net' on
that very ground, if there is no other separate reason for this to go to
stable kernels anyway, I guess.

There are 2 reasons why with felix the bug does not manifest itself.

First is because both the 'ocelot' and the alternate 'ocelot-8021q'
tagging protocols have the 'promisc_on_conduit = true' flag. So the
unicast address doesn't have to be in the conduit's RX filter - neither
the old or the new conduit.

Second, dsa_user_host_uc_install() theoretically leaves behind host FDB
entries installed towards the wrong (old) CPU port. But in felix_fdb_add(),
we treat any FDB entry requested towards any CPU port as if it was a
multicast FDB entry programmed towards _all_ CPU ports. For that reason,
it is installed towards the port mask of the PGID_CPU port group ID:

	if (dsa_port_is_cpu(dp))
		port = PGID_CPU;

It would be great if this clarification would be made in the commit
message, to give the right impression to backporters seeking a correct
bug impact assessment.

BTW, I'm curious how this is going to be handled with Marvell. Basically
if all switch Ethernet interfaces have the same MAC address X which
_isn't_ inherited from their respective conduit (so it is preserved when
changing conduit), and you have a split conduit configuration like this:
- half the user ports are under eth0
- half the user ports are under eth1

then you have a situation where MAC address X needs to be programmed as
a host FDB entry both towards the CPU port next to eth0, and towards
that next to eth1.

There isn't any specific "core awareness" in DSA about the way in which
host FDB entries towards multiple CPU ports are handled in the Felix case.
So the core ends up having a not very good idea of what's happening
behind the scenes, and basically requests a migration from the old CPU
port to the new one, when in reality none takes place. I'm wondering how
things are handled in your new code; maybe we need to adapt the core
logic if there is a second implementation that's similar to felix in
this regard. Basically I'm saying that dsa_user_host_uc_install() may
not need to call dsa_port_standalone_host_fdb_add() when changing
conduit, if we had dedicated DSA API for .host_fdb_add() rather than
.port_fdb_add(port == CPU port).

Anyway, I was able to coerce the code (with extra patches) into validating
that your patch works on a driver that hypothetically does things a bit
differently than felix. So, with the commit message reorganized:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

