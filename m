Return-Path: <netdev+bounces-260921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC6xJlztnmk/XwQAu9opvQ
	(envelope-from <netdev+bounces-260921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:38:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6C519778F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC40130DE2B8
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AD639902C;
	Wed, 25 Feb 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqqsxai9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBcYUhe8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D363AE70D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022922; cv=none; b=uJ1KQNW/s1ji3BCFvuZuVQ7RNBJ2qSP4QwHBUCDS6LMnhsRuSINwDMWdcT8mW81aVez6kv/IsG6ynOuVrgcAj7FSRm/kMNSXXF85o5sRSEweiXq/1HUYrwkc1izd1rqJBkviF1+7Ei59D8l8VIiBkKJQob0IZ/XYKPPZPfTElcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022922; c=relaxed/simple;
	bh=CH3LHHiMdtoONBad0iIbbz4lf6piNKIo8bQmtLOKVxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHbvLBwz4CVeD6z8ili0UrlIz0qTkw+b0U3CuTLvNLvMkbaNLCobPocgi9B3tiDiJCC52FpCfxPClzwE1m6WGkNbY5vosRuLfVBRT/j4R6PK5lbJq/7fZxq5YQpRhFLM3INPtZgoE5lzUOVl0tsSEylKKNXrnESGJUhl34cXVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dqqsxai9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WBcYUhe8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772022919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7nRjofDA7RJDcj+NFBdh2tr4w28Tk9uEGBjPh6ATJ4=;
	b=dqqsxai9L7s9khvdOLud0RfsZ/BNhv9yRDbkJCg1e9KEVTSx9/Y3WzQEpSWTDKDa7z6cN/
	uwbwTKqMVNieT0WlHcQ1X+41o3G0glKM/5RNPdzVboTzb+0ASX2JgUUMdYD0XVRqHfpmJM
	dZVwGCkSqHH1Mw358OAvEE+73haY7DU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-d7pcq-1-OK-wkqSVMDYL-w-1; Wed, 25 Feb 2026 07:35:18 -0500
X-MC-Unique: d7pcq-1-OK-wkqSVMDYL-w-1
X-Mimecast-MFC-AGG-ID: d7pcq-1-OK-wkqSVMDYL-w_1772022917
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836b7c302fso57150735e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 04:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772022917; x=1772627717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P7nRjofDA7RJDcj+NFBdh2tr4w28Tk9uEGBjPh6ATJ4=;
        b=WBcYUhe8al75YqMLTCaLD+ceIPBSfmpl83N91Wr06eHEEfd0mkdk2MmR3m9ak6QpqJ
         xS1VFswnMXtve9nTOJMgZTnn12h5N1XwgHEBVzKPuhJsHze/WGbpkDQbbdcyPk89ElTs
         ObVt4n/7wY7TQEQj7SJ+oojjHC/ne3gMxHvsddb6JznXA2wTAALiIzz3kxbaJQizMS3n
         E0o9avexFYs8GygY15RwrHiWC9ctslQtsppn74+8B49hSR8exHnNUunahEtnM1PSmwRA
         h7JLHlEJJsmf2cQDkyIJNu9Mtz5Cqp7Lk9K99IhL/Pjo+C8rVJ+hd1LyMKsS6vvzisF6
         K3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022917; x=1772627717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7nRjofDA7RJDcj+NFBdh2tr4w28Tk9uEGBjPh6ATJ4=;
        b=YmvBkhiwrAgIQbf9MjzPt2kt0glDi7xVeV5/jEIFXhcR54qizJ8/SAHGfL2ADxvfkw
         l4IQujXWWnvaYA8hCtfBcRKrI0hXkN5tBCRm15U1lMcLEza9E7G6M+6a9haLznBYv/Hw
         VSSYlcp0pBd0dJEGsZ3zhahnSYCSXMtd5mkmafINIQFYO2hs9jHS8JHklmBTI2zS4C3a
         4Q0Htt403XdTMJS+TA7dvjwHZuGqmoNS9f+ZP6nmZ/hXRIWaUxYuscB7Okt5dgJtfXXQ
         1wr6WcEJ37nO8f0avmdPIb55gAqIruMZV9mlF5V9vIdGaWvhvz9xWMPC8svlQ61Rf4fO
         6phA==
X-Forwarded-Encrypted: i=1; AJvYcCWw577dWoWSfaCMkbBfXlA12Z6+Exk4ZoMAB/Hm6253HFzBd4hFwQVPeZJdIJn187vDA7C2SIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5EVr93kHysq2dWSZ2HSt6ygLlgcO2CVoQzvTYol0RQeB6SWG
	9qXLFZgIfaWu/bSVi9HOp2W469n0ePaDOnCzR5PvF41Lt2X/gpM1Gdz8yWuEjK8XZz1tqovX97R
	XACWT+vHatlKf/iXsRmbh65lav4vWgrAYCZ9UsLTH+2p7htKmyEeTftpEcQ==
X-Gm-Gg: ATEYQzy4sK8RPxNxfqPKavIUr4KdbSd/Vdu3kA3itVrbNi7F1hOoidz6HrZ3OlbTkBD
	9HqLAl0I6LCm54c3oPyiE+p26N9JI627yMWc4rOdijzKJSnKTB04tArF6w5Af6Ybycn6umPA0aP
	54bsIAO2fG+pGIyQ+WPTeu2UBkM0mUh0ra46ryoYKV8W1Y1B8YBpoGk0/rrD+gC5xNw0CavCag5
	D2YlpXABnH9DShYhDCTGdLDP5d39IwroPzK8eBjh5SOA9P1z1aXO+pVrBomjM9S240d6UE6A0AS
	y/LJ2ucRqEyGekBaZ8QtAVfJs7YBbdceuIaJdEEhCRILvwg5F0gDzUbsGrJF+PBMjItxDKFeHHs
	dHDFfOWQC8B/zfPNTn/UmX6nEZBt7cDPVjKjrr6twKIn06g==
X-Received: by 2002:a05:600c:4751:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483a963df99mr245469795e9.34.1772022916526;
        Wed, 25 Feb 2026 04:35:16 -0800 (PST)
X-Received: by 2002:a05:600c:4751:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-483a963df99mr245469355e9.34.1772022916050;
        Wed, 25 Feb 2026 04:35:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm74365755e9.11.2026.02.25.04.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:35:15 -0800 (PST)
Date: Wed, 25 Feb 2026 07:35:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Subject: Re: [EXTERNAL] Re: [PATCH net-next,2/2] virtio_net: replace RSS key
 size max check with BUILD_BUG_ON
Message-ID: <20260225073338-mutt-send-email-mst@kernel.org>
References: <20260225042302-mutt-send-email-mst@kernel.org>
 <1772011833.9281492-3-xuanzhuo@linux.alibaba.com>
 <20260225043249-mutt-send-email-mst@kernel.org>
 <1772012166.8117785-4-xuanzhuo@linux.alibaba.com>
 <20260225044528-mutt-send-email-mst@kernel.org>
 <1772013149.5017734-5-xuanzhuo@linux.alibaba.com>
 <20260225050441-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63742AD7C6599EC81A858427A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225071659-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63746E0AE4CEEB32F708F1D5A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY1PR18MB63746E0AE4CEEB32F708F1D5A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D6C519778F
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:29:41PM +0000, Srujana Challa wrote:
> > > > patch 1 is unreasonable i think.
> > >
> > > Patch 1 is targeted for net, addressing an issue where
> > > VIRTIO_NET_RSS_MAX_KEY_SIZE is fixed at 40, which is only the minimum
> > > required by the spec. This led to virtio‑net probe failures when
> > > devices reported an RSS key size greater than 40. However, the driver
> > > also cannot handle keys larger than NETDEV_RSS_KEY_LEN (previously 52)
> > > due to the BUG_ON(len > sizeof(netdev_rss_key)) in netdev_rss_key_fill. To
> > resolve both issues, VIRTIO_NET_RSS_MAX_KEY_SIZE has been replaced with
> > NETDEV_RSS_KEY_LEN.
> > 
> > but where would driver *get* keys larger than sizeof(netdev_rss_key), even if
> > device supports more.
> In virtio‑net, we rely on netdev_rss_key_fill() during virtnet_init_default_rss() to populate the RSS hash key,
> which uses device supported length.
> The code path is:
> static void virtnet_init_default_rss(struct virtnet_info *vi)
> {
>         vi->rss_hdr->hash_types = cpu_to_le32(vi->rss_hash_types_supported);
>         vi->rss_hash_types_saved = vi->rss_hash_types_supported;
>         vi->rss_hdr->indirection_table_mask = vi->rss_indir_table_size
>                                                 ? cpu_to_le16(vi->rss_indir_table_size - 1) : 0;
>         vi->rss_hdr->unclassified_queue = 0;
> 
>         virtnet_rss_update_by_qpairs(vi, vi->curr_queue_pairs);
> 
>         vi->rss_trailer.hash_key_length = vi->rss_key_size;
> 
>         netdev_rss_key_fill(vi->rss_hash_key_data, vi->rss_key_size);
> }


Is there a point you are trying to make? disabling features because user
bought a stronger device is counter intuitive. Make it work
in a sane way pls.

-- 
MST


