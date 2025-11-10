Return-Path: <netdev+bounces-237109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38AEC45359
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8C83A9BBB
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB62E974A;
	Mon, 10 Nov 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEUpycRO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwsK0g7S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A677B1F4CB3
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759630; cv=none; b=Gqch13FgMtpAJ0L0sFib+1+xI4zdN0xFLfrSzqEYJmELAuV9rxCkiEofAMoPjRl2FywvmdRtXsaFPbJluB1hRHZ7POg4gaQorELTy0uuPvg22kgT5dQV6JPyfJepEAGy8tYU0eNDSJaUoyCF/6ZqR7LeA+IYvujtfGP/EtsXbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759630; c=relaxed/simple;
	bh=XUT23dtRQ9JDXHuvYsTi21YFd/7an4tE9F+V5WLNTAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3xqgsmqh6dhB24VGfOaEiySGPxLWAyP7TM5ea5KYuPWAtHzLiuIWq7vvpFBNA16b+srW7KyVLu7+tJqvMXJOsR6CjgIfZe+5IcsIZobPRtgUcJnykPw7gI2ZFhtI2nubCboMONRkO0pXftZqLVZhvuX+wXb8cGhzN2IkhSioHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEUpycRO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwsK0g7S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762759627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eN2rz2uTu9iFkEupVoH3hbAbTYcyN2eAv1mkojYGSTQ=;
	b=KEUpycROR1TtTdPuplHP0WFn/wWU9BfT7BMo1SIvPxT82VEjmK3LM7iJtm3TBEGBae4Dqi
	qhHC5HzJHPxmxXZ9lIJlFSI5W8TocFQSSOiJ8yt+hXPQB1mbvi92bAmLr5pace7WHRROEX
	yaryGYlb8d+Zec2/fgGzttP8cbPAjE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Ba68nOHHP4GzwN4cVz9QPw-1; Mon, 10 Nov 2025 02:27:03 -0500
X-MC-Unique: Ba68nOHHP4GzwN4cVz9QPw-1
X-Mimecast-MFC-AGG-ID: Ba68nOHHP4GzwN4cVz9QPw_1762759622
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b30184be7so417165f8f.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 23:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762759622; x=1763364422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eN2rz2uTu9iFkEupVoH3hbAbTYcyN2eAv1mkojYGSTQ=;
        b=BwsK0g7SDIkwpnuwt/3Jo1brUlPscLdQIYP8mx4pYcYJ6FPqi+6WPX31Dm0Jw0/VrI
         N81ux8XnqFPNDl3eMVYe9OaJtMWpapXfoOSgAWjPP/o4jG0caoe4WoXrCtYL2Ej1TNQi
         SpsyI8TrCtxiFe2qAfuEen1m27zro/I4lA0HUUhDZaU5+wc5vhLM3kcLHi6NwsvCt8pj
         J7Rji0Uaw+qL11/zTM/WCkjt92nmb+Zw8QOqEe/5hckxYyN6LhtS/CAUoCZQ18Cf2fK5
         74JcZb8CzEaFDOwZnn4U9KaPkLYpruZHSZp/nxw6rGk03xryRQV1OGDcXaUzZNFAfmHn
         H9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759622; x=1763364422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN2rz2uTu9iFkEupVoH3hbAbTYcyN2eAv1mkojYGSTQ=;
        b=dEE8zJvqKCBFd/28jB+vAyR+LfY6f/PCU/04GDpHDy3wnZ1q7I/wY4Zv7rUIyl3RfL
         zl8e2z9eKqoMKH8DdX5PeHVt9XjEQpE6PKh2dElJbOzUlweJglPL2t+5LwLLtYP4Whjb
         zdphej7x7S/xaht03DDyBTfkpWxgcQcFADOsOBpJD7Y2zViPcKSG1VYMQrPe9eQpRZeC
         noa3KJjCUPLDvNiXb58yGNSsoE1ux0T1x/SqEhPZfomqRfNdfkhoz/Wl2Us0ZwWAQRbm
         ydABSXzr1jHzlggh/uRrT/vSyrHhpik9QH/vgzB5B4h2Iab4N3ZYnqG5kMdPjVAFSGJi
         rWAA==
