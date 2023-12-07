Return-Path: <netdev+bounces-54991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9938091FC
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D43281EBF
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73284F899;
	Thu,  7 Dec 2023 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZndeX6Yz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059210EF
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:57:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28647f4ebd9so1188875a91.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701979039; x=1702583839; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HMdpJ28r8mttHeq5lgMJ6ge0bIyorsFZA7pKmCIgG0=;
        b=ZndeX6YzBLZR/pEgTLg/u+dTJJvVQtdvPCfgHp8DcNqA3onc8HxqQgwwugORzn4Vql
         7hpRy8tdPtnjuvZE+p4xNsWRLG7Qp5VEaJCoshX5vkJjkKtguDPIpBwpGh2plB4NlRst
         3R4T+N44ZzFNGnwa56muSLcWYEHrYflubNdwCQZhiCVuT90+1jU3j6qqY0bTuCPSeDG+
         zFiaindP7VEF92oW6hqfRWwcFMeUVZks86ZIIRiU0yab4elMSscO1Nskl2INWWPA4bN3
         4zjUtb45AMdbM2hTsp1oI0pJ4rLUoc2EjfYQTmKJAFhUXLZSk45PiepUkpu8nMvaTgsU
         uuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701979039; x=1702583839;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HMdpJ28r8mttHeq5lgMJ6ge0bIyorsFZA7pKmCIgG0=;
        b=eZyMgHiy6nBjPbkSATDtx2nyxfnobOc6VqGaKSIl8I/cxRmbuzWE6oUGMMJrGKeE/q
         pPiTfLalzyt47TjSlPE4+MgdFtyLk7BUxL1S9roKHDNY0GlDg/Q+m5NWk5SjGhnP/+F0
         kPY5iPumJvSXIC2n2gcdjPqwXzKdV+0e5EqMnmV1PyxjI3/0dzw36V9VTNObYe6jDbTh
         /osFo3ZIi+BkIFByxvhLscZoAIBagql6KcJ21blpWcv7bomfv0UWHjvImnt2t9giCkSx
         3RCIkexkE5SY96mmA4a9eIJDd9FYwW0WCaO7egVdLvJxLCrGhCQmOgQIv2aMseEWJaF0
         dtXA==
X-Gm-Message-State: AOJu0YxBNjVHMD77Oc0TEfCTtYC4jzjg4ZryUxtnaIMimR8Xsi9+9mp3
	HxHXTY3fpdxe4RUTxFhBYIJgk9YQRMQ=
X-Google-Smtp-Source: AGHT+IGzSbAwlqROIcyE68Q3E2B/NiRhI2NIWGas5VvRuwvVKzg4jQ1S5Gc3lN036PTg91OxW2wgEQ==
X-Received: by 2002:a17:90b:1b0e:b0:286:e436:4aca with SMTP id nu14-20020a17090b1b0e00b00286e4364acamr2725961pjb.92.1701979039342;
        Thu, 07 Dec 2023 11:57:19 -0800 (PST)
Received: from smtpclient.apple ([2001:56a:78d6:ff00::1fac])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090aec8500b00286f5f0dcb8sm300811pjy.10.2023.12.07.11.57.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:57:19 -0800 (PST)
From: Arjun Mehta <arjunmeht@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Rx issues with Linux Bridge and thunderbolt-net 
Message-Id: <C6FFF684-8F05-47B5-8590-5603859128FC@gmail.com>
Date: Thu, 7 Dec 2023 12:57:08 -0700
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)

Hi there, I=E2=80=99d like to report what I believe to be a bug with =
either Linux Bridge (maybe and/or thunderbolt-net as well).

Problem: Rx on bridged Thunderbolt interface are blocked

Reported Behavior:
Tested on Proxmox host via iperf3, between B550 Vision D-P and MacBook =
Pro (2019 intel). On a direct interface, thunderbolt bridge Tx and Rx =
speeds are equal and full speed (in my case 9GB/s each). However, when a =
thunderbolt bridge is passed through via Linux Bridge to a VM or =
container (in my case a Proxmox LXC container or VM) the bridge achieves =
full Tx speeds, but Rx speeds are reporting limited to ~30kb/s

Expected:
The VM/CT should have the same general performance for Tx AND Rx as the =
host

Reproducing:
- Setup for the bridge was done by following this guide: =
https://gist.github.com/scyto/67fdc9a517faefa68f730f82d7fa3570
- Both devices on Thunderbolt interfaces have static IPs
- VM is given the same IP, but unique MAC address
- BIOS has Thunderbolt security mode set to =E2=80=9CNo security=E2=80=9D

Further reading:
The problem is outlined more with screenshots and further details in =
this Reddit post: =
https://www.reddit.com/r/Proxmox/comments/17kq5st/slow_rx_speed_from_thund=
erbolt_3_port_to_vm_over/.

Please let me know if there is any further action I can do to help =
investigate or where else I can direct the bug/concern

Thanks!
Arjun=

