Return-Path: <netdev+bounces-249059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C8D136ED
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E93830548BE
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94BC2D061C;
	Mon, 12 Jan 2026 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1VEhHot";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZHAQQrn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325802BF3DB
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229304; cv=none; b=SQcIWuAGa8l6aFWOoGlJGtWXG2dMYLHK+eCbmGwzJNW4rLLXsS5Zq9HTSqQBEJoqXiYSmbMxzISz1vDtMUfh2AViZ20jjU57a+t4VBJ1ymdsnUyu2IZqYErDeKFpgGJO6lbqEpgRCXzCoB5CId0jLbsJTqPzM/InQIgFq9HmPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229304; c=relaxed/simple;
	bh=unu+z7fUfKJmL/eHLl0giWFWnZl9lhh73IswOVtZOOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL9jAMtyQYXu5u/CC/tm9EW4BNWxAGLSEidOjbGVdqr9qBXjhj7JQcVNMgz7pA/NiwnnwbJR2hhhMo2ijewjQJge72ds1i0p8i+GdIMqFiLnWNS5jaXpbKEOX94QMrDQb0qNH3TKWiBt4LhtRnXdJ5fX9NLCHEdYYeY/G0/VWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1VEhHot; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZHAQQrn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4uY6QtcEAOdroKyjwSP1zoQ56MLnzMwcJEHXal3TGs=;
	b=d1VEhHotQbVbtnAj7PYpVDZVJZyfqcsRbDOlbaPOHIUxw04rMR7i+nyXpXcBwLb7LYFq0u
	T20o9kjZsASl/LJe7nLKEShfeIn+5hB/yCO+f/aAmbiTbwuP9jIBv2cKUYHaWo3ytCJZSO
	J732NUm8teOrDRElht9ul8lj+HxBjxE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-FAs7ewpUOmOWbquW3F2qYQ-1; Mon, 12 Jan 2026 09:48:18 -0500
X-MC-Unique: FAs7ewpUOmOWbquW3F2qYQ-1
X-Mimecast-MFC-AGG-ID: FAs7ewpUOmOWbquW3F2qYQ_1768229297
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432488a0ce8so4949216f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229297; x=1768834097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4uY6QtcEAOdroKyjwSP1zoQ56MLnzMwcJEHXal3TGs=;
        b=TZHAQQrnFm0NsXxpCwiKV14D4sSbSnp/ZKrtKYAN9oDZv09rzEQagt4uxI0u3tGgr4
         egVrNxwetLlLron4Ij/mlK1UAe4LVPKa1Gy/7fTdj2hzO3dDg4GdQLHzGmiVCIdG2xf9
         bdXP6U5D7fqWaoI7tcpoOQJhRyHGONZ39Bn2ObxqKgLWiKzGKY2UMi7sgfRmKN4XYh44
         USj9JILFjjo3CC10SmfTGGZhG5j5c4Iq+fyMuhsJq8Y/eXmJxE/h3OnEPQeOebdqppWu
         5vaxy3l6cb+HFv4QxTgomME64ENEOYrACy6japjmO5LNYbql9q0tgWnFsEmXF9CVGA+t
         i9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229297; x=1768834097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4uY6QtcEAOdroKyjwSP1zoQ56MLnzMwcJEHXal3TGs=;
        b=rfGoKxAEQ5zEyr0sazVD5tTGG60yuRk76OPX8Mr4JC5BAFE0BXYXr7EQWhJ4EWHqXM
         TLu117Qjvvj+Z/GOHJnpoJC8vxXYSf/N/efkZwAZ1Etnx7d2nd/X4edR7bDYGP2Y4ZFT
         wamlA6n2JzMNNbgHHdB0ZrmNUh6NzQyk+1PMtOs+AtHLBvV2XFJdFvuUt2FOXzYzHfYW
         b2RkB6Il5V+bfsIov72qcd7XIBv2d+pQxK97vA3dr3XhbkNdsU9XM1itML3/EH0KpzVG
         +PW55pz0DJqD59F7i3BA4grIbD/RUFzPMzWyAn4DewfWEbolzA/zyNvsVJvxJRx8hk5v
         snig==
