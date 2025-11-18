Return-Path: <netdev+bounces-239386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565AC67A58
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF5DB351977
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 06:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CD82641CA;
	Tue, 18 Nov 2025 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2GTRwhP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4454C98
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763445805; cv=none; b=ZReefn5o4PYO0tOShcPsRMiGKxYxkANaaNZY9OLZDxOWRH9IX1iw9jt2ZCCUYqAjPofUtoWsXBWxOycIDXgP6ds3+ckc6wHjdNW1ML4vBerXbrjqvmiab09q3fAdRuBDGjOA0vafc3veRrqnuv1qkKEwhA4lWzkWjs2kygID51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763445805; c=relaxed/simple;
	bh=92rPwNkA0wp1/CPkIGi3GfljIJFTaGsXO1IEOosvvgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTGP7UYgCKcAJatgFtnSgMezpaP/7Wesc5jTPAII0InVIrMm9hsBzeY1vFbzLkTpwGltTwlkSm5/YFM6NRpFR2VEBQDt2gqirFXuA6J9ukCBVLDFR7Y8Bd0qIqz+/a1yqWsQSXJDu6kPGjbDkkhDbtkzI2KWRoHxJHJxxytVNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2GTRwhP; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29845b06dd2so58820745ad.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 22:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763445803; x=1764050603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DmOTsXlYB7MqzlZh37ZZ/xq7r16Vb6eepjVqfs+L0Uk=;
        b=W2GTRwhPAjNfIsQ7bWBroOabHGrkxCnq2ASOf1H0gmpPYAe1IhntD5ClP6Nhh96Moj
         yEy6SFcUgHM2gjVHF3+omGX8RZbjw7Xa1vyx9Tqdw6isiFHzhkSO6aMFy9G3dvlO/h0e
         eZu+CWHhvPBqbtJk+exS11j2cGzOJnRkElVJOiwH5KQnhbLu+FUHhIazbiJYOhTGphOG
         4VPmUq3nIe5HztAIGLdohFsZDuDRDz4CUDHjqQ4VopRJ3Pc5WTMs+j2IxFD7T0s2tnAj
         wEuq/zEDpbOH3A8qJrvFsvYhUeWWOnUcHHHAr1tD4jD0bBIgUcZDsF93cLO5GVg+CvMj
         EYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763445803; x=1764050603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmOTsXlYB7MqzlZh37ZZ/xq7r16Vb6eepjVqfs+L0Uk=;
        b=kSxVsHsKcjnLmHWMSXJpBscf0jJfpvqCP06HPbaXQjPrebp1PaL1ba/+f6kTsEF9LT
         rcR8eaPuogu4RR4pDe6IR4Z5wylEfB/FN0/c9RPRgc4bfSb2eAsn8K2cg0v4A2l7IlMk
         ZioMng9yMme0b/gMvIsIPDgFpftSBLgF4bJQbEXTn/HGex4B8qlAXYBRSoYKumvPTsk3
         PcPhWYAHdEl/e/wZJblP9N+rMARfA3LeQVehPYwP3C2JNaHH46vgBlvZCgtVpRLHaDbk
         PcUdF9cX1BRgTUBzaJ0Rr9Yl+0kVWBKQz4OJctZa9au+ogNaD4lZZzXxhjQ4Xe4tXC+u
         vL0Q==
X-Gm-Message-State: AOJu0YwKZ0gaLKnGOLqCVapaHCKOcUXqlDZU91zxTxbMAHOEpQYx+X73
	QzrC/G+Oo1tna/Ltwhmt8bgx9uWaQ2XLyV5Evniq0YRLx2QvdJ1o+Uiq
X-Gm-Gg: ASbGncs+FbLh5LgqCHpH6oYfm026ZYrvv+shJKZ8Xnje+3WlB0NI5U2w32Jyp4C6VxD
	0uQfOQL8vyM/X0QhpnMygRRTThiiNid9TC6UryWGSoZJjXdrmkMx5/qLmW65BvoaqxL2ZuL7soW
	IP0QsPWnoA9irWIA4pJoW4wDtTViH7aRFJh8GznWX6jNIhX5dC6oMQaVnGWCb86LQFsgjf5qCYD
	jRXlcTtjkKLkpKleqToyDFnz9epDWyl27X9rOM36FbGO9pt0/Pb3z196dA2RKPnHsPfPggZ4P7f
	CwZRgCErkA06SLh/vEihyncS1LjE2GSCEzgvIpjm9x/hPJ9jgRZWR1CfU07b/hmcDrUjg31YhoJ
	7dRikgftN6qLboq+kkzb3tyZjvhBO0YMVueYFU0iVE4NbWy+NLgn6v+qeUOXhzK8ZS+3xo2BQiJ
	muRMZED96cl5LWP4+PKecHb5KVig==
X-Google-Smtp-Source: AGHT+IGHUXnOuD9R0UxFil9hakpET24GotmTi34Iuyulno4NPRLkJHjKqG0ucMiG1w2XUeb6BblN1w==
X-Received: by 2002:a17:903:120b:b0:295:613f:3d6a with SMTP id d9443c01a7336-2986a72ca49mr173170525ad.29.1763445802779;
        Mon, 17 Nov 2025 22:03:22 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d17sm160149605ad.72.2025.11.17.22.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 22:03:21 -0800 (PST)
Date: Tue, 18 Nov 2025 06:03:17 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <aRwMJWzy6f1OEUdy@fedora>
References: <20251114082014.750edfad@kernel.org>
 <aRrbvkW1_TnCNH-y@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRrbvkW1_TnCNH-y@fedora>

On Mon, Nov 17, 2025 at 08:24:35AM +0000, Hangbin Liu wrote:
> > If it's ipvlan that fails rather than macvlan there is a bunch of
> > otherhost drops:
> > 
> > # 17: ipvlan0@if15: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
> > #     link/ether 00:0a:0b:0c:0d:01 brd ff:ff:ff:ff:ff:ff link-netns s-8BLcCn
> > #     RX:  bytes packets errors dropped  missed   mcast           
> > #            702      10      0       0       0       3 
> > #     RX errors:  length    crc   frame    fifo overrun otherhost
> > #                      0      0       0       0       0         4
> 
> Hmm, this one is suspicious. I can reproduce the ping fail on local.
> But no "otherhost" issue. I will check the failure recently.

This looks like a time-sensitive issue, with

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
index c4711272fe45..947c85ec2cbb 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
@@ -30,6 +30,7 @@ check_connection()
        local message=${3}
        RET=0

+       sleep 1
        ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
        check_err $? "ping failed"
        log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"

I run the test 100 times (vng with 4 cpus) and not able to reproduce it anymore.
That maybe why debug kernel works good.

I need some time to figure out what configure affect the issue.

Thanks
Hangbin

