Return-Path: <netdev+bounces-260966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFTYLev/nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:58:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D8198719
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAF62302C802
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7593D1CAA;
	Wed, 25 Feb 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxP3GSvi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0zTYXpT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6D3D330B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027872; cv=none; b=YvNi4WVgAnW9GgLY9r7gWQgX75oDNiHUN1Du7VyQEJepfiq1cqUzrAQpxwWF1b6Bce0m43V2q2WytnB59tC3kPmDEUjejbkLZgrERC45U/DT3IS/bYKWHcmacJa79pq3ddu3fEfZNqyqloDiBxFEzWagw0P7kN/kBGTBEHN9pDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027872; c=relaxed/simple;
	bh=BjpCm1b460eDJlTTxeDtrDCf8v/HQ9t1gJnD8PhPRzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwosQBgTPA3xEGjEQr6CxKfLkwI8bP4qxIxBo9yxAxyrLkBacBAHISXoRg6gSGkqNVUhrN2ul5XtrQjoOwfdE/r+eOZT94i02ZJejBw/YkQ4LPPcx0lsmzklqukGHrBQ/jsVmuUjCVKqnDXxU5oJoevcr5ktemTQdF3mspem+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxP3GSvi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0zTYXpT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772027870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReMKR00ftNX6ariSVfYbnK7T/z45lFmC8ykR+jm3nU8=;
	b=bxP3GSviPJH5PryetSPqVE7k6Va4THC5ugad99hCGnETwzE1+lYVwV2fOVGhS/XSYx88qn
	0Xlf8OsgHZWgd0EDiKzYeL2OnMy/Xd97d0EbTCKQRWBQ58b8AB3AURl4yKU8g5iw5Pi3WG
	n0JKUMQV7bl8KewlvlSLikq6GFDGMFg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-rjXEX9xIPiS1s_ScEdaJvw-1; Wed, 25 Feb 2026 08:57:48 -0500
X-MC-Unique: rjXEX9xIPiS1s_ScEdaJvw-1
X-Mimecast-MFC-AGG-ID: rjXEX9xIPiS1s_ScEdaJvw_1772027868
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837a71903aso22681565e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772027867; x=1772632667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ReMKR00ftNX6ariSVfYbnK7T/z45lFmC8ykR+jm3nU8=;
        b=c0zTYXpTmtSNmm/PaxIjI1dB3BGIRrCw8f0nhGQzpD0BPYKzVm0gh+kORiVxBtfIri
         VxEjp4mQnd/iAsqJ0lSnCi6JMeynhXQnPfN/X9f9jHhQl4Cvcd3r57DxYlHNUfH+xXc3
         CaxxWfaNUF67zMzGdai0KpfVCxvwu93hmq2Wa7odQT4o5HFTZWcadz3vXLLeeHyKObu+
         STIsZFdhEELFHhtAfx7EjLA5gLvR8QjGsk/OdHBkxi7x0oxmp/e0fWnhkGEacpn7izjH
         vAhYn/LeQ3DBJllCLgchrbPZ9lpqjgNR0kQJSi5msXiS2UcsNsCb1ym3hFZs6qMrwIlb
         AyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027867; x=1772632667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReMKR00ftNX6ariSVfYbnK7T/z45lFmC8ykR+jm3nU8=;
        b=szTpodJva43k7Qpc9GydWWMGD8UEZpOygMx7lQiv9BQkt3NVI0B8riVDfnUPUXO1NB
         PWDDUcMNxDqYmNZrJolfqcUu7bVmoqc3h29OyVE3CH1M00YSHfKmN3ekORWqjbHgN9hz
         kzgFJjYhOFpt3rh8Yz0NsDeTlS8CIKEbjYGWyS9VfjC91q5BrON6iJy+aoVMTh8W8JYq
         ytquPRx8DgPi9H8mI5iq/rvRqaVg7aX/p+Zr9qgJ1ATH9nkUXAiIT1BdhSdnQZR+WOqJ
         7+mKmvyrqzKd7w3wCeUw1bVc2HtNmMiw9i9uUZM9cN7oUrUDKc1AeeQRVnlqGEXVMxZG
         2y4g==
X-Gm-Message-State: AOJu0Yw3JyZCEyOpLrCrLCVb4NHuSnVFwpjvCmKbMmqWivoMQtFycRKC
	3wvmGyzUpdcLtOyco65qTbcovhdUWI7prJnlmp8Xuygq6dmdKiuFSBeSrHtRpsUCKrRQkk43/xn
	uK1EwHiU/k/cYQKYOwP1FNGlRwgo575mPiM24XbKMvWWBHZKGVRJeA9gZTxf48Wa4og==
