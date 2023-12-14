Return-Path: <netdev+bounces-57525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A947C81347A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B105B20B1D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CD35C903;
	Thu, 14 Dec 2023 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Au00VY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB811D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702567112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uouXIP/mY6V89mn8ffGDizGjbA5gvdMVTlnAPaRcEZY=;
	b=L0Au00VYVHL1qUBKfIqAOayJ4ho7ubYcR/YUHiwEJ8gP9SIiqOiyVISMyIAhDoX9AEKF7s
	OAdBfmTD1GztbwlzMoAiWsYC7bNGlZtWQ075lpnuNwYCp+yW1LnFK0Sv3bApdWOFl4dMrO
	rxt2mwPnR1UlLJMpIeaGGyQK4PXKOBU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-hev4HcwHM9KOJL_ucyAnqw-1; Thu, 14 Dec 2023 10:18:31 -0500
X-MC-Unique: hev4HcwHM9KOJL_ucyAnqw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1fae8cca5bso90120666b.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567110; x=1703171910;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uouXIP/mY6V89mn8ffGDizGjbA5gvdMVTlnAPaRcEZY=;
        b=NXEF89Xf6KZLkQFk2JliiE62lspnGxPyBi9PPAO8+bqujLSLmvYoDIL7PjvXUR2hg5
         f+3LSfFTxL1FZBrOIGmFk9UkH2JZe/neGweHvdRlwucbk5SPIO50GD+AgsCvXAWlE8Qs
         qJmmPsE2b1i27tAk8kThi76OD00uMcgWbzztWUcS9F+FliGyynLPkQa3VOBdKC0Ux0W8
         Ex/+czLZ54v1JBhkdxcVF2024EzMbVFi9PF/pdUe5dWgKVSkfCWeXpaCt7+bpZiPljuE
         n6MtdMk55kG9dwhFN4sI2rS/UyPbMzW2gXhAqBuHd4XF+u7M0UatDU1scZiiVfVLcWCz
         X2HQ==
X-Gm-Message-State: AOJu0YzWp3/Q1nRxvtJszafgLjw731Vu1SfiTZeRxX9LeaSe/v9/YxWA
	waDj2Ai/xtgv/sCjnt2XpExtFofsiJlFpNjG9sZFS2bquF7A4RWn3EwQr+DO+JIWYUxYB6fJEe7
	722aei5zlTq+rXjeB
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11509613ejc.5.1702567110036;
        Thu, 14 Dec 2023 07:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbLh6Ckh+2C7wi9l0Q+FDN5slGlIEm9FPCvaL/O8/HwM1PTKqTgUfLgM/T/AGEUxS/XBLhng==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr11509595ejc.5.1702567109820;
        Thu, 14 Dec 2023 07:18:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a2310f34d0asm725097ejc.196.2023.12.14.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:18:29 -0800 (PST)
Message-ID: <4837d1401e1610764eeea7446280de87d51912f6.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_check_listen_stop
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Date: Thu, 14 Dec 2023 16:18:27 +0100
In-Reply-To: <000000000000703582060c68aeab@google.com>
References: <000000000000703582060c68aeab@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 10:53 -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>=20
> HEAD commit:    2513974cc3e1 Merge branch 'stmmac-bug-fixes'
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D116337fae8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db50bd31249191=
be8
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5a01c3a666e726b=
c8752
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1119061ee80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D110ca006e8000=
0

It looks like tcp_diag_destroy is closing the listener subflow, while
the mptcp stack is not expecting anyone to touch it while in listener
status. I guess we can relax the mptcp_check_listen_stop checks.

/P=20


