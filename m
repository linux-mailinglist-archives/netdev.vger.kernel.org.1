Return-Path: <netdev+bounces-191550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B9ABC11B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338DF188BAFD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F03283FEC;
	Mon, 19 May 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUPgu37h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C01283FF2;
	Mon, 19 May 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665716; cv=none; b=qcSHavcIq5xrujG+oXNRvoxpGL9lbhxhOjArV8dzTEhxlX0khqs2pN5Eo4sgjJGVkirKa8H7T1NeJ454Cp6Pzj6Re+Sz4gZdQxjzoDjjWpKMSHHz7CJc6KT0CA/40sgOt3/gduEicyjjnCKfp9Bw2cDnePPFWbeSb8Gmgq565CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665716; c=relaxed/simple;
	bh=ML143J+/Kn3jIc1eIZG0hGbK1RpU7d4laW0wjMgBeYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs4TlNUzwNzqooBy1XObAHbARcQlgEPwy1m0VawddSl7un08AjuJoeH5wyWdmQtciazjWJTCJjaRfGriSfCWxvw6G5GlL1JufhAmF7GzpJA70VitAf5BSFmLb3fXlwAG7UGEPHnsZUKqfbDvvl6+AzieTNsI/vfjRgugPdQEyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUPgu37h; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742caef5896so1249347b3a.3;
        Mon, 19 May 2025 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747665714; x=1748270514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aw5n6tsCSDHyMQ+j8LxQhjXH9U1Kb6RLRDfUGa4F/V4=;
        b=mUPgu37hSPcQt2WnW8HbJYQewq1ToNC8m+mcrb+SPXtWHVS3lJ1VGrruB0t23v3rAi
         z5Ncd6xrdft4MNg09ch2XcnwhVt6IE8yvpi9vk1wc9kt/if5SVtgrPo8TxrskQ/90Lvf
         y+edilCXAsIo8d4SvaPRAjLjpc4/I2AkNjNwNNNX629CTBTAbcdpzO6zTFvXQUO0q4yB
         sTNnk2vW7YOKFePMttYZWJV0Z9HvrynACQ8AmXqozIDJBYdGPPvQVamC32qB6fM2SVDZ
         OPLZXuEMEq/XsMUExln3sTWyuwxJmW24giQ82XjPCkpp7VgVOytmTQwyL+nmNYV31Jqx
         1frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665714; x=1748270514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aw5n6tsCSDHyMQ+j8LxQhjXH9U1Kb6RLRDfUGa4F/V4=;
        b=TY1qd2Bq33E6Sn3Or8j0J70Cq+Ihm/A3VmjEUzu5kP1Dma+KnO0l5PJ8Zwgv6GDWEw
         p+31N7Rn0Rd0VbO5O4H2smCB1AJoIoIkLhLb+xRPxnyTlnSLlo/Ts9b9CKgQdb86V9QG
         6Eo8gAkM/lqReBTi09ljrI2hoFWrTpCE5qzeG2nWMUoQHypbD6ipiQRRNRaduNGYElBx
         CVpkwBU4JUEQhj4nRmqyoYUYAnKZ0Mi1RoIcW0MypDo6LA5Scf62QRbmY+Dmc6NEtcys
         VHMQ6w0VUU0HGIyUwXYQNB4Qx+UuojcTPWvgtO7JfjgqlYSCM3bPnZKcV8JAGQx2/O9C
         sRIw==
X-Forwarded-Encrypted: i=1; AJvYcCWdl0a421Lkbr5ZJILOU818QrDFI9TZQYsBJX4hhhyBpj3YQCBk9obYvEWRtMvhXjWyLsFqEyPU9o9fSDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwknwaICgIpq2iPA4OuByp2A8Df2CYUcbeeTvEvhrNahD+ggKGy
	H+QUn2gs9eXQiCfyi2q8faBJFY595HEhydKYykQzMEmSB3KEamjcCMw=
X-Gm-Gg: ASbGncvsMu8nMtaaxGpZIXTGAGRxFF5F7a+tZ31GW/zem0o8+1/dEMvAb9SgvOO2oaM
	UwjE84d7h9gGjNn63nPJZf1if8YFMLlApDHVUPecxgbsQjH089+zkXxzsm/XR6ht0mm8433Ytgt
	SurHkQIEmchrX43DgUtik8KKH51jBqRVLKLBfkIWAlC3+9uLcxVL1hQ0cJ3xOwp71aLRY/PJpaR
	tcCNBGDhRRAQMemdzuJiz7ncJoo0fYx/kNBCa4zoeU912Qz4rFsO+p+3Y4O71P8ZGnvAwrR0E5C
	ir8WvmHW7FBt3F6lXy7asahY9RsPgjoEAzVPrcHJhYG3fjRzCPLMteOXnMBLmm19XvIiXx7nI8Y
	5l633+HFNpIvJ
X-Google-Smtp-Source: AGHT+IHtUXVvbyfz/wUk/NPtlQsWt3ANZFh5Vd5DCTyznNBWdm3FahFaArdDxlec41yDtf15OLtwkA==
X-Received: by 2002:a05:6a21:33a5:b0:1fe:6bbf:af22 with SMTP id adf61e73a8af0-21621875a3dmr19276547637.1.1747665714077;
        Mon, 19 May 2025 07:41:54 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a96e58a9sm6304089b3a.34.2025.05.19.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:41:53 -0700 (PDT)
Date: Mon, 19 May 2025 07:41:52 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	sagi@grimberg.me, willemb@google.com, almasrymina@google.com,
	kaiyuanz@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: drop iterator type check
Message-ID: <aCtDMJDtP0DxUBqj@mini-arch>
References: <20250516225441.527020-1-stfomichev@gmail.com>
 <ab1959f9-1b94-4e7f-ba33-12453cb50027@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab1959f9-1b94-4e7f-ba33-12453cb50027@gmail.com>

On 05/19, Pavel Begunkov wrote:
> On 5/16/25 23:54, Stanislav Fomichev wrote:
> > sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> > iovs becomes ITER_IOVEC. Instead of adjusting the check to include
> > ITER_UBUF, drop the check completely. The callers are guaranteed
> > to happen from system call side and we don't need to pay runtime
> > cost to verify it.
> 
> I asked for this because io_uring can pass bvecs. Only sendzc can
> pass that with cmsg, so probably you won't be able to hit any
> real issue, but io_uring needs and soon will have bvec support for
> normal sends as well. One can argue we should care as it isn't
> merged yet, but there is something very very wrong if an unrelated
> and legal io_uring change is able to open a vulnerability in the
> devmem path.

Any reason not to filter these out on the io_uring side? Or you'll
have to interpret sendmsg flags again which is not nice?

