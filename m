Return-Path: <netdev+bounces-288813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBiEF1RuCmrN1AQAu9opvQ
	(envelope-from <netdev+bounces-288813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C97F6564DD3
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C859D3008502
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A1231A23;
	Mon, 18 May 2026 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wtwy4/6+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D713C918
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779068497; cv=none; b=A/WJHvq5pE50aT5OdbC3gEcX/WK5h/Aoo4kaQNcJNBfmQAFYmLTvTcIj8efa/ykB3KF7G7QrGSJfcRk8s72r+tLAhyH/5cInH0ZELgZBYo6Q6XfXFBwUFqdRITq+eu/UZYtaRrAdWZuW95YDZHnrDZB8fZxCaQu3/BLRlGoRgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779068497; c=relaxed/simple;
	bh=iwXE59wk1nQ9MmUoHeijllavlgWxixgLF7CGvj7mQZ0=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YHr2B9e+UKXTNqfy9BVlvUTbRVRvJMk+znGsMl6jpwMq3gqC9P8I6wY7/cibonGLTCdrxBanXziqQDdNNrkKcwAvW+NXuYfJq66KwEIbpxh1UwGfAPWzTek4dhGNbCijLC35w6T5QLgQXH9eqfrbMHb+sWIoURaRD59fQRZslDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wtwy4/6+; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779068493; h=Message-ID:Subject:Date:From:To;
	bh=x1uxmUc10JM4qBa34adzzemW5ZYd49t4ye+2F5mK9Fc=;
	b=wtwy4/6+MBEM1Xh0hqnrzwQbVOBpg5DyFb7Ay3ouJ6Bb7V9poox6FzS0TpURMtEIfm26YBkKlwGa/2HBCQKFFPvyor5YA2tXjX1fR49SAlpOiyF5UHmLCoveeNd+ejRd0O3gMkQ7qpuKLPf6vZ1OI+FG5Bt5Zf8haGrsG3u3q4c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X32opsP_1779068491;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X32opsP_1779068491 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 09:41:32 +0800
Message-ID: <1779068468.870556-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v43 3/8] eea: probe the netdevice and create adminq
Date: Mon, 18 May 2026 09:41:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Dong Yibo <dong100@mucse.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 netdev@vger.kernel.org
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
 <20260514095138.80680-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260514095138.80680-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C97F6564DD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288813-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action


Sashiko ai review:

commit b9e7d5d9497cc9075fff4db2f0e1c143dbb8d2d8
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
eea: probe the netdevice and create adminq
This patch adds the basic driver framework for the Alibaba Elastic
Ethernet Adapter, creating the netdevice after PCI probe and
initialising the admin queue used to issue commands to the device.
A few questions on the code below.
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> new file mode 100644
> index 000000000000..dfad1bdbc44d
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
[ ... ]
> +static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
> +			     dma_addr_t req_addr, dma_addr_t res_addr,
> +			     u32 req_size, u32 res_size, u32 *reply_len)
> +{
> +	struct eea_aq_cdesc *cdesc;
> +	struct eea_aq_desc *desc;
> +	int ret;
[ ... ]
> +	/* Returns 0 on success, or a negative error code on failure. */
> +	ret = le32_to_cpu(cdesc->status);
> +
> +	eea_ering_cq_ack_desc(enet->adminq.ring, 1);
> +
> +	if (ret)
> +		netdev_err(enet->netdev,
> +			   "adminq exec failed. cmd: %d ret %d\n", cmd, ret);
> +	else
> +		*reply_len = le32_to_cpu(cdesc->reply_len);
> +
> +	return ret;
> +}
The wire protocol header defines:
  #define EEA_OK     0
  #define EEA_ERR    0xffffffff
cdesc->status is a __le32, but it is stored into a signed int here:
  ret = le32_to_cpu(cdesc->status);
