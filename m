Return-Path: <netdev+bounces-17970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21768753E23
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53F32820E1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F02134DC;
	Fri, 14 Jul 2023 14:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF713715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 14:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F67C433C8;
	Fri, 14 Jul 2023 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689346488;
	bh=ZH/581wIsvRkjbT1Km2WPpK9yxOv+wJEG0gq+KRNxmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pcmyzOgVvkq/IxwsTWZTza8vFkLmG5W/a9dZ9FgjbnfWJ7S6yTx7gJZ3kI7vu1vLi
	 Bqaqf5q6cz69MjQEi0UvzrSdIltmkWwyyYOOtRLZiCuxTl1agCBk0vN7OGtRVrYwLZ
	 sJK5Ke3IikttOGmJomu3a9F1zmWL24NVy9WGCTwBjtsmssnEZ8BwJboKSHc4ucEWIe
	 2AovQVoXJmCD/WKCP6T730m1rrOrto0Fhq0DidlFamqKZRvQfqDU2MSxpr/SQaQ91j
	 /mruCsdztAW6pP1z9FUw2fvRt663SNxsGnCi6rUJsKeEZ5DvKcLL/WgcaK4gIXzEK1
	 8zcDi3f1H3biA==
Date: Fri, 14 Jul 2023 09:54:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	linux-pci@vger.kernel.org,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] igc: Ignore AER reset when device is suspended
Message-ID: <20230714145445.GA354014@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714050541.2765246-1-kai.heng.feng@canonical.com>

On Fri, Jul 14, 2023 at 01:05:41PM +0800, Kai-Heng Feng wrote:
> When a system that connects to a Thunderbolt dock equipped with I225,
> like HP Thunderbolt Dock G4, I225 stops working after S3 resume:
> ...

> The issue is that the PTM requests are sending before driver resumes the
> device. Since the issue can also be observed on Windows, it's quite
> likely a firmware/hardware limitation.

Does this mean we didn't disable PTM correctly on suspend?  Or is the
device defective and sending PTM requests even though PTM is disabled?

If the latter, I vote for a quirk that just disables PTM completely
for this device.

This check in .error_detected() looks out of place to me because
there's no connection between AER and PTM, there's no connection
between PTM and the device being enabled, and the connection between
the device being enabled and being fully resumed is a little tenuous.

If we must do it this way, maybe add a comment about *why* we're
checking pci_is_enabled().  Otherwise this will be copied to other
drivers that don't need it.

> So avoid resetting the device if it's not resumed. Once the device is
> fully resumed, the device can work normally.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216850
> Reviewed-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> ---
> v2:
>  - Fix typo.
>  - Mention the product name.
> 
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 9f93f0f4f752..8c36bbe5e428 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7115,6 +7115,9 @@ static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
>  	struct net_device *netdev = pci_get_drvdata(pdev);
>  	struct igc_adapter *adapter = netdev_priv(netdev);
>  
> +	if (!pci_is_enabled(pdev))
> +		return 0;
> +
>  	netif_device_detach(netdev);
>  
>  	if (state == pci_channel_io_perm_failure)
> -- 
> 2.34.1
> 

