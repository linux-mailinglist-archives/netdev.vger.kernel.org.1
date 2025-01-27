Return-Path: <netdev+bounces-161093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB5A1D48E
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A4B18854B9
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C41FCD12;
	Mon, 27 Jan 2025 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qbwgdyow"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4A25A63A
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973942; cv=none; b=gBRnnwHZl/Knb80s6MNMbfieZyN/31nyGIrD8zuJgTy56aKS4pCCgZVUFhcc94lqmKCY8UHQ9qgpJ+zEII3OtfgnbisqhkLufHkNbfo7P+xSjtQuqTa8o8UNOcnR++JxdVVoZulCA3nzo92l5TCeuUi95xQlOD+iVMcJMgfPHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973942; c=relaxed/simple;
	bh=Qd9LwvibzRcc4vzTkCDluKMFR9Wk5xfGDEsoBrYMyQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GfYcmlLqEX/wooH5Qun+YUEZD2gp5PnxcuGdX3r1CnLntUViLJuKyNVXOHDo4dW0kU3HA+ovu/3h8QNgVHGMc3sYrbO2fS/zp3jiyBUJChnuKpkPg6zpWEGZQPafWUAVDtf441sFw3oDmd24Nww8aUt/1WQvF3Ix8an/cuhAG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qbwgdyow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737973939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3Vqlt+y8lCu8rofsRb8z5Kc4aL/iRuZFloOalU+aYU=;
	b=QbwgdyowuiyLThEe4MEBZYBOE/uVsn6efC3hKo7e6/YT0bHoMvlI3fS4deuD7i2Dayc5fW
	ZtfW01aYmtRoKt+5YPqgiZItuflEnZ1CAaGKy3XigkdIBoppyChTzmlA86o0iCeb7OR8Wf
	WGP6lpxGy7kY6XB6XA4LA+ps/mSjIAI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-X1u0zZmaNAWsCAwPcBG9lQ-1; Mon, 27 Jan 2025 05:32:17 -0500
X-MC-Unique: X1u0zZmaNAWsCAwPcBG9lQ-1
X-Mimecast-MFC-AGG-ID: X1u0zZmaNAWsCAwPcBG9lQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862b364578so2489883f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 02:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737973936; x=1738578736;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z3Vqlt+y8lCu8rofsRb8z5Kc4aL/iRuZFloOalU+aYU=;
        b=budqaZa5/HhmTIJtjrxttMZ+fPKthNnhR68MZ5sqa9j/ThOhkpKbQIamdGCBLLpV3t
         6Uz/aGSZvmYwyYzrOEMYjrN4AWA+4pyGoVnIt983m5Z1LtWdGr9cIVXgHVSNtvB2lwqk
         R9H5qzgtWfZ+frBa3vXFnwzLfCHLArma2Z20YKBpFJcR+EzwuV4THHIgXO4Y1TJ68w7Y
         VwpD09dxpAg6I8h4732B1ARhm/ohoXAUAn1YSos4KnqiMIpN4LKP/jcrfEDF/dNKnMIl
         9guMaLOhcyTb2kyYdlcn41tJ1d/s2BpLj4zvaDBe/sALrc/+iaChDbxj6FXzr3qiWgjI
         wp8A==
X-Forwarded-Encrypted: i=1; AJvYcCW+ZG4BRNsC7c0+WypBFGC1/InGMQkmlV2PWWZR3fWtlt/D6BsV93Y1GYovi53LwwVzHTyFZ3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA/VgFmWcl5WVXscVcB7JGmzK74tMNXGk0uCSleEqxtsq3Ep8B
	IqE7AC7Nytihd6K3Y+8ysA14LktooWN10WykfmHaOuax4Yvvv4HKQfiBLhXyMAEemtpIjMprMnA
	mELpR5EqGz51PBCf3ah1J8iRpVctg3dUe1GGKk5O1tJFMPNWE0+IhhA==
X-Gm-Gg: ASbGncuG75Ls628cHbthPqTMj+6wasyaAvDQjZuVMSKJq4nYxkrOV0N9TZfSVXjJDwe
	Ox/UyZlHeabWGhmQqNb/NBG30RInif1KWADwjgc8KWc9tqesOkF5jzQBRXG6HiyxSwh0fxpun1s
	sKbyYQgbzQrxNzv2y2gbz5hKkN8ubs0LhRS9dzsOXOMSdST7MWO1Z8CzB4AzK/FP5WouIUCtY3Z
	KVOB/vIIiiUTigwBqrLtBIszEtzK8kwKaav2/NxRSD2uzoojG1RPCDk6I0Ld8UCPLDpTPBADLBr
	1KWqFWSftszfI4GgBzkvBY6EHrX1cirLhg==
X-Received: by 2002:a5d:5f87:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-38c2b772201mr8780042f8f.7.1737973936604;
        Mon, 27 Jan 2025 02:32:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQbbX7uJ+01NGvsbX0RdImEsMiOFh00VlYJjdc+sd/qdIka6oOUb2qOaQhfYZrKM7WgffxEg==
X-Received: by 2002:a5d:5f87:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-38c2b772201mr8780019f8f.7.1737973936293;
        Mon, 27 Jan 2025 02:32:16 -0800 (PST)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4b99dfsm127890385e9.26.2025.01.27.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 02:32:15 -0800 (PST)
Date: Mon, 27 Jan 2025 11:32:14 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top,
 lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com, Menglong
 Dong <menglong8.dong@gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
Message-ID: <20250127113214.294bcafb@elisabeth>
In-Reply-To: <CAL+tcoBwEG_oVn3WL_gXxSkZLs92qeMgEvgwhGM0g0maA=xJ=g@mail.gmail.com>
References: <20250117214035.2414668-1-jmaloy@redhat.com>
	<CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
	<afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
	<c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
	<CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
	<e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
	<20250127110121.1f53b27d@elisabeth>
	<CAL+tcoBwEG_oVn3WL_gXxSkZLs92qeMgEvgwhGM0g0maA=xJ=g@mail.gmail.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 18:17:28 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> I'm not that sure if it's a bug belonging to the Linux kernel.

It is, because for at least 20-25 years (before that it's a bit hard to
understand from history) a non-zero window would be announced, as
obviously expected, once there's again space in the receive window.

> The other side not sending a window probe causes this issue...?

It doesn't cause this issue, but it triggers it.

> The other part of me says we cannot break the user's behaviour.

This sounds quite relevant, yes.

-- 
Stefano


