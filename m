Return-Path: <netdev+bounces-128103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E78978081
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 14:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBADB249FD
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C911DA607;
	Fri, 13 Sep 2024 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgkE9xCM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38C1DA613
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231938; cv=none; b=rG0HwGpwk071afHYhdsldLW5mYJFe+pRA5Ogmlp+SQlQurkXfTHeh7LauaNKtiKzBbz9Ix01Q08xGGvvU0jFypQszdCqMe6yMaL+JVke+fAU2DRJnJMJGCTPVFtdyKt1Vpbjd1BxYFoikMKCQ+fB9U/zFuqNFqZ4cQDJFGoE2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231938; c=relaxed/simple;
	bh=p0uA9UaifAM8/aDvbCRa9Ilx/RNI84JMgLeBv1uBwWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCVaelBZ/erEpSfde2PhVADbrp5Zfn2j7lM7VojXJWpcaM/C2NGJUUni8fFJ8DnoBACkHdEmZ5eT/aRZRymIP71IIXWdZwtsrffDpA/mZt1isWdRPhAXu0slQ7wu2Oei/WmIA0/0zPMGaoFyA6ZQx4XGmbn423T3bOph0dP99pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OgkE9xCM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726231935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0uA9UaifAM8/aDvbCRa9Ilx/RNI84JMgLeBv1uBwWI=;
	b=OgkE9xCMBCzgl+Hh+RE0PG+RP7eQ/3XMChpkeZhu6CdSldVDXyqIw9lWv4+9LFAS/Ye+S5
	ICsx1yfjJv6N/WTvRX9R4BtSrQE5S7a89tejbcNw5wdtdh5PQ6JA0YqLAkR5w2AjQnHsik
	G0OW6+oQyDAhKDOm9mxzTtvLwPsx3ZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-JSJNo_nnNtaAb_f7_xcDEg-1; Fri, 13 Sep 2024 08:52:14 -0400
X-MC-Unique: JSJNo_nnNtaAb_f7_xcDEg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb115566eso8552615e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 05:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231933; x=1726836733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0uA9UaifAM8/aDvbCRa9Ilx/RNI84JMgLeBv1uBwWI=;
        b=F0rPEpw6kiOa1ZDiksTVJLW7Q/utVXnkdJLFGdyjOGuY5fytg8Kd6h9pSsVItJul9G
         mk7+cvFypXz4HjHQh4aWvc4d0wfzV8IcHi8kHR7D/HwVS53oc8ygvMitA2nMq50fHD5e
         d2aRrKdEggSNBGM7Vajg5yyTkX2TY9+oMS1DUdq5ZaswW+XBsPSXIb9KB4gkipOHP2Dy
         M/ywD0APhyz3yzosCl8AP5ZfkBk9nqrwF/wmp6xwwlfdL5n5nfVgKHxF6SG1tsDGT29k
         nFM5OKXDNTDAmGwC2HaTTpk7q6kwvvGofWZ8bRc3b7+fxgFioW6ohZwhNgDK/xzO1J7I
         lvXQ==
X-Gm-Message-State: AOJu0YxiIpoP5rALJoED+ClcH7IwfJt2qfOQ04j5A1I71/9K9agVTRj7
	cHUlg/pVvxnRcCpcMo/Wf48Qy4f2pv7I0fb0gTM01SgZBBsamx5z1z9cKW33blcg/3N2XK1kjXj
	CPMX8XfFipR1oCQGeOSqfOj97FGb6C8qxTfOBMP9jQe/mszufGmHGgg==
X-Received: by 2002:a05:600c:3b23:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42d9082739dmr27845195e9.17.1726231933361;
        Fri, 13 Sep 2024 05:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHEzFgiGx9NhRrOKJq0VpOGAlJucJBj75q3wBaM2NjdXHLjXKrcYKaydAaRDuAtx5a30vtLw==
X-Received: by 2002:a05:600c:3b23:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-42d9082739dmr27844435e9.17.1726231932171;
        Fri, 13 Sep 2024 05:52:12 -0700 (PDT)
Received: from debian (2a01cb058d23d600f8cdc4d4209368b3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f8cd:c4d4:2093:68b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665babsm16915374f8f.47.2024.09.13.05.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:52:11 -0700 (PDT)
Date: Fri, 13 Sep 2024 14:52:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 5/6] selftests: fib_rule_tests: Add DSCP
 selector match tests
Message-ID: <ZuQ1et36Jd8R/cGf@debian>
References: <20240911093748.3662015-1-idosch@nvidia.com>
 <20240911093748.3662015-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911093748.3662015-6-idosch@nvidia.com>

On Wed, Sep 11, 2024 at 12:37:47PM +0300, Ido Schimmel wrote:
> Add tests for the new FIB rule DSCP selector. Test with both IPv4 and
> IPv6 and with both input and output routes.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


