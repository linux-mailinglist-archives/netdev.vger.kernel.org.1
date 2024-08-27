Return-Path: <netdev+bounces-122358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AED960CBB
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CCD1F23102
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD361C460F;
	Tue, 27 Aug 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awqkCmrD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A8D73466
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767049; cv=none; b=cqDbMdki/1BhFIVFR21YvQlF5A8fxORs6RBTW4aFVDEzW+m6wUy0JcZnARBPlz/djN+awLgIfchW56SQsZWvnXDFFo42Oib+k7Brewq/fzvgyqT1xiqXHb/w5Xr+h5zs8P8uUzI7PWyg4srAzPxWTIOsEID5sfTZxxHQa+A8HWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767049; c=relaxed/simple;
	bh=50VGgfJ39Vn095GKRLqCQYnG9dPP7cqRS8ayEwj0x0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX2rTufGQ03QNRpzmqYpJxnrfVv/ZrC4Q72ichIcgq3rYEnAcHWm5VQ0mqlpNom0nvlG3boZuidk9k7fchowOTOVs+U6Y4caJ/DD6XLFiqae+BTRQeRLMfWdDLJlPdF34juPyTVa82rPgHOfS0yPQNYSX+I/R/hfuOU94NZcRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awqkCmrD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724767047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50VGgfJ39Vn095GKRLqCQYnG9dPP7cqRS8ayEwj0x0k=;
	b=awqkCmrDz1Xd6FQz2zhAs/J1rl3NTXO0mMLzlSlMABgFXzkbUv2xlEvRWtpnO1sjbjqI6a
	68o1x08B3wNIWEXKH6FEI/oOh4yWFMXd+/ncwkiboxD2MUwu4j219ahc79p08QJ9UKbBLK
	LuS/XCzzv1dk16Kf9m0ch8/N+U9sy8Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-3r1g_mKRP_KdRvPc8kQDJA-1; Tue, 27 Aug 2024 09:57:23 -0400
X-MC-Unique: 3r1g_mKRP_KdRvPc8kQDJA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428e48612acso60669265e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 06:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767042; x=1725371842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50VGgfJ39Vn095GKRLqCQYnG9dPP7cqRS8ayEwj0x0k=;
        b=fZpg62IG6DfwYF0OBl4rercraRcRa1afwuJ2+6t4cc7ylppkGWGI4N8S9Hj2EJspWH
         fynomEIspACtlpcs9vzA1yHZwQjBj4I3dzkCl5uTKA44/g2U5kE/OlPbXe+eQvMcXvB9
         VKeP5tRqVJH9oI9ECd8uD59+oJ4jz+StrBONgmGhjScKw2ZmdXuNTT497mjiFWFsc1Kl
         QuPYIQJfuqK66rdTIloTEzIm/Et3BAX84tNAO9NAf85pGH6JgeGSc3UbN8Sud2ilpXCM
         CpVYDTgvihvbEovuz+na8lsWtT+SuvrD4owi0NstjL8/CfUQgfcbY8WEV/nY+vWkE1q4
         wK6w==
X-Gm-Message-State: AOJu0YwKxnGTHnLtmZagWLOB08iDXHu2R4raKe2HKbvky1C2hfzmlIHA
	o6+vvUUyPmJYm7fDnj+WfONfmilwlscE+rs+ww7YwdsPi89dhCUg73aKujXwYTD2aEzbU3DA447
	HxwQr2kN6w9tWJe9kcpgowSUhp8t7Un/lH+EdXqaEhKE7Gv278J3SSw==
X-Received: by 2002:a05:600c:354a:b0:429:d43e:dbc3 with SMTP id 5b1f17b1804b1-42acd5e7513mr114490945e9.34.1724767042672;
        Tue, 27 Aug 2024 06:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxpsjaqSyA5LuzkxA9XJ4emA+wSpbmgWayC6kww92lxBE+u93eN4thaAxJMWp0dXVk3KhlTQ==
X-Received: by 2002:a05:600c:354a:b0:429:d43e:dbc3 with SMTP id 5b1f17b1804b1-42acd5e7513mr114490465e9.34.1724767041926;
        Tue, 27 Aug 2024 06:57:21 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817a5acsm13174367f8f.64.2024.08.27.06.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:57:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:57:19 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] ipv4: Unmask upper DSCP bits in
 ip_route_output_key_hash()
Message-ID: <Zs3bP9fFt1z4RJek@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
 <20240827111813.2115285-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-3-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:03PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits so that in the future output routes could be
> looked up according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


