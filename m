Return-Path: <netdev+bounces-182736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47ABA89C92
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8A41901E4D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9F29615B;
	Tue, 15 Apr 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPG9uy8k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46872957BB
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716623; cv=none; b=mFqHvQjphlpJCwZOx5V2sUxdY/RMgVjzw0rdlPDa0gf9wM6lU1OkDtW4XXC3oz+maxltMjum8GOjnhN/8ULdbSNRIQv+mFC5q+KFgVau+/iKMhzSS/YQoIHIKpHYIUxBNv0tMYunetc6mNbq3atSUONUVlKzJPMIwbkSwaFFNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716623; c=relaxed/simple;
	bh=ho+BIZkkHCNPFh5mOIzlN9sX0n4qGaVKCx7gnc8eyF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa68AEfpt6lQX6uUX483TM9YaFG1PzETN5GEikWdWh6+kWIyc3/d/xvV1jm1tk6xZUrkjtyijCH/xcpcnqH4Mufeu/LjDw9cFXB8yfNNqV9+JaVzEnF1H32wOZtOxhfe7BecP8YhSLBPD3NF2r6AwI0f/hhDST+SzLaOjEMN2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPG9uy8k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744716620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WL9NlzbUnGnzvSoEyfdI3sGtjP4UhtYp1pIkY1wcER4=;
	b=iPG9uy8k+xEkozCXTGgj6nPsosdAHIESTYEkHKe9INeAOGPnpAqifpf01CAg0qc5o2UPI6
	tX51+5LAUh50NiB+Pr29XsoXy2Mqqi0BVS/TPecOKhsem+kEh6PdZI+pV1JIIoyWPJBJ21
	In9ToWGPKR1Zk75ODKYXLedtz24UNvg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-S4LrtPCcNli_dQHPZa9fDg-1; Tue, 15 Apr 2025 07:30:18 -0400
X-MC-Unique: S4LrtPCcNli_dQHPZa9fDg-1
X-Mimecast-MFC-AGG-ID: S4LrtPCcNli_dQHPZa9fDg_1744716617
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso42346445e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744716617; x=1745321417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WL9NlzbUnGnzvSoEyfdI3sGtjP4UhtYp1pIkY1wcER4=;
        b=u3aau54CWvXxOK8XDLNuv4q6jeR+ezBfjispy3zBA8bEBY9Gzl9yptLLzuaOjZhoca
         chrESmd/P/Qlm9xtjI8fe72lFq3OOE/ZT02fHQXP6pEsuJEnnM8RqOOIra+tVJMzQfT3
         H6dqnT1d8HujLZkbn5obhNugJr1skElxkEUZhQUoIbOlKburSJxEIwkG4XuJCyXcCU36
         0V7tbOy7CcAAxCnlymV6XScGNX6nZw2tTUHiPU79fbG/ox3pha3AIZRCFQIVPORwPAMq
         YxHiwHr4GlRlYwb4mgCCXSL7XJdu2aQq6QgQaLZDSj8+o7pHQqbMfNtnIWR+mKueAtGH
         oKFw==
X-Forwarded-Encrypted: i=1; AJvYcCXWPt+j7PffEIanXdhkh4e0DnnTHJygCQ8ekHL0SOMj7AZSjt/4rytY4zkSZeZUSlwOBQ5g8hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaRCCCW0nsLQkYsToegktKL+SyUM7NjGmE5Xo0O7z8wqizhdy
	wMIcESx4pti4T3C/UI9/fTuiQbi9/HobMm/e5RC4qdqK/2NKq2RKdQXMtXI88BbbuMsK1QyDQC/
	pAv+cuXfk69nlKCyFGiRYNAVZdsNFaQdgJtisrUnrNa1u73zNRglt4Q==
X-Gm-Gg: ASbGnctFPznk5f9wNMY6kX3p72rR+OlY1u1scv2nAuxwcsIUril+PBWuxgHwQCfHT6K
	lHiiqp5NLPFozJy2B1VxuAv6pnEjrEIwogab4C9lv5RK1yiZGleTQjWKVzCcAmo9maPMKR5do0p
	HysiIOLOFJ3O2I5WSg7MRBRIVdU8z78VIGGZ8iYA1PIrUJJ0K4Bpcl7WWqeQVKnSFPdtRWunuHs
	APjg55LirJ6fsmFIFTtu+tLBkcr5UX9o+OgECjSc6EtXYKFeMN/rgpcZaMNTxmylGVtU+fjl2Qa
	XrOBIt4C5c86Ks0GmIamfORJvPWkOGOmbtqGoAU=
X-Received: by 2002:a05:600c:1d88:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-43f3a94c5a0mr152192765e9.12.1744716617247;
        Tue, 15 Apr 2025 04:30:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHTty5zldCcVKBl8bs1qCQdERVonAOGxKe+N9IX3VziaHsTcIq127AQOONK9qhEgPTFMAq+g==
X-Received: by 2002:a05:600c:1d88:b0:43d:7588:6688 with SMTP id 5b1f17b1804b1-43f3a94c5a0mr152192445e9.12.1744716616861;
        Tue, 15 Apr 2025 04:30:16 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206332d9sm206447235e9.13.2025.04.15.04.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 04:30:16 -0700 (PDT)
Message-ID: <d44f79b3-6b3e-4c20-abdf-3e7da73e932f@redhat.com>
Date: Tue, 15 Apr 2025 13:30:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
To: Luiz Carvalho <luizcmpc@gmail.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
References: <20250410175140.10805-3-luizcmpc@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250410175140.10805-3-luizcmpc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 7:50 PM, Luiz Carvalho wrote:
> The current tcp_acceptable_seq() returns SND.NXT when the available
> window shrinks to less then one scaling factor. This works fine for most
> cases, and seemed to not be a problem until a slight behavior change to
> how tcp_select_window() handles ZeroWindow cases.
> 
> Before commit 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze"),
> a zero window would only be announced when data failed to be consumed,
> and following packets would have non-zero windows despite the receiver
> still not having any available space. After the commit, however, the
> zero window is stored in the socket and the advertised window will be
> zero until the receiver frees up space.
> 
> For tcp_acceptable_seq(), a zero window case will result in SND.NXT
> being sent, but the problem now arises when the receptor validates the
> sequence number in tcp_sequence():
> 
> static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
> 					 u32 seq, u32 end_seq)
> {
> 	// ...
> 	if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
> 		return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
> 	// ...
> }
> 
> Because RCV.WND is now stored in the socket as zero, using SND.NXT will fail
> the INVALID_SEQUENCE check: SEG.SEQ <= RCV.NXT + RCV.WND. A valid ACK is
> dropped by the receiver, correctly, as RFC793 mentions:
> 
> 	There are four cases for the acceptability test for an incoming
>         segment:
> 
> 	Segment Receive  Test
>         Length  Window
>         ------- -------  -------------------------------------------
> 
>            0       0     SEG.SEQ = RCV.NXT
> 
> The ACK will be ignored until tcp_write_wakeup() sends SND.UNA again,
> and the connection continues. If the receptor announces ZeroWindow
> again, the stall could be very long, as was in my case. Found this out
> while giving a shot at bug #213827.

The dropped ack causing the stall is a zero window probe from the sender
right?
Could you please describe the relevant scenario with a pktdrill test?

Thanks!

Paolo


