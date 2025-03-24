Return-Path: <netdev+bounces-177192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54CDA6E394
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0974188CADF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3D0199E88;
	Mon, 24 Mar 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqaf5Xud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D74191F91
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844674; cv=none; b=C8JeNK+y2zOada6DaXEqk+XWIoXY55rHejDWffE3I7F0yROsyLm9kfToggq3EgTgHMJXe9BxfKs2dgwvZ7Jh2F/I8WlfkKB0pm7BCqq6LVCawXTgj8KsyMs1YbQ4fEGEcJIKin5olOYxiubOYy2PVi4wNEMebdMEPcldV0HXhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844674; c=relaxed/simple;
	bh=90BirN/U+PZLAcCX0vyrhX44wko9nIl1omyCuZF2nos=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=azN6ZW43uW7rg0u4YfcubjlSmOHJXORaPMzGbCs6W+/vyshnxuxejnFy9BtkpaQiTTSH+EDroOGIlMiKSY/4jeKHtBceqXTJZiUdG3kY9Gg9SzB9BbFDj1IbTvGv5CpsSC3znm68TTlJhJzHuD28RikX6MAI44k4GoQA0/YCySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqaf5Xud; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be8f28172dso333130785a.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742844671; x=1743449471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyOvjiA096ekxn6ht+lDfE8MqAJXIvRyXX1CmqAgzGM=;
        b=dqaf5XudvNMsiWNDG/2dc7hOyAmO6Dv7RLMOHNRRI5UlFwgdyhJ/7R3IbSnVQQIt4z
         744FgyPSUZjqaxoGsCOy+JZdm7x7zWRLXS30XazT+18+z//1hpwlBqcoBJUl8SqnWKGV
         sjltr3Hb8eI20L1d33bT27uvj2dOF1zLDjL6mfP+OMhPGqxp9yfIz2F9IdZbNswbTl4G
         7ZQPRQqLnz2IHSLPAJHEpGgtL9l3LsP5f43ve4nfO7ODX0UIqXXVHpP77zVCLHh+7/4N
         p5fo0FUzh4Gn1YBY+Ed9cSOCkQhnKNfgrMAmSIX36/QylW2710q+qHPMI6OnEP0+EC9w
         21fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742844671; x=1743449471;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oyOvjiA096ekxn6ht+lDfE8MqAJXIvRyXX1CmqAgzGM=;
        b=R1geZJdaARgy4FK3Adey0o+8362cfhcDcF1t+ShzGwZbUlPUAY/FXMl4EA5nItVr5S
         f3ftrrL+9eOgBYqTX675fVRbTX5bVruQUXjLvFO2Hv/rrdAzzGb8uiTc6Z92U6kmJko/
         e4nHVAaF2tSbphHLZu0ggX3KmXv1+nImG/jD/xs6GqjaJ2Ze8E76jriqGIUzB9rnWgOw
         Fv2rd4WqUWYdrB/GVfTFnNRe+GD86zee4NrwX6nwNCzRR9AL+FrMGbU7q4sjkpKdiB8+
         xr87Qyqp5wJwUtELSZ2ILvve253ZaH/1+0LDAwzG3k/CWVJJKwMEZb4TfyZwE1COsYpk
         nxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLZCfQLSVJbRrduRQNPizs0Zdv9rHTr9iu4NSqr1HC0cV4MxYo96BmvCP4ooe8avUZczxmYCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjU5qkz48SqSz94mbdeHCXSw3WkIabSqqqJI8DKk63KQ5v0KJX
	TfBzBplSB+fQ9BCm9V+A1TxvejoOxfcbrZjgYupZaf3wQ+Og9Bqr
X-Gm-Gg: ASbGncsDljFPXOKk+yewAZfvCpnUi2PSzRzKLAbfIOof6P66xmqd6yVy3PstYKm4gWK
	Q222WLj8ku/tjhvYorTe/0mqWVc005bBIRcLBi0vzOEjceoQOR9PLkIGJQnyvm4dW5qdVitjF0w
	a0CjHcW98aTrkljozgd/QdAExftrVtlwIblHVh1EmoW8vLkp7rYQU8fRSQxzLt2OczWUHfbTAbC
	k/eIrrTMA5HwxgdXEvHUL1M3gspBlzllDYW3hCOn6Mu1IqNREbESynavgXtepH2V2AvfrEZpZRN
	K3NrVg5JM6B7F2PM+LXgtZ4VmT7zUh55DeUVK8GBxmhvzXs1l/shOkOWHItHyydze92gIMUN9ez
	+pMxrDBwePF5b1vigIHXgiA==
X-Google-Smtp-Source: AGHT+IGaFjQS2XuhkwNepFb0hNRKKuCeZTuIpS0flJYUHv/6WAK0E0VVip5tka+Yq3lo1gVpvmXFbw==
X-Received: by 2002:a05:620a:4115:b0:7c5:464b:6718 with SMTP id af79cd13be357-7c5ba23fdf6mr2344109885a.54.1742844671392;
        Mon, 24 Mar 2025 12:31:11 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d6b09sm546475285a.46.2025.03.24.12.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 12:31:10 -0700 (PDT)
Date: Mon, 24 Mar 2025 15:31:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 horms@kernel.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com
Message-ID: <67e1b2fe98de0_35010c2946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250324182602.47871-1-kuniyu@amazon.com>
References: <67e1810e3b460_2f662329482@willemb.c.googlers.com.notmuch>
 <20250324182602.47871-1-kuniyu@amazon.com>
Subject: Re: [PATCH v1 net 3/3] selftest: net: Check wraparounds for
 sk->sk_rmem_alloc.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Date: Mon, 24 Mar 2025 11:58:06 -0400
> > > +TEST_F(so_rcvbuf, rmem_max)
> > > +{
> > > +	char buf[16] = {};
> > > +	int ret, i;
> > > +
> > > +	create_socketpair(_metadata, self, variant);
> > > +
> > > +	ret = setsockopt(self->server, SOL_SOCKET, SO_RCVBUFFORCE,
> > > +			 &(int){INT_MAX}, sizeof(int));
> > > +	ASSERT_EQ(ret, 0);
> > > +
> > > +	ASSERT_EQ(get_prot_pages(_metadata, variant), 0);
> > > +
> > > +	for (i = 1; ; i++) {
> > > +		ret = send(self->client, buf, sizeof(buf), 0);
> > > +		ASSERT_EQ(ret, sizeof(buf));
> > > +
> > > +		if (i % 10000 == 0) {
> > > +			int pages = get_prot_pages(_metadata, variant);
> > > +
> > > +			/* sk_rmem_alloc wrapped around too much ? */
> > > +			ASSERT_LE(pages, *variant->max_pages);
> > > +
> > > +			if (pages == *variant->max_pages)
> > > +				break;
> > 
> > Does correctness depend here on max_pages being a multiple of 10K?
> 
> 10K may be too conservative, but at least we need to ensure
> that the size of accumulated skbs exceeds 1 PAGE_SIZE to
> fail on the ASSERT_LE(), otherwise we can't detect the multiple
> wraparounds even without patch 1.

Thanks. It took me some time to understand. Without overflow,
the pages counter will saturate at max_pages as the queue fills up.
 
> The later sleep for call_rcu() was dominant than this loop on
> my machine.

Ack.


