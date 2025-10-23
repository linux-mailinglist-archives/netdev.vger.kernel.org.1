Return-Path: <netdev+bounces-232264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A6BC0386D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96D53A2FAE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61F261B9C;
	Thu, 23 Oct 2025 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdWgpEOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A591DB375
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254727; cv=none; b=XitDaEz0J1o1bWOYY+dlNkm99W9CjiIovl3UwKzTBLnTFTqeD2su2UpValarPpvCbyvizf/XEWoXM9gaZimndXgDE3aowHBBN9RL7qc5AqZhNMZbqEiW63DqW/kHJ/d59gsySTUm8hUIRvDXU9Z+zNafw+koJ/CCx2gpLUNIbms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254727; c=relaxed/simple;
	bh=KL8MH4uiDwXzDJGJgKqg6xWOMUxs8dFvLHB+r+h12q0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cVxCu/gVYj5mWFOsUW6EdQyLudaEoPB2/Kaob72FyhVv6RnnYNc4iejL2X7uZheIR57mdIsQVPngaJytYStXV+AIdfzlBLmpejMPaL+VfdDfd2UsE7H0R+sCD3SW1ei1bzdex/AqIf9+XaZOidfS8M9hYZstE+5IvEVGq1e1dQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdWgpEOm; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88e51cf965dso176611385a.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761254725; x=1761859525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yD8t7GPMvKAHRGElvreZlEBxLi862Pnc19yFSqIvIB0=;
        b=HdWgpEOm7uC8E+e081VqSRQhEyLjRMPaJXjYnGgyPrGgXJAEg1nV3t0+EiceqYrSGI
         AbeAbMs7fA+UZyBY80l3AWlbqPGUPI6ZC6e9Mvv4IBZ5LfPc426voxNmd64LCSCL1t2A
         9He2FDXCB3UtldxQtBepWc7Hw0LGpi6qlgIoA5kdFIkDsU5jFgu33Plyw8ALKOD+6P6b
         PzDykNKkH/xL1evMOGXYK4z34qKxGTBn3n4EUOuQ7nsvnKTBoMGmGXauKWHRe8o7YfQI
         GhH3KHX2UE7vv+afZZ61ztVmqxN18Q6FevLa8bX66pt5DJe85Sm70PQ0PXccjGefkhkr
         yTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761254725; x=1761859525;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yD8t7GPMvKAHRGElvreZlEBxLi862Pnc19yFSqIvIB0=;
        b=c8fti4eJcZpn9iUOT5j43ugMrgW98XSHeZ3DYJTGy2IuDa/ceQxxHiywxdpzCEpfIf
         Puvk6Zub9QurhQ+iyHeWALtJcGoLZPFbQtEx9lDsmMrOEvQ6+453WYcz4dBWtgN/AA14
         pILX3Xeml4yNZeK4qyhNTcKUAbsW6wqtLrc46lAoE4cynhHBSbzTgitqjGsdsOFqIf8d
         /cYskJNkf0Ji8K130IhdWWn/4QqEomFK01ubS2680bCIeZCxJtL6bK7xnbaUE9DBDMR3
         KCPoBNS+uzl63REDMEtR2Q5w4ORkbEtZe2jBKWtvu6j7/dRW3+4H9wX3CrckzNc8o8WI
         bs4A==
X-Gm-Message-State: AOJu0YwcX3tW/9u+6BBuOLkTPJnkb6y0qCcWD0uxbXEsgFcBnjDmq5lz
	EmxsSA58DyZbfuNdY+DMbq526vcG8x+kjYhoTmbbKEGzFyT1Qywm6KMZ
X-Gm-Gg: ASbGncvfaDdyVpUC3+/OlLcucXBs/Ie8wovw1ygq7SlSdberAFy7nXTKDnsECf4fDlp
	wkW7GuhfDfa9ZJu7Y9LIxUm7RqNWxVLPigzcX5PjSvYtrwNzVFuJyZVFVIokQd2XSG+RT/8R0Hm
	csgJs/JGT05PPMhHU+CD5V3PsLBzWDDwBwP5H3QCHAk1YTn9FhN7QreIy1E04A6j12j2LNDeo9L
	BnJpGrCu6M8AJ8AmWqBmQ7C/Rle5R0IqXDBYJC6Az9RFTKp2WhrvNzj30tcZJYBWcTjAIvZi5Hu
	kpcE0LkJI2Z3bR6b/HXMxYYXdyEhwjWa62mYaEUnUBvmnYXigbHKOAqWMagUs5d/9FlZA+2FDzN
	z0LrUEcgpEzKBY2q2WitlyL8+gtwplGqiNt2W3TRJskRMmVEybQs7zHTgGKGvw8gQoCrs8Fp3iw
	fFw8W7UqXpIpYUgLs5AGFJZihyhXT43qQN6fFoeZ6sxo9QNugqDZei
