Return-Path: <netdev+bounces-98768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D98D2612
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8482827AE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE3A179203;
	Tue, 28 May 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8vR0LL0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278A1791EB
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928877; cv=none; b=ayTN1I/Q7o0+myxyDfP3VF2Y+ELwV9U2wE2TIv/Idp031Ecj9QP7o+sYG3PIwHbwEPe+A/pGUjTD/ssfIHkog7rha8scPR4f/kzGYu2p7QV1VVpCyNE0ZgtaTATKQgajYxsT2Ar2/WplW9V6S2xny3vAGeV5eKChYJLqeGb5vR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928877; c=relaxed/simple;
	bh=3g76ji7xG7syw93pdi+7nybuREQ43mYf0T+2CyIVO/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjA72AWDQZk0+Qw+/K+9ctx+dQGwCtjOdvAwjbH3mtxsUvMwjxIO48BlLA72Fg4bV8KUj+lFmUA12uvQqEHwGSRVkI5ZTw0aLut1R8FskNm+UpH3YL91JpICSg3YqebOu94D7N5Nv9ni1E9MZ46QhxlOMbqnR6RxWNoznpMt4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8vR0LL0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716928874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHLLFApeJ4V8SU4kObKYGKIEC4OL/obNTMhTcS6bvI0=;
	b=V8vR0LL0giSFX8BHz2fMuGM9+7A5ZQnFpRLqB+bbXETQTNpqmTCl9ak5n5G3jrD8TEGd2+
	epY4coajJrhe09i9WxOaz38t0/t4vWsP0cqedhYpEPE6PG+sD04wBajdR9DZcXyMsFhQW7
	8bn9UIC6/ezNcVzA1eHw+auXzLJMjyI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-kSCWymZ8P7SxkD7YY_G3xw-1; Tue, 28 May 2024 16:41:13 -0400
X-MC-Unique: kSCWymZ8P7SxkD7YY_G3xw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-794afb0cf8bso177883485a.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928873; x=1717533673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHLLFApeJ4V8SU4kObKYGKIEC4OL/obNTMhTcS6bvI0=;
        b=SinpbEYea9HSBd2lfvz3gWZhgaO6CXUnDW9pjvkivsVEw63UAQF6FJhxrCagHsN4N2
         UfqyG/yfAt9Gm+MmJnOGxI+6VLqhfv5RkBzxaROp1Q0Mp8FMNsF3q8tVjWR2Bu1dXP00
         0RkLBl1T5/872LFtfmHndc+QVQ1/rWELT23iDtWiNaYoGdCxeE3/XuW/aHbwPSSYESTK
         sLEHQiT2pHjADaLR0agQ7FSRecZLgZCPR5kNX/HbPB1NMMNmZgXRouOTqPKOrgVh/Vtf
         S1Kq+qiGrRCe8e8vEAkN3AwVvrtXicD3XQbJGHYLKvxkU878n4jM5GiWJ+aLGeO6MK4Z
         N8lA==
X-Forwarded-Encrypted: i=1; AJvYcCUs69r8uccIAKB69/php1Zg7Y29Ve8AmWVfegQdQWYFxy3fyyilZkR7fdSbpgjhMXsZrKIOnk3Jp282FZJ81f7H2tqGU/mG
X-Gm-Message-State: AOJu0Yw+1of/5W0XwHXFTx/0g8iiIvqeZahKmIq9ls6raUjWGZgRra6o
	cpnBCZmnuI//cVdhCWivFmRZLRhQPx6vLWHgRwRWRnGZEAuyTdjkUILeUdV9oKBf8wlNr6pB+DO
	JVrsseqFIhn9HUsJJwZ11uLN/ibI0hG09RUNUNzD/aurLOxOo5SJhxg==
X-Received: by 2002:ac8:7d42:0:b0:439:577d:9a93 with SMTP id d75a77b69052e-43fb0e8729emr125869301cf.20.1716928872618;
        Tue, 28 May 2024 13:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6YXrNajDUDbr7l5g13YizJiMN8IyJIYZyrLmGPUOL2k7RP9GlB7OmQyyHIEERpa012+7G7A==
X-Received: by 2002:ac8:7d42:0:b0:439:577d:9a93 with SMTP id d75a77b69052e-43fb0e8729emr125869041cf.20.1716928872060;
        Tue, 28 May 2024 13:41:12 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17f3bfasm45738051cf.37.2024.05.28.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:41:11 -0700 (PDT)
Date: Tue, 28 May 2024 15:41:09 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 4/5] net: stmmac: remove unnecessary
 netif_carrier_off()
Message-ID: <z7rcnzmmk44fjn3bnh3mrtub4r62keliwjutvyydjjcn6qp26g@bsuz6hj36ok7>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
 <E1sBvK1-00EHyi-4l@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sBvK1-00EHyi-4l@rmk-PC.armlinux.org.uk>

On Tue, May 28, 2024 at 12:48:53PM GMT, Russell King (Oracle) wrote:
> It is incorrect to call netif_carrier_off(), or in fact any driver
> teardown, before unregister_netdev() has been called.
> 
> unregister_netdev() unpublishes the network device from userspace, and
> takes the interface down if it was up prior to returning. Therefore,
> once the call has returned, we are guaranteed that .ndo_stop() will
> have been called for an interface that was up. Phylink will take the
> carrier down via phylink_stop(), making any manipulation of the carrier
> in the remove path unnecessary.
> 
> In the stmmac_release() path, the netif_carrier_off() call follows the
> call to phylink_stop(), so this call is redundant.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


