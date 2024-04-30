Return-Path: <netdev+bounces-92501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB6A8B792E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99B21C22B87
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FB1BED66;
	Tue, 30 Apr 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRzstxTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D161BED6B
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486254; cv=none; b=svLbTXYgVOcwubXuMpumUvgBzb0T/CUnCr5hBj4U42y6QhXbK7ro3UvlNlVOLzXYHIi0A+gue3uN/1nTSHV57RgFSs9uiLwhHtTo93niJC5qn+TH5HpW3ypYN/1tcGs+t5LWsjJHk/0pp9ktnBuyXC/U/NIHTE0ZWFQsy0ULoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486254; c=relaxed/simple;
	bh=wXeEDI3PBBpnP38xgjZueBZM8hRXH32paMvVIPlN0zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFNsc6ksUG6JfX2SQ5/vyFWT3o4KR38U7hy3G8LXiW1XODVDevaPXiyZng5rPFuh41bQe1sK18MmeRYKaI9S5KIRRfauy1yL+peocHWASxNkB/StB28LooJJc5aelECnfMBrycZvCiTmKxMp5YHo0dryB7tUmmBxv5qH5nsAOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRzstxTJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5727ce5b804so16249a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714486250; x=1715091050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flcLrs0CTLkRp4lwBH/tgPTamGYUt9unQEu51+eSG9A=;
        b=IRzstxTJEA+Opkhlppnte2uXbIU8lKD78ueMsFfsrZXc+DI8S3Cps4XcMMpx0FzZjh
         EHa+Jy/KGn2S8lv62OKXMskW0Hzg0HKcWzsSj5swMBSJMMYDEEcZqqfl2VMj8w/W92L+
         yQ+V+JcQqql7WBgXNDpFPFGJ8D4klufyYQlaNQ8aInVdZdnev75y+pDD/HVVvBVRrr4m
         dqws/f1gVzsZqJCEojC9zuoo9Yx4RU1ebqHvhW5nuo3UJN3iGoJIQysPtyk1QPx+l9bu
         vQJpIPykR90YuX251jvuXP/Moq2eIMjJq58PKUERi61z1GIvmNKdOix7TL3PO3fJWMQG
         hdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486250; x=1715091050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flcLrs0CTLkRp4lwBH/tgPTamGYUt9unQEu51+eSG9A=;
        b=k9gShXSZzoTTlFyO3lGLAxJF4pgTbj0icJzaivJ+Dtoh2kXlGx40vLjFcbCR10r5CB
         0Vy6co1bQrNwB0923XDoc9SvLeK1ZeUiyZSS7fRlEsE9M9k1b0VXhq+2yfaP/Tq8KPtr
         FQD2JRcrgf9KQJqwq6HtPJKtW2nMmzCXbxeq3XAuqc6ZMqe3t1ImOwNa9Wonsf2rgawJ
         RErVLmAT7jhmpjTKxNEht857CwcpBz6tbyGALiXQW6JGgicDepRZfK83I/wO9hDHV8wA
         mTzTVz0pw9ZO39RzaVhF/cCLKsheYO1T11TlEeRDJbYIB2lNKYtsvUKi1TeXinpSLoGk
         nncg==
X-Gm-Message-State: AOJu0Ywla7mtn31BPkao6UkCIBQEwpf4zRFBe0Z262VNYJG2pDIdrdfA
	zXitattfEly4HdpXEF0fx40tA9YQDTnFZU6OcxAe4eiRXEFMlVRLBRO41Y1D5ATmBYiSqZE4QZr
	veuv1x3HdloZGL/z0QFgL65d0KnsAfwD6z1i8
X-Google-Smtp-Source: AGHT+IFRVUNJVq9usLqD0aQ1nwKNEZGrhBiNwqO1rXgfFnz4VSVNxq2azlgdwljeZ+D7Qn5hsFjHAEsrjNRxWkII3/4=
X-Received: by 2002:a05:6402:2032:b0:572:7c06:9c0 with SMTP id
 ay18-20020a056402203200b005727c0609c0mr272713edb.0.1714486249968; Tue, 30 Apr
 2024 07:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <752f1ccf762223d109845365d07f55414058e5a3.1714484273.git.pabeni@redhat.com>
In-Reply-To: <752f1ccf762223d109845365d07f55414058e5a3.1714484273.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Apr 2024 16:10:38 +0200
Message-ID: <CANn89iJoxoA92tF3avTTL+rthen_iYfA6pc6wevNRkwnvaLWjg@mail.gmail.com>
Subject: Re: [PATCH net] tipc: fix UAF in error path
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>, 
	Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, tipc-discussion@lists.sourceforge.net, 
	Long Xin <lxin@redhat.com>, stable@vger.kernel.org, zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 3:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Sam Page (sam4k) working with Trend Micro Zero Day Initiative reported
> a UAF in the tipc_buf_append() error path:
>
> BUG: KASAN: slab-use-after-free in kfree_skb_list_reason+0x47e/0x4c0
> linux/net/core/skbuff.c:1183
> Read of size 8 at addr ffff88804d2a7c80 by task poc/8034
>
>
> In the critical scenario, either the relevant skb is freed or its
> ownership is transferred into a frag_lists. In both cases, the cleanup
> code must not free it again: we need to clear the skb reference earlier.
>
> Fixes: 1149557d64c9 ("tipc: eliminate unnecessary linearization of incomi=
ng buffers")
> Cc: stable@vger.kernel.org
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23852
> Acked-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/tipc/msg.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

