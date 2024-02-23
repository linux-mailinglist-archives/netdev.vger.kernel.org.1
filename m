Return-Path: <netdev+bounces-74310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0A860D72
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 10:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1048B1C2223C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE10018E2E;
	Fri, 23 Feb 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ajjqO81W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E821947D
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678981; cv=none; b=r9uoqkEyln6rDCUQPmt8i3RPiFA+73MIWHewaJE9/UODxYr2enS3XNK87x91qYEXphvGpYQjgezHYyFVa8jx/yBPPLgFdgKTXZc4aTL3xAAhsxRrn7iB0XLzWFSormVH/kHi+N7mRWgFG05zDYe6tG8PcihqZY7M+5RmlAaE2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678981; c=relaxed/simple;
	bh=zIrNTpGSvxbJvIhZojHOlW1vE6ZoOwFuUHv1CVFANCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLnTRQUSikOxtWXf+5vwJ43QMfHvVHru2i2yAxKnqaB2LoNFTHgpRyQ4lRxkzSt1hE3PtivxAGbPGV2kES24Pe759RilReqWOM3NFL9xJ5kNZVgIoA4+uQVMVbwzj/3jjoQlWlsfm3jFKNk8i6t2MRro+9KVsn45IfStxW/cxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ajjqO81W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d18931a94so469733f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708678978; x=1709283778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIrNTpGSvxbJvIhZojHOlW1vE6ZoOwFuUHv1CVFANCo=;
        b=ajjqO81WcKN/dp/ZT3FqE8mHL8HQmTobcEYdAMUsqU/2wK1G9apxSIRCSK3nZYkcnP
         +Db4Wmmi/5OaiLpd4NS/1ji297n036t+W/3YzS7zayhzghUNo1aRtjX462WEFX2JsZ+X
         c2H2rkaCmtbyPGs3dnjmbkSZXEWH0MsmwdOsbVOyaK2fKUMoQBFiz2DYlO3v9+Io2nmC
         giHuSRJ/nrilAG+XoiBbzghGk1nA7+0AAhEFHBBturCB5ZmZf1ovTRt+8uCIa7Tdc70l
         lTiz5LuSaUCaoB3jRFilWhPHrSg0ewzjDCI8gjsAqGSxBZd3nJ3v71FDfoE31bL6Lq2I
         RUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678978; x=1709283778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIrNTpGSvxbJvIhZojHOlW1vE6ZoOwFuUHv1CVFANCo=;
        b=LLa6ym4aaf/VQFiiWq4JtMFOLAEuEfO80ARGt4ZTlF6n6K6bPwkAU45NrEEGK50a41
         DgMt4x1g1M7deiU3/CI6HZUT6+/WyFJ6ZjxsM5pIxF2umpuGE+9YFSyAGbSpDN23WcDh
         k5DyNirzwLm01/k0/8xwgy7ZzRPHphNdMlF63MGtzlGKjj0bN3dYYKLe6LS4rJs+7qrG
         SbMWDpYRavZUJyOaoa10LiPlMyRwD6qf74Zy9uw7QOcaLztsqFsE2QKn/LD6a+clagiT
         8SaTEsNUTuGUZDGyZ9691FIYEBxAk11CoopVZ4zryg43546H6V13nUX+QjNMbin7Q/yF
         2kHw==
X-Forwarded-Encrypted: i=1; AJvYcCVt3bcRcGp8Hq96eT5hHtLdq1GzWjBPbvHQgFovmBI5xb6HG9cG3epADruQB4yujTBDarkAk/6UuBrm2XSuvR0CTOQ1OCna
X-Gm-Message-State: AOJu0Yzoo3TzzJMrWXlBQn5sWKggdHEYTG/Iw6Q0RVRHJUREgBhgvXBj
	tl7NCxt9asfz8QlDNXsQHgm6OlLYBHPZFxu41WpNtiOBgu4P/fzN9idRLBkbryg=
X-Google-Smtp-Source: AGHT+IHbALTArC9t7W6DOwOWKFggl6be8fAMgdu4fXFs/i6uWoHArR+81Vcoq54US1YG+K0QAIIFzQ==
X-Received: by 2002:a5d:43d1:0:b0:33d:89a8:6b99 with SMTP id v17-20020a5d43d1000000b0033d89a86b99mr852393wrr.70.1708678977950;
        Fri, 23 Feb 2024 01:02:57 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i9-20020adfefc9000000b0033d1b653e4csm1997344wrp.54.2024.02.23.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:02:57 -0800 (PST)
Date: Fri, 23 Feb 2024 10:02:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	chuck.lever@oracle.com
Subject: Re: [PATCH net-next] tools: ynl: fix header guards
Message-ID: <ZdhfP3lMccJC6KFB@nanopsycho>
References: <20240222234831.179181-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222234831.179181-1-kuba@kernel.org>

Fri, Feb 23, 2024 at 12:48:31AM CET, kuba@kernel.org wrote:
>devlink and ethtool have a trailing _ in the header guard. I must have
>copy/pasted it into new guards, assuming it's a headers_install artifact.
>
>This fixes build if system headers are old.
>
>Fixes: 8f109e91b852 ("tools: ynl: include dpll and mptcp_pm in C codegen")
>Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

