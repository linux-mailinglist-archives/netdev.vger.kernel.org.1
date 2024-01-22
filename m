Return-Path: <netdev+bounces-64733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4A836DE3
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218021C27069
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB64174B;
	Mon, 22 Jan 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iomCm1JM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629D3D573
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942698; cv=none; b=LMzR/KRf2LD6nV5TPUQDY/4qhN7KVN5Hq3J0h/cMT8u5Mx7jJP4wV6PxBrOaj+1vhGUFLLU9Iqvil4leyG0p7qQHDPN0M0h1hzWng8xyP7dx5Rs9UPnIkJzh1J9FeX8YmbwH1+FgW/PJlRUt1VV6NPysJE0lX5ZHvOIHDmuDemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942698; c=relaxed/simple;
	bh=TThDKN+hytSknlEQ90UqQuDvQ0bUOYizIRw9WaAoHKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEV21xSLgrkgi/vyptLNis+d4Y2W2VzWlsrp9ob7CQ3WmYc/K19voI0I4xpBeB1S27/nsXAdUV7X+ttQ+kFc3FiCWKxJpFnaZ0LSO0gIAPWhNU11e2He5jXXfdtGpADEDN/a/MpdTZtZY54XYasc5zL/Rs01Ix4zIDqp4dglU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iomCm1JM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705942696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UD3TaVQCq5cpcvHo5x1gtqreooSr4te090bQqv+Lxac=;
	b=iomCm1JMn0xT8RIm4jEKggHqHgjsy5FfW6iDfC+cReScaOMootaLmgLBxrT68ZK99H7DfO
	Bn0qn5ivw1xuhYO9XpVgKwgds0+b8pufvwV/JYkmwI5kg71oxr2Escs5kDA4OgJT1r9a65
	8NMd7cHevH67bkgkyhetOoyGUdxXg4w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Amd23FQgOXeAkRBlYPjzcA-1; Mon, 22 Jan 2024 11:58:14 -0500
X-MC-Unique: Amd23FQgOXeAkRBlYPjzcA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42a2e2d7469so44608791cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 08:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942694; x=1706547494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD3TaVQCq5cpcvHo5x1gtqreooSr4te090bQqv+Lxac=;
        b=CuzYkjfHVpx4lVog5+yv4r5GHp/5hNAqVxYyJa/k87jV4tCCwDKxU7WyzdTotHpTkv
         er1Nkup1pJcu/0CDIvCTPtiaksPTY4E5LLIIXF6gFmWzzoW42rMGc8gYmjIZo6YLzAKg
         DbdzztgPUzDIQ+faPjaesXGpJevfTV/bzB1pS3SScEFPFiXkhk8sOJuIjLTWJXcdIKyP
         LwbCqCHa8HHCn/hnUkAm8Iry3BDgzB06eq3VmP0p/D8DogDsS66PV+3mS2HRjFZ0h7mC
         7ZvXJNYl9SV4roGVTKvwf8YhLDsga1rG+82iw+Gby/MNY9Iasdnb3sjAlvNjyuVpFHdQ
         tO9g==
X-Gm-Message-State: AOJu0YwJDXbiKLND08sy1or914or43fqPeao5u3GD/zlPdvfoPr66hSC
	9eSNmIYMobqNIV7GRiqAOyZEbdja1XGAA56JCqPyZIsfovChEOzR1xHYMFpOAPfMnxVRD6FalYK
	kqibz9azf3cyfWpqjSsuFWV6P4bsDLvM2g9ZeO4TrBddI60oYQjXRoQ==
X-Received: by 2002:a05:620a:3916:b0:783:3646:ea43 with SMTP id qr22-20020a05620a391600b007833646ea43mr6480274qkn.13.1705942694206;
        Mon, 22 Jan 2024 08:58:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKTtCibC+sui8cHBqVriiau8UzHM1cQ5XU9grgj3lBsghAPIyGiU8zHTPmlXTeM2dZOPHotQ==
X-Received: by 2002:a05:620a:3916:b0:783:3646:ea43 with SMTP id qr22-20020a05620a391600b007833646ea43mr6480264qkn.13.1705942693984;
        Mon, 22 Jan 2024 08:58:13 -0800 (PST)
Received: from debian (2a01cb058d23d60079fd8eadf0dd7f4f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:79fd:8ead:f0dd:7f4f])
        by smtp.gmail.com with ESMTPSA id bl36-20020a05620a1aa400b00783a6c22457sm118286qkb.44.2024.01.22.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:58:13 -0800 (PST)
Date: Mon, 22 Jan 2024 17:58:10 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/9] inet_diag: add module pointer to "struct
 inet_diag_handler"
Message-ID: <Za6eon25g/DtqHGf@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-4-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:25:57AM +0000, Eric Dumazet wrote:
> Following patch is going to use RCU instead of
> inet_diag_table_mutex acquisition.
> 
> This patch is a preparation, no change of behavior yet.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


