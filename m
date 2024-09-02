Return-Path: <netdev+bounces-124327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA07969068
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 01:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADD91C2169B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 23:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB781A4E8D;
	Mon,  2 Sep 2024 23:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3R2LoJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB432032A
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725319531; cv=none; b=OCaXgnEZhYH08hzk+ENfs2drIgag6c021MavG7Cluj3odIIMr+JY4CN59fM9jKKd3HYsjqBbOFPBawrVtmTHNxLOZoxjLPFVGKbJxZqdDtCi+vuDl8RYn519WGHs9inwBz8A3/OzNrZH3Pip5wDFPdHOoVmC5q3TVFZgfnNjT+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725319531; c=relaxed/simple;
	bh=aqWBjBYGZNooM8PNh8gN4JFntWR1DmcLhl7ufBy3N3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXblccoSuEj6tGdOMjk553hgAjYRMR3xd1T4QdkYMh/PLhiOB9Q48aexyMnaIqUuTfIPj3FmcY68CQrrUKdwi6qhCbN2nRx+2j5LcvxQ9TH2S3txNEfBcSYtfI/aeD9exhZb5hcErtMeTVxWP3nuJCJCl9bmdYoJL6HfAjEpqNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3R2LoJB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3719419c2aaso109177f8f.1
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 16:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725319528; x=1725924328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZPbEk837UIQeWK1zj9VvBLJMdvblUtE/V1kEMjqnzg=;
        b=D3R2LoJBUGKPTFijy/y+QtwS0umxhllStfkR31vdMND8+rcHlFrMKbv2MWQApiwlvK
         0rnmt69+hzDL9su+B2yQ4v4Ugw9zbpq2CtX/472RdOTg0eDhjdvRkaljFcQ5EuKobo21
         KHz/mV/vKXVxKf6FDFA/pa/rnpGFaLHTnimQkZO1VXDKXUsibkSht/nIitWMhIx+tB7D
         Bq75Shc59jMHAk+kt0ZevyVEp9LsFdyHTvx2VCcwAuqqi+ULvk8i2Rd6buuxNOAziika
         vXe3Gc85VLy/6Bv8cw0UpTzKj4Ml1H3uclGnvaElQVG/CWwZaFKVx/ahH2QDhEkgZHSC
         2iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725319528; x=1725924328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZPbEk837UIQeWK1zj9VvBLJMdvblUtE/V1kEMjqnzg=;
        b=rREujTri4Em/qeZCM4xLBIVf/YoIhf07HqkQ5M4Pi4HTHVz0pE9+Z79Mzwoa77XnwO
         mtZzXEIj0nDuwfluNiO3wiJx5+SLC7kJFQ9dlg5tDSumQjOJnU/QZeKsEf/jj+FqnKum
         vL87ad7efsBt6Y9sx3ChVoOISSwLBZ1+3eYZkA8TF8vMGwZQPTnzLxUPVPEi52Pq/DTP
         8SW/vf2FzrD3lhH3RCjay+QaZH6tkdHShQCbq0DqlpWC+dKnQzmCPlsWCG76q4pp4+W1
         C6qIF2Fgr0za7DKu6VnhjmZajYHk6DYXNryD4v0JKgFprrSGar6ZxA/CQAbEBe9BZIjA
         la4Q==
X-Gm-Message-State: AOJu0YzGLkz7UWFgLoIUJvWGNpa7kN0vcfMIZYqZ3HM8vjFBolOdXFay
	yaBP+FHFd40AYtqUMFakxC84VDJmqKi4WcdB3lFNdDquLT/DZvFvsE2OQSMAOZE=
X-Google-Smtp-Source: AGHT+IGodv6U83bhyOrivZT9MKQClD2J3mAAoi4gZsnTSM89crXcjvYge4qfExEjp1ElnMZIJ20BIg==
X-Received: by 2002:a5d:6d05:0:b0:374:c2e9:28aa with SMTP id ffacd0b85a97d-374c2e92e71mr2690184f8f.8.1725319527051;
        Mon, 02 Sep 2024 16:25:27 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749eea50dasm12602549f8f.56.2024.09.02.16.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 16:25:26 -0700 (PDT)
Date: Tue, 3 Sep 2024 02:25:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 08/13] lib: packing: fix
 QUIRK_MSB_ON_THE_RIGHT behavior
Message-ID: <20240902232524.cz77daj2tsajhrpb@skbuf>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
 <20240828-e810-live-migration-jk-prep-ctx-functions-v2-8-558ab9e240f5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-8-558ab9e240f5@intel.com>

Hi Jacob,

It's very cool that you and Przemek (and possibly others) spent the time
to untangle this. Thanks! Just a microscopic nitpick below.

