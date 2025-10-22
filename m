Return-Path: <netdev+bounces-231879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EABFE1D7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C74E322B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1D82F6587;
	Wed, 22 Oct 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kllj+V2h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4BB2F7AA2
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163475; cv=none; b=Lte3rXBpKae1mwKwjloKv1WG5mQSFR3OxGXTzQja80nU+TQBkpobsa+Q8n927UJ5nGS4ajiyWKLVAr5W28bq4PeqoJWdXEWXIP/kGI4f9kktM/51uE6rOca3UGS/MOXoSNLxxhce4iSeNji6/Nx6UdF98yVSidg0ox9LCVy/m8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163475; c=relaxed/simple;
	bh=5kSHtqSMPLWq5WwPm/iwP1qje6tfTwJPD4eLVRFnRtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCg6vb6HcXPJKk0ysnYi76nXTy2mT/AM7l0xh+/XGLUi/APDAW8Dj9Mw9zmbTEtSYCbN9XxtJb3+IQ8hM0mPhd6pUfpK8gEivQSNxHK1FmA2jipvI7G8NyITSeEo0CUSlm326VP4GT2D8dLPG7HXCcQZ5awBU4WOmZKlUwRw0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kllj+V2h; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3ee18913c0so10377266b.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761163471; x=1761768271; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVSmP58vLNDXKtZLSHsonVofaKm7gnshEKZbkuGHmnc=;
        b=kllj+V2hz+cgcU0J3DAos1Bm58RLUEJ+TntR5zdBxwI7zm65R3XteOkBMVT25rBdyU
         vNi2vs8WTjpg231qfYMhPBqxCv1MWnNAyPfYrcDmlKpqW+lzMe+JPl6wTnshyTaF1Kxe
         MGEJFquMcG1ZqiKp3oPQGHYRt4rFIfCP6pcVKAsWVlJkL2x2d0+yIgrJGoKSCANffrMZ
         MfNXTV6asSwvzx/X8mGreK3Z9y0L3YkgSfXkgtQtu0FmxBqclBu8o5uWjOUjCE85wvkR
         xAerf5MKeZvmllW+RV9bxT0RdBLo06W4sGnBvxZGGrNvPmLNGzL9CuRCucwvONZjgpAn
         QjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163471; x=1761768271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVSmP58vLNDXKtZLSHsonVofaKm7gnshEKZbkuGHmnc=;
        b=fFUMjvf6rW+lV6E2k2HenNcND8g10VZbRA/1phruW7CczfNAhACSGvAG1g+vbEtq8v
         1zGkq1yrtDaMlhwhP2eQcLBXE/TVg86UT+fM+AW6U7oIkVd0s48wJeQ9mDdszpQolK/D
         PxfEV/voNNiuN5hPyZoRTxcwoPRg6s/M/ZGKBNhXcOZUfNXnGA2tInpLA9NWPTRVOvpb
         Y3dJucDClKM3iG5aSoR8Na/nPxJN2KqncIYd+D+0246dOE+DTKnPTACVrWiVJopatv3/
         tRGP+V3RsBoQwPDJTkVvy8Owiol9qHI0TJleS/kqPJeFeLRagPckqpbYIira2Ns4xVsz
         sUNw==
X-Forwarded-Encrypted: i=1; AJvYcCXFTgir1sXCGrhhBLlWhuIW3Yb0ih26WaZYN/sDdwHauenNZRQy9Kn3OAfPxcicGRnTIL74thE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjvDB9aqnKe5+hpEA526mJfFgteFs1BzG1CCa+gvd4TLeWSff/
	CzM2pvha/UZ0Bz1vHUrdaqsdEpdqJkxx/ZQ5Xha2A0g4Z8TfZG/E72q7
X-Gm-Gg: ASbGncuJrKGa20YNyyu4rZrpckzMip/2c/LLjByYbGgfG+JuAJPF/RDRMJ2WV7zU32A
	9fLVD+x5h2WiuTVzt7UWoa01DsJLrLcqEdCNvW3fGmcKwZTDrazkASQOcv6cAXLqPWBWJlvMZwz
	lonp2+zZbtivGS+0sZGtsx/DxEppf/tiJpxq+H8LpThG22/y8onqNzqi6wwBGKIlsJCh44rsao5
	FgnbUS6DEBxC9gVlB/JTd2aagzFuUkFZZuT6oKGajagpSVR1fZMQXrTA9sKJUmYbbjYxPc1b7iQ
	qOYwpHYO003HDdIAsj6L1G9ecESL4r65KvHlnoLd2F8s80xDFfjr45c8ahRoEYzjZIWk+tjq+gi
	eCuk6kD3dmqPBixi1d4omcrGQhScZtN5tA82LdenN/7hB3xLNZmrHLd+9ruN5VQ==
X-Google-Smtp-Source: AGHT+IHCAXlGLFQGE7nq3DxlfqCvMe0ghMNIyNBqQt1gHQW5F1/alSGk8I/YKWg0yty+IIt/e1cxag==
X-Received: by 2002:a17:907:2686:b0:b42:1324:7986 with SMTP id a640c23a62f3a-b647254f3afmr2358003466b.6.1761163471460;
        Wed, 22 Oct 2025 13:04:31 -0700 (PDT)
Received: from hp-kozhuh ([2a01:5a8:304:48d5::100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4945ef49sm12525863a12.29.2025.10.22.13.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:04:31 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Wed, 22 Oct 2025 23:03:23 +0300
From: Zahari Doychev <zahari.doychev@linux.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>, donald.hunter@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jacob.e.keller@intel.com, matttbe@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	johannes@sipsolutions.net
Subject: Re: [PATCH 4/4] tools: ynl: add start-index property for indexed
 arrays
Message-ID: <3hlrcm2mvwhtpeuq67vrqupjabuws7o64lh5xoks3cuyyrfpsj@vcuuwazenoys>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
 <20251018151737.365485-5-zahari.doychev@linux.com>
 <20251020163221.2c8347ea@kernel.org>
 <75gog4sxd6oommzndamgddjbz3jrrrpbmnd4rhxg4khjg3rnnp@tlciirwh5cig>
 <e9cd34d4-2970-462a-9c80-bf6d55ccb6ff@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9cd34d4-2970-462a-9c80-bf6d55ccb6ff@fiberby.net>

On Wed, Oct 22, 2025 at 07:37:10PM +0000, Asbjørn Sloth Tønnesen wrote:
> On 10/21/25 5:50 PM, Zahari Doychev wrote:
> > On Mon, Oct 20, 2025 at 04:32:21PM -0700, Jakub Kicinski wrote:
> > > We need to be selective about what API stupidity we try to
> > > cover up in YNL. Otherwise the specs will be unmanageably complex.
> > > IMO this one should be a comment in the spec explaining that action
> > > 0 is ignore and that's it.
> > > 
> > 
> > I am not sure if this applies for all cases of indexed arrays. For sure
> > it applies for the tc_act_attrs case but I need to check the rest again.
> > 
> > Do you think it would be fine to start from 1 for all indexed arrays?
> Yes, AFAICT it would. Most of indexed-array attributes that are parsed by
> the kernel uses nla_for_each_nested(), and don't use the index. The TC
> actions are the only ones I found, that are parsed into a nlattr array.
> 
> Disclaimer: I have only mapped out the indexed-arrays that are declared in
> the current specs.
> 
> See patch 4-7 in this series for the full analysis:
> https://lore.kernel.org/netdev/20251022182701.250897-1-ast@fiberby.net/
>

thanks, will try it out.

