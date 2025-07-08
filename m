Return-Path: <netdev+bounces-204849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC8BAFC40C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C1C4A14AB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96229826D;
	Tue,  8 Jul 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF2pzRg4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FF219EB;
	Tue,  8 Jul 2025 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959816; cv=none; b=PU9rMzebMUNlqI44dVfE9280PbQtFV2hKf+kleqbV8RVRohdgO6bnvtt1KhRLaAYnbWL2dMDfOxDYlTX69d51+31tSw2tDN7XVHHIQcG67lflz9U5+OOyPwoo45ZdH/ufwNzeFJ4ouEH2IKHEsqMN7aHPb4B2EneaWZy8XZf3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959816; c=relaxed/simple;
	bh=cKMs56fyVZ6L7AKJr+/shd8+cZbwH4talnYosOwBTK8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mnzLehquautyLzUpCPzX0MgBLrUIe2/IErSNDqLc13s79gaUBkAFR6evJZLeKpnBRv23cdoQEf/TthZmIUPTXGM1zy4oIKzYorDmGLhUDOfkeZ+/uQtZbeCFwmQoOJ7UgbwdSv5ghSx58KLlbNUmBFqy7Tu43hPSyux5ckNA0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF2pzRg4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso34630321fa.0;
        Tue, 08 Jul 2025 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751959813; x=1752564613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKMs56fyVZ6L7AKJr+/shd8+cZbwH4talnYosOwBTK8=;
        b=cF2pzRg4Ozqeu34DkRUg5+IiSEv8+afQ/DWLbPwuY/JVSN2KzTYp6SFidi1veU9+5T
         cOOX5SPW3iqHkAv520eSvC8AxjZRjwOo0m6pn67yL380mQvHRbbM5qYQqdzGlgGKAjBa
         oe58ShZkzSWzWToANOseN6dORUiM47gV3ZqpbS7IrqzivqLeBuT85vgBX25a1ANWJ2z9
         IHfjKiLFhheAgX13lQeEgE3AnNHoDcwxjibAzYW6kGdPdwz/960gOfMNfJ7lQ/j4qDhn
         4HLW8EiUQrHqN2iGEuxiTbkMpTH9oH7IsWpNxjrv97GrF7lgSN/TTwh3uc7wmfAw4jzf
         bw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751959813; x=1752564613;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKMs56fyVZ6L7AKJr+/shd8+cZbwH4talnYosOwBTK8=;
        b=dqjskbSoy9xuB8CQW+tEQRwjrt1FAEPj4EwCsgG8cwQe+9maIsQE/OYtrb04sEgrUJ
         7Kkz2DuLcvLWf5RBqsE8h3+hb/4r3C4GKVbGzQyBZn7t+6QNrjnmXWycJxv+xO2fBSW+
         8ExR8D5TIHLwgJR69dhfTu7ImWpIM0oAEAMlurR8HFhcgJRlCp8Wg4GtTMqMzUVd7U1z
         9jMK/5AAHBPNFGOxLynHoh/u2EymOEf+XpYtCLJ1jUUZuc2L1/NCjg8DPRSc95d1+E1Y
         1PikDTZ2/rPYZQwrHnPvPhFj4c0/SRbSOKhpFUJAAfYceBhZrYXv/HNan2ZxC8N/c09L
         t/ow==
X-Forwarded-Encrypted: i=1; AJvYcCUU2VeJPLOTwkEbmnLZWc5shn+b14U3Bmaixud0iKtZsk1ygcnG7yUNL1qBUx6XUg3rStXDNETV@vger.kernel.org, AJvYcCVdq9UdPA1k8XhXaJrU+jYSoQlHTVMlrdRm4V9Lsuo6HXjvJ1/gN2JhUj502e3MqGzxeCl5Mx88nRecoKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrRvGaEzK9WVbmNuzC4IxTU8A2g/V/T7uPWkiVyGc3MDd2oEP
	O9TpE3IMoogj5abNxk1KWk3UnsSVkXFz+bIijuibAeYjDo+gMwP7lrDrVB8C+Wj04EsLAP0q+vH
	TwqOdRtv8nbqIm1gJouKbriV8fuGJMG4=
X-Gm-Gg: ASbGnctznUHGKzs3jwUhjRkMQcnX/rkXebSv0qVOTFJwD3fXWVzXsOGXP/Jfw5kaN50
	8v+I0UYYpm4Hfm9xcQcMgqmuTf9GhyL5s0Mrr7tVjIJ0VaYtN99/ZcWIrBQ9X73w0y5gsyMl9Vy
	qJJe1o/3KTx6hIawK8z7Fw72BFtX1JVGB1LD3dpI25mc9KQQnRWCJWwknJIl5CM8LYyg==
X-Google-Smtp-Source: AGHT+IG9u7HevHo7AiuQj+pH88OB49lCJ5p4tfyJqAiwxXcSLRq1HfyoYecHFlcEolIQ+cfZ+WvRz0YimD4HCl+Udag=
X-Received: by 2002:a05:651c:408b:b0:32a:749a:14d4 with SMTP id
 38308e7fff4ca-32e5f57cd56mr30715501fa.12.1751959812512; Tue, 08 Jul 2025
 00:30:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Tue, 8 Jul 2025 15:30:00 +0800
X-Gm-Features: Ac12FXyraQ03idfOwzLtCSZFyJPKxJ_-bjxd743jjyA-XCOHtPya6EBPHGprq54
Message-ID: <CALm_T+1s19Kr0=v94oUJEbN5ciGcumZDZp-hbn5=z_wPefqG1Q@mail.gmail.com>
Subject: [Bug] soft lockup in ipv6_list_rcv in Linux kernel v6.15
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.15.

Git Commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca (tag: v6.15)

Bug Location: net/ipv6/ip6_input.c

Bug report: https://pastebin.com/vw0Vrd2m

Complete log: https://pastebin.com/HsUKHEpJ

Entire kernel config: https://pastebin.com/jQ30sdLk

Root Cause Analysis:

This bug is caused by a logic error in the ipv6_list_rcv() function
within the IPv6 input processing pipeline. During the handling of
multicast packets, specifically in the ip6_mc_input() and subsequent
calls, improper synchronization and premature release of socket
buffers (skb) through kfree_skb() lead to corrupted memory access.
This results in the triggering of a soft lockup condition where the
CPU becomes unresponsive due to prolonged execution in
skb_release_data() without yielding control. The issue is likely
rooted in incorrect reference management or double-free conditions on
shared skb structures under concurrent processing scenarios.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
Luka

