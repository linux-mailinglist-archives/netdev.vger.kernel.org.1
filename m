Return-Path: <netdev+bounces-172836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA5A5649F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA378174D4F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDFD20CCF5;
	Fri,  7 Mar 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybNdpNx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953320CCCC
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342075; cv=none; b=bfGfk87TpJoOg+hwcmyymYerB8cEp0VKtOTqqN/pFJhlDEuxx9Klaq+NOxJroX+uq5YUB3YnMLJa343FxyjuAeTd6pR39tSgZFuwsnLfv5kVVv91EtFkqm8s68wczEES+jld5bahzcIbo4K2rme1E6ybu/uLu1bwRT6wUkW9mMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342075; c=relaxed/simple;
	bh=/gUDHjxsHkBIP7SFXpa/6Mcgh+2DbRGZIym0dU8AlPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCPNVTaU6Wks6suC9fTXzhIQ3Iscqbm1CIvlKfAv1CJNbUQ2mWUZ2zDCilluW8OZtpWIYs+JBMWi2UInG2eOlQx6XoKCn23DvjAb82guIRT2e56ojmNvGXi0DnhQWuNfrfItR/22WV9BGQ3KAwlVph8UHb1WIUl2Z8rvz95s66o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybNdpNx4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3b533a683so184067385a.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741342071; x=1741946871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gUDHjxsHkBIP7SFXpa/6Mcgh+2DbRGZIym0dU8AlPg=;
        b=ybNdpNx4mktyXlY1YpQFAR7R7OulJ5G1TCMSsenc9rVX5cLyYg9PtCXGEQ+8EYn7gm
         FSzrflOdz748e0F0OJVgOsBB9lEZp9skL6ZIE/DEZ5ZwwALypSN2zm9bQCrvSfVyqjT9
         cybyTjaS65XOTObLr9lxNb/vVCCrFRELfG5O1GRpHMqr4frzicBWGpy6d0swKXwLFHIf
         gHZfRbd1pOjId2ubqux244uw8jJ8gqjLsY1dGv0HrUJBOFhRiMNDh+NkE1EJ9w1JLkFq
         3rexpITWSIyWF1RdttIC0aGsJi4TpMCKbcqRT1gRWtAvw9CK6jdjfR2mOTVyhfPBEO64
         uS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342071; x=1741946871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gUDHjxsHkBIP7SFXpa/6Mcgh+2DbRGZIym0dU8AlPg=;
        b=uO1k4HHYPrfY6i/BxODZI8jZWCfjgCDwUAcG297YiyUunQJdsu/4Aln960jiHmVwwb
         Kh1jEz2M04ubPJpOmA5SBHhFMNSQf9QT+oNTaRNAo0aIeYKNigRXjsCHOtCcXW7Dvf3g
         XEhpKAejZQmIrErUCK1TsJXM+wIiuxwieR1HqSyId+aLZVgiv6O9YpfTlIyu3anevI1G
         N9njMPFj52nkgGugmjBTOOL8CTrDLPjARl3/peaxAwC6pqRuKA8bXWWwdCgurTx1NAZC
         o4trI0RNh+lgqBJ1jf9uy9pCoJ/L/CLO4FrX3Suqgpok9yKVPc/H0S01ULQsSQWZrvCp
         xKWg==
X-Gm-Message-State: AOJu0YytmAT24jIWdHQ63IhJX9nNin1YRBInB1LZCpyxcj2sjYwCQXl7
	h35x73cyOV0JdZcR+XyVDsvZGDBganyU+52l96jItSdh+Idj3YfyPpIwaLvW/qPwebVhOwFbaAp
	sip9PHuYkJTOhlVV9nYGaz5uueKMayGXUzKhu
X-Gm-Gg: ASbGnct2B7QLuUyR1UBcgGnlx0NqYMKbtp/E25R5LWHtj8CEVt1DumuIV7mCHb0wjpT
	OYX4NNURDIhrP4ecE1t3p8Ctp4lIsreRXvzPCJgiR4/WE16ghh5uS+fkCAHYFHCPMlT9749+ijF
	zvbGZqahyIm3cgkEQ/pgkNejsVzEo=
X-Google-Smtp-Source: AGHT+IGv55EyMoXUkj+2/WJhdfN1sngDXwyUjvGw4VrDWv2ZkjRDIZ6nrLzLc1BQz7mSL9kYooY+fI0j8MZcqOqixpA=
X-Received: by 2002:a05:620a:63c4:b0:7c0:a8a5:81b6 with SMTP id
 af79cd13be357-7c4e61b7094mr342998985a.39.1741342071389; Fri, 07 Mar 2025
 02:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com> <20250307033620.411611-3-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250307033620.411611-3-willemdebruijn.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Mar 2025 11:07:40 +0100
X-Gm-Features: AQ5f1JqsBtrEGgzGgbkgiBWRJFXhWYs5RtzEI5qcIwuEQmE7jnYKkAst1fb1DB0
Message-ID: <CANn89iJrj7LUz5bxB0Kk-=OM8m6_++279ganNJBPUoSszxUjjQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] ipv6: save dontfrag in cork
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:36=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> When spanning datagram construction over multiple send calls using
> MSG_MORE, per datagram settings are configured on the first send.
>
> That is when ip(6)_setup_cork stores these settings for subsequent use
> in __ip(6)_append_data and others.
>
> The only flag that escaped this was dontfrag. As a result, a datagram
> could be constructed with df=3D0 on the first sendmsg, but df=3D1 on a
> next. Which is what cmsg_ip.sh does in an upcoming MSG_MORE test in
> the "diff" scenario.
>
> Changing datagram conditions in the middle of constructing an skb
> makes this already complex code path even more convoluted. It is here
> unintentional. Bring this flag in line with expected sockopt/cmsg
> behavior.
>
> And stop passing ipc6 to __ip6_append_data, to avoid such issues
> in the future. This is already the case for __ip_append_data.
>
> inet6_cork had a 6 byte hole, so the 1B flag has no impact.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

