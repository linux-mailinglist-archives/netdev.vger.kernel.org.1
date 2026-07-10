Return-Path: <netdev+bounces-306688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KU/wF7pMUWppCAMAu9opvQ
	(envelope-from <netdev+bounces-306688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:49:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C388373DF12
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:49:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g1e+jbnk;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306688-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306688-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3032A302E0DF
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E8B38F227;
	Fri, 10 Jul 2026 19:49:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8C38E8BA
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:49:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712947; cv=none; b=Pw/2hvMDXYrcNWgcZeHsnJ2N8db9+7jyO6si+Xx4ilgaoQ7qeX9PCEffNA0JOlFXGJsBPg3R4fLEoGFy+C60UyeZtYzoH4NbQYofJ3jrsM8uEjeZchnCd2fuBc53SnaJeF35T9nQtSSf2AVSu1687bfZsn+TA7BbKOqXQdfgRzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712947; c=relaxed/simple;
	bh=9ffiN42qaC1jpsImMXKTd2bML44rwupDWgL0tCrKHHM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ZHq43x1a4TxMvN4A2v7k9aIeGXZtxY4JEb8EVWGlnVawFQcyP3aIC7ok/nij3webJlZgtx+3ewrT01ldusaJEYX2I4CZo2KXutwmVT4A5s58aaRpoRwj8cX8Rr2vKgSyjf4hRo+ksX4M1LRogNlKX5Xdi/KSsRLNaA7E8U7afQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1e+jbnk; arc=none smtp.client-ip=74.125.225.128
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-493b4e7be03so5081025e9.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783712944; x=1784317744; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9ffiN42qaC1jpsImMXKTd2bML44rwupDWgL0tCrKHHM=;
        b=g1e+jbnkJmSaNDHsIJ64qyQYZlumSYLB/a10JIwFRjjwaW2a0xREGFAWIgyNyGWmnd
         kDQ8o1OEMpd+I9WP0S1bfPXZd6+DZCBbeYhM5h01rOlwAeCxLZkgNFSzn7mlPygUt8rv
         H/UU0KL15590crrsVGz00Z7NPciqvZGEkwImz+TdSKvMs3xxywlJtQysgrVJk0EXo+sB
         QMM/q5ZXdo5O8ulg2ippLjLncjFrwtFo9uE2nZX3ZnkmtEVB2s1B+bVGbqeGG9R8C0Wb
         irZ3qR3huZbVJfA1Jbw+N05WTczBI65j9SqimuSUd9EOMpkcob6yNw6QSmqAf/tlpKbP
         C7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783712944; x=1784317744;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ffiN42qaC1jpsImMXKTd2bML44rwupDWgL0tCrKHHM=;
        b=gtR/07dqc+7uAp4DM83PKjz3fHGGWJNt/0SDPB4cd7Bh6eET6BCUK4iUADP7RVl1St
         Ufktse44Z4sYBU7KRfiLsccKqZuZ/Z5xpXQUX6qrqiucWR4q9+xK7Kgf9aPO7+E1J7hd
         NDjHjcZMF+7B08QWYC3CTP1mXvMqMMAAKWEa8qNWe7/3rHvOuOnr9FADx6Di9b+Ofz/I
         8WMiuRiwx1HesPMAsjFxYVvmTh48La7ZXL0JQkzEU8nfy+XOZaxLD66sI3UGQZ9hmYn1
         T2/D29GfmK2jEiW1Npon7gppxzn/+8bwioLge9sH8gT3HakiEAGdBlxLTyuH58bs00Ds
         S6mQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1q6F4+4aU5DXRdAdp9VWWwI9skAe574tPuJORsMzPXpm3oCGd6+ITgnFOfFaMClWbuLehEX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuL9PnRD0iUIyGjqfaPZhRhBWrOjrvtnPG7XoBHprc/3BZm5q1
	48Kg9WzvSbwLuUDd78ywicFS7QbZChYRzI1LRv14aEVgBx6H14r+AeHygDV/32p/
X-Gm-Gg: AfdE7ckbCpYP/1kciufH1eX5WaLf7zBFf6KYkdvEtRamkHqWxV93r5e20EySycng+rY
	Tg0g+In/dy0aWJmZJcTUFjya2OLutIWiz5sP2Oi8BI/Czto6n/SO/5KzP3u+AKk+dJOeSMdPYc/
	YDv9YGTjy1Ibn8MndoShvBbx2THd0SPJduPK5BsW/eieTjnXlnCfSWj2k7dK1EAc+eYiigPby4n
	FSmPtMuAw3SA5oPHOgDgGN4F0sE26er4D7itqy78Ay0sI9QheEO/wljQRkfxRRK93wMx68fU7nU
	ON7m1Hb6dJu6J3Dpm/l3qBaxdguYUUYbeXSKuwQ8xB6o45QFBhRojuTHCZQMrxOpWwAjydljIu4
	D/4Ub7Q4I2msbONXznGoHSj9n69IV9L9WX0/e6Nnzit0kpA8xOGmjpR56JBQRRSn8dhOfrpdcG7
	f6GSOGUPcmtbH8+PB90kXtNbZKwARkmYBPlKSeER/Eclp4ajk6VHRfB7s3kxxogaiRzfgdQ00oG
	aG97LOIWycCehMKgmn4qm8qokmhtRJHN2PDCrEBr9bqQUxnG3FUKVw=
X-Received: by 2002:a5d:64ef:0:b0:475:f0d1:eb5a with SMTP id ffacd0b85a97d-47f2dd132e0mr127404f8f.53.1783712944499;
        Fri, 10 Jul 2026 12:49:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8cdsm66202553f8f.1.2026.07.10.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 21:49:03 +0200
Message-Id: <DJV5GU2AGDJB.2YWAL2MA7FM6T@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
Cc: "kernel test robot" <lkp@intel.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jordan Rife" <jordan@jrife.io>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Fix unused nskb warning in bpf_icmp_send
X-Mailer: aerc 0.21.0
References: <20260710180915.7105-1-mahe.tardy@gmail.com>
In-Reply-To: <20260710180915.7105-1-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:lkp@intel.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jordan@jrife.io,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,jrife.io,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C388373DF12

On Fri Jul 10, 2026 at 8:09 PM CEST, Mahe Tardy wrote:
> Declare nskb inside the IPv4 and IPv6 case blocks so it is only present
> when the corresponding code is built. The case braces are intentional to
> scope the local declarations under the switch labels.
>
> Fixes: f3603df9aebb ("bpf: Add bpf_icmp_send kfunc")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607110140.JeJZ6GIa-lkp@i=
ntel.com/
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---

pw-bot is asleep, applied.

