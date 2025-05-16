Return-Path: <netdev+bounces-190944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B81AB966E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE287A06BDE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EC7222592;
	Fri, 16 May 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDJPpFc4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D471215F56;
	Fri, 16 May 2025 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747379926; cv=none; b=Hh4D2zKGJWD3UatqlAXOzltICchibQ2mDWWalX3pqlV31IPOy1NMh1/oSPkyEfHFE9G1z0AWKz78A0qocflaaUSjmqEIqeCAQsPLhuNa/+pj4tq0K2LfEk1uhoXYhkpDlsbHiQHf4L4Qa7JrouzLZJwyN0M+WtO4kASzBgfuDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747379926; c=relaxed/simple;
	bh=nwBsT22w/K1MZAlFL6jnYXmqMbinibQckfsxPHwloXM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jqb1wTlTxl2a0VlpkfFfhHTcwYARy4YOvyZMMNcTe7nNWtVbhVeiVtQXpVXTpXUNx7ngGX7gvcpjeyy81kaYQleNY/2M7FYwfVCXkz4kZ58PG5f4NSZxolUC8WRV8HfPyIPBeTw2/ipYdbd0bLft2xsthJ7Mzqp9b2Zvo1gLhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDJPpFc4; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4df9c028968so384632137.2;
        Fri, 16 May 2025 00:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747379924; x=1747984724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nwBsT22w/K1MZAlFL6jnYXmqMbinibQckfsxPHwloXM=;
        b=IDJPpFc4rcqd2lQdZDYsMRg63QQfgb1Ns6GYDU/KlW1Gdzczc8u2hC7FuJ5oFruEgX
         rbbrR6WTevOKmNs4yn1I6IgbpGCfl7SiPD20sNfG2QLg0aA0pnUvFwNqa2ZTq7DoM0TH
         q5X5BZAHlfjt+RlKNj3AwanXBNnPzGDogJZKRDSuziCCtc2iaa8FhzPdJu4q7VhWDWCk
         KBWxEmxEQNeyvJSaE5tc2dapBTXuEvCoIuCUs4UIOCumMrZTWAj8VdNils3fxnN5lVAO
         INK0IgexxpOGq6xfXNBTXCSwiXY+Fo3RBG1Y7raMhF+iVaBhhSuI69lxP3+ejlWOTrM+
         EYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747379924; x=1747984724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwBsT22w/K1MZAlFL6jnYXmqMbinibQckfsxPHwloXM=;
        b=P2pdN/hM+KLbBx4umiMfZpGd+klsFpeoq2hM26v1AkYa4rITdkzEWSMVj6qaAb2wLy
         J+kfjmuLHFFZhJUrloGOqaLhkhbtHDyIRQ06fAqBvhwAevrFCVYeyXLhGQoTVsdRuyU4
         cWfIEmus9l0Mx1WDVL8hOU5y5SswkJv+jAg0xHObir7jlhmX9AjDaFVB77bJolT6aAti
         2vOFktzl7E+d2652Z70fMwPSpPRc2cW1vnQrMylEYXUozQC6eIAQpuX2b0VAUdkTlhw9
         PJQZBegInJR1LCFPnX7bNQa1Ucn7fKz5RmbqXvcZU7IopT+hjGfU3jpFJg5U9sGu9ATA
         zUvg==
X-Forwarded-Encrypted: i=1; AJvYcCWHIFxORcFVgcMFdXFPlMxFBgSUKStY1iQUKLc0wB9Ix+xa5IRZV7Zfj4FASN2IUL4V6Ecz9MKQ@vger.kernel.org, AJvYcCWmYTEX26Q+Hgzrkp7owhWrSEdPsx8ytx6OOssmYTK6JLwKn8g3Bhew1g+92uSIEtiO1SC1/6vwyEGYZ5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNl+SPFhrSMDDPMUKohYQCu7spenEmZmcg7SDJnmuMTJR1Tcw
	piGNBx60Xm9Ls5sANqwf6QdV7piC4n5XaMaCuNYvNrGzwPIOf8PZ7+eHrcdvhB2Xpl9zpM08oqU
	6IMr04mGO3EZ4iWdGandC+9RBth2cOIh0J2Ht
X-Gm-Gg: ASbGncseRVZdlzefrYEkiZlaRfpe2NwmIJnuP0mZIw/YhBK/aDdRlDx6AvP4PEO3m7h
	3okmGO8NJN87xZz8LeZ+5w6YcjhzORIh9v/H2Fd4qBCpM5bSHbMWaPDmsaz/Ld+xhwthZgbfjoW
	Kqg/Bob+Z4WFQLGIePX105/pj/W6xwnJh+HA==
X-Google-Smtp-Source: AGHT+IE4A1XRxjveKlRweStMHozjka1jSrZKewno38SO+0w8lawmEziz2A92/CVhErkLuo49FrZNL4er5g8c7tmfbQg=
X-Received: by 2002:a05:6102:3593:b0:4dd:b037:d23f with SMTP id
 ada2fe7eead31-4dfa6bd2eedmr3272891137.15.1747379923929; Fri, 16 May 2025
 00:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Harriet W <wangxianying546@gmail.com>
Date: Fri, 16 May 2025 15:18:32 +0800
X-Gm-Features: AX0GCFtXE2hO2hM04aKOLNwIKDE62wy7lJnxeBWKv9PWDmSettCeegh1O2DpT5I
Message-ID: <CAOU40uA0EXVrZMLA76DErFjT4Op5_JUse_Sv=ncX+dgemiGFTg@mail.gmail.com>
Subject: [BUG] general protection fault in ipv6_renew_options
To: davem@davemloft.net
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

When I test the Linux kernel (commit
0c3836482481200ead7b416ca80c68a29cfdaabd), I encountered a kernel
panic issue related to improper protocol family handling in socket
operations, specifically in the sock_kmalloc(=EF=BC=89function
(net/core/sock.c:2686).

The issue is that the sendmsg() call interprets the accepted TCPv6
socket as a TIPC socket, and the kernel proceeds without validating
the socket's protocol family, leading to access of uninitialized
sk_prot fields.This leads to a null-ptr dereference in sock_kmalloc().

This crash can be triggered by executing the C reproducer for multiple
times.The full crash report is attached to this email. Please feel
free to contact me for additional information or steps to reproduce.

This can be reproduced on:

HEAD commit:

0c3836482481200ead7b416ca80c68a29cfdaabd

report: https://pastebin.com/raw/Fh27JF8p

console output : https://pastebin.com/raw/46Gj5gPm

kernel config : https://pastebin.com/raw/cdj4sjkD

C reproducer : https://pastebin.com/raw/R5AQ1PG4

