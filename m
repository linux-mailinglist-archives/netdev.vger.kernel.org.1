Return-Path: <netdev+bounces-166786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A98A374EB
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3BC188446E
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315C1990A2;
	Sun, 16 Feb 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oQdo1u38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04678F45
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718615; cv=none; b=KWC8zbH517f91+mj0qqxca6J+eCqo16pfVD8AmtbdYFlVxK8Q9pbPCrx1/xF/65G+0boB9IxFeQlDrGmipGGYdziNBKu6LdYLHdX5NlLsqONlA0BJp49HvrIAahZhLs59GPpgAtvs++cQAMUNfKjwgSAumSJeuaJW6An6WOCqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718615; c=relaxed/simple;
	bh=7ExF0LBX/qghoeSiQHKm/aN/R2QQJsGgdHWO2KKmWCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apRG/sJ11N+7VPf+68hbj6CxcgtiexwEiTYEimTDWZ/EEJOl2qpnh1HNvQCB/rCQ/6T8DumEmCPPjCrvMBr84jhSxumnG0p4H10GqVai5OKsttL35X0ZsiRAMXmI1fY9NjLd4C/zlIuWg3XyAQCLyGP1TuuA96Uo+KCkiJSR5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oQdo1u38; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb8f586d68so64502666b.0
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739718612; x=1740323412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij4A6kvxWu+Hg4KiMOQry5de3PPhSfmpkY0YNQ7zBMM=;
        b=oQdo1u387NymAJYEPFTFYgxQwsLCeJLz/b7nUvwmCAQv65IAFELr9LLRIy2luVG2I9
         QucXr6yPHgNRD0ukK/bmtGLNSsMLBxNXJhduD8YZTGXghUSqmSRzVuHwVf1YAR6X36sy
         pUX/qwjTEllTzPaJsZ+WTjA5f5/GhoM0nq2KcaPd/BVLJa6vDzdE/fwsyA/WLVB24Vy4
         0U3w6S6BWlTiPvo8BsO2ZqysR1ViS8PRVAPxpR5UqxZjoc+JWT8ZVkkS/3pS4x/AJduT
         58twXIXsO78FBTGuzqMRYHUnPqhUG8h8NiqWyVqZlR6iSEjtsHJBAfU0qeDs5vgExOoq
         zZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739718612; x=1740323412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij4A6kvxWu+Hg4KiMOQry5de3PPhSfmpkY0YNQ7zBMM=;
        b=cQtU8Lra5nyjygwK5WWJ0aYTnQJBx26otMODzLPgyKFVx5e7Q5XX5MFqoDj4kKxYjU
         qjNq6s0oVX6T78OCguzzYDRazZOe0EDWUkRQzsKar1CYIYvRfF8b5jiSB5LUjpM4/xY7
         NYgat6Zl4UerBdNg70kpt9Vty1kssjhwnIrNM0NywLbSCyzLkackONxb4pl5EwPCb2Ql
         euyjiII02q6f4taVqi+WgfT7fuOr+SVyhTOeclfwKKi4d2rOpjOSggptJMQWIufGXhc+
         MT0ghB+NmoYmNmddy/185CZ5ICsOu1yLQHKM6mNZ3BkDnwUV2FFnH6Rs5WF2zESvdv3x
         Cktg==
X-Forwarded-Encrypted: i=1; AJvYcCWgtVN/Mo5iut40OQ3YJz0p5RYl55hXIUXM9egtlPkdLo04SdbFsvu4KIyWwLfrEEGjhiFgctU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ginDXhiXMa+7g7HWWhX8i/TW2qT0SYJyxYbI4WlA7iHEeWeT
	MPBWBIDvqqvMkSkiLz39rSF4IPyLfBZ4i6Q9Dox+B8h1GXBHcJ6k0QQdS3yidC8=
