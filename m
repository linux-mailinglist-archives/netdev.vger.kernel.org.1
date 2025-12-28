Return-Path: <netdev+bounces-246181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DFCE51D6
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 16:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7050E300B81D
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCC02D061B;
	Sun, 28 Dec 2025 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZf+wBRh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+/Mi4yt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB5F1D95A3
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766935254; cv=none; b=im/n6LSZcaRryrgpFlRNNv1TRx/fA/S/MOverev6qRrdeCrpEY+gNzo+Eec6pE5bqsBZJsA/yNj/8jgXsagsin/f31OZ2Agh93mP2z6x2YfkGlE9b51VjODIIxlLxyS06Ju9aBS5ygLpXDOyKqx0kSesSsm54Rm7maL5Y/OE3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766935254; c=relaxed/simple;
	bh=fpXtmAA+RNriJg/+1iSarUAoS4iS6sPSHSP+qgbePRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtcsKTF9J4HmXHoLu/Ae2VHcB8oJwGzgLIXX19rv3NXiOWi2YA2RL92eG7nbZpwPziyMP3qDwaySUATR0jPuRdzPcpWl7hpq6d8VlC0yQ7+Qa3vsjiCvs69L2rwfi1373I/RZL43/9f38H/NlL8mbJGN18kULua4RhAIkyXvjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZf+wBRh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+/Mi4yt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766935251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j0rnxqRbvo50owZYjxe/Uz4dKBVSBK5opK+mrnaIhE=;
	b=JZf+wBRhD0vLKwVxPVmJh4mJjlP4xMnSuReYB0aebheBP+2N9/uPY8hq3F565dPIqFBZZd
	1hIZ8F3YnsjR+a+SjQEEehD4kv2JPzjZhfvPjL8SHBW/CM+DmLr8mNbXM7JRXXCRwFYHmf
	+WPAVbNLcW73iOB8kHgAzXYKzoVsRbg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-cmtKftPFNAORdYEd7m2I3w-1; Sun, 28 Dec 2025 10:20:48 -0500
X-MC-Unique: cmtKftPFNAORdYEd7m2I3w-1
X-Mimecast-MFC-AGG-ID: cmtKftPFNAORdYEd7m2I3w_1766935247
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430f8866932so6824562f8f.1
        for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766935247; x=1767540047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5j0rnxqRbvo50owZYjxe/Uz4dKBVSBK5opK+mrnaIhE=;
        b=M+/Mi4ytS6IFIaq/DCXXF3xEw1D8mFEQ145a1+RWiLC3oEwWr3bO807e+lXA1J2TfL
         DmUFymbOYEBEM7AgxoC5gwJyBcSHhYj+QYLy0pTwln0CcAVZx94MCe/g8SaoNhd+uQvK
         P94y5OT3pp4fNuTpJ3lZJg6TzBoCZtoRGu9j4qwWFFQn0c9Ar64V5+6EhH2Uys0ssTQV
         4gS7oNMVMCv9aysfrg1D+XyOEy8S9KxbTs5rpnwjfMu82YSlIQBeDCGTgh6gAg3D1o9w
         PZM33S6Ulg3ptkSNPkh14ZadztGLtHQSMWJ4cnJLKmfUJN5PJy7dbCz3NAyaxji12NdK
         Xqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766935247; x=1767540047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5j0rnxqRbvo50owZYjxe/Uz4dKBVSBK5opK+mrnaIhE=;
        b=iOSf29B/ivHKt/Q2nGy5B+vznbj++Gnq6XzOFvgR/aYp/TCPS1SsAtbLc/ENytzMUW
         B8L2Bvuq8wALiQfB0ZUfPeghcM6o+lrXI+E83QJgB0QOPR89rDgGmu4y2/tXIcLEeIz7
         JFJgYzDx4sCA+0jnLK+8zoaP8pcMAr/yGukF9i1w/4uluzlVvBQMrJR4gmpje/mFjv4W
         jMcHWd9seENUZ8WDDFq1zb7RIt+axRsUI1VZOcqFsXo33LnzHymb0M580PQLiyAhqrln
         fBLFTI3nZOm+3xLlXRFn/XN7MNCsjMAtZruIywUwUpGVCdt/MI1OhDjYyaH+hR8gf+NZ
         razg==
