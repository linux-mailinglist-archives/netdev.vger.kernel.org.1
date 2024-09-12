Return-Path: <netdev+bounces-127964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8385F9773C6
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A4C281787
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A418EFDB;
	Thu, 12 Sep 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvnRd2RC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4651C1AB8
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177637; cv=none; b=ItQJD68cTfix+EXWLdMOQWqIyy2cFy85Ce6ItndJX7ggsuZA3kxJG18Sc1Ql/skHrd7YHxmCvDTrfcpZ1898L//jVGBdk4h87n2/CFLv3WRfowCVzq4Od1bz/pP3imVolIHq4QnLrnZ9bBtxb9Dxfuce75087yBTAsVM7htPQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177637; c=relaxed/simple;
	bh=nhZSKY8RxDcChvebiA2cWrtcOGCQxJCmSKiBXNPp42I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEygVPQy6M7YUbW7mNtytbA3dBoqU9LyunsRZGVjh7yjdl+9zaL9cmSPpu/M0mX+yypMHVfY/i8M1jn4yrSYtsrPYD7iwqfLzfI1WJSNMkiItlFjKO44BOvssL5TNaMvIDitZy1jXBXWBKjzpYX8Mx4rAoS62I+7mgeNRyzM9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvnRd2RC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8a4bad409so1089554a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726177636; x=1726782436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JsWhR8gwhIgZn+pbrFdMh9BmPu7oeqwCL3qrJFQSY4w=;
        b=CvnRd2RCE1QUevBIuAVQOx3ClF4rPnzKjQnH4gXUZwCQ/P/yp5LU69lMyQlc+n4wZh
         amFFjn+RQbWTOqeWA4o3O6ZA+uO5+knhN8qClgPsPqIKXffXQNgluHe7tagwb0Em/q3M
         wRirFNzWkkFfmMYZeJ03orlGu1TJ4b2sa4ZDkSDbXMoaizL1Ud++se3ONDEuNGPT5xk8
         EZllcnVwIaIlu0lwuDeu9EDt429pMk59an9z9+cRdubj0ID9Lk6IUUA2QjZLyADHS+FG
         dU8pwEUKCbLWTrqwPGIqCV1WCee5Xu3SHWhKqFKLHsFvHlFbXfzhRbcbxqWAJb36YND3
         MgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177636; x=1726782436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JsWhR8gwhIgZn+pbrFdMh9BmPu7oeqwCL3qrJFQSY4w=;
        b=umfjfSVuPIrYhBPpq6mIHFyK+sV7X1tiZ/S31wBkdi887ZBie3iwP+HR7dV3Oxexok
         EW+IJOsdxjB9prIiLPeHvStcD9cCZ5ijoH9Voof96xPAxrZjseEE3xWL8/4QG21zQfWV
         7cQmGGwI0lxLRt0OFYeE8cDSUj1ppFHSlocNG9rtJYyzq43aInTi3vV2cEas/rFzHz1A
         WPArqEMhaVrMo3tuyp0gUQXqS79o8WvsPBz2n4dXRw3ERQBQVXi+5fd3qVaMGTtPmJMh
         YfgeleSjxr5ZzPubouKCIpAhypiYxrr3S8hSoIf/SfAkZ//3dxnRfj3r+hB5jEKFrBj9
         np4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDxAH6lejNrSj9fz0POWGJJwg1fqmjLy1GzL6C/DY/Xt7njzOlq7uv9TidovES6eRoHZ5nOBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+4Pr6bkENRhAAdHRJStWRWl11WaXbI/91g2cB+M35Nilbwxg
	ijC9SklFUXRk+iVx/5+aRgI1K1AkAuXb7TbBxrdTJWaDL2u7ZWG10iOJ
X-Google-Smtp-Source: AGHT+IEwzLtx3GyppSj36oJpQCgieVaURPEK2nUkf2kHYNtgZ6kpzMSiAvTtj/C8ydKbVXFsn2zm0g==
X-Received: by 2002:a17:90b:4c41:b0:2c9:3370:56e3 with SMTP id 98e67ed59e1d1-2dba008304amr4609470a91.34.1726177635837;
        Thu, 12 Sep 2024 14:47:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c51268sm223400a91.11.2024.09.12.14.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:47:15 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:47:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 11/13] selftests: ncdevmem: Remove hard-coded
 queue numbers
Message-ID: <ZuNhYn7wlXddLWiO@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-12-sdf@fomichev.me>
 <CAHS8izNKzuNX-nttnucfVioOt4PuMOfq0h=5W5=30jouP_2qvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNKzuNX-nttnucfVioOt4PuMOfq0h=5W5=30jouP_2qvA@mail.gmail.com>

On 09/12, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 10:13 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Use single last queue of the device and probe it dynamically.
> >
> 
> Can we use the last N queues, instead of 1? Or the last half of the queues?
> 
> Test coverage that we can bind multiple queues at once is important, I think.

Anything against doing this in the selftest/probe part?

if (probe) {
	if (start_queue > 1) {
		/* make sure can bind to multiple queues */
		start_queue -= 1;
		num_queues +=1;
	}
	run_devmem_tests();
	return 0;
}

