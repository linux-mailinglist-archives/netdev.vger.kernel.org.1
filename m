Return-Path: <netdev+bounces-93779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E668BD30A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 18:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B901C21086
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B682F156C62;
	Mon,  6 May 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OrLwiqx8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A6825569
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014035; cv=none; b=msJ3SFanOLHNzqQ9rmW93td48V2xXRGEbtpDfqfTe5zsD95SK/fZjWjNY3gR6PEz7ZNkZgoGaz0O5gtaWjg1tr0qW+TO5XNa4X2F8/gW5vsun+zGzI4YkZhfvE2pLSyDpVm9ObVFCw6DJKBjwTc9uHghVoiAWmxPGAS+lNmrBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014035; c=relaxed/simple;
	bh=ne0VrpciWO44fCdFNq8qPNWA+XkpPJ7XBbp6hOq5Wek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmCMeweEijTmoZseKpvNk+yFw40T+/3BU9FyptjcNd/TII/0X6M/49y97kS2WYVNAKItGt7qlAB1v4vuZAsxYDCArT19Inb6/YI/T2kHMgPFmryZHzSLjIeCYb+9w0+1e2B8rRDXaY3yOAO3fmRkuBTLxC3CjyMCnR8uJBlbSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=OrLwiqx8; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A04DE400F4
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715014030;
	bh=lBDhS1Ebaa+YuFiVFmddrCNWvRnay3hvunupCOY2htE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=OrLwiqx8fz94kRBAbeijfc3aGK/1bwl7b/OB1NYBfCryjSIH6fyzGHsWLfDh/ln/W
	 nxodG9Ldh3C5v+mt7SQo9BgmT83Y+LDojortpb5+0wH/tEKoXKGXnoUSORBI0nTmWV
	 BpcBq8rXmV+SjCfwKYo/wfvCbIm1pOnZrGkujoxfXxTOYeyuTiV+BZVnM1j2Hb97NX
	 FyUhJjwU5E8gD4RMRSEwBaCP0YM4OkUVW6ps14kudm1gYz08Qm5RT+lxIKW3224bLG
	 fRGXDzla/kMLLGcG8S2oPvF+FREV9hAfyS/pxPT6pL97DCy8hdBa5JrnmcXCn5W8ZJ
	 D/hLX7RSbfl/Q==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-349cafdc8f0so1213275f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 09:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715014028; x=1715618828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBDhS1Ebaa+YuFiVFmddrCNWvRnay3hvunupCOY2htE=;
        b=JPvjkaR68uayyZUx0hsDDfhJ/2DALrJV1wdWo+w+W9qSdIn4BNGMj2VeIM2ui2JMBB
         uuTfV6QghkXRiN23FD7qYW6fX3GE2+qgk2YpPe6X91I12hsqyuEES5S4SqbwQE62ITAP
         N1cYF6wxekM0ZV66nUhOD3xi9T1vun/6LAuEGn7azr7dd6GtPmlYSf8KirfS9W1kIOCt
         jJluAJeubPVIwjeXaOBxfPE3IceyXgF7ktvHNzsiVNGOqOXPH46R3jxgMwkNajleAGoP
         7pPk9I90+IUtCvxV78p9oH9qfvCqUCKsYqMl0wNgHogBvSohTiUWqDsQ5CkIAe/1258q
         QdHw==
X-Gm-Message-State: AOJu0Yz7pbQ3b/RV26ItMQrTlB8FPH8fSG+e/YzyDCjsYDDMtExwedCu
	KzZDqVZFdsIyO4Dz7sibgPA7eG+A1ETWaz3APtabc5KZtip94C0gdHkkHONwPuMB8A/2vSoQD8Z
	lnorb1x1EReIqPUa2g4VWMinSIqY3px89npWea1MaFfIPGzv8NduET3ssasbWtnGUnng9XiYU/b
	6uLrp3zmPI0Zh8dpHfokLw1bo3SL28RMQCSsM8E/HaQprK
