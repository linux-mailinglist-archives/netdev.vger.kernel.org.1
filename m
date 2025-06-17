Return-Path: <netdev+bounces-198780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759FFADDC5E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA9E7AA4EA
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4B128C5A7;
	Tue, 17 Jun 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Wa04klLd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868225C82E
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188761; cv=none; b=IjuvwqpXAi9Ah6D9HGgWVFLVMAJZCMHxqn7VlZQIR7BAKkrdkxG8uoIjSXmzxJYKdCjCmYFeVe3SMSBdDtYI6nsM/VYC/IIdEuD1WZjzmmJ7stMK2YnOqqPe+bum2Oj257poHCEMK+d5mRVUjPfnf9B0Qh/ovqpjRzzJTutDdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188761; c=relaxed/simple;
	bh=maosBMqcEUMS4h2mAKWow8LWfPYq+6TS1PNZ4TsGvMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmarIS83fwN9ZU02Yn57dB7Q6eWIPYbX113CmhyFJ1QJmjCSMvw/ccM03vTov86petsfKSNKsVyYYpgVI8/yv7zo5cyHhpzNAyVP3qsrJvmcYMHKK26v/oYIE5ZZPac8APMf+Q3AMfaasBvrSbH9QSuGvodPGkU9gxRKDcr1E8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Wa04klLd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so5042210f8f.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750188756; x=1750793556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2mnqssJBMGEGZ4yel65uTxyhzurhDZlVcPz9/ChFNk=;
        b=Wa04klLdkmQ/xKvpWT52JECt8nLb8Z2fpNzWpRZQ82JEo/gQS+yLjDcQaZh3JHCkRm
         NjpzUUNP060TMA3a6eXE5nG0ImgrtpJfwEH1RjgETk2pPwwW2TGEf2FPHjecabjxq/Ga
         e1rZwxZP0J+qcsfGN3w8j24ygU9PL9V87Mm5MbQREU7u9BeFGhAWHpKY21HgFNTUMK+o
         CTQ38tubaUTNE7ZxWVGcamDhxu5n5Yb2bfUJ6cwsg3cqlerL3MUTUCTqsBSbR2/I/cXi
         n5FoWoH7SbiP6AOp6zOz84ceDKICzTZDF9DmfHrJp160Or6wgIp3jTJ73tSTku8cnUpj
         f7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188756; x=1750793556;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2mnqssJBMGEGZ4yel65uTxyhzurhDZlVcPz9/ChFNk=;
        b=EZ7ZQZhrb52W7f906KvaYCJhEzD3sMozY0oO/jxBjohe6cDV5HfiTAuC1NfflSQU08
         tX5r7I+0WVH4KdHTsOhUfTjr0I9xpPZkukgqYJPTujnGVbCHs7Sc8PZ41TeDAvSrxnIf
         9GpnR/0Byo2dMKmj4LgTiVbnajB04xqx0GATX2LzKUqNtyP1srn3wo/SeIJzKywH4sfh
         rLxGwRNTPBVk5gCmwamAggk8hrRKrwQ8djZu4MaZ7viVP4AYiikkAYfp6Hr+5F9YO4y4
         dsFVAFINj29IQg41l99hEor+FOvWha3McJPdSpotNBEiB3Thm9e5PufrBvF87lynLzBT
         ab3A==
X-Forwarded-Encrypted: i=1; AJvYcCUBYzIDsahiTpBLDenMGa4cSWe/HMHHAGfxMBSAKVYDjbV8Dzi/dleD0VXPUsoaTlueJrFuTS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHXwRUe8LDD5EfftIqXf9MbRH1igKenl1XoKloK5Pfa/B4tUp
	UjsS+JWcCM1F4DCpVC77V9RhQhMWXzdljx/AJkQIvYWqxKvy2iQKf0L9GdVqwlGHHtQ=
X-Gm-Gg: ASbGncudrTk0ZmQxW2eCy2NIBwcA0V4pRA1wjR3r8gPI+WS773SdIanTnqnA1RRru+j
	jE8aXA1HERDh5zs45vBdYZvNQCZsfwdc2EttHH2X8aWK/KP90//xFr8cBlce0vU1DKqntxGNx1u
	S3T472ENG6TWySGNoapxvQjJpEOaimCTYTu0PDE/bq6eBwYyFZF6mizNITngO0XQvKZu3SZY6ef
	e0hyLUiWFS3ebzaydwyLJ/u1q3AeYmt5A6nZZEehgvJ1CpZFG4j+ePVZXLDCOF13Sa+SHOlw869
	6/wrXqzfi6lG0zGJ+3MJ9K9U5Tu5uZzIggi+ph9MuuOORySdsdyJTCf9I0xW9aOYkSo=
X-Google-Smtp-Source: AGHT+IFvX8UDNBBi5DC3/Ybdm1840HegO6/7yt18rWlEL7Zc3/qU8HDPT3MpH4li36+sH1FH3nFgGQ==
X-Received: by 2002:a05:6000:71c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a572367afbmr12226086f8f.4.1750188755945;
        Tue, 17 Jun 2025 12:32:35 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6389esm14585247f8f.27.2025.06.17.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:32:35 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:32:32 +0300
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
Subject: Re: [PATCH net-next v3 2/4] netdevsim: collect statistics at RX side
Message-ID: <aFHC0AFQoJ98Xo2A@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	gustavold@gmail.com
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
 <20250617-netdevsim_stat-v3-2-afe4bdcbf237@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-netdevsim_stat-v3-2-afe4bdcbf237@debian.org>

On Tue, Jun 17, 2025 at 01:18:58AM -0700, Breno Leitao wrote:
> When the RX side of netdevsim was added, the RX statistics were missing,
> making the driver unusable for GenerateTraffic() test framework.
> 
> This patch adds proper statistics tracking on RX side, complementing the
> TX path.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netdevsim/netdev.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

Thanks for moving the RX accounting around.

Reviewed-by: Joe Damato <joe@dama.to>

