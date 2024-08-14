Return-Path: <netdev+bounces-118280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD70D95125A
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1BA1C20B72
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 02:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30015171A5;
	Wed, 14 Aug 2024 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+Yw74CB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C11CA96
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602535; cv=none; b=u7c9fhjLjkBEO4l3ni6glfTCjPEyD+EWbespLq8ZIjZnMbrDthb+/gWDXOjLnqDA0juAIbQIOZVXWtPEtlWFh9s+D7/DkSeu3azqEaIpZHd7fSZv/QRcGAl9HgiQ8ru2R2EQSKW/g5jM/n2H8HYrG9qgy7/0cI7tnXB2LM0+t2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602535; c=relaxed/simple;
	bh=5P9OoyLQI7tBDAPK+hZKalYTmfPO5gT2N4Ht1PhcUW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pKt0v0uT+0xCWfvq6BKEuD+jD0YvStSc6a0XABpa5WZJQkLMGacSd6ixz2S8LXDEJZLZSxVVgbLoIA4adkqEEw8+AJwW8k448M2w6SC9VG2nmIkXp60czOVmXB0kalFqd3SAnmSG1Jad7SRhO8Ma6hpkPBZrjyAM0FUDAPJw0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+Yw74CB; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f905eb19cso300838439f.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 19:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723602533; x=1724207333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5P9OoyLQI7tBDAPK+hZKalYTmfPO5gT2N4Ht1PhcUW4=;
        b=d+Yw74CBKoapuFHdAYdj7a/EdXC+TJtZ+ntkDX21M2eTAxL2N32merY52DX2pVG9Zv
         XzHDcsKKKjt3TwyLxN4isoaGMxRvoExXZHs1728HfTv6uoyTXh1L9ERHY0p2UGTXdZ71
         Scin6AYUSqP+KoSUMbe1Nm3WteoQnt5wApNAlxI7OHBOYLAV3eeh3YkSQyAZPFgOUTR8
         5i59JQd74jEg9u4fTUy1q6m5ztt/dvrAYJMtazpjTENxz8SYxgTF6vM3dFQpAk9Bsbwf
         Xco7a8OuOriVlsvExF6qote22v5rEfo7R/z6LT/t7ffz7Y11I9JDVUW3eVcYOHKv2CgV
         ObZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723602533; x=1724207333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5P9OoyLQI7tBDAPK+hZKalYTmfPO5gT2N4Ht1PhcUW4=;
        b=eGJ7jVgJv7/6MDaTmy6aQiQXRNekISDqbVqUouzsbRVdh2jtbEuGAyS2xXIkEkH5yy
         eiNoAzqDUIQoqZX7zrqQfomfH7E1L2iHJ8ZJU3yyau5eDcMAyCM7cbl6TI05Z8uE5VOM
         WXb+3Jpy/0nkOkrRRUJ4YuCFw1Z501+lJyDgay/ZFeFDXdsSxok7kBF38hkamWz8V87V
         2Wi5kAWwsUOMsjn62w7Y0mLPO2IsCxTMIRWr5Ukq+q7x/XTmiiDeaCP+mq4NVWhtkdKH
         JgD1mVA4KA0YsiNS+VI58gHelNIOzlVAnG1tTHpOjctsKSmvn1iXc61ZSq44JyG3+ayS
         QrmA==
X-Forwarded-Encrypted: i=1; AJvYcCXNzOAmF1GH7pW4f709iPRm39EoPWy/iyjKhrDhcl1Ippg9NjB2Posm18xEGOs77pafP9AegzZT8E6OtjG5Dc0gN/625Dui
X-Gm-Message-State: AOJu0Yz+Ea4SLITG5Yz8TqJKQDrQbzJ/Xj/ZHVmiGtRD5dMuXmo3l2X2
	dGZFlPlVi+ehaLM5mDX9gQ7xxWdh27gHk3HxdPsDf45fpz3XG3iGfHf+DtAK2HhA0TnmmTXl0Ew
	Uyfv0tjxEZFD4bTGM0ac8GrC/Clw=
X-Google-Smtp-Source: AGHT+IF3euvTNjogCUX2eZtGiH+yi/96MmXZ1aQgxts38keHdmnt3uLdT9Yj4e295YDODAhB71Jdy/LTAGnLHQeNOs0=
X-Received: by 2002:a92:cd85:0:b0:39b:640e:c5fa with SMTP id
 e9e14a558f8ab-39d124bfc29mr20574155ab.19.1723602532773; Tue, 13 Aug 2024
 19:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726204105.1466841-1-quic_subashab@quicinc.com>
 <CADVnQynKT7QEhm1WksrNQv3BbYhTd=wWaxueybPBQDPtXbJu-A@mail.gmail.com>
 <CANn89i+eVKrGp2_xU=GsX5MDDg6FZsGS3u4wX2f1qA7NnHYJCg@mail.gmail.com> <CADVnQynUV+gqdH4gKhYKRqW_MpQ5gvMo5n=HHCa08uQ8wBbF_A@mail.gmail.com>
In-Reply-To: <CADVnQynUV+gqdH4gKhYKRqW_MpQ5gvMo5n=HHCa08uQ8wBbF_A@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Aug 2024 10:28:16 +0800
Message-ID: <CAL+tcoCbo2v-Td=1vLgxLSZ3bj7rnkWkr27yjCiMC4QScQo3jw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Adjust clamping window for applications
 specifying SO_RCVBUF
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, soheil@google.com, yyd@google.com, 
	ycheng@google.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	Sean Tranchetti <quic_stranche@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hello Neal,

> > Otherwise, I feel that we send a wrong signal to 'administrators' :
> > "We will maintain code to make sure that wrong sysctls settings were
> > not so wrong."
> >
> > Are you aware of anyone changing net.ipv4.tcp_moderate_rcvbuf for any
> > valid reason ?
>
> No, I'm not aware of any valid reason to disable
> net.ipv4.tcp_moderate_rcvbuf. :-)

I was also curious about why this sysctl knob was useful a long time
ago? I don't see any good in it (for many years, we haven't touched
it, setting it to 1 as default). Since you maintainers don't think
it's a good one, could we mark it as deprecated and remove this
sysctl?

Thanks,
Jason

