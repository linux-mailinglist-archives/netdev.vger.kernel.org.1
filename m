Return-Path: <netdev+bounces-201514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE5AE9A0F
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE2E7AD554
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE562BDC37;
	Thu, 26 Jun 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktr3T636"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FEA218AB4
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930284; cv=none; b=atE5rPCRebeUwsnaTCw46eWyYIzbfigm+ky2UxaQHu327wKL3Dp2eGY9/uud1mPaBMqz+VeBvG59nDOGuDn2BfcYmdwQZOUvbv7Xb+3sG5m+4fDJP6Azz/XGwq/vCFiOCjQJga6GrkIr4NAGzB0gFhA3WK4yMU8TenF9OkpEBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930284; c=relaxed/simple;
	bh=zcJcfMMo/3ACIpZ4LXAPPwHUQXeQXL9s0zWxVNFTS0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cj+/X9NC/aR7Krc6z5dF0KZJbHmDvb4QulDFNE57sf0X4rvZYp5/rW3qA5paY+y4PvkphGA+nwAWQovu3vij01ixbHgY/J5WNTcKgQwjGsdCZPdl8w00PGUncI9jSKSr+PhToYvbvg33yPno/6pdBp/yDzn+1kYZZID8L4ryRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktr3T636; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58f79d6e9so12516651cf.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750930281; x=1751535081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vP735jlG/NZz9NPdW241a1xK9Iw0Q6bSF51FFzMtrc=;
        b=ktr3T636XiNlATAJGn/WX/Ncx5d+CR0Slt/iR5RL7D9SqJgSjwuRp8T5OihcWahh3A
         njJdTboeNDX8DWo0zY2irmWoWuBYErOhOnrGLm/fHU5A9GJ+Q7Em6s5AbxZ7FUTMBedm
         lJ4KIMeS2RPVo009JakzKA9CnJKMX3KBHwkewn+CoTBlIKFvSWITBYgWo/ltjOhfB2jD
         pgEFGg5MkQ6zwRW2KYWtl+DIOmX+UolM69XuZTua6x1IGuXFpza5vOflTTvmvG26cJQ9
         als9azWbPxtMtwYLuT1kw8wm+YDOiUMFSTEibErRJLzjiLIlgds1Ma4SvbKH8IuiGL+l
         9JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750930281; x=1751535081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vP735jlG/NZz9NPdW241a1xK9Iw0Q6bSF51FFzMtrc=;
        b=OLN2ui/VOKpcFG3SzLctJfzfssKVR5ARV/F/XN96HGk5C6BlPJoc1VimqqqT/YeMCi
         MhOX4RI1VDG7wjYaBJMzk7KXWO7xd+26F6fi///Zqduw2HOyWLHYZdn32zZrSw6moGaV
         VxLRdRLkHyZYD8db4Xjxj0WRZAkYwOu+xqRhwVm7OI52g88lFLYx/n+l79NjCom/5aAJ
         0VmW3CMB5HCQcnc/NosMX1yIxLHLzKokUCnJutf/2llh0WvCzmxYgdVo9w6XgTCGqz8/
         dyYeuvak/k+LhLzopyjUNJGCWHs00GmdD7Iw189yM7+f6TziklOvP8R6bky7f+6sn79w
         kfkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfUMSv9VnYTIy3nvQq3T9WqtDY9rGhkuj08NFCc3dSXfozup8+FSrbdgcpuZTxzez8LRY0hhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhO9kNLiqWYQnp6+IoKXNwSBuRhYhPxEH4fxGa9ybD1kfHQSi
	VKw+gZSMaQnfISbYliaWKA34BqC6QQ4LBuX3wfTSSCAnOC2ShRD2L4ZpbJLCaUS2Ixwb0uX+LPj
	duxMrUXQnV0EV+lnWGs0OnnrZqrig+p7dZ1RvOuyX
X-Gm-Gg: ASbGncvz8PEpHsrE7DWxKBCkc8nYpmAAx9wa3KwVIVAyAukM+EhGtW2q9rGwDB+LeYf
	ZVnTfJVPqWuParp2H8vQzSFNGfc0p2I7R+SrJPNBJu6OdK7FIFTgLr0QJQoLCEK4jt5aAhlsWL7
	GW5KmDTtawxUFuhviBlMAx3H5jhqT6nyM3j/T0KvS3
X-Google-Smtp-Source: AGHT+IG3j1OK/oS3D82GvQxL4C8Q7CEz96grJuI9Aq7cyeeFt9o1HqZVmE+bU3EeKkQJ01kqRFz0Z8i4LjDFkj0xAsk=
X-Received: by 2002:a05:622a:64d:b0:48c:5c4d:68e7 with SMTP id
 d75a77b69052e-4a7f2869e45mr46583711cf.6.1750930281188; Thu, 26 Jun 2025
 02:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625153628.298481-1-guoxin0309@gmail.com> <CANn89iKrwuyN2ixswA-u1AxW=BX8QwWp=WHskCmh_1qye3QvLA@mail.gmail.com>
In-Reply-To: <CANn89iKrwuyN2ixswA-u1AxW=BX8QwWp=WHskCmh_1qye3QvLA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Jun 2025 02:31:10 -0700
X-Gm-Features: Ac12FXzzAQB73uPrqVNvj4Bvd9uyIFjGaubPVHvVRmijuUwdC8s3o-pnVmVZm2g
Message-ID: <CANn89i+ZVR_qvYE3F+ogyhEKX0KjiW3vQx0R1V9GHNxm+EHt0g@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: fix tcp_ofo_queue() to avoid including
 too much DUP SACK range
To: "xin.guo" <guoxin0309@gmail.com>
Cc: ncardwell@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 9:03=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jun 25, 2025 at 8:37=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wr=
ote:
> >
> > If the new coming segment covers more than one skbs in the ofo queue,
> > and which seq is equal to rcv_nxt , then the sequence range
> > that is not duplicated will be sent as DUP SACK,  the detail as below,
> > in step6, the {501,2001} range is clearly including too much
> > DUP SACK range:
> > 1. client.43629 > server.8080: Flags [.], seq 501:1001, ack 1325288529,
> > win 20000, length 500: HTTP
> > 2. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> > [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 1 {501:1001}], length 0
> > 3. Iclient.43629 > server.8080: Flags [.], seq 1501:2001,
> > ack 1325288529, win 20000, length 500: HTTP
> > 4. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> > [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 2 {1501:2001}
> > {501:1001}], length 0
> > 5. client.43629 > server.8080: Flags [.], seq 1:2001,
> > ack 1325288529, win 20000, length 2000: HTTP
> > 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> > options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:2001}],
> > length 0
> >
> > After this fix, the step6 is as below:
> > 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> > options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:1001}],
> > length 0
>
> I am not convinced this is the expected output ?
>
> If this is a DUP SACK, it should be :
>
> Flags [.], ack 2001, win 65535, ... sack 2 {1501:2001} {501:1001} ....
>
>

>
> At a first glance, bug is in tcp_dsack_extend()

After more thoughts and RFC 2883 read, I think your patch is correct.

I will include it in a series with two packetdrill tests, and another fix.
I will add appropriate Fixes: tag

Thanks !

