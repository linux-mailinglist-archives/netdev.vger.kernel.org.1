Return-Path: <netdev+bounces-280219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tj9ML/DJ52lKAwIAu9opvQ
	(envelope-from <netdev+bounces-280219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0A43ED64
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 21:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DDC2300C6EA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A23242BE;
	Tue, 21 Apr 2026 19:03:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983A26ACC
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798185; cv=none; b=GnTNCGROgliGVCOBuQdmh8Cre/zBjAJsi0jRtusk8JVIfocbTXU6Fzgl28rG8b4JWLCsA6kOMe1w5kBAQ5LeF8qL/2LmcRiwy2hZwhDpqwXy1aWq2IOPP7wiS36Q4iym6K3GwSP7NzTeJz58gUlRjCkPGa9oKu8DDq1dVtP7o5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798185; c=relaxed/simple;
	bh=+szDRLzHiZIAqHJDTu3m/bEvTHMAIpDC/Vn7BRp3Pls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SB20GuRKf6ageEnr/qYa5d9+1Sr3PcdeE+3R6rNaUC3fPConLdImm8NucsCjH8P65LL2Bz4iJF67kit046Mjz/1mZ+8a5sy3mYoEDv3gXa5E7B7IXp4ItgBu/XqW8iE5j9ZvgtlbxBaaWlsrwnoPOi33qPUpcYELHqkH8lQFQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-467e226743eso6605889b6e.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 12:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776798183; x=1777402983;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG8mTfwfBFzvMp4QCKORmlTF3aYuTNF94d68znk7hg8=;
        b=EzgaxBbSmjQNR6+2o5zpdvfLmIYE10nQCaAJ+aQQrAYTcOn5lbo1+zJbS/Y5fs0d6C
         f6rVsVl36yMuiamS2MWkH+f85gOKf9qP41ZC/RfNpPHBJWMmHcH9XHMv/KparuKDsAdT
         oCrbOE2qXk4Z0GVY2DNIxd3QAV31WICCRsUHrKKCSjrmMma+kjwJ967w3oXDXqEEGskq
         or9uXq4Jw6fZoVFbdl3WT13hzHkYS7Eh/NHdhag5CYktHkZ4cP+PA7uao0b4908kpTm+
         Wm8bhBXFHVqTq7APCxQjS/qO2X2x9nM+13ySKuVjL0Nvdo0w04Rz2FkvASQiW8cINcDN
         b/cg==
X-Forwarded-Encrypted: i=1; AFNElJ+cO9yioHb7e4g/XAAwP+8bhCsFuAZ2z9gpUW8jIjQWALoU2sKTboMv2DBC6n0k5SH5uhnQ6kE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9zEK4QXWM5DUZhFAVeidKl3D5YHzehUfRd7sTretA0S/UOB9
	VhNuu6rWBRZyMPbI2IovmzBSCaOWsiuWwxYiiFB7Bz5qAOU9MKRqU/6NbTKf10HIR4cvYGtQGci
	VsU1HL6ZADhAHqcAnXbOJJyX5CXGHlUDux/Up03b76pNN/7nPeWpSUXJgUbI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:159d:b0:46a:d9fc:1423 with SMTP id
 5614622812f47-4799ca4b7f1mr10611990b6e.33.1776798183245; Tue, 21 Apr 2026
 12:03:03 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:03:03 -0700
In-Reply-To: <aeerTzpq8B-WTKeC@x1>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e7c9e7.a00a0220.17a17.001c.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] BUG: sleeping function called from
 invalid context in vhost_get_avail_idx
From: syzbot <syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com>
To: jasowang@redhat.com, kohei@enjuk.jp, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=95ee3fe1c5a8ab57];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280219-lists,netdev=lfdr.de,6985cb8e543ea90ba8ee];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,golang.org:url]
X-Rspamd-Queue-Id: 59F0A43ED64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to copy syz-execprog to VM: scp failed: failed to run ["scp" "-P" "3=
6338" "-F" "/dev/null" "-o" "UserKnownHostsFile=3D/dev/null" "-o" "Identiti=
esOnly=3Dyes" "-o" "BatchMode=3Dyes" "-o" "StrictHostKeyChecking=3Dno" "-o"=
 "ConnectTimeout=3D10" "-v" "/syzkaller/jobs/linux/gopath/src/github.com/go=
ogle/syzkaller/bin/linux_amd64/syz-execprog" "root@localhost:/syz-execprog"=
]: exit status 1



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
 -ffile-prefix-map=3D/tmp/go-build4123752491=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at 5be7a9deb87
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D5be7a9deb87612d05fcc86125226d72bc2297875 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20260417-202028"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D5be7a9deb87612d05fcc86125226d72bc2297875 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20260417-202028"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D5be7a9deb87612d05fcc86125226d72bc2297875 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20260417-202028"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"5be7a9deb87612d05fcc86125226d72bc2=
297875\"
/usr/bin/ld: /tmp/ccUDlBPa.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         4ee64205 Merge tag 'clk-for-linus' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D95ee3fe1c5a8ab5=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D6985cb8e543ea90ba=
8ee
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D122eb4ce5800=
00


