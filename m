Return-Path: <netdev+bounces-103842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0DD909D8D
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1381C214FA
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005916D4E9;
	Sun, 16 Jun 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkQCdpNj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781168F54
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718541990; cv=none; b=Tr/RaHDVBUNw54TYbmaQKbE0jB2IqN8Dm4Y3qYO/EXq5SBIfdV7dAnpD+sSs3CjkaVB0tX9roGTyN2xbCEOlfbn+TNdXsU4JLFfZWzUNEFezR8jc2L+parOENcpF2PDeWBGnowbw9x5MLgxQTJTf+CRDJKbjSYbWToyQMuJatto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718541990; c=relaxed/simple;
	bh=f29fGqQdbgRm8ZEH+gjoCXM6qfTeOcvsgfr8P/M2veY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pH1UTetS4/GmYMKlFAv1i2gWK5nvtGuZ5ppCPfdWulfoMfuPW+hA3ob8U+UEzzEFptxHN9X6j7YC9XzAQsNfxOYFIf29dl4dOkvAIgRRidzlXAOYE8sNwmUkwLkEh3buxAiBwZ7F6yM/RitJLamJaVpv1XkSBETlZf0MmiGAW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkQCdpNj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e9a52a302dso179182a12.1
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718541989; x=1719146789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f29fGqQdbgRm8ZEH+gjoCXM6qfTeOcvsgfr8P/M2veY=;
        b=UkQCdpNjwiHEAx+8AQ9/x9qmwPP9Wg1mqeOHFJc1OVHMyYiY8MclC2X5cJVWWja5wi
         mx7l9WmB7TVFOPZVKB86WG2bsvOvzHnWytCw89Zwxp6JU8oRUKnNBzviNnrb9uzu/kdW
         GXS2FEi8QY5L1erltdckk5+F9wDy9NVftiifSdh7YYu8jNy1F9AL+uhACxXP/KDxwYkF
         K+XtLXs34bTr2jta63uGMaQ0NFxs4QnnbuunUdTHWQQP5Ao5BcNNTFn1ZhjkY1vHyLeF
         nstw9kY9Agvd7VPE0h6U66tOCXR9iChZmBtchk06wBJZmq8JJEHS7SHRI4zalRtJAyO3
         0jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718541989; x=1719146789;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f29fGqQdbgRm8ZEH+gjoCXM6qfTeOcvsgfr8P/M2veY=;
        b=JyYipK89d6dsykcahIdGeNLJ/+I6ws/ywgxma9wjvAikEUgHdsaaCIUUF8WOXI779i
         zFXi0PpEjyGLjzF65+683rbSg4ec89SwcpJuXqh/OB7unFa9LXej0q/k2be2JzNATp6R
         +tgrZ2m/aupzOFdNXyt5FqVCI4Ll+CUMpCpQ7Sf1Y8DYU9aex2fQvC3Vl0qSMv9H3hFO
         6qjMAm18z6aKl4roTnq7dWXkx+B6aWk2KpbbcsKyxJvaqib99Zkfd+A8bj74cp6x/tB3
         xnPcIP/VIuD3tNeLYkBnbS4yMZ8xOz4P/BwisTCNLM02aNdGAkw8aM7z6hhztUwDvoHP
         VOhg==
X-Forwarded-Encrypted: i=1; AJvYcCVzOkAaAMwiD+ZugRBAsVW1BeMx6tLcRKpXNP/maVe2XXsEBeeb8JCiBSBZ8p7ldOI34OIfBEN/ordEAO+bZIrvv3jiMcdI
X-Gm-Message-State: AOJu0YzSq3yYhD8sLc1wRtuinplcVs92+r9epMsbRNvZlRgF//ACIo6G
	rXXV0D3gSBkUfN7U2RiG6kRev8SBvVCSBrcAOaym2fdRJFOrQ6CL
X-Google-Smtp-Source: AGHT+IEpsWb86cziWfH+QonsgToHfV+W8jHL+/ZKfZ3s7yn2ONl7NUPFh394C6S9VEDw8YYPrBk5bQ==
X-Received: by 2002:a05:6a20:da98:b0:1ba:f7a6:ed61 with SMTP id adf61e73a8af0-1baf7a6f430mr5653516637.6.1718541988555;
        Sun, 16 Jun 2024 05:46:28 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96752fsm5872093b3a.50.2024.06.16.05.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 05:46:28 -0700 (PDT)
Date: Sun, 16 Jun 2024 21:46:22 +0900 (JST)
Message-Id: <20240616.214622.1129224628661848031.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: hfdevel@gmx.net, fujita.tomonori@gmail.com, kuba@kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <00d00a1c-2a78-4b7d-815d-8977fb4795be@lunn.ch>
References: <20240615.180209.1799432003527929919.fujita.tomonori@gmail.com>
	<2f9cf951-f357-402c-9da7-77276a9a6a63@gmx.net>
	<00d00a1c-2a78-4b7d-815d-8977fb4795be@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 15 Jun 2024 20:33:04 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> I did wounder if calculating the value as needed would be any
> slower/faster than doing a table access. Doing arithmetic is very
> cheap compared to a cache miss for a table lookup. Something which
> could be bench marked and optimised later.

Indeed, that might be faster. I'll drop the table in the next
version. I'll put that experiment on my to-do list.

