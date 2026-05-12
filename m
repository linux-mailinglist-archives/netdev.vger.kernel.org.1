Return-Path: <netdev+bounces-286978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KODFDmfWAmpXyAEAu9opvQ
	(envelope-from <netdev+bounces-286978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:27:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F3751BD02
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 566383055BD1
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1363947DD66;
	Tue, 12 May 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/qLRcRr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP9wZRSx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D74478E5D
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570412; cv=none; b=pAnDeTe3yuwwhxihd3nwkrQcZcEO9H5HYbn4X9zExwONnglTQQkIo91pOUwwL7+YBRUGLRk+kR81/4ZgRkrgViPzGOHuazxuO58ka0SNDBoeVS43DFGeQwNKHs+xiceV9q2HH+G4QmqlDR1umIcj3oXwzX8CbYE0gcbk7u7iiNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570412; c=relaxed/simple;
	bh=C9nOtZphHGvpRbbB1mh095pYAR4HXW7ByitF0l7nAq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu11cTk09ZLA/rSUMDYdUMHjBTEGlEvZCB5M2Xr1Z61qbgBe+vjF1dUtsa2Vto7Wea8r2p1qrezILyvPHmIcWjVbAwU+qq09/xW0zxAv+gwAhl4oZqpLXnn7xjRSIIUWQNpDqvEOOuPCrACaw6ASq13pm0Yt7IKnDpA8H3XjcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/qLRcRr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cP9wZRSx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778570406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjTia8hEEWTMEUzJIZRRaWOPCFQqnc9xnPKI05ARaEw=;
	b=a/qLRcRrpV7bC6S1euMGgPpBYOi/lVZ3WoGPZefAZ5arSzWMlsi/v9pIopdBvpcRqqOsTP
	TazwQYW0Act/DJuN4vxWi4FXbT/tYIXvZHaha03usQakdu6yE0SPyIhAvEiO/yKfOUeNSy
	BeL0j7jroPSe/yLV0hVlv6meuGDacrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-aHMKUtdlPZCqQt-HmyBFzA-1; Tue, 12 May 2026 03:20:05 -0400
X-MC-Unique: aHMKUtdlPZCqQt-HmyBFzA-1
X-Mimecast-MFC-AGG-ID: aHMKUtdlPZCqQt-HmyBFzA_1778570404
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so56931945e9.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778570404; x=1779175204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QjTia8hEEWTMEUzJIZRRaWOPCFQqnc9xnPKI05ARaEw=;
        b=cP9wZRSxRq8qvPmqlHHwVZQSEVFNWuYPiFxG6iNVSMEjb1K27TVa5fm4HpT3pZASoc
         GLh8Zb3BOB3M7ty4wevx8EJ2pZIfeHEuKy+w+I37/JGJw4hbNmei+W6YmIkJOo8pPKGJ
         y2M/xhsDhCihHUE7hWw/jqofFw4JrOhl6oPyM5pxDVR7ubSsj4cf7l2eRJniry9k8juT
         GSIxRBFFmMXFMmnGdMVYQsUltfpo3xLlt8jmQZkv+rtkMboXg2TxwiVLO8TvzpV2EYM6
         mWlFOGJ5vyavE1lUAWs20qj4RQnAJPm3Mj/vpswFkuFjsXSCvd4iIvVIS1JT1rlkfeOX
         Zygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778570404; x=1779175204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjTia8hEEWTMEUzJIZRRaWOPCFQqnc9xnPKI05ARaEw=;
        b=IB8KG8+EVqqJLeb2mGzGFAPMr4mZl7Cs1iPHLtVG+wPfRgbUW+FWDshOCTf6LtPKOC
         Z+tNfQZ2KUkbBtPL5CcMLTdUy/mzpAA3ofDxyTr0vjF3ZKTf7HuUfyftDmgkHs6sMKr0
         /iJV8LKBZcN5DgV/gbGBxZzisgiyAuILgbeeiKgnF091fOn5RfY/eHyW6nbWs/TBYPGt
         3E8pqDr7tuMyVL2bTk3hIIYQ2SFM2OqH6d49FVexLJF+3i7YzbNGnfR/2+14SkEp8WbM
         hi9SL91eeH4Gs0absJt/7+OkrL0zNOvFSnVfFQi1vjO3Xql54cBsFHljU/nCIf1A7fJw
         Pp3Q==
X-Forwarded-Encrypted: i=1; AFNElJ88stnj9hhIKfHvzoomxNFArnMytog7sK64p+9OT2yhwYwHqFGnvd81EwGOuxQ8czQBHQDk8dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddbBBQsGqNPOvzeVpQhR1IWf3D8mE5pVfWiyHrB5QeM3rF/Sg
	X3yBQyYgtZR61Mbf6iRESh6mtEmLhtyGWgDS/HXkxntPJ6v3vWURvyvMiStrET9vfKmSvZB4izP
	52/m0aUrTz34WRxQGD5VxrA0YvcV0sn7RyCNUmcSL6mzrOjiXtcS1QnoYng==
X-Gm-Gg: Acq92OEA7OFlEVVFpkfwRzKIkeslK4c1Kt+J+yDe0Rzn3oJNv56MOw5CBUgz/9yC7bo
	uQ/yI2cvsCq13XQyGpnfGEBy1ad5yV1KbUhH09NsHX92wTWyDEMfkjemL0OBKSrZ+Zoux96ZXm2
	nQ7fgcZe2t3ordPTeQyKL31AsWOuifZJOMcYdYnfS5c2TC9TxsEnxASG54iOSuY27pKVjdWL9JF
	4UvIueL+OP28nd4B2UStg/25/rQ3oo6crFdgPOueKm/XFwYaLZzpyri+y1xjPJx9dBFZiGw8ag9
	/F4SbK4R5Xb8iicfmXs7uKiUfseMA7ZPsMKEEGCQlaVb1ZE5Rmk5/Kc+tJH+iE5ongH/D3xQ0dR
	9+2ch//3Hk4jp2n2Ymel3IHhteFx+FV4dPbjFIHMbv7YRLz2xMMZeoWQ44l9ISkaOTSJlMiaozw
	==
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr215488935e9.24.1778570403941;
        Tue, 12 May 2026 00:20:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba8:b0:48a:97b6:7420 with SMTP id 5b1f17b1804b1-48e707fbac7mr215488205e9.24.1778570403394;
        Tue, 12 May 2026 00:20:03 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906ae8b5sm44119615e9.6.2026.05.12.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:20:02 -0700 (PDT)
Date: Tue, 12 May 2026 09:19:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agLR7RkX_3kvL_qw@sgarzare-redhat>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat>
 <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
 <20260511084551-mutt-send-email-mst@kernel.org>
 <CAGxU2F6TPfRxZ7SX20vXiqDM4_sY3yUQBUSfEM=Nr+TKXwT9mA@mail.gmail.com>
 <20260511164841.7f7ff557@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511164841.7f7ff557@kernel.org>
X-Rspamd-Queue-Id: C7F3751BD02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286978-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:48:41PM -0700, Jakub Kicinski wrote:
>On Mon, 11 May 2026 15:17:56 +0200 Stefano Garzarella wrote:
>> > > Okay, I thought it over over the weekend, and I agree that this patch
>> > > still doesn't solve the problem and would still result in packet loss.
>> > > So, until we resolve the issue permanently, and since 059b7dbd20a6 is
>> > > coming to stable, I'd like to rework this patch so that we only start
>> > > dropping packets when the overhead plus the queued bytes exceeds
>> > > `buf_alloc * 2`.
>> > > Removing the other changes to reduce the buf_alloc advertised, but
>> > > terminating the connection so that both peers are aware that something
>> > > went wrong.
>> > >
>> > > Any objections?
>> > >
>> > > Stefano
>> >
>> > Let's try to first fix it upstream properly please. Discuss backporting
>> > later.
>>
>> Commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> queue") is already in Linus tree and will land soon on stable. Which
>> issue do you see on having a patch on top of that to close the
>> connection instead of losing data and breaking our test suite?
>>
>> IMO we need that change in any case, because the previous code also
>> discarded packets without any notification, whereas breaking the
>> connection would be better in that case.
>
>Sorry if I'm speaking out of turn or misunderstanding but, like Michael
>says, let's focus on fixing this the way we want it to be fixed?

IMHO, these are two separate issues (related but still separated):

1. taking overhead into account and setting a limit (which Eric started 
doing in 059b7dbd20a6)

2. reducing overhead by also merging SEQPACKET as Michael proposed (we 
already do this for STREAM).

Even with option 2, the overhead won’t disappear, and we should maintain 
a limit as Eric rightly pointed out, especially since the initial 
problem was a flood of EOMs with 0 or 1 bytes, which option 2 doesn’t 
solve, since the overhead will eventually explode.

So I agree that we should implement 2 as Michael proposed, but I think 
we also need to fix 1 by improving it slightly (as I’ve tried here, and 
would like to do in v2).

Since I have v2 ready and tested, I'll send it because I think we should 
have it in any case, even with option 2 implemented.

>IIUC you are trying to minimize the size of the fix, please don't worry
>about the LoC in the diff at this stage.
>

Okay, I'll try to work on it, but this week is a nightmare. I hope to 
come up with something by building on Michael's idea.

Thanks,
Stefano


