Return-Path: <netdev+bounces-155196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45836A016F4
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 22:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7548F18839C2
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 21:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB241514CE;
	Sat,  4 Jan 2025 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Fw1hm2+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143417FE
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736026629; cv=none; b=hsY/es67/Rw0hZxS2H6AXKIaDMNBGHfO7jmh60RHz6w8P8T/zQ92BjyO/+8biO9i+XkMsBYjB4cBB5SqVJnY0r/XP14CDE733eBM/YBK/CwMsiB5AJBfl0kHiSa0pkWRFV060jWiYku0jwEUqyyhpxcaVec/PLq4vnqs2duv2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736026629; c=relaxed/simple;
	bh=JsPw728C1vDt5mMNXZFcY3Oog8b8MDa7wmGNySfm/2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8KS857Cb2goCeQM882WLiNhQ0PmOu7cJRPG8l5TcG1vwokr25yO7tQRacp2JAxV14VeE/KoX+OUUvlgiHfgOiBEfVaKR9/EdKeqAJn2zgflyGFfW7hwWhBNEuQNmaZHo8BPtLviv8xpGDo1iXp2zYjJoXXZXcp/TWfBZQoCKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Fw1hm2+D; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e3a227b82so12336817e87.0
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 13:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1736026625; x=1736631425; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvTqvNkvvfHuXKhA3SUUtWdJmN1voFWwjBlhs5pwwkA=;
        b=Fw1hm2+D3Lb3vlT8QyUCqlAw6JYCR0Q9C28dB8CZc5L/g4rc63Sz8vDNmClsLte1gP
         q3VEmR1hxcIBFAyq0oeHDg6bKbF9vgfnUAROLIKm65d5FDoALnh3VIO3FjXinzcDEK1O
         xRybilLx3oliAYuwFEfeYKuXplGHS2ITA12ZZXAhitRynputFlBKSigC+jdksBiSNR4h
         ZlaPIzN2v516adbqLGo4CZiFkh5wImZWWil0N+Sj2mj1fq5J/MDRHkHX/l9hFU3e6fJ3
         b9hK1x4F5dPfCPcVNcni1bYP2lwrglnCnwQ7lrbIZoSDf9r41ifRuOmK6VVa6KP4xEKs
         1oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736026625; x=1736631425;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvTqvNkvvfHuXKhA3SUUtWdJmN1voFWwjBlhs5pwwkA=;
        b=rd7JW2EE5mplkuVTvkDWZyR7v8rxD6EzQspwresw8UqYYzFHBq1AEpi1C4xTWV4QEk
         LXiaB/bEV+wKpqEjLM98bpP9TUYytwR+btHZSgZSrQ5eXkuVuIr4+ZmsaqbYq/jaV24f
         c4p20pHUy2IJO+2sk4/TcsAlxsrHbrUiP04c56qXPuq+89i6ZXW5VxfIdLCjhCOnEuuk
         J+/FJz4wZsdvrzPoHKViDzE/kZlEPaDDf93cj1mchFIV57h3OP6InZageqEpen6PBY1j
         6AZnt1f6YWzEWullEPvgq86CIF0gdxniSDFkm0jFqk7B2ByvSxU8rA59GVxqUzNKspqA
         IDUg==
X-Forwarded-Encrypted: i=1; AJvYcCVN6Qi4v93UHzm5v/byYz5J1++j80B/OulDJqMyPSskMIuUvRr+48Bxt89qrHvXhyx9oRBjOQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv7k0NXmAIR/7Vq72od99CtTQGfjH8lq4N2hrAYKPAU6CIjSYC
	LLWvPSIlAzd0ZQI8mP6VKnkua5xQFoePZxt6EiUJ/Sd0KLR4HrqW6gTQXZLrjh4=
X-Gm-Gg: ASbGncsuj1ULtFxj+InGxgf90d3jpS3aJcIzcJTfzeexeuqq/KXwUDNuAxHsxRo5rqe
	4FDEfVGVs2kgXyCg1m5aihWWlpVXJr/6O5GQxUapxz9cSyYziopFkMJz8JjEVFd0NG4GdYqaFJy
	I1kVqSE0hNxyn2erM+GX7+zjksUOKPINw2yxhqL/6k/W4Ty2zRo+D7tCnhsFILZnhvFm3ZQJr27
	9kzGH9GzHcnFflZliG+3s6Y+b9DW9uvOmxlTBUNhaw1clbxUjFLMKnY5Ko8cnkC0JI14ZzoxBPw
	DJE8SXuTu3kAyg==
X-Google-Smtp-Source: AGHT+IEFsCX3a3CQqN9Z8+jrtQa4uTYJppY2noLbU+wOWKtn1yb1gf1w5QqYlNJ9XBI1OIRv6oHYYQ==
X-Received: by 2002:a05:6512:3049:b0:540:20eb:80c5 with SMTP id 2adb3069b0e04-542295602bcmr15520309e87.37.1736026624721;
        Sat, 04 Jan 2025 13:37:04 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54270d3c148sm242292e87.221.2025.01.04.13.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 13:37:02 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, netdev@vger.kernel.org,
 chris.packham@alliedtelesis.co.nz, pabeni@redhat.com, marek.behun@nic.cz