X-Forwarded-Encrypted: i=1; AJvYcCWH2C8a57vfClhbjlK7zh3e1V2OggYSR9GosMMwBsUrGbq+t+pz0So/oFWDu0FTTwoc6NVj2tw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5C412nCwBeoAEgeAxK5jHaKiWqefo6ehDs+hMK6y56ifZMi4k
	U2awWikz20TxyPhyAh+p7wbaVUyg3IasYdcGycrRzDfPd2iqqUcZ9SsfcIcxSXTpMi/lhfAjfLO
	+5R2TFKbTLJUhZ1Eix/0MR8LyjJYSMF2c79B2f69JTG4z62EfewZxxqGL8w==
X-Gm-Gg: AY/fxX7D04xmC4sI+ZqZXUXwSkKk0wfSwsbfD787DK44f2eJgGIyLi3zb576lAR6fF2
	j1dskcZqlFOC1oThNpOuV0OoMjnYtKSB9ODq+FXcsptBQ+if6qUCxkt/Owl7TYinw1guuw5A+vb
	66Vx2jTmNJsOa79Ue3GUfUDn/h6cFV4QFPv+hFC+hAG/JIQ8Hhmrjm5wnPTmWCCerVsdOiNURwN
	c3zZurg8TwtZGW32djGEevUobKu9JdImil9tP5PuZgbhBJXnbWcIX1RSxQLJiiKaxqb1NTrBpv3
	OT68i4fqYaDQcAwgZxRU3Rv/u8TE3BsxLUkMPpXoLxB7qbWxhvSjfIhvX/JyZQX4eyNDFRubZqB
	fIZVlYKj6t+wpDIZ6BuXFnJQ0a8vaYPnQfEH6gyvtiy+eEN2QgkZrCUeeiSRmeA==
X-Received: by 2002:a05:600c:8b82:b0:477:7b9a:bb07 with SMTP id 5b1f17b1804b1-47d84b5405amr219660185e9.35.1768229296688;
        Mon, 12 Jan 2026 06:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJzr4Y2fS6XgBSkiJLd05rWsmzsrdXz2PkPaLKrPstYswApqBsGl7lyU7UX/8hluUAjZao2w==
X-Received: by 2002:a05:600c:8b82:b0:477:7b9a:bb07 with SMTP id 5b1f17b1804b1-47d84b5405amr219659855e9.35.1768229296265;
        Mon, 12 Jan 2026 06:48:16 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm19136662f8f.27.2026.01.12.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:48:15 -0800 (PST)
Date: Mon, 12 Jan 2026 15:48:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 4/9] vsock/virtio: Resize receive buffers so that each
 SKB fits in a 4K page
Message-ID: <aWUFnZTkdOrZAest@sgarzare-redhat>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-5-will@kernel.org>
 <fa3cd687961e63dd2b79780eb84c243c8d35532a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fa3cd687961e63dd2b79780eb84c243c8d35532a.camel@infradead.org>

On Thu, Jan 08, 2026 at 05:33:42PM +0100, David Woodhouse wrote:
>On Thu, 2025-07-17 at 10:01 +0100, Will Deacon wrote:
>>
>> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>> +/* Dimension the RX SKB so that the entire thing fits exactly into
>> + * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>> + * rounding up to the next page order and also means that we
>> + * don't leave higher-order pages sitting around in the RX queue.
>> + */
>> +#define
>> VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
>
>Should this be SKB_WITH_OVERHEAD()?

ehm, is what the patch is doing, no?

>
>Or should it subtract VIRTIO_VSOCK_SKB_HEADROOM instead?

Why?

IIRC the goal of the patch was to have an SKB that fit entirely on one 
page, to avoid wasting memory, so yes, we are reducing the payload a 
little bit (4K vs 4K - VIRTIO_VSOCK_SKB_HEADROOM - SKB_OVERHEAD), but we 
are also reducing segmentation.

>
>(And also, I have use cases where I want to expand this to 64KiB. Can I
>make it controllable with a sockopt? module param?)

I'm not sure about sockopt, because this is really device specific and 
can't be linked to a specific socket, since the device will pre-fill the 
queue with buffers that can be assigned to different sockets.

But yeah, perhaps a module parameter would suffice, provided that it can 
only be modified at load time, otherwise we would have to do something 
similar to NIC and ethtool, but I feel that would be too complicated for 
this use case.

Thanks,
Stefano


