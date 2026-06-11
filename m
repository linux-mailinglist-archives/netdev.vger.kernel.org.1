Return-Path: <netdev+bounces-298020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j/d6Eoh4KmqEqAMAu9opvQ
	(envelope-from <netdev+bounces-298020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2769670161
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:57:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="QJn9b/AD";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298020-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298020-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBB030391E3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD593BAD94;
	Thu, 11 Jun 2026 08:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CF3BA236
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:56:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168183; cv=none; b=Za9025aFzi+SGYsX/vA3YCct1Gbayj8xzef6NZOJHqn7uZKok+rqmJSTaKUkL2f2Wyy83M4DFsaES88phgb6xvu0JPy3HqNv0DXedRQkCCoahqCof8USvKSqu7zUYv/7VDw++MEaJxT4gUPkVbBxftDKyTFS+12OIARze6yjGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168183; c=relaxed/simple;
	bh=DgBPzL6z1Yltiaswa5bp/i450PjHDVfyYhPj67SlEJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrw3r6KLM93C8gTYfTZwE0L2IQ/ckjhX0glBfhSw5E+GngHIyrK7bFCgTCUVl/amauQ/0vPh11Xn1Z2T05L2mnfXgXD/R4K/61ZLOD1vADRfQQb514hdTGiVsoGe4jYagkRAtttK4rmRK+dttb5hmB6v3KqmPNWIUjRbRU+a24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJn9b/AD; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c20f0c0aso59762975ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168181; x=1781772981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6qwMGpihlKqdGNZklUOA6TclFJahvJxIIDO9zFQ362g=;
        b=QJn9b/ADOf5RR13Bb+fT4L+ZJab4z/lc222zx5eEBqYm0+bHU9+SGiyjRTOSpwUQwk
         xh0ovymhrHUYpNdnvoBdfArHNnnj+q4Ry/o4scTtQ6LPh/G3N5yJgzXRjfQx6/MtB+dt
         nUEAjh/DHz7XhaeJzYr0YqY+mxEBx8qUZFGxzyPlIxlMISDgBUBvxJwb67yiMjMlRIoM
         gF0GqJVgp43TdCHObRnoIpYNyUsN33aiYQVeJA3KhPGXSsTlzdAO7YSYlNKrT2oTWjKy
         74UWAWQsIzr1eG+7RoouZRdBOj2yaEQJuYP2csa9X2RspnLgThngB0D3Tr85I9c+awE6
         Qmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168181; x=1781772981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qwMGpihlKqdGNZklUOA6TclFJahvJxIIDO9zFQ362g=;
        b=KG8EwimgV/U8wvGB0qEw35dkjja+Oh4RSZd3ajMpTdTM0LgOUO/voKcM+YjT/EMCH6
         +ecOYvyIhAM3o8VsZEHI8ZsxqL09cF67jNGAfMc2tcwmOuTyyBt6eP5h58hYy12Kz6Hm
         2qvII3j/9vD03ExUZe//cQpO5XASop9xgAgdwnT2hWCZYefA6WPISQ5PrbyZIuDvJ+qf
         CoJCEQJj3oxBBeoyiqbTM/ygNUCIFFLswKSXm1MCvFybLyWwPYjteJc6FbXCixfNUXUP
         lZ252c+VuyZjxq74uRGojBM1iXHnuJJKi5w5HYOvVfRrfdvjc5fgdtLvWLg4zY6zpLAC
         tioQ==
X-Gm-Message-State: AOJu0YzMiTFekFIo8zpSzAmozENNLMVi6z/OsHVRLoLDLedUOReOYgmZ
	Bw9GD+fkiQ+StX3oOb3OKwn8uKU7Jq/r6kd45iGRnNudyUVRQS19Khx0
X-Gm-Gg: Acq92OGAWv0kztlSB0lQ747YjZGQUBFzm2xQkmcRbp7xWj9MvpFQKItvHz6BEri7b7P
	AsK4xaiaDQSA3a7dZP9yMwRnzWVOtCqi93+eqsgIvlg1nSwxQHY1a7wtrgdUWIHa2ET3Gwcn/F6
	OQXcDs+vBCefhGm+n8qU4gokjeFUATrnqle+e9SdFHYPpLhSewtXDZIc9d+bopQaPJDySnwDlHL
	wvoL0BFJy2a82/5Q7bQjFkdTTa64oGVhpAjPkETYtb5azT1G9GDWAMnn8MpbR5c0p+S5+nYrbPV
	s0gDkQEP5cnlBAbNslDTQ9Lj5o3k95Gf/3ApMF5ipuNNuWt54AgfeHEfu2FeF3LQQ8qGi176mp4
	0g7dgXK5uodUHflgxgNuct+OAMpy5rowjJCimRfqGpEmsPxIuFKba+aVharsARC+4XfXVUUH2dx
	gYscPpuPFv8wO1jMENRuhjemZnHHri3Fnp59/vKxNNQw==
X-Received: by 2002:a17:903:2acb:b0:2c0:b081:84b1 with SMTP id d9443c01a7336-2c2f1dc159cmr22565615ad.10.1781168181253;
        Thu, 11 Jun 2026 01:56:21 -0700 (PDT)
Received: from [192.168.89.2] ([27.232.220.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c2da5b7b2fsm20547105ad.0.2026.06.11.01.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 01:56:20 -0700 (PDT)
Message-ID: <a7f661e5-61ee-42d7-be9e-5569e0f16e28@gmail.com>
Date: Thu, 11 Jun 2026 17:56:17 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 0/4] bonding: support LAG IPsec offload with
 replicated SAs
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
References: <20260520081004.2232091-1-hurryman2212@gmail.com>
 <20260610141843.GI327369@unreal>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260610141843.GI327369@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-298020-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:netdev@vger.kernel.org,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2769670161

Hi,

On 6/10/26 23:18, Leon Romanovsky wrote:
> On Wed, May 20, 2026 at 05:10:00PM +0900, Jihong Min wrote:
>> This RFC adds a bonding model for IPsec/XFRM hardware offload on
>> 802.3ad and balance-xor LAG devices when the transmit hash policy is
>> layer3+4. This is an intentional scope limit rather than a hard limit,
>> as this is the configuration I can test with my gear.
>>
>> The main idea is to leave the existing upstream single-lower-device XFRM
>> offload path for active-backup intentionally untouched, while adding a
>> replicated state model for LAG.
>>
>> For LAG bonds, the bonding driver installs the same XFRM state on every
>> eligible running slave and stores the per-slave hardware handles in
>> bonding-private state. Lower drivers that support this model can then
>> resolve the handle for the concrete lower netdev used by the datapath.
>>
>> LAG IPsec features are user controlled. Newly eligible LAG bonds start
>> with the ESP/XFRM features disabled, but advertise supported mutable
>> features when all running eligible slaves can support them. Users can
>> then opt in with ethtool. Feature enable is propagated to the lower
>> devices and rolled back if a lower device cannot enable the requested
>> features.
>>
>> The series also handles LAG membership and eligibility changes by adding
>> replicated SAs to newly usable slaves, removing the departing lower
>> instance on down/remove, and flushing bond-owned XFRM offload state when
>> the bond leaves the supported mode or hash-policy configuration.
>>
>> This series does not convert any physical NIC driver. A lower driver
>> must explicitly opt in to the replicated-upper-device model before it can
>> use these bond-owned states in its datapath.
>>
>> For example, a driver such as mlx5 would opt in by marking its
>> xfrmdev_ops and by resolving datapath handles through the helper:
>>
>>         static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
>>                 ...
>>                 .xdo_dev_state_lower_handle = NULL,
>>                 .flags = XFRMDEV_OPS_F_LOWER_HANDLE,
>>         };
>>
>>         handle = xfrm_dev_state_lower_handle(x, netdev);
>>         if (!handle)
>>                 goto drop;
>>
>>         sa_entry = (struct mlx5e_ipsec_sa_entry *)handle;
> 
> I’m curious how you replicate and maintain the hardware state across these
> devices. How are you handling the anti-replay window?
> 
> Thanks
> 

The short answer is that the RFC I sent was not complete enough in this
area.

The long answer is:

At that time my preliminary test setup was an Airoha AN7581 board with
two 10G PHYs bonded together. I had ESP hardware offload working by
modifying both airoha_eth and an EIP93 driver that was tied into
airoha_eth in a rather ugly way. For this RFC, I tried to extract only
the generic bonding/XFRM infrastructure and leave out the
Airoha-specific pieces, but that split was not clean enough.

The mlx5 example in the cover letter was not tested. I used it only as
an example because the modified airoha_eth + EIP93 setup was not a good
thing to show as a driver model. Looking back, that was misleading.

After doing more work on this, I agree that the original RFC did not
handle the replay issue well enough. The current version is quite
different. I now have a driver for the SOE (Secure Offload Engine) block
in AN7581, which is the SoC's ESP crypto and packet encap/decap (+
NAT-T) offload engine, linked directly from airoha_eth. With that
version I tested XFRM/strongSwan (IPsec/IKEv2) over the same two 10G PHY
LAG setup, in 802.3ad with layer3+4 hashing, and I can get up to about 5
Gbps.

