Return-Path: <netdev+bounces-112212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C9293761D
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4FF281053
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780EA7CF39;
	Fri, 19 Jul 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iFir82KR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565A639ACC
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382645; cv=none; b=Kn/uGkgFMWZbldtMbs12m5KIef6uMDONDMLfFDwRVX1q8LVJK18GHDcHnIOOxhp2/3Nn+4y1gPJWmwaO2F6zo9Srgeir47Dh5tb+dE+hPfdLphoj236jP9pI8/IItzLAJvXJPoxc2e/Zsssq8Ze5Mo7Ku6iP9ZKC9lLOOTy6yeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382645; c=relaxed/simple;
	bh=uMLZSBuJCOpcHwgNgEA4u3L6fQnaj0FIYHDr/6KbpLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afcH7d/PLVEhfIk/wXXoUtxeMtYTWpf4J/gwOOiyo/EZjFUHwWDAJncPbRK0fvH4YJuRBFWiR2hcY8VtaDQaQ64YwHGhKk+zi0U7sf8V1+wggq3sddR7CG1Ruih15Wr07fkRIPuMULiCYQSeke/J2V2lRmsEKV9O3lRF3hJlsrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iFir82KR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso1487017e87.1
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721382640; x=1721987440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMLZSBuJCOpcHwgNgEA4u3L6fQnaj0FIYHDr/6KbpLo=;
        b=iFir82KRAFHbQMhXNrzoptu67rjEdfSEa/Vu0d+I4tiNJsUPae8JFRnjx9gDYlmrXW
         XF7gNX8lbTgNyztN3NBt2R6PqefybNkU2P0VmwnUsInz9T7OpJw3RMLRIgZYRodpnRqp
         nN0wFA9Y4z9rhVxzozr1d4v+A/N19x1zxbLrZETItpmbiFD1Q7nGR0ULtjrxNSc+9Qqu
         dVSBDRaOW0g+7SpA28F4xCfoDJpBn4nMce3HaGDE9VGkybN/l9A8tvEYXx27pCCn9/Rd
         gQvUW5PDk4t3+zA0jzX1GuZNp0TQNJY+SDw/lJbifzJOsOT5Xvy3d6EYLtMRnXw84Qur
         yz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382640; x=1721987440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMLZSBuJCOpcHwgNgEA4u3L6fQnaj0FIYHDr/6KbpLo=;
        b=M4cf7/4paLe4bqZl7RBhjE3zLHPp8tqlU5jR1T7UQUf6SJ5Qz1A4ai8wFa1RnV9y29
         MF440NWP4fZElSxVNyzv7yfUGW4Aci70CcyCbmO1F4wBcn1VUSz/K7fUH6qZ6bIoNzlD
         k/u0S1YWxpyLlbxmJk1kb2X+4W50RXgfbqJILB3yE8FVy2rwhhlBt9KQF5ETpLhQ0olE
         pOaHg5T8h2Fp7FPXcGEhjm2LTHv1XEz46fardA2+DOQcLCI+AFyeLTc1u8ncAHFB79Fk
         adQLtncyr96+sBZ0dFgfjttXDZqWHXjnOHuXxjQIwL0kFCYFsL1WJJE43i0paoA6JasC
         unIg==
X-Gm-Message-State: AOJu0Yx7krnBFg5DdURYqUijFamXhf4PWUNha4XABtGIrqvfvgcdN4Oe
	rWrax3tYr5U1XxxG7qMOjxAlWGyBPJd/Pb8FMC+RxASvLkATxM1Oz3Jj63f2y4dalVGSJaqd4a/
	IRsI=
X-Google-Smtp-Source: AGHT+IFPrjFfKT9LLpWMwNVtDF2tWMVGV+5wd/GIORSIO8FEX2SKhvHtUgtfkPjjKWYBhlzu3acj4g==
X-Received: by 2002:a05:6512:2252:b0:52e:a7a6:ed7f with SMTP id 2adb3069b0e04-52ee546cc10mr5430022e87.60.1721382639852;
        Fri, 19 Jul 2024 02:50:39 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c918188sm5993366b.146.2024.07.19.02.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:50:39 -0700 (PDT)
Date: Fri, 19 Jul 2024 11:50:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH 2/2] net: bonding: don't call ethtool methods under
 RCU
Message-ID: <Zpo27pq6lWYyVv_y@nanopsycho.orion>
References: <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
 <20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid>

Thu, Jul 18, 2024 at 09:20:17PM CEST, johannes@sipsolutions.net wrote:
>From: Johannes Berg <johannes.berg@intel.com>
>
>Currently, bond_miimon_inspect() is called under RCU, but it
>calls ethtool ops. Since my earlier commit facd15dfd691
>("net: core: synchronize link-watch when carrier is queried")
>this is no longer permitted in the general ethtool case, but
>it was already not permitted for many drivers such as USB in
>which it can sleep to do MDIO register accesses etc.
>
>Therefore, it's better to simply not do this. Change bonding
>to acquire the RTNL for the MII monitor work directly to call
>the bond_miimon_inspect() function and thus ethtool ops.

Is there a good reason why to directly query device here using whatever?
I mean, why netif_oper_up() would not return the correct bool here?
Introduction of periodic rtnl locking for no good reason is not probably
something we should do :/

