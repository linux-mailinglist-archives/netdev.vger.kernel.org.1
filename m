Return-Path: <netdev+bounces-128104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C49780A0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6CB1F27287
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD401DA635;
	Fri, 13 Sep 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ek1k5eWm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC751DB523
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232328; cv=none; b=oZ5BtcA8xu5CRyBKVhemduJ2cusMW6EVVHSdWz0AarKC2w2REgpg/UYIKpGb7jVDOHtPYBOk7Vg1rgBvr5OQYJXk6Mf/9jKCCFSLry+3+SlP/evpW5Umo2uv+GjolEpPcsGmgvSnXjiad/mIb5HZFnu2XCl/v7suxq8NUoeh8+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232328; c=relaxed/simple;
	bh=E+phHv0mDtJRAqUU9hv1ryQJlJF1CcboASi00lV0PRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwbElwJNcP5d558btvZKDjgUMibIFae4aZERDAkg5dPAmbP3/UxatdZAsBp7k98I17YnJYFiHo1+FrAjuIFplG2x7PGIV/CWynlmPThnlm/J9dO+mfrkiCYz5FW0qVyvZ+SstFgkwo0drAhHtWgSOaa8Uw0pbse+SoHwtFiKP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ek1k5eWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726232325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+phHv0mDtJRAqUU9hv1ryQJlJF1CcboASi00lV0PRQ=;
	b=ek1k5eWmISAqeFkJIVENiL7O7vQ9AC6VWV5LhtdjTZj1QbpZ9YvSendjzKpYKmckZYXKDy
	nCsnenU33tkfp/7eUizvcZIEAko7c7tBz+hCz54szrQcz8wIljjosGbkPE2r+OP2fm/B7y
	IhE1WALvS9OFnO/1p7bSG7CBLz9mybE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Y_ouyX4EP9WQXlTy660ssg-1; Fri, 13 Sep 2024 08:58:44 -0400
X-MC-Unique: Y_ouyX4EP9WQXlTy660ssg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-378ab5b74e1so477415f8f.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726232323; x=1726837123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+phHv0mDtJRAqUU9hv1ryQJlJF1CcboASi00lV0PRQ=;
        b=oWniTPFXSBPD1ouXN6QRQMstMGgRhdK3BRaUcrBi//bQ6sHED05MM6QgfFU1XZ3CSD
         Gd9c3MgOqiXJBtkHsPDxGHxIYqJs+p4UdIFc+70aK/4oWyH7GL+D3G7nGtTQF48ia65/
         By5AjJXTBWNKXxG4JkHpbsAK6RyWruPnCCeeBzyPDNJx+w6v08gLe4j1Wh1hJZJg5Fio
         +PL0lUqYK0a4vtyBra26F4Al98bJsAfe3nnC8IbAhjhXctDqeXotKq8JuQqtOGI+xEjJ
         TIHsSLeYTDJVSMlx1jxXlp6RexvqXEihiPb5mzzY87A7I3rHgpq5ai5igTN1cMsXeMJ0
         BuNQ==
X-Gm-Message-State: AOJu0YwFeFedddpNducED6ikwG6+Vbg63f1lUKh7o+HHNovymnYbRfic
	PGOEI1yhGSkKGMlGWUNnv9nxDShwG2bcExb6fNP2D9QE52OhSxt6pVYWrw1PHtG5JWFHnfZIMQP
	5rKLdmx5Bxub0gLyte1ybGyCHj5cYxvmJHjXwEd0j4lG3UeMbPQGmPw==
X-Received: by 2002:adf:e891:0:b0:366:f8e7:d898 with SMTP id ffacd0b85a97d-378d625a40dmr1546543f8f.50.1726232322846;
        Fri, 13 Sep 2024 05:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI9DhlXBKNgZ3qMGjU7CeLkrFwgBgFmIICJKY4Ecv21ywPmGuNvM4ie24OkdaJl67UC3yI1Q==
X-Received: by 2002:adf:e891:0:b0:366:f8e7:d898 with SMTP id ffacd0b85a97d-378d625a40dmr1546523f8f.50.1726232322243;
        Fri, 13 Sep 2024 05:58:42 -0700 (PDT)
Received: from debian (2a01cb058d23d600f8cdc4d4209368b3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f8cd:c4d4:2093:68b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b181866sm24412825e9.41.2024.09.13.05.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:58:41 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:58:39 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 6/6] selftests: fib_rule_tests: Add DSCP
 selector connect tests
Message-ID: <ZuQ2/6wcVWRSHzl4@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <20240911093748.3662015-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911093748.3662015-7-idosch@nvidia.com>

On Wed, Sep 11, 2024 at 12:37:48PM +0300, Ido Schimmel wrote:
> Test that locally generated traffic from a socket that specifies a DS
> Field using the IP_TOS / IPV6_TCLASS socket options is correctly
> redirected using a FIB rule that matches on DSCP. Add negative tests to
> verify that the rule is not it when it should not. Test with both IPv4
> and IPv6 and with both TCP and UDP sockets.

Reviewed-by: Guillaume Nault <gnault@redhat.com>

Thanks again for your work!


