Return-Path: <netdev+bounces-144861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77C79C8976
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44241B2833C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E61F9A9A;
	Thu, 14 Nov 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afhQGr3v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AB192D9D
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585780; cv=none; b=tqMbCjzEN4ztVi20bpyCfWstkxzhDk0an7fbrlF0Bgyux2OzvC7i1mfCxMS03wIg5/GGv5v9cY/5NmzYQROai0sYd69CklkdZVbYHjCCYAYDyzzBiV4knxqLdatXiBQvkiNxTHR0EaRGjQlpcht/9lW7dZIW9lY5e5Oc9FlH0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585780; c=relaxed/simple;
	bh=k8vvHLSi3/Ba27sZNaoHwLkf9qlD47v6sneOKR2gKYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNzJvo5FgxgkwZTRxh6RIejAOWXsnpYQ0zCrPY5WWpK0XXmUUXEeUP3YsB2bSCv60EQZU3pEMXSPo9i7qunnRqXrrhQ/dKn8cIUMqCjZu45oRMUQ4oR8zhZFEZWSFV2Udi+5nMSkkTRrxD2e6drB7eRVDNmXa+3RDyyotvdo9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afhQGr3v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731585777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zpQdMqKFFqaHRJ8M6WcgEvfRNF6AeI76vWq5L2MI+s=;
	b=afhQGr3v7xc+3FOLlU15/PJc135LPfn4n08/GF6DPIkRdngZkN1RLpvsgBXmefkFfDuC0f
	wGh6VZKFsxa0LrpB42C0AftYbhEd7LYZQHBIZsx3CeA0RnY3Eq4+m22P//CmKkhAi884ZF
	ZYi+VMgvfcLewB3MOZUMYppFzxsFbUY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-9F0_5PVEP_C_YjXyRuHRzg-1; Thu, 14 Nov 2024 07:02:54 -0500
X-MC-Unique: 9F0_5PVEP_C_YjXyRuHRzg-1
X-Mimecast-MFC-AGG-ID: 9F0_5PVEP_C_YjXyRuHRzg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43159603c92so4036275e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 04:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585773; x=1732190573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zpQdMqKFFqaHRJ8M6WcgEvfRNF6AeI76vWq5L2MI+s=;
        b=jnM+nQQ5R/PiPvpK2HFAK1pka/9/Ekoc3t4nNHm0S/FksgkoAYinjHK1Dookgh5I8S
         aKT5b06V6Bpl+d9F93N8XJOXVdfeoCwsuhlMV58Fp7hcnjxKJ07KjEn2LfFR2oOEdj8O
         KtXP26FkJU323ox3mjaYKgAwI9uGNE+VL2wjVMCQvS5qIFSG9T2jf2JWJKRWoL29Obje
         milUVS+iQXTwT8ffwvgQelORgZgblOdJH7aOS6iFectrptBGvmMAV/yE8VmTtUTl1mSw
         PbPrpRFCLs3A091+ppv6Wmw++DFxVdFP+hQqZzeqcLS5+7JP1SacMkUeg7as6dmmrauO
         0usg==
X-Forwarded-Encrypted: i=1; AJvYcCX/fyL9bopPQqPvwTu4xFKlJq3UnGByk8CdqbznYCKOHQCD0Yg5mv1pqx+VBvISt9hylVzBXhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE53S7Bp/titAq1DuBxkYN9XKm4NrdvUa1h6pataJWERo616hk
	TVjDuI/HHfGP6/AMImjIofdkggOaTz9vYYPbBIQUAL5qlCDOc7PKzZVCPeQW6W57BsSb15k22Qy
	6WAezxn0mFplMbXW3/2Jnp0NLuUjrPzarKSsVPgG93IjCvJhb9wNAzA==
X-Received: by 2002:a05:600c:4689:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-432da7dc45fmr14238875e9.28.1731585773175;
        Thu, 14 Nov 2024 04:02:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbgc10bxAJ/VIRFkaOi6IwkSPLAJX2D33rxzmsycb7616hQU5vNcmjB3rsRSBucznfT6zuWQ==
X-Received: by 2002:a05:600c:4689:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-432da7dc45fmr14238395e9.28.1731585772696;
        Thu, 14 Nov 2024 04:02:52 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298a41sm21695655e9.38.2024.11.14.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:02:52 -0800 (PST)
