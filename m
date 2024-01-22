Return-Path: <netdev+bounces-64742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832E1836EDB
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E911C29557
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E1633EA;
	Mon, 22 Jan 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQfL5y08"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B963126
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944346; cv=none; b=o7pA4Am3Vl80psx5AddBHrVjbUSeGjPHarIT44SK3jJaXd8FO31pP1PRPnAQWRGCYvUbYFSATqI0WT3CrwJvlHoIk1WFeOq04cktFuTw1Ilmwqe1fwgBLh3sXbWo6AWLLDeh/TgJ6vkjaFJRknMt/hWYY4q2vzBXuV9pj4gCXbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944346; c=relaxed/simple;
	bh=3sGXeiivTilxtVUp71x2VGRYKeQQ4fhnGnxW6ZH6f+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NChGHlRmSjBADIznfh4FyEJ2UY7nYXpC7s9ZTYpIA74qabdiPycVxEh9W2AjH13gz5WxvUquLDGs4FKFhM4rdsag1YnJ/0wWBS4cldfYRUomTKgKUtKWpfOVN9WOwxd7bIxnECTQu+ss8rrO2kxd4aRyO8Q6otl00hnNAJxxlvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQfL5y08; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd9pY0tcPu8z1nTQGu9bLLHVmCLY7vOqjM29u5WUgOY=;
	b=SQfL5y08bNmdj7OEe0S1pJ/rIksFocdao3p/8btJ3hzBEPVVfmpsZm7hfe1P9Et4r7AvgU
	xdGKLgs+9QeZHuh2MuIcH9D3oq95MYSelVPwOR1uFrTK19K5RaPA7anpDQiF4B/mgz3aZv
	duNxd9MmRfTAZt9KTEQYCyCf7/39Ifw=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-j0zPdTeDOKW9lCcIhE8GjQ-1; Mon, 22 Jan 2024 12:25:42 -0500
X-MC-Unique: j0zPdTeDOKW9lCcIhE8GjQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd3b54e5c6so5263260b6e.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705944341; x=1706549141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd9pY0tcPu8z1nTQGu9bLLHVmCLY7vOqjM29u5WUgOY=;
        b=hJCFlFqkjLmxU0ej4MAxA/TcEFYe3Dz0P6+J4Ucjm5CB6IqLgGKYwGbMblgr6DxYpW
         wjRHDzjFGR4MKxyQD/Z06+X72lVpRCbOrVpm0MW6VKoqUtq8euVMc7WNa6p3p26LtLLi
         4DJodfzLF4UWmYhzC2wddOllWKi94o6uv5rRw+87Ddfv9wcjQVcTy5eiv6gw5c7MYCJz
         HM+M6cWam8Y73Lxgkp4Lk4s9GMcBq+6MJyZizJwnbL25YA87JvETTz8ivAQ4+A7cp2IR
         jeapDAqjR+YuYXsgcEX4CR7zM1/qmuAsM+Ns91yP/XvgMdJrM2C01uVbIRP3fFJOQTjh
         9FXQ==
X-Gm-Message-State: AOJu0Yy4541bBOMNt4QIj3Jb4g9aLRJC6mep9qY+TQ+r1/8XYkQfbXJU
	XpH090ThzJf/9gzKgw5fHvcsDnlRDnmfF8pDhErbK/PdzC/iVc46L9N54Gux95JKZpoeZusG/Qj
	OAEfbE3GsAi1/fXNbgScZXGxilupuHekU4E8CeRTH/9ElLprNiRpk/A==
X-Received: by 2002:a05:6808:238c:b0:3bd:be6f:b7f5 with SMTP id bp12-20020a056808238c00b003bdbe6fb7f5mr967998oib.21.1705944341759;
        Mon, 22 Jan 2024 09:25:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCfNfofGQFRbQaVFCLOzjN+6IyQaViR+fAh58sgihG7AL8NJ43ne61ciig+ejSjGqMLsUPoQ==
X-Received: by 2002:a05:6808:238c:b0:3bd:be6f:b7f5 with SMTP id bp12-20020a056808238c00b003bdbe6fb7f5mr967988oib.21.1705944341561;
        Mon, 22 Jan 2024 09:25:41 -0800 (PST)
Received: from debian (2a01cb058d23d60079fd8eadf0dd7f4f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:79fd:8ead:f0dd:7f4f])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05620a319a00b007839441b69dsm2026510qkb.97.2024.01.22.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:25:41 -0800 (PST)
Date: Mon, 22 Jan 2024 18:25:37 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Martin KaFai Lau <kafai@fb.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 7/9] sock_diag: allow concurrent operation in
 sock_diag_rcv_msg()
Message-ID: <Za6lEehyxGkwlWD3@debian>
References: <20240122112603.3270097-1-edumazet@google.com>
 <20240122112603.3270097-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122112603.3270097-8-edumazet@google.com>

On Mon, Jan 22, 2024 at 11:26:01AM +0000, Eric Dumazet wrote:
> TCPDIAG_GETSOCK and DCCPDIAG_GETSOCK diag are serialized
> on sock_diag_table_mutex.
> 
> This is to make sure inet_diag module is not unloaded
> while diag was ongoing.
> 
> It is time to get rid of this mutex and use RCU protection,
> allowing full parallelism.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Guillaume Nault <gnault@redhat.com>


