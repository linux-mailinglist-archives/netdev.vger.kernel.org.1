Return-Path: <netdev+bounces-67968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041F845807
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 13:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353941F27831
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 12:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B89886634;
	Thu,  1 Feb 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aI1/fiHr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8886629
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791653; cv=none; b=mQ/aChI+sFxiBUM5feFKyOz2cQHsVoZVLpIaP16bdvgZiSnY5VGJePW1lP1eKOD77a2hUGql/lYcvcA7HBnKa1Dmo56V8Z5ImBFvUUQsrufN1SfHN2hluR4qWkBBd0BVUkcG7b9rgfRlRMgKCiHFZWt42hFsIhvRigoSE5T1tW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791653; c=relaxed/simple;
	bh=SrCCSDqnT83NBejFDqLvZhNBdZEM7c/GDlvAag2DkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdGPPDl6Snkn7hfEvntMnkWQYzVunL8qutDVAyFOnROc0zugY4JFXfoIMMkgMoabTPy/tlsT4806M+AR6jdwnBcq6Wl9tzF5ybKKyQvTB6CVa+E5uFoDPZUM3mp+4Vk0dYklqUuxZJziybNRniWY6zRE5Xo4+uNIxxkxWCq3qug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=aI1/fiHr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so8049325e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706791650; x=1707396450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrCCSDqnT83NBejFDqLvZhNBdZEM7c/GDlvAag2DkXA=;
        b=aI1/fiHr6NErtr0KIAfc5sKxYgbxdGCNb05/KAC6/UbWsuUxsWYLM0XNT90TQLTm54
         CEkw32xscbGCB2SaZfxUr5AoGLoETQL/VDk9FyzDYszmn3UN0FWOW32yEMsZJzE7intX
         e28UwOGOi/aVK9gL6i+0hkBHokLASqE8fzpCA8r7vrg7iyG9906kdnYLymmQJu7KptJQ
         0m85+kIfrDt1ZGbMcfs0zB8/2yXWv++Prz1Y1dti5xanRSQxPmjcpUE5bqckoj8kOUT2
         OOvakqwgHqLG4e+zZXNX4WvHv8JtAaouY52gpSODD1FvUIKuLGb30ltSzQ7Q0sGEuElD
         ctrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791650; x=1707396450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrCCSDqnT83NBejFDqLvZhNBdZEM7c/GDlvAag2DkXA=;
        b=CKzRR6jCkYMy5AuvQH/1zHiGxD/zYdGHjFwxEGza4ojAsVFnzniEICtG3jexg84W33
         DiebptJ2a+on6SSOlfO3Zei1Ob7ZFo9EGzDZdGGmVaLmpFAzy+7igNBPE/hyLjKDpwLs
         hnwnBiEMqyoV0tCU+cv8CDbO7AESSJVo6waWiNnIFeQ10jO95VrjAM87W9Yb+i2I+p+G
         elnmIgk3X99eMNvGjudITCYrgP1vGpfKe2wXvRWRsL2kj01beJToM8Xch4MCcoApLQ0F
         VnRvTElff39mRbHq49Ipu9mV5kvd0JbK1fzUuhVe39o8NhigmZr92KnM5AoghOdyoUr4
         QhXA==
X-Gm-Message-State: AOJu0YzLAA8utJ0DvsJCvEx5wHR1I/0lTLDYpjWaxOb9gTL2GeRiplxK
	ovt+wuzJxiVEaYDY+GBRC90lEpSn+dBP6qf1YAybdgbcp1sFpgDcdwuZJ6qW5zk=
X-Google-Smtp-Source: AGHT+IFBQDMjB9QaO2zF8XjHM829y8wQFGbOhiy7LTTNAI0oH7do/LOdRbfw60OBh09NOApacPt4Xw==
X-Received: by 2002:adf:ea8f:0:b0:337:c73f:db0f with SMTP id s15-20020adfea8f000000b00337c73fdb0fmr2765113wrm.41.1706791650430;
        Thu, 01 Feb 2024 04:47:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUgoQNbt3yJXfH7E2BOIhJs+AzgLHGcMAQhcPyICRIlMkpiRP+/hBdsENkApsvxCAuI0g5AIskYnAXSr1M3h6H6fYbiWiRNBlZbRHylTt9VQNK2tpJJHRnCrXl6tBMvajWkywnTWDaLOv5ZVbW5CBODV4KYYQbc6m/kUGz6gOGuwkfOY9KyISmHgR7JDeP717oUvPtbwGA+QFhnWQ4XrKEdEMsHeMYtfC4274B92qU33D9O7GF0muyY5+6gGjZD1fk6DHmEGszC0NGSxVi922d6Z0czanKQA4XTc2jexMJOmlkoKjwpTZR5rYWhpKbuIIy5h38SKqC6VkjQyxmk
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cw7-20020a056000090700b0033afcb5b5d2sm6653298wrb.80.2024.02.01.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:47:29 -0800 (PST)
Date: Thu, 1 Feb 2024 13:47:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Simplify the allocation of slab caches
Message-ID: <ZbuS3n8DM4QqoUGg@nanopsycho>
References: <20240201100924.210298-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201100924.210298-1-chentao@kylinos.cn>

Thu, Feb 01, 2024 at 11:09:24AM CET, chentao@kylinos.cn wrote:
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

btw, why don't you bulk these changes into patchsets of 15 patches? Or,
given the low complexicity of the patch, just merge multiple patches
that are changing similar locations togeter.

