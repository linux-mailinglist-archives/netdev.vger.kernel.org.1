Return-Path: <netdev+bounces-205798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB99B003FA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EA61AA283E
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E12701BB;
	Thu, 10 Jul 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="guOUChlT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B326E6FE
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155148; cv=none; b=an5V3DGrw2RHvJenO0Dd/DXpLEfkEIQLkoYskH8NJgv+uoG5uLyaeGCRbSlHSgiEaDS1EVv2U5ENS1qTjwL+5KVHng2LRfHZ+vOxHiVejkGFhoq/AVwF1rObHwsxn3PgjfmmuEFGKCV+doWWvhN6C8G6rj6/n3OmqnKMbIMXN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155148; c=relaxed/simple;
	bh=J/+NSots16qh13gup9e/XOa76r1mq1UmsZQb+Ygds20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnPnVEWPJepDrTvvw862/59/zDta+cOqP6U4ofIXHg9NPS5PZJaaOYYdh18axEjlrNo+m3A//RdPJKWK0XYxJR9RcCqc26vgWJzfLyNXee6b1H7ShFzJXcjPGUEPgL8IMsreNUCA3AI1ph/e6nRdE+HiKcwE6Nda4V3JZ321M34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=guOUChlT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V3FF+zxIWuh2LJsmLj4m9qkVMuzr1JAKLLCnNwUv8Ec=; b=guOUChlTRjbp2oqY1Kydngga7E
	zwhZiomurZVQhXJP2+9AgRHLp5c4+JDe5RdpKx9S6+dd8rEtAo7AwG4M0r/5YjdpwBv5eWjW9xA0n
	DA3TDrL7yKRYtbFtkiZlhVrUaL/I5c7dFR1o8u2u9FG0um9pmBx0OiKj4Yya4ivcfcUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZrak-0017We-9S; Thu, 10 Jul 2025 15:45:38 +0200
Date: Thu, 10 Jul 2025 15:45:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <7b957110-c675-438a-b0c2-ebc161a5d8e7@lunn.ch>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>

> +module_param(aq_timeout, uint, 0644);

No module params please.

