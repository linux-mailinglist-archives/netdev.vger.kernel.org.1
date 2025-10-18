Return-Path: <netdev+bounces-230669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ED5BECCDA
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 11:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A57834E1FB5
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 09:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3F227A130;
	Sat, 18 Oct 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQJ/gup4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E432944F
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781179; cv=none; b=pPnl0RtqpjkK9zvykEPYxoKsIDGdz9xcYNxuoerswBg2tM0E0wlZ3cWn/tYaSqDni6tEpamZG87cy5W9sRRQODOqzprwaeFlYRcUQrJWJ2GS9cbr6F4SRJxkBRm47YSDI+JVeUNDCPXJPWTLO+Hw1JxtX9gmc8UmBVcFJXZvEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781179; c=relaxed/simple;
	bh=Y45xI99lNq3bg0jwaIprFYNlGwqcmi0LDhG9j9uVIfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3y8w+R1AqSzipDncdRcc0Olh2T0+1SoUS5NJqadacwlaMSKKt/K+stApSvgBsyYewIOSrGKP7fPmmHPj1ZMgORH3MdGag+mteZPVWecrcSNSYGbnYWLhllBy1uiS5IvU5Qt+aWyAOmsK+rzC5ewkW9GHaltBYhBsDLn1qj2Fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQJ/gup4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7810289cd4bso2641738b3a.2
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760781178; x=1761385978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDggDaVozKMDJ3kUVYug72mUZBMi1Sh/R7yLQU2yJos=;
        b=gQJ/gup4fIzOsvECYg9XQJPn12AJ4F7Vh0CFnplJnb/24uhmoA9cpETsFxw84EFFIE
         JDQHY0GPTtqEWIoa90HWlgSjeba/LSs9a2CJM9/8Y9P6s+9HiLiL6Ojc3WD4a15j6jxe
         2qZ7fbDiAbiCdCfjfXs8a4wWnV04AzHcHPc70njQNgg6GXmU3EbxknSSWj7gTyqgzhlU
         kNSOnkWDxqSvXzRWDCHFyIUmNXyGONeII21ppbfLdDki3UKWMJuwZMVKJn0KICuyIk39
         YVKqs4BWGUf1jZmn17f5FkhNAFn14f77nf6Ee5y3V2KYjVhpBC5sVRlUmR7/jYMU7cO4
         XALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781178; x=1761385978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDggDaVozKMDJ3kUVYug72mUZBMi1Sh/R7yLQU2yJos=;
        b=lmdpTJEO12CYsZUD5r4q4FMc8ZKa9vM5OacQ1LOiZ/qjC0Ui/MFdWo6uAf10Z809Pt
         2Qo2Xpms2igvNg1j7eQGgAEeY25txGJvv1PvNa+sSJft73iE9KvIfwXfDNzetcvZGYG/
         9RhucTvKlRSbPMWpi4JN+e8DS+QzqjGBYjNSQx5+V0aE69/xEv3uGEP9+LziXszL78kJ
         k4r2Yqq54BacW7hoHXoDGg7Hr70uDS7kusWFaSzqPeNC+U0G1nE6v9ooEWcvTbLI+BYV
         iNeB2nYLhyc7+AkeDjVWCuN4sbql+SsihoPAQXE0Mk/V+oe0IE0eFS9rtyDHl7mEj2c7
         BU5g==
X-Forwarded-Encrypted: i=1; AJvYcCWp0UYtJdvXqyR9J178rGtmUTO2XA2H8+xkLrzrmsV9hdIFnw7XCv4HiNUqz6XJZCjx7vyaoIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6f4SO1FTSxxYuNbIb6CCdFfzLY69K/+1Hj30l/clTc0die3OW
	+kvmr+JgCOq59BJt9xVzQuq022NV/ZkDIUTEDJv3YRU5VI5J0UbH+Eir
X-Gm-Gg: ASbGnctdq60hMeG/kxVoY0c1DIwWydn8MZBrzLVK4YbjRFERulH9GUeP0X2+tsKEpJ5
	dVkFSDU6JR6V1unM1ueVUqLTIqZs9i9bWDwZAK4n6m1Kyc35q6qepPmY9OWHVac10L0+9dSqCUH
	98Vt033cEV9ATr++Hois+EzFi4OtL1ALrRDjTJ9HlNVi2QNBpvYPRJaqmio47OL9estt7El6ppG
	VwX1GrbSGUolgWVgHrT6QNBJOCmCCdiO+llksvmP5bLowzMWqVbpAXxQADn/f7dfTgT+O/eLASK
	psUj7ZcLX5FY53+N2QPer96r7XS5WYbVYbFuMj42QmRy1r3nm+qbEv+7ZzcfU8Xlgrij3a6zRcU
	sHUyDg2JFeOKm0ifKjWzNBoH2vHLZ49ygiExId1p5FB5VM+DhdAMdk5TAOvVP2LF/AlbPEf8kOr
	9Fd6AP
X-Google-Smtp-Source: AGHT+IHjT3vtmC4Zp9pVe+m8KhsOPQzDkwDC4erYLJEc3KHShsIBzjOCwBE0zfE8NF/Ki7mwy/01Qg==
X-Received: by 2002:a05:6a20:a123:b0:324:6e84:d170 with SMTP id adf61e73a8af0-334a856d518mr10185866637.15.1760781177656;
        Sat, 18 Oct 2025 02:52:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm2290657a12.0.2025.10.18.02.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 02:52:56 -0700 (PDT)
Date: Sat, 18 Oct 2025 09:52:49 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: show master index when dumping slave
 info
Message-ID: <aPNjcWo8G3tTpin0@fedora>
References: <20251017030310.61755-1-liuhangbin@gmail.com>
 <0be57e07-3b90-44f7-85d5-97a90ac13831@blackwall.org>
 <7quap7umeeksodg62bbv4ob4344edplb7f33yiebs2hvhrrdvf@wndrzz7rxi7v>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7quap7umeeksodg62bbv4ob4344edplb7f33yiebs2hvhrrdvf@wndrzz7rxi7v>

On Fri, Oct 17, 2025 at 11:56:55AM +0200, Jiri Pirko wrote:
> Fri, Oct 17, 2025 at 08:10:09AM +0200, razor@blackwall.org wrote:
> >On 10/17/25 06:03, Hangbin Liu wrote:
> >> Currently, there is no straightforward way to obtain the master/slave
> >> relationship via netlink. Users have to retrieve all slaves through sysfs
> >> to determine these relationships.
> >> 
> >
> >How about IFLA_MASTER? Why not use that?
> 
> It's been there for a decade. Plus is, it exposes master for all
> slave-master devices. Odd that you missed it.

Once, I wanted to find the slaves from a master interface but couldn’t. So I
added it to my to-do list. Later, I noticed that the master information was
already available in the slave, but I forgot about it after long time.
Recently, when I reviewed my to-do list, I realized that printing all slaves
from the master interface seemed impractical. So I tried to list the master
information in the slave again — and forgot about IFLA_MASTER...

Hangbin

