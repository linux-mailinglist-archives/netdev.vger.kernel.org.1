Return-Path: <netdev+bounces-152675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D373D9F558A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFE518968A9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E91FBE83;
	Tue, 17 Dec 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBd0brOY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0A1FBEAC;
	Tue, 17 Dec 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458096; cv=none; b=RaiKJAVl88PYsDoBALDCPAP49uvjJUTVFycG9BDOb/NQMR5z9jIXgQtXi/gb+caU5aOBcYCD3G4MHr14IOXvQhMBXrLwEbA0kAjdsNgc9ORz+Nl91NMQ6MZHXxvCh2HK+A1EvPt0BUNGmdiLih0FYTQ1pbRA0sVLM8YrDExpqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458096; c=relaxed/simple;
	bh=5PykxEFIGGCVAhvaitz/8BJOTQ+bEmFMD3w76LQued0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib4OH/bs4XiWThNLuTRdXO5uMxR8E5vX0PCBnuu4ynEWrmg15sj2Xsyyaq0XQROT9h3EsOhVrAMd1NqjTUOb6lO6Lgd0Ti3q/XheCL1h9zJeBLBD8133UUAqreBO5pRZS/9yp2OQPQlVeV76vTbI7k1B/giP7wIopwIlsfX/CT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBd0brOY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a766b475so59173805e9.1;
        Tue, 17 Dec 2024 09:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734458093; x=1735062893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyrmzpRaBGC3KODJNI/AuY5aXSnDASObC2Ra3ok3feg=;
        b=JBd0brOY1ieWqV9pT5fIUm6AL/7l74X7zwKCkM2OX2X2Q/ApqMpPftr8aAFvgfrNcB
         1g4+igtYVJAdA6A0AmBoESBvHISasNfqFTCXgby6gTl2foIp5SVsF4onrD7R3F84RdeF
         zGma2CbRyDDh4OXTu6Z4NIu238FD6aytQ8N7wP5RIIVC6FTYUdIRy45qdG7WKQa5wI5Z
         9byDYvshaX3g1QAxUerRSKQ9IaKf7JC6/ksF428K1JTD9PS5fP38xbRhqBIWwaa/e09/
         Eee1VBCFxqq8lwIspTjp9EA7DZYEIgVwuP1+R+v0WkEKxTsDAj15Du/TUnTr+olNraAE
         oUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734458093; x=1735062893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyrmzpRaBGC3KODJNI/AuY5aXSnDASObC2Ra3ok3feg=;
        b=PJzx9byympXIWfxAVzKdxxZWRTuB0YgT7u8TGx1tUhZWJBhNPnnwaY/p34xnZYU6se
         w7IuLWVB4TA5OFEWgoWZSxNS0W45yRPCcwyjAoaAu2IsTidyzjNuoVNg0jqhO45K0gPg
         C634aT8C0Lnwhzpbn8Js7b5BwQqkwMt8l63J273nGpBPGl7tayy7RfKn770KZ/NWLH9I
         EQOn7tapN/+eIzBok7BGY466KF42N5smzkBvJLc8zzR/44EO7daVbCOXhr/4lmmrl5VH
         l0DLCM1/ZX5DhsHWA4TxeWLqwRGlT4r9EwmYxfNf8wxSJy/RJcPZQSr1JAMC0uOENGvE
         0TuA==
X-Forwarded-Encrypted: i=1; AJvYcCXOwrrpyQ5caJFDu9J0iXuI5fA5QSUXIlNTUXg8HKjKG+gSxYhrpHBvV1KD8n3xjK1jHxto1zKd6bLcjzM=@vger.kernel.org, AJvYcCXWCGsj7uzzEn5aVMF3CXLTISNmyChWuJAm4wK351wixKGMbWi6pJHeD1LquMFrUGMg73X5ukKa@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7QBZq37k4cn3Y3hXtpaIEL5eUHmJforzck++EA8HpZNwEGzA
	ir6kRQZQMfGhMYF++QtGC8hDwwYtpWb1FY41DxhRyhN0z7EbfWMu
