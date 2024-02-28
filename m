Return-Path: <netdev+bounces-75886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D286B919
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 21:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791D3B22386
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607F33FB9A;
	Wed, 28 Feb 2024 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItqSDZr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3555E060
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709152521; cv=none; b=kJcdCjyvGSuQE0yjP84IPGLUg+AGlxbIy8jt/sXrFlr0cswJfZVIkcGn4wxCmTJoOgicQxCQOjRTQBrEEINT9GnybO3hA+zYoPSrbk6R6dtsbll4JFyIe9MVfCGy+HG1ehFEW65VyJHC2yfQa0+oBtnp9fwBJ2zjKY3xGSr8LmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709152521; c=relaxed/simple;
	bh=k2axefX4qq8ZKhrAUoDvoKs1h2ARXenV9uuV9dVYEcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ2f4n/PPo86bBOaeVoygKooLzSclqXloztkzXB+MBPWH65IrybUajLg/jl8LjgSOnzqV7x86uEItrmZcQ8E7+J009CqAjYIWEhXfl0QWJe71gRAAy8PvquC/q1mAu3AcxrojDzlWaONZRDyJVyz+U0f8QorRCmd3xC9rtvkbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ItqSDZr4; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-470441239easo49198137.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709152518; x=1709757318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dTsbG5Q4/3YonRF9tCw4Nlusv99qrBzh3bD+/1+Fjgk=;
        b=ItqSDZr4kO/XuKiuHN9RyyvPmsmPwdcqM9RAMpbGn9irHlUGEMKzJgWHTGRBYFQ7qF
         4yzTKqsYqBclASlhoXn21u5NpRS/lNlyjjU4TBbRcf3iuaG6e0QbgOhrKlHEcCdzGqSp
         D+GBzdd+K2xqy5FhgQgqEYSfANpfjRBMHLYG3ArbPykYFzeVIfJvCA0NOr89x+Ufwx47
         6+qqpim4PQNpt52KxQE9lcukgslzg0QYVIKWJNN2gQKCJP5DMc7JiKD2RH4VUL+zWZ3+
         DYzzuQnazLA8VB7+uqJ+sVXB0skEEW+QomUNnQbOebpJ4WPCMxSWLeM3937jCf/TolC9
         2ZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709152518; x=1709757318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTsbG5Q4/3YonRF9tCw4Nlusv99qrBzh3bD+/1+Fjgk=;
        b=Aal/hpVJFU+7ijFb63/ZQs3s2yYV4oBf3viHcbRnU8hEwYCflDI/x5t7TrksI+iQoS
         xBD+V9qj987l0KpA+mq2Uw+9g3jbnLa6LG1pYGPX5PJwVaVKeqEYF9W/JZZP1K67hXn2
         LF90ruHED2cd+zmqaErsc3DNm0stqsI2Igb85aHrlv4HvgcrthD7P1JvOuMRKdJUNzAK
         AzpgjSbE5VbyC+3EFr9EcB7wDbM9Z+/kzJwdshnAN2Fx8YgSsHxbDsrlavR/Cnarw7sh
         MSfFaReyLkdtzPtuJOUPEIbsNW7IxvMa+kom8fFaoNk6MKlb93V1fYNylFOJAwBKhJPX
         CN4A==
X-Forwarded-Encrypted: i=1; AJvYcCWHdiqciMC4QCNSX7jr2dnKGsXXZu5aYb6GzxwHnmttp1THW6JEGof/AtrR1b5bNEwbfREn6YBv917APEcU74ZLPOoAhh9g
X-Gm-Message-State: AOJu0YyjTcPcvZ9MVnFnvxk2ufqn80cI2xWoILnSx+OG3Z4X0VpOJMOH
	BCm3a+eeG0jka6qKQM4En0/SWSxhT00x48ZdGBkJ2yQ2CguZA1dN5k+9ss15jZ1GHtYfjpI/lsO
	FObdlD9QMSjSuBKv1XD7j3UIGjGJeXJGViIghig==
