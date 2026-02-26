Return-Path: <netdev+bounces-261618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC9KKzfLoGmlmgQAu9opvQ
	(envelope-from <netdev+bounces-261618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:37:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB631B074B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 23:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DC7F303E0AB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FDF3DA7D4;
	Thu, 26 Feb 2026 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCtugYRI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9D3A1D1F
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145456; cv=pass; b=cc3JdU3rdIH/R63NnMwAKBCavkM+NtLEIkMjNXWxlpJeZcrg3ols+KWrbxkmqYAUj1vQjHD7LYk0Cmi2EkCjrcDuL+BgMi4DyxgVH7fGNzUyaHBuQHXlsaYxH9+uOJoh3A0tsfjGbH+xRXBX3A5gEcyGo6rS8ekPDdeOcZTYQVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145456; c=relaxed/simple;
	bh=mCr3duE5TcsqSwukvLPepzzcVucP7vo4kKDGdJ3igU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYPJLPf/Us7UrflKfKFvNTBY58tXJq8fS7esxxhUan0jw8adJsD4iAscUVOFCPmmpLq3GPMwOIX+2uWQqkzIGa7pWpx7bxyIu9z6braRhEV6Ezl4k5AxuYwpHYGZj10QeNjewi2IS4y5sOXj3AlCBmAMSdE8gDQSNLDb15S1lS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCtugYRI; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-126ea4e9694so366100c88.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 14:37:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772145455; cv=none;
        d=google.com; s=arc-20240605;
        b=PoaHUtD6NuFvPiL09jhSqxsGFxJRdcA8OKoZ8UMxEZh9feA0fNLfyDLMAj4G6KlOJQ
         KXxdPl3CnRQMC5yYj7YJ8lhD4lXttyezcjymm88l7jHtGUdTXf3q3o6hPQ/NoqRV3Hcs
         dOK7U1rUtdKMdyoeISiyzDOuJIg+OPodkp9zXhCgnNfjtpJbGXkHXQipzttznBBcsvVj
         Ii6pWIgwfltL3+hgtrt7GzLtyB9wDDUy7TuFjiANFtoXDRfERUBLtVDb+owaguljr5lJ
         XZP5FC7rj9NNOfVjorvxmxkIdehl5PXAyysoiPjR6naFPDeivUvVWuzVRDq9akQMwJbZ
         T+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCr3duE5TcsqSwukvLPepzzcVucP7vo4kKDGdJ3igU4=;
        fh=jvHMBa6/n7T9IAiSC9JcJ7gOgtgTLk3WmExFerPbZls=;
        b=C4i2QyalYwVSR+eZp2M/uXdU05/ZibpPBOtyJFrGSZGy8Mp7qnYDjMUnlyFdSVcWhW
         d7NDsS2qiK802Wsfmx0we54tLn53UDRxcAmXIHU0skq1BO8FtqShNUrAXsRZCbPPAoox
         JPBe7HjjtVJHSOCmEQK/2E5kue3wnfMaB9rh5f1o4suKy1S76LsJh3A7F4t20G6qrXc6
         T901fET22BecOrYSQAlYaJgHXyqGXpKfhpEgQ2qyDTCqRmZxOOADR+bmYh52wg+uDeZt
         B52JqcpPre1YsvKUdYOBrtt8nxreSJRxScrer5gc7OMq96qHkRBIV83TB8MAACtdDH0E
         g/Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772145455; x=1772750255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCr3duE5TcsqSwukvLPepzzcVucP7vo4kKDGdJ3igU4=;
        b=uCtugYRImeqHJacshxZB5Qmrj7HF0PlxSRG+H58hyM6m6BeqGsGSMWSygtAZid3AA9
         Q+vckBnr+YBombJKJ1fIYTD3gydXM2d+Ki9DBXFAu7++6W3mV3Rt2tRtiouEex7cm6j8
         z2ddkz0nOIpGX3Xyj6eHTD2Z7b3DGrqG1tQGs/sAqVcIVIEvocg1OWdNA1Klqsq7e/eL
         rwL1tldTFkX8FICVi274jCEi5Jl4KDcHuHB3h9TBr6Zcv9pwyHxXqhIzdFiPZvjbYkdy
         yNpeyuxA0HVmBEPb24cIND9+wr7RwPaJll5E5igYmlAT6E+P/l1r1s+es0iuyjL/auOa
         JKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772145455; x=1772750255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCr3duE5TcsqSwukvLPepzzcVucP7vo4kKDGdJ3igU4=;
        b=hIaskc68Pcu12oyPKHngzz/YGjixnIXi6egcA0+br+SqDTfC+8olN7T2IkN8WTUeWM
         3yQ4GsNW/E+QL36FSRJWFWWSJ7+8YSozWu3PjVe0w3QrfO+tdzAlK+z5jQ1C9fZryaqI
         GUh2Cov8BwxsH9L/1jbqIUIbpixXgX7G3PpPXeDIpBkAjFiF5sA4yHQVVxHZKARY6R6m
         +EET/f9NBvO+vq7Ok4gMePTPIJey76NAWirRyp61pwI8ab3MjwF3JQE4n6Kz4iPHfx3S
         RKnYQDlETzY3INXDc0+ntLnHW97PZEru6B1r8eX56NsopfNQP3680HkYx23rlv+lQtVy
         /01w==
X-Forwarded-Encrypted: i=1; AJvYcCU9oQKTtE4hrP4f+1MyUfJM8KMZ25dhU2C7bXiGxQ0LAQL/fZm9O+rk4Tn5gc5MhWhol+N1Zvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwK4zppFoZ2H/nGt8yysn2keyVceDpD3BW1MCdhFdUmXVyCK1e
	6vKFZ0b6SQlF7Tm62QEB6hogL9wNs2SpvaKzWcJVK79ixQKT46tZsAcpASS5NWwYikz6YWEYAkB
	OnIWL01vD5MPnSjplUJOmJh+Ru5lXC0PEopuOjzoI
X-Gm-Gg: ATEYQzzGntUV238uYfEZ5QjqzeGzNlQXySbzAyjVti7ljOVsfdTb/TVlD/4IDIdOOD2
	F20JcB4roYP/T+lcXl5B+2ngu+Rc7+1L5dBXGTpWhJWxiRhPTOXRXCvWuSxessJFc56wlRLb+D6
	/oEXvVFZsVNHCsYqtv86g3UJABdcYPXn7svfe1F65sCaIBZtM2mBhfV2hR8sa9qWv8AYDJKyf8/
	Ia4RiPYEX0EGzN+bYJXQymYJ7IvIGwhAXdUQeROYyJBOhfTdvQsNDmjNSNnJ/v6IlBJPmcpqDL0
	maSp60KaJh1uA11YjH2t5eiju9xKxldimX9cu+EuUsIx3kg4wkk4wOgGldrHVz4oOI43mj4q
X-Received: by 2002:a05:7022:23a0:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-1278fd32e81mr286977c88.40.1772145454278; Thu, 26 Feb 2026
 14:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225203545.1512417-1-edumazet@google.com>
In-Reply-To: <20260225203545.1512417-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 26 Feb 2026 14:37:22 -0800
X-Gm-Features: AaiRm53sK2sGTlSmEMExZJGQBAHLF7V8-iHQBF5fBH2cJA8jTS6Q84i5xbQx2_U
Message-ID: <CAAVpQUCD8eYKfsyPF+P-FRWqRXrZ5mEvSeG+tQ55fYN7rSC1Gg@mail.gmail.com>
Subject: Re: [PATCH net] inet: annotate data-races around isk->inet_num
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261618-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FB631B074B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:35=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> UDP/TCP lookups are using RCU, thus isk->inet_num accesses
> should use READ_ONCE() and WRITE_ONCE() where needed.
>
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hl=
ist_nulls")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

