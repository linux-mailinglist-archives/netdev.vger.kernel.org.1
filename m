Return-Path: <netdev+bounces-54804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F658084EC
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EB3283766
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C43526C;
	Thu,  7 Dec 2023 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="1C0L1ov8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D36DAC
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 01:47:49 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso6344091fa.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 01:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701942467; x=1702547267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Udm2aPJYhwYfW/78pD9PeOsUFPVyY/oGIglFK9KdLNE=;
        b=1C0L1ov8DxGWosjUCEGYBV5JPWg8RIBJOQQfedDNdjFEtlmLD2h1Pyl0BRGMCOP9iQ
         M4Ly3QVKAVqKB9Qp3a1qU0TL7pVbgLMelxR9rAA8smPZ38Nw200h46OGBqd1AqS7BCcQ
         ujwrko11P5SRWaAkhw1RgW4BbDrYMnb7Z35OEtDjFCveGv5AT1LmYCvOX03BRuMrT8SQ
         SHJdqYAYnJuzFHRQO3XzKF6bLb6YR2GKht3RJiZiWipM3yo1FOCDxeMpVAWHzgf056Ye
         lO6s8/R5O3b7BTtpZhBgzYdA4hG8xwFP8jSAbbZDy7kgZhyhNUAwF49yltJjsHTt9cuI
         NJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701942467; x=1702547267;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Udm2aPJYhwYfW/78pD9PeOsUFPVyY/oGIglFK9KdLNE=;
        b=drCmFSnPH7dMi5YWccGAb73SuoWfOAFMe+Iw03/E/rMyOST897BfGrMHOK6jf2+LEj
         oJtc/R+R4AzElefn4v3tp+VgOn99dUhrcpl+aE6edQfTOh0vAVLGpXFqQSkddhGPaDaj
         ktiWCg+15LNqL/NBv6rtKOs3MrMDp3VzHXfsrQ0Uot3s4nJgtvEBHNKzTyq1nIVp3W/O
         jEG7MRIi2khgWEIxpdyFzrwTyeAGSmSRFMRCa8pOFWvEPokM+RIQ4H6THf/8dGQK/oMI
         xLjVcCk4/Aq2qEo3tb3q4sLxERooYbxF43uvk6sx4FjMjoC3rNQ3aRk9mrfGri4gKh8D
         Vwbw==
X-Gm-Message-State: AOJu0Yy5PTv7M9VEAiiYa7MyjW6UjJbXxVrg0u0Ld8ydATYnVBVHcLdz
	ayCoxR/Mib+5Lrc8X78/HV3GvvFJx/AxmFcJE8g=
X-Google-Smtp-Source: AGHT+IHG7//rx0jE9OjhCJw0Ji1A95gbyRbpEcCDCFWYvofHD0U3b6FXKAnKju8TIfUF5bHrBFKzpw==
X-Received: by 2002:a2e:8310:0:b0:2c9:f099:cdde with SMTP id a16-20020a2e8310000000b002c9f099cddemr1299434ljh.53.1701942466627;
        Thu, 07 Dec 2023 01:47:46 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id a12-20020a05651c030c00b002c9c1ab1314sm180529ljp.46.2023.12.07.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:47:45 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/6] net: dsa: mv88e6xxx: Add "rmon" counter
 group support
In-Reply-To: <20231206195550.4bf3qlybd3hoip5h@skbuf>
References: <20231205160418.3770042-1-tobias@waldekranz.com>
 <20231205160418.3770042-7-tobias@waldekranz.com>
 <20231206002225.nehk4htc4mozcq5b@skbuf> <87v89b91n2.fsf@waldekranz.com>
 <20231206195550.4bf3qlybd3hoip5h@skbuf>
Date: Thu, 07 Dec 2023 10:47:45 +0100
Message-ID: <87sf4e8htq.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On ons, dec 06, 2023 at 21:55, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Wed, Dec 06, 2023 at 09:27:29AM +0100, Tobias Waldekranz wrote:
>> > I just noticed that this doesn't populate the TX counters, just RX.
>> >
>> > I haven't tried it, but I think the Histogram Mode bits (11:10) of the
>> > Stats Operation Register might be able to control what gets reported f=
or
>> > the Set 4 of counters. Currently AFAICS, the driver always sets it to
>> > MV88E6XXX_G1_STATS_OP_HIST_RX_TX, aka what gets reported to
>> > "rx-rmon-etherStatsPkts64to64Octets" is actually an RX+TX counter.
>>=20
>> You have a keen eye! Yes, that is what's happening.
>
> It would be nice if my failure-prone keen eye had the safety net of a
> selftest that catches this kind of stuff. After all, the ethtool
> counters were standardized in order for us to be able to expect standard
> behavior out of them, and for nonconformities to stand out easily.
>
> Do you think (bearing in mind that the questions below might make the
> rest irrelevant) that you could look into creating a minimal test in
> tools/testing/selftests/net/forwarding and symlinking it to
> tools/testing/selftests/drivers/net/dsa? You can start from
> ethtool_std_stats_get() and take inspiration from the way in which it is
> used by ethtool_mm.sh.

I'll give it the old college try.

