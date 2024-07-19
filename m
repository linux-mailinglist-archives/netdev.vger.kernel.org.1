Return-Path: <netdev+bounces-112181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9DB9374F8
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 10:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2272B21013
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157A208BA;
	Fri, 19 Jul 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BauxjBLa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085E5F873
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377406; cv=none; b=XmXTiLC/OWG0VbZxFQz46yhXDRYGL5M87QaPaljdEHxs/s9mm2GZdHOxIL79fxjCvApCciG7vuvxTwpfVSGrwR862D0Ehzcx6icOhBnsDaEOSoarFPEZw1FUXzh5Jg8C9Y8GcVsVWqhK2GOItjt8bKZBs3112qnOlf1zG714MRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377406; c=relaxed/simple;
	bh=nPqK5jk06xhbXftOpXQxNALaTxu6Tm//WB3okCjQOuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeAtf23hYGWA8J7LNTgf8a4u41MdKKxbaOObOwPrSvrho2czyhc2TvrC1Lt5RvxwVGUx9nGcROC8YU98DcG7QG47WixekVXUhdpGOwrzRQanakRlSF+5e6CrU9nvxqqR9QratSJU70C/LoZCASoHzqbNUZBSysLCkavSrnyWQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BauxjBLa; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eeb2d60efbso25973431fa.1
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721377403; x=1721982203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLs1Em6yWpOViKIdjAmzp2EHbUSxrWl+eIs4kQSeqSU=;
        b=BauxjBLaqEBDXO1hz5cw7Yhml76VAAa8YBa4akth7Qa7Pculw5mCAEXyVkj/Et0wPB
         OfenML0VGvZ93pjMouqyhoOdzrcYzQnmMlh0KSTlMthLkiPu74Vg62wbM3wAp641YrCP
         JbBskMqIq+zrjHJtBDQLB6s3Km9MrpKbciNvpFUOT+LGshO6H+JkDaGGan3LCUlf+aZ5
         +LyhzAp21hHUUoSMT9uBaVh2bVUFRYeLyYq3m9+lZ6JBjK+xSn2RsIoAL2pOYoxq6hN3
         v9ttBFViozbKaQ6xuCGZh9HehIB2pwhtC5A6itMhTM49DsiAaytrZAIL1646RHaAxnVG
         XaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721377403; x=1721982203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLs1Em6yWpOViKIdjAmzp2EHbUSxrWl+eIs4kQSeqSU=;
        b=hVKcM/h56Rt+Y7+theCjvmVCNVLYQ4xO2fZesyB+UyiLLpoxlg3COfJ9xMuttyHEa5
         INYIyJ+7lPWOQEgfuZYPnBuHaoMgkm5rulNdOOy75Cq88nTnI0EwMcikMBwCiHLARyEK
         eCIL0mnNCGDQZ2Mef7lFvYf69ChQ+j9l4eU8PTrQyu0Um7vNMLfEntIo/cqV722q628r
         aaasF4mYdm3MdxyZvVhx7ytzKidQkJz9PoBDg9WT/px40JV9E5hQK5R62zYuUWYz0eu1
         fb98AI1xZE4wDJqC8V9iwFHIX/h46XaURJLZJnCKydR8uToAf32vyAT4+kO90otQteK1
         6RaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj3ZX/YpKoNpIZS+8wDO9kKeEjVAxWVDzRD38cJDDSdr+OFEDapEBhrySZaBl5a6Q96XPA75mj+LXVLCU6zRLFS6hYA64F
X-Gm-Message-State: AOJu0YypAxzteJbcXd46K8pbCce7wbqyPxCok0UEC7hw8LmDLtUqbvVk
	uTcjbGTLj1faoNrLVDzHH43MiaPXmhCHPFfUpwgHv2ORy/Zxhq4DlomR+SA0Koo=
X-Google-Smtp-Source: AGHT+IFsBhIolO7+GRHI4dCTaNHoBUCns5rPt61TwyPih3yE3YG0+vBqChIBNRw8/OSbT6zRl0SdAg==
X-Received: by 2002:a2e:7c04:0:b0:2ee:854f:45be with SMTP id 38308e7fff4ca-2ef05c78cd2mr31780181fa.12.1721377403242;
        Fri, 19 Jul 2024 01:23:23 -0700 (PDT)
Received: from u94a ([2401:e180:8852:770b:e576:e894:caae:7245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d73631sm8573915ad.304.2024.07.19.01.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:23:22 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:23:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <kees@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Florent Revest <revest@google.com>
Subject: Re: [PATCH bpf-next v1 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
Message-ID: <onr3unastba5zd22wfkgotnrwcipuhznw2k6ip6f2mhlreyu3b@xdbae6cx5ds3>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
 <20240719081749.769748-6-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719081749.769748-6-xukuohai@huaweicloud.com>

On Fri, Jul 19, 2024 at 04:17:45PM GMT, Xu Kuohai wrote:
> From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> This commit teach the BPF verifier how to infer signed ranges directly
> from signed ranges of the operands to prevent verifier rejection, which
> is needed for the following BPF program's no-alu32 version, as shown by
> Xu Kuohai:
> 
[...]

Ah, I just sent and updated version of this patch[1] about the same time
as you, sorry about not communicating this clearer. Could you use the
update version instead?

Thanks,
Shung-Hsi

0: https://lore.kernel.org/bpf/20240719081702.137173-1-shung-hsi.yu@suse.com/

