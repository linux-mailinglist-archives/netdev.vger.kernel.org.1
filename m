Return-Path: <netdev+bounces-95690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDC8C30C2
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91681F218EA
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CAC54278;
	Sat, 11 May 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVtpwWRQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7D33BB21
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715425359; cv=none; b=Xewz/025cqpkHjooc6bNT+s0WYsO0FsnZ9GGc2vGNap+YwfMMmvJClrQGC5FfpgLk6aJBkxgG/SGp/tY9eEqwCspD2LQFzl5I5DjUQZtyyZpfHxuiYL7I3i1vEDgfrgHHvZ+6YUllq2YWtIvAnz0gFYFvfavZsLwtgKPQgfftQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715425359; c=relaxed/simple;
	bh=vDqy2rUJHSBhHFmjJtm+s+VS/KY6qlG35a/J5pyzAcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCPRR2Hnb48tXh1D8ZRHk8ys9NpJYz8fOqccR+H32JVw/LOH/3J+DHacoGxSkopa5JPQbNxIyIfODxY6t04AAB8nTcXLBXgCEkipGQ0hihqYtwhbKMenGWjJ02RQOEOXV96aptXXv0EKlu/mkAfG6nmvc86mDeS3GHbzCqZEC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fVtpwWRQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715425356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gnu1vXlSmPcmH/HpL6fCtMgv+98LozLNST85UYYD6a8=;
	b=fVtpwWRQwLqdJpxvUHp1Lop3w5z+znONvgXesMY9a2wPd4hsV/Qf6wgI00iMUzH3cn6g1h
	u9ybY05m7a90DkdvBRRklkg5DEJp2Qb66Y/N0i2k7di5i2djvpAR8ln+Jz4NCOTcSll1/t
	vWHjnBtRL5mQTRcxepFWdGHVpDuDM+Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-K2UWfr-KPfS8fe0-YtsX9w-1; Sat, 11 May 2024 07:02:35 -0400
X-MC-Unique: K2UWfr-KPfS8fe0-YtsX9w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b265d41949so2596500a91.1
        for <netdev@vger.kernel.org>; Sat, 11 May 2024 04:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715425354; x=1716030154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnu1vXlSmPcmH/HpL6fCtMgv+98LozLNST85UYYD6a8=;
        b=ZbQCguLA7d5IrCfPunk6Q7cZtXwgQyJl4pEToHY81QJJYJUXiasGlLs4C08VH5yZZh
         CEQJZVHCcFEpi37NuVIRDjDU/T6UUnt4UgpBDohXvktASWzk84rdsaz9I2xSuct0XXh2
         OXEWiy5gLJsBhRi+PLdUErT6VB8V4y9+boLKXBg7GmqKfjB2FYVcwlhgr9iz7Zo8D7lo
         KX0fuGWXGENyyDZUo/DIWhQuWsXmXcmBh5FfPyBiVHKje/kqDywg8mZ4em132nq/7Smx
         cH1AxGNcGGQhJb+kMxr5a7PWwuMUxUQ7JoiWnbgDHao617u1zKnh3oT4Xqk4bbqmL9bH
         3ruQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHjeoSBCSBX/fM79jfyq0FjLDrktNufNM71oPROjndsl4te6+FSpMZ6WBsKZKhHEQvCmkDUZ8x2r28LlSCDYB37Vxh8h0P
X-Gm-Message-State: AOJu0YzzfIdLPrPl5pAVSS4k7C6Bs80puVx/BHbBU/VbX0SWiku0YoQ9
	RWAxF2KCLq4YcwRRB7ySS/A/Ehz41Kb9Q4sSktTuu3jiFnhUSQjr6RZ0CfgqXXbaVMazJsnm+IR
	QNd6pP23Prt6fFNARzEKPSVlJl6zDleC0KsvlxN5E6zf/ApC4HBG+AA==
X-Received: by 2002:a17:902:db0a:b0:1eb:75de:2a5b with SMTP id d9443c01a7336-1ef4405977fmr65410985ad.62.1715425354117;
        Sat, 11 May 2024 04:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW1wVcz3JzT6t2/hgM7DFD3R3lj4OMYE08lFFhh193x9UELxrofhUoXM2JG/MivKkiCPpO3Q==
X-Received: by 2002:a17:902:db0a:b0:1eb:75de:2a5b with SMTP id d9443c01a7336-1ef4405977fmr65410595ad.62.1715425353530;
        Sat, 11 May 2024 04:02:33 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1642sm46757925ad.31.2024.05.11.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:02:32 -0700 (PDT)
Date: Sat, 11 May 2024 20:02:28 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <Zj9QRIjGLbVdd7MX@zeus>
References: <20240509113036.362290-1-ryasuoka@redhat.com>
 <20240510190613.72838bf0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510190613.72838bf0@kernel.org>

Thank you for your review.

On Fri, May 10, 2024 at 07:06:13PM -0700, Jakub Kicinski wrote:
> On Thu,  9 May 2024 20:30:33 +0900 Ryosuke Yasuoka wrote:
> > -		if (!nci_plen(skb->data)) {
> > +		if (!skb->len) {
> >  			kfree_skb(skb);
> > -			kcov_remote_stop();
> > -			break;
> > +			continue;
> 
> the change from break to continue looks unrelated

OK. I'll leave this break in this patch. I'll send another patch about
it.

> >  		}
> 
> > -			nci_ntf_packet(ndev, skb);
> > +			if (nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> 
> > +			if (nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> 
> 
> #define NCI_CTRL_HDR_SIZE                                       3
> #define NCI_DATA_HDR_SIZE                                       3
> 
> you can add a BUILD_BUG_ON(NCI_CTRL_HDR_SIZE == NCI_DATA_HDR_SIZE)
> and save all the code duplication.
> 

Sorry I don't get it. Do you mean I just insert
BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE) or insert this and
clean up the code duplication like this? (It is just a draft. I just
share what I mean.) I can avoid to call nci_valid_size() repeatedly
inside the switch statement.

static void nci_rx_work(struct work_struct *work)
{
...
		if (!skb->len) {
			kfree_skb(skb);
			kcov_remote_stop();
			break;
		}

		BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
		unsigned int hdr_size = NCI_CTRL_HDR_SIZE;

		if (!nci_valid_size(skb, hdr_size)) {
			kfree_skb(skb);
			continue;
		}

		/* Process frame */
		switch (nci_mt(skb->data)) {
		case NCI_MT_RSP_PKT:
			nci_rsp_packet(ndev, skb);
			break;

		case NCI_MT_NTF_PKT:
			nci_ntf_packet(ndev, skb);
			break;



