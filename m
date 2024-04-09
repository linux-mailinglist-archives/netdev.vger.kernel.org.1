Return-Path: <netdev+bounces-86202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847089DF4B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 17:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53C92811F2
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512E1135405;
	Tue,  9 Apr 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9dRsehm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727D132810
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 15:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676833; cv=none; b=soykiKj9w5E1xa5DplRULdCPgaQVI/zqUlGXv526jsqJ8ryS4BbkI95ZEXO6UuBWAm5M/DVKWn6JBNQQXuC8AIZOzUGhJJKkDQvxk1woxhXD6Q1pGDCbL1ueLsF8vKH9HX343RNLvdNlQg0yBZoxfgWDDbPucuS2zTvuZjplE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676833; c=relaxed/simple;
	bh=JAmJgbEWmN/3SSEDhOCLiSP26k/LRzQLiBVwQ/wbhWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOOrB+jFQBNsSKTZWs1fOLvlTXyauP0f1jPVWHjgm0d6sFHaW2+uC3uJaB7DYSi7xMqt4ojAK5eB0EThEGzOPuDWwlJEDHSyX1Rc+PK+K8KpM7i5Rc5mfGoZVlPFHyhE4byLQGXpxs+JHbyMBV0HV8oJgFHYJInLdHcLu/7G5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9dRsehm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343d1003106so3471230f8f.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712676830; x=1713281630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hM6v7Iqf/0E7JcGvvIITpVGycfBnDT0Q61jcWbQCJUM=;
        b=R9dRsehmgOqiqPMywgRuZ0rf8ZdSKFK/29BVaJ54jqeo7NbHKpvkDtNUuw9JdAS2MV
         foJ79LhCyg0HXMzJa9mv71UHvJy/tyiXuwdNMH6QNfk1ucU6MZn7S2zLSLxOdyO5U8GU
         8wjb220PfcknJFfLapp8m1d+T5aZLxWqvbskfTJabY/ql2ZXkKvSlbil0q4B4wz1jbjL
         Pc8+/9bbuOWISZ1KALEmjpJ7SmKwH1cJMimUo35C4h/WdgKiJJzQaTZkm9Rj4vpcHkJK
         p0FudKtT1nhwK3u202mDucHV7SwG9/pr8G3bLLeH19ZqrkQL7Hnjz7ocVDp8hWiU+NQ/
         tG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676830; x=1713281630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM6v7Iqf/0E7JcGvvIITpVGycfBnDT0Q61jcWbQCJUM=;
        b=nayuldQgYGLqF67CmRspFoiHtacnzSvzJMa2Fg16uZU9yHMocFf1irGlqTWZGBKor0
         r/IBXli0lZk35/KHUmjHoPW8cUqKXGAsIo/gry3rQXSLVgMnqW8RVSCMflnU+XGwK/7Z
         69/RRGzMOVT0596OO7QsIMpLAT9r/s5MrrWXn3IeQ4BMpNzXQ+OawYO4d0xjLsh3OYCu
         bv7jyHhJXDbFLByuurFa3orjZtEjvPLyAGg6P3b0bpqI3kAn0ry2hYvlubSkp0xotMHk
         aFeIrDK0kFfqXJMbM6P7KU/5JmBWbTq7U5zmOcIwqKR30EKk9+Vy4SKkBWUwuQJD840k
         ieaA==
X-Forwarded-Encrypted: i=1; AJvYcCU+hA/Cja9j4yFlmrQFOI52ivYyqtV0kMM756mRMBCeXro5ijwGSWpHi4/YeGUH5uFNda41+ZUnYEwJYKquwgxUyBf5BNk7
X-Gm-Message-State: AOJu0YzOZpka0+xV8mhRdOsj+rGWhAyYghmu7Pa2xczMIGtYs/gD20GW
	l9BxSuA6I/YK0JI6eKmame6e+XDpM6CfaybIsMiVXfQifwAekL+t
X-Google-Smtp-Source: AGHT+IE90xDSge24bgnqEwWBlnZSe+8wtwbJdLcVBNzlFueY0nK/KCkD5bJq327KP72EV7cAWZU8TA==
X-Received: by 2002:adf:f084:0:b0:343:95b6:8a9 with SMTP id n4-20020adff084000000b0034395b608a9mr37513wro.60.1712676829662;
        Tue, 09 Apr 2024 08:33:49 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d201:1f00::b2c])
        by smtp.gmail.com with ESMTPSA id d4-20020adfa344000000b003462374f350sm1852212wrb.26.2024.04.09.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:33:49 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:33:46 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: dsa: allow DSA switch drivers to
 provide their own phylink mac ops
Message-ID: <20240409153346.atvof7b6ziaf2xr5@skbuf>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
 <E1rtn25-0065p0-2C@rmk-PC.armlinux.org.uk>
 <20240409123731.t3stvkcnjnr6mswb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409123731.t3stvkcnjnr6mswb@skbuf>

On Tue, Apr 09, 2024 at 03:37:31PM +0300, Vladimir Oltean wrote:
> On Mon, Apr 08, 2024 at 12:19:25PM +0100, Russell King (Oracle) wrote:
> > +static void dsa_shared_port_link_down(struct dsa_port *dp)
> > +{
> > +	struct dsa_switch *ds = dp->ds;
> > +
> > +	if (ds->phylink_mac_ops) {
> > +		if (ds->phylink_mac_ops->mac_link_down)
> > +			ds->phylink_mac_ops->mac_link_down(&dp->pl_config,
> > +							   MLO_AN_FIXED,
> > +							   PHY_INTERFACE_MODE_NA);
> > +	} else {
> > +		if (ds->ops->phylink_mac_link_down)
> > +			ds->ops->phylink_mac_link_down(ds, dp->index,
> > +				MLO_AN_FIXED, PHY_INTERFACE_MODE_NA);
> > +	}
> > +}
> 
> Please roll this other change into the patch when respinning:
> 
> else {
> 	if { }
> }
> 
> becomes
> 
> else if {}
> 
> Also please align the arguments of the phylink_mac_link_down() call with
> the open parenthesis.

Something like this:

static void dsa_shared_port_link_down(struct dsa_port *dp)
{
	struct dsa_switch *ds = dp->ds;

	if (ds->phylink_mac_ops && ds->phylink_mac_ops->mac_link_down) {
		ds->phylink_mac_ops->mac_link_down(&dp->pl_config, MLO_AN_FIXED,
						   PHY_INTERFACE_MODE_NA);
	} else if (ds->ops->phylink_mac_link_down) {
		ds->ops->phylink_mac_link_down(ds, dp->index, MLO_AN_FIXED,
					       PHY_INTERFACE_MODE_NA);
	}
}

