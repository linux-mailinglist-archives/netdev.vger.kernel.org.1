Return-Path: <netdev+bounces-245003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2FCC4D9E
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 220373037B8E
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAAB252906;
	Tue, 16 Dec 2025 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6Nw8kYI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8A78F2B
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908800; cv=none; b=EcbBCYLJOpSs4zkK0YjCU61v3bvI8BL1xjGYFlgGpxK4S2Rvy/70zmysekoXsdz+GDsF91tsHcPgUh/+bpvMWJCawB9bl1T25pe2aB8JDBNAjeSEi138Q2pDyLJSFD7JDKd0AzQXtSkpQTm45R169P/p0CT+JBLKx+v8nEvzjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908800; c=relaxed/simple;
	bh=1WD2AgbR0CB6c6WH237tb/F1j4LqnO1t2NAbM5RtarM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwiiNhq4l1m/Q6oH+21Q/iZb/RLMMAlVMsDlMwLWqA6CbNKUKBh+upfU/a/+HajnK29JnVV+hdGoM7DtI5dwKoQDe+aO1IFlMe0NWgw9umM/pf+TmBWEwyNSewJ6K0ZsSJ4cK6exZ/p0nNd/h8lPZnkLu5Xyjp2jLOtr9GMO/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6Nw8kYI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b72e7205953so83008666b.0
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 10:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765908797; x=1766513597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmaB4ev8W3tz37Ek2hvrRn1VIAwgRQkGwDiR4TTSpX0=;
        b=T6Nw8kYII0Oq2szX1dA0yJMXiCZ34YMP+5BzFW3GbYCfxQNuvNnAhYdYi4He33B/Be
         NdGk1yQ6O2avS5EIwpYZlaZ5gpVp2Tt35g36/vz+F81UN3Yu12eIPmJdbJ7AUSmrq24a
         aLSQ25BXlwGeksHsUP7oOTyNlQe7fnOOUag013B27kfTlqYgDvs2kZwZ/4O8GpHsi+wH
         BAiS98KpnLwub1LBBQzrJNRfWfjI1mw2W2CIQvcupiaoMvPOGVnxj3jBXUUZmfe5lrBA
         kmWMTdzEwkGyMh5f+wffBGr7VnDTs9PG8J4IgighEbxkIdBXQrjbBcWDjmewO4iwZY9Y
         OLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765908797; x=1766513597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmaB4ev8W3tz37Ek2hvrRn1VIAwgRQkGwDiR4TTSpX0=;
        b=N/c7R2aM5Pcp6cRSkNXHCOsIQUXSUgnXeuljcoL2gThLovZNkFmi6IkEK8KkFD+ZRd
         5WE4RnzxBoLQ5u2CoT0XJ/4GgjOvEBhvIHELrl6myBpxApQKlJNnmUXLOxWyOz9qHKDp
         ICHiIa2fwrep62VHViGPKtenzqg2BZQBQ/NwKK02t5wFYXttqhjF6NW4ITraPZq679lJ
         bI//kA0ln2OvaH+7SUu611sBYIvFqADp04MvlzZGaXi0VTaXTBO/ydBgNSUVLZfM1f+j
         dIY0qUz7cq18syPPE+H+q0s5Ju0ixXEKX3i+vnxlBHm6uu+gFiGfiXheqgDmiB5TX8vn
         7kXA==
X-Forwarded-Encrypted: i=1; AJvYcCV61wftJdFB37MUNoMqVkGDtQK2YEuU5UfnmXZwreEgTWLHqzPwojiSO6MUvLOIPJ5TVLNUVjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNGNcgLzq2LDXlH8cGFon56YqqPnR92R3issaOeZHg1KjFBef
	kPVyKxuIhgGgAEkdTH8sy5/poEc9Rp5KVhG7oZHvv8St7GSWKl8W0739
