Return-Path: <netdev+bounces-249951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080FD21890
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2900300C02F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E6A3B5302;
	Wed, 14 Jan 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aw2eqnlp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6fEyAqd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4A2ED860
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768429180; cv=none; b=lZt67yRLrJ6RCuMjmfdr1bOtLzZGZJkNzgujOMuhV0VGKxLM3OQNtQDI13gwOfa+y4a5v0bL2YhulmgZG61ISy4PmuIKgMGTXIcaF5z/jGQOu0vE4uPGPidiPog3IP4iuxClqiVg0pR6r0U9S+S/whgNZq8Os7K1Ep1A6JR3xcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768429180; c=relaxed/simple;
	bh=Zd3hjooXcRLvny48hHqRzr6SITpUI+66uIBAPLtuRVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJR7RZ5wwY/BoCGmnukAELnPnl/WSXamG1u8h0O8oiSB5JI8VBHtrEzv/7qqSBTVJSi7Sk/YAd5meFuaP1f9E86unV9lwW8MuL9InszUqIji04zrPW810eY01+8T78y0+MCCwyphxmEbUEfBw6KWeaA+BgigM7gsbIxqc9Uff4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aw2eqnlp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6fEyAqd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768429167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftR49wJT1ig0dKZDi8tPuyXzRv13vJOC8jN0Oc8SYJ0=;
	b=Aw2eqnlpb2tUDBiGSvqOL69f6vSr86/nnqrYfZK/3hUDUeJ/EKpjH/gFt7PQL6EY6wZoCT
	CNmnmmPY0teoXcd465LNalM4nTTfMliC6xNVnAe1XighgyDs7O0prfZAG4JcGhVOcdyZuD
	H4zkwLXBWi5K6ljwDmLdnpx7ST8U4S0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-1DFbnr50P-yEVmnfGVePPw-1; Wed, 14 Jan 2026 17:19:25 -0500
X-MC-Unique: 1DFbnr50P-yEVmnfGVePPw-1
X-Mimecast-MFC-AGG-ID: 1DFbnr50P-yEVmnfGVePPw_1768429164
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325b182e3cso132325f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 14:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768429164; x=1769033964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ftR49wJT1ig0dKZDi8tPuyXzRv13vJOC8jN0Oc8SYJ0=;
        b=B6fEyAqdfIlD9e1DArygZ2NEEEmZtDLDgqKIAjfn/dy3kdvGyUEItLCkwjggoQzXCl
         /yW6u/S6Ko4u3ql1Zwst3DyoFuKK/+BP10DjTiQOb/OMDNV8Vo3Z1KEpHBq3WpcrJgcv
         m2UixGcX9YnNCHQBSSt/BGWRfyGqsnX/WnY1oC7oeyUdbI79rMzyuCpUlB0WnyRIVF+j
         sFnayxMcXdn9RGWE+XYdyU6GnuhfTUgL57LlkGPpZhUgZsan2tf4+fJ4ZUYPdRspZeCJ
         frZ3UaOmEOQNZRP74x6SJSyAiLI3RCSQ87xalE3qTgbO/RU+w4miVOitAqIxsUpU8ODR
         /nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768429164; x=1769033964;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftR49wJT1ig0dKZDi8tPuyXzRv13vJOC8jN0Oc8SYJ0=;
        b=Lflec2W80cGM30MgaKoxLBsasdz3/EfqHO6Qst11A9Q1L6xNakDgu99cmn65KI3via
         DPnULsWPmrhrhM+jKOoHuTwbOrhQr2R1pFDxTkisZC8Qiohvt6Kzy0KOR+xjcHblRvhM
         +CDBkcuyTPA3TWUIoD9QZGe14+ze7WOhbs+O2GeH7Tmh5ukZuRSDA3rlaWRPc9MRlfgo
         DOtRgv5sqCWbPciDE+9GgdzIXixl9wBvqy5xQmJ7rt2qeGTzSK5t5DL6VEnX9/HkEW87
         +RVIeLr99l/+q73dzlXnICicA2ljHk8Mxn1fbp7Mv3EHF3aaoBxv32j823qZ6yHvu+Aw
         qVqg==
X-Forwarded-Encrypted: i=1; AJvYcCU+g6vO9PtY3iBeOjCbxAEPN52gRNMV/bOIu530gaMbSwwZhyrpfAQfuUDV+lECKA7XSO59Vqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lU4yY0nKQxgKHlNc3EsTERBubOwhdW1XT0Ts7O3B0FyrQaH+
	463uqFH1EbZQi3VLU2Znbp1OCDrUgG4V5YQZmUZh5jHqTcdaZC5qiDUn6+5IGS6CHOS5R+zR5lX
	gBnW0RqM9g75PQjj3q8jl1EEDiHcw7DEMBQx3ddFsW7zWATmIBQWeeg+NKg==
X-Gm-Gg: AY/fxX5GFRIQci9x0MZhxgysIlaiD76v8RtmQt77nOKgV1BYYt9NgTL08/hR1n8ivR6
	orremRhfROclgTskj3I9jqBLAx8CmeLwzbK1P6qhnOflD7vWT4B1OVMME3O+TyHL6aoX0rTFyHX
	eECc/tqAwrj1ugS+abRmLUwe/evVyRfYlCzTSXpxnizgecR07mfFOSy01pKNpO5t4pflWBLFdzV
	tmbUHT9UGP0rC6BodBgJiHT3Ipxg3kVRHpJplAI1HTULQBp4wRApHhcrwXhO5cr74ky7OARB0kR
	X182Nx7I7dyb7mY5gAs70uF/OL3zITkKtEv9+fKHm2hyTis5lV8Bxp4jdjP3Akz7oD2oZTnIos9
	6zlYqcU8Rf+UH5iv7Bfrq
X-Received: by 2002:a5d:64e5:0:b0:433:1d30:45f with SMTP id ffacd0b85a97d-4342c3ed5c3mr4692487f8f.1.1768429164304;
        Wed, 14 Jan 2026 14:19:24 -0800 (PST)
X-Received: by 2002:a5d:64e5:0:b0:433:1d30:45f with SMTP id ffacd0b85a97d-4342c3ed5c3mr4692469f8f.1.1768429163890;
        Wed, 14 Jan 2026 14:19:23 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6535ddsm1648131f8f.15.2026.01.14.14.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:19:23 -0800 (PST)
Date: Wed, 14 Jan 2026 23:19:22 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Oliver Neukum
 <oneukum@suse.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usbnet: limit max_mtu based on device's hard_mtu
Message-ID: <20260114231922.6b41e9ed@elisabeth>
In-Reply-To: <20260114090317.3214026-1-lvivier@redhat.com>
References: <20260114090317.3214026-1-lvivier@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 10:03:17 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> The usbnet driver initializes net->max_mtu to ETH_MAX_MTU before calling
> the device's bind() callback. When the bind() callback sets
> dev->hard_mtu based the device's actual capability (from CDC Ethernet's
> wMaxSegmentSize descriptor), max_mtu is never updated to reflect this
> hardware limitation).
> 
> This allows userspace (DHCP or IPv6 RA) to configure MTU larger than the
> device can handle, leading to silent packet drops when the backend sends
> packet exceeding the device's buffer size.
> 
> Fix this by limiting net->max_mtu to the device's hard_mtu after the
> bind callback returns.
> 
> See https://gitlab.com/qemu-project/qemu/-/issues/3268 and
>     https://bugs.passt.top/attachment.cgi?bugid=189
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks for fixing this!

Link: https://bugs.passt.top/show_bug.cgi?id=189
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


