Return-Path: <netdev+bounces-99666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD18D5C34
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A959C289483
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA843762D2;
	Fri, 31 May 2024 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ycG9ge/t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CE1865C
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717142730; cv=none; b=etNoO14UwXUmRvEfKv+D6wQPPfERq0vHNRppGNVJk42Pcj9Uwo5drdtuO+u7bcVmSNCGlYUUpbxaav6YXIhoSBL1ZpD3ydFv0Y4T2VpUr5v6fimwJrS7fiup+9+PPjREHGYuecwYlYJPAknZ6VqvSecDytFpFMMknXWPAJQKWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717142730; c=relaxed/simple;
	bh=LdOe7vKJkwmCN7blsp3hxb+hR1lKuyKqJ0YB4ZRrgs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0rvxCOoLgHGpj1cFTjDsQThaFrpMtIVd5NMusWdevXVQ8LX2sbuNQSqZH8NjcgTykVB8fXFOQ1w+y2eBABTNWVMSCy6hI1U9DrwIJ0LjprwtkONzXuz0EBDahjjc4f+QUC1XRDqrn/dLT6tn9KXDx597NzD6TnXgwySPK7+Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ycG9ge/t; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso7078a12.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 01:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717142727; x=1717747527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdOe7vKJkwmCN7blsp3hxb+hR1lKuyKqJ0YB4ZRrgs8=;
        b=ycG9ge/tkAOWVux0SRFUMx6LGBbkjitGuwL0nWPL7v7+crEjjfd9hsaQSWFwuSP7A2
         7F/yTl3PYnERczlu5iy6UISUTIUvFX+bR+p1WF35m96ElgtfJtDGZkOQz+onAscPCMel
         cJV2STTTcbB5MG03ofRMyZWCGEyPqSIAI/Y9TUu4jaYkcHqhyal7Sq/5w02irF6C0ABh
         Sqhx3G3jvldw38aoN3zZhfl5FUpvVHHiG7+2YHX35h1EbLHZ/suvZj6aG1Z6yOdcqWTr
         h+7SHEnYp0yWG3V2gbKTAjiHSRJJRckaScijblYhYlbDIh7uCnnfd4YSYY6MGJJ+hs9C
         CHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717142727; x=1717747527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdOe7vKJkwmCN7blsp3hxb+hR1lKuyKqJ0YB4ZRrgs8=;
        b=DOeiuMBR9v9h2tuDcCvXr/QGfc1KtHg1Lg63a1CXavEVpZpnCUjF675KmfUAPX7nNf
         Co3yyhTBWK0JOZPXNOU+sGCt4WrlAAuXyHxfY9g0seDoUVeR7ak3oWwA7UGNxjWq+7wK
         gUSfrpTZ91KEqWAUxCnyMF3sS1rZtVcnT5Ga9Iu5WxHBROeQwEnnml7xggHJdZpCU2sR
         9NKWa0Ad4Ax28hmCUnUZ0ENyFbnGxLt3Yo2HQisZ3flxHEqaE1LTIDS4iCWj+4GXasnw
         G3nA5n0pPt6D16vEhf9dno+yxMSPDTVN+DES7aaGnLtaqNMvfldAYb6YMAOfby7Da2qf
         s4ig==
X-Forwarded-Encrypted: i=1; AJvYcCX8hC9WE4Vy+UcQqK0JGqgNdczDfmB6gwcXmb/K9AVzPmgaBnz3v1Nu5fM1NycsC6+HvRZBTYgFVHxrwdQJFSmKCke4O7o3
X-Gm-Message-State: AOJu0YyU7FkrdTbz0kSw3XI/yVu4uvuotaN/p629BZa3ZzfVJVsaGMOS
	t5j4zloMpVDUEQC2TsNghOWN+ch5e5M/7n1JcXQeCwttDRKHnnXvTYRPwm02S8KY9CGz6xyudYz
	77PMNAdo2ySZqBFeAXZWUTM7s+5ZkQ7SvENfs
X-Google-Smtp-Source: AGHT+IFQFBnqbUV7tAf95uZTmt3CZ4nUyEqX3z2RmFBUqTlcS9EnjAIBpQPRN9agdan1iDop76JyIXfT/gCUordUqgk=
X-Received: by 2002:a05:6402:38c:b0:57a:1937:e28b with SMTP id
 4fb4d7f45d1cf-57a37861c27mr65077a12.1.1717142727187; Fri, 31 May 2024
 01:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232607.82686-1-kuba@kernel.org> <20240530162919.178c8cda@kernel.org>
In-Reply-To: <20240530162919.178c8cda@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 10:05:13 +0200
Message-ID: <CANn89iLy_tn-5Z9oyEDtaGCuHpW278PeQbFj5yVfqhgD0ZVSTA@mail.gmail.com>
Subject: Re: [PATCH net] net: tls: fix marking packets as decrypted
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, dhowells@redhat.com, borisp@nvidia.com, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 30 May 2024 16:26:07 -0700 Jakub Kicinski wrote:
> > For TLS offload we mark packets with skb->decrypted to make sure
> > they don't escape the host without getting encrypted first.
> > The crypto state lives in the socket, so it may get detached
> > by a call to skb_orphan(). As a safety check - the egress path
> > drops all packets with skb->decrypted and no "crypto-safe" socket.
> >
> > The skb marking was added to sendpage only (and not sendmsg),
> > because tls_device injected data into the TCP stack using sendpage.
> > This special case was missed when sendpage got folded into sendmsg.
> >
> > Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE=
_PAGES")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Forgot to mention - compile tested only, ENODEV :(

Reviewed-by: Eric Dumazet <edumazet@google.com>

In net-next, we could probably move skb_cmp_decrypted(), skb_is_decrypted()=
,
skb_copy_decrypted() to a new include file, and define
skb_set_decrypted() helper there.

