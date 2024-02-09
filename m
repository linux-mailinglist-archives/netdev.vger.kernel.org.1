Return-Path: <netdev+bounces-70647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFB284FDD3
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6981C239FB
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384238F78;
	Fri,  9 Feb 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6EGL5WJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957E76AA1
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511500; cv=none; b=EjZinrZVB2M1WYXgkEBe8sX60PnaVYdqgJuIBkJ4dRhULpp9x6Alt3pzSKM6WV7B7gkCNkHcoYMj+bk+zvI5jDjTALB3tfwj88+atCD42XBxS6YU/dyUitK/9fdoJZ+2MW/1wq4EEmLtlxB7HEZPTmdNyaoBwffxmAOQDpaP/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511500; c=relaxed/simple;
	bh=doSnRSb734b5e+iLDyq5CNkQ3JukV76zod1QHLCQrMg=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpFxRX844wLUTxgvokBtuHWmpBZMIofG4TDhdhmAf5Hk3NHvFfOpon+L+dAdiq8Dm6FHbfpq4pFDVa4Clom1jtVTzjyTbqhwEU2gwkXPPLMydu/q37gidaEMLusfN2Ijt1QFNPbB1BPn5V59qWXMeah7+0cBGvq+LQRlS7sb8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6EGL5WJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707511497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRXZt2Lenadkrg19LXKZFfHoYrs//vZSF/wB8P7zq0Q=;
	b=R6EGL5WJjJbImN0jEd1A+iP+f/GyUJ5gjRxfN47r9q/AdtoqG8GGr2Bp8v2c68fEraPMrY
	yh4TsLq3k7N1uo7TcfjMHbosoU4ozmnmvnVlJD5bTU2IxcmTT3Y66NNiPnqKfcZRbn06xw
	MuA0lTZyODZaBMScVlP2KVkrzRzkeW8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-D_ISJdigO1yVL1nc3BRQhw-1; Fri, 09 Feb 2024 15:44:56 -0500
X-MC-Unique: D_ISJdigO1yVL1nc3BRQhw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-560d965f599so799856a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511494; x=1708116294;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRXZt2Lenadkrg19LXKZFfHoYrs//vZSF/wB8P7zq0Q=;
        b=uv7An1UPhfy+Y5qbjBdlmsi5LqyDYz8JLppo7OGNZEvRJmu1rdHt86VOgKpR3+ogbI
         ZiYoeM5NUsgviLXsQhdJwe7VHezzob7D4kVdraEJJgV/0yuSeTNUnn9D0LrCHgX29DNR
         blZd+E/anj62jr12aLObi7t2p09LIrX0bE/YyayAQynhkxcdjLlHtgaQagFWzb+T83vZ
         ipt9eYExBfPsRJf8gVaB0A8y9klxH4z63MlEakQvc49Lf/aylvXsWHk6Wi2jg5T1xye6
         +JtAExwd6hWaEnozsEiXTsAOfApj1KC5IQwLe0zv3UHpllEoSC5hLHrlTRdbKMJeYAyK
         xMAg==
X-Gm-Message-State: AOJu0YzV1CcS6cOsXXatXy0Qm24wh7VIvOHpagu2LCpYEJbjSavzsvND
	+Ee0gGtDVpY+7eCaTpH7MF2RZ58qnE4dL8Gwj696PYkgu3ufuEq+hS8AXPXtxkH2sY6TordLX2J
	D4xObs7V59GD2ro9oX96XzF8nR8PKASaPPiCJ7nBAnGInwBItOGHlvJv7HduLYkeBIMeWcnVFxA
	3UtYYcgmD71wUsh2S0f+ioGRLoX7yqxFW1pEFGh60=
X-Received: by 2002:aa7:de08:0:b0:55f:f73d:c63b with SMTP id h8-20020aa7de08000000b0055ff73dc63bmr60529edv.20.1707511494429;
        Fri, 09 Feb 2024 12:44:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFACatev+ue2ffrSrNyXNM+8+D8ylLsSpVDF/RKwVPMfZgSaNoU/Yhb4/jkVmBH275fjPdMKoPrRXo2iLgAvN4=
X-Received: by 2002:aa7:de08:0:b0:55f:f73d:c63b with SMTP id
 h8-20020aa7de08000000b0055ff73dc63bmr60509edv.20.1707511494058; Fri, 09 Feb
 2024 12:44:54 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 9 Feb 2024 12:44:52 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-9-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-9-jhs@mojatatu.com>
Date: Fri, 9 Feb 2024 12:44:52 -0800
Message-ID: <CALnP8ZZAjsnp=_NhqV6XZ5EaAO-ZKOc=18aHXnRGJvvZQ_0ePg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 08/15] p4tc: add template pipeline create,
 get, update, delete
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:54PM -0500, Jamal Hadi Salim wrote:
> @@ -39,6 +55,27 @@ struct p4tc_template_ops {
>  struct p4tc_template_common {
>  	char                     name[P4TC_TMPL_NAMSZ];
>  	struct p4tc_template_ops *ops;
> +	u32                      p_id;
> +	u32                      PAD0;

Perhaps __pad0 is more common. But, is it really needed?

> +};

Only nit.

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


