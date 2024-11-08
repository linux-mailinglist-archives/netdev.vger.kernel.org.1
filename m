Return-Path: <netdev+bounces-143342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C418A9C2182
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D21EB2618D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAB1974FE;
	Fri,  8 Nov 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLSZ3bGR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E76198832
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081783; cv=none; b=UeRL0jw3rhcZIS2LN9ezEpr+UyS3EOmQgNIwJrk3HDi4LuhPnhKzcwoYfFWFxa9wrj9V/hn/zmgz9rGqbo7K6ONyqtCcNEWlh/SkWGEICC3r/CHK/CTOBkMVmJX6RhJjBPxL9lCzSzZJhEBA4KzAwhBxweKp2WO5HVM7tg2uAko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081783; c=relaxed/simple;
	bh=Dkl1ieEc1BAg1ZDaYT7VtIs7itFlvZ0wDVhM9n7ovBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR0oI9XjVdx1TDi9tTvHZ4uQXRI+aZSnhBUii6d9LTFgY3sbVC1a/IknzuGtfbmWYEPWnU7+H3j9ejH6WkhfjY+ksl5bTMM54pDdjjehHJ3W/SizOkh/dRVNED/mP4o80/LYiX54g3j17o7XWRXMdkS13N96Wvsz6kpJkAp9SQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLSZ3bGR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731081780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KodwbNUeuehD+z2uf2ly+jd4Lxh5FbYEBZu9aS+ypso=;
	b=bLSZ3bGRt4cxNvVICOghx4IilkwPXaLOlFGpTxrz4bO3xRmB3NE+c06rJThdnwG4yg+9D1
	o1e041V8cl1hiVd6fyvReMcYxwfiLxjnNRyl3JYYvahjwHMaIisB5j6YTU3rsWrsFZ4lmT
	3S+rtsN1nGII2dl7YQuKFeOJLtcDhvU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-2qcPiiI4NFCwlk3WhjY2Dg-1; Fri, 08 Nov 2024 11:02:59 -0500
X-MC-Unique: 2qcPiiI4NFCwlk3WhjY2Dg-1
X-Mimecast-MFC-AGG-ID: 2qcPiiI4NFCwlk3WhjY2Dg
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53b1eddcf4aso1968954e87.3
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 08:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081778; x=1731686578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KodwbNUeuehD+z2uf2ly+jd4Lxh5FbYEBZu9aS+ypso=;
        b=dGWXFKy2giQKkEM96dH9ARRjQtg/Ftr/9uOcea6aCH2zpuM6cLbNpvw7MiSrqnDtCu
         l9mahwRI2t8iATQMjLqvsmkLuY4AisVK8IAAdghk8cAsnYG7ENC4MGRzI3+b0/1YRyfc
         RWyVuTbDcTRxomV43ze3hNQhUvrynTqovKsLJ/3+jsVffiR6MTWWBiX1hJt5lNZz3E0p
         2ZNppOPCJIKU5DBQ1vNDMG6ncA4k53t0uY4X4hQOKrvlGHnoABYHTTvgudIJq0I+lOZi
         lw3RfaUZoBY6qbUTmH8nYQYPq6xO1qRP1rsOy+FXAlsrlJju0XBSnszsZCbSuT054IAo
         5+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXugfTCUjXjG2k0SNVgSvhUUyc6LezxXop37YxmlH38TgqEE8scuOxhEOgRe+0PWeGxHZLc22U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrgjhg3jYgShLEd3TTF2Ah/AFGEsAc6GYANMczNePhiEfBytj
	jgMRi1K/1vWkMT06AS+uMHjIBqoFpwx2p9m6y9fYDFH1Ai5tYu1ZJJJ+usfMjKy8lTsDxuGoVWj
	Z3H1KVNmQiVAVWXrDrTNs070DxSR3xgeME+3WAN65PWn2Hm3Wdu+LqQ==
X-Received: by 2002:a05:6512:3d0f:b0:53d:8274:a300 with SMTP id 2adb3069b0e04-53d862c5bbfmr1437135e87.34.1731081777513;
        Fri, 08 Nov 2024 08:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXUwhruY1WxPZM2lD15BwhIP8JhX3dp+oHUK/E9prDaGfWq7Kte9cKFc1RP7RvGorjuU5tSQ==
X-Received: by 2002:a05:6512:3d0f:b0:53d:8274:a300 with SMTP id 2adb3069b0e04-53d862c5bbfmr1437063e87.34.1731081776647;
        Fri, 08 Nov 2024 08:02:56 -0800 (PST)
Received: from debian (2a01cb058d23d60039a5c1e29a817dbe.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:39a5:c1e2:9a81:7dbe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm72642485e9.17.2024.11.08.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:02:56 -0800 (PST)
Date: Fri, 8 Nov 2024 17:02:53 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: Implement fault injection forcing skb
 reallocation
Message-ID: <Zy42LfWaiWHJ12Nw@debian>
References: <20241107-fault_v6-v6-1-1b82cb6ecacd@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-fault_v6-v6-1-1b82cb6ecacd@debian.org>

On Thu, Nov 07, 2024 at 08:11:44AM -0800, Breno Leitao wrote:
> Introduce a fault injection mechanism to force skb reallocation. The
> primary goal is to catch bugs related to pointer invalidation after
> potential skb reallocation.

Nice to see this kind of debug option being worked on!

> +static bool should_fail_net_realloc_skb(struct sk_buff *skb)
> +{
> +	struct net_device *net = skb->dev;

It's confusing to see a variable called "net" pointing to a struct
net_device. "net" generally refers to struct net.

In case v7 is needed, it'd be nice to call this variable "dev".

Looks good to me otherwise.

Acked-by: Guillaume Nault <gnault@redhat.com>