Date: Thu, 14 Nov 2024 13:02:49 +0100
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
Message-ID: <ZzXm6SHjRfbaOX14@debian>
References: <20241109-am65-cpsw-multi-rx-dscp-v3-0-1cfb76928490@kernel.org>
 <20241109-am65-cpsw-multi-rx-dscp-v3-2-1cfb76928490@kernel.org>
 <ZzVBS1zXIy31pnaf@debian>
 <76dd6141-5852-43ae-af98-f0edf0bc10f5@kernel.org>
 <8bfe8acc-9514-4ba8-9498-2427ddb0bb78@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bfe8acc-9514-4ba8-9498-2427ddb0bb78@kernel.org>

On Thu, Nov 14, 2024 at 12:12:47PM +0200, Roger Quadros wrote:
> On 14/11/2024 11:41, Roger Quadros wrote:
> > On 14/11/2024 02:16, Guillaume Nault wrote:
> >> So what about following the IETF mapping found in section 4.3?
> >> https://datatracker.ietf.org/doc/html/rfc8325#section-4.3
> > 
> > Thanks for this tip.
> > I will update this patch to have the default DSCP to UP mapping as per
> > above link and map all unused DSCP to UP 0.
> 
> How does the below code look in this regard?

Looks generally good to me. A few comments inline though.

> static void am65_cpsw_port_enable_dscp_map(struct am65_cpsw_port *slave)
> {
> 	int dscp, pri;
> 	u32 val;
> 
> 	/* Default DSCP to User Priority mapping as per:
> 	 * https://datatracker.ietf.org/doc/html/rfc8325#section-4.3

Maybe also add a link to
https://datatracker.ietf.org/doc/html/rfc8622#section-11
which defines the LE PHB (Low Effort) and updates RFC 8325 accordingly.

> 	 */
> 	for (dscp = 0; dscp <= AM65_CPSW_DSCP_MAX; dscp++) {
> 		switch (dscp) {
> 		case 56:	/* CS7 */
> 		case 48:	/* CS6 */
> 			pri = 7;
> 			break;
> 		case 46:	/* EF */
> 		case 44:	/* VA */
> 			pri = 6;
> 			break;
> 		case 40:	/* CS5 */
> 			pri = 5;
> 			break;
> 		case 32:	/* CS4 */
> 		case 34:	/* AF41 */
> 		case 36:	/* AF42 */
> 		case 38:	/* AF43 */
> 		case 24:	/* CS3 */
> 		case 26:	/* AF31 */
> 		case 28:	/* AF32 */
> 		case 30:	/* AF33 */

Until case 32 (CS4) you've kept the order of RFC 8325, table 1.
It'd make life easier for reviewers if you could keep this order
here. That is, moving CS4 after AF43 and CS3 after AF33.

> 			pri = 4;
> 			break;
> 		case 17:	/* AF21 */

AF21 is 18, not 17.

> 		case 20:	/* AF22 */
> 		case 22:	/* AF23 */
> 			pri = 3;
> 			break;
> 		case 8:		/* CS1 */

Let's be complete and add the case for LE (RFC 8622), which also
maps to 1.

> 			pri = 1;
> 			break;
> 		default:
> 			pri = 0;
> 			break;
> 		}
> 
> 		am65_cpsw_port_set_dscp_map(slave, dscp, pri);
> 	}
> 
> 	/* enable port IPV4 and IPV6 DSCP for this port */
> 	val = readl(slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> 	val |= AM65_CPSW_PN_REG_CTL_DSCP_IPV4_EN |
> 		AM65_CPSW_PN_REG_CTL_DSCP_IPV6_EN;
> 	writel(val, slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> }
> 
> > 
> > Is there any mechanism/API for network administrator to change this
> > default mapping in the network drivers?
> > 
> >>
> >>>  static void am65_cpsw_sl_ctl_reset(struct am65_cpsw_port *port)
> >>>  {
> >>>  	cpsw_sl_reset(port->slave.mac_sl, 100);
> >>> @@ -921,6 +974,7 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
> >>>  	common->usage_count++;
> >>>  
> >>>  	am65_cpsw_port_set_sl_mac(port, ndev->dev_addr);
> >>> +	am65_cpsw_port_enable_dscp_map(port);
> >>>  
> >>>  	if (common->is_emac_mode)
> >>>  		am65_cpsw_init_port_emac_ale(port);
> >>>
> >>> -- 
> >>> 2.34.1
> >>>
> >>>
> >>
> > 
> 
> -- 
> cheers,
> -roger
> 


