Return-Path: <netdev+bounces-148741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A79E3078
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD5A166AAC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36762500AE;
	Wed,  4 Dec 2024 00:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5i998IQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0ED7F9
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733273268; cv=none; b=raqg4+cwGj4P0lABL5vufZMppSuCO1yFl+KpL1b7DWizVc5QQSvV6kgY5gk3fkIRL64//baEtqNYbCGGQyAH49r2yfpYB9alluRtDqv1PhTRZLcB870iKSdPUBX7yFimaBPWdawJK8c3FDoUDeCff1fQ+wQ3kD/T68J+ddJxiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733273268; c=relaxed/simple;
	bh=ptQbecT42phwWHJcCmDakuVLhHPDAhu77BBcDeC5jqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uACivnXqrUMUOQjA9iyJ8psw9aRiIQ40p194XNN8YUfKAKewqJ6xvFAhDgp6h6gmEbrIcNtgPClvgRcuFWj/b1g1nkEesyQ55LKe9nIlwTMR1/1fqMKtfn+K8kYSmRF/7qysD7sKRjImQT7mYev1anK0YBi6avvLz2qeaVE/vTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5i998IQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so5909275b3a.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 16:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733273266; x=1733878066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thif8ac4DB2+xwZ+rFRjg2pTq0jVNWH1/3nmCosAiBE=;
        b=k5i998IQXSh4+HXWGfgmi6fypnjdm2XKKUmfqfqgd5qllHOoypeeVBh0jyXiyggN4e
         3uRjkMfj+dCEmITFG5f8pSYP4cJhj7tzI6eeLW+QYSKJWY1W0yZZFjttbA2fhukEK3hw
         k4d1L/yHAKvHz1lEywDRpCzNxl5RTxkFsk1u4I3oKNAElpEt2c+lIiKTxng7HZIQ6gdo
         KZEciHpwpr8A46pqD9PZedB66QwspEhvZgvE47O5DBXAkn88AwrHUwaWMFV6tPbdCJMS
         OPsFRSFyAXVUDmCrLY0wVGIqnBZcetENnMJUckxxMFrv6R5k/IN0aqbGPUX/Ca09qBYf
         Tbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733273266; x=1733878066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thif8ac4DB2+xwZ+rFRjg2pTq0jVNWH1/3nmCosAiBE=;
        b=YVqFCKQK5UPtAaTttxcmxmMfMvzyHRB1tUmEImeJdtqN+aGnxABXFiXMJ7WzQAYP5f
         sqM7m0QSlzDd9L6qpEOi++LCr4RqmkajN5KSW4nbpJEnKZ1jwcFmKk4apltCfcADhhhN
         HqvmqgFpKnkZJy8Mm6Hdy4Xi4aZtnv4gudLjWBwfc3YAYxBlJK0wl5cX9ueYaLMUDygn
         vDacfQXUUOEefdknJsUT4hiAfQGWFfbRHznKMeKHIWGlauBEluf+CiRMOrrIKrQf/ReO
         nao632R8TNaaUX7gvf04Zwru2+IoBtu1ypD6e9QqtbgWY95i0t2KqBVF981N00NDIMZ+
         1eUA==
X-Forwarded-Encrypted: i=1; AJvYcCWHJ9DjsBtEL5lCFCeBevK6vzjFKWE9i7j7TZPORfgpjNkqzdLk4lqcnOiTWghaZzkfSbXPdVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJTbqZ6jP6at1Zx1SJVQYMscSyx/NKiR91pZvRPDyslG+MU5E
	waxuMeEVWUGxI+al0b+WZymW43fwjmos87Q0s3DCZct8N3VSMdWO
X-Gm-Gg: ASbGnct/tHuI74jtd09Bu7P7qmfX7FaAdonLNt0qMY95IZ6828d24tGab1fi6QeAIn1
	h1cH7TfpYiLkyPb2qaaRiB80Tl7tBKt6xuqPYzTkRpPOijGmTl8IMTUEbXTagnI8nGbVHXPUQca
	GTR1oO4z91WgZTL/ko6je+TfWyT67aSuznTwCwMww3X+95Hr0cJt2tWWA+MUk05t8rgo3N07V7J
	AOne/ba9B6CGeEsj93K0XfGH1++LKIuZyo7OmIEz7r5f787EnWINiX4
X-Google-Smtp-Source: AGHT+IEkXpSLrgkEwIFlHkj6tcSDuMwAbHqL+AZ9TBX/QM/aYNc21tCJlxFl0jZWoZKAt6Uf3GRCSg==
X-Received: by 2002:a05:6a00:805:b0:725:99f:9732 with SMTP id d2e1a72fcca58-7257fc744c0mr6475379b3a.13.1733273266465;
        Tue, 03 Dec 2024 16:47:46 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:32d6:f9ea:3b48:6054])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb7b6sm11445985b3a.129.2024.12.03.16.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 16:47:46 -0800 (PST)
Date: Tue, 3 Dec 2024 16:47:45 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net_sched: sch_fq: add three drop_reason
Message-ID: <Z0+mseLf3mn9mFxz@pop-os.localdomain>
References: <20241203210929.3281461-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203210929.3281461-1-edumazet@google.com>

On Tue, Dec 03, 2024 at 09:09:29PM +0000, Eric Dumazet wrote:
> Add three new drop_reason, more precise than generic QDISC_DROP:
> 
> "tc -s qd" show aggregate counters, it might be more useful
> to use drop_reason infrastructure for bug hunting.
> 
> 1) SKB_DROP_REASON_FQ_DROP_BAND_LIMIT
>    Whenever a packet is added while its band limit is hit.
>    Corresponding value in "tc -s qd" is bandX_drops XXXX
> 
> 2) SKB_DROP_REASON_FQ_DROP_HORIZON_LIMIT
>    Whenever a packet has a timestamp too far in the future.
>    Corresponding value in "tc -s qd" is horizon_drops XXXX
> 
> 3) SKB_DROP_REASON_FQ_DROP_FLOW_LIMIT
>    Whenever a flow has reached its limit.
>    Corresponding value in "tc -s qd" is flows_plimit XXXX
> 

Just a nit: maybe remove the second "DROP" in these long names?

Reviewed-by: Cong Wang <cong.wang@bytedance.com>

Thanks.

