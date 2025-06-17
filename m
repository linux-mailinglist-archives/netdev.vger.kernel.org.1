Return-Path: <netdev+bounces-198774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFBAADDC1E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4AD166E2D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372E25486E;
	Tue, 17 Jun 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="f24dP1a6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC725178C
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187866; cv=none; b=G6XBnlrrDxzn1aab0nhGs4sVAbWjxQosohm9QvW2PjYpav00sAx3WlpwHqynvUF/8wPT7Z3Iap9EIAHvs6JSjSq7xg/12z/ln3tct9hL5Ox5j08zwoIU9LdXQ1FuFCTinMTr2DKeGaxeFJCpNk8aPWUjRTtvDhU/WrX0uQxyUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187866; c=relaxed/simple;
	bh=1bP6rJEA8wFohueF5jqDh/zAC0rZ53XrMgdF+00Sxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVSz6Cu6sqlFdoUkh6Pf+qIqqnUiUr3BUu1MhvsX1qH7q7E4RFRp097iNNnbLD8LPikcQDL/Y/deqzyISf4vJ92ug/S+qS3ul2tcMGKm85XKXDFU8BIq910En3EWqlIjrSheIkXADHKpwLzQpKigaeQsHhO2OHPI7TxFNETkEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=f24dP1a6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4530921461aso53380235e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750187863; x=1750792663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvfQMwCx3aaFLH1gBYzFPVa5Y0KFbLLTPkKAtJ7FGcM=;
        b=f24dP1a6dfCFYcJJz9zsm/qxBai4Kp/6CWp1u6yb5AR3BJAqSBmKihBlsObpDAmyBK
         rH2EN970kST+6qFYVH8eSayc1z9Tu8gTR0nDMFCD5iZLQHxwwpHRcn546psZp1H3PDL/
         TsfRJgvSN+Kwgpekvg0HzFVmFjshdTGkU9Czhgs6HpcL21QH95DKcRfVxIYaPc0vFbLi
         2l7WhVpoNH6weLKZwwURN9Ixny85r4mYVs0p13tGQDQkBuNosxIkSCkj9bFuWWVqx5+l
         2i0SqJKu51oGLHO+Kfx+V6NjhIu3nUeTdG4k6e10E6W1YVwqpP14fcGRTqeK2MO5EFWc
         zKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750187863; x=1750792663;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvfQMwCx3aaFLH1gBYzFPVa5Y0KFbLLTPkKAtJ7FGcM=;
        b=jokelU8mR6IYlzHY6CwIqsJh/e5yUhaWkZ8NYrq2RXZPFxcZyKsP33IDIRMXUxJeTt
         dx8nKs3ToM1Rha7QxYyVjhP0/2VUoAhCi8r7YQltFLnk06UTCIVVzEE468NBLoPc5+VU
         QOsrQ02aUfglRKbjz/MDWwVamDetkJqjgQnqsTFT0CjnLHgDM/L9myuTRH/4xZ9+LqpC
         S8qSO4qhbcqdGTLBvE/QZXK7LiiaSDSt9kZ36BMDIv7hkQ+5qc059ydN/+BDHPEZAkft
         fpNax/rNdFHZIIxIdl3vwMIaty54j2HZ+xiBG/oS9km/oPxg65PPzdzlwgaJQtNdqpPH
         priQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6325sQhSiwPOkyasmXMEk6vBmM8XTxq2Xi/CxyxYq0iVDdeKhR8Z0aHV7FPikXLbqeuWFGto=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTg2S+Nz+7Z+n00rzpHZINd5svAgBw6zI5t3wCND5oGauGdv0d
	YYLtkOBhi2EFFlhQk6/3zbA8s0+d7IXH8GwKWHQo00wtvYDNG0jHxZkekH7Ei9p6nVQ=
X-Gm-Gg: ASbGncv1vLr9Q4Wc6IgIC2QSuO0OLL1nb2FpR4AMxsgC9yg84Iwxk3AdOFh+jeI1Pvr
	YDEThXZl0E7PbA2BwsqDcIxpKDi8oqGBHDV4l9zHtS3HeVTNSQ3yLI1T00YGLMuQ+DAMChSbjVp
	Y3v2anT5ofPrY9cJvzS8BgQjE9P/on8JycuP/wHeTPEkmeHrEviXlXNgBI5Z8s0N/pmpJqRWH6T
	1u8RDFoK/tlyeHxebGsXJa+8JVtU4nqAk84i/jy99O8A2veSk7Z+chhDVooyl8uzdBW9hsQVg9D
	WUqQBwBO9Aa3TAVvOGh9DjjM27Bbc2n4/IFr47DIHPO9MR7NX7IK1zaVbvCHVuPBgUo=
X-Google-Smtp-Source: AGHT+IH6QEm50PmO7DOXT3ObwZddoTuvRG1KMDkLrrDO70vSNhxTbXEd9HYKRQhDrOpboEzGDHDmKw==
X-Received: by 2002:a05:600c:1f10:b0:442:e0f9:394d with SMTP id 5b1f17b1804b1-453560d2fe9mr22881915e9.24.1750187862956;
        Tue, 17 Jun 2025 12:17:42 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1925sm188221825e9.12.2025.06.17.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:17:42 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:17:39 +0300
From: Joe Damato <joe@dama.to>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
Message-ID: <aFG_U2lGIPWTDp1E@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch>
 <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
 <aFGp8tXaL7NCORhk@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFGp8tXaL7NCORhk@mini-arch>

On Tue, Jun 17, 2025 at 10:46:26AM -0700, Stanislav Fomichev wrote:
> On 06/17, Jason Xing wrote:

> > >
> > > Also, can we put these settings into the socket instead of (global/ns)
> > > sysctl?
> > 
> > As to MAX_PER_SOCKET_BUDGET, it seems not easy to get its
> > corresponding netns? I have no strong opinion on this point for now.
> 
> I'm suggesting something along these lines (see below). And then add
> some way to configure it (plus, obviously, set the default value
> on init). 

+1 from me on making this per-socket instead of global with sysfs.

I feel like the direction networking has taken lately (netdev-genl, for
example) is to make things more granular instead of global.

