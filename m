Return-Path: <netdev+bounces-181943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0C5A870E2
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B619C7AE87E
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796F1487D1;
	Sun, 13 Apr 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6k6bXQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466B8460;
	Sun, 13 Apr 2025 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744529173; cv=none; b=ZCW5vGRzuOJry55wA627F0Bvgjgt0QwcAFw2y7yhxmFC/nbZ/d4hrKtFI0LhwQvIFHPQNKFTbk5rGSIJoaoPPPJmIo+F28LGZpHu/Mu6aL7suz7mTi9Z29ggPQ5nGXv8tF4HQBimPfufhOySX9Rjr+8c1aH1ervaBE5RSlPlfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744529173; c=relaxed/simple;
	bh=o4AzouUi7VIx4Jpnr1y460PhYao9sduxoaPAVVMF5Tg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=W5rSExFQN8627A3/e82+YmZYmM7S4ko5rqgE/sR5VYGpFc6671+qwSeGgakeAhc16RCDnpGIQUHBT2HNojLaNTfOBQGdsFRMUbm0OfqoWdxDvM7Iofi8qxxaFcTnF75xUtHEtyXECVD4iQ8e+C5pmfhCGNL0EIGIu9YJN52LbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6k6bXQO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30820167b47so2569868a91.0;
        Sun, 13 Apr 2025 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744529170; x=1745133970; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=od3VOhmgG64I8q1xef8CGnXB4ZBUqWgfySPpsP8vdFU=;
        b=m6k6bXQOMLgYVEwQmBKsMH9bZMRhmKBKiNvi2M1WHgqZXWTm1upFaD4Q0xpdGjXuJU
         NHt1cPibMZx093maupc95S3M5VzKDF4IKXi17LqWe/+n3M6Xqze7uPSKFokKn38oOVnc
         +ifWF4vSLu1agkbu6jZ7Nh87VfdnCwLAlDO7R7f6LarqbQhfsZ5ctpBBXiKgjEsAE0mB
         jRJ4vszhp/gSqgImJ1DXJD9rpfylR3veq9gt8fiKk8tKILfJq15goXrfSt9sbSNLMs25
         uc6mFBwBJDWLpos1l1VV0VaLtS1zTZY2PnOoEqa33vYzra0nAC1Ft32hSzwLbTixtifC
         vEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744529170; x=1745133970;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=od3VOhmgG64I8q1xef8CGnXB4ZBUqWgfySPpsP8vdFU=;
        b=fInY2ziMQzN3bXTyZNKt9+EI+qxc67l36wlvJwbb/3dGXdwz12E4KR8kg4gI7tQrab
         8732IxPJAHw9RC1EApXdAZdixz82nveWLrwovRRK3dIngomyQSK0NfDoArNbFbETw1HZ
         hlwqwKuZ8ZKHsyXcRsQHkh8nmrSF5UrI7qpSqSCJt/3NDQRE8yFfhkbDJNE7Ptj/4rm1
         KlCnBzRlls5xtmap6WcJ8WcFRng7WVe9zV6Z+wKTqbFkMgZ09vokIV7a5C8FktqzBcGC
         1K8Sp7DS17zzmWbOESMuvicvbE7HKyLlggF+z8ZotUui7gw3YSG6jGaBVuJkW16vyzuf
         t5/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH0wZGIM7V4dXS7kTPgN2GKoGa3mx40Y0vp2YUJSBm2JtePBnEzmulMwM8qpcdyLx8/KeCKGoF@vger.kernel.org, AJvYcCXU2K2/4/zZ2kAK0sjwiWqMnFzHWy2Hqwv/6RWC4Gc6eNZ1SL1wD5+hc+A0UiinjyCDiN8v6l4x10l8PFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEajjfHAPChjUtZqtm+zD1Pl3xpGTGBBVFB/E6HEwyqdK4E1Wf
	RMvw/z63udlTHQ1DIehD0MZ0BERFvggZgUVXe0OTikvp7AvxYLm5C2LornVVJ/PwHi0uC+k8jqc
	3yDPp7g6cBjeKgVUhazvSJgZ6Cg==
X-Gm-Gg: ASbGncsbwwjhvm8z5u8HV4XpdwDMOcthSLPvAO0x3c9adHRzfbI2FisFxqtaYT9itvw
	ADSaFkQtrDABY8L2mP2OcnJfs7gR6crbVrxHQDVbdTpRkWY1Rzc/swGxBZlZUvZKVxuneCxgCpe
	LEtSSSYevM+wovZMylp/Bka4wqk9VVTp3jTaP768ZtIMsHfYCbr4dRSc4=
X-Google-Smtp-Source: AGHT+IE1/b5sjrbLlWni48LfSIwYxcrrKKtJGNhl/KGBr6YTcQNTnoyypcLjyBVic9TFh9zrY0L11rPFEM0hVqZQWJg=
X-Received: by 2002:a17:90b:5111:b0:2ff:53d6:2b82 with SMTP id
 98e67ed59e1d1-30784d3f77emr19811667a91.11.1744529169875; Sun, 13 Apr 2025
 00:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Sun, 13 Apr 2025 12:55:58 +0530
X-Gm-Features: ATxdqUEjycNNStPWtYc9zsABVuK0vCzjMN7f8Pw2fPvgiCymzDtMO11MHkorkX4
Message-ID: <CALkFLL+LxVk+M--+qHiP6g31rcvXxBGRJpKvp=CCFekL9OyUww@mail.gmail.com>
Subject: [ethernet/broadcom/bgmac]: Implement software multicast filter clear
To: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
   I'm trying to work on a few TODOs in the
drivers/net/ethernet/broadcom/bgmac.c driver code and came across the
"Clear software multicast filter list" item.
   I tried comparing the multicast filter implementation of the
sb1250-mac.c driver for inspiration but realized that most of the code
for bgmac has been written by reverse-engineering the specs:
   hhttps://bcm-v4.sipsolutions.net/Specification/

   I'd like to try my hand at this if there are documents/guides
around this topic or if there's a canonical source for the binary that
I can try reverse engineering. Please let me know if you have any
leads/advice.

   Apologies if this is misdirected, I've just started to get into
Linux kernel development / networking stack.

Thanks,
            Ujwal Kundur

