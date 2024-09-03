Return-Path: <netdev+bounces-124619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA296A391
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A791F24FC3
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77901189516;
	Tue,  3 Sep 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RI0CDY8t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433918991A
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379409; cv=none; b=S1XFN/72eDFP6v+X5szWe1JYsk4BEa6YPH+5Liz+sR0/TgW5tk1F3jHRDjZgllZmY3621YRvZ7aEsfYEwh/gctIg5tg8/jCWV4EvsO78DUM03TMyjRHjyk0UaJ29EyBh2Go2uKRdD7QRw7A7etoaeqKVOn6aF8VxweJj0Rhj68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379409; c=relaxed/simple;
	bh=3IvJSrBYxVN8dC86n/L5zD6oHtI+vPQnUe0Qz97ymvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab63a9cJwzKK+3ch+m4x8IXUAxNZqL5gmUP8sSeAWcTdXMsgGyE9CVLoB6Uf7gR1mTS93mwBHqO8lcdEF9KYST8WTKRdKwoRAh1EAXri7Xsxzj+Xq65v3dggl3FM0ZkoCjBYp8IxoeogzXJiiBAqjNYTCH1rlrc0FfHEgorKDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RI0CDY8t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725379403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IvJSrBYxVN8dC86n/L5zD6oHtI+vPQnUe0Qz97ymvI=;
	b=RI0CDY8tKv7QwL4CrhZhuLQzEZ4cnb8FKP0Zm3MP06i6qGaVxlExG3TU/jsp+pNIeMHHMa
	NnegqmUK1Ge+npYANv17xc+h57zO87wJL3HsDKi4/nMx8z+tZUsd3wzrcjkwxB92I8+gDx
	eqXYSi+fyxTNWdWp7Xy66Nh5xLJA+fU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Eipo7XJtOZaxDs3z-RmcDw-1; Tue, 03 Sep 2024 12:02:46 -0400
X-MC-Unique: Eipo7XJtOZaxDs3z-RmcDw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f515891a64so53762171fa.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 09:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379356; x=1725984156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IvJSrBYxVN8dC86n/L5zD6oHtI+vPQnUe0Qz97ymvI=;
        b=cUaxh/5FP/QI0QMXWJXetGNL8ksGVT82m9YPZa9ri3lHP1o3GcF6rUMUoo7P9L9glS
         BNcsR7dKWXeQ1Z1R0QdYVZSER/rutMJPvREPvZ0FxNzult0r9pWpZelCvvWteH99xHN7
         LZtJhzgdpZ0ufX0YX8Lwt3deLpmnUsGeM4FBoY4slX8FJlkrue2LbJO8arrZlTQKflUE
         pvouwAz8f721afyW5XdxJPbkv3Wm0LuDcMuhU3b6GLvqEd+sjN0B0zoCOrX4uKyi0a70
         Lf3tqqMiDyKhcPVoaY+zEtMNiDijyO3DqEoONlETCqRMJUawnviIseKRSxFuT/LkWbII
         tZbw==
X-Gm-Message-State: AOJu0YwRB/fHtmodwgAgXEMDpqHt4ROK6l8dOYo1e8wjzmYPxbb5KJZw
	2aAmSkZpbb10djCj+T1S5AhcBIRMrLk3jTM/ifASG3J6zrE3MZo2ZP+104kYvN3TKkee8mGoJwz
	OIYOUdTxoDC7+OPwe80dxhtu3r1YwHtroACFHhlR14R4PidaNqNzh+Q==
X-Received: by 2002:a05:651c:221e:b0:2ef:3093:e2c3 with SMTP id 38308e7fff4ca-2f636a7fd94mr52595301fa.31.1725379355803;
        Tue, 03 Sep 2024 09:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCIkj+1j3B5tgRkqNDiCuGqjul3hIbjzKGIqKIIx+nPDIWR8iq8GsNl8OZ3I0Xs83FDegyxg==
X-Received: by 2002:a05:651c:221e:b0:2ef:3093:e2c3 with SMTP id 38308e7fff4ca-2f636a7fd94mr52594381fa.31.1725379354665;
        Tue, 03 Sep 2024 09:02:34 -0700 (PDT)
Received: from debian (2a01cb058d23d600f5dfa0c7b061efd4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f5df:a0c7:b061:efd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df84b9sm175745215e9.24.2024.09.03.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:02:34 -0700 (PDT)
Date: Tue, 3 Sep 2024 18:02:32 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 4/4] ipv6: sit: Unmask upper DSCP bits in
 ipip6_tunnel_bind_dev()
Message-ID: <ZtczGFcrsh/3xXcM@debian>
References: <20240903135327.2810535-1-idosch@nvidia.com>
 <20240903135327.2810535-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135327.2810535-5-idosch@nvidia.com>

On Tue, Sep 03, 2024 at 04:53:27PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_ports() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


