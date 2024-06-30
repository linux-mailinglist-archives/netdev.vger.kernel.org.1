Return-Path: <netdev+bounces-107947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD6991D21C
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 16:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AC11F2138D
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418113F43C;
	Sun, 30 Jun 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFhZqOoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7361E13213A
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719758278; cv=none; b=W4Kk7/sArx5Bznc2fDyekdzHNoO3gfQK6Il7BUYfLMPv+m/tCBP4pPsarH32XO0DkuRqx93XHd/iCS8XLvU1YAVe0Dssea+cPINfUlTLVmEt89OEIxUciQ0Pt7omtxcjr4AqzVTUSMyBD7z826pk0vruOB8hGFjHWnUau5Chrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719758278; c=relaxed/simple;
	bh=xzzWgVVyC+IdPM6b70rkwDgNNseKTa/9oKoJgVJI2vc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=krXuAHa+5ABnJjUD1cpx3JXnCdhak1fiibotshldNRbyhrCGFHPFaLEtqXdoCkSYwHXadzg04oxpQkkMpFrn8/u2+ZAQCVnmQ5cTg+WJOyFkJNxHyMbzyNZ516xznsuevCWoEQZe894WjDX6C2+XVTemGdSK1Ez64tQB4edrMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFhZqOoj; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4464c3c8f10so10559801cf.3
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719758276; x=1720363076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsjCNgCRZvcsQXW4vjgs8LIkDl2U7UoAJSswPhTXSoU=;
        b=DFhZqOoj0THD2CmjsK2KWHYkWXb6iiK8C2ZsXM/PIViB5KqYRHcg6ItMiJRB+s+lHy
         1+p4zhg9jeEHimvpP94zH4fQZ3KcBeEyiiUKfQB1KLWlXuv4faDQhT21l7xTMfKaKGUt
         uAcqzOwC/2t8vQHiZsKBwwo3xLAZ2dRnOybWkp09k4shDBJL0Aytd5tN108IA/2OMs4j
         hclh8RGCzFvyEOPOa2f75GpsBWi6va/0e7dlGp2OIuQOp4egH1IlHWDyBm27RztYISv3
         fNyfZ9ATD+e2d7s+JBLY6TGZ1eWuVfYQ1SE3UBazx4XaV657TfTyY7kIgrXNf4B1e9mb
         sJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719758276; x=1720363076;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsjCNgCRZvcsQXW4vjgs8LIkDl2U7UoAJSswPhTXSoU=;
        b=vWFMu2Lly7w82IGTvdRfR/UozTyvJVGfp+O4RwpeHbOj60If17CUXKFDTLq+0HEHOC
         93fN8S39NMJW3Rh6N6848+TFxWRkJ898VHj0ndg73sdRsdYxtEhzpUmN87GkhhyZFyjq
         Yvp0LE9m+y/ctauhGhHYPjpKK70Viw3W3HzHGFHdVAcjXMGJuYApVfermNoKsakkw9Hf
         JV2eab0hw/qHbZEnP/8xrJH5LY3IRdDhYctjOyve9ASUPLL1wPKn83lcdUJXqGqtr/Nb
         AVNVwYrGrtM0eou/uxbOG9soUAnn/UaFlW5j3EhMh3HndxX5B5CgOMvjC88lCGxj860l
         Y6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUawbQGJmpMIcJgeh9iiAqp60lUK0L2zuqTKQ7BeVkhSsv6RygH2yxuTBe5h/k8bmp+MShUTIjBpJJ8Bw/8qhN/ej9vxK4Z
X-Gm-Message-State: AOJu0YzhjYxH8YmqtDtM0j2jrWliMXBmRKO4oeo6OmhB8nojm59FMKBo
	2xTWi+Njjwd0n4jFe9kSESYlCM/L5RDCDI/BpS6xUmCPfPCWMiSi
X-Google-Smtp-Source: AGHT+IEYhaJxuNEgauhwLQ/3HwVZk9lVzRJUGLHcpPLdXR8oUsUL9L/z/P3EpHBhQnYS3XdjoptpkA==
X-Received: by 2002:a05:622a:8f:b0:445:3de:a843 with SMTP id d75a77b69052e-44662de80b9mr45521561cf.39.1719758276228;
        Sun, 30 Jun 2024 07:37:56 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446733fc155sm1026071cf.67.2024.06.30.07.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 07:37:55 -0700 (PDT)
Date: Sun, 30 Jun 2024 10:37:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <66816dc388821_e2572949a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240626193403.3854451-2-zijianzhang@bytedance.com>
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
 <20240626193403.3854451-2-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v6 1/4] selftests: fix OOM problem in
 msg_zerocopy selftest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
> until the socket is not writable. Typically, it will start the receiving
> process after around 30+ sendmsgs. However, because of the
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> the sender is always writable and does not get any chance to run recv
> notifications. The selftest always exits with OUT_OF_MEMORY because the
> memory used by opt_skb exceeds the core.sysctl_optmem_max.
> 
> According to our experiments, this problem can be mitigated by open the
> DEBUG_LOCKDEP configuration for the kernel. But it will makes the
> notifications disordered even in good commits before
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").

Since this is not a real fix, no need to suggest it.
 
> We introduce "cfg_notification_limit" to force sender to receive
> notifications after some number of sendmsgs. And, notifications may not
> come in order, because of the reason we present above. We have order
> checking code managed by cfg_verbose.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

Probably just send this as a separate patch to net-next.

