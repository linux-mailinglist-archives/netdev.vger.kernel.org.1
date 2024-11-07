Return-Path: <netdev+bounces-142793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892CE9C0613
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26875B220A9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CE420F5D9;
	Thu,  7 Nov 2024 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHJZMKDi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C520F5BC
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983382; cv=none; b=Ec8EwMe5o3pAP4E+/fXJPM+YudwU4tHtVuzL7D3l347vhSMxXU7bBnJ5C/2/Mh3mGQVMEnalQKJ36s3VTQi2I9tQK/XROZ8jcvUKEdjo8htl1mYVk//5cHMgpjLnmDZidAyC95XKX9MaudoxFzrGr1kREwin61zpDQli0pxyo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983382; c=relaxed/simple;
	bh=/v6itHHmwpj55a9Ueu87me8eVNwUqqHOLNHMFGOvbe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw+uv1AOOgFhjsPkJmtp9RzapgY5K1ijeLM4EZGqVMzDdnJTkKfX0N8GTwWrva14biGJyJGi2x9pHuZ7HawUV1TNyYnlHmfkvwl37GdxnGohKaaWlrBF9YI2TVdJxGjgysKySb7HMn/YwpxzFJRPmnvT04aCR3YGOWOkY+WRRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHJZMKDi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so963025a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730983379; x=1731588179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v6itHHmwpj55a9Ueu87me8eVNwUqqHOLNHMFGOvbe0=;
        b=iHJZMKDiKhXYjkYmb/AW7LrwPGJrHgzh0cBP4P1/Y9Juh4ORT4ZJKEjFzVtUYFlgKa
         Z5O6nca0tCY+NUdjLrnGwRFPB9XaXPUWox2n7fUt9IO2DXjPiD+Q4MOyXy2OUqzo2g7K
         y7N04z6bvnuqdtUDoVWyUxosJV1UEc72k1wmANExOhQJi53or261OUeskrrgZ6t9hYcm
         qa+MXwe/uqY+xfVhqBkpYF2ZLRNuFiLZEcRqrqdUdLpqd5LoRf3eqQPtBibPn5Z0IY9d
         BMIeG/Y5+6tc6mN12dS912a9q8+LKsLqu0J3fSd/eDlFMQ1Yxd9mV4wSpPIxFXBcRHLv
         ClvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983379; x=1731588179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v6itHHmwpj55a9Ueu87me8eVNwUqqHOLNHMFGOvbe0=;
        b=FnFOXudTMYdgXkYjWYh66WtZHc97hPoVaPytOPV4C7Jsjpjwg2kz+IX0n5G7tx2Dqh
         YPKi3FExDjZe4y67dE0jB3EB2b0nnqU9pa59C/zPIhy9aT2p/bIdhzwoHCORV2ouY+kT
         w/uyvlXDnxMqFiEl3E4FJrYH9TXHYaQXbTQ3Z+HPG6Iit38M0snLseY6zWUowW27E7FL
         CrOdTgyLKBcXHZQE+8ArenXYbIFGtSI0RMszKy/Q25gAr3s0cMdWVSiralFMBK6/wN2C
         ywW9CBaTCaGcgowgTcqnKW4VMBSr5W3O+AFy5b5D/9jyttMsxZbyBnTHIQC2OcsRIsE4
         ahrA==
X-Gm-Message-State: AOJu0YxIzo9twsp7kkZctqHJjbNJK0MxdkPXuGBE/JEX+grdEIEbEWYs
	5qhz8PnRePmASbHuflTMbcOTdDtUfAX4AzKcz/0MNuDJgswOqRHvbuz6t/DRPhdPkdhMeqIygRf
	Qylwy4QlU3LTwsIuUx9zL1FM20rH9sHVqAJhKhvUOiGpGg6q0uQ==
X-Google-Smtp-Source: AGHT+IFKf6zZ//WCw5XMeJTuoFw4Owv0wF+FRy01fL8DSe79ySBpTLQb9HFtlA/iK5UJCkaX8LOlbT1jyjeJKZv2HS4=
X-Received: by 2002:a05:6402:3491:b0:5ce:c925:1756 with SMTP id
 4fb4d7f45d1cf-5cec9251eeamr12190654a12.6.1730983378900; Thu, 07 Nov 2024
 04:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105100647.117346-1-chia-yu.chang@nokia-bell-labs.com> <20241105100647.117346-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20241105100647.117346-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 13:42:47 +0100
Message-ID: <CANn89i+t0cJ8Ah5rYMh0B_Js-ynrsHbWpKsT3WXS=OcYqsYN3g@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 10/13] tcp: AccECN support to tcp_add_backlog
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, joel.granados@kernel.org, 
	kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org, pablo@netfilter.org, 
	kadlec@netfilter.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:07=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> AE flag needs to be preserved for AccECN.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

