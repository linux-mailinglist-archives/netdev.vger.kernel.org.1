Return-Path: <netdev+bounces-257780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIefJpqwh2nwbwQAu9opvQ
	(envelope-from <netdev+bounces-257780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:37:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 188031072CB
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D826330120CE
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BE133B946;
	Sat,  7 Feb 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRnLqyVl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C312EC553
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500244; cv=pass; b=Oy0Ah0rkRYkcK/Fti3AS2+uZ/55HgCh/gwzB4M8wqs/VxFI8gbKJpTzXLK77yxFn3FRog/Kpie3TJsbhQGexFTnkvUDxQDjQIhLP0GXFY8StitHRJdmGwWmumCwt7qHc6hgxBukh/OdTuSx4YXNMjiFKbbXik9ROgk5R6xbscDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500244; c=relaxed/simple;
	bh=GPDr4RJ2vwvuo7XuqD1xY9g1YWj3Hadzqymtc0pdKiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZNrbrMPGNVrwB9I0RoSrQTWzJn4R8NaC1XeN4rjcPGR2CZm/7+ekrpkF0ZOKf7svYjJmH6ys0XV6MQDwSa2dFcX0FZaQ+jRV+TtnonC9gpwcnJA3SqxGyV8CRPRUaVNaQAQqfQI6kHwqQYJ8TAvjVNlCodVDNpLZBHNdewl5/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRnLqyVl; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270be4d125so3623390c88.1
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:37:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500243; cv=none;
        d=google.com; s=arc-20240605;
        b=Ug8nF9rcHXgaku9wZxLXU9h383bhjpmTpDB5dpDoW7+IKOlRo7iDewwCR7TS0l1kvF
         sfRk2FI2M7vxZGf1EDuQugwSxGqAgO/2X6ZfhPKRNF8EJeltnadfZhMgC11uGSWiltOP
         7a/XRTn4/S/CXSpXSKZRrTy+e1sPsozNg+/6CuENV/tfoV9JGuGqOSOfoq5oUqtOilMn
         7DdIIQ+EIr79xjYt11lgqAGdEsaTjKIMp8/63HfJUcw5VvaokgkTA7617ef9lkKUjIU3
         fgvi2zhk5zHtW2x6pANHD7OLO1k3bjo8ZxhUIPSgpYH8PhYXo8YBESEq6qeGEkEAItva
         amJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPDr4RJ2vwvuo7XuqD1xY9g1YWj3Hadzqymtc0pdKiA=;
        fh=D9F9melUZZHyhC21n5jNa8smpPcz5fvzTUW+Zvfli+A=;
        b=U6XePjAbC7CpLKmwWq4i2bQkIM7ywBKfFj20EjPuGL+JdSt2F1EoudbZ4HZzof5RAF
         4WlCCh7Ca+djZ7d7jHLY4+Cls6mlcErXy+JkS7LwMk6+lps6MJEiGhif+7u2qtBd8jM5
         vTAP++ArgrB0un2aKkguQEK5AxCnYPuQE7Z1L3SEh9teglJhwdkpu4AcAm4GUHK3XwM0
         kVz9XX5PSAffPgLPU1RWdjbllgeZYu/jfeTMgJSaARfGbK0DRWG6Wqe9ALvXDksVM0Mz
         zMFdqCr7SN1UeE9EtEl33KQm+LOVncljm7Hth+zjcE4ppLQZORguq65S6Gh8JEFUYa2v
         mZ6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770500243; x=1771105043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPDr4RJ2vwvuo7XuqD1xY9g1YWj3Hadzqymtc0pdKiA=;
        b=DRnLqyVlBQ5gZAMW3QY6PBkPW87ArPvxl/Eb35t9ql2DiK5eDfh8o0ZPahJh+GNsWo
         AsBmYk2fgwjPAiIx1RocIbL58Z3hfi94XAy8obJOUGPZJa+Ys+vwmzh9c4hcPNvF3LnJ
         pmt1zfxep0rVMrWy/q84L+qVxYYtQro89Q+xvmYFTA/b4ayMNwZ6w622Qpv9+xd1w6Aa
         lTXG73OTuCg5ldd8anz51La3yPSGuF7ADLoGrRdKAQgir6ycfROxEXp2X3R52xlMHNwG
         dgBO76PGIBUXXt2ETbNfLU3RV9aCMrBHOTqCgxcooKCfy+r7W8dtQimXPCz+SAi7pDn4
         v2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770500243; x=1771105043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPDr4RJ2vwvuo7XuqD1xY9g1YWj3Hadzqymtc0pdKiA=;
        b=cUit0+V68cZ777bh6BIdEDWzc9J4IJ6OWsu9//TePAGOjYjEJJbgf4bepn/TGIeQKN
         WlbehjT2kpf1YrKJTAmOGG6xFE5lEp5aG7oYbhvB3ed0qBG3pm9liKQ4GoQH9MOYy9Oh
         exJimjCL2JHLTrYxXaHT5lYfoO/i/FF+Osbt+bWlSV8ySK+WGXMXyGkHNqbZolw1NeGo
         obarMNGhrxggj0ceQJaomnwE4ix6FjqMUsSFMg6wAMoBFzql7Ao/r4EoHTNZ3CJUcQ9d
         BNVeF+Pm5ulaNcguSzy9QIVSC+KNCMVAjB0wuef81lNrBUIwHWah+SseDuNp8zFk2ILC
         IzSA==
X-Forwarded-Encrypted: i=1; AJvYcCU4S1lW3UJkj02Vlb5nFOLWDA8FE2QN/3ZH6T9JJkMlMOfQHO0g2Ork1QmlcM1ycBqCS4TlRqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykwFlGAQuCXQliFtJ49t530Qj5cKhrIssf7rA+uqIpNPpJ5dO/
	2ZDF28LqzZPQK9WovppEvUD+3Yl+7ciSqsLLnmShPU9BPGkyg1ya6M05QLW3KtX/wYX7StA9Fqs
	GwCpxuoHEd+DfzocHZ7qXydn9mqPYEV5QoMrSljBQ
X-Gm-Gg: AZuq6aKvE8cj6HlUM9a+McUJTIFwPgUhUIInCznIA1ma/OzwVHi3LStEBCY/dgya+Ru
	doscPTaaGqrNHEYh0mhjoR4sdMY1vTPRjDvDjWry9W6mlbnFWTN5Z5JXa5mT4C7BgSaUOkp4jqa
	QuYRHVXCTtzIJnzXs1Ran6oDiiFgnR+K02Ay96xEBgaYbCU+4XBJ3pHFKjoUOI7Q/MHVD+o5sCk
	XkB+3p8rJFCSwHl+A1Z489o5aCcvtJG7QkbWL7brnxFRIJzN4zdM6lmlNCTT7BFmGJ0sEGbrJic
	MWToKjeSsuAz273enmQGnwuh8vfvWXXckKS/YKFa6V7IDmLxCoyVlBwURYQ=
X-Received: by 2002:a05:7022:629e:b0:11a:4ffb:9825 with SMTP id
 a92af1059eb24-12703fd8e59mr3931626c88.6.1770500242462; Sat, 07 Feb 2026
 13:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com> <20260206173426.1638518-3-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 13:37:11 -0800
X-Gm-Features: AZwV_QgxC56GZMb4u7xpqwgXyse8pHUJsGOxwznGmhGHVw9ifwpmBj1TSFkepKQ
Message-ID: <CAAVpQUDEXW_Gz_4uVzZSknj2_+BwfHkCE9w1RPKe8CV3CW7SkQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] ipv6: use np->final in inet6_sk_rebuild_header()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257780-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 188031072CB
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Instead of using an automatic variable, use np->final
> to get rid of the stack canary in inet6_sk_rebuild_header().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

