Return-Path: <netdev+bounces-68235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA919846445
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BD01C233ED
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 23:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E103D960;
	Thu,  1 Feb 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYBfaUfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE747F5C
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828717; cv=none; b=BeNUBamdy97R4mO/F/aeXC/LpAWcG9DNH39W+ecvLHBfXW1V/TF1XQTfRygBuQrj9iuW/fGqqYQ6KFQ7LLfDDJ2UYIj+L5ErmXBo/C8SUl4HmwpUyXsn2cHjXMOBjjC/TLmjTLuw6pdlhdA2SUtHecT9Wa4d161ESIOiDGSAJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828717; c=relaxed/simple;
	bh=jZKZvywDdddnNc4X6eFsCo4m8AqAV5RIFRVFMF99TIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIQ/GBaDbOrAomeN7U+14X4IHMvrPEaH4Bw7Mk8bqaWTDs5iGuRO/dC6dqhhEn/Acrod1lkwExWxc803XI0pzYw+dQ2gGXrQ+DNGOARHrfUCkHFqBCTXRwMlGcNyZOWkEYNTHxivhAvkrxqsiyVk56Jh5yXM4uALkK24oMgndF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYBfaUfh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51124d43943so2319177e87.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706828714; x=1707433514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZKZvywDdddnNc4X6eFsCo4m8AqAV5RIFRVFMF99TIA=;
        b=nYBfaUfhStJWW6taTdnkREIAfp82cb3pQGGm6hpwv0hI694Vbfpp4pV5Lhu4zB+5G+
         cFPp92ltZe/18oyrHcJ/u2+Jl+Xx8cUh+5XwMJL001SByLT0XIfVSzSziqVd7e2M2NmZ
         txDNFW2YOmJMDYIW9N6HlsfXa+318o1D+8FlBqoh4PuuCwcWho1Zz0ZQk+v9bBslPbZX
         9HnPqRhIL3OkcM0qsKnyQtw3jU++61pbskYCMNfG3ywaz3K4uObg8VK2Duo01I3o/F55
         XzKduHQ9jdaYOtFC/21uSVnN07j78p7mAi0n6PkoeIHv+moZr/oEc97jpyKshf49ei5p
         V6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706828714; x=1707433514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZKZvywDdddnNc4X6eFsCo4m8AqAV5RIFRVFMF99TIA=;
        b=YIIDRQIehK6R+oGV58Tb/Qg70hkyF4ze/WEZsjZcVDe+3KuCfZ2Xz0PxkiHl+GLbkz
         341YQE+5+UP5ecSTZ8ZQtx1/hhU/tFRGWjwOR1Mq6ibw9UlXUkyGkl8+r6AKm9RVO5OT
         NwcQPpiRLNiCgv207f0J4YX8VkvuxrUVMxcQ4tambNQ4KYD9QerIjXW/mCoQWc5lpIt9
         RYVfsKW+6CMBfGkD0afKHAxBV0i55/Yzpw7SBO+uaZIgV7cd8zcp4y/Ztj7XgKF0yTQc
         wJGBurkkMn7ZMTp9cpI73jJrN0zFQyB1cn5PZEgbCfqC3EBe9afIMADm76bUms2oVjnX
         2NjQ==
X-Gm-Message-State: AOJu0Yy8Rk94mY2+TEYcLuldYuiv1n79g4/YGn426MpkaH81SeQL7X53
	DBa5iBSteRPinPu0qqr3JH6Anz94/1veWoos3q9I72fXIKzx//EG
X-Google-Smtp-Source: AGHT+IHj8ayAivmzIWhPgLKluZGh0MAju091b00svwcv2bw87f3M8xRCUg1w2etV7RUgmLJcJ4ENWg==
X-Received: by 2002:a05:6512:32a4:b0:511:31fa:cb17 with SMTP id q4-20020a05651232a400b0051131facb17mr238175lfe.27.1706828713583;
        Thu, 01 Feb 2024 15:05:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPNzPR8alnWCjwsvxmGFPvK+sif6SYCCRH2kIiCxjLVW4VqRvoTSXpBmiQJmTPw/iL6qH702eppOH07iHqo6nnsAfPVbtljNCrNjGF1QVVvFvMrkRQZ5bhgtD6R1mqLga3yLZGBbOPEKSFNn3NVDT/iX9xTMBBVO3BJXs/OYpbt+2U8KKbn2frXb7dhrZSNX/xwq1AG4eKCTlYuYquNG+THJOO7Yqm3ZkzjiM6EW2ZJyVwfrd+bhLJhvaL/dgHtw0IxhBUWdd9hjjOYLE1uyzbxPQKl8yiEHMVuDORC6pXUcA0RpdklaYMr0yvzkuqHHqOooWJPaSfnQVC47v2zK4=
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id hu21-20020a170907a09500b00a34b15c5cedsm244261ejc.170.2024.02.01.15.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 15:05:13 -0800 (PST)
Date: Fri, 2 Feb 2024 01:05:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH 11/11] net: dsa: realtek: embed dsa_switch into
 realtek_priv
Message-ID: <20240201230511.iznisjslqbcnohsc@skbuf>
References: <20240123214420.25716-1-luizluca@gmail.com>
 <20240123214420.25716-12-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123214420.25716-12-luizluca@gmail.com>

On Tue, Jan 23, 2024 at 06:44:19PM -0300, Luiz Angelo Daros de Luca wrote:
> To eliminate the need for a second memory allocation for dsa_switch, it
> has been embedded within realtek_priv.

Ah, I forgot. Be consistent in the use of the imperative mood for
describing the change throughout the patchset.