X-Gm-Gg: ASbGncvGglJPoC2js8LWsLg/2A3EhJ8ZQYAh0ae1PLuZNBGJwlaRCay7vNokd3VhCJX
	56uhZ6ploly7wCMdiH39HQW0B7MuEbSP93YBuMs9U00ze6WIK+UjUvg/Ji/Plz7ku32Cupgzw9C
	Fa4MmbN8xrxrFbNYEXd4oOz3aDO5CNzmkxOLIvSEZiSmScbPXTNuhAGpsF8P3fYoqwLkKLEpkog
	IfkaKmwufYlj9Es27sqZijg4oc7SuQQnoYuPSaVoDPhN/Tb3BhEyaivTzj7m/Blzdfu25IjuMuv
	jMVZKAev2bAqIudvvb4nrN6ryNjnZUpS7vQn4sc4rJl/Vro=
X-Google-Smtp-Source: AGHT+IFQh0rL/Bg1EuwMpta4dBVvkkJWxoGM82Qgv8oKgCY6nes2v7mgUC/hhvgX4IM8hChl5iYP3Q==
X-Received: by 2002:a17:906:6a03:b0:ab7:1816:e8a with SMTP id a640c23a62f3a-abb70d9e25cmr724855366b.36.1739718611596;
        Sun, 16 Feb 2025 07:10:11 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb94e4d0adsm97434866b.56.2025.02.16.07.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 07:10:11 -0800 (PST)
Message-ID: <507f8250-c240-43a2-beee-a46c9d626916@blackwall.org>
Date: Sun, 16 Feb 2025 17:10:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] vxlan: Join / leave MC group when
 reconfigured
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Roopa Prabhu <roopa@nvidia.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
References: <cover.1739548836.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <cover.1739548836.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 18:18, Petr Machata wrote:
> When a vxlan netdevice is brought up, if its default remote is a multicast
> address, the device joins the indicated group.
> 
> Therefore when the multicast remote address changes, the device should
> leave the current group and subscribe to the new one. Similarly when the
> interface used for endpoint communication is changed in a situation when
> multicast remote is configured. This is currently not done.
> 
> Both vxlan_igmp_join() and vxlan_igmp_leave() can however fail. So it is
> possible that with such fix, the netdevice will end up in an inconsistent
> situation where the old group is not joined anymore, but joining the
> new group fails. Should we join the new group first, and leave the old one
> second, we might end up in the opposite situation, where both groups are
> joined. Undoing any of this during rollback is going to be similarly
> problematic.
> 
> One solution would be to just forbid the change when the netdevice is up.
> However in vnifilter mode, changing the group address is allowed, and these
> problems are simply ignored (see vxlan_vni_update_group()):
> 
>  # ip link add name br up type bridge vlan_filtering 1
>  # ip link add vx1 up master br type vxlan external vnifilter local 192.0.2.1 dev lo dstport 4789
>  # bridge vni add dev vx1 vni 200 group 224.0.0.1
>  # tcpdump -i lo &
>  # bridge vni add dev vx1 vni 200 group 224.0.0.2
>  18:55:46.523438 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
>  18:55:46.943447 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
>  # bridge vni
>  dev               vni                group/remote
>  vx1               200                224.0.0.2
> 
> Having two different modes of operation for conceptually the same interface
> is silly, so in this patchset, just do what the vnifilter code does and
> deal with the errors by crossing fingers real hard.
> 
> v2:
> - Patch #1:
>     - New patch.
> - Patch #2:
>     - Adjust the code so that it is closer to vnifilter.
>       Expand the commit message the explain in detail
>       which aspects of vnifilter code were emulated.
> 
> Petr Machata (5):
>   vxlan: Drop 'changelink' parameter from vxlan_dev_configure()
>   vxlan: Join / leave MC group after remote changes
>   selftests: forwarding: lib: Move require_command to net, generalize
>   selftests: test_vxlan_fdb_changelink: Convert to lib.sh
>   selftests: test_vxlan_fdb_changelink: Add a test for MC remote change
> 
>  drivers/net/vxlan/vxlan_core.c                |  24 +++-
>  tools/testing/selftests/net/forwarding/lib.sh |  10 --
>  tools/testing/selftests/net/lib.sh            |  19 +++
>  .../net/test_vxlan_fdb_changelink.sh          | 111 ++++++++++++++++--
>  4 files changed, 136 insertions(+), 28 deletions(-)
> 

For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

