Return-Path: <netdev+bounces-246577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB8CEE771
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 13:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1EF302C8F5
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E608A30EF84;
	Fri,  2 Jan 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJwsYjUo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269B2D24B4
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355867; cv=none; b=RzvD8YRB2FZPjJFYqZygOAWYAxeaDeZQq2UeSM5EjAHkQhsC67Xi7QFXyUAOUbthvYzLL20NDqmeKV+WXNHQmGCxixn66wERg+Mcl/EBIXGJXKjRIBFl9tcWVdkMGGeEW2mK5mvaYNv6KQ/Wx0cNtuFVsGsImzekOXwT76POvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355867; c=relaxed/simple;
	bh=YkwKeora1mLV9PdHzkifnJhsG7z5aIrHh9/DgI4be78=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axd0mEKldKRcjqmU6iYK/Ocs4kllS5d3RHN1pbUXkvlDwsipKfCEWH3Nvh//u+REuNQ0pHho4l60rhY0INLUZ8C/SXn2LG8fLBgGlVcXhKnhjWjDnEe2xPQxVyO2mUTIz6hlqTOg5LjcTQR6GsG1IZXBZZlPBe49RuMSGPB5iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJwsYjUo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so65085635e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767355864; x=1767960664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsymdoSnuKbN2NyfZ9ktVw8fTlQLoP9UwvhxFPZnyng=;
        b=gJwsYjUot6uGYLkdPEp1fL2VaUjINgI6EoXe6r49RY4/CAScgwZ2JGH5PqLTkczMHN
         Y3DWHz3V5hmT6mW3SrRgMAFJxA5ypPeMaZFJc0Tycf+/9iCTzgAIZ9zsnxgpQNcVzDfm
         b0ylHo/sGtwf2pujiyE70XiE6OhiscUNcLof02vSMdZMxaMWZQKaGOzsWNh9MXRuYaYw
         B+4KYiz3q15fS4OPLiE5IzkvZ/PBt0cVaAvHYfhdNEMt2Kj2nsMcPjENbvKLQmq9VUiZ
         uPnU+JewKgJifpoMQhJ9/rv/YfvZoZENxscp/1z+J7liutaASjWIurP4qbunG/KDnsHG
         PXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767355864; x=1767960664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsymdoSnuKbN2NyfZ9ktVw8fTlQLoP9UwvhxFPZnyng=;
        b=Z7wnQ3WHdxeYNyItwvkCoQuqEy/vBq365aOk+EPDDBv0nteJSIg8BpN0g0Lt68IChz
         agWBShWNlXVmUm/e7cveRID5s/eTSNIaQH0PAbwDIdBzXnb8zpg3h/t6FEBQAko7AsJF
         K+4b/uzWri2IHnvcPb+94W+7/2R/4fg3Edr9vOCCp9fON6Hu/ZFIX1dbpUnqSVGa+Qmi
         76hcbhrEXvUa90fAFcCAPKDKi2YptQvp8BXCURRFMn9eVQYs4sfPdFitHPIp1CdlVR0V
         pK8sue1RNjiMVRQJBfRh2I39HJT4dCq6AVMiDaB6aoRIOZrjtkd73/39xFJ1qKbmiuEu
         T2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhWakWbJTszdLK4AfU1G97NutHc3MGr97hhm4n/1SXQGqqi5C1z88rMjO2cN5o+mP1iw6sHRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqrNddO1IB8N7+hZdPDOEP9yjeD81qrQAgoPqX7a6GW0GXQ/x7
	0BdyDjYGA7mxYAbXieLqWWc0SHoBgNH3+unRyoJUw4tH26RAGLGHRrPw
X-Gm-Gg: AY/fxX60m7wdOgCCW9vM3R/KWyIWie+M/YQXxB3s31RIEgCFoKERoh5ox/sjPuJbodc
	HIlZL0shPtajYFgdevVHCx5+ciMH+K5t04x3JUo4o3nVU4XChfalJTGjQsMXL31itcvJ7wlsZ6D
	Fa2OhCHmaNsjEoNml73bthSZF5y6k2Y0XwXMYr/weaSNoM47UTWszhDILrVrRv8JPfbsK+uh99Y
	0g1HGD17X3ltTtMKuJdLWRvdQXN4k5sFzYy3tUmErtXAuGzsxDc1YNNA4tpqbMGiCxK4r9U7ztm
	sYw3/zvjRU8V0oOYVRvo+BGt7/kXCBXlFJEAdPxtSnFHmAJZ7rWR9Hge3+ocIqIK29EydG0JG52
	pRYSzknnWq5+limReIbljRXxkgW6XPWZfv7BPilhS2VX1MGpoXioGvXM6TzEb
X-Google-Smtp-Source: AGHT+IGeHD9QGEO0EfQ4SPnoATfBRsOVSiPNLkPDj1EO6UPvf2BjuDLtdPNOtD42UKdvOUOZls5LEg==
X-Received: by 2002:a05:600c:818f:b0:477:a0dd:b2af with SMTP id 5b1f17b1804b1-47d195920damr519524465e9.33.1767355864261;
        Fri, 02 Jan 2026 04:11:04 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2bdfsm85321033f8f.32.2026.01.02.04.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:11:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 Jan 2026 13:11:02 +0100
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 01/10] bpf: add fsession support
Message-ID: <aVe11o2SFzjEnGpw@krava>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
 <20251224130735.201422-2-dongml2@chinatelecom.cn>
 <aVZ8LQXPhRqUz5dO@krava>
 <2251274.irdbgypaU6@7940hx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2251274.irdbgypaU6@7940hx>

On Fri, Jan 02, 2026 at 05:21:42PM +0800, Menglong Dong wrote:

SNIP

> > ---
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 4e7d72dfbcd4..7479664844ea 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1309,6 +1309,7 @@ enum bpf_tramp_prog_type {
> >  	BPF_TRAMP_MODIFY_RETURN,
> >  	BPF_TRAMP_MAX,
> >  	BPF_TRAMP_REPLACE, /* more than MAX */
> > +	BPF_TRAMP_FSESSION,
> >  };
> >  
> >  struct bpf_tramp_image {
> > @@ -1861,6 +1862,7 @@ struct bpf_link_ops {
> >  struct bpf_tramp_link {
> >  	struct bpf_link link;
> >  	struct hlist_node tramp_hlist;
> > +	struct hlist_node extra_hlist;
> >  	u64 cookie;
> >  };
> 
> In this way, it indeed can make the update of the hlist more clear. However,
> I think that you missed the reading of the hlist as I mentioned above.
> You can't add both the "tramp_hlist" and "extra_hlist" to the same hlist. If
> so, how do we iterate the hlist? Do I miss something?

ugh, it's on the same list.. nevermind then ;-)

jirka

