Return-Path: <netdev+bounces-302274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kVQhCEX7PmrANwkAu9opvQ
	(envelope-from <netdev+bounces-302274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:20:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7419F6D06A6
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:20:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OecdhoDQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302274-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FFE0301F9CB
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4B3C3798;
	Fri, 26 Jun 2026 22:20:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DB3BFAC8
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 22:20:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782512444; cv=none; b=WWmm0e8rJBIwYnR9lANs+DziSRAMyYfxTtS6/994//IgRatWVn9IXfWi4vl2BAQ1Bvul790AYNArkH6IpXRRndLxaal86qHAlhe8ptaIw5RQY6UG6gEzM/DHfqyVWtMrU+uoQBpZ5jST/JMGhZdCzwECPE5ts6djgQTCrvl3YQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782512444; c=relaxed/simple;
	bh=thPGL7uRo/2HzUJFgnx7YqyT1JviNUojRclx/SbtywM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7yudo19bYSwP9krcRdUv2QEyFiL7rLG6RwGNap26VhOFodbk+mRwOvY/8s1BPjRXFFQQonOBj66l1AWFZFYT6aHXoZfblxdmjDzCvTVpssTBRzMs7EeHXi5qlwL6Z4VuJizsyT98lNEfLPk31AJPm/2CyuGgMNKtrGw7DZXeO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OecdhoDQ; arc=none smtp.client-ip=74.125.82.174
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30c8b23420bso2471892eec.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 15:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782512442; x=1783117242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rjHzRwZSz30dinLgqV6749iLHAxrchS05v62XyW/Tgo=;
        b=OecdhoDQuQWdsn8Fso3amimWMbeuqRhDzxv00N1rfsw8TfvxBQHnqiNMFcNlXhhymG
         Q0dphSNjFW03cF06OgI8zpWM9sjRe9tLdkBnTx4AI5TJ4DUaqgoshN+rQSjGDiPjvKVO
         d7djzp4v+LEVv7bsS7jUfrMSX/3DBtgABpzTNgrdTVnr/oDG0k1Hx1ek+QP+9B3omsXt
         7zjqWSEJm8a6t9M/x6OLLBKjRe1sJ7rrohMyV7fhOPvDLkT/Lt6cJtnfFCzkbeiaMVMp
         9g0ZTWM8JJNyinLATyEzUGuzPnGytacaXAXBzBnOecmpWxJbL/3VG1xulLINdqAQ/OSu
         zKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782512442; x=1783117242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjHzRwZSz30dinLgqV6749iLHAxrchS05v62XyW/Tgo=;
        b=kUyJZrSGyi7o473Yb9fm6jvkfJ2xZJByyeJrpYk+aPP5vbAVvTpf+4F98BSQXI8XcK
         RKI+Q6PJKg21RxydzwRYCr37OC6rmfgaUSkJMuaecubMWBhztGofiJS8aC/6zRSinGCE
         i/tNC0otECTzNEwz1KS+oUa1QwZNjZgUaWADzpjtT6nebmQQ91ksemN+SVjN4dBNw1RR
         lYlWOlaCk8iME3727XAP9jX3v6/RP4mZmtOS7h5k1bjX9115VuTu2yupwOczjS/QoRUc
         jdGpu0RJZD7XawK59nV00bMejgg+iKPvlQN1KfZXpfqPRbuMA0mQaIGumgpq4e5tdGtG
         R5qg==
X-Gm-Message-State: AOJu0Yxhdxr8A250LE35p6dTYBj2F5Id/DpEog5iXAubAeSuIMEyh/fw
	bWYmfAGnm468kmsSLDjkV/H4OstnwRaU4HgYEfqOLhTyRTpODVg/C3br
X-Gm-Gg: AfdE7cmemDfhmSAZEkcjWYydy6ecHYt4dGQLmG2RChokGWikQVDlnGTYVxQ8D4SeGH/
	B0TOzQSaiAtEsaGuBAqyJ7JY9bZOViuq8cXEvd8/ZAnAC90SOAXnzS7YDdDVShR+EsnkQN2RFdD
	Vhytu7e0IkEQbZozaMRG/vi0FGB6sYOCaY1AHYeYeXjsA+OgRUg3s6Vyew+48WTJGx2AfbWFkko
	m7n+3aAwDphGnDMOMulVgCGUVvRW9ow3qEWUBhG7WRcSK4hDnfbYQ1wzr8R9rPp5bBin8pGQPsJ
	28ddjElTycW3JTx3C4iDSdMHZ7d/UguDgKbP5xcd8ABuFUxjIfzN1wZABPd+sS2UBG35UWgarqM
	3YmYr55IawW72EO+ehHC5MhX/wFC03V1FgjZKz147UVdc9VDcQEBqFokMdtQk9DHDb1eSIHrukD
	G7IwEMbEzm36w22YRkHounE2n8CdxbsqvV8Xx+tVmv01OZ/5k9Dih7u32UF8uoniSGynqc7Q==
X-Received: by 2002:a05:7300:1903:b0:304:819f:5029 with SMTP id 5a478bee46e88-30c84d109cbmr7151279eec.2.1782512442111;
        Fri, 26 Jun 2026 15:20:42 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c002:b4e0:8df9:2e4a? ([2620:10d:c090:500::1:11ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cac87dcsm24435824eec.31.2026.06.26.15.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 15:20:41 -0700 (PDT)
Message-ID: <30d2edf636f25e16e7ea61bc1d549c915b38b356.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/15] bpf: Make struct_ops tasks_rcu grace
 period optional
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 	daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, kuniyu@google.com, 
	kerneljasonxing@gmail.com, kernel-team@meta.com
Date: Fri, 26 Jun 2026 15:20:39 -0700
In-Reply-To: <20260623175006.3136053-3-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
	 <20260623175006.3136053-3-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302274-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7419F6D06A6

On Tue, 2026-06-23 at 10:49 -0700, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> bpf_struct_ops_map_free() currently waits for both a regular RCU grace
> period and a tasks RCU grace period for every struct_ops map through
> synchronize_rcu_mult(call_rcu, call_rcu_tasks).
>=20
> A regular RCU grace period is still required for all struct_ops maps
> because the struct_ops trampoline ksyms requires a rcu grace period
> (take a look at the list_del_rcu in __bpf_ksym_del).
> Add a map_free_pre_rcu() callback so the struct_ops map can remove
> ksyms before bpf_map_put() wait for the regular rcu grace period.
>=20
> The tasks RCU grace period is only needed by tcp_congestion_ops.
> Add free_after_tasks_rcu_gp only to struct bpf_struct_ops instead
> of the bpf_map.
>=20
> When CONFIG_TASKS_RCU=3Dn, synchronize_rcu_tasks() is the same as
> synchronize_rcu(). Since all struct_ops maps now complete a regular RCU
> grace period before bpf_struct_ops_map_free() runs, skip the extra
> synchronize_rcu_tasks() call in this case.
>=20
> This cleanup prepares for a later patch that needs to support
> free_after_mult_rcu_gp.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -997,24 +1006,8 @@ static void bpf_struct_ops_map_free(struct bpf_map =
*map)
> =20
>  	bpf_struct_ops_map_dissoc_progs(st_map);
> =20
> -	bpf_struct_ops_map_del_ksyms(st_map);
> -
> -	/* The struct_ops's function may switch to another struct_ops.
> -	 *
> -	 * For example, bpf_tcp_cc_x->init() may switch to
> -	 * another tcp_cc_y by calling
> -	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> -	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> -	 * and its refcount may reach 0 which then free its
> -	 * trampoline image while tcp_cc_x is still running.
> -	 *
> -	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> -	 * to finish. bpf-tcp-cc prog is non sleepable.
> -	 * A rcu_tasks gp is to wait for the last few insn
> -	 * in the tramopline image to finish before releasing
> -	 * the trampoline image.
> -	 */
> -	synchronize_rcu_mult(call_rcu, call_rcu_tasks);
> +	if (tasks_rcu && IS_ENABLED(CONFIG_TASKS_RCU))
> +		synchronize_rcu_tasks();

As far as I understand, this removes the synchronize_rcu_tasks()
for qdisk, sched_ext, smc and hid struct ops. As far as I can tell,
each one of them employs separate means to guarantee that there won't
be any pending BPF trampolines referring to the image being freed here.
So, the change appears to be safe.

> =20
>  	__bpf_struct_ops_map_free(map);
>  }

[...]

