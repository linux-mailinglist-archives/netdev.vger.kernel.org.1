Return-Path: <netdev+bounces-152413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FBF9F3DDB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 23:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24380163136
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C71DA0ED;
	Mon, 16 Dec 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LHjUJxnw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79861D9339
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389933; cv=none; b=L+D/skgiTCntXOaeQyAc0XaSvJ80AXQyvpXMVtLDKT+sKCKI3anUGrCkJppzRUZOlRJW54R74su51RGw4VvQ4GuiH9+FDuj6oPcmXSlMCbHzpyutsla+rxrkogBn/03Wr9dA4uC2Cba5M7xdTe9hwyQUEHIrX94kku7Cqm+401k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389933; c=relaxed/simple;
	bh=yO3ABFgaRA6gQLk+jKRulrwSj3yPIlDRR9FUiP+tIUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+nck5hCdp7Gy6gTObWT891TZbN7usezhXVgW8PweElJDaCu1xS+gPp/OPHWWpqFQGQT4UJVC4MWF87XZAjifOE+FjbycvAEfOG2RLXnfe6BCHcNdZFBYL53uCuIcDfj3MQ2ntdek8gS0syiosy7OeUD7YgeDgaMgLv1uJA6IEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LHjUJxnw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2165cb60719so36576945ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734389930; x=1734994730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckzL0oeGyqxBSfgSo+iDPJ0MToAoPZLjRSeCSLdBC4E=;
        b=LHjUJxnww0YcecA/jMMoaWHyV5FeHjwZJN3WXASQPMrZ2AEBzl0Z7RfoKTr/s6G9Wp
         bJPnms5iQ2QsvbuwmKj1rYYr5TecXvMSR+yv//TmubdRSmFUZqCZGDd8jmB2VG2FH65Y
         qroJILftfQyXKP1v1FHtQ+GAuVlSHVpu4bzJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734389930; x=1734994730;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckzL0oeGyqxBSfgSo+iDPJ0MToAoPZLjRSeCSLdBC4E=;
        b=SE93pDkLgmzU4Ts7kCud67GSfqUYeZ49Akcw8inmZKxvBc4Il3ef6FnWSzn/AW3vZ4
         a5BuhgRkIC3rvTMU5PT01FJwqi1Z5Ecr3f6rnIBX2L2lJNcpovujpHcJ5puTttc2ijFh
         yofWZTmBT24KNm2NCrMu11Es1/Jz5EGzEFoycA3SZEICFM9RZpSKpa8HdSppvAt98S7w
         5RjBup8uxjrUn23by2DZP6hOiMcvaUWmXdWM/rZM50yoh8LGrmTIRNrZerYdLP4g/f0r
         tjqWkojTclaSw9podsBDCFETgxc31i4v32NxEyA7CFCoQjwCiqqDHtoQJJkLkfcubNCR
         SUtw==
X-Forwarded-Encrypted: i=1; AJvYcCUYtbU2k3xCbjYkF6LyEzEjhewhSBIjzp7vQn+apONhJgb5onBa1cCMVXgZRYOP2I8fatOONGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmTIJpmThGe3Voyd+m+PiDu7WoK5Z908YxEJ5+tqDe3NOd3DK
	RJtNDB2f5wPTT40Ap1dvoTXily2Gc+ple4Sd1XYytSrESTZOgcRKPVaKegrmSoY=
X-Gm-Gg: ASbGnctXvLXyOcu4J00vi8XZ1C07Gzf9pMSKvR4EGTMM0qLaQPecmiUdkj0NJxJqa5E
	Az03MbdstozSsbW+58Q+XcQCxsXdE0PsxtbiDykNmhCdm6dC9+i9Gbq6bltZa4TaSPGYZV7d6Rm
	XqWHdoLbHVE25lqP5+aqQklOKfjsjG51yVIXQfjQfqzTPSoXbpGXlytiTQY6AkNrEREk9k+a47y
	rRJWsvvB+fCkoEh4OQu3kyJl8TcsrF1lfpzde/2yom0xrTFtzqpB1qspj16W7FZH4En5IOMFm6i
	uVhbs7+vDGSF7gs3I9nF2Uw=
X-Google-Smtp-Source: AGHT+IEhS4a23hLc5yRiE+reTRzwxEtxicFqcw6AdK1K55/wi9yfudPn2pEhLuYgK40BExGRzrx28w==
X-Received: by 2002:a17:903:1788:b0:212:4aec:f646 with SMTP id d9443c01a7336-218929e88fdmr186237555ad.33.1734389930253;
        Mon, 16 Dec 2024 14:58:50 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e4ffd9sm48022275ad.142.2024.12.16.14.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 14:58:49 -0800 (PST)
Date: Mon, 16 Dec 2024 14:58:47 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, stfomichev@gmail.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tools: ynl: add main install target
Message-ID: <Z2Cwp2Qbbodl3x48@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com,
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1734345017.git.jstancek@redhat.com>
 <6e41a47b9ea5ede099d9ae7768fbceb553c6614d.1734345017.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e41a47b9ea5ede099d9ae7768fbceb553c6614d.1734345017.git.jstancek@redhat.com>

On Mon, Dec 16, 2024 at 11:41:44AM +0100, Jan Stancek wrote:
> This will install C library, specs, rsts and pyynl. The initial
> structure is:
> 
> 	$ mkdir /tmp/myroot
> 	$ make DESTDIR=/tmp/myroot install
> 
> 	/usr
> 	/usr/lib64
> 	/usr/lib64/libynl.a
> 	/usr/lib/python3.XX/site-packages/pyynl/*
> 	/usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
> 	/usr/bin
> 	/usr/bin/ynl
> 	/usr/bin/ynl-ethtool
> 	/usr/bin/ynl-gen-c
> 	/usr/bin/ynl-gen-rst
>         /usr/include/ynl/*.h

[...]

Thanks for including the headers and doing all of this work.

I tested this on my machine using one of the sample C files and it
seemed to work:

mkdir -p /tmp/myroot/local-inc/linux
make DESTDIR=/tmp/myroot -C tools/net/ynl/ install
cp /usr/src/linux-headers-`uname -r`/include/uapi/linux/netdev.h \
   /tmp/myroot/local-inc/linux
cp tools/net/ynl/samples/netdev.c  /tmp/

cd /tmp
gcc -I./myroot/local-inc/ -I myroot/usr/include/ynl/ -o netdev netdev.c -L/tmp/myroot/usr/lib64/ -lynl

./netdev
Select ifc ($ifindex; or 0 = dump; or -2 ntf check):

Reviewed-by: Joe Damato <jdamato@fastly.com>

