Return-Path: <netdev+bounces-202782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B98AEF006
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912121BC58BE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9BD25DCF0;
	Tue,  1 Jul 2025 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D+e37poZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E125C6EE
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356129; cv=none; b=m2FBu+zexrQEr8oUtdUlNE1vdjGoTUow/DyuSs9q12JEdb3dqiJy+ly3KW56Qqt39hi3BUh6//iIvvIWrfpTnHCNXy45HmgEoAu9vVVd7CjRG8jVjUisUsrVpT49alfuc7doMR350GUihAIGP2pflXwicD7HoMPDLOWpB9uAvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356129; c=relaxed/simple;
	bh=yfyVRPQTE8JqiDbaOUKxGFIbx1q4UehpJFGONWIiHbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8PjqG/ZQN8786n8z68PXeB0axaa89Vt4E1KW/u6aO05InlAGJ462snkf/DtykvrwuYr+/tWB72ZAkn8WfUFUi3Asv17dlB9vxDRG0luEMLaJ4nPgXSZNS4h9RnAYWpDEY3AFMzJsO8wRVfNx11pmzFMSNdsVC2kurtmDlcBarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D+e37poZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso1915887a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751356127; x=1751960927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEpFKt7YYcFzTPMsl+PrVIXjmxXbTAxWQl834MFcBTI=;
        b=D+e37poZ7ObDomrskbXZhXkWIiOk1YSqbJLLoZ2ZmKkJ2+ovir9J2RiyiV3TqHddtd
         vmQLpXJc0n3GLEqbiupHurA/VHHeXngP7cd59gKljSQBXjxB7g50eakFOL6XfXyIu0Hh
         Fv0ZXr2HPu6s/MYd1HF0eptn/qzHy5Zf6PZIRqMsAn8dffPsz3tbs925t/q0+Qi28kyP
         To/9yTKvAxmaQoydpoytGqEL6TcAN2VZdJX2USXRU1cIqTvZ4Z+NgfxkxFjO8Mp6P4eQ
         AQo7bdpHgopBAhiMsH8P31FixnWEhJrIpNyx1k9ZdKZ87fvr1RdLwJMYtcNwX0mUzuLZ
         R0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356127; x=1751960927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEpFKt7YYcFzTPMsl+PrVIXjmxXbTAxWQl834MFcBTI=;
        b=ZpJnPxnXMffn3hSGW//LEtjPxDNfs6PTJmIdX4QTU4joWtuOwP3tE15tA123RSOvz8
         m8eQACCcLg2yEvW8Y9aqM2b0vpFaDXHdq4DovrI7jzTN8NW2u4ZjTBZ0R42VD727k4cP
         7g0CPeKoBtEU8knM9cFu3iTydHUhhnX/m6rfgOQDP2UywsP9RaI9uV7dFDXKf+1vxiJS
         2a89qzWBs6OajlLoxaJKFoWW+k2RV4k5squoi8VGCzsh/DE34EBXxsIFrSBf6YNoGlb2
         jc6fJ7LJ2JaK2lWUWpPcX4VBUtHgzQ9mf8UPmOGB5oHp7JT7PT+5Dazx+EVMwcUtUb0d
         4SNg==
X-Forwarded-Encrypted: i=1; AJvYcCWyskdwPUFXxr9GLPyGmbe1QzPqBpkYhPEM3XLdaAwJr1UJybfuXcxLbyXqHsmbfhlRSXkkT0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC2tn28bvU1oXMq8JfUJjFxnlalAPIV/Wp7G1b7KL3ELb0Mtyz
	aXOTWVpVBmz3lnupLrAHDV8T+5P5cgllJ6NH98xqAsk0URFB4QFZqIgPFFu+Z6TKeM0=
X-Gm-Gg: ASbGncuFDqfRFiG5DrKIC7CO+mdoxvqqMoMLxXdMduSaVMM9ruGoVZpCPWFTv/cdTNE
	W1a6YqqFGGnFLhDqNZiIXw6EGb5DJY6e+G6wF+LPvy3FjMOE5TkiTIix5zViQektv0K+pH3ASM3
	XyvxJhp3T6VrUI54mTbJbPeQ9drbH+xty5ovXTkUR5ymDHSHqkHAtoauGikFFaJi2DxlolWPvGY
	TGwj8jdKD7q2dbbfINy468osMCXwN1QogPNZcSW8kAwjcFihQrFFCd2Yiwl7vCAEyTceyW8T9Gk
	S+HaVolTj9nykTl1OxY0V4O3k9mCmKp6dk1QsZvrf984bWWmXNeGZ0XaJdDjcdlCa5QG91hOcoI
	wOZDe