X-Google-Smtp-Source: AGHT+IE+/hzS/vGrRzSKQdGSR4NcId7rk/TeVbgs5eLd/tk8OY8lA1rMAVBrA+H0+CV7kdHxkJVMxQ==
X-Received: by 2002:a05:620a:f04:b0:85f:89:e116 with SMTP id af79cd13be357-8906e2d040cmr3479556385a.1.1761254724853;
        Thu, 23 Oct 2025 14:25:24 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-89c0dbcb6b8sm239229785a.13.2025.10.23.14.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:25:24 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:25:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 horms@kernel.org, 
 dsahern@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 daniel@iogearbox.net, 
 fw@strlen.de, 
 ishaangandhi@gmail.com, 
 rbonica@juniper.net, 
 tom@herbertland.com
Message-ID: <willemdebruijn.kernel.2fa37d812e711@gmail.com>
In-Reply-To: <aPpMItF35gwpgzZx@shredder>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022065349.434123-4-idosch@nvidia.com>
 <willemdebruijn.kernel.2a6712077e40c@gmail.com>
 <aPpMItF35gwpgzZx@shredder>
Subject: Re: [PATCH net-next 3/3] selftests: traceroute: Add ICMP extensions
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Wed, Oct 22, 2025 at 06:12:13PM -0400, Willem de Bruijn wrote:
> > Ido Schimmel wrote:
> > > Test that ICMP extensions are reported correctly when enabled and not
> > > reported when disabled. Test both IPv4 and IPv6 and using different
> > > packet sizes, to make sure trimming / padding works correctly.
> > > 
> > > Disable ICMP rate limiting (defaults to 1 per-second per-target) so that
> > > the kernel will always generate ICMP errors when needed.
> > 
> > This reminds me that when I added SOL_IP/IP_RECVERR_4884, the selftest
> > was not integrated into kselftests. Commit eba75c587e81 points to
> > 
> > https://github.com/wdebruij/kerneltools/blob/master/tests/recv_icmp_v2.c
> > 
> > It might be useful to verify that the kernel recv path that parses
> > RFC 4884 compliant ICMP messages correctly handles these RFC 4884
> > messages.
> 
> FYI, I just ran this test with this series and it seems fine:
> 
> # sysctl -wq net.ipv4.icmp_errors_extension_mask=0x0
> # sysctl -wq net.ipv6.icmp.errors_extension_mask=0x0
> # ./recv_icmp_v2 
> 
> TEST(10, 0, 0)
> len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)
> 
> TEST(10, 41, 31)
> len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)
> 
> TEST(2, 0, 0)
> len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)
> 
> TEST(2, 0, 26)
> len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)
> OK
> # echo $?
> 0
> # sysctl -wq net.ipv4.icmp_errors_extension_mask=0x1
> # sysctl -wq net.ipv6.icmp.errors_extension_mask=0x1
> # ./recv_icmp_v2 
> 
> TEST(10, 0, 0)
> len=0 ee_info=0x10000000, ee_data=0x0 rfc4884=(0, 0x0, 0)
> 
> TEST(10, 41, 31)
> len=0 ee_info=0x10000000, ee_data=0x50 rfc4884=(80, 0x0, 0)
> 
> TEST(2, 0, 0)
> len=0 ee_info=0x0, ee_data=0x0 rfc4884=(0, 0x0, 0)
> 
> TEST(2, 0, 26)
> len=0 ee_info=0x0, ee_data=0x64 rfc4884=(100, 0x0, 0)
> OK
> # echo $?
> 0
> 
> When the extensions are enabled and the RFC4884 socket options are used,
> the offset to the extension structure relative to the beginning of the
> UDP payload seems correct. In both cases the "original datagram" field
> is 128 and if we remove the size of the headers from it we get the
> offset to the extension structure:
> 
> IPv4: 128 - ipv4_hdr - udp_hdr = 128 - 20 - 8 = 100
> IPv6: 128 - ipv6_hdr - udp_hdr = 128 - 40 - 8 = 80
> 
> In both cases SO_EE_RFC4884_FLAG_INVALID is not set.

Oh excellent. Thanks for running that.

