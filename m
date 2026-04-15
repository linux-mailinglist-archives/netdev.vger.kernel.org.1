Return-Path: <netdev+bounces-278746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCuzIK9r32niSgAAu9opvQ
	(envelope-from <netdev+bounces-278746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:42:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2018A4035C4
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84F293094B4A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4D335072;
	Wed, 15 Apr 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lnsnk7QF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tIxeoYOU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100C346FAB
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249754; cv=none; b=jmkoRiCHIE6eX6oN9SbKy2TVdmkKk8Y9wmZLeZuTeq/ltUZbF5lkwdHaZguL1IJYGbryyLLeno3CtTvqdFFAYOQsyxDXAPAqPrIrlpN7xTU1fH54h+bL16FxtmruQq84iwOuhuWeyxXUZMQ6/4sreage8BjdotmBTAJwqrVdJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249754; c=relaxed/simple;
	bh=Z8ZM7RZK8ybTCU1uHBOlcPD8CQy1Evp7Q8nKaT8TGXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiYW4rMmrYRrg8lJ/e+d1+EiJYCRLtuXQS22lFf27nqpJW6U3FOU7mIa1HT494yykwLtF1rHLSJmksUEAMOQlg+1Rp+1pv4Vw+RlB+xck69WG9+gUmaEfpzWCZx7ifFOFyD69SBo5cFrBsuHkjW5CyYRfh/yUlxOLMNA7yHPMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lnsnk7QF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tIxeoYOU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776249752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5Es++6jZY8aKLtLSfo9uIdq7eeB6041SLW/QpiJsjA=;
	b=Lnsnk7QFBGhRQXgCG+fyIZw3Xt1yf7rx4SDn3TB7M/15phOVXiMd3LoJ2JQ/6N4SbmK8qr
	34WATitmCnTrBm4xv2JV069fIE2ebzHiWzarNLjo0Uzd2CREPEwIKgKJ+kHA9AS0o6VLry
	ZjjAR+q61QV9HVkMRsPOR5li+0HyZvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-J4dwooAWNC-NVJXMJO1Z1A-1; Wed, 15 Apr 2026 06:42:26 -0400
X-MC-Unique: J4dwooAWNC-NVJXMJO1Z1A-1
X-Mimecast-MFC-AGG-ID: J4dwooAWNC-NVJXMJO1Z1A_1776249745
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43ea7a5da42so865938f8f.1
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 03:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776249745; x=1776854545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Es++6jZY8aKLtLSfo9uIdq7eeB6041SLW/QpiJsjA=;
        b=tIxeoYOUhjh5hS2B/6UiVEHcrrTiTSWMcsLl7mu3qH9NM+UnaWS2E7H88n0qi0c7Aj
         nJi37mXKvWlFFkwKeyPGiRFDDWoLtuj27h9JILICuwzrWANZch+6uz4VzIkbiu3iOgTS
         FskOI+nZ/vPdJMqT1rdPk0J+exy2uqJsM4qxvJkwRQqPBBzqI11RzDG+swjlW4sj4GSA
         dEPuP9DiAD1sUvk01fQ8ZvQWUS41UbhGgAMn2Kds4HNyHoKCyNtTR42QSx7QCgAr4iKI
         h2ObSRAfd+3UZa+KjSSrgAH78WrLrkvGHsCZquOjmtsGalBOg7lT8cssSD3+z4saGd+s
         okIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249745; x=1776854545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5Es++6jZY8aKLtLSfo9uIdq7eeB6041SLW/QpiJsjA=;
        b=iV/QGI80adZ3E2ZzTnFm7j8w3vjrcKow3KO8o80LB7kS/IwHGsx4Vrfu/PB3hBD72T
         jQ2NzeSeOUtARYEaoSL41l7lY+GKCmelsUYTbq+zBPCWQrXKXMUswzMO3X+p05qTl/1O
         rwTUCExMvlxjZWCYN/Kdxp/M8JQxpkM3Ll6EyVlHK84kL5eJCFDuxuiMt5pJuDlB/Z61
         Y0gplPVlfx3qTM6gcTfxF+O/RU/b1uDfgW+hfjqJONPllan0e9VifpdIYcnHe1QAvvdw
         HV8qhCpUXoYNoCjfB5P+AdGA8ZODdsN/eujyTh09wsjDgznFSXanTNTQfF20v4cio1H4
         VTMA==
X-Forwarded-Encrypted: i=1; AFNElJ8NQQiEJYmXJheEtVfah57qgEFtNMgHUkd2kcB3h2pPxr/ltw/l35mbqzmtrOu5dHgmZ/JfZE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQa/mFWy8i3MHHrEPyY0G0LMWGSdCWuJVf3rfrOhNj6154Ofv
	i2HQ1wiOFZrqTm2qdC62YOvKqgq6CtjjOc7TfsR3GLT1KFFy9yLz43q45NwZqQ6uX8knT+L6LkV
	a1qal6OS/cdHT0zB7k7zqGDbqIMDYUD04/dfPqA7r5sp8P4D1gxJA3X5afA==
X-Gm-Gg: AeBDiev5v3afulJvJ7HmeIJKKShYxj1K2cuz98iIWvIumY3ekl0t5GfIlBIPGtVnn69
	Y7EeyCOmMYC2+fbpIYXbJDCvDLvCEaBMJD4DbjQZZfE55Jmf2aQNRbE/THHUyEAUclQkXJATpDw
	tf5Tx5ztfFAYtInFgngTDtLiMO9f/6lI4XJ+YeVzUqio+tLToxwoBfb6LtLc1fEA5VPDrVpaH1f
	Es5jYQDFZDxGY3RKQpo0W2yW29+e+AvWiZ4WIbSOh4aicnei3o/flciwi1oVIpA+IP29rYwibDv
	fPha213vUJQjJ57OruwX6PSAafHGo2MbtD/ejAZUFzd7kLIHOtCkEl1aIxmXub+L2u+2SAy98kA
	CO7h6QCQEXo0WTAwE5dx8ORi0WoRH9/robahdwPPBPf07IP2VAe8w+saUJsbVqzcffjXaFKuLHh
	iXcio/HQ==
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr269862015e9.24.1776249744835;
        Wed, 15 Apr 2026 03:42:24 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488d68c2cb4mr269861615e9.24.1776249744366;
        Wed, 15 Apr 2026 03:42:24 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5fd6sm4397440f8f.24.2026.04.15.03.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:42:23 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:42:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Norbert Szetei <norbert@doyensec.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] vsock: fix buffer size clamping order
