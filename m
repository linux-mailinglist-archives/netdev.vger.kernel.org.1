Return-Path: <netdev+bounces-248853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C378D0FDF7
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A73330617E2
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C344726562D;
	Sun, 11 Jan 2026 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxLhH+rc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D002641CA
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768165176; cv=none; b=V222NFtH4pgvmeZIzPcpzHDZGqrXqp3qm2nd4orkxMngUyS0GSwoegVLIHyOwp4tnP3AvYuMlNf8zvAQ8TmffCfKw/XSmeCf9LD9W14RttWT6bcRRwfHBJ5Z4oh2GdO1WWs8m+wOyRXP8duEH4YDseMsEHgbijgtr0REEpLKK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768165176; c=relaxed/simple;
	bh=9cMqLVdnlfr5VoREHhzueSPLC6rLwb22tF8EKySvNfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4KzaymUxmtYDtERxXwa65Fmd0VxsRUNZtSdFQOsMVVaAKBhZKN9amUxAKitS/XqOv1aC5Uj7681AalSYz9M8fEYVEA7SJqb03yXWC0uLDPv8ioE7ylKgg6RGxpue2Jp25mqnE9/+xubPC2CZ8ome8YR5RGHzqZlZ/odOUMnAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxLhH+rc; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1205a8718afso6349205c88.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768165173; x=1768769973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tk5+OCorRg8A3Jr2MKWpFXAr4+NCiPUyLmkpARaUCDQ=;
        b=QxLhH+rczBwu7O99XrLJ4B85+QG6P6FfwOzfRZAKSK0XIUp1FS9bFEu0r7ycZLpFtK
         cvtK0oUsIg4IIo4PJ3BYy/m1Vq7E+7sB59VgLWfNJPqVOdWPiHwd1Tnnus8QJMu+lgfV
         6GXi/YQsLIHTWBoWHeUnHNHdU2fwhJSycQjLd+RUwHmVcKX9TpPjFqpzvudi7oTWcjN7
         M1dKH3rD1OXd2z919THnxGikrZiXDOzXi9TJntooGQUG0YFUNNLG/MQ0DKKr7h0Oqjl5
         eRKF5dHihWiQgFhzv4NXuzNlgt61yNmhIgLtYccBIYdj2UV34ooZdme51PAGyRzGWuQy
         zr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768165173; x=1768769973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk5+OCorRg8A3Jr2MKWpFXAr4+NCiPUyLmkpARaUCDQ=;
        b=CTyaTuCBjrtrzDnI/7qz2BxKnZeSuPSaz642ystfAL5UzhwuGD0tQXWCeECrsjN+Ud
         kPfUQJri+Cu7n6A/snDzZwYte1iXlmaUcyPG9/UWxlWPRjUw4WidKvIEpCvXw6z9d6xK
         m/HcJQEhS/ME7n64frhq0wsBtmp/9TlYyZkwHWY0oU8J6sVur4ZEB65kdYsHWO93OyhT
         iFq+HEKkLqcYd4SHvVyj7U74VYWQChYRY5D13pvAy6shVWLYYPmMGrB6tAvHgkl9KRFY
         luhlGO4ph3svY/huuGE2DMqURLd38ag7/5G5p3W4715VrtxIgBFrT0k2qEpA6JdYxvH1
         Wd/Q==
X-Gm-Message-State: AOJu0Yz6j++CMY0sNvMc0hyCCo3IVDpXdKPqhhjnDijPpFtjXIWgisCL
	kloLRDuHDOs1vEPJ9cgC8PvaQ2KAJOrsbJ6ini9CbSElcIzKzS5eIxA=
X-Gm-Gg: AY/fxX7GRL2zwIqjDV6XdQo+ChWAE0QHAumYTCTRIFpJDACsNAG3+2ZlmUwuljaulbQ
	c1eS8GF9Gj7ya2ozKbCqf3bUy01uXxcwrC7BwyzGCQfNkCQsCmLtSK5s+4XXvSH6SyIuFS4Osr4
	TmWhS882BztEXi5yj+Da4llTxpRJxqsdjzX0WiYV9ho/v4KORX9Od3JBUJD5ft46kjvumgVyFtq
	Ggb87/CdF8HsSPBl6Aj11DE9dTTayXgfXCjKcP11E2QJ8RkqNVN0u9cRYirFrLCIlfk4uoGE20J
	u4AaW05ljS/iI+ZXOaD5rd1iwnJ0+9dCogmT0Lbmn+1YAeDpeWKCZaO6wrz5Xyy1VmsCW54vpdk
	3vvp/w+pShV+zLVfEBQTtJMA63JRMjBvftP/kV2CvCUCciH7xwUNvyEVtB7NIFQDFDG7R8qoLxy
	XsgqRRdEXEfIExGXJyzjCqgnPJBvutXSWFV2qAaEYq/KGHKWRbcTGVJBvwS3HqhinEMTlZQfjLF
	iv9yg==
X-Google-Smtp-Source: AGHT+IEdltKZuIXPtfMp5G6LJA7IDXw/XJYLJeSYppqof2AJjZUPjmPHEVu+QC8ZZUWWmYmGwG65vg==
X-Received: by 2002:a05:7022:620:b0:11b:a73b:2327 with SMTP id a92af1059eb24-121f8b7b38dmr14826869c88.30.1768165173249;
        Sun, 11 Jan 2026 12:59:33 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm19093739c88.9.2026.01.11.12.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:59:32 -0800 (PST)
Date: Sun, 11 Jan 2026 12:59:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v5 13/16] selftests/net: Add bpf skb forwarding
 program
Message-ID: <aWQPNM5Sh1QNKtp7@mini-arch>
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-14-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109212632.146920-14-daniel@iogearbox.net>

On 01/09, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
> prefix received on eth0 ifindex to a specified netkit ifindex. This will
> be needed by netkit container tests.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  .../selftests/drivers/net/hw/.gitignore       |  2 +
>  .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
> index 46540468a775..9ae058dba155 100644
> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
> @@ -2,3 +2,5 @@
>  iou-zcrx
>  ncdevmem
>  toeplitz
> +# bpftool

nit: "# bpftool" is not needed here?

