Return-Path: <netdev+bounces-208218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D89B0AA4C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5845B1AA7EA8
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC12E2E5B11;
	Fri, 18 Jul 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2LAuboX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570B1DE2C9
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864537; cv=none; b=EcvPEG6Fi1CgbW9PnM4QWdeSWKGhlqVr4mEWMaUyXBhJGajYmh+ZHncIVwk0llskNWirBPIjDAGZ3G+tvM0AC9NoSVfsd7XtzGC2+wpC+MGbc96CE83JfXWpASC3B6FAbQoPgVEF/H6wP1NE12CYNL18VnvgXtXmiOuBC3064t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864537; c=relaxed/simple;
	bh=N1DzyVZVUi8fBN1+xjMlVR4WHNb9iDCdSESHjy8hHso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACI1KaoDw6hJAnWCMgu9JvQgwWhzhkR2dr0DNlI2Hz17UplRzAmNsmcw6/4ufVej5vaxWxQ2rTF1ei8KVxZV7enHpXslc4xthocHDcg/J4RLD+DB3dRFh9F01R69M6BaxDaFuB10JOthcU/o6CC9RlaFyendQCJirODWuw9ceBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2LAuboX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-237e6963f63so14922885ad.2
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752864535; x=1753469335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e16YcthxfvwFTxc5XCEGeBD3DHk00TUcsWLw2mCmyxU=;
        b=N2LAuboXmcaMvRYdB/JFtrrnfeo5T/TVgCTRT+2ssDqpuRD9zbQYg3NfUOmQkeikdH
         ZRAo+AMItu/pDcLeIrxdpQgdfhQAQHTlpHussoRALLLMVrKxgskbKeCq8vrYlTq770f/
         GHK2dZ3kLD4pejmX5EES0JxXVZH+VUdivgNOIxs2JKvznc16GfqAnKtkVieNEXyy80tI
         5/4etZzw9Fwh7iIMIWad/H0flEgR3jJ1zDZBE0C1nDnRDf+0Zs06YakBTU25/oBx7cjl
         YQI6gwHTm98ce0tputnw8V2NBqb8pD7exNh0U7LeC1mmBVGSAgKz3FsOSmEeFHEJOaC6
         yjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752864535; x=1753469335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e16YcthxfvwFTxc5XCEGeBD3DHk00TUcsWLw2mCmyxU=;
        b=mi1gWzpQVfN/AU6lnccYUX+gpHbk0gPIKtKe/CdFlB1qILQ9hzxKxbqYSTVHGm/r7i
         vhuALATE9/7zPPlTUC2uSpcJlIfEpWWeoP2wbk+qWCqbN4PR3HRUjTiaIy6wFkTbJXcb
         uIrXPyqzkNCy/jkZ8XIdwNrIHhBFLTfIJjgjXLkwbthSzw5F6ZODdCIpAtVYfEV8QC2I
         02XjCudfMyY98S2w1y69RLgng87wcLW0HMuFSiWlKA719JPKoIo99kxe4nTYaCNtoxqd
         DixJwJKmQRo69FJRq1yEu7jwso5Rl/6XGnjl66Oq/uP6bvvw/sWzt+GubsHqbZ0oHs8L
         6rGA==
X-Forwarded-Encrypted: i=1; AJvYcCVKQRNKhMTP12uP/eV9NArwB0A5Jc4Xmd2pLQ6Kxn4g+XWDnkl0yLsCf193YqP9j5Z8NO00+30=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2X4QORuWwl/8Zpag7Io6rF1xY1Zovm1yWzCYf50grei/HJIw
	VNlXx7iWdHRfvJ7HvRaIHhuhQJMOO0rPl4rsMjzBLMFKX3wC6R2i0q/AH5PEPQ==
X-Gm-Gg: ASbGncucCiG7LuBNjRf8E58eM5BLp19HTBRQswUzQny/6e3cYZiAxCT5TWnVpTsqjyz
	FfS3EPDoPuiy0sFWU7Dw1kfi8kmphZuDNoILtx3W4c+Af7Q1tyxFeRw5r0Irc2PBicLfjDAC9IB
	h4CzgYFkeAiQlnRc+wakb33P77Ga7XbCTVMUJG9IqAxz4kFw7werUgO1qi+BJl6DathlJzJ/t+s
	73t+18aQsmltLuQANz7pqUM1/g84m2HPjJa/CaDrMvrl43BfTmh9a+BrNxm8tW6tu6LELJtDXk8
	b7bmBv/HrplHv4mMXN0wg+Ifw2E2r0hHZFXXSHgiYlTctRvt0g+9iRVQwtM5s+Jyg1kVAReRsZx
	zQrwbF49M0oeApy/xh2BwNJN3
X-Google-Smtp-Source: AGHT+IE91OEPBq/897txWHJVh0queu4U3IZWPEvqxqND0FP+UIJ53qoY/m41qTuQkB9Cu4dZd+hFUg==
X-Received: by 2002:a17:902:c947:b0:23e:1aba:410e with SMTP id d9443c01a7336-23e25684a2dmr182308045ad.2.1752864535385;
        Fri, 18 Jul 2025 11:48:55 -0700 (PDT)
Received: from localhost ([50.209.154.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff951easm1327984a12.54.2025.07.18.11.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:48:53 -0700 (PDT)
Date: Fri, 18 Jul 2025 11:48:52 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: dan.carpenter@linaro.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Avoid triggering might_sleep in
 atomic context in qfq_delete_class
Message-ID: <aHqXFDrL/r2UWWCP@pop-os.localdomain>
References: <20250717230128.159766-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717230128.159766-1-xmei5@asu.edu>

On Thu, Jul 17, 2025 at 04:01:28PM -0700, Xiang Mei wrote:
> might_sleep could be trigger in the atomic context in qfq_delete_class.
> 
> qfq_destroy_class was moved into atomic context locked
> by sch_tree_lock to avoid a race condition bug on
> qfq_aggregate. However, might_sleep could be triggered by
> qfq_destroy_class, which introduced sleeping in atomic context (path:
> qfq_destroy_class->qdisc_put->__qdisc_destroy->lockdep_unregister_key
> ->might_sleep).
> 
> Considering the race is on the qfq_aggregate objects, keeping
> qfq_rm_from_agg in the lock but moving the left part out can solve
> this issue.
> 
> Fixes: 5e28d5a3f774 ("net/sched: sch_qfq: Fix race condition on qfq_aggregate")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Link: https://patch.msgid.link/4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks for the quick fix!

