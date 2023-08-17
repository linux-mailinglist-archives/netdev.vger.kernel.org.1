Return-Path: <netdev+bounces-28342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9D77F185
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D144A281DE6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82534D52B;
	Thu, 17 Aug 2023 07:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897FD300
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C86C433C7;
	Thu, 17 Aug 2023 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692258803;
	bh=wLHcMFA3CIUc34poTbaEPFtVB7xpSezsHK+CzDZ6KY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dadzYAOhzo1wbnVfqCoHf57M14d+DoVLqMEdy000bu4gp+JY4fxy18AcxA3p4JAXP
	 bnX5zis0KIZZBFb5gByWYK1ZJVkde1SFJKIeoWdCGxV+PoKl8EjqxnLGrZef0FowOw
	 2IJkbq/KAO/+9buGJz4sLiAENcNa1Mtc8LhTxfF97mDG3SsGm2ikav7fg0MzQTPwop
	 SprPN1br6Lfmdlb+1083hdZ1Rth86jQLqP+Y8vVBU8amwfPJ8QFbN2EE+KhlGjgcso
	 4y6q0JvrfyZA7LPf0/48oWRgDhqDrhstgnwdvPVE5lxOfSqzrCP2XErOxtvzP5vECw
	 pVl5c/b4IQqbQ==
Date: Thu, 17 Aug 2023 09:53:18 +0200
From: Simon Horman <horms@kernel.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	shannon.nelson@amd.com, liwei391@huawei.com
Subject: Re: [PATCH v2 net-next] pds_core: remove redundant pci_clear_master()
Message-ID: <ZN3R7mujAOOEFwbS@vergenet.net>
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

Reviewed-by: Simon Horman <horms@kernel.org>


