Return-Path: <netdev+bounces-221873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF95B523A0
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20B11C82BD2
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 21:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEDF311C15;
	Wed, 10 Sep 2025 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="kiFd3BT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062F13A265
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540481; cv=none; b=kW9g1+YV8h9wqfK/4MCzZxVRVfX7jLH4OMy60Mn4rZMtZfurTQ6fbZys5XSoK1PK/mw/etL9MIoEzA6X9a8P6dFwU5ZyTjD+SoXidh1uy92Gh605pJIFmY3EupRbT704ro39TBdWynu3zzUf+6+oc8gpAlGP9U7cJLiU+wSeqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540481; c=relaxed/simple;
	bh=rBTNYVsF3YFvmX+4VP6dC8AXXIIfKsebSpVauz6I77Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omPtvAvizPRAUeMO/aweqU6TMKKbLGXPsDRYG8YAmwNXId3ZsSTS+lJhVBPUWPbmj0+IYgm2AMkVy0aTy263xEwin/A2pGP4786vW5c3Ki7zYGfpNEK9SXPraSmTeBJe9i/4sG9tVt/AjrR5THR1o1uHxNHToSOqfcLBnPK4Sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=kiFd3BT9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24af8aa2606so40015ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757540479; x=1758145279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bzId/RkTQL8EC0WDO7Pec0MLfxYUok0E0Fzx4XPk7rs=;
        b=kiFd3BT9cs2JZzyLlLLN0uZEoNJ088qMuSkl56MQAQMoZxK8cZ4iWKjNAXbOklQjBJ
         KXGIxng6lA1YaxgW4yEYqWmcVjSy42APmLyW1A0P/W+r+WvnwdUJLmgL+EiTUbZP62Xj
         MCvVjIptboEvqmARIHcuH5cI8Fb8v1J89nT/yf3V1U/jmajVb1xAhlkiTwUfUBBtW6DW
         sL7edHOuLrHQWdNdUhw2/+yzOmm0Zmq0qNcxUcbH27fzyHpKsISTPbkr/a8ftjLfLGoo
         KYoDq9yM5yyY8ZX/oI4yCruN7/wP3uQym1LU1sAJYwJkWZA6AhYgopej0hs1oGXSQjJQ
         ylRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757540479; x=1758145279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzId/RkTQL8EC0WDO7Pec0MLfxYUok0E0Fzx4XPk7rs=;
        b=lEekptL+zVlLJ17M4J9GxjHAKbbrkBltdb7/bmHvuNxJJQxOuX0R4cRszwRfecxeL5
         DX3K8ZcPAiaX9KQps0yIKaYvFGEodGlH/yma2HqPlS+nSR8h6GbwCrmCbNaepdwxQPRf
         feTselnsRZL9nGdUMnGMbZ+H8WDLTiFx3HEdQr0fvojZkEsQgVGjcR+4s9m5dZ1usx5L
         WcyBJ3OFaCr3Bl2JSYyAf+JaiP2TpeQKlxWSJfJ92pjzcrOdXZqpvioyeWUjez89Gs5S
         MYLkh81mpJ5mhgfYeJc6BbxTq8/bU8cFXlrHlTvWqtPCzwP6jmFpv51WzZsyl4DHUu9E
         18Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVuHR7a0dJUsGiRbVj4wZjkHrddvkXeJGrGI0VaBf/iCfSVUB3LLWWpZpB2sz4+dVunlNGKiyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DfnvyNov0igCPzDE7SJEj8iqtcRzxXhDpLUU86nMuFC6a1Gs
	Mr8JhnENLDbYpYEEaKUuhsMUtwQC2M+RDx6Zaa4McUozlphOelcHWEwly8gPCUh/WfI=
X-Gm-Gg: ASbGncsAD9R1jZkoEkUjWKCIuOv2FC7OaZg52v+SHhwcVaop+rY5OSgPdVLHPmwlOFx
	yacFBTu/mi/mlRa5h4TazwStkZjlrytv2Ytsbwudm2u1vWS8WtRr+F1WVLLvhlhDCZvXU654req
	r5vZ16VnZOaJJEzIuL0R7nTkHMJrqEmG96KZiUzLznjXTC4Luv2M6exvQHgNmocoT4gaYhRImTx
	DiNVD6CQWr5dlRgBhrUb2Z8QET8AUrl2IHWeZkMcgBshj5TQLel/WTHWGCPEexD+7XqibVgiq1W
	7sd5aOlx+65xnmFBstdqQweDF9o0WAbTtB40DlOTZ6rdqO6iP7LKL3CdJXtHDm6fs21Veog/ZPl
	Ky6s2cWpB
X-Google-Smtp-Source: AGHT+IFc3gLRJ6cR/FpRGzTCp6rzCTj3/EJpFuXvGDWz9QQY3e21hQurVVFTNe86D+WDyYrwdADdpw==
X-Received: by 2002:a17:902:ecc9:b0:248:f683:e981 with SMTP id d9443c01a7336-25174c234ddmr117757125ad.8.1757540479412;
        Wed, 10 Sep 2025 14:41:19 -0700 (PDT)
Received: from t14 ([2001:5a8:4519:2200:5e8f:88f7:48b0:e920])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a924eeasm37135765ad.108.2025.09.10.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 14:41:19 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:41:16 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Aditi Ghag <aditi.ghag@isovalent.com>
Subject: Re: [RFC PATCH bpf-next 11/14] bpf: Introduce
 BPF_SOCK_OPS_UDP_CONNECTED_CB
Message-ID: <aqvluk774lxbko2znaeozteef246mcvwd4qhvcqsqahr5zdmyw@kmbefshxxm53>
References: <20250909170011.239356-1-jordan@jrife.io>
 <20250909170011.239356-12-jordan@jrife.io>
 <CAAVpQUA8VyP=eHtQ3p4XJYwsU5Qq7L-k1FRGhPN+K9K+OeBZ+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAVpQUA8VyP=eHtQ3p4XJYwsU5Qq7L-k1FRGhPN+K9K+OeBZ+w@mail.gmail.com>

> >         res = __ip4_datagram_connect(sk, uaddr, addr_len);
> >         if (!res)
> >                 udp4_hash4(sk);
> > +       udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);
> 
> Why is this called on failure ?
> 
> Same for IPv6.

My mistake, it should only be called on success.

	if (!res) {
		udp4_hash4(sk);
		udp_call_bpf(sk, BPF_SOCK_OPS_UDP_CONNECTED_CB);
	}

I'll fix this in a later revision.

Jordan


