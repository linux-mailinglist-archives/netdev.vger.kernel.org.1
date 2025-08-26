Return-Path: <netdev+bounces-216834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB5FB3567B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 10:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83704680856
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0592F5316;
	Tue, 26 Aug 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVuMTRfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AACE284678
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196054; cv=none; b=iIhVrWhI5VuVnemg9mnXBX0P52O/2b8kIzMyUeIofkcMMFzOZlCCgYsxcvQXtC2+1wr/1uUG4ZqVCvmZPUD5qxgfUm/iojzr39SyBbEL0FDYKvaw5sR4fkxiGu0DYs74AwECGA+cwGICrVIfXKRHIlPGEeOBC7zP4a/qVjVaFa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196054; c=relaxed/simple;
	bh=h9u7C3pqJnM4zMdMnReRGZ/HSmB+17GO3ew7kK7JkGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6/K3vGbDkR/hbSuzkJ75NhmzX8yOU2UInAQnEvv5e5R3z0UkRkiPN0Cag1J4rekKF6IPWT0GPX9n0wn6qJY9ybCJ328M89itSSRVkWQKXqpWmleiE/nIJ07sm+eNY9z0AR3eLu6BCTPNRqdD8nyUGw0VjWS+2IptJF8K27Jf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVuMTRfv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3cbe70a7923so48813f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756196051; x=1756800851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htJocjFCbY0wQ75QkTSmsj/N5xHgBbkFNdLz93b0Td0=;
        b=bVuMTRfvNT6Nd/XoPZDgckoqxjbbpew+NVXLtXdZQtL8tDZcMf67niLfrMFEdzBIPv
         Jw+vL79zNlvW3QSxbwGf65HfhVRbhS9KuOi+6AlJrEgBerEJqfKTDcmsPvf4WgRzBnEh
         YDMcx3xqAhFBxt8nJQWqI5BRQLRAw2Brd2HAfNIkMQmOuTICknMY0NDYXNPfzGguGhoo
         6zHduYFlfw67yd6D0bCD+g6GdnaDBQIePWFOAiDD4FhU9ctet1iDGQLvsTmU4QgZ6I1i
         XBuwrh1HYHvh9zEuVuj8i1x5t13IRaAicmNi2m3U3ogjiG3wXzVFr6UqM+y94oo2jO5U
         Ac6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756196051; x=1756800851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htJocjFCbY0wQ75QkTSmsj/N5xHgBbkFNdLz93b0Td0=;
        b=tS91JC/MCXj2OpFsSPbMsyLlcSp+6CJe3NFHFOm0lVHxehhicPLe0LhtuwHuxZ3Poo
         osee0haimgKVb+sJqzg6UpA+uaBHftOOr9ahfC3WK3mUBcpPHbWVO2YaWvzJTb+RpVbI
         Ogd4dYMHeHDY8pvIangg5NJl29slp5ayYwSbtecKF1cuy9KvveqeILUi1Dhi34PC8/Lc
         7lEQAa3xJdmCmgYhFkbEjHqe5bBsyvhz89MkzVg7mq02xkpSOomfzrIM0TkGPoz8DsDQ
         3Wpe86BJwRCn0YTq+AJIMvp355vqOh6ZJP5IqlqiNpmCAg5uE8bFIAOjvZDy9G9EFYxX
         p3aA==
X-Forwarded-Encrypted: i=1; AJvYcCUbqHGPt8gqG5ednZpECNC/JdLp5ys9dg2g/11Wwa6/cByLefb/fwebZ7IuKnX+64HjyeJHQMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1g/pJPIVuBXbtDExNPnmKSXKWfU0G3dtkGqbtkYZPaKljdMMV
	DN5eeqFYoI96pYwYZzGQPNy4xBA441RAeSWR7ZK6TPzJelJ0HfHBwWgIeRPFaLzAGMI=
X-Gm-Gg: ASbGncsPPXaoYnBMvFCZ/W2UtxJdRHPhLIPngmc+AA7SeKljrVfG8buXrtx9y1MvNI+
	yvBJRWaGLXOYYU+qv/VCMVGRyDdYDD3TfHd6XHn0420K5yzkx+0RREY+8PTPHUnyYPl5zJ4GJ9w
	zMH4GDOFDHkUUD4Vka4b6mm+vUcTDlba7iAVC665JH+mSGO2NhFjJvXq0Gyt+n9ptexq0NMl+7z
	ivV/t534UcoJQeGWt93T78k7aLs45SCXQXEwPXPzEEac/KAQxm2rrjPjQpYc3DyRu0265dvu/yL
	cD16mRrkt4p4PczbrTXUtx/tHU50r32YPQFh0F7B9x6efQCy3PhRE7LJz77klM9iA1k1/Sja5I7
	NAYEBfBDxa+gjxYzpj9T9JUbt80s=
X-Google-Smtp-Source: AGHT+IEbKxCrV/crYXvaOYg+DOzSnDljX8XhhperEq+dcEo354TQCGi1v3zOaG9kMQNx5o6N4Me2oQ==
X-Received: by 2002:a5d:5f8e:0:b0:3c8:443:4066 with SMTP id ffacd0b85a97d-3c804434575mr6485502f8f.61.1756196051410;
        Tue, 26 Aug 2025 01:14:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ca8f2811d9sm4480136f8f.20.2025.08.26.01.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:14:10 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:14:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Eryk Kubanski <e.kubanski@partner.samsung.com>
Subject: Re: [PATCH v6 bpf] xsk: fix immature cq descriptor production
Message-ID: <aK1sz42QLX42u6Eo@stanley.mountain>
References: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820154416.2248012-1-maciej.fijalkowski@intel.com>

On Wed, Aug 20, 2025 at 05:44:16PM +0200, Maciej Fijalkowski wrote:
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> +
> +		addrs = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> +		if (!addrs) {
> +			kfree(skb);

This needs to be kfree_skb(skb);

regards,
dan carpenter

> +			return ERR_PTR(-ENOMEM);
> +		}
> +
> +		xsk_set_destructor_arg(skb, addrs);
>  	}
>  
>  	addr = desc->addr;

