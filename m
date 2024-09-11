Return-Path: <netdev+bounces-127355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED5F9752E7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4883280D93
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73D1190047;
	Wed, 11 Sep 2024 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGQohbQ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED218A6B9;
	Wed, 11 Sep 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059172; cv=none; b=l818/MnfeaRMCC2QGH2qJcVeK/mpVy1rxEJvG7ga97vX41Gu1/yczvrYYsIsPlZ2QfC7HVpQLiCa9/b1YZ1MKx8sNEWqUgKTAPjGkzIZVfGr7/LiPyL/P0cFwzYi+M7DLEyQbimPRh+zGPbaMhhUXwJrbrKIucxCw4FhPW1yzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059172; c=relaxed/simple;
	bh=8pc6zUftTePnKsFif7HOo4mBe2dPhXToHtJ4JpuoYHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBkLCbwco5t9QP+zGRuwjMyjDwmpPvxqKREAmhFkNyE6p7XD7Hw4EAf/uRBsZmNq7M4QuajjfywCPR4qpeZAzLnaBvR8Q9R/mHWwOMj2Sq6Lf+s+Cp4o8KVU/x30UKLI6VG5sfvDXxybj81/pvbhKzHWB3KcgjVwHDVKeZYRh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGQohbQ8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so172518866b.1;
        Wed, 11 Sep 2024 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726059169; x=1726663969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsMLBhML6sz1HDYJ3QdvJLhl/K9b5dz0pvEo/+gRrfk=;
        b=QGQohbQ8FxSbUWjLssRt5I01gyWDxTosCKWIF1AjAJJf9Yhrw26j0RPkOGrr+yAmFc
         YFbthhcWXXE6ezCGxdA+AysD7/n95vYaY7N009CU08eTEHp9+FebTIPDvAWQI4Yerens
         Xnahm6Oal2dqy14aIsm6/+rcLAGoZWpB1s53x1XmQbVxD4mGn+Gq1HGiMSoqRIZ6PKKh
         V0qp1eGGrkORM1zhYCKf2MMxhw0EFHkQl17J4VI8H6/5aQzOJ7B5FJLX/rd0Ijk+qVJH
         uBKGetAfNLwRrI3lKyWaBxVV9wf+X0JwVTfWtSTsLR4LvpJQhkaEaQCPYq/OvfXa1zsn
         zMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726059169; x=1726663969;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsMLBhML6sz1HDYJ3QdvJLhl/K9b5dz0pvEo/+gRrfk=;
        b=GWgr3jTz93NxiNUcoLr0G5Ytb3FZzg/6u7dJSq1FJVK0ppFupb1peoubJaZb+gqDgZ
         F9qI8VbdQvwW/M/nvmRDpLdx/h8Gp6jcpuSAH5pECwoUA7OBorM2Zw4JEywKhImlEXM4
         2fS9WMYGCPts17pzLO6ivNyXQS/d3jMc3SOTyqfgSYfaMaTKAC7DsJioDzX25xz/J6Ol
         qO1fqv5wxQ6NSvIk9IkdJhPJ792/as3ZEFifj+3NEuofAiQjmAlRKncp4BC/fYmH9DFt
         QFgb3z79yUx//tsC23Dn7+WTpVn3S2BOIV4c/86kHgnNz+M369AFU4K8KMwKSTEF6ROC
         Xyjw==
X-Forwarded-Encrypted: i=1; AJvYcCUQFp9leYJQYv1S1UlRGiTZDY1sRfQLrfaIbWeUGbSTnYN8PHvmenJKv9gen7P5hlzhXwzViy+P@vger.kernel.org, AJvYcCXGMadvxzDAZGWlsDaVl4h+nIyutMF9OkgG9JdD3Po4KX4HIVm9XXOqnPvV5gnPN/SBytYVl1ar3R5zMKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjSG034B/EePKyyEIbDaLjY8/VWBMhKn9v+1tDgEFLmoVFYCJe
	ZADOSszyd4jxm8+14Xq7UEyeuBbTabZodr/+AMs+A2fLLBM5rRz2
