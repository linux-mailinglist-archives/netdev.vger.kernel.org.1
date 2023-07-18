Return-Path: <netdev+bounces-18651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE4E75836B
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48A328159A
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510D14AA5;
	Tue, 18 Jul 2023 17:25:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682DF9F7
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:25:57 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C2611C;
	Tue, 18 Jul 2023 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FcwgIdzFCVUEo9D5g7XqioPox9/gjSu8PoqoPPfMJOY=; b=Q8xZNYlqBslLWzbfNDBUYXNvT9
	ifN3DYtXE+8lpu7YxZq6/b4X3UhTmZgvl4FfeL0lsWBfiiA12N+wNhHTsFuO2dVnx2k4aLJQw/VOp
	GhNT/o2zAPmkO2so/GYfcobhhEo1iMvXLPnryZ+ZWvWo5FfgkId0M2ThAd4ijTQ/7ZEI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLoRw-001dmw-1r; Tue, 18 Jul 2023 19:25:24 +0200
Date: Tue, 18 Jul 2023 19:25:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 01/11] net: phy: get rid of redundant is_c45
 information
Message-ID: <68c0bbfb-ec7b-435d-a1ad-98e438c70bce@lunn.ch>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-1-9eb37edf7be0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-feature-c45-over-c22-v3-1-9eb37edf7be0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 05:07:01PM +0200, Michael Walle wrote:
> phy_device_create() will be called with is_c45 and c45_ids. If c45_ids
> are set, is_c45 is (usually) true. Change the only caller which do
> things differently, then drop the is_c45 check in phy_device_create().
> 
> This is a preparation patch to replace the is_c45 boolean with an enum
> which will indicate how the PHY is accessed (by c22, c45 or
> c45-over-c22).
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

