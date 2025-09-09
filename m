Return-Path: <netdev+bounces-221171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B15B4AAFA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBC37ABFF1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5831E106;
	Tue,  9 Sep 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qoq4x5pF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417A28AAEB
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415363; cv=none; b=aOrNttmjN14FrjFygrAYgHpLQAOVYvabucdhxU0LFVsv/+XywaqpBF2fBmBKIwCPAayBdxyQZSJC8YL/5LNVu9/GVN3a1siLb+zgdFvGwZUk18HF1IVznmEgzCOsirXwuI3vZf+8dCnL6I9ALXRkJdlSA+qBhX2JOcG0MW0q4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415363; c=relaxed/simple;
	bh=P+FQuJhA1PrMmXPlKv+nsJEpTrgwiKcfidU0cZC6Aa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmhTuIo32bG5qMjE4l/9H1xlQ/SjKl6BRWgdhfN1xdVoYvTL4c6x8//O9YzSXpdLq3ALSJmWuQaYseWhattKiGwjP76O4F5G8Skzw9wRtJaHocyPbY5whiv3MGAFxhq8H+aUp0pWK9GmZiS9aI91zZLz8AxSzs/VRRXUTt4eAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qoq4x5pF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757415361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T1K7vaX+eZEVLfGul1pBfoS3Sr2T++RNF7So0hyGuo=;
	b=Qoq4x5pFUGU1DykoFGTXoEO2idhvA2xzWejA//KVtC1m3k7lmMMrjEfxCOath5aZGXAP4v
	kK8DPAj+J0KVpln3nIQLps5jqmMcX41I7cMvuuCr/SQIHUhV8BJEFnT+dkdnlnqOULffOB
	cuoixur8veIJNZfK4w2EsFj3yT7VUK0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-HKa_sliTOAeInBWQt3AZzw-1; Tue, 09 Sep 2025 06:55:59 -0400
X-MC-Unique: HKa_sliTOAeInBWQt3AZzw-1
X-Mimecast-MFC-AGG-ID: HKa_sliTOAeInBWQt3AZzw_1757415358
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df2f4aedd1so3970487f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 03:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415358; x=1758020158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T1K7vaX+eZEVLfGul1pBfoS3Sr2T++RNF7So0hyGuo=;
        b=usY9mU/3pXtSxv/WOamW2si5OxROPAcImBU7sFoEeb5xGE7l5X4dQ2lj6gTxcegLeQ
         ccmH04faGU/Mzhgijy09f1IkYNri/y4iEKAZqlj4rO5cU2bQXnSywCjR00NcfX9aI9BL
         yeyT5VQWvFJIm3VqchI3R9fvcMiphNZDUGCCbZmmUrSlaHR0rgAkkiBItlslhZDD3UV+
         QxXACkptlvJVMHvPp4SlE5PmhUuci/fztRExJDO4SESK1QB6sJUmgekhekZcdCdkTGLe
         2jkGZo2b9ppAMMmf1TDAUBLz4gBGRhxOG66NiIQCnnq0NTql5Rqz87VpUFaGiu39BXIS
         WESw==
X-Forwarded-Encrypted: i=1; AJvYcCXrc9wBIRBUFF+BaFktnDohujOaKUtMbqjrNSD3iC+UDT2TdIp3T+VMyrlDXoUaqPbc3y8h7AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSgoPD51jUmDIa+7I5OHpl85tRjEcqXCjdlfMhN5Ftp56zORY
	lT960lTWFQhWFSeLxnHvB4b9iZVtWtC7Fa8A43sWrypneJt0HdehHZS/7H0JRJ6kP4tFsb5MfPn
	Hd1krv5sQy72NqrM5y94XpSQSnEJPNYt9K3nRZxF+7zB1NZJ5v+P6i+rqlw==
X-Gm-Gg: ASbGncshjPvUImt36Hheu7qMH32J8ngpOUQTQOIEvR5Dk/o4WoJiCLjjoVhFLqhg1Oo
	/ZUYynS+7DKeeevgCKAqxm4OpiE0i9BMddBWn5SWkTivsBmK/qqfmZMTGnM/xkFvPN71d6z+fMW
	6V8VKAlCydV0VUsURwmr/Zz+QF2gXjhXQVYtOgBlLHjLJYydjj2X8n95s7VYFAyg+EkzOVzmCn7
	8tmWTP7CI5cuCmQeAG2sdhn7AAbFwcxR5g1r9AnTMt8Uf0ayQS+F+NoXehw0W6K0P5EgU+hnLbb
	4vF/q8qc3gAlHNy4I7oMfc659k6e9WPsDa0aAGT860hRn61V+fyGezf4gNQGHmah7BLpqaEwXLj
	xCNT/uqx+M6g=
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id ffacd0b85a97d-3e641e3ac00mr9036201f8f.12.1757415357953;
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnmvFRwe+aQHJSfIB96YNcsk+I5KT04KIyycuSAFbcSbi1qXb6O4cvvbjLLpNmJLmEpECY3Q==
X-Received: by 2002:a05:6000:2383:b0:3d9:70cc:6dce with SMTP id ffacd0b85a97d-3e641e3ac00mr9036184f8f.12.1757415357529;
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224eb27sm2177631f8f.62.2025.09.09.03.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:55:57 -0700 (PDT)
Message-ID: <d7026515-433f-4c45-9d24-ea529d5f04b4@redhat.com>
Date: Tue, 9 Sep 2025 12:55:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rds: ib: Increment i_fastreg_wrs before bailing
 out
To: =?UTF-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20250904115030.3940649-1-haakon.bugge@oracle.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904115030.3940649-1-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 1:50 PM, Håkon Bugge wrote:
> We need to increment i_fastreg_wrs before we bail out from
> rds_ib_post_reg_frmr().
> 
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
> Fixes: 3a2886cca703 ("net/rds: Keep track of and wait for FRWR segments in use upon shutdown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

whoops, I replied to v1 by mistake:

https://lore.kernel.org/netdev/d918e832-c2ef-4fc8-864f-407bbcf06073@redhat.com/T/#mb92f279c773d443313f9e0951a2107060078802c

But the comments apply here as well.

Thanks,

Paolo


