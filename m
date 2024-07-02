Return-Path: <netdev+bounces-108464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CC4923EAF
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647AC283E7B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2A1B4C55;
	Tue,  2 Jul 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzsnYh1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549801B4C53
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926279; cv=none; b=PbI2g9p8WcVK3pFVpg3++/nh0k2hrG5sR8McooTHAxmA92+NWfD+cc6y/Yw2d6w73hjOON1hZilcBsx7trMd91wDQvuHJ07UZ3WGWHxDgnvbXspx1DNfUbnht7e+g8PFyjbOk3goT04veljuR8z3FUlV5Pb008JolqvQROrQhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926279; c=relaxed/simple;
	bh=XhKTyTpJ7vqszEh0PAf6r9U3Cd1q7BbdZwuiL6t8g5U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t+VgRPkopQIcqkzFw6cTL04X4LkGR3qyeIRILgdkAYSQdP2WiLGuv/QJT9kYz8P8U6B9bmRPAQithOk1gc2cccy07q00v52qFRCkaG4pdPtjSxSlrPHzNnpWEIEBmXUTWD0hWdcwbacqHzV8hIykua/mn2c45lddLJ7jiPyGGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzsnYh1Q; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4463be6230cso25665671cf.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719926277; x=1720531077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss3KPZ1OC7+8l0HInW3t9F4RXwiFwRWWxBcsbW8Ejrw=;
        b=gzsnYh1Q6P/J0EqBIdUorTJrgBdm3vbLAjM0R++g29oeYQKUK8Dfz7loF0NRu29we4
         BYBYXRU32KUned4imZmYoe9aLo5nIBfkkYPfWUeM/p5UcRjcSiefl79bBtNunfpIfxaD
         qjGOMJSzWKOFEWAU4qbLMAp+HbE9Gu5fON/JO9fzLMlPpHWRO7oOoQVEVo810c3ofD95
         B3ENNtsrPF8gE2NAXpdHXgu88A/tR3CCrtb7o/UNiZZmor+vbL6hDJR3hCoykRsnA3ZO
         60AFednv4O4tXhyALATx1ntch5SeJWBCGva1zPfZFdb5BVpQkHZkimQeeZaiZj5wMSGD
         6Mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719926277; x=1720531077;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ss3KPZ1OC7+8l0HInW3t9F4RXwiFwRWWxBcsbW8Ejrw=;
        b=hFtW+bKZbBNaTRu158ihC+6S9pVlssbbPL6zavQu5zJG6PS2IgxmAsR3QCTsW+cOR/
         C0l+iSYysfnmP1eItJdD7rMEm1C84lIUeuFFQx7Rb+5brClLqQB6ASvi+CtGmM/Kb2vS
         Q78jNZZxRf7ohAKZZHIyGtYEarSB/lDVWkCEy/ajDbMaotaIDOyjx/DELFlRLyPXTR9L
         wPX+VG68BTju5lqgeaMdWcTaRMmJbYvgE1RHOjjKpvQwNz3EBiS2RV9eJiMkXXle0E3D
         HDFkq9xwDmUE3FKBhaXTaHc5uhXoklBp20hRQw7UtqfALpENDoFXL94m/toTd5Sr3B4+
         RH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEtNsVWIepCp4j2g1VFGwkQoNmvF7dvG39uiZ/8BIjfayeHNKH3DBO60AWRdX3I2Wh81TiV5Txh84RkV580+4oVhxCvvDj
X-Gm-Message-State: AOJu0Ywn0zd4k6BNffghwdqNZ23/8enAZ47YUiuTHTh5qQ9SuKsRQrUD
	/SfXsY7OmTsSzpfZqHcLaL7OXdloLKkHivZW4zXkC0AqoOn3Qwvu
X-Google-Smtp-Source: AGHT+IF4ETcdDcbiQPoJHMlBI9XiGEs272JjIYwL8bBgVoZao8jdT+3RY0G/vVeVjlm/1EsE3Y5ZBA==
X-Received: by 2002:a05:622a:48f:b0:446:5b1a:da8c with SMTP id d75a77b69052e-44662e3c538mr112535421cf.30.1719926277148;
        Tue, 02 Jul 2024 06:17:57 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514cad7esm40671861cf.93.2024.07.02.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:17:56 -0700 (PDT)
Date: Tue, 02 Jul 2024 09:17:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <6683fe0480c3d_6506a29452@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240701225349.3395580-2-zijianzhang@bytedance.com>
References: <20240701225349.3395580-1-zijianzhang@bytedance.com>
 <20240701225349.3395580-2-zijianzhang@bytedance.com>
Subject: Re: [PATCH net 1/2] selftests: fix OOM in msg_zerocopy selftest
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
> process after around 30+ sendmsgs. However, as the introduction of commit
> dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is
> always writable and does not get any chance to run recv notifications.
> The selftest always exits with OUT_OF_MEMORY because the memory used by
> opt_skb exceeds the net.core.optmem_max. Meanwhile, it could be set to a
> different value to trigger OOM on older kernels too.
> 
> Thus, we introduce "cfg_notification_limit" to force sender to receive
> notifications after some number of sendmsgs.
> 
> Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

