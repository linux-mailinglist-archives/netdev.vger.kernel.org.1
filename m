Return-Path: <netdev+bounces-140779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1929B807F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6FE1C21AF4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD31BD032;
	Thu, 31 Oct 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgOScP/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4CC1BD4F7
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393131; cv=none; b=TEsucMGKjWXuaTb9Ua9tg5xqQ5UsEAcP+oIfRh9Gax6cY5ybt5CNDCyVRj2BODYlHHjosonllizOd2+Ee7ce9z9NnqIWEXL+OqqfI08rtQlxuAdgIJKEJmX14dRRm95jGRasVmjAxPxdAJoZ0nkIWCdEUMhnMLnAMM1XEu5PIEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393131; c=relaxed/simple;
	bh=rkdqG/nrgIcJqGiS/dstGzJE2Pk4kvgZxSdqcJxcBuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5Mc3dIV3+Yw7UhlALmtPD39MS48TE28od9AHFTTOwslXf/KNmjIJhFvZ0YTvW1ZTHBv5VCeb1jBApIKtVTe9eiNmENWdlk8itW2ibstdHBlyWf0jhKC2/bWazT7qrm8Ik5WeHdYHN3KQHrc4Ma3zmP/CA2ue1xKiMCsymmCMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgOScP/2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460b295b9eeso581cf.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730393126; x=1730997926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajSNpZ+3WMV4SP4tjIDU9tWATJdss3I7t5t7CZg1K/c=;
        b=bgOScP/2JM0L3JJj/LvvA0/jas9W+D1S5C71iEi5YHbtbA+wQVl8iH7J+Ka5/lCDQH
         evoNB1R2GnmLIb/dS8w6z9LLoMxTEyYpgNHz8fLXsTVI62jxgdRdEtBF+iuvfZpF+0x3
         +HwDOvRpH05LqXTZiXVsVUhaDMV/enEvhaMu8mPhNrF4OacYlgRSyra/ofQRPWlnOul0
         NHoxZZzV3fyUQd2r9mS+uYURMnlqFemxlLcxQvlHUWdq413ikJy4GiKFhib/Zwvf3UWv
         AUIhAZbDeD1LRTyjiV+2B8nVEckVmmsJVYt7b0EQGQ6n/3tJiUUY3g3lbeYWGGcnCGIS
         QNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393126; x=1730997926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajSNpZ+3WMV4SP4tjIDU9tWATJdss3I7t5t7CZg1K/c=;
        b=c9AxcZ2ygDb5qEklRlKrEVL575PUgK4IoG9yDMJbfOFYSxDAhM8G0PiVZUONVx3zPt
         4TXxjJddnL8mEJBf02UioBJERsqlGB5po//AnIKrIDm4eThTVFFe4QHdVoeApa2MOMFb
         isDVEfr3KReB5EcEFUrStwUl2XTsGSfkRIstHGt5EWQhM/2URyEnw11uQe1MD5DCTp4P
         w04DrBeBiRH3desybsZqz3g7Tm0B2U3zpfSlm1idJb8WVt4G1/+cgYjvmosbhLCl60Ap
         /XqEvThQKiKugOJ05zyXRZXnpE5msJnQbCJb3Upv4FT+4LfE/fyaEZmU+jncKacczTff
         kucA==
X-Forwarded-Encrypted: i=1; AJvYcCXN3j3yUaaPWh3LVylo1HZeaNSohatBK5KNCc3H9Aqle2+Q4lMZjKdPdQWpooObk9otAq+kmLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ltYrvvznHZtjCs0TalUnNRUKjQjMganM/tsRc1N2qMBipgPs
	qsHUuxLL3dWGZmE0goQSRk4n5OLkBaxAkux7+UGi6xkXKBCnnN0fc751wE2QGoNSoltt0ZsiMAv
	U4bgXMCrApheVyri5inEv4bNU5Fy/ZeAwKBy3
X-Gm-Gg: ASbGnctNAxLoO2Sx9/b5kAyWtnZi5ERDDaVlJvkfyk3DQT7Sxe78iuZzhfjXaoEHVRf
	gNSUKk4MXeKN1qc/L0IRBDs4kIywDmq58mubvnGhiP1Ew3WcTcOuoeuIHPZuAUg==
X-Google-Smtp-Source: AGHT+IG/0R3i1ODpwp7LvGfwHIDqYpiF6xbdGWgqEnkqUJcQZ6mUNfG/1HplzFp3uMaUggF77XP54VKzykRwvgeAa/4=
X-Received: by 2002:ac8:5f0a:0:b0:461:6bb5:99ba with SMTP id
 d75a77b69052e-462ad0feedbmr3752101cf.5.1730393126111; Thu, 31 Oct 2024
 09:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030142722.2901744-1-sdf@fomichev.me> <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch> <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
 <ZyJSpBrhz7UJ0r7c@mini-arch>
