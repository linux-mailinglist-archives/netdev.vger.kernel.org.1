Return-Path: <netdev+bounces-148924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDDB9E3747
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F0E165A5C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFE1ADFF1;
	Wed,  4 Dec 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b="EzytqyZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5781AB528
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307152; cv=none; b=rNBZ2ZJ/TE+eW+qOm3KUuryd+CEQo4FClfNP+TWuHVDp/pPgLc5qfK0XBnj9ARML0AqMncEr4cpDYjXgw/XGiSx6C8BzuZTX9MUIukd1SWlpWG/uH7NuZkUviJa4ilIoj1od61wqgczNNGS8BElgWQwUv+AVpshjOj5ZpdBCVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307152; c=relaxed/simple;
	bh=bDcBWgVILMB12NHWB4fcs1W4araBsBKWumSB2kQnUP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1LsZEdk6xvHxJB9nuAdo727z2hpZCfFNsPp55J1o9YjMsZ9gLhm8TihT75JyZgDDxSiF7RZHGuLzL208rfXOzDUQsdShSAvMdbG1t+FlmEXMcYqvHhRo73K3dVWCprM/0d23aZHyogdZBv/kEtEd1kZD+UERH5Rmh1jKDuc4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com; spf=none smtp.mailfrom=andrewstrohman.com; dkim=pass (2048-bit key) header.d=andrewstrohman-com.20230601.gappssmtp.com header.i=@andrewstrohman-com.20230601.gappssmtp.com header.b=EzytqyZx; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=andrewstrohman.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=andrewstrohman.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef402e4589so63795807b3.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 02:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1733307149; x=1733911949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8yJtp0VtRWCyGUDMUPSKyYrOKeXIERy5/6YkYGZGIw=;
        b=EzytqyZxKNKvA5/TqCooxuF2jLO+c5FGJAlsaYPPTuSi8ZC68Q26O5WRzENi6ZIOz1
         qgCYcZMKs1BbKetL0drec+uD6DyIDMyeLda9n6pseBqHz4ILj8DpDVKMnoRLBpB0uMBj
         tA6FbPb+FahgWhkDVFGsS7kqQVaoboyPDjZeLmtwuE+9BLN03zXy2S7XfV16hIsDU8QF
         FObGw7bQuSPuQlOH6rhV6F5sIH6UCQ56VK7+awQ/ftuDAEXu/ifqENySMtt3T7Sl6uyp
         uBOTD6YqwZsykpshi4ZZYcYfuuz9wkzTr3Qo19wmImXonJOGeFVGVKHLPl0WvqX6zvN8
         fNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307149; x=1733911949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8yJtp0VtRWCyGUDMUPSKyYrOKeXIERy5/6YkYGZGIw=;
        b=l12iaoid4X0rRH+3SNnIRpSPgnjcfiBI1QqiR0043AKuERKxJgE1ZhmuWc25DnA7Uk
         TAEKdzWAjvZOEsfNjd2yC6GBpCoy1MpT43luqFBLevA0I4y8ruTBrlLaND/iRHlFAdUG
         bLY3c7WTmrn/gZmov5OA9NOYdNnkKCZaQKAfl2HgltLYGAo32IHHUQnk0SmAfNcDJg7v
         caBJ7x7R99loZlTUiXyEii8UYjMEEznAiNUHkJEAEjznmEURUux4laPbkdhyP9G9mq+t
         y32Eo0bfXF1dNHwekrxsIsfsTmPLVXwfolYQSfUc+Guuvuc/DHZnjufJQJLDTA4UmdWH
         Z9hA==
X-Forwarded-Encrypted: i=1; AJvYcCWPVLzwzINdkzXVX62+e8NesPHCEqbSBEQyxb4jbUIMdK2g7ZdP3tz63dDSlL6UbMg06mUc21o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8DrF1qQuhesRXWCc0bdC7MalvVNyYuOT6ck4svITMU8t4+nm
	/iT6nuArnYVGqX6xZ/7uQhmBX3g/TJtZ1X5Qa0XwHsazKUVY82+OaWZutfF0KTjbgzjj2/ZeEgo
	17bJOEukAC+5s3YGiYrWizrD0xw5SNhpTrbBh1A==
