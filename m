Return-Path: <netdev+bounces-162351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F09A269E8
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F8D3A569E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4965588F;
	Tue,  4 Feb 2025 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QDa0KeIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA623BE
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738633722; cv=none; b=EyAdhX8ioPhRpVMpInaTIc2BMDvA9LoNDJpPhRx0qE9FVCn3A0gF2o7FdMFzvKQD5UToXUklCXYKEYSSRdWwrocg+JY+WFnCBdqfbHOHbQgQAJschn6uRmcizC0tGayRmflLnPsgY9F7w6eEixiJT6wnu/HE9bTpJvvCwzq34z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738633722; c=relaxed/simple;
	bh=x/OIKJRfGoHJKiEG/ZgGGRzS5wgA4E0d1g0wi30cVDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcayLnOn9mb+ZebKXsfKoLwZh7UBpYAR2TWA+0yVMRP14GBhMMA2VYhLDV9C3kiAPBL1t66qmKO1sm5vcRIXs1zm4f7toRVFILAH+wVA8cjN5NkvtVbr25EXmjSuy6NXoBk+0/IglBmJtYfjK8nwk9rX8hRnTcOeF518bRytVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QDa0KeIb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21bc1512a63so96974505ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738633719; x=1739238519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9PMsVjSdOLj614fOvI/y33lqQJtjqVvfONyLRXysDo=;
        b=QDa0KeIbaTJ+dY/GYoVbJs82iEJGSxwQfe/fTKxVWQnK1ykNkk8IHjy3FS5I0Byhiv
         j7bfv5C1LEOxJpSA/QjY8lrFIbA9TvA+u3AaYViwHjvOQ/KY8HwgL+yamapirzzZ+qqO
         LsjHM7aEvI/eHDQ784Lwh/HO32H8dYzt7LsYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738633719; x=1739238519;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9PMsVjSdOLj614fOvI/y33lqQJtjqVvfONyLRXysDo=;
        b=S0oaJld2TQC4KF+CPiVX+wjC+T4U2z4igjEJjQ3Rat9J/4S2TUH9s/CqBXBvfeIpeb
         cP+JniyexNRMafw5/HVdMs22TclNFtoo56JiSCaj5Jm9YZYkopDT4CEerWzzHa1MjxQb
         d40GxBiK35Wq+dHcdTjLrkyP3Ntl+xTNNYBrdIj8q8qwwlXDqh28YynUHegtKnbz6j2b
         UnSqNVP8L50wwPi8s2Vzq5d/W82LTE5xBctdBqCV5iP2/Kr54EP49gafGxzgphnnGg5p
         8Hk5WHf7Svsni6SAWPggraX/zazUNCW6gazkovhcAMGJsJ41xVb6cixuDcpG1GjKgSl1
         +9zw==
X-Forwarded-Encrypted: i=1; AJvYcCWUBEbSTRM1ZfmMkKOC0DFYvcQz+caXnqrnytgKjHi+oNjwtkQ1nC/KuKk+USkv22pKdNiYPSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DJ2zHxvBH7Q6NZqAuexCs3RrrKcRDFW9I0kY9xe6bv0KCTIr
	H4glV4OAbQsdUxFbDfF5yq3Atj2zI2gUiZVJkHxgWYTOLaKUnV5474yImio17A9EYBfO/0QRpph
	O
X-Gm-Gg: ASbGnct0J6IKI0xp5jqgNvKfglEp4MKBGao5UB3+zK2d4WEnNLCDwVTAAP1Y2E7fK/q
	i20GwHg7PLnoORylcRxJK3L9M8ikhcwGjN6QsFmXQ/xRWJRcJzld/Fdsarr/htUTxH5VJf96CeY
	oRpxpF0mpKmhLl16WQQakQ/3X1skSwczdCHoTfTAog/ilC8Thg6NI8pxiULNtr+DxnDMc3ZlhT3
	xyzAwOFbwiYkQEz9g49MlTrBsDnRDZkHXtAAL+sIZdI3+mPdzs6KkLD2hfJFHujC4IGRcpX+gfh
	K8789KfzQehchkUiNWjBHgy9C4tjt8xqlWjbhkN0LjHvsezgLnfDGXSm0DxXEHs=
X-Google-Smtp-Source: AGHT+IH+YlFS/HGPHIcdKOd9X0q+iUCXqabwJHbf1864R2wClY8SSV5WWThU/9kYAkkhwx8gURU0oA==
X-Received: by 2002:a17:902:c40f:b0:216:281f:820d with SMTP id d9443c01a7336-21eddbf3371mr263415235ad.11.1738633719540;
        Mon, 03 Feb 2025 17:48:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccd590sm12169855a91.12.2025.02.03.17.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 17:48:39 -0800 (PST)
Date: Mon, 3 Feb 2025 17:48:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next] net: warn if NAPI instance wasn't shut down
Message-ID: <Z6Fx9ElQJz1ql7zF@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250203215816.1294081-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203215816.1294081-1-kuba@kernel.org>

On Mon, Feb 03, 2025 at 01:58:16PM -0800, Jakub Kicinski wrote:
> Drivers should always disable a NAPI instance before removing it.
> If they don't the instance may be queued for polling.
> Since commit 86e25f40aa1e ("net: napi: Add napi_config")
> we also remove the NAPI from the busy polling hash table
> in napi_disable(), so not disabling would leave a stale
> entry there.
> 
> Use of busy polling is relatively uncommon so bugs may be lurking
> in the drivers. Add an explicit warning.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

Let's find out how many bugs are lurking:

Reviewed-by: Joe Damato <jdamato@fastly.com>

