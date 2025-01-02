Return-Path: <netdev+bounces-154729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9328D9FF99B
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E23A33B2
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E74619D071;
	Thu,  2 Jan 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="HfGGy8mq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AF2119
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735823199; cv=none; b=RD340x4/JuY/MnwMI32/mL4wJm+EzDJiUjBAc1FUviqNvl4NjNkkFgcfGf+63sjOwdINMAapW3GZ8n7ryml3JvashldBZ5sZlXazb9/GKAEbomCjZLnkkok4eHdgLXOlTQukk9hmWjtfayLm6H4JUKcXADXz7lTnFGPnal7hyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735823199; c=relaxed/simple;
	bh=2X7zS61xBcGbscOq3SG+fP6GihJO+9E3+PYsAo8SThk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tdOqPfC5226A6T04+BapElU90mDRXfaE1iP7VBe0Ui25N6cXSNpfILF4lZy302grrPDWNCGgy8nlRzsGsa07bLG0EY7Epq9eUr5j/l0dJK9olq5NulfSoyVP/WZ60AdGGB+C0LVvtDkc5JDrexlOLWHAJJG+jU04dGpntkSczk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=HfGGy8mq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401be44b58so12237565e87.0
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1735823195; x=1736427995; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwxnWNKRrr2O48v+RT2TxpoucokG4LWqKuag6aIj08I=;
        b=HfGGy8mquCF230x7vYfyQLS6FHXIErJmAZszRcpRhj0Yb2Sy2GEGa4h8RN1oB7PytR
         Jdun+LIj5qvWVkWcv3xqoQ1u/bJpOhssuIchz3tdt55Rcin9ecEEA2ES6nffzN67TMuo
         3w56vQFxIuhW8Q8qg0ODn+P5nH/M99x9mXPMMSK2Qtb4YRM8XER5/cQyszpcFKkcArjo
         1+izwD+d+VLbxtjaFTrLvS2HNVsK2T/jNkkoU/fgHqkWsam1P59RCfWwpbxxoznGL3GY
         jGVTcDqlrDhMPRQIJLinEOQl/yNgatFc/bwv+aYWyckAAGbOPngw10m9uZvS1MkL+DJj
         bTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735823195; x=1736427995;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwxnWNKRrr2O48v+RT2TxpoucokG4LWqKuag6aIj08I=;
        b=nHA/tZkEgnR37wMB8XcHFV1EOObUmd8jiVZPOzqGoTPVWxCjz9aW5G0lg5A6WWyVuf
         XeG/dHdxdyMCmvaZtyxeHQmu9AEOvhwBwH94u8b1vLcLShw7wjC1ZWBFxupGQZerRaQs
         lDMDLffH7xXcnlUOytdYDQ2vrmyniVynCYriARNQKkpLmKFLyC9oefljRDdDvbzRgiKM
         Z5Aycx+GctehBsVk42gS4kXOSszeFm3yiTP5rGKbWhzbjSAJLuQUVH4KdctpdMTVedFZ
         dw6Kpfuek3mEdtPLXOFN1BMYsQJUj7/zGB82hEp9lRZKqKr0gVelg50bfyy0h6Fh5P5j
         kq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW77UDR2B+z7BoaPdfTKlOmNQgpyg/vJx4VcfoEVQguCbEKaB8KtJCtbxiqChl7xJbOuL42hQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVW4XBqvhmlUlQNNCMmS9+hTDgK5U5WLxEiXRA43rJS1gxwFHJ
	xYlZtpHyHqCWFhJ4YjrFwIaw4zdQLjsomm3t3v2m+Tre7+Up2+hO5F9/q7f3jB4=
