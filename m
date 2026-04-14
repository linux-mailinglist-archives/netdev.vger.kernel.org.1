Return-Path: <netdev+bounces-278249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kImrIZuI3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:21:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBCA3F468F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37455300899D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7301C84DC;
	Tue, 14 Apr 2026 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSTarZRc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B7198E91;
	Tue, 14 Apr 2026 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126105; cv=none; b=LaKYLi1TRx/biajW7nJrqsuv9wJjQNtEipSiXtVPs+F3znHCa4A7t4Y4sfSvZ5o9EjVCYzt4bjmML3aFS4Xb4Z+9wjgPoKLhpqvk6q0sYW1nlceiUHgCdPJdXqwX82cm0rZENXKbY6yDjEAYNCFREhfm2rfzN22IP2XrxUYxFr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126105; c=relaxed/simple;
	bh=tgpexcGJxojFj1jsjKX9GvXbFRVwgWeAiHvWhfxxnsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCDCgiXBkcWJxrXtIlM1Itzjo5t+HK5T18l1touqQlNHhKtDEmh5ZHpR0Fk+eSLxpVCXaIF7K3SUzWgb8rwelTMcobxCUsXIL+QfvRxiDmrAOz34Uw/Su9CdjcPx04crltkfFo5VzucyLBocpu7TQIcBISXQDQ8dL4nNT9Fy6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSTarZRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE82C2BCAF;
	Tue, 14 Apr 2026 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126104;
	bh=tgpexcGJxojFj1jsjKX9GvXbFRVwgWeAiHvWhfxxnsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSTarZRcrheL7jbmi/VOV23tAua95U0x534hLdQM8VXc2qz93HkvlwjLfV1Nq4w1a
	 VdshbBhDv5YY/xmTR76dqzxZBIOCsWAcjai1EksLGwvFhadZpRriIyuSUiu+F0tGbw
	 Ei7E5YLR2lUUUCpV4RtsSTK9Ag+f8XSjIIKxs+25M7whatDO+Jn1Q7P11nwuEbu3WX
	 i93Y9bx5bNkaC94G+nRtesh2+Ffnzm6dke0mqN/fcELIDPEC7q19cIbr1bc0ObYn+2
	 B1Q8LpaRwUoiAKXjDaMpE+qxX4Nls/5eehgVLwoDfYeSsGXIEjBeNV23JnoK3WyDIG
	 pmGfKMP58PwXA==
From: Jakub Kicinski <kuba@kernel.org>
To: devnull+satishkh.cisco.com@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com,
	satishkh@cisco.com
Subject: Re: [PATCH net-next v4 04/10] enic: add admin CQ service with MSI-X interrupt and NAPI polling
Date: Mon, 13 Apr 2026 17:21:33 -0700
Message-ID: <20260414002133.3734391-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411-enic-sriov-v2-admin-channel-v2-v4-4-f052326c2a57@cisco.com>
References: <20260411-enic-sriov-v2-admin-channel-v2-v4-4-f052326c2a57@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278249-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,satishkh.cisco.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BBCA3F468F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
enic: add admin CQ service with MSI-X interrupt and NAPI polling

