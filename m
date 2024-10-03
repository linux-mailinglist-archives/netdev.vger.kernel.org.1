Return-Path: <netdev+bounces-131805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8288D98F9DC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD252865D8
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC331CC171;
	Thu,  3 Oct 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsYkzWlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB87824BD
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994509; cv=none; b=HOVhT4Kna2rXl7/NZgwzV6An+SzGUCXNp+jiAsYxLTpn4cvg2bfiL/2B1F4XNTs8IkxSgONyWjNiVb2oyutySG47tDweBYzr0ARnA9rGqxx2nFosZvpG4m2AvOR6rnGn2BY3Uac3AnWsDqP2Io8oy/BrWMdTfN0tCGW59VMAbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994509; c=relaxed/simple;
	bh=iWacaPHF7gVzqjZTXkzwNi8TfAtkVht7MihIQdn1wBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRg2xCebjbMwzg/GE/kw12McevAGt5FPSd4mpuFRns2YDuW7vAt7E2apwlHytktJqAhmKaFvJ4MRiJopQT5AfeaGHPc4EQJK14pYaD++5kxaZ4OIA1WSgjJp76ul3W+8k2DpKH5lZVMo9Iw7CYpXo7RiszGr3GyvHV0bxsR1AXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsYkzWlQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c87b2f1913so214607a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727994506; x=1728599306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JxN5320XIr1tiexxDkM1DtR2ZMgssjjtwZqxx7j44MY=;
        b=HsYkzWlQ+DQku+iSjSe00ywu5/SU3raHDXBs7Lpp95EbcWzEQZBY8VL4JCDDkw2TeO
         hEoFqjMIhIOgMZq8qOF/0+4hRchdH83owyCjNCGKXGA8UrIpUSg7q/MRI2M+tyzQcbHZ
         OhcMFPOzh03eaDGPfVER/tjk2wZVQBApu5xTIFbMMzf3euRb/xGH/THE1+zhIPI9vMeo
         5DeTfdM+w2mD6D1M289TSWjWazIRzmqeBOGvhpBnZTEyiKpDeOgplnGtS+7REoAuxsOs
         1VLNenf68L/e+4eF9Pk24NkmV+fDQ4ZayH15tlXavjK8f/lDrvo4vYu4MINwSH+SsLp0
         T4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994506; x=1728599306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxN5320XIr1tiexxDkM1DtR2ZMgssjjtwZqxx7j44MY=;
        b=sdPnOrlOYnVh6/eXG5XRk/yYYWzfmfi1FERJYlgOXPnOxmnaOsnChgQV90oWfCmWRb
         n5cbqceePkDAOAf4sv1yIjqNM3uZm9jCMConuQ7ANUZuBecOtegfdWteqQrrdDUkqrsc
         6Nk9cRmRkVGmpAy240xvjbZTk03bsZlhrrQdMp25T4lyNp07+6vXPzGnIRXmLVlZOIEW
         Tm4xXVMcKoOAZWahgjwXLGTdqEPJyJGADnDV687VtsBwW5VEt4A4E2t7Szg9eioxMYyg
         ef/CI8Pzs/gMJgjzDPk/W/pew/x+zQi+CgRVCmbJve+/QoCO+Y8rXDJIa1EH0EDghuCG
         V/4g==
X-Forwarded-Encrypted: i=1; AJvYcCUHcM3+E3jZLwbFRhRr2LsfWKJaI25ybj62eRoeV+o1a2j4WUfzXi667yOwrJzJ8t5KEBbfYt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEbHKeO9VBIT2oXJvqL7tVt9FiBRRKCy/W8VWFWmrUgaxXlOsW
	IHTgbOiY9wQPMgekTrvOowdHEzU6PpoBheU/vq84aO7noOVRZvVe
X-Google-Smtp-Source: AGHT+IH0cH2kyMKawuwBVHKDDGmzrBU7oY2OhZJwnQGddYwYE1XGN+cFB+SpZjKr1aR2itmNhbV+ZQ==
X-Received: by 2002:a17:907:86a8:b0:a91:158d:363 with SMTP id a640c23a62f3a-a991bd8506fmr33013466b.7.1727994505798;
        Thu, 03 Oct 2024 15:28:25 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104731a5sm136562066b.180.2024.10.03.15.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:28:24 -0700 (PDT)
Date: Fri, 4 Oct 2024 01:28:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: remove obsolete phylink dsa_switch
 operations
Message-ID: <20241003222821.2jngvjyaqbp4ibub@skbuf>
References: <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
 <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
 <20241003145103.i23tx4mpjtg4e6df@skbuf>
 <Zv64OWFyXY5B0B-l@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv64OWFyXY5B0B-l@shell.armlinux.org.uk>

On Thu, Oct 03, 2024 at 04:28:57PM +0100, Russell King (Oracle) wrote:
> Yes, that's correct, but let's keep it to this for the moment.
> 
> There's more to do with mac_select_pcs(). When it was introdued, we
> needed a way to distinguish whether the method was actually implemented
> or whether the old phylink_set_pcs() function was being used. Those days
> are long gone, so returning ERR_PTR(-EOPNOTSUPP) no longer makes much
> sense.
> 
> DSA's core code returns this, as does mv88e6xxx when the chip doesn't
> have any pcs_ops (I'm not sure now why I did the latter now.)
> 
> So, I'd like to (a) make mv88e6xxx_mac_select_pcs() return NULL, then
> kill dsa_port_phylink_mac_select_pcs() and then eliminate:
> 
>         if (mac_ops->mac_select_pcs &&
>             mac_ops->mac_select_pcs(config, PHY_INTERFACE_MODE_NA) !=
>               ERR_PTR(-EOPNOTSUPP))
>                 using_mac_select_pcs = true;
> 
> replacing all other cases of pl->using_mac_select_pcs with a test
> for pl->mac_ops->mac_select_pcs being non-NULL.
> 
> However, that's for later - I think for this patch, it makes sense
> to keep returning the ERR_PTR() value because that's what it was
> doing prior to this patch - we're then only removing the members
> on the dsa_switch_ops and their callsite in this patch.

I was about to write the same thing earlier, except I stopped when I realized
I also had no idea why mv88e6xxx_mac_select_pcs() returns ERR_PTR(-EOPNOTSUPP).

The removal of using_mac_select_pcs is "further work", and deleting
dsa_port_phylink_mac_select_pcs() altogether, although it can also be
done now, can be grouped with that.

