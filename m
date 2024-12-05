Return-Path: <netdev+bounces-149508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D49E5EA8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F180169879
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA1225788;
	Thu,  5 Dec 2024 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC1yKYF0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358BE18FDAA;
	Thu,  5 Dec 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426181; cv=none; b=Rij2HNWLKGjs4m9btd5ZGG7FpioAD+RVkgWri2Rd30eiNpppkSvHoY2HsgZh/LSxYmnJdqVoM8CKdaCuWt0ryPajU6ehr39FxRLOqrUXgOBSUYWWXrHkh/3BkxAGb9n0D0gDyRngj9xr2rsMXemiKP49JFktLq8uQMh9Se7kQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426181; c=relaxed/simple;
	bh=SmBhLmmKb3/JpxnOaGqkc1Z6xWAgvghhCqLwDySUaxY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neFkCl3qLf2CIg0GKzq/SCAeYlVtLy+CA94wTVSlifcMtzI7giW+PVLuDitrT2/ECtEps1Ad3d4P2uq802k5dfvAHK9hY2K5PPEscW9BiRf4jjhnKY+8Wvn959+qmYa3gcJ5G0yAVa32W1wfj9ZHCN2PQHO/uUhny9qC0bBY9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC1yKYF0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a95095efso14928315e9.0;
        Thu, 05 Dec 2024 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733426178; x=1734030978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MY4w8h/Y2faTte8A8zuwQmkux3tQ9Zf0xj0qV+I4U4Q=;
        b=AC1yKYF0pe7oQBTQ7Fi4QAASYqmW+wz1aHSdNl3V1e5ALCA726vZnYXvTR/vkynhza
         rUOt6UVfcIC6ZGrsXpGnVPudEgyZOU3IwE5C8s4cEbQkTcRf0xRSwodfXwNAinuDQ7UO
         x+e1INni3oDVTlQSV5w3XXnnaf3Dk8M4wU3nNoHt5F7R2C+dftoonODlHtxo95KEdRIy
         iPeY7LtolkP4zIkn0KQS8GoWSb2+wpFdWkMkJ/3ueQFg/fuyVY2G3IRrLpJWY6cWyTH5
         OzpUyMKkZWZCzrfEK/YWU5lzfR7tON3fdL1d7kAgr9M+Ij2PfN+XmksKSmIMRhi2xtXq
         /zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426178; x=1734030978;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY4w8h/Y2faTte8A8zuwQmkux3tQ9Zf0xj0qV+I4U4Q=;
        b=plC+R8EWjQtgOvKzLhQxazEaclAWyyl5EK5uFuX48inw3Q1zZ3YGTjsnzC6AKzNjYN
         O2bUsWYiDz1CeLw3XW25xXNgWkKM0H884Yrk98Hzv5/NTt5Ij7mUgWhjGa1oGAakGx1U
         Mbyd/D2Ue2/JU0CWMrVHh15maZcap2qCYsBhm/IRcfjnq4eicZ0FpZJ/+L2agmqfvVr/
         OCjnMSLpINIz8QFE76YMdYhTozRZrw/txifU86+VfXLX7QBZ9QESa/j24UHuNY+OQELj
         YMdvP0EJamS9VQR+U2GIuemWy85X7Y7DGE8J9dMVxp8qXeErLdYYVXTz5nGrqgxJVCyu
         +obg==
X-Forwarded-Encrypted: i=1; AJvYcCUNy5rwCWCR7m9g04D8dqVtVH/kbFpxLRxP6f3s+9ZoP9CxLVC4U/6AERuLMyKUeWvTyFuc5fKKjhJl@vger.kernel.org, AJvYcCUrx8NLATuBhCe5SsuzN9TFOxtrQ0OR5tfcfwTpvjbPhgZRU9iimjXO84tiwJBpeLGWfl9IQp63@vger.kernel.org, AJvYcCV45KJxPOwHPd4+1Fi+5mOWVyoS0UBolApU6c4U6PeCf9629uc/1JObhRDhyubpj4DZ7HxV9uwbWKMWqXcu@vger.kernel.org
X-Gm-Message-State: AOJu0YwU10Mx4QH6vmFTDNHof15ybmQL1ctcumt2yJJvxU1xSxi/kWeK
	PS+TUEuMUW52Mjnn7PJADOqD4u9N2ltfYQsiFsgy757psXEQdSYL
X-Gm-Gg: ASbGncv4c2gZ0Nj7sw+615jQLAGVVZBKlhLF+f3dSWJFf4nid2pnqWB0wSvrxYK9ZVE
	FBNfJJhVZcoFSXNuBF0sfJTqrFMwC0mk0x4QbyHQimqUtA9h+eyM+i3vT9k4RGQQgFkjI3uo54i
	jcdqZvQdnYyrMVchyRX1yHiTNkdxWj2iXNmDQhuTEQ75lMJBZKac4HbSMkUGcgaXfYrEZTIijKb
	03XDloyi+lxkokNFNdojVvIIWIbjTXpqkzre7dTBsStqpcWDAJ9sb4+2cojlfYdylCAO6znM6zB
	wtuAuA==
