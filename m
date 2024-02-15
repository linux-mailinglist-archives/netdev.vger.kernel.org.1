Return-Path: <netdev+bounces-72151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC5856BB3
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824E4B26513
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC413848D;
	Thu, 15 Feb 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeJXX/+u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F63136641
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019774; cv=none; b=qML72j77C8ZJDlYwZcqd2FWkIqYZX4oPlWu4OD0aupjziItEF+YQrnvNW7tGXTlV6yHtmrgT4VgKmmU1kFeYGmPWJjv5i7fz7PU/GzsjOnSn2bvMj4wKdqgkSWrklMnPzFeJgm96/Foc4MmwR7aSwZ761bA5DJnDAr0GZPYCsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019774; c=relaxed/simple;
	bh=oKtv2APj8l0mO1DIuBTt0dKeKN83ha+KYp6qE3pmWkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkkyssC+Ku+DPfZ8RquON8mbOWwb/qqRU//UPeR2a/Bc8PXuFccjgg1nHlkfQ+LOZZmi66U6lTleyKxVY3f36uLQNMqOzTtlXj3wpdCezJiCoGSozgFz68II9DNpvtRqpJFWYyUIil2lAVs7Kib0f5wSZhsghei0aIiQzhcNxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeJXX/+u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708019771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKtv2APj8l0mO1DIuBTt0dKeKN83ha+KYp6qE3pmWkU=;
	b=QeJXX/+ujLiA+17I0sCw+W2Sg8ndlYq8Lo3dYAC7ojTSHWBRTr0lG2Ahh7s+5vSKlJsWF8
	LbywZjGRXWqsbgfAyG34uiaMWk3vTzg97UE1mtD2HuCWIbE07ysMVbzsuDOOt6zAdgizRM
	bxPboNlAXvWjW+P7rwN03TAacKE9gus=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-k1MZ3wlHO--hfRp2MtOlYg-1; Thu, 15 Feb 2024 12:56:10 -0500
X-MC-Unique: k1MZ3wlHO--hfRp2MtOlYg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-511535180b4so975928e87.2
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 09:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019768; x=1708624568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKtv2APj8l0mO1DIuBTt0dKeKN83ha+KYp6qE3pmWkU=;
        b=cHsXTm5UQJvHxqft9QYhjaEnl3dXIWvXUYYF2wRTf0LUUz37qa1HO1S5be/Apbg0Pw
         4OaZr/8Z2rPyIghYGUP6TN4yWVIuSGRFPj/vD8JjVbMKN2Y6JwH/IU46M44pv3PWdXpx
         qL5hmiIvkfFIxheXz6JLmLOZQLN0Vp8wGRGu/MgI2eYQmR4u++GFeNCEVhTS8SvnFKUk
         BSgKQABo+3dMH4K1SU9U9hesETfRSSMIf5NquVYG6gChdxpHdJ9x8w9wek2aahjYnIll
         qlJuUcJUqdjc0ncu3NXRDbjfayAvjWg10mKduGQcEucWjXRt0S0faou5xrCX/Ijr0FyC
         SUBg==
X-Forwarded-Encrypted: i=1; AJvYcCUoHPTAN77NEwbCyusPpCKkdbxIBgtGEIkpvTtiDXMBK6M92c+BkZaVthwj3LLZJpxUlETzFxtF2Ubtj5IMfAxI2fSqAx6b
X-Gm-Message-State: AOJu0Yzt0UpMdKkZATZ6b6vR7gWhLjPIef+JZ/htWuOH/cCjfPB7Fuku
	dFyh82KUtXKrmxFlGJN8npfBvcqRSZ/qL1TFlnOyIRatRtS3rPRQ12th3JF+NDNtdPqiHQIcYlw
	Hk2LLfzTYZyHm6Yz/m0fSPo/qAW2af1vgz6i6ynVfhEnz8rfi4695ibAnbjX9ENx7WeigSH3NBl
	3BNFQnsOylpFpvmyVGx08Zi6hgXRXv
X-Received: by 2002:a19:5205:0:b0:511:47f7:62e0 with SMTP id m5-20020a195205000000b0051147f762e0mr1856535lfb.21.1708019768632;
        Thu, 15 Feb 2024 09:56:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbf9A7YdOFWhLkLSXMyiedaavL5pPS9/qcv4yiSmUOuIOMITpLfF+9dRh+rZbSBmpnhoYoaYxAoAhZWKVKWRI=
X-Received: by 2002:a19:5205:0:b0:511:47f7:62e0 with SMTP id
 m5-20020a195205000000b0051147f762e0mr1856525lfb.21.1708019768324; Thu, 15 Feb
 2024 09:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209235413.3717039-1-kuba@kernel.org> <CAM0EoMmXrLv4aPo1btG2_oi4fTX=gZzO90jyHQzWvM26ZUFbww@mail.gmail.com>
 <CAM0EoM=sUpX1yOL7yO5Z4UGOakxw1+GK97yqs4U5WyOy7U+SxQ@mail.gmail.com>
 <Zczl_QQ200PvyzH5@dcaratti.users.ipa.redhat.com> <20240214163132.54fd74bc@kernel.org>
In-Reply-To: <20240214163132.54fd74bc@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Thu, 15 Feb 2024 18:55:57 +0100
Message-ID: <CAKa-r6vwCpK0ZcoaFgQtdFaQ15_RF0zE+jR0_NoZdwg9D1ybbQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred ingress
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	shmulik.ladkani@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,
On Thu, Feb 15, 2024 at 1:31=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

[...]

> > If I well read, Jakub's patch [1] uses the backlog for egress->ingress
> > regardless of the "nest level": no more calls to netif_receive_skb():
> > It's the same as my initial proposal for fixing the OVS soft-lockup [2]=
,
> > the code is different because now we have tcf_mirred_to_dev().
>
> FWIW feel free to add your Sob or Co-dev+Sob!
> It is very much the same solution as what you posted at some stage.

I'm ok with the current tags! thanks!
--=20
davide


