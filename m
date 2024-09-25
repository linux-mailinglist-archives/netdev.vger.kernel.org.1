Return-Path: <netdev+bounces-129812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46AC9865FE
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3AE1F253C9
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79213698E;
	Wed, 25 Sep 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wlH8cZsO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B590129E93
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286722; cv=none; b=TjnBTZvMkddW73w9wTI8UjQ4l9san6ZB8q1Iq48Z3ZswXgs7iZfeXrzhSbNASaZB7981QmHEUkK/fgSnF8/nnijC3vw5S77s7KT9yjxoYmc/ld68drOsHedw1y8PajyfYzg9X+txwk5aFT0jauVzIX9HIj+beTPrza/IYE/Asy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286722; c=relaxed/simple;
	bh=525HOdbYMTprw8A7MmekduGTcXrZxpqa9hbA2x+lp+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaDAM6dRhqeKmUcqWeRenCpNDb7Pg+L2+zPDWse4HVKPHtR8DXqJRw11rMmCnLVv3RuhRUbCvuUy0bmkgusqfH9u9WQhJFIeqaqrjYpazYbrRqr9kme+/IaKrnQnhAWqS0SksQjYp7Gf8pMCcAqSnA/ja1JcPJWtUNQYW+IxzD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wlH8cZsO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so135079a91.2
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727286720; x=1727891520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=525HOdbYMTprw8A7MmekduGTcXrZxpqa9hbA2x+lp+I=;
        b=wlH8cZsOw8+DqnpZBmaPEp4QcVeX+NwCqmZzzIdjYjVyMxW4Po0l+YFXQyre4roKJH
         gkMc8TVFrPatT40ZQy8QfStaXVn37w2xqp/5A32PxUHT8oyd+vZ8Sy7JIYzoarBb0Ryb
         EEZQEgqYLS1xciQl95zYUIEvOUSdwHP+l9bz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286720; x=1727891520;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=525HOdbYMTprw8A7MmekduGTcXrZxpqa9hbA2x+lp+I=;
        b=FDDhhkVy2j89zxOPm5FNFJLirpLqa9xnkxVkmwvU/COP0zS6f61hxKk9bLqcWpQdar
         1fOPcdukhDTV3/fz22Jw9SQgYEyONtYtalpWJTr6MUAnDMK8qq+qZGrr+TnWH1BKBLwr
         ujgP0VJIojrdlhX5vkxcXEvFNkJTHeF6Cp2l7s0YCA1mCp80uPNzHxqX3WkHJZNHmLGr
         TC2be0nj0NfYaeo2A9c8ja28Jwrcn5qH7Bn6227/S2IjNKMsxojsRCbNacdtxpfdd1O/
         ipQtXYNPLycgwR9CRk2sf5xsXTZN/FeY8p16xh24aSf6jva6jI35NjTCGbpD54WRH1q8
         tLfA==
X-Forwarded-Encrypted: i=1; AJvYcCXBOxasdNdpQfWRXTsTsXbW2b95r2HHX5FYoTrzTKX0P/aYbRdTYOZ/u5TwUjyjd8ROrHN1GbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOVp+b87nhjWOfp0CIr23FumBGf7ajFxtGmyGNgZsrHC+L8mj
	yv19Ve4RRH4uhqZn3z+ZSgaTG6ENbXMdRXmHIPTAbe2as0qPEe/YCBbPc2rd41M=
X-Google-Smtp-Source: AGHT+IGYVTn8NJ0/AUmI7jMRIwPrABoFatSI94BOCSbHFlOFxp32qIeMtXFo3VJ7g+mGJHPUYVYhhw==
X-Received: by 2002:a17:90a:fa8c:b0:2c9:1012:b323 with SMTP id 98e67ed59e1d1-2e06afbf27cmr3983925a91.27.1727286720538;
        Wed, 25 Sep 2024 10:52:00 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1ca665sm1824343a91.18.2024.09.25.10.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:52:00 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:51:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
Message-ID: <ZvRNvTdnCxzeXmse@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924150257.1059524-3-edumazet@google.com>

On Tue, Sep 24, 2024 at 03:02:57PM +0000, Eric Dumazet wrote:
> One path takes care of SKB_GSO_DODGY, assuming
> skb->len is bigger than hdr_len.

My only comment, which you may feel free to ignore, is that we've
recently merged a change to replace the term 'sanity check' in the
code [1].

Given that work is being done to replace terminology in the source
code, I am wondering if that same ruling applies to commit messages.

If so, perhaps the title of this commit can be adjusted?

[1]: https://lore.kernel.org/netdev/20240912171446.12854-1-stephen@networkplumber.org/

