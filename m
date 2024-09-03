Return-Path: <netdev+bounces-124746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283F096ABF0
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9821C24671
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7F1D58A1;
	Tue,  3 Sep 2024 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeqHbtFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406321D2230
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401646; cv=none; b=pHPn+l2uX+DJJkYyEARy5ydTQjElmVpj72vmx83ctDs8uKj/A2mimXGd3p3FBA+01Osf6RyZynx0xj52FDTALxP6u1ilMDk5qyXMkMkWGuKbbhaAzFgmk/jvUJfBRTY991jcS/enVg1ZSdz74hC4TEnkgaYexiDMa7jNf7Ey640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401646; c=relaxed/simple;
	bh=gQuqZpOUaWclzlM/AES8o4lVpEeSnh6sU1O4sLtUka0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brvqQJJlbhDsprhJgYE3B6CxKUv91xm4BnNZQr5AASva1HU38y6judilV2cVJDABY1lNryq50azesKen9Fri33DL4vffmvM5GcXqPCv9nb6R6HHQ7ZC5tJvmwbz5gMgc4acbEQzaX9EMw9Cwnrc/ETF845mfU4SKiiFRc+VBsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeqHbtFF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334eec7485so1014143e87.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 15:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725401642; x=1726006442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AcK1nF6kUwxwZ2jpc/IhuhiDwrp6++pkFCuTrnOeB9A=;
        b=KeqHbtFF8Fr1lNrzlDO7HwJgjN88tGgqRpKJ+TwHs3yNjPHH/V/IXk6JQF5mCOXwge
         y7MHZhZpx2bXmS/+pmJbliWvhUYYEvo/wTucAUUD9z7h4dosm6RFBNpdSMhSM6epYElo
         sqvdlWft4WxIy4WexcHZSV4CsIkjk/gswuKRa/k624d3Dn/TsXl5m2yl0kUt6NnT6n9w
         0xVQyCdwN0XT9/oif3y/AW5O8z42mYU6iq7+xBl8EYZryHBHnsBVHbOcq+iXuy1QxS4j
         5TXeJ3op1PlxvcIIgsHd/Rz5HClYzezLGhMOMmUcetOFQxkFEt9dHfJiSxbmOb0Ix0xw
         6Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725401642; x=1726006442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcK1nF6kUwxwZ2jpc/IhuhiDwrp6++pkFCuTrnOeB9A=;
        b=GRO54ZMwvT/ybbxqhUuKoRkKQrfWu2uDM0k3JT5BE1B9hhFS+5hhePBYJt3goNR98b
         T4PVUjRWDKVZ9BtO1fnw3zZcsk2PZqK5QelYX/iuaqR6KsIY+r0mJK8bhhEu88c6xBkc
         AkzLnLKxDtcC2VslQ1l2ojUaUjcaBQqdRvAvVzjiHtPSlSwhtmO9/MBrPiks3YNOAHgH
         CG9PLyqOywmy6JzzMGR/A8PLtr3DXcb0VInTUxrDgl9qLTGVUthJNp2hJTI1Wdtceusx
         q5phYj4I5TDL4BYNSPVOU7F1KURuWksTUKgpVRrv0zPCmopTj3aLLXlf55UVNSH/snvs
         x9Ew==
X-Gm-Message-State: AOJu0Yyr8uNZf9ETN2ToWE+Q4y7r0jrJC5XCCTbSQTeZCf5BwG6vzx20
	pXu6NiXuU408paBXShyNY5RC/Z0Rjy63AXTjhziDDlfILGiegKJmzOKkUqEQ
X-Google-Smtp-Source: AGHT+IGXit/jHuVzg+2ijFxZWxjBBFlz6Qqutsm7Cte0Lq4BDnLQPMOOpiUoyA7ipTY22vrYjjYaTA==
X-Received: by 2002:a05:6512:b0d:b0:530:e0fd:4a85 with SMTP id 2adb3069b0e04-53546b2d158mr5616974e87.4.1725401641267;
        Tue, 03 Sep 2024 15:14:01 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6d88sm733532066b.151.2024.09.03.15.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:14:00 -0700 (PDT)
