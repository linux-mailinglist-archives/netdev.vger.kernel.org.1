Return-Path: <netdev+bounces-119883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56D957505
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB914B23B9F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D35A196C9C;
	Mon, 19 Aug 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJW9YJ3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671728F3;
	Mon, 19 Aug 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097218; cv=none; b=unCQJoiJZ+amO90+AFM67G+IEo+u4kqGdYKjC3TAPnH4qcU6ML8qfUTaYuDGHOSXYYg7OcMqSrsHtuXaz1rdf7h7q14K4Kmmve5rbAvpnGnKIcfUlsCsC6HqzQcDwbi9GUsoC+seSoWCy/KQnTKMPHGfeC8r6z+ZyydhU/Rm6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097218; c=relaxed/simple;
	bh=jl5DpbQGRk/IPdWkCXB5oQDeDocBJf76OGsNDxelbg8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i32NDL17vkdM4eruDss7PsyznIRMeL/ExP22AyEWCflDNLT2QA2iPib2bAAqLgXsYGJsFi6m+SjaDcO87yDwQJqmL5LvU0JEVN4aL5zNH7lwixWRjUxQnYObI/6bsClvRX9WXSJ+lZgDY9ArwaerfnLjBQrk43WB2uXPZIZMMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJW9YJ3r; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7ad1ec3aso24160246d6.0;
        Mon, 19 Aug 2024 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724097216; x=1724702016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4/rme6Y689f8B+BXTJquVeqNo6oJaW6GhfFKTCdo7w=;
        b=NJW9YJ3rwzMEbAQgJliZSjBU9KtyYXChuwM4SYnuUaUg3VhAnYtIaQkQGcv+0PB4ju
         imLtYx840ZE8xNxHOEfmzPSDiV3daYrkImy5mpFW1kHPi+VoC8wHuAAysIhyFKp5seCr
         QKVB3It3DF3smu8fjzKZnkGigjIeSv+vqHwCZ/ihob2+dCmUPonZYGe6qeu+HZ1UHOCC
         6lBMpHNjpRwei4IMQcjS81JY3I8Qtaew8YP1XkcMzoP1BdUvCzXCKAOY0m8AlzGn1Su3
         s0IjRM3k5UWEL4ocUJdbiwnaDXH/+kHWlNlyWAllcIJiY4cc9LC6xr6/LwOu00TISU59
         oWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097216; x=1724702016;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t4/rme6Y689f8B+BXTJquVeqNo6oJaW6GhfFKTCdo7w=;
        b=itE9EaF1CoqToanFG8KaGLjY+YPUJOcLMvvzIVgr1Fm4LhAx+AXAW+ME2Mx1ps6QqO
         BAwIaDJL0XPbRDOH1AZ5jYv/NqKvxgXYMbL2SwGnOcvoGtNA3D1VZsYGUDQAdNMlZuio
         MrkPoe/qDVh0HpPPVFmfoGcgmsrBQoMHxnAv4CG96ztU5F5c6r4cEew75c+FGF/sZZZM
         bRXnZNRzkJrD1hxcdIXbTBIcZpxSfjtXRL+GEMqIC6Yt/kOyxsRcTGEy1gctEdlaS64B
         UoHFh7ZhTirQBfnqkszBv4yc1pz6/055jYCHH2AI1xfCxBgvwn7+qS0BGM4t7D1R4yRc
         v2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXmz8cj/StOyL7MYCbN5IQo/g7WktTiJY/suJ/8rEhu1HujuYUH97YBDPaa4yK/SagOBererE4WuNiTgO2w6ZfrOpuQ7dCN
X-Gm-Message-State: AOJu0YxgjeZ8TixVg1pCZigK8I+W722Usvsh+0sv+Iic0sySnMrQS1+M
	Eak7txoyg1O//D2gII+8Zn+xJ63HTybTTp+AcUsM7Hm0JsFjtwJx
X-Google-Smtp-Source: AGHT+IGrCErCS7voHEMpDcxdGlY8K9w0YRGuQlDb3FWnmg8IUeCpV+e7n/Vngc03mUYasQ7B9wS55w==
X-Received: by 2002:a05:6214:15c3:b0:6bf:828c:4fc4 with SMTP id 6a1803df08f44-6bf828c5339mr88038556d6.49.1724097215496;
        Mon, 19 Aug 2024 12:53:35 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe10ddbsm45745856d6.49.2024.08.19.12.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 12:53:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:53:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <66c3a2be81834_740b1294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240819150621.59833-1-nbd@nbd.name>
References: <20240819150621.59833-1-nbd@nbd.name>
Subject: Re: [PATCH net] udp: fix receiving fraglist GSO packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> When assembling fraglist GSO packets, udp4_gro_complete does not set
> skb->csum_start, which makes the extra validation in __udp_gso_segment fail.
> 
> Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Oh right, UDP GRO fraglist skbs are converted to CHECKSUM_UNNECSSARY
with __skb_incr_checksum_unnecessary.

Rather than to CHECKSUM_PARTIAL, as udp_gro_complete_segment does for
non fraglist GRO packets.

virtio_net_hdr_to_skb cannot generate fraglist packets, so this bad
input check is unnecessary for SKB_GSO_FRAGLIST too.

Thanks for the fix, Felix.

