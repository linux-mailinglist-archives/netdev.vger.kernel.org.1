Return-Path: <netdev+bounces-159980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500FEA17949
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 09:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA643A8A73
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 08:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015261714A5;
	Tue, 21 Jan 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2XumyDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DC8F6B
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737448352; cv=none; b=XvvH10Icvuor0y+eqSTxOCofc0TOzStgSilqxVG/OrJB998bOncmBCORu9MhA4sZbnDOz37oxyQGjZhfyFHnljmF3lGnobn0+IUxZWjOIAqugbFP0IqNFC9Nj5o/HdKEMUStQXnhyom6KaVsJuCCTthxHaYYWZ1NP6EruDFbxxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737448352; c=relaxed/simple;
	bh=Cs7xzi8V8pM4u3lBQDG/pLwqOEMNGG8CKHafAUvqO3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDhzSjNnyWJ1v/VISVp76v+5Xe7ranoY3d/+B1Ek+Sl7zMJh0uor4u3TOzwG9QJUHg6XN3/JasPUBrcTeRZk2xJsa/4h83F0Nu7wX3lsjQsZEk9i1Et3csct37yZsM9EDSWgD5XE4dzbUFfCKTWaex7kJG1lW78TvZB28hFfQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y2XumyDg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e3621518so2417644f8f.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 00:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737448349; x=1738053149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESpTe+lri75LT42+cryrAzTBPeSJJFWMogc1OuFX7rw=;
        b=Y2XumyDg4M97F2ATTxHHQgDIOtRaA+xoACyMaOaBXd0x5BNzaYr1yf6IZB99PbGctN
         uOsLGwyDJF4PJ/q5jr56Bb3s+YcEfm1Z39y/lZcyd3jY+CCQentWn6szAptxytTcyup2
         xuuIwhIB1ofQghRqfMv1LSJmsYXjwy6jd2Z2QN12phs73A9c23lCfFmGu9cagurykOqr
         2+D4BRX/tEmSCukAtHj1eqHJ3NTfTcsNSjxTlRJ4KxK38DrstNJ5rF0eEdyONYbmmp96
         /TRZtJ06/oAIqCG7GTnVSAOQ+cv2h4KaDLPuXm4ITKOp+Xskjy9TIGXyq+THF981zRHD
         Gw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737448349; x=1738053149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESpTe+lri75LT42+cryrAzTBPeSJJFWMogc1OuFX7rw=;
        b=pUpsxizVKBrK7GFWGXZJd1EhH21X+nJ5Sjs6SfNwWwGLpipjLz1Y54ATgrUw0g/nIK
         6pz7FKCO1PtdXARErj4r8+myK50O+QIvzbdkncpmMQ9CYqR4jWVOFPFIkJEJRi5otczk
         1hapmDVFYD3klfS+Qy+jMFOeUn/MuGVVvqxcBY/Sg8tCk5lqGZipPLQ+sE0lOgUbmziP
         fiMoMbp75Ut7HcdcshcxuG/YN0NpXly+VtFPunZmTJe+wOO1le6mDsd+52IY/T5azoH6
         fDWDKyA+Vso3e6fCEvGOQEAk2kiIztzKBpMoAwYEcXoghGLSxAtMRIgyNWH7TtqLpVVN
         IC4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUi1SBTYYXLl3iBfKw1D8xfsEUpgc4NrORg6801WBuUfyKmyEhtdA2I2eBdJYV1rcJTdmCxqe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpLK0PokPUoQEQxHjDTpPcrkSt5GL3g3JUtw5gZteGZ0TB19D
	OUK2PdlIiaORpurMQtb5ApQVVCYidoxJRJf3Hy7JaXKnFYgFkA2Axbbnp72dapE=
X-Gm-Gg: ASbGncvZiaJt5IW0muilHLO6xN/hQXqXET38lCsnzkV1bARU/NZXQ6h4GAOn5/wm4+q
	aYheF/yodQqrVC974fpKTQM9B4dW4QnkaXtt+BULqXedUDjJfkLAACBdL6jAj3f1td/hQJcz8wm
	SxUpl8FIfXWNzgEeoHEtX/ZbxodYqXZuBKa0tzrvIaizAFsLibZrGzMiXACRcl+hr2wwjjYx142
	h8ia2HueHhm2zqUERHcf1Z9Uib0yV/4nK86pRottutvBmJ2OjfoS01AlX3S0zciA7YwQ+6Blnk=
