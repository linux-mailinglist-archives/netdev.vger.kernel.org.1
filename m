Return-Path: <netdev+bounces-280658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBRAFeXS6Wm9kgIAu9opvQ
	(envelope-from <netdev+bounces-280658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:05:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4953444E501
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEECC3034780
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB333644C2;
	Thu, 23 Apr 2026 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAmPQs5S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGnZL6Po"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAE363C6A
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931538; cv=none; b=t+SGyK8VZBQMUTAKKTb4aPR+b8Pho37RWImOD5qxziJfGETwDLS2JtF/CwBim92Iz8fZP2j58sY/y4xaR4dY2V/Q5VLsTsF2K9qts8WO5ggyXDZRd6Tlhsc/yLVM81mSU3NrMZ6pddkn4egxl2zdxhpBxpz5AA/0V1SC7HDzzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931538; c=relaxed/simple;
	bh=X51NaAAcD7xcfIzDgCXl+Nl7qU5/Uz5j+26QWsxbles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4Uq7I1vGQAqtevZJ/PTm33sdUu1cjrAHCQeuz5+PDrTcTu+UHd1Lob5jJPui9CWSs1iMhY/4FD3KxcVuNSdhlTsfnwvIlFc0yGt9+VdVuLK7vwfjK0k7dhn+7HEC9o01GdBU17pN2tK+UKr8UJhprYX7gbVQW/nrc8d/5ZsMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAmPQs5S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGnZL6Po; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776931534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAeTuHOLXjIaQmds69HgujTGIBBKyZUhVPw/w5CcHkE=;
	b=JAmPQs5Ss7RWHmWs5MdcuwJE/k8BPkjVwiNenBIfeDvxcDXIArAKdUXVC8fGDOu8OTCxYF
	D1WjlPovB9IDrPjiYgl8vfzo4VZfHALiWYQDWPrHHzsPyPVEIxxXDSdpQygbowMBzkAR3j
	8ZqLwmQxOEtnR3ZTvrMONPiOvhDzVSE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-o4NHt8_EPTK6_S87UGg7AQ-1; Thu, 23 Apr 2026 04:05:32 -0400
X-MC-Unique: o4NHt8_EPTK6_S87UGg7AQ-1
X-Mimecast-MFC-AGG-ID: o4NHt8_EPTK6_S87UGg7AQ_1776931531
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso5130031f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776931531; x=1777536331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAeTuHOLXjIaQmds69HgujTGIBBKyZUhVPw/w5CcHkE=;
        b=NGnZL6PogWkjkJmFyrzOsJcsnhy8A+gpETpXZCOyvZcM+XX/mnmv58StlTT2k5tYLT
         /zBd+xmlEgtabDm6f6/MuoaTdEnOGXuPPR73S8wIkAQv4v/FnKG5scnktVDbxOCdA9B6
         k46qmPltz6FRaRqgjWrT9RN5Nfvg14D3kOr46T40CVc9Ts4qY5RkEyMQjjzvk/qBP7XC
         rM5chj6JMRmjMWP0PClmcOFy8V2hTPs/Btm5z8srsU+n6Q/sS30HEnqldcjaofbKHyws
         MPwMqfR3vVFaAynXdShP2RRbBtnHRUWVA4R5kFzyqivbihfya7ZiHF8yLHm01lSprwzK
         6oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931531; x=1777536331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAeTuHOLXjIaQmds69HgujTGIBBKyZUhVPw/w5CcHkE=;
        b=RYzYsQuln23C2JpvKkv2MgqwXPtkNo8t58nTEOiRj3DwJurd6+GOb/ZJyROSZwXF3w
         Q3+26Qzx833LkVaMDCisvNxgL8ZLt7TW6s/QJlDamJ7vaNmVWdf/N9/Le42LvOZAylaY
         u+L4qkdEFhCkPphHcmI55Y0xm8q+Ak0LJCjbiLLvglu2G6wbW4zjCJG2fnATUDg1BdsG
         IB0jEpRDwT9OWoahiNQ63HBnRI4vcz3r0VI6cRLvngfF45ZfkfH6VjgSOAJtc/Dc0ROf
         V3EPAtkj4jTCk45ln/JNJRIi+BIoaJciwMcqFRR/0Rrk2W/UeB/slrus8NjzzUT2/F3P
         KmYg==
X-Forwarded-Encrypted: i=1; AFNElJ9aJ3JkcNeNeMrp4VkzKqITjIWEeDWoHZklSArytRYxKA9+xtnRW/J+JS77g17qq0SMaMM/bQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDMdBFQ6ZxJWyUibXhbByBm2S7Ejzg7aBuPK3iwubne5aXyuV
	d4C8Df7i2mnaDZ0tgKg1wk27cmMHN8T9Yxl9+UXB/6/wPZIe1ueg6XDFosEvy4ZUHeb4m0C6DuU
	ndcBAHcnLMvk5pJyoZqMjvF4evGswtgNeIdF2xYNA9p93TXn8aA9DBMvktg==
X-Gm-Gg: AeBDiesp3YTjf7A6TGMDXYbl69IXgcgTVNcTT+Rhx+Xig35PVGkRJAZZZcPAQsl/2cf
	y24Hfyowowz7IThcY4b2tmJzNsHqD4myWNm68GKlwdNTSKSZxl0b6kzU97B+v2pnVOtZEb2t3OH
	gy5aAbNRShu1tN1byZTavuCgdynqx6MaoiywJy8M3Q1plFXLTkXCQQDNH6BJGsotVs/9c3Nfyu5
	JsOcjDFiEL5JSZYNNVdjQZ8ic5tAM7W0QbO/qe53KIqXln3TTSIw6XQiL2mZkaH/2/k7Pu894s3
	u90wBZMbNzGm7+38b1ZhlYkXosalvfS2I0gzCMXRDF24FZYuqhSTjESmWN77t8OJiCqYKlNQ7HB
	JdqYQM+0lcAaKDu1vN70GTadbNFqjxfsg2rMsXuwTxuZ6/xEqdtgXJQ==
X-Received: by 2002:a05:6000:18a3:b0:439:b8b2:fabc with SMTP id ffacd0b85a97d-43fe3dd4b7dmr39978192f8f.21.1776931531315;
        Thu, 23 Apr 2026 01:05:31 -0700 (PDT)
X-Received: by 2002:a05:6000:18a3:b0:439:b8b2:fabc with SMTP id ffacd0b85a97d-43fe3dd4b7dmr39978117f8f.21.1776931530769;
        Thu, 23 Apr 2026 01:05:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm54697842f8f.7.2026.04.23.01.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:05:29 -0700 (PDT)
Date: Thu, 23 Apr 2026 04:05:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Brett Creeley <brett.creeley@amd.com>, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net] virtio_net: sync rss_trailer.max_tx_vq on
 queue_pairs change via VQ_PAIRS_SET
