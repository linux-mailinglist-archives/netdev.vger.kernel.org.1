Return-Path: <netdev+bounces-151335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF019EE36A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8EBE1888D41
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6F20FAB5;
	Thu, 12 Dec 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="0N/fKWJx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4C13CF9C
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997017; cv=none; b=MRCuauink3sylma5AoNRtAhN1kwcpEDCEMFGodHL9Z/NQa60VvcDFqFbsrU1EoqFbXwTGt5cYmwNztBePhD/PNX8krdr7idbOfyDuETjD3ZMeXN95yVetkmLCJCRm7vQ+t/A19TpNXSK98ti/wxW+ZzTTgTOEWmQXVIiCDf1lJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997017; c=relaxed/simple;
	bh=aiVkN8wFSy53vfy//qHN9Y3veBiW3RpnG+0M2iqvCnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaSecGJEcD6jYUWclrVDdiRMPCelmVDmtbf+nvYAWVuAOqd0vj7RXOjL4a+rCiNM2tWkhfjWgVVskWDTtznoR16m9OgVf4W3yurmskYiZlXvggqXIJnQOdhwNFCsFTWZjRYkZU1lyFAL03j4rMUPRPA3vrmnGI0Dm3dQT08N7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=0N/fKWJx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385d851e7c3so12903f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 01:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733997012; x=1734601812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=okWFcqwz745riexuVOmnLalQvUEWtOTwhEvqHtgzFLo=;
        b=0N/fKWJxquog4y3Y0O7c72ukuWPeuYSTq95mSAW2hkd2Uo9i3q/BHu93fUMmq5221p
         TzhMWFS+xOO0JdTj0x6pA5kiYQpx4rvSyJskDZiYjIId8X1F/UlWsmxFFgLUF05ACFgW
         /Bt0BUZnLaGLNhY3Id6FLT+gW2r/aLDlR3eSxt2I/RoGe/InIa5CuHSi5+SvhdaJniI1
         GFvYfCb/Gp5L2nhYTqnzhCK0Q2dmuUG+fmyzzw4utzzpekheqY+ekInDxpak8AZvGrLq
         zrFZVgtt5PowQEafQ4rbAHXueWX9uN/JDIe20UbaxGMtgdRiHMlAXVR08Pq1JD8J8tay
         JiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997012; x=1734601812;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okWFcqwz745riexuVOmnLalQvUEWtOTwhEvqHtgzFLo=;
        b=IiTi4IuH+EPHT2O4+nrbO4zqfgFueR/qXr0nZ9mv08vc3KehuwhMS8tzVJLAb/5bn9
         f/GHdBJW7D0YSliksPIDIQ5qmKotQZ8ljz+X6wChi5sBC7B5I4NxyY75u5pqScDAkg4H
         4WbspWfF6YD59V3VWBX3YJff9zrXEFgXqVSFUW0dLbS29f9aCPbdqZu+JcES1IJDbmFu
         5Yec8+aHmxLuRlAkacJMttWCPYwYrsRu58VkPlNjYOK4fOco6j3uQr9DrNv5LHsp6z0G
         idn5EnYZVq8VRzAnErIpYA61JfwJDhm2XzcYpzdDpZDEhbFvaPjZwjZErJVO2CHxD8Xy
         xYIg==
X-Forwarded-Encrypted: i=1; AJvYcCV3yYBvsaeuiRdfsRIewXpJkht7NwC6abu2ElFGGLy9CfX5U5HBzTwx7XEf1o4tgFIjJdzmoDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCGwg5/WxM2rX+x7Z6b4Ks1mA5iA8htnAJ1+Eat2a1z+IMWmD
	uLS5iIsBVPA/NNkxD3gX6DmjoMkKyDMDFBfMAqeqkCF5kjSYcTztbWQ95x5XAlUqcDWtmf7UTub
	2OBQqoA3Pe9jBj07eGktkojPiyGxJ7xy3FzHQTQbgr5yTVq8=
X-Gm-Gg: ASbGnctF3YY3rVK6eR4Pv25ZJC4VRjKT8H3imQaMVO8vTEmAZ1+5qXic7adB/UEEO/H
	+LkDWPeB1GJpI6gv0wTlGgJgGuA9T4yWwp0aim43ycQsRst6EBVDkm9vd+8up6erc8UbTXb2O6+
	J84bKScKpCcw0zPvkh6bzcQPViBSjFgrX8RegNIHmyBllBzR28Af95uvCPHp8u83fTIycZsmfaS
	WRC4OdYmxaq8h7wNnPOQd0QpwTk2PwDAvUOAYH1W3ZWhrF+3fJQWSsDZz9zY69dzxy/J06GxvEA
	OMqa8Il4X8FFd5RLtZl5yYDqYZmQZzlkhl3zJlXoYw==
