Return-Path: <netdev+bounces-169049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC9A425F2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EFB19E095B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30E1607B7;
	Mon, 24 Feb 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z+qZsqlb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9B14D28C
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409250; cv=none; b=LOR5hdgLVqCFJaEuhsx4FUld4S4xry1Wbt9kYddQiR5LzY1dN+wNFUv4OspN+BWycbxvjRKGGe5Vj/ocnBqDL4U1wmo0PYDuY4OtoQUaipfVJioWjUTxcPk6dMr3GTlkGWmXDZBdlNsmekGkl0lwlf5mJSjFzxhLoglHwWOw774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409250; c=relaxed/simple;
	bh=oTSban7O49r5PrEOU7T+kZPim6pE3bvgO7Py7Ngt3vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvCm9IYOjOcP9UvXZLtR3x5XwMEy6c0XZWvv1Er8MW4H6UWMTkTJv3BDgJb8FkS3Yv0iSotUiboQ/ZNj7mtlmuxAxPynmJcQYloP6A2dTpMsm/f6CAjIKJpUkt5I6PbCykakR1xPjUZpekXZJDDX/BRmDZ2ucAm0TgU0cRNNNJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z+qZsqlb; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471fbfe8b89so638541cf.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 07:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740409247; x=1741014047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i/aAq/y1wX7uDy2Awd5tIAoOmMYDWMDjd+L54nfzg0=;
        b=z+qZsqlbFcdWQDNFUQimbBika2CS7ZRB2rDYRtxZMoMkyNlLK34q7iO758DkTWBPjV
         J/vdgWL4T82+Hx7HsNRO4+RuPg2wgEZeh0jqHpiQ+CwUrSIo4uuzLAPPCxwdAbvnIWt6
         LEB/tW8qgV1KhAmmZNV/gI0RX9qEVrL9wqWsL4qGTbiAZ8xb8AXTnr1B7b4V+ly0W4iQ
         jolp2VcvZlUaDD9XbuDhKxMlGHzIYiRtSjj809+Qlj6rdxpeCsxsbX5fClHghQKyYbFd
         R6tl6GMakuuWCY6jjJ14/L0JjDamw4hSNB77WD73xzuGfub7vB7kZEUWVO5ZAPp+XV99
         aQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740409247; x=1741014047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i/aAq/y1wX7uDy2Awd5tIAoOmMYDWMDjd+L54nfzg0=;
        b=DxScfqtf+lp/5FUpQJ8w+kjmEAH+mN+8VlymZRpx0Ko6Wr5sHtaEvHRFvjIRlvNrn/
         c5+EtuND43TqW5j5NmyZwnTWBWQefPj80noZE6Tmm8jmIg5xJj4mDrptkfn8Iq2uVgrq
         wmyNr2/8BS9KeWohD8Ypv1FnQwBQx3CRc/OYDA8EUi+ERGyytDRKghvku9X/ZhoDUATx
         w7K6QIxboGh4NamvsGAYNy5yO4T5GyKDXeSIzhPiJ9TaohZSdkD0zIqpOo3taqi389Sz
         0iCpGSCjhizjt60f7LqoV6MmCMlWGiQS18eIfxbhmX9hRXGdvEWpalBHktILMUx/CEKl
         mdfg==
X-Forwarded-Encrypted: i=1; AJvYcCWR4od63Bciw0maytGZ+oVZbS3Xl6LCFkm8X37IF1IA3UyZ+Ks3O+P0skwDfWBBPgd1bvuD7GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCXioLrAe06P+L2MSFe3QkaMsq4aKwf04MsmAkcEVYpSwwVdK
	d4w/ZNVAf4/cGiZ7uawufeXz7zUN+JdagoMjdhDc8vq8pEj4K+YxnRK983LqXMIoX5/xoMMnLRX
	rG0S2ojitb1v3PMOD2+6herk24sh6gqs7J8/r
X-Gm-Gg: ASbGnctttMjJs6gZQ2RblFDic8HapgaXIRb4PpXp4SOAzSTlLGhNMItlMTF01vdv/S9
	jQL9ua3IbL30pJQXkWXfnjoEA6GCG8hL5wZL3bXTDHS/ws9PgWDwc2XQgY5Tftk4r5EfjynSzcJ
	/RpJ5FzFGhGqdaZMlFDTfWlv3oM7q5kTm7Ex9EiorM
X-Google-Smtp-Source: AGHT+IHcN8KVAUp5tyZuf+Eu5+Xg0ayZeEfOEd35r1moP41JcucNzU6CfoY5TAtDYGsZxOtL/Y9U7HrVqrmfEDEB30c=
X-Received: by 2002:ac8:44d2:0:b0:471:f8af:3231 with SMTP id
 d75a77b69052e-47234ccbf1dmr5464941cf.19.1740409245772; Mon, 24 Feb 2025
 07:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224110654.707639-1-edumazet@google.com>
In-Reply-To: <20250224110654.707639-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 24 Feb 2025 10:00:28 -0500
X-Gm-Features: AWEUYZmNZgmqWA-hvk2PPhkqYLbdPL0O8PZ_LGkBAxXNySOyiMK5ZyWGWFY55m4
Message-ID: <CADVnQykD8i4ArpSZaPKaoNxLJ2if2ts9m4As+=Jvdkrgx1qMHw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Yong-Hao Zou <yonghaoz1994@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:06=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> for flows using TCP TS option (RFC 7323)
>
> As hinted by an old comment in tcp_check_req(),
> we can check the TSecr value in the incoming packet corresponds
> to one of the SYNACK TSval values we have sent.
>
> In this patch, I record the oldest and most recent values
> that SYNACK packets have used.
>
> Send a challenge ACK if we receive a TSecr outside
> of this range, and increase a new SNMP counter.
>
> nstat -az | grep TcpExtTSECR_Rejected
> TcpExtTSECR_Rejected            0                  0.0
>
> Reported-by: Yong-Hao Zou <yonghaoz1994@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Very nice. Thanks, Eric!

Reviewed-by: Neal Cardwell <ncardwell@google.com>

neal