On Wed, Aug 28, 2024 at 01:57:24PM -0700, Jacob Keller wrote:
> The QUIRK_MSB_ON_THE_RIGHT quirk is intended to modify pack() and unpack()
> so that the most significant bit of each byte in the packed layout is on
> the right.
> 
> The way the quirk is currently implemented is broken whenever the packing
> code packs or unpacks any value that is not exactly a full byte.
> 
> The broken behavior can occur when packing any values smaller than one
> byte, when packing any value that is not exactly a whole number of bytes,
> or when the packing is not aligned to a byte boundary.
> 
> This quirk is documented in the following way:
> 
>   1. Normally (no quirks), we would do it like this:
> 
>   ::
> 
>     63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32
>     7                       6                       5                        4
>     31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
>     3                       2                       1                        0
> 
>   <snip>
> 
>   2. If QUIRK_MSB_ON_THE_RIGHT is set, we do it like this:
> 
>   ::
> 
>     56 57 58 59 60 61 62 63 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47 32 33 34 35 36 37 38 39
>     7                       6                        5                       4
>     24 25 26 27 28 29 30 31 16 17 18 19 20 21 22 23  8  9 10 11 12 13 14 15  0  1  2  3  4  5  6  7
>     3                       2                        1                       0
> 
>   That is, QUIRK_MSB_ON_THE_RIGHT does not affect byte positioning, but
>   inverts bit offsets inside a byte.
> 
> Essentially, the mapping for physical bit offsets should be reserved for a
							      ~~~~~~~~
							      reversed

> given byte within the payload. This reversal should be fixed to the bytes
> in the packing layout.
> 
> The logic to implement this quirk is handled within the
> adjust_for_msb_right_quirk() function. This function does not work properly
> when dealing with the bytes that contain only a partial amount of data.
> 
> In particular, consider trying to pack or unpack the range 53-44. We should
> always be mapping the bits from the logical ordering to their physical
> ordering in the same way, regardless of what sequence of bits we are
> unpacking.
> 
> This, we should grab the following logical bits:
> 
>   Logical: 55 54 53 52 51 50 49 48 47 45 44 43 42 41 40 39
>                   ^  ^  ^  ^  ^  ^  ^  ^  ^

These 16 bits should have been 55-40. Bit 46 is missing, and bit 39 is
extraneous.

Also, I honestly think that another "Byte boundary:" line would help the
reader see the transformation proposed as an example better. Like this:

 Byte boundary: |                       |                       |
       Logical:   55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40
                         ^  ^  ^  ^  ^  ^  ^  ^  ^

> 
> And pack them into the physical bits:
> 
>    Physical: 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47
>     Logical: 48 49 50 51 52 53                   44 45 46 47
>               ^  ^  ^  ^  ^  ^                    ^  ^  ^  ^
> 
> The current logic in adjust_for_msb_right_quirk is broken. I believe it is
> intending to map according to the following:
> 
>   Physical: 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47
>    Logical:       48 49 50 51 52 53 44 45 46 47
>                    ^  ^  ^  ^  ^  ^  ^  ^  ^  ^
> 
> That is, it tries to keep the bits at the start and end of a packing
> together. This is wrong, as it makes the packing change what bit is being
> mapped to what based on which bits you're currently packing or unpacking.
> 
> Worse, the actual calculations within adjust_for_msb_right_quirk don't make
> sense.
> 
> Consider the case when packing the last byte of an unaligned packing. It
> might have a start bit of 7 and an end bit of 5. This would have a width of
> 3 bits. The new_start_bit will be calculated as the width - the box_end_bit
> - 1. This will underflow and produce a negative value, which will
> ultimate result in generating a new box_mask of all 0s.
> 
> For any other values, the result of the calculations of the
> new_box_end_bit, new_box_start_bit, and the new box_mask will result in the
> exact same values for the box_end_bit, box_start_bit, and box_mask. This
> makes the calculations completely irrelevant.
> 
> If box_end_bit is 0, and box_start_bit is 7, then the entire function of
> adjust_for_msb_right_quirk will boil down to just:
> 
>     *to_write = bitrev8(*to_write)
> 
> The other adjustments are attempting (incorrectly) to keep the bits in the
> same place but just reversed. This is not the right behavior even if
> implemented correctly, as it leaves the mapping dependent on the bit values
> being packed or unpacked.
> 
> Remove adjust_for_msb_right_quirk() and just use bitrev8 to reverse the
> byte order when interacting with the packed data.

Yes, just bitrev8() should be exactly what is needed for the "MSB on the
right within a packed byte" definition.

> 
> In particular, for packing, we need to reverse both the box_mask and the
> physical value being packed. This is done after shifting the value by
> box_end_bit so that the reversed mapping is always aligned to the physical
> buffer byte boundary. The box_mask is reversed as we're about to use it to
> clear any stale bits in the physical buffer at this block.
> 
> For unpacking, we need to reverse the contents of the physical buffer
> *before* masking with the box_mask. This is critical, as the box_mask is a
> logical mask of the bit layout before handling the QUIRK_MSB_ON_THE_RIGHT.
> 
> Add several new tests which cover this behavior. These tests will fail
> without the fix and pass afterwards. Note that no current drivers make use
> of QUIRK_MSB_ON_THE_RIGHT. I suspect this is why there have been no reports
> of this inconsistency before.
> 
> Fixes: 554aae35007e ("lib: Add support for generic packing operations")

When there is no user-observable issue in mainline, I believe there is
no reason for a Fixes: tag, even if the bug is very real. My understanding
is that the role of the tag is to help the backporting process to stable.
Using it here could possibly confuse the maintainers that it needs to be
backported, even though it is spelled out that it needs not be.

> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

