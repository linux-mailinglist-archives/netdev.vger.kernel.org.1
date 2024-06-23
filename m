Return-Path: <netdev+bounces-105917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4369138FD
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 10:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5DC1C209F5
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 08:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96821DDDB;
	Sun, 23 Jun 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5EueZIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216915E83
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719130718; cv=none; b=UsbdDQtNts5vwaACQYKcAWVpgetGLdmaSk4C1DxdQyijzf5gJCS7VxMahV3VCgd8Nnwevi2z+/QS/ezsMFdDoewHcu2VUHC6l3G/yk6uTTAsnivLqOI0WjV/boYh/miTAyhye4XTZ0MFtV3L6akhaFzCgucId6h3B3BP+EZIqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719130718; c=relaxed/simple;
	bh=L7/GcWS21G16kMIr4Rzh73cWYISjZBxjNnHHyKG51rA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XrY2exHsZFSH8FjMSpKWFMsJ0VymqFnqcfyutSAJM3OVlA/yjGZh3zd8zaPHwMWslTU2Qi3ttAUTKDQORGHDODQeW/3rkf1i9Dn6Mufj3zfcfMymy8r8CN8EoihLm8XTOgo5lx/Jqv6qVVuB7zjR5nVoVmXCNYyrx5eFLD8AJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5EueZIU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so15584056d6.1
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719130716; x=1719735516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfS9kQF98h4Kpv62+gbOTX+SlATEv6FSmMirHiclb+g=;
        b=m5EueZIUPELEW3+YlMMkEhaBx83a3Jub/5wTTWp63g+mbyrEjW+T7WsoboQiyu3BpJ
         914rGRo18zoliH8Os9ZsEigH7tdlOIJ1wWjzLHouhPtpjK9wPvdT4HhWMu4ha0hGCX8w
         uOoko9q69+aoncnWpUxiFUsM/yQ18VRaZmtLmj1ZWC+njIBvN9kdF6NgShcv+xhP+UWr
         NYyei2YsxrAa/NPOgHfJCw4LV5aemG2D9m1yJepCPH+d3dP5wuHbnqKG7Qoj1UcGSosA
         BUiw01cje3C/B46wdO8Glmvsz0AOeYTqKPSJLMsUoRXsB52yHD+M5BVQ30ID4NuYIs1J
         rjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719130716; x=1719735516;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QfS9kQF98h4Kpv62+gbOTX+SlATEv6FSmMirHiclb+g=;
        b=mwKipyiHEJjKBB3bCKaJB6zTYMzS2VU3k0U6yRqbq3H8zIerWMNc72PDZlmmlssldK
         QM2a8+EODR7fsh9BoWlwQNHzW79K9CXZcvnsNhpEq0+AaTyPCTQTiLuVoKnqDTkjTfhk
         0OLdT+xFmq5597ReznvFcHRAgz3GCH0hrHghItTPf0r+/oKdGdvgiHsokT+4yUPWyYQY
         w39lxc/3BHwoa3wCyMZU7a0RNOdMTf3JfpWTnfY4k3Jz7RxgGYe/bGePCHSES4Oruuv0
         2T98VyigpTnKmBCUx76FtXCEcQu0vj4B1XvaIP42C9b+4YUx+c60Y6zYk3qOFInF0wgu
         O+pw==
X-Forwarded-Encrypted: i=1; AJvYcCVP1seXw65Okjdh/2MgF5xc+xWjdcPEO2WM2hMGOY1zXl6ehz+nn4ptT+y2OAH6VHDrznJdP+aCoAuZgLWYlI5ftnauHCzq
X-Gm-Message-State: AOJu0YyGtRisYqmEWSzqLpOB41P/K8OFqLryBaRIqwslhKemuwDQBIE0
	Wxe8WEGCtJZ9gNmD/zaYVWHDjjW6ZXgpFTcBpIB1Cmr1Kmvd9cDj
X-Google-Smtp-Source: AGHT+IGqgXi1aNJ1PKoaCXA6SED3DDm396EdJfGp1ppfQA0T+x4/RHNXfRJTTiMqHv2n9QnFMwsiGg==
X-Received: by 2002:a05:6214:3005:b0:6b4:fdcd:1604 with SMTP id 6a1803df08f44-6b53bff0eadmr26188626d6.62.1719130715952;
        Sun, 23 Jun 2024 01:18:35 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5295df066sm16183396d6.64.2024.06.23.01.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 01:18:35 -0700 (PDT)
Date: Sun, 23 Jun 2024 04:18:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 kernel-team@cloudflare.com
Message-ID: <6677da5b3c52e_334d34294dd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
References: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
Subject: Re: [PATCH net 0/2] Lift UDP_SEGMENT restriction for egress via
 device w/o csum offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> This is a follow-up to an earlier question [1] if we can make UDP GSO work with
> any egress device, even those with no checksum offload capability. That's the
> default setup for TUN/TAP.
> 
> I leave it to the maintainers to decide if it qualifies as a fix. We plan to
> backport it to our v6.6 either way, hence the submission to -net.
> 
> [1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/

Agreed with the change to allow UDP_SEGMENT to work regardless of
device capabilities.

In my opinion this is a new feature with sufficient risk of unintended
side effects to be net-next material.

Maybe worth recording in patch 1 the reason for the original check:
that UDP_SEGMENT with software checksumming in the GSO stack may be
a regression vs copy_and_checksum in the send syscall.

> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Jakub Sitnicki (2):
>       udp: Allow GSO transmit from devices with no checksum offload
>       selftests/net: Add test coverage for UDP GSO software fallback
> 
>  net/ipv4/udp.c                        |  3 +--
>  net/ipv4/udp_offload.c                |  8 +++++++
>  net/ipv6/udp.c                        |  3 +--
>  tools/testing/selftests/net/udpgso.c  | 15 +++++++++---
>  tools/testing/selftests/net/udpgso.sh | 43 +++++++++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+), 7 deletions(-)
> 



