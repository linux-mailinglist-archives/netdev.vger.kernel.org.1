Return-Path: <netdev+bounces-266010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHLKJzf5r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:57:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8C249D26
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6284D3087C39
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C52379997;
	Tue, 10 Mar 2026 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4v2VjB/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81E36E47E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139909; cv=none; b=At100z6Dmj8Hd4nk/UFcf9c7R3/REubJf+DMLGk6jLz0s30jBZyS71i4kxb62Dts8GeKueQ/3oYu+ZPIMTxkbTfHL+DaadjUV+Hs30fMpc0TYe9IaLFgmieLHkh9CK5uri5G0Y3nYvUGKDGptT8LoUNYjvLRrzXqNq86ZeKbr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139909; c=relaxed/simple;
	bh=iCthyEbs4qL5//qCDSmTJYB59LoErQYQ/NLPVHYahFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNVDaiOpxk2eM+sYYZ+MkK4CoP0in9d6kzutUypsL9G5LJgkrVWLnm6w7OrFlHMsjcwCbcmGKIOnm3+earRfK+oJFa3mneS0hn+uF0+BG+Lvy3VsGJGPxgs8HZDtLF8ZW1/QGKW/WbrQ5NI6dh9RQLfhoopllIDJpWnnf1tq9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4v2VjB/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773139906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmxaYQwdX0pNQ0ouRn9aWVbVIzE4xQyxEMU6u3LVzs0=;
	b=E4v2VjB/GyikHBoKW+hW4YcxyiuQSb4E+VMyRkHgr5fRA/GRGib+Sq0WnUEey5vvbgvf32
	VDZ5CSa+zcitUKONntYQXrvUxg4mqim9paUrR+0VY4q7DhB8O0SFLu+AphJlhTfpv4QBWT
	b89cELOF+PUyeaMJCZBB6PxxbGUm+c0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-l1k_SNAQMdGZdmB5nD-WBw-1; Tue,
 10 Mar 2026 06:51:45 -0400
X-MC-Unique: l1k_SNAQMdGZdmB5nD-WBw-1
X-Mimecast-MFC-AGG-ID: l1k_SNAQMdGZdmB5nD-WBw_1773139902
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F1A2195609D;
	Tue, 10 Mar 2026 10:51:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCF0A1800759;
	Tue, 10 Mar 2026 10:51:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jiawenwu@trustnetic.com
Cc: kees@kernel.org,
	michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	richardcochran@gmail.com,
	mengyuanlou@net-swift.com,
	jacob.e.keller@intel.com,
	joe@dama.to,
	linux@armlinux.org.uk,
	abdun.nihaal@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	davem@davemloft.net,
	larysa.zaremba@intel.com,
	netdev@vger.kernel.org,
	leitao@debian.org
Subject: Re: [net-next,v4,09/10] net: wangxun: add Tx timeout process
Date: Tue, 10 Mar 2026 11:51:27 +0100
Message-ID: <20260310105127.167195-1-pabeni@redhat.com>
In-Reply-To: <20260306063211.20536-10-jiawenwu@trustnetic.com>
References: <20260306063211.20536-10-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 15D8C249D26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266010-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,redhat.com,lunn.ch,gmail.com,net-swift.com,intel.com,dama.to,armlinux.org.uk,google.com,davemloft.net,vger.kernel.org,debian.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wangxun: add Tx timeout process

This commit implements .ndo_tx_timeout to handle Tx side timeout events.
When a Tx timeout occurs, it triggers a driver reset process.

> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index a71b0ad77de3..c8724bb129aa 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,5 +4,5 @@
>
>  obj-$(CONFIG_LIBWX) += libwx.o
>
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o wx_err.o
>  libwx-objs += wx_vf.o wx_vf_lib.o wx_vf_common.o
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_err.c b/drivers/net/ethernet/wangxun/libwx/wx_err.c
> new file mode 100644
> index 000000000000..bb77bdce69d2
> --- /dev/null
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_err.c

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index c65240ca3c28..5a21478a592b 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c

[ ... ]

> @@ -742,6 +743,48 @@ static struct netdev_queue *wx_txring_txq(const struct wx_ring *ring)
>  	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
>  }
>
> +static u64 wx_get_tx_pending(struct wx_ring *ring)
> +{
> +	unsigned int head, tail;
> +
> +	head = ring->next_to_clean;
> +	tail = ring->next_to_use;
> +
> +	return ((head <= tail) ? tail : tail + ring->count) - head;
> +}
> +
> +bool wx_check_tx_hang(struct wx_ring *ring)
> +{
> +	u64 tx_done_old = ring->tx_stats.tx_done_old;
> +	u64 tx_pending = wx_get_tx_pending(ring);
> +	u64 tx_done = ring->stats.packets;
> +
> +	clear_bit(WX_TX_DETECT_HANG, ring->state);
> +
> +	/*
> +	 * Check for a hung queue, but be thorough. This verifies
> +	 * that a transmit has been completed since the previous
> +	 * check AND there is at least one packet pending. The
> +	 * ARMED bit is set to indicate a potential hang. The
> +	 * bit is cleared if a pause frame is received to remove
> +	 * false hang detection due to PFC or 802.3x frames. By
> +	 * requiring this to fail twice we avoid races with
> +	 * pfc clearing the ARMED bit and conditions where we
> +	 * run the check_tx_hang logic with a transmit completion
> +	 * pending but without time to complete it yet.
> +	 */

The comment here mentions that "the bit is cleared if a pause frame is
received to remove false hang detection due to PFC or 802.3x frames."
However, I don't see any code in the wangxun driver that clears
WX_HANG_CHECK_ARMED when pause frames are received.

Looking at where WX_HANG_CHECK_ARMED is used in the driver:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_check_tx_hang() {
    ...
    clear_bit(WX_TX_DETECT_HANG, ring->state);
    ...
    if (tx_done_old == tx_done && tx_pending)
        return test_and_set_bit(WX_HANG_CHECK_ARMED, ring->state);
    ...
    clear_bit(WX_HANG_CHECK_ARMED, ring->state);
    return false;
}

The bit is only cleared within wx_check_tx_hang() itself when packets
have completed or when there are no pending packets. The driver does
support flow control (both ngbe and txgbe implement get_pauseparam and
set_pauseparam and advertise MAC_SYM_PAUSE/MAC_ASYM_PAUSE capabilities).

Won't legitimate TX stalls caused by pause frames be misidentified as
hangs after two service timer intervals, triggering unnecessary adapter
resets? The ixgbe driver this appears to be based on has
ixgbe_update_xoff_received() which clears __IXGBE_HANG_CHECK_ARMED when
flow control pause frames are received.

Should the wangxun driver implement similar pause frame handling to
prevent false hang detections, or should the comment be updated to
reflect the current behavior?

> +	if (tx_done_old == tx_done && tx_pending)
> +		/* make sure it is true for two checks in a row */
> +		return test_and_set_bit(WX_HANG_CHECK_ARMED, ring->state);
> +
> +	/* update completed stats and continue */
> +	ring->tx_stats.tx_done_old = tx_done;
> +	/* reset the countdown */
> +	clear_bit(WX_HANG_CHECK_ARMED, ring->state);
> +
> +	return false;
> +}

[ ... ]


