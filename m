Return-Path: <netdev+bounces-100843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B78FC40B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864181F26A78
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEFB73446;
	Wed,  5 Jun 2024 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoN3JdqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502E42AA5
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570849; cv=none; b=cGYHDzIKiWCDGbkyD1dI7oKdyFC7o25C0s3e93LdACsR2CbvQm9dECjwGL0e6QEL85FPTMWR6Dse17o+GpiP5Fd/OU5TanmU44ujDNnVCPWZVwCJtfvFf+NLXhfxGQVIQzHM6tHb/gOUUAwfFXxGpl9NUjutfNkPf0E0YrgCcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570849; c=relaxed/simple;
	bh=b7NgfXyaZtvmAZgqkZSPqZZTVRXZmuZ/P8bz9U63Oqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKtXeT31mv9OVk/Qao7w/hNSYQnBIS7An/NRf3R1K8+pmom6OjDZdCAoZRl1CDA4QAF7HLZ1KA9gkWflJLPlyMZABNgJrA17XKI9vbhbL21WOW6RZdGkKb2ME2dcYaBW+nq1dgdAk5GHDw5A8CTRlfWbW9jtrnBNwfASYcobSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoN3JdqD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso5241a12.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 00:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717570847; x=1718175647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7NgfXyaZtvmAZgqkZSPqZZTVRXZmuZ/P8bz9U63Oqk=;
        b=KoN3JdqDK1MJoT+2dgzcCdG9p4GkhtuVnzjlriidNRAl4+i2/oTpLUp4HLgkORNf82
         J1rNIOsHwUUt3ADA1DLVPdwYs1yhqO424K7PiLOz7gs7sAtQ0WmG0J3djf7oFvKetbXm
         SrG/EnAPOBacjKMf9hKE4YjM1sLOdaMP8iwwkO4sOvjx3jZ3nKt+cKZ8X8qbeeMCTIzR
         u4FhmLfTfgxe8V6f8y4yTrOVHxK3X4bzoQxLGeBM/v8KlktBRQ5XZ1DIHZ7f40+9wmGp
         1d5wzpLdyJM/Q70Iid2wR2cvMSiV5pg5sLgqkl+onEx5UUBITUWhtoAQwxy5YOq5SZTu
         ajLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570847; x=1718175647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7NgfXyaZtvmAZgqkZSPqZZTVRXZmuZ/P8bz9U63Oqk=;
        b=gOMgJhQYLIX2dul/vMjFp2NrG9pFLUNuWpUEZ6t1mfPuJqyBo+NCpIbLZgJz3sAIGu
         49cdEFWWMPS8ESoRG1PtwO0VOoHokQmqqpdgjnHPZyF/5qclfbwLVJhfzjOAEtDBt3BV
         xe5Tm8IGruqz0dwOJrYq1EyTTggiFnfF6GeRm5GBzJQfBK2cEWxIgZwftWQKKGfGv9uN
         ZBXhZ48Jg3Q+i4wG1ltL/k/ZNB2S89EaNFj/K2/y7SkT07AvMJvNFhgQPl3VFWIaQ/Z3
         YOBjP0tPEyKvLsPSL31VkxJtg0KgFCfqD/MfBdiSpM5vDhW5vyObvYNbdEU3d7kxsxtR
         eA0g==
X-Gm-Message-State: AOJu0YwzRMxHe2nODbwA9+tMSW0lAbgDPJMuWDWhJXi2LGYx8269qeUI
	U61dr1tADZNTL0pBZoXw4PAgh8Hhujky2HJtEi7YuPK2c2hikZEthcHj+i0zo69GRugqhld7dXs
	98Ceb+/bJDRBuBI78kXuSUZBloYb8XcXyd095
X-Google-Smtp-Source: AGHT+IFbST5bF4Wer0THVJb7QsprRJ8nNQ4QRlnsOXxCNOp/6R+kKOG8HcJ8VL6BTQHpnvy6aws4Nk2V1ZewA8KFL5o=
X-Received: by 2002:a05:6402:31a3:b0:57a:1937:e28b with SMTP id
 4fb4d7f45d1cf-57a94fb3c0dmr80141a12.1.1717570845685; Wed, 05 Jun 2024
 00:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604140903.31939-1-fw@strlen.de> <20240604140903.31939-4-fw@strlen.de>
In-Reply-To: <20240604140903.31939-4-fw@strlen.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Jun 2024 09:00:34 +0200
Message-ID: <CANn89iJzA261kZBr4453MY0Kix5YjeNWSmJD_jFGiLWE5bHNVg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/3] tcp: move inet_twsk_schedule helper out
 of header
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, vschneid@redhat.com, 
	tglozar@redhat.com, bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 4:11=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Its no longer used outside inet_timewait_sock.c, so move it there.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Eric Dumazet <edumazet@google.com>

