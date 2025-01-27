Return-Path: <netdev+bounces-161158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF819A1DAFE
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0278018873F1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371518628F;
	Mon, 27 Jan 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="w4WFE9mX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC293D64
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997605; cv=none; b=pXXCmPT463GNM8wqh6srdnt2aJ6owA9EcUHlDVji656Wmxn854WeIa1M7F16gXUgicvihplqZ9a57ayvAORxiw3yVZ+RZi13wSuAaTw/YlBV8Jk3aIqOhXGCYNE9d7ke7HCyKj/rex9SBYmzFYswbte9aDN33JCcLu5onbfVy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997605; c=relaxed/simple;
	bh=qlqx4rZqHC/l3KePO8UHK/0zGhIXXgbP80fO3bq2P5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhG1TI6bgD9EomhWzatd0XBrMHW9hHGsrEBtORIcyH8im8pWYTca8f3hFK4bDR+COfu1z6IPx8iE22Rro4KDNlyBkecOwJEM/5jORO7Y3LHemYZSdMKmavUh5WUQkwSnsdaT3sKbzMhxcqj5H8Ey6cMqAgblShbrEoOUMgjoW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=w4WFE9mX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21636268e43so103082955ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 09:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737997603; x=1738602403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E34pl0BoUrncaZIlq/JLi0x1yytukPdl98VLmKsLLMY=;
        b=w4WFE9mX6Tgf9Wpk3llCE1L2l7m2NM6VvwIggnZDE6Ji/JZORz8BFJ73zuxwx4lfXB
         7yNnZcjc5TJHoEO43IzO1y33PxDfnGBfKNakaV8AZgcdqVrS7GlykkUQWa0oNyISnMU1
         youfyRwRfL+vnmZ6Nl0qRHT3MDScBV7wRdkck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997603; x=1738602403;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E34pl0BoUrncaZIlq/JLi0x1yytukPdl98VLmKsLLMY=;
        b=qX9GWdoUZrOWvBtfwwL7patAFrjKt12ySiyU0w2tEHewMHZnoxWkCKIxu3iNRpghSK
         xU41cLP47YDctB4ZbFfvXpHK4GLw9GtXixnH9KhxMDQoEAPjeP5e81qSjrJt6U+p2KL5
         +qGzgoY1+RX8zezjMehnQTvC0rz5acTPlFgBY/zfz2/FxFv7P/5zDv0JG7NTsi1KdbaS
         3TsKAvA9ucPO4XNxqL+CtIddL8jcXDwRGQ2x0/zdJ1Hou7JegT4+1KiGQ1LpF0/mM519
         MHZmsVIzXEB53Gq72+cF3EfQcSWlmzLuc3jniSNmrRn6Keyo8qsardAR+ADSlYn5HQ/t
         BKAA==
X-Forwarded-Encrypted: i=1; AJvYcCXnsxIqnNPNYSbv4Xfr4Xn760KrZcq0WCeQGj49OqWKF87bGWARl2yXUncOVGnnjkYsJDKe9DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxruOBePXMoFi6oiQVaDA/ktaxORGKYlCXpD1AvKb9B8KrN/dTm
	33cIbwFD2l38gFwou7nTq2SL+oxhJlx1yvnu4f7urCyFk+uvNTbqK2WnR4P1qPA=
X-Gm-Gg: ASbGncvFfeIqCpwKDcjh0nx4TfwVkxQcelo5OiQQKd9D6RSJJJmcTwon+jAx3xNeFzk
	b+8D9JbGULvb0lDq4qKCOIzZMl3npUbcHl/TIkXjtZEepdm1NJiJd56iL+MTC7MtbrT/MNYQoIn
	dY9kZUkO7gMFRujkCWtx23xEFf6IMAa5ul8yYkz904eBfea6dEfy+qX75jwL02iHhK/wKDXRj7T
	3KVcSeBd06Re6C6jsO85GTCztU5b+vRW+dV6JjO2rT9yYJWcdybmF2RslbzlvUokDHlNXxQSfmi
	k/0Wsb5yrdGvSbDHqw5Tsp3hHjTlFa/XpgUCtfrEz/7uiY1d
X-Google-Smtp-Source: AGHT+IFO7lCRngJ2/Aoer2/vVcK0gak0j2svkFSPh0vTnwbSvuIYQZoRmS5k3Yckv3NAUnyMvW4Twg==
X-Received: by 2002:a17:903:2283:b0:215:7421:262 with SMTP id d9443c01a7336-21c3540a248mr713566675ad.12.1737997603237;
        Mon, 27 Jan 2025 09:06:43 -0800 (PST)
Received: from LQ3V64L9R2 (ip-185-104-139-70.ptr.icomera.net. [185.104.139.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414cc61sm65382575ad.164.2025.01.27.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 09:06:42 -0800 (PST)
Date: Mon, 27 Jan 2025 12:06:39 -0500
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca
Subject: Re: [PATCH net-next v2 0/4] Add support to do threaded napi busy poll
Message-ID: <Z5e9H6dtwyrGQFfK@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca
References: <20250123231236.2657321-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123231236.2657321-1-skhawaja@google.com>

On Thu, Jan 23, 2025 at 11:12:32PM +0000, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors from
> backing RX/TX queues for low latency applications. Allow enabling of threaded
> busypoll using netlink so this can be enabled on a set of dedicated napis for
> low latency applications.
> 
> It allows enabling NAPI busy poll for any userspace application
> indepdendent of userspace API being used for packet and event processing
> (epoll, io_uring, raw socket APIs). Once enabled user can fetch the PID
> of the kthread doing NAPI polling and set affinity, priority and
> scheduler for it depending on the low-latency requirements.

When you resubmit this after the merge window (or if you resubmit it
as an RFC), would you mind CCing both me (jdamato@fastly.com) and
Martin (mkarsten@uwaterloo.ca) ?

We almost missed this revision after commenting on the previous
version, since we weren't included in the CC list.

Both Martin and I read through the cover letter and proposed changes
and have several questions/comments, but given that the thread is
marked as deferred/closed due to the merge window, we'll hold off
on digging in until the next revision is posted.

