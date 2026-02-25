Return-Path: <netdev+bounces-260938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILwbMF33nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:21:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F004197FB4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08AF53031AFA
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979E3B8D53;
	Wed, 25 Feb 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFBCMogU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OK12alkZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941F39282E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025686; cv=none; b=U3vK1+tr6WWglNaOJhLoucLRhamhCTap+wI3EaLMTbUO/ekpYebdxWfoDWW7efth1J80TbbWTk45+WHhpzQKc1rL5GAbX/5yXfRSJfl+Oeg24BNp3pi7Cf5corkung+z8XIf20RWKJrl8J2CaZ1HeyJUvODeKiXgobMPiTsmzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025686; c=relaxed/simple;
	bh=gPd6+PZcmUbTbkDvrJ11b6yWE2uDUvuPbL8XSCOXmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+1LIumUOAiBCaLmHTSpqcDQVQ9/x4yacvWujyQGa0rJ9yeNqEm/zoBCQ7IzHPgdLZSxeRWEGsRE7KL0n0n5CgjJvwvRZdTz8XxF31UnhVbj1M7hGwkbPpRMcXZE/RoOfOCACjFQPHhrMdPabg62TzrBEmk7GRhlxQ/Izht5Rj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFBCMogU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OK12alkZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772025683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
	b=RFBCMogUMVpq1g0g3KCsQBQ3fDVnpByqUFVUG1MOQsxYLaR9NnESvUYyRHP2zdpzGqgdKo
	XDOESXoHBPpZK9k8xbqfk3nPfwGhHXbQrtEpwlby6LXJiM34oa3bchAejkJcCwVHJWA2LQ
	e3+acIhcwkFGyXfd/z5uuE9PCuORCxM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-vIlXnpvGMs2F8oH27_MwSg-1; Wed, 25 Feb 2026 08:21:22 -0500
X-MC-Unique: vIlXnpvGMs2F8oH27_MwSg-1
X-Mimecast-MFC-AGG-ID: vIlXnpvGMs2F8oH27_MwSg_1772025681
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-437159d3ff2so4399478f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772025681; x=1772630481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
        b=OK12alkZTJlEg2byMp7L8vec/l4RYh/iLnJcm1wCKjXuwldfczS1wJevya08eAGKfZ
         cf9XY/wf+gHZ/f3nKbL3e189ru+G1GkvKLjsjpXK+wPBjLGKsOtbd4YquY237PkzrBMe
         U8OoRIudaP2LnvC24yzd1ERlciOlu7AJ/UnWOnyl7J59peU+jYo4NHZt1sJUsE9/TKp0
         A2MinrgZjknHcDCZdjYpAiu2QMPP1e5AYAygrbcv+/1XsY1MAZfJEaWUI2Lx/CVeVzgU
         YmDObNUb2+TNDWTZObBi250Pf9iuKOpQ0Rcis7EKP8LfMC4EnM/qe2A8iRV/PZlqJ4he
         Zv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772025681; x=1772630481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9FXhwMMHFtDvmmN9O+r+h6L/Zassq9EP7jemgy3/40=;
        b=MSATobPQuzZQBT/VI3+ftzntY9ShrxBmQw4DT/cPg8roIm0guPMG6W+q3xTj+wnU4z
         g5jb2Te+cz9AI8hf76RnfhKuOuxdlw/3Mo0pxSWyCVp4Ajw1vGHdKKFaJSL1+FFgIaKM
         u2QKZWpPOtTRQMQLarKiCXeoKaA/LEZOn/+dyh2oWK1R+W6K37UySqGTKnB8buxFsQFU
         lGgRF/y1ldwz02Tiwk/yoSw5O1Haq3U6OzkumuemL9yNUJCIIKlYzJMrdDJtwXF1GS1J
         I6gIsVMp3qzIT/1Qc/9XyHJ98M30bKJBVhbBxetx+bMhhLy58OFBl8oGqFWZ59OJMjjy
         cQnw==
