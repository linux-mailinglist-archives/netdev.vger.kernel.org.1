Return-Path: <netdev+bounces-28348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D0A77F1C5
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E071C212EF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 08:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63EDDDD;
	Thu, 17 Aug 2023 08:06:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC401D52E
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D1FC433C7;
	Thu, 17 Aug 2023 08:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692259561;
	bh=uGDttfdyb+662HTdW8Iu4K20oVfPDLGyo1IGJrG3GK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Guooke14U746i/SCAOA3A/jwiTEMbCcJZYAMwFBCUR0Mb5PwK2blFuaj6ksZk/QY1
	 YoWuCfmqk6kUKRGidoOCvHwo28MxGg0iPU5+CmhgSP6mgeTwE5TlYYNcPoJLGlv6Fo
	 rrBy7Yug3ZMhkQS8qVoCwtcESMm8TzimtwLZpOqOLvAhjkizaff/zcaWbzLJU8hypu
	 Us/0BPl0NxxIH/PlFo+3IrVY7GRm8cN9e/j+F6ny/We92cfkyMukYqc7lhovOInY3s
	 vNB4PTPFK5SV25vzGxRJnlacsC0BfgG/DUgbZQJYbz2FHs4ajXJwQFmQCuharqCbXU
	 a3rekaSIMGn0A==
Date: Thu, 17 Aug 2023 11:05:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, shannon.nelson@amd.com,
	liwei391@huawei.com
Subject: Re: [PATCH v2 net-next] pds_core: remove redundant pci_clear_master()
Message-ID: <20230817080557.GG22185@unreal>
References: <20230817025709.2023553-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817025709.2023553-1-liaoyu15@huawei.com>

On Thu, Aug 17, 2023 at 10:57:09AM +0800, Yu Liao wrote:
> do_pci_disable_device() disable PCI bus-mastering as following:
> static void do_pci_disable_device(struct pci_dev *dev)
> {
> 		u16 pci_command;
> 
> 		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> 		if (pci_command & PCI_COMMAND_MASTER) {
> 				pci_command &= ~PCI_COMMAND_MASTER;
> 				pci_write_config_word(dev, PCI_COMMAND, pci_command);
> 		}
> 
> 		pcibios_disable_device(dev);
> }
> And pci_disable_device() sets dev->is_busmaster to 0.
> 
> pci_enable_device() is called only once before calling to
> pci_disable_device() and such pci_clear_master() is not needed. So remove
> redundant pci_clear_master().
> 
> Also rename goto label 'err_out_clear_master' to 'err_out_disable_device'.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
> v1 -> v2:
> - add explanation why pci_disable_device() disables PCI bus-mastering
> - rename goto label 'err_out_clear_master' to 'err_out_disable_device' 
> ---
>  drivers/net/ethernet/amd/pds_core/main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

