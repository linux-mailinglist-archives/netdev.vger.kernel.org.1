Return-Path: <netdev+bounces-48688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD927EF3FE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FE0B20ACA
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555E230CEE;
	Fri, 17 Nov 2023 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="h5e0OFZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8245811F
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:06:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40806e4106dso12306885e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1700229992; x=1700834792; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUSucFXkd+WYLMrExh+s/XprL+xuPEud4tsvteCnamA=;
        b=h5e0OFZYMkx3MBlJys62IliHelqDBXJaWw+amVbtPokYCkdqS9zIO1hp5lrV0gZ+vd
         jPARcjJ3WFcL2RIN4nccRZzemn7vEFTtnuFWezG5dE0xAUgM1SDgJmA3II34jAZh6dZo
         QiyQV7f0mi3uotS4fks1+nJczho1ZQKJBKTX+yghZOffZtYWt7vHQcLo2xageZYxHore
         vU6sWLuC+4U8EF6PsCp2TppIcMJtel4WYKZbq4yAuNtvUTqF0m0k0gJvq5ek/4DjtKIL
         oipStE9m55YBkd8cbgiUCYQGQGFp2dP3XN64dq4zFktyBr4BWvjKdks9m1hky27rEh4v
         hoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700229992; x=1700834792;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUSucFXkd+WYLMrExh+s/XprL+xuPEud4tsvteCnamA=;
        b=Hz9M8yJtH0bhxOtdMsGx+k46HSNGtwZNb3Q9ZxGYB4ELfMb5FXdOJOFVS6GPDJh8cI
         Ewib6qd91HYMxzBVnOG/cOZH3oWgLrMAC1Mb/XJ64HC0+0FToIj4gGJOG3D44QbCXRul
         /7OyWzGAimRSHCkEZgiGBD7VwCQoKEuByMdn6rlWTGlkibPqcVTe8jPJlR4yfGAcZ6e1
         wYry/dW/JAI8IPnclAVRzncaT2E3Mhl9C4/1XIodM7jTpieK2mAPRhWTX/myNY/UE43J
         p7PdBY0dfMUq31sj+QRD68hCxZPxllmavx+xe1yW+ulW19sApVpcM9+QHGN06QqtSk0c
         S6BQ==
X-Gm-Message-State: AOJu0YwQJxlvNaevDeax531E3bQEYzBw3nHg3fdY+oK15Xyo1Z+HVPDr
	5bsUoGNXQILdj22FvdmzqR4D5J+nsHLpzna2A3E=
X-Google-Smtp-Source: AGHT+IHxnQY9h6ozXzSeg9DzlCNwLvPpHH78PCwPm38Oe90AqYsY9t3FZXWE7GWfco0zUwpPzH51JA==
X-Received: by 2002:a05:600c:1906:b0:409:6e0e:e95a with SMTP id j6-20020a05600c190600b004096e0ee95amr4541776wmq.19.1700229991945;
        Fri, 17 Nov 2023 06:06:31 -0800 (PST)
Received: from [192.168.0.21] ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600c364f00b004060f0a0fd5sm2776406wmq.13.2023.11.17.06.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 06:06:31 -0800 (PST)
Message-ID: <7d221a07-8358-4c0b-a09c-3b029c052245@smile.fr>
Date: Fri, 17 Nov 2023 15:06:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: Florent CARLI <fcarli@gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Subject: hsr drop frames when received out-of-order (?)
Organization: Smile ECS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi netdev,

We are looking into the hsr module to create a fault tolerant and "soft real-time" network.
But when experimenting, we noticed that enabling HSRv1 did *increase* frame drop on high load.
For example, with iperf at 800Mbit/s on Gigabit links: 
* Without hsr, no drop
* With hsr, 0.05% drop

I'm using a recent 6.5-rt Debian kernel.

I created a script[0] to replicate this, using iperf3 and veth pairs inspired from the in-tree hsr selftest.
* First iperf3 with in-order frames : no drop
* Second iperf3 with .1% out-of-order frames : ~2% drops

After investigation, it looks like the hsr module (HSRv1) drops frame it received out-of-order.

Here my understanding on how the current hsr module work in HSRv1:
To avoid creating frame loops, the hsr module will only forward frame it has not seen before.
This is implemented in net/hsr/hsr_forward.c:hsr_forward_do().
And, the "not seen before" part in net/hsr/hsr_framereg.c:hsr_register_frame_out() : this does store the highest sequence number it saw passing through the interface.

Here is a simplified example of what I've observed:
* 2 hosts ("local" and "remote") are connected through an HSR pair to form the simplest loop
* Local host has a hsr0 interface based on hsr0A and hsr0B interfaces.
* Remote send Frame1 then Frame2 to hsr0A and hsr0B.
* For reasons I'll list later, local host see Frame2 on hsr0A first.
* hsr_forward will forward Frame2 to hsr0 (toward userland) and to hsr0B (to make the HSR ring)
* Then, when Frame1 will be received on either hsr0A or hsr0B, it be forwarded nowhere because a more recent frame has already been seen on those interface (Frame2). It will be effectively dropped and will never be seen by userland.

Out-of-order frames may seem a rare event on direct Ethernet connections but what I've seen is that the re-ordering can happens on the host:
* MSI-X: it "load-balances" the IRQs: an early frame received on a busy CPU may be seen after a later frame received on a not-busy CPU.
* Interrupt Throttling: in conjunction with some frame drop, Frame2 is seen on hsr0B before the Frame1 is seen on hsr0A (because hsr0A was IRQ-throttled)

BTW, I did not investigate as mush but we also tried the hsr module in PRP mode and also noticed drops.

Can anyone here confirm this analysis?

My idea to fix this would be to improve hsr_register_frame_out() to register the recent N frames instead of just the last one.
* Do you think that would work and could be merged?
* How hard it is to implement ? (I guess parallelism will be an issue since we do not want to mutex/lock on this path)
* Is anyone secretly working on a fix with a better approach?

Thanks for reading!

[0]: https://gist.github.com/ycongal-smile/7b42472669e83025f106c185c5159ca3#file-hsr_loop_test-sh

Regards,
-- 
Yoann Congal
Smile ECS - Tech Expert

