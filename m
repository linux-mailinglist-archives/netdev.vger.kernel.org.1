Return-Path: <netdev+bounces-265437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIT3CMWVrmnRGQIAu9opvQ
	(envelope-from <netdev+bounces-265437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:41:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1EE2365AB
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68C073040022
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D58637B3EE;
	Mon,  9 Mar 2026 09:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D0377ECC
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049144; cv=none; b=bXsRE3YDCubU6uUn6qUE/XVzr7bsdYEoL+O0kz9ws8D4ROTrbH7xhRVWLlw/tv/ovYNs8H2BqvoEs+1VwM0VA0qRWF2Ui7Ku6zLYEoFjWn6U7n2rYDFfVsZaKCmXmYvH9smVzeDfF/e4ZEAco01XsUDZWUD5XEC+Vuz5RcIAlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049144; c=relaxed/simple;
	bh=mhcSW5ofChxPY7nazYhgsZIcrw+YsIdHRnnge4PT+XE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VhL8mZO3CEZ6o6NKxCNI64zTTL1JSIEHh+zhSw7B5aV4+ED2xVj/izY/FMv5Qjc8R+1SXTEvuTAvwPE6RN6DEhKPvzdZrVYsLfCjzL0FCCGvk/8DS16VuvbHoXUw2hAgvlEsNa048WXuMVP4q86aBJTamj3x4uQwsAS746L+IhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d74cd7b1e3so2952260a34.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773049142; x=1773653942;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fulRvnbfDto4isKubtnsqcm+jpd2DtUBe+QZPggWKQ=;
        b=g54PBqpBPs5bQkVd/pcwnvUnm4k1U8iDU7b6jsf8U3Mmm2qlvEIvgABrVRhqnXYsMJ
         h9qvrMKt1VdWD0jm0qWJ+h/gYnit3T1GFYva6SVLPQS9jUdliMeE5Rc03Ss5KRmELV2p
         y+vxM43PN/N9h1fQ4PxgqVG1n2Zids7u28MUKdwwLT0y3Coany0+pN+duOR970xOt/j0
         Fbc/xo0AYTMAIkGtl1/KbCsrCWaA+QO0YADCHo8pkPCxlBtbYqOOUN+0qLGRD6cALfaJ
         EFW/0009lFVWgO5F8Ezyy7MlA0fL42ba4ORcE1UUe8wG62P0MTGvaaKZgzEl2fAUGP0o
         FRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdjh++8hiZ9l5mHwG4h8JDacaJ7qOQ1iE14zT9fqr5WdJ2AxKFelHrVf00iABOUIiNGPBMin0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytqv/8n8XNenK2uNecdTMheRzxgKf4GZ9n58gOAwEwC92j+Mm+
	CDXG0TmZyybglNeU5o7DcXYIR6l6IHbCI4GkjWenv61L3vy04j1obKVWerpsBUp+k1jrmMP+qeQ
	HGwKGUzWJVg7NT6ck9OldbRFur4ZBqdsFdtAEBNhC9lKdq4OofVEus8wM2w0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f023:b0:679:a5a6:8331 with SMTP id
 006d021491bc7-67b9bd6c368mr6747365eaf.64.1773049142109; Mon, 09 Mar 2026
 02:39:02 -0700 (PDT)
Date: Mon, 09 Mar 2026 02:39:02 -0700
In-Reply-To: <hsaps6s7nptbzfp2mdx3b7ah3u2e6ydxj4ww2hho3ou3l7la6m@b3fw343ncpja>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ae9536.050a0220.310d8.001e.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 sock_def_readable (2)
From: syzbot <syzbot+f50072212ab792c86925@syzkaller.appspotmail.com>
To: jiayuan.chen@linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8B1EE2365AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265437-lists,netdev=lfdr.de,f50072212ab792c86925];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.891];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,golang.org:url,localhost:email,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-execprog to VM: failed to run ["scp" "-P" "48817" "-F" "=
/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "IdentitiesOnly=3Dyes=
" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o" "ConnectTim=
eout=3D10" "/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/bi=
n/linux_amd64/syz-execprog" "root@localhost:/syz-execprog"]: exit status 25=
5



syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build3224921581=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.26.0'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 7c9658af8505
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D7c9658af8505abccd5bf5890cc8a8e6d9826eaa0 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20260223-092328"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D7c9658af8505abccd5bf5890cc8a8e6d9826eaa0 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20260223-092328"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D7c9658af8505abccd5bf5890cc8a8e6d9826eaa0 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20260223-092328"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"7c9658af8505abccd5bf5890cc8a8e6d98=
26eaa0\"
/usr/bin/ld: /tmp/cc2JgryH.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         1f318b96 Linux 7.0-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc5c49ee0942d1cd=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3Df50072212ab792c86=
925
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-=
1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1528375a5800=
00


