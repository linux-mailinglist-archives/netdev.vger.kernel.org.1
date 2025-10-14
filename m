Return-Path: <netdev+bounces-229183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D51BD8FEE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 535964F1625
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D330C344;
	Tue, 14 Oct 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4+ZsNVm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA230BBA0
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441156; cv=none; b=sjx3iTduiZ3Fs9YKBkdIWLEVZZjDtiOtlt9UY6Df+Jv5rN7fVSW4jwZ2ywU0ebkWnLulAtDO4KUL8Q/bIWbkOHQgRq7kQmoT51B+SRVkrVw8U7Ruwh5spg0sC4LjkygyJuRfDymDlIAc9wkCzVJNoiSe9bVVmK2ebbuHLpOtZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441156; c=relaxed/simple;
	bh=2b4XwuGrRbKdgtk9KYKGiKTcSlxhY0TB7j1lIQ7jL7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/iTi7Xv9sx9CSGb/826yxdBMKCnbAGhc570K/YaqfnYP2ZMnmuJCusSYKRBAW5OpEncWKNH8/YBOBLu6kVXbKehJaTPZJ8/JcF/olHq5DKatj33YESGMIswCRJqbzYJNQVtTVHcgkoX31qJb9BZ8dPPntU7NHqjt2bTFSHJ7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f4+ZsNVm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760441153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaI2Sofd6uFkuMmO49kC+bW2/I7ajgBnIYxMl3T9Cvw=;
	b=f4+ZsNVmV68+2LbBYWWj17ArmnQ+WzWPu09e7kLF9BrIZFGuONDts5zKMmdN1KfLvkQFnQ
	V0+OhPb1F9anqRkbMYnfysggQZ+s8BD+4xIW3aJ3+PL9IuwLQcpuC/Tk1GVYvlb0gDrd6z
	oh1Mzca2DsobCO2oNPsL0COK2G4NPGg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-WsHrGtwgOPK3QDslpOeTcw-1; Tue, 14 Oct 2025 07:25:51 -0400
X-MC-Unique: WsHrGtwgOPK3QDslpOeTcw-1
X-Mimecast-MFC-AGG-ID: WsHrGtwgOPK3QDslpOeTcw_1760441151
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3ed6540fso35058325e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 04:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441151; x=1761045951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaI2Sofd6uFkuMmO49kC+bW2/I7ajgBnIYxMl3T9Cvw=;
        b=Qfz+TQjVikpw8siu/gSJw7Y8kxL8DZDtlMeC51VVlMMc0vdZwV014x3LwaIIji03YH
         R8rCQjGPlDjLMvnQssJOJL+CRaPxdj+H8Mo8xsIrYwAySIiq+tcURvb8WKpQoTly3VJ9
         vrtWYJmz5agRYpAEIaoH2zuhRc2U6qgh7GN1Tfdh8RGM0+vz6ZdpTqc9oL2UVFehDQVT
         LVxsuTnpg3jQ108mDSR/18CaAyM74pfGa5UuvY4EXmfdYSH32QK/r/qR+osal/bnLTgt
         sYbz9IcziaPAndYhPfDQv2peDXERgvTnJwd77r1UxsywXwbORt5vLERyOo2kjY3F6lZb
         /ygg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+6TNKrDJMY8wpaGkEYx6Wzp1FxTsOAa+VEQQHYuxh0Jgh9ac5WcNub1bAjpK0lue64TkjTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7MG6gEw/03uzfBNb5PRvn5PAlIGVstpprWIBbS/k72mfkwBI
	7Tba3UZT8WMx0ffVDiau3EMEn7ecK5NzQ1NzMosacDVXr2Fgrsc0QCHYGL3nAIlmRaTrJYbkTz3
	xAHShmmdqoMwqCo71CtmoIeSGAm61FuRoY5GwJXWJNA5TKqWUWzlw/pv2Hg==
X-Gm-Gg: ASbGncvu+gru+a0RboraEAm0W/OOB+Y5MU0Uc1Y6UaVmLiAjqR0th4sOm1ecCbHJFvp
	kFEkna/+uadRSbMoZS1g9TMoYyJKwbwBD6YJbce099xzHiX1WY13yltA0K1J80gRpNIMLQQ8m/H
	Gb9XJOTOsikiOosHGDJOQFXYEhKEouCpUTUwI00YgT3TDbusGjzj2hoPTu4Y8stmrQb78agj2ow
	6alicluW6OD0RljeTw09/7pNCMxIPJOEJFNHhZ5KYczHYhFE1pglYH5z/F1p32lJ4tv6VM4cHxi
	H5SC56Um65vKsGLDq1Tn/IUdQ//sjqDpRb0uoSd+RxdOAWR54QL1GJhu6j5QmSJyZUztWGNhC5J
	/pERGqyy8fCdr
X-Received: by 2002:a05:600c:190a:b0:46f:a8fd:c0dc with SMTP id 5b1f17b1804b1-46fa9e8dcbbmr200402705e9.3.1760441150623;
        Tue, 14 Oct 2025 04:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeUf3ex5nalCFHoDLrjPFfJia1u2Yzq34U3e2oEbjoLPrRguDTyyWxCTkuH5vPKV1AA/UEhg==
X-Received: by 2002:a05:600c:190a:b0:46f:a8fd:c0dc with SMTP id 5b1f17b1804b1-46fa9e8dcbbmr200402445e9.3.1760441150163;
        Tue, 14 Oct 2025 04:25:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49be017sm231524945e9.13.2025.10.14.04.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 04:25:49 -0700 (PDT)
