Return-Path: <netdev+bounces-128430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F80F97983D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19525281FC4
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B5F1C9DD7;
	Sun, 15 Sep 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V93MBX16"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DA1DFED;
	Sun, 15 Sep 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426126; cv=none; b=JGrY2uPLcekSvh8zLj0EQgLwzWS5TPLhx2LtH6vj+ogZZNejV1IBZ0oNNFK/ch/AJGsJA32NgiOsUfyFrB9mnE0af4FIcBRBPOIgjXV4G57jbzixbHoKMWJkQPzp3v/G4pKmiByICT3zmXI5YAaZaLBO8vfutjCW9DoOpr3xpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426126; c=relaxed/simple;
	bh=bsJbX4ieVW4CGM0QopTmsniea6/pQU0izC0dMsrHiR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4P4iU72F3rWe2p4fJp6Bhcwr1/uWOuw9g3z5cd44uAXWek01WCrlQRXYgowScL1U6dT1IZMkY6Dcz7RyUIOq3rwS8VSWT/yrvnPnOG6Ak5UWgzHmJoyIJDMaH4OZ8+hozsc98y2B2GtJMUCaTXwxtUg4ruiguiLC+Nh55wps0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V93MBX16; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so37045925e9.1;
        Sun, 15 Sep 2024 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726426123; x=1727030923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBqTfSE8074Wil/Ykbh3vaWKrUQT3VfRlf6Q1bjSdGw=;
        b=V93MBX16yrbNIUqq+THxCLUdR8tVuu45BdvC4YRtpB80FK7SXvMQ17/WsVwd9C1543
         APbFrAZiZmyvQZMleWIWhYhJPtBeXlqCGirDoVk2hFIiD6q4KEoCKCkGhANl/f9mCwBq
         g+ljq6Toko5kurKtHCGpK51x5yw5sSOzHp/Jb+qG9n815eGQDrXaffqcEnNfgsYHLgyN
         BpRV7DmA3pJmXIu2kx1ttsFfzTdQkeWZZyNR+TsWSlUKMbbGTeolgOai0SqzwKPCpbUi
         h7WFDRHjd9bccvRWtG81WA91BbENowmYaA2g5XX+FzB7DOvM5q8APOoBGZamyLKv0duE
         Uf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726426123; x=1727030923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBqTfSE8074Wil/Ykbh3vaWKrUQT3VfRlf6Q1bjSdGw=;
        b=ntdvsCpHmCN8OP7QlhVfxma33tvfQKCuduL0bC27DcwWyANrEhVvNTcU5Gle4c/Ci8
         MfRC1avZ73l7XRB/3iKbD5BQGKiGNHH0VlAN7J5kiLva1PHYnnfSBTkPEJkYFO6CM7CM
         1//inSDYgIYgb/wpL/Y+4yJYmjwcpM/mALTi8wOMmHduqkw/6ySm5ns+jbwlIux3has8
         UMxGuOjSDHqCtVo5wWNAgALEjBDfp1K4jWk6dVnh9B/OO0FQ6K9USqbL3qK4JY0dv1Gm
         icv24+CbZFQhlJsw6NSnxkQXT/G8Pf7PyrBTJ5TAZxHpi06fFV0PsoGEESBVWSYrAjQX
         C/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUJWL72uflklzilH5dt8ePdylm2lv3RqAOYq+6L5UF/x8GhlJ8gtpFfUniVIzSLn1qNRPoxGRwP@vger.kernel.org, AJvYcCW6aQ12vOQA8LfI4OvvZ20O248MljjyE24OiMkCcMERxPGwLr/GkNvzqxGYdKzzkcCnPAPlCNhOO8Ykp6ZX@vger.kernel.org, AJvYcCWDSNaYNqhLH7Dfdszf7kCjwRQL2TUi2OS1Ay3LgiAL07Ed47VEKviAo6FlBOZ8k+wPqjQ2Rcs8PLewGMo0Veo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcclwXT+8veFtjR4KRdQJoRWWMH5HUYvzM3OWdWuUNMqy47ID
	P6xJnrlrZJHsysfcheiD5K+bSc9RF8sVHxkpQ1cCb5t195xPLfa2
X-Google-Smtp-Source: AGHT+IFveZ14ySmpBcJApjM4s85GFRTC60yZ5ipmF1JeEy8FsH5EuZSx0bo/CBMZ8kpdGPGbH5ew3w==
X-Received: by 2002:a05:600c:1c29:b0:42c:bd27:4be4 with SMTP id 5b1f17b1804b1-42cdb531e7emr89981745e9.8.1726426122505;
        Sun, 15 Sep 2024 11:48:42 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da24214bcsm55148825e9.31.2024.09.15.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 11:48:42 -0700 (PDT)
Date: Sun, 15 Sep 2024 21:48:39 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] fsl/fman: Fix a typo
Message-ID: <ZucsBz7Gok1430HT@void.void>
References: <20240915121655.103316-1-algonell@gmail.com>
 <20240915192405.5b41145d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915192405.5b41145d@kernel.org>

On Sun, Sep 15, 2024 at 07:24:05PM +0200, Jakub Kicinski wrote:
> On Sun, 15 Sep 2024 15:16:55 +0300 Andrew Kreimer wrote:
> > Fix a typo in comments.
> 
> Hi! please repost any cleanups for net/ or drivers/net in two weeks.
> We only accept bug fixes during the merge window.

My bad.