X-Google-Smtp-Source: AGHT+IEctkZLGO5v7EGnnqCCXz5TRdxclObc3TuK+xOSavP0SmDfNbmZzxClJ3DHs1uYb7NYf/TQdQ==
X-Received: by 2002:a5d:6d02:0:b0:38a:88b8:97a9 with SMTP id ffacd0b85a97d-38bf5655197mr14382188f8f.2.1737448348597;
        Tue, 21 Jan 2025 00:32:28 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3282a63sm12803366f8f.96.2025.01.21.00.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 00:32:28 -0800 (PST)
Date: Tue, 21 Jan 2025 11:32:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	jdamato@fastly.com, Francois Romieu <romieu@fr.zoreil.com>,
	pcnet32@frontier.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, marcin.s.wojtas@gmail.com
Subject: Re: [PATCH net-next v2 06/11] net: protect NAPI enablement with
 netdev_lock()
Message-ID: <dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain>
References: <20250115035319.559603-1-kuba@kernel.org>
 <20250115035319.559603-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115035319.559603-7-kuba@kernel.org>

On Tue, Jan 14, 2025 at 07:53:14PM -0800, Jakub Kicinski wrote:
> Wrap napi_enable() / napi_disable() with netdev_lock().
> Provide the "already locked" flavor of the API.
> 
> iavf needs the usual adjustment. A number of drivers call
> napi_enable() under a spin lock, so they have to be modified
> to take netdev_lock() first, then spin lock then call
> napi_enable_locked().

You missed some.

drivers/net/ethernet/broadcom/tg3.c:7427 tg3_napi_enable() warn: sleeping in atomic context
drivers/net/ethernet/nvidia/forcedeth.c:5597 nv_open() warn: sleeping in atomic context
drivers/net/ethernet/realtek/8139too.c:1697 rtl8139_tx_timeout_task() warn: sleeping in atomic context
drivers/net/ethernet/sun/niu.c:6530 niu_reset_task() warn: sleeping in atomic context
drivers/net/ethernet/sun/niu.c:9944 niu_resume() warn: sleeping in atomic context
drivers/net/ethernet/via/via-rhine.c:1740 rhine_reset_task() warn: sleeping in atomic context
drivers/net/ethernet/via/via-rhine.c:2545 rhine_resume() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7603/mac.c:1483 mt7603_mac_watchdog_reset() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7615/pci.c:169 mt7615_pci_resume() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c:266 mt7615_mac_reset_work() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c:508 mt76x02_watchdog_reset() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt76x0/pci.c:288 mt76x0e_resume() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt76x2/pci.c:156 mt76x2e_resume() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1362 mt7915_mac_restart() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1575 mt7915_mac_reset_work() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7921/pci.c:528 mt7921_pci_resume() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c:86 mt7921e_mac_reset() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7925/pci.c:561 mt7925_pci_resume() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c:106 mt7925e_mac_reset() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1705 mt7996_mac_restart() warn: sleeping in atomic context
drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1967 mt7996_mac_reset_work() warn: sleeping in atomic context

The big one is the local_bh_disable() the mediatek driver.  Let me break
it down a bit more below.

regards,
dan carpenter

=========================================================
drivers/net/ethernet/broadcom/tg3.c:7427 tg3_napi_enable() warn: sleeping in atomic context
static void tg3_napi_enable(struct tg3 *tp)
{
	int txq_idx = 0, rxq_idx = 0;
	struct tg3_napi *tnapi;
	int i;

	for (i = 0; i < tp->irq_cnt; i++) {
		tnapi = &tp->napi[i];
---> 		napi_enable(&tnapi->napi);
		if (tnapi->tx_buffers) {
			netif_queue_set_napi(tp->dev, txq_idx,
					     NETDEV_QUEUE_TYPE_TX,
					     &tnapi->napi);
			txq_idx++;
		}
		if (tnapi->rx_rcb) {
			netif_queue_set_napi(tp->dev, rxq_idx,
					     NETDEV_QUEUE_TYPE_RX,
					     &tnapi->napi);
			rxq_idx++;
		}
	}
}

This is the trickiest one.  The spinlock is two steps away in
the tg3_full_lock().

tg3_reset_task() <- disables preempt
tg3_set_ringparam() <- disables preempt
tg3_set_pauseparam() <- disables preempt
tg3_self_test() <- disables preempt
tg3_change_mtu() <- disables preempt
tg3_resume() <- disables preempt
tg3_io_resume() <- disables preempt
-> tg3_netif_start()
   -> tg3_napi_enable()