Message-ID: <8b853379-1601-4387-adaf-31f786f306ca@redhat.com>
Date: Tue, 14 Oct 2025 13:25:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>, alok.a.tiwari@oracle.com,
 kalesh-anakkur.purayil@broadcom.com
References: <20251013021833.100459-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013021833.100459-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 4:18 AM, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> 
> v5: Thanks for the comments from Kalesh Anakkur Purayil, ALOK TIWARI
> v4: Thanks for the comments from Troy Mitchell, Przemek Kitszel, Andrew Lunn, Kalesh Anakkur Purayil
> v3: Thanks for the comments from Paolo Abenchi
> v2: Thanks for the comments from Simon Horman and Andrew Lunn
> v1: Thanks for the comments from Simon Horman and Andrew Lunn

You should add a synopsis of the major changes vs the previous revision
to make reiviewer's work easier.

> 
> This commit is indeed quite large, but further splitting it would not be
> meaningful. Historically, many similar drivers have been introduced with
> commits of similar size and scope, so we chose not to invest excessive
> effort into finer-grained splitting.

That also means that you require the reviewers to invest a lot of extra
effort here, which in turn does not help making progresses.

[...]> +/* resources: ring, buffers, irq */
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp)
> +{
> +	struct eea_net_tmp _tmp = {};
> +	int err;
> +
> +	if (!tmp) {
> +		enet_mk_tmp_cfg(enet, &_tmp);
> +		tmp = &_tmp;
This is quite ugly. Let the caller always pass non zero 'tmp'. Also a
more describing name would help.

> +	}
> +
> +	if (!netif_running(enet->netdev)) {
> +		enet->cfg = tmp->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(tmp);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_netdev_stop(enet->netdev);
> +
> +	enet_bind_new_q_and_cfg(enet, tmp);
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: active new ring and irq failed. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	err = eea_start_rxtx(enet->netdev);
> +	if (err)
> +		netdev_warn(enet->netdev,
> +			    "eea reset: start queue failed. err %d\n", err);

I'm unsure why you ignore my feedback on v2 WRT errors generated here?

> +
> +	return err;
> +}
> +
> +int eea_queues_check_and_reset(struct eea_device *edev)
> +{
> +	struct eea_aq_dev_status *dstatus __free(kfree) = NULL;
> +	struct eea_aq_queue_status *qstatus;
> +	struct eea_aq_queue_status *qs;
> +	bool need_reset = false;
> +	int num, i, err = 0;
> +
> +	num = edev->enet->cfg.tx_ring_num * 2 + 1;

The above should probably moved under the RTNL lock or you could access
stale values.

> +
> +	rtnl_lock();
> +
> +	dstatus = eea_adminq_dev_status(edev->enet);
> +	if (!dstatus) {
> +		netdev_warn(edev->enet->netdev, "query queue status failed.\n");


		err = -ENOMEM;
		goto out_unlock;


> +		rtnl_unlock();
> +		return -ENOMEM;
> +	}
> +
> +	if (le16_to_cpu(dstatus->link_status) == EEA_LINK_DOWN_STATUS) {
> +		eea_netdev_stop(edev->enet->netdev);
> +		edev->enet->link_err = EEA_LINK_ERR_LINK_DOWN;
> +		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n");
> +		rtnl_unlock();
> +		return 0;

		goto out_unlock;

> +	}
> +
> +	qstatus = dstatus->q_status;
> +
> +	for (i = 0; i < num; ++i) {
> +		qs = &qstatus[i];
> +
> +		if (le16_to_cpu(qs->status) == EEA_QUEUE_STATUS_NEED_RESET) {
> +			netdev_warn(edev->enet->netdev,
> +				    "queue status: queue %u needs to reset\n",
> +				    le16_to_cpu(qs->qidx));
> +			need_reset = true;
> +		}
> +	}
> +
> +	if (need_reset)
> +		err = eea_reset_hw_resources(edev->enet, NULL);
> +

out_unlock:> +	rtnl_unlock();
> +	return err;


[...]> +/* ha handle code */
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
> +	/* Ha interrupt is triggered, so there maybe some error, we may need to
> +	 * reset the device or reset some queues.
> +	 */
> +	dev_warn(&ep_dev->pci_dev->dev, "recv ha interrupt.\n");
> +
> +	if (ep_dev->reset_pos) {
> +		pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> +				     &reset);
> +		/* clear bit */
> +		pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos,
> +				      0xFFFF);
> +
> +		if (reset & EEA_PCI_CAP_RESET_FLAG) {
> +			dev_warn(&ep_dev->pci_dev->dev,
> +				 "recv device reset request.\n");
> +
> +			pci_dev = ep_dev->pci_dev;
> +
> +			/* The pci remove callback may hold this lock. If the
> +			 * pci remove callback is called, then we can ignore the
> +			 * ha interrupt.
> +			 */
> +			if (mutex_trylock(&edev->ha_lock)) {
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

Nesting here is quite high, possibly move the above in a separate helper.

> +			}
> +			return;
> +		}
> +	}
> +
> +	eea_queues_check_and_reset(&ep_dev->edev);
> +}


I'm sorry, EPATCHISTOOBIG I can't complete the review even in with an
unreasonable amount of time.

/P


