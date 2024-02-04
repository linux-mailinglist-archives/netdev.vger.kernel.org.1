Return-Path: <netdev+bounces-68893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C711848C2B
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 09:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4582813BA
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449E1400A;
	Sun,  4 Feb 2024 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRCW9zPT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3914000
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035499; cv=none; b=m5fGIHNSxUy/pAcFhw+oO2d0LFE0SHTK26EX5r5k+1f6SXRQHQL/RnAeaYDJcb+cukbzar00rjnA5wH91lu3bYSmOfG6cTOYtR22gDA361Uo+Egv75Ata070wJ5So8ULnafso8gs1HrZFHiZGbvKqQ0qctyR4e9xkZHNXQCKJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035499; c=relaxed/simple;
	bh=r1A/v1eHjPiuL7AiKqjoHYb4dmV50y2kBpOqXR4AzbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKdM0kkRh7Hw8X6M3c2dln2sR/gdjYp5oAiFtfzXBOSr60RdPv4+ViTD+CbEvF8gIn3Yl3nXtQqyGEPTtLvACj9xMkPKPDO0sLPTaEv0Cw0cTiIraHOngrQVms2FCa1eQBLy1G6mAd0au0WXD1bsO+G8lZZQCf010SiYQk84R2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRCW9zPT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d8ef977f1eso25509935ad.0
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707035497; x=1707640297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5rjl3F5UK/aWtPDYHKg22suQ7v7gmFu3q/2eXmMt0M=;
        b=HRCW9zPT5FQLPjtv4sLLLpm2AasSOjtSZnifMfCqxgoIngQUOIVNfvfIO9/aqW4xsM
         LEzt8sQQ0OcqW2rBMCJhr0c/yRh97lwi2k6Brw7lKDHbkdP7eNZNGKvUlcqTSr6j5FT1
         0p/yBae1uaLqdOAFi46+LJnff+3U0fJIoQYDxNRGHM1j86hDAY3P0GuJ3PIkl1h3sMMA
         G5k0HbjAMyB1PsgGdtdIx1gOsPVF5chuFoKv7RVSlRc/rwkRixlRTdmXZI1BcUqYwXt9
         o/fBmeNh6RRG0Bf1epa30FOKu6RHKXUfMELYC0GQYHAvpffAJ/5YVuuf4hIwW6TDCiek
         lhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707035497; x=1707640297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5rjl3F5UK/aWtPDYHKg22suQ7v7gmFu3q/2eXmMt0M=;
        b=NDfD9HKfC30Imq7KdxCfpfNJXIfESEHyU5EJnVrh1B7MA2LDlDL2I/wcw4hK71mwpU
         fTOI/qT7m7yRcd56CiHYaVou9TSWW/BI7cxO7Tmv1a7I0vQIOuua/DRq301b2I9xc7az
         DvcaT1Oio1zF8bsImHTuolFYQnPzM5NtO5v/tBjLc2UkjcoTeOrKwLL/N80GsPiXb6Zs
         QvrrAYkz1NX5/HhITh4xFdXO84p5SVcIluLmuKH7l/V07rjPNR3+GJa0O/zs9ST32ApQ
         d7XAW+6Jgje2IZqAzXkS+80Uir4UFseL9a0xLGYEJ4/g4RBp8ElMXRKQc7WkQ9DSDdYM
         iztw==
X-Gm-Message-State: AOJu0YyhrsGBhWNriL12KCAZYb3VoNIXZOYqzUYjRSnEh3kRsNazvBij
	AGH8qK6yRsKR9F02/KamAOReRzphXrjs/UAE5IhKJwcYZMkzBYOJ
X-Google-Smtp-Source: AGHT+IFfGzse11U+c+cfAqALdf82n098u6Ym2j0H3S8Qpnv/AABeYcMxZQYfDjLBFoBu7cY+PJ/ZEw==
X-Received: by 2002:a17:902:8685:b0:1d8:b2f4:28ce with SMTP id g5-20020a170902868500b001d8b2f428cemr10717920plo.42.1707035496768;
        Sun, 04 Feb 2024 00:31:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjK5nOs8YO0X8I8xt0ibipA001+8y5NJBzEnjFs+VzmgAmiaBRzDwPMyCNARAqHVbOJfPxoZT4ik/WBJfSvR4fM1/nfpIB+A2J12J0Wh0+xRwR3kuU11A237leM78g+QVkWAJ7vbPqmho4i/zGck/Z4PRI/qsNpw8Hss8rZUNEDFo25yqKwBo2t2q0/ZqnesS6HInwpFkds+HWIqDQChovvf4ERqKJTePiVrnuds96dSI=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id li7-20020a170903294700b001d71729ec9csm4205362plb.188.2024.02.04.00.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 00:31:35 -0800 (PST)