If I were to write the driver opt-in example again, I would not use only
XFRMDEV_OPS_F_LOWER_HANDLE. That flag only says that the lower driver
resolves the hardware handle through xfrm_dev_state_lower_handle()
instead of using x->xso.offload_handle directly. It does not say
anything about whether the replicated LAG state is safe for sequence and
replay handling.

The opt-in would need to describe those guarantees explicitly, for example:

        static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
                ...
                .xdo_dev_packet_xmit = mlx5e_ipsec_packet_xmit,
                .flags = XFRMDEV_OPS_F_LOWER_HANDLE |
                         XFRMDEV_OPS_F_LAG_SHARED_TX_SEQ |
                         XFRMDEV_OPS_F_LAG_SHARED_RX_REPLAY,
        };

        handle = xfrm_dev_state_lower_handle(x, skb->dev);
        if (!handle)
                goto drop;

        sa_entry = (struct mlx5e_ipsec_sa_entry *)handle;

Here XFRMDEV_OPS_F_LOWER_HANDLE means that the driver uses the
lower-handle resolver in its datapath. XFRMDEV_OPS_F_LAG_SHARED_TX_SEQ
would mean that the driver/hardware can keep the outbound sequence state
correct when an SA is used through a LAG upper device.
XFRMDEV_OPS_F_LAG_SHARED_RX_REPLAY would mean that inbound packets for
the same SA are checked against one valid replay state, so the same
packet cannot be accepted again just because it arrived on another slave.

