Return-Path: <netdev+bounces-298516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BTlNB9LBK2rYEQQAu9opvQ
	(envelope-from <netdev+bounces-298516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB38D677C41
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:22:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JDt16QBX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298516-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298516-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43A803019010
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C5135B63D;
	Fri, 12 Jun 2026 08:22:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CAA379C4F
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:22:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252545; cv=pass; b=dNAcrdAk6rn6bClZkzkVEs8KCg2Vj61eb2UZrU9eKcBA1LT8KNoD6BNtgSv5tErFsKMG5qHlsAGftaOndfIpRQ/PiFgSc3z88q/156XU8MixFz5HE9iF7M9av3CJE8T2jxIUviXRjiEjbOydumgI5r59kT/HiJmSwExE5M4W8JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252545; c=relaxed/simple;
	bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFYzwoljxhywoejeC1agWM/68oyHGNDmjFD8c7CVeF93etAFxCLsJoJN/GH85BnhrmIJosyfBy6+27oe5uYbNM/XezL2LMWKDFOd+utC7A+tZR0VkRr7yEHIOmZkPcO0y/uorbPo5mP6uoj1QeVpBFdCKS1MWSm8cP/yQ9QQEjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDt16QBX; arc=pass smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9156b74006aso48429885a.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781252540; cv=none;
        d=google.com; s=arc-20240605;
        b=R1jfh5IYqfnkjkLJCPkgy8lzGdr7LYeMHZwtDQjvyR/se4TxcI4ryN6vHFew3HrTOm
         5Gcfzj+1JYyw/Etl/k4J/ylIUUJqGoxezxpokl3rQU+LgqpBjhPzpl8AatHBRxPgSeEu
         nEQkTuNTPXHHrsv+tWc4Jtasc+A0v5TD1DCAE4UC0RFstDFIKrq7O6WrZ7Usq32Nj7JH
         AxF4O6MY4iIX/LVJS1DmQysQUZEtJ7eEqr+EuTmjIojK0wFNGfOhxVm1rKOB0HDOUXrE
         5byXbBfgZQu2tae+0V5xXJ+xWH99YkqyT34HcKqUVl6O0qt2OBaIvJZeLFsFWUmDq4pz
         gCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
        fh=PAp0ysuc3i837L1fCQ/mNKkwMMUoCjAwreRffKoSAtY=;
        b=LCF4/wW5cf2tZ9O8hxXrrvov4Xeg3JPNjgCBvZc1RbhybtIyMmdDI91/ZrUu5RaUIy
         F9yM2E+Ccf3V+8dMRIfViqZGfeD8ldo/ZBDYva9b8EKJWfdn1KFCjNmdkygGbPfpzQNJ
         dsI+fHZXLm6f0lySUeZpj50A4OtYfigbZrgg1k1NdPytTqyADdaeD6kxVFcuS88C0oL7
         G33crf0GKxtGbm2qB3eFP009HaAlBRTrbpPRcP5REzv4jHXFBAJLc1Q+irtC2VfuJNex
         6zAi1RncdT6J1+czAP1iCCVP8FszV9zDOMDcmzVJC7Zenu4N8TFo8iYjwsc0NbLM+IzY
         FUQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781252540; x=1781857340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
        b=JDt16QBXUnTjMNzV1BI/6xEjTK487dzE8SGIOTbOTjGovo8X9S16Tv2tcYtnsBtxSg
         iryGdoLDWQAkOm/TvSmIf1lq9j7whlAahkIWbocwpe7/9oJkXeFG684fdlbcI00gMzuW
         sCuLJv77Jz1WuKwVFObEgk4vyS8qiI6EzRbpBsXUZjg9XBfDxXfLn6s6QLUIF9fjDKLo
         CDxfRt7STizd7gfG+ZeiypLjj5hFZGLKFlWrVVrP5qvw+os+M+KgVP2CL9fTElmazF1e
         che2Op4XGtiKXo/7h8LYuiHjLr3s5i3tuN7zJFaYWZDC9ClEyRR4iuSbWyO+PH6vMotO
         1jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252540; x=1781857340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZ2msG6bBpRSdvBS/f6pbbPMHjxvTzTeADXUE0xMIaM=;
        b=EFRBO2YRctXqzxeehd4XYJ2YBjLgx7/ew/PLU0Ec7mvcJjiI4AsqUXiNsjNpelY9S7
         Z+Rx/IksgwwC9pZdRLA6MaKTgKjTJF6WDqQSfGvOPqDesNC0ljdA84Xp+IJWL4msnrg+
         TJ6Eono5sdAXnmok8aHo3i0cPM/wpTXQ4zvFwMTI8gsVxpdu4JkTAYKKC/I56AvyKDFf
         O/cF4SG+R84YeMBxfCsvMOBh7bdf9Bvvx+w0mEjRQPBSi1gCYoIFvrETB3ir46cebSav
         gAm5T18mZvf44dLwa45Htc7ajp+9+wBThkCi7G0xOEKKOrQyJZ6knKdOtNlilcGlU13w
         Kaig==
X-Forwarded-Encrypted: i=1; AFNElJ8gmyiHwyQb6wYcn+zVzaNzoTSaLIGpjPVkcbCesDvSt5edbUmqY0L//WxR1YWmFYKbvCyrrks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp6WjyfxF85fdPGz4n/N6VYhVrs2Psi1WS8/hJt8KsbWEq6fUN
	7ZjcmxXoDIEQPQpCj+CJEUe2T+LOhu0oWLAC0UghZ1Of8TzjrJRhr+ywfW8t0suPcyaB3My3qoS
	wUhxBF8aJ3yiTTAxUIIFwDs3HwRK0cqkFMXFiJ/t4
X-Gm-Gg: Acq92OF9rp2X2rW7fpx+ZeYVRmCR8mK5jEtdJ5gexLvvFhkrHjbk5V3N0m2RSQjjWd6
	+QwjAsWuddTUes2BOCKa72obmTOybNUhjHsb5R0aCS1DHfseLHHH5qRIz2wCEny9q28NA1qetNB
	qsOqnI8v56UbM4i8YM0Nl88PzN+xWoER3CmfMQYCsGt3d/vGAaeadI1poPWoYwgHmXEXWu2DV2E
	nOOyWuWlNbSUxJZ29Bxb+tD9vX3/4774UYYao3kNsdM72ZMFHhVyfxUhWD5uAmLSK+aU+vgzTVs
	Ep1wxvkSnoA5JRUVDIXIrv3+u96BJQk3sOIuclE9TsXvkgdiqTwJpEaUjgqFX+yfjCZ4xrumFEi
	9ZO6l96MgtALPb/9X3pzX2mpBXhprJw==
X-Received: by 2002:a05:620a:414c:b0:902:5778:d312 with SMTP id
 af79cd13be357-9161bac73d0mr204971085a.12.1781252538914; Fri, 12 Jun 2026
 01:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260611092923.1895982-1-rhkrqnwk98@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jun 2026 01:22:07 -0700
X-Gm-Features: AVVi8CdYqSuoQH3pk2Lv3uigV13KDhOSb_2-LFWlIyooPmjFJdH8rcCzSzQ1a9U
Message-ID: <CANn89iK4Df+F-Q0AS=QR5LQz7JziM-9F1vS+U7YMMvW=FzaOCQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:horms@kernel.org,m:brakmo@fb.com,m:ast@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298516-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB38D677C41

On Thu, Jun 11, 2026 at 2:29=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state(=
)
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me()=
:

...

Reviewed-by: Eric Dumazet <edumazet@google.com>

