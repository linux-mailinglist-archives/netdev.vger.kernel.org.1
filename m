Return-Path: <netdev+bounces-248110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C6D03BA6
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 369E1324E604
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056D35B14B;
	Thu,  8 Jan 2026 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBkT5c/F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qL5xVEv8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F591500943
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883503; cv=none; b=e/ME1q/uGRs1bH0DvjHzZ+07ZU9P0reFyXuEnlo9daE7LSU37gWo9RPzuz95WnKgxktPUssDwNYRBTyNXDhSVhD4a5R5tyyiWPsF7D4WemiqU9E9sjYfqSgEaKzXNRLEV/XNPoBUYGaduxw94lqTB58QgNcBsBqQUxm84fQrnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883503; c=relaxed/simple;
	bh=2ikIko3KGMz2lxo6cPtvzB37bbtbezApYJoyH7zP/VA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LWOvILnydef08yopQ7fA0t5FAOBcsShP7Uq30OTywJJfpd/6DfCcYzXEVkihFuT22BpwPNiURVczHXp16ErypYHep82/xRS82O1vflILoCKHPMtdP8ngQpVzu9azWs4iDeKNzYL3QsHKjy63ev8M0MXRzbAZk59DnAG/cdVGM74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBkT5c/F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qL5xVEv8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767883499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/Q7qpmP8A0+7zNfRe33pEqqMDnUmdV8WNFELb0p8Po=;
	b=IBkT5c/FmxAx/IA0UNJHP97Q+2SHLVfxz/nxbI0WUrWNuGuI5oTteJQhiPlR5l21S5fSyC
	ZssiC04S42eTTNQnIDCn6Qs3v7FB1kHsmuPw3hYqgTG227hSBtgdN5IxQ1qLN+O3tRjYX9
	2koPTtQ4+Dif3NAHSX3wixPJTf3Un8s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-v3SVnd-TPDi6dyFSLbUsJg-1; Thu, 08 Jan 2026 09:44:58 -0500
X-MC-Unique: v3SVnd-TPDi6dyFSLbUsJg-1
X-Mimecast-MFC-AGG-ID: v3SVnd-TPDi6dyFSLbUsJg_1767883497
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b76eaf310f6so262361166b.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767883497; x=1768488297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/Q7qpmP8A0+7zNfRe33pEqqMDnUmdV8WNFELb0p8Po=;
        b=qL5xVEv8dAp7EyKck7LJOb8wCRJLY2bzjg10LosuJ4aGUXXq1KYU9SBQHIekxu6Eag
         SDDKv7pagT5fBa83wU9I/ZHZhnv4MeaXoawDXEPvrjEAXINTVWRjf1Sl3W+E/Rl9LB2O
         Dh92py/UtTvIvB0hCUiQ3dlJNKIjru/RZ36T7lYMfzTi323e7jBZ30/083Qe2wPLPGUf
         kd3HYzKhijj8f2anZh4IOADs4e94alUEWlwJ5E5837Z1wYOn/u6H0egSWQWlf0511coW
         o7BcnloBLgdrnI11i6n6DCtH4UXzpYLDIqe+i+EDJG1E1J7aVGQ68dmXwPL9rpkiUint
         8BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883497; x=1768488297;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/Q7qpmP8A0+7zNfRe33pEqqMDnUmdV8WNFELb0p8Po=;
        b=XJtPBBjlZCh7PhKPgj95OeOqFMwohqUfNZ+c+tzz5i2xKBsrraH1FwJmXY8KvguJLG
         pgRgNBRIQpyyQ04QT2FCWYJs3rnwQF8tF2VNqb6TrJswdCzpLeghMsyVlX7BEcsjZjto
         Y9+2SoUssn/cIFqN/watWOcrHPXk8N2m8V4aZg0aKUCMPHgDOADmbGMRueq8CW2QtCoK
         FD+yETrk9/PQ1eOPris9cVzXdsT9r6aFRIfBDSSX2fL16YOXj2+LWND3QWCMldp/48lt
         0D0qRlPPFLv4jpEpr7UdCkul24adNkVg/Yvjr1V6QJ4Q/NQwiW4BkhWmZ6nYyoEsR9oz
         GcGA==