In-Reply-To: <ZyJSpBrhz7UJ0r7c@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 31 Oct 2024 09:45:14 -0700
Message-ID: <CAHS8izPCFVd=opRiGMYu3u0neOP7yCJDX8Ff+TdURq2U-Pi27A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org, willemb@google.com, 
	petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:37=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/30, Mina Almasry wrote:
> > On Wed, Oct 30, 2024 at 8:13=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > On 10/30, Mina Almasry wrote:
> > > > On Wed, Oct 30, 2024 at 7:27=E2=80=AFAM Stanislav Fomichev <sdf@fom=
ichev.me> wrote:
> > > > >
> > > > > The goal of the series is to simplify and make it possible to use
> > > > > ncdevmem in an automated way from the ksft python wrapper.
> > > > >
> > > > > ncdevmem is slowly mutated into a state where it uses stdout
> > > > > to print the payload and the python wrapper is added to
> > > > > make sure the arrived payload matches the expected one.
> > > > >
> > > > > v6:
> > > > > - fix compilation issue in 'Unify error handling' patch (Jakub)
> > > > >
> > > >
> > > > Since I saw a compilation failures on a couple of iterations I
> > > > cherry-picked this locally and tested compilation. I'm seeing this:
> > >
> > > Are you cherry picking the whole series or just this patch? It looks
> > > too broken.
> > >
> > > > sudo CFLAGS=3D"-static" make -C ./tools/testing/selftests/drivers/n=
et/hw
> > > > TARGETS=3Dncdevmem 2>&1
> > > > make: Entering directory
> > > > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selfte=
sts/drivers/net/hw'
> > > >   CC       ncdevmem
> > > > In file included from ncdevmem.c:63:
> > > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftes=
ts/../../../tools/net/ynl/generated/ethtool-user.h:23:43:
> > > > warning: =E2=80=98enum ethtool_header_flags=E2=80=99 declared insid=
e parameter list
> > > > will not be visible outside of this definition or declaration
> > > >    23 | const char *ethtool_header_flags_str(enum ethtool_header_fl=
ags value);
> > > >       |                                           ^~~~~~~~~~~~~~~~~=
~~~
> > > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftes=
ts/../../../tools/net/ynl/generated/ethtool-user.h:25:41:
> > > > warning: =E2=80=98enum ethtool_module_fw_flash_status=E2=80=99 decl=
ared inside
> > > > parameter list will not be visible outside of this definition or
> > > > declaration
> > > >    25 | ethtool_module_fw_flash_status_str(enum
> > > > ethtool_module_fw_flash_status value);
> > > >       |                                         ^~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
> > > > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftes=
ts/../../../tools/net/ynl/generated/ethtool-user.h:6766:45:
> > > > error: field =E2=80=98status=E2=80=99 has incomplete type
> > > >  6766 |         enum ethtool_module_fw_flash_status status;
> > > >       |                                             ^~~~~~
> > >
> > > This has been fixed via '#include <linux/ethtool_netlink.h>'
> > >
> > > > ncdevmem.c: In function =E2=80=98do_server=E2=80=99:
> > > > ncdevmem.c:517:37: error: storage size of =E2=80=98token=E2=80=99 i=
sn=E2=80=99t known
> > > >   517 |                 struct dmabuf_token token;
> > >
> > > And this, and the rest, don't make sense at all?
> > >
> > > I'll double check on my side.
> >
> > Oh, whoops, I forgot to headers_install first. This works for me:
> >
> > =E2=9E=9C  cos-kernel git:(tcpdevmem-fixes-1) =E2=9C=97 sudo make heade=
rs_install &&
> > sudo CFLAGS=3D"-static" make -C ./tools/testing/selftests/drivers/net/h=
w
> > TARGETS=3Dncdevmem 2>&1
> >   INSTALL ./usr/include
> > make: Entering directory
> > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/=
drivers/net/hw'
> > make: Nothing to be done for 'all'.
> > make: Leaving directory
> > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/=
drivers/net/hw'
> > =E2=9E=9C  cos-kernel git:(tcpdevmem-fixes-1) =E2=9C=97 find . -iname n=
cdevmem
> > ./tools/testing/selftests/drivers/net/hw/ncdevmem
> >
> > Sorry for the noise :D
>
> Whew, thanks and no worries!

Sorry, 2 issues testing this series:

1. ipv4 addresses seem broken, or maybe i'm using them wrong.

Client command:
yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 | head -c
1G | nc 192.168.1.4 5224 -p 5224

