Return-Path: <netdev+bounces-113716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDB93FA44
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506DDB21A89
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE9145B21;
	Mon, 29 Jul 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQSM3gVX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D636B17
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269245; cv=none; b=Da20Ky2ddtqNn2bTBPqHjXIHK8UM43CH11qt3vZ7P1LbXD/7rwlCIsBO2UuxQw3a3/3pnNw6lxEF5Oc3ZdZ8LNzM1mcoHGF+j14st0N3TekqmwDZhNGcF1uDpKrAhSF7hOBveP0qkwKPGYMoHMbqzVhFczXSjkdMAEWramz0Nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269245; c=relaxed/simple;
	bh=tsTiE4ecxR0zB+gJrv6oOTcN/YMdhi2NlPkt9dffxtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ7ci6fRbpJ3t/KKnImnFcw5E1mazRkMNu3Tm3FsjowGRbJ+Cibchb0C/w9VkOth+CH68DoerWUgp0C0Bu8Vz80pFNoritK4MF2xV4ngOTse3xCACw37K9dDdbQ4AuXTwWdkh9dH6/RbgOBlR+BQL+efva3O7UgIf2grMzLZorQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQSM3gVX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428063f4d71so70815e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722269242; x=1722874042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsTiE4ecxR0zB+gJrv6oOTcN/YMdhi2NlPkt9dffxtE=;
        b=lQSM3gVXrW4o4bAZEsFKF+FbLGVmkxzHnB3j3aDa98gF2mrwVu4djCV9LmrKFemVo5
         7bDeufC756pEfzZZvP7MIeCPVE1Ay7hUdQG6lLERlhVzUTBZeND26uHk3PdAWLlKdTWn
         1zL+gWjBtd9vNAxSGhL0V6P1W/tHSsFyCdzgH9EhlcVcxcJtn4MotTGLYNowXhzRPtZn
         aUkYx4r0aYEUBFngb+LIpBDuSfTKrCndP98XId4Qnl7dkuesaOkuyT8HoLMLNh9hG0TX
         tjyPlfO2SMoRYyH9TwfOKtHCdhBslCwiUWCH8G2hQ7dAswmt0Tmj+3mtbXEsi6Ip02ch
         xtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269242; x=1722874042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsTiE4ecxR0zB+gJrv6oOTcN/YMdhi2NlPkt9dffxtE=;
        b=fPZdch7UfCJQSKRPyO/JrHWKFRMC15j03e9W3/FSdvdsVTjLmrAjHugkMEhhnAOoTM
         jWjAGLcSqaIEIZ/oW66CiC8G+zwhgNNSfdfWM13u81JVa1M1uTLVkwJlD4ZVWr9y7mIh
         pO92jUVdyJ7wz1dBzMSw+G0g5ANOOVzX5eyoeV6lOxAy9XxiYncpSTc2C1rQNFziYidr
         7K8tummXZM7EWPbmAIsnXAEuv0gKKWLa6wePYecCaSQz5hj5K+dwlTD2ql6dID8Bz5AC
         rsm4K/BN+wU7CuuE2IuZ70MZvuJ2Pics2DiXVL8MWNx7y+jsi8X4iMnMQ7ZjtQnTdYhV
         z7WA==
X-Forwarded-Encrypted: i=1; AJvYcCXuAIFSf3POeB5IBCDaJIFpmiH+HrTYZRnMbleqoprikW/q/ZCP9c6S/hmxKknlijCgtUs4iWkN9Vr85f7gUx5NPMblTPnv
X-Gm-Message-State: AOJu0YxxC7YkpWexHp4UXhZOw6Scluax5fsOqimoB1gXQoCOgJAPWwWO
	FLEBYwSZ/J5iRGJXuF5+AWVNK+th0JIAswrnGDMZOyZeCVPkQZb6sNEwaHAMpi3xnfKkMfLAG7x
	8oEH5sN04dur9HqP80fLf32UztY4n5i9Ff6Ta
X-Google-Smtp-Source: AGHT+IGsnV5jXsHEmgyoLo1fJ3O8G3K6ObWiAAyaS7Q7EMfGdIH+YNhWiL5jQXTlx2sFwQIc41iXs+ImxhiJeFDolZU=
X-Received: by 2002:a05:600c:4e88:b0:421:7caf:eb69 with SMTP id
 5b1f17b1804b1-428225559f0mr147135e9.4.1722269241660; Mon, 29 Jul 2024
 09:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726204105.1466841-1-quic_subashab@quicinc.com>
 <CADVnQynKT7QEhm1WksrNQv3BbYhTd=wWaxueybPBQDPtXbJu-A@mail.gmail.com>
 <CANn89i+eVKrGp2_xU=GsX5MDDg6FZsGS3u4wX2f1qA7NnHYJCg@mail.gmail.com> <CADVnQynUV+gqdH4gKhYKRqW_MpQ5gvMo5n=HHCa08uQ8wBbF_A@mail.gmail.com>
In-Reply-To: <CADVnQynUV+gqdH4gKhYKRqW_MpQ5gvMo5n=HHCa08uQ8wBbF_A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jul 2024 18:07:08 +0200
Message-ID: <CANn89iJ6w9dkfUqKMe1q7uMHv9dF12tOQdxABv+qCqG37oa8uA@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Neal Cardwell <ncardwell@google.com>
Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, soheil@google.com, yyd@google.com, 
	ycheng@google.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:33=E2=80=AFPM Neal Cardwell <ncardwell@google.com=
> wrote:

> I was imagining that the code would not really be in the fast path,
> because it would move to the spot in tcp_measure_rcv_mss() where the
> segment length "len" is greater than icsk->icsk_ack.rcv_mss. I imagine
> that should be rare, and we are already doing a somewhat expensive
> do_div() call there, so I was imagining that the additional cost would
> be relatively rare and small?

Let's see your patch :)

Thanks !

