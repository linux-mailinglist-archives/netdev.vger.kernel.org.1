Return-Path: <netdev+bounces-104164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF7190B617
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9A428366A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615E817C68;
	Mon, 17 Jun 2024 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d71eeYtt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E117BA4
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718641113; cv=none; b=luTj+yI3u0e7Qz9DF8RtAarvAzKfktbEY8if4iYaPbnQ4qdU2P1t3MXtqGN6S1z8oqDNwOjrYfQ6RsL8bWCQTMXnu9QxKPsgtK0gp4r6X1aUlZx6YsepcnmcGxjxS3Kv1Y7wVboiu59SfKmwyOS5RgWBWLLmMEv5sJpKJJNc9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718641113; c=relaxed/simple;
	bh=Xoln7j8EbQc4V569jmXeK9Nyl281J3NJCSqkqztUsY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzZT70bphuwL3f7usV6NZKSlEx0cx87l+aT/i/7M0aQE38VaEmlq0mVJa85+QwCQvJ7mUVCP4Ld1SDga9svYl2FSDil/fTv7qarSIzOrZq/z9PIfUiaq1HU871lETyeBLsqYkJRNYjUNfHY1GVA+cROfQA7mErIXAiOCKzptvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d71eeYtt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718641110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sFZFlosMMIe4sydwcE//6HkoJc4uYg5CDJdWIzZfrtE=;
	b=d71eeYttM4vmlfEavTdEuUV+/ikxmZhKnVRy9T3sZjOq7GM48pv48tjD/LIZaFUVsetj5j
	47Rp4ruXt+38G+haMzyb76FGENfKd5ckgXIcCb7wjSRRX5mkPF053/XBrbjeU+mTE1b89z
	QtOGggfaWxN6u/TNXpLn3wHiaM02VlA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-CM_imOqcOauA-NdbeImzBQ-1; Mon, 17 Jun 2024 12:18:28 -0400
X-MC-Unique: CM_imOqcOauA-NdbeImzBQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1ddd8a47so2282843f8f.3
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 09:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718641107; x=1719245907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFZFlosMMIe4sydwcE//6HkoJc4uYg5CDJdWIzZfrtE=;
        b=Cqz6LMSmItplRAXlEraCriaFJ2IELUgrEac+R5v3taHy7OWMDqKFxgygmFVm7i7MTD
         yoc2w7ip9myBmoH5tRCkKye87SM1jiBGocktrLUDBlLCjQVWWi73c8aA4YXLGto3Rrkk
         /kVqUsK2wxYtIB6dvootjx28KykNGvDD61mwawv/hd63J7XLklJjBTZnkXouU476Bp7Z
         Ps4+sLGrPMGf7rNMLtpiSaDH9oLi6OCIXStkM29AY63sChoQ3TkYvNXVLDnNZc2q0cD/
         Au021YJi5ceiAhaVTJ1sPzYI0JB/58DelxXlOu7JlCyjVb//pjlGpko7GIKSB7xRVWYh
         xMYg==
X-Forwarded-Encrypted: i=1; AJvYcCWIHPeYkue/NTQAeDk3ffQQvwdsb+0VLgs/5Zl92gTIntZMI3OSXugFCUKzWQp/HekRBPUHBLQDhjZiS/3k0zacZf9+IChC
X-Gm-Message-State: AOJu0Yyh8TKHO/XQkw5XgccS+L4dt7HcIkdv1ahSuWj5O7f2tVITKblF
	prISn82z5p5aHr1RB3IAk5gSvh8k0nxs4drEL0/tZj1S0lVNLu6/kh/oM5TOLJ/o1pxWzVQM8O5
	NdYSfUdfly1k5mweIsIa5mjriJr9IMs1LIjB2BUjj0WN15veraZh6/g==
X-Received: by 2002:a5d:6104:0:b0:35f:1f19:594d with SMTP id ffacd0b85a97d-3607a76b530mr6829037f8f.33.1718641106876;
        Mon, 17 Jun 2024 09:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbulzU89H9MpwhLDESOVQ9ymHNpAT6A9fGxoXOf1BjyfaorPFCdoAiLsEBxLzhvIbwN+dt3A==
X-Received: by 2002:a5d:6104:0:b0:35f:1f19:594d with SMTP id ffacd0b85a97d-3607a76b530mr6829009f8f.33.1718641106428;
        Mon, 17 Jun 2024 09:18:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b74sm12124104f8f.107.2024.06.17.09.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:18:25 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:18:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240617121737-mutt-send-email-mst@kernel.org>
References: <CACGkMEsy37mg-GwRXJNBBkvhEuaEYw-g3wthv_XS7+t5=ALhiA@mail.gmail.com>
 <ZmG9YWUcaW4S94Eq@nanopsycho.orion>
 <CACGkMEug18UTJ4HDB+E4-U84UnhyrY-P5kW4et5tnS9E7Pq2Gw@mail.gmail.com>
 <ZmKrGBLiNvDVKL2Z@nanopsycho.orion>
 <CACGkMEvQ04NBUBwrc9AyvLqskSbQ_4OBUK=B9a+iktLcPLeyrg@mail.gmail.com>
 <ZmLZkVML2a3mT2Hh@nanopsycho.orion>
 <20240607062231-mutt-send-email-mst@kernel.org>
 <ZmLvWnzUBwgpbyeh@nanopsycho.orion>
 <20240610101346-mutt-send-email-mst@kernel.org>
 <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvWa9OZXhb2==VNw_t2SDdb9etLSvuWa=OWkDFr0rHLQA@mail.gmail.com>

On Mon, Jun 17, 2024 at 09:44:55AM +0800, Jason Wang wrote:
> Probably, but do we need to define a bar here? Looking at git history,
> we didn't ask a full benchmark for a lot of commits that may touch
> performance.

There's no may here and we even got a report from a real user.

-- 
MST


