Return-Path: <netdev+bounces-221591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF4BB51138
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F23A5AC2
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EF30EF8B;
	Wed, 10 Sep 2025 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ8xI2qK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534630CDA1
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492895; cv=none; b=MPcwdyYdfwyy5MtT+ARjkBI7Nlot6AeNBTv2DTOdif5/Xn7pCy2R8/03YKpaxQ1LYtHDyqkMwlEpY0W3vS3RIu3sxyhGbMSG08WD2lCWHCDfSt+Qyg67iHYwO99ROYWj8vl8miMFHBtDEPNdloeBl+IpPN2+U4SM9d7Gy6k2OXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492895; c=relaxed/simple;
	bh=vaX7Ju+p+Z3MWIpBaMIHx9c7/gUB47qSlUxX61hFoPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpZqRQktrpTBMPPy2hy5LR96KRmp1QlsgBZ5KIxYnIP9yjEHrViwMGkw8lqEIRma4JQ8Zp+BEw5m1+399qAfvdrtl8a+D8//5/AjUo/pmHICT/Dqp6LoCIANqy4Vol+VDnbEra0VvcpuNwp8Acz8tYD64fruPKLcOF8rBJJ44tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ8xI2qK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757492892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lyl88Wjtp1RCxQS+mXtK5muxD+C3zmjvgsqdrJfM01s=;
	b=jQ8xI2qKsvAPer5UtCTvmFpxDeHxsKN/RgQapSTpNvE2dqKjCZ5sdMHeY11iSuTR7tKMvL
	ukStzcBgvBVum5Tt295MfiIgv0ujlk0mjfKN0C8raPsPIMW0gr5hsh0918HPPsD49yk1Fq
	F8EYz5mP9sH8GdykXs08JTGc1FMp3lk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-oFBKGhpUNrKflZb3qBhlXg-1; Wed, 10 Sep 2025 04:28:11 -0400
X-MC-Unique: oFBKGhpUNrKflZb3qBhlXg-1
X-Mimecast-MFC-AGG-ID: oFBKGhpUNrKflZb3qBhlXg_1757492890
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so2296895e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492890; x=1758097690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyl88Wjtp1RCxQS+mXtK5muxD+C3zmjvgsqdrJfM01s=;
        b=jH3xx57gcOX/tT28Zq9NhVKg493qo4ZL+TYs+nc9tmD1MjiTueYO1Md/p+8qrut3P0
         4S00QXG3TucVtwDtEo4LaMHT7Cp/sl++mQ90mkhGvpZImzqkW9yNCN4Ga9fUgpFolJ6C
         mOX3jomUU9iqMuk9+MZ32ppEJQVpXLtm5RUpRPPpBTeJmsUNvvlqs2b9epjfDCAh3tJ+
         L3Qpi0rV8jo6GAl6lLiwAuWiCodm1Hb8buZ5l5EvSrH+BjRLdabPkYWHjs+TitTI0p+/
         AtCBS0os0xfETmZBRVg+tu/ezIBpNW8NaWOczj26hmVRh0+g5LMrm+95cu3+GTFvQZNq
         sFQw==
X-Forwarded-Encrypted: i=1; AJvYcCUWFZDFJt4ideuWIG9WIPGAuVgs41PG2D+h3H0EIjkXZVqR4+hMIY2pSXP0yXiqsliRg7euQ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/3pYIBHpG3kCZ7+ygAwas29QWjuHBUIURNGRV8EuVDQcs7+S
	9CsKPb03bUtywKGgFEikNgdyvAv+JaBYIyY1G8rdTE9qn320qhHHm9K0BFdEFeBANBv0mnAfiy2
	gr6oUWbHTcNHy3z1S84fnOnKmWHP/IPbciSvMi6GPEep1TdSZ6Vx06ovGQsfSLqVWA37R
X-Gm-Gg: ASbGncs6tqtrJEM6poEQdBYMEdOER7rziFO5x951U7rF2RtHHxO8Ftr+D7MijI4bRaR
	Nsn8NjpCrg/L54EleLu28fb5cQ11Vh4z10riWgOM8L9yhINDQo3vxmv654B4dOcK2SQeCoNxrQJ
	2qVtVGFlv0WCXD7gSTECkM3hTHG6jKeqii1XoG54dk4IVh/wrJmJaDHGK8InxE1PBYfvcmDSks3
	zHduAfuyPS1v/v2X35wz17DQkr0so6utm6oQ4JEM+X/hY27yFuIrMZ13mruMcZ+zH0P7iXLxR6E
	P8qJ7uAEW9ZRBnB+7OkLLsTObWoJnkLYPtffIg==
X-Received: by 2002:a05:600c:354f:b0:45c:b61a:b1bd with SMTP id 5b1f17b1804b1-45dde220a2emr138989945e9.18.1757492890030;
        Wed, 10 Sep 2025 01:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpcTkn0wW4LsqJDafwujpAjLDY5EPkSvu6F/qT+LDRJgx5vEptRBgEGFHxNaolEYNmPJYzww==
X-Received: by 2002:a05:600c:354f:b0:45c:b61a:b1bd with SMTP id 5b1f17b1804b1-45dde220a2emr138989665e9.18.1757492889566;
        Wed, 10 Sep 2025 01:28:09 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df821f714sm18713505e9.16.2025.09.10.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:28:09 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:28:08 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
	kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
Message-ID: <aME2mCZRagWbhhiG@dcaratti.users.ipa.redhat.com>
References: <20250909134840.783785-1-mkl@pengutronix.de>
 <20250909134840.783785-3-mkl@pengutronix.de>
 <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>
 <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>

hi,

On Wed, Sep 10, 2025 at 09:37:59AM +0200, Davide Caratti wrote:
> > ...
> > # 4.13 [+0.00] # Exception| lib.py.utils.CmdExitFailure: Command failed:
> >         ['ip', '-netns', 'rhsbrszn', 'link', 'add', 'foo', 'type', 'vxcan']
> > # 4.14 [+0.00] # Exception| STDERR: b'Error: Unknown device type.\n'
> > 
> 
> > Best regards, Ilya Maximets.
> 
> thanks for spotting this, I was testing the patch with:
> 
>  # vng --kconfig
>  # yes | make kselftest-merge
>  # grep ^CONFIG_CAN .config
> 
> Then it's probably safer to drop the first hunk - or restore to v1
> 
> https://lore.kernel.org/linux-can/fdab0848a377969142f5ff9aea79c4e357a72474.1755276597.git.dcaratti@redhat.com/

And I see that the build [1] is doing:

  CLEAN   scripts
  CLEAN   include/config include/generated arch/x86/include/generated .config .config.old .version Module.symvers
> TREE CMD: vng -v -b -f tools/testing/selftests/net/config -f tools/testing/selftests/net/af_unix/config
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o

[1] https://netdev-3.bots.linux.dev/vmksft-net/results/291401/build/stdout 

while the enablement of CONFIG_CAN_VCAN is still necessary, the contents of selftests/net/config need to be preserved.
@Jakub,  @Marc, we can drop this patch from the series and I will respin to linux-can ? or you can adjust things in other ways?
-- 
davide


