Return-Path: <netdev+bounces-77085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7AF870200
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA2A1F21C94
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6823D3B4;
	Mon,  4 Mar 2024 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zikvjlzr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA023D3A8
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557491; cv=none; b=QQUGHQFo5B+nBuy6trlrXugm1he+iB4PASiMmoi6M+jPKY06+HZtwJE5/BQCjrYMLpYoPS9Yxdc3HK/fXATOLIixdh0v3hyiBv8idddNiGLF/QyjSBMg/x7aLcOiWPlVooUTWXr4ihQVCs95Ah8zHQYHPXQMmTmHfwICbwCht6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557491; c=relaxed/simple;
	bh=HNiN+xkH678ZJoh9nammOe7dG3DeThTZUr1GoXvGeX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B99M1jCJyNoWb3C62rcUVaklCM0GPEJ3GfH9ATxVtXNnYospWF+gMZFl88caMRk3eyQMeyxZRLXy98rEqGqAzuXaTcy+n7kfyhrk7WTTYpjQfHcY5b9Xpk2bNV10BC95l0DATg619k9PeGvC8SmAf6y78JFwJw6NdO8oX+tF6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zikvjlzr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e80e13abso2729645e9.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 05:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709557488; x=1710162288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+rjFZkIaawy1l3Aez6KUCHrjIrQ3sXyH01LpdLOUMQ=;
        b=ZikvjlzrWGH1KhBD/mDb1/rN4yJaXaipWpLiQs/eJ8bwViPtFiO8URt/0yt7ZyeBvi
         OKsrHEOIyhlYhE4KwZW+SuvBpB5nTuPE5xDNVnTd1AE8HshNzAjcZk9OFchmBgFsO8Ei
         mjeUK7QntYKsR4Wv2PLJ5BrdUPDzvFiqknPuaFQc+GuiSOfrQwhVB/N+Xl3nTG+Gbwp7
         NKv916aAGLGCEttvWxI9cmV/yaVpkc7A9BGGJrL5SyQkKaOEEvAY8XF3jOwqUUrZx4qy
         GSGvFebsqnUKq4wlQdxOY1LZrbaWSSq538ceTLqa2fbM5Kd+yUoVTpm2t5eBXfZjEOC5
         xxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709557488; x=1710162288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+rjFZkIaawy1l3Aez6KUCHrjIrQ3sXyH01LpdLOUMQ=;
        b=uLzctklcXcX5Z4LAxONonMsrsJ+vBgXHncOG4xEaN5p6tfBLtEA5O2S8ThCPp0Zr8o
         HkL4IBSLu22orIwHXzLK8jvYAmib/0M/6PGQ4sq3Xm6LiPiQelZNCukEDtiN8JeCRlJm
         RXLBu9qK8JUJohwbVWhsvNVpZIAo94W/lo4DqIIP2gTl1tFQkgwW73K3ho7pVwTS/KQy
         KwuPLzSVHX6Mrz4P1QXx+/TXk62yjGNfGif/zm2OzKvgNkK+M+TCP5SekpfsRC6LeP9Q
         XzxoeP457Jkutkv3RFVHa2SHsAfZ7o9+OrtOtqDbnya5eXlDevLfbbBwJ02Tfwf9EyCX
         t0AA==
X-Forwarded-Encrypted: i=1; AJvYcCUDbqgqi/qf5swPN0UCNF1RvOCcf4DgR4UtYjut3RVAZk8K7LDA7YjALhalsQIFM4bstSYHcujRqMOcvlgTsTX8+Ue5nghZ
X-Gm-Message-State: AOJu0YxVcMjg4sLpD4duUlwzgsY73G84ABoyPC//IN5E/E8vwnw1si9r
	H15TL2yDVbENxngYF/k+3aT6ZLBZdKoGEJn6IysGdj72UbEzBP9w
X-Google-Smtp-Source: AGHT+IGh4L8KFKF/gF9G4V8EVF7hXohb8Yu02eTFazSDI7bISBqX1m6Jgptlii+M6WN7oWRUAWcYqA==
X-Received: by 2002:a05:600c:3b04:b0:412:65e7:3639 with SMTP id m4-20020a05600c3b0400b0041265e73639mr5783198wms.27.1709557487552;
        Mon, 04 Mar 2024 05:04:47 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id hg14-20020a05600c538e00b0041228b2e179sm14598147wmb.39.2024.03.04.05.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 05:04:47 -0800 (PST)
Message-ID: <55cebf59-d366-4d41-a946-94320295f5c1@gmail.com>
Date: Mon, 4 Mar 2024 14:04:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/4] net: gro: change skb_gro_network_header()
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240301193740.3436871-1-edumazet@google.com>
 <20240301193740.3436871-3-edumazet@google.com>
 <f8711f5c4d6dfae9d7f4bf64fdde15feaee56494.camel@redhat.com>
 <CANn89i+19QU3AX=9u+x51P0xxPt6sNj-GHUh85NF0gsBChEgvg@mail.gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <CANn89i+19QU3AX=9u+x51P0xxPt6sNj-GHUh85NF0gsBChEgvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> New profile (6,233,000 pkts per second )
>     19.76%  [kernel]       [k] gq_rx_napi_handler
>     11.19%  [kernel]       [k] dev_gro_receive
>      8.05%  [kernel]       [k] ipv6_gro_receive
>      7.98%  [kernel]       [k] tcp_gro_receive
>      7.25%  [kernel]       [k] skb_gro_receive
>      5.47%  [kernel]       [k] gq_rx_prep_buffers
>      4.39%  [kernel]       [k] skb_release_data
>      3.91%  [kernel]       [k] tcp6_gro_receive
>      3.55%  [kernel]       [k] csum_ipv6_magic
>      3.06%  [kernel]       [k] napi_gro_frags
>      2.76%  [kernel]       [k] napi_reuse_skb
> 
> Old profile (5,950,000 pkts per second)
>     17.92%  [kernel]       [k] gq_rx_napi_handler
>     10.22%  [kernel]       [k] dev_gro_receive
>      8.60%  [kernel]       [k] tcp_gro_receive
>      8.09%  [kernel]       [k] ipv6_gro_receive
>      8.06%  [kernel]       [k] skb_gro_receive
>      6.74%  [kernel]       [k] gq_rx_prep_buffers
>      4.82%  [kernel]       [k] skb_release_data
>      3.82%  [kernel]       [k] tcp6_gro_receive
>      3.76%  [kernel]       [k] csum_ipv6_magic
>      2.97%  [kernel]       [k] napi_gro_frags
>      2.57%  [kernel]       [k] napi_reuse_skb

Overall looks like a great gain for GRO, less code for handling frag0 :)

Could you please share how to measure a <10% gain in pps in a stable
manner? While perf top is stable for me when testing CPU-bound tasks,
netperf pps measurements between 2 physical machines generate ~5-7%
noise when I try to measure.

Thanks

