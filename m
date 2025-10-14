Return-Path: <netdev+bounces-229195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A38BD9132
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C21F4FAEC4
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E1F30E849;
	Tue, 14 Oct 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MuGny2fw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC6C304968
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442199; cv=none; b=dHUTSg+f/MMl0cp6oJ2KMwbhNxzKZFrkiVJkTel7qBlCDnggDxIGFeIPXDlBn5+K1WvkWhoQzGZo3SC5JJy/bbDXE1Pr/Tc4Xs5Rq2N27jDkdFPN0PJirSHx0PEnPyIWquP8/5ZoJSmpt0r4KQyIlWkG0YD3Tf2P+7BgbpVJPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442199; c=relaxed/simple;
	bh=fop943o6Wr7krlLuhY+A/L0lmKCKTRtK52xoFzXNEsk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=bzyD9L0j3B28uhGx9TSQskeC1rc8xaMgQh3uGFdpfZNpeQipGmJXblQ6MOsPEBFZEkVuGpJFngrZV31bI5EbhqCAD2B860gWh14Gi0aR3rkA5ZnJeYylwBvflJDviBLBrvBPS7qBI8kfBXyBv+nFO4EgtZ8k1O3lYzkergLtHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MuGny2fw; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760442194; h=Message-ID:Subject:Date:From:To;
	bh=P0z2O4rxFMH3PJkgW9Ke1tx+hDmvIb6pYaqqJlalReM=;
	b=MuGny2fw+PZKmfdHbF++YbCpruY7YrzqHGRIzqImYSw42Rz7WIVKJoZUQbZjgdMjhR8vhnFMuCJoQUyd5gQnUnSkKnlCq45dhdJ4Id3J3M4SZ6BIF1ZSBSQpCb4mftciZ9+Wjr2mHKT66zKpENnjEgrxro7wz7dshYZJKkygYy8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqBpOpH_1760442192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 19:43:12 +0800
Message-ID: <1760441688.9352384-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Tue, 14 Oct 2025 19:34:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>,
 alok.a.tiwari@oracle.com,
 kalesh-anakkur.purayil@broadcom.com,
 netdev@vger.kernel.org
References: <20251013021833.100459-1-xuanzhuo@linux.alibaba.com>
 <8b853379-1601-4387-adaf-31f786f306ca@redhat.com>
In-Reply-To: <8b853379-1601-4387-adaf-31f786f306ca@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 14 Oct 2025 13:25:47 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On 10/13/25 4:18 AM, Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
> >
> > This driver is currently quite minimal, implementing only fundamental
> > core functionalities. Key features include: I/O queue management via
> > adminq, basic PCI-layer operations, and essential RX/TX data
> > communication capabilities. It also supports the creation,
> > initialization, and management of network devices (netdev). Furthermore,
> > the ring structures for both I/O queues and adminq have been abstracted
> > into a simple, unified, and reusable library implementation,
> > facilitating future extension and maintenance.
> >
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> > Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >
> > v5: Thanks for the comments from Kalesh Anakkur Purayil, ALOK TIWARI
> > v4: Thanks for the comments from Troy Mitchell, Przemek Kitszel, Andrew Lunn, Kalesh Anakkur Purayil
> > v3: Thanks for the comments from Paolo Abenchi
> > v2: Thanks for the comments from Simon Horman and Andrew Lunn
> > v1: Thanks for the comments from Simon Horman and Andrew Lunn
>
> You should add a synopsis of the major changes vs the previous revision
> to make reiviewer's work easier.

Generally yes, but all the changes are so minor that I can't possibly list them
all, so I'm using this format.

>
> >
> > This commit is indeed quite large, but further splitting it would not be
> > meaningful. Historically, many similar drivers have been introduced with
> > commits of similar size and scope, so we chose not to invest excessive
> > effort into finer-grained splitting.
>
> That also means that you require the reviewers to invest a lot of extra
> effort here, which in turn does not help making progresses.

Indeed, it's been quite a while, but I haven't made any substantial progress on
this patchset, and I'm really considering this. Would splitting up a few commits
speed up the review process?

