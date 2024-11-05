Return-Path: <netdev+bounces-141724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4EB9BC1BF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04673B2105F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFCB1FCF52;
	Tue,  5 Nov 2024 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="clBDYcfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FA1B3951
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764806; cv=none; b=Ybsr5UFyWNPlfUdFs5Dg+izG+Oq5VY7stqVEvEjHrQQNtencGC/nI+B5Yq0QoeWDJtaDJJ90RvqIAHTbygxWHYsnpK95W1faSzpDF+tUR4SxEvMy6xXBCFwjhjim8OTSpsxoaHB5hom8JkoNhK54mM3JmZK24u0taKpM4NhDIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764806; c=relaxed/simple;
	bh=mAkFgCxWNbgHQQsvcbYxnXkz6l64EKdZMzmY/bptL6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaVX5vtrb4Nb8jAeMBWbrvWvqvn682NY8HNucIvAzHel7pCTCDeIUARE1MiUN8JOUISEG32jn5+DLV5AxmFOiVwU81M3HEogcqO83BfH5TpU/DRkYfhfgycDCj9K6gK9Kg66212odU4ZUBTTk1Lk/g+2UPoaK1uxDSqgFicINWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=clBDYcfC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20e576dbc42so50571315ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 16:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764804; x=1731369604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss2wdvpc+S9jF1wGdl+GS9FQpnDeDgZxQImgGWvIwg4=;
        b=clBDYcfCXnTB9oZXZEbu4vX2HNUAS6m7q74fLhDIIj/BAxewMlekirRF2AlguhM/cj
         UCnBhE+m4AVaPcz+lKr1HjqgSmdpr/jGg9CRBX19uIikCZY7ZZLVh5ig3IscNeIixc3A
         HzM4eSfSs7IDKPFbIVkzRgfeoQS5qjrCmVl4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764804; x=1731369604;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss2wdvpc+S9jF1wGdl+GS9FQpnDeDgZxQImgGWvIwg4=;
        b=qNi0y7mXBoODCZp/y+Pn4vMY35SgkB1XFbwWVCRscSrCZawc9158/sw88L9j6zthVJ
         pSehaz0habObqHY4kPQSVz5jvjiTvz3H6Mhg9q/YYEDK+EKpMPmyMe3h+jTryeifVEpE
         KmW3ckeAKhvtmz3/nl0GMqZGK33NsqVbwFSA7JkULCxeoAvWuqU9hc7w7fmQ77pwbg/S
         bEZxT0IYfunELBiSrnXODyGT6+oSemLZYLag2S286KhodCCpHZS3CRFOicjayhsdsd21
         zIx2LZ5zSAfItxJqmuPdn2o4eETtGTB9Vvg06IzVEMEkbqBtL34jP39ju6TxIiZ3Nxcw
         B/Zg==
X-Gm-Message-State: AOJu0YxMjLNgcP0u1DGBd9w0N6woOt7i5ms5bViZhJKbCHPY8cMimoCh
	z/LeONLEsuZgUKctXD/qrE1rDbBIOdEwoRzvbkxl8Qvh5GQLvcJDZNz0z/g0h0s=
X-Google-Smtp-Source: AGHT+IEkbdGvIND5jE3XAsTDbBC7w3dQ7XXuiWp6+dkn4ch0B6RZqBsVaq+6l6hQ27sWvq1RnnEcpw==
X-Received: by 2002:a17:902:e812:b0:20c:ef90:e4b5 with SMTP id d9443c01a7336-21103ca54e2mr239137785ad.52.1730764804073;
        Mon, 04 Nov 2024 16:00:04 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0518sm67092635ad.182.2024.11.04.16.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:00:03 -0800 (PST)
Date: Mon, 4 Nov 2024 16:00:00 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 08/12] selftests: ncdevmem: Use YNL to enable
 TCP header split
Message-ID: <ZylgAPuiYuNcEAvk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-9-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-9-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:26AM -0800, Stanislav Fomichev wrote:
> In the next patch the hard-coded queue numbers are gonna be removed.
> So introduce some initial support for ethtool YNL and use
> it to enable header split.
> 
> Also, tcp-data-split requires latest ethtool which is unlikely
> to be present in the distros right now.
> 
> (ideally, we should not shell out to ethtool at all).
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/Makefile   |  2 +-
>  tools/testing/selftests/net/ncdevmem.c | 57 +++++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 3 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

