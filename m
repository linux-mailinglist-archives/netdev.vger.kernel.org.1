Return-Path: <netdev+bounces-144908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB189C8BA1
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E2282B57
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5E1F9ABF;
	Thu, 14 Nov 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQ+GV+dB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E363D18A6A1
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590272; cv=none; b=g4BaX30AnoiK3exwDDlmDiL8dGBZDRuZzfoL7WQuHWqLsJq+8UK6v6jv73l6IoAFC8YvHJ0GHMJYH1qgIwKPuoWSujR4jR3WJuxpvHh1exFHWMslHnDmAsdky6SexGu7vISc2KJzbQg7yYhFXGNjO5855bI5xc85nANYREQck7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590272; c=relaxed/simple;
	bh=kOcxvdK94REh1oUeYcJmdN8/ZqLhYHikvQOHyzk0ZAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfR9ibLR6Cf0i8hFVTz5cQ1PfYyPm2SlRI535NTb5/G3d1Tz1BZ2oAU1M9azbNt+6S1V8Efs5I9zFOYNq94PE6VV7c8HbOT4RUoheO6SvmSIyIrC3De93h84Kug2ljpFrkdcqfSRfWxb0sIxGfj9edM8RUEOEOSZgyLX4etP9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQ+GV+dB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731590269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIkbTTXRzRps+LUew0VaU/Iqcm4Qp8dWdivaxskb2+Q=;
	b=BQ+GV+dBBHTZugVURk4t2tmuGE3dxmZS0Js05UGGOCInYCz9K99IRwYqEH1Ci90M2rLTtI
	P051Z987Qbnf3Id2ObSSao6KpAqD0FnPBy0g8vxg9MnUlZMTi1Mi1wa0oA42fPf/MLAM2S
	pbaGhuKe2QtcUvGaAk0o9bn2Zdgy4/s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-7PVjlqljP3-bRsFugMxEog-1; Thu, 14 Nov 2024 08:17:48 -0500
X-MC-Unique: 7PVjlqljP3-bRsFugMxEog-1
X-Mimecast-MFC-AGG-ID: 7PVjlqljP3-bRsFugMxEog
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316300bb15so4854495e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 05:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590267; x=1732195067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIkbTTXRzRps+LUew0VaU/Iqcm4Qp8dWdivaxskb2+Q=;
        b=c5WFReOGYHpPq29t3DwujB51Ni9awvcNxMBSXOR5WV53ZNhO3TbhAq0dt+4M8mKf+t
         HXS3cb7nDbo/9Wqq0fV1iQK1Bw/AJ5fEr9WwepxMjmr3FDrl7UWHRhS2CDjbh8r0bfxf
         anzOhXKwsRkBURc92lPv4VS7eJT/+Z1I3QdckmQgkk7Q/WWb5PQvIkgoWMQNtfcEdyj4
         SKJWj4w0ePVw+bwttIu3dCEzE9GnAhJdC+vaceghFBvNYO6XU1xn3YK/DE9D5xB2Omqn
         F6Jxo5elARCwCMdb4qxNeKd0bhJPdge0/9gOEYC0WdpVHulSFiqHbALvOeRFiOWtVGzU
         u6tg==
X-Forwarded-Encrypted: i=1; AJvYcCXohcjq8egy+DBNSBDZRpy0rWHFYyxQjsYVsLCfzO8onMv6KSiOJ1YConY1C6LdEidyFKqMDU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ue82dmKW+mD1XWx7kxtXYsifF5tH/HPBQWpTjskIs9M9JoAW
	eladrPRDJgGzV/u1TT+xerhR/+bVbVHmGy92xt4MJ4onF7DCCYz/2o6tWZ/OFk8HxDYQrMsWePF
	+flx81wGER+kP/GRS6TMboQf8+Nevw+X6/+3kaCI4pHqQh23Xt2E7Fw==
X-Received: by 2002:a05:600c:1f94:b0:431:5ab3:d28d with SMTP id 5b1f17b1804b1-432b75036eemr212205255e9.9.1731590267528;
        Thu, 14 Nov 2024 05:17:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI9dlGsQXrDIQispJUmVhXEmP25HAzMxF+CW2ZS8/AAybcLWHEjjID9r9LVs0dYjf7ZJUgGg==
X-Received: by 2002:a05:600c:1f94:b0:431:5ab3:d28d with SMTP id 5b1f17b1804b1-432b75036eemr212205015e9.9.1731590267150;
        Thu, 14 Nov 2024 05:17:47 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac0ae25sm19958155e9.35.2024.11.14.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:17:46 -0800 (PST)
Date: Thu, 14 Nov 2024 14:17:44 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-omap@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next v3 2/2] net: ethernet: ti: am65-cpsw: enable
 DSCP to priority map for RX