> +struct eea_aq_host_info_cfg {
> +#ifndef EEA_OS_DISTRO
> +#define EEA_OS_DISTRO		0
> +#endif
> +
> +#ifndef EEA_DRV_TYPE
> +#define EEA_DRV_TYPE		0
> +#endif
> +
> +#define EEA_OS_LINUX		1
> +#define EEA_SPEC_VER_MAJOR	1
> +#define EEA_SPEC_VER_MINOR	0
> +	__le16	os_type;        /* Linux, Win.. */
> +	__le16	os_dist;
> +	__le16	drv_type;
> +
> +	__le16	kern_ver_major;
> +	__le16	kern_ver_minor;
> +	__le16	kern_ver_sub_minor;
> +
> +	__le16	drv_ver_major;
> +	__le16	drv_ver_minor;
> +	__le16	drv_ver_sub_minor;
> +
> +	__le16	spec_ver_major;
> +	__le16	spec_ver_minor;
> +	__le16	pci_bdf;
> +	__le32	pci_domain;
> +
> +	u8      os_ver_str[64];
> +	u8      isa_str[64];

Why does it care about the OS, kernel version etc?

> +#define DMA_FLAGS (GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO)

Don't hide GFP_ flags behind a #define. It makes the code harder to
review.

> +	start = get_jiffies_64();
> +	while (!(cdesc = ering_cq_get_desc(enet->adminq.ring))) {
> +		cond_resched();
> +		cpu_relax();
> +
> +		timeout = secs_to_jiffies(READ_ONCE(aq_timeout));
> +		if (time_after64(get_jiffies_64(), start + timeout)) {
> +			netdev_err(enet->netdev, "admin queue timeout. timeout %d\n",
> +				   READ_ONCE(aq_timeout));
> +			return -1;
> +		}
> +	}

See if you can one of the macros from iopoll.h

> +static void eea_get_drvinfo(struct net_device *netdev,
> +			    struct ethtool_drvinfo *info)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +	struct eea_device *edev = enet->edev;
> +
> +	strscpy(info->driver,   KBUILD_MODNAME,     sizeof(info->driver));
> +	strscpy(info->bus_info, eea_pci_name(edev), sizeof(info->bus_info));
> +	snprintf(info->version, sizeof(info->version), "%d.%d.%d",
> +		 EEA_VER_MAJOR, EEA_VER_MINOR, EEA_VER_SUB_MINOR);

A hard coded version is pointless, because it never changes, yet the
kernel around the driver changes every week. Don't set version, and
the core will fill in the git hash, which is useful.

> +static int eea_get_link_ksettings(struct net_device *netdev,
> +				  struct ethtool_link_ksettings *cmd)
> +{
> +	struct eea_net *enet = netdev_priv(netdev);
> +
> +	cmd->base.speed  = enet->speed;
> +	cmd->base.duplex = enet->duplex;
> +	cmd->base.port   = PORT_OTHER;
> +
> +	return 0;
> +}
> +
> +static int eea_set_link_ksettings(struct net_device *netdev,
> +				  const struct ethtool_link_ksettings *cmd)
> +{
> +	return 0;

-EOPNOTSUPP. 

> +module_param(split_hdr_size, int, 0644);

No module params please.

> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> +	int err;
> +	u32 mtu;
> +
> +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> +
> +	err = eea_adminq_query_cfg(enet, cfg);
> +
> +	if (err)
> +		return err;
> +
> +	eea_update_cfg(enet, edev, cfg);
> +
> +	netdev->priv_flags |= IFF_UNICAST_FLT;
> +	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +
> +	netdev->hw_features |= NETIF_F_HW_CSUM;
> +	netdev->hw_features |= NETIF_F_GRO_HW;
> +	netdev->hw_features |= NETIF_F_SG;
> +	netdev->hw_features |= NETIF_F_TSO;
> +	netdev->hw_features |= NETIF_F_TSO_ECN;
> +	netdev->hw_features |= NETIF_F_TSO6;
> +
> +	netdev->features |= NETIF_F_HIGHDMA;
> +	netdev->features |= NETIF_F_HW_CSUM;
> +	netdev->features |= NETIF_F_SG;
> +	netdev->features |= NETIF_F_GSO_ROBUST;
> +	netdev->features |= netdev->hw_features & NETIF_F_ALL_TSO;
> +	netdev->features |= NETIF_F_RXCSUM;
> +	netdev->features |= NETIF_F_GRO_HW;
> +
> +	netdev->vlan_features = netdev->features;
> +
> +	eth_hw_addr_set(netdev, cfg->mac);
> +
> +	enet->speed = SPEED_UNKNOWN;
> +	enet->duplex = DUPLEX_UNKNOWN;
> +
> +	netdev->min_mtu = ETH_MIN_MTU;
> +
> +	mtu = le16_to_cpu(cfg->mtu);
> +	if (mtu < netdev->min_mtu) {
> +		dev_err(edev->dma_dev, "device MTU too small. %d < %d", mtu, netdev->min_mtu);
> +		return -EINVAL;
> +	}
> +
> +	netdev->mtu = mtu;
> +	netdev->max_mtu = mtu;

Setting mtu the same as max_mtu is unusual? Are you defaulting to jumbo? 

> +	netif_carrier_on(netdev);

Does the firmware give you no idea about carrier? You seem to have it
hard coded in a number of places.

> +static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
> +{
> +	struct net_device *netdev;
> +	struct eea_net *enet;
> +
> +	netdev = alloc_etherdev_mq(sizeof(struct eea_net), pairs);
> +	if (!netdev) {
> +		dev_warn(edev->dma_dev, "alloc_etherdev_mq failed with pairs %d\n", pairs);

dev_warn()? That is fatal, so dev_err(). Please only use dev_warn()
for something which you can recover from.

> +int eea_net_probe(struct eea_device *edev)
> +{
> +	struct eea_net *enet;
> +	int err = -ENOMEM;
> +
> +	if (edev->ha_reset)
> +		return eea_net_reprobe(edev);
> +
> +	enet = eea_netdev_alloc(edev, edev->rx_num);
> +	if (!enet)
> +		return -ENOMEM;
> +
> +	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> +	if (err)
> +		goto err_adminq;
> +
> +	err = eea_adminq_config_host_info(enet);
> +	if (err)
> +		goto err_hinfo;
> +
> +	err = eea_netdev_init_features(enet->netdev, enet, edev);
> +	if (err)
> +		goto err_feature;
> +
> +	err = register_netdev(enet->netdev);
> +	if (err)
> +		goto err_ready;
> +
> +	eea_update_ts_off(edev, enet);
> +	netif_carrier_off(enet->netdev);
> +
> +	netdev_info(enet->netdev, "eea probe success.\n");

netdev_dbg() or nothing. Don't spam the kernel log.

> +#define cfg_write64(reg, item, val) { \
> +	void *_r = reg; \
> +	iowrite64_twopart(val, \
> +			  cfg_pointer(_r, item ## _lo), \
> +			  cfg_pointer(_r, item ## _hi)); \
> +}

This might be better as a function, so you get better type checking.

> +static inline void iowrite64_twopart(u64 val, __le32 __iomem *lo,
> +				     __le32 __iomem *hi)

No inline functions in .c files. Let the compiler decide.

> +void eea_device_reset(struct eea_device *edev)
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +	int i;
> +
> +	eea_pci_io_set_status(edev, 0);
> +
> +	while (eea_pci_io_get_status(edev))
> +		msleep(20);

No endless loops. iopoll.h

> +void __force *eea_pci_db_addr(struct eea_device *edev, u32 off)
> +{
> +	return (void __force *)edev->ep_dev->db_base + off;
> +}

When i see __force i start to wounder if the types are wrong. This
probably needs a comment.

> +/* ha handle code */
> +static void eea_ha_handle_work(struct work_struct *work)
> +{
> +	struct eea_pci_device *ep_dev;
> +	struct eea_device *edev;
> +	struct pci_dev *pci_dev;
> +	u16 reset;
> +
> +	ep_dev = container_of(work, struct eea_pci_device, ha_handle_work);
> +	edev = &ep_dev->edev;
> +
> +	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");

What does a ha interrupt mean? Why is a dev_warn() needed? Some
comments would be good.

> +
> +	if (ep_dev->reset_pos) {
> +		pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos, &reset);
> +		/* clear bit */
> +		pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos, 0xFFFF);
> +
> +		if (reset & EEA_PCI_CAP_RESET_FLAG) {
> +			dev_warn(&ep_dev->pci_dev->dev, "recv device reset request.\n");
> +
> +			pci_dev = ep_dev->pci_dev;
> +
> +			if (mutex_trylock(&edev->ha_lock)) {

Maybe add a comment why you use trylock(). Who else might be holding
the lock, and why cannot you wait for it to be release?

> +				edev->ha_reset = true;
> +
> +				__eea_pci_remove(pci_dev, false);
> +				__eea_pci_probe(pci_dev, ep_dev);
> +
> +				edev->ha_reset = false;
> +				mutex_unlock(&edev->ha_lock);
> +			} else {
> +				dev_warn(&ep_dev->pci_dev->dev,
> +					 "ha device reset: trylock failed.\n");
> +			}
> +			return;
> +		}
> +	}
> +
> +	eea_queues_check_and_reset(&ep_dev->edev);
> +}
> +
> +static irqreturn_t eea_pci_ha_handle(int irq, void *data)
> +{
> +	struct eea_device *edev = data;
> +
> +	schedule_work(&edev->ep_dev->ha_handle_work);
> +
> +	return IRQ_HANDLED;

Maybe just use a threaded interrupt? What will make the code simpler.

> +static int eea_pci_ha_init(struct eea_device *edev, struct pci_dev *pci_dev)
> +{
> +	u8 pos, cfg_type_off, type, cfg_drv_off, cfg_dev_off;
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +	int irq;
> +
> +	cfg_type_off = offsetof(struct eea_pci_cap, cfg_type);
> +	cfg_drv_off = offsetof(struct eea_pci_reset_reg, driver);
> +	cfg_dev_off = offsetof(struct eea_pci_reset_reg, device);
> +
> +	for (pos = pci_find_capability(pci_dev, PCI_CAP_ID_VNDR);
> +	     pos > 0;
> +	     pos = pci_find_next_capability(pci_dev, pos, PCI_CAP_ID_VNDR)) {
> +		pci_read_config_byte(pci_dev, pos + cfg_type_off, &type);
> +
> +		if (type == EEA_PCI_CAP_RESET_DEVICE) {
> +			/* notify device, driver support this feature. */
> +			pci_write_config_word(pci_dev, pos + cfg_drv_off, EEA_PCI_CAP_RESET_FLAG);
> +			pci_write_config_word(pci_dev, pos + cfg_dev_off, 0xFFFF);
> +
> +			edev->ep_dev->reset_pos = pos + cfg_dev_off;
> +			goto found;
> +		}
> +	}
> +
> +	dev_warn(&edev->ep_dev->pci_dev->dev, "Not Found reset cap.\n");
> +

Should there be an return -ENODEV; here?

> +found:
> +	snprintf(ep_dev->ha_irq_name, sizeof(ep_dev->ha_irq_name), "eea-ha@%s",
> +		 pci_name(ep_dev->pci_dev));
> +
> +	irq = pci_irq_vector(ep_dev->pci_dev, 0);
> +
> +	INIT_WORK(&ep_dev->ha_handle_work, eea_ha_handle_work);
> +
> +	return request_irq(irq, eea_pci_ha_handle, 0, ep_dev->ha_irq_name, edev);
> +}
> +static inline bool ering_irq_unactive(struct ering *ering)
> +{
> +	union {
> +		u64 data;
> +		struct db db;
> +	} val;
> +
> +	if (ering->mask == EEA_IRQ_MASK)
> +		return true;
> +
> +	ering->mask = EEA_IRQ_MASK;
> +
> +	val.db.kick_flags = EEA_IRQ_MASK;
> +
> +	writeq(val.data, (void __iomem *)ering->db);
> +
> +	return true;
> +}
> +
> +static inline bool ering_irq_active(struct ering *ering, struct ering *tx_ering)
> +{
> +	union {
> +		u64 data;
> +		struct db db;
> +	} val;
> +
> +	if (ering->mask == EEA_IRQ_UNMASK)
> +		return true;
> +
> +	ering->mask = EEA_IRQ_UNMASK;
> +
> +	val.db.kick_flags = EEA_IRQ_UNMASK;
> +
> +	val.db.tx_cq_head = cpu_to_le16(tx_ering->cq.hw_idx);
> +	val.db.rx_cq_head = cpu_to_le16(ering->cq.hw_idx);
> +
> +	writeq(val.data, (void __iomem *)ering->db);
> +
> +	return true;
> +}
> +
> +static inline void *ering_cq_get_desc(const struct ering *ering)
> +{
> +	u8 phase;
> +	u8 *desc;
> +
> +	desc = ering->cq.desc + (ering->cq.head << ering->cq.desc_size_shift);
> +
> +	phase = *(u8 *)(desc + ering->cq.desc_size - 1);
> +
> +	if ((phase & ERING_DESC_F_CQ_PHASE)  == ering->cq.phase) {
> +		dma_rmb();
> +		return desc;
> +	}
> +
> +	return NULL;
> +}

These three should be in a .c file. They are too big for inline in a
header file.

	Andrew