X-Gm-Gg: AY/fxX6L8zWZ3nlkfiTq/kRQaDzs1m7gjqrIPo3JYi16mmAba69L2umyVLxYmzk/KAj
	hfH2otIRGKQrb2dhysUz3Oc+kKtlHnRxf3e6/1v/z3FwK4bH5xZOmuRcEvAQQmi5V9hP63vm5En
	rRbPAcqZ4j9yWqTAJHLkoVAvJVtnl1CHtCkSntHt6IcjkLTPjSL8oJBqSNbBzsieCqK4gH3bs1d
	QHjDnXzVv3aF4D2kYDLYX08u4qH8TirlzyOXN55qTffD6btSeP65zreJFRVeZ+7J5rtts5KP/7d
	j/c6Ya2I9kJiPmes4YhME3/KUIA14eKk5IOvNEZmPh0eyH5OiXfXcM+pX95U/y7ZRP8dmWqJMpl
	pdHPlPmENlNDOpEXZZol1bbtH/4B7woibtSnFZ7krUekq0XYGaenrJGp/a7PTQuQmCUGDMJNEHI
	ar
X-Google-Smtp-Source: AGHT+IGIeR9se1hUWC3ZK0/I8qc+joVCW+w9vOIo/2WkdYVDl6z0QWPwuG0teFhFkc3BBgr0VoSMnw==
X-Received: by 2002:a17:907:3da7:b0:b73:4445:85a8 with SMTP id a640c23a62f3a-b7d23a8caf0mr899586266b.8.1765908797155;
        Tue, 16 Dec 2025 10:13:17 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:c18:aa1:b847:17e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e70c2sm1716927466b.15.2025.12.16.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 10:13:16 -0800 (PST)
Date: Tue, 16 Dec 2025 20:13:13 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net v4 0/4] net: dsa: lantiq: a bunch of fixes
Message-ID: <20251216181313.tn4n5tj6zv6z6wr7@skbuf>
References: <cover.1765241054.git.daniel@makrotopia.org>
 <20251210161633.ncj2lheqpwltb436@skbuf>
 <aUGgBj8YZHQnaIsv@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUGgBj8YZHQnaIsv@makrotopia.org>

On Tue, Dec 16, 2025 at 06:08:06PM +0000, Daniel Golle wrote:
> On Wed, Dec 10, 2025 at 06:16:33PM +0200, Vladimir Oltean wrote:
> > On Tue, Dec 09, 2025 at 01:27:42AM +0000, Daniel Golle wrote:
> > > This series is the continuation and result of comments received for a fix
> > > for the SGMII restart-an bit not actually being self-clearing, which was
> > > reported by by Rasmus Villemoes.
> > > 
> > > A closer investigation and testing the .remove and the .shutdown paths
> > > of the mxl-gsw1xx.c and lantiq_gswip.c drivers has revealed a couple of
> > > existing problems, which are also addressed in this series.
> > > 
> > > Daniel Golle (4):
> > >   net: dsa: lantiq_gswip: fix order in .remove operation
> > >   net: dsa: mxl-gsw1xx: fix order in .remove operation
> > >   net: dsa: mxl-gsw1xx: fix .shutdown driver operation
> > >   net: dsa: mxl-gsw1xx: manually clear RANEG bit
> > > 
> > >  drivers/net/dsa/lantiq/lantiq_gswip.c        |  3 --
> > >  drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 --
> > >  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 19 +++++-----
> > >  drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 38 +++++++++++++++++---
> > >  4 files changed, 44 insertions(+), 18 deletions(-)
> > > 
> > > -- 
> > > 2.52.0
> > 
> > From a DSA API perspective this seems fine.
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > 
> 
> In case you are reluctant to accept patch 4/4 ("net: dsa: mxl-gsw1xx:
> manually clear RANEG bit") it'd be nice to have at least patch 1, 2 and
> 3 merged as-is, and I'll resend 4/4 as a single patch being a simple
> msleep(10) instead of the delayed_work approach, if that's the reason
> for the series not being accepted.

I think it has more to do with the fact that network maintainers are
taking a well deserved end of year break.
https://lore.kernel.org/netdev/15b104e5-7e8d-4a7c-a500-5632a4f3f9a8@redhat.com/

There are older patches than yours in patchwork.

