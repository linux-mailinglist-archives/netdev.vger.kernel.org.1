Return-Path: <netdev+bounces-86775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E58A03DF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 01:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE262289104
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EAC10971;
	Wed, 10 Apr 2024 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Q+WZpB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBD138E
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790414; cv=none; b=KFhN1DnpcEjRFCiZLC/CGOR+MoB2geCl9/lIeOOkbaNdBI5PtZsm0/7GcGQSJk0gkC4mWQhNJFXi2wCJd+phFotnisupx9T8DciCsp3I3ajNuK7nXSQe/Jj+lZ5K7S70yAsRugaHoZet8TWjJ33SevcNmu+spuViVaFraRiq5/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790414; c=relaxed/simple;
	bh=CAVxlM9Jf9TCc8Gu1VAFQRjdoA7J3HNipBscehG7leE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=JWL2xNebsPlRTY/3OkkuNi315tglCtNK4jz68xCkRp3p5F02fCZxoiiU2Njumq1RZ1u1163D0AhZ90aT51lYCg8448iH4i/cO3VZYiwAnPKUR0lzBbLowR2TqLCjgWQUueoUjmoqbrXSrRlryrE2EmxZxtCJOlobV+rtVyDVTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0Q+WZpB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b44071a07so4061686d6.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712790411; x=1713395211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptQdhZdIBXP/seHo2T/94bCd3+LKNU/mNFZDFHMq0YM=;
        b=H0Q+WZpBf1UC0y3hesyP9rAqSoTC34285RJgrocrSxBF8RIogT210/OArZ9/6aIAw4
         /tH+wcWyNrhj+sj09RxNsB1LH+ksejI7w8x320CzEMbc2qQv1vlnRBLMePvOpP6O85no
         J/6mUepyFRix3Gxp/zaYWb70uvT4jq3lhs+C8hWaH5r7L4T/M9w1PSKTxn0TsJ0OdnBn
         6F3T5whEqJDV+Zz6l9lk+y48KiWVROxTlUY0irqUZE4+hNuqyEWFAXztNnlND5gBci/R
         2bIBJx7n1cbOACkhhzMBC/e8o27bhwR54GPa/a75Tk/shR2zLrW++wZ9rzBhBCXkgDeS
         ZWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712790411; x=1713395211;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ptQdhZdIBXP/seHo2T/94bCd3+LKNU/mNFZDFHMq0YM=;
        b=EbYdqWeBaGiNYrMljhS5QXTZN3tjDrOQL3Y5sMos3DBXCAVn7qnTEkjpfbEPcR9u2q
         7+H6EgGgNbuSQIdsnXR9+yQhRAq6PGJ3R+ZOqB0/XJIsu7sD7tlf4+YsGffUNqdHtK21
         0OOJIJKOJEg1Fs5t2Zun7et/Tsrrpuuuj7KA1B3K1M6728zt00fRzdD7KFcRHYZG6ScV
         NpYf5Q1nXCJQLiU8+1WV+WZGyBQhL3eDWeUAl+pleCYPf2ePdwxgzvXyB96StaTv1ldV
         YxSaqrsYqsZCz5VcEEjAXZWFj+HU545cL5AZ7mdGqso5ztFZ/ypKJ5ULwgf/P+zu/1wp
         csfQ==
X-Gm-Message-State: AOJu0YySRxh/kfSLUbwyzofc0ntwoWru+r4FqLFmLw37hMD6X5PR6oqK
	W57VejCIT+llnwCIti5iv/DtqmdjDqxKOn0w5Z4xraBDCADzGyA0
X-Google-Smtp-Source: AGHT+IHppdcoYDo5kBIDwzJRyJyifx9cX47mS7lEhYilmP9t8F0qgcPkUQNmFREJ/Rzk+qrlT969NQ==
X-Received: by 2002:ad4:5d6a:0:b0:69b:18bc:f65a with SMTP id fn10-20020ad45d6a000000b0069b18bcf65amr4522565qvb.19.1712790411464;
        Wed, 10 Apr 2024 16:06:51 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id s9-20020ad45249000000b0069b1ef5d425sm128853qvq.134.2024.04.10.16.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:06:51 -0700 (PDT)
Date: Wed, 10 Apr 2024 19:06:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com
Message-ID: <66171b8b595b_2d123b29472@willemb.c.googlers.com.notmuch>
In-Reply-To: <0c6fc173-45c4-463f-bc0e-9fed8c3efc02@bytedance.com>
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-3-zijianzhang@bytedance.com>
 <6615b264894a0_24a51429432@willemb.c.googlers.com.notmuch>
 <CANn89iLTiq-29ceiQHc2Mi4na+kRb9K-MA1hGMn=G0ek6-mfjQ@mail.gmail.com>
 <0c6fc173-45c4-463f-bc0e-9fed8c3efc02@bytedance.com>
Subject: Re: [External] Re: [PATCH net-next 2/3] selftests: fix OOM problem in
 msg_zerocopy selftest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> >>> In this case, for some reason, notifications do not
> >>> come in order now. We introduce "cfg_notification_order_check" to
> >>> possibly ignore the checking for order.
> >>
> >> Were you testing UDP?
> >>
> >> I don't think this is needed. I wonder what you were doing to see
> >> enough of these events to want to suppress the log output.
> 
> I tested again on both TCP and UDP just now, and it happened to both of 
> them. For tcp test, too many printfs will delay the sending and thus 
> affect the throughput.
> 
> ipv4 tcp -z -t 1
> gap: 277..277 does not append to 276

There is something wrong here. 277 clearly appends to 276

> gap: 276..276 does not append to 278

This would be an actual reordering. But the above line already
indicates that 276 is the next expected value.

> gap: 278..1112 does not append to 277
> gap: 1114..1114 does not append to 1113
> gap: 1113..1113 does not append to 1115
> gap: 1115..2330 does not append to 1114
> gap: 2332..2332 does not append to 2331
> gap: 2331..2331 does not append to 2333
> gap: 2333..2559 does not append to 2332
> gap: 2562..2562 does not append to 2560
> ...
> gap: 25841..25841 does not append to 25843
> gap: 25843..25997 does not append to 25842
> 
> ...
> 
> ipv6 udp -z -t 1
> gap: 11632..11687 does not append to 11625
> gap: 11625..11631 does not append to 11688
> gap: 11688..54662 does not append to 11632

If you ran this on a kernel with a variety of changes, please repeat
this on a clean kernel with no other changes besides the
skb_orphan_frags_rx loopback change.

It this is a real issue, I don't mind moving this behind cfg_verbose.
And prefer that approach over adding a new flag.

But I have never seen this before, and this kind of reordering is rare
with UDP and should not happen with TCP except for really edge cases:
the uarg is released only when both the skb was delivered and the ACK
response was received to free the clone on the retransmit queue.