X-Gm-Gg: ASbGnctC867srFxev+NQlKxZZjoHC6h/2MJnGDMkpRuclDHDrCZLSGOuNUl9KrOwtC6
	R4tH8JEk6edbBXDo9QC1nttr3CvualfPnwkauPnLI54ITFpKx+zLaR4ptlkalWfFsx3VI66RbYN
	hvrU24RgddFNhAxzwJDIf5IWMt6AGEGMb9b8S6PJencTMSRVzq3RRqbvVmtq5DRtRxCA+G9Ssvx
	aQsmpxtQGVxCu0dXKPZiyKBwhFkf7Bbn7jI4B/T+G3+klKYWj/K7/nkI7LWLbUbdnmGJm7Xvinz
	6IVA7O3yUx1CLg==
X-Google-Smtp-Source: AGHT+IFm/jBEdpD729kVFas8QA8aMDLNVv3HL5out41yDYmC3CrieOLe4EFj+OQZYzWpjITCqaOprg==
X-Received: by 2002:ac2:4e07:0:b0:540:25a6:c342 with SMTP id 2adb3069b0e04-54229525435mr14983097e87.4.1735823194895;
        Thu, 02 Jan 2025 05:06:34 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f61c2sm3802341e87.32.2025.01.02.05.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 05:06:34 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, pabeni@redhat.com, marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
In-Reply-To: <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk>
Date: Thu, 02 Jan 2025 14:06:32 +0100
Message-ID: <87zfk974br.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, jan 02, 2025 at 10:31, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> On Thu, Dec 19, 2024 at 01:30:42PM +0100, Tobias Waldekranz wrote:
>> NOTE: This issue was addressed in the referenced commit, but a
>> conservative approach was chosen, where only 6095, 6097 and 6185 got
>> the fix.
>> 
>> Before the referenced commit, in the following setup, when the PHY
>> detected loss of link on the MDI, mv88e6xxx would force the MAC
>> down. If the MDI-side link was then re-established later on, there was
>> no longer any MII link over which the PHY could communicate that
>> information back to the MAC.
>> 
>>         .-SGMII/USXGMII
>>         |
>> .-----. v .-----.   .--------------.
>> | MAC +---+ PHY +---+ MDI (Cu/SFP) |
>> '-----'   '-----'   '--------------'
>> 
>> Since this a generic problem on all MACs connected to a SERDES - which
>> is the only time when in-band-status is used - move all chips to a
>> common mv88e6xxx_port_sync_link() implementation which avoids forcing
>> links on _all_ in-band managed ports.
>> 
>> Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when using in-band-status")
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> I'm feeling uneasy about this change.
>
> The history of the patch you refer to is - original v1:
>
> https://lore.kernel.org/r/20201013021858.20530-2-chris.packham@alliedtelesis.co.nz
>
> When v3 was submitted, it was unchanged:
>
> https://lore.kernel.org/r/20201020034558.19438-2-chris.packham@alliedtelesis.co.nz
>
> Both of these applied the in-band-status thing to all Marvell DSA
> switches, but as Marek states here:
>
> https://lore.kernel.org/r/20201020165115.3ecfd601@nic.cz

Thanks for that context!

> doing so breaks last least one Marvell DSA switch (88E6390). Hence why
> this approach is taken, rather than not forcing the link status on all
> DSA switches.
>
> Your patch appears to be reverting us back to what was effectively in
> Chris' v1 patch from back then, so I don't think we can accept this
> change. Sorry.

Before I abandon this broader fix, maybe you can help me understand
something:

If a user explicitly selects `managed = "in-band-status"`, why would we
ever interpret that as "let's force the MAC's settings according to what
the PHY says"? Is that not what `managed = "auto"` is for?

Could Marek's issue not stem from the fact that his DT stated that the
MAC would pick up the link information in-band, when in fact it was
unable to do so?

Looking at the functional spec for the 6390, it only seems to support
in-band-status when SGMII is used. So would it not be more accurate to
require `managed = "auto"` on boards with 6390 SERDES lanes connected to
an SFP cage, if hot-swap support between SGMII/1000BASE-X/2500BASE-X
transceivers is needed?

I.e. users requiring maximum flexibility can still have it, while
someone with a fixed connection to an SGMII PHY can still get the
benefit of using in-band signaling.

