Return-Path: <netdev+bounces-185812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9B7A9BCAB
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BAF17BD5F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DDB154BF0;
	Fri, 25 Apr 2025 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GKTHmmYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87F13C3C2
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547256; cv=none; b=KlpAHFRfeb6ivgKeUT/VgSGnG1B/2xbbBUStEWH2ZOaH0dqKoihBb/ch5T9ssfUQ4VpUNNaUG7mVr6KNSRfuITRdHsTT+a9RGCh5hLfgrW65RdaVkS1xMhzTh2dN3NYWlze0LJmjXnwHvq6/Vcb5tVQd7t4v1AfyKqDeCRoWTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547256; c=relaxed/simple;
	bh=I3A/zHwAYSwnjgk+xe7X/mxwoo6oP41oVPwo+1vnug4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpoDO5gQRK36wFdro79mUJESOvIn4RLpqy71IWOmlBkOz9F44sGFELhTYbAnQJ4RysLM+zFJCBKqTUy3UWHztTQNZ8BH6KTEhLa0WCYkme0AJ2opFKimhtiFjpUzg0Tn9W9Z4tXaaG+rEcAGCKUZdlDEw36DQNf2ktoWQU1nY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GKTHmmYg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227b828de00so18113985ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745547254; x=1746152054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09kVEaqIXaUD+GEpgwr5iE/SxGZwllT1KTlsw5VQ7Mo=;
        b=GKTHmmYg2VRFiafJKBcyjLO6aIcxwnOzkMSmlxg0VqLTiGhOatT+Wf9nvSn0vY7MPp
         hsj3zcECz7pFBP0jyd3H4vTs1jbjdGnehSPOyjgeD4TgPPiQ/LUuWNGJSBU5iQE+qnBH
         0brq5LLbinQBOxGHhE7a0y7wZvRAXjEJYRyXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745547254; x=1746152054;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09kVEaqIXaUD+GEpgwr5iE/SxGZwllT1KTlsw5VQ7Mo=;
        b=T8rKDvj5uQC0T3DvQ2Bi5c/Hd8HsrApc52iLnbxmeo+IJRSapdX4xM/pnEen35Aea1
         AS+xdAjMOt2niuYJLUrSQIdO82NhTYUmm8V7t6YnT/IEvgrGp9sAm/nkx1TuL8euEBfv
         verBmMCpdgGaTLkgSjMnB6K84Z/ahMZM9mC7rIwfZ2fcVJYBD9BHzSBQgMuXFBbBNEAC
         itCHsLqyOwbfZou1Rb8AHbrxAV31JAD3CVd01ZdTBqSXKG9KxXbHHXTeaGrdu8a6JJN3
         uOjcwHsfsisKiP/QTgkn+mp4z7I1gm9C80AVUkBW8TSXSn7RTARdDcf/3bol5f/26iGz
         O+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd0aJkbG5lQOa0SXcbbUO6IyyGkdaAPVW4Tjmk+aJuI6esM1qNetvacpWsKhUB4a/JU2Yz+l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+DOUc5FJTbpwv7kmu8vqeG2UMdSgRiP9nhdCoZ30j+iiatOt
	8myp4pm8DFvyKWKFfGu5EE8EAeeQ+cgSify1+ywbd8VpSv9xMLbTKVpK4kVvViHGqcS3qC0IGW8
	k
X-Gm-Gg: ASbGncuBBJSCf9v/+g4QceWSRdR4E3V8cZ2WQ24iiJ8WMgu8akkwqJyuOXCAPl4pkvB
	c2aEOqExgIbIToyd01q84IUtfa/t49ze+OipY+HMpIol2ycYeTQMhyMpzdgiJrUocqCbeQFd8qV
	c9EwTj4AB3wPBT2M2RPJoKK1AMDCR9KZzhmxzlI2uMMjl2ZOkj5cV2qU7xlgvRCRNjfa4r+zvSm
	+FqNFkTJS29/TreUyP0siXeGJp6YLrqRL6c0z2GQ69VFF0yQSvVe6iEzhWlB/kEre6WQet0uDTj
	YUrZ4KaaZjr7Os/fSnEPzxVikjcwDE6n9wf69aSXpSetcGarIfzptEjUC/EBRKCGfluhaGA2Mqn
	ILbK4CM4=
X-Google-Smtp-Source: AGHT+IH/PkabTYLPdtMjI7iYWLibevj3DXs51yGrnj7JIYtqi5YhGlW6R52IDmzjr567SoWgTnJEdA==
X-Received: by 2002:a17:903:1b6e:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-22dbf5e8fc9mr10072345ad.12.1745547254181;
        Thu, 24 Apr 2025 19:14:14 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbd6f7sm20934285ad.76.2025.04.24.19.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:14:13 -0700 (PDT)
Date: Thu, 24 Apr 2025 19:14:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net: ip_gre: Fix spelling mistake "demultiplexor"
 -> "demultiplexer"
Message-ID: <aArv84C4NDwv2aCa@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250423113719.173539-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423113719.173539-1-colin.i.king@gmail.com>

On Wed, Apr 23, 2025 at 12:37:19PM +0100, Colin Ian King wrote:
> There is a spelling mistake in a pr_info message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  net/ipv4/gre_demux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