>
> [...]> +/* resources: ring, buffers, irq */
> > +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp)
> > +{
> > +	struct eea_net_tmp _tmp = {};
> > +	int err;
> > +
> > +	if (!tmp) {
> > +		enet_mk_tmp_cfg(enet, &_tmp);
> > +		tmp = &_tmp;
> This is quite ugly. Let the caller always pass non zero 'tmp'. Also a
> more describing name would help.
>
> > +	}
> > +
> > +	if (!netif_running(enet->netdev)) {
> > +		enet->cfg = tmp->cfg;
> > +		return 0;
> > +	}
> > +
> > +	err = eea_alloc_rxtx_q_mem(tmp);
> > +	if (err) {
> > +		netdev_warn(enet->netdev,
> > +			    "eea reset: alloc q failed. stop reset. err %d\n",
> > +			    err);
> > +		return err;
> > +	}
> > +
> > +	eea_netdev_stop(enet->netdev);
> > +
> > +	enet_bind_new_q_and_cfg(enet, tmp);
> > +
> > +	err = eea_active_ring_and_irq(enet);
> > +	if (err) {
> > +		netdev_warn(enet->netdev,
> > +			    "eea reset: active new ring and irq failed. err %d\n",
> > +			    err);
> > +		return err;
> > +	}
> > +
> > +	err = eea_start_rxtx(enet->netdev);
> > +	if (err)
> > +		netdev_warn(enet->netdev,
> > +			    "eea reset: start queue failed. err %d\n", err);
>
> I'm unsure why you ignore my feedback on v2 WRT errors generated here?

Do you mean this?

	Here you should try harder to avoid any NIC changes in case of failure.
	i.e. you could activate and start only the new queues, and destroy the
	to-be-deleted one only after successful real queues update.

Sorry, I missed that. This function handles the scenario where the entire setup
fails, not just a few queues, so I need to allocate all the queues and
reactivate them.

Thanks.


>
> > +
> > +	return err;
> > +}
> > +
> > +int eea_queues_check_and_reset(struct eea_device *edev)
> > +{
> > +	struct eea_aq_dev_status *dstatus __free(kfree) = NULL;
> > +	struct eea_aq_queue_status *qstatus;
> > +	struct eea_aq_queue_status *qs;
> > +	bool need_reset = false;
> > +	int num, i, err = 0;
> > +
> > +	num = edev->enet->cfg.tx_ring_num * 2 + 1;
>
> The above should probably moved under the RTNL lock or you could access
> stale values.
>
> > +
> > +	rtnl_lock();
> > +
> > +	dstatus = eea_adminq_dev_status(edev->enet);
> > +	if (!dstatus) {
> > +		netdev_warn(edev->enet->netdev, "query queue status failed.\n");
>
>
> 		err = -ENOMEM;
> 		goto out_unlock;
>
>
> > +		rtnl_unlock();
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (le16_to_cpu(dstatus->link_status) == EEA_LINK_DOWN_STATUS) {
> > +		eea_netdev_stop(edev->enet->netdev);
> > +		edev->enet->link_err = EEA_LINK_ERR_LINK_DOWN;
> > +		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n");
> > +		rtnl_unlock();
> > +		return 0;
>
> 		goto out_unlock;
>
> > +	}
> > +
> > +	qstatus = dstatus->q_status;
> > +
> > +	for (i = 0; i < num; ++i) {
> > +		qs = &qstatus[i];
> > +
> > +		if (le16_to_cpu(qs->status) == EEA_QUEUE_STATUS_NEED_RESET) {
> > +			netdev_warn(edev->enet->netdev,
> > +				    "queue status: queue %u needs to reset\n",
> > +				    le16_to_cpu(qs->qidx));
> > +			need_reset = true;
> > +		}
> > +	}
> > +
> > +	if (need_reset)
> > +		err = eea_reset_hw_resources(edev->enet, NULL);
> > +
>
> out_unlock:> +	rtnl_unlock();
> > +	return err;
>
>
> [...]> +/* ha handle code */
> > +static void eea_ha_handle_work(struct work_struct *work)
> > +{
> > +	struct eea_pci_device *ep_dev;
> > +	struct eea_device *edev;
> > +	struct pci_dev *pci_dev;
> > +	u16 reset;
> > +
> > +	ep_dev = container_of(work, struct eea_pci_device, ha_handle_work);
> > +	edev = &ep_dev->edev;
> > +
> > +	/* Ha interrupt is triggered, so there maybe some error, we may need to
> > +	 * reset the device or reset some queues.
> > +	 */
> > +	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
> > +
> > +	if (ep_dev->reset_pos) {
> > +		pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> > +				     &reset);
> > +		/* clear bit */
> > +		pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> > +				      0xFFFF);
> > +
> > +		if (reset & EEA_PCI_CAP_RESET_FLAG) {
> > +			dev_warn(&ep_dev->pci_dev->dev,
> > +				 "recv device reset request.\n");
> > +
> > +			pci_dev = ep_dev->pci_dev;
> > +
> > +			/* The pci remove callback may hold this lock. If the
> > +			 * pci remove callback is called, then we can ignore the
> > +			 * ha interrupt.
> > +			 */
> > +			if (mutex_trylock(&edev->ha_lock)) {
> > +				edev->ha_reset = true;
> > +
> > +				__eea_pci_remove(pci_dev, false);
> > +				__eea_pci_probe(pci_dev, ep_dev);
> > +
> > +				edev->ha_reset = false;
> > +				mutex_unlock(&edev->ha_lock);
> > +			} else {
> > +				dev_warn(&ep_dev->pci_dev->dev,
> > +					 "ha device reset: trylock failed.\n");
>
> Nesting here is quite high, possibly move the above in a separate helper.
>
> > +			}
> > +			return;
> > +		}
> > +	}
> > +
> > +	eea_queues_check_and_reset(&ep_dev->edev);
> > +}
>
>
> I'm sorry, EPATCHISTOOBIG I can't complete the review even in with an
> unreasonable amount of time.
>
> /P
>

