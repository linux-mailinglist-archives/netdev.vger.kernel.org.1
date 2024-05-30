Return-Path: <netdev+bounces-99395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB1E8D4BB2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C3C1F219A8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D9213211A;
	Thu, 30 May 2024 12:30:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF5132108
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072206; cv=none; b=DNGLce+czTy42Wid1gbbf3qEIq5Zgf6lu32540ak1tBulS5oOCJaZyFcVgEcuh+6k4dk+QuiEUGmbH1VJT9Nh3Ym2e3eZN5kLbJhCX4fP1WHQnn23bFnxn2EgHaZQsH1Dl1v4z14aV0wO4RqjB9150+ZBAB3OFapWoMQNff7rn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072206; c=relaxed/simple;
	bh=Z86/bwzoIGTeheQvIOSjk3VXeGotywVyGsYhpCc041I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kpAi+eaA3OqAy008qLjF2L3v8UaTbonqETKHrInXV0XSKKGHCMK75/NAF++eAHLzEhzEn1P63XzPG7LQ6dtn1HPj3ciRBHja71WmMe6bfgx0hMq8bAA49TnzUKWJdtI2xHGPHokqKMqMO/aEHTe7i/7hnQIqSXRKVWi0GHMa9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e25de500d2so105997839f.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 05:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717072204; x=1717677004;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eLhHAslkbviJaBdkblmjCqAmkbuuyjQmSFMgQ0wmIQ=;
        b=F86AJeC8DxVICLDWkjoWUOkLNm0Rygza1YMNn2HORRsOv089D8OH9I8D7YqYlO7+ff
         yDPG77stfvbsSfZJDvQN5aG+DUhXPqDoU/GdxoM9U76vUseGUeUkJZbIaChtraGn0hyI
         6Ie6mZYyx+0i9m2K74NEdGVGX5PjtpH4pgpI5N7taWGx8NgCzoq62XpzT+KJeL4Oz/r3
         UmHpH6beH7RroWyh8iVAGaKA4eHXRPzD72yP945fp7wZ9b7D7CEc0uwOjL/JA0Rf0XBi
         PtG8VxkYzLxleb2nA7cVDoLj0B+hZd6v6ts8zzwV0oqCv8zpAC92oXmLhuT0J5qPQey3
         yUaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRWf3U2lUOyesPGu7lT8AOFOvahjhmEU2Vhx4YTJDTvCeSz5R1PmSqeJ7Ae5Q2xb5Aynar8NpkW6bOqtyjZxsFstHBU9rc
X-Gm-Message-State: AOJu0Yz8IPjmosQr5o/eiegAND4roJAk2nbT76AAduTZNui6NYY6K+5G
	NSJQyFLkuonSRtTKHVkKutp+DD6AMtBP7eLVxlw/JpK+KaeVvGcLnndTus9n/nFT2F21udv83s2
	pj/HWQWr4nZXc0gF+JZ03eA3PVNE5vo9oWoaRYVQdhtP9n543z1+dFI0=
X-Google-Smtp-Source: AGHT+IHS64V4nxwqMzWi/qvVJE9dWbGyDcvb2zN0pVVaMptK0OvAt6EOKIAK320p7O628gefYufedum4ExJ+vooRgI+cGOSbFd+6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:ac84:0:b0:488:5bf6:f8ff with SMTP id
 8926c6da1cb9f-4b1ed16f4bbmr63451173.6.1717072204631; Thu, 30 May 2024
 05:30:04 -0700 (PDT)
Date: Thu, 30 May 2024 05:30:04 -0700
In-Reply-To: <20240530115726.3151-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfa04f0619ab0668@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
From: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>
To: edumazet@google.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, radoslaw.zielonek@gmail.com, 
	syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

lost connection to test machine





syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.21.4'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build2710826618=3D/tmp/go-build -gno-record-gc=
c-switches'

git status (err=3D<nil>)
HEAD detached at 4f9530a3b
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4f9530a3b62297342999c9097c77dde726522618 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231220-163507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer=
 github.com/google/syzkaller/syz-fuzzer
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4f9530a3b62297342999c9097c77dde726522618 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231220-163507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execpr=
og github.com/google/syzkaller/tools/syz-execprog
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4f9530a3b62297342999c9097c77dde726522618 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20231220-163507'" "-tags=
=3Dsyz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress=
 github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -fpermissive -w -DGOOS_linux=3D1 -DGOARCH_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"4f9530a3b62297342999c9097c77dde726=
522618\"



Tested on:

commit:         c53a46b1 net: smc91x: Remove commented out code
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-=
next.git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D98a238b2569af6d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da7d2b1d5d1af83035=
567
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D169aadec9800=
00


