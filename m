Return-Path: <netdev+bounces-282697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGBUC8ER82k7xAEAu9opvQ
	(envelope-from <netdev+bounces-282697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:24:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 852CF49F352
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 10:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64F430125E6
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF12C2349;
	Thu, 30 Apr 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXn3uHf9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9KqPhnX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23925A2A4
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537470; cv=none; b=FKdUqDpuAKeQPQ3lTnvIDtlbjARzhGLG6yjAixtWzRAQUkSdQtPeIZvXFHj/mS8xQWA1OudqGkD8SLFSIE2vDdKMpvYhXVfn38Vi/5GUFC1tGisDrOM/YZ8lk3EasgdHK9KwU9ZWxC2yLtZe5b/wUf9J9+Gxd/rnsMEzHXgESqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537470; c=relaxed/simple;
	bh=jjidWdW0YWSV+wkMhkXcGYqkGoHqXZyXLu+qBjBHHD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkUXoYnw+4jMEjV1qg4O006dueFyt7EDfbCTQUkavZvcuR0IUL/T6MJ2onhlqHGWb745Zt3WMNJlWBzaf3wU8JYynN82Dz6lKkoRimHIL+UJ0sjp6nLJb7ezSb7JoLFQkEQiKlcVVot6RALKsGwG7OjvHxp4/b6Ty3+SdqCma1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXn3uHf9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9KqPhnX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777537467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVCaEm6muV7wKha/pOtJeifcwpGgdooKYnz79e+lKwk=;
	b=KXn3uHf9qKXPB3FsqmAjeEzy4KoIXxhjzJ52GMI9pI26RRLuqYdMX9PKOfk7VrF1P5y3nk
	jPXtPkQevJVkaOVz+AW1dn9KktAEIESUMM77LOhtqO13E1qTB7PEqv5LLADX+wA65qxUB+
	Pz2bXDNuTjx2DXve7UOElto8O2grs1Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-sjpqXU67Nqit46IPhV65HQ-1; Thu, 30 Apr 2026 04:24:26 -0400
X-MC-Unique: sjpqXU67Nqit46IPhV65HQ-1
X-Mimecast-MFC-AGG-ID: sjpqXU67Nqit46IPhV65HQ_1777537465
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5adc12ffso3918685e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777537465; x=1778142265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVCaEm6muV7wKha/pOtJeifcwpGgdooKYnz79e+lKwk=;
        b=b9KqPhnXVs2mQqicBgUilVfhNDDD5YFF1t3PRx10h0ScAGCRTRSwcE9+jh1r2gqRTw
         P/9bDz4P9Kxgc2F9fp7A6ZvTbbzUKQ03p/UU1c5eFi/ebwkJhiWuzT+JdX747sQzkoHe
         NkEyApNFg1yuAqdvo7PFVCTnWu/FBYh2LQPKP44uryerJU+iWoBwr/lJcvF11cQoXS44
         g08Sy/lLV+dIQwQqSUjUmKJ1Oa8OYzChrbI75/Zq5EAXtGtiNe4hg4Yp8JyOvFj7lP0c
         3YFXIyzG9MgovknLY1WZYm/m3GIeJsiIzGtxraObMVA5OxvTIHgkyBqF6uyPr9tjCboP
         InDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777537465; x=1778142265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVCaEm6muV7wKha/pOtJeifcwpGgdooKYnz79e+lKwk=;
        b=nT1Zsho6Ni4Ppt21dKFOz41zFAmFLbahMtExfGpev8y9AMCcfRHiTP76SO7mSacHee
         owCYbxUEuw8gOz4A10T722SYUGmI5xdkNzJwCe7P9bASrzKIeftwvizaMlGo4gBYR9XO
         OSWO7Kyi404tEG8skam25QYIEYwErhqOtl311jGDNxgvR6lbLZ0QQZt3zoZhSSG8I9W9
         NcYAgqHwX4Xca4qEZKGsDvCwcun89ixAR1azwA1RBTTw4tFxeWMEtHxxsRgN1KHVO9fI
         zuzo+GhuKyyzUNYl2roXdpXk3/7JxZNUEkcmq3vze8qTCK6Se+Eyp3QfyqOL8aljd2vv
         8+UQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C1jRB0AE9T+6R483GsrQiedX5j2myrq3S43Dkn9NLn49JjKT3xrb4rKktLwZH/Cj25GDwpNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztf58cfJ+bs7VTKnXXwmnQ1qvOfpbhd4l9ne6grNKggaze7hvP
	VaBtCp9SEAryEj0yQuqw7CmLuXX0Q9w9BdwFnnd7tGBGV+I/fkEGb50j2bycIb5u3zRYMTyeW7b
	/x3R6a4C+x/HDLd5QAcDL2cDLdgmefEArnOgHbk/uUa2LuVtAR9RRYK4dxA==
X-Gm-Gg: AeBDiev+EiP+M12Yr0yh6eyKDBR4SJMGl0edhIcFtW1m5O+o1q5PYfv+/yVkRAZ5uJp
	XaprPFOcT3e7vAjqjW+2K77mND95ejeZ3voaQtIDAVwP83yTV5QJxGc6JyZjCMAiMSj07vECSV6
	hywy8d0yORXnzWbA1U9usxDaXzQ33ZMqaTdznKmmDevihNzH4L6D3B0WNnKGKyaHsboPgFGNthc
	moj8GFvlGopUOp6uwgZ4f2nfERCcGuA5y6gKLNb6dhDyIZzNvJPUw0Ungs+Afte6ZYD2oWVpS4V
	gTc/VYUCWv9C0W1GLYTjD71wClXIjTFvRCpFJ0kXp1SnPewE7Djx9f7BQzwNWcoBdvYzthenTrD
	+Azf+JH18CJgEJr+3iFpEol/A9tCibi2VkVUJhGunfKnhuy1SPFoRxwH7hgMUMksCcA==
X-Received: by 2002:a05:600c:8b0d:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48a8451d095mr30957275e9.13.1777537464856;
        Thu, 30 Apr 2026 01:24:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0d:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48a8451d095mr30956725e9.13.1777537464289;
        Thu, 30 Apr 2026 01:24:24 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c71f2sm72738455e9.5.2026.04.30.01.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 01:24:23 -0700 (PDT)
Message-ID: <fb036ffe-b2da-4e9a-a3f4-0f0e467b9e25@redhat.com>
Date: Thu, 30 Apr 2026 10:24:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/5] net: wangxun: add Tx timeout process
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Breno Leitao <leitao@debian.org>,
 Joe Damato <joe@dama.to>, Jacob Keller <jacob.e.keller@intel.com>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
