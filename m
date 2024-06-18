Return-Path: <netdev+bounces-104555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751BE90D488
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670171C22D38
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8F16A931;
	Tue, 18 Jun 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uUL9jVfb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC016A929
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719295; cv=none; b=kCMPwdR8DBqEnmyZZHu6EdOCLXj+4fYADQkfeqtBHUAUXIwRJomlQbU8OBsCm/Lua5NtXpZDyUljnIzTT+ah3kc60bD7Lq7BupxLOzS09WbmegyK9DZmbBy4L7agVcdiFNWx/ynVgUkVgu10fBImWBS19nJFP9JVCiKug6WL9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719295; c=relaxed/simple;
	bh=tZ+BggyK2Mentlltwlv+MyRODRDLhD1dW6pZVoP8z1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKSmzjHiDIROvxBnombVZ2t6/jZkf5mFeW42Q3d+J/fTv7heA3QKs1v9Gihwi+6hFxrhZvwdmkNaq/BTxYMUFtOq/3KX9cMDub2bgnTZ5kDf5OQ47LMyJI8qFA36FCUdGVhqcZGIKM6a92S1rZtLZAl35oBdHzvHdzkhrE39pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uUL9jVfb; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f06861ae6so4761756f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718719287; x=1719324087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/90O4iXToyfWL0CkLrSqG+6+ufkpVBJPNMJlveTTd0c=;
        b=uUL9jVfb/vr4QhdKmEptDaMcqt0Uxvdn1eG5t/aoNY4Mc8yTxHsBlkbRvFARTqX1BT
         LevUsBIPn5qlbk1N0jL7B+p9AfzwG2cTd8RAnwArSGh4ae83NrFWCqSY9nTFhIO4m+cN
         rtYKoP81DhgRSUE3Sb0dhggXM9dpb3OCLeC6yw//F7JMZ1jNtDFAEged1FN5j1IWsibb
         JQ3krCyRN87JL9O0fOEWDT4mVBBJb7VNvI5gk7pg4tXuUHEARsxr2AtOFWU9XdnRYoPY
         THI414P+XS/mJT+aF7yrl87Fls+qZbbeM/C242+EmMHBGwNtm1spFb9cAfS/hfSrAidN
         G+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719287; x=1719324087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/90O4iXToyfWL0CkLrSqG+6+ufkpVBJPNMJlveTTd0c=;
        b=JylJnO5xam+MBfjh9hnIlLbE6ynUGz2VDFDjfLtkRkmTaOlvF58EPsbF07ySUZtdB5
         3Fey/UJRKnmuef7G+Y8J9+GEzwsscsQQm8lpm/izcCvAF4PiS9iE7Hf0pzL0IHJkZMmR
         ZRKPx0irAZKDVSVO+sMx4nziAvF7VF1L+rEUliZCINrJ3+Zj28pFhLkNCuz6dZ4MJSbg
         aweg1vbhXZpCMUmreioak7Z5Q78Dgub7dnnEgwKGa/mbYytiDxYOEbwItD0O5t9shJIv
         YXjkKXMhE21hcn6Jm1n4uC7wMLhIdwGDF2tkDOoCbj3f/BugXcKsHi2JB7KGxRBBl4c4
         86YA==
X-Forwarded-Encrypted: i=1; AJvYcCUcYkxco6v+IZuK5hx1Q5SZsN/QUnoxLrnddZ72I8H6ht2oP8Y3ir8eRKJ4EBu19guUmFVqg065q+uvkJqziWYbL4ztu4KI
X-Gm-Message-State: AOJu0Yybx7KjA7zLBmPjrrESl0c6vCeACBR88m5EiuajXDMn+dKUFuVB
	gc9zzLDboN7pEpIbuZTe73yynCeLreUpoKlaNuM/0ch4mh1GAacF76weEk16Xxg=
X-Google-Smtp-Source: AGHT+IHwG/TPSs4CnBjTeiZdwsaw9kXfgczyCXyqJcPT9dqg3NaYSeidCzIwWV0haJLLA1bY46Fonw==
X-Received: by 2002:adf:e702:0:b0:362:41a4:974e with SMTP id ffacd0b85a97d-36241a497e2mr913056f8f.16.1718719286716;
        Tue, 18 Jun 2024 07:01:26 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36262f77ad9sm969980f8f.109.2024.06.18.07.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:01:26 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:01:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 0/7] mlxsw: Use page pool for Rx buffers
 allocation
Message-ID: <ZnGTLSSlZpvf8zum@nanopsycho.orion>
References: <cover.1718709196.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718709196.git.petrm@nvidia.com>

Tue, Jun 18, 2024 at 01:34:39PM CEST, petrm@nvidia.com wrote:
>Amit Cohen  writes:
>
>After using NAPI to process events from hardware, the next step is to
>use page pool for Rx buffers allocation, which is also enhances
>performance.
>
>To simplify this change, first use page pool to allocate one continuous
>buffer for each packet, later memory consumption can be improved by using
>fragmented buffers.
>
>This set significantly enhances mlxsw driver performance, CPU can handle
>about 370% of the packets per second it previously handled.
>
>The next planned improvement is using XDP to optimize telemetry.
>
>Patch set overview:
>Patches #1-#2 are small preparations for page pool usage
>Patch #3 initializes page pool, but do not use it
>Patch #4 converts the driver to use page pool for buffers allocations
>Patch #5 is an optimization for buffer access
>Patch #6 cleans up an unused structure
>Patch #7 uses napi_consume_skb() as part of Tx completion
>
>Amit Cohen (7):
>  mlxsw: pci: Split NAPI setup/teardown into two steps
>  mlxsw: pci: Store CQ pointer as part of RDQ structure
>  mlxsw: pci: Initialize page pool per CQ
>  mlxsw: pci: Use page pool for Rx buffers allocation
>  mlxsw: pci: Optimize data buffer access
>  mlxsw: pci: Do not store SKB for RDQ elements
>  mlxsw: pci: Use napi_consume_skb() to free SKB as part of Tx
>    completion

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

