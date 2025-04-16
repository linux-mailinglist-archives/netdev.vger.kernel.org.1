Return-Path: <netdev+bounces-183217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E778DA8B69B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D399C444585
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8D2475F7;
	Wed, 16 Apr 2025 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp099sMc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3433238143
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744798695; cv=none; b=FWJoePiel/qPr3vdltuphE4I0mNCX6wMOA0A+7rM/qSYGhLXUFNcrPEUDI4Uk4ed6y9ct7AmJJ+4j6N2RY0jxdAFl++KaRNzyqQ8FmvfDHm8JdBbSzd+5oC2Ehcf4UB2ZQPg3s2kBL2i12bk+4Ag6HKFmEhvtOBgoTNssfiT/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744798695; c=relaxed/simple;
	bh=acwVM6EpM6rJFxAZraZUmmSeuiSbfOluehd9tus2l4o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=N5CkcM+Q3pkxq4h2/l4KtWVAnFDyM5nCgyc+WHKS1F9cJfS4UUj+XHLOlvZo+DzNc47T7MxcDRxW2sdYiWlSqKzCugxqJ/ETG4lFnpQO6kdv5Uy4F+TXvCtBJw/lZ0N3qm6FRnpG5tk03GqpfwypbGbefLq9WXtJrVQcJE2ROn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp099sMc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so53980155e9.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744798692; x=1745403492; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=acwVM6EpM6rJFxAZraZUmmSeuiSbfOluehd9tus2l4o=;
        b=Vp099sMco9tcHCAWeETc+jspiAa7AaHLKJ4lG+7M4aIpfXekkPEfHt2eWnRzgddxkx
         qtMjIRYnlq9H7thXsDts1YjvJTD6D1Jrm9Wha6TKfWeNXsR2Ryu1/hqiHwJ5SYb3xDHj
         ASN0rdVaaaLqIK7D8+lHRzqk8WFc/CzgIe2wZHlG0p1NH5hLj82SPO9LPlbPkyJ9XeGz
         HML7jC1ytgNzMccn1RiPUkapYTehjPxuqb0aHvJrPd+OpT0WY29eBWj4s0wE6jGWY5MW
         hBSdWwbUewqPt1KAdPzNxzkI8KhrD3EyT3SOr2kjgB7Efx9Oqr+aFd4NXlv2OyUnRcVT
         9dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744798692; x=1745403492;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acwVM6EpM6rJFxAZraZUmmSeuiSbfOluehd9tus2l4o=;
        b=g/g6Xkuu/csv5wpDGxRr9w7WUIHpARxgQT2t5aCXF0+zkkayYTDzi6GAKU0bols4zl
         Z8gTvpNDVp4w4otprecHK1/Z5Xl5qdz7qfUVUro7w08x7LwArvZ5S3TRIPoGK2kz2OSr
         f7BbJsVlRGBunyElMymbnDmlRawtp55fEjINTNRPzs3O+ftCzRYfBiAKqi/QevH6vReT
         DCrPZzuQqI1Ifdt6g9y8FUhCNAcgUZAE/s5CNPbDB8Y6GEV7Q/VWih6SPNvjJKDhRZeT
         aEKVFHXqUFT7Gys4W/Hy7UJizSh1x410w10vTb3y3f8XD8hZ3ZDSpuZolCcWdCpTDocq
         iKKg==
X-Forwarded-Encrypted: i=1; AJvYcCU/wPdJKEgoBqbsUei+SA+p308gN3b1oesQd6gvieP3xkbF3cUhglZSUOBGD5XuXfjdmaZfKyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3VVGNv8FUFjtg6P3aWQG6YXlRkD0YIG+FMSgZYs0/QCGv8sN
	+erejOkn2dg8YGVqn6PKraN/Oym8MQXBDSJo3S6wfThhMtSvnI7r
X-Gm-Gg: ASbGnct4f+l3p55Gdx4R24nOGvz9hWvwT+FH+UOnF3/7mLWlxAACm7FMtDx/w7vOP1v
	3PKgXIgsUnPIlOTdQudCZ2MTkQuyrw/6BTXQJH3jxHTEyCvuNs0b6X0SkbUz5HGEX26hqBPua8a
	crriEfxy0FyN+pamP70ZyYqI9XH4qGKz/hqPqzmVc9Az4Jc2V0NvGuqfLsOdj5w/+qp2Sgx0YWK
	5dvuC/vjj4M85b5cZldHRqVu5Cn6gLYGZF3c/gC/gv99wc7g0WXNO9cnZeMIWuyfDa2ecnPmcvb
	kplFlTyevdDfb06MBBHcywNmOuToUoiAMP/86+MOSh8oBOfOI6R6EGV97A==
X-Google-Smtp-Source: AGHT+IFrOVqPpbnvKAh3IvAtVDw5bRw9hs8dJl0VrcKG6Jvi6LWRkvewgdQOZEVvzs+EFi1347pAGQ==
X-Received: by 2002:a05:600c:8883:b0:43d:db5:7af8 with SMTP id 5b1f17b1804b1-4405d69b0d8mr9335565e9.21.1744798691866;
        Wed, 16 Apr 2025 03:18:11 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e94a:d61b:162d:e77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b58cb6csm16885255e9.27.2025.04.16.03.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:18:11 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  daniel@iogearbox.net,  sdf@fomichev.me,  jacob.e.keller@intel.com
Subject: Re: [PATCH net 8/8] netlink: specs: rt-neigh: prefix struct nfmsg
 members with ndm
In-Reply-To: <20250414211851.602096-9-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 14 Apr 2025 14:18:51 -0700")
Date: Wed, 16 Apr 2025 11:11:27 +0100
Message-ID: <m2cydcl8kw.fsf@gmail.com>
References: <20250414211851.602096-1-kuba@kernel.org>
	<20250414211851.602096-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Attach ndm- to all members of struct nfmsg. We could possibly
> use name-prefix just for C, but I don't think we have any precedent
> for using name-prefix on structs, and other rtnetlink sub-specs
> give full names for fixed header struct members.
>
> Fixes: bc515ed06652 ("netlink: specs: Add a spec for neighbor tables in rtnetlink")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

