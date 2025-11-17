Return-Path: <netdev+bounces-239122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F500C644CA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 14:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A02AA240D2
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC1330328;
	Mon, 17 Nov 2025 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLVj8uYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346432F74E
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385102; cv=none; b=KBSTBcry0A0xVdUgQXSFVz9GcB6xFX/VgQKHfxFqE/sG9Hvh1mkyRYpwUhvdRTVX6THKTW1xeM932CZujok+ARia/SCfZVQV4ocx4ilcssgPE3kZaqn2SoGLflRydvCyfsH04SrwF4mJa9YVbn5+zrhKWTyLw6JtCdyFYbPysm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385102; c=relaxed/simple;
	bh=h38v3zpCAfMH+LpTc6wSw688KR9quyXTFOdnu5vd3ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhoDElB8wgxzAIdZg/UFgMRaUBvE4NMKqeVNsBTlD69/pjSFlKIx2I/7IU9TTKy/htnaScCWN1rl7v5/CHVEqqTzYAvT7v0BuPtbwOHReSC1npO7qflUdbQ8v0RGsmghpWn2MC4K4uh3ibfCZs/MkrwKXj0/bV9j+CkXg3cK3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLVj8uYa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477a219db05so6384605e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 05:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763385097; x=1763989897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01cC7ySHWhCFyMvXlU1Mt2SGt2tFSxfshKiVMAheuoI=;
        b=yLVj8uYaSCjrb72FiilVrWr/H2KRDyuSdftsRh+jw5/BjrJAimz9B8Z8ZRPkh94c+2
         QFJqJKGGon/Bd/W6B7NNUPzBxKfwdPwLYn+HQxlUyJw+xmRJn7FMRqkeP1ozaUuC6x3I
         QuXmfmi8YFPxnH7jxyOcwQ94X20/89r3GonEhH6ReH+gt44g1AUgezz58AlQ2joi393A
         HQd2OYZDct2/mJnCXXZz/EWZH7f1dVSr2nla5VQuqxZYKK0TaneyStTqgk44kWYkQKnV
         DR1F0+ndJ/rXRpy6dn2rwgMZViDYMH5U46JNh+a4aTBW1xKkVrtO/6ShxNC/LOlWqnJs
         e6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385097; x=1763989897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01cC7ySHWhCFyMvXlU1Mt2SGt2tFSxfshKiVMAheuoI=;
        b=Dude2jLULbs5KJCzs/XKsTIv8aTmdwPyRIjZt5uMibjiZjw0Baw3ZA/hJzYQ+dLVkO
         mK5xlXhRNX9M+ua+HHgD0Dj/8muyCLPBMcYo6/Xp8+c2KkfQpddO6hDADJmc3OFZUbtw
         UhBm8Zxhs4emWFHYYBXIf5hwc0ojVfd1KtlHSccOhPcEuMhG50iDjaT0Xnyn1KxRcX1k
         2KXW4Arlpiupp0oYgrRRgP8VMC81fQn/TvcWo/6FsdLCLjy1Cki91wD+e8Tp/DgZchh+
         spaEEJj4d6YmyWJK5ef9YpZAB+TwmkpiTN64aNg3X6E4OsEeisDbwt+TJpayjAqD9XnK
         WGwA==
X-Forwarded-Encrypted: i=1; AJvYcCWjoWf657Gp6sCZPU8Yetc0xvci+fff33yNyJkwUGo5YHPRITmB7jk2P/AdQcOY/jhNuikBpC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4kFJKdrO6YQJZr5do8AGiI68qQjX49DZEGsIl8gxS0bAnB6O
	20tZx759qPq6UTlMzJvas93Sz8hrMl7+HpwOLKkV/bl39G7Laa+KFw8J5N4PlP1HMbc=
X-Gm-Gg: ASbGncuEpfE3+Wao7uOhvZ47/Hq2gEfIihJyKiTynR2arEEi/oaMxqfDNKLzaH2bIiY
	2fOXnHtntAmKxI520deoVPbmhdugDcpmjQLNyfRrZzE4xQLLAidtBtX4hNkCa8CEfV/cu+ITPxb
	XNDVgdellXmTdesxtYxvTg8jC0ndy5s5uEIepTTUd0PQumOhLpRNs3CZS3DuO35Rr7CTO1eK+9x
	NhMtP4unzu71OIVCrnPAr6i63a7lf13vKJgv2fUkzPaMziyURqnHNIPa+/q5Uc0USCH0rwr77v6
	WyvHOU7aHVop52ngcWW2/OXwPksnd1eLMGd1hhPBHoeA66nVZvLpOfzkSJkBmYVr6JseWbDYiJw
	rUZYo/IVzYHApxsuYXRlaXhfqOSoHkMkMEwpnH378e0uqUYCSqRzztLi97r05yC4p2DtSpTR1Zu
	LE/l2s5w==
X-Google-Smtp-Source: AGHT+IHBC+9FsxtsdSHIREVrp/G6htztuNX/oUndRO09FTt+ZBKnna4hH64IsewtZZFfCyMd6Zo6+A==
X-Received: by 2002:a05:600c:a43:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4778fe59f2amr105544325e9.6.1763385097412;
        Mon, 17 Nov 2025 05:11:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4779973ddcfsm130108955e9.15.2025.11.17.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:11:36 -0800 (PST)
Date: Mon, 17 Nov 2025 16:11:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ally Heev <allyheev@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
Message-ID: <aRsfBDC3Y8OHOnOl@stanley.mountain>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>

On Thu, Nov 06, 2025 at 03:07:26PM +0100, Alexander Lobakin wrote:
> > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> > index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
> >  			 struct ice_parser_profile *prof, enum ice_block blk)
> >  {
> >  	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> > -	struct ice_flow_prof_params *params __free(kfree);
> >  	u8 fv_words = hw->blk[blk].es.fvw;
> >  	int status;
> >  	int i, idx;
> >  
> > -	params = kzalloc(sizeof(*params), GFP_KERNEL);
> > +	struct ice_flow_prof_params *params __free(kfree) =
> > +		kzalloc(sizeof(*params), GFP_KERNEL);
> 
> Please don't do it that way. It's not C++ with RAII and
> declare-where-you-use.
> Just leave the variable declarations where they are, but initialize them
> with `= NULL`.
> 
> Variable declarations must be in one block and sorted from the longest
> to the shortest.
> 

These days, with __free the trend is to say yes this is RAII and we
should declare it where you use it.  I personally don't have a strong
opinion on this either way, but other maintainers do and will NAK the
`= NULL` approach.

The documentation says you should do it that way and avoid the `= NULL`
as well.  The issue is with lock ordering.  It's a FILO ordering, so if
we require a specific unlock order then declaring variables at the top
could mess things up.

The counter argument is that if you declare a variable after a goto
then that's undefined behavior as well.  Clang will detect that bug so
it be detected before it hits actual users.

regards,
dan carpenter


