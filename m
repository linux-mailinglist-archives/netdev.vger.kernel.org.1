Return-Path: <netdev+bounces-102038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB56901337
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 20:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790F11C20B66
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD21CABA;
	Sat,  8 Jun 2024 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="s50xo1m0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C71C696
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717870791; cv=none; b=Q3BEEu6LD+RhOW9c012nu6rBohT3ZMTMPpf1Tox39vm+YUR7DP8TM+JJS9Nv8/UXLpZQYXKCsREO86rZPO2x83AJGF+Hhr6B6pKwYPdrkbmNO9Lyec+YhT26xKEBTWeJPLDfkp5ZOnpMFh6DxfwIBPYZ/gCfG1qdyfItaPXFRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717870791; c=relaxed/simple;
	bh=60kDRbMMvgm6QJOHPpiWh1H9Y8+f7TECVQuH+9otJ4I=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZFyUodafzOy9VtlZilUrSh8I9nJLeL8AHP2dmB1wrSa/KtSNHlAu/FS6oLLPRlW8Z/3Lqw857FCGXvlZJBnFDwmdFJY3Iy7H3xgS+Ba03qjos+KHyNrE/asQU8buE8xnKGbX+OPLv63T5wpN3LYFpREZuorx40USj8UNW2x93Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=s50xo1m0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c68327d1aso1088990a12.3
        for <netdev@vger.kernel.org>; Sat, 08 Jun 2024 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717870788; x=1718475588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3QtwmDL0API+mZdKoSplk54d4aIIr/RT3oeBqPC2kY=;
        b=s50xo1m0xTUCZuL6ilhQdJwE++gGvAtkPEtM/ZOpGaPCObh341JXiYKR9sXTiUzto5
         PvfMeywFJw/jZfYu37ordxrGp69ALHfafvBFy33CJf7q0w+3HhegpRQzBpTLmKWSHrdZ
         XJjij894XIXazbk5uYzleFqc6ZVZJ6xMVHOfyXL4KB777JIXh7PZmlXGg09SWVTbd8mH
         5lXZRnAq+8cRHHolm2r+onQHymnxIGh8VyyRxj5HqvLiXX0IzwC9VYfIjMe7ko07RgJL
         UKLEG2/rcLNBSHXGGINEuwwLt++mIWePl9u+unYlP+f+2pSv17AmQCIcdbF9tzN5QScs
         HM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717870788; x=1718475588;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3QtwmDL0API+mZdKoSplk54d4aIIr/RT3oeBqPC2kY=;
        b=RDaQfYNUYtCUMdbQS9L+NM2ChYVcFpFlBxBePgFpwbENE3KaQH+CFvqY6HkPb++Zek
         X76sgSCG5qiwk2gzCs9YnzT16gQNeD7Z+x5lvH7IcpNweTLE+c43qH+wggUPgZy/h4dF
         4dOpDXNSllbw8ce9p48G9sEEMAfMIEGuMpSenX0F1VkcjPtPcC13ICpFF7DWgZ4qWpRn
         fVCGE/RDXWZXBJbi0rA+uKXo+PIYCbytqjN3+KtAznOKSKztTtb3PX4SJXbBtI1I/X5b
         Ojs1jKw5PvQAeFFX+A8uBEaTO/GiTEA7F3gbVgShFSPqht/14GzGBEM3VyHVcDQXQkQn
         peGA==
X-Forwarded-Encrypted: i=1; AJvYcCUPCf2gIvuss47EzAanryoz2EJ8l9tqcG0RoC0ri2TwYX4mhNjsOD1ojPiU4CJZSjvbaoU3wPNxR2G5eGb6+MK75IYSa9IS
X-Gm-Message-State: AOJu0YyCC6mVpFnzWM9ijFWQudBPEjdGajI8WNauPV0ahbQ0m/GKQcPt
	BF9+SuiZeqC2ksUZEoIRCgl9+oa4O9SlXLkm+xwz52sFYnLJf9hM9FPlcyMrTAc=
X-Google-Smtp-Source: AGHT+IEaFVDSEclURPDGjTFY7NKVfypetqC3fXT4pVooDvUfMianoN2oMx1tOrYoczutiQxbmTo50Q==
X-Received: by 2002:a50:8a93:0:b0:57a:30fb:57f with SMTP id 4fb4d7f45d1cf-57c509a65efmr2956761a12.40.1717870787671;
        Sat, 08 Jun 2024 11:19:47 -0700 (PDT)
Received: from [127.0.0.1] (u13956.alfa-inet.net. [193.33.64.87])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0c9f95sm4516437a12.28.2024.06.08.11.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 11:19:47 -0700 (PDT)
Date: Sat, 08 Jun 2024 21:19:42 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: syzbot <syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: =?US-ASCII?Q?Re=3A_=5Bsyzbot=5D_=5Bnet=3F=5D_WARNING=3A_suspici?=
 =?US-ASCII?Q?ous_RCU_usage_in_br=5Fmst=5Fset=5Fstate_=282=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <000000000000cfb785061a64415a@google.com>
References: <000000000000cfb785061a64415a@google.com>
Message-ID: <E54F417D-8F71-4A15-8A12-30D21AB3D08D@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 8, 2024 8:29:23 PM GMT+03:00, syzbot <syzbot+9bbe2de1bc9d470eb5fe@s=
yzkaller=2Eappspotmail=2Ecom> wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    8a92980606e3 Merge tag 'scsi-fixes' of git://git=2Ekernel=
=2Eor=2E=2E
>git tree:       upstream
>console output: https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D14f9eab=
a980000
>kernel config:  https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3D9a6ac42=
77fffe3ea
>dashboard link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D9bbe2de1bc9=
d470eb5fe
>compiler:       Debian clang version 15=2E0=2E6, GNU ld (GNU Binutils for=
 Debian) 2=2E40
>
>Unfortunately, I don't have any reproducer for this issue yet=2E
>
>Downloadable assets:
>disk image: https://storage=2Egoogleapis=2Ecom/syzbot-assets/e77750e429bf=
/disk-8a929806=2Eraw=2Exz
>vmlinux: https://storage=2Egoogleapis=2Ecom/syzbot-assets/910e4410cf78/vm=
linux-8a929806=2Exz
>kernel image: https://storage=2Egoogleapis=2Ecom/syzbot-assets/85542820b0=
d5/bzImage-8a929806=2Exz
>
>IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
>Reported-by: syzbot+9bbe2de1bc9d470eb5fe@:=20

Oh, my fix was incomplete, I should've changed the deref helper as well=2E
I will send a patch tomorrow=2E

Thanks!


