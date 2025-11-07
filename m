Return-Path: <netdev+bounces-236661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C7C3EA49
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 07:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F03944E1324
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E1A2FC88B;
	Fri,  7 Nov 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Y4dlwaR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7132FBE13
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497786; cv=none; b=LnEk/9u1RIN7qxEuLHVzE1R1vyU6Nh2V/8u6N11dynfo50Z8zN2eq4B8B+UNxgvoHDqBiiS2IaNsEF9zdpNIzI5b/KvrCBB1f2UM7DSntD5yxMartnudg/FeNzdbYmVlee0ouvSu70L7irHxULZAq8mpTI2PQMNd3Cw5Y9f92QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497786; c=relaxed/simple;
	bh=N+NJU+hTtzt16EiLlablo4X/qYf7vzaZj632xhYf1lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN0YOftK6BMPDttOMks7GvaL858nu6UgKi5yIUWLa3OhKK2++jKHWazV+ZMOyd4y3MlHp22LLEF40eU2bSZqIP0X0jK2RDr5vdSJ8xkvyZRKNCdXYQ821j7dyR45KYAvzKv/dsnNMdzTL6xT7osPAbLPKbyEbLI6UHggdXmtQe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Y4dlwaR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29586626fbeso3860235ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 22:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762497784; x=1763102584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+NJU+hTtzt16EiLlablo4X/qYf7vzaZj632xhYf1lw=;
        b=1Y4dlwaR9C5ZiwJAEpA93QNsgXNgLV85kP6M393mPMJkgifG/vtXv885TWT/zM4egW
         trmQSNgEuhJ98P0vitaREHwO7uO/ixRP77VfxNMxGcf0XLeD+bxSdmS0Wq32leNUMbC9
         LcyZRzqQ7da/4S2jtJmDC1jsB52x2C8egTWQl3apcaKZc7xnk6YhAhzAvRiFukiniT/5
         GJPM/m9YwNv6MPH2iKzW5dIT+TTf/PEXbolkeygX3LZPXl57MK/K6cWhVNOCPqwuyFP8
         /jL5x4OlwZ2JrL+HY7uO/nzyTvo5IZfr9QcExnD5ibK/JM/QBgQSnu2+4tKlLsVLCFp/
         f5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762497784; x=1763102584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+NJU+hTtzt16EiLlablo4X/qYf7vzaZj632xhYf1lw=;
        b=WZC81W6SO6pwXYQ/Tgv42GrCcDbtdv8+zlx887kB87li+pRhmfsF0CWBD1+IjdSRrs
         e07QDi6V+5t6vKNhrc+zTrtqXK+CTZjj5e7p2dIJj1FXCgryXwpsxsWZkDKZ1xsCqhue
         imJRIGIRhTFl4gu4VPPlmYxXMWdfR5LDbLfe1E1Tk3JgcewBdCUqgUBCNn2voDyezXT4
         uv9Mk71XslDaJSOwC95B+UwlB74hJCg65TNwVRCPR2Beeew/OrF+5JDlPALhm/iZKCQI
         ucygBOPM4MGal1oM7Y0tQT4y7an9w7KrGVFYn31jwjUFvtHYxusxsKMCZp2tSfGuEZsN
         q30g==
X-Forwarded-Encrypted: i=1; AJvYcCWbm30m7LTor0JzzF8tarEAg7wO7nOW43x5Ljy9EcqfswtOJ3JvqNaIL0PTMIVUfS65eLrxIsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDp8L2GqZcpVUFYMu97z9gIWYMYtZzsgg9lTq28xeWwSHtKOv7
	PnS0jqCskbUslmzE4K2v06fXXBEckGHEAUhW4tS6IAwz6kaJmhSZKSk13POFk1OUgQJi5dOfMge
	61j65WX4ZWexcSGPAUxNovm/aYrgkN1LhKe0AGjqb
X-Gm-Gg: ASbGnctZF8nHC4DMXmo9iXOTcfdh8X61bXqE6SosVHU5eWfeDSSZr5uS9QHEU3a2oqi
	Dh1aPx8HSjWMZcZzLVXmXnSN2X8TxQY/SS6+zfJ+2zkhAf1R1j4O97nhwqSMqHPoyHb3hSUvtcJ
	wWnoZfLl6ucYuY9io+Yw/Z2VL+uOHFGpgTQ/AuiwkMbIYLUx0lHOC5kkkw4Nf4qA+GsS+lcvcAV
	mAYkMSFviFm3ptG8I5AJr467o+kW5uCrKwEr5OYuDkW1M6Rs78CZI7lc9y4TAxrXRxXeDkfQdMD
	8hkFUzbxruxtD9DIIDUf3P/TwNqg
X-Google-Smtp-Source: AGHT+IEA/yhCzTJyfdEAbkQiwgR8tEbUa1BheFnQ6FMhbm/4Vl1BmWBbBf1RXP7O+ZRP/MoB/Zn1xJVNGlWfKWUBoF4=
X-Received: by 2002:a17:902:db05:b0:295:32ea:4cf6 with SMTP id
 d9443c01a7336-297c03b72ddmr31756285ad.5.1762497784235; Thu, 06 Nov 2025
 22:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-2-edumazet@google.com>
In-Reply-To: <20251106202935.1776179-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 6 Nov 2025 22:42:53 -0800
X-Gm-Features: AWmQ_blheAxhYPjKXzvfhLRrXnPfxc_-ojg26kpImzokDPA6AObFNw-TPIzJb3Y
Message-ID: <CAAVpQUBWr0dRtq5Y2Lv=y3zAx4q5HLOQY=J_RsdhCD7_x0h7Sg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: allow skb_release_head_state() to be
 called multiple times
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Currently, only skb dst is cleared (thanks to skb_dst_drop())
>
> Make sure skb->destructor, conntrack and extensions are cleared.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

