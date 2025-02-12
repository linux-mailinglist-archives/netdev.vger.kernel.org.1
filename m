Return-Path: <netdev+bounces-165622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B22A7A32D7E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAFF188177D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED7257AD7;
	Wed, 12 Feb 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHyFBImX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDE1DC075
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381355; cv=none; b=mf7RsEPOQQfMD4ZtCBBeos3Q7CxKZFLrYZWDV+/vpBdxw5rZCXVxN4gKpbyShy7oLr3cJWPz8engH5p6vSfiZzYG1dkWU+bx3dtJFwAbOR0dN8d2Pzdif1jR0wl2++VAuXuiaeV2z1MtkQDxnNTcbTZlsWecOoBDXX7esBgFkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381355; c=relaxed/simple;
	bh=v1E0baCYwvPTm6W2l7mhYSDoo8BYoAb0Zh7kaADVDQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkssKUxa5j6siNd0rCnEbmeSj9GQfbV/kMlrC1sVCQq3t5M45w8oathlsa2yn6pOTqjJjU5MXnJRJ3iQcN4fBhATciHE78w487cOZMT5sAFnuM0p4PKKP7LqM+6bszFgOftGUZjrlCgWf+XuiGzg4g/mA1LI5mxj0uRu1F5ka9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHyFBImX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ddcff5a823so341806d6.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739381353; x=1739986153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gquHr0eT2+B6bx9x04CQUMoJUVGXo0TIanyPjb2fHkM=;
        b=GHyFBImXoKYpaJLH0jS9V0i7iYzkC4DxH3N2q3YKZsGeOJdBrxiossETK46ubAeQaN
         oTke4evi216ERhawBRt+/jbbHZiLccFQ6omBRA5owDm6I8F7PXkTpLm0j3LFsEEorT8T
         elgNAEgal5wMGkVZhOlRYOfKTVNYXdix8rUCBvmAn1cdBJ9HoyVDmdUkFw6XNMBxiwCF
         nmM5vu8qzI8W2Vary8/FIbRqGN17dh4RE3aFGDfWW9Ef5/calZz62v4/FXgDF4z4K3Dz
         lgjKbtr4QDe95qs1nD8eovSNqv5B8ZvtDpZ1WxyWkiAqdv+JDpvC4vq/DTzQfvkYmxcI
         3BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381353; x=1739986153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gquHr0eT2+B6bx9x04CQUMoJUVGXo0TIanyPjb2fHkM=;
        b=ul4rkbcEVaXshMHAAMM29qurTjVCSVS4ZUPzMKCu3tSzUue+gBxSwXpIi/27tj45PD
         bEj72GL86kZaDxESbNXxTG6iMnZtP+ddIBf5Cf7Xfi22cS05Z2qmK6rMzx730HYrBXHQ
         6VF2/KSDkS1/9ebQCKwsu2IfLI2XINA3BFpbdbiSyYTfBdTJynKUNbLKit6cIOBLBX+8
         d+PdsYnkiHxHF/eaJy+J2BdtALFUWyBYwd0pmu0y10/1cbZ3Q7KFypDKYV96sV6Quenj
         UoCC4Yas8bauyo5DMVm3SoMwxgp9pZg6fHy8bzPF5Y1I7KJjwgxpsIz4k1e7Wkuxnkgs
         RG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgzrcJHGstlf83Pb6DJq8fRv2NFTZvAzJoX2g9IsbKZj9YOuu/2+1ic0Jj5nb6t7uroNqUACA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4XjAbtRq2WF2z52yUqz33U43NI65WOoZ3DoaRF6CHKS59OK8j
	p83Nz5OB29qP9KGqcfOkEbfEz60l+4ZJqGets7YcX7U9Rp5tIWwEP4HeBaVnmQm/nv07si4r796
	AQGCFRDSKvANVY7b3bR2yJXjIQGNlgU/JajL0
X-Gm-Gg: ASbGnctlw/l0ZhFGvefyv5mlOWzywqiNvS15r0me8Me1egeDOJcyzlXDJNp3ZBKRPDT
	51LKfylIV5ns/0xzrUI/UyJtpi13JdPKuykSS7f+97EoU/rYDTvv/GH7kL0hZY/6c0WlJ3CbPZf
	5gT0JZ8ji8fCzsuOHeZPFYvGmsPVQ=
X-Google-Smtp-Source: AGHT+IGyUbj2hccuFFHlk1Hhvr5KM33hs3n3t+wSbcCxGyj6DvlsLf+y7cGmeGwq95MetrI7dseIGPBZiiNjexR0q7E=
X-Received: by 2002:a05:6214:19cc:b0:6e1:a51d:e96f with SMTP id
 6a1803df08f44-6e46ed8e6d5mr68013576d6.8.1739381352553; Wed, 12 Feb 2025
 09:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SY8P300MB0421FF8BC82A17CA7A892675A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY8P300MB0421FF8BC82A17CA7A892675A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 12 Feb 2025 18:28:36 +0100
X-Gm-Features: AWEUYZlUvPCrE_W2ZQDiIkwuwePQ9_OsUYB2xuuCg9zu3mpKV7G1pBpzp4LkW9M
Message-ID: <CAG_fn=Wh-Z12SaBNgXJNqKyfODwxUAYJqyc86hguXn2M2Fv=nA@mail.gmail.com>
Subject: Re: general protection fault in __fib6_drop_pcpu_from [CVE-2024-40905
 Incomplete fix]
To: YAN KANG <kangyan91@outlook.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:27=E2=80=AFAM YAN KANG <kangyan91@outlook.com> wro=
te:
>
> Dear developers and maintainers,
>
> I found a new kernel UAF  bug titiled "general protection fault in __fib6=
_drop_pcpu_from" while using modified syzkaller fuzzing tool. I Itested it =
on the latest Linux upstream version (6.13.0-rc1), and it was able to be tr=
iggered many times .
>
I was running an unmodified syzkaller build today for a different
reason, and came across this bug within 40 minutes of fuzzing.
Just giving you a heads-up for the case you will be evaluating the
fuzzer modifications.

