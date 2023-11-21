Return-Path: <netdev+bounces-49770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24957F36AF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB57B1C20B61
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989EC59161;
	Tue, 21 Nov 2023 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="nh+BfHI0"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A084A110
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 11:13:15 -0800 (PST)
X-KPN-MessageId: ffad03d6-88a1-11ee-a95f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ffad03d6-88a1-11ee-a95f-005056abbe64;
	Tue, 21 Nov 2023 20:13:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=ljdYkpkWzVVHQf9D1GVF+nu60LCCrweTOGhk6X/ACdI=;
	b=nh+BfHI0W1E9q4ZYVwta6309tAGNsLRhJ0Y0SwWFXUunx4EcsA4IIFrEWVtj06kVZQAykNtnNxcrp
	 dliR+DJEwovOH9uaTNznaYYMAbYaEmq6WYTFegNCQGnJCPhpz8T9QrJDA6YQHkS6aoTKYCWvpMMVMF
	 LDohNp0BlCHJRHGE=
X-KPN-MID: 33|b9UAv2Toq9Ju9tW1YhIWxdY14SsqdOibvIEhfMpX878SCJxZx6CpW7/nFGVCqKR
 JFktEVmhjvXfKzdmJfMhqXd2IGTTFsH+x3yL2Pp4mmmA=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|Ak7Fv6JTBcjWU3cuIuJzlV2XFeePo6zc42uSVBTax8iNl24q39/HLy5aViyLMBx
 CfWl+gyfbKHT8jNHPfVJSCw==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 03b7e6cb-88a2-11ee-a7b1-005056ab7447;
	Tue, 21 Nov 2023 20:13:13 +0100 (CET)
Date: Tue, 21 Nov 2023 20:13:12 +0100
From: Antony Antony <antony@phenome.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
Message-ID: <ZV0BSBzNh3UIqueZ@Antony2201.local>
References: <20231113035219.920136-1-chopps@chopps.org>
 <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVHNI7NaK/KtABIL@gauss3.secunet.de>

On Mon, Nov 13, 2023 at 08:15:47AM +0100, Steffen Klassert via Devel wrote:
> On Sun, Nov 12, 2023 at 10:52:11PM -0500, Christian Hopps wrote:
> > From: Christian Hopps <chopps@labn.net>
> > 
> > This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> > (AggFrag encapsulation) has been standardized in RFC9347.
> > 
> > Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> > 
> > This feature supports demand driven (i.e., non-constant send rate) IP-TFS to
> > take advantage of the AGGFRAG ESP payload encapsulation. This payload type
> > supports aggregation and fragmentation of the inner IP packet stream which in
> > turn yields higher small-packet bandwidth as well as reducing MTU/PMTU issues.
> > Congestion control is unimplementated as the send rate is demand driven rather
> > than constant.
> > 
> > In order to allow loading this fucntionality as a module a set of callbacks
> > xfrm_mode_cbs has been added to xfrm as well.
> 
> I did a multiple days peer review with Chris on this pachset. So my
> concerns are already addressed.
> 
> Further reviews are welcome! This is a bigger change and it would
> be nice if more people could look at it.

I'd like to pose a basic question to understand the new IP-TFS config 
options for an SA.

When configuring IP-TFS parameters on an SA, are all parameters actively 
used by that SA? or does their usage vary based on the direction of the 
traffic?
Currently, each IP-TFS SA includes both init-delay and drop-time parameters. 
I would like to understand whether both parameters are necessary for every SA.

ip xfrm state

src 2001:db8:1:2::45 dst 2001:db8:1:2::23
proto esp spi 0x32af1f6d reqid 16389 mode iptfs
replay-window 0 flag af-unspec esn
aead rfc4106(gcm(aes)) 0x0... 128
anti-replay esn context:
seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0x0
replay_window 128, bitmap-length 4
00000000 00000000 00000000 00000000
iptfs-opts pkt-size 0 max-queue-size 1048576 drop-time 1000000 reorder-window 3 init-delay 0

Chris, would like to you share which of iptfs-opts are for input and which 
are for output?

My current understanding suggests that, depending on the traffic direction, 
onlysome of these parameters might be in active use for each SA. If this is 
indeed the case, I propose we discuss the possibility of refining our 
configuration approach. Could we consider making these parameters mutually 
exclusive and dependent on the traffic direction? Furthermore, given that 
the xfrm community has previously discussed the idea of adding direction to 
the SA — a concept also used in hardware offload scenarios — why not explore 
adding direction to the SA?

We currently have DIR with offload.

ip xfrm state { add | update } ... offload [ crypto|packet ] dev DEV dir DIR

Implementing direction could imply that an IP-TFS SA would require only fewer parameters
– init-delay or drop-time, depending on the specified direction. This would 
make ip x s output simple and comprehensible, thereby reducing potential 
confusion. Also avoid confusing when creating state say input, why add 
output parameters to an input SA?"

