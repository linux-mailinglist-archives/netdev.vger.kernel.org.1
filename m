Return-Path: <netdev+bounces-148501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 043439E1E15
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5E8161316
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF11F4711;
	Tue,  3 Dec 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUhcTFJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FCF1F4282
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233440; cv=none; b=LaI3VcMV3+5jTw0A3fo9bjHsWeECabsrGz4Wy1572DyU03PQp4g/NDpdBJbDpwTllbDT+WGSB01+TF7bc9jQNyrmqTsQLSAjgIcerSz9jADQeo7EKEJFyk0vpw+f5j/X4FI7CwfNQhC7pi06nIXW/X/SqQ1XGG1TrUPafymz2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233440; c=relaxed/simple;
	bh=Ry13v3NzXUSw18lkGn5nUZFgjPN1r9/Bisyl3C4YKBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9tAJSST9kAJqeIaOAeAkkKgNmINNydQfm9kwJEtNOa7Jat5wMwC9Sgl8aesTKNR5YsmVPQtTjZN0IxiK6Zj/kxqSZnrgcIgoPJyFJA8PcvOZX0ky/ukKHnOuJqQ65+O8Dq9Qz/QhW+tKM/nd1Q3wG826P1KslQ67+pcziRvdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUhcTFJU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4349dea3e0dso5460485e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 05:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733233437; x=1733838237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqkGj42G2/n/di+k6LsyHMwJysNHG2ZEoIS32cKqwmM=;
        b=eUhcTFJUL4rLur+RlPEimy6HwAt4D240In/hFi7Zky/K0I7eA9eLzCvs9MXGvalf7D
         MdngNfQfhoHHeY4tvZNaOwoPVfzw06umbppF9EUaIGAnCwS5BUuzhyQVQNPPoMeQX0w3
         93o82ixB8xOR/NiTZtakb4HHr5ipo73qRFMZlbdNqJJQwGiQZeZOc2JqaPwORW3pIGkA
         m55er5y+8H1rgoc6tK+PgPqa8JXQboCbu/gRAM7c+QM52vNVGi6miktJWtABSmvoterX
         a6PjCX6Or/awo+Mb7Uk7uTKT3W1/0616l0/0pkfy+6tGiy/YGt6VVND3sxvb+hCp1flV
         8dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233437; x=1733838237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqkGj42G2/n/di+k6LsyHMwJysNHG2ZEoIS32cKqwmM=;
        b=iHAv2/N3EyflUbUmqr5WI+DCRmz2B0D8u4S04Q173lhzs82Omo3atEEZXUM6rkBwao
         9qk8P+2KV6dQ/HD4TgMp2taoD4d4q7aqhjQdj18WboU0PJWyii+XWyhxjqf5VQclKcNd
         RdRhV6Mlj4zDsGs0vE3JuYHJ6h3dxTzEG94anlJwT+LSxeaB78sdzseXPgbUyqzQgWYc
         +kIWRA69Lvpqit41/DYNkRC9BGKIQr8n1tD0VicE1+yXV6A1uCOaYTC64zFGd8OFNd8c
         knL91T4r9y+f/OPz1SoTl4+0JRoDQy5Z2R8qoI2GIkj1Xht1lq/QReoc0udIJa6+35vk
         t4PA==
X-Forwarded-Encrypted: i=1; AJvYcCVandzOfXxUrW0Q0MeS7skam1AjhNGGIvTssp7gHwj8kvH1Uv4BqH9tWCkl5cjPZru/O3fZ3nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwl8y9r7RrufuegQrva1VpbmFQ/x7JZ0tv19V4mSFW4GgF0UQJ
	Qhip0CQMHVkRvXPgwv5fwxTfGUwrJj5Gb2KGAypCtALT8Qi3N8Gw
X-Gm-Gg: ASbGncu229kvqlDFpSt+tT5CAKAqRtjAGZTVLnj7Aue5x3u5QY0Xxba51xSoPX8Z+KD
	GssimGy0qkbOSXnEcexRQggwk07+0l/WgxPnyN06XLnXRISsYYDXN8652c6nCM7zBgRcx8Y9KzM
	Ke5yMVnFABQvgcoLLFN+qou4jhdcZ0RmUVRb5mdtWwOdLZSu0bBNoYla2ZStOx8E6DlsubQfNvJ
	bOdMKHw/3eHL/ul3zHKSkf4ptNjEye9ou8aFPE=
X-Google-Smtp-Source: AGHT+IGdgmd5B7J7e4bSDEKw//Z2fzTDr/DQ2HKrsTROH+dU1dn2E0O4VQSMq2GdcVpozUJGV/GaBw==
X-Received: by 2002:a05:600c:46cf:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-434d0a1f397mr8296745e9.7.1733233437185;
        Tue, 03 Dec 2024 05:43:57 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e30c54bfsm10419145f8f.110.2024.12.03.05.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:43:56 -0800 (PST)
Date: Tue, 3 Dec 2024 15:43:54 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v7 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
Message-ID: <20241203134354.mormzine4gt37xha@skbuf>
References: <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-6-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-6-ed22e38e6c65@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-packing-pack-fields-and-ice-implementation-v7-6-ed22e38e6c65@intel.com>
 <20241202-packing-pack-fields-and-ice-implementation-v7-6-ed22e38e6c65@intel.com>

On Mon, Dec 02, 2024 at 04:26:29PM -0800, Jacob Keller wrote:
> +/**
> + * ice_pack_rxq_ctx - Pack Rx queue context into a HW buffer
> + * @ctx: the Rx queue context to pack
> + * @buf: the HW buffer to pack into
> + *
> + * Pack the Rx queue context from the CPU-friendly unpacked buffer into its
> + * bit-packed HW layout.
> + */
> +static void ice_pack_rxq_ctx(const struct ice_rlan_ctx *ctx,
> +			     ice_rxq_ctx_buf_t *buf)
> +{
> +	pack_fields(buf, sizeof(*buf), ctx, ice_rlan_ctx_fields,
> +		    QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST);

An alternative pack_fields() design would enforce that the pbuf argument
has a sizeof() which reveals the packed buffer size. Pro: one macro
argument less. Con: too intrusive in forcing authors to write code in a
certain way maybe?

> +}