When the device reports failure (0xffffffff), ret becomes -1, which is
-EPERM. That value then propagates up through eea_adminq_exec() into
eea_netdev_init_features() and ultimately out of probe.
Should the device's protocol-level error be translated to a more
appropriate kernel errno such as -EIO before being returned to the
generic layers, given that the wire protocol defines only EEA_OK and
EEA_ERR rather than a kernel errno space?
[ ... ]
> +int eea_create_adminq(struct eea_net *enet, u32 qid)
> +{
> +	u32 db_size, q_size, num;
> +	struct eea_ring *ering;
> +	struct eea_aq *aq;
> +	int err = -ENOMEM;
> +
> +	num = enet->edev->rx_num + enet->edev->tx_num;
> +	aq = &enet->adminq;
> +
> +	ering = eea_ering_alloc(qid, 64, enet->edev, sizeof(struct eea_aq_desc),
> +				sizeof(struct eea_aq_cdesc), "adminq");
> +	if (!ering)
> +		return -ENOMEM;
> +
> +	aq->ring = ering;
> +
> +	err = eea_pci_active_aq(ering, qid / 2 + 1);
> +	if (err)
> +		goto err;
> +
> +	aq->phase = BIT(7);
> +	aq->num = 0;
> +
> +	q_size = sizeof(*aq->q_req_buf) * num;
> +	db_size = sizeof(*aq->q_res_buf) * num;
> +
> +	aq->q_req_size = q_size;
> +	aq->q_res_size = db_size;
> +
> +	err = -ENOMEM;
> +
> +	aq->q_req_buf = kzalloc(q_size, GFP_KERNEL);
> +	if (!aq->q_req_buf)
> +		goto err;
> +
> +	aq->q_res_buf = kzalloc(db_size, GFP_KERNEL);
> +	if (!aq->q_res_buf)
> +		goto err;
> +
> +	/* Before we set up the AQ, the device remains in an inactive state, so
> +	 * there will be no DMA operations. If the 'set up AQ' process fails, we
> +	 * can safely free the DMA-related memory.
> +	 */
> +	err = eea_pci_set_aq_up(enet->edev);
> +	if (err)
> +		goto err;
> +
> +	aq->broken = false;
> +
> +	mutex_init(&aq->lock);
> +
> +	return 0;
> +
> +err:
> +	eea_destroy_adminq(enet);
> +	return err;
> +}
By the time eea_pci_set_aq_up() is called, eea_pci_active_aq() has
already programmed the SQ/CQ DMA addresses into the device registers
and eea_pci_set_aq_up() has signalled EEA_S_OK. If the
read_poll_timeout() inside eea_pci_set_aq_up() times out, can the
device be assumed to still be quiescent?
The err: label here jumps directly to eea_destroy_adminq(), which calls
eea_ering_free() -> dma_free_coherent() without first calling
eea_device_reset(). Every other teardown site in this commit resets
first, for example eea_adminq_destroy_all_q():
  if (err) {
      /* The device must be reset before unmapping buffers to avoid
       * potential DMA writes after the memory is freed.
       */
      mutex_lock(&enet->adminq.lock);
      eea_device_broken(enet);
      mutex_unlock(&enet->adminq.lock);
      ...
  }
