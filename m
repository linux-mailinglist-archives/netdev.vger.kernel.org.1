Return-Path: <netdev+bounces-157887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA21A0C2B9
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F4E3A8079
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384A1C07C9;
	Mon, 13 Jan 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1iBCJxN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98224023B
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801227; cv=none; b=rHY+2G4y1AfDbAR/11pkuDy6dFT5X/vMvj9yO8oQIK9NxAIyXrZv+rRtQWX2ebChuj2Yx5EmSqtJWlT7JiFb5Rv6PafWQOI3wWLK7MLSODx2CSEUSYU27lhIClr1ADrmalYHYTS3vBnLkp24z44hBsx9pzz2rtt52tAp0rOcCZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801227; c=relaxed/simple;
	bh=8cJD4unik2sXWZa4E2sdL+wD00JTOrDo2G7UPHH3Rjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGmE/llYIDAVp/Xe4KgZtTCq2HjUqoyo7e43gczbH+fb5yssMf4LuRRAEJicwVClxn/MXNyOiT6EJN80S+EXQ1mTmMzIkFf142/JnV52unpKFg//h9o96wcdjVmunyxa/PfpajyLj4vbC76eWQGAAapUG+CLc6RhxfqlRkd6D7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1iBCJxN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736801224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X5FBGFo628NG7TIukXYV94iAzpBm3+Gg1mQf+wAPfMI=;
	b=e1iBCJxNg4pOkAjIFjL8XR4O7W/YpkfbafVe7u6sBWQIR+d8MMP3lt/LGX7TSX7JqG5QJZ
	5+STXb+OhnbKadrvNjcgU3XhPyD9NN2Uzi8Q7b0l/5fSIF2yiZiCXXaTAV8WR9+4Dzy0y/
	oPe5xsUGy8Q2B0rEVJKZSQStWpdn8VY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-9e2f2y5qO_GdHDeJh2Vh5A-1; Mon, 13 Jan 2025 15:47:03 -0500
X-MC-Unique: 9e2f2y5qO_GdHDeJh2Vh5A-1
X-Mimecast-MFC-AGG-ID: 9e2f2y5qO_GdHDeJh2Vh5A
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71e1158c92eso381613a34.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 12:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736801222; x=1737406022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5FBGFo628NG7TIukXYV94iAzpBm3+Gg1mQf+wAPfMI=;
        b=d+ChsEU+NsD549GRZ/bCqN0vvPlu00jpn0sHAyKdNaNiiNsg7lcYEk+ORmOcnCjXZJ
         B2hMcluuE2/IhrbRUuhem3i2FjREaA0ZrZ2cxI26zlxXrQ/NNHQ3YJbTim9YJbsQI8sm
         kOCvPcIbuk5e38Qnpn6sP3251G65geoSaXOAIMhn8eyGcNYlw7YVUSyDDarvO+Jxvq/j
         jRXDyGPSqDzfPGeUPaL0rDzby0K2czGGPgizmN2olqzZMUCgGw+AK8IufQPqUPfavISs
         rkusVe3yGT3RuDlWK/0fgxZgo+VrDO4qJ7vVhPCRG7nHrR0bND+WFa2Cwkoi4vfDMXPC
         FUlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9YOsyIsitdzoosdRFVz4HybPLbognTI+20gIt+FlL2Txn1o6NwAa2oBqySc4DSxWrRmWic4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCe5mdZ4A/scjHWHZb3Hdp1mYtj+Yc3KvRGfdgslyeTjSVnND
	1pmzb5yjcazRpIhJccTdBmVras/ZX2lfubDhFASo2pmjcAKnQfFoToAnlFYho/TG/cdR6XXk4zY
	pzMey85dStxZpO83kl9Qz9qnFbFbr8Y19aNuLlqghtARywN1N1c4d/p6UwVyk449jlokG1gW0EG
	6zh1b9d+4yBlC5MwD3gNnXxBUW869I
X-Gm-Gg: ASbGnctlPuus2dXNDnR8ZsQ8nWeUy4oLb15BPbghgZdOg9hhx3gR004MQNT9JM5oNl8
	KqieBnsV67aGEd3Xgarf1avOP5du7LzWz/13CDw==
X-Received: by 2002:a05:6871:4608:b0:29e:4e50:378b with SMTP id 586e51a60fabf-2aa0664827dmr4505008fac.1.1736801222156;
        Mon, 13 Jan 2025 12:47:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH/K80PGj/4rYYdObdzYPWQ4q9v+6dCZlU4/pdy0hUxKSVk0uQSz1OhcSCuSdSyUD96ErXxTItHv00mK70yi8=
X-Received: by 2002:a05:6871:4608:b0:29e:4e50:378b with SMTP id
 586e51a60fabf-2aa0664827dmr4505003fac.1.1736801221848; Mon, 13 Jan 2025
 12:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
 <20250108221753.2055987-13-anthony.l.nguyen@intel.com> <20250109181823.77f44c69@kernel.org>
 <961f010f-4c53-4bb6-a625-289b6a52525a@intel.com>
In-Reply-To: <961f010f-4c53-4bb6-a625-289b6a52525a@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 13 Jan 2025 21:46:50 +0100
X-Gm-Features: AbW1kvYmyqpBgQBX3k0ubqMH59Kfkc3o0Ie-qmbgpkGOJ1IgrwXR88uLvPF4OSU
Message-ID: <CADEbmW3As4t9LbZqvjKe0CyWQkYMOVKMzQgtmJdcqkQbyayP1w@mail.gmail.com>
Subject: Re: [PATCH net-next 12/13] ice: implement low latency PHY timer updates
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, anton.nadezhdin@intel.com, 
	przemyslaw.kitszel@intel.com, milena.olech@intel.com, 
	arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, 
	Karol Kolacinski <karol.kolacinski@intel.com>, Rinitha S <sx.rinitha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 7:51=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> On 1/9/2025 6:18 PM, Jakub Kicinski wrote:
> > On Wed,  8 Jan 2025 14:17:49 -0800 Tony Nguyen wrote:
> >> +    spin_lock_irqsave(&params->atqbal_wq.lock, flags);
> >> +
> >> +    /* Wait for any pending in-progress low latency interrupt */
> >> +    err =3D wait_event_interruptible_locked_irq(params->atqbal_wq,
> >
> > Don't you need an irqsave() flavor of
> > wait_event_interruptible_locked_irq() for this to work correctly? =F0=
=9F=A4=94=EF=B8=8F
>
> My understanding was that spin_lock_irqsave saves the IRQ state, where
> as spin_lock_irq doesn't save the state and assumes the interrupts
> should always be enabled.
>
> In this case, we lock with irqsave, keeping track of the interrupt state
> before, then wait_event_interruptible_locked_irq would enable interrupts
> when it unlocks to sleep.. Hm

Do you even need spin_lock_irqsave() here? It seems to me that all the
functions where you're adding the
wait_event_interruptible_locked_irq() calls are always entered with
interrupts enabled, so it should be safe to just use spin_lock_irq().

Michal

> So this code will correctly restore the interrupt state at the end after
> we call spin_unlock_irqrestore, but there is a window within the
> wait_event_interruptible_locked_irq where interrupts will be enabled
> when they potentially shouldn't be..


