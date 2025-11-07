Return-Path: <netdev+bounces-236798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC1C40391
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD2424F21E4
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F60A319859;
	Fri,  7 Nov 2025 13:55:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31263195EC
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523742; cv=none; b=ClH4Edgg18KTyTyaVlWhFNx3VRN+/2aRXkf4uJr5NzhRv0cUsA+ONHbCqAA2zzB5NQNccDedUZmHEjvcA3Z/Rhm8/iQ1Sn4Bq14HS0WuTwwXy6l9M8UTSmYGsII61XXPSsVhQCIPv3pnOn7IWtga8zIrAiahyef3pBGYrwyWRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523742; c=relaxed/simple;
	bh=Hxb/gWTOsdtHlXVI0iFMLTENSvzBdCoasJxqnUiXeIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2JuLVwo8Zchj/ZwMmibsNxzvddv+EASkMvquYeceyqp1+hyYEe9rrZ+5y735klj7h4llSKE9y8H9wl1vchxXAYnSY1sBkYGMqcygS4/zfZvDm6lMpHFS3hvbGKOkW7P/kJRl3TSB5BNFF1wJ1Pj+OItenrXueaPcKUDLQh9zC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so1396959a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 05:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523739; x=1763128539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZE6WJJFFBiJVTyI5OvLy2/eZGTZ4IdwtaNd7dO/eBE=;
        b=RyV/c/KhdzMEpktJYmNCJWQYjq6C3G3gH23JoDnMQTE3IrtMCwMSMWIFtD3uSGsXIx
         Wnv6Vx4wJ5IVw0jMNMCwUceT8frv9qut5/WpibsyTH4Fp95hlNyotA5n7h2L1lxW0ED7
         rYm+Zhdntk03zIzepnxPVdMFbPfd1PKwGfhxFwaiyvDAK+pkmt2Qyasu+3+TOz7QwQtn
         SWj+vAq5gpUdEAdYt8seujGMpFAnhpj0VPVxb3CjWjZKfUk3LNTpSDgS9d6mpHepYPTM
         NF1ATmGqsWBP9f8KRbGMur4hrRog+UswO787Ie4jvpLv4tha94m/STmChAGrBkXox8Yh
         Wt1A==
X-Forwarded-Encrypted: i=1; AJvYcCVRf8PbmTLkHZ2htrQ6TD85qmqKA83COKvZW55CjMATJY+3GMStuqV1rgIhmu/REU7dr55daxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54LJsW78txgXug7I3ml5az1BQ5kcSqpeF2iHEsCN0I362HIaC
	5DGCId2P+NSdXKEAXjtisGgOzL3o9SQzSt5Jm5+R9Q4hJagb0iXu/STF
X-Gm-Gg: ASbGnctUXid28hK1jrYQMrP3YJgMVH61crnnhv/bSy47bD/tW0Q9OelBr3QrsyJpDyZ
	qB24PaiI8vEBNfeHaWH3hohVOwvbVWvcKmnC8pBg9hgL27LVSqRNzZODCZNYsKwPybjS7832X0b
	YZVhnEmhP0icndwEcmT8CLN1VHQP9LkkV/AeVENP5NAddCDSRuxcgzMns76c/3ootyyjGMI2cEw
	wA6toUegUFP6ywVUq9+GOveOuZ4lgYUUkMKsneulKnnbK3ioFj/CneV5tCQtLb6DtYaBnIipdgI
	MBVr9kC07xxu2Of0qAAo97d75AI3iUJZBEgDlJTs+FWr62Ww1a2vEofhvLRm14himRFcYZVrr5y
	fDWEjy+CNfddazIFswDwdOq+LnJQ/7kNPWxdf2QEdjhhNcy2ba4xC2Em9KXpxyzeopwuYYDhObf
	fP
X-Google-Smtp-Source: AGHT+IHlTScJC+oO2U1HIWORq+rSxPXReipszaWTgQ3KvvBT9dPCs3MWAerxSZPOSFFxVPN9CHWH7A==
X-Received: by 2002:a05:6402:3550:b0:640:c918:e3b with SMTP id 4fb4d7f45d1cf-6413f0f5f4cmr3131005a12.26.1762523739041;
        Fri, 07 Nov 2025 05:55:39 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6412a27d68dsm3303524a12.9.2025.11.07.05.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:55:38 -0800 (PST)
Date: Fri, 7 Nov 2025 05:55:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v9 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <f44ccmfiiq47ecug5jyfxsi2imsytzhg25szr5yotpdry2b32h@5hxqifqyvsjz>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
 <20251106-netconsole_torture-v9-4-f73cd147c13c@debian.org>
 <aQ3ExWwuiiN0xyBE@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3ExWwuiiN0xyBE@horms.kernel.org>

Hello Simon,

On Fri, Nov 07, 2025 at 10:07:01AM +0000, Simon Horman wrote:
> On Thu, Nov 06, 2025 at 07:56:50AM -0800, Breno Leitao wrote:
> >  function create_dynamic_target() {
> >  	local FORMAT=${1:-"extended"}
> >  	local NCPATH=${2:-"$NETCONS_PATH"}
> > -	_create_dynamic_target "${FORMAT}" "${NCPATH}"
> > +	create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"
> 
> Sorry for not noticing this when I looked over v8.
> It's not that important and I don't think it should block progress.
> 
> create_and_enable_dynamic_target() seems to only be used here.
> If so, perhaps the 'enabled' line could simply be added to
> create_dynamic_target() instead of creating adding
> create_and_enable_dynamic_target().

This is a good catch. I _think_ it is worth fixing, in fact.

I will send a v10 with this additional change.

	diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	index 09553ecd50e39..3f891bd68d03c 100644
	--- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	+++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
	@@ -147,15 +147,12 @@ function _create_dynamic_target() {
		fi
	}

	-function create_and_enable_dynamic_target() {
	-       _create_dynamic_target "${FORMAT}" "${NCPATH}"
	-       echo 1 > "${NCPATH}"/enabled
	-}
	-
	function create_dynamic_target() {
		local FORMAT=${1:-"extended"}
		local NCPATH=${2:-"$NETCONS_PATH"}
	-       create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"
	+
	+       _create_dynamic_target "${FORMAT}" "${NCPATH}"
	+       echo 1 > "${NCPATH}"/enabled

		# This will make sure that the kernel was able to
		# load the netconsole driver configuration. The console message


Thanks for the review!
--breno