=========================================================
drivers/net/ethernet/nvidia/forcedeth.c:5597 nv_open() warn: sleeping in atomic context
	spin_lock_irq(&np->lock);
        ^^^^^^^^^^^^^^^^^^^^^^^^
	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
	writel(0, base + NvRegMulticastAddrB);
	writel(NVREG_MCASTMASKA_NONE, base + NvRegMulticastMaskA);
	writel(NVREG_MCASTMASKB_NONE, base + NvRegMulticastMaskB);
	writel(NVREG_PFF_ALWAYS|NVREG_PFF_MYADDR, base + NvRegPacketFilterFlags);
	/* One manual link speed update: Interrupts are enabled, future link
	 * speed changes cause interrupts and are handled by nv_link_irq().
	 */
	readl(base + NvRegMIIStatus);
	writel(NVREG_MIISTAT_MASK_ALL, base + NvRegMIIStatus);

	/* set linkspeed to invalid value, thus force nv_update_linkspeed
	 * to init hw */
	np->linkspeed = 0;
	ret = nv_update_linkspeed(dev);
	nv_start_rxtx(dev);
	netif_start_queue(dev);
---> 	nv_napi_enable(dev);

	if (ret) {
		netif_carrier_on(dev);
	} else {
		netdev_info(dev, "no link during initialization\n");
		netif_carrier_off(dev);
	}
	if (oom)
		mod_timer(&np->oom_kick, jiffies + OOM_REFILL);

	/* start statistics timer */
	if (np->driver_data & (DEV_HAS_STATISTICS_V1|DEV_HAS_STATISTICS_V2|DEV_HAS_STATISTICS_V3))
		mod_timer(&np->stats_poll,
			round_jiffies(jiffies + STATS_INTERVAL));

	spin_unlock_irq(&np->lock);

	/* If the loopback feature was set while the device was down, make sure
	 * that it's set correctly now.
=========================================================
drivers/net/ethernet/realtek/8139too.c:1697 rtl8139_tx_timeout_task() warn: sleeping in atomic context
	spin_lock_bh(&tp->rx_lock);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
	/* Disable interrupts by clearing the interrupt mask. */
	RTL_W16 (IntrMask, 0x0000);

	/* Stop a shared interrupt from scavenging while we are. */
	spin_lock_irq(&tp->lock);
	rtl8139_tx_clear (tp);
	spin_unlock_irq(&tp->lock);

	/* ...and finally, reset everything */
---> 	napi_enable(&tp->napi);
	rtl8139_hw_start(dev);
	netif_wake_queue(dev);

	spin_unlock_bh(&tp->rx_lock);
}
=========================================================
drivers/net/ethernet/sun/niu.c:6530 niu_reset_task() warn: sleeping in atomic context
	spin_lock_irqsave(&np->lock, flags);
        ^^^^^^^^^^^^^^^^^^
	err = niu_init_hw(np);
	if (!err) {
		np->timer.expires = jiffies + HZ;
		add_timer(&np->timer);
---> 		niu_netif_start(np);
	}

	spin_unlock_irqrestore(&np->lock, flags);
=========================================================
drivers/net/ethernet/sun/niu.c:9944 niu_resume() warn: sleeping in atomic context
	spin_lock_irqsave(&np->lock, flags);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
	err = niu_init_hw(np);
	if (!err) {
		np->timer.expires = jiffies + HZ;
		add_timer(&np->timer);
---> 		niu_netif_start(np);
	}

	spin_unlock_irqrestore(&np->lock, flags);

	return err;
}
=========================================================
drivers/net/ethernet/via/via-rhine.c:1740 rhine_reset_task() warn: sleeping in atomic context
	spin_lock_bh(&rp->lock);
        ^^^^^^^^^^^^^^^^^^^^^^^
	/* clear all descriptors */
	free_tbufs(dev);
	alloc_tbufs(dev);

	rhine_reset_rbufs(rp);

	/* Reinitialize the hardware. */
	rhine_chip_reset(dev);
---> 	init_registers(dev);

	spin_unlock_bh(&rp->lock);

	netif_trans_update(dev); /* prevent tx timeout */
	dev->stats.tx_errors++;
	netif_wake_queue(dev);

