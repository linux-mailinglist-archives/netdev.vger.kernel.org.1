Return-Path: <netdev+bounces-139488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3B9B2D39
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BFE1F21E2C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2051D54E9;
	Mon, 28 Oct 2024 10:46:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CA1D54C5;
	Mon, 28 Oct 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112364; cv=none; b=MbJDdzNEg5N+0qtj6uywX8Omj3fkMmLnVMTd5JD05QMeS0I1arPtFTr3WVQpPHkAdfyr+BqbYv65dPUgtATTyjIDkq2HUNnndDFy++CUMBTlRYcl9TnQuDkSW+6ZZzhRIZm6jkuiT2t172Wto99yQRo5dbRJZN5Tceqdq3+eYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112364; c=relaxed/simple;
	bh=il0DE5lv1B54yAwfuGnLWuQOFFU7r9KcV+4D0CqjDHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzAMH/vibi2i/7GGqiYK7AOCqv43rwguPKZ2mNt8y3kaKR2AKViZKyRAuqFXkBdtrLgcuDq02mF4+o1mjsM89MDkZ7li2y2FyKU4qJf99YVhvTO6JONnCd4e2kkFfsfqCQtYAUSKHl64hWIVPu/sX46yvZcjPq8zG4JybokWMnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso512447666b.3;
        Mon, 28 Oct 2024 03:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730112361; x=1730717161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1BjVKSO8I+x3GaiJSREYnWx2OchEwLaQshYFwa4DTI=;
        b=usbDzO+kz2kdRM0iDwm7Y5DkmZYfpeUJJeSPMYgp1IsUIAaS2FF8hMTWVbSfn2U38u
         zo0vAOyd2fbF/xy/hhYGhU305bDLxZ0GYVYwHBYLdzbjfSnz5lg5t9iOiO0tFvH8a9T0
         4A5LtYLjd/RUWiGm6zHKFG0+w4cUmz3l6ut55Vn0vH+Ch8Cp3DQTJTFl+Exnt9N/RlZY
         LbKXmAG1ufuTZ8I2ucQ87u2zKsmjcJFnETh3WWi3OwcNHBR5qpdbNuv7p0G1obye8Giz
         9EKc/oww7y/Uj6Xzi6DgloyQGe/MXr4GBHqq2Q/5WZPrAnpneLQ6ccaA666QXik61eUT
         mDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3mfQwHvaXEwbykk28QclmBaQhuzEloOaaP1acy5SGcdcuM7z3XoXzy8ypTZBehnyR+tT3K5VJP0Y=@vger.kernel.org, AJvYcCU8l52A6QdHDN5A6enIXT86NG2iWQrl+cq57YZDTpakZAxZudTZ82I4CVgKJZW2IUGd/M1AzFDS@vger.kernel.org, AJvYcCWV0BwjfSu7zVepDA6CGmoPKyS7KJPpy9AGc8eeKE05CVPdr0BH7j1UuuklnWbmq6z54fJt3pMa1JHogPWJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyoGCicQiLhIsvQ8EaGGrRR1TUWE7azRpCjMWRGGYpi5QyL94pa
	cciwVaFtVMvlUw6zn+PtV5PPje9aHFKyYyzEVjfhU8zWWOtekkgQbwXtbw==
X-Google-Smtp-Source: AGHT+IE9qqYS2fEzZ2x0FFgbt51fndc2QMC2/BQkBtJjD63HfIcuv4E5GvorluVyi1ruJibEdYEOvA==
X-Received: by 2002:a17:907:7f8d:b0:a9a:3d5b:dc1a with SMTP id a640c23a62f3a-a9de5ce1524mr769099766b.15.1730112361066;
        Mon, 28 Oct 2024 03:46:01 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0298dcsm365852566b.77.2024.10.28.03.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:46:00 -0700 (PDT)
Date: Mon, 28 Oct 2024 03:45:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Maksym Kutsevol <max@kutsevol.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] netpoll: Make netpoll_send_udp return
 status instead of void
Message-ID: <20241028-artichoke-capuchin-from-arcadia-ee1ea8@leitao>
References: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
 <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-1-a8065a43c897@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-1-a8065a43c897@kutsevol.com>

On Sun, Oct 27, 2024 at 12:59:41PM -0700, Maksym Kutsevol wrote:
> netpoll_send_udp can return if send was successful.
> It will allow client code to be aware of the send status.
> 
> Possible return values are the result of __netpoll_send_skb (cast to int)
> and -ENOMEM. This doesn't cover the case when TX was not successful
> instantaneously and was scheduled for later, __netpoll__send_skb returns
> success in that case.
> 
> Signed-off-by: Maksym Kutsevol <max@kutsevol.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

