Return-Path: <netdev+bounces-75266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950B9868DEF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0812874A0
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC086137C42;
	Tue, 27 Feb 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dl0XcH6m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EFF9D6
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 10:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030874; cv=none; b=pE2LmieDLK0X/nzhaj+17FmAHUQRAZ/pOYBebevdHRnDsgM6DyNXRQNuYRjq7XyeqDmpws2mrPY+ageySggtL8QeILplEyhSye8cPFVmA1ilOo154PXNo/o1Cwh5ef8V36KORyw19D7Hv3rPOY1xv3EBG0rGuK2qDel82B2Slhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030874; c=relaxed/simple;
	bh=Y91zr2azftOqIPLyWYUk5yX2Zf8tODDVUBtw9OTxeBk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lXre+UeomcQPs71o+Nt7rmMLGFZ9Kdj9J+s698Kslxz1OvMfOobi4zAAGnxwvj6jVL3HlzVIR+/FoAwZrHhkcWl2y5qK2cteWcEnCpoBkAImDavizXkjpu4V5w7fBnoz0MTHI5Jw+plmTT2ok9PcV8trCr0byENpGpe2v49StSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dl0XcH6m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709030871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FbSh6Zvc5/ELlGMYNczAHSsZGvnmxWIf/D11jjhDQuE=;
	b=dl0XcH6mldgafJEQryh0Qft4G7mANWQ4P78Bnr6t3mpxjdtfF6guYUHV17ZKUrHTSI4cOA
	T92/3asj7SbdPdR3FPcXKo3Rv2ZL8cHswcZ1KBxe3x+OfRiJZcMHPR0NUcBeu80GJu0686
	H7ytydjqluxMFNu6kasZuSKB7DMNIX4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251--Yr9wHxoOACsIDxfea2n5Q-1; Tue, 27 Feb 2024 05:47:26 -0500
X-MC-Unique: -Yr9wHxoOACsIDxfea2n5Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412aad037fbso758055e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 02:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030845; x=1709635645;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbSh6Zvc5/ELlGMYNczAHSsZGvnmxWIf/D11jjhDQuE=;
        b=lI37YYk3cIb2MZifG2OvPBd+wEmAfxtb8s53pyuRWa7qD+RXg0GTjSZH1vuBt1ZSLe
         UKJO5eDAooLYMub+w5LHjCTFtx1zSY58lLd8164IKqjOydewmH4erBLVSvTnn/Ichf66
         WNAWd3V/L3k8iz2p2esEJU7XYf0w6dEao7arAyGhn39XfDpiCzffZvpDXgFunl/wtJ1W
         SXsYS5FX5NP6sg0PkseAQQ03tyuIQi7ROE7BLrcztGEhmSUy29gV5dS1qiQ3a5lwH4b5
         o4NBxTsRrBrREPQ0xuG0ACDFq1HtA+nYtZDhq422yCpY5+iY6IvJDohC34/UpgYZdW1X
         SBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYHZah0Ms+6DcqAOlEv+1bFrpcBF9s4GFYfd9XqG0gxE6L72AaVm9LoqaHnlTgvvnzy7sVn4xZ2/G3VVDh6UTZZqB4Tnhp
X-Gm-Message-State: AOJu0Yyi+EYi47cJ3feLCSwNBFONcEMKnzJv9B5HhsAB3pckRjVducwk
	KDifKQ6dd4D93LdtnRMrRGte9H+OllWfDlrWQTRuiCVTcSHr4Gn7OvrPPa2saPR/VmABJxdiBZY
	prHKejuEC3SyYHBFim6R6KtZ6iQgHRACwehYe595IG9bZREKxZMmUQw==
X-Received: by 2002:a05:6000:1f8b:b0:33d:9ee1:48db with SMTP id bw11-20020a0560001f8b00b0033d9ee148dbmr6133776wrb.2.1709030845191;
        Tue, 27 Feb 2024 02:47:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJEp90FB/qc0P2HqefTkH4D7vqNGPVhZvw/zs2z5fuaAJTuFmSWZ0cgLGMlL/zpgC5RWKeXA==
X-Received: by 2002:a05:6000:1f8b:b0:33d:9ee1:48db with SMTP id bw11-20020a0560001f8b00b0033d9ee148dbmr6133769wrb.2.1709030844851;
        Tue, 27 Feb 2024 02:47:24 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id cg12-20020a5d5ccc000000b0033b1c321070sm10849058wrb.31.2024.02.27.02.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 02:47:24 -0800 (PST)
Message-ID: <d90b617800cedf03ce8d93d2df61a724f2775f56.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 04/14] af_unix: Bulk update
 unix_tot_inflight/unix_inflight when queuing skb.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Date: Tue, 27 Feb 2024 11:47:23 +0100
In-Reply-To: <20240223214003.17369-5-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
	 <20240223214003.17369-5-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 13:39 -0800, Kuniyuki Iwashima wrote:
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 96d0b1db3638..e8fe08796d02 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -148,6 +148,7 @@ static void unix_free_vertices(struct scm_fp_list *fp=
l)
>  }
> =20
>  DEFINE_SPINLOCK(unix_gc_lock);
> +unsigned int unix_tot_inflight;
> =20
>  void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
>  {
> @@ -172,7 +173,10 @@ void unix_add_edges(struct scm_fp_list *fpl, struct =
unix_sock *receiver)
>  		unix_add_edge(fpl, edge);
>  	} while (i < fpl->count_unix);
> =20
> +	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
>  out:
> +	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->co=
unt);

I'm unsure if later patches will shed some light, but why the above
statement is placed _after_ the 'out' label? fpl->count will be 0 in
such path, and the updated not needed. Why don't you place it before
the mentioned label?

> +
>  	spin_unlock(&unix_gc_lock);
> =20
>  	fpl->inflight =3D true;
> @@ -195,7 +199,10 @@ void unix_del_edges(struct scm_fp_list *fpl)
>  		unix_del_edge(fpl, edge);
>  	} while (i < fpl->count_unix);
> =20
> +	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
>  out:
> +	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->co=
unt);

Same question here.

Thanks!

Paolo


