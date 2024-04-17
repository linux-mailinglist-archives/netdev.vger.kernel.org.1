Return-Path: <netdev+bounces-88654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05188A8113
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 12:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515F61F2119A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4913AD25;
	Wed, 17 Apr 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCX1w3gP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981D128807
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350247; cv=none; b=LapIZOzglVWPUYrWKqbtZ9AIEHWlnNeeTw/zYgEvwzmcBZQVFDppEID5xU7Jnt0+c65htDEAsWQgDlh0TXxGeALMmelopTZCkesa/WtCJfiGUiqiohFllPVupI6uA2gJudTOo0q68xITCSByGedYmzl5xixhVieCmINWMJfACmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350247; c=relaxed/simple;
	bh=F82AssVgXvCob8ZL9Z4+OKy8YClSbjD7FR4etRy+/zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL6cficKYur5BlnNPGtcK3Ln3iHxUJUs66bnNzcyx2lEwcEJfjd1mcVVcATLIg7KPWRQinQ8Zn8aTxSwUoIKYwk1hqq44M1KjR1oZem7UXN45jOYkcfA7JKpUSdoUmRK/P49fW5tWqG/NkeBGZUP+AWl3s3laB9xgrHSVzBG0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCX1w3gP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713350244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9nMNnE8K+akgXeJg/dpP7arElOO03kY2h1QsuXP85M=;
	b=fCX1w3gPZTTZ9yOMK6UymEbEaHB/ph+5Q6gFHIMx5QlGtvAQjmeOUXydgwFOYFuzQCSL2p
	gBlWI+Oy5aaUK1vWNbow/fYKh8u6h6gsVW+bDKz4hgLQHZzHmPIcABAtm1unJ6CcM1clc4
	wRAgdG6EJsrhW85TpBluFXvWqQDFfJQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-JXHFyWvAOPqPVG8S5vyZEQ-1; Wed, 17 Apr 2024 06:37:22 -0400
X-MC-Unique: JXHFyWvAOPqPVG8S5vyZEQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-417bf71efb4so3677585e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 03:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713350242; x=1713955042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9nMNnE8K+akgXeJg/dpP7arElOO03kY2h1QsuXP85M=;
        b=Ef2EMa4jlNvk3v+n0PBML4RINloT/YBYTnAKX+KfHqF34eWqZMeEofksNGwEcuGswK
         hA8QzGjcZ4iH08tSkGT2s0i75hZFkXzrYmSUzSoiKRSmxo+Kt1KPY4ORLRrD8lsBmvUL
         LeUXaIxtBEQm2VAiKUav06eDPIKwOrWH+HLFmIrduiiLKqjLmAwb3IjFj9Ak4c+NOOrU
         N15n9Y4Zj6Y2bDbLdZ3FuWNXvx+f8DNTGW7B1DFpoj7r1ExYuz/pq7v/k/oRuoID8si/
         78LxmEb7eAU9GR6kd2kLAy7c/Sh8ANlLqQCRdeu8GYitjngFUDhA9fuNJKVaXb5ynkzl
         sC9g==
X-Forwarded-Encrypted: i=1; AJvYcCWr+FF0kGOQcKbJjg8zC1AS2fEaCkxPdLWWe0TrF1J8oTJFmN5Z7QsCOyoPH+MOEpiwEvxi9/C5Bl9Jnb5MFLJ9GZAlMziM
X-Gm-Message-State: AOJu0Yx1BF4e4QVEy1iuDbAPepT5WWvrVO+H+C+7a9B/QOI/4+Dqea0N
	r+uYYmrBeCy8pVAEqNpADnR8m9h+XkUQdbJR+b55RTVMtuuLJnudFAkSi0je7U/OkyrPmInPjH0
	kmSMtzC7rVKCu5ot03kUiUgWCXDwMsDjm8anrmSI4jOyWUz7mAIFJlg==
X-Received: by 2002:a05:600c:1c11:b0:418:b62c:70dd with SMTP id j17-20020a05600c1c1100b00418b62c70ddmr1424281wms.4.1713350241843;
        Wed, 17 Apr 2024 03:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUlAXjYfIucv/x0TWFHnbg7SSh6ulD9yz6nzYtJvVu/55CHOaGWjd3kw5nXT52z397jFoudw==
X-Received: by 2002:a05:600c:1c11:b0:418:b62c:70dd with SMTP id j17-20020a05600c1c1100b00418b62c70ddmr1424266wms.4.1713350241560;
        Wed, 17 Apr 2024 03:37:21 -0700 (PDT)
Received: from debian (2a01cb058d23d60016331420a0ce55f3.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1633:1420:a0ce:55f3])
        by smtp.gmail.com with ESMTPSA id jg23-20020a05600ca01700b004189cf6bd6esm2229047wmb.22.2024.04.17.03.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 03:37:21 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:37:19 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] netns: no longer hold RTNL in rtnl_net_dumpid()
Message-ID: <Zh+mX5YQyJMzddn7@debian>
References: <20240416140739.967941-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416140739.967941-1-edumazet@google.com>

On Tue, Apr 16, 2024 at 02:07:39PM +0000, Eric Dumazet wrote:
> - rtnl_net_dumpid() is already fully RCU protected,
>   RTNL is not needed there.
> 
> - Fix return value at the end of a dump,
>   so that NLMSG_DONE can be appended to current skb,
>   saving one recvmsg() system call.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


