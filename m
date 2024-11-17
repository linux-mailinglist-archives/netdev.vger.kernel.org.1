Return-Path: <netdev+bounces-145650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD649D0469
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 16:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2A4281D72
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9741D90B4;
	Sun, 17 Nov 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb9rrZSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB561D88D5;
	Sun, 17 Nov 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731855870; cv=none; b=dKSmRXK1v0RV/QKzS7KeaHciTSoMBpX9qi1VlS+dQHoarVCrna7OYE6U7KNT5OKsnGA9IkWlXIZ81dF2NqHdsjjxTW8BLxQIoUaNunn/fLP4XQwIiEir0bfXO3aPQ4Efg61/xE8tGEcP5gU8WJvzcZnG2eTOqh55Z2rtSlkToe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731855870; c=relaxed/simple;
	bh=5tkeO5rU1xRGXTehyLb6AVPpffFFdbs0aUoVRgmj//A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CyU2IzEMwaRHPS4aionn+Svof+8pQQ1yRIwxe+I4ipQWNUmhNG4YdkEpXRVclpi/CLhwufHvj+c4PXMEepIGMfPQSpcIbVc5pmq4w9+xVPR7k0X4YE9FJ4uVUDIFczBUmu2lmtcR//ayDnUVtNXIB9jbhZ2XmpGdd2/JB8OHJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb9rrZSt; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460c0f9c13eso28307671cf.0;
        Sun, 17 Nov 2024 07:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731855865; x=1732460665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMUZ/lFrZhuWNRTmGZWkHzS3NTckv99Tt3mvMgBJPn0=;
        b=Lb9rrZSt6Q4aeFU+/V5CCmSnAejYZAYK/mupnCR9dlIccNVVgytiirqV5YlnHR8gCs
         a67cne0F9gTTTsjphR/mtay/n0bSvxxd3XxakrcGDBlcu92hOZIOkemMUXgUG5LBaW0s
         58treBklh+Ix9mnuns9tfwjFlm7nJ7FmXqVHoH+w7l91iRt9mROgQhzP+0FOb/3Tqs5T
         G4j/UMwJzZ8E/llVnD35lk9zXosWLVso+yRYad6Z2UuPdL7Pk7UN2SpX7N1aJ4W+9oWL
         FNLcY+YFMsmSHoWvHgNR6eh0ceci2zKCrgV7q7v1uYO6nxKoIuruzDdznzaC2kte8L78
         Vm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731855865; x=1732460665;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nMUZ/lFrZhuWNRTmGZWkHzS3NTckv99Tt3mvMgBJPn0=;
        b=IjX6Z886Tc2V4Sh7jP2Cezx8kKMYJ3tKTU/UKyQkx59x9yACQ1yNLckQOIcDWEOmA+
         6lji5jaDS6avj3tRe+ERoAmaOzZ5yL+rJ5RoSPp7yG3eDAj/cfu9I+llatQYI5SpjtYQ
         Gtd4jipio0dnVq6cbt4LUoRzIeclMApOL3krbIyFzZVcJ1KMUVQebgZqhuHqk1j9m+fc
         ijvFxEq6QY9YYz6rKS7oOKmBZK8UamgODMOFAOxft9HH0/DoKQzHnbKh8VfhpegA/7D6
         2bCCqEJm9kgo9uVwlYeGz/k3UHb4VeNB4iDqkZpn+xPptH3Q1C9VcGFG391jSjEL6aEh
         mMVg==
X-Forwarded-Encrypted: i=1; AJvYcCVHoL/TdSEKmplVRSeaj1uvolmQbuNBReTThSHDA8ZA2IU6kLmLam6OLVWKWc6URmmYaYKWsQIR@vger.kernel.org, AJvYcCVJhRyFxrJ327rrGqG8hvwaYiHfp7dA4eoWZAFdnePMQ5mVEZfxirwU1kHuxAZcVKEpJKCW6V0qJUOwcNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SzkTAiYLAmMvkAxNGqpfWZOTMFtFF/Rfzge5lTM3tIdtg2m8
	FKuB+w8Zhpvf0D1NaPaXd+xWnUS3AQ6/CgvNL+aOReu3XgeYwvt3
X-Google-Smtp-Source: AGHT+IFNUHsHK3UYkTxlpYXDnkKbEDYcCloDBC7fHSPIV6EjYUzsCWmbRR1tiASKVkzZmHnj37Z3pA==
X-Received: by 2002:a05:622a:b:b0:461:7558:892f with SMTP id d75a77b69052e-46356b34f42mr234903361cf.15.1731855865300;
        Sun, 17 Nov 2024 07:04:25 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab25bc8sm44615531cf.69.2024.11.17.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 07:04:24 -0800 (PST)
Date: Sun, 17 Nov 2024 10:04:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stas Sergeev <stsp2@yandex.ru>, 
 linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 agx@sigxcpu.org, 
 jdike@linux.intel.com
Message-ID: <673a05f83211d_11eccf2940@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241117090514.9386-1-stsp2@yandex.ru>
References: <20241117090514.9386-1-stsp2@yandex.ru>
Subject: Re: [PATCH net-next] tun: fix group permission check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stas Sergeev wrote:
> Currently tun checks the group permission even if the user have matched.
> Besides going against the usual permission semantic, this has a
> very interesting implication: if the tun group is not among the
> supplementary groups of the tun user, then effectively no one can
> access the tun device. CAP_SYS_ADMIN still can, but its the same as
> not setting the tun ownership.
> 
> This patch relaxes the group checking so that either the user match
> or the group match is enough. This avoids the situation when no one
> can access the device even though the ownership is properly set.
> 
> Also I simplified the logic by removing the redundant inversions:
> tun_not_capable() --> !tun_capable()
> 
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

This behavior goes back through many patches to commit 8c644623fe7e:

    [NET]: Allow group ownership of TUN/TAP devices.

    Introduce a new syscall TUNSETGROUP for group ownership setting of tap
    devices. The user now is allowed to send packages if either his euid or
    his egid matches the one specified via tunctl (via -u or -g
    respecitvely). If both, gid and uid, are set via tunctl, both have to
    match.

The choice evidently was on purpose. Even if indeed non-standard.

