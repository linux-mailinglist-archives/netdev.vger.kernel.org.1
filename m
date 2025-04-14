Return-Path: <netdev+bounces-182427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA77A88B18
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB2F3B3EB5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156A28B518;
	Mon, 14 Apr 2025 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUOU2+Lh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60367279787
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655390; cv=none; b=ic8ZlXYxEk/rXquNYXKon+/gUCprfBPo9eq4dMiqCgqnsEVeHM1jbfmUfICoCbNAzMHUtmIF1dhfAgvlte/UX2DqiOMrGlaA/vHc4vBf3YeIE5MTXCCSJHAD2ClLm1PmVNEhB15q8VpsWeTSetL85t8JPKpJhmkK8SvqEG/h6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655390; c=relaxed/simple;
	bh=XXe7qeEa0wJjmfFPKX3reTci24VGaJTWIZ5SxCVEnW0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QmDRhEXs6Ri/hXYccvjssa9h2XSAUNyDcbPS3EcQ9iM2Wblcp+SWXZDz9j7/YBzS61l/4fp3+Viw6HEdhGDVP+YpAAx5kPFW1U1OUdpyN2GZPqcIEI5888s550FHGVBkUq4meCrRIsnfNgPx/VzzZ+cMy/awn1tjSEg5DbsAsc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUOU2+Lh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so45630126d6.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744655387; x=1745260187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuOHfOUEzS5oTsspLos/Tpu318IKbp/69t5oWIAAy90=;
        b=mUOU2+LhZfhPIXDA21KZavPcuVMWzBQR7UDMDvawDka0odu48/C7Vcm015w+vr2SaV
         UWWF5wCmhX8Nx+EWOkuku/yUPQUWdmT3dJhuKGAJyUbkxMy91GkRPQBguvzRqjMduMVg
         Bk4jjQWWmACInBMBR+6OBW2qKdOBe86QLqAbNxxTs61TZEKQS1cuiOsiDATPI44zA3q2
         nQ0hu+ctrgg8iQZxDHAgeGyj7YJ+mlTxn34denRIG24agFwTz5svG7ViffCcyNV3x+r/
         vbnkvIizTFkhczyoJq6mzaqitoHu6a23s5iZRLidcEmvgplkgqjPbfzQX0QaWPKBEAdQ
         CJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744655387; x=1745260187;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DuOHfOUEzS5oTsspLos/Tpu318IKbp/69t5oWIAAy90=;
        b=ML3X2Fcydh2Q2bRsHEF0aPjlS5FK1ZRbTzjuIWB+BEdP1uaM7EMIDZw9nAfShu05xn
         cgb7omcrAIwaB2wiNR1tj4VFEQEdhxtq2pTlFD+2c8rAAC4rtZy/og7AyNMr8WywdE6W
         FOWHJ5/zsWE6UMAN9cUzZxhhkqpuksfThOBGeZ/R1Cj9s5g/K9GFy7OAo7WrWGap52f9
         1k3Rmqwpwh/hbW89GIVEgtpbvyaVd2IfQx/TOTxohMXWCIzOS78NRM92gcGcU2T7mH1c
         3CaLFBTO6GsunKdJycbdEScqxLHyWjBwFQZGpWiJsvQD0obfk50Khb2DQikSwo8nZkve
         ZuQA==
X-Forwarded-Encrypted: i=1; AJvYcCUqkhSJHN++9LIejq9yG/LC+eHvQkNHTlMtVigbRcOFiyFXQHA96m239xp7hrpTqpHl8V0YMrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZBAw0j2m8lMU7W7WsBGPZPzpiZ9n5Gn0z3PzsDte1IlJEIi3
	RocK77W9rfMjMyfFBVBmJhwTy1msiMXaq0Z4ncgFKFn5MfBgb9Lp
X-Gm-Gg: ASbGncuotdEQzgOjyS9ppbLhfYUEmr5wI6X61XCkvWJHdy2Ws9I4G6yqp5Z5QTSnTeZ
	k57R0a3gYfWGgxlLh8kAvdhuoqtGmRiOi3LfhHeD1ii3oo1CUKgTT7Q+X9qSRC5exPWDI8xKcIq
	mAUM5X3poFT99GLobFuHfr0hjHndp27USO2oXzYX+XP1A0MlzRQWegVgl25phn6RDsUmsgZtXnN
	X/K9aoezKzzn+v1lW+f71fPvRy8O/xVlAb9NibyQHWs6BZbcuY2NnfdblZPqDbxPtMpmdyyVMNh
	mRQeDRaGC0KmHxArb9z1t+VHvjYqK23RxXmRvcVKv0KRnpqJt4rAZqceAp4XT13YZ5RH2bLwIrR
	XiQgM4XlvHNcKcVW7bQrTIMfcUYr5
