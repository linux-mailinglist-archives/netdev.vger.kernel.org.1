Return-Path: <netdev+bounces-142064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3174C9BD3D8
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AC5283FFF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F001E3796;
	Tue,  5 Nov 2024 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="U47k3SwG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27773BBC9
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829486; cv=none; b=ZdDsRVKZkHQqgFUEGPIYP2roXOnDH3+4fuE0elnuMqC82x2XOn1En6dMkiB+KBHeelcz0veEvpkytoNFmk/GdaPLSq/+ygJj2dwwByvj+jW1hBL6pZHFykpK4k4pw66s/PmGgk4kXC9OCp2VYxe6jJvw5y+eq27UuHEuteeCxBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829486; c=relaxed/simple;
	bh=pesRQpCEjoHHfXa++7G26MudQ06lttVWNu8YZEZgIQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoWqJ8mX3b6drHPRgOiUpazdng6tnKWypcSsutkq1f8dZPkWvHzK0O/BQMJIxm/3Et9SdFZeaWVp1bMwBG9cvBHiX82sojiIyfGkG4K20u26KYN8mW/jhcO/sPxhwCflDMQb2DoT98CFXgLGc/mDWMiJH2woJ46Hh0QozKbAKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=U47k3SwG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso55190335ad.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730829484; x=1731434284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYBYmrEVnlcZ38vo7cuAmYu2ej+TxLS8wZbANIK79+0=;
        b=U47k3SwG8bRK7y7y0AOOhFDWSY9T6tQ5+fUETpO5NMDkkdjiJbvbJ8khGu6e5AUFDY
         F5whZZyNBcYU6ec25uqkXAS5MgEI2bZEJTdXvUCZIufbiIIB8X+cEU0AWebOcuv/C8D8
         CqcuI0fdIOHIGaiX88adbVXIYL97+Hr6N4C3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829484; x=1731434284;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYBYmrEVnlcZ38vo7cuAmYu2ej+TxLS8wZbANIK79+0=;
        b=KWWjIoccm+BeEiZv9lMnxbEK9/hBeC9EiFoypWD1Hn04/Bg8YI91Rznw3jL2EeN6bk
         3kr7pBPg3+9rj7X456JeSNgy6PFJiUZORYW85vZ8zu0LqaEUgpz3WI5F+qSQg2a1pkgm
         Cjef4Il9G2BazG42W1M/9jTV6xCqUaNljZOUFtcKmL8LqiP8QHKWKpJ1TYqddWZFlsk/
         U9D9ze/mkW68LOKMnutCdOyMB2iOxBXrDZl5OEoP42a8Omly4VvdUFHaM4871tx4gYWN
         jYBIUvKrvvR8yZNlR+soOwsK5MQ2nLdnBbJOxuoNcjQSSlqOZ24/t2DOazSI28zbGC/z
         +dLA==
X-Forwarded-Encrypted: i=1; AJvYcCU61NQ1BxK1ON+7hF98ZAICtQ6mp18QZtRY7DKd/UFvUjxWUuQFl5R+Jki0e+VKZ7Is9EM0bRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgslZk16tB8dtsV7W882KxgqjvvL/irM1fmLNvZuEitXxxyJn
	UqUjUg6/lSowTaruT2mtDLqRPkW8GhahngEIVz+b1Zd5MpUW/uD30qD20JRNYAo=
X-Google-Smtp-Source: AGHT+IFjFwBBmqq+u8wobF3/v/bQ4BXg0ejcCW5jEwXkAI4nebY0eWz8hM42qky3NZOBTNRuoOXxMw==
X-Received: by 2002:a17:903:22c5:b0:20b:a10c:9bdf with SMTP id d9443c01a7336-210c6c0c4a9mr525683855ad.32.1730829484045;
        Tue, 05 Nov 2024 09:58:04 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee490sm81722505ad.18.2024.11.05.09.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:58:03 -0800 (PST)
Date: Tue, 5 Nov 2024 09:58:01 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/7] net: add debug check in
 skb_reset_inner_mac_header()
Message-ID: <ZypcqaOdDgTV0fLL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241105174403.850330-1-edumazet@google.com>
 <20241105174403.850330-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174403.850330-5-edumazet@google.com>

On Tue, Nov 05, 2024 at 05:44:00PM +0000, Eric Dumazet wrote:
> Make sure (skb->data - skb->head) can fit in skb->inner_mac_header
> 
> This needs CONFIG_DEBUG_NET=y.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

