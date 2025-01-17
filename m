Return-Path: <netdev+bounces-159373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD40A1548B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46453168FE3
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689919F10A;
	Fri, 17 Jan 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6T+vqcd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC1189F3F
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737132183; cv=none; b=YvPu5ATTwpW7GveGhc0QNBAVDlbVI9Db8Gwh889K/8eNOD5r+zcWcWEd2fNWsYsXRbOlxSu4kv0tvTsou4BuEJqhaIHqcqBBCoSUFEPISQtgsop7+56Z/ZmJNCrFpURbaUxs+9rqwKOZ3gd4fmynphEMzzo/iV5Wts7bo5U2inY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737132183; c=relaxed/simple;
	bh=FSnHYvk6TCcGSJ2aFbSgdEI20yieZkmQp81bQFGkVoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=et0LDnYztETDcg6rhjHbjnMXqjCqm+cqvy3ILGc4/uCiwZfCJjwtDZ+sK8Sc0n+Wpex74ZEjTEFQe6kh06vxdU+pDVGcyzbOM5NuB0AhJB0MjTru31VXk87uhETRISjAMyw8lkKejvLEepiVVlZEf4yMWKAeK/avhBo4yHDpryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6T+vqcd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737132180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AzH0N3Q+fMi/HkvVqAXL9WI8l6XfmBkxagfYRz+FbjQ=;
	b=Y6T+vqcdl0Arvp4L2boaPJ66KKOXJ60vW+ahXPzcYcr7RllpemoLigEGUQi56QXjYiHOPs
	kDR/aEtkOLaTuRdZj3V6QXKoNRDyOlvg/e4DZ2tYbX0E2Xk1Qjvg6KXsThnhFxvZBBsRE4
	Htm+i9PWwlXI/aPTZQL6rC0P+UGH++0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-FtNSC9gAPiKhmqLGMrrEWA-1; Fri, 17 Jan 2025 11:42:59 -0500
X-MC-Unique: FtNSC9gAPiKhmqLGMrrEWA-1
X-Mimecast-MFC-AGG-ID: FtNSC9gAPiKhmqLGMrrEWA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee5668e09bso4617916a91.3
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737132177; x=1737736977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzH0N3Q+fMi/HkvVqAXL9WI8l6XfmBkxagfYRz+FbjQ=;
        b=Bc9zl9E0JiDQ+CYrmqgvNOYsQfzAQznGoXhS1ejV7cgfawTcPOQpPhLuhiQ46skD/p
         QNWdoent9frGTny3KsipqTHda/qmfuK29cZJtqkb6PxSZt4OrYq3aFyXCZexXeznvFxc
         EP4eDnG07v5WgHiD2Vmn+p2AMKknk8vQkophmWNA6Hj8fyOGntWJG/81nmBoP8yqQT6Q
         uE8w81Ppi+8sSn+Br12yL882sbNrhUSyrRupfjeX3YUCm6QlpqpXGOdNy7m0PXCyjaTU
         MUH9vfE6VZBV2gbF1AcfxB9MCK05MDwQL4/Z6KujhxOaaU1j28bU4lY/IBx9GYudlGd8
         va4A==
X-Forwarded-Encrypted: i=1; AJvYcCXOOD7FqJ9c07U74XsYKtFaASZsNYPx/egsMgn7QNCfNmmFJnCgzNZcIE7law7w6Xp49cXSVU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHjRRBuMb6jDFAwapHFePZWJyWGnNjkS2P1Qoo//hCTnu9NRwp
	jyELTl1DsLXEK17pwNLOYTZGAM7ZP94jq8sUHuPQ4JYbeWeDkXf203nPNPYue/d2GCS7J+6YLw6
	yGpIojKX8QVbJWBdBE7jB8Tan+hXAkSv7H30gBMD5trV2HhqM/VMhuQ==
