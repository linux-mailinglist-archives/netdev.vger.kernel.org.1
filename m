Return-Path: <netdev+bounces-124616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F296A37B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B311B23497
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BFC188A22;
	Tue,  3 Sep 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNHop460"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDA188A01
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379201; cv=none; b=ECOo2die12442ZEXyXOy/6/CcvXg3F8d/Lz091wjGzWuSJRyTOxDPFBMxrRUjDsVvy7Zi/aOGV0xiAdVXkdA+s3chJgZiAyb8j6PQ0sf195sY+GT3WOMPiALW/Dpwqlcd+1yvDNwR3l+aS5Uqe4s/AuSr/9OStQRi69jHJWVoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379201; c=relaxed/simple;
	bh=gLfQyFwU1LaaeEDG3O1Ck1oclGi07P/yZbuW8P7qQrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trKCqGAuRxundWxL6Inwz6rYxh8tzPpYUzkp8i0MpK4b+YYgIy7AA8amRDl9GHBahq1jQd6qNWYRYJ5BP2hZxGJQlxkNOLvaZhb3bg+5fLlGQ/7PN5IbLnURzU0ozaMDlCqYN7TZY+BIDlkJkLIfMAN9mSOpkUYCHIuVcYezv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNHop460; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725379199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLfQyFwU1LaaeEDG3O1Ck1oclGi07P/yZbuW8P7qQrc=;
	b=CNHop460kpejvvaNAxAnAQALFuWEWytWZ/QLlzjUJ90snHGGGD736aMMf1O8RI/rcUxIzh
	aO5fQ3OAoIW4ujde7gNSnYRGx+abZMW8rLKObfYwY1Kc43S5mUgdhkcM531DzwvaJEUeOt
	Cp20A+jFAy8lQ74xQprqr4N5hF82UA8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-xm8dh71RP0uW2KCfEU7p4A-1; Tue, 03 Sep 2024 11:59:52 -0400
X-MC-Unique: xm8dh71RP0uW2KCfEU7p4A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-371bc601737so3902923f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 08:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379192; x=1725983992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLfQyFwU1LaaeEDG3O1Ck1oclGi07P/yZbuW8P7qQrc=;
        b=Fh6cCVgQhfg9PKZ8kejwDY5ApI/OWUPbnt9aJDTBj1v1I7gTUxLtcPYfo+LkYuEKkx
         XvkkCwT2PURtMuksTJ/1hxMa6CpBPoDbv8KrudGOE+h/UGCsLWSoxtsRJaWZnGyEhfcd
         K9BN4NgVsYlsCTAHHUjz7GWaQA6XOYd/QOWgW7qO9hasIjS44FdmYjYvg5xB2MOzXKeE
         0D60N08x9W48FQs23ZOyI3adoCosaGFUJ3lbTxME+gYn0fOM2SK41T3qENbmdlejAwPD
         mtBMNM7KfdBAGNEtQvYmKaIzZg3sqinyGERPVrxPL2JqFZVVPmbl4o+O+ULmhaZIds6j
         C2Lg==
X-Gm-Message-State: AOJu0YxQ0G7gImVX68EMa5hOg3Bh20STwhPxs7tzByLZcYFXHTGY05Qd
	n1IVa8oYMACxLKeH+OeulTS1dxIj2+Lv3/fNQH+/l472QkiE/n18nLdTN6tfMcStQcgmm4WReL1
	Rl3Ijz/2otHRURgRYPPJTrvVD/40lymWTUz3DtpmNIHuCZY4V+SLwNQ==
X-Received: by 2002:adf:e592:0:b0:371:8c19:f5e6 with SMTP id ffacd0b85a97d-374bf1c95d5mr8698997f8f.40.1725379191700;
        Tue, 03 Sep 2024 08:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfJ16dgA2GavSpOT051qXOey74Wql1P3sAOnor9DUUMglicU/NZWqBVyKCaEqY9PP8HQzZHA==
X-Received: by 2002:adf:e592:0:b0:371:8c19:f5e6 with SMTP id ffacd0b85a97d-374bf1c95d5mr8698971f8f.40.1725379190814;
        Tue, 03 Sep 2024 08:59:50 -0700 (PDT)
Received: from debian (2a01cb058d23d600f5dfa0c7b061efd4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:f5df:a0c7:b061:efd4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1de81b2sm9092418f8f.30.2024.09.03.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:59:50 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:59:48 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org
Subject: Re: [PATCH net-next 3/4] ip6_tunnel: Unmask upper DSCP bits in
 ip4ip6_err()
Message-ID: <ZtcydO/CPCh8HMwq@debian>
References: <20240903135327.2810535-1-idosch@nvidia.com>
 <20240903135327.2810535-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903135327.2810535-4-idosch@nvidia.com>

On Tue, Sep 03, 2024 at 04:53:26PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_ports() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


