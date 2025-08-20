Return-Path: <netdev+bounces-215330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D939B2E1FD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61947AD1A4
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A20322DB7;
	Wed, 20 Aug 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="SRNq3Yik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDF322A1F
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706324; cv=none; b=udwIsCbuX6a4m7fNIQH43nbcDr0hkdlxkfRyzWWFrCj6j1NyEvDru9at+yz0c03PL3Pt2uFUPaEsyYUtaB8mZNEGdtULYlgr7mSOuOq7H1TEJ0g9BCNAIy1Qu2SKaMDJRu1pym7QdaxksL54gH8bBbbO4Vh22eRAQix+OyxJ8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706324; c=relaxed/simple;
	bh=csMe8M02JACrzGu8/LynQcRf1XbJhwyyTLHJ8vGCXTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIxTGRQn4yts8EfI4hGjfsUv6kZTT8KJAqULg3Iq5lsVh6ao79IfVzibjO75mTmO8Pp09z48SKqr+Hk+fCE40LrTvbfivklhGnpMq7VcFc79txmST+/y0bUg3XSaMbAYaTSLjkdJGKOepPNxAGwqJTtv3SLTELZXZ15VClLOS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=SRNq3Yik; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445818eb6eso50253905ad.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755706323; x=1756311123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4lQnboCJ/SfpiSxnqVz4g3RDlcDQI6fBuRKe7d0k6ow=;
        b=SRNq3YikFWqDJA4ozu1C/XSRuCx5QzJVUtXTPnEwGf9o6R9l8HPdVyiN/iXWlBZmJf
         sCvFXtLv+aXwdqvYrsvdr4c4s+IRck60HqT7uS9m2U2LNf02OZrBaiLHpQYI6m/Tl/nk
         ipSBiCY1AV+SXwW4Yz40/LPCliByklacEmG3DnmvfyDgJvfoFM/DAvGVK5EQJoj87iay
         HsBDDVquPxTUdTdipHmPZybYTJOe6WbLOlqldYTLiQJTRMx10x0b/Zi9rFqeo1Aazi1R
         vD8rsAVSWDUemOfxLVU4OXNwaxBDU9t2TDSGjllNMdhcAGnPws6Bp2VZSEheyvGyJqtd
         vL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755706323; x=1756311123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lQnboCJ/SfpiSxnqVz4g3RDlcDQI6fBuRKe7d0k6ow=;
        b=E2hHhhWcm8SkTYD5Xek9UHYOvU2W0/kelIKCsA+rM/mJ++W/6wwRq76VBORJgHMjbI
         +fh1PyXJGtPzdCCj6AFz/7+SMaUQUrXymDKBONiFY+foN0Cb+wNtchXAtEYm9WZoluV2
         YQMyqZ4yFPgMo3j0NzX/KsiqfdCFwtr+C8v7YC9qytReb0meMMAUqMIcyT3UWz8PEvtA
         BbQnSZyMaNP2MFJKYaz0SC/sk64rVw2C10ppuK6yf4kF2tSLaATc8m2UPp8j0Mv2zXWg
         h4KKLPjFyImcyj4RKUeG5yjZKVba2uJKEqfJx+j2gqLF++amXdHToaY4gyXO+mPKvKV7
         Pl8w==
X-Forwarded-Encrypted: i=1; AJvYcCWmcf8UMX8b+Kk1u5f8KRqt9uyjR0oAoHD5yehODI5+B6yqRAFcArhGg6WmYYbcxcYoUx4ToeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAbBDUm2C7bWHySRanz6giL4y0c5taGdBBQWAfvH1aSCN5g1J
	yhQ5mt7/RhIUaDM5c5dh2JFis+AxlZL0ijY0cN1UHHozBdPela3/48H9tsepfnVFWz8=
X-Gm-Gg: ASbGncs3f9dBOTtUCbvJgwpOCALJxWF0KRwidI6H01Q+g2+XC/pXF1rcNnPjmYkK9b7
	6sh+0p23l2qqKv/PuvGIUYIshtpVsOkb6VYxkSb0Id55g2k0NBc/2Mcm7G2eMYhRlc1VeSToX3i
	fLu9nHs/MvHZi5/gj0Uw13REC3MO9LPIS0MAt1eNn6ZDC3zsP5FK10efNoMc+CMR6OMVkbMeMYq
	7Isl1KVi5inSlRl7uZTIyos4HJcv/JBTcP1U0NERDeqeP89+Ou8jCWKgEHuGMz2/kP+fppeLksB
	E1VxedkiyQaIGvsOolsaTiDOYsqk7Zsw/zml+sUBuREOzSToF8yMJYsdbUtd2/xGJeJJDiqLuLI
	JxxLc0RWVkMp4HkB18xpW/M7K
X-Google-Smtp-Source: AGHT+IE/nk+N9o01n4/ZPtP5FhA/L8bgVJ0gJaRs1K8wSnasMCzJcj3TGsZPPTFT1q0y78NPONUbNw==
X-Received: by 2002:a17:902:d507:b0:245:f5b2:6cbb with SMTP id d9443c01a7336-245f5b270a2mr23013545ad.52.1755706322694;
        Wed, 20 Aug 2025 09:12:02 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7588sm30840115ad.101.2025.08.20.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:12:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:11:59 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKXzzxgsIQWYFQ9l@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <089ba88e-e19d-40eb-844d-541d39e648e8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <089ba88e-e19d-40eb-844d-541d39e648e8@intel.com>

On Wednesday 08/20 at 11:41 +0200, Przemek Kitszel wrote:
> On 8/20/25 08:42, Michal Schmidt wrote:
> > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > The same naming regression which was reported in ixgbe and fixed in
> > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > changes") still exists in i40e.
> > > 
> > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > > 
> > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > 
> > But this one's almost two years old. By now, there may be more users
> > relying on the new name than on the old one.
> > Michal
> > 
> 
> And, more importantly, noone was complaining on the new name ;)

I'm just guessing with the Fixes tag, I didn't actually go back and try
to figure out when it broke. Let me double check, it would certainly
make more sense if it broke more recently.

But there are a lot of reasons I still think it should be fixed:

	1) I have ixgbe and i40e cards in one machine, the mis-match
	   between the interface naming pattern is irritating. Can't we
	   at least be consistent within the same manufacturer?

	2) The new names have zero real value: "enp2s0fX" vs
	   "enp2s0fXnpX", the "npX" prefix is entirely redundant for
	   this i40e card. Is there some case where it can have meaning?
	   I apologize if I'm glossing over something here, but it looks
	   entirely pointless. If it solved some real problem, I'd be a
	   lot more amenable to it.

	3) It's a userspace ABI regression which causes previously
	   working servers to be unable to connect to the network after
	   a simple kernel upgrade.

And, at the end of the day, it *is* a userspace ABI regression. If it
matters enough in ixgbe to warrant a *second* userspace ABI regression
to fix it, I think it warrants that in i40e too.

Thanks,
Calvin

