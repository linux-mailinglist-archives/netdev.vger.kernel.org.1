Return-Path: <netdev+bounces-106429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D7F916413
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35660287235
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA0814A096;
	Tue, 25 Jun 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUhW1xbt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E21494CF
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309208; cv=none; b=vFrC+R+UNnGi833n5NsU6Was2uj2TKYWPg3ZTRYWlS+tx4wbAjpt67a73CG9vjMAwH0CwEe41zNoZqsIq5Ntj6REDHg91zuwaAwqhRQArXMxAkGVh2Xu/CU0x60ibyOzTGoiimqPOiM4VPMOR50H7YjfjnBr4eH/elAmcEU1rJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309208; c=relaxed/simple;
	bh=R3FCxbaMJtybn040DrjxA8NUBVBQpqRvUPiknZOt1TI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUuwDO3o7f8SHytTFTMMp12pEswUBMq1Nha5VmMx/gB9ngLGlG0OMoVcOTeIE1A4oX1c82lg+ZGnx4UVFAxyXND9p7Xe8VtSJ47qNR6Ol2/BS7ItEMPnwTm7fYUsepRjYcG23FimIW2Lasw4MIvEqbPoUl2eoIgYTCkMv5chumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUhW1xbt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719309206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCDVg82SvAc+NbfdoyAHMeVF+Y0QRccTMhp18TkLsuQ=;
	b=XUhW1xbtgt9Fg7v344OXvOxL+uw007NmulTq+BYFywBeh4N7IsbTPTeZckqg90n+qyGDLa
	A3q9mI9BcB6OwJvRwUw8NQSMsnSsh8jxrNtq9xyfJS46OgKe83xn1BJTsiiluzpUdUwAVx
	grXJtMF6DzIMX8rjOo1HBv/MhGHmnc8=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-0ZpyM-qxNjSYnlVaX5h0HA-1; Tue, 25 Jun 2024 05:53:24 -0400
X-MC-Unique: 0ZpyM-qxNjSYnlVaX5h0HA-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-48f6476949bso1708965137.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 02:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309204; x=1719914004;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCDVg82SvAc+NbfdoyAHMeVF+Y0QRccTMhp18TkLsuQ=;
        b=KPnhm4liYPHs2caQeTQcUPD4lclB/ZEnw7GTbp5fi666welBX42033Ie4moCbahb9U
         n5ww+nWYEA3z73XiiXXe7rZmDblNSrqTfsB7KM5Uuom4Py/spnRJwUIEXvNXea587flU
         hL5pVgk3TKQaajJNGQ7EZRlgIM7jpfcP2NxHgPgfiMR8QXESXXXwEray9QiSy4aOdSwc
         GwxJmZ2hbuwnBLM1jBM48I/Sa9BeFG6mT3gCs8A5APKIWyakNMoCW/2SYpP94a+6zG+Y
         3DT5+fiZCkR6tY6IZQ5BSBrPDSeJLTPZhcjlzNLqlM4SG17WjAEYNWFtmSvFQC9esdyI
         +j2g==
X-Forwarded-Encrypted: i=1; AJvYcCV256LEtbRh0xVDxi/IIxrLgpYHiuDGFIgIwH+cx87uaL9og80Deak5idFM0qU8OoapAYKo8a7GlgfdnzeKkOSIQKXkGT1T
X-Gm-Message-State: AOJu0Yw7o2RYU/EoCyHbfL35PElwVF3nGD03K5g3PDdlNuvPsrduOdyH
	wYNP68RYR9KzhCjCo1KX2k+yXjZP6H3j7+Thx6VBHMNq7PPmzseHXviKS1TDbNIGy43O6xE7WvP
	zIMEozB+g3Gu6hYy2cfUhO7DX7UDrjyK43nYFglER2wKSi67souPBlQ==
X-Received: by 2002:a05:6102:34c2:b0:48f:2f28:833c with SMTP id ada2fe7eead31-48f529c9ab0mr6186855137.5.1719309203354;
        Tue, 25 Jun 2024 02:53:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7GVgIeXQfikh8im4fFadRGZfZMvzwXv5Lgjya/R6ZwlnSU1s7SQ/q+IhvLlQc4qI0cL2giQ==
X-Received: by 2002:a05:6102:34c2:b0:48f:2f28:833c with SMTP id ada2fe7eead31-48f529c9ab0mr6186831137.5.1719309202782;
        Tue, 25 Jun 2024 02:53:22 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c96b06a2sm45955701cf.15.2024.06.25.02.53.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:53:22 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:52:17 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240625115217.07c820c9@elisabeth>
In-Reply-To: <20240624153023.6fabd9f1@kernel.org>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<20240624153023.6fabd9f1@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 15:30:23 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 24 Jun 2024 12:53:45 -0400 Aaron Conole wrote:
> > Additionally, the "Cannot find device ..." text comes from an iproute2
> > utility output.  The only place we actually interact with that is via
> > the call at pmtu.sh:973:
> > 
> > 	run_cmd ip link set ovs_br0 up
> > 
> > Maybe it is possible that the link isn't up (could some port memory
> > allocation or message be delaying it?) yet in the virtual environment.  
> 
> Depends on how the creation is implemented, normally device creation
> over netlink is synchronous.

It also looks like pyroute2 would keep everything synchronous (unless
you call NetlinkSocket.bind(async_cache=True))... weird.

> Just to be sure have you tried to repro with vng:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> ? It could be the base OS difference, too, but that's harder to confirm.
> 
> > To confirm, is it possible to run in the constrained environment, but
> > put a 5s sleep or something?  I will add the following either as a
> > separate patch (ie 7/8), or I can fold it into 6/7 (and drop Stefano's
> > ACK waiting for another review):
> > 
> > 
> > wait_for_if() {
> >    if ip link show "$2" >/dev/null 2>&1; then return 0; fi
> > 
> >    for d in `seq 1 30`; do
> >       sleep 1
> >       if ip link show "$2" >/dev/null 2>&1; then return 0; fi
> >    done
> >    return 1
> > }
> > 
> > ....
> >  	setup_ovs_br_internal || setup_ovs_br_vswitchd || return $ksft_skip
> > +	wait_for_if "ovs_br0"
> >  	run_cmd ip link set ovs_br0 up
> > ....
> > 
> > Does it make sense or does it seem like I am way off base?  
> 
> sleep 1 is a bit high (sleep does accept fractional numbers!)

This script was originally (and mostly is) all nice and POSIX (where
sleep doesn't take fractional numbers), so, if you don't mind, I'd
rather prefer "sleep 0.1 || sleep 1". :)

-- 
Stefano