out_unlock:
	mutex_unlock(&rp->task_lock);
}
=========================================================
drivers/net/ethernet/via/via-rhine.c:2545 rhine_resume() warn: sleeping in atomic context
static int rhine_resume(struct device *device)
{
	struct net_device *dev = dev_get_drvdata(device);
	struct rhine_private *rp = netdev_priv(dev);

	if (!netif_running(dev))
		return 0;

	enable_mmio(rp->pioaddr, rp->quirks);
	rhine_power_init(dev);
	free_tbufs(dev);
	alloc_tbufs(dev);
	rhine_reset_rbufs(rp);
	rhine_task_enable(rp);
	spin_lock_bh(&rp->lock);
        ^^^^^^^^^^^^^^^^^^^^^^
---> 	init_registers(dev);
	spin_unlock_bh(&rp->lock);

	netif_device_attach(dev);

	return 0;
}
=========================================================
drivers/net/wireless/mediatek/mt76/mt7603/mac.c:1483 mt7603_mac_watchdog_reset() warn: sleeping in atomic context
	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
	mt7603_beacon_set_timer(dev, -1, beacon_int);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
---> 	napi_enable(&dev->mt76.tx_napi);
	napi_schedule(&dev->mt76.tx_napi);

	napi_enable(&dev->mt76.napi[0]);
	napi_schedule(&dev->mt76.napi[0]);

	napi_enable(&dev->mt76.napi[1]);
	napi_schedule(&dev->mt76.napi[1]);
	local_bh_enable();

	ieee80211_wake_queues(dev->mt76.hw);
	mt76_txq_schedule_all(&dev->mphy);
}
=========================================================
drivers/net/wireless/mediatek/mt76/mt7615/pci.c:169 mt7615_pci_resume() warn: sleeping in atomic context
	if (pdma_reset)
		dev_err(mdev->dev, "PDMA engine must be reinitialized\n");

	mt76_worker_enable(&mdev->tx_worker);
	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(mdev, i) {
---> 		napi_enable(&mdev->napi[i]);
		napi_schedule(&mdev->napi[i]);
	}
	napi_enable(&mdev->tx_napi);
	napi_schedule(&mdev->tx_napi);
	local_bh_enable();

	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
	    mt7615_firmware_offload(dev))
		err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);

	return err;
}
=========================================================
drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c:266 mt7615_mac_reset_work() warn: sleeping in atomic context
	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
	clear_bit(MT76_RESET, &dev->mphy.state);
	if (phy2)
		clear_bit(MT76_RESET, &phy2->mt76->state);

	mt76_worker_enable(&dev->mt76.tx_worker);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^^
---> 	napi_enable(&dev->mt76.tx_napi);
	napi_schedule(&dev->mt76.tx_napi);

	mt76_for_each_q_rx(&dev->mt76, i) {
		napi_enable(&dev->mt76.napi[i]);
		napi_schedule(&dev->mt76.napi[i]);
	}
	local_bh_enable();

	ieee80211_wake_queues(mt76_hw(dev));
	if (ext_phy)
		ieee80211_wake_queues(ext_phy->hw);

	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_RESET_DONE);
	mt7615_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);

	mt7615_update_beacons(dev);

	mt7615_mutex_release(dev);

=========================================================
drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c:508 mt76x02_watchdog_reset() warn: sleeping in atomic context
	mutex_unlock(&dev->mt76.mutex);

	clear_bit(MT76_RESET, &dev->mphy.state);

	mt76_worker_enable(&dev->mt76.tx_worker);
	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^
