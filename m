Return-Path: <netdev+bounces-185776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D061A9BB2C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684B71BA3C1D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925D1FAC42;
	Thu, 24 Apr 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qagfri0E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC604A93D
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536919; cv=none; b=bSB/nhXeMdNcsGrIE2YnH1aKCymqS7lERlitFqREwgIUi5rmJ2akDsKp52bUFryMn3hXDYmEqmNDZ9di9fy9v5ZvCnVGyY8lvTf+9Y35Ukmp9yZV08jSkcdlQ3Ei52DF+v6M189/bNooIqG88QIsWoNcI3O3Po6WQoiHYG4OJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536919; c=relaxed/simple;
	bh=leP1MMCvTfw2WniCmxA6TjTr8mxlmUXSG09y7229cGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb1fNo/RzJNZR7gEwTyjnBjawshEtSJjXBUCSJd2x7LunDwRjTJlaZG2hOYPF4H6MixEqdfCezVol78NOw1aXEWHGQS4UTUb0NQZbQGNjxkt+O0fJio9bK0SHMtJOmWqyj8za/Ta9jwbeg/y4is6QMJCy9bDSP/vwfwvEND7pxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qagfri0E; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-301c4850194so1245658a91.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745536917; x=1746141717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPm+ZchIX4coFmmYlxiyIumxW8XQ8NkfWSG26kLwuwA=;
        b=qagfri0EoKqTxh1sAxj+WpI8A3JXbZYB7MY7kgoVJfADcZ0Kdy4d/xtNVC0nc9xJX8
         MiEAZVAz5vEk/jsSjbCJ8hrmtXazhG+a5FPAYX5iNHGlX86KLNFsX8GeZTo7+qEp1Gan
         jFr9pi98SSiUuyeiyAk469F5tgQk/95Myq8x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745536917; x=1746141717;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPm+ZchIX4coFmmYlxiyIumxW8XQ8NkfWSG26kLwuwA=;
        b=RtMjplRVal0c02Jg58tOrBh1cKbm1DQWbCL1C4TEHI7V/iauuoqlfgMNoZRW+bzHQE
         SpwI3ne28Bqt7ECUDpFbfoix7n78HfM18NjURp6RAxI2S9ugg/dI5dt9NsydeYQ5k8qr
         hFR8lFQTWMUdVISdltc9tGXfuKnGrQMxbtbptWivBRzy8gjhPQwwwRVeG9Sh26u+WKP/
         B3L8unyLCW5tA0XKs96Arf0nDlRQsEWf1cLar+tyIszMtrVK4RexPqFDHgJx/vQ6VArg
         TqM9WoGCOdwecYG46N5pf8w7ovK2mOGR6QGWVAVpPirzgEtewERIm3NxXrARm7ASXQ0b
         cKqg==
X-Forwarded-Encrypted: i=1; AJvYcCXfM7PT7Uj+HReL/I+wSDxAxwDDUfCi4flU0KMZT/aCkzqbf0TVZkDkxOwddoJiBkD1ZHV/ayU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1SI9RReRgFWoGwPkCeEkKpuqUyrpMF0qPHYinqa2/tWrorNtB
	Db9f0aKl24lq7c+ckDCI5WbxS9fkiiOoH3jxXopKS5tLlTowMYkPYV3eWZJu3eI=
X-Gm-Gg: ASbGncvOsMGR9rhTpGu2QRJSrPTQyiKCiApRGuBZyGWNhWWctJ9FLjujoJ/fowFwxnH
	Vd/0zz3RQNzMZo8dnnPy6PO3TTHUBZGX98ZchFWm6PPw5hAlctQDVJJoVutCpcHATH8t7izAmt8
	MybdS6L2cFdePMHD/gU+m/YEIgTUMkcgOmLbzuOippufyWB0N26S1B/r79vxEF2SHVfhw17JsEv
	3bwBlQ4b9+moavqPRYQa1DPAkn24YEfLyJtn9EhYoIu0FOO/XtnPC0F1tku8LbAR3PDr7Db7Zao
	27E1NK9GvtcvIfBXssKpFbhxcQhoR4jMaTkB616QMebcFM3buZHXeetHBJh6CDbLF+z/OxKFnyX
	ueM7M2lk=
X-Google-Smtp-Source: AGHT+IG9U7wDjilGvJBmj5VDZ/tkV58FQnCaIfGJyL1yx6idSDGdc51cezUP/ZnnBH55jBxy5CfISg==
X-Received: by 2002:a17:90b:56c8:b0:2ff:5e4e:864 with SMTP id 98e67ed59e1d1-309f7e8ce0dmr457526a91.25.1745536917080;
        Thu, 24 Apr 2025 16:21:57 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef0619c2sm2040926a91.12.2025.04.24.16.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 16:21:56 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:21:54 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/4] net: Create separate gro_flush helper
 function
Message-ID: <aArHkrU6V5nhgg6a@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250424200222.2602990-1-skhawaja@google.com>
 <20250424200222.2602990-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424200222.2602990-2-skhawaja@google.com>

On Thu, Apr 24, 2025 at 08:02:19PM +0000, Samiullah Khawaja wrote:
> Move multiple copies of same code snippet doing `gro_flush` and
> `gro_normal_list` into separate helper functions.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  net/core/dev.c | 16 ++++++++++------

Looks like there's an instance in kernel/bpf/cpumap.c that can be
replaced as well?

Maybe the code proposed should be moved to a helper in net/gro.h and
then it can be used in net/core and kernel/bpf ?

