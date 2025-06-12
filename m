Return-Path: <netdev+bounces-197184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36497AD7BF2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A16E3A4200
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA752D6615;
	Thu, 12 Jun 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7JS5W1B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D32D542D;
	Thu, 12 Jun 2025 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758814; cv=none; b=tNXU07ctqgkMKLVRQnFMpbGSK4r+z1plONQTJE6mjuXSQXOacWEyd6X3sVWdKU8AWZGVzN6AlDdfL7h+wYm8Q5KI+zImo21BRVfghSfDBGR/VnQqRoasthV9dcYVmkb6VR6o75BGL6HX4jA9m6yIswPvelCU2QR6MtSDjwtrMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758814; c=relaxed/simple;
	bh=zDlFT87txcIFmArf/LehUaQjM2xBjRJpDiZIcmFl2SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjMxqKGhBPe6DqxHqCrcW8/GhFLi3QlCM4Ar7BOFNxb4ZamajoWLresfIAtJD9DeS/YnSQ+ZtUNsz1tkIZTbblYb2hZ4TrncytUe54pB7Ngy3x4FSmFUEfeYrTLHCqoi/7tqaR4WXGvptfZviADiIIlEiBQyo2E/iCbs9GmVwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7JS5W1B; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c49373c15so1040869a12.3;
        Thu, 12 Jun 2025 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758812; x=1750363612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTxl14oi+ElrUbf4YIsWM1WNqQ2qYV8l0dhSYWLQAjc=;
        b=j7JS5W1BurjMj1fEKlmT8fYoRTpAfwNtX+Nnu2ES7EdOEkP8GZdNknDsYWfp3sBMpr
         npHBXKRmA0YF89v3aR9FUc6kQWIvS8MffuZVsF0dAAiuKP4YmUBPb1Acc+pSSqEv0H7T
         Juh0psTUfWd90ZeRrjp9M3mvGOWpp6YOOhiip8zXgW6aVRzF9MLlycw8cAMORfe8XgoB
         v7o9BVwVvQ3/LWrQP+/6B1a2nAqZw7APZ34BpyE1bD5HH5a6Bt4gccRzwA8W2Aqu1T/2
         bJi5LfTM4w6aaGYM/hvf00jx1F8Cb9c+8fTwSv6II+Jb5T02O50Jy3seqwrWqC2fmUFR
         ZGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758812; x=1750363612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTxl14oi+ElrUbf4YIsWM1WNqQ2qYV8l0dhSYWLQAjc=;
        b=kReQetu9Yup4hb+c7t08y78J4BFp+ovZGRu71dWjLNoFa4+emkcLeZinz3E2llshTU
         qy6D7gY9Hj3KfA8INWKEVn8vcOnjymxxlE11jMdE7sW89mUuq3VKL9jJ2Y2LSan5UGFf
         9m+6i/o7M0hvccPxzXiy6u3yVHFYQWfGH4OjLsnjlCLhKe2HfmOlaZkhcnQXTn76vlCJ
         UX9e2d4kwHrs/6JUzaQ0pWFI90ibtnKOZpCtBBYWH3FtkOpv8RcahlgBbfq/r9Aw0Y3B
         0d8qSUE2z8aaQ5vhTfvDqPu51cCszbLYF3wCv7GWewG8oEoz4JiM+UsTprPEtMb0UiYW
         uwdA==
X-Forwarded-Encrypted: i=1; AJvYcCWKA6B3/rUYDf2xHgxX+DwoGXnPPMpeGC4OaQhJCuNHVpE6HhE/BEPPuUENDlAyROTGqQkP6nM2mdT0JwY=@vger.kernel.org, AJvYcCXcIeqq12cY9w7tURkjpkHqoZm3nRHl9LdZpecYvUIiMYCHr6l6sT6drvdIr868ho+m7QrR/blG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VOAh33aoG7dh4jpIcfWaToS0kwS32pqkRAK3RbN3chhiM0eP
	eOAS0gURf5etgiIrFyKc+XIe6K5MTP/4z2z6gKpUbN/O7XhHStWyjW68UC3D9o4+lQ==
