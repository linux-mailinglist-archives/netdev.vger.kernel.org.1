Return-Path: <netdev+bounces-184167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC5A938AA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2C7B124A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CBD1A3159;
	Fri, 18 Apr 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYflkgTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BF19ADA4;
	Fri, 18 Apr 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986605; cv=none; b=eFy4+FyZV1Je7gxE8sIpjR3JtbBKs0YZjsJM4kQFyS9UR0znfKaKqqSJSR8LRHTzS42RvFyC811VAMFy0eEb+8BN9peU1gQe0xjK3nuhOgwDktrS3QJzXf8758H2ECu/jiUQ0ApnHsWXRg/aMKs9AjyyMEYOCfuT4NPlX0pYBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986605; c=relaxed/simple;
	bh=wUzmH4xqUNFx6Lqx2Itt/tpaeGYM05BZoZ1guKnRXn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKm70yev4s8pBrMd80zeEzGlrEpUY5wy2wph177IH71Vqi0LaAWz//k8k+AkJxaOkzYJS4fQGKFPlCgjWNq9w4YlVkumMYAFW5OtcdoYovv4/h0DAV48Fa3cvzblzH36u114JiVdKNmOngTncRsK80GIqpzF6lUGpYpLit7pclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYflkgTx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5f37f45e819so317816a12.3;
        Fri, 18 Apr 2025 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744986602; x=1745591402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jEb+3qqZQ6y0qknhmyqZMe7sYP4AQ+xYtScn/gz9NwM=;
        b=hYflkgTx6BEiK0mbALMwmYMJvprDRft4ylwPl6KN++Pq0ZG9lMv/z23w6bPVW5l9WK
         KNhcxWWAHUeZrNALRzJZc8vt8LH257AMg9nhN9wCLeUgRtL3QaSKgQwqATYW/775Rleg
         AHHtsKJwiRNpHmbVEruly2LQEJ9206cCCcSfj4avsr8Gw5uwZnj/agmHdBhFrgHfgDSI
         +6wViNH5u7+jIo4NLuJKleXQxNQZD9EoJuPIfsELNVlUfGVQ0WqE/L6AlefYu9Fl2toN
         8fVvgeFPZjbKA7vuHhpXCbKlFQnFANKgxpRo6sy1MI9ph0AkwfXG9F6THlwA70zj8Q54
         ccLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744986602; x=1745591402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEb+3qqZQ6y0qknhmyqZMe7sYP4AQ+xYtScn/gz9NwM=;
        b=Z+vIO/5LWae8jjL6h1OdR4OrJG0hxZQ4u0opLwlj0S6eSPKnGORP78iu688s/S8r1x
         XRaZLEbwFyLU1l9rL0qJnhA7ozgjXXdnPOqA4C4ZYV1978aAFRwEhW8ietZ4pvFVnM0Z
         c2y/srgZOikZ6UIBdrOkqOfZYj1zBSRT9jrorCZd5jRYtoaouRoW7IVmfvZqUi6JRDoe
         J04ZMuNq72HAerqcM6j9uhHHGea9KgYAHU+AJXJ90U/g16D8mTAR114FCjgtCDefk3u3
         ghQdRrRL0fOWu2GchCbaMkHVg/vB8b8DxK7MBfwlCQ5veWpAQiFvOxn/0dSz7oNLbCC7
         kgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDlS1bYqh/jLNg7Qm6mC7IENS/hPhiRMRrNNreHxjaWffZDTRkSwIHLLbVX7l6fr1dks1RAEC1esJJi5o=@vger.kernel.org, AJvYcCUr+OtCLFPK09tdMvFtWmRS5f47noHa3/YX7o0APHEAch4G36tagNoBf8uZN79Ndgau3SHnRrqC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1co47s5GJS4ohFpzzu/LNzsKQ6Sx/1rrXinqdkYkq8myEIRIq
	ILTesK+rfIBhs43D63zhIKJrEzonYwbGagG/x+Vb6dGrGrLFpoRH
X-Gm-Gg: ASbGnctjgL1svjQQREtXiwRBwCyynf6i3EuTG7ghuPlt9fWhHeZ/vPGaB6IRB/ZjyaO
	jwMWlOW2MJqiofuh6A+do9n5kLC3l0boxVpyCkIA/1gUCOdAHXgzuVVif3TwO/5ElmCoTKnXNdO
	jZWSgqLd3L6EEU0cHF8WYkGdIwdSWIFLesGwPeF5vQIz7QlVt1Bx2Wpn8awLLzfxGGj/hX8DkWb
	5TIURacNsNVFvF6yciJyDkzqcO8lihHFJdncqSaZRSxqAV7H0tl2uQ+qpbQ58PlYOAr0axnLOgm
	THjSrhgWbc3x8Eru/+w/E8BMuoff
X-Google-Smtp-Source: AGHT+IGdnYDFhquPDANBW/t8s+v17pRTpxTdgVNlSSlgqLevLyFnxfpZxlTzVSiFWuujrFYTqz760Q==
X-Received: by 2002:a17:907:6e8d:b0:ac7:2aa7:5ba6 with SMTP id a640c23a62f3a-acb74b2d23emr92002066b.5.1744986601569;
        Fri, 18 Apr 2025 07:30:01 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef41605sm123261366b.124.2025.04.18.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:30:00 -0700 (PDT)
Date: Fri, 18 Apr 2025 17:29:58 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 net-next 04/14] net: enetc: add MAC filtering for
 i.MX95 ENETC PF
Message-ID: <20250418142958.6ews5uuoqayc7lof@skbuf>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-5-wei.fang@nxp.com>
 <20250415204238.4e0634f8@kernel.org>
 <PAXPR04MB85100BB81C6B25BFC69B32B588BD2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB85100BB81C6B25BFC69B32B588BD2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Wed, Apr 16, 2025 at 05:16:15AM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: 2025年4月16日 11:43
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> > <vladimir.oltean@nxp.com>; Clark Wang <xiaoning.wang@nxp.com>;
> > andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > pabeni@redhat.com; christophe.leroy@csgroup.eu; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; imx@lists.linux.dev; linuxppc-dev@lists.ozlabs.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v5 net-next 04/14] net: enetc: add MAC filtering for i.MX95
> > ENETC PF
> > 
> > On Fri, 11 Apr 2025 17:57:42 +0800 Wei Fang wrote:
> > >  	enetc4_pf_netdev_destroy(si);
> > >  	enetc4_pf_free(pf);
> > > +	destroy_workqueue(si->workqueue);
> > 
> > I think that you need to flush or cancel the work after unregistering
> > the netdev but before freeing it? The work may access netdev after its
> > freed.
> 
> Yes, you are right, I will improve it. thanks.

I think the workqueue creation needs to be handled in
enetc4_pf_netdev_create() somewhere in between alloc_etherdev_mqs() and
register_netdev(), so that the workqueue is available as soon as the
interface is registered, but also so that the workqueue teardown takes
places naturally where Jakub indicated.