Date: Wed, 4 Sep 2024 01:13:58 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2 10/13] ice: use <linux/packing.h> for Tx and
 Rx queue context data
Message-ID: <20240903221358.eupqxac7chvzxp6e@skbuf>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
 <20240828-e810-live-migration-jk-prep-ctx-functions-v2-10-558ab9e240f5@intel.com>
 <20240903000800.ue77eim4664dhy4p@skbuf>
 <00d23c42-2611-45d7-9d25-5ad394477238@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d23c42-2611-45d7-9d25-5ad394477238@intel.com>

On Tue, Sep 03, 2024 at 02:16:59PM -0700, Jacob Keller wrote:
> I only kept my interface in terms of lsb+size because I did not want to
> attempt to re-write the table. I actually did re-write the table at
> first, and discovered a documentation bug because our documentation for
> the table has incorrect lsb/msb for some of the fields in some versions
> of the doc!
> 
> I ultimately don't mind switching to the packing convention of start/end
> (though my brain does have trouble sometimes thinking of the start as
> the higher bit...)

Well, you can keep the ICE_CTX_STORE() macro formatted in whichever way
you want, including Width+LSB, but reimplement it to generate a struct
packed_field, formatted as startbit+endbit (endbit=LSB, startbit=LSB+Width-1).
I actually encourage any user of the packing library to write the code
in the closest way possible to the field definitions as they appear in
the documentation. What do you think?

> > I came to the realization that this API would be nice exactly because
> > otherwise, you need to duplicate the field definitions, once for the
> > pack() call and once for the unpack(). But if they're tables, you don't.
> > 
> > I'm looking at ways in which this new API could solve all the shortcomings
> > I don't like with lib/packing in general. Without being even aware of
> > ICE_CTX_STORE, I had actually implemented the type conversion to smaller
> > unpacked u8/u16/u32 types in exactly the same way.
> 
> I think having this in the core API with a standardized table, along
> with support for unpacking the types would be great!

Cool then!

> > I also wish to do something about the way in which lib/packing deals
> > with errors. I don't think it's exactly great for every driver to have
> > to dump stack and ignore them. And also, since they're programming
> > errors, it's odd (and bad for performance) to perform the sanity checks
> > for every function call, instead of just once, say at boot time. So I
> > had thought of a third new API call: packed_fields_validate(), which
> > runs at module_init() in the consumer driver (ice, sja1105, ...) and
> > operates on the field tables.
> > 
> 
> It does seem reasonable to me that we can move the sanity checks here,
> especially since the main programmer error is if this table is incorrect
> in one of these ways.

Actually I did manage to cook something up which I like even more than
packed_fields_validate(): a compile-time sanity check. I'm not completely
happy with it, just reasonably happy. You'll see.

> > Basically it is a singular replacement for these existing verifications
> > in pack() and unpack():
> > 
> > 	/* startbit is expected to be larger than endbit, and both are
> > 	 * expected to be within the logically addressable range of the buffer.
> > 	 */
> > 	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
> > 		/* Invalid function call */
> > 		return -EINVAL;
> > 
> > 	value_width = startbit - endbit + 1;
> > 	if (unlikely(value_width > 64))
> > 		return -ERANGE;
> > 
> > so you actually need to tell packed_fields_validate() what is the size
> > of the buffer you intend to run pack_fields() and unpack_fields() on.
> > I don't see it as a problem at all that the packed buffer size must be
> > fixed and known ahead of time - you also operate on fixed ICE_RXQ_CTX_SZ
> > and ... hmmm... txq_ctx[22]? sized buffers.
> > 
> 
> Yea, these are fixed sizes. Strictly I think we could have a macro
> defining the size of the Tx queue context as well....

Yeah, you'll need than when you'll see what I've prepared below :)