The exact flag names are only illustrative, but the point is that the
lower-driver opt-in needs to describe the sequence/replay guarantees,
not only the handle lookup mechanism.

I'm currently working on and distributing OpenWrt source with the newer
bonding/XFRM LAG offload work and the Airoha SOE/PPE integration; one
snapshot is this commit, [kernel: add bonding LAG XFRM offload
infrastructure and Airoha
support](https://github.com/hurryman2212/OpenW1700k-test/commit/fbfe8f919f836bb62b3849f803865a4d9b8dc76f),
which carries both the generic bonding/XFRM patches and the
Airoha-specific SOE pieces. I do not think it is ready for the next
submission yet, because some logic that is still only in the Airoha path
needs to be generalized and moved into the bonding/XFRM code, and the
TX/RX sequence and replay protection rules still need to be made
complete. Once that is done, I plan to submit a new version; I have not
decided yet whether that will include the Airoha driver code or only the
generic part.


Sincerely,
Jihong Min

>>
>> Jihong Min (4):
>>   xfrm: add a lower-device offload handle resolver
>>   bonding: replicate XFRM offload state across LAG slaves
>>   bonding: expose user-controlled IPsec features for LAG
>>   bonding: handle replicated IPsec SAs across LAG changes
>>
>>  drivers/net/bonding/bond_main.c    | 855 ++++++++++++++++++++++++++++-
>>  drivers/net/bonding/bond_options.c |  59 +-
>>  include/linux/netdevice.h          |  27 +
>>  include/net/bonding.h              |  29 +-
>>  include/net/xfrm.h                 |  48 +-
>>  net/xfrm/xfrm_state.c              |   1 +
>>  6 files changed, 1000 insertions(+), 19 deletions(-)
>>
>>
>> base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
>> -- 
>> 2.53.0
>>


