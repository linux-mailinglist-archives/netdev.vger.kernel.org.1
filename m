Return-Path: <netdev+bounces-21254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B6762FF8
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA95F281D50
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E2A921;
	Wed, 26 Jul 2023 08:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038929455
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:36:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A160E0;
	Wed, 26 Jul 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RAU0cPXH92fccMay1mm1XuQEOIvzdh7WIU3f587dsCI=; b=19FUvKyFVXqzZLN143udiZB+9n
	jOVsdfJXaR0AVtp6/XVgx6Q6mG7vMGdXjzfQnH+g6R+tOd1F+Au2XBnapGLSzVn6L/xPqgpyF4GxC
	BsbUzcuGv1OdH1fcE5Idi/uz9J87rLntH3Hc/o/aLakld8zzDYVFA0oM4a8N4Iq1SVBM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qOa0k-002L4n-O6; Wed, 26 Jul 2023 10:36:46 +0200
Date: Wed, 26 Jul 2023 10:36:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hayes Wang <hayeswang@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] r8152: adjust generic_ocp_write function
Message-ID: <c63b0f24-4e6b-4df3-8783-9899d178b16e@lunn.ch>
References: <20230726030808.9093-417-nic_swsd@realtek.com>
 <20230726030808.9093-418-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726030808.9093-418-nic_swsd@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 11:08:07AM +0800, Hayes Wang wrote:
> Reduce the control transfer if all bytes of first or the last DWORD are
> written.
> 
> The original method is to split the control transfer into three parts
> (the first DWORD, middle continuous data, and the last DWORD). However,
> they could be combined if whole bytes of the first DWORD or last DWORD
> are written. That is, the first DWORD or the last DWORD could be combined
> with the middle continuous data, if the byte_en is 0xff.

How often is byte_en 0xff? Do you have some benchmark numbers to show
it is worth the complexity?

   Andrew