X-Google-Smtp-Source: AGHT+IGbPq5jv3tng931RyYaor6H6McKtd30+PYR5wOOTNYGE1fF/lo/xcMSdesLXzTiFWMBuab14Y2HllKuyH0AWKE=
X-Received: by 2002:a05:6102:3a0e:b0:470:3c97:9787 with SMTP id
 b14-20020a0561023a0e00b004703c979787mr46197vsu.0.1709152518180; Wed, 28 Feb
 2024 12:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206075950.47d0bdc7@kernel.org> <20240228164939.150403-1-naresh.kamboju@linaro.org>
 <1562999a-05d7-4d4e-8fc0-43c5979793b8@mojatatu.com>
In-Reply-To: <1562999a-05d7-4d4e-8fc0-43c5979793b8@mojatatu.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 29 Feb 2024 02:05:06 +0530
Message-ID: <CA+G9fYtg2Uw0Qe_iJfqdfjiYcqVGcMXxd_YdC0gcb4f7E0_xww@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc tests
To: Victor Nogueira <victor@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	jhs@mojatatu.com, kernel@mojatatu.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, pctammela@mojatatu.com, xiyou.wangcong@gmail.com, 
	lkft-triage@lists.linaro.org, anders.roxell@linaro.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Victor,

On Wed, 28 Feb 2024 at 23:05, Victor Nogueira <victor@mojatatu.com> wrote:
>
> On 28/02/2024 13:49, Naresh Kamboju wrote:
> > LKFT tests running kselftests tc-testing noticing following run time errors
> > on Linux next master branch.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > This is started from Linux next-20240212 with following commit,
> >
> > f51470c5c4a0 selftests: tc-testing: add mirred to block tdc tests
> >
> > Run log errors:
> > ----------
> > # Test e684: Delete batch of 32 mirred mirror ingress actions
> > # multiprocessing.pool.RemoteTraceback:
> > # """
> > # Traceback (most recent call last):
> > #   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 142, in call_pre_case
> > #     pgn_inst.pre_case(caseinfo, test_skip)
> > #   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
> > #     self.prepare_test(test)
> > #   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 36, in prepare_test
> > #     self._nl_ns_create()
> > #   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 130, in _nl_ns_create
> > #     ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
> > #   File "/usr/lib/python3/dist-packages/pyroute2/iproute/linux.py", line 1593, in link
> > #     ret = self.nlm_request(msg, msg_type=msg_type, msg_flags=msg_flags)
> > #           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 403, in nlm_request
> > #     return tuple(self._genlm_request(*argv, **kwarg))
> > #            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 985, in nlm_request
> > #     for msg in self.get(
> > #                ^^^^^^^^^
> > #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 406, in get
> > #     return tuple(self._genlm_get(*argv, **kwarg))
> > #            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 770, in get
> > #     raise msg['header']['error']
> > # pyroute2.netlink.exceptions.NetlinkError: (34, 'Numerical result out of range')
>
> It looks like the ip link add command is returning ERANGE.
> We have tested this in NIPA for sometime with 64-bit and this is the
> first time
> we are seeing this:
>
> https://github.com/p4tc-dev/tc-executor/tree/storage/artifacts/485544
>
> Could you give us more information on how to reproduce this?

Steps to reproduce:
-------------

# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U  \
  --user tuxrun==0.62.2
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
#
# Please follow the additional instructions if the tests are related to FVP:
# https://tuxrun.org/run-fvp/
#

tuxrun  \
  --runtime podman  \
  --device qemu-x86_64  \
  --boot-args rw  \
  --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2czN3tP1CXUNgatiVGk7ANylgIu/bzImage
 \
  --rootfs https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.ext4.xz  \
  --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2czN3tP1CXUNgatiVGk7ANylgIu/modules.tar.xz
 \
  --parameters SKIPFILE=skipfile-lkft.yaml  \
  --parameters KSELFTEST=https://storage.tuxsuite.com/public/linaro/lkft/builds/2czN3tP1CXUNgatiVGk7ANylgIu/kselftest.tar.xz
 \
  --image docker.io/linaro/tuxrun-dispatcher:v0.62.2  \
  --tests kselftest-tc-testing  \
  --timeouts boot=15 kselftest-tc-testing=20


Links,
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2czN6g0MY3kgnwGYHadaUQHfPOU
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2czN6g0MY3kgnwGYHadaUQHfPOU/reproducer


>
> Note: This doesn't seem to be related to the patches in question.
> Seems to be a generic thing with nsPlugin itself.
>
> Thanks,
> Victor