---> 	napi_enable(&dev->mt76.tx_napi);
	napi_schedule(&dev->mt76.tx_napi);

	mt76_for_each_q_rx(&dev->mt76, i) {
		napi_enable(&dev->mt76.napi[i]);
		napi_schedule(&dev->mt76.napi[i]);
	}
	local_bh_enable();

	if (restart) {
		set_bit(MT76_RESTART, &dev->mphy.state);
		mt76x02_mcu_function_select(dev, Q_SELECT, 1);
		ieee80211_restart_hw(dev->mt76.hw);
	} else {
		ieee80211_wake_queues(dev->mt76.hw);
		mt76_txq_schedule_all(&dev->mphy);
	}
}
=========================================================
drivers/net/wireless/mediatek/mt76/mt76x0/pci.c:288 mt76x0e_resume() warn: sleeping in atomic context
	err = pci_set_power_state(pdev, PCI_D0);
	if (err)
		return err;

	pci_restore_state(pdev);

	mt76_worker_enable(&mdev->tx_worker);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(mdev, i) {
		mt76_queue_rx_reset(dev, i);
---> 		napi_enable(&mdev->napi[i]);
		napi_schedule(&mdev->napi[i]);
	}

	napi_enable(&mdev->tx_napi);
	napi_schedule(&mdev->tx_napi);
	local_bh_enable();

	return mt76x0e_init_hardware(dev, true);
}
=========================================================
drivers/net/wireless/mediatek/mt76/mt76x2/pci.c:156 mt76x2e_resume() warn: sleeping in atomic context
static int __maybe_unused
mt76x2e_resume(struct pci_dev *pdev)
{
	struct mt76_dev *mdev = pci_get_drvdata(pdev);
	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
	int i, err;

	err = pci_set_power_state(pdev, PCI_D0);
	if (err)
		return err;

	pci_restore_state(pdev);

	mt76_worker_enable(&mdev->tx_worker);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(mdev, i) {
---> 		napi_enable(&mdev->napi[i]);
		napi_schedule(&mdev->napi[i]);
	}
	napi_enable(&mdev->tx_napi);
	napi_schedule(&mdev->tx_napi);
	local_bh_enable();

	return mt76x2_resume_device(dev);
}
=========================================================
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1362 mt7915_mac_restart() warn: sleeping in atomic context
	/* token reinit */
	mt76_connac2_tx_token_put(&dev->mt76);
	idr_init(&dev->mt76.token);

	mt7915_dma_reset(dev, true);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(mdev, i) {
		if (mdev->q_rx[i].ndesc) {
---> 			napi_enable(&dev->mt76.napi[i]);
			napi_schedule(&dev->mt76.napi[i]);
		}
	}
	local_bh_enable();
	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);

	mt76_wr(dev, MT_INT_MASK_CSR, dev->mt76.mmio.irqmask);
	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);

	if (dev->hif2) {
		mt76_wr(dev, MT_INT1_MASK_CSR, dev->mt76.mmio.irqmask);
		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
	}
	if (dev_is_pci(mdev->dev)) {
		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
		if (dev->hif2) {
			mt76_wr(dev, MT_PCIE_RECOG_ID,
				dev->hif2->index | MT_PCIE_RECOG_ID_SEM);
=========================================================
drivers/net/wireless/mediatek/mt76/mt7915/mac.c:1575 mt7915_mac_reset_work() warn: sleeping in atomic context
	/* enable DMA Tx/Rx and interrupt */
	mt7915_dma_start(dev, false, false);

	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
	clear_bit(MT76_RESET, &dev->mphy.state);
	if (phy2)
		clear_bit(MT76_RESET, &phy2->mt76->state);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(&dev->mt76, i) {
---> 		napi_enable(&dev->mt76.napi[i]);
		napi_schedule(&dev->mt76.napi[i]);
	}
	local_bh_enable();

	tasklet_schedule(&dev->mt76.irq_tasklet);

	mt76_worker_enable(&dev->mt76.tx_worker);

	local_bh_disable();
	napi_enable(&dev->mt76.tx_napi);
	napi_schedule(&dev->mt76.tx_napi);
	local_bh_enable();

	ieee80211_wake_queues(mt76_hw(dev));
	if (ext_phy)
		ieee80211_wake_queues(ext_phy->hw);

	mutex_unlock(&dev->mt76.mutex);
=========================================================
drivers/net/wireless/mediatek/mt76/mt7921/pci.c:528 mt7921_pci_resume() warn: sleeping in atomic context
	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);

	/* put dma enabled */
	mt76_set(dev, MT_WFDMA0_GLO_CFG,
		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);

	mt76_worker_enable(&mdev->tx_worker);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(mdev, i) {
---> 		napi_enable(&mdev->napi[i]);
		napi_schedule(&mdev->napi[i]);
	}
	napi_enable(&mdev->tx_napi);
	napi_schedule(&mdev->tx_napi);
	local_bh_enable();

	/* restore previous ds setting */
	if (!pm->ds_enable)
		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);

	err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);
	if (err < 0)
		goto failed;

	mt7921_regd_update(dev);
	err = mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_ON_LED);
failed:
	pm->suspended = false;
=========================================================
drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c:86 mt7921e_mac_reset() warn: sleeping in atomic context
	napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
	napi_disable(&dev->mt76.tx_napi);

	mt76_connac2_tx_token_put(&dev->mt76);
	idr_init(&dev->mt76.token);

	mt792x_wpdma_reset(dev, true);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(&dev->mt76, i) {
---> 		napi_enable(&dev->mt76.napi[i]);
		napi_schedule(&dev->mt76.napi[i]);
	}
	local_bh_enable();

	dev->fw_assert = false;
	clear_bit(MT76_MCU_RESET, &dev->mphy.state);

	mt76_wr(dev, dev->irq_map->host_irq_enable,
		dev->irq_map->tx.all_complete_mask |
		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);

	err = mt7921e_driver_own(dev);
	if (err)
		goto out;

	err = mt7921_run_firmware(dev);
	if (err)
		goto out;
