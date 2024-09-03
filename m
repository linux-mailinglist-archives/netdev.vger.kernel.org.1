Return-Path: <netdev+bounces-124333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD43969095
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF526B22229
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 00:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1C036C;
	Tue,  3 Sep 2024 00:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQyYW/bw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54459195
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725322087; cv=none; b=Dq0SqC01/qu/JBEIhV5PZCYRC0iOSO2ca16dn0Ke+6rkXyLFS4oW+qyHp+XN7Q8H3k7iz9hRk2/IPDelnsG1XNCu1ggtIz9aI23YLtJ0RpSWMLXaFAgcPy3Tc3E8hO0NnwbaQyfYY9YNcRkxX9bIKxUBWHswz2s/DLUD50EXZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725322087; c=relaxed/simple;
	bh=xY6aaugtho2KPTb0Ul6Wnh0i/gO8PBZJBNJZZsnfx4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdCMVmtJrQUNtEjKd+oQhxo5sFlx3c/DsVvhfy5qpTDrpNEZI19zhW+1ZjbtGt9tkcrdYsX5LZ+Uhf8TCe0rgtQFMLndEpnQAfXfEpik6vZj9IpNGQ5g/wu/Np3hhFtc+KFcnVX2ygYRHcrlHkTWYNQEZG1U60aW+t142W2/nbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQyYW/bw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42baecbd4fbso6677185e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725322084; x=1725926884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jverNQzc8OEnv1hJ+On8rPhs7dBruz9IRY9b92+fQ5I=;
        b=HQyYW/bwfExnD+ZL8ueFZjFi0AEvyiNl9f5RuZE89C6ikHKg4925FWBicckALT9O9S
         YxbhIfIj+3rWalxVEMhBKL3RGAxwe8AH6Qlc2t7/dfKCy+GZmrzWaRHu2MtFS+TlnHsk
         N19u7B1EKkEGFmTzOcb1ctw5+KFMb6656ZKJ5hWPzd1M849Anf43VlHzNYGE/mqg6jYK
         1bMfhEk3fAeLYo3dseh+a5Fia++xBdyichG6BRu34HNyRrYEv6NE4eV7N/zgMhFZFDaO
         qNGWR/YKdhPfd1eKOPuB5hL8oC7hacORKA7+sqbt6SRYMRZH5ToTwFd2lqJ/1JjRsmzs
         7iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725322084; x=1725926884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jverNQzc8OEnv1hJ+On8rPhs7dBruz9IRY9b92+fQ5I=;
        b=bqHBS0O06cxqAEAq/oAgEGA1CgoApcN0BQP3PkfZuweeFtfrHw/tHkJJK8MqVfZyi3
         mDEfrZ15IyKqgW7cEvb+fXofulmNEGlxRYiY8H771gFFOxjBgMZHufrQmx9cN9H8n/S+
         Zv5zbusbF+L26RiaDEe/UtfRtv5XBog+Ajh4T5V2fNmL5F4eyvK7ll4f/5vFSUfHptTR
         bwDW/1lypAUF75OgWvAFSxcB1pFJUG+wbokKaYl+/rSBsYmtpUnZLUub05MNQQKT5n44
         eEqSHy3BnzFB+/GuigbLgDdOm272NFmTm3TmeBy3Ig3n0DRCyqzn9uqm061U/jceZkaL
         0W+w==
X-Gm-Message-State: AOJu0YyZSRiZUMkeHYGrqNp6O81j4gKvFPEVVlcn7bXA6l53kjC32HoD
	Z8kSdwNLHI6XSq6Wg/p2LW8RdBBrCDTShMey1alD6Ha9tNj0J99b
X-Google-Smtp-Source: AGHT+IECfz0b7w8YnRDzE9ye+95wL81FU5aqo1+RnHHS6qTUiapghUcV1Vxc5qXT7VPhZnE/K+fgpQ==
X-Received: by 2002:a05:600c:4f4a:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-42bbb10d61dmr48457865e9.1.1725322083046;
        Mon, 02 Sep 2024 17:08:03 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbf15b9b1sm111758835e9.10.2024.09.02.17.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 17:08:02 -0700 (PDT)
Date: Tue, 3 Sep 2024 03:08:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 10/13] ice: use <linux/packing.h> for Tx and
 Rx queue context data
