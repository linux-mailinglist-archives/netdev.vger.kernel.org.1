Return-Path: <netdev+bounces-114353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD10942432
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1221C2224F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8DC125;
	Wed, 31 Jul 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGKQQPBQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA8846F;
	Wed, 31 Jul 2024 01:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389873; cv=none; b=K63aD+jWEe47k9nk5RZDUglP9eqg1Cw5aqDJz6q1TDT4wvd5o3jUqddSMXFZsqcoAt93v0PX480R4Xi9nEyVhrYBARgS5nBhv67mTaDWb12Y1z/AJTv9AHBxi1rwsF7tq8XKAC7Eef4oTwLK3WgDh5d3b9pZ7RiK8wuSRFGLSZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389873; c=relaxed/simple;
	bh=3s0CDbIpLDG4BAy5fizhb4Q65VE4rFxJZAkAwZXu9jc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=iqPj3swSpWlhYZbuqNLaWLEqY9749rsZqFAV2BRR7BO99mgN2Xm5A9FUOJg3yXAgJ2Jhz7+uKgOYIYzD/guFobXT7X0L1WXRznZev1BNR8s51zy6ewZacGaOajo5X71A50IYQ8cWCNKN3hjfFDNcfyRF4/fmyfFW6DK+8PyLcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGKQQPBQ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db18c4927bso2745205b6e.1;
        Tue, 30 Jul 2024 18:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722389871; x=1722994671; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3s0CDbIpLDG4BAy5fizhb4Q65VE4rFxJZAkAwZXu9jc=;
        b=MGKQQPBQbZfWxTNuoagRoWg2gO4kV7mvNLpKOcKXroteUR2mwMX8+d4jJv47tsb5vX
         Awejn6PSbb0RUo9AJhytUjVYPA8OkTnf5YKiQlK6/znA7HzmtPpkQW6avfaS/04VaH91
         bh2AqTuHW6J6fRsrO2M3/atOk8y3slbrcZUKntwikLYBgrWcNr4cvS5jW0lDeaZ+F83L
         CdIDnaw0PsGNWy8HhAWUbbJOL3yLyALSUTbMOB2y3pReHWFqlLVin/jjUh1I5GPlwYKP
         a6klrOHoimyMONTO4y9pBp6I7hGLM+8gfB2+i9qAJXyMpi1yLyWGB74hf6FGkS1rLHx3
         yCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722389871; x=1722994671;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s0CDbIpLDG4BAy5fizhb4Q65VE4rFxJZAkAwZXu9jc=;
        b=ajCcDV+DttHFvyJqPGZ+hV3Fyg+++0YFcepcxrS0OaVnOMRFcwxoc6KkgFdlf1WfZx
         SDiXfJlsBYv3G0BW206r2EZ6fTc3uh9/9sOmL/Jvil6j/IXteewT7vAjVxXb4h8cF3gn
         IarYuzZtw298InlbjfDC6I0CDciyPvZHpXCULzEqJ+QWggwemSTz4dXXS6399+p4Idl1
         4s1th9fsw9BunZdw3aaol+mE80HL23W7N/F3EAPtNAURYoK8KWQR2RuKDiSdMCeoIBTU
         BEIFd9gOIpTokqSgquz/7M0CA+7vGiPFxuQxDRBMIbqdJvoiBXYp3Ve6OGhhwG7Ytedi
         jSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZDj4uhL60tpcbwjIEWnBDmvLx1Urql46CtS1jJBvoH6p9lRm5j0fuQ6Vh67GY/LUFKGumPPTSd6xijhPctEYQeMBJSb6isIF1TkApO+UYFPuOMUdmHp3tOrgoy6dbJvGV707
X-Gm-Message-State: AOJu0Yyvoi0JT7UORdIOJQJrZZVm7cL5hnZqTP2FAX2Cm210gEqyJCvw
	vDcavrmr2FP9kC3pRa+wFv2Z8IGBhDhrupA1FV/BfDXzG00tr+JSxIurcBdNeRs=
X-Google-Smtp-Source: AGHT+IGG8esjWomK5mbChu4uZWWVHOB+o3iv9TIzDgiJnmPmdh2TLYKXYS7xlGDHjnJLM7oEZsKHnA==
X-Received: by 2002:a05:6808:1507:b0:3da:ab89:a806 with SMTP id 5614622812f47-3db238b74fdmr13765287b6e.25.1722389870629;
        Tue, 30 Jul 2024 18:37:50 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a884:2749:91b7:fcbd:cbf2:f90d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa6987dasm8171632a12.86.2024.07.30.18.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 18:37:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jeongjun Park <aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net] rtnetlink: fix possible deadlock in team_port_change_check
Date: Wed, 31 Jul 2024 10:37:38 +0900
Message-Id: <AB56B530-B67F-4A41-99E7-1FDA14604D5F@gmail.com>
References: <20240730165912.67600510@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 idosch@nvidia.com, jiri@resnulli.us, amcohen@nvidia.com, liuhangbin@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
In-Reply-To: <20240730165912.67600510@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: iPhone Mail (21F90)



> 2024. 7. 31. =EC=98=A4=EC=A0=84 8:59, Jakub Kicinski <kuba@kernel.org> =EC=
=9E=91=EC=84=B1:
>=20
> =EF=BB=BFOn Wed, 31 Jul 2024 00:22:10 +0900 Jeongjun Park wrote:
>> do_setlink() changes the flag of the device and then enslaves it. However=
,
>> in this case, if the IFF_UP flag is set, the enslavement process calls
>> team_add_slave() to acquire 'team->lock', but when dev_open() opens the
>> newly enslaved device, the NETDEV_UP event occurs, and as a result,
>> a deadlock occurs when team_port_change_check() tries to acquire
>> 'team->lock' again.
>=20
> You can't change behavior like this, see ec4ffd100ffb396ec

Okay. In that case, I'll write a patch that modifies the code of the team dr=
iver and send
it back to you.

Regards,
Jeongjun Park=

