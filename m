Return-Path: <netdev+bounces-146541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEDA9D41BC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 18:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223542845D4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84F15531A;
	Wed, 20 Nov 2024 17:59:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292F82F2A;
	Wed, 20 Nov 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125544; cv=none; b=ZVhxUm7tatX5i6iLhFMEtOwqTlOD8rg75AcJuMW3rxw1u6Gwgyyj9qT6OV8oHM4dQrVxo2B0IsGPKTR1RUU7T8s2IxV9h37n9Cgt500nrE78eFpuJSPrmQWRvqPn0pk4M1h4XqM0XJtb4HTlytkruql7dzaWjOTiJ9RIdg82Jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125544; c=relaxed/simple;
	bh=GaqaoGDaxskmVsW5vllZG7RBgq4x71h9KMbZhE96Keo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rusEMyWbQN8hKG11SMXCd78oUmplWygcZHTzQr/fPd2tDnjXQgZDLUtkTIxzDmj+rF6CxC5w2P+fuuGZtaUaGz5RinDMmhJxw7Zeigz5xB4FvIxxhZ2AvMhH3gcBU8reVX252QHPo6PGKwg3PROLIwrgR1JXr8nN/hctlVa1JIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfd2978f95so4546246a12.0;
        Wed, 20 Nov 2024 09:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732125541; x=1732730341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fCNR3dpgET8mMrjgjMRdhFUYjPWfvh0Y7iSX92L8ZU=;
        b=gvFlUzqRePoM2rcV6ETMjvNynCGRgfDpGOX+ckU37q5ywuUz6jaOoYBFMKZpfNo0Zc
         FwX6UMyiy1bHrH8t3pBvESGM59y64oOK6hziix42lUCfigJq1j0/7lLLVb1ATYrQmCKQ
         YkDd/AIkfsrxmp69C/Zww/Mv/gAPh07R11abfsNzjWoGcpi7aCuo5WYipJNudUuYpL4n
         EWsXXIvSkc61ic0va7YdW8kNYP2gHnw7zYH25ot5vNbPqOpf9pQV6oGJE0Qi2S+KJuTk
         oW24+lgAH1WGq+QMOxiMC7FZQU70FblOH4yv+hllWKsYYSRT09OqBau+c6/tI/aGlSDr
         n+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCX5dVGRzijBXONVacVWedy/cNceBVfuc/F06tVzNZjwVw5E5N0Bh3/itVU89tsiXmNQ3YqdTJXIedR1GoY=@vger.kernel.org, AJvYcCXwu/ZObaEXIKMpO6cUoqTeK0bzBWHQrNWn9Hb64q3t5UBbg8+G6LgSlIOrHxaBhxEZkj5vEePg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tHzSLbv2bXXuGtvF5UK6jiTp5pF/Ulllhs24rhe2iRz77HxK
	ZZPzWODbue36SHMKqiXNPdRPHkl+nA8tiPWkW3S+Ne01T7Kb/G21
X-Google-Smtp-Source: AGHT+IEQGnA1PvX9SL9KJMh1MzYS08jWANI0WfLjUL8mSSRqXoUC8K82j0Fmyc8j08lCmnG7ZUfQcg==
X-Received: by 2002:a17:907:86a5:b0:a9a:dac:2ab9 with SMTP id a640c23a62f3a-aa4dd72b605mr352406166b.42.1732125541271;
        Wed, 20 Nov 2024 09:59:01 -0800 (PST)
Received: from gmail.com ([2620:10d:c092:400::5:a87e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0016b3sm805305266b.103.2024.11.20.09.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:59:00 -0800 (PST)
Date: Wed, 20 Nov 2024 17:58:57 +0000
From: Breno Leitao <leitao@debian.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 1/2] netpoll: Use rcu_access_pointer() in
 __netpoll_setup
Message-ID: <Zz4jYTfzYXZ9d79q@gmail.com>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
 <ZzwF4QdNch_UzMlV@gondor.apana.org.au>
 <20241119-magnetic-striped-pig-bcffa9@leitao>
 <Zz1RCAT9Ao5PsAAK@gondor.apana.org.au>
 <Zz1cKZYt1e7elibV@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz1cKZYt1e7elibV@gondor.apana.org.au>

hello Herbet,

On Wed, Nov 20, 2024 at 11:48:57AM +0800, Herbert Xu wrote:
> On Wed, Nov 20, 2024 at 11:01:28AM +0800, Herbert Xu wrote:
> > 
> > No, rcu_dereference_protected is actually cheaper than rcu_access_pointer:
> 
> BTW, this code should just use rtnl_dereference which does the
> right thing.

Sure, let me send a patch with rtnl_derefence then.

Thanks for the feedback,
Breno

