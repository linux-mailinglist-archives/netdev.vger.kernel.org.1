Return-Path: <netdev+bounces-135213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E045B99CCFB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7A1C22505
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1E1AB6DA;
	Mon, 14 Oct 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEO+2Bai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3481AAC4;
	Mon, 14 Oct 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916040; cv=none; b=H6nPwgHbv7Kfy92BQwB5njNZkM/8IiqwqhCa9Q+RyZUjHz60CV9HuipdUPBKxvUs/uTVIbocNHs6En2iNK7ML+85g2Knt2k7c1wdmpdbBj/Vd8WEahH4juzLA972o/SamkN/+5sJIVzNhtO0wrC88tkLYNThUl79YFWZLWywmAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916040; c=relaxed/simple;
	bh=WEDA3/5i1PMkYapLq8RmXqKUWXx3zwsyD6Bwe1ka4fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYyaaKzG3lm+ztSIqesqjMS9jf0cR7GwX57DSxDreX8zzMVhvXQ8QstHcDYUG528xebUQ7dKs4F6JGVOxxYeaQU7P/LYy90DJecy18hCFyuadnUgq9AcepwAomT5x5WkxiK1Ti3gv8jcc/7IlaCuJTjRy5+zk7BfaUH5I6ZUywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEO+2Bai; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d5231f71cso166410f8f.2;
        Mon, 14 Oct 2024 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728916037; x=1729520837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4fI7ZFSKGrcvx+dthi4wOxiRSSJeKc/d/ltpVnmO6BA=;
        b=ZEO+2BaiSEzo3ZgZftd7DsKHBCtog0VkS78asSVlJk3t0hZVNEbtztG8Kss50bdwRI
         YZYvf+g1Hm8d2O3fkVzx8aAkBzXn0dIHc84YYa1I3+JcX+9iUVSAtLRVmmghgmoOldHk
         SOq/juAFGZroysNXE3yutPrOgPLx8cSAZXbX5x+as8X0/bQmq2BVySa6LV2BzWjGAqW+
         Svs6PPHIEy6gtO9jdAeiActSvnsmHHeEl1odUHZsx8dEcAyQ1T1gkZxSSwxzut2q0jiB
         0Xt0ANOeMUC17TCvn+blSWISr3b0C/BBEbZ6BodBNFfoNt9I8yIkz0E/mvYRKQKRKcyN
         Af8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916037; x=1729520837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fI7ZFSKGrcvx+dthi4wOxiRSSJeKc/d/ltpVnmO6BA=;
        b=gZJmefv4neihAr8zN9StS6jGWZUX5w2og+ZX4OQf0ljTTmHkHDk1kElqjuK9oAlXna
         XhnY+N3/uOUkuZgxxVImLRnAtbjmjumjJV05E2S1aF6eMYkwPUeOLHNvvHmwCnovTWOC
         mt2AkHGZB7a3+JTogYAcR+QV4/euT7TuWK6DYvLfAtqawsgswqwnOxdTthRATZQUmJkc
         MkrpmrVL8k5LgO3aPJKjJT2zJ1rE5DKvD/kqcNB3r8vITgiafz8mjuczgOLhhwlRJB9N
         Hh70MK+ggnRuVJDxH+AV+P0SxV160BntJuVx9FQ1rufK6m2xcIFp7UJKzIA0rhdyDkRn
         LP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV88nhKi/FcQwHxfZ7HoxTT88cm2cDewqJK2J7Cpzx5Wl//Xp8H9qla/17Lle+fdmTGbJZRJnZd2GEujZo=@vger.kernel.org, AJvYcCV9X6/eQIFA+4t2WVA58Go48xxdt4Nd1Lz0W+HG42+/iGJY/TRrNJa/JFMxbF4b/ptV5TPn9yRG@vger.kernel.org
X-Gm-Message-State: AOJu0YxDked5cRG6yHuRELpk70Dh7BBkojuZgf5zu5pMm84yNMk+1obV
	+BL/dY8c0J7t2fDxR8XwZZkcVDTXCubWl7dXJWnOdHWPgLkrVuWyw3CXQqFV
X-Google-Smtp-Source: AGHT+IHNAchLhtGUMOU9OShafD6JmcbWIxzB5YkF/e9JFt2C7kEkpnPVbGbyrepTyLlcxO/ZeBYkcQ==
X-Received: by 2002:a5d:5989:0:b0:37d:2e83:bc44 with SMTP id ffacd0b85a97d-37d5533447dmr3804202f8f.9.1728916037024;
        Mon, 14 Oct 2024 07:27:17 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937119cb7sm5084166a12.36.2024.10.14.07.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:27:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:27:13 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next 1/8] lib: packing: create __pack() and
 __unpack() variants without error checking
Message-ID: <20241014142713.yst257gxlijdxdw2@skbuf>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
 <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>

On Fri, Oct 11, 2024 at 11:48:29AM -0700, Jacob Keller wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> A future variant of the API, which works on arrays of packed_field
> structures, will make most of these checks redundant. The idea will be
> that we want to perform sanity checks only once at boot time, not once
> for every function call. So we need faster variants of pack() and
> unpack(), which assume that the input was pre-sanitized.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

All patches with an author different than the submitter must have the
submitter sign off on them as well.

Please do not resend without some reviewer activity first on the code
generation portion from patch 3/8, though.

