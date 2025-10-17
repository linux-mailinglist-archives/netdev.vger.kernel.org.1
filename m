Return-Path: <netdev+bounces-230276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6FBE6295
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 04:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEEC74E7687
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 02:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEBF244664;
	Fri, 17 Oct 2025 02:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp7Nge6+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F423C513
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 02:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669651; cv=none; b=RqSzhI+KMKnzXReCyMkKf1a7OgrVe9AtQQ1n6AdP7NbVMM91DZDULiql/DTGKDexwFtLkmqzF6TNKE/8FPjB1r8iFDl8TE/qDFdncQOnfP8dFRo1G85+1ttuN5FqNZQ2KfJ8M4JMZEOqt4wISvk1OtNGh2Wu3Jn4r/04wl+oSMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669651; c=relaxed/simple;
	bh=8NiRwe3AAfFzQraWgyYBbLfsnHjwYW4yzgTVKceBqbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvJ9iq5SL7iIIcqs2AqExb/cgg6z7zB5NvGXgAQvpKuJHZqnMIn4aySZ3A6S3b/Szuf2qEUY/AtJ9TdveLLZ1FnJYv3262f+GHu+YNWHZD/328+O//KlztAy2ZFdzYgqRnqqs3+1Gp3knDGIA/0XFFO/RtIqwrIbBb6Uq8wy1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp7Nge6+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290dc630a07so1287715ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760669649; x=1761274449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSQYaGp05AgjNcRCXlpxVBC+oAL0afxX158+woz27Ds=;
        b=fp7Nge6+VBWpUR2VdhzVukWYVYymU+xbw6ig/uk9xJaa94AOzXBB91IdutBALAPt4O
         K8Rpa7ymUC9gRNzBQbnkQHIfucAgh77XxXprNPdt6JVS9K8bbseeW3xhmegViAUImOcc
         zhcKmdY88X1W35tD6heualeJOBYCrv5Ird2+vmDtE2cRCDPdE0qINkCIBlCWnOk0+/iI
         RksRM+1oDmlvjNiZt3HAl0fBpi+2dE6Z2FFY0nObbHfd5JKDjNCuGr7R4F4XbpoYhx+w
         Iq8bplDdD9SLSLSixhFJ8u9gf2BeQibsi8TdL/rBMLpbt/1VmUieEzVEP/3P9bV/5gH6
         O++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760669649; x=1761274449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSQYaGp05AgjNcRCXlpxVBC+oAL0afxX158+woz27Ds=;
        b=Hc+YjiU32D4EeF+OsgYNGKH/91e/ICzkKDWf6PTw/qKAQYF2hnUZzNyuUe9fEi70JL
         apxbjQVQ22+kBiPqlNKXTkL4IMgXaE/zOYX52W3aUAxtvWyEyjgWuAxseKHyWNqaGkEF
         o2nuf07TM3Qcgx/nG2VUnA2pWlRsZgnx9oAAO8oQnUrtLVSQgq+WneETaIWOm4JMFj2Z
         Ypc/h5kCf/KrlHhZ+skU3n86JGpCl46Q9585vEh2Y72T4ocDFZVh16ogU3rcdI2ybRku
         wibbAfZ0RS/honuNShPhOErWNN4JDhmjCOIsQTb9RUghs1tPRVt0pPi5caiEvyd0CtVS
         Hpvg==
X-Gm-Message-State: AOJu0YzTIn1WzzocekMPqHwfHkO2i0YzZHzFvluAqXZcsdar9OXxkEjJ
	LEICBx4VSZ4Sv3D8zW9X3cp8EsS2ivQc6Ht24QVGJii63WgK0Ra4Uj2k
X-Gm-Gg: ASbGncsGzkd3UsX9t4SDdIkP1nV3ZGF+H5kXhzcbmG/wyAV/tLdGu1Cwqtojo50sGNc
	Iw+hwZDmoQNgXEKteTe7ICkuBk9Wzze2rSUMsqgSRBlA0oNiuJm0kC1JRIyucmySbxQz6bzvR8q
	BP2bn9iVj7d2P8ZLdxGFwryyo8Kwyh8rmGNKK9OTl2lBmPqBUWECHiyKw36GQCpzVbBfseFcM4G
	NcfsT+TJyJGqL7rfVh8uvIIcweeqj5wB2PAIcZW/27nZtGnez6snZZrWz4xu2+yBACQoLU+2YNc
	pbcYz+5TC8Ng2e/EcxPS1+ByI4c7sT5Ne2hTHHw67fJnrao6N4RcXByVsclPIxfaK9pYUsfjpLn
	2umg0u04HxK1ufYV5PlMEFgRtOpEnJhSWcwZHQuXC1C2HtZTh5x3hIZ7+ryx5saq0VSg4XWfrSv
	zVY8tQ
X-Google-Smtp-Source: AGHT+IGQi3U8O3cPAK1IhHTZZ8syKPaPbEumFj3MTl163+GXW0epQ+kNRrCWpnDLoeWcdl0oOcSMxw==
X-Received: by 2002:a17:902:d60d:b0:28e:acf2:a782 with SMTP id d9443c01a7336-290cba4edf7mr24841635ad.37.1760669648941;
        Thu, 16 Oct 2025 19:54:08 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7c23fsm46176465ad.74.2025.10.16.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:54:08 -0700 (PDT)
Date: Fri, 17 Oct 2025 02:53:59 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv4 net-next 1/4] net: add a common function to compute
 features from lowers devices
Message-ID: <aPGvxybFp42UN_f5@fedora>
References: <20251014080217.47988-1-liuhangbin@gmail.com>
 <20251014080217.47988-2-liuhangbin@gmail.com>
 <sfjjkeub7fmvsktzrx6mmv6zvilno3un665tbqe2punw4azefo@jwuhk23763gc>
 <aO74J20k16L7jS15@fedora>
 <to4zjjo5wfd5suootcy2v7n7kuc6rym3ld4jov26nunnarji2u@2hr7jyiq36pj>
 <aPDnN072argrq23q@fedora>
 <fw4pvt7morcydktpqmmotab7pyvbixhrszgdfpl4dut52rfesf@4fztqcywdwpm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fw4pvt7morcydktpqmmotab7pyvbixhrszgdfpl4dut52rfesf@4fztqcywdwpm>

On Thu, Oct 16, 2025 at 03:24:59PM +0200, Jiri Pirko wrote:
> Thu, Oct 16, 2025 at 02:38:15PM +0200, liuhangbin@gmail.com wrote:
> >On Thu, Oct 16, 2025 at 01:27:00PM +0200, Jiri Pirko wrote:
> >> >> How about "master_upper"? This is already widely used to refer to
> >> >> bond/team/bridge/other master soft devices.
> >> >> 
> >> >> MASTER_UPPER_DEV_VLAN_FEATURES?
> >> >
> >> >I'm not sure if we should avoid using "master" now. Maybe just UPPER_DEV_VLAN_FEATURES?
> >> 
> >> Why? We have "master_upper" to point exactly at this kind of device.
> >
> >I mean try not use "master/slave" words. I'm OK to use UPPER_DEV_* prefix.
> 
> If you don't want to use that, change the existing code. But when the
> existing code uses that, new code should be consistent with it.

OK, I will update the name.

Thanks
Hangbin