Message-ID: <ad9q6r6ZBHIH7k4f@sgarzare-redhat>
References: <180118C5-8BCF-4A63-A305-4EE53A34AB9C@doyensec.com>
 <e965ff22-37b2-406d-b885-e2736e84c0f3@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e965ff22-37b2-406d-b885-e2736e84c0f3@rbox.co>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278746-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2018A4035C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 04:22:04PM +0200, Michal Luczaj wrote:
>On 4/9/26 18:34, Norbert Szetei wrote:
>> In vsock_update_buffer_size(), the buffer size was being clamped to the
>> maximum first, and then to the minimum. If a user sets a minimum buffer
>> size larger than the maximum, the minimum check overrides the maximum
>> check, inverting the constraint.
>>
>> This breaks the intended socket memory boundaries by allowing the
>> vsk->buffer_size to grow beyond the configured vsk->buffer_max_size.
>>
>> Fix this by checking the minimum first, and then the maximum. This
>> ensures the buffer size never exceeds the buffer_max_size.
>
>Something may be missing. After adding another ioctl to your reproducer, I
>still see crashes.
>
>     SYSCHK(setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MIN_SIZE, &min,
>                       sizeof(min)));
>+    SYSCHK(setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE, &min,
>+                      sizeof(min)));
> }
>
>[*] Setting buffer_min_size to 0x400000000.
>[socket][0] sending...
>
>refcount_t: saturated; leaking memory.
>WARNING: lib/refcount.c:22 at refcount_warn_saturate+0x7d/0xb0, CPU#2:
>a.out/1478
>...
>refcount_t: underflow; use-after-free.
>WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x50/0xb0, CPU#12:
>kworker/12:0/80
>Workqueue: vsock-loopback vsock_loopback_work
>...
>

yeah, I pointed out the same during the bug discussion 
(https://lore.kernel.org/netdev/acuKUpZQq6z1DY_n@sgarzare-redhat/) and 
suggested to add a sysctl or reuse net.core.wmem_max/rmem_max
(https://lore.kernel.org/netdev/adYKERRYwzMIhZAl@sgarzare-redhat/)

Thanks,
Stefano


