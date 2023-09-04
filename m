Return-Path: <netdev+bounces-31910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8147915A9
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86AF1C20506
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3411C01;
	Mon,  4 Sep 2023 10:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5CB7E
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 10:23:22 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF26C1B9
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 03:23:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdbf10333bso9759615ad.1
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693823000; x=1694427800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSLFlV90xYVMKo1p38ar4ODwBk0cpGS2kbhadSEuNTY=;
        b=hXiygC8gjD9aQERokAuM/sz9POt8e9J+cKNKCGlJqNW7LNDWWzCyKCm9zL+S4N8WbD
         /aX4ORaGr7lP8Z12XxRKDBonPceif/j+VUlNnMzswg0F1B4f4h12iOq02tmbUCK94Php
         H8EJabQoYcPuPjNQeYu/H7n7mUJ9hw2RgeUZHj8Yoe4jSfL1a7ucqScuriAXVQdr+h0l
         wp3N+OYt/q8BV56bsFPhIxm8iFGTBMmnh3ioAir47VPg2+3QG6LDVwlu2zrz8nCro9Zp
         2TOfKovBDb/1dVUJOczrzQDBbl1Oyx+tIX6QaEuxHGXBzGY10XdFynaPZITVrImJcf4z
         S6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693823000; x=1694427800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSLFlV90xYVMKo1p38ar4ODwBk0cpGS2kbhadSEuNTY=;
        b=dicB5R57+unJ2C0Tm4KWr2yBMg0NuOU+3blTrpqCtzEnOMuylDE6H4NYM70zgEg3ge
         lDduDAI6inXHUnreKD7e4khnu1Fv1cP+SCSZNsVLZeIR9BE0oN2JNJJDX0z61R3JzZ8j
         5Wad2LHorbrtHqqbUpiuh5LJmeWnJmmZuMcdh+Z0dS32qepNjVpx5fqeqUbGzCC6Uo16
         pbW1FktQAaCVr7nARJm+JF0jdRN902e4EIutaWI7aa4Ab6sAnLwV9kDMyUq8jGNRcmU4
         B7cJGhIDbWAq9h4ymrq5ApREuVcpTIXK3SVU3VDbpQbURbogoiYW687SmEfF3nrs4mzZ
         NMVA==
X-Gm-Message-State: AOJu0YyqwyXlv+H0fu+fP6uKr0axrjBLemz99sF3F9aoBTJOKirFIboJ
	fSZ8PCyz3dGkjV+3DfoG1Cc=
X-Google-Smtp-Source: AGHT+IFhZ0ckKJJXVAbUIfLX78DkVrIx8RFTBPzgxo3W/GkLN8W8Ht9sMiWRaL0FS86GRHWkKOI4Vg==
X-Received: by 2002:a17:902:d490:b0:1b8:33d4:77f8 with SMTP id c16-20020a170902d49000b001b833d477f8mr13874923plg.23.1693823000290;
        Mon, 04 Sep 2023 03:23:20 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jd5-20020a170903260500b001bb8895848bsm7290584plb.71.2023.09.04.03.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 03:23:19 -0700 (PDT)
Date: Mon, 4 Sep 2023 18:23:15 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <ZPWwE9IYArI08Zsc@Laptop-X1>
References: <20230902092007.3038132-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902092007.3038132-1-william.xuanziyang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ziyang,

On Sat, Sep 02, 2023 at 05:20:07PM +0800, Ziyang Xuan wrote:
> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
> $ ip link add name t-dummy type dummy
> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
> $ ip link add name t-nlmon type nlmon
> $ ip link set t-nlmon master team0
> $ ip link set t-nlmon nomaster
> $ ip link set t-dummy up
> $ ip link set team0 up
> $ ip link set t-dummy.100 down
> $ ip link set t-dummy.100 master team0
> 
> When enslave a vlan device to team device and team device type is changed
> from non-ether to ether, header_ops of team device is changed to
> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
> for vlan->real_dev in vlan_dev_hard_header() because team device is not
> a vlan device.
> 
> Use ether_setup() for team device when its type is changed from non-ether
> to ether to fix the bug.
> 
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  drivers/net/team/team.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index d3dc22509ea5..560e04860aa7 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2127,14 +2127,19 @@ static const struct ethtool_ops team_ethtool_ops = {
>  static void team_setup_by_port(struct net_device *dev,
>  			       struct net_device *port_dev)
>  {
> -	dev->header_ops	= port_dev->header_ops;
> -	dev->type = port_dev->type;
> -	dev->hard_header_len = port_dev->hard_header_len;
> -	dev->needed_headroom = port_dev->needed_headroom;
> -	dev->addr_len = port_dev->addr_len;
> -	dev->mtu = port_dev->mtu;
> -	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
> -	eth_hw_addr_inherit(dev, port_dev);
> +	if (port_dev->type == ARPHRD_ETHER) {
> +		ether_setup(dev);
> +		eth_hw_addr_random(dev);
> +	} else {
> +		dev->header_ops	= port_dev->header_ops;
> +		dev->type = port_dev->type;
> +		dev->hard_header_len = port_dev->hard_header_len;
> +		dev->needed_headroom = port_dev->needed_headroom;
> +		dev->addr_len = port_dev->addr_len;
> +		dev->mtu = port_dev->mtu;
> +		memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
> +		eth_hw_addr_inherit(dev, port_dev);
> +	}
>  
>  	if (port_dev->flags & IFF_POINTOPOINT) {
>  		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);

Thanks for the report. This fix is similar with what I do in my PATCHv3 [1].
And this will go back to the discussion of MTU update. How about just update
the header_ops for ARPHRD_ETHER? e.g.

	if (port_dev->type == ARPHRD_ETHER)
		dev->header_ops	= &eth_header_ops;
	else
		dev->header_ops	= port_dev->header_ops;

[1] https://lore.kernel.org/netdev/20230718101741.2751799-3-liuhangbin@gmail.com/

Thanks
Hangbin