Message-ID: <20240903000800.ue77eim4664dhy4p@skbuf>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
 <20240828-e810-live-migration-jk-prep-ctx-functions-v2-10-558ab9e240f5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-10-558ab9e240f5@intel.com>

On Wed, Aug 28, 2024 at 01:57:26PM -0700, Jacob Keller wrote:
> The major difference with <linux/packing.h> is that it expects the unpacked
> data will always be a u64. This is somewhat limiting, but can be worked
> around by using a local temporary u64.
> 
> As with the other implementations, we handle the error codes from pack()
> with a pr_err and a call to dump_stack. These are unexpected as they should
> only happen due to programmer error.
> 
> Note that I initially tried implementing this as functions which just
> repeatably called the ice_ctx_pack() function instead of using the
> ice_rlan_ctx_info and ice_tlan_ctx_info arrays. This does work, but it has
> a couple of downsides:
> 
>  1) it wastes a significant amount of bytes in the text section, vs the
>     savings from removing the RO data of the arrays.
> 
>  2) this cost is made worse after implementing an unpack function, as we
>     must duplicate the list of packings for the unpack function.

I agree with your concerns and with your decision of keeping the
ICE_CTX_STORE tables. Actually I have some more unposted lib/packing
changes which operate on struct packed_field arrays, very, very similar
to the ICE_CTX_STORE tables. Essentially two new calls: pack_fields()
and unpack_fields(), which perform the iteration inside the core library.
(the only real difference being that I went for startbit and endbit in
their definitions, rather than LSB+size).

I came to the realization that this API would be nice exactly because
otherwise, you need to duplicate the field definitions, once for the
pack() call and once for the unpack(). But if they're tables, you don't.

I'm looking at ways in which this new API could solve all the shortcomings
I don't like with lib/packing in general. Without being even aware of
ICE_CTX_STORE, I had actually implemented the type conversion to smaller
unpacked u8/u16/u32 types in exactly the same way.

I also wish to do something about the way in which lib/packing deals
with errors. I don't think it's exactly great for every driver to have
to dump stack and ignore them. And also, since they're programming
errors, it's odd (and bad for performance) to perform the sanity checks
for every function call, instead of just once, say at boot time. So I
had thought of a third new API call: packed_fields_validate(), which
runs at module_init() in the consumer driver (ice, sja1105, ...) and
operates on the field tables.

Basically it is a singular replacement for these existing verifications
in pack() and unpack():

	/* startbit is expected to be larger than endbit, and both are
	 * expected to be within the logically addressable range of the buffer.
	 */
	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
		/* Invalid function call */
		return -EINVAL;

	value_width = startbit - endbit + 1;
	if (unlikely(value_width > 64))
		return -ERANGE;

so you actually need to tell packed_fields_validate() what is the size
of the buffer you intend to run pack_fields() and unpack_fields() on.
I don't see it as a problem at all that the packed buffer size must be
fixed and known ahead of time - you also operate on fixed ICE_RXQ_CTX_SZ
and ... hmmm... txq_ctx[22]? sized buffers.

But this packed_fields_validate() idea quickly creates another set of 2
problems which I didn't get to the bottom of:

1. Some sanity checks in pack() are dynamic and cannot be run at
   module_init() time. Like this:

	/* Check if "uval" fits in "value_width" bits.
	 * If value_width is 64, the check will fail, but any
	 * 64-bit uval will surely fit.
	 */
	if (value_width < 64 && uval >= (1ull << value_width))
		/* Cannot store "uval" inside "value_width" bits.
		 * Truncating "uval" is most certainly not desirable,
		 * so simply erroring out is appropriate.
		 */
		return -ERANGE;

   The worse part is that the check is actually useful. It led to the
   quick identification of the bug behind commit 24deec6b9e4a ("net:
   dsa: sja1105: disallow C45 transactions on the BASE-TX MDIO bus"),
   rather than seeing a silent failure. But... I would still really like
   the revised lib/packing API to return void for pack_fields() and
   unpack_fields(). Not really sure how to reconcile these.

2. How to make sure that the pbuflen passed to packed_fields_validate()
   will be the same one as the pbuflen passed to all subsequent pack_fields()
   calls validated against that very pbuflen?

Sorry for not posting code and just telling a story about it. There
isn't much to show other than unfinished ideas with conflicting
requirements. So I thought maybe I could use a little help with some
brainstorming. Of course, do let me know if you are not that interested
in making the ICE_CTX_STORE tables idea a part of the packing core.

Thanks!