X-Gm-Gg: ASbGncvmLfnd9XSj9nsAXudVGS5xJy0v6Hur4S3C1tgz3li+1+AF55OBhxo+yCwZTtH
	mLIAuHtuAp30L+EAUrp8XhTNTs18gyXWj7R/+SYlVNVSrO5kwIHm/M/ENYFoajaCXDkb0ojjXYl
	cg5w1uSe+Knzp72nc99DbqhT/8v9ONQQOvaJ9KDYBiT4bKxOeE1QAaxGow+VIQHO5pRiQviTq1p
	w6+BIy7i6eKp7YHUJgPR1sEjcPThhL2GkoYpqqv7mw208Iu3CZXiRUothnDk5naH+1+KAdOxWE1
	5Be9KUy/yH63LmLq8MU7WAhMRlDOFxQskC8bF9w=
X-Google-Smtp-Source: AGHT+IE9K+Pg3CgqmLqtae3q0IxypD70/IprlW4cyUt1i4GzOuEEtGQyIzTapP99lz40DVts01bYQg==
X-Received: by 2002:a05:6a20:72a8:b0:21f:543f:f124 with SMTP id adf61e73a8af0-21facc8e6a9mr375732637.24.1749758812279;
        Thu, 12 Jun 2025 13:06:52 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680408sm148237a12.39.2025.06.12.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:06:51 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: wangxianying546@gmail.com
Cc: dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [BUG] BUG_Address_NUMNUMac1414bbbb_on_device_lo_is_missing_its_host_route
Date: Thu, 12 Jun 2025 13:05:58 -0700
Message-ID: <20250612200650.4049799-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAOU40uDOh7JY7nVmrS1Pr013zMP2Y=qLwiJeANvgEupNvuHnWw@mail.gmail.com>
References: <CAOU40uDOh7JY7nVmrS1Pr013zMP2Y=qLwiJeANvgEupNvuHnWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xianying Wang <wangxianying546@gmail.com>
Date: Thu, 12 Jun 2025 10:40:11 +0800
> Hi,
> 
> I discovered a kernel BUG described as
> "BUG_Address_NUMNUMac1414bbbb_on_device_lo_is_missing_its_host_route."
> This issue occurs in the IPv6 address configuration logic in the
> function addrconf_add_ifaddr() within net/ipv6/addrconf.c, where a
> BUG() assertion is triggered due to a missing host route for an IPv6
> address assigned to the loopback interface (lo).
> 
> In the triggering sequence, the loopback interface is assigned a
> unicast IPv6 address (e.g., 200:0:ac14:14bb::bb) and subsequently used
> in a bind() or connect() system call by an IPv6 socket. During this
> process, the kernel attempts to create a host route for the newly
> assigned address using ipv6_generate_host_route(), but the route
> installation fails, triggering a fatal BUG().
> 
> Suggested fix direction:
> 
> Investigate the logic in ipv6_generate_host_route() and
> addrconf_add_ifaddr() to ensure that assigning an IPv6 address to lo
> always either installs the appropriate host route or gracefully fails.
> Consider special casing the loopback device to avoid invalid or
> unnecessary host route installations.
> Add error handling or a fallback to prevent fatal BUG() when
> ipv6_generate_host_route() fails.
> 
> his can be reproduced on:
> 
> HEAD commit:
> 
> fac04efc5c793dccbd07e2d59af9f90b7fc0dca4

This is v6.13-rc2 and 2 dev cycles behind...


> 
> report: https://pastebin.com/raw/xe3fvj5Z
> 
> console output : https://pastebin.com/raw/8XXmK7B8
> 
> kernel config : https://pastebin.com/raw/6iC2wRBj
> 
> C reproducer : https://pastebin.com/raw/SN7zKXeN

I tired this but didn't reproduce the issue.

---8<---
# ./repro
executing program
[   24.926531] loop0: detected capacity change from 0 to 512
Bad system call (core dumped)
# 
---8<---


> 
> Let me know if you need more details or testing.

Could you test the repro on the latest net-next and do bisection
if it still reproduce ?

Thanks

