Return-Path: <netdev+bounces-246715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B90CF09D0
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 06:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5178300F32C
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 05:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB852D5959;
	Sun,  4 Jan 2026 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg6Zqa0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D002D593C
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767504551; cv=none; b=F/M65HTneztvNgGwD9YXLHE64eZ9gdLw7TJw0MRyhgpZ5FISr1XPLGsVqiK64SKgHBEq+5aMY3ptDOlgzEyI4fCDThMkIFmypuFCXrg1g1ZccBguGlmjMpBFoxqAbyueFnO9Jb3F3mtsK5pO95kNI6CvlzadXsNqz27f9dplzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767504551; c=relaxed/simple;
	bh=65vgSVMqf/BQy1Yp33ggrUZQR1FCpsrPR3lKZwoF6e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZKULY/4XJJ61ZIl89Phz1AEV1ARNixmQjE9ibAs23QCxUgczyjpQaa6qZJtTdwI3USb7ogdGyRtpMVmKuP02USvtepp3sWa0yRB8do4Ne6834i2i+W+n4rHGQyrByNX0m2zER7LUB8WrlXwxHPwHyDOlRcbM9RyS4OCh2/kDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yg6Zqa0y; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11beb0a7bd6so1228607c88.1
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 21:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767504548; x=1768109348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvOkP8SZJigPzeyYaj+yZhhAkS0A2aAjhXuUNUZVL+k=;
        b=Yg6Zqa0yl4Ps3xat499EvczeKmPP3moBORRbUlV1QwjEzeMc2FetSIJuCtbs0xtf+l
         lCWXpwZzaZAEqvlD0feNi3BzaeGwEw9+ejVV+ZUjPH1Lpan1bVeLIixJaVysBv+/t5IV
         X6YFXEH5EKv1KMD6dbg8J7d7sWaWzu8wK59iQ90DJMds5LwqrLJEMQcY49mX6eC/kQVV
         bHEo2ypbv+2s6Wj3z8y8lxVNyQBOTMvbiL0tTw7YnhkiXz3fUdvsRDd9kbVNpOkjDxQ5
         DBrABF2OGuS5DIGq7A+GwgXOr3T4uR8t7sJyTp3eHFAUf2ft/ISVWPeE2X7lvHUzovGG
         FAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767504548; x=1768109348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvOkP8SZJigPzeyYaj+yZhhAkS0A2aAjhXuUNUZVL+k=;
        b=DxerIzqAJXtjcVSAbwDF7IWWU+b/K3g//egT4So2qbVBCrI2bOG3gww/rjZxRRDF5R
         1z1Zj2ZSr8zi8DwSPhkW79NUN8348B4DpBe+A7DsUezaUs3/OGaLnRKl1J82zRhLg7Sc
         VZRBRW9VB72NkfXyMbHuDzwrHHjKGG4Q3uX6qzMzy4Ya/mzlryWEb2CVbLwwihs+dH12
         GA0oGCQ9qVzXQ9lbP4PPHVpFqlBEL2zxwUdvKHyqn3AP4hiaXzPC7GGO7CK4DbfPGUWF
         ZzTWOvCzrfFnmGiaYgCknj0r1+TCuDNbkVi6a6KGd69YXw9YcpNpjwc50Q07Egywwfes
         Cy6A==
X-Gm-Message-State: AOJu0YxkmUSvDG/omJ2irQ9YBqRkoSWJ56x/SNGshiZWD3BhjLa2IEcf
	5NHA++udhDrVGBvgvoFJWs9VC+nPJtuRG5pGG8NMgOvE0GQL/m6oAkWf