>> > What's the story behind this?
>>=20
>> I think the story starts, and ends, with this value being the hardware
>> default.
>
> I do hope that is where the story actually ends.
>
> But the 88E6097 documentation I have suggests that the Histogram Mode
> bits are reserved to the value of 3 (RX+TX), which suggests that this
> cannot be written to any other value.

I'm pretty sure that is just typo in the documentation. Every other
field in the documentation marked "RES" has the description "Reserved
for future use" - except for this one. My guess is that the author meant
to type "RWS to 0x3", since that is the convetion for all other
multi-bit fields with a non-zero reset value. W is right next to E on
most keyboards, which makes it even more likely.

In section 4.3.8, we find this:

    The counters are designed to support:
    - RFC 2819 =E2=80=93 RMON MIB (this RFC obsoletes 1757 which obsoletes =
1271)
    ....

At the bottom of that page there is this note for "Set 4" (which is the
histogram group):

    **Note**
    The Set 4 counters can be configured to be ingress only, egress
    only, or both.

These sentences have remained unchanged since at least 6095, up to and
including 6393X.

>> Seeing as the hardware only has a single set of histogram counters,
>
> "Seeing" means you tested this? calling chip->info->ops->stats_set_histog=
ram()
> at runtime, and seeing if the previously hidden histogram counters are
> reset to zero, or if they show retroactively counted packets?

I've now tested it on a 6393X (the only chip I can get my hands on at
the moment). On this device, the bits have moved to Global1:0x1c, but
the description is the same. It behaves like the documentation would
suggest: There is a single set of histogram counters - the user gets to
choose if they collect stats from rx, tx, or both:

We start out with the default of counting rx+tx, we've seen 400 packets
before the test starts:

    root@infix-06-01-00:~# mdio f212a2* mvls 0 g1:0x1c
    0x07c0
    root@infix-06-01-00:~# ethtool -S x10 | grep hist_512
         hist_512_1023bytes: 400

Send 10 pings to our neighbor with a large payload, both rx and tx are
counted (20):

    root@infix-06-01-00:~# ping -L ff02::1%x10 -s 512 -c 10 -i 0.1 -q
    PING ff02::1%x10(ff02::1%x10) 512 data bytes

    --- ff02::1%x10 ping statistics ---
    10 packets transmitted, 10 received, 0% packet loss, time 934ms
    rtt min/avg/max/mdev =3D 0.150/0.172/0.313/0.046 ms
    root@infix-06-01-00:~# ethtool -S x10 | grep hist_512
         hist_512_1023bytes: 420

Limit to tx only:

    root@infix-06-01-00:~# mdio f212a2* mvls 0 g1:0x1c 0x0740

Same test again now only increments the (same) counter by 10:

    root@infix-06-01-00:~# ping -L ff02::1%x10 -s 512 -c 10 -i 0.1 -q
    PING ff02::1%x10(ff02::1%x10) 512 data bytes

    --- ff02::1%x10 ping statistics ---
    10 packets transmitted, 10 received, 0% packet loss, time 934ms
    rtt min/avg/max/mdev =3D 0.148/0.173/0.323/0.050 ms
    root@infix-06-01-00:~# ethtool -S x10 | grep hist_512
         hist_512_1023bytes: 430


> I searched through the git logs, but it's not exactly clear that this
> was tried and doesn't work.
>
>> it seems to me like we have to prioritize between:
>>=20
>> 1. Keeping Rx+Tx: Backwards-compatible, but we can't export any histogra=
m via
>>    the standard RMON group.
>>=20
>> 2. Move to Rx-only: We can export them via the RMON group, but we change
>>    the behavior of the "native" counters.
>>=20
>> 3. Move to Tx-only: We can export them via the RMON group, but we change
>>    the behavior of the "native" counters.
>>=20
>> Looking at RFC2819, which lays out the original RMON MIB, we find this
>> description:
>>=20
>>     etherStatsPkts64Octets OBJECT-TYPE
>>         SYNTAX     Counter32
>>         UNITS      "Packets"
>>         MAX-ACCESS read-only
>>         STATUS     current
>>         DESCRIPTION
>>             "The total number of packets (including bad
>>             packets) received that were 64 octets in length
>>             (excluding framing bits but including FCS octets)."
>>         ::=3D { etherStatsEntry 14 }
>>=20
>> In my opinion, this gives (2) a clear edge over (3), so we're down to
>> choosing between (1) and (2). Personally, I lean towards (2), as I think
>> it is more useful because:
>>=20
>> - Most people will tend to assume that the histogram counters refers to
>>   those defined in RFC2819 anyway
>>=20
>> - It means we can deliver _something_ rather than nothing to someone
>>   building an operating system, who is looking for a hardware
>>   independent way of providing diagnostics
>
> If the "reserved to 3" thing is true, then both (2) and (3) become
> practically non-options, at least for 88E6097. The waters would be
> further muddied if the driver were to make some chips use one
> Histogram Mode, and other chips a different one. It implies that as
> a user, you would need to know what switch family you have, before
> you know what "ethtool -S lan0 | grep hist_64bytes" is counting!

I agree that having different chips work differently would be a
nightmare. Especially since this could mean that "lan1" might behave
differently than "lan0" if they are attached to different chips on the
same system.

Fortunately though, it looks like (2) is still on the table. Do you
agree with that assessment? If yes, do you think is the right way
forward?

Andrew, what's your opinion?