X-Received: by 2002:a5d:5445:0:b0:343:6b09:653c with SMTP id w5-20020a5d5445000000b003436b09653cmr9213438wrv.43.1715014028039;
        Mon, 06 May 2024 09:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELDM24XgpFlJfKqTrie0KzqLju4QkFgMrMwyxkhc8UujUz4TrH5RzyaUIOGAI1gDgrRnTn9pHTWWPlV8jlkw0=
X-Received: by 2002:a5d:5445:0:b0:343:6b09:653c with SMTP id
 w5-20020a5d5445000000b003436b09653cmr9213423wrv.43.1715014027737; Mon, 06 May
 2024 09:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503101824.32717-1-en-wei.wu@canonical.com> <7f533913-fba9-4a29-86a5-d3b32ac44632@intel.com>
In-Reply-To: <7f533913-fba9-4a29-86a5-d3b32ac44632@intel.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Tue, 7 May 2024 00:46:56 +0800
Message-ID: <CAMqyJG1Fyt1pZJqEjQN_kqXwfJ+HnqvW1PnAOEEpzoS9f37KBg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 1/2] e1000e: let the sleep codes run
 every time
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: netdev@vger.kernel.org, rickywu0421@gmail.com, 
	linux-kernel@vger.kernel.org, edumazet@google.com, 
	intel-wired-lan@lists.osuosl.org, kuba@kernel.org, anthony.l.nguyen@intel.com, 
	pabeni@redhat.com, davem@davemloft.net, 
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, 
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Content-Type: text/plain; charset="UTF-8"

Thank you for your time.

Originally, sleep codes would only be executed if the first read fails
or the link status that is read is down. Some circumstances like the
[v2,2/2] "e1000e: fix link fluctuations problem" would need a delay
before first reading/accessing the PHY IEEE register, so that it won't
read the instability of the link status bit in the PHY status
register.

I've realized that this approach isn't good enough since the purpose
is only to fix the problem in another patch and it also changes the
behavior.

Here is the modification of the patch [v2,2/2] "e1000e: fix link
fluctuations problem":
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1428,7 +1428,17 @@  static s32
e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
- ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
/* comments */
+ ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT,
100000, &link);

Do you think we can just add a msleep/usleep_range in front of the
e1000e_phy_has_link_generic() instead of modifying the sleep codes in
e1000e_phy_has_link_generic()?

Thanks.

On Mon, 6 May 2024 at 23:53, Sasha Neftin <sasha.neftin@intel.com> wrote:
>
> On 03/05/2024 13:18, Ricky Wu wrote:
> > Originally, the sleep codes being moved forward only
> > ran if we met some conditions (e.g. BMSR_LSTATUS bit
> > not set in phy_status). Moving these sleep codes forward
> > makes the usec_interval take effect every time.
> >
> > Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> > ---
> >
> > In v2:
> > * Split the sleep codes into this patch
> >
> >   drivers/net/ethernet/intel/e1000e/phy.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> > index 93544f1cc2a5..4a58d56679c9 100644
> > --- a/drivers/net/ethernet/intel/e1000e/phy.c
> > +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> > @@ -1777,6 +1777,11 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >
> >       *success = false;
> >       for (i = 0; i < iterations; i++) {
> > +             if (usec_interval >= 1000)
> > +                     msleep(usec_interval / 1000);
> > +             else
> > +                     udelay(usec_interval);
> > +
>
> I do not understand this approach. Why wait before first
> reading/accessing the PHY IEEE register?
>
> For further discussion, I would like to introduce Dima Ruinskiy (architect)
>
> >               /* Some PHYs require the MII_BMSR register to be read
> >                * twice due to the link bit being sticky.  No harm doing
> >                * it across the board.
> > @@ -1799,10 +1804,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
> >                       *success = true;
> >                       break;
> >               }
> > -             if (usec_interval >= 1000)
> > -                     msleep(usec_interval / 1000);
> > -             else
> > -                     udelay(usec_interval);
> >       }
> >
> >       return ret_val;
>