References: <20260428021156.13564-1-jiawenwu@trustnetic.com>
 <20260428021156.13564-3-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428021156.13564-3-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 852CF49F352
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,intel.com,debian.org,dama.to];
	TAGGED_FROM(0.00)[bounces-282697-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/28/26 4:11 AM, Jiawen Wu wrote:
> +static void wx_reset_subtask(struct wx *wx)
> +{
> +	if (!test_bit(WX_FLAG_NEED_PF_RESET, wx->flags))
> +		return;
> +
> +	rtnl_lock();
> +
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;

Sashiko says:

Does this early return path leak the rtnl_lock?
If the interface is brought down concurrently while a reset is scheduled,
it appears this would return without calling rtnl_unlock(). Since all
network
configuration operations require the RTNL lock, could this lead to a
system-wide deadlock in the networking subsystem?

> +
> +	wx_warn(wx, "Reset adapter.\n");
> +
> +	if (test_and_clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags)) {
> +		if (wx->do_reset)
> +			wx->do_reset(wx->netdev);
> +	}
> +
> +	rtnl_unlock();
> +}
> +
> +/*
> + * wx_check_tx_hang_subtask - check for hung queues and dropped interrupts
> + * @wx - pointer to the device wx structure
> + *
> + * This function serves two purposes.  First it strobes the interrupt lines
> + * in order to make certain interrupts are occurring.  Secondly it sets the
> + * bits needed to check for TX hangs.  As a result we should immediately
> + * determine if a hang has occurred.
> + */
> +static void wx_check_tx_hang_subtask(struct wx *wx)
> +{
> +	int i;
> +
> +	/* If we're down or resetting, just bail */
> +	if (!netif_running(wx->netdev) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +
> +	/* Force detection of hung controller */
> +	if (netif_carrier_ok(wx->netdev)) {
> +		for (i = 0; i < wx->num_tx_queues; i++)
> +			set_bit(WX_TX_DETECT_HANG, wx->tx_ring[i]->state);
> +	}
> +}
> +
> +void wx_handle_errors_subtask(struct wx *wx)
> +{
> +	wx_reset_subtask(wx);
> +	wx_check_tx_hang_subtask(wx);
> +}
> +EXPORT_SYMBOL(wx_handle_errors_subtask);
> +
> +static void wx_tx_timeout_reset(struct wx *wx)
> +{
> +	if (!netif_running(wx->netdev))
> +		return;
> +
> +	set_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	wx_warn(wx, "initiating reset due to tx timeout\n");
> +	wx_service_event_schedule(wx);
> +}
> +
> +void wx_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> +{
> +	struct wx *wx = netdev_priv(netdev);
> +	u32 head, tail;
> +	int i;
> +
> +	for (i = 0; i < wx->num_tx_queues; i++) {
> +		struct wx_ring *tx_ring = wx->tx_ring[i];
> +
> +		if (test_bit(WX_TX_DETECT_HANG, tx_ring->state) &&
> +		    wx_check_tx_hang(tx_ring))
> +			wx_warn(wx, "Real tx hang detected on queue %d\n", i);
> +
> +		head = rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx));
> +		tail = rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx));
> +		wx_warn(wx,
> +			"tx ring %d next_to_use is %d, next_to_clean is %d\n",
> +			i, tx_ring->next_to_use,
> +			tx_ring->next_to_clean);
> +		wx_warn(wx, "tx ring %d hw rp is 0x%x, wp is 0x%x\n",
> +			i, head, tail);
> +	}
> +
> +	wx_tx_timeout_reset(wx);
> +}
> +EXPORT_SYMBOL(wx_tx_timeout);
> +
> +void wx_handle_tx_hang(struct wx_ring *tx_ring, unsigned int next)
> +{
> +	struct wx *wx = netdev_priv(tx_ring->netdev);
> +
> +	wx_warn(wx, "Detected Tx Unit Hang\n"
> +		"  Tx Queue             <%d>\n"
> +		"  TDH, TDT             <%x>, <%x>\n"
> +		"  next_to_use          <%x>\n"
> +		"  next_to_clean        <%x>\n"
> +		"tx_buffer_info[next_to_clean]\n"
> +		"  time_stamp           <%lx>\n"
> +		"  jiffies              <%lx>\n",

It's better to use a single string for the whole message, even if it
would exceed the 80 chars limit

> +		tx_ring->queue_index,
> +		rd32(wx, WX_PX_TR_RP(tx_ring->reg_idx)),
> +		rd32(wx, WX_PX_TR_WP(tx_ring->reg_idx)),
> +		tx_ring->next_to_use, next,
> +		tx_ring->tx_buffer_info[next].time_stamp, jiffies);
> +
> +	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
> +
> +	wx_warn(wx, "tx hang detected on queue %d, resetting adapter\n",
> +		tx_ring->queue_index);

Possibly two warn messages for the same cause is a bit too verbose (same
in wx_tx_timeout()).

> +bool wx_check_tx_hang(struct wx_ring *ring)
> +{
> +	u32 tx_done_old = ring->tx_stats.tx_done_old;
> +	u32 tx_pending = wx_get_tx_pending(ring);
> +	u32 tx_done = ring->stats.packets;
> +
> +	clear_bit(WX_TX_DETECT_HANG, ring->state);

It looks like every caller checks WX_TX_DETECT_HANG, it would be
probably better to use test_and_clear_bit() here, and drop the test from
the caller.

/P


