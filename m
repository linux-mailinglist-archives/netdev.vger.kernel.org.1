Return-Path: <netdev+bounces-153115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35FB9F6CFC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAADA16EB6A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9D11F2395;
	Wed, 18 Dec 2024 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="iwYfB+cY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24B685C5E
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545832; cv=none; b=COw1UIqpDBJSCsH3KT2xKotqRQDUb3Py88Gr4qu4f3aZkdiZCNUsn8u2jjFKz1SvSiiy8X2yuXviFNCA/JzXgr6Al6RfBijB9IevntnEiLXRJC7+tso7rxdDVmvjJT8uSI4FUh5hYqRb93IRQyo9hiIWCv/bDKKN0ITtAFmB7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545832; c=relaxed/simple;
	bh=yHxsSZ6q+A1NadJIUiWHeFIdq178jwCIQGcOT716NvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCRIKdp7B0UHy9yjy58twonTntjZkidaXbgOZYTRVwqkPG6GDVjYuKRF+zPYfLq4t58h+qAdbojLl0qmHSF1N3qRchRTIBAeS9UEY9GKJNQ+c+WkdNMmvO01zU+OniUMILBLP9ygTeHnihe1s5pQPQG9yVpFkB/+6dXEADUzt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=iwYfB+cY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21669fd5c7cso60710495ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734545830; x=1735150630; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iakiKmf+7Q9VIzTYqjBYKfCKiGPHad6qNBcUzxHUOE8=;
        b=iwYfB+cYyCnr/M/OL9COGRxRup77jViNxtJXx+S8LLPy7LpCcVQP7Zt75PGi+WCxlZ
         PTDUIm5PC2HnRtDNGL4Mjuwu824MwYEUWzBDZcpxNcb8y6e07hCGqjApeFKt6KnYAvd5
         oxsp1IP+dsTREMZgKnc2vto7VIt5gVnehoG6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734545830; x=1735150630;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iakiKmf+7Q9VIzTYqjBYKfCKiGPHad6qNBcUzxHUOE8=;
        b=LvAy9L2fB1rDnaFrcO4CSP4E/Hd2JinyhAwT9Zn68zPF9ZRFZ1SBjyBg52Jw8JAmiH
         Zn6d4T5TjpS1kwY8FE1LUoCaTf4G0yW3m4yHdIvMjxYTaZ2LNjGJBticl6A/GKnii5NG
         w84d7iQhBT8guaC27un1BQjICJmBKbUnaxEE3k+r6nwgEWgUbjF7zAYmgwHsmVmUVGF2
         mxv/4QTWCaBeb2Y6jOIw5GEe9WX+8N6OvSBxGS8dRz6mfTFVhlhRcPSZu5v5iSPsTnnY
         mVvwajYaqPadEKgPkaMGgHkuhWfWuyi5SLBEGRkF6fNj7ZRNXaCaK8qjgWN0qldkaGrW
         mTyw==
X-Forwarded-Encrypted: i=1; AJvYcCW0KOXChRM5otc0+lqMJkw0+AxBc4Ry2OzjL5BrxqaVQV4C7jsmrhprGwH+imUf/nyynpnuM3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDd5bxCAV18Hvb3IkWOuoA7UluPWAB3yGQZ/AOsj0TZDrh8pF0
	2/Zzaape/5vP2RTGTiU41oH7TIGDlppQHH5xFXzF1zM0TwqQ1agBuqDhtV0BhSM=
X-Gm-Gg: ASbGncuOJyoXekq0Zu+XeLdJu/HIE2b+BWVflRAAEVHdFOM3mMmI/anoJm6E857Tm4M
	qXH3j3tHUa1Sbk8UTNQ9HijI67qUvdh626klBO/oPxrUYB433WUT2XbSkVzbsv+/x1BrQuzusLB
	mwIRsU3/Cr5J3ysoI2b7i2RlocAWxWIXX5YBE5HZGlAVB2hlM9512mjYxDgLFVJRNT/4NR7Rlpg
	L7BO/aMXBOitNt4U/Friw/gsm1hzR6N5vqWkWOP50np4kbi1yGaBe3FENiG3a38lqFMZ56I7m3S
	c4u2TS/JKQDMKTlQtGy5eEnnOYcO
X-Google-Smtp-Source: AGHT+IHPHiEexDezHlXuFrMCscCAQo6iMjo5+F3paQ1J/viXj6USzR955e+hTVg8p684L2olz/s68Q==
X-Received: by 2002:a17:902:da8b:b0:216:3c2b:a5d0 with SMTP id d9443c01a7336-218d7274085mr50745305ad.51.1734545829939;
        Wed, 18 Dec 2024 10:17:09 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db8793sm79231795ad.50.2024.12.18.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:17:09 -0800 (PST)
Date: Wed, 18 Dec 2024 10:17:06 -0800
From: Joe Damato <jdamato@fastly.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: admiyo@os.amperecomputing.com, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v9 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <Z2MRouOBizgKt-h_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Adam Young <admiyo@amperemail.onmicrosoft.com>,
	admiyo@os.amperecomputing.com,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
References: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
 <20241217182528.108062-2-admiyo@os.amperecomputing.com>
 <Z2HLJD8z3wFNvnlV@LQ3V64L9R2>
 <7bfb8a48-8a14-47cb-bd69-1d864535aeba@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bfb8a48-8a14-47cb-bd69-1d864535aeba@amperemail.onmicrosoft.com>

On Wed, Dec 18, 2024 at 11:23:06AM -0500, Adam Young wrote:
> 
> On 12/17/24 14:04, Joe Damato wrote:

[...]

> > 
> > > +		u64_stats_update_end(&dstats->syncp);
> > > +		return;
> > > +	}
> > > +	if (!skb) {
> > > +		u64_stats_inc(&dstats->rx_drops);
> > > +		u64_stats_update_end(&dstats->syncp);
> > > +		return;
> > > +	}
> > > +	u64_stats_inc(&dstats->rx_packets);
> > > +	u64_stats_add(&dstats->rx_bytes, data_len);
> > > +	u64_stats_update_end(&dstats->syncp);
> > I suspect what Jeremy meant (but please feel free to correct me if
> > I'm mistaken, Jeremy) was that you may want to use the helpers in:
> > 
> > include/linux/netdevice.h
> > 
> > e.g.
> > 
> >    dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
> >    dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);
> > 
> > etc.
> 
> I don't see those function calls in the 6.13-rc3 tree I am working with. 
> Are they coming later?

If you are adding new code you should target net-next/main, which
has commit 18eabadd73ae ("vrf: Make pcpu_dstats update functions
available to other modules.") which adds those functions.

Have you rebased recently? Maybe your local clone of the tree is
stale?

FWIW: you can use `git format-patch --base=auto ...` to include base
tree information which can be helpful for identifying issues like
the above.

