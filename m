Return-Path: <netdev+bounces-99368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519878D4A56
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1041F217DB
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F317D355;
	Thu, 30 May 2024 11:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBD17C7BD
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067946; cv=none; b=knJUtiWhPSuBWuyFOvpMUcaateq41TWXeEKjyLhx8dyu7p/Vrw66L6wPf6dipzZqMW6dQrogXaIlVq96FHkkxWndK3ajj/uisVjT0FrpBpvbTgiVhBw0D4G6wvJl/J2mrd6z+Sl3rksxREbxMyb8/zuHYVTEqTr2NB1oQGXeh34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067946; c=relaxed/simple;
	bh=TZtErRrn9BuJ/shP328m+ALlU8XeK7qyK1b+NpnFhSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Anq88AQbwLf/KstwvSN+hEYDDCL3JIgFw43sxbpTu5IBahQCA6T83+30Z3YR/hCUjbr7kYdef4s1BKpJ8+oXT0qu+3dAWd+5PBAdxhfmU8k+60GUXOBHQig1FL/aydDX0gr2ETIA7u0CNLTiHx6FFgjsfnGxSpPz075IwsnvgDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36db3bbf931so7547195ab.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 04:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717067944; x=1717672744;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1L0yw6JjJQlCzbvwK7356fjD9g4ArNEcx738vKMeXw=;
        b=VGYusohNFH88GSMY0oPN5YeT7BR08ThIss+HaInGRkygsdOqVmKBQuDqdZBCyUkgn2
         HAEdsLRBdoLDBZo1PQbDED0xQ8QRLVlQi68GUWJovL1P4iv00vpk9BqGAXQpeABJR5Rn
         zE9F/tMaj5aiJVIflQc0eFLl1u6sXrQlmnSKgIVCCaLzmWDNqdtQVPQjxZyAVUalGiyW
         BhulUs7CRM/G06qSkuKp5srhbQdw/OsKHP7ZPWMuGzh79w+8UseXRB/5dTF3L62pr0ZA
         J8GztSfAl7N/XOVpX2i7AOsq530bMsUZRBzOFViP/N8etJbn0GLQio/u0uWiHyFWY3wt
         METQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1qBwKhdUhp7BFF5Q7dWk6HbtD5x8PL43WCehs6RiKYvLFmFsb3ESle6sNWkc6dFDt/4Vq+L8RiEtdtqDwGNOg4Bh+vrfR
X-Gm-Message-State: AOJu0Ywg/J3jHnTHegh9nsbmHp/vMFw9Iq6bed2a+TmG72mmRnm/NcdN
	GGCstDCOU9YYNg2IUujA0+ShgBCK6sA2XOlKZGHwFKQPWbTM35SyZ6eyiZxut8OPOGm2jdKuT5u
	wLz2f7hoxs0kRkgkeB6Fsn+N9799u+HHGXw2SnY+NPBDyNweKjdVCUyI=
X-Google-Smtp-Source: AGHT+IGoruQB8wc9P6Fc34Pgy2yGZlJ0WxM82Qhla7Kg4rsoY2Qau3B865zduG5CuwoWwkr18e5imYir+RPrwWNGzzhIQV5BXKPg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-3747dff6adcmr1315115ab.6.1717067944216; Thu, 30 May 2024
 04:19:04 -0700 (PDT)
Date: Thu, 30 May 2024 04:19:04 -0700
In-Reply-To: <20240530103435.3077-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dedcea0619aa08aa@google.com>
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
 -ffile-prefix-map=3D/tmp/go-build1459151336=3D/tmp/go-build -gno-record-gc=
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

commit:         13c7c941 netdev: add qstat for csum complete
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.=
git main
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D98a238b2569af6d
dashboard link: https://syzkaller.appspot.com/bug?extid=3Da7d2b1d5d1af83035=
567
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Note: no patches were applied.

