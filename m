Return-Path: <netdev+bounces-160163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179F5A189B2
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 02:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31D31888FF9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960618035;
	Wed, 22 Jan 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2RuaXNb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F60196
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737510638; cv=none; b=KqRB3VCfUbw6WxNhAsrMKjE8fsQszJP8mIPdxG7S9MNhPPLYVARRRzIQeINpiuyna4JBQOxtXWg7ZPoujMO4NZ+EngSxt5rknQ+TdBB1WP9HQqN6ZtSS9S+6ZFePCer3ev50NS3oKaxzL07pNZV2XSpIISXdpCbW2ouXyFG+gVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737510638; c=relaxed/simple;
	bh=BEP1/jKes9JLLTm3VgKYQMISWtEO0G6d4iZj41eLkoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGiejt++sVXmP4xsU5BE+muv1Du9NEgZ7SfaIoZNA7Ru4jxvr6LFdKCwPxekuTqHc5iFqGT6mmqg/OIb9VVSkFwkOpGBFzA49sJuovo5N33pc49dtJAJJpsv/2D5W7jzJdN9F8Wbo6eQvB+WNc+5V/fVlVpn8KoLEuDMk5VwhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2RuaXNb; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so8352788a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 17:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737510636; x=1738115436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4e/Kv50DV8qQ3c5/TTTTMCP0K5tNALSlFezOE3pN3Ec=;
        b=Q2RuaXNbrwcOrJ8cqSt+KxvwyqXjLE+iYiBBtSjDLk/nn302+9VeIIwZ8+Y2mwOxvg
         gsRMOHtCYIgqHoCGBoFWfXPuJzvFnbggABjE7F1HwHag9omJnVQeYwCbdHEz1J1p3bZs
         QznM47/tl4DCRJXC+aOQnpqSmvGEON+MtOSSWr++X3yQD3i2j3JASrpSPjI8El33+98N
         2iRdqsVHTc6E1vt3wz3Iu6/0B0/T63yeknRJFCCXBmqR74LIDjGVM6VsTp54mBv/o9AR
         mHZ1lSCVTcjShGeFk+G+0fTzHVAr1cvkV9Cvu7v29mnnHeFmK7DPmQarWXwnqv6UwBAR
         dICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737510636; x=1738115436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e/Kv50DV8qQ3c5/TTTTMCP0K5tNALSlFezOE3pN3Ec=;
        b=RtE5Auq3xQfajV3jb9yPmpoJaJqFyI9uhCsmLZexe/XZ8JdVKRhlgDu9Cw35klHTOO
         kTafc9ekC/df01LzmwzZ8OIGcbSsdl0+tiFQkC9NmY5gEf28Xf2Qv7mo3l6nlzCvOfHM
         r+4PDVC67fDO36kPIWP2svRcVcMoL60vwHZZTJp6Ecwy70Xb1fyOmFQ0QXe0LNUaQHy1
         6HA4ek+g7VonAXJpZjAdnlEIc1V9EsChel8VeOQXGW9r6v0dMtmXiOQ/w7O4qF/gG9Zj
         JBfwFLdZ+eumhRGCllvY8o4oUmCCwHnsKW3AcudHOLAkjUv/txjV9Wyd1iJ+hI3ZFb7L
         Hf5Q==
X-Gm-Message-State: AOJu0Yz915LiHUPGY6YokjG1DIS3102va9jw4ZNmsGzOfy93LJXAJF9K
	RqbPM/Q2dkV7eSB3/7MzFGkw4b9JQNDgiO4NM8wA1LXBV02jUUJ5
X-Gm-Gg: ASbGncukw1t6B04snJ+PBesFAlECNdqW8YksxGhcm76RE8UqHbchXk1EuZfMoVLTpWd
	Okg6AmR42KT012FhGDdQuGEXbjQ7t7Kub4krexIcnMDR0+BeQ7vytbBZdJqiwdNcLNcd+kB0yRJ
	4Mawn2eqINJdkZW8HUC/wlPTgPs8TRHroD3CCy29gWo8K43noG8JlXXCxdc79VbbFctB43Uwh+J
	UdrftF8BnXWyoYkF6oBE4jT5/1BeCaQIWJKpUe5qniEEUSp25LPwpOV/9xV9jTIk03Dn1HA6bU=
X-Google-Smtp-Source: AGHT+IE2x1aRD8oIuEIzQXo/AWwuWGPnb6rsrXJBm4nTSU07mYMzOVlnFsPM/CEelGTcSkvNb1VdXw==
X-Received: by 2002:a17:90b:5146:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2f782c6579dmr25064572a91.6.1737510636138;
        Tue, 21 Jan 2025 17:50:36 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6ac353fsm211736a91.37.2025.01.21.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 17:50:35 -0800 (PST)
Date: Wed, 22 Jan 2025 01:50:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Liang Li <liali@redhat.com>
Subject: Re: [Question] Bonding: change bond dev_addr when fail_over_mac=2
Message-ID: <Z5BO57CBUEL6gRUX@fedora>
References: <Z49yXz1dx2ZzqhC1@fedora>
 <3990673.1737505950@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3990673.1737505950@famine>

On Tue, Jan 21, 2025 at 04:32:30PM -0800, Jay Vosburgh wrote:
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> >I saw in __bond_release_one() we have 
> >
> >        if (!all && (!bond->params.fail_over_mac ||
> >                     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
> >                if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
> >                    bond_has_slaves(bond))
> >                        slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM - is still in use by bond - set the HWaddr of slave to a different address to avoid conflicts\n",
> >                                   slave->perm_hwaddr);
> >        }
> 
> 	If I'm reading it right, I don't think the above will trigger
> the message for your example, as "!bond->params.fail_over_mac" and
> "BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP" are both false.

Ah, yes. I need to read carefully.

> 
> >So why not just change the bond_dev->dev_addr to another slave's perm_hwaddr
> >instead of keep using the released one?
> 
> 	That would cause the MAC of the bond itself to change without
> user intervention, and the active-backup mode won't change the bond's
> MAC except for the case of fail_over_mac=1.  It's not uncommon for the
> network to have dependencies on the MAC address itself, e.g., MAC based
> permission rules.  There's also an cost associated with changing the
> MAC, requiring a gratuitous ARP and some propagation time.
> 
> 	What you describe is also the behavior for active-backup with
> fail_over_mac=0, in that the bond will keep using the MAC gleaned from
> the first interface even if that interface is removed from the bond, so
> it's not really something specific to fail_over_mac=2.

Thanks for your explanation.
> 
> 	I don't think bonding should automatically adopt a new MAC
> address in this case, but loosening the logic on the warning message
> would be ok.

OK, I will try add a warning for this issue.

Thanks
Hangbin