X-Gm-Gg: AY/fxX6gd0C3x+uBmIv/OnYNj6DQQ8dNJFbWVct5G9UlWFNkkLOab3WP8mFPSZ4WAHG
	keGwTRA7UzfdySmStVFdRMOdHWD8P1i1Im7iM/cnI8pOJ5aLsSOhCku+23m9zri2a1QMp/JKOUc
	Ar68/BMUPp82H+ej401PKP2bBEtOknF811sIHVsS4ENZc5iHDXR5VEVpEjvaf7gik6M2Wgii0My
	BHGWe/j4NRzlAC5aJ117sVqQSHObS+PgTxBQfT+yGZ5Vxu6Zhkr5FHXDGHHfMEsOT00ChgC3hM8
	63pG9EQFBOVLh33bXUhNWWwvMcK3BC1BeiH5kOCYPdOM4h/kwjRGOCYC270L0pPAsAOu27MzIR5
	sSn5M6ctOEX03lZixpK9s+W+RhiMYopfy6Ce8oKfEiD+eI1KFic+56CsITBGZ/KJZeeK5jqAldc
	bMD1cg03K3fIIedC8S
X-Google-Smtp-Source: AGHT+IEUP35P72PXbqK3T+Jw88HQN7ZqgMrv6wlEXPBBGaZBS9BBhhgZozXciIYpR2i4MqLpZOsSXw==
X-Received: by 2002:a05:7022:320:b0:11f:3479:fb72 with SMTP id a92af1059eb24-121d808b16emr3204222c88.6.1767504547989;
        Sat, 03 Jan 2026 21:29:07 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:8a10:ce2:890f:8db0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm164944598c88.4.2026.01.03.21.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 21:29:07 -0800 (PST)
Date: Sat, 3 Jan 2026 21:29:06 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, Cong Wang <cwang@multikernel.io>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [Patch net] vsock: fix DMA cacheline overlap warning using
 coherent memory
Message-ID: <aVn6ooxGnWH3X8ZZ@pop-os.localdomain>
References: <20251228015451.1253271-1-xiyou.wangcong@gmail.com>
 <20251228104521-mutt-send-email-mst@kernel.org>
 <aVGz39EoF5ScJfIP@pop-os.localdomain>
 <20251230081220-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230081220-mutt-send-email-mst@kernel.org>

On Tue, Dec 30, 2025 at 08:12:47AM -0500, Michael S. Tsirkin wrote:
> On Sun, Dec 28, 2025 at 02:49:03PM -0800, Cong Wang wrote:
> > On Sun, Dec 28, 2025 at 02:31:36PM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Dec 27, 2025 at 05:54:51PM -0800, Cong Wang wrote:
> > > > From: Cong Wang <cwang@multikernel.io>
> > > > 
> > > > The virtio-vsock driver triggers a DMA debug warning during probe:
> > > > 
> > [...]
> > > > This occurs because event_list[8] contains 8 struct virtio_vsock_event
> > > > entries, each only 4 bytes (__le32 id). When virtio_vsock_event_fill()
> > > > creates DMA mappings for all 8 events via virtqueue_add_inbuf(), these
> > > > 32 bytes all fit within a single 64-byte cacheline.
> > > > 
> > > > The DMA debug subsystem warns about this because multiple DMA_FROM_DEVICE
> > > > mappings within the same cacheline can cause data corruption: if the CPU
> > > > writes to one event while the device is writing another event in the same
> > > > cacheline, the CPU cache writeback could overwrite device data.
> > > 
> > > But the CPU never writes into one of these, or did I miss anything?
> > > 
> > > The real issue is other data in the same cache line?
> > 
> > You are right, it is misleading.
> > 
> > The CPU never writes to the event buffers themselves, it only reads them
> > after the device writes. The problem is other struct fields in the same
> > cacheline.
> > 
> > I will update the commit message.
> > 
> > > 
> > > You want virtqueue_map_alloc_coherent/virtqueue_map_free_coherent
> > > methinks.
> > > 
> > > Then you can use normal inbuf/outbut and not muck around with premapped.
> > > 
> > > 
> > > I prefer keeping fancy premapped APIs for perf sensitive code,
> > > let virtio manage DMA API otherwise.
> > 
> > Yes, I was not aware of these API's, they are indeed better than using
> > DMA API's directly.
> > 
> > Thanks!
> > Cong
> 
> BTW I sent an RFC fixing these bugs in all drivers. Review/testing would
> be appreciated.

Thanks for taking care of it.

In case you need, it is 100% reproducible with CONFIG_DMA_API_DEBUG=y.

If you need my config, here it is:
https://github.com/congwang/kernelconfig/blob/master/kvm-debug-config

Regards,
Cong Wang