X-Gm-Message-State: AOJu0Yy/kVxZWI1KD3F7YletveajlFn152ZhskXdM5+meuQb7F/X5IP3
	5j821NBh06CnxqG14k2Q4vaUmAbKlwGRb/rMYnWKJ0DIU/bbmV/hg8SpiE4xzFyOh/y5oAMRp/5
	pwOyRq7o7T5YsNKYl54+lgkq227TQ5fS2wBM9hM5MHx0/3bWKv1LmEaC7AQ==
X-Gm-Gg: ATEYQzzOWf49gZ5NZLLyHTAVgwyxKcrO4MWiD0Qm5UgN58E4RzdkM2y0YvEjxTdZQMC
	oHp85lh9kiA8oedOn2xYsR/lr9Rrff27FLSvihmeoEHk1CMt9ZcpMFSsyat4lsfjkyLgJc/G6Ji
	XHKk5lbvFAiw0x4BTsNb31HOqBzqaROiiQQctDKjkZPAzM/S3PBksxTgJttKRPez7V7EojFS9ui
	vCh7TlhHsr8iu25Mpcldzdb3N7VCa+nk1RswK2kvxUklxUMDI+dkvFveaCV3tznM6EQ7zrYaXdb
	W5c497hf5zQILz0SNBKnIzJyNa9u+kWYnfb351sOS3i28W/4fdq7FBStI15JxgjQBmTGIp3wUw3
	2MydEo+hE3HUVOCm9gsmWku9vaZPsA/kr/hVPS5ssc4t+aw==
X-Received: by 2002:a05:6000:4009:b0:436:7ab:9290 with SMTP id ffacd0b85a97d-4396f16e345mr29973665f8f.1.1772025681016;
        Wed, 25 Feb 2026 05:21:21 -0800 (PST)
X-Received: by 2002:a05:6000:4009:b0:436:7ab:9290 with SMTP id ffacd0b85a97d-4396f16e345mr29973604f8f.1.1772025680520;
        Wed, 25 Feb 2026 05:21:20 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fdd0sm33025046f8f.19.2026.02.25.05.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:21:20 -0800 (PST)
Date: Wed, 25 Feb 2026 08:21:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>,
	Shiva Shankar Kommula <kshankar@marvell.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Message-ID: <20260225081735-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260938-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F004197FB4
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:56:19PM +0000, Srujana Challa wrote:
> > > > > > >
> > > > > > >
> > > > > > > So if device is powerful and supports a very big key size then...
> > > > > > > we disable the feature? how does this make sense?
> > > > > > The intent isn’t to disable the feature on capable devices, but
> > > > > > to ensure the driver never advertises support for RSS key sizes
> > > > > > larger than what the net device can actually handle. Even if a
> > > > > > device reports a very
> > > > > large key size, the driver is constrained by NETDEV_RSS_KEY_LEN,
> > > > > since
> > > > > netdev_rss_key_fill() enforces:
> > > > > > BUG_ON(len > sizeof(netdev_rss_key));
> > > > >
> > > > > so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear the
> > > feature?
> > > > Our device mandates that hash_key_length must be identical to
> > > > rss_max_key_size to guarantee symmetric bidirectional flow hashing.
> > > > If rss_max_key_size is larger than VIRTIO_NET_RSS_MAX_KEY_SIZE,
> > > > clamping
> > > the value is not feasible.
> > >
> > > I don't know what to tell you. rss_max_key_size is just the max device
> > > supports. driver should be free to use a smaller size.
> > My understanding is that this patch prevents the probe from failing by
> > disabling the feature instead.
> > Given the current implementation, the driver becomes unusable when this
> > condition is hit.
> 
> I understand that the driver is allowed to use a smaller RSS key than the device’s advertised rss_max_key_size.
> But, our hardware does not behave correctly in that configuration. For symmetric bidirectional hashing,
> the device requires that the hash_key_length match rss_max_key_size exactly.
> If the driver uses a smaller key, the hardware produces inconsistent hash values for forward vs reverse flows.
> Because of this device requirement, we cannot cap the key to NETDEV_RSS_KEY_LEN when the device advertises
> a larger rss_max_key_size.

Would you not say it's a buggy device then?

-- 
MST