X-Gm-Gg: ASbGncveSCXidZ+FoeW+V9n/R/5ywPsMHsdTT4kjjg4lBM6LfuM8KRvflwqGiJ9Evzo
	7IQC2sNl70ii+o/8GfPKEtNA6Ua0GAmg=
X-Google-Smtp-Source: AGHT+IFiZwav0lkXcdEoC0k0swq2tYz4RZsKxcJnENpHGhhnbUCXatljeleEVM5PesTsKopimNNDdHD+hwBm2MoI2HY=
X-Received: by 2002:a05:690c:46c7:b0:6ef:69b2:eac with SMTP id
 00721157ae682-6eface0164dmr68389077b3.4.1733307149315; Wed, 04 Dec 2024
 02:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130000802.2822146-1-andrew@andrewstrohman.com>
 <Z0s3pDGGE0zXq0UE@penguin> <CAA8ajJmn-jWTweDMO48y7Dtk3XPEhnH0QbFj5J5RH4KgXog4ZQ@mail.gmail.com>
 <20241202100635.hkowskequgsrqqkf@skbuf> <CAA8ajJkPzpGRXO6tX5CkgX7DjGwR6bPyT4AXjZ0z8kXBk8Vr_g@mail.gmail.com>
 <20241204084817.g7tort3v3gwdzeic@skbuf>
In-Reply-To: <20241204084817.g7tort3v3gwdzeic@skbuf>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Wed, 4 Dec 2024 02:12:18 -0800
Message-ID: <CAA8ajJnRPB=KRcDpQiAJww3Apv6ZGqWaAg5stSjOE99BOmkCjg@mail.gmail.com>
Subject: Re: [PATCH net-next] bridge: Make the FDB consider inner tag for Q-in-Q
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, UNGLinuxDriver@microchip.com, 
	Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Roopa Prabhu <roopa@nvidia.com>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> I didn't say "tagged". I just said "not PVID". There are 2 independent
> bridge VLAN attributes: "pvid" and [egress-]"untagged". I am suggesting
> that packets in VID 3, 4, 5 all exit the 802.1ad bridge untagged, but
> every bridge port has a unique PVID from this range.
>
> bridge vlan add dev port1 vid 3 pvid untagged
> bridge vlan add dev port1 vid 4 untagged
> bridge vlan add dev port1 vid 5 untagged
>
> bridge vlan add dev port1 vid 3 untagged
> bridge vlan add dev port1 vid 4 pvid untagged
> bridge vlan add dev port1 vid 5 untagged
>
> bridge vlan add dev port1 vid 3 untagged
> bridge vlan add dev port1 vid 4 untagged
> bridge vlan add dev port1 vid 5 pvid untagged

Thanks for the clarification. I think you meant to have the second
set of three commands affect port2 and the third set of three
commands affect port3. Please let me know if I'm wrong
about this.

I gave this a try:

root@OpenWrt:~# bridge vlan show
port              vlan-id
lan1              3 PVID Egress Untagged
                  4 Egress Untagged
                  5 Egress Untagged
lan2              3 Egress Untagged
                  4 PVID Egress Untagged
                  5 Egress Untagged
lan3              3 Egress Untagged
                  4 Egress Untagged
                  5 PVID Egress Untagged
root@OpenWrt:~# bridge fdb show dynamic
f4:a4:54:80:93:2f dev lan1 vlan 3 master br-lan
e0:3f:49:47:9a:38 dev lan2 vlan 4 master br-lan
f4:a4:54:81:7a:90 dev lan3 vlan 5 master br-lan

Like you said, this has a FDB per port. But I think
I need to have a FDB per inner/outer VLAN combination.

Connectiving works as expected in the above example,
but only because of unknown-unicast flood, which of course,
is suboptimal. The switch is acting like a hub.

For example, ever time the host behind lan1 sends a frame
to the host behind lan2, the bridge is not able to find an FDB
entry for the VID corresponding to PVID of lan1 and the MAC
of the host behind lan2. The only FDB entry for the MAC
corresponding to the host behind lan2 is associated with
the VID corresponding to the PVID of lan2 (which is a
different VID than what the packet arrived on).
Hence, there is constant unicast flood.

I also don't think that this solves the issue for
https://docs.google.com/drawings/d/1FybJP3UyCPxVQRGxAqGztO4Qc5mgXclV4m-QEyfUFQ8
. If you like, I'm happy to explain why. But before I do, I want to
make sure we are on the same page before going further.

Thanks,

Andy

