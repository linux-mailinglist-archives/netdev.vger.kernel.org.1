Return-Path: <netdev+bounces-202173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC53AEC7DC
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA01189F813
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EFE255F22;
	Sat, 28 Jun 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y88+V+8+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5924EA8E
	for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122173; cv=none; b=MQZVK6WHpbQ61PmDT9UnD/ihbLxOOci+EkakmRaTUb0P2bQ+8UaEfGD7u/b1duVuWw67j6ptO8L1NixB7fU1NcnLDEEXqdZfjR/tUaa95rnlll1xvW3vXXTYFl/KPjcSc/xBvoA91XmQBVRKLoE/WgCmfuyLzJ3Lhx4+bcorz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122173; c=relaxed/simple;
	bh=6+KZoMVc5l3O0E2jVAKspFsGkvQhoeVjIimapKumKLA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=OG4NIKjveN3s4jbvzOw/4XifvVrFqcyUAn81t5igEt2vABLHcHOfvQZoEt+o/gdUwnJyLFgmhCSViPnaZePOjWNQUvwOf6O26HHC3PbqS1Vs+YhD0C9lcLwD6KlP3DIvoVAvRBfyMhNSPseMI1TjFTNuUrTF8L9zwoOS1ugiv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y88+V+8+; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso2530178276.3
        for <netdev@vger.kernel.org>; Sat, 28 Jun 2025 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751122171; x=1751726971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOfGqVPC2oK99EsGKD/1zJLmPY9MS1I4kN6eRD0TFQ0=;
        b=Y88+V+8+Tst4UazzlREenjcqvORf/bZqZuNOoDNIPjhOcn8pDNGbcib/jKm3eIj6xk
         xiex+8X82cplUYgNRj567tRyMw6KB4bWxD04oe3lzIgLUaNgW0yAgYLnXlwGJWoGKUaZ
         Gx0GletBl2Fs553I48Fx91/5jr3lI/IqstVJixIV+k/TYiTaihL27SDdDt/B3CAr2LE5
         nf9bZDC0RyahTDr6UvT/ivgxI71FdhqRMtphTKc+VU3qbwJJpBhS2zlDWFHyOtz5knUW
         7++XvZwLg/ZrN0VlptqwT1PRWUEGgcezQSEnHgQIThzSePSk7IlQurBep0DBxNEHxaz1
         4BMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751122171; x=1751726971;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yOfGqVPC2oK99EsGKD/1zJLmPY9MS1I4kN6eRD0TFQ0=;
        b=TQHjAXBJsydnbyj6JgMwFcVtWyvkq0tZCJN2EAyY9eLgqvnKUmvr0v00/fUXuNWDYw
         y7+hvBj2vtOetfZf8Dfjsc4SK4miriRfH56UNSUsbTFTwHTG2xtVu0ItO14o5rh4/rIB
         FUs8BwbligjhpS/bJ9xeFE4X886fMSNPcCEPHmIbPWP/h/6cVgAphxMwetSvGT/7SJ0b
         eWbVjUcRKYF4Dug7GoaA2o7ayz2JvdQvg/u5tg5Zr5Kc+RPgj8fNlljILeT4MIkTct2U
         j3Ltz1p6X/492GkDZmXazdxsuJLhR6P3W9eLAbJhpjsuWYbGW2g7eI53cRn5nNet33eB
         Wn0g==
X-Forwarded-Encrypted: i=1; AJvYcCUYGxBs2Zp4gn2urI678J0MKQidq2Nz9D+FJkTZhnVbjZibyM4zIEuPWH+pxnXtyNqcPUhT/XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBzevdD3z/A3LXC5u0rmUtZ3Ld5Fcv1wr7bocwMaAKrOm4xIqz
	22GOf7CUUlhsxuPevE2jp7dJQ1PNbnDQwyTdAX+c/NfNkYSah/gPvJZb
X-Gm-Gg: ASbGncvA0AGMtg3Xf1b3CZVzVIqS7eBkVkEe2qc1Lb5/vKxFueG8hDOZIzcXtBROf7g
	lOtivhFfQjNICc9eMCQLktrKcs98MbeP6xKJT0GxvYzndbbpVkcyX0IGGb/BicFzp1MEV4o3HDE
	q42NrO5Y1bFPe/35bhkSAoqdkCEYO6zXhFwb0QBXeEpTS2t7Us/kYMC6SPg3dUiZjfc6n+kBP0H
	ULtQZwFpnMuZkQBSQKgSxks7cZ87O81e1J2LRCRQKOfopVXWRB/mqNs9RvhL+LLpKRb7AAyx4Rv
	5C3PrB51/4spaBbTuLFwORRr93K9TcboQNTwHXpJzyetrOQEwewoLWicWr2CGzXcOWRQyrVJ0o7
	U5+0XJTdXCFSLkFOhAQmEIccFFD+iX1rF0cDTYVM=
X-Google-Smtp-Source: AGHT+IF+viCic+ce8WWlaH+bh8xCfkA7X0e9kF5ARabZJMwkUA579Yu4S7oicXz32XBh58Q8HLg6Qg==
X-Received: by 2002:a05:6902:3006:b0:e84:2001:2779 with SMTP id 3f1490d57ef6-e87a7c02d9amr6516353276.43.1751122171068;
        Sat, 28 Jun 2025 07:49:31 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e87a6bf02bcsm1199359276.50.2025.06.28.07.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 07:49:30 -0700 (PDT)
Date: Sat, 28 Jun 2025 10:49:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <686000fa42469_a131d2946c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250627200551.348096-5-edumazet@google.com>
References: <20250627200551.348096-1-edumazet@google.com>
 <20250627200551.348096-5-edumazet@google.com>
Subject: Re: [PATCH net-next 4/4] udp: move udp_memory_allocated into
 net_aligned_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> ____cacheline_aligned_in_smp attribute only makes sure to align
> a field to a cache line. It does not prevent the linker to use
> the remaining of the cache line for other variables, causing
> potential false sharing.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