Message-ID: <ZzX4eD/0i8SOOZGP@debian>
References: <20241109-am65-cpsw-multi-rx-dscp-v3-0-1cfb76928490@kernel.org>
 <20241109-am65-cpsw-multi-rx-dscp-v3-2-1cfb76928490@kernel.org>
 <ZzVBS1zXIy31pnaf@debian>
 <76dd6141-5852-43ae-af98-f0edf0bc10f5@kernel.org>
 <8bfe8acc-9514-4ba8-9498-2427ddb0bb78@kernel.org>
 <ZzXm6SHjRfbaOX14@debian>
 <e9d3a6c8-fb12-4926-8c2b-414017681f03@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d3a6c8-fb12-4926-8c2b-414017681f03@kernel.org>

On Thu, Nov 14, 2024 at 02:47:07PM +0200, Roger Quadros wrote:
> 
> 
> On 14/11/2024 14:02, Guillaume Nault wrote:
> > On Thu, Nov 14, 2024 at 12:12:47PM +0200, Roger Quadros wrote:
> >> On 14/11/2024 11:41, Roger Quadros wrote:
> >>> On 14/11/2024 02:16, Guillaume Nault wrote:
> >>>> So what about following the IETF mapping found in section 4.3?
> >>>> https://datatracker.ietf.org/doc/html/rfc8325#section-4.3
> >>>
> >>> Thanks for this tip.
> >>> I will update this patch to have the default DSCP to UP mapping as per
> >>> above link and map all unused DSCP to UP 0.
> >>
> >> How does the below code look in this regard?
> > 
> > Looks generally good to me. A few comments inline though.
> > 
> >> static void am65_cpsw_port_enable_dscp_map(struct am65_cpsw_port *slave)
> >> {
> >> 	int dscp, pri;
> >> 	u32 val;
> >>
> >> 	/* Default DSCP to User Priority mapping as per:
> >> 	 * https://datatracker.ietf.org/doc/html/rfc8325#section-4.3
> > 
> > Maybe also add a link to
> > https://datatracker.ietf.org/doc/html/rfc8622#section-11
> > which defines the LE PHB (Low Effort) and updates RFC 8325 accordingly.
> > 
> >> 	 */
> >> 	for (dscp = 0; dscp <= AM65_CPSW_DSCP_MAX; dscp++) {
> >> 		switch (dscp) {
> >> 		case 56:	/* CS7 */
> >> 		case 48:	/* CS6 */
> >> 			pri = 7;
> >> 			break;
> >> 		case 46:	/* EF */
> >> 		case 44:	/* VA */
> >> 			pri = 6;
> >> 			break;
> >> 		case 40:	/* CS5 */
> >> 			pri = 5;
> >> 			break;
> >> 		case 32:	/* CS4 */
> >> 		case 34:	/* AF41 */
> >> 		case 36:	/* AF42 */
> >> 		case 38:	/* AF43 */
> >> 		case 24:	/* CS3 */
> >> 		case 26:	/* AF31 */
> >> 		case 28:	/* AF32 */
> >> 		case 30:	/* AF33 */
> > 
> > Until case 32 (CS4) you've kept the order of RFC 8325, table 1.
> > It'd make life easier for reviewers if you could keep this order
> > here. That is, moving CS4 after AF43 and CS3 after AF33.
> > 
> >> 			pri = 4;
> >> 			break;
> >> 		case 17:	/* AF21 */
> > 
> > AF21 is 18, not 17.
> > 
> >> 		case 20:	/* AF22 */
> >> 		case 22:	/* AF23 */
> >> 			pri = 3;
> >> 			break;
> >> 		case 8:		/* CS1 */
> > 
> > Let's be complete and add the case for LE (RFC 8622), which also
> > maps to 1.
> 
> All comments are valid. I will fix and send v4 for this series.
> 
> > 
> >> 			pri = 1;
> >> 			break;
> 
> For sake of completeness I will mention CS2, AF11, AF12, AF13
> here that can fallback to default case.

Yes, very nice.

> >> 		default:
> >> 			pri = 0;
> >> 			break;
> >> 		}
> >>
> >> 		am65_cpsw_port_set_dscp_map(slave, dscp, pri);
> >> 	}
> >>
> >> 	/* enable port IPV4 and IPV6 DSCP for this port */
> >> 	val = readl(slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> >> 	val |= AM65_CPSW_PN_REG_CTL_DSCP_IPV4_EN |
> >> 		AM65_CPSW_PN_REG_CTL_DSCP_IPV6_EN;
> >> 	writel(val, slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> >> }
> >>
> >>>
> 
> -- 
> cheers,
> -roger
> 


