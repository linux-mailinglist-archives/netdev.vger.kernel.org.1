Return-Path: <netdev+bounces-263383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JaJLv41p2lwfwAAu9opvQ
	(envelope-from <netdev+bounces-263383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:26:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413DB1F5F87
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46E3A302A68B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C7396598;
	Tue,  3 Mar 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="209XTgGf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D435396590
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565881; cv=pass; b=Dtxe3UbtbZe0v8CV8BQUGbBOCvVra0ljqP81ZpaBojiy9Qm4oR9NfbzXjGmqetIDuH6LPcZeU4holiAUV38v0+UqCOHlw4QyXOeb7QEhpYWKrRFapRQyGvOq1OlFuYjmujnklbfzlss/M9AJIELdkQJvGLNZkeoBbC4a2dWpfFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565881; c=relaxed/simple;
	bh=L9/z18nmfrRfeydTvNgPpq6xtvm6YCw0UnGtsLZn7cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgCOC05Rvf3amMreohq6ttrxeY2qs+fnGVLblOqQ0DICHFZO7ppehL5KdPchisLtXG5Xj8w1SolHKSA0gvbW0FA7LjafmL68dcV1HEI+MpYDF9WuIDMka9fh0SGhgQeZTKxn2uW4PNogvpB08S2Jc184MeGfKvJmKYm2ZsL5g58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=209XTgGf; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1277e072e2dso3462039c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:24:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772565880; cv=none;
        d=google.com; s=arc-20240605;
        b=IJTAK4zVwn7F9tVJw8Re6+JpPvKTSwsnYA5IrE3HATzgNF49I//O3wFjDMrzlk3H9e
         ifdKdk0NeNbQ0xboKloHKBs7m/FqwqDZVmY+dlG1cICh+KN6kRUHudzK30F5qWcOUEBj
         bkd0SaBpYSgzBxHZmQmN7CmDvqfSCtSPw+G4sqYKNAq5Bc/11ftWrY8S6QHZbktDB6AS
         8+Q8N/j5YV8FImbJ8D+UwKfyHsjLWvpe9uh7Nx5L811ap0eZPFzBwiMSKq4BRXC/EEqx
         6wPqyS13b+fvE5dmZ6R//QV74bY3qUACXW28U/GnTCuKzrGrWvfjGnPgFFrFWY93odR5
         5rVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L9/z18nmfrRfeydTvNgPpq6xtvm6YCw0UnGtsLZn7cs=;
        fh=Y/K1uCUhyWieCBe/sQMp6A7dcxeFVlw0sKm2F59gcGY=;
        b=c528HeyZ8VsZk3Ckv2JmAkmJfwWcvI6iP9NrMmKjHmHdxHzFpzNCJew399CRfi3PK8
         jS2xDDLPZN6loWg1ixby4k9i01HrkslHU4KNuynUxUrUEBHA+Ssnbw5vP9+LfQH+Tnzq
         uStFT6ZB9cp5GI5nUGBLyV8sEGatiIxIVvHq1vjhawloLW5bGH16PRWoYrP3jl9M4ncs
         o+U7rOSlG/MH4uqtHT+ep6O/F7aEF4QJNI5Bt1SQ+nQAniI1AxT63ADMq1U7eCTaKfrk
         9jgOy9LcfMfQPO0B9PdH3PbREhR1XFffxVUUczqjDlbHwOQ/o8atyysV6bGLxRcadMo8
         fSUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772565880; x=1773170680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9/z18nmfrRfeydTvNgPpq6xtvm6YCw0UnGtsLZn7cs=;
        b=209XTgGfV74Z+3KV2jQLxPJNcUZokiTDS6M2mONXz5/GlSP/YMbQuCE+YZeKkLSlvb
         Qp9oCKfZB3+XHjx79pS5S8lYC+0Pa9Z5zDHoX+q1NZZ+n1vxjRqreWggt8RPlP4JGdts
         qdKGUVwZH0eWgPpE4zRLQ7EgNqKp6rgw7BRaDwVOFjWnp2CPSzLSPyISJf4pMFDFDZX4
         mtu1+swngM0gb7DC0v/T5HReo4UhNzCcvMt1RHICUX53kTK+9KNOYMSC+d9SgZgqcsMY
         Ljly+/rTsTQNc52Kly4ZORWuhCak2NBVFmAzbTSd2idltrYLNc0rUDV4UU6HGEhrdw3t
         MHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772565880; x=1773170680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9/z18nmfrRfeydTvNgPpq6xtvm6YCw0UnGtsLZn7cs=;
        b=odOmC7lALq6VNCcsFzJEKZp9Sscra2l44vCQi+yCfLt6fOltd0vTopyrlw016Yy5Zq
         6dUbxwnZdkpikYcj6ZPgYFXFnR6XcqnhRtjDTiamBnvpAenbdEUz6xa1kYHiAFH207QY
         CUPCiOlkenoPiCc/Ioebcfd7r8FT12PXvmZlRXORJ+qCIn3Xaf7xSpRbXkARiM9VloEl
         L4j7Dq1r3RG9Iw1b6Fh2nKy+25Zk2GAP67Hdtvi+NDabU4jI02hamdyF3Ng4pzcDDlpF
         Tm/c3h8h8V0NjDO53NNzOax/5dONW64KCyX3nqEw1Kp1As62uPaClDa+6rJT3EpCLmbe
         GYbA==
X-Forwarded-Encrypted: i=1; AJvYcCWVyp+wNEv+VSnayYIW0NRYe8U6k3vu0eCENkv4UjHcmOVwglVCIkIfEOkEXOx0ynMb85nb5i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06E8pc2NFR0d3nWrtbZ6XlFipQgRClOjNQ22DOtFwWLu3L/0M
	seKbdf/bv3WqlX2DqqsBYhA5wc1NocjGOVvAnx6QDVr38GdLg2Lc7bBbzQPmTDxQIEEgudmjUVU
	ehoQzwRHP0F375KRwavEp+L25I2znGmodNNURCn7A
X-Gm-Gg: ATEYQzyOlQ6pVnfbpqFA8UMVGMpV2ctXaYPrQ/oVcd5GG7n56eMGfKpyZ+rmtNuRVwl
	hnuVLgCPoNBXEW359NVfees1r+AOfKmZr8qUm/BFL6WD2YGhby7JuFG/wZP+pW5l8gh/G4PcIqa
	6SbZDF/tw0mAD27GW9Hn+xR/X9raDkLJv5lgrDcwQ62fnYvgtD1e1kAVrqCMYuHTqV81BMrHxSk
	khp9n9gR8McLrXwdXAmHAcXBHoq+RP+on+h7LNIUS1GBe/gRMFyUnOlf97cLZqV+HURV4Pqai2v
	7ZXw4h2R7kWyYNe1T7UFHgfycBC9Y/9ZDJjN9YexPNgiavuw4yIXiW/O9S31csZY4/xQYw==
X-Received: by 2002:a05:7022:1601:b0:127:4da1:ecc0 with SMTP id
 a92af1059eb24-128b0d44c18mr1276214c88.11.1772565879110; Tue, 03 Mar 2026
 11:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com> <20260302181432.1836150-3-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 11:24:26 -0800
X-Gm-Features: AaiRm5216AopJg-jjJmqLGDtDca9FpDkH1L3L4tcthdMXx15aK67v7LtTYLDs98
Message-ID: <CAAVpQUCW1LurRWZWmhqEsKYimL6z52PCXtojb3p9R4JQ0jFKXw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/7] net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 413DB1F5F87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263383-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Removing rcu_head (and @mask in a following patch)
> will allow a power-of-two allocation and thus high-order
> allocation for better performance.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

