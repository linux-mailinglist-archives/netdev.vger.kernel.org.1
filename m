Return-Path: <netdev+bounces-291317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJfYAk1FFGoKLwcAu9opvQ
	(envelope-from <netdev+bounces-291317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:49:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5646F5CAAC2
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B36D302350F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F68383315;
	Mon, 25 May 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAoc0Ygf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kjRkhazS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984B36DA02
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713332; cv=none; b=objBWSSq/7JE3pftHEa+HKRUyflmuVTXfekvvJEFOabgTjN/G+CXNuTIJsF2yGBHPpMH3WwFzy28ZQszIY4OpTcTBK16agog4IobDK5NauljNdwaeJ5uh/wLZ9ecyIjxQ0G+CNM8VWEcz8IeNskAslG9JHQ2C5IUvjA3vmei5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713332; c=relaxed/simple;
	bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH8y8Jt9D2K3P1g9D8Arc4noiLljmdUFpzOV0uEaGhBzenK8ExMPfNImrJneUgQP4ncTHolatQByz91N4lUWtibFE9TwOKk9bDnu+pY4T8DJDIsj9vTaYkrYDrmd4TQk1G9glBmEZm1tfQU+IIU6oNrKkd498OgdZ2DC4kFx4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bAoc0Ygf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kjRkhazS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779713329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
	b=bAoc0Ygf7U3mDYF2pGpdxfTogLDKzrMdtABZF/ZYKYShVgSeacfQBZs26SLBYzgPPenI+v
	5ZTyVnwdnXHKgONdRrkmZFOL3ASVa3IgjEqPnSzEk/9MEMK2s7tuSpdX0NJkcYIgXJ8PBw
	MswpmEfdRBD8Ao0sX/9Wj5z3YV+v8zs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-wqE_db6UNv2w0eaolHU6uw-1; Mon, 25 May 2026 08:48:47 -0400
X-MC-Unique: wqE_db6UNv2w0eaolHU6uw-1
X-Mimecast-MFC-AGG-ID: wqE_db6UNv2w0eaolHU6uw_1779713326
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a52d5e572so6709825f8f.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779713326; x=1780318126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
        b=kjRkhazStr15+7M/Ih3LPfMYwvXmc9W0UoohV4MgAtxo4qWvWH78X8oynXxVFZS9vg
         aKv9RnK9poC7OclDSANsH1otIjHiggPMD71ar+hJtfoH0/i+IYmKIy2KCkVCfES/vxi7
         lW4dyzLz0lVBgod1Np8zLRc0hVMYsBJHfJEr8+bevD8Dszj0nCcGaZfElFD+R3+/GxZm
         PmojGd7knEiWEIh+kJCjUWREt2gjWdU3vkKcV65i55DUXdl/7OdW5Aj8aRGC5j8his2q
         ikt0kYJoJeU9WLTwCItY5dfCPtvG4EhptRGGN4gNLIunHWdIQnvRfEkNWjXdSRhhH3Hi
         2hRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713326; x=1780318126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
        b=C12gDxoDhoM9JFLcPg0TeTiAsr+UFEKpPN688S3u513DSQDJlD71E0w8NiCTa61DtC
         ER6sW2OBOHn0Rqyf7vk7WPXa1MNmr2ZrySXZHWdezUSAHioZUBk69mQDWmnndGkIlWWQ
         e4XSrAv4mUxDdaBXtEA3PUkUmwgKFcyM+Iw0zY4fUmUUfQMSf3kHG1YK7Y8eTCF6rbG3
         EQyX4EskUxgiDC6iNi3gCt+ys9TAoF9/QWSfeATCzxgYivgxqfDYEqRVV6NvQHJYvHa6
         gFQ0oWUQ9mXAN6qJM9BMZYy0Htvh7A/DDupwsLDvEXH9QlD/7HOacGY9gueUyXkfIWtq
         koWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9heg+IPB1uZ2wVdVBw6CCwkReXh8yTXricwXClDisLCGkqsERCPkHf7GBAfZnQLdP+b7IhUEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Jy0WF7uHfc2yzO52Zuc9SIeWCwlnLhVUyz+5RcFt3XnfxzK5
	hshTR79ezIAVosgyq/wMZCETnAWV30M1EvPprpLnYHIX7uk+XadV3Fg1rh0CP/3pV7pnJWGOp0H
	xIwjYB0JjBdI+SOg1khNIwfw36VbB5uUjOiyRpqQUWzNG8CicLNupgxkQkA==
X-Gm-Gg: Acq92OFfdnwljw/p09HJ4eFH08xDX91KpMbbe5eVm7seOpbIPg9LjnIk/9XP1nBFKPE
	euqgcaxpePCo+tX5avqsA5W0ckLHMcixwhnRAckE4zD05adX29XO8m9NMiCp4xD/zT9k8HpDMdp
	BsrnShyRAtYksHnsY6W/WIOj1D9WCcwIg6r7izN3rfjHkxWOO/EuPxi6bVRe73818cU/RY6rRXc
	hA6VB+O6zGhCbuhN48WseuvHX3pFtPBVR3eEqXww+Ru6ySI4sHLUWJC3/N8BLSTanXCn+RCZgvX
	wY47oEqWrl47NgtmU3me3gxRQq4OBuHaYLSVr+aupuTFc1T6ZB2VwAHjezuv5u5eVTL0WnrxtI7
	19tz5BfDIAkDmM9+JAI77fmECefDLvVKdhMt01fJyu8OItmM1fnttRk5ZFRRV5kFAJFO+58k=
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-49048df2f57mr209950375e9.26.1779713326063;
        Mon, 25 May 2026 05:48:46 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-49048df2f57mr209949785e9.26.1779713325422;
        Mon, 25 May 2026 05:48:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904333146bsm143470125e9.0.2026.05.25.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:48:44 -0700 (PDT)
Date: Mon, 25 May 2026 14:48:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "malin (R)" <malin89@huawei.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	tanjingguo <tanjingguo@huawei.com>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, Chenzhe <chenzhe@huawei.com>, 
	cenxianlong <cenxianlong@huawei.com>, cuirongzhen <cuirongzhen@huawei.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Message-ID: <ahRFCaqFwdEFA9CK@sgarzare-redhat>
References: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9fece5ea269049f883f367642c07eaa0@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 5646F5CAAC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:15:12AM +0000, malin (R) wrote:
>From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
>From: Jingguo Tan <tanjingguo@huawei.com>
>Date: Fri, 22 May 2026 19:53:45 +0800
>Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
>
>virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
>before entering the send loop, but virtio_transport_alloc_skb() still
>fills the skb before it inherits that uarg. When fixed-buffer vectored
>zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
>managed frags and return -EMSGSIZE. The rollback path calls kfree_skb()
>to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
>skb_release_data() falls through to ordinary frag unref.
>
>Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
>before virtio_transport_fill_skb(). This keeps control or no-payload skbs
>untouched while ensuring success and rollback share one lifetime rule.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Lin Ma <malin89@huawei.com>
>Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
>Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
>---
>
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


