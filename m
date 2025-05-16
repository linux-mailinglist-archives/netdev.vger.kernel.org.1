Return-Path: <netdev+bounces-191018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B1CAB9B38
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FACA02651
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F71239085;
	Fri, 16 May 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9bLP6Sw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D5123816B
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747395554; cv=none; b=LRK9HTdu3rTW5BIOMIUbVpQYSE4F+bJ3FiMBusk13OslDmGvO3ENfy66j/+kI+fRelJiAcwDOPffdSEqUmV/ScyZAbiAixi7XVjlWdANxDc2hY1beBY3CiuUbO9gwIntX2Oz2WuoNiWcBnN+RZ3ZJlxZL5DLbKdYoUqDnAX7CBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747395554; c=relaxed/simple;
	bh=4LhXSpS+0Zl6SvQ9GrRCVxcaDvmorv677aW0u4mfVCM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=hqhdlOEiFgAgqAZA4Q8VAY8bDs6MrHDt/2OyrVSsEc9mM/BjNIwimW4205PLE5WP7gVBHssJpIsaZmby8HAbdaMQ0suvyuwhYiWF1MipitQy4coeH4aausuUFO9Nht4Z48Zl+NxC9fl1lTK365y5e9pACIeuyitqE4ouUWFAlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9bLP6Sw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so16056635e9.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747395551; x=1748000351; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LhXSpS+0Zl6SvQ9GrRCVxcaDvmorv677aW0u4mfVCM=;
        b=O9bLP6SwDXVeUvQnLjtyrpxh70MjODHCdJVnMp7Lz7qmJMbSFSNzgDi4MEQIeXBxS8
         Y9a2faBKeovSCh4pvO8GJLZ7PQtiXVm0PxTBwRieQwJ/UCw3Zj7MSjwb5hbf1YnBI1Ts
         v13JOzin7DUHjgLR6B2rl0De9OW9N26AxaVpzJNC3oWm6EkiQUhYWBjkVxV6cgTEpJAH
         9oWxVLonqtGRuYr0Ctzyqy+2PuaIc6Jtd6cyLadlTuIqv3NwMpjXaeO865z2bxrFWxbu
         j2s4BGRWuz0CeX3c4UFkwn7RcfR5qpB9zieEwR73qRw8v15zLAVnBefLh6s9keXwhq3s
         8PPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747395551; x=1748000351;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LhXSpS+0Zl6SvQ9GrRCVxcaDvmorv677aW0u4mfVCM=;
        b=Te98t7eunM1t9snlNmk3qbbWvFA+zp3mPq/3jk54RdyJrnf/6Tq5x7abSWe20fiAFc
         kedA/AeXOzpoVU3sQjU5riNtnMFq6fa++sF4TcMqGOu7Hz3whgzOt/tADXaGGmCI4nfs
         CFJuTO3Mh3krnFGkJkNDUBUvNy0EGPdtTE42hPkfVBK3r/gbmFiJA7PPI2aM2k5i3Fog
         f+ADxpAHK59hGPj5K6SZo0vev78UdvYIvTbDyUp60KoDYVGRRxU58C0URBtRf4gYHDpy
         BlhOvF4yl4Wn1x3vVJA+8K3d0eDqifM8/2TZRUQlfQDSa6ZjpHXZYvEGw49wEpCyRpIu
         z3Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUEgwbssZI/rp0o0IFc9FGB7HWd90H2UzpmD2EHvlw50036jodDkjIXR9PjwCHIylSp46WfOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVo/LIpYOX92nxFp0yphcDSJ3QvMwXGw9LJ5OvYBRlklljiDZa
	Ncr6l3ioUm/I4bCRMvAoPE0CbHP60yKl6kRD4KSMgJagjfzf++gJZ7n8eNcbVQ==
X-Gm-Gg: ASbGncs7WJJKKMEs4P0QK0pbbe7SzzuGK14E1MFRP7nIC3SlN3Hey7PD2RqSG3LPrL7
	rIiYORbzssPWFCRbw4y2DLLxgQLqs7wW0uuPXMuvpJ2jgJOQtkZK4RZVtkrV6NLzbnh1FPVKLLQ
	UgC+mYk3DXCOIwcXEJrQ2sLSWHsmIvKzzFg/GHFtVRLEDlRvJp2Dwiv/KNFidbjc09pgo30Llil
	6cFeGZATzAWWhjba24ZoPgFt4MevtjDD7sLFHw6mhSpuwv7d1FDRdnCfrlSFfh8Cz9RL3+vsIhY
	Tot10wkIb6YNvSUqE7O1oaQbqR5YxuGvSdMst0k7cctfZFAff0eM++rl3vbXZkhq
X-Google-Smtp-Source: AGHT+IF1ry+666GBzsvnV+5oA7E0M515auCvX8CFAXEe+9lWx5/pJSQnmkRAiSAH5b+goAn0+pllag==
X-Received: by 2002:a05:600c:1553:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-442fd665728mr28765825e9.26.1747395551262;
        Fri, 16 May 2025 04:39:11 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:fc98:7863:72c2:6bab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd59702asm29970785e9.39.2025.05.16.04.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 04:39:10 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  nicolas.dichtel@6wind.com,
  jacob.e.keller@intel.com
Subject: Re: [PATCH net-next 2/9] tools: ynl-gen: factor out the annotation
 of pure nested struct
In-Reply-To: <20250515231650.1325372-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 15 May 2025 16:16:43 -0700")
Date: Fri, 16 May 2025 10:57:14 +0100
Message-ID: <m27c2gop39.fsf@gmail.com>
References: <20250515231650.1325372-1-kuba@kernel.org>
	<20250515231650.1325372-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We're about to add some code here for sub-messages.
> Factor out the nest-related logic to make the code readable.
> No functional change.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

