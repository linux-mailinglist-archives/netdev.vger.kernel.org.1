Return-Path: <netdev+bounces-134558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D699A199
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAD4286DFA
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A9210C1F;
	Fri, 11 Oct 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGtRovGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40B21262B
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643159; cv=none; b=JK6w/xYVqeZX8G5uJXKHvCQrDi2iawoSs4ax2pgi3xgdiyL8wPV6Kov1V2EVQ1H40pPd5tEjs30CO6JcSi8L+vB78B0HTqZu2zbreKjgUdiRdWicwNnw0W3LqWjsJAj8Zuw/JUZNvzk0eBCQgmKCO+BRAM0tlhXlnnQ1FDzZgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643159; c=relaxed/simple;
	bh=AtDbWnwhTKEHs+S1S2UEm8RNZeqaVMl4porwiqx/K+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHG86NY6icgJ5DWsc4EEvg4LNEm9Jt7H3khwJ29C65LwyIKWNjSHC+pKr8sj1EbdZVsSZ8MiD/wZPGUJYrFOjn4zO6kDqwQpiEQirnSqPMDQ2ec1nOY9TVxpNnJz5sEGBatxCOx7ersLJYH9zJSWfiAOpelu9AFw8E9zXtFcUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGtRovGp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9953d3b2cdso18767966b.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 03:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728643156; x=1729247956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1mFBRj5sMYNsxtx56KGXXXNfR2K56nqQiSMZ1ZHdTU0=;
        b=bGtRovGpsuIDxKKIpIUT59E/eRc4JFvSKiFibFS0KBjacMnz1hElXRH0v2qB5L2BD/
         Wh1tDk/4kgFcRygMRz87ulJojwQ9W4Fs2gbjsPTsuUZ8c7/w3pKy6n+2s0BBKgtnMSqJ
         X20u0u8+hzWUn3aQSQHowpAa8i68UN8bsZTmfncEBoA/yEHOiV8cphCuVg6j5A1eaZcs
         4HYpdmm/oClTYrgaCGZTY8+yIIkcFJz3gNiVQzt+HCINE7/+j0hx/g4zC5G08s13vAdb
         1iWn13e07Baw495uWh9FQBR/0PhGpnRvIJn9horMKxp5nFfMs7+wxnWcQyLvG63KSKaZ
         Lp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643156; x=1729247956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mFBRj5sMYNsxtx56KGXXXNfR2K56nqQiSMZ1ZHdTU0=;
        b=oTFrMzdAKvUBOQtXVPIoqAk11qOQMmWarW+Jv3B3UMqiDiRsBvIr3DU6PPGa4cIHgQ
         QV5iDC9N46+J9wjotwhViVMYMKjo+GBbe+4JuT4HULuz/Zf9iU9bSLt0Qe3e3vxQgebH
         F99eeKnwM9NtSD3/23Cj/tH2pXj2qb8D7ELML49otLxzE6dAWi4AWDHevMU5uBYaFVSL
         /9Ez1Q+F8SKBwOHBIYZWokoAVOoxi8ozWEHDw/aGhHWdoeyowO2OEJpImqgrF9favmm3
         UeJE9kKWQW+MfFbcnKGZRZ8OHPvosWRVCMuSJC6ydsZq0U3Ree8HkzTGzRsOfthABNmB
         4ZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCamsQ49ND5gE98f9EQJC69mPMarvfnAsB8Qen1MtYiN4nOvd15ZQAQch6RjzRVlOCCyYHkx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNQQ5OjE07eyQjUnNsuorvttzqEMVbZ2O3xZNJgsgKDPwAoekC
	axVF5nLBX91pw95lICgO731XnvbLOyPG2lJFWlN82RJKB6K4hTC7
X-Google-Smtp-Source: AGHT+IHmLc0U/R0WQGzv4zGbs4Pa8ruIew5Ge71kF/8R+Em+lTm/UaO0sx84gbhRt4hUDFtAMo8Kqg==
X-Received: by 2002:a17:907:36cd:b0:a99:a6e0:fa0b with SMTP id a640c23a62f3a-a99b941b516mr93808466b.5.1728643156077;
        Fri, 11 Oct 2024 03:39:16 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f27ea8sm197170566b.82.2024.10.11.03.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:39:14 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:39:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <20241011103912.wmzozfnj6psgqtax@skbuf>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
 <Zwe4x0yzPUj6bLV1@shell.armlinux.org.uk>
 <ZwfP8G+2BwNwlW75@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwfP8G+2BwNwlW75@shell.armlinux.org.uk>

