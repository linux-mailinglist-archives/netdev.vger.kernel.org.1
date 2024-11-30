Return-Path: <netdev+bounces-147933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB99DF358
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2156B21405
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85D1A7045;
	Sat, 30 Nov 2024 21:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/nQ1t2t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7F8468
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733003226; cv=none; b=cIMJgIAXqMopG37eabd11McXyqgyn6bZBaItIcmvRBWUl2O/rRvirvW2sfdg0jUqe+SY7HBU9JqS+rP/srnysO0wt34M061MeOJln6JiDiO8O1J/ge0xayuIl9Pa1tCjJb/bqGHn756XdhwTnZ/vN+rghrWkgzX5/OPZduYbXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733003226; c=relaxed/simple;
	bh=pwoO4P+jE5ifsI7F3+iHmGYobwkIH9KAVe1vH7VY8wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eth/44yZ9fSI0Mq9qQQLVyleS7ZVQMU6JXMAVZ4+cJorWk7XFuAlTNvhjgda9TXy9jc1GxRrHokgTRZLcN9Dtl9Yv9BWuzGhs8vlNj6DXjno8W2IGdOtTZrDZzLyR6x9fcapyXFuyQZBZbCKMRauepRy7ppzWPIMmCE5qDdMiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/nQ1t2t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7252fba4de1so2602637b3a.0
        for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 13:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733003224; x=1733608024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4nWP2xcJV4E/fnKVDcn+i9fI2h/7DdvD6CmO39VfkA=;
        b=i/nQ1t2tFcVZqGlWkRYPWbeEo60OPGRaUg9dZkwD/LCk1BBteYQZE8Es8ZRcJ/GLXB
         ItDqQER0VPBdGD3J3xBB9rSd5TLQ4I7lgeFHKbAcAtQtPRsTlNvXXsZUVmcm/8Xuplrv
         dHeM/o3OHRiu1WRxOqVonRAPeex05xo071Y5hZIB5/s65QCyz5Dgz0u2rstobtpamEtp
         nHYCwn440ZoueNvIY0Y9xabdnoWvP1JDyrLDjkr/eHIL5fNhIAVui9+ijjTaYbqVj5rw
         IufPOBHcJc92n9Ec7zhuWpBN9fzsWv2J9f9hNafqE828pwVkXfMsBgbU+9WMELjsm/W+
         SaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733003224; x=1733608024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4nWP2xcJV4E/fnKVDcn+i9fI2h/7DdvD6CmO39VfkA=;
        b=CzQUBGfU3bYmIoxYzYru7lEwtPZTA/r2ofyv1hA2za17xAf9MLivu2kzm5Aibadxi7
         qeXw/gbvGh01Oyh9z9eigL3zS1XSEBmpMsJ6ugdXtBHb3J3EPKOjcfQMYezRN7ue0FQN
         hEToP9whAxCoHydEwhnlPs6PXVL1FoDcYwujKoYPMQKxu6o6BgoWL/+cXWtwhVItY+2q
         HFn0N8uGAo2ftqAG8zoreicQm0RPXequswgcpe6bOKKtQH76JnJo3ZDdNDEphH2hPmAw
         XuJaUgU+bGiYJE8TPp8UUU86kFbmZB0I1Y4lcNGdzJUa1KR8SHvC9rQ0ZReBAmEsbH59
         2u8Q==
X-Gm-Message-State: AOJu0Yxo9tBbSvXtD1fCG3USmktrAod0cemC5jrsQCr5AcS2UnQ9Tc81
	I2JMvauHZ5feVPS0oqskUcPM2CSGFiwgAJNB0nNokbwxh372q7jGPlmTdQ==
X-Gm-Gg: ASbGncvRdiTw6FWfYJ2SZnnpLbkm7C7AQEgA20xGOvAOxa58pDyunrLPtfRKfmY5z52
	v1MSXxoEOj9f12VHUiGBscXOlO1gbpzfrrBOjdbpi9CD4qu1fPReqrKvWye1akgmn1e9r8srO3b
	HT5n91J9c6FvXZVzw7mfjvrOpqVPi7BU6y9MQGYNRLNoz7rePISpbc1orZSQMHMvF44HSrRr7vp
	O6XdP39Jtr2FcihPOX3x9Avf1jpn7bZ8tB0D4grLPCHOgqq3tAomTq80tGn8wWh9bJHqA==
X-Google-Smtp-Source: AGHT+IEz86dQ7/IxujzGjGWxMVXkuCulAy5yXTIqp4iimya4/PGidH/pn/w8hHvd0iXGaRLCCKxUMA==
X-Received: by 2002:a05:6a00:4b11:b0:71e:3b8:666b with SMTP id d2e1a72fcca58-725300666d7mr21094013b3a.15.1733003224405;
        Sat, 30 Nov 2024 13:47:04 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725418148bfsm5635869b3a.164.2024.11.30.13.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 13:47:03 -0800 (PST)
Date: Sat, 30 Nov 2024 13:47:02 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: list PTP drivers under networking
Message-ID: <Z0uH1j5fpeF3MYH3@hoboy.vegasvil.org>
References: <20241130214100.125325-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130214100.125325-1-kuba@kernel.org>

On Sat, Nov 30, 2024 at 01:41:00PM -0800, Jakub Kicinski wrote:
> PTP patches go via the netdev trees, add drivers/ptp/ to the networking
> entry so that get_maintainer.pl --scm lists those trees above Linus's
> tree.
> 
> Thanks to the real entry using drivers/ptp/* the original entry will
> still be considered more specific / higher prio.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thank you, Jakub!

Acked-by: Richard Cochran <richardcochran@gmail.com>

