Return-Path: <netdev+bounces-100027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8248D77A6
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 21:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE2E1C20DC2
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422E74413;
	Sun,  2 Jun 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUJFALTb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6210795
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717357856; cv=none; b=UaKoEaH8VKeacpwx7Muo3gQwYOpiMh3I6/pI1jX+dXGaxiIMNrtYl9enmQSnqjmto2EgS3+iHn8VGeAEP9EiBmf7D0LTDfLsMw84wQGLrWMEksGy6jlXSdWq+o2AnlSAopSdi/Tk6L/AZ7nowEQJ+ivsjHpaZcOlt4j7PmBCwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717357856; c=relaxed/simple;
	bh=gPFTxi1ykAQRIrBq4wXHZNf/fKBP3xSqjBeWh75o0T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K900/kaj588qAz8vlesT5p2M/ISkKuash5BaEhXHEs9h06sz9hhq6iudD2X7F3lBanZqCbncJN7R6pnLBguFBNCQbQzPzd6nrIQVaW0MCivwWzCNSV/F0C0AIpg2FnQeIZXNfQuilEI3vJ2HdRy4Ip1/AdOjBPEFTJKBRt2BgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUJFALTb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717357853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ7dcJrZdfShxTmy5eRD0xFRdj/3JG84Ancyo6SGE5Q=;
	b=WUJFALTbXo3spwaxoccQHH3B6ElOktXx/FeX5/I5Llmbu+vv55p4D/4X/g1QI0HeSG/XYp
	SMvfBP3r3DxO8X23+ztvMZSwgUkNgZdUnpsfbZcWk5A9JfJQZg5Zox383RzZ5YET/TY6z+
	CExddFil+vzFaFd3gr5tXcyH1aG0xFA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-y05NoanpPXCgjPDbtlQhZA-1; Sun, 02 Jun 2024 15:50:49 -0400
X-MC-Unique: y05NoanpPXCgjPDbtlQhZA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4212f105f0bso11240145e9.0
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 12:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717357848; x=1717962648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ7dcJrZdfShxTmy5eRD0xFRdj/3JG84Ancyo6SGE5Q=;
        b=RooGsn95J7pme7qZ7OEcjtbJwXATkiFTL/NDoG5OnBW12bF/6e7S8sx/FZF95Wh7Dk
         9xAfL+rTIOWq98QhA+wmaQCZksCZE5nofbsRNklNVeZePEy0aydfStyunsvHkj2C1Fai
         mG7ZGtJppuDaBjfE4IjfGVWGsFKfi8hqIBDQjXgBosWQFOC9mZBjFVYT7oRIorNZjw6f
         aQ1FeB5iC+BfaweIZDuVWGJQuR3mtT1SW8HkWixiPznnSDfNHT8hpXOlIghh6AKgoRf/
         Ok37mrnL5DWSaf6Wq+N4/RxcV9GFTx07+0CB2MLkGHvhyH4HWtVJfIbyQeDBHNXXG3FG
         1RIg==
X-Gm-Message-State: AOJu0YwrK+8g9gCDjXQpgl8lfQHbKvrbPTxx2Wl/Otr56mo6IOMECO39
	fgz5XleFm5rVziA8ZTKKszu31loL2vpWzUwlCkJTy7hHIucU45drl1I7fhsLdMYSCltiSjyxKgI
	9819kM2Z1I45o4pj+s0SayljK41wnm3l/22GjZgNKRcHVOI7y3ggGDA==
X-Received: by 2002:a05:600c:3b8d:b0:420:29dd:84db with SMTP id 5b1f17b1804b1-4212e0ae51dmr48109665e9.35.1717357848067;
        Sun, 02 Jun 2024 12:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYqsXbQOYD23JV0Nxts22Ok3ofm37UBzuKMoSngQUM7XRrHtQ+KzJlWwXOOHAHTXv0enXVpQ==
X-Received: by 2002:a05:600c:3b8d:b0:420:29dd:84db with SMTP id 5b1f17b1804b1-4212e0ae51dmr48109505e9.35.1717357847536;
        Sun, 02 Jun 2024 12:50:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d98sm6838419f8f.24.2024.06.02.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:50:46 -0700 (PDT)
Date: Sun, 2 Jun 2024 15:50:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/12] virtio_net: refactor the xmit type
Message-ID: <20240602154943-mutt-send-email-mst@kernel.org>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530112406.94452-13-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530112406.94452-13-xuanzhuo@linux.alibaba.com>

On Thu, May 30, 2024 at 07:24:06PM +0800, Xuan Zhuo wrote:
> +enum virtnet_xmit_type {
> +	VIRTNET_XMIT_TYPE_SKB,
> +	VIRTNET_XMIT_TYPE_XDP,
> +};
> +
> +#define VIRTNET_XMIT_TYPE_MASK (VIRTNET_XMIT_TYPE_SKB | VIRTNET_XMIT_TYPE_XDP)

No idea how this has any chance to work.
Was this tested, even?

-- 
MST


