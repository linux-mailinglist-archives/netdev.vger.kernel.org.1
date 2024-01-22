Return-Path: <netdev+bounces-64888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF245837594
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F94B1F2BEC7
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0993A481D0;
	Mon, 22 Jan 2024 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQ/eF/ZS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108E3EA95
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959871; cv=none; b=oYddhr8srxwPtg0s2F7AX1wQ8vG/kzIOQkIq1AenRGrOVp1hpUneYPMbFxZgnboKySUoSNuwLysLTaiffyOERZq1Ca76mep7ILE8qVqrJ90Iuw0T6eR96RcwQPx7BPE0iM47T1Pbov+bOh0uHwp1JgjnW296EXn6kdC/4mPbuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959871; c=relaxed/simple;
	bh=OnaVsuJ2eTrsOW2eX2ZsStahDMb3BDYaCGq1vSWSsIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO6RuHkxZ2pGgBXtSBeYnxAqufnIQBjayP9oe+B0Mbft8BBsHS9Q1WU8OIO2kTeFbjNap5qMolko5GC7QfcXcwW1wBVmti0qQWRoeNzDMFPTRnjH9TrHSwz0nOQIknTGfh1A/Q84IwrrMITYIK/+6qL92grA6SuJAOxu4L0xhek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQ/eF/ZS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705959869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTA7X9tYRVaCQxnz75s4KQvy8kumvksC7rr7nu7TkuQ=;
	b=PQ/eF/ZSCp0MLW9Zpz7rpfOmRiKh9SbObhvu2oEynCUrKkEL/ZS1a09LP9ZhS2ojDx5Z++
	uSi5j7b8yquUyID1hJiI0ph5wesrrmtnHHfREURyyVITO/7chuqwp6e7pg9nGEhwuCGY8V
	hBDeBOoFlaJ5bxykzQRBS6wDCXTF8cs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-obDiZeOuOiS25ZxQYec-SQ-1; Mon, 22 Jan 2024 16:44:28 -0500
X-MC-Unique: obDiZeOuOiS25ZxQYec-SQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3367e2bd8b0so2682478f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959867; x=1706564667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTA7X9tYRVaCQxnz75s4KQvy8kumvksC7rr7nu7TkuQ=;
        b=mzMWyGnf+Ww97YGG1Wy5JfvBUJuPMCCDC8r0lG//c6p2txDPKTqLCkQmWYIM2nhMvo
         muudMkTc2Fps9inH2p8aMqdV8DpeTMsCLJ3wFf1R98Aner1AQx3TKZvrXOK5Bixbyfw9
         f3gDBiBC5KvX4UfnW3GCd5a7G+AZ7aStzMgFHzfiTobj6tFsgAjhIm7Av7dpcoqUiDB1
         Rw4Td/cAu/WgmvtQBo2JLbTnfmvP5cqCXpCgUEvEnkHWsy6KsjzNXIiy9/mQRm3KM34d
         36zadsqHrt0DFhyY8c1rD656cVD3oZHpGOt04zkwOqxVlCMUw0yKk1xNMc7Ci5WNKrkW
         h+cw==
X-Gm-Message-State: AOJu0YwWqiPguSzA9ptex4qVoKG1I8n5Jo9v2SJtcu24L7eRJ1xBYsy6
	IGVsGXE1QjUgWN6LjsTan3fteaSubyAp4/l+/ywPyeP8pa0/GdIk+d1AOaM7kwzuKCJcUoSbjKk
	VZxMUb6ymNzB0ZYRbmHSJlScWQYmtIpp9NveGTKJ1JbSD7dyZysZhrQ==
X-Received: by 2002:a5d:5f8c:0:b0:337:3ed6:8697 with SMTP id dr12-20020a5d5f8c000000b003373ed68697mr3422224wrb.90.1705959867052;
        Mon, 22 Jan 2024 13:44:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZUqT5N+43v3469ML+ldsst19EUQegJa7GxBB/IGUey7MxIMivH4Rv0qjcoaxcCGf6bHBHkQ==
X-Received: by 2002:a5d:5f8c:0:b0:337:3ed6:8697 with SMTP id dr12-20020a5d5f8c000000b003373ed68697mr3422218wrb.90.1705959866712;
        Mon, 22 Jan 2024 13:44:26 -0800 (PST)
Received: from debian (2a01cb058d23d6005fec131dfc58016b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:5fec:131d:fc58:16b])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d4d91000000b0033935b0a0fdsm4093802wru.44.2024.01.22.13.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:44:26 -0800 (PST)
Date: Mon, 22 Jan 2024 22:44:24 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 9/9] inet_diag: skip over empty buckets
Message-ID: <Za7huFhYnIydYK9J@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-10-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:26:03AM +0000, Eric Dumazet wrote:
> After the removal of inet_diag_table_mutex, sock_diag_table_mutex
> and sock_diag_mutex, I was able so see spinlock contention from
> inet_diag_dump_icsk() when running 100 parallel invocations.
> 
> It is time to skip over empty buckets.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


