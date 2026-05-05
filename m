Return-Path: <netdev+bounces-284506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SApZNi0Z+mmWJQMAu9opvQ
	(envelope-from <netdev+bounces-284506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 794824D12DA
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957F3308CE3D
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A85480971;
	Tue,  5 May 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDI2uvFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2F48B385
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997708; cv=none; b=c3PTaTiak/aT0FO8yhWdi8WpzJfi5fx5UxOQcStvxb/rvwUlQL0xqiYPqEuhQ7FF6NZFi84PEDEnGdMWGIn6EMI2vm5l9XbAo2A/HJ29FdvsMoWz+uyVHY6y4PONgi3j5+WfjdoGL3jyZF97qdpzesMdA3R7PD6dCyiWFSGKdCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997708; c=relaxed/simple;
	bh=OKnCaRscaD5AMQW74QgMnZH55f8knznXING8OMTYuwo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Exd6IW+mUcTlhVe8y/xF1CslqUpOkRD3PTg69xcfVqof2I2Lava5Rcqz+viGoL7PsJEzukRbBudOFfT86fCYBfqbedbEH1HQr/rqUh2Ih8A2z/RTV1tf2RkvkUONa7fSnGVeF1v3bvPbXMXz4jVhYIMhAnga8y1hCsGzHqxVvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDI2uvFb; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so4814744d50.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777997700; x=1778602500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN3IdI2YSKMwtlaK/dSF8QlrtpEFwwQMCrMXfh1AmIw=;
        b=kDI2uvFbIqW/J56PjjxSLbhlv/wP5BZCs2kF4rsuU2OqiSBqFUyivnQpsJRunJ52Bh
         7AMWL02RpdahIsCnwkQ6facaKTWOYAG5N6Z2HsyZdZOf7x2tQgRycpb6qySWeUv1OTeI
         H5j5l1ZmgQgKpG2bAYSujC9lump90EiWpqKEwValaoeBA2zhWSgDCMNIxKxPkMwU+LPl
         zouAFyym8+Yz+c9ntKmTs2KiwTHcy/XS97UTH00kJtUUs5agB6oNtXVRxYSZmnnZm/oe
         vl2hj74KfI4z5LTPFUoc9sUCC3MX84iw46HEbJA4iKQpqqPvtzVFGtEYq3mUUPscZWAt
         WhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997700; x=1778602500;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hN3IdI2YSKMwtlaK/dSF8QlrtpEFwwQMCrMXfh1AmIw=;
        b=KtUjd00YECPBMpUk61pKRExv/k6O8BNDhTWerCweb8jVixMNvbNNDluDnLkh8qonZp
         BP62QXVbBonSagA4uZbHPs1ezDfINBsUsOxigzcbx8L6cYjMdNkgZn+D9leb06GBKy1A
         5mNBo6g/UdHuBmb35/6ODsOywh1EUARnrtGoXE3HlRmwYuzK2NLyyYPjp9gt07+8eF5c
         uZqUi+9bTZmbwAp6ufaD6x6y433p0rcyw+jJdH0VyYhvW8qbbwo9A7DIWmSzWvbuJDEn
         mMC4FxVbTB43POa+cyOaPUfFrGbtwMm7lQsrMyDqFETwHgIqyytwNluXoS8DwDxMtJNp
         2LkQ==
X-Gm-Message-State: AOJu0Ywce1xJr7laZ5NQXQgwV2hMPM/pVzmZXz9HDOhCx/2LLihaJzQM
	bsI4W5JaId4+9q0h26TIfBv0J6KHueAwv/SL3WKWAS/z5ePilPNPCAH/
X-Gm-Gg: AeBDievq8Vx0bYVGFLdGXS/qpHMIHV54YhtGO0TknSQ6tLaBnAZNCUGcbiEbtckIzto
	LHDPUqxDwwuwGCOINstwOZz1wXTP1qejhByU6gZZu8DdKMoCs3l9jV3ilQpBos1zPtEeI7sqgGd
	zwUCtjiDzpD0JkglDkVZK/AqwAbTw6Fuv9kT4tfy/umUg8tJQWVAl/bpEjlIW1acyaVtq7LR1Ai
	WPCQ5ytVCsU0sdW17jfVwoj/O/LVYUu+4lAa56lbEF/Fqk7E3hPreQ1ijdSnqmWkAIn018FYOj5
	czxE5rl6T+b9VnqCf5q0kMv6PJ/SPbLI4YfNbVpBswgLRCvqTHxS6eb+DGVbb3h6ni8Pt5Jj+7E
	+vsmCMoupv7Rfadyt2ujzh04xrj9iT5+HrvR/CnmzRdd6OBMhpDc96GsCO1AyopjzzPdizt9zIe
	wvSTNhxshjKN3zn2nDzAE/LHrgvDx8kbi5w5P+t+9yeT2pV4u9pTQPJ5uGY/5knrSmBq0WblaeO
	SfhBtriBXG1Pw0=
X-Received: by 2002:a05:690e:2105:b0:651:cc9c:af08 with SMTP id 956f58d0204a3-65c3db4c149mr11088537d50.64.1777997700114;
        Tue, 05 May 2026 09:15:00 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1a73c7sm7319748d50.5.2026.05.05.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:14:58 -0700 (PDT)
Date: Tue, 05 May 2026 12:14:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Neelima Muralidharan <neelima@ti.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, 
 Pratheesh Gangadhar TK <pratheesh@ti.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <willemdebruijn.kernel.8d257bcbe351@gmail.com>
In-Reply-To: <20260505095216.T02Z4R1T@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
 <willemdebruijn.kernel.31592d82701e5@gmail.com>
 <20260504085911.nLZLRjPF@linutronix.de>
 <willemdebruijn.kernel.22897601ad5fe@gmail.com>
 <20260505095216.T02Z4R1T@linutronix.de>
Subject: Re: [PATCH RFC net-next v3] hsr: Allow to send a specific port and
 with HSR header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 794824D12DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284506-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Sebastian Andrzej Siewior wrote:
> On 2026-05-04 13:08:04 [-0400], Willem de Bruijn wrote:
> > > > > +#define HSR_INLINE_HDR	0xaf485352
> > > > > +struct hsr_inline_header {
> > > > > +	uint8_t tx_port;
> > > > > +	uint8_t hsr_hdr;
> > > > > +	uint8_t __pad0[4];
> > > > > +	uint32_t magic;
> > > > > +	uint8_t __pad1[2];
> > > > > +	uint16_t eth_type;
> > > > > +} __packed;
> > > > > +
> > > > 
> > > > No specific need to make this header ethhdr like?
> > > 
> > > What do you mean? eth_type is at the same spot or do you mean it should
> > > be named h_proto?
> > 
> > I mean there is no reason your fake header needs to be 14B or
> > or otherwise resemble an Ethernet header.
> > 
> > That ties into my last comment to use sizeof(struct hsr_inline_header)
> > where working with that header, rather than ETH_HLEN. It is an
> > independent header.
> 
> But I can't expect that the header is always there. A random ping/ arp
> packet goes via the same flow. At the same time I don't want to make it
> mandatory for all AF_PACKET users by checking the skb's socket.

I thought skb->protocol is the unambiguous signal whether this custom
header is present?

> The skb starts always with the ethernet header. To avoid collisions with
> a regular packet that looks similar I use the ether-type of the ethernet
> frame and it has to match PTP. It makes no sense to send a PTP packet via
> HSR. Since ether-type is at the end, I can't make it smaller than 14b.
> So eth-type is safeguard #1 and the second is SRC-MAC with a multicast
> sender bit set which is usually not the case.

> > > > All use of this information happens in the context of this ndo_start_xmit?
> > > 
> > > I receive it from af_packet in HSR's ndo_start_xmit, yes. Then
> > > hsr_xmit() is forwarding it to the slave device via dev_queue_xmit().
> > > Here the skb->cb information gets overwritten.
> > > 
> > > I need this hint in the slave eth driver in case there is hsr-offloading
> > > available. 
> > 
> > This assumes that the slave device is somehow HSR aware. But standard
> > net_devices are not?
> 
> Yes, standard devices are not hsr-aware. It is just your average
> ethernet device that sends everything as-is.
> But you can have devices with HSR-offload capabilities such as
> NETIF_F_HW_HSR_FWD, NETIF_F_HW_HSR_DUP, NETIF_F_HW_HSR_TAG_INS,
> NETIF_F_HW_HSR_TAG_RM.
> 
> So if a device provides NETIF_F_HW_HSR_TAG_INS and it is enabled
> (via ethtool -K) then the HSR stack will pass regular skb and the device
> will prepend the HSR-header (and maintain the HSR-sequence number and so
> on) before putting it on the wire.
> Also, the HSR stack will send a skb on both slave interfaces which are
> regular ethernet devices. But with NETIF_F_HW_HSR_DUP enabled it will
> pass it only to the first slave and expect the underlying device to
> forward it also via the other slave interface.
> 
> So I need to pass skb which is can be sent by a dumb device but at the
> same time a device which does offload needs to be able to know when it
> should not do it.

Interesting. I was not aware of those offloads. 
> 
> > Isn't it HSR's ndo_start_xmit that selects which slave to forward to,
> > based on the information in this header?
> 
> Yes, this is correct. I needed to verify that the slave device with
> offload capabilities does not send the skb on both ports and add a
> HSR header while doing so. The non-offloading devices are not an issue,
> it sends packets as-is.
> I managed to rework it and it works without the skb-ext. I just track
> the HSR mode (HSR vs PRP) and then parse the packet for its type and
> decide what needs to be done.
> This works now. Once we settle on the header I can repost it.

Excellent.


