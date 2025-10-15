Return-Path: <netdev+bounces-229464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A8BDCA52
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0093AC4F7
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E55B2FFDD3;
	Wed, 15 Oct 2025 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1uH0Avq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FC25392A
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760507691; cv=none; b=sKbV9epONsWk/YaPAWB7HoXfXuGcGgcCIdak4nVEoqGxcYZkgOtBDsqbX0vbkzBTX0LqkmYb35VTLw1P2nLzX5B/ZrYhYjvWFrhR3QPNKPKB+j/LUk1/7BdMdvnmRygh28Kjal7T4q3B0WLiyLlY0aUrDpu3gNhD9XoElfdWeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760507691; c=relaxed/simple;
	bh=Tpm5yCdYiNDT6L7HYf2Jq91WJo7kaaSCQiNhCVLSw/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmXKiNbA0OaF3FSFmelEFAEQIwF4QB4Hzth9M09q1Jw+Ei9aGUX4KZBvSUUMfMuW/FFhHsjEQSriRzMeWhB6RHZt1dSERoNQtMNA5+rMyn003YaVAj/pTzmXoJIzGSWHahQZ1gWztKFjqm02LU5UiqSIXrAmvlZlIa1m4+rV7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1uH0Avq; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-26d0fbe238bso44840795ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760507689; x=1761112489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpm5yCdYiNDT6L7HYf2Jq91WJo7kaaSCQiNhCVLSw/Q=;
        b=V1uH0AvqYMyB+6Srpi25ILupk1aHODTrU6bIwE/ih2sCyQ6LvJTd4dKMVtB5KImMOB
         7zXeuUStNxceE2C+7G+PfoFtKl4NzJugpGGQP7/wrSF8/jBj2ZDUn5F3PrDU/JH2jiwg
         ciczWYDlqbrF2Vh58Zv3SUjkwDlQMptRW3T99ZY+JDDqPmAM1LAeyM7enBZ+/DOdWKT2
         lCuA8lHNnxtQXH1TTbXnbgZqwbgUSwA7Vm/RYMoAgoqSXiBq92EGWRSkpCB+J6GaVjrT
         1fDN1K1JZqD3neHtGKBfRznLo15p0HuzkvguwiWF5hYnQWDDh9UyVYymTKmhT7xs/vfX
         O2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760507689; x=1761112489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpm5yCdYiNDT6L7HYf2Jq91WJo7kaaSCQiNhCVLSw/Q=;
        b=NKH8HKeqo/XL4U+7RjqGfTbR3x7Kh+9Lje8tzVR8sQoaiShEqJhLnL0pq4LaUHUi+b
         A7Gp8Q+zlbl8EAmk081U2GSs2FEVATRHDeL/vHP38O8A/xcgEWDQ5Oq11Niz2wbMAsyx
         AZwgAjrzWEoZALEu6DkIluVMu+kaD1HaSPj4GRE6Qji+LycGL2WOaSqu9zSS4kfTc0Z4
         FB0IRfL6oLRJhfoC1XVq6lX3Yc/DQg9JSQ3luoN8w1F9vP1Mw+GBVFCdK3ffwdGOG4sV
         MwHV5+B1MV/d27zP0Kv9QgwslltFpac7ja16KaKmZPvKEC+Cluf8ynjtuBSW79yrgmUu
         +69w==
X-Forwarded-Encrypted: i=1; AJvYcCWDgR8rN8adx2d81QPCtjD8WZYMfh+yoMgQAQ8JFLgI3CMwk5u3CBIfx5AIHwV+xXnBSx3cbgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtLNQDXiVgJXobIpu9pMBuFkArjpkCCS7C3DpAM/O/XXoya4lE
	05lU2gEA70sg4LSfcS+633tZ9P1NSInAxZAJgNm3BYKvn9eD5JusdkFzxKZXM13ow4SFKDnZCaD
	kBwrZn/46ZThwf/LFlhJT7MiJ9m1ncnNAyF+Q9ymq
X-Gm-Gg: ASbGncsPKxPDrhgz2I3hEILopgDRGDHOT1e/MrokuFvjlOKokNTkzxtqiOn4n4pmT72
	j/lvqWpD61RbFRmeh6piAE/dKzU+bicd0aJmmbYW8CartNlIBoPe6mhG5oYlrq5iRJcbNGt9Qm5
	dHlpeZff0UzaG7NA82HMf0Wb6+CPCPCAZw8neBQKDoWvMMXOG1SZQKpsyNAvGolqBRGgUyeiArF
	c1c9Tqf8CUjHwb+388m8dzqLX4RmIJ2lRtjrwaNBuvB8paX6f22XlD+fZ+7CLpPyaHI0/C0pic=
X-Google-Smtp-Source: AGHT+IHOqIjWjc1eJbL5smQncvTqW9LAJIwfakqfRl2JSe/zFA+li+TBDDBtxF8k8uoDbbS0TflLeQpyzgCcQI+la28=
X-Received: by 2002:a17:902:d54b:b0:288:e46d:b318 with SMTP id
 d9443c01a7336-290274008ddmr385200185ad.40.1760507689086; Tue, 14 Oct 2025
 22:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-2-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 22:54:37 -0700
X-Gm-Features: AS18NWCsEBhpvvqZKA4u_VHEyEQVeX2ntklrqJRuY3kriqq5SXxdlDzMYHLxuHI
Message-ID: <CAAVpQUA-_c13xjh9g011ToVAvBh1XVC_QkFkMgsbWHuTXhifbg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/6] selftests/net: packetdrill: unflake tcp_user_timeout_user-timeout-probe.pkt
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Soham Chakradeo <sohamch@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> This test fails the first time I am running it after a fresh virtme-ng bo=
ot.
>
> tcp_user_timeout_user-timeout-probe.pkt:33: runtime error in write call: =
Expected result -1 but got 24 with errno 2 (No such file or directory)
>
> Tweaks the timings a bit, to reduce flakiness.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

