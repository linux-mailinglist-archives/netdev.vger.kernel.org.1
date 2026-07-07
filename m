Return-Path: <netdev+bounces-305391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q2QWEQzMTGqXpwEAu9opvQ
	(envelope-from <netdev+bounces-305391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:51:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E80719F83
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=dLtxi9c7;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305391-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305391-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C9A23003349
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535893D6CA0;
	Tue,  7 Jul 2026 09:51:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B089938E8BE
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:51:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783417863; cv=none; b=dnCGlWoWYIk5KLBxDEge9rOyR8h2es2e+g3pXO4/ITgqFoj2oev74CDaT/dnJN4xtEFKRQ2zrMcFziBdVqNAONXNaZM2dDtMt5VrkHoyfoyKujMEKhA+5veRHi36VyA8T50olThZ/G93EunuIQU08Cv7PqbmAWIRMRcyUOV088o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783417863; c=relaxed/simple;
	bh=aJQ0ly8Annqu7wUcM1h0Q+vrgFGwD26kho9OopYkqgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osMKd+W5578gPLKD41DRIaHYNqYCf7Todd2axIewTzTUGZpmKDqyu3Uf4MVk8J4Wx+4f9+k0haiG6V4iBDxs34ZtseaUTG8cjujOhnG0CzLzYHuejnVnIeAlTDCsLK2UJJYL+0CdAgplSC3LryIKSF03oHiX9iNuXKS3IdvRQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLtxi9c7; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783417860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vu1zjMfca5o2RwKPRfJ6pXG1LSs6VoyCrJkHKRwc3r8=;
	b=dLtxi9c7Qfq7R+zOKfI8NsylwVmV+ajJ7gpR+dzRbN6SGfOsVsa5GkcgWmJAdCAe4W5tqq
	AHX2hpEoGnHUQWzh1vpt/ICGyJxQnGc+wETP1BN1qOOVepW8s2DVHJPkjmF3EXdw2BCl/L
	gyMX+jNZLxktXUV5hRvw/2KnOwDcLok=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-6IQHRQ3fMoiXa-mkp23Czw-1; Tue,
 07 Jul 2026 05:50:57 -0400
X-MC-Unique: 6IQHRQ3fMoiXa-mkp23Czw-1
X-Mimecast-MFC-AGG-ID: 6IQHRQ3fMoiXa-mkp23Czw_1783417856
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 492271801322;
	Tue,  7 Jul 2026 09:50:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.253])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 695891955F71;
	Tue,  7 Jul 2026 09:50:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mengyuanlou@net-swift.com
Cc: netdev@vger.kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v6 3/3] net: libwx: support vf per-queue statistics via ethtool -S
Date: Tue,  7 Jul 2026 11:50:46 +0200
Message-ID: <20260707095046.104606-1-pabeni@redhat.com>
In-Reply-To: <20260701100145.23738-4-mengyuanlou@net-swift.com>
References: <20260701100145.23738-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305391-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,net-swift.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2E80719F83

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
Now I have enough information to produce the report.

commit e59c58bb080afb34cac34c91b8c320a1f05134e6
Author: Mengyuan Lou <mengyuanlou@net-swift.com>

net: libwx: support vf per-queue statistics via ethtool -S

The patch wires wx_get_sset_count, wx_get_strings, and wx_get_ethtool_stats
into wx_ethtool_ops_vf, adds a small vf-only global stats table, and starts
calling wx_update_stats() from wxvf_service_task. It also adds NULL checks
for wx->rx_ring[i] / wx->tx_ring[i] inside wx_update_stats.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> index 22037f015ded..f72908630ea4 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c

[ ... ]