X-Forwarded-Encrypted: i=1; AJvYcCW4qlhCoZQg+3/ttwwy3EBJIxKZPWB3Ebp6yT7ojFU72A8LnkLJ6QoXDZq/6ZjmRAaRKZB6Wik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0VALwhpqn340tfrPRUDdoPjNaahplbR0tnaZlAhzjKp0mARY
	XmBmFoQPqWOaq5ED1Zvc/ZM2b76SXicJ0OXdIjPnJ1ViLKvActVg6lpHekgLIUv0IxVK5dMHIEG
	q754dehCrzI6T0BI4vbAFxZ/KiOzPTxspQGwg9QsqZrKB0bytddoNxDYdGw==
X-Gm-Gg: ASbGncvopmaBB0xS0sMue8wHm6+dFGeREdGOKdoDqu5Gs+zNWwb2vodnrsHO9OQblXe
	erml33RibnwYYlnpMn9J6vnriduBxbnLohLtCSkvITIuJemDinYdFTqoGs4C7LoOlf5R7bAb/nu
	vYDgiFad79p7svmw1quamv5NhSbX2IKpvReKH+vo6ce2kz/n8CI7YA0xmh8wa6GBhXf/YD7cZNv
	LF5xMLN/Omk2/OtikWu9bdBECQ4LrxzpY5D300C9dD3QdPTbMzE1IVeSLVSN5w8620fHaLz3XxH
	C3foWs5G2bYOFDIuCzM32eGltl5YdKh9BFFTyQ+3ZMinNHPf8S/DI1Pm307ysx0t7IQ=
X-Received: by 2002:a05:6000:4112:b0:42b:383d:9c8e with SMTP id ffacd0b85a97d-42b383d9f37mr2993490f8f.41.1762759621751;
        Sun, 09 Nov 2025 23:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/a8qq+Ue+iHNjogq2bkP0rULMW/kLl3jHcx5gWR6m6UdyH6hhrWDWgTsH7k/b1hskYU9tew==
X-Received: by 2002:a05:6000:4112:b0:42b:383d:9c8e with SMTP id ffacd0b85a97d-42b383d9f37mr2993448f8f.41.1762759621250;
        Sun, 09 Nov 2025 23:27:01 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm15051311f8f.2.2025.11.09.23.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 23:27:00 -0800 (PST)
Date: Mon, 10 Nov 2025 02:26:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v4 3/4] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
Message-ID: <20251110022550-mutt-send-email-mst@kernel.org>
References: <20251029030913.20423-1-xuanzhuo@linux.alibaba.com>
 <20251029030913.20423-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEu=Zs-T0WyD7mrWjuRDdufvRiz2DM=98neD+L2npP5_dQ@mail.gmail.com>
 <20251109163911-mutt-send-email-mst@kernel.org>
 <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtxfZh=66TSTC2B8TdXWP-fsTrYFkfz5aOViYkZmmcvxg@mail.gmail.com>

On Mon, Nov 10, 2025 at 03:16:08PM +0800, Jason Wang wrote:
> On Mon, Nov 10, 2025 at 5:41 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 30, 2025 at 10:53:01AM +0800, Jason Wang wrote:
> > > On Wed, Oct 29, 2025 at 11:09 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> > > > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > > > feature in virtio-net.
> > > >
> > > > This feature requires virtio-net to set hdr_len to the actual header
> > > > length of the packet when transmitting, the number of
> > > > bytes from the start of the packet to the beginning of the
> > > > transport-layer payload.
> > > >
> > > > However, in practice, hdr_len was being set using skb_headlen(skb),
> > > > which is clearly incorrect. This commit fixes that issue.
> > >
> > > I still think it would be more safe to check the feature
> >
> > which feature VIRTIO_NET_F_GUEST_HDRLEN ?
> >
> 
> Yes.
> 
> Thanks

Seems more conservative for sure, though an extra mode to maintain isn't
great. Hmm?

-- 
MST