X-Gm-Gg: ASbGncvcQM0q89QibNlSsp8oRiFs6L3adPcuZnTDbpbFbZHDDaRYPuCfb3G4CKLatOm
	aerH9HHMp8haGBMLJp7YFvfg1g21EriZnB4ElFw2Tuq3IxtYQaLFIWOhCw+Hbp57Ui+mdgXH4NW
	Rdyz2LlUfOL6W1rAjxuQvTmNoJtm90Mms0mSrmNdhvqy5gr2d4zFAaCx4CsLZsazHi7leis5yTr
	UqvbXfb0i80fgv0ptgiX5r/4Ex7lzw6myoz9Bv+NTWHxzUCUOyM
X-Google-Smtp-Source: AGHT+IECFEtLkTK128lu9CsBumM33qWpYgZlGgNWPCfhtohQpNVOeboAjx2KzumX7eW6XvHOBHMIHQ==
X-Received: by 2002:a05:600c:3b25:b0:435:9ed3:5698 with SMTP id 5b1f17b1804b1-436530eeefamr2315305e9.24.1734458093037;
        Tue, 17 Dec 2024 09:54:53 -0800 (PST)
Received: from debian ([2a00:79c0:674:2500:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625553213sm178825245e9.8.2024.12.17.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:54:52 -0800 (PST)
Date: Tue, 17 Dec 2024 18:54:50 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: dp83822: Add support for PHY LEDs on
 DP83822
Message-ID: <20241217175450.GA716460@debian>
References: <20241217-dp83822-leds-v1-1-800b24461013@gmail.com>
 <20241217163208.GT780307@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217163208.GT780307@kernel.org>

Am Tue, Dec 17, 2024 at 04:32:08PM +0000 schrieb Simon Horman:
> On Tue, Dec 17, 2024 at 10:16:03AM +0100, Dimitri Fedrau wrote:
> > The DP83822 supports up to three configurable Light Emitting Diode (LED)
> > pins: LED_0, LED_1 (GPIO1), COL (GPIO2) and RX_D3 (GPIO3). Several
> > functions can be multiplexed onto the LEDs for different modes of
> > operation. LED_0 and COL (GPIO2) use the MLED function. MLED can be routed
> > to only one of these two pins at a time. Add minimal LED controller driver
> > supporting the most common uses with the 'netdev' trigger.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/net/phy/dp83822.c | 271 +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 269 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
> 
> ...
> 
> > +static int dp83822_led_hw_control_set(struct phy_device *phydev, u8 index,
> > +				      unsigned long rules)
> > +{
> > +	int mode;
> > +
> > +	mode = dp83822_led_mode(index, rules);
> > +	if (mode < 0)
> > +		return mode;
> > +
> > +	if (index == DP83822_LED_INDEX_LED_0 || index == DP83822_LED_INDEX_COL_GPIO2)
> > +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> > +				      MII_DP83822_MLEDCR, DP83822_MLEDCR_CFG,
> > +				      FIELD_PREP(DP83822_MLEDCR_CFG, mode));
> 
> ...
> 
> > +}
> > +
> > +static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
> > +				      unsigned long *rules)
> > +{
> > +	int val;
> > +
> > +	if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {
> 
> Hi Dimitri,
> 
> As per the condition near the top of dp83822_led_hw_control_set(), should
> this be:
> 
> 	if (index == DP83822_LED_INDEX_LED_0 ||
> 	    index == DP83822_LED_INDEX_COL_GPIO2) {
> 
> Flagged by W=1 + -Wno-error build with clang-19.
> 
>  drivers/net/phy/dp83822.c:1029:39: note: use '|' for a bitwise operation
>   1029 |         if (index == DP83822_LED_INDEX_LED_0 || DP83822_LED_INDEX_COL_GPIO2) {
>        |                                              ^~
>        |
> 
> ...
Thanks, will fix it.

Best regards,
Dimitri