Subject: Re: [PATCH v2 net 3/4] net: dsa: mv88e6xxx: Never force link on
 in-band managed MACs
In-Reply-To: <Z3bIF7xaXrje79D8@shell.armlinux.org.uk>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-4-tobias@waldekranz.com>
 <Z3ZrH9yqtvu2-W7f@shell.armlinux.org.uk> <87zfk974br.fsf@waldekranz.com>
 <Z3bIF7xaXrje79D8@shell.armlinux.org.uk>
Date: Sat, 04 Jan 2025 22:37:00 +0100
Message-ID: <87pll26z2b.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, jan 02, 2025 at 17:08, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> On Thu, Jan 02, 2025 at 02:06:32PM +0100, Tobias Waldekranz wrote:
>> On tor, jan 02, 2025 at 10:31, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>> > On Thu, Dec 19, 2024 at 01:30:42PM +0100, Tobias Waldekranz wrote:
>> >> NOTE: This issue was addressed in the referenced commit, but a
>> >> conservative approach was chosen, where only 6095, 6097 and 6185 got
>> >> the fix.
>> >> 
>> >> Before the referenced commit, in the following setup, when the PHY
>> >> detected loss of link on the MDI, mv88e6xxx would force the MAC
>> >> down. If the MDI-side link was then re-established later on, there was
>> >> no longer any MII link over which the PHY could communicate that
>> >> information back to the MAC.
>> >> 
>> >>         .-SGMII/USXGMII
>> >>         |
>> >> .-----. v .-----.   .--------------.
>> >> | MAC +---+ PHY +---+ MDI (Cu/SFP) |
>> >> '-----'   '-----'   '--------------'
>> >> 
>> >> Since this a generic problem on all MACs connected to a SERDES - which
>> >> is the only time when in-band-status is used - move all chips to a
>> >> common mv88e6xxx_port_sync_link() implementation which avoids forcing
>> >> links on _all_ in-band managed ports.
>> >> 
>> >> Fixes: 4efe76629036 ("net: dsa: mv88e6xxx: Don't force link when using in-band-status")
>> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> >
>> > I'm feeling uneasy about this change.
>> >
>> > The history of the patch you refer to is - original v1:
>> >
>> > https://lore.kernel.org/r/20201013021858.20530-2-chris.packham@alliedtelesis.co.nz
>> >
>> > When v3 was submitted, it was unchanged:
>> >
>> > https://lore.kernel.org/r/20201020034558.19438-2-chris.packham@alliedtelesis.co.nz
>> >
>> > Both of these applied the in-band-status thing to all Marvell DSA
>> > switches, but as Marek states here:
>> >
>> > https://lore.kernel.org/r/20201020165115.3ecfd601@nic.cz
>> 
>> Thanks for that context!
>> 
>> > doing so breaks last least one Marvell DSA switch (88E6390). Hence why
>> > this approach is taken, rather than not forcing the link status on all
>> > DSA switches.
>> >
>> > Your patch appears to be reverting us back to what was effectively in
>> > Chris' v1 patch from back then, so I don't think we can accept this
>> > change. Sorry.
>> 
>> Before I abandon this broader fix, maybe you can help me understand
>> something:
>> 
>> If a user explicitly selects `managed = "in-band-status"`, why would we
>> ever interpret that as "let's force the MAC's settings according to what
>> the PHY says"? Is that not what `managed = "auto"` is for?
>
> You seem confused with that point, somehow confusing the calls to
> mac_link_up()/mac_link_down() when using in-band-status with something
> that a PHY would indicate. No, that's just wrong.
>
> If using in-band-status, these calls will be made in response to what
> the PCS says the link state is, possibly in conjunction with a PHY if
> there is a PHY present. Whether the PCS state gets forwarded to the MAC
> is hardware specific, and we have at least one DSA switch where this
> doesn't appear happen.
>
> Please realise that there are _three_ distinct modules here:
>
> - The MAC
> - The PCS
> - The PHY or media

Right, I sloppily used "PHY" to refer to the link partner on the other
end of the SERDES.  I realize that the remote PCS does not have to
reside within a PHY.

> and the managed property is about whether in-band signalling is used
> from the PCS towards the media, not from the PCS towards the MAC.
>
> So, if the MAC doesn't get updated with the PCS' link state, then
> mac_link_up()/mac_link_down() need to do that manually, even if the
> link from the PCS towards the media is using in-band signalling.
>
> I think you're confusing in-band-status as meaning that the MAC
> gets automatically updated with the PCS media-side link state -
> the DT property has no bearing on that.

If `managed` does not declare a hardware capability of the controller,
then what information does it convey that is not already present in the
`phy-connection-type`?

E.g. what does it mean to have an SGMII link where in-band signaling is
not used?  Is that not part of what defines SGMII?

I.e. could you provide an example `$TYPE`, where both of the following
configs are valid, and what the difference between the two would be?

    &eth0 {
        phy-connection-type = "$TYPE";
        managed = "auto";
    };

    &eth0 {
        phy-connection-type = "$TYPE";
        managed = "in-band-status";
    };

> Thanks.

Thank you for taking the time to explain!

