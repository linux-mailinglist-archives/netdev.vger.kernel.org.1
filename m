Return-Path: <netdev+bounces-112964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C725093C045
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EF3B209CE
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2351990BB;
	Thu, 25 Jul 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXJjTL62"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA516A95E
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904275; cv=none; b=pX7RpHrlXhP2fO2p/ME38MKtE8Y2WYwcQTbsCU3FsWcNksSJpD+hh2ocKSTEeJ6kwjukt91BRnyWrGcYWECEn2cJsvbqxw6GmCT3c+Iq+OYC7/0lm48NvwYOrc3Zv9983vSCd3BmV04/5c4P/InZNmwbfkq/WbOuNaZ8d+Opj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904275; c=relaxed/simple;
	bh=0vq0rDUT6bKO2W9H+6WFqSg/9iuDLDwHFDr3lWX1Za4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQCAU84Ce2OBBi+MSd+bk9yqmciHIYXs40yCRCXd5YL5wiJh3Qj6+bW8V4QTmqwY66l0dVie8GiYBxlJfrgCrbFOTGQS2ElwX3WQ0+nLZoN+ujoxylL8hwXMES5mgliIMcu3xEp1IyzpRvsDxeXB0+txeg6VFWPSynFigmLkyQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXJjTL62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721904273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRI06KBbgnO+Bpzme7unWL6gNnWyJ2ogiXiY5GeACt8=;
	b=TXJjTL623oUtRoATckil8p/mgqxgcjZKb7iptAQh1fbk9zRCinr9taPYTToGFrECwQV30v
	YrBGrMW0N5HgbAOHVZU7RCxPawJMb+WWNtJjMvpSboVfsB1igiox9yS0T6gT/MX4h2Xya5
	q1xRQEufY+qS7nmu3hVBRYnbNxSGwxI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645--N6UudkBMwKRmqkD43yIAA-1; Thu, 25 Jul 2024 06:44:32 -0400
X-MC-Unique: -N6UudkBMwKRmqkD43yIAA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef185db2b4so2361fa.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 03:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721904270; x=1722509070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRI06KBbgnO+Bpzme7unWL6gNnWyJ2ogiXiY5GeACt8=;
        b=hX4m0qxANkxK+Y5xRvUOXB5OthgRzNuvpcfEBsEZw5URw1PGEjMFZlZEGPEejDO5Fg
         tytyxD370Y+6/Q/lo0EO95Lhe++FrDsUC93kyiSc/cI3/ig/K8ITwmMEWKVj6ln2eUIl
         dxI5WdMYs4baokQQA6v5h6V9CLitJRU4QaS8y69JhVcSOVGy6MLsMYu+5k3RrI7QF2oY
         xrww1eThtvy/cB6mfgyoUk6vgIyEc4yflJvPXLqGTllWQawQIQqcKRso5CaCLJWolnjU
         Zu814u6+dAu4DkQnjYsKILhC9BWZRA4d+TWiuj5VAGd5+uLAHfIqSwL/A09Am92feaxz
         w2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUgcEH9Y+5pcQgw+qOyDullcFW00I9dIv/Avz5Q0FLu0FTXZvIjMSTWDW+ila/vlVFFf34LPPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJbrxfJbjGP6+2+0AlcDTzMEAbAyTUiWvbWwF9BlMsj+yz2PZ
	DWkYwk+ndADTDnMZYHaDFgAfnk2/IgXOOEPiG8c62eralIwrisjMIhqTG1yImcvkwf3lFkk5WB1
	UALrKNpbkxy5KgPkAZWevDWnm1wvrNg5JZVYgbpF2rIKR6MrS/xqbvg==
X-Received: by 2002:a05:651c:155:b0:2ef:2346:9135 with SMTP id 38308e7fff4ca-2f03c8000e0mr7282361fa.9.1721904270476;
        Thu, 25 Jul 2024 03:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUBK6W2GUS8+jtAqWZDWCnsmj9yGfBQkRTr8Yb+Fe36zV0LVzufyszMXt+QAvJPZG2mpdWvg==
X-Received: by 2002:a05:651c:155:b0:2ef:2346:9135 with SMTP id 38308e7fff4ca-2f03c8000e0mr7282221fa.9.1721904269873;
        Thu, 25 Jul 2024 03:44:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9386b87sm67279135e9.19.2024.07.25.03.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 03:44:29 -0700 (PDT)
Message-ID: <e263f723-0b9c-4059-982d-2bb4b5636759@redhat.com>
Date: Thu, 25 Jul 2024 12:44:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in
 do_xdp_generic()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jeongjun Park <aha310510@gmail.com>, jasowang@redhat.com
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000949a14061dcd3b05@google.com>
 <20240724152149.11003-1-aha310510@gmail.com>
 <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 04:43, Willem de Bruijn wrote:
> Jeongjun Park wrote:
>> In the previous commit, bpf_net_context handling was added to
>> tun_sendmsg() and do_xdp_generic(), but if you write code like this,
>> bpf_net_context overlaps in the call trace below, causing various
>> memory corruptions.
> 
> I'm no expert on this code, but commit 401cb7dae813 that introduced
> bpf_net_ctx_set explicitly states that nested calls are allowed.
> 
> And the function does imply that:
> 
> static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
> {
>          struct task_struct *tsk = current;
> 
>          if (tsk->bpf_net_context != NULL)
>                  return NULL;
>          bpf_net_ctx->ri.kern_flags = 0;
> 
>          tsk->bpf_net_context = bpf_net_ctx;
>          return bpf_net_ctx;
> }

I agree with Willem, the ctx nesting looks legit generally speaking. 
@Jeongjun: you need to track down more accurately the issue root cause 
and include such info into the commit message.

Skimming over the code I *think* do_xdp_generic() is not cleaning the 
nested context in all the paths before return and that could cause the 
reported issue.

Thanks,

Paolo