Server command and logs:
mina-1 /home/almasrymina # ./ncdevmem -s 192.168.1.4 -c 192.168.1.5 -l
-p 5224 -v 7 -f eth1
here: ynl.c:887:ynl_req_trampoline
using queues 15..16
Running: sudo ethtool -K eth1 ntuple off >&2
Running: sudo ethtool -K eth1 ntuple on >&2
Running: sudo ethtool -n eth1 | grep 'Filter:' | awk '{print $2}' |
xargs -n1 ethtool -N eth1 delete >&2
ethtool: bad command line argument(s)
For more information run ethtool -h
here: ynl.c:887:ynl_req_trampoline
TCP header split: on
Running: sudo ethtool -X eth1 equal 15 >&2
Running: sudo ethtool -N eth1 flow-type tcp6 src-ip 192.168.1.5 dst-ip
192.168.1.4 src-port 5224 dst-port 5224 queue 15 >&2
Invalid src-ip value[192.168.1.5]
ethtool: bad command line argument(s)
For more information run ethtool -h
./ncdevmem: Failed to configure flow steering

The ethtool command to configure flow steering is not working for me.
It thinks it's in v6 mode, when the ip address is a v4 address.
(notice `-s 192.168.1.4 -c 192.168.1.5`). flow-type should be tcp in
this case.

Reverting patch 9e2da4faeccf ("Revert "selftests: ncdevmem: Switch to
AF_INET6"") resolves this issue. Leading to the second issue:

2. Validation is now broken:

Client command:
yes $(echo -e \\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 | head -c
1G | nc 192.168.1.4 5224 -p 5224

Server command and logs: mina-1 /home/almasrymina # ./ncdevmem -s
192.168.1.4 -c 192.168.1.5 -l -p 5224 -v 7 -f eth1
here: ynl.c:887:ynl_req_trampoline
using queues 15..16
Running: sudo ethtool -K eth1 ntuple off >&2
Running: sudo ethtool -K eth1 ntuple on >&2
Running: sudo ethtool -n eth1 | grep 'Filter:' | awk '{print $2}' |
xargs -n1 ethtool -N eth1 delete >&2
ethtool: bad command line argument(s)
For more information run ethtool -h
here: ynl.c:887:ynl_req_trampoline
TCP header split: on
Running: sudo ethtool -X eth1 equal 15 >&2
Running: sudo ethtool -N eth1 flow-type tcp4 src-ip 192.168.1.5 dst-ip
192.168.1.4 src-port 5224 dst-port 5224 queue 15 >&2
Added rule with ID 19999
here: ynl.c:887:ynl_req_trampoline
got dmabuf id=3D1
binding to address 192.168.1.4:5224
Waiting or connection on 192.168.1.4:5224
Got connection from 192.168.1.5:5224
recvmsg ret=3D8192
received frag_page=3D15997, in_page_offset=3D0, frag_offset=3D65523712,
frag_size=3D4096, token=3D1, total_received=3D4096, dmabuf_id=3D1
Failed validation: expected=3D1, actual=3D0, index=3D0
Failed validation: expected=3D2, actual=3D0, index=3D1
Failed validation: expected=3D3, actual=3D0, index=3D2
Failed validation: expected=3D4, actual=3D0, index=3D3
Failed validation: expected=3D5, actual=3D0, index=3D4
Failed validation: expected=3D6, actual=3D0, index=3D5
Failed validation: expected=3D1, actual=3D0, index=3D7
Failed validation: expected=3D2, actual=3D0, index=3D8
Failed validation: expected=3D3, actual=3D0, index=3D9
Failed validation: expected=3D4, actual=3D0, index=3D10
Failed validation: expected=3D5, actual=3D0, index=3D11
Failed validation: expected=3D6, actual=3D0, index=3D12
Failed validation: expected=3D1, actual=3D0, index=3D14
Failed validation: expected=3D2, actual=3D0, index=3D15
Failed validation: expected=3D3, actual=3D0, index=3D16
Failed validation: expected=3D4, actual=3D0, index=3D17
Failed validation: expected=3D5, actual=3D0, index=3D18
Failed validation: expected=3D6, actual=3D0, index=3D19
Failed validation: expected=3D1, actual=3D0, index=3D21
Failed validation: expected=3D2, actual=3D0, index=3D22
Failed validation: expected=3D3, actual=3D0, index=3D23
./ncdevmem: validation failed.

I haven't debugged issue #2 yet, but both need to be resolved before
merge. I'm happy to provide more details if you can't repro. My setup:

mina-1 /home/almasrymina # cat /boot/config-6.12.0-rc4  | grep -i ipv6
CONFIG_IPV6=3Dy
mina-1 /home/almasrymina # cat /proc/sys/net/ipv6/bindv6only
0

--=20
Thanks,
Mina