> > But this packed_fields_validate() idea quickly creates another set of 2
> > problems which I didn't get to the bottom of:
> > 
> > 1. Some sanity checks in pack() are dynamic and cannot be run at
> >    module_init() time. Like this:
> > 
> > 	/* Check if "uval" fits in "value_width" bits.
> > 	 * If value_width is 64, the check will fail, but any
> > 	 * 64-bit uval will surely fit.
> > 	 */
> > 	if (value_width < 64 && uval >= (1ull << value_width))
> > 		/* Cannot store "uval" inside "value_width" bits.
> > 		 * Truncating "uval" is most certainly not desirable,
> > 		 * so simply erroring out is appropriate.
> > 		 */
> > 		return -ERANGE;
> > 
> 
> If we support u8/u16/u32/u64 sizes as well, you could check that the
> size of the unpacked variable too. Could this data be in the table? Oh I
> guess technically not because we are checking if the actual value passed
> fits. I think keeping this but making it WARN would be sufficient?

The u8/u16/u32/u64 unpacked field size will absolutely be held in the
struct packed_field tables.

> >    The worse part is that the check is actually useful. It led to the
> >    quick identification of the bug behind commit 24deec6b9e4a ("net:
> >    dsa: sja1105: disallow C45 transactions on the BASE-TX MDIO bus"),
> >    rather than seeing a silent failure. But... I would still really like
> >    the revised lib/packing API to return void for pack_fields() and
> >    unpack_fields(). Not really sure how to reconcile these.
> > 
> 
> Since this is generally programmer error (not something where uAPI can
> affect it) what about making these WARN in the core?

Yes, I went for demoting the -ERANGE error in the truncation case to a
WARN() that is printed for both the "int pack()" as well as the new
"void __pack()" call. Practically, it doesn't make a big difference
whether we bail out or do nothing, as long as we loudly complain in
either case. It's the complaint that leads to the bug getting easily
identified and fixed.

> > 2. How to make sure that the pbuflen passed to packed_fields_validate()
> >    will be the same one as the pbuflen passed to all subsequent pack_fields()
> >    calls validated against that very pbuflen?
> 
> I guess you either duplicate the check and WARN, or you don't, and let
> it panic on the invalid memory? But I guess that would only actually
> panic with something like KASAN

Yeah, I'm still not too sure here. The length of the packed buffer still
needs to be "obvious to the eye", since the same length must be manually
passed to the sanity check as well as to the actual pack_fields() call,
otherwise "bad things" will happen. I believe in the users' ability to
structure their code in such a way that this is not hard. Especially
since the sanity checks now rely on BUILD_BUG_ON(), and that can be
technically be placed anywhere in the code, I expect the best place to
put it is exactly near the pack_fields() call. That way, it's the most
obvious that the buffer length declared for the sanity check is
identical to the one during actual usage. Especially if the usage can be
restricted to just one function or two.

> > Sorry for not posting code and just telling a story about it. There
> > isn't much to show other than unfinished ideas with conflicting
> > requirements. So I thought maybe I could use a little help with some
> > brainstorming. Of course, do let me know if you are not that interested
> > in making the ICE_CTX_STORE tables idea a part of the packing core.
> > 
> > Thanks!
> 
> I think moving this into core would be fantastic. Since pretty much
> every driver handles these sanity checks the same way, I also think that
> moving those into the core and making them WARN or similar seems
> reasonable, so we can make the pack/unpack as void.
> 
> It would be interesting to see a comparison of the resulting module size.

Yeah, I'm also very much interested in comparisons: text size vs rodata
size vs dynamic memory usage. With the pack_fields() API in the sja1105
driver, I can shrink an enormous amount of u64 unpacked structure fields
to just u8. I also really like the idea of compile-time sanity checks,
and I'm curious how much that matters in a benchmark or something.
Anyway, I don't have a complete rework at the moment, so there's that.

> How much of this do you have code for now?

Well, I do have code, but it's not yet complete :)
I've updated by https://github.com/vladimiroltean/linux/tree/packing-selftests
branch on top of your patch set. Until HEAD~1, I've tested the sja1105
driver and it still works. The last patch - the bulk of the conversion
actually - is extremely tedious and is not yet ready (it doesn't even
compile). Yet, with a bit of imagination, it should be enough to provide
an example and hopefully move the discussion forward.

