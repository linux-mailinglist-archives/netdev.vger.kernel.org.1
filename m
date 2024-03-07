Return-Path: <netdev+bounces-78388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09CB874D9C
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF88E1C20B0D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1C129A84;
	Thu,  7 Mar 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3/YH6w7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FC9128378
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811390; cv=none; b=HfnvHwZySCyMChkXaPChO47c2mF2thCPpZotnxjYkVbjWiHv8aQ6+ZQS1TZ8iP6JzZCXgMGpFC/9RVDMmxKt0uw0QmtZivq8X+pyPyGNZXHt+S1btx8AkwKP9r6GS27NBMJhEI1GABBbAn3nJhYT5SYCIyJzJ930urXAKTnidiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811390; c=relaxed/simple;
	bh=z/APOdaKVCW0nV+fzkJMoIJM49ECU0kgRk9+jVDwdgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBgVbDy+pf0677wT63ZTZ0LvI/BMe9Ks9me4f8HCau8j3Yj0240c45P8YUqRRKqgl01pl7V9mCZl5xBPFldT0vq17+mLF0rAbQJ/4jF/tCKXp1Y2/bP0U3UPxHinFYIiHhpJb6cEW9yUBfT0PYreoNpfVrqdPfGmYppT1VQUWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3/YH6w7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5681b7f338aso3361a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 03:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709811387; x=1710416187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/APOdaKVCW0nV+fzkJMoIJM49ECU0kgRk9+jVDwdgY=;
        b=p3/YH6w7V3ni0kAfCB554OLE3gcBjcfTMFxfwadffcDXkPR4L+rRSSI0iJUaYNNp4W
         FYmACN8wNxeIC046XUIc4BPXx9WAYEUyoBnQ2haXqgys/OWu/Z3gr/iBmxHbF9w2OTXS
         ewPQrNZCiSi+mftOEHTMJyOvNMunw92QiSrPCLuEeYIACXxkR2ZWCjoF8hLDXpZ2gJMc
         7RFRbH0hLRJliuoTG0D6Ks951o2bxg+nhA/x53J0ZdXQmpzRvmy28dOpDe7hKUJT3aR7
         wnumfMvIBRzwFJXhc66m0xlhTZDjDv/IAUT4buWMz/IVRdaK+FgGDPLqenm84jJ9sE5/
         O9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811387; x=1710416187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/APOdaKVCW0nV+fzkJMoIJM49ECU0kgRk9+jVDwdgY=;
        b=fUcHXQyJm/HaHXmLpCIdLuqO9EMNezgDoiaY7vLd+vzyCoDOIZsFvuGgSAjNpQDg97
         Lk3uit/c7Z2qo5KXFn2WGy+oV/Mf3pYvNYESjUKLNXcOu2l7Yxs3ajfQ1RZlWMbX03Xq
         m8FpElFHQoAP07fy820p+h4yEdkGZDFfd/rAc1BTcEgSMe2XNACVohsw9UBFeTWgF7tm
         eUGIoObURxEO3gM/9tMDSfbsb41i4FaLRprXXC5gru9hCHNxHx6yb2pfGuhc6Tz7wzeu
         k2JPZRizSNbN3MAosKxwWnRma+QcMWvQv2smdGeaOLGzkVT3KvSfdoCHGJ7l8VjLnIHk
         EBQA==
X-Forwarded-Encrypted: i=1; AJvYcCXqmTEW4uFYyYaa8ChbL5KrQDFK/n4q1yG9VuMuVlVwN91kB7aYufuOEI8EnSEcfecKEe+llk5oheVAr+u5AF9z+/BlE2E5
X-Gm-Message-State: AOJu0YyTprKpMfP7dp8sC3TR2wDpu7Rlo2Ke06QXlAJ0Z9U/8E2Jwvnr
	FGJGsIXUh5fAsrClI68kUQToTGR2pe1g9YcaX82alOa10lBsF0skNgCNzJjrRZh2Wji0GwmbM3t
	5eQIQ0Uea7SSoJCq0c548htiqJDoiQ5lqEccb
X-Google-Smtp-Source: AGHT+IGhKpaFISh6h77rzCFM8kMEcKQujZVf7FZR95JZO09BK+PBIzQ0T/DBA/25M6CBax+euiF805iv0p6iHRNTWsc=
X-Received: by 2002:aa7:df92:0:b0:567:f511:3815 with SMTP id
 b18-20020aa7df92000000b00567f5113815mr149020edy.3.1709811386941; Thu, 07 Mar
 2024 03:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304092934.76698-1-kerneljasonxing@gmail.com> <20240304092934.76698-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240304092934.76698-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 12:36:13 +0100
Message-ID: <CANn89i+LCcumU32pHt2oUnpA19hvgy7YJ7us0brcpL7Szx8tcw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: add tracing of skb/skaddr in
 tcp_event_sk_skb class
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Printing the addresses can help us identify the exact skb/sk
> for those system in which it's not that easy to run BPF program.
> As we can see, it already fetches those, then use it directly
> and it will print like below:
>
> ...tcp_retransmit_skb: skbaddr=3DXXX skaddr=3DXXX family=3DAF_INET...
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