> @@ -114,7 +133,7 @@ void wx_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
>  			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
>  			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
>  		}
> -		for (i = 0; i < WX_NUM_RX_QUEUES; i++) {
> +		for (i = 0; i < WX_NUM_RX_QUEUES(netdev); i++) {
>  			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
>  			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
>  		}

[ ... ]

> @@ -852,6 +878,9 @@ static const struct ethtool_ops wx_ethtool_ops_vf = {
>  	.set_coalesce		= wx_set_coalesce,
>  	.get_ts_info		= ethtool_op_get_ts_info,
>  	.get_link_ksettings	= wx_get_link_ksettings_vf,
> +	.get_sset_count		= wx_get_sset_count,
> +	.get_strings		= wx_get_strings,
> +	.get_ethtool_stats	= wx_get_ethtool_stats,
>  };

[Medium]
Before this change wx_ethtool_ops_vf had no get_sset_count / get_strings /
get_ethtool_stats callbacks, so the VF exposed no ethtool -S output at all.
Wiring these in also picks up the shared per-queue string loop that emits
tx_queue_%u_packets / tx_queue_%u_bytes and rx_queue_%u_packets /
rx_queue_%u_bytes.

Per-queue TX/RX packet and byte counters are a category that already has a
standard uAPI (netdev_stat_ops with queue_stats_rx / queue_stats_tx,
surfaced by netlink and ynl). Documentation/networking/statistics.rst and
the ethtool -S guidance state that new counters covering values that have a
standard uAPI should not be added to ethtool -S even when the driver does
not yet implement the standard interface.

The wangxun tree does not implement netdev_stat_ops (no
get_base_stats / get_queue_stats_rx / get_queue_stats_tx callbacks are
present under drivers/net/ethernet/wangxun/).

Would it be preferable to expose the per-queue counters on the VF via
netdev_stat_ops instead of adding them to ethtool -S here?

>  void wx_set_ethtool_ops_vf(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 260e14d5d541..349afbe60132 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -2886,6 +2886,8 @@ void wx_update_stats(struct wx *wx)
>  	for (i = 0; i < wx->num_rx_queues; i++) {
>  		struct wx_ring *rx_ring = wx->rx_ring[i];
>  
> +		if (!rx_ring)
> +			continue;
>  		non_eop_descs += rx_ring->rx_stats.non_eop_descs;

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> index 26de78e9a69e..1d84fe35d7d9 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
> @@ -409,6 +410,7 @@ static void wxvf_service_task(struct work_struct *work)
>  
>  	wxvf_link_config_subtask(wx);
>  	wxvf_reset_subtask(wx);
> +	wx_update_stats(wx);
>  	wx_service_event_complete(wx);
>  }

[High]
Can this call race with VF PCI suspend and shutdown to produce a
use-after-free on wx->rx_ring[i] / wx->tx_ring[i]?

Both ngbevf and txgbevf use wxvf_suspend as their PM suspend callback and
wxvf_shutdown (which calls wxvf_suspend) as their pci_driver ->shutdown
callback:

    static DEFINE_SIMPLE_DEV_PM_OPS(ngbevf_pm_ops, wxvf_suspend, wxvf_resume);
    ...
    .shutdown = wxvf_shutdown,

wxvf_suspend() in wx_vf_common.c does:

    int wxvf_suspend(struct device *dev_d)
    {
        struct pci_dev *pdev = to_pci_dev(dev_d);
        struct wx *wx = pci_get_drvdata(pdev);

        netif_device_detach(wx->netdev);
        wx_clear_interrupt_scheme(wx);
        pci_disable_device(pdev);

        return 0;
    }

wx_clear_interrupt_scheme() ends up freeing the q_vectors (via
kfree_rcu), and the ring allocations are embedded in the q_vector, so
wx->rx_ring[i] / wx->tx_ring[i] end up pointing at memory that will be
freed after an RCU grace period.

wxvf_suspend / wxvf_shutdown do not call timer_shutdown_sync on
wx->service_timer or cancel_work_sync on wx->service_task, and they do
not set WX_STATE_DOWN.

With this hunk in place, the service_task now walks wx->rx_ring[] and
wx->tx_ring[]:

    void wx_update_stats(struct wx *wx)
    {
        ...
        for (i = 0; i < wx->num_rx_queues; i++) {
            struct wx_ring *rx_ring = wx->rx_ring[i];

            if (!rx_ring)
                continue;
            non_eop_descs += rx_ring->rx_stats.non_eop_descs;
            ...
        }
        ...
        for (i = 0; i < wx->num_tx_queues; i++) {
            struct wx_ring *tx_ring = wx->tx_ring[i];

            if (!tx_ring)
                continue;
            restart_queue += tx_ring->tx_stats.restart_queue;
            ...
        }

If the service_task latches a non-NULL rx_ring / tx_ring pointer just
before wx_clear_interrupt_scheme runs, the added NULL check does not
help, and the subsequent ->rx_stats / ->tx_stats reads touch memory
that has been kfree_rcu'd. wxvf_remove() covers this by calling
timer_shutdown_sync + cancel_work_sync before wx_clear_interrupt_scheme,
but wxvf_suspend / wxvf_shutdown do not.

Should wxvf_suspend (and hence wxvf_shutdown) quiesce the service_timer
and service_task, or set WX_STATE_DOWN, before wx_clear_interrupt_scheme
now that wx_update_stats is on the service_task's call path?
-- 
This is an AI-generated review.


