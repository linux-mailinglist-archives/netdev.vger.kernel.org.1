Return-Path: <netdev+bounces-20250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749275EA4E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 05:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200361C2099C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 03:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A761DEDA;
	Mon, 24 Jul 2023 03:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C222EC5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 03:59:36 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C828B0
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 20:59:35 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583b3939521so22411687b3.0
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 20:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690171174; x=1690775974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHAPnnSZKvMt5Lg/QwwUMZiuW3NABbsBjEppktwmZ5s=;
        b=s6QlQkeGDbg4NtN0K1dDPke7OouHeeljrgct8fibCP+/nASOksiruIbML3WWZIQ2BX
         8+nZO2WoxzcGf0FmY1fsAPAdCldnIpftIkU40XnkqYdxu1oCe97jN5nqlBvrBk+E0d33
         h0/m9cVF5M/dDAXTZop9LUiZIO1ZfOb/QWVz57K6rUbCBqiqe/uxDjrDQVsp+wJGfUlV
         rztbYuNHNUZPGM7l1VPKEkmPtVzTB7v3RbIY0x/H7G+rYrCv++1lyA8amyJJGIkTEGv5
         +aIDdcCOs9htUlcyu1YxRXCws1H68NZ2+nq/f62cyLrAXrNa4sp7/mL5cvggPeb2oAA+
         lgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690171174; x=1690775974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHAPnnSZKvMt5Lg/QwwUMZiuW3NABbsBjEppktwmZ5s=;
        b=EFgnosCpRFlUOysTReTZMGxZzPQjxGW6MmUNylHXTsSjrrwthKx4Gwq+vA6CN+fen0
         de1jEg6vHPGEQ3A16Vd+AwqI876bum6xio6+pMDbWbexG/FNwi8r1LtuvMfUT/BQbZbg
         pN4wK+K1gjipYK3zw0p95dqRqjTr8/8a+y7RxecY/LSPSwE87RmAGB46xz3eMLFJqBef
         ZcDz7lgcIR1QBAgbg1nrbATy566OAF5OhSzwQOiquYfNHGp6eIJM3AK6ZlYIVf/P6hlm
         dR6vFRms7XxPpZ3A33JRud1pAX9+ootE+vNbBo/frBnQkU6OQF1B6r1wX8SSYlyeiV0u
         FpvQ==
X-Gm-Message-State: ABy/qLZiMN9QxbaSEatpaXbxC5EaSM99XcvFD/Vs7wU35TMZR1HPAscp
	FfG7ETta4J54O+NOTxeKpG6bhHHx76XacKXo
X-Google-Smtp-Source: APBJJlFTv5haGrkOIdYByCil8F+KVUqqmN0jiUzmmVkUEAHj4wfsVdkLcENFThFXnLFuwxiUj0XwZQ==
X-Received: by 2002:a81:9143:0:b0:573:7f55:a40e with SMTP id i64-20020a819143000000b005737f55a40emr4764334ywg.49.1690171174347;
        Sun, 23 Jul 2023 20:59:34 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001aad714400asm7671560plb.229.2023.07.23.20.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 20:59:33 -0700 (PDT)
Date: Mon, 24 Jul 2023 11:59:28 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: [PATCHv2 net-next] IPv6: add extack info for inet6_addr_add/del
Message-ID: <ZL33IPUcU3bmpO82@Laptop-X1>
References: <20230719135644.3011570-1-liuhangbin@gmail.com>
 <ZLkL3eNVNfzZbaBv@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLkL3eNVNfzZbaBv@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 01:26:37PM +0300, Ido Schimmel wrote:
> > -static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
> > +static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa,
> > +			      struct netlink_ext_ack *extack)
> >  {
> >  	struct net *net = dev_net(dev);
> >  	unsigned int hash = inet6_addr_hash(net, &ifa->addr);
> > @@ -1037,7 +1038,7 @@ static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
> >  
> >  	/* Ignore adding duplicate addresses on an interface */
> >  	if (ipv6_chk_same_addr(net, &ifa->addr, dev, hash)) {
> > -		netdev_dbg(dev, "ipv6_add_addr: already assigned\n");
> > +		NL_SET_ERR_MSG(extack, "ipv6_add_addr: already assigned");
> 
> How do you trigger it?
> 
> # ip link add name dummy10 up type dummy
> # ip address add 2001:db8:1::1/64 dev dummy10
> # ip address add 2001:db8:1::1/64 dev dummy10
> RTNETLINK answers: File exists
> 
> Better to add extack in inet6_rtm_newaddr():
> 
> if (nlh->nlmsg_flags & NLM_F_EXCL || 
>     !(nlh->nlmsg_flags & NLM_F_REPLACE))
> 	err = -EEXIST;
> else
> 	err = inet6_addr_modify(net, ifa, &cfg)

Thanks. Since the dup addr checking will be done on inet6_rtm_newaddr(). I
will remove the extack msg in ipv6_add_addr_hash().

> > @@ -1103,6 +1108,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
> >  
> >  	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags);
> >  	if (IS_ERR(f6i)) {
> > +		NL_SET_ERR_MSG(extack, "Dest allocate failed");
> 
> The only thing that can fail in this function is ip6_route_info_create()
> which already has an extack argument. Better to pass extack to
> addrconf_f6i_alloc() and get a more accurate error message.

OK, I will update the patch.

> > -	if (cfg->plen > 128)
> > +	if (cfg->plen > 128) {
> > +		NL_SET_ERR_MSG(extack, "IPv6 address prefix length larger than 128");
> 
> For RTM_NEWROUTE IPv6 code just says "Invalid prefix length", so might
> as well be consistent with it. Also, I see IPv4 doesn't have such
> messages for its RTM_{NEW,DEL}ADDR messages. If you think it's useful
> for IPv6, then I suggest also adding it to IPv4.

OK. But since this patch is for IPv6. I will post another patch for IPv4
specifically.

Thanks
Hangbin