X-Gm-Gg: ATEYQzxYRmLrBfQ1U12TzSszVz3wfAv6o7wt/6xWkSAQz+1uXAyP1Od1ZCiHAKvam2/
	i9U3ILbdeFVXO1NAmG+zjbttSdQ1MGpIwKpkUHcfRAs6FtgLQm1A1iBpyK3yM3mVHdL4Xzdg/4v
	givi9lYH9edmxiV2BVqfBAjjiVZWTgWRYR5HER3cR/MWWcux1/aNe7ti21/6x5+DJIiSfn+xppd
	LBqY9EvQEFPz+KceS2JLBE7gBg5VcTf5T6RBKdK8KpCiJi1eJrabnu+oRQLvFptpwh0BA33O88u
	iGzpnFQoC/e0JlC9lJKBwp7jnXk4ghnQWAPDCvwvTdO28DeyF9FvWDK/S3okeg+x0+Ghin5RDv4
	w7jYGiISE81AIvKTdxb+rtB3IreHJPqtpejXpzyawT0V0Rw==
X-Received: by 2002:a05:600c:4750:b0:480:1c2f:b003 with SMTP id 5b1f17b1804b1-483c219ec0bmr6831445e9.20.1772027867350;
        Wed, 25 Feb 2026 05:57:47 -0800 (PST)
X-Received: by 2002:a05:600c:4750:b0:480:1c2f:b003 with SMTP id 5b1f17b1804b1-483c219ec0bmr6831035e9.20.1772027866853;
        Wed, 25 Feb 2026 05:57:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf5fbsm11717095e9.18.2026.02.25.05.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:57:46 -0800 (PST)
Date: Wed, 25 Feb 2026 08:57:43 -0500
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
Message-ID: <20260225085523-mutt-send-email-mst@kernel.org>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225081735-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63740F76E83C299E9AAB32F0A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY1PR18MB63740F76E83C299E9AAB32F0A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D48D8198719
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 01:31:50PM +0000, Srujana Challa wrote:
> > On Wed, Feb 25, 2026 at 12:56:19PM +0000, Srujana Challa wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > So if device is powerful and supports a very big key size then...
> > > > > > > > > we disable the feature? how does this make sense?
> > > > > > > > The intent isn’t to disable the feature on capable devices,
> > > > > > > > but to ensure the driver never advertises support for RSS
> > > > > > > > key sizes larger than what the net device can actually
> > > > > > > > handle. Even if a device reports a very
> > > > > > > large key size, the driver is constrained by
> > > > > > > NETDEV_RSS_KEY_LEN, since
> > > > > > > netdev_rss_key_fill() enforces:
> > > > > > > > BUG_ON(len > sizeof(netdev_rss_key));
> > > > > > >
> > > > > > > so cap it to NETDEV_RSS_KEY_LEN. Why is that a reason to clear
> > > > > > > the
> > > > > feature?
> > > > > > Our device mandates that hash_key_length must be identical to
> > > > > > rss_max_key_size to guarantee symmetric bidirectional flow hashing.
> > > > > > If rss_max_key_size is larger than VIRTIO_NET_RSS_MAX_KEY_SIZE,
> > > > > > clamping
> > > > > the value is not feasible.
> > > > >
> > > > > I don't know what to tell you. rss_max_key_size is just the max
> > > > > device supports. driver should be free to use a smaller size.
> > > > My understanding is that this patch prevents the probe from failing
> > > > by disabling the feature instead.
> > > > Given the current implementation, the driver becomes unusable when
> > > > this condition is hit.
> > >
> > > I understand that the driver is allowed to use a smaller RSS key than the
> > device’s advertised rss_max_key_size.
> > > But, our hardware does not behave correctly in that configuration. For
> > > symmetric bidirectional hashing, the device requires that the
> > hash_key_length match rss_max_key_size exactly.
> > > If the driver uses a smaller key, the hardware produces inconsistent hash
> > values for forward vs reverse flows.
> > > Because of this device requirement, we cannot cap the key to
> > > NETDEV_RSS_KEY_LEN when the device advertises a larger
> > rss_max_key_size.
> > 
> > Would you not say it's a buggy device then?
> No. The device works correctly when a smaller key is used. The limitation only affects
> symmetric bidirectional hashing. For the other use cases capping the key size is fine.


yes the device seems buggy in that configuration, in that it has this
requirement which does not seem to be in the spec.

so tell me, what is the actual rss_max_key_size of that device?



> > 
> > --
> > MST
> 


