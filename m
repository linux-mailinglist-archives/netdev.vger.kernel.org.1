Return-Path: <netdev+bounces-180033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71AA7F2BF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B5169BF8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930E8222594;
	Tue,  8 Apr 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="PkG2pKQU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F379CF
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079997; cv=none; b=P6NbcxgxaBuLBwLQhDxpooAR28SzQDJrAmrz1zypgtW1ai0r0PcqF40IPDymitZSn7DD3iYf7wlA0VcT46Szwl1PXDr2/wUC1GqBYJEXr5w8EyFW7OAOuktrgECt7H+INAeIgA5WMR4ag5QPt46GrRKGdcfc0CilBFoi8DrB0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079997; c=relaxed/simple;
	bh=M31VxOzVmZnycXapvIBZosqTUyiTH9P4jML+1afoVLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs7fc5H23coU4KfzMnWdHmllcdjErbmvHbdoXFrlO120c9uYHGKasZ50Pl+/taJSBxmh5dxTtayp/gafO+buRaLXniWDrog+A/Aov1oDG3FbxQ7n7su9TfuLu5HStLgWUXuCBOAlm9I7i0CCW7YIskYos+VG51lsl3lkqJpHC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=PkG2pKQU; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c57f2f5a1bso57683485a.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744079995; x=1744684795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M31VxOzVmZnycXapvIBZosqTUyiTH9P4jML+1afoVLI=;
        b=PkG2pKQUlLCKRprYTfO8R01aYeegvO2ZcukPta9qWRBZvE1xaWz1SnZjJFQlKpdwAN
         VmWb50mWFr4q7XpNpnHJ46ZkPxIP9Au9KG4Ti2OOTwQPteSFndreAgDRO0T7g4QrcktE
         64sdByegSR25hUo0bNEn5lzsUP1GE/CmzpaE0c/1lEU8UnCQMl8qucIaSXg+2OGo9WKm
         FVF4uWLrHtTbLRlFhC4KNV9aB2FpJ77KGRp5oDVpFSfwdQhaWh6xapR1zKVAEZVGX7kn
         OgCDzw/1zP7ExOOhMEw3gKmFmU6o/gKtG9+lbwfRDcJROqpoNEac7fQb3Hgt5GLPTotW
         8MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079995; x=1744684795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M31VxOzVmZnycXapvIBZosqTUyiTH9P4jML+1afoVLI=;
        b=C64Brx8gNuI1b7i0L2GHdRg031QBbiX6IYVnb2YOfxYjCjFntdN33e53GcshgnX4mp
         qNM14EkHGdjDO46aPpg7NvO23WYDnQ83yUD9mlf7x2WNnw717nyhTtFUfF95bCNOxOFS
         zghdVNoIRqr/VBbyRUMchnvVXnJHsnStsrw7WQBhXE+aFFLexQrQsujb6YnRHQZYPb6n
         w6Rf8DMbwHkksp2EZKUP2DyNyB0eXVdGBJPfYHr8hj0rmAUorzRxWyGB1E4WDq72elIC
         asbYmVv8DkDS+zXojv67s34RSAkWh16sVNxHjWCCQIhAavUYKoQZGhy6Zm+OZOGMkW7p
         X0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2gETCaRZUQQqmsY/nmHxo0kUThBGlxlSXqIH3t+k6rJtWLDPFzn2uR/wxKoPreERHBny2A6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YycQhyv+KfutXVQRBrVDHEiggcEsEVAVaUYK4LHy891bPcxiJaf
	Emj/wbnlJBwdpVzUspsTJRF8BmVimjYqGiqMERFNzXlyCUkUv3vMby047u1vux0S6NriLHhiQor
	Epucqj/IPc+qsPe48ThYgeUYYeqHGCqh0FsYj4A==
X-Gm-Gg: ASbGnctzbc+irLHcuE/Dk5qeXeyCf99qNM9aGeEZ+wkX61pVfBl8Ri/A0PmH5lhgSsS
	RMWl4GTn/iYvTjAz4v96UiVCYN9SKP8u81NLzuqpjU2BPfCsuHDtCO62Y8OgkLZkGsXl4hE4ndY
	XXidx0Y72ZAZewWg+Mb1rtEAuWRBPJtdw8fnwHjxJKteTXENVwPCutHAmp1CM=
X-Google-Smtp-Source: AGHT+IHpSLU3oa6SVfByXmuw4k5+J+vcfz1hIimEpRpnPeruT5HxoV3Dp5AbBE5EUCxZstJmeFto1r2adE6kVPlUl0A=
X-Received: by 2002:a05:620a:2706:b0:7c3:cccc:8790 with SMTP id
 af79cd13be357-7c774d259demr885538185a.5.1744079994828; Mon, 07 Apr 2025
 19:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
 <20250408001649.5560-1-kuniyu@amazon.com>
In-Reply-To: <20250408001649.5560-1-kuniyu@amazon.com>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 7 Apr 2025 19:39:44 -0700
X-Gm-Features: ATxdqUGyx7acR0AtEZl7zRjwptuF_xH_VJRTNQaNyV1ofxqMXhsBnJNdNQ_k2cU
Message-ID: <CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: aditi.ghag@isovalent.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

> In the worst case, where vmalloc() fails and the batch does not
> cover full bucket, say the batch size is 16 but the list length
> is 256, if the iterator stops at sk15 and sk16 disappers,
> sk17 ~ sk256 will be skipped in the next iteration.
>
> sk1 -> ... sk15 -> sk16 -> sk17 -> ... -> sk256

Ah yes, this is true. Thank you for clarifying, you bring up a good
point. In case vmalloc() fails, the batch size can't cover the whole
bucket in one go, and none of the saved cookies from last time are in
the bucket, there's currently no great option. You'd need to do one of
the following:

1) Start from the beginning of the list, assuming none of the sockets
had been seen so far. This risks repeating sockets you've already
seen, however.
2) Skip the rest of the sockets to avoid repeating sockets you've
already seen. You might skip sockets that you didn't want to skip.

I actually wonder if a third option might be better in this case though:

3) If vmalloc fails, propagate ENOMEM up to userspace and stop
iteration instead of making the tradeoff of possibly repeating or
skipping sockets. seq_read can already return ENOMEM in some cases, so
IMO this feels more correct. WDYT?

-Jordan

