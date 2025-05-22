Return-Path: <netdev+bounces-192746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07758AC1026
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868967A5025
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4E299936;
	Thu, 22 May 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHdn68Cj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645828C00A;
	Thu, 22 May 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928501; cv=none; b=eVSx0Ze97eUPxFXeXINmfV+E26OKEBrArsEYRPmMcIuTBTbYRxmPyfyv4bOoYIgsGoJeEbH1BSjECRzVWvxPYVGeTTCYc53L8g2l3GU+wYi8aMVE+jMh47VB+49YILuc2hKR2MBn3PbjVU00qNtul4uUH3tGOLbiYgiNFcUNV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928501; c=relaxed/simple;
	bh=k3tB6OPX7QIGtB/u9nELbzQrJAonc4DmqQNz7pLFRc4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GwxEJfALJPntCt4t0IYcgyvreSK+DxHDj1zrEQ+eeR7TbY9D1tnKI47V92FtEzrawxOWnL/NEBQzOsCzclKsJmXVCjh8WXiKZEpUMp4l4A0HzdsuWbYHyPlE8qlVOJKcJTqdLdSnH7LvsiV5lwGKIrAMSpwKg7IOsWVctaNnD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHdn68Cj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-329160d133aso24286541fa.2;
        Thu, 22 May 2025 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747928497; x=1748533297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k3tB6OPX7QIGtB/u9nELbzQrJAonc4DmqQNz7pLFRc4=;
        b=HHdn68Cj4bMM9Ix0X4Vbg0lmw7YspZICNZmMxgzmzshmsKJq17vJufiE1CzDml2i3t
         /M6l1K9D8aW5+kBS4g924i1dsEV1OJeftE2GIwyb7DzB/Nezp6tezDqDhHsiZ7BRkCyc
         VDZYkaWBL3MOfjGPMtaUNlZF1Tz+YmS//xUA76PGxd0KEiXI/9q2gCCKvlXfzggxdLV9
         GekE7mwZUaTPGJcC0288jMfyEEE3Vs/Xu7K0YkRx8WTFza5gZ606mX4dhG5iq1P5RA9G
         E1DBbWV42nNnrevWdnIYEKTZ1D7NFIFbYRpPQbXSbwB2qeLGU1L55pdZ1NlSHayqQSXu
         a1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747928497; x=1748533297;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3tB6OPX7QIGtB/u9nELbzQrJAonc4DmqQNz7pLFRc4=;
        b=t8cunQxtV9C/+41S31Dth8sN8FpTzJ+jJWHymzQhgalIexZy9XULYA+eQrbCX9pVVX
         U5/jPSl7LCLmMjUhFC7nu/JbtT2w758wcB5ToVHpKNKHz0Y2VXd26ND5FaFagC3s9zde
         2yr+GI4VNtmPs+V1x1tt3V3Xw06vrdkQg89Q6oNABWvEywrNfUTCNzm9nOMpzNM/nijy
         UjFiZHLQTsMAylTZ67laZ/DjSb4gVZYyxXlUm/RF6cUJj0TcRlzN0lqja8WXvvluujY/
         2S7ufqY2zkv4xDBRmq7jGtTr2cge5OkENfGfwFFzyhZTY3GFsxqiZjrFcH22/uS4Wked
         AnYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDEYwNKezC8DZWAO+2EfXbdpYxCYTDDqMgID6H4mZC6uOAV6V7A4O11TMY93P5xvYvv4oAFTFc@vger.kernel.org, AJvYcCXCkc0g7O9LiO5/VuHqTK4KL9EvZzfBpXka2d4rFSY9RAdOPNawQE4+7Xqaj2/o8o18Yubj0JynKyFI+rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2kXyFy01wZWMdj5nEVXek2ngSaxmMfxHrtGT2WJlatWqRlSm
	4+acSJCrsIrOg7iRk3Hfud5uWyk76K2E/0IBxng2NneDjuoowvvqzDtdmh9NV0QjeQasn5TlGQR
	As1cQghIRiQZf6clgsR0RQP19zT1/xQ==
X-Gm-Gg: ASbGnct+EcC0n4R46ZgYPFDNTME8dZy7SbMSsXWIPrVs3sai9oovkUDf2XmKXHQaq9g
	Ke2Ddewy7xqcUJ6h78PRw9JSB3VDM9NRa8asnXJmMMAil1GEloiNtd6BdI4uFhU7fyUHnu/+8j8
	tZWWuwfGedzv+QqTim85bf1sCSk9bcYT/72Dt36PG8Idlq58h1AvKqjQ==
X-Google-Smtp-Source: AGHT+IFBYT2ECq7skPX/+CLf6pZBRbOOn8MyrBq7gpAH02lpUmjOZ3+RxWM2BoLStFU/ehrHXtRin6akCdMdkRC4nSI=
X-Received: by 2002:a05:651c:f0a:b0:30b:ee81:9622 with SMTP id
 38308e7fff4ca-3280978631cmr74772971fa.31.1747928497402; Thu, 22 May 2025
 08:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Thu, 22 May 2025 23:41:23 +0800
X-Gm-Features: AX0GCFt4Ipa5E88ueb2O2mhmmdZsvjLs_H6IPPx2cSxROCy4uonB3PH6xysBdBI
Message-ID: <CAP=Rh=MvfhrGADy+-WJiftV2_WzMH4VEhEFmeT28qY+4yxNu4w@mail.gmail.com>
Subject: [Bug] "general protection fault in corrupted at " in Linux kernel
 v6.14 [sock_kmalloc() Null Pointer Dereference via CALIPSO NetLabel
 Processing in IPv6 SYN Request (IPv6 + SELinux + CALIPSO Path)]
To: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: 0010:sock_kmalloc+0x35/0x170 net/core/sock.c:2806

Bug report: https://hastebin.com/share/vewamacadi.bash

Complete log: https://hastebin.com/share/otoxiberok.perl

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:
A NULL pointer dereference occurs in sock_kmalloc() at
net/core/sock.c:2806 due to a missing check for the validity of the sk
pointer.
The function attempts to retrieve the associated network namespace
using sock_net(sk), which internally accesses sk->__sk_common.skc_net
via read_pnet().
However, in the specific code path triggered by an incoming IPv6 TCP
SYN packet with NetLabel/CALIPSO security attributes, the sk structure
is either NULL or uninitialized, resulting in a general protection
fault.
The vulnerability is triggered via the SELinux NetLabel connection
request hook and affects systems with IPv6 + SELinux + CALIPSO
enabled.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

