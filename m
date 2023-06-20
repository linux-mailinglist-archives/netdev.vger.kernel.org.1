Return-Path: <netdev+bounces-12288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A1C736FC9
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4182812AE
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99190156FC;
	Tue, 20 Jun 2023 15:06:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88173171CE
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:06:48 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB88C1A5;
	Tue, 20 Jun 2023 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TF58PbEnutisgyOb8/ZMr1H0VJK22Rp1e0KXoeR8sbQ=; b=AbGUggnkPexptF8+XjIwEZckzf
	BgsNsc/iE4pv7q/HfY5k4nTJxSvb9YlklOaJcWcLIaKLRVVGa2uWg7X6wy9U53yt3qdzA52ZfY9Cc
	dMFYVWMAlfABEeCeREmsqSUXINQ41FaJb+lk2GphICwho1kL+t5xK1KalKDsQKrZ05cQSp33ipoUi
	hpN0N+0zHVJrT7Jb0/hXoxcgLRO3fkP5IJQ3Yy7BKxK92p0Tw7XmpUvrG1uXv7c4FuLg9atuM8I0w
	GJ/+T0mnzAGQa3tfJ9xrmU89XAoWIH1ORPftYbSIywJzv5EKpSXXksw44QidGGHp/WMBVhwOiUEJn
	1NUjvvwA==;
Received: from [177.94.78.149] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1qBcwD-000lqI-AB; Tue, 20 Jun 2023 17:06:33 +0200
Message-ID: <3d9822ba-e692-e779-3ecb-bb284fa2a733@igalia.com>
Date: Tue, 20 Jun 2023 12:05:21 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] igc: Ignore AER reset when device is suspended
Content-Language: en-US
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com
Cc: linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20230620123636.1854690-1-kai.heng.feng@canonical.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230620123636.1854690-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/06/2023 14:36, Kai-Heng Feng wrote:
> [...]
> So avoid resetting the device if it's not resumed. Once the device is
> fully resumed, the device can work normally.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216850
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index fa764190f270..6a46f886ff43 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6962,6 +6962,9 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct igc_adapter *adapter = netdev_priv(netdev);
>  
> +	if (!pci_is_enabled(pdev))
> +		return 0;
> +
>  	netif_device_detach(netdev);
>  
>  	if (state == pci_channel_io_perm_failure)

Makes perfect sense to me, based on the days I've worked a lot with PCI
resets and whatnot heh

Feel free to add:
Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>


Cheers!

