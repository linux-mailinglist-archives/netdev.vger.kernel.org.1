Return-Path: <netdev+bounces-14993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF3744DFF
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E5280C50
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B920FE;
	Sun,  2 Jul 2023 13:46:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89623A6
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 13:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C31C433CD;
	Sun,  2 Jul 2023 13:46:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Zk5MeBPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1688305613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgyTZpYH4n9IkxjItDbDmUhF/fhQUb1wwAJFpzqh190=;
	b=Zk5MeBPwfSW2n6S0hurtfsv37B2KBfPoDKpwtPYaU4YjNrbK5UeNyWtPg3kZ9sEIzGgYmG
	eMZisM2BYTvZL15MxAQ08AXbrj/1WgSB83k0VM3+pD11YYEeiEDpHcVIq5sGjpA68cUOVr
	roKu6D7dy7GuGSzfcBs0KssjpjyC7eA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e873d92c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 2 Jul 2023 13:46:52 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-44357f34e2dso1151245137.3;
        Sun, 02 Jul 2023 06:46:52 -0700 (PDT)
X-Gm-Message-State: ABy/qLY3auxrqaLVcA6rMI+UM4RwdLmOhNkskQpdTgaF2micpxcJONfo
	gBKFa2qxJ3Iru/wP6BiQcOwvqWPFZL7NPG0qM7c=
X-Google-Smtp-Source: APBJJlGqQFeoUfE02AmvsH2pJ+qPAs8UdnGuzSAglr4yxRzNPQyJCtBP9XKz1B4Kp4ZazFDt6bCHMPcaSpg4TPOUzY0=
X-Received: by 2002:a67:f94c:0:b0:443:7e49:c023 with SMTP id
 u12-20020a67f94c000000b004437e49c023mr3929865vsq.6.1688305609944; Sun, 02 Jul
 2023 06:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5b76a4f-81ae-5b09-535f-114149be5069@gmail.com>
 <79196679-fb65-e5ad-e836-2c43447cfacd@gmail.com> <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
In-Reply-To: <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sun, 2 Jul 2023 15:46:38 +0200
X-Gmail-Original-Message-ID: <CAHmME9onMWdJVUerf86V0kpmNKByt+VC=SUfys+GFryGq1ziHQ@mail.gmail.com>
Message-ID: <CAHmME9onMWdJVUerf86V0kpmNKByt+VC=SUfys+GFryGq1ziHQ@mail.gmail.com>
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux 6.3.0+
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Eric DeVolder <eric.devolder@oracle.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, David R <david@unsolicited.net>, 
	Boris Ostrovsky <boris.ovstrosky@oracle.com>, Miguel Luis <miguel.luis@oracle.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux RCU <rcu@vger.kernel.org>, Wireguard Mailing List <wireguard@lists.zx2c4.com>, 
	Linux Networking <netdev@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	"Manuel 'satmd' Leiner" <manuel.leiner@gmx.de>
Content-Type: text/plain; charset="UTF-8"

I've got an overdue patch that I still need to submit to netdev, which
I suspect might actually fix this.

Can you let me know if
https://git.zx2c4.com/wireguard-linux/patch/?id=54d5e4329efe0d1dba8b4a58720d29493926bed0
solves the problem?

Jason