and eea_adminq_submit()'s timeout path (via eea_device_broken()), and
the err_reset_dev label in eea_net_probe(). Should this err: label
also call eea_device_reset(enet->edev) before eea_destroy_adminq() to
avoid a DMA-after-free window into the freed SQ/CQ rings?
mutex_init(&aq->lock) is called only after the last goto err point,
and eea_destroy_adminq() never calls mutex_destroy() on it. Should
eea_destroy_adminq() pair the init with mutex_destroy(), and should
mutex_init() move earlier so the lock is always initialised on the
teardown path?
[ ... ]
> +void eea_adminq_config_host_info(struct eea_net *enet)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	struct eea_aq_host_info_cfg *cfg;
> +	struct eea_aq_host_info_rep *rep;
> +	int rc = -ENOMEM;
[ ... ]
> +	cfg->os_type            = cpu_to_le16(EEA_OS_LINUX);
> +	cfg->os_dist            = cpu_to_le16(EEA_OS_DISTRO);
> +	cfg->drv_type           = cpu_to_le16(EEA_DRV_TYPE);
> +
> +	cfg->kern_ver_major     = cpu_to_le16(LINUX_VERSION_MAJOR);
> +	cfg->kern_ver_minor     = cpu_to_le16(LINUX_VERSION_PATCHLEVEL);
> +	cfg->kern_ver_sub_minor = cpu_to_le16(LINUX_VERSION_SUBLEVEL);
> +
> +	cfg->drv_ver_major      = cpu_to_le16(EEA_VER_MAJOR);
> +	cfg->drv_ver_minor      = cpu_to_le16(EEA_VER_MINOR);
> +	cfg->drv_ver_sub_minor  = cpu_to_le16(EEA_VER_SUB_MINOR);
The driver carries a private version triplet (EEA_VER_MAJOR/MINOR/
SUB_MINOR = 1.0.0) and reports it to the device. For an upstream
driver, the canonical version is the kernel version itself; private
driver version numbers tend to fall out of date and have historically
been pushed back on by netdev maintainers.
Could this field be dropped, or derived from the kernel version,
rather than freezing 1.0.0 into the device-side ABI?
> +
> +	cfg->spec_ver_major     = cpu_to_le16(EEA_SPEC_VER_MAJOR);
> +	cfg->spec_ver_minor     = cpu_to_le16(EEA_SPEC_VER_MINOR);
> +
> +	cfg->pci_bdf            = cpu_to_le16(eea_pci_bdf(enet->edev));
> +	cfg->pci_domain         = cpu_to_le32(eea_pci_domain_nr(enet->edev));
> +
> +	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
> +	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
On every probe the driver unconditionally sends utsname()->release,
utsname()->machine, the full Linux kernel version, os_dist, drv_type,
the PCI BDF and PCI domain to the device. The kernel release string
is set by distros and can include build identifiers.
Could the commit message explain what the firmware does with these
strings, and is there a reason this needs to be unconditional rather
than gated on a module parameter or kernel option?
EEA_OS_DISTRO and EEA_DRV_TYPE are both hardcoded to 0 with no
documented enumeration of valid values. Together with EEA_OS_LINUX=1,
these become part of the wire ABI introduced in this commit.
If these fields are intended to grow (for example to distinguish
upstream vs out-of-tree builds, or kernel module vs userspace
consumers), can the meaning of value 0 and the reserved range be
documented now? If they are not needed, can they be removed before
firmware ships against this layout?
> +
> +	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
> +			     cfg, sizeof(*cfg), rep, sizeof(*rep), NULL);
[ ... ]
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> new file mode 100644
> index 000000000000..bb8a49f8c6df
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
[ ... ]
> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	struct eea_aq_cfg *cfg;
> +	int err;
> +	u32 mtu;
[ ... ]
> +	netdev->min_mtu = ETH_MIN_MTU;
> +
> +	netdev->mtu = mtu;
> +
> +	/* If jumbo frames are already enabled, then the returned MTU will be a
> +	 * jumbo MTU, and the driver will automatically enable jumbo frame
> +	 * support by default.
> +	 */
> +	netdev->max_mtu = mtu;
netdev->max_mtu is set to the same value as netdev->mtu, where mtu
came from cfg->mtu in the device's reply to EEA_AQ_CMD_CFG_QUERY.
The eea_aq_cfg structure has only a single __le16 mtu field and no
separate maximum, and the comment above describes mtu as the current
configured MTU rather than the device-supported maximum.
With max_mtu == mtu, can a user ever raise the MTU above the value the
device happened to advertise at probe time via "ip link set dev X
mtu N"? Should the wire ABI being introduced here grow a separate
mtu_max field, or should the driver derive a maximum (for example a
fixed jumbo cap) for max_mtu?
> +
> +err_free:
> +	kfree(cfg);
> +	return err;
> +}
[ ... ]
> +int eea_net_probe(struct eea_device *edev)
> +{
> +	struct eea_net *enet;
> +	int err = -ENOMEM;
> +
> +	enet = eea_netdev_alloc(edev, edev->rx_num);
> +	if (!enet)
> +		return -ENOMEM;
> +
> +	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> +	if (err)
> +		goto err_free_netdev;
> +
> +	eea_adminq_config_host_info(enet);
> +
> +	err = eea_netdev_init_features(enet->netdev, enet, edev);
> +	if (err)
> +		goto err_reset_dev;
> +
> +	netdev_dbg(enet->netdev, "eea probe success.\n");
> +
> +	/* Queue TX/RX implementation is still in progress. register_netdev is
> +	 * deferred until these are completed in subsequent commits.
> +	 */
> +
> +	return 0;
After this commit, eea_net_probe() returns success without calling
register_netdev(). A bisect that lands exactly on this commit will
see a probed PCI driver that has consumed IRQs and DMA buffers and
already issued the HOST_INFO admin command to firmware, but no netdev
visible to userspace.
Could this patch be squashed with the later patches that complete the
TX/RX paths and call register_netdev(), so a bisected kernel either
has a working interface or no driver activation at all?
> +
> +err_reset_dev:
> +	eea_device_reset(edev);
> +	eea_destroy_adminq(enet);
> +
> +err_free_netdev:
> +	free_netdev(enet->netdev);
> +	return err;
> +}

