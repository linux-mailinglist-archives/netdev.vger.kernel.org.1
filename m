Return-Path: <netdev+bounces-122355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7186960C7B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B96E1F21BD1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6C1BFE02;
	Tue, 27 Aug 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQrVyUGD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF573466
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766434; cv=none; b=rYqxnUnDZK2sFEwGrh6DICDtENtWvIRhA8QPUITqFFsd53USa4nmGYq6xBwSNEX0Y7cHyCOfgZGxPfM4pXFbQ/rLV505AGQ4f1R7QosU3rQEdyTSf9KndkA86QOGLb6Km9YgTSehqlB1mgvCnYt7XB8Ta/Q5a2wQ0CxTU+2kiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766434; c=relaxed/simple;
	bh=1FNU+ePQW46CBMUzg/er+PfI0csLiJqEhkekKP73aNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzCR7cchxDp3fVxs0fKJbL5nm2QUhtbe6/TTr5xS04m0IyhPZo5qOvuiQ8h8CTGS3CbpOHhBj9hnbpepKAa8mr45Pk0A81FHpZ99wmf6agbRIzecC5VDrdu+N7Gjb77XOQHXTKvZWtbe0KG5j4HZ66em4sfIgeoFtAJy6k9ftHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQrVyUGD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724766431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pTH0l8fX/RclGiIzlwD/DqtoJKkl5MRP5LOQ2KEamrw=;
	b=aQrVyUGDTK0Mmp7ZyI4KWSwWKdy75mpUMKJMhhJrRaQ/pphJ2fVxFuxq8zC0aXpZMhpBgz
	IXc8eVH76ZDt6ALXNq5p6IpBnlZnS91xrH+lfv3KGI0SC8NsgCtEaxVd3imOFhgQMRtO59
	OiJl3mbdpl6FtLHd1XbjkcmvXLpCK8w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-3_Q2gPfCMiWgx2xtqtGGZg-1; Tue, 27 Aug 2024 09:47:09 -0400
X-MC-Unique: 3_Q2gPfCMiWgx2xtqtGGZg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso48716485e9.2
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 06:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724766428; x=1725371228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTH0l8fX/RclGiIzlwD/DqtoJKkl5MRP5LOQ2KEamrw=;
        b=E8Mas4C+e6wOQBvA7LVmp0RdZiqJ0Bwq7WXNpD8ElixbAWejd4rlaZ8NJCjCb13Y2+
         e5yku4s/IuWAyoJEptr6a5jkOePduNBWr/SpDu7OtMKNcyO0/V7QHEo2LkI1jJ1cBLOr
         3xmX7J/N7IuZBPg8OXnfttNlz4t3KFZ6M0xdlFtTwXVGjGco5t91fFVbDeHeM+eSfhnP
         rpERodWha9EjJjVHyPheEsac3JcnC+rvTCzdu7DquQD4Ux51pek+8SAGE5VbX8NytkmD
         1KdMMT5tF+w+JqgyzOf/aWnjkeCCxzIN4VUsjTy42RusXlwgfOXH+ZsgMOYJoDiz3IU+
         JBQw==
X-Gm-Message-State: AOJu0YzFpOeKaYu1K33kaX8ejrmVRNIOPIn1sKQnKVXxrZy3RGV0Q8wU
	5rjo8H09YN3qLvpeE8W/HDXBrmJqAOxadmNvOtS7HCdIOdUEHOsZ6MW6CZv7sL3ueq6Y6r/9G7Z
	tUR9rkNYw/i5j/1o+iwTpyzAEvqf3tQKQto4R7K0hbp7UuuuxpnFvQg==
X-Received: by 2002:a05:600c:3b17:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-42acc9fe1ffmr105760775e9.29.1724766428108;
        Tue, 27 Aug 2024 06:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3REVz9d0YmDrZrXGKl+8MwwCTvOAA/45OMUhMwJQuJq09xZG3EJ1QHoR85r+wJ97RmVpnFA==
X-Received: by 2002:a05:600c:3b17:b0:426:59fe:ac2e with SMTP id 5b1f17b1804b1-42acc9fe1ffmr105760435e9.29.1724766427401;
        Tue, 27 Aug 2024 06:47:07 -0700 (PDT)
Received: from debian (2a01cb058918ce0010ac548a3b270f8c.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:10ac:548a:3b27:f8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b964d7552sm56566245e9.16.2024.08.27.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 06:47:07 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:47:05 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 00/12] Unmask upper DSCP bits - part 2
Message-ID: <Zs3Y2ehPt3jEABwa@debian>
References: <20240827111813.2115285-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111813.2115285-1-idosch@nvidia.com>

On Tue, Aug 27, 2024 at 02:18:01PM +0300, Ido Schimmel wrote:
> tl;dr - This patchset continues to unmask the upper DSCP bits in the
> IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
> DSCP. No functional changes are expected. Part 1 was merged in commit
> ("Merge branch 'unmask-upper-dscp-bits-part-1'").
> 
> The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
> lookup to match against the TOS selector in FIB rules and routes.
> 
> It is currently impossible for user space to configure FIB rules that
> match on the DSCP value as the upper DSCP bits are either masked in the
> various call sites that initialize the IPv4 flow key or along the path
> to the FIB core.
> 
> In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we

Hum, do you plan to add a DSCP selector for IPv6? That shouldn't be
necessary as IPv6 already takes all the DSCP bits into account. Also we
don't need to keep any compatibility with the legacy TOS interpretation,
as it has never been defined nor used in IPv6.

> need to make sure the entire DSCP value is present in the IPv4 flow key.
> This patchset continues to unmask the upper DSCP bits, but this time in
> the output route path.