X-Google-Smtp-Source: AGHT+IHq45tkenupRA9vDqE9xZTkLm7PWdrsRVDd3A8nGPjBqlteoLoFUEErYLDmFsg9bYCexZQaxQ==
X-Received: by 2002:a17:907:2ce1:b0:a8d:41d8:14ad with SMTP id a640c23a62f3a-a8ffae3fd9fmr520510766b.29.1726059168611;
        Wed, 11 Sep 2024 05:52:48 -0700 (PDT)
Received: from localhost ([149.199.80.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835551sm613395766b.24.2024.09.11.05.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 05:52:48 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:52:46 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: jonathan.s.cooper@amd.com
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: Add X4 PF support
Message-ID: <20240911125246.GA65878@gmail.com>
Mail-Followup-To: jonathan.s.cooper@amd.com,
	Edward Cree <ecree.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20240910153014.12803-1-jonathan.s.cooper@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910153014.12803-1-jonathan.s.cooper@amd.com>

On Tue, Sep 10, 2024 at 04:30:13PM +0100, jonathan.s.cooper@amd.com wrote:
> From: Jonathan Cooper <jonathan.s.cooper@amd.com>
> 
> Add X4 series. Most functionality is the same as previous
> EF10 nics but enough is different to warrant a new nic type struct
> and revision; for example legacy interrupts and SRIOV are
> not supported.
> 
> Most removed features will be re-added later as new implementations.
> 
> Signed-off-by: Jonathan Cooper <jonathan.s.cooper@amd.com>

Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/ef10.c       | 127 ++++++++++++++++++++++++++
>  drivers/net/ethernet/sfc/efx.c        |   4 +
>  drivers/net/ethernet/sfc/nic.h        |   2 +
>  drivers/net/ethernet/sfc/nic_common.h |   1 +
>  4 files changed, 134 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 7d69302ffa0a..de131fc5fa0b 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -4302,3 +4302,130 @@ const struct efx_nic_type efx_hunt_a0_nic_type = {
>  	.sensor_event = efx_mcdi_sensor_event,
>  	.rx_recycle_ring_size = efx_ef10_recycle_ring_size,
>  };
> +
> +const struct efx_nic_type efx_x4_nic_type = {
> +	.is_vf = false,
> +	.mem_bar = efx_ef10_pf_mem_bar,
> +	.mem_map_size = efx_ef10_mem_map_size,
> +	.probe = efx_ef10_probe_pf,
> +	.remove = efx_ef10_remove,
> +	.dimension_resources = efx_ef10_dimension_resources,
> +	.init = efx_ef10_init_nic,
> +	.fini = efx_ef10_fini_nic,
> +	.map_reset_reason = efx_ef10_map_reset_reason,
> +	.map_reset_flags = efx_ef10_map_reset_flags,
> +	.reset = efx_ef10_reset,
> +	.probe_port = efx_mcdi_port_probe,
> +	.remove_port = efx_mcdi_port_remove,
> +	.fini_dmaq = efx_fini_dmaq,
> +	.prepare_flr = efx_ef10_prepare_flr,
> +	.finish_flr = efx_port_dummy_op_void,
> +	.describe_stats = efx_ef10_describe_stats,
> +	.update_stats = efx_ef10_update_stats_pf,
> +	.start_stats = efx_mcdi_mac_start_stats,
> +	.pull_stats = efx_mcdi_mac_pull_stats,
> +	.stop_stats = efx_mcdi_mac_stop_stats,
> +	.push_irq_moderation = efx_ef10_push_irq_moderation,
> +	.reconfigure_mac = efx_ef10_mac_reconfigure,
> +	.check_mac_fault = efx_mcdi_mac_check_fault,
> +	.reconfigure_port = efx_mcdi_port_reconfigure,
> +	.get_wol = efx_ef10_get_wol,
> +	.set_wol = efx_ef10_set_wol,
> +	.resume_wol = efx_port_dummy_op_void,
> +	.get_fec_stats = efx_ef10_get_fec_stats,
> +	.test_chip = efx_ef10_test_chip,
> +	.test_nvram = efx_mcdi_nvram_test_all,
> +	.mcdi_request = efx_ef10_mcdi_request,
> +	.mcdi_poll_response = efx_ef10_mcdi_poll_response,
> +	.mcdi_read_response = efx_ef10_mcdi_read_response,
> +	.mcdi_poll_reboot = efx_ef10_mcdi_poll_reboot,
> +	.mcdi_reboot_detected = efx_ef10_mcdi_reboot_detected,
> +	.irq_enable_master = efx_port_dummy_op_void,
> +	.irq_test_generate = efx_ef10_irq_test_generate,
> +	.irq_disable_non_ev = efx_port_dummy_op_void,
> +	.irq_handle_msi = efx_ef10_msi_interrupt,
> +	.tx_probe = efx_ef10_tx_probe,
> +	.tx_init = efx_ef10_tx_init,
> +	.tx_write = efx_ef10_tx_write,
> +	.tx_limit_len = efx_ef10_tx_limit_len,
> +	.tx_enqueue = __efx_enqueue_skb,
> +	.rx_push_rss_config = efx_mcdi_pf_rx_push_rss_config,
> +	.rx_pull_rss_config = efx_mcdi_rx_pull_rss_config,
> +	.rx_push_rss_context_config = efx_mcdi_rx_push_rss_context_config,
> +	.rx_pull_rss_context_config = efx_mcdi_rx_pull_rss_context_config,
> +	.rx_restore_rss_contexts = efx_mcdi_rx_restore_rss_contexts,
> +	.rx_probe = efx_mcdi_rx_probe,
> +	.rx_init = efx_mcdi_rx_init,
> +	.rx_remove = efx_mcdi_rx_remove,
> +	.rx_write = efx_ef10_rx_write,
> +	.rx_defer_refill = efx_ef10_rx_defer_refill,
> +	.rx_packet = __efx_rx_packet,
> +	.ev_probe = efx_mcdi_ev_probe,
> +	.ev_init = efx_ef10_ev_init,
> +	.ev_fini = efx_mcdi_ev_fini,
> +	.ev_remove = efx_mcdi_ev_remove,
> +	.ev_process = efx_ef10_ev_process,
> +	.ev_read_ack = efx_ef10_ev_read_ack,
> +	.ev_test_generate = efx_ef10_ev_test_generate,
> +	.filter_table_probe = efx_ef10_filter_table_probe,
> +	.filter_table_restore = efx_mcdi_filter_table_restore,
> +	.filter_table_remove = efx_ef10_filter_table_remove,
> +	.filter_insert = efx_mcdi_filter_insert,
> +	.filter_remove_safe = efx_mcdi_filter_remove_safe,
> +	.filter_get_safe = efx_mcdi_filter_get_safe,
> +	.filter_clear_rx = efx_mcdi_filter_clear_rx,
> +	.filter_count_rx_used = efx_mcdi_filter_count_rx_used,
> +	.filter_get_rx_id_limit = efx_mcdi_filter_get_rx_id_limit,
> +	.filter_get_rx_ids = efx_mcdi_filter_get_rx_ids,
> +#ifdef CONFIG_RFS_ACCEL
> +	.filter_rfs_expire_one = efx_mcdi_filter_rfs_expire_one,
> +#endif
> +#ifdef CONFIG_SFC_MTD
> +	.mtd_probe = efx_ef10_mtd_probe,
> +	.mtd_rename = efx_mcdi_mtd_rename,
> +	.mtd_read = efx_mcdi_mtd_read,
> +	.mtd_erase = efx_mcdi_mtd_erase,
> +	.mtd_write = efx_mcdi_mtd_write,
> +	.mtd_sync = efx_mcdi_mtd_sync,
> +#endif
> +	.ptp_write_host_time = efx_ef10_ptp_write_host_time,
> +	.ptp_set_ts_sync_events = efx_ef10_ptp_set_ts_sync_events,
> +	.ptp_set_ts_config = efx_ef10_ptp_set_ts_config,
> +	.vlan_rx_add_vid = efx_ef10_vlan_rx_add_vid,
> +	.vlan_rx_kill_vid = efx_ef10_vlan_rx_kill_vid,
> +	.udp_tnl_push_ports = efx_ef10_udp_tnl_push_ports,
> +	.udp_tnl_has_port = efx_ef10_udp_tnl_has_port,
> +#ifdef CONFIG_SFC_SRIOV
> +	/* currently set to the VF versions of these functions
> +	 * because SRIOV will be reimplemented later.
> +	 */
> +	.vswitching_probe = efx_ef10_vswitching_probe_vf,
> +	.vswitching_restore = efx_ef10_vswitching_restore_vf,
> +	.vswitching_remove = efx_ef10_vswitching_remove_vf,
> +#endif
> +	.get_mac_address = efx_ef10_get_mac_address_pf,
> +	.set_mac_address = efx_ef10_set_mac_address,
> +	.tso_versions = efx_ef10_tso_versions,
> +
> +	.get_phys_port_id = efx_ef10_get_phys_port_id,
> +	.revision = EFX_REV_X4,
> +	.max_dma_mask = DMA_BIT_MASK(ESF_DZ_TX_KER_BUF_ADDR_WIDTH),
> +	.rx_prefix_size = ES_DZ_RX_PREFIX_SIZE,
> +	.rx_hash_offset = ES_DZ_RX_PREFIX_HASH_OFST,
> +	.rx_ts_offset = ES_DZ_RX_PREFIX_TSTAMP_OFST,
> +	.can_rx_scatter = true,
> +	.always_rx_scatter = true,
> +	.option_descriptors = true,
> +	.min_interrupt_mode = EFX_INT_MODE_MSIX,
> +	.timer_period_max = 1 << ERF_DD_EVQ_IND_TIMER_VAL_WIDTH,
> +	.offload_features = EF10_OFFLOAD_FEATURES,
> +	.mcdi_max_ver = 2,
> +	.max_rx_ip_filters = EFX_MCDI_FILTER_TBL_ROWS,
> +	.hwtstamp_filters = 1 << HWTSTAMP_FILTER_NONE |
> +			    1 << HWTSTAMP_FILTER_ALL,
> +	.check_caps = ef10_check_caps,
> +	.print_additional_fwver = efx_ef10_print_additional_fwver,
> +	.sensor_event = efx_mcdi_sensor_event,
> +	.rx_recycle_ring_size = efx_ef10_recycle_ring_size,
> +};
> +
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 6f1a01ded7d4..36b3b57e2055 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -821,6 +821,10 @@ static const struct pci_device_id efx_pci_table[] = {
>  	 .driver_data = (unsigned long) &efx_hunt_a0_nic_type},
>  	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x1b03),  /* SFC9250 VF */
>  	 .driver_data = (unsigned long) &efx_hunt_a0_vf_nic_type},
> +	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x0c03),  /* X4 PF (FF/LL) */
> +	 .driver_data = (unsigned long)&efx_x4_nic_type},
> +	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x2c03),  /* X4 PF (FF only) */
> +	 .driver_data = (unsigned long)&efx_x4_nic_type},
>  	{0}			/* end of list */
>  };
>  
> diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
> index 1db64fc6e909..9fa5c4c713ab 100644
> --- a/drivers/net/ethernet/sfc/nic.h
> +++ b/drivers/net/ethernet/sfc/nic.h
> @@ -211,4 +211,6 @@ int efx_ef10_tx_tso_desc(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
>  extern const struct efx_nic_type efx_hunt_a0_nic_type;
>  extern const struct efx_nic_type efx_hunt_a0_vf_nic_type;
>  
> +extern const struct efx_nic_type efx_x4_nic_type;
> +
>  #endif /* EFX_NIC_H */
> diff --git a/drivers/net/ethernet/sfc/nic_common.h b/drivers/net/ethernet/sfc/nic_common.h
> index 466df5348b29..7ec4ac7b7ff5 100644
> --- a/drivers/net/ethernet/sfc/nic_common.h
> +++ b/drivers/net/ethernet/sfc/nic_common.h
> @@ -21,6 +21,7 @@ enum {
>  	 */
>  	EFX_REV_HUNT_A0 = 4,
>  	EFX_REV_EF100 = 5,
> +	EFX_REV_X4 = 6,
>  };
>  
>  static inline int efx_nic_rev(struct efx_nic *efx)
> -- 
> 2.17.1
> 