X-Gm-Message-State: AOJu0YwyAgiBFH3BJ7DKdCqPtn1NdjelDW5NiT8McAa7ro3F+t2KB62W
	V2VZArUNR11zlN1IxauB5fPhYpsmOLPuAcbmugTEja1rAhLs2qx3kSmKS0UbCSX+YiPOriKUP+6
	q5Mdck6TI3BagIWROM7Ae3RxxsiWZj7HCKvy23XPfpl6Uzivj+p3PbRCl/w==
X-Gm-Gg: AY/fxX63eJjZ7SFFqmOTz1sSM0Y2Mn74E+z2Yc9ZNw2Frl3TN5lgK+qqXuklQmTsfyb
	IWtQ0c0xXrwBr+gAgvba0ZEbNzBkKNtRyGUuDv2U12A0I8x5TcspsmxU/bcMurOJhbRxedUzBkF
	MU+NYX06BfkR+ojMl2Aya8TvIL+AM+MsP81qbGPUP/Pzy8FT6ZJsPIrqMXLCzhhEUZdRHOTsLqq
	VmGy1IPcRJvh0YWz6svDMvRbD6xehNyM7ZzGh2NAEwXJgpC8ausRv9ARMsKsRIDKfgOkGc7XtN6
	KJvu9R2jgKpHOtyqnfa0OqtMy1M863GWSeFdsAZ4Dkv7iy5Lh4h9LTJ/oH/OhK7F/ixmvRJN9og
	KqrPGJ4j1nfJCYA==
X-Received: by 2002:a5d:5f85:0:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4324e709a92mr31050433f8f.55.1766935247086;
        Sun, 28 Dec 2025 07:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzGqpYSD5SPgjtty0cT7dVYSX5Xz87ZnK537PCOjzNyd2NsHpM7223xNB/jGgJBHjaA2uWlQ==
X-Received: by 2002:a5d:5f85:0:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4324e709a92mr31050402f8f.55.1766935246640;
        Sun, 28 Dec 2025 07:20:46 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm56716343f8f.0.2025.12.28.07.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 07:20:46 -0800 (PST)
Message-ID: <f7840b22-38b5-4252-9663-4aefb993b211@redhat.com>
Date: Sun, 28 Dec 2025 16:20:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: I Viswanath <viswanathiyyappan@gmail.com>, kuba@kernel.org,
 horms@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev
References: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/25 6:42 PM, I Viswanath wrote:
> This is an implementation of the idea provided by Jakub here
> 
> https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/
> 
> ndo_set_rx_mode is problematic because it cannot sleep. 
> 
> To address this, this series proposes dividing the concept of setting
> rx_mode into 2 stages: snapshot and deferred I/O. To achieve this, we
> reinterpret set_rx_mode and add create a new ndo write_rx_mode as
> explained below:
> 
> The new set_rx_mode will be responsible for customizing the rx_mode
> snapshot which will be used by write_rx_mode to update the hardware
> 
> In brief, the new flow looks something like:
> 
> prepare_rx_mode():
>     ndo_set_rx_mode();
>     prepare_snapshot();
> 
> write_rx_mode():
>     use_ready_snapshot();
>     ndo_write_rx_mode();
> 
> write_rx_mode() is called from a work item and doesn't hold the 
> netif_addr_lock lock during ndo_write_rx_mode() making it sleepable
> in that section.
> 
> This model should work correctly if the following conditions hold:
> 
> 1. write_rx_mode should use the rx_mode set by the most recent
>     call to make_snapshot_ready before its execution.
> 
> 2. If a make_snapshot_ready call happens during execution of write_rx_mode,
>     write_rx_mode should be rescheduled.
> 
> 3. All calls to modify rx_mode should pass through the prepare_rx_mode +
> 	schedule write_rx_mode execution flow. netif_rx_mode_schedule_work 
>     has been implemented in core for this purpose.
> 
> 1 and 2 are implemented in core
> 
> Drivers need to ensure 3 using netif_rx_mode_schedule_work
> 
> To use this model, a driver needs to implement the
> ndo_write_rx_mode callback, change the set_rx_mode callback
> appropriately and replace all calls to modify rx mode with
> netif_rx_mode_schedule_work
> 
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


