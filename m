Return-Path: <netdev+bounces-118900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CD95373B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC6288709
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12A1AD3F5;
	Thu, 15 Aug 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/cc7sLl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FF1ABEBA
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735700; cv=none; b=d5m2NxMUg2IC4Ntnu5U9hyOI9jWOfyF2NOf/MKXvWfoCiilnJNl48f3h4xXRw8tCCwZHWY+T7E5vuO8bpy1veUagTqg++8a/yj1bW5N4VhZNfYdceIYwgLrC8SKkXgl1iXD5jTfcG/2kSvWWDDnxuNOqnYczTjVrrD/K2fIqvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735700; c=relaxed/simple;
	bh=w6Y8keq7MC/RcB+oPriVQpHgxKv2tM3osBO16JjXgjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnAd7FdI9EWajrBjmQAPKif1/D6Ar2FxJkyKQ6klgrRTijW/7pXyWcscZqPa86SvHOFYUhfoh9sQ51bqduZZkl1/lAdkNNzT+ilhRbCaiZskbFF67Z5AhEwflGTN4wVNvXY6GLKvYJsd1WfDtxFXOHnTSz1N5E+pIAxBWfuvKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/cc7sLl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723735697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnzeqT3NI2WawfrxS2a5Y4awkZprFbrha1qv4O7ZfPE=;
	b=N/cc7sLl9SD6y7E7VzzMoI2PpUiPA+EA97nlxElUpCGlnGXCLeqmvzDFxW17XFy/4xUbbk
	qmIJFb6akG6JmUsjaH5d+gnk46CKz8tZ/J2sAKwUMMgQVYldUK5xjin3DWOm8EmrzA+Q34
	ph8s9U3n16caB6XVEYRO5+/VxV62uBM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-PdE-4kBrMyWheQIq5exAcw-1; Thu, 15 Aug 2024 11:28:16 -0400
X-MC-Unique: PdE-4kBrMyWheQIq5exAcw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a2d4fb1e73so814192a12.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 08:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723735695; x=1724340495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnzeqT3NI2WawfrxS2a5Y4awkZprFbrha1qv4O7ZfPE=;
        b=TF0QNffGVj4YNELhEjzuECkMx0q/yHDAdbipFHJTS19pTutHZ/RNmPgD8nG+jsFeCS
         UHyoOAMfp2USHQPTURbxp5g1tCSUExBzzAyFeXD2A7NM6r/g68v0FWmuaFDz6tSfKwBp
         C8f9Aswh7uqXQ18t030LlaqvPA+p2lBNmoNrLeTva3/8fJ9cgdGvw6V7fiPhFT2mbhgJ
         3x7UrOg2IozhsIx7jRT5BXmNxLGRvu9ePUB2FqFr6U2MrMY+SsbPe/b6YvyWwm7susRY
         oE33lSdnepvE7PJn7mm76JZjC3tUpzjgzOeWB3vcpbGD6uPF+hE6gTHE/moGYbF0wOi3
         fQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCX1sZxOTid2egXwHf5VmdvrgWtdeH7iI1IrAjw5v8By0O4bHNiY+p4TdP4b9F+AQjSE5DJypLVmvFMIykBKhfXwzFDKrmAR
X-Gm-Message-State: AOJu0Yyx0bKEL82omvZC3Et7J1Qx07GS8m7yHeRzKR+xsp+GnkQaczbZ
	6DjTPYyp7LEpOvOiD+dBmKcm014bB7SIhU5FmQhAMQn9f0Ppg5z2QaPQEbtF/PMSST6imHrzKK4
	n/RsS5KeYMV1UcJcEH96bAMytDZPuMlg9XMEYnUUbDUgoVJOX8YDZqA==
X-Received: by 2002:a05:6402:510b:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-5bea1c7c716mr4272239a12.18.1723735695168;
        Thu, 15 Aug 2024 08:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/D7aBbTHDx3JnriGHYm8AR362yS4TnGCkKy4ZMsjbocDfbfeVNGG4wtZoRfQcR4P1Ow+x2w==
X-Received: by 2002:a05:6402:510b:b0:57d:12c3:eca6 with SMTP id 4fb4d7f45d1cf-5bea1c7c716mr4272220a12.18.1723735694455;
        Thu, 15 Aug 2024 08:28:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:8f0f:2cfe:cb96:98c4:3fd0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f17bsm1022082a12.59.2024.08.15.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:28:13 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:28:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Darren Kenny <darren.kenny@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH RFC 0/3] Revert "virtio_net: rx enable premapped mode by
 default"
Message-ID: <20240815112508-mutt-send-email-mst@kernel.org>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <a6ec1c84-428f-41b7-9a57-183f2aeca289@leemhuis.info>
 <20240815112228-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815112228-mutt-send-email-mst@kernel.org>

On Thu, Aug 15, 2024 at 11:23:19AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 15, 2024 at 09:14:27AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > [side note: the message I have been replying to at least when downloaded
> > from lore has two message-ids, one of them identical two a older
> > message, which is why this looks odd in the lore archives:
> > https://lore.kernel.org/all/20240511031404.30903-1-xuanzhuo@linux.alibaba.com/]
> 
> Sorry, could you clarify - which message has two message IDs?

Ouch. The one I sent had a bad message Id :(
Donnu how it happened, I guess I was mucking with it
manually and corrupted it. Really sorry.


