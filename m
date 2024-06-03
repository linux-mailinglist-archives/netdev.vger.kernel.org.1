Return-Path: <netdev+bounces-100059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2066D8D7BDB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C749F282F21
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F02942A;
	Mon,  3 Jun 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K6hHIbnB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17C4A0C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397410; cv=none; b=jOnZwVtDPxklA8c9tdBH5NuVEUiCeIQFpZ4JgFSJn/gYuiYNM5fFRZ+BMJQh/A2wl37UoCg1rsy3FCjYLOD0CNK+PkrSoDM4Q2DQUuRwAFATOtAcCixriAGLDtAlA11Ost5TmIkrrRB1NsyplWC9W2cKyRSouJEScRiPE4+lURI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397410; c=relaxed/simple;
	bh=PO7ROjgWGh0j/Bt2Oh1uyt+Zm9p8BrwKQ4PvEQloriM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJWJl9TF0U/88ASTl+7U2RF2A2R78FRkmd0v0E6PXL9Y48H/z+2AfvgoZEORwvKXcQn0mwSMxd+je7ptnq9NliirOIDIVMTiaONLGxAJUsOMKDcUsvuvltHjzsSGsKGAsECygzTjGvxXqRL4RSBIS8Xyu9XI0hxvEsGnwfcFYUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K6hHIbnB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaad2c670aso7107481fa.1
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717397406; x=1718002206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hLNa4V3lkhnuVGaSZmqqlUqLoKvF5RrDlnm0Tj/pohI=;
        b=K6hHIbnBaFby7XCcGLhE6AZgzfsHPaTvaHYb89tZomXuIE9YSPuU4N0Ccu832+3FkO
         aSmTc2Mbyxfqy+77nbjKMkzkzzLiOtg7ti1ujy34hQiO4vGbxxjucqq89hzTXmOfIPXd
         cP4hCzsngmBxlW5C/0ov69F2mVPQVyBUFYPpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717397406; x=1718002206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLNa4V3lkhnuVGaSZmqqlUqLoKvF5RrDlnm0Tj/pohI=;
        b=dykOmnaDIBJRxqZArFgUVLVAA0x7s0Hirfq4D8HFCzR2AvBu5nF7D7SswA6sxnseFH
         7DAnXk+wraJIsx2M7N0Jplm/8pWCiAeBayL2WGNOAvE5b8bpVLaWT5wMpPbFT38aBQ0X
         /WnO/oNy4zoV5HCqQDi5/Yf3wQctd4daZfsq5un4IueXPsMrdOabaL6f4Ut4RRuhx3U6
         8410AGAjhRPgT/6PaJSEiBB4tKXEt2BpxatI+kZoLHYDCfh6r7IiWWJRFBWjFuIuk3JJ
         MHh3LBmzwT3NT2inA+V0CgGj/YQMTHjU3/KoJ31T08MyvsIXOudR0TOuGoa2Pm2fTPTg
         SC2w==
X-Forwarded-Encrypted: i=1; AJvYcCVQIXm04n5EsJOn+DMus9RncWEIzn7uCDt4ax988d/yKutMGr1cT+rhVKV/pYFxuQmmRPCWq79XBVUZa6y9EUZ4Xmu2Mp/J
X-Gm-Message-State: AOJu0YzOkMvsidep/eHlt/alUEUstuM30MMQ5dbfjViAqaSd6eVLgGHV
	A9OUp3ayUqLvSTqvST0SAsvr0dDcPmJb7ABDOydk2ZrYnI69F2et5Su1Mo6ArNt9l3R0UHK5Dg/
	Yzexjm5nCVa3pVOE3mWqz6QFAJHlaVMh5+1fCUTRxa6kxtHxcreP2D/CdOjCd0vbgcMdn8rTb7f
	FsV9LXKo1IhWjrDX76XZkLq7mwfImbYGU=
X-Google-Smtp-Source: AGHT+IE6JZ8z6rHbGfuyAqsPwwZ0A6UTgt2q9H0BIIO41e5ssqw7oM+Z24cq4lJYlqJnkhIvaQCDfMDIC96pb1leHiE=
X-Received: by 2002:a05:651c:10b0:b0:2dc:f188:a073 with SMTP id
 38308e7fff4ca-2ea9519b622mr46052261fa.35.1717397406398; Sun, 02 Jun 2024
 23:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531103711.101961-1-mstocker@barracuda.com>
In-Reply-To: <20240531103711.101961-1-mstocker@barracuda.com>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Sun, 2 Jun 2024 23:49:48 -0700
Message-ID: <CAP1Q3XSvz60Lo10j7RUJR7qmFLv=cMMkaN_EZ1q2YuP1VE6xxw@mail.gmail.com>
Subject: Re: [PATCH v2] vmxnet3: disable rx data ring on dma allocation failure
To: Matthias Stocker <mstocker@barracuda.com>
Cc: kuba@kernel.org, doshir@vmware.com, pv-drivers@vmware.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

> When vmxnet3_rq_create() fails to allocate memory for rq->data_ring.base,
> the subsequent call to vmxnet3_rq_destroy_all_rxdataring does not reset
> rq->data_ring.desc_size for the data ring that failed, which presumably
> causes the hypervisor to reference it on packet reception.
>
> To fix this bug, rq->data_ring.desc_size needs to be set to 0 to tell
> the hypervisor to disable this feature.
>

Reviewed-by: Ronak Doshi <ronak.doshi@broadcom.com>

Thanks,
Ronak

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

