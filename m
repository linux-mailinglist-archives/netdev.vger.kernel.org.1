Return-Path: <netdev+bounces-98064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1180B8CEFEF
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B9B1C20E9F
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA6376F4;
	Sat, 25 May 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePvQPLFn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D731BE6F;
	Sat, 25 May 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716652297; cv=none; b=QcCh9YHwjscv9yc8TvqS8EgHrsgBe7x7OkwpZSrQPVCHsKGXST0nx30VHNQAzvrdrTAZzJapWrdvKGMInBHdevxopcvIJR5wJNsqMfFmFNcKSFOoqDXBnC8TimNnJbW+8o0TlK3avmQChZ1nUdXuOVYf93+6UN52kvSRV3n+rUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716652297; c=relaxed/simple;
	bh=jftO7f5NblNwnoz76DDIOK9hIE11fOzhi5My8DHfobs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=luy+dM3ubAwDLQMRlMp1fOjB0+tCuY3T/9Kl9PzZG4VdayfiHPUEVg5uv3I876Lw5KdpT4V8QICmaioIluJNSWERz88OrT6YfAjNyIZGP2ckB+frMMCJpIH5AYHtuIA4t2Dim2CFgvn6hFTZV/6LRR3Jpts83in7OHJ8PpvUTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePvQPLFn; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f855b2499cso1429703a34.1;
        Sat, 25 May 2024 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716652295; x=1717257095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jftO7f5NblNwnoz76DDIOK9hIE11fOzhi5My8DHfobs=;
        b=ePvQPLFnmnS9534kA94R7O5QGjRZyY+9j9QAjmRbMWacxgRShsdLExtTwJK1X8hm1S
         Bpecyy6UzG9pFLVEdimzDHP198pL5EJIl4UCfOpcK5/bjHoMz6EdK1tRbp6tFiyl5ouq
         cQzTWWMH8/75q4M3IWZeIxIBd36fnpIhvYWFWzv9QDGsee90K9uDuCEQncoIHnjw4fC4
         rfjouvgCx+uyzFfeSWQBoIOj2p8su/gP5jpg5/4I8U9S3BuFfIfAiEIee0zUYdzkYlBw
         roQhkB5hmwmNhutskjKxsLrphEyHtWQrxqRNYEd0qTVfe5TMlpxvPGK650MevBKTGSCO
         A+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716652295; x=1717257095;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jftO7f5NblNwnoz76DDIOK9hIE11fOzhi5My8DHfobs=;
        b=sFhujmKAFQn7pvMur3JL/iPW3hzqAWNkPiSwZzNAYlTu5myx/bIyusMUBstNtJAVnT
         p9GZ0TocAkcVcji25TKcPwolW26GLjJ/clBWSMnWTcz4cUUupJPehOPcJ1+XGR89LKfS
         ZwLjS8uxrry91XDBUwAhiz8rTlO8tcB7DNa4BU3gN81NTDONOb31FXpF0xy3D3C2fKn5
         KCrvZUuiDlhXaVGiZC9kYcva8o7PKS6aNmJbnXr+xpbmO7pD1axFELVCfxj0QVnlkqqA
         xwuEiTzUCuLyzmGaYb+KldYco75HHZoby9tNzuPsxINdZd+beR/HftULwxTIWvLNcDdd
         we5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLEPsuJWVUuFIDy/8M7k08hD9N6tS6PUtWytx1eY1PGtAq/fons6ehVVKaZgM+768hiEs9XzzjDr2yvXZkEWuAKNgRTInrDUAH0Sz8oFaDAw394g8KeepVz6dy1t3CLotXC6UB
X-Gm-Message-State: AOJu0YydoQm9UrwxxLFtYsT2YSmEd/NCseRMVAGl7BAcobVzeYhlxVU2
	q7RHlGetOwUbS5jQaBLFHpJbFLW7VUO7uiWItpdLT2V7UJY51nl+
X-Google-Smtp-Source: AGHT+IHrmbsOOcQ49qAJB30roJGLb+SK1iSkJK1I5lClQNllEJRqyiW6A/NgNM4QCAk508qYT0Ex/g==
X-Received: by 2002:a05:6870:c6a8:b0:24c:ce54:49c2 with SMTP id 586e51a60fabf-24cce544a74mr3787029fac.34.1716652295450;
        Sat, 25 May 2024 08:51:35 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac0710865fsm17874786d6.71.2024.05.25.08.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 08:51:34 -0700 (PDT)
Date: Sat, 25 May 2024 11:51:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Chengen Du <chengen.du@canonical.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 alexandre.ferrieux@orange.com
Message-ID: <66520906120ae_215a8029466@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAPza5qc+m6aK0hOn8m1OxnmNVibJQn-VFXBAnjrca+UrcmEW4g@mail.gmail.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664f5938d2bef_1b5d2429467@willemb.c.googlers.com.notmuch>
 <CAPza5qc+m6aK0hOn8m1OxnmNVibJQn-VFXBAnjrca+UrcmEW4g@mail.gmail.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> Firstly, I will submit a patch to add a new bit in the status to
> indicate the presence of VLAN information in the payload and modify
> the header's entry accordingly.
> A new member will be added to the sockaddr_ll struct to represent the
> VLAN-encapsulated protocol, thus avoiding direct modification of the
> sll_protocol.

See my earlier comments to your v1 patch. It's a minor respin. Please
don't add new members.

> Following this patch, I will work on enabling the link layer header
> via a socket option.

Let's focus on the VLAN for now.

Any expansion of the ABI requires a very clear path to use. I'd like
to see the pcap and tcpdump (or wireshark) changes that use it.

First, we need to even understand better why anything is using
SOCK_DGRAM when access to L2.5 headers is important, and whether the
process can convert to using SOCK_RAW instead.

