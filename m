Return-Path: <netdev+bounces-85098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C28548996E2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 09:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC52B23A5F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 07:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AECA13D8B4;
	Fri,  5 Apr 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX9XFpY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199D13D265
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303284; cv=none; b=K8xLrjq+go+kCuCvheP7TcphIrLNcX1j1xXtHvTetPYwpC/V6EIgL7Cvcgxv5v2ra+tmZxFIXmTjgxLq67eeBLiJCrSbBau7DlocvjLsKYZMOGV8mwi9JgWqBrVMnTz02ipWmrPGuPPrF7EKHnYep6IgsrbWZT7bCpmIM/pwfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303284; c=relaxed/simple;
	bh=uS0aQXQsh/a/pFBghae45x0sP6pAJI09/0vpYdULpm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMW1141egkNgyoJ6/qGBSlZ/+YvYVG9uhz3QifxjplJBv8Y3zc435L9V9+LobGgPTA08ELPVThSSZxJPSW+v0fpOAzBW5KRASodsbZrU1UOhUJA0EZHcQC45Ki6s1tP0wI90fJWQ+VgLDGzepT12W1Jit6clOovquIeoYvU35RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX9XFpY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712303281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uS0aQXQsh/a/pFBghae45x0sP6pAJI09/0vpYdULpm4=;
	b=aX9XFpY07vlHNJcwJA7NHVN3g1ij9UCDk3PN2Kl803VRe/r18LbH9xVxXgKjdNd52JJ3Kd
	16P6M1pR4fKUhRCJn3vtvZLcGT9kvXX5jRYYgvzoR5199EZrr0M2kTng5dCoLW9ESqxEtP
	VrohzsMrFXpJkRrSVUFeRTl345svGMc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Qw5jbqfxNkaDL0QnIIyZ5g-1; Fri, 05 Apr 2024 03:47:54 -0400
X-MC-Unique: Qw5jbqfxNkaDL0QnIIyZ5g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343b9425ed1so350205f8f.1
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 00:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712303273; x=1712908073;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uS0aQXQsh/a/pFBghae45x0sP6pAJI09/0vpYdULpm4=;
        b=JWPK1LEcPYJgoyNFJYlmyCtqKY4aMCAFVAV6JvB+uZKmaJkhASVsf6E19M6VhxUfzL
         Hvy4gmru2t5cMrEiYucMHCDOj8WF967C/QZWxxmoNax89FQks1nZ5uuAkeeeCde+wNWp
         vULptQ5w6uY/iT8GvE6Oe2vy3tPxpWMPCFRyuH8z3KSQHETYkpa8FqO1aSuOBSpVmlsA
         l8bZUvWvzh4JtLDchRxHibLR95qXeq97aPWT6RxSZc6HtMWqWlep1wpTKC7HKy+S+SkN
         s2BqmHjjtvMwmJKJIQ8CPWLCwMGf4YU044MNDA73O32gR1X8clO6Gl7PuJOaCZxUbko9
         7iZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYYXdkBN/9PxDfIOLDHyH6SG0vb7pZsNYTypPsOlTj86NR4noml0F9PMU85e5bC0aTKHS+1JOXFBpfHZ/Tn5a6QDRfbBhs
X-Gm-Message-State: AOJu0YxzXQkQ5GBEDb+CyL+5QVvKDB1nf6nVAPv4rPbCb4TnaSbNhb55
	tcSOcG2/x8y/qg/2KmtnKgmT1RTHvowqtJXlIT42P836vrEMpoUPDQ2JxUOTDmp4INUvS4vvsGZ
	oRKSz1XP5mR8PEMpOC2tHDqdCw62+ivzMDAER2Sx/YC6U8RScKTts/A==
X-Received: by 2002:a5d:64ec:0:b0:343:b5f0:f510 with SMTP id g12-20020a5d64ec000000b00343b5f0f510mr674804wri.1.1712303273204;
        Fri, 05 Apr 2024 00:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj95jbp1+tsuypKHAdGT+4GN5iykJLOOBF/bALOCINV/YZ+Ry60hzjSeiqcRf/DjA0/1S37g==
X-Received: by 2002:a5d:64ec:0:b0:343:b5f0:f510 with SMTP id g12-20020a5d64ec000000b00343b5f0f510mr674784wri.1.1712303272857;
        Fri, 05 Apr 2024 00:47:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id c8-20020adfe748000000b00343a0e2375esm1352353wrn.27.2024.04.05.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:47:52 -0700 (PDT)
Message-ID: <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP
 in mptcp_reset_option()
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, matttbe@kernel.org,
 martineau@kernel.org,  geliang@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, Jason Xing
	 <kernelxing@tencent.com>
Date: Fri, 05 Apr 2024 09:47:51 +0200
In-Reply-To: <20240405023914.54872-2-kerneljasonxing@gmail.com>
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
	 <20240405023914.54872-2-kerneljasonxing@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> Before this, what mptcp_reset_option() checks is totally the same as
> mptcp_get_ext() does, so we could skip it.

Note that the somewhat duplicate test is (a possibly not great)
optimization to avoid jumping in the mptcp code (possible icache
misses) for plain TCP sockets.

I guess we want to maintain it.

Cheers,

Paolo