X-Forwarded-Encrypted: i=1; AJvYcCXk8eVz6lC72B1etJNOooM83OSgA+ozjpEPYXsTAqJr/mCyfFgfK78VQoxQj+VtuyRp0+hT5IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUuaODJkZ8TTNdroxTd5pwByS96RNLOisfylSC9D3uvjCwCty
	L4SIEMbJMOxbIi7MHYMIhCf9Fhxaj+3LzHYVSiqqH8s4hJ9GuMzoBXeUeHTuG7dRvCTZfERS3Xl
	UNo9cUpPQrxIiR2LozRQzTmS27QNL10q3w1s6WOr9uvtT3G6O1sF/9LwmLg==
X-Gm-Gg: AY/fxX7u74tCYg/+CF/OFIKJ12IbNfKum4sZ3zttxQBlGcoU37AppEtO8CRErPVhbJZ
	i0zxF9QOLiMP9sU2gbZrmR4Qnv26Desm/PuiW6mZVltLRI7bpGaPVJEmtQjnOx1KsPmIg7zOUHt
	zTiEYb4W6ZiUAbznOM+tps/9BInIpJAQ40hQ6rNzAdynZNXouMiIfTcJG6iNZApGVwo5IMfOpU9
	oVfLzYFdCgIEdaYP778aYo7X20C1vlto3UVl9WC/ejUXH9n/b8xiwa1wK2YBbuDkbTMhVV7aorZ
	P6SM5jYBe4GjHfjuJRynLUTFCKuW5CF3DH3wb7dG8gjmH2KwYAnHMpv4DE8JwOwKMym1BBTD7+n
	XDv+gLUyZFaUbjdJglIYVQa2HWKe/gr4pBQ==
X-Received: by 2002:a17:907:25c9:b0:b70:4f7d:24f8 with SMTP id a640c23a62f3a-b8444f77113mr649072166b.22.1767883496870;
        Thu, 08 Jan 2026 06:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcPSvlJsD8p2A3/nMpOjV9vchPE43dNxE7Zk85KfgaABHa/y3pNk4yLxoo08W1VeA6CV/+PQ==
X-Received: by 2002:a17:907:25c9:b0:b70:4f7d:24f8 with SMTP id a640c23a62f3a-b8444f77113mr649068866b.22.1767883496464;
        Thu, 08 Jan 2026 06:44:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4cfe60sm817928666b.45.2026.01.08.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:44:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 30AE0408381; Thu, 08 Jan 2026 15:44:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Alexei Starovoitov
 <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] bpf: fix reference count leak in bpf_prog_test_run_xdp()
In-Reply-To: <1db0fa14-af3b-47e6-93dc-0adffaa3d934@I-love.SAKURA.ne.jp>
References: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
 <87qzs02ofv.fsf@toke.dk>
 <1db0fa14-af3b-47e6-93dc-0adffaa3d934@I-love.SAKURA.ne.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Jan 2026 15:44:55 +0100
Message-ID: <87o6n42mfs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> writes:

> On 2026/01/08 23:01, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hmm, this will end up call bpf_ctx_finish() in the error path, which I'm
>> not sure we want?
>
> Excuse me, but I don't think bpf_ctx_finish() will be called, for
>
> +out_put_dev:
>  	/* We convert the xdp_buff back to an xdp_md before checking the return
>  	 * code so the reference count of any held netdevice will be decremented
>  	 * even if the test run failed.
>  	 */
>  	xdp_convert_buff_to_md(&xdp, ctx);
>  	if (ret) // <=3D=3D ret was set to non-0 value immediately before the "=
goto out_put_dev;" line.
>  		goto out;

Oh, right; I think my brain just pattern matched on "if (ret) right
after a function call" and assumed there was an assignment to ret there
as well :D

Okay, not the clearest code flow, but not sure there's a good way to
make it clearer without quite a bit of refactoring.

>=20=20
>  	size =3D xdp.data_end - xdp.data_meta + sinfo->xdp_frags_size;
>  	ret =3D bpf_test_finish(kattr, uattr, xdp.data_meta, sinfo, size, sinfo=
->xdp_frags_size,
>  			      retval, duration);
>  	if (!ret)
>  		ret =3D bpf_ctx_finish(kattr, uattr, ctx,
>  				     sizeof(struct xdp_md));
>
>>=20
>> Could we just move the xdp_convert_md_to_buff() call to after the frags
>> have been copied? Not sure there's technically any dependency there,
>> even though it does look a little off?
>
> Unless
>
> 	xdp_md->data =3D xdp->data - xdp->data_meta;
> 	xdp_md->data_end =3D xdp->data_end - xdp->data_meta;
>
> in xdp_convert_buff_to_md() lines do something bad for the error path,
> I think this change will be safe.

Yeah, sure, this should be fine.

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