On Thu, Oct 10, 2024 at 02:00:32PM +0100, Russell King (Oracle) wrote:
> On Thu, Oct 10, 2024 at 12:21:43PM +0100, Russell King (Oracle) wrote:
> > Hmm. Looking at this again, we're getting into quite a mess because of
> > one of your previous review comments from a number of years back.
> > 
> > You stated that you didn't see the need to support a transition from
> > having-a-PCS to having-no-PCS. I don't have a link to that discussion.
> > However, it is why we've ended up with phylink_major_config() having
> > the extra complexity here, effectively preventing mac_select_pcs()
> > from being able to remove a PCS that was previously added:
> > 
> > 		pcs_changed = pcs && pl->pcs != pcs;
> > 
> > because if mac_select_pcs() returns NULL, it was decided that any
> > in-use PCS would not be removed. It seems (at least to me) to be a
> > silly decision now.
> > 
> > However, if mac_select_pcs() in phylink_major_config() returns NULL,
> > we don't do any validation of the PCS.
> > 
> > So this, today, before these patches, is already an inconsistent mess.
> > 
> > To fix this, I think:
> > 
> > 	struct phylink_pcs *pcs = NULL;
> > ...
> >         if (pl->mac_ops->mac_select_pcs) {
> >                 pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
> >                 if (IS_ERR(pcs))
> >                         return PTR_ERR(pcs);
> > 	}
> > 
> > 	if (!pcs)
> > 		pcs = pl->pcs;
> > 
> > is needed to give consistent behaviour.
> > 
> > Alternatively, we could allow mac_select_pcs() to return NULL, which
> > would then allow the PCS to be removed.
> > 
> > Let me know if you've changed your mind on what behaviour we should
> > have, because this affects what I do to sort this out.
> 
> Here's a link to the original discussion from November 2021:
> 
> https://lore.kernel.org/all/E1mpSba-00BXp6-9e@rmk-PC.armlinux.org.uk/
> 
> Google uselessly refused to find it, so I searched my own mailboxes
> to find the message ID.

Important note: I cannot find any discussion on any mailing list which
fills the gap between me asking what is the real world applicability of
mac_select_pcs() returning NULL after it has returned non-NULL, and the
current phylink behavior, as described above by you. That behavior was
first posted here:
https://lore.kernel.org/netdev/Ybiue1TPCwsdHmV4@shell.armlinux.org.uk/
in patches 1/7 and 2/7. I did not state that phylink should keep the old
PCS around, and I do not take responsibility for that.

Keeping in mind that I don't know whether anything has changed since
2021 which would make this condition any less theoretical than it was
back then, I guess if I were maintaining the code involved, I'd choose
between 2 options (whichever is easiest):

- Imagine a purely theoretical scenario where phylink transitions
  between a state->interface requiring a phylink_pcs, and one not
  requiring a phylink_pcs. I'm not even saying a serial PCS hardware
  block isn't present, just that it isn't modeled as a phylink_pcs
  (for reasons which may be valid or not). Probably the most logical
  thing to do in this scenario is allow the old phylink_pcs to be
  removed, and its ops never to be used for the new state->interface.

- Validate, possibly at phylink_validate_phy() time, that for all
  phy->possible_interfaces, mac_select_pcs() either returns NULL for
  all of them, or non-NULL for all of them. The idea would be to leave
  room for the use case to define itself (and the restriction to be
  lifted whenever necessary), instead of giving a predefined behavior
  for the transition when in reality we have no idea of the use case
  behind it. I don't know whether checking phy->possible_interfaces
  would be sufficient in ensuring that such a transition cannot occur.

I find no contradiction between my replies (mostly questions, actually)
in Nov 2021 and my current agreement that phylink's behavior of keeping
the old PCS and using it for the new state->interface doesn't make much
sense.

