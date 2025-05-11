Return-Path: <netdev+bounces-189554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF153AB29A6
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770EC174DA2
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD60025C835;
	Sun, 11 May 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcaFy2HQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312716F288;
	Sun, 11 May 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746981667; cv=none; b=Uf90ab84Ae1GPCWRVZIxDU1gY9gQeowV0qSW5LEZrEnklQ5ybWaluVBFYSY337wZXRZ6jjzXqnbCEer5oa82SgC1+f3OOabjbynw9ZBgIpb5sc8W8qXjZhm8PaYKvIK0Ig6xXGeQM6k4yqtIvGI3bv7FCFveumD1X1PHAJsGLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746981667; c=relaxed/simple;
	bh=BpSqAAgolvD8QzRsgGhpTRNqIaJNfoxadA4FR4dZmf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGnAPfzoIzZo0jkTf1pv5TvA7QeHExmJ2ZjiwWCJ3haiMwBagkMTsdW/fMD1dGvq74Dj543VYzRJkeNGXmgYYQsna/Ut/Gj7w+3emvCyrggmcTi7Q14CWR9msW+6ZrX+YoWDto3z3mtCsapLgkeQYdctjeW5QVmcdabvuGI1msk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcaFy2HQ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so4197502a91.3;
        Sun, 11 May 2025 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746981665; x=1747586465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/ZKlgrvhhQSKqz6Ce5fQAQH/I5sPBIWYRgGJ35R9E0=;
        b=RcaFy2HQZWn8DTBMWmBNmwUBcPBiYRwzz5svfvMkaa+3HBFcKGzPUeCYQuTNpSN7x1
         ulw5zq6Ivp3ypbtekK58I4I8fVxk39Gz9duQWldSaSJq9OCTs+Y0b825feL5ovWYFKKP
         8yj4RtHrr6iopcsiZYM9jSzxqICje6cJdhZe5KHXzzu0RHH2lbXuwi2kf3uYKTq9Px6B
         CtRfFgMDv2NQlfdWdm/WoV0Wk0WMRI6TeeU9E2k/4ild5l2bYQR6Bs5K/+I4erPSYwXN
         GK9nrevaeuGpYrRYFf0h/JIJcfIq+tibxNBIv7PfyMbVRk+5iW3lrobrtqynPXGH5Vbv
         QQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746981665; x=1747586465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/ZKlgrvhhQSKqz6Ce5fQAQH/I5sPBIWYRgGJ35R9E0=;
        b=nczG1LVA1LeIzF1MiccxgnBK21KJenZ6TwY842Ino4H3/IZ2k/xciQXQO71sutYFxN
         nX9CcfAI8cHMrBfe0n95UF0VX6/3iMsdVI60QOR4Siy2UnwzRTEIwYY8Hgb+DRjdKnng
         /VBWftyRNbRSNw0dT4fMMrYTcHm9YedAk7/A16Ni3gID4F+CdQHNkEoOG6kfNjhamT4N
         4RorKZDuBpyOa8ZI55C9uW4iLlfGiRgCNUF1GezX4Wduz4Ww0acpn7R46PHDJTciH1GN
         hUCS6sV/PJUlVSc6o40t2aRXKdXaYYq/+gKyo6yOAjpI5wTci7p/2Mt+qwuy86IykSiA
         qrEw==
X-Forwarded-Encrypted: i=1; AJvYcCV+WKLMJA9tQOu9yCcYPMbYXhtVFdJbvR8R1M6UH5A3NK6nDvTi07qSoFpQ8AdWyyDK/ZFK4Opl@vger.kernel.org, AJvYcCVe5VhLLt3fDSInsOVLfCtHKi2KrGJ0JJyXUWSJuTunpg+cm2JpWxgb996R0Wd3t4qE3VmFEjLLJcgy4yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx91chjt5AciMCESxj8mU900S5bZIyueWTXx87tvTbtftJqmrdy
	F02l/NkDxPetLwXuCayulNp9vxvPGqyM9V4lX+9B19JfsqqeBtDH2KZ2tA==
X-Gm-Gg: ASbGncvtomuK2ECEB4iyFa+qY9l1C2qxsVNlpbS1kc0sBiiG2trAZT7qEnpusFFKWpy
	v1BMVKeL5lv8WNt7jDqT90wjbDIY5whfnfz9tcLI/ZqWkPuqTRoRTkIykDD/v9HqXT+8EeKdudX
	Z9aOC7SjVrVE+NzbiaVkAHc7KgQw1KipX9Qqti0zHxN3t/E9/akB8TFEztaEyRVLo1fBHPhzbVa
	mp/EKI5auk/wI+5opWXqQyk2J3fLOThX9Zi6SQcWjElGtOPgoJymRmXiQAZv0tRSeptccT8JrHp
	xXzb1iWSMl+L+dIRvOJHtSk/JlUaEKtHS+bqZccXHg==
X-Google-Smtp-Source: AGHT+IH93JHbE+Y48xZx8JXhKCIOUKB2OXPaENOqRGtg9dKu3QxstqC/x2ecI3wu2l+kiwmiMuxHxA==
X-Received: by 2002:a17:90b:38cb:b0:2ff:52b8:2767 with SMTP id 98e67ed59e1d1-30c3d3e1bcemr14436859a91.19.1746981665624;
        Sun, 11 May 2025 09:41:05 -0700 (PDT)
Received: from nsys ([49.37.223.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dd5899sm5113089a91.12.2025.05.11.09.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 09:41:05 -0700 (PDT)
Date: Sun, 11 May 2025 22:10:58 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: shshaikh@marvell.com, manishc@marvell.com, 
	GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, rajesh.borundia@qlogic.com, 
	sucheta.chakraborty@qlogic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] qlcnic: fix memory leak in
 qlcnic_sriov_channel_cfg_cmd()
Message-ID: <d6y5vo73ga3wedlw5tlu62xfgwmxdsc4w5ruqfc232ddzm2jqa@75kxrvg7bp4i>
References: <20250507152102.53783-1-abdun.nihaal@gmail.com>
 <20250508173647.GN3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508173647.GN3339421@horms.kernel.org>

Hello Simon,

On Thu, May 08, 2025 at 06:36:47PM +0100, Simon Horman wrote:
> Thanks, I agree with your analysis.
> 
> But I think it would be nice to include some text regarding
> how you found the bug, e.g. by inspection, using static analysis,
> via a crash.
> 
> And if you have been able to test the patch on hardware,
> or if, rather, it is compile tested only.

Thanks for your suggestions. I found this using a static analysis tool
that I'm developing as a research prototype. Also the patch was only
compile tested. I'll add both the information when sending the V2 patch.

Regards,
Nihaal

