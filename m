Return-Path: <netdev+bounces-246392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACFCCEADC0
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FC3D300F31C
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 23:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF7242D9D;
	Tue, 30 Dec 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGTCHa55"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A122689C
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137067; cv=none; b=ZDC29al89unXNB3Xy80AZS2XsiDJw0M/c/aHznCHUUMTv0upgCHXtneAEGzG7daoo4aMr1XwOvqaUTHF5GtYgWRRCM4Vrqc+rJJY2dmFW33n4vZoRgHd0IEXhfvxQxoLcmgO/n4xLBcqdoZP1KlvNpD+noZ9wd8BEia3Vg/B16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137067; c=relaxed/simple;
	bh=SIikXicIPVE6mIsTe0Brr3XY/DnV6A9FoUg4Wm80Mqo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxjBiB5vMQgSxz+ljuifc8EzHC7fXDX1FIEZ7/kN0/MkkOurgCHdrPFQhcIpLo7esJAIWHs6WHDvQVN8wuG/v8CMpd24ulsMzb5c+QVAQznWriLSwEC/CI+xRyF8g7z46pmzeaYQkmsWVmWrpsByvF7RCXrB21yqPW6IkYOl1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--decot.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sGTCHa55; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--decot.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so260401635ad.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767137065; x=1767741865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=otefy10bqMQ6Rkz8jl3RITolqSd8NKK7YcepSO+lkXo=;
        b=sGTCHa553qNJJrOkLhOv+AU+VsKZFStK7vsngHW2NpLPUNUcMUTtUkAnnbf4x6iAyX
         e6Ww4U2kjsY/YMbWsqw+iiXoHy+Rf/l5u9kKqJ3LkbGFxow8dSfcNnVprVRRjeZ15nGE
         oOfjKVGu/1pfei5hWHHIBuzuZ/+e6696SLkHqHGLvgvpkT+XkmiHXn7fvmtQ09fIaWbv
         LZPgWl9Sgs99iAw3NXoDeMT3TnPHhHVf9HY1FrStJn5LPPbBqSBntx7RXpEMpSUYiAom
         uEU/NEn1vo+KAXFkmCxW6GbLt5G/e102wAWmWWhQpSJWX+WCGRVSJBc0kkHv1vS6UMWa
         zFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137065; x=1767741865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otefy10bqMQ6Rkz8jl3RITolqSd8NKK7YcepSO+lkXo=;
        b=IY3SyaVPzZlRron432E94rEFhBHEwjlTXJsm35v6Dn1nvFTLYbdFT3H6VR760XpHQY
         Mq7NCgWDQdaHYcbWvifCss0pavoiJDuWBn83ak3M6DAMFzEfISYTtDVHwoFNI/iBkHuX
         OVIl+sunOh3WaQs8jBSeuimDSI9tP/r6MJnPZ8E2pqqq9VJXGaawDujkDDmyy5hCyiZP
         Z1Dctxw/vbVtDdYapoWWYBQlZ/EtKUatUUxhlcYQoHfdT4p4fPC6hUHtBoyU+a8qajBH
         BRi1HjMa3FurGwRnv/SPsxXjWIcd7C17qPowccolvTFNysMPYVxRU/EbbOFEjXk1W5K1
         UPdA==
X-Gm-Message-State: AOJu0YxX8vYE0VGj1NHD8O8DQ147paxsHJjUWjE5XrGCupxrn03p/qr0
	cZChL+0Y+pLKkpKVTnfghjrbrSRRZdj2gbY61cdpg4nSbslD5j0xAwJrKJbRl7zsuHaeMC3WzoJ
	rlg==
X-Google-Smtp-Source: AGHT+IHqR/6lsYHNU7FNcWu3yhSTAtOgs3q5BmJ4yTy19weMjJ3YUksVel4kP5W/QptL5Y2q7QbRD4Sv8Q==
X-Received: from plzu9.prod.google.com ([2002:a17:902:82c9:b0:2a0:8cbb:6431])
 (user=decot job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6e:b0:2a0:c1e4:e25
 with SMTP id d9443c01a7336-2a2f293bdc3mr328462765ad.54.1767137065078; Tue, 30
 Dec 2025 15:24:25 -0800 (PST)
Date: Tue, 30 Dec 2025 15:23:46 -0800
In-Reply-To: <20251103212036.2788093-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251103212036.2788093-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251230232400.3515704-1-decot+git@google.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: cap maximum Rx buffer size
From: David Decotigny <decot+git@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Joshua Hay <joshua.a.hay@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	David Decotigny <ddecotig@google.com>
Content-Type: text/plain; charset="UTF-8"

On 11/3/2025 1:20 PM, Joshua Hay wrote:
> The HW only supports a maximum Rx buffer size of 16K-128. On systems
> using large pages, the libeth logic can configure the buffer size to be
> larger than this. The upper bound is PAGE_SIZE while the lower bound is
> MTU rounded up to the nearest power of 2. For example, ARM systems with
> a 64K page size and an mtu of 9000 will set the Rx buffer size to 16K,
> which will cause the config Rx queues message to fail.
> 
> Initialize the bufq/fill queue buf_len field to the maximum supported
> size. This will trigger the libeth logic to cap the maximum Rx buffer
> size by reducing the upper bound.
> 
> Fixes: 74d1412ac8f37 ("idpf: use libeth Rx buffer management for payload buffer")
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> ---

Reviewed-by: David Decotigny <ddecotig@google.com>