=========================================================
drivers/net/wireless/mediatek/mt76/mt7925/pci.c:561 mt7925_pci_resume() warn: sleeping in atomic context
	mt76_set(dev, MT_MCU2HOST_SW_INT_ENA, MT_MCU_CMD_WAKE_RX_PCIE);

	/* put dma enabled */
	mt76_set(dev, MT_WFDMA0_GLO_CFG,
		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);

	mt76_worker_enable(&mdev->tx_worker);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(mdev, i) {
---> 		napi_enable(&mdev->napi[i]);
		napi_schedule(&mdev->napi[i]);
	}
	napi_enable(&mdev->tx_napi);
	napi_schedule(&mdev->tx_napi);
	local_bh_enable();

	mt76_connac_mcu_set_hif_suspend(mdev, false, false);
	ret = wait_event_timeout(dev->wait,
				 dev->hif_resumed, 3 * HZ);
	if (!ret) {
		err = -ETIMEDOUT;
		goto failed;
	}

	/* restore previous ds setting */
=========================================================
drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c:106 mt7925e_mac_reset() warn: sleeping in atomic context
	mt7925_tx_token_put(dev);
	idr_init(&dev->mt76.token);

	mt792x_wpdma_reset(dev, true);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(&dev->mt76, i) {
---> 		napi_enable(&dev->mt76.napi[i]);
		napi_schedule(&dev->mt76.napi[i]);
	}
	napi_enable(&dev->mt76.tx_napi);
	napi_schedule(&dev->mt76.tx_napi);
	local_bh_enable();

	dev->fw_assert = false;
	clear_bit(MT76_MCU_RESET, &dev->mphy.state);

	mt76_wr(dev, dev->irq_map->host_irq_enable,
		dev->irq_map->tx.all_complete_mask |
		MT_INT_RX_DONE_ALL | MT_INT_MCU_CMD);
	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);

	err = mt792xe_mcu_fw_pmctrl(dev);
=========================================================
drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1705 mt7996_mac_restart() warn: sleeping in atomic context
	napi_disable(&dev->mt76.tx_napi);

	/* token reinit */
	mt7996_tx_token_put(dev);
	idr_init(&dev->mt76.token);

	mt7996_dma_reset(dev, true);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(mdev, i) {
		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
		    mt76_queue_is_wed_rro(&mdev->q_rx[i]))
			continue;

		if (mdev->q_rx[i].ndesc) {
---> 			napi_enable(&dev->mt76.napi[i]);
			napi_schedule(&dev->mt76.napi[i]);
		}
	}
	local_bh_enable();
	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);

	mt76_wr(dev, MT_INT_MASK_CSR, dev->mt76.mmio.irqmask);
	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
	if (dev->hif2) {
		mt76_wr(dev, MT_INT1_MASK_CSR, dev->mt76.mmio.irqmask);
		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
	}
=========================================================
drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1967 mt7996_mac_reset_work() warn: sleeping in atomic context
	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
	clear_bit(MT76_RESET, &dev->mphy.state);
	if (phy2)
		clear_bit(MT76_RESET, &phy2->mt76->state);
	if (phy3)
		clear_bit(MT76_RESET, &phy3->mt76->state);

	local_bh_disable();
        ^^^^^^^^^^^^^^^^^^^
	mt76_for_each_q_rx(&dev->mt76, i) {
		if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
		    mt76_queue_is_wed_rro(&dev->mt76.q_rx[i]))
			continue;

---> 		napi_enable(&dev->mt76.napi[i]);
		napi_schedule(&dev->mt76.napi[i]);
	}
	local_bh_enable();

	tasklet_schedule(&dev->mt76.irq_tasklet);

	mt76_worker_enable(&dev->mt76.tx_worker);

	local_bh_disable();
	napi_enable(&dev->mt76.tx_napi);
	napi_schedule(&dev->mt76.tx_napi);
	local_bh_enable();

	ieee80211_wake_queues(mt76_hw(dev));
	if (phy2)
		ieee80211_wake_queues(phy2->mt76->hw);
	if (phy3)
		ieee80211_wake_queues(phy3->mt76->hw);