X-Gm-Gg: ASbGncsnfjJFirw4H7RItcvuDYhMJBDmNcPJ7vMKqWitub7A3zn2KpptOas7Afrxuo4
	kfx6FdOemyrGoXVv26vM4Ta8oEdKlaZndWBpXXruXOTgtgernsbNwiy5ZnOhoWTDKsZ3h/KIwjn
	Ces9RkS6P5pNWe3pCN/Elxki45cNsvxILQyAFE6U54HssR/UatD5C2QR8c3fuW+sRXkPrp5NoO4
	enapz9KNEEGpH2gsIU9MyQKA+Sl6E2e8cbT5ropc/VKDtZknAbU9lPmdseXYTfUYCNJ358wveae
	203FTrPADdHJ
X-Received: by 2002:a17:90b:534b:b0:2f6:f107:fae6 with SMTP id 98e67ed59e1d1-2f782d32397mr3983869a91.23.1737132177168;
        Fri, 17 Jan 2025 08:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUypNKVESCSeTPoEHheWM7U+PR1FuGloZujdrA5sBPWkQUoZirvOax+nHkVQHE1STgQctdxA==
X-Received: by 2002:a17:90b:534b:b0:2f6:f107:fae6 with SMTP id 98e67ed59e1d1-2f782d32397mr3983838a91.23.1737132176853;
        Fri, 17 Jan 2025 08:42:56 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4301:5e20:98fe:4ecb:4f14:576b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77619ed33sm2280866a91.23.2025.01.17.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 08:42:56 -0800 (PST)
Date: Fri, 17 Jan 2025 08:42:53 -0800
From: Jared Kangas <jkangas@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@kernel.org, ast@kernel.org, johannes.berg@intel.com,
	kafai@fb.com, songliubraving@fb.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: use attach_btf instead of vmlinux in
 bpf_sk_storage_tracing_allowed
Message-ID: <Z4qIjSMgIOqbHoef@jkangas-thinkpadp1gen3.rmtuswa.csb>
References: <20250116162356.1054047-1-jkangas@redhat.com>
 <9e5b183e-5dd5-4d3d-b3e6-09ad5e7262dc@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5b183e-5dd5-4d3d-b3e6-09ad5e7262dc@linux.dev>

On Thu, Jan 16, 2025 at 12:03:53PM -0800, Martin KaFai Lau wrote:
> On 1/16/25 8:23 AM, Jared Kangas wrote:
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 2f4ed83a75ae..74584dd12550 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -352,8 +352,8 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
> >   static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
> >   {
> > -	const struct btf *btf_vmlinux;
> >   	const struct btf_type *t;
> > +	const struct btf *btf;
> >   	const char *tname;
> >   	u32 btf_id;
> > @@ -371,12 +371,12 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
> >   		return true;
> >   	case BPF_TRACE_FENTRY:
> >   	case BPF_TRACE_FEXIT:
> > -		btf_vmlinux = bpf_get_btf_vmlinux();
> > -		if (IS_ERR_OR_NULL(btf_vmlinux))
> > +		btf = prog->aux->attach_btf;
> > +		if (!btf)
> >   			return false;
> >   		btf_id = prog->aux->attach_btf_id;
> > -		t = btf_type_by_id(btf_vmlinux, btf_id);
> > -		tname = btf_name_by_offset(btf_vmlinux, t->name_off);
> > +		t = btf_type_by_id(btf, btf_id);
> > +		tname = btf_name_by_offset(btf, t->name_off);
> >   		return !!strncmp(tname, "bpf_sk_storage",
> >   				 strlen("bpf_sk_storage"));
> 
> Thanks for the report.
> 
> There is a prog->aux->attach_func_name, so it can be directly used, like:
> 
> 	case BPF_TRACE_FENTRY:
> 	case BPF_TRACE_FEXIT:
> 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
> 				 strlen("bpf_sk_storage"));
> 
> The above should do for the fix.
> 
> No need to check for null on attach_func_name. It should have been checked
> earlier in bpf_check_attach_target (the "tname" variable).

Good to know, that simplifies the patch quite a bit. Should I add a
Suggested-by when resubmitting?

> 
> pw-bot: cr
> 


