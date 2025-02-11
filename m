Return-Path: <netdev+bounces-165094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EAA30673
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226767A0621
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D111F0E25;
	Tue, 11 Feb 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZq3/7Bu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF0B1F03C5
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264084; cv=none; b=EJaFKbiQOF/d3tfQyEzAmKaNVOlMm4jUYlaMgU8wzL9IhWAnxxbCxz+x0PRCh5T7pGZGsynRjMJfhyc3rqDFqQClzC46Kw7kDJ82giTgktklNk627DQkqSH+N2OdErvZoAPSwpkiIHsdqm4oKhgJWIl7XcukyDzdamAwteqHkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264084; c=relaxed/simple;
	bh=A9OGoTsHrjtvyBc5Q07ZgbbmAyoBumXm7SUvVbyvJc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGR7YibOSY+6PG5vDzMVLSDutFXBeuHXiPFWjN92aUfjt0K7Z77Kqy2ObCcks8Xa9PolL/o57//bg6ae7KhGi5QEEdff6z9f/woiEWTZeGvm/tUoUafXfI0R70pBiMHflxN61eiHZk+1fFteQKvEk4C9VzA/EVeHoeGp4+7V7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZq3/7Bu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739264081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JLq8TzMXCM9fnXbwXAYKIjuUWhuJvIj9pOn4Osk/Hg=;
	b=GZq3/7Buua4e4xWI7jRkfUghkVpbsyf2KBHk/uEQi+KHCIoljcmDDc5URwia7Lu9PQ6SZJ
	BsdOpyrXh5EjxB04vUZ2/9ZSd2KkzXwv2yQstrmQNd1WEVv4+MQrtkavCNOYrU5H5ytqjZ
	QNfLPxm0kKqIWYOi3Vdu2t8j+iyVmZc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-xt-meVDPMNS3ZQ5t4NFTfA-1; Tue, 11 Feb 2025 03:54:40 -0500
X-MC-Unique: xt-meVDPMNS3ZQ5t4NFTfA-1
X-Mimecast-MFC-AGG-ID: xt-meVDPMNS3ZQ5t4NFTfA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38dca55788eso2176911f8f.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:54:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739264079; x=1739868879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JLq8TzMXCM9fnXbwXAYKIjuUWhuJvIj9pOn4Osk/Hg=;
        b=f1uLLCr5cn0xnrCrfopw1OICV+7iWF5s7765dcVh5NrIcsibnxXJMDEB0Ce8tMv6c3
         4+IbZeOIMBR/x5dqwJKriJWFD7KTAK8QBWN1WVgQ0gwtIPBEH0WAp5UIzUmYBmzRv9Ha
         uGgnFF60796SuNLBIUh/bvqJ2TWpzgar9i4Dhnl0NnVdToN80A35QnAqqFPfEFUElthS
         BquKwg8JJdrCL0O+xQqzysJkLviKdh38RwkzFEz7HDsXr7rLN0PN1wbK8rJ8zKufkvr6
         2IARa7Ue3lVWMeDxOL5GgQAEQw5iD5LV1AFBSBR3zi4taW1xji0vg4La+7Bjxj9OGmLm
         IcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJwlPHG/obtLuuuUhBtOx/LFCqZTpRJLx9oznOs8bbF6ENjPYP720qReD348fzkNiRp4GSk08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1qKXPN58BCw/wfDJ6GvAmWpPPnvt/dMDtgRozFZ0LfQRqpHx
	RBM2WUfpC5xqcbn5/Tbfq25JtIObB3d0HKrRQ7U5lMKnZFxEFeiWZ+jaYDMkpiHS+JZkz0Y5mHk
	ivkJMFpN7UjjT9IQU2X+vIqzn8z1Y7Mu7PT40dmgUo5ccEKXjgaiokA==
X-Gm-Gg: ASbGnctpvnBrouOT6e5gbLtJOjZ7CJ722NwaRSndBBttXDOMHfugrh/Xy520xNOPQi3
	CyK2GVHc6wDg/L2TXgyd1GYb6DyJ96vWVscpen4VQG2zENesGjU7fcxSQ4WpUUI5ibsq06fpGRH
	S0jJRApcE6U39N6DSasM8GDmy90xSlOWOLenWZnN9/fNDNDgXLJ9SLXFGh86/gSyx7cz0siFom+
	hA/d+xtE2Pnw4KZdNiy9uAW3tj7ObP5wnAzKnlwomg8VKN/Gl86PFoLratzrnGZzVlPe3XWJonc
	D4goqA2HdWQE/TLBRG4GymEDQ7z2OV95eIn5mLaxJpzDQaYGBh8yoQ==
X-Received: by 2002:a05:6000:1a85:b0:38d:d906:dbb0 with SMTP id ffacd0b85a97d-38dd906dcbcmr7731129f8f.7.1739264079242;
        Tue, 11 Feb 2025 00:54:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+FXQlM4sVQQqQ6bfC1MLrVyaITtJSDcEgeRD57O/EtV7ZEKzfLqyRzc94bzpSoemBGMAbgw==
X-Received: by 2002:a05:6000:1a85:b0:38d:d906:dbb0 with SMTP id ffacd0b85a97d-38dd906dcbcmr7731090f8f.7.1739264078600;
        Tue, 11 Feb 2025 00:54:38 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394df55f51sm12596505e9.0.2025.02.11.00.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:54:37 -0800 (PST)
Date: Tue, 11 Feb 2025 09:54:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	q1.huang@samsung.com, ying01.gao@samsung.com, ying123.xu@samsung.com, 
	lei19.wang@samsung.com
Subject: Re: [Patch net 0/2] vsock suspend/resume fix
Message-ID: <jeqyqnuqklvk4ozyfhi4x4zadb5wxjvnefmk7w4ktvjna4psix@fc244relosif>
References: <CGME20250211071930epcas5p2dbb3a4171fbe04574c0fa7b3a6f1a0c2@epcas5p2.samsung.com>
 <20250211071922.2311873-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250211071922.2311873-1-junnan01.wu@samsung.com>

For the third time, please READ this link:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

This is a v2, so you should put it in the tags [PATCH net v2 ...]

And also include a changelog and a link to the v1:

v1: https://lore.kernel.org/virtualization/20250207052033.2222629-1-junnan01.wu@samsung.com/

On Tue, Feb 11, 2025 at 03:19:20PM +0800, Junnan Wu wrote:
>CC all maintainers and reviews.
>Modify commits accroding to reviewers' comments.
>Re-organize the patches, cover letter, tag, Signed-Off, Co-worker etc.
>
>Junnan Wu (2):
>  vsock/virtio: initialize rx_buf_nr and rx_buf_max_nr when resuming
>  vsock/virtio: Don't reset the created SOCKET during suspend to ram
>
> net/vmw_vsock/virtio_transport.c | 28 +++++++++++++++++++---------
> 1 file changed, 19 insertions(+), 9 deletions(-)
>
>
>base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
>-- 
>2.34.1
>