X-Google-Smtp-Source: AGHT+IFuDbDXehXYsBi6xl7fgDJ5Sol9Zw7bXDmpOsPPgotivjrNeToP4S7EaQV5i5I+CBxG3DevZw==
X-Received: by 2002:a05:6214:194e:b0:6e8:f4e2:26ef with SMTP id 6a1803df08f44-6f23f11912bmr229463126d6.31.1744655387056;
        Mon, 14 Apr 2025 11:29:47 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a89f9a4csm776816785a.71.2025.04.14.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:29:46 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:29:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Hangbin Liu <liuhangbin@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org
Message-ID: <67fd5419b11d8_c648429411@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250414101348.497aa783@kicinski-fedora-PF5CM1Y0>
References: <Z_0FA77jteipe4l-@fedora>
 <20250414101348.497aa783@kicinski-fedora-PF5CM1Y0>
Subject: Re: [Question] Any config needed for packetdrill testing?
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 12:52:19 +0000 Hangbin Liu wrote:
> > Hi Willem,
> > 
> > I tried to run packetdrill in selftest, but doesn't work. e.g.
> > 
> > # rpm -q packetdrill
> > packetdrill-2.0~20220927gitc556afb-10.fc41.x86_64
> > # make mrproper
> > # vng --build \
> >             --config tools/testing/selftests/net/packetdrill/config \
> >             --config kernel/configs/debug.config
> > # vng -v --run . --user root --cpus 4 -- \
> >             make -C tools/testing/selftests TARGETS=net/packetdrill run_tests
> > make: Entering directory '/home/net/tools/testing/selftests'
> > make[1]: Nothing to be done for 'all'.
> > TAP version 13                                                                                                                  1..66
> > # timeout set to 45
> > # selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt
> > # TAP version 13
> > # 1..2
> > #
> > not ok 1 selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt # TIMEOUT 45 seconds
> > # timeout set to 45
> > # selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt
> > # TAP version 13
> > # 1..2
> > # tcp_blocking_blocking-connect.pkt:13: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actua
> > l: 60 (0x3c)
> > # script packet:  0.234272 . 1:1(0) ack 1
> > # actual packet:  1.136447 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 3684156121 ecr 0,nop,wscale 8>
> > # not ok 1 ipv4
> > # ok 2 ipv6
> > # # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
> > not ok 2 selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt # exit=1
> > 
> > All the test failed. Even I use ksft_runner.sh it also failed.
> > 
> > # ./ksft_runner.sh tcp_inq_client.pkt
> > TAP version 13
> > 1..2
> > tcp_inq_client.pkt:17: error handling packet: live packet field ipv4_total_length: expected: 52 (0x34) vs actual: 60 (0x3c)
> > script packet:  0.013980 . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
> > actual packet:  1.056058 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 1154 ecr 0,nop,wscale 8>
> > not ok 1 ipv4
> > ok 2 ipv6
> > # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
> > # echo $?
> > 1
> > 
> > Is there any special config needed for packetdrill testing?
> 
> FWIW we don't do anything special for packetdrill in NIPA.
> Here is the config and the build logs:
> 
> https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/75222/config
> https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/77484/build/

Nothing special should be required, indeed.

Individual git commits also have explicit examples of how the code was
built and tested. Such as

commit 88395c071f08 ("selftests/net: packetdrill: import tcp/ecn, tcp/close, tcp/sack, tcp/tcp_info")

    make mrproper
    vng --build \
        --config tools/testing/selftests/net/packetdrill/config \
        --config kernel/configs/debug.config
    vng -v --run . --user root --cpus 4 -- \
        make -C tools/testing/selftests TARGETS=net/packetdrill run_tests

and commit 8a405552fd3b ("selftests/net: integrate packetdrill with ksft"):

    Tested:
            make -C tools/testing/selftests \
              TARGETS=net/packetdrill \
              run_tests
    
            make -C tools/testing/selftests \
              TARGETS=net/packetdrill \
              install INSTALL_PATH=$KSFT_INSTALL_PATH
    
            # in virtme-ng
            ./run_kselftest.sh -c net/packetdrill
            ./run_kselftest.sh -t net/packetdrill:tcp_inq_client.pkt