Message-ID: <20260423040522-mutt-send-email-mst@kernel.org>
References: <20260416212121.29073-1-brett.creeley@amd.com>
 <1222eb4d-2b6d-44c6-96a3-03c42f714b4a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1222eb4d-2b6d-44c6-96a3-03c42f714b4a@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280658-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 4953444E501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 09:01:26AM +0200, Paolo Abeni wrote:
> On 4/16/26 11:21 PM, Brett Creeley wrote:
> > When netif_is_rxfh_configured() is true (i.e., the user has explicitly
> > configured the RSS indirection table), virtnet_set_queues() skips the
> > RSS update path and falls through to the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
> > command to change the number of queue pairs. However, it does not update
> > vi->rss_trailer.max_tx_vq to reflect the new queue_pairs value.
> > 
> > This causes a mismatch between vi->curr_queue_pairs and
> > vi->rss_trailer.max_tx_vq. Any subsequent RSS reconfiguration (e.g.,
> > via ethtool -X) calls virtnet_commit_rss_command(), which sends the
> > stale max_tx_vq to the device, silently reverting the queue count.
> > 
> > Reproduction:
> > 1. User configured RSS
> >   ethtool -X eth0 equal 8
> > 2. VQ_PAIRS_SET path; max_tx_vq stays 16
> >   ethtool -L eth0 combined 12
> > 3. RSS commit uses max_tx_vq=16 instead of 12
> >   ethtool -X eth0 equal 4
> > 
> > Fix this by updating vi->rss_trailer.max_tx_vq after a successful
> > VQ_PAIRS_SET command when RSS is enabled, keeping it in sync with
> > curr_queue_pairs.
> > 
> > Fixes: 50bfcaedd78e ("virtio_net: Update rss when set queue")
> > Assisted-by: Claude: claude-opus-4.6
> > Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> 
> The patch LGTM, but waiting a little longer just in case the virtio crew
> has some comments.
> 
> /P

Acked-by: Michael S. Tsirkin <mst@redhat.com>


