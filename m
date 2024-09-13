Return-Path: <netdev+bounces-128091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A81977F32
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA681C2205D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41681D9348;
	Fri, 13 Sep 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqnwkAxG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252181D86D8
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229023; cv=none; b=E4CRyIp8qaIC4PhbWJHw8NjzNdqJQGMjhlXQULHFZx7f710nyqra2UsrLFzrg76k4PVs7qqgrkD0s1kW0SsF16teYHd9fU8bk5M0g24oL0dj7V8Bmq1TlQRGtOaN2PC/Fyfe9NwTO/1btTWODr3DdI7k7ub4QOUW+r7TaOMx8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229023; c=relaxed/simple;
	bh=9ng40oYAgRV62vDU8LkffBGgKUXp5k6gcUL9UTEfGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2F+kalMaB4YCWfonrVsfpViOSGJl4qn6MlRyuM17qP01lToNp5d4TIaVB5KdQWpB4IoEa3AwmXVMTOHfhKGrsVzP4jkigxk5A4lp5IG8ld0f8uSFE5kIycz9A2DLaAw/pblsXVca4rQ/Pn6oir3Tred+mqrwa00mwwnkPYk1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqnwkAxG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726229021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/qGbd8bqgZoV5GwVi3px8eV61nhOypciW6N1GHtrHxI=;
	b=gqnwkAxGvDB0kvvYFaPM84A7mPITmmWK/DU9GSyjkqvOP3XEjWA14NVPCznyboZLJTkZTy
	rSOLXde/G1sn05mrhLNpmrslFIKXu6HZ7pqJT71i70QDeW2MW/ejHTIzPAdXOcmrzHyLZ9
	GlYfYpJVUWyWK4Oww4JGb00rb2Y62C8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ghay2b80Ncyrw7XhARDMpA-1; Fri, 13 Sep 2024 08:03:39 -0400
X-MC-Unique: ghay2b80Ncyrw7XhARDMpA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3750b4feb9fso1024458f8f.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229018; x=1726833818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qGbd8bqgZoV5GwVi3px8eV61nhOypciW6N1GHtrHxI=;
        b=IMb9eD5pdJwg5WjJLRMYIRlS8X+YfdBlgLYk7hx5xG9x56M5WPejIXzrmcPI4uhl3r
         7SCb6FLoodVt5AFH039bl5lIDO3ur+JmnHQbyuHXyjNz/4LlBCFEvHOubBcY9uVjzG6M
         Fpv9qZ35vZugOMsn8iHOL1t1pS3f5Q58ReLVXyyjRm+kCiObuw0VnKAeDz8qssa9V7l8
         fmEAMt3zyHVmjnr8GYvHH9uwuQ8m/mmC5RMN8WwEz3AAnaFnLhTaj5XNCioFnc6mCvUl
         s0O3KE2iGG1KhLTp28040ZlwncCT8nG7tjgkLJbDu42+R+HOPf7/qq0su+AXM0yqwgMq
         HdHQ==
X-Gm-Message-State: AOJu0Yw1QpGHV8bbeHJc2zQ8eqjhggyiWGno4ATweVFvt4mQuu73gZEy
	eXyDcO+BAWY8Dok6oMlq4JKvy7Q0wguYItPQhdmkSUY46nyxTHAGLJSgh9MOMg+fPhnsE4/jwpm
	zqJCLAhIhkoZQs9c2v0V8e4nW5BkGJHkYcWCc1t3BCojYmeXnYJeZ2w==
X-Received: by 2002:a5d:6d85:0:b0:374:c3e4:d6e3 with SMTP id ffacd0b85a97d-378c27a258cmr4698815f8f.5.1726229018549;
        Fri, 13 Sep 2024 05:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxearb4HlVaXXsJRkbiDTagvRnei2oGV5VLKRtSVw6kXChafcExboyoB/cqdrTPdFfg5MTmA==
X-Received: by 2002:a5d:6d85:0:b0:374:c3e4:d6e3 with SMTP id ffacd0b85a97d-378c27a258cmr4698752f8f.5.1726229017404;
        Fri, 13 Sep 2024 05:03:37 -0700 (PDT)
Received: from debian (2a01cb058d23d600f8cdc4d4209368b3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f8cd:c4d4:2093:68b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378a72367b6sm11073692f8f.52.2024.09.13.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:03:36 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:03:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 1/6] net: fib_rules: Add DSCP selector attribute
Message-ID: <ZuQqF/UN0ZeXZaIi@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <20240911093748.3662015-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911093748.3662015-2-idosch@nvidia.com>

On Wed, Sep 11, 2024 at 12:37:43PM +0300, Ido Schimmel wrote:
> The FIB rule TOS selector is implemented differently between IPv4 and
> IPv6. In IPv4 it is used to match on the three "Type of Services" bits
> specified in RFC 791, while in IPv6 is it is used to match on the six
> DSCP bits specified in RFC 2474.
> 
> Add a new FIB rule attribute to allow matching on DSCP. The attribute
> will be used to implement a 'dscp' selector in ip-rule with a consistent
> behavior between IPv4 and IPv6.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


