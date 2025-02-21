Return-Path: <netdev+bounces-168597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C9A3F8F5
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC8C704C37
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC93F215F41;
	Fri, 21 Feb 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKKcZSMa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5C3215F40
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151780; cv=none; b=CzIHBYQ/szRmAa3tdViSeCUYZH4JZumj6g/k/SjMuosr9ViKw8yvf9HGELB8Ofbum0kwLZBKjLhzniO+jy8yuHGPNkiZWDR8iNzAbGvYveDn5hrrB4qZbmzH/JELlAlT1lV5GYGYpay2y9bH28w7CL+OYb+MFewlf/pRBYvKvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151780; c=relaxed/simple;
	bh=ikHWh3FRsOR6LUazjmLmkD2YnjUSzsqIxCeGiizeZKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHF+mzXb0zAQmRT3F/De5FwxJkxDZHbxSmbR6dCfA/6QDjDKuXMprthcAXAJErqfZEjdPTOkdSt99dzLDjDzU5UNU/HrPMxR3AQfO9DCuHHrP7BSYa8R2bpYvTt10LrqI2w9KiAnyJ3MLhClp09qYVejvZ6R3oTp2YC9atABJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKKcZSMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740151778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iD0T11rD05jyFUl2KQwuGENbXxLi1JAwcITzeBwqvlE=;
	b=VKKcZSMaG0L9JpmFLMLutzp7teA54zOvC5pl+EmJ7q7opn18a7YWP7FqwQQk5iIoHQyv0k
	suZ7DYiiRZxjh0YWmF0OlLt8uKtOHYAnK7XfwYQehzIzNewE8on3F+Bv/Q3wW3xbZsboQr
	CNoPGtJnTEQupaCIe2DOlcSh0fPgwTA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-me5nQbhWPrS0dz6HnYEXnw-1; Fri, 21 Feb 2025 10:29:36 -0500
X-MC-Unique: me5nQbhWPrS0dz6HnYEXnw-1
X-Mimecast-MFC-AGG-ID: me5nQbhWPrS0dz6HnYEXnw_1740151775
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4c0c1738so1914813f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 07:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151775; x=1740756575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD0T11rD05jyFUl2KQwuGENbXxLi1JAwcITzeBwqvlE=;
        b=M76LeKNVuDczENfj8JsBZaE0o8+MkNHCceY4xpB2pLgBErJs6U6BkvmRDRfPEX2DVT
         QIImQGo0A2xllf19kw8kjjdv7eFyttJq6k3EUgWc7iEePT+DUMHr3Q9FUyC+ykFxeBYB
         i3TuEHBq/vdeS3WIUrOfB8nZwvwlZym8mMemtC9xldM6plBmqwb28SsJPxsxDO6H+DYE
         SKrEtwfJ//X2ze4/G7l0Q8tr0ol2oBIeF0l8SlmlNV+4EAzrzjmY7dwBVEkzZYvUTr7h
         m9sUyD07nMT1af4NdrCZ293WmWsTwjNT1re5DqiUviZykoYAQoo1XEj8v4fKgrnoU/wM
         7THw==
X-Gm-Message-State: AOJu0Ywo9vJqdhPhCCaW3P+1Fzbck+xcMOfTONaXwd6rh5yjJEIP9m3p
	MPpAgKiehfLs48zC5vsc1TDsMxTKEcLqbGQAb/7TsepnJPCvqR2tGS52xgwJfif2RFux8x/WYAI
	IBaWUUP12hcr181SHRk5KtpWm0GV88LzZNFN4/LtNnmJJFP8GnU1xtA==
X-Gm-Gg: ASbGncttdsynVTRVH1JpDvKHFtZl7nkLL85puJcZWMymIFjnQBm7DAplhAvZCwLA/VF
	j+PUC3pfU3rwYAsW/3RiotyYEvyrIDJA6ndmdK3MjOCljMxu1lHazrsPOquZ0ZhGGdWBezTnZzF
	yQ5DcYVGJy4fIhoICWZI+gAWDe7yp9jNpI8DJNwL8gHQ4u8oYH1t8+BjDPWJivZA1VSuB/TXDzK
	Ej6j1DHrqd+1lZ6cjgknMfIuSThvSl64cIKdYqOJ+PCCIg/oyA4AQLs4CyFbbUahoq4kkv7CzgU
	2cE=
X-Received: by 2002:a5d:6da4:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-38f6f0b0107mr2585230f8f.34.1740151775485;
        Fri, 21 Feb 2025 07:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHQjh+C1d1kCVEo3ko6Ux+i5NDRIN9dOQxZ+viLDi6iYlXOKtTeBReMP40EggjNf5Au3S+Lw==
X-Received: by 2002:a5d:6da4:0:b0:38d:d371:e04d with SMTP id ffacd0b85a97d-38f6f0b0107mr2585205f8f.34.1740151775190;
        Fri, 21 Feb 2025 07:29:35 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d94acsm24050773f8f.75.2025.02.21.07.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:29:34 -0800 (PST)
Date: Fri, 21 Feb 2025 16:29:31 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	donald.hunter@gmail.com, dsahern@kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next 0/6] net: fib_rules: Add DSCP mask support
Message-ID: <Z7ib21vF8rJ5K+Pe@debian>
References: <20250220080525.831924-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220080525.831924-1-idosch@nvidia.com>

On Thu, Feb 20, 2025 at 10:05:19AM +0200, Ido Schimmel wrote:
> In some deployments users would like to encode path information into
> certain bits of the IPv6 flow label, the UDP source port and the DSCP
> field and use this information to route packets accordingly.
> 
> Redirecting traffic to a routing table based on specific bits in the
> DSCP field is not currently possible. Only exact match is currently
> supported by FIB rules.
> 
> This patchset extends FIB rules to match on the DSCP field with an
> optional mask.
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