X-Google-Smtp-Source: AGHT+IHZRbJn+9HtrGJ38A8jyPTzo+TDn7EX7QFEByqYqphbe67U5+K0SKR8aakCPuxnrCyTXLoJ7g==
X-Received: by 2002:a5d:6c66:0:b0:385:e45b:92a2 with SMTP id ffacd0b85a97d-3861bb5c4eamr3657331f8f.7.1733426178337;
        Thu, 05 Dec 2024 11:16:18 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280120sm68799815e9.20.2024.12.05.11.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 11:16:17 -0800 (PST)
Message-ID: <6751fc01.7b0a0220.1f425b.5416@mx.google.com>
X-Google-Original-Message-ID: <Z1H7_Z7UsSZ5GEhY@Ansuel-XPS.>
Date: Thu, 5 Dec 2024 20:16:13 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v9 3/4] net: dsa: Add Airoha AN8855 5-Port
 Gigabit DSA Switch driver
References: <20241205145142.29278-1-ansuelsmth@gmail.com>
 <20241205145142.29278-4-ansuelsmth@gmail.com>
 <20241205170629.ww7qcvgbqdf5ipcj@skbuf>
 <6751e22d.050a0220.3435c6.57de@mx.google.com>
 <20241205183403.zla5syfzj3yrinwj@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205183403.zla5syfzj3yrinwj@skbuf>

On Thu, Dec 05, 2024 at 08:34:03PM +0200, Vladimir Oltean wrote:
> On Thu, Dec 05, 2024 at 06:26:01PM +0100, Christian Marangi wrote:
> > Concept looks handy, ideally I can just assign one ID for each port
> > like:
> > port 1 -> FIB 1
> > port 2 -> FIB 1
> > port 3 -> FIB 2
> > 
> > Question:
> > Ports of the same bridge should have the same FIB?
> 
> The answer, as well as many other explanations, is under the "Address
> databases" section of Documentation/networking/dsa/dsa.rst. Please read
> it through before starting to implement anything.
>

Ok sorry, will read.

> > What I need to check is how the switch handle this for learning. Does
> > the switch correctly create FDB entry with the right FIB?
> 
> You're asking me how an8855 behaves? I have no idea, I never interacted
> with it :-|
> 

Noo it wasn't a question for you, it was really to describe a problem
that might be present if the switch doesn't account for that and that I
need to check.

> The idea as far as the DSA API is concerned would be to learn addresses
> in the bridge database (DSA_DB_BRIDGE) that the user port is configured
> for, and not learn any addresses in the port-private database (DSA_DB_PORT).
> 
> > If that's not the case then I think assisted_learning is needed and HW
> > Learn can't be used?
> 
> ds->assisted_learning_on_cpu_port applies, as suggested by its name,
> only on the CPU port. On user ports, address learning should work normally.
> 
> As you will find in the documentation, the CPU port is not like a user
> port, in the sense that it is not configured to service a single address
> database, but all of them. So, source learning on the CPU port will not
> work unless the switch knows which address database should each packet
> be associated with.

Ok so in such case, learning on CPU needs to be disabled and assisted
learning enabled.

> 
> In principle, one way could be to pass, during tagger xmit, the database ID,
> so that the switch knows that it must learn the MAC SA of this packet in
> this FID. I don't have the full image of the Mediatek DSA tag format,
> but if an8855 is anything like mt7530, this option isn't available.
> Thus, like mt7530, it needs to set ds->assisted_learning_on_cpu_port, so
> that software will call port_fdb_add() on the CPU port with the correct
> dsa_db (for the right bridge) as argument. But I don't think that is
> going to pose any sort of issue.
> 

In theory I might have found just this option. Tagger documentation is
totally missing but there are some c and header API that define some
interesting option of the tagger.

It seems the tagger can work in 3 way:
- portmap (what we currently use)
- portid 
- lookup result

Now the last 2 mode seems very interesting.
The naming is very confusing but maybe with portid they refer to the
FIB. I need to check this. If that's the case then it's exactly what we
need. They set an int so it's definetly an ID.

I assume lookup result is to only use FDB to decide where the packet
should go. In this mode no ID or port are defined.

So in short lots of tests to do, maybe this can be handled in the
tagger.

> > (I still need to check if I can assign a default FIB for a port...
> > Currently the STP register are 2 bit for each FIB id, so 16 different
> > FIB are possible)
> > 
> > Also do we have a script for selft tests? I remember there was one back
> > in the days for fdb isolation?
> 
> I don't remember right now, I don't think we do. I'll try to come up
> with something in the following days.

Yes that would be handy.

-- 
	Ansuel

