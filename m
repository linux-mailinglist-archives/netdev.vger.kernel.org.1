Return-Path: <netdev+bounces-96195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BCD8C49F7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E01F220D2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7585272;
	Mon, 13 May 2024 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="EuEuIpBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278F82488
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642257; cv=none; b=JaRx5HPyY7IqAIY9Nf0u6IOR3pENTuLA6SSeFZHpist/U4sRbwwWVqfvb/igPqLx2wmJRcCX30Ocm79/CnWHKiFYKVqMSjobkZlNuMYukToZaZ5hyJGAMKzpc+bzBSwH2XcBLJRmchSw0xEJeSxzaMKPYIVMJv6eIGeJbn0E9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642257; c=relaxed/simple;
	bh=8sFnwkIDJcTw29YECKZQzjAe1IutNxyRQnDAajustyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mrLeq4zTP7TTr3cGmJGQr/CJiUPC9KFkhKENA4kJr4SubScEyNZwOXm0O3RIhMNgybhU+rbFxpJE9oFUM7AWgDfmLog8lnuT5FJilSJLx5C8PUj9j7cejcgq4GPOVm/dn/uctyuWNefl9BEqARMyv4CQud6ldtIAMiHKPhTLYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=EuEuIpBZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so28247335ad.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1715642255; x=1716247055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDihUHCvdxt2IeYI4uIVgM+JJKGx/hS/rMFzo2PjzSM=;
        b=EuEuIpBZYmjOoLdnMvVa3uy1KB0IgEYCeuiqFF+0+Zkv5cQqtQXcvO5EL2uDQ8wzV1
         fhS9DCEoiJIIjYAilzkfk0i5oAnaInPW9NzcbO4wKcbh/Yp0AVXx57CyPtx1hC5phLI2
         TXnkZ+wz2sMuZWGBXwMjK3eMqvW0F43+/zw17OLIwPPSVUx0necS8L7cu//Ekm+ApoZc
         vwx/DfnBtwzt8NKQbVdP97AMevjMiq/Ke1aPGQjBdxO7q1x5lsoa7F9W5MwxVzWPcd0I
         2DHOYq90qQXTcSqSWyhEFTqaA66SXYo6BzWjcmeSVjePePdOPS1abkWaSOid+LDnZqPz
         3jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715642255; x=1716247055;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDihUHCvdxt2IeYI4uIVgM+JJKGx/hS/rMFzo2PjzSM=;
        b=MCsIrXbGEjDauG/scMCtm684a3fBsqnNn/9W4fxM2FSRnXc6e+Sqgi8JhKfrerGxNn
         rL+l/+kGwu5h1o3bmGIQzfVXkbgUQwvPlwhkDdNvNFeiRdKPfClc5NrH8E2ahLsc9Nqi
         3G/JmTApe9eD9hTT3tRUo00JA6WFI0M6aW5AydO5eqhpILdvblrSfF84kLYFYQzZXEIi
         mEKxCNX74shxEID+VsCeDPkNc91yEGSrgzWAzpitDCnSV96UzEBY7YKZhbOEpCivlGdF
         OJSB49whn0ZX7W/huLtoYNL8KGKqjP3HJEm0pNFBFL5gQzTvmmlQHYgX6nGJ9Mtirdh0
         M3ag==
X-Gm-Message-State: AOJu0YzxgR/c2L+wXmeluR/DfPw1AAj7eFkOXUxqMfJKDQBWXS40WemC
	h7l5ojailhTE+LeyCGnf+531l9yTAt5I5KNHkvebuVcpbJDcvKo5Aojapl+ftkOHinJJha/vL/f
	IO0t72Q==
X-Google-Smtp-Source: AGHT+IFFnZRJTVRyntxhf+EtmWKMusVyx3nhf1DT07cytdA+foeNpy4zjVFTT8kJK0pZYdZPVfYy0A==
X-Received: by 2002:a17:903:190:b0:1eb:d72e:82ae with SMTP id d9443c01a7336-1eefa03a3b3mr213467195ad.13.1715642255131;
        Mon, 13 May 2024 16:17:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30ca3sm84929035ad.151.2024.05.13.16.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:17:34 -0700 (PDT)
Date: Mon, 13 May 2024 16:17:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iporoute2 6.9 release
Message-ID: <20240513161732.4a4dd47a@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is regular release of iproute2 corresponding to the 6.9 kernel.
Release is smaller than usual, usual documentation and bug fixes.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.9.0.tar.=
gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Aahil Awatramani (1):
      ip/bond: add coupled_control support

Andrea Claudi (1):
      man: fix typo in tc-mirred man page

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      man: use clsact qdisc for port mirroring examples on matchall and mir=
red

Christian G=C3=B6ttsche (1):
      ss: add option to suppress queue columns

Date Huang (2):
      bridge: vlan: fix compressvlans usage
      bridge: vlan: fix compressvlans usage

David Ahern (2):
      Update kernel headers
      Update kernel headers

Denis Kirjanov (7):
      ifstat: convert sprintf to snprintf
      nstat: constify name argument in generic_proc_open
      nstat: use stack space for history file name
      nstat: convert sprintf to snprintf
      iproute2: move generic_proc_open into lib
      ifstat: handle strdup return value
      ifstat: don't set errno if strdup fails

Jiayun Chen (1):
      man: fix doc, ip link does support "change"

Justin Iurman (2):
      ip: ioam6: add monitor command
      man8: ioam: add doc for monitor command

Luca Boccassi (1):
      man: fix typo found by Lintian

Max Gautier (1):
      arpd: create /var/lib/arpd on first use

Quentin Deslandes (3):
      ss: add support for BPF socket-local storage
      ss: pretty-print BPF socket-local storage
      ss: update man page to document --bpf-maps and --bpf-map-id=3D

Stephen Hemminger (24):
      netlink: display information from missing type extack
      ifstat: support 64 interface stats
      rt_names: whitespace cleanup
      tc/action: remove trailing whitespace
      tc: make qdisc_util arg const
      tc: make filter_util args const
      tc: make action_util arg const
      tc: make exec_util arg const
      README: add note about kernel version compatibility
      netem: use 64 bit value for latency and jitter
      tc: remove no longer used helpers
      tc: support JSON for legacy stats
      pedit: log errors to stderr
      skbmod: support json in print
      simple: support json output
      tc-simple.8: take Jamal's prompt off examples
      uapi: update headers
      uapi: update vdpa.h
      ila: allow show, list and lst as synonyms
      mnl: initialize generic netlink version
      use missing argument helper
      uapi: update vdpa.h
      uapi: spelling fix for xfrm.h
      v6.9.0

Victor Nogueira (3):
      m_mirred: Allow mirred to block
      tc: add NLM_F_ECHO support for actions
      tc: Add NLM_F_ECHO support for filters

Yedaya Katsman (2):
      ip: Exit exec in child process if setup fails
      ip: Add missing options to route get help output

Yusuke Ichiki (1):
      man: fix brief explanation of `ip netns attach NAME PID`


