Return-Path: <netdev+bounces-101661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D4B8FFC4D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7DF1F23562
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F2152530;
	Fri,  7 Jun 2024 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6Z3qebR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490FF152164
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742148; cv=none; b=Uxlsf6G4g27Ul85R17U2txTIRl+VdbtQjecfH5lcG9Q6elHkEOJmZkHGWSh9ckQhMx0xbtTF1KbDT0poqfPLE5gB9CUK/awoQvdnkUtVolS/TW46KVD5WRUsoss0EG0yYErrA+WlIpEqvv7+nRnraMkS5kYCXVflf8imA7YJHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742148; c=relaxed/simple;
	bh=vsF9fVM1//kd5zIx0GTtpB46iJMt9vsqNkPX4bd/w5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChU8Uh/sC8ct728+DRg8Zg/COd3USynhgfA3q1MXZOeVb59D8jxadC1JYSbxOCJEAfz0t5so9pEOkqFPyfbk/lL8buWpFFgx1hRCgwS/ix8uDGK41gyB2GI2EISVcYTWqzyOquK0eNCMfjn8jsGKDiJZCuHEUyv78/DVM9A7QNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6Z3qebR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so1318a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 23:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717742146; x=1718346946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsF9fVM1//kd5zIx0GTtpB46iJMt9vsqNkPX4bd/w5Y=;
        b=O6Z3qebRozuaXrdItPF6U/X0GkPvJTO/BwV0iHOr3HgIdH7VyQMuctWBXynllyqEUb
         nxcaXZ7YCGM2HmZHsYh03+U9mqnS5LAhAAo2QEFrpOjjRTYlT+gYhw5CzPnbgnWLb3WH
         NQ0Z1T1GVjlGxTyH3RIVPbJ2XUu2hW5QegI/PQadVWQEb7YT17S50n6I9Wy9GZS4Riqh
         pyFB+vEy+mY9Wtk3TlzxrbJ9v2NWI7QAJKq7Q7zgCW3IG+4LJJ27RwHOoYQoFrt5Pzyw
         6c0gZ5uIuvU+PlA1/BDUhz3Gj0UH0S4bjEhKhtNFZbuaQsgX54jMfh2N2cOgCsagnieP
         WlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717742146; x=1718346946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsF9fVM1//kd5zIx0GTtpB46iJMt9vsqNkPX4bd/w5Y=;
        b=mEla/45Mw+JdpRmQOBcF1eo3m0P5+7KDeeQhlJ9kXgRg7Ozmfmt6aUDKE4nEDRvolz
         IP3qfItDHGFrLBNTF/+5/R251oueKDmMZT0MMujPvOL8Uk4gJCtX4cfmqlqtnz4mV+Cw
         gE6yr8TlrW10t0imy0zezKGX727ddQUqyzN0AE+ph2dQ6u1+BpxuWMeWglBCWSgoPezM
         uZpr8H9Dv0eFfORF/KXwcZl98sUE5dfZzEUA0v8pqfFvS+gat4NSAi1G3kFf/JZfZuZX
         REOzRadPSDFSShp0ejBwgnvEkyyd04UGpSzH/ZQzh+wACUk8LrTT8rJW/jo0vEsg+b26
         ZH3w==
X-Gm-Message-State: AOJu0YzyDQIEolCo8mTfe5RMg8C/yqWdJ2miIdAym6Z3O+jngm6zQO15
	qmAs/ZfMBfyXHvVhDcYsYQ2iUrEFAFEUZrV9RQtJB20kaAjybmq8SMgWd7LMqU5CHa973eL8G6K
	uvEHklHbLd+v9hYr5ZTiDdgq3xOn8oRV5UIS5
X-Google-Smtp-Source: AGHT+IF64JuoiPukSNP2gEYzmiAaRR7C51MbEvSdVrxmayAIXhwe79uUqXfwQeRF4HSgZ8lXBFI/4q1ZrGMcOMdXg/k=
X-Received: by 2002:aa7:d307:0:b0:57a:3103:9372 with SMTP id
 4fb4d7f45d1cf-57aad3278f8mr374926a12.7.1717742145328; Thu, 06 Jun 2024
 23:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606192139.1872461-1-joshwash@google.com> <20240607060958.2789886-1-joshwash@google.com>
In-Reply-To: <20240607060958.2789886-1-joshwash@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jun 2024 08:35:30 +0200
Message-ID: <CANn89iLy1qGXzrv_coRcaRDOrOMHKb-NG1xn06Sat0QTvrDwXA@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: ignore nonrelevant GSO type bits when
 processing TSO headers
To: joshwash@google.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	stable@kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Andrei Vagin <avagin@gmail.com>, Jeroen de Borst <jeroendb@google.com>, 
	Shailend Chand <shailend@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rushil Gupta <rushilg@google.com>, Bailey Forrest <bcf@google.com>, 
	Catherine Sullivan <csully@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:10=E2=80=AFAM <joshwash@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> TSO currently fails when the skb's gso_type field has more than one bit
> set.
>
> TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
> few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
> virtualization, such as QEMU, a real use-case.
>
> The gso_type and gso_size fields as passed from userspace in
> virtio_net_hdr are not trusted blindly by the kernel. It adds gso_type
> |=3D SKB_GSO_DODGY to force the packet to enter the software GSO stack
> for verification.
>
> This issue might similarly come up when the CWR bit is set in the TCP
> header for congestion control, causing the SKB_GSO_TCP_ECN gso_type bit
> to be set.
>
> Fixes: a57e5de476be ("gve: DQO: Add TX path")
> Signed-off-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