X-Google-Smtp-Source: AGHT+IEkSOMFIWuHzTsl3h9jkYp4/Xk30pqD6Wb6IEepi4SrOE2ToSdyXBQqLIMA/PtSl0WH+SMRvA==
X-Received: by 2002:a17:90b:2dd0:b0:312:db8:dbd1 with SMTP id 98e67ed59e1d1-318c8ff231fmr21355546a91.5.1751356127275;
        Tue, 01 Jul 2025 00:48:47 -0700 (PDT)
Received: from [10.74.31.243] ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a16besm10785331a91.14.2025.07.01.00.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 00:48:47 -0700 (PDT)
Message-ID: <f1f68fbd-e2cf-40c5-a6b8-533cb3ec798f@bytedance.com>
Date: Tue, 1 Jul 2025 15:48:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net] virtio-net: fix a rtnl_lock() deadlock
 during probing
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250630095109.214013-1-zuozhijie@bytedance.com>
 <20250630103240-mutt-send-email-mst@kernel.org>
 <20250630105328-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Zigit Zo <zuozhijie@bytedance.com>
In-Reply-To: <20250630105328-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/25 10:54 PM, Michael S. Tsirkin wrote:
> On Mon, Jun 30, 2025 at 10:50:55AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Jun 30, 2025 at 05:51:09PM +0800, Zigit Zo wrote:
>>> This bug happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while
>>> the virtio-net driver is still probing with rtnl_lock() hold, this will
>>> cause a recursive mutex in netdev_notify_peers().
>>>
>>> Fix it by skip acking the annouce in virtnet_config_changed_work() when
>>> probing. The annouce will still get done when ndo_open() enables the
>>> virtio_config_driver_enable().
>>
>> I am not so sure it will be - while driver is not loaded, device does
>> not have to send interrupts, and there's no rule I'm aware of that says
>> we'll get one after DRIVER_OK.

Yep, at first we're thinking that when the VIRTIO_NET_S_ANNOUNCE flag set,
we can always assure an interrupt has fired by VMM, to notify the driver
to do the announcement.

But later we realized that the S_ANNOUNCE flag can be sent before the
driver's probing, and for QEMU seems to set the status flag regardless of
whether driver is ready, so the problem you're talking still may happens.
>> How about, we instead just schedule the work to do it later?I'm not sure if scheduling the work later will break df28de7b0050, the work
was being scheduled before that commit, and we have no much idea of why that
commit removes the schedule_work, we just keep it for safe...

Then, for plan A, we change the check_announce to schedule_announce, and if
that's true, we do another schedule_work to call virtnet_config_changed_work
again to finish the announcement, like

	if (v & VIRTIO_NET_S_ANNOUNCE) {
		if (unlikely(schedule_announce))
			schedule_work(&vi->config_work);
		else {
			netdev_notify_peers(vi->dev);
			virtnet_ack_link_announce(vi);
		}
	}

>>
>> Also, there is another bug here.
>> If ndo_open did not run, we actually should not send any announcements.
>>
>> Do we care if carrier on is set on probe or on open?
>> If not, let's just defer this to ndo_open?
> 
> Hmm yes I think we do, device is visible to userspace is it not?
> 
> Hmm.  We can keep the announce bit set in vi->status and on open, check
> it and then schedule a work to do the announcement.

Okay, so there's a plan B, we save the bit and re-check it in ndo_open, like

	/* __virtnet_config_changed_work() */
	if (v & VIRTIO_NET_S_ANNOUNCE) {
		vi->status |= VIRTIO_NET_S_ANNOUNCE;
		if (unlikely(!check_announce))
			goto check_link;

		netdev_notify_peers(vi->dev);
		virtnet_ack_link_announce(vi);
		vi->status &= ~VIRTIO_NET_S_ANNOUNCE;
	}

	/* virtnet_open() */
	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
		if (vi->status & VIRTIO_NET_S_LINK_UP)
			netif_carrier_on(vi->dev);
		if
		if (vi->status & VIRTIO_NET_S_ANNOUNCE)
			schedule_work(&vi->config_work);
		virtio_config_driver_enable(vi->vdev);
	}

This is a dirty demo, any ideas are welcomed :)

(I think in virtnet_open() we can make the S_LINK_UP being scheduled as well?)

