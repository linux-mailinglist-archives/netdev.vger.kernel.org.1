Return-Path: <netdev+bounces-122399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F13961078
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3039CB21D36
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397B1C5783;
	Tue, 27 Aug 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh5z1wND"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5F12E4D
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771352; cv=none; b=cL47UchOWzZdog1XusLIMZxWYN1zDmd6QpasOlvOt0my8NtW1/J+C6HmhzuCmVx+RnfRmoi87pWhwkVNNdp/d4gQOjWTieK6D0fPFCExDclGCbpLJjhtrdManKSDa9qYvWiu4PUdk+PSk5Nya48FtpM8yW+38hsTJfG3JzL2T4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771352; c=relaxed/simple;
	bh=sbYHocYuDiWoFpMIwmfYHT3Lra5AGZauU1LdBps54Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G57gqwAwFLXSp9yIFS7EdVbaMOemiZNgbOReixhDVxXhPsJTduYsarKZdm7zGVBY513r1b3fp0x0IZT5wNzBl/wIGvECwK+X3POiu+tjiRvLyC6uqcvxdqvRSKLRn+2uRyOPVQsFXU+Kd7j6n1MxS6f7tN56OQY6fBvmp258OMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh5z1wND; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724771349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg51UQEdNrHqPKausCCH24BO5x8BzlOc9BYF/ReK8EE=;
	b=Gh5z1wND6qjmZjp11BcU4tt0cqizwh1CwBsPSs/QWSpT9va84prNaZblGFSgtmdkndjaU8
	TH0vuW6maYlaYkkQzm8a2lYlPMP5IItjXus/EJ3eiy8EMry6XhNbM1AWf1RMQ6JSr99qT3
	Th6LSorNkXCbeA6wgY1aDLlJgcbBcsY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-8_H5xRM6M3qZW5AZlzjABw-1; Tue, 27 Aug 2024 11:09:08 -0400
X-MC-Unique: 8_H5xRM6M3qZW5AZlzjABw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-371845055aaso3270662f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724771347; x=1725376147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg51UQEdNrHqPKausCCH24BO5x8BzlOc9BYF/ReK8EE=;
        b=AnBJTg8DEJxBPvoeWoZQrv7kgn7C+O4MDtj9S8WOtnCiooPpLgACfZzth8g9oNZONH
         +LuQgbNh9iEEW0bpuvRkBTO4UYpt6/PqiVZq69tk8US3weOKgdeQJc6vGSdcWh/HdPi1
         lhglcLEC2YPaJLr+4a5yNMZW4mA3zWg5CdbmlZD4Tp9H78BNCzZ0N0eaFIKFu0RO7kHM
         WiWb9LS0KlnScKp0EqyRqrdkGYe1xySP1stW6ftQql/KsRxD119/xiUEGl69fVnd/LCe
         DTtLC7iBvRi/f/qsFGsmC5belgvh/sWcjcSL/FwPFfFJWOZ2xseOf+9Gdcx50HXQg9Du
         X9qQ==
X-Gm-Message-State: AOJu0Yy02od5fPctoNh+kwRHLMJ7a4Z6djttRgL7n1edxuHRbVi3WOKY
	xKN5QZffCKBALPf0hv+3UFccVzQ8MlIsdrvxKwx6+Y7REz06rNPI/04BtJGnWtYR4bx6HMHK6LM
	dcscNafUsWzVB5+qwBBY93xC/sikF8csA0OhalvYmpHz1S1P9fwdoyQ==
X-Received: by 2002:a5d:522c:0:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-3731187e538mr9224870f8f.1.1724771347219;
        Tue, 27 Aug 2024 08:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY41EHXwRcF9MYj3dYFX6oAp9OXMv/6nLWdnYYYk5WThZ3Z+GfFjwbuvWSSFeuWlVaykrtqw==
X-Received: by 2002:a5d:522c:0:b0:366:e7aa:7fa5 with SMTP id ffacd0b85a97d-3731187e538mr9224835f8f.1.1724771346333;
        Tue, 27 Aug 2024 08:09:06 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff5d0sm13451519f8f.72.2024.08.27.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:09:05 -0700 (PDT)
Date: Tue, 27 Aug 2024 17:09:04 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] ipv4: Unmask upper DSCP bits in
 ip_send_unicast_reply()
Message-ID: <Zs3sEHhFKIyyY9NJ@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-9-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:09PM +0300, Ido Schimmel wrote:
> The function calls flowi4_init_output() to initialize an IPv4 flow key
> with which it then performs a FIB lookup using ip_route_output_flow().
> 
> 'arg->tos' with which the TOS value in the IPv4 flow key (flowi4_tos) is
> initialized contains the full DS field. Unmask the upper DSCP bits so
> that in the future the FIB lookup could be performed according to the
> full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


