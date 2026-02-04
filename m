Return-Path: <netdev+bounces-256496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D0DOraTgmnYWQMAu9opvQ
	(envelope-from <netdev+bounces-256496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:32:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A73E006C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE62A30095D3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028F1BD9CE;
	Wed,  4 Feb 2026 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNedAo9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D14138D
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165170; cv=pass; b=pw7Sm1u6KsYQRzn0ndQ5CuIzTZZPKRfznx61sHF/0YX9N2esyQpkEzsIHaCGk52Sqqnt5IeIWyBUXojLU/7ydtxyemRaZXpR4U2F4MYDzstCMIh+En3H2+WicHkrIAmTE3SlJFFZMmDMBsJ1dqPihPjM45T+SCPmcz3/nQOc6vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165170; c=relaxed/simple;
	bh=EkwJSYPiKW1mJZGAF1P0UhC7EfZkgVHWX0ItyRs0mJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSeUCjMlNAE8azQJssCaO6KliFRxIdqyUZF1e0sSuo6hZcRgpwBd10vf3W4eBKhIphZvWvh7SQwZutgL8Qu+ezQrEe47XWyNURUMRahB/78tBaR19IvxkFmsxlFFhCKRolOhBLI+5LlKRSoCB+YjwCnZ+qYm8w8MtluvTsclBc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNedAo9G; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1233c155a42so10281822c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:32:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165169; cv=none;
        d=google.com; s=arc-20240605;
        b=ZmMdzaXDBB2JNCGw5qLY3zEfKQR5d5/StxfRzHJR1lOmutxc1POnVMY0snWJ11ocz4
         UtIsadmgya1vpoE3JL4zhFTP32gdGpuqjFwLs+8tnsdAXgHwlXAi6YljUE1LJfzZYZ4u
         vJaQ0h9iE+z2Ug2tDXCdYUR7/sAyGJIrNG8R1Fkshef8DEdqGYX5UtVnHpsLb/Q3zphn
         79oIXSOW8ivdhJnP/6P9AQu+C03WdpG5EJg50Wza3Jwd2vbLQj7gSGRzkkpp3rsou9NZ
         9+TxbzxuTun4+nVF62tYGB8eiAYlaQ/t3hT71CnNNY6bQh9nukbHnTb81jDnpJ5OuQxL
         I9DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EkwJSYPiKW1mJZGAF1P0UhC7EfZkgVHWX0ItyRs0mJ0=;
        fh=gTJqTJmlbxZIqE//L1vdlsAWUeA33wDIV8tC7GV+2jQ=;
        b=Yc/R2ktNOPITsjFasEsVZOkyOXkrxivRcd451FrJQfPbwtgoqK9FNKrk/3nLopTUgy
         YYTuFKgU9qTpPMSswW8LHnaXXHfJ/Ndh+X2HyGLviTjjZ1G0jKG16Y3IvHxROsXrbOOP
         f96f5JwqJNFgATxeZkF70z6eUDgYP1mUyhFqrCXY0bglX5bVTLfQ6aAtS4nzgazwSQVj
         6Je3JJmT/tM+UQe+CvtmYUCUDHqpMSeTmZP3hQTXKsVVimDtvCf5hL70fWAAG6mB0KJV
         CGBY6yXGpvXRA88Ncie7trIRW7pqN9A4GoE0nUOTG9CaAWbIonIbjU+D0I8hKVgF+GLt
         JyvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770165169; x=1770769969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkwJSYPiKW1mJZGAF1P0UhC7EfZkgVHWX0ItyRs0mJ0=;
        b=lNedAo9GoweT2QQd3Q0/TGSyvfmk2fF/cLLZbYjls8f+cl0NjHt72G8AGFrEBAZKAc
         9co33+s5cmFZm21OvzyUjR16hEi4VVjvF/JyunUChDpo93rz+ebNelqoOqKMdalEU9JR
         yF3w/sRkKfJEUuj2Pg0nSN9ITtr8YUaAu2N5CXHT4bteyLSenFwn9W5/mzmwzp30Fc3X
         UaOQsOCj+vhUQhtgXF5TYLKB1Q8oahY/fWjI2ID9j73hWjWWLhPg93vAot8yybaOOPHw
         FsHkmegb7YeqDr9ET2wICLFibPrnV8+3nRm7L1GeM4rYDUzWDesRZGtUIJWYZ7rPkucz
         OpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165169; x=1770769969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkwJSYPiKW1mJZGAF1P0UhC7EfZkgVHWX0ItyRs0mJ0=;
        b=iXkgAIguBIVl2ETHrhEoGqCUgPhzW0HgViwIkBMPYCfbXDWAwGtCslvsJhHxzV6+HI
         Fwq8CY1o+T/zAzvNjUmwAeojEA0jpona0JEqEm1ABo6c4n4ML+k5GLDOYG6nT9iyXuaM
         ORRdOaelu/smOQGr8+nyW/YqqixwjDF2lhhOIrLG8MOZvQk1pQrpVx75DyVpluvSAW5R
         C5ejlVti9GmX9tKwzq3E3YR1DdFNNh4uZu0a4nXLXwGdzfb/pszb8ZEsnTuuZybH2cmc
         VzYlaAHQmwBeRbUJAK2KIF65xOAMPRorJ/iC5/H7aU9DdsFRvBFlmY5LlLZcZ/oGN4eq
         wI7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/YVv4Al6gSAYgICGq/C7k08TF6XQRC920Du+6RqHkTnYGsshWOokk9Le6KBHOTc0ngik3rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziegIO7YfmHMbGLyN6dRkOS4XrfPesfRYx6RgOWvVyHkTmJGmf
	cLstQk4ZwL1EPJOEoqXXSeBP84vgPSnNYvothS0RUEVdABPGLTFx+oQJpQaetpnP1GmaVgoM67/
	kZfA8Bwm/QOZ1xxxIq2OBuzAzhAOXAEj6aXEcxwnC
X-Gm-Gg: AZuq6aKcWcjEBuKN1jv1sIlIEgMdOIOS83g7rmvcBE7uqBV8AFK5QX9CqtLf8/iL0Sa
	tMFMFRb+h1Hll4ba0jQct7l2ec9ZjAd8Ikd2LPkdgL/mqu0gw3c2CEBdQnSKjFdiJA7T9Cp99AP
	5+1aBtJ3h5zFRFs9U2Pq8un+NvUOy30VprUFuMTyx/zSoz03vFE/+z4U3pKq5A/aaUVvDlSBADU
	PVkNllkQfCTGYzUNGHPv131Vl3Mb7cEoG+pwzV6cUBOkPkXYrMFSvCtM8klh17t27oTZbOgMb8O
	t7Y/Z3UKY1ctfxv3sADxACJWjrtA4TJaqFngB2AB7JcF/2mk0xUfCdBCKg3gLQQ3LNxw
X-Received: by 2002:a05:7022:327:b0:11c:b3ae:c9e9 with SMTP id
 a92af1059eb24-126f48e1ff2mr530121c88.43.1770165168468; Tue, 03 Feb 2026
 16:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com> <20260203052210.3684125-3-edumazet@google.com>
In-Reply-To: <20260203052210.3684125-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:32:35 -0800
X-Gm-Features: AZwV_QixlpHDR_B1lRWdaXcIhY7jX3meQ1M6a1uhVXZmD0h12KXm5O9_Wh1-1eo
Message-ID: <CAAVpQUA1KDnF5cKiwy4oURnQ7eF1ack0j-EetWE7agbWhSmG7A@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/4] tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256496-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22A73E006C
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This function belongs to TCP stack, not to net/core/request_sock.c
>
> We get rid of the now empty request_sock.c in the following patch.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

