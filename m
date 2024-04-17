Return-Path: <netdev+bounces-88681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C68A833F
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 14:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9491F22381
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76D85C7A;
	Wed, 17 Apr 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMqJX3Ad"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46084E01
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357496; cv=none; b=lIFmtR4DWy+S8l2lbHcYF6Wkd91VazqIlzRSZr6AyIlKDHqC2GVmVX0esYOAqLZ70HGGa6wMiwjHf76ZblMXrdqMeVm8TCna+auikBm7nRTRD8SMuz/XBaiQZAjQHOsyHWlwPhnEpqJctoQkHgwDs6oExINsAejcFCperNM7Ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357496; c=relaxed/simple;
	bh=Uv+3pKCjLIkGRI/R19Z/0cMwsRJq1hQjBGjV+wyv3JY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mSRDcCAROzQPUCLM4MVJ6cCl5E1MnKj4l47Q/luzqN9ajW2R3yvWaQvJqbnm+5VVfZib4JiRbHN5hOfL8KrYuPv7KYVa8wHpMrXGhpIwMTg2G6ALnCy+4oaVPTTsqOu//3VSuGCDZXl8+rJegboi9t3q/CAkRiflDbj1l2oubd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMqJX3Ad; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713357493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQsJ74gs8uNCq3QmXHX/BCc46rTm4CPPCIlkZTHPEUk=;
	b=LMqJX3AdMQkkWZq9C0Ki8EjfpAFi6TQ6eTj435Wt7nvYeKLN8SWeUzr8lYb9MPv+s3TGUh
	FwFuJpkAcORU0fZXOlq2rAVr8Ij/GxsqR1Wf+XLjnym6o0ri0p//nBrpPCv/J5T6IsbDJh
	bWvQz8jYp3iGFCEkR1Hbe/+OqfAd5ro=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-rpR2muN0PpC_xTVs9r-ISQ-1; Wed, 17 Apr 2024 08:38:12 -0400
X-MC-Unique: rpR2muN0PpC_xTVs9r-ISQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516d46e1bafso3222580e87.2
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 05:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713357490; x=1713962290;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQsJ74gs8uNCq3QmXHX/BCc46rTm4CPPCIlkZTHPEUk=;
        b=HimI7iEUW47KcQkCXIoB4V5zR2jm2Cab2xjCYFQBBURUcSznb2ZGnkx7tu6TLRiph8
         lZAJz7zK6Ogbk3L1p0YiyZXk86Gtu1qMd+TAV5axn8NbcvPjCyXGzYYtn0bM9GRC3lAN
         Is9t3W6qbICFAlBu78pfFg34VGgng1MuXA9n95k3Nck9T4JGhz8xEfsKFfBJZtFi6ZtW
         m38+CrOnFC3pE1ue5VR/rXrHE7oL2VA/+LEIBQuEplffOZ2GBjBWvgsfQipVOUWReN2v
         ww3XN/0i+6uha6i2GSb2oQmprmMyAyniA3LTC8ZcW5uw9DzjH8Du1/a7BeEWeaxm9/gM
         YKWw==
X-Forwarded-Encrypted: i=1; AJvYcCX8Yq+kDtjtK6d7xCN8GuL84fuyQBglzvVcopPl/hhnjrdUuH5KJicHgzgx9CQ52ijBR5v1E84vi5ZSO0qChL3sCDSVwhKO
X-Gm-Message-State: AOJu0YyEIuheTGE3+iDwjgYHnzbZ0lLddlJnHftuHCFbrprCVY0wkTMN
	PjanKhxLLBdi7w06by9eZgpI3JlZel4YUZQP7p+cy8utdPitZ8FfC3cd6gFXA7ntgDHcW8WPaiA
	X99pfivodUpNPIlhcXDGu+7JHpecTTOBYH+zBn/3MysRK+Chx7GrncQ==
X-Received: by 2002:ac2:47e3:0:b0:518:97dc:d85b with SMTP id b3-20020ac247e3000000b0051897dcd85bmr8375586lfp.63.1713357490572;
        Wed, 17 Apr 2024 05:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeUFJ352/1MTQiEFFy/J/cM1tPdbSfRnd+F7UDGy5i/v8SGgrqD3jBxFhL9k+vsKNJouu3wg==
X-Received: by 2002:ac2:47e3:0:b0:518:97dc:d85b with SMTP id b3-20020ac247e3000000b0051897dcd85bmr8375572lfp.63.1713357490294;
        Wed, 17 Apr 2024 05:38:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906c01600b00a51cdde5d9bsm8099945ejz.225.2024.04.17.05.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 05:38:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 221251233A6E; Wed, 17 Apr 2024 14:25:08 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Simon Horman <horms@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 cake@lists.bufferbloat.net
Subject: Re: [PATCH net-next 02/14] net_sched: cake: implement lockless
 cake_dump()
In-Reply-To: <20240417083549.GA3846178@kernel.org>
References: <20240415132054.3822230-1-edumazet@google.com>
 <20240415132054.3822230-3-edumazet@google.com>
 <20240417083549.GA3846178@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 17 Apr 2024 14:25:08 +0200
Message-ID: <87cyqouqfv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simon Horman <horms@kernel.org> writes:

> + Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>   cake@lists.bufferbloat.net

Thanks!

> On Mon, Apr 15, 2024 at 01:20:42PM +0000, Eric Dumazet wrote:
>> Instead of relying on RTNL, cake_dump() can use READ_ONCE()
>> annotations, paired with WRITE_ONCE() ones in cake_change().
>>=20
>> Signed-off-by: Eric Dumazet <edumazet@google.com>

Just to be sure I understand this correctly: the idea is that with
READ/WRITE_ONCE annotations, we can dump the qdisc options without
taking the RTNL lock. This means that a dump not be consistent across a
concurrent reconfig that changes multiple parameters, but each parameter
will be either the new or the old value. Right?

-Toke


