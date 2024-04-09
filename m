Return-Path: <netdev+bounces-86211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302A89E00D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743DA1C225EF
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04613D89C;
	Tue,  9 Apr 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STelNkvp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B2C13D635
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679009; cv=none; b=Nc1qrZfpYNU5bXDIjs/mCOzX1nEr3o5cUQu+/RR9hGhfYx1a/LZZDoxQhiPue3TbwHzzUkkVERc6pTemVJGBnLLJPzgGx9jb+OU7xcUVFbUV36lsVevaC2oD7FwBVraNVet6b58mmLJHTZ/XX76xtJjHx89NAzyXQGJWs770hP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679009; c=relaxed/simple;
	bh=L54kcvC7tM5k3CHEDDLLg9GL0uS3slGoj9IlpaeX31c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pGLvmJKhVykY0DtadeKIC4cv7dnLxJAJ1UBntnVyJWeTobh1xLsuPypG/nrCxVVrfeqqhKH2TUsptw+jJ85gn8bjTJUS1jMWRCLleadYhI5tnM5Zlw7AWmgrngjnj0Gejnf6TAcn2QaarKA7+z5WnWSg2fhagvq+1+tYaHSovQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STelNkvp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so7777402276.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712679006; x=1713283806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTzBA8vCpg1bQoyDxMrjJAPBioScXieCvpaS67N6E3s=;
        b=STelNkvp2N8Jd5d84GuyhHp6kqSVAW1feJpsZMatiLuhHAU7nAVYJ5bIOpOQRufdAX
         nKrai2HEUa3TCCqEOynm8fh0JFSTzxbMYL/SLmHmXSzhcb5q1/Pwh1odwl5hF3G5CFI1
         /JRa2A3588CE3F+c8RbpETqB+tjE0Dp3CjlHuSQju4mMQr89ZgbXo0g32DUCeq4T/+ny
         bai34qX6u4PnOJ/zP3CFQJD2h9IgIAyxe05mVvhUWbB4iwiIcY4+S0UNroDPHFy3RCMK
         UnWgzK/w0SMsmgc2hJO7HjIi9v8AHNHHX5CpC7AoySgPvNqn/CUtqiphLRICRBgabq4Y
         ur0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679006; x=1713283806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTzBA8vCpg1bQoyDxMrjJAPBioScXieCvpaS67N6E3s=;
        b=NNIQKHapK5jyya3KVhb9bEyyDGG7r/HS9dFuzO1GuBTzsEIeNTDcWJm+ioV3Bz5fTt
         DRP0+M69HDSBZhwF4XRvOilNlX1tVzCroyOVy5tXMyPaU0BNWXWnsJZ4RcZ77v8tmEys
         D5aZLIO0eStOE9DxeP6DdASxP80Uat78SdH9rmQf8LL+f3HfmXkO63mKbd6RaONRl2Bc
         L5cf6KONfkrtVQvDaDIq3EtDxHgRfxdUYYpTb3caWI1JcTWvdtG9Nsc/0o6J5TFkQ7Hm
         veBFMP5OtOOuP1i5X/822ErDiCg/c2XHEZ8ZzbYSXubDY2Nt0CnKoTBovRo+sHZ41ABT
         zSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUdO/bth8tVcB3D9fqh6pfP922LNVlsVfUHZS1WryUSAo7SNXNlmt3t92yx4/0RcnGGpi0L7Yw4WuP/jyGu3uOytFlyiJg
X-Gm-Message-State: AOJu0YwlqvCs24GeM30ts89RZzDiWOS3thtTOgjN5sWwFGgpGcV97giw
	2yKB7B5K0gHWkX/2r4EptoNh8SL/8SgjUAfA3DtC0UAHr9Sn68ia0BA+UvazIhoA7A==
X-Google-Smtp-Source: AGHT+IE38beRAL/GyZV4u501PGP7OFfQCcNi6umKaAXPP8K0ga6UOvT4QIR9eYTeiccqjAl5Tf1y/Cw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:2b88:b0:dcd:2f3e:4d18 with SMTP id
 fj8-20020a0569022b8800b00dcd2f3e4d18mr14472ybb.12.1712679006109; Tue, 09 Apr
 2024 09:10:06 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:10:04 -0700
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409031549.3531084-1-kuba@kernel.org>
Message-ID: <ZhVoXIE9HhV5LYXV@google.com>
Subject: Re: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf to net
From: Stanislav Fomichev <sdf@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com, 
	eddyz87@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 04/08, Jakub Kicinski wrote:
> The test_offload.py test fits in networking and bpf equally
> well. We started adding more Python tests in networking
> and some of the code in test_offload.py can be reused,
> so move it to networking. Looks like it bit rotted over
> time and some fixes are needed.
> 
> Admittedly more code could be extracted but I only had
> the time for a minor cleanup :(

Acked-by: Stanislav Fomichev <sdf@google.com>

Far too often I've seen this test broken because it's not in the CI :-(
Hope you can put it in the netdev one so we get a better signal.

