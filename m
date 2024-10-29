Return-Path: <netdev+bounces-140042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE769B51C4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1385A284543
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ED0155316;
	Tue, 29 Oct 2024 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSt9ar8U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD1042A80;
	Tue, 29 Oct 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226515; cv=none; b=HfJV22Fy2XshIoJtOQmFXoV75EDvqWyaXG0QbF1+Jt+gj3f0awN8RbdkvbH3/dCDL3iwoyYPhqSEPfSVH0vp7ss0+jZCJDquRNKEfdrqlCB2kYbSWQRwk2xV9sSs+Vb/EHS44wvRQU0c6lRH9+9OJyIPsAfyiExeXLjoQkFQ8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226515; c=relaxed/simple;
	bh=GlXuBhAWQJ0Y9uwUyXNrx0vBVJymCZRecaCWBOqP9XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLMhNOTLsWuc9Rml5UwsINBdY8TcNZ5eAim6FZBlSDZ9MqmZLBVKzXx/m6A0Pec+ecgvaBWnChspyDwSaW/HLUSQ4HmN5Kmc2iUKMPnbX8WJw0D6RLy7/tWUstW0wSKliHB68dBFCb3rHSe9J+Cj31kj83uGGVYRJWY6KETaJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSt9ar8U; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d570728ebso720215f8f.2;
        Tue, 29 Oct 2024 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730226511; x=1730831311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p38Nw/wn8P1HtvutoMsQSBm8NKDoK6ubRUVWzA0Btis=;
        b=GSt9ar8UEO+2fMf01fjrxv8UYN9nBi5IbqJdDZcNGQb4BwhRha+W5UxPgAqSknpMuy
         oZAErrGaq3ubuITvETNOKdsh14ZNT20jVLLtdRs9EnTR1R0tQ5zfgUtgv73OucthTY3Q
         SjA6rC0NvVJqudihpa9+ewpi2rvL1QYXXiu36/gPZByDnJL7+V1IEtN+j+pq/tH/RFIb
         tiGPDErDy6N9zOZeVoiBBU4XB43pM2ge0+FD1XbS/k9UfE9rYbA0a4e53pmoufkrNZeD
         FB+N5/XNkEzBFZRmP7I5NUa3OSlBbOrvvJvKGQ9H4e0yOBLlKKp7dSrsFpkbWt/dK9iU
         +dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730226511; x=1730831311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p38Nw/wn8P1HtvutoMsQSBm8NKDoK6ubRUVWzA0Btis=;
        b=I6KT2Pc4jhI2/VRN9AfBArZShG8Jj1aQfrI+Tj2BlFYzIuG0aVXLMLtY6myvslDxA1
         M3H0G5YtyEYNzuYHA0dJxzEAd0NS9E28dDBM5eMbctczoTmQ++KZvVqD+R8WmsmFrQjC
         5FGitzfxNfQybEcrZcJEPfjACMZ8lwCKR6Dli/+pFUWYiuJdZr3EL99PgFKGU50xn163
         EnEEKlfQZOozhZNgaVX9AVUcHGIR3dvFcdUrlnalcdN3Hv8cOEgE6FPeB9bOKxHwQvEi
         DtHFPwaO8/+dGqW+KsliwcbIc2Uh4hmfUHwrCzZ+5SUECt+xuxRM5I/WHkIBENPzVTss
         gUsw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Wv3e9b3Vgs/ThK1UDfIWoHjDO3HCn9Q9cRJyEQynvevJ3dE3bOPFpFJZ49A7VT5hV1k2Rdj7@vger.kernel.org, AJvYcCVKKnvww2ccWoAYeog1E7V/0Pcoiz4Bue5ecBfBuWAWsa1buQVU2Mo2cUSRxic1GYXmHP+LmhHFeWn+yMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RJ1MJMpDyr2erglydYkcZxNKHMXYhpoyJMTq5KNMQo9mNQhF
	wUxdxHgL/LW6Bm9rkzY45/X8O/LUnjqAGDd+w9cDvOg7LOsor+65
X-Google-Smtp-Source: AGHT+IGxEyO2SZEGXuddS7oneYG/VfTQFgXCrabkVo4IppTaYF9yjLKtIZ4oYyZTm16h/8jag8IM5A==
X-Received: by 2002:a5d:47c2:0:b0:374:ca43:ac00 with SMTP id ffacd0b85a97d-38061126ae4mr3808713f8f.4.1730226510979;
        Tue, 29 Oct 2024 11:28:30 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b91f43sm13353284f8f.92.2024.10.29.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 11:28:30 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:28:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/9] lib: packing: introduce and use
 (un)pack_fields
Message-ID: <20241029182827.u4az53onywedeot6@skbuf>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>

On Fri, Oct 25, 2024 at 05:04:52PM -0700, Jacob Keller wrote:
> This series improves the packing library with a new API for packing or
> unpacking a large number of fields at once with minimal code footprint. The
> API is then used to replace bespoke packing logic in the ice driver,
> preparing it to handle unpacking in the future. Finally, the ice driver has
> a few other cleanups related to the packing logic.
> 
> The pack_fields and unpack_fields functions have the following improvements
> over the existing pack() and unpack() API:
> 
>  1. Packing or unpacking a large number of fields takes significantly less
>     code. This significantly reduces the .text size for an increase in the
>     .data size which is much smaller.
> 
>  2. The unpacked data can be stored in sizes smaller than u64 variables.
>     This reduces the storage requirement both for runtime data structures,
>     and for the rodata defining the fields. This scales with the number of
>     fields used.
> 
>  3. Most of the error checking is done at compile time, rather than
>     runtime via CHECK_PACKED_FIELD_* macros. This saves wasted computation
>     time, *and* catches errors in the field definitions immediately instead
>     of only after the offending code executes.
> 
> The actual packing and unpacking code still uses the u64 size
> variables. However, these are converted to the appropriate field sizes when
> storing or reading the data from the buffer.
> 
> One complexity is that the CHECK_PACKED_FIELD_* macros need to be defined
> one per size of the packed_fields array. This is because we don't have a
> good way to handle the ordering checks otherwise. The C pre-processor is
> unable to generate and run variable length loops at compile time.
> 
> This is a significant amount of macro code, ~22,000 lines of code. To
> ensure it is correct and to avoid needing to store this directly in the
> kernel history, this file is generated as <generated/packing-checks.h> via
> a small C program, gen_packing_checks. To generate this, we need to update
> the top level Kbuild process to include the compilation of
> gen_packing_checks and execution to generate the packing-checks.h file.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Changes in v2:
> - Add my missing sign-off to the first patch
> - Update the descriptions for a few patches
> - Only generate CHECK_PACKED_FIELDS_N when another module selects it
> - Add a new patch introducing wrapper structures for the packed Tx and Rx
>   queue context, suggested by Vladimir.
> - Drop the now unnecessary macros in ice, thanks to the new types
> - Link to v1: https://lore.kernel.org/r/20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com

For the set:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Thanks for working on this!

