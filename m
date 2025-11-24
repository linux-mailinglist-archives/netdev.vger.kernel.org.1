Return-Path: <netdev+bounces-241249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA7C81FF2
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73F534E6FD8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D053176E4;
	Mon, 24 Nov 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHZhVOwe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF328315764
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007210; cv=none; b=qmPk0xZzINhoPWDm6UFjFxekvJkpz+hqvBVRJ3KOuAxtHp4Bk1uIyJm1MjChIJvsR29oyDAem4uLk46hM/RUoswu25aykN3eFJ0GPzDnHNyiFF6Bm5aHmGemhtmTIvKc6TSAt13eaXTtq5Iz9JaVCjB3TRkzWDf70ATtZVLTa6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007210; c=relaxed/simple;
	bh=xeKarZkaklyd3gpxHsuk4C9/ZNiv+OwseAeiICkTRg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egjrOA/m/nxNFq7Ehngf3G5paTr8WD71JOMIDybYvDW2CoJpChZdbkkzm6zpc7UpQHR1d24N4A3hOsFyfkTyrDlQzUHA39K1mlYbJi9bbTQIrBX8YhrGmA2jBsvwv386a1zUg+9+4RAlZr/qF7qXY1Dka/2VhcC1p4Qtv2QWsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHZhVOwe; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so5476231b3a.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764007208; x=1764612008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwc0wEErQjElnL7obMEURy2H0bzgY2YYjZc6h4X9QZE=;
        b=eHZhVOweU3FA/ObZnOxFSKw6bziTB5HuNNnBnnjN3ZUyjp6Dvymj+/Qy6C0UWmKCCb
         voPFInL0v0b7nqOxLl57SX6fXQM2qAczjb23um1E5//v2wBOjoJNNyyXqAlgwkiqd6Vt
         uXPmJd+pe/iSLxoVi2KPFrg1gD5Pbaqi9sVO5T81BTl6FM6KdA6eEcc0VXVFVo4Z5bSL
         UUPzvF16CdLFjl+6fajuBcxOhfJbbaM+9Ty1oX1Ez/An6nGXCX6I/p1ubvHVbogO0+gN
         UZHX/qsPlMqIH6exdPmsbmItNioUCFkFMu1XOJ5xuMsz/JMyYvIq/eGm0wS02pr9l+G3
         h1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764007208; x=1764612008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwc0wEErQjElnL7obMEURy2H0bzgY2YYjZc6h4X9QZE=;
        b=lKGSD13HCsMou/O98jUMkQ+kQPPBIEXbfJf2mL9J16jMPt0VyFWlkkQUtoSE5m3hIg
         ishPIqVJeO9NjPi27KOyx+npaOdeYN6WH+CmMvtggtayc7afosiN5eDctnMljGEAImY+
         2qWreIKiI0bYsUH+d6DRPaTLBs4KB+Yaw+mrpI6eMe1EA3C4alKK1DH4BZzNFpbyYuiQ
         HFZac+qEssMmW57Oyv0NV4sQVzHONYljyKY2fmvvNUXhAZjzCXzL86ah36+TsipzR8oN
         Pj3iTzSJQdXgyzfkFrORreHK/zl7hgGU2nLnbffonJbXQwgjBBswEoJT9u3M4G4Z8E50
         WaDg==
X-Forwarded-Encrypted: i=1; AJvYcCW/x570NLYMulIbkN6vQ0aoM8PI8jtoZHddlHSFUdvKpPe7hhFCozOoZ2HVPMClmytSKTRoXWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+C4ufvJu/zQcyKvaKx+bsTJ4q/prkXogFSsZZOsPrEhW24JYD
	so7YdUeJ2kNQwCnpKRLA6qAvJQJwApMsJdrqhUNV8ocfrbmygxbV+BIq8m7QBT65
X-Gm-Gg: ASbGnctG30w8Dv9vPurGxeol+p/vTsJq9KJYuO9eHOyeLejso59Xz8ExmH7GYstJ2N2
	at9tzgXuEc7ZFzwVpBOH6yK89HP5PbikO1rtNSm75PYVjgTh84OuVjAEXp5xf1WPtGgLG0RmEAS
	WV9jKUDYLJ0kMZtHWhnLgMZJnoqv5RuCJU5uVzwzEznsFF+OFKWqJcXvgTUkDk/wf7N5eOGz4uV
	aMOpY8tPKN9sMSd7xvensWp1uAuIIxuNUpgDRwssO8z2knwNkH1X9CUTCg87FIogDctL44/qxH8
	KuooZRtG43PAlrSu7ZdOOoVltT/y3kWkkd5bz5b0kebaZ/zaA4yAr8haj/BY4k6JQymny5TgCXU
	q0ezpjWYIa5yIKkzjTyQ6z69vK91/jifhlhqB3SM20fZ3S/pjPLEahbFm7Z/zKld5o7IsUBu5Yx
	nyLSSF8OFQIrZ/mXcDwwL2FXa8AjHxiO1hiLCmHCuQ
X-Google-Smtp-Source: AGHT+IER74fvOLSGEfGwFDnZuS4IVDFpU0C2s1EkdQfgEctIUUfm6XcENb38f8Cs/r28V+tnVr0Upw==
X-Received: by 2002:a05:6a20:748d:b0:34e:975:3bb9 with SMTP id adf61e73a8af0-3614edb433bmr13952748637.49.1764007207909;
        Mon, 24 Nov 2025 10:00:07 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm15313120b3a.52.2025.11.24.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:00:07 -0800 (PST)
Date: Mon, 24 Nov 2025 23:29:59 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Xing <kernelxing@tencent.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: initialize char variable to null
Message-ID: <aSSdH58ozNT-zWLM@fedora>
References: <20251124161324.16901-1-ankitkhushwaha.linux@gmail.com>
 <willemdebruijn.kernel.6edcbeb29a45@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.6edcbeb29a45@gmail.com>

On Mon, Nov 24, 2025 at 12:46:52PM -0500, Willem de Bruijn wrote:
> Ankit Khushwaha wrote:
> > char variable in 'so_txtime.c' & 'txtimestamp.c' left uninitilized
> > by when switch default case taken. raises following warning.
> > 
> > 	txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized
> > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > 
> > 	so_txtime.c:210:3: warning: variable 'reason' is used uninitialized
> > 	whenever switch default is taken [-Wsometimes-uninitialized]
> > 
> > initialize these variables to NULL to fix this.
> > 
> > Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> 
> These are false positives as the default branches in both cases exit
> the program with error(..).
> 
> Since we do not observe these in normal kernel compilations: are you
> enabling non-standard warnings?

Hi Willem,

this warning appeared while building the 'tools/testing/selftests/net'
multiple times. 
Cmd used to build
	make -C tools/testing/selftests/net  CC=clang V=1 -j8

while test building by "make -C tools/testing/selftests/ CC=clang V=1
-j8" doesn't raises these warning.

Thanks,
-- Ankit