Add completion queue service for the admin channel WQ and RQ, driven
by an MSI-X interrupt and NAPI polling.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
> index a8fcd5f116d17..345d194c6eebe 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_admin.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
[ ... ]
> @@ -83,6 +85,207 @@ static void enic_admin_rq_drain(struct enic *enic)
>  	vnic_rq_clean(&enic->admin_rq, enic_admin_rq_buf_clean);
>  }
>  
[ ... ]
> +unsigned int enic_admin_rq_cq_service(struct enic *enic, unsigned int budget)
> +{
> +	struct vnic_cq *cq = &enic->admin_cq[1];
> +	struct vnic_rq *rq = &enic->admin_rq;
> +	struct vnic_rq_buf *buf;
> +	unsigned int work = 0;
> +	void *desc;
> +
> +	desc = vnic_cq_to_clean(cq);
> +	while (work < budget &&
> +	       enic_admin_cq_color(desc, cq->ring.desc_size) !=
> +	       cq->last_color) {
> +		/* Ensure CQ descriptor fields are read after
> +		 * the color/valid check.
> +		 */
> +		rmb();
> +		buf = rq->to_clean;
> +
> +		dma_sync_single_for_cpu(&enic->pdev->dev,
> +					buf->dma_addr, buf->len,
> +					DMA_FROM_DEVICE);
> +
> +		enic_admin_msg_enqueue(enic, buf->os_buf, buf->len);

Does this code expose uninitialized kernel heap memory?

The driver reads the completion queue descriptor but does not decode it to
determine the actual number of bytes written by the hardware. Instead, it
passes the full buf->len (2048 bytes) to enic_admin_msg_enqueue().

Since enic_admin_rq_post_one() allocates the receive buffers using kmalloc()
without __GFP_ZERO, passing the full 2048 bytes copies uninitialized kernel
memory following the actual packet payload.

> +
> +		enic_admin_rq_buf_clean(rq, rq->to_clean);
> +		rq->to_clean = rq->to_clean->next;
> +		rq->ring.desc_avail++;
> +
> +		vnic_cq_inc_to_clean(cq);
> +		work++;
> +		desc = vnic_cq_to_clean(cq);
> +	}
> +
> +	enic_admin_rq_fill(enic, GFP_ATOMIC);

Can this lead to a permanent receive queue stall?

Every processed receive buffer is unconditionally unmapped and freed via
enic_admin_rq_buf_clean() above. If enic_admin_rq_fill() fails due to memory
pressure, it silently returns an error and no replacement buffers are posted.

Because the original buffers were destroyed rather than recycled, and there
is no deferred retry mechanism, the descriptors are permanently lost. Repeated
transient failures will empty the RQ and permanently deadlock the admin channel.

[ ... ]
> @@ -128,23 +331,8 @@ static int enic_admin_alloc_resources(struct enic *enic)
>  	if (err)
>  		goto free_cq0;
>  
> -	/* PFs have dedicated SRIOV_INTR resources for admin channel.
> -	 * VFs lack SRIOV_INTR; use a regular INTR_CTRL slot instead.
> -	 */
> -	if (vnic_dev_get_res_count(enic->vdev, RES_TYPE_SRIOV_INTR) >= 1)
> -		err = vnic_intr_alloc_with_type(enic->vdev,
> -						&enic->admin_intr, 0,
> -						RES_TYPE_SRIOV_INTR);
> -	else
> -		err = vnic_intr_alloc(enic->vdev, &enic->admin_intr,
> -				      enic->intr_count);
> -	if (err)
> -		goto free_cq1;
> -
>  	return 0;

Will this removal break the admin channel on Physical Functions (PFs)?

Because PFs frequently have all their standard INTR_CTRL slots consumed by
regular networking queues, they rely on the dedicated SRIOV_INTR slot for
the admin channel.

Removing this fallback means enic_admin_setup_intr() might fail its bounds
check or vnic_intr_alloc() might fail, breaking initialization.

[ ... ]
> @@ -165,10 +353,32 @@ static void enic_admin_free_resources(struct enic *enic)
>  
>  static void enic_admin_init_resources(struct enic *enic)
>  {
> +	unsigned int intr_offset = enic->admin_intr_index;
> +
>  	vnic_wq_init(&enic->admin_wq, 0, 0, 0);
>  	vnic_rq_init(&enic->admin_rq, 1, 0, 0);
> -	vnic_cq_init(&enic->admin_cq[0], 0, 1, 0, 0, 1, 0, 1, 0, 0, 0);
> -	vnic_cq_init(&enic->admin_cq[1], 0, 1, 0, 0, 1, 0, 1, 0, 0, 0);
> +	vnic_cq_init(&enic->admin_cq[0],
> +		     0 /* flow_control_enable */,
> +		     1 /* color_enable */,
> +		     0 /* cq_head */,
> +		     0 /* cq_tail */,
> +		     1 /* cq_tail_color */,
> +		     1 /* interrupt_enable */,

Could setting interrupt_enable to 1 on the transmit completion queue (admin_cq[0])
cause an interrupt storm?

When a transmit completion occurs, it asserts the admin MSI-X interrupt and
schedules the NAPI poll routine (enic_admin_napi_poll). However, the NAPI
poll routine only services the receive queue (admin_cq[1]) and never clears
the event for admin_cq[0].

Since NAPI unmasks the interrupt upon completion, the uncleared transmit
completion would immediately re-trigger the interrupt.

[ ... ]
> @@ -187,12 +397,24 @@ int enic_admin_channel_open(struct enic *enic)
>  		return err;
>  	}
>  
> +	err = enic_admin_setup_intr(enic);
> +	if (err) {
> +		netdev_err(enic->netdev,
> +			   "Admin channel requires MSI-X, SR-IOV unavailable: %d\n",
> +			   err);
> +		goto free_resources;
> +	}
> +
> +	spin_lock_init(&enic->admin_msg_lock);
> +	INIT_LIST_HEAD(&enic->admin_msg_list);
> +	INIT_WORK(&enic->admin_msg_work, enic_admin_msg_work_handler);

Can a race condition occur here?

enic_admin_setup_intr() calls request_irq(), which registers the interrupt
handler and enables the IRQ line. If an interrupt fires immediately upon
registration, the ISR will schedule NAPI, which calls enic_admin_rq_cq_service().

NAPI would then attempt to acquire the uninitialized spinlock, modify the
uninitialized list, and schedule the uninitialized workqueue. Should the data
structures be initialized before requesting the interrupt?

[ ... ]
>  	return 0;
>  
>  disable_queues:
> +	enic_admin_teardown_intr(enic);
>  	vnic_wq_disable(&enic->admin_wq);
>  	vnic_rq_disable(&enic->admin_rq);
>  	enic_admin_qp_type_set(enic, 0);
>  	enic_admin_rq_drain(enic);
> +free_resources:
>  	enic_admin_free_resources(enic);
>  	return err;
>  }

Does the disable_queues error path leak queued messages?

If initialization fails after enic_admin_setup_intr() is called (for example,
during enic_admin_rq_fill()), the code branches to disable_queues. By this time,
the MSI-X interrupt and NAPI have been enabled.

If an interrupt fired and scheduled NAPI, messages could be added to
admin_msg_list and admin_msg_work could be scheduled. The error path does not
call cancel_work_sync(&enic->admin_msg_work) or enic_admin_msg_drain(enic),
which are required to stop the deferred work.

