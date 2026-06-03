Return-Path: <netdev+bounces-294878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 44UUJINwIGoC3gAAu9opvQ
	(envelope-from <netdev+bounces-294878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:20:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C3763A809
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:20:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aFV+dOeu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294878-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294878-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B713930942E6
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83E3B3BEB;
	Wed,  3 Jun 2026 18:15:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650E32C92D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:15:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510514; cv=pass; b=P0pgx3upKAPqCJ2PnzcKmm33KDJWFf189FGRjHI//cHjY/82rR6fTFWouJ13AFcX4JziR34Ho9upBvh2alB8R/1ZI0leYp5gv8l6hpC+WYWCn5+f8X+9JL4paX7jt4F5QoHYX1I3OonSFTQ1gmZgU+2nVVSWaGpwXuM1T5DRpkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510514; c=relaxed/simple;
	bh=bc8yf+vDwLYZktVpT0wu1uj2q7kMRTlyg5TCqNOarGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ug8fC6kaU/UXugBx9fhkqeipFrC0Clq7KTcGdAybxYCfoUBGB0ZuKAIz3etOuRZw2WU1SbZ10saOd9z3uHzw5GjMe9f3w6o8BRTVg7CXl/9E+71INpfXtkmjfmLONMIAwiDqZSpjyG5hRbmc9rvc48HYSJPfNufpVomhdjt6zzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFV+dOeu; arc=pass smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b8e1760ccso3847121a91.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 11:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780510512; cv=none;
        d=google.com; s=arc-20240605;
        b=koTD1ou5ckph4XEIH5W91dbR1X6jtyEsFz/Pph5Bk0dnToW7Z0K3a2qSp0GGgoKAct
         05lu8vGa6I5XIFSCth7KXQRZ2uY89KTDUWjjqLb3RMiXRptwPsXVRD5IhRoEzQAVH+5a
         S/y2o5Pgr5V77DxP9sxPKh+sV+PCeCd9eqGfkgNv0SeeO08gHxMvMrt5M2SNP8DUcJ+2
         tM4D/AHIJTT4fKPXH9xG6hPyJzq7mfq+U/6PB/PfaQoMJIlgr7J6lnWqvj8chn2+v/FW
         ZNe+SuWVKcyXRPhhonkaZFZvVSwsbHhRjN/s8k2MpD8eqAeLjYbb2tDYptTh9YtI6V9m
         T6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bc8yf+vDwLYZktVpT0wu1uj2q7kMRTlyg5TCqNOarGo=;
        fh=cKqjYbQudL7VTBQLX5UHx1TmIiCax714sbG9kmuoYwo=;
        b=OpbFOXtT1vXEUC5znb9m1yWTEvUxxMotTZR7EpTeEm4lQ4HOvq4VXZgnO7cNcX6x5t
         TM0TV9TClTX7uB3BigkyV3+CIKB+XNr6GGEovypfFgnxki42cyv47rlJcz3dJjC/10B7
         /ZeBmaQju3/G/31i2Z4LnFUvoUIC3bBrDjcmN+Jg6S9VLAfUIye84vFzHuahNs+lnPkJ
         NSGnhI81xUe/aRjwiUWRcRBKjqzQRfBy2c/q0IFdXmfmnsmV3V0UXL0Di6aQF9FhyHIq
         d0vOdIXCvgdzeCp8QT5CcwPNYnlCBSBa8nB9k7+EV5zRYpqDTUHOgA3U3nwWHEZK9X6I
         X8AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510512; x=1781115312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc8yf+vDwLYZktVpT0wu1uj2q7kMRTlyg5TCqNOarGo=;
        b=aFV+dOeuTPulqvokDemyQ2rRRI8G9mxnL9EdLVLIxJd3/t1aI6kytBhskmoGD/UNsf
         O0/pKKvF4x9bnPbdZ5ETO3r1VNoVmXGRvFdVpsg2LoHOEieRUbzbuKLitKobkt8GsjMw
         2Xevb6m24RjwsNJ4l/AswTqPq4UosI9zBOL/3kPitQLn4dIvBXCRWh6kw9nimM2p4Qvc
         6qYedgBs4AsnziovFyWghBVZSz+rnnfSc0jlgBhYO4/MfoXelOK66hvE/D+bGgV+Ly7W
         7UTlMRV+loU00xg9kQ+DGGOMcrOYn53JtQyT/bSqfgasiHENPIstoGCBOogt1naxJayi
         MNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510512; x=1781115312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bc8yf+vDwLYZktVpT0wu1uj2q7kMRTlyg5TCqNOarGo=;
        b=bIllIzzI1zcCSDhMc9UJD8ZrP22vnn0K8XQVUQ6B3IZKmgwJ4sOlQCh1yeKeVwo6mO
         oEk5+eICZ+rbuMtvYKmRwCsPSlohUVyvcR72RTt+jLaGaTBcEE+TUWc72eNCbd0cz3ZQ
         oqZ8M+eyj8vyxOhuq7E/Yv6Of7/NW+31e0IxqEoMUAzy58DjGGzRChFCWQpIG8bJ8GBn
         gtt3YxtTGKtRnN/5kAsTrfOF4XTZ/vUqxVke5v59njAzT03bnsnlaA/o0+RzqgfNlpUT
         gOgc7H+G/oEd4vJHgQ67R5fwhCJUygEHFI9oM31fnNKRpCe/TPi74gxU4hEnXN6/y5Vt
         h7fw==
X-Gm-Message-State: AOJu0Yym9x3zLk9ZzkUfkS4o8PbSNmjBDb3ESUMVOV7h2SqrZSkqwDjc
	BrXMEDzSdHFGAjCKjZCA5a0Z+T+oPHqeSZRj1kGn/pK07Cynn4lbkgSNOFqSUWW9PxpSC0c7cHH
	7W2eK7s1bdIbjzVt6Q0+IV9npvb8RuzI=
X-Gm-Gg: Acq92OHdnlFGwAW/5wYblRiELVyRLIJlbnfUP0TiirYFVYmOXNLnnZNiJjMvyrYbn+s
	dg90DQ6tcDo/YD8wfBSAziGKoxpIMWP7qEWxkewmv1D319wlTbOAQ3NfEbA446mWwo6Nmmj6h00
	t0L36e1tQdTgSRjIyuV6NI2/4yUldNTWWjGyOZ46RQEOqJylmB9GlHiGoa26MKzc0CUSiMyhQLR
	5xntyS8xsfizoH4ITp5+CBuNiA2XZVDEvG+dVCqaVGQXEWP1yDodBAQ+iWb6Jo9X+95SxqBJwfj
	ZDug7dlu5yN95+FVDg61acrv6tdWeHzsuE4pobI/O/eZysIDzO/beCAETwoXaK0JnGu28A1bknX
	h2YcQ73K12+momDRtWg==
X-Received: by 2002:a17:90b:3f90:b0:36b:71e6:3de3 with SMTP id
 98e67ed59e1d1-36e308379b2mr4410234a91.3.1780510512536; Wed, 03 Jun 2026
 11:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780232930.git.lucien.xin@gmail.com> <CADvbK_fBbLCwY61HXsNeGCA8MhiBKcbvE0BvSZppohJgtXO+2g@mail.gmail.com>
 <20260602111823.0b1129d6@kernel.org> <CADvbK_e7T=Yfb800TbO+BcpDEp=Sf6rbtiy2daLaskFAjeg=Ww@mail.gmail.com>
 <20260603103924.643f1ea4@kernel.org>
In-Reply-To: <20260603103924.643f1ea4@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 3 Jun 2026 14:15:01 -0400
X-Gm-Features: AVHnY4Iv1uP_QmOrLNz1hlCQg2FIUIb0L_vtpgS-GxknImKiY2MQj6lnEeZbzQ4
Message-ID: <CADvbK_eSh_b7kVRkkgXoRwygCVoxuwB=Dg3qxEbYdW5cscSfHg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 00/15] net: introduce QUIC infrastructure and
 core subcomponents
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>, 
	kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294878-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,kernel.org,samba.org,openbsd.org,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9C3763A809

On Wed, Jun 3, 2026 at 1:39=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 3 Jun 2026 10:14:24 -0400 Xin Long wrote:
> > Will address it in v13.
> >
> > BTW, is there a public link to the Coccinelle check results?
> > I don't see them showing up on Patchwork.
>
> They are part of the CI that runs ksft because they are very slow.
> So they should show up if you click on the "contest" check in patchwork.
> (caveat - I haven't actually check if that still works :))

I can see it from "contest" now, and it's a long list.

Thanks!