Date: Sun, 4 Feb 2024 16:31:31 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <j.vosburgh@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCHv3 net-next 4/4] selftests: bonding: use slowwait instead
 of hard code sleep
Message-ID: <Zb9LYwfRLsi5VucO@Laptop-X1>
References: <20240202023754.932930-1-liuhangbin@gmail.com>
 <20240202023754.932930-5-liuhangbin@gmail.com>
 <20240203094151.5347fba8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203094151.5347fba8@kernel.org>

On Sat, Feb 03, 2024 at 09:41:51AM -0800, Jakub Kicinski wrote:
> On Fri,  2 Feb 2024 10:37:54 +0800 Hangbin Liu wrote:
> > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> > index b609fb6231f4..acd3ebed3e20 100755
> > --- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> > +++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
> > @@ -58,7 +58,7 @@ macvlan_over_bond()
> >  	ip -n ${m2_ns} addr add ${m2_ip4}/24 dev macv0
> >  	ip -n ${m2_ns} addr add ${m2_ip6}/24 dev macv0
> >  
> > -	sleep 2
> > +	slowwait 2 ip netns exec ${c_ns} ping ${s_ip4} -c 1 -W 0.1 &> /dev/null
> >  
> >  	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
> >  	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
> > @@ -69,8 +69,7 @@ macvlan_over_bond()
> >  	check_connection "${m1_ns}" "${m2_ip4}" "IPv4: macvlan_1->macvlan_2"
> >  	check_connection "${m1_ns}" "${m2_ip6}" "IPv6: macvlan_1->macvlan_2"
> >  
> > -
> > -	sleep 5
> > +	slowwait 5 ip netns exec ${s_ns} ping ${c_ip4} -c 1 -W 0.1 &> /dev/null
> >  
> >  	check_connection "${s_ns}" "${c_ip4}" "IPv4: server->client"
> >  	check_connection "${s_ns}" "${c_ip6}" "IPv6: server->client"
> 
> This makes the bond_macvlan.sh test flaky:
> 
> https://netdev.bots.linux.dev/contest.html?test=bond-macvlan-sh

Hi Jakub,

Thanks for the report.

> 
> I repro'd it and the ping in check_connection() fails - neigh resolution
> fails. I guess we need to insert more of the slowwaits?
> 
> Reverting this patch from the pending patch tree fixes it. The runner
> has no KVM support, and runs a VM with 64 CPUs. If I lower the number
> of CPUs to 4 the test passes. I added the note that some flakiness may
> be caused by high CPU count:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#tips

Sadly, I can't reproduce it with an Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz,
which has 20 Cores and 40 Processors. From your logs[1][2][3], all the tests
failed when ping from client to macvlan_2. e.g.

# TEST: balance-tlb: IPv4: client->macvlan_1                          [ OK ]
# TEST: balance-tlb: IPv6: client->macvlan_1                          [ OK ]
# TEST: balance-tlb: IPv4: client->macvlan_2                          [FAIL]
# ping failed
# TEST: balance-tlb: IPv6: client->macvlan_2                          [ OK ]

Or

# TEST: balance-alb: IPv4: client->macvlan_1                          [ OK ]
# TEST: balance-alb: IPv6: client->macvlan_1                          [ OK ]
# TEST: balance-alb: IPv4: client->macvlan_2                          [FAIL]
# ping failed
# TEST: balance-alb: IPv6: client->macvlan_2                          [ OK ]

Let us checking the client to macvlan2 connection via slowwait and see
if it works.

[1] https://netdev-2.bots.linux.dev/vmksft-bonding/results/449541/2-bond-macvlan-sh/stdout
[2] https://netdev-2.bots.linux.dev/vmksft-bonding/results/449361/4-bond-macvlan-sh/stdout
[3] https://netdev-2.bots.linux.dev/vmksft-bonding/results/449001/4-bond-macvlan-sh/stdout

Thanks
Hangbin