X-Google-Smtp-Source: AGHT+IEDd+50dKxAbyIgOqqAGJTZtS2ei9utFw1et+1WqXefvgzsGVXHKEFqreLUMWi7G/9lvq+Phw==
X-Received: by 2002:a05:6000:1569:b0:385:e877:c03b with SMTP id ffacd0b85a97d-3864ce4a512mr1799556f8f.2.1733997012047;
        Thu, 12 Dec 2024 01:50:12 -0800 (PST)
Received: from [192.168.0.240] (dslb-084-060-024-069.084.060.pools.vodafone-ip.de. [84.60.24.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248e63esm3550177f8f.10.2024.12.12.01.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:50:11 -0800 (PST)
Message-ID: <fb085904-e1c2-4bbf-b826-b6ba67d283b5@bisdn.de>
Date: Thu, 12 Dec 2024 10:50:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
To: Ido Schimmel <idosch@nvidia.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Hans Schultz <schultz.hans@gmail.com>,
 "Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
 <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
 <Z1lQblzlqCZ-3lHM@shredder>
 <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
 <Z1mmnIPjYCyBWYLG@shredder>
From: Jonas Gorski <jonas.gorski@bisdn.de>
Autocrypt: addr=jonas.gorski@bisdn.de; keydata=
 xjMEZxdk5BYJKwYBBAHaRw8BAQdAPu67BaIt3vpOuFNykN1bTGnMCt3SfaTAdTgdx7x3aM3N
 JEpvbmFzIEdvcnNraSA8am9uYXMuZ29yc2tpQGJpc2RuLmRlPsKPBBMWCAA3FiEEFDg1Kr+u
 iVjQpdfy5Kt7/8+fcMYFAmcXZOQFCQWjmoACGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDkq3v/
 z59wxkUZAP4uDlkfv1WhuDjPUaeL9uL33RUo4mUwIYQLAR8gKQk5lgEAiQvKbFvrB2Zz8Tbs
 anWvhWddIu1L9D4KMdoayMpCqQrOOARnF2TkEgorBgEEAZdVAQUBAQdAQSvRRbcsAY5GLbFn
 qnD2JZ3hGcjOviBjgQpPQV48MSMDAQgHwn4EGBYIACYWIQQUODUqv66JWNCl1/Lkq3v/z59w
 xgUCZxdk5AUJBaOagAIbDAAKCRDkq3v/z59wxuVgAP9D6DwrhASXLN8c5uy/BYuaMznIfqf5
 6R95DltdAG2xigD/TCGATSNdLFd253kU+qiZPLWwcqNouB2cTa1ItM1N/AU=
In-Reply-To: <Z1mmnIPjYCyBWYLG@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 11.12.24 15:50, Ido Schimmel wrote:
> On Wed, Dec 11, 2024 at 11:32:38AM +0100, Jonas Gorski wrote:
>> Am Mi., 11. Dez. 2024 um 09:42 Uhr schrieb Ido Schimmel <idosch@nvidia.c=
om>:
>>>
>>> On Tue, Dec 10, 2024 at 04:28:54PM +0100, Jonas Gorski wrote:
>>>> Thanks for the pointer. Reading the discussion, it seems this was
>>>> before the explicit BR_PORT_MAB option and locked learning support, so
>>>> there was some ambiguity around whether learning on locked ports is
>>>> desired or not, and this was needed(?) for the out-of-tree(?) MAB
>>>> implementation.
>>>
>>> There is a use case for learning on a locked port even without MAB. If
>>> user space is granting access via dynamic FDB entires, then you need
>>> learning enabled to refresh these entries.
>>
>> AFAICT this would still work with my patch, as long learning is
>> enabled for the port. The difference would be that new dynamic entries
>> won't be created anymore from link local learning, so userspace would
>> now have to add them themselves. But any existing dynamic entries will
>> be refreshed via the normal input paths.
>>
>> Though I see that this would break offloading these, since USER
>> dynamic entries are ignored in br_switchdev_fdb_notify() since
>> 927cdea5d209 ("net: bridge: switchdev: don't notify FDB entries with
>> "master dynamic""). Side note, br_switchdev_fdb_replay() seems to
>> still pass them on. Do I miss something or shouldn't replay also need
>> to ignore/skip them?
>>
>>>> But now that we do have an explicit flag for MAB, maybe this should be
>>>> revisited? Especially since with BR_PORT_MAB enabled, entries are
>>>> supposed to be learned as locked. But link local learned entries are
>>>> still learned unlocked. So no_linklocal_learn still needs to be
>>>> enabled for +locked, +learning, +mab.
>>>
>>> I mentioned this in the man page and added "no_linklocal_learn" to
>>> iproute2, but looks like it is not enough. You can try reposting the
>>> original patch (skip learning from link-local frames on a locked port)
>>> with a Fixes tag and see how it goes. I think it is unfortunate to
>>> change the behavior when there is already a dedicated knob for what you
>>> want to achieve, but I suspect the change will not introduce regression=
s
>>> so maybe people will find it acceptable.
>>
>> Absolutely not your fault; my reference was the original cover letters
>> for BR_PORT_LOCKED and BR_PORT_MAB and reading br_input.c where the
>> flags are handled (not even looking at if_link.h's doc comments). And
>> there the constraint/side effect isn't mentioned anywhere, so I
>> assumed it was unintentional. And I never looked at any man pages,
>> just used bridge link help to find out what the arguments are to
>> (un)set those port flags. So I looked everywhere except where this
>> constraint is pointed out.
>>
>> Anyway, I understand your concern about already having a knob to avoid
>> the issue, my concern here is that the knob isn't quite obvious, and
>> that you do need an additional knob to have a "secure" default. So
>> IMHO it's easy to miss as an inexperienced user. Though at least in
>> the !MAB case, disabling learning on the port is also enough to avoid
>> that (and keeps learning via link local enabled for unlocked ports).
>>
>> At least in the case of having enabled BR_PORT_MAB, I would consider
>> it a bug that the entries learned via link local traffic aren't marked
>> as BR_FDB_LOCKED. If you agree, I can send in a reduced patch for
>> that, so that the entries are initially locked regardless the source
>> of learning.
>=20
> I will give a bit of background so that my answer will make more sense.
>=20
> AFAICT, there are three different ways to deploy 802.1X / MAB:
>=20
> 1. 802.1X with static FDB entries. In this case learning can be
> disabled.
>=20
> 2. 802.1X with dynamic FDB entries. In this case learning needs to be
> enabled so that entries will be refreshed by incoming traffic.
>=20
> 3. MAB. In this case learning needs to be enabled so that user space
> will be notified about hosts that are trying to communicate through the
> bridge.
>=20
> When the original patch was posted I was not aware of the last two use
> cases that require learning to be enabled.
>=20
> In any scenario where you have +learning +locked (regardless of +/-mab)
> you need to have +no_linklocal_learn for things to work correctly, so
> the potential for regressions from the original patch seems low to me.
>=20
> The original patch also provides a more comprehensive solution to the
> problem than marking entries learned from link local traffic with
> BR_FDB_LOCKED. It applies regardless of +/-mab (i.e., it covers both
> cases 2 and 3 and not only 3). That is why I prefer the original patch
> over the proposed approach.

The original patch (just disabling LL learning if port is locked) has
the same issue as mine, it will indirectly break switchdev offloading
for case 2 when not using MAB (the kernel feature).

Once we disable creating dynamic entries in the kernel, userspace needs
to create them, and userspace dynamic entries have the user bit set,
which makes them get ignored by switchdev.

Ofc enabling MAB and then unlocking the locked entries hosts that
successfully authenticated should still work for 2, as long as the host
sent something other than link local traffic to create a (locked)
dynamic entry AFAIU.

FWIW, my proposed change/fix would be:

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..41b69ea300bf 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -238,7 +238,8 @@ static void __br_handle_local_finish(struct sk_buff *sk=
b)
 	    nbp_state_should_learn(p) &&
 	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
 	    br_should_learn(p, skb, &vid))
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
+		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid,
+			      p->flags & BR_PORT_MAB ? BIT(BR_FDB_LOCKED) : 0);
 }
=20
 /* note: already called with rcu_read_lock */

which just makes sure that when MAB is enabled, link local learned
entries are also locked. This relies on br_fdb_update() ignoring most
flags for existing entries, not sure if this is a good idea though.


Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


