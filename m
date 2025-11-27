Return-Path: <netdev+bounces-242119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C32BC8C830
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 053EF34D8BB
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E844E29D26E;
	Thu, 27 Nov 2025 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2gn8gBO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99F335BA
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206103; cv=none; b=nLDIlxkpsAOL/AOSqpPanjOoG1YTZt0iwF++jP4JOjVQe0uSNjwVvi9C/lqfwq65BHFNtoHkOmq3bmXRYiz3ywVpPo6V9xebBh2pn6adnf6N+cbrev/uS1ku6rGZo5wMHNkTdRRF+11hkILwF37blQmW/vg34xT5nejSgq3xjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206103; c=relaxed/simple;
	bh=rbQFswE/A44rlfhcVBMow8L4G7M6RfJuDcDkIsytVk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIU1FvYk0PqLBh19vltYfnAoo3oSpTIzuZNzjXVm/KPi9ovIvbdPZZd+SgdTYGtyXY8SXMi04bqfEZFQmq1+1y2xKZGhw2lf5WnBbkFkKxRkoJw90jSPaTBGNTys442JMNv9jnzEMoBJB7Rutcj/8XBWGrDWG6q5XWHwv8lpkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2gn8gBO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297d4a56f97so5136975ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764206101; x=1764810901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNZ1IdrzXUYP3I+fzHDQlSBQ0mxZF7OB8+xj0SRLYX8=;
        b=k2gn8gBOY4xxxXT9yI6JWF2Xc9cLIaWJRaYjMAVZjWLi0aC0h2uFwos1NLvvJj9bEq
         fI1Q6SBdd3/IZO3gLAQ9vnoJrr6ZMjVlqEkmSLG9kCXtxEpKK+2GJQWa0cLFruIP+3v7
         y69UEm3KsUmqHxEts5c9Kuth+Ma1vfCpqI79CKqMwGdt3uW8FTyRAm0q3OrtcGfayUyR
         hW49l3mY/d3YjpDSi59/a+linNYtXijFilWSAUPOdErvNXTEYTqZxJaXExuZUrviIjj+
         pxX/tf0SsDCZly3VOhSUGvJAoMSQDcx0/S6w7jUl78FJTkxkwTswq4pdU3j7Ogq9SIGZ
         9igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764206101; x=1764810901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNZ1IdrzXUYP3I+fzHDQlSBQ0mxZF7OB8+xj0SRLYX8=;
        b=K5QODfKXhWxHfEfVNIvCjpD8PzDXlKVhPsFfXltdOdpIkS6d5e9YzQjaNfLRkuO1a4
         fWhMVApN1aVUgMyg69/m5WFToEYgRqY+0ZfcN0Wr0XUo24s5EfjYWFddwkuETC7EVtjT
         wy8RoAs7LKlrC7XTkaqz1vrFABiOwpW9LR01lF/Hh1kzsawBPuohHJVSq3w0J6YW963W
         +kysiEOlREJ4uXilWBf1OhNUU04z8U0vBBZPO6Qkvf56i8Y+OGL7dQ3/aXw6z6SPv7vh
         uQz5DsJJ8X4RLP/p6rzoRPmdpxGz/VD7r4UX6/XU48O1fKgObfovFIjXT0YQWiMQpp9c
         LzlQ==
X-Gm-Message-State: AOJu0YytrZPhDl4mOFQta9+/90iSd/tIG1JUOKRlcbuxBh0OVTq8ty0w
	OnUMI2Ef7/pxq2NUnIJBdLL55du3jb3GGinjv5q/c+KqUSLeJnBayCa3HrFDvFPWxlA=
X-Gm-Gg: ASbGncv/L1v+pjXMjoVmyjH1Z5HrXNqQnCuuTgQ/gNsSqE/ayPF/gG00xWFjed2rXaM
	p0op9HnaLEBeljYZkAVXcUD/gZWltm1OTgqqFuRmayaHQnNhueTn8DrMWL+zztYW80M+uy4PYWZ
	oyWWgikgn6LrIBCMOEs4RHUi5ixXVafAPaTemfeagWNy6qk6fdwYiVVqoQ6owruL2GyWSe8JwX0
	aYikXY8vpVK4sog04lUWor5Xy5celjyX0B4uIor8Vtgt9SfRkPQVbFCBdiKEXsn6b5DhR89AF+B
	KoxvCw3/szTFhGjmUMrlKgbnUDNqSlNSc3WUvAvTSgWVWTSKcUllJduo/kNUH1cE66J4SrqnV2d
	gtYeEg/43Z7YWFb0Rcaf1QNuN0ymAbLgQXYnXbib9Z0hhByYk97vhQ0nRIRiWl9lS7Eae3pyV85
	NesvfF/zZJXbVrPa8=
X-Google-Smtp-Source: AGHT+IHBES2UvXICh5OA8Qnb/Z0pu9NOih9Oi4Hd56lXZBvzFHwDX+wK5NGfkNcD0O0D/ftit985KA==
X-Received: by 2002:a17:902:f547:b0:295:557e:747e with SMTP id d9443c01a7336-29b6c69233emr214561235ad.40.1764206100486;
        Wed, 26 Nov 2025 17:15:00 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm209199325ad.75.2025.11.26.17.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:14:59 -0800 (PST)
Date: Thu, 27 Nov 2025 01:14:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [TEST] bond_macvlan_ipvlan.sh flakiness
Message-ID: <aSemD3xMfbVfps0D@fedora>
References: <20251114082014.750edfad@kernel.org>
 <aRrbvkW1_TnCNH-y@fedora>
 <aRwMJWzy6f1OEUdy@fedora>
 <20251118071302.5643244a@kernel.org>
 <20251126071930.76b42c57@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126071930.76b42c57@kernel.org>

On Wed, Nov 26, 2025 at 07:19:30AM -0800, Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 07:13:02 -0800 Jakub Kicinski wrote:
> > On Tue, 18 Nov 2025 06:03:17 +0000 Hangbin Liu wrote:
> > > > Hmm, this one is suspicious. I can reproduce the ping fail on local.
> > > > But no "otherhost" issue. I will check the failure recently.    
> > > 
> > > This looks like a time-sensitive issue, with
> > > 
> > > diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> > > index c4711272fe45..947c85ec2cbb 100755
> > > --- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> > > +++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
> > > @@ -30,6 +30,7 @@ check_connection()
> > >         local message=${3}
> > >         RET=0
> > > 
> > > +       sleep 1
> > >         ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
> > >         check_err $? "ping failed"
> > >         log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"
> > > 
> > > I run the test 100 times (vng with 4 cpus) and not able to reproduce it anymore.
> > > That maybe why debug kernel works good.  
> > 
> > I see. I queued up a local change to add a 0.25 sec wait. Let's wait 
> > a couple of days and see how much sleep we need here, this function 
> > is called 96 times if I'm counting right.
> 
> Hi Hangbin!
> 
> The 0.25 sec sleep was added locally 1 week ago and 0 flakes since.
> Would you mind submitting it officially?

Good to hear this. I will submit it.

Thanks
Hangbin

