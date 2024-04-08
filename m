Return-Path: <netdev+bounces-85689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A464189BDAE
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5B51F225AC
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307E66168C;
	Mon,  8 Apr 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik6WSzJN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE75FB8C
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574090; cv=none; b=VTSI/nwMgWS5kR5H6cqe48bTxkwZOOg1hZt79BloqwqA75FTa2JEHP45lECconl65D4nv2/VwxzsyLSxtz3sonj+CD43ERDp6LJj0bOKkm3nL30DYrwQPQqQJyAKu4kuYea5220cPO7hlUUdffkXPjt6xmDLW9ChdaOOE6bzeog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574090; c=relaxed/simple;
	bh=nbt5DrxQ/4u9cBOhUW34//4c6cXw9zNn2WAthk/Qgg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2guDBWT2OxnyeusvC7sq5+CMI+m6T55L2ynTuWdbzmEqFXODbe6Db8jxy32Nq56JvTBAiHs1ZPxRIYB6aoxYoKzGBgBWpyTS1WVPzxDJHvJUQdfKoJdXPNM/WYzuoq2Uv/RhxTtgJfC3A1x7MTBu0dLmT8XVi/wXk82fh3UVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik6WSzJN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712574087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScJ1E+wTN6zvVZouf3O4q8jXzLSJvBWlc012JYotauk=;
	b=ik6WSzJN3ftwGF/si2Q/8bBSYNHyT/E18IBVFNrKCggKqkJZncR38GuV0ptzfoi5y3h6uY
	8FoMj97W0JaVy5JvfcD6b0T2XwoJbAMsj5j1W4H/h/DxB38wBqhykco+0YHzWT3LLlQqJm
	yGdz/oanJvTBG/dtevxwuRdyywrTGbo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-q8VjxRqLN2mwP9a3j2QLHA-1; Mon, 08 Apr 2024 07:01:25 -0400
X-MC-Unique: q8VjxRqLN2mwP9a3j2QLHA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d5e9230c3so168779985a.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 04:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574085; x=1713178885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScJ1E+wTN6zvVZouf3O4q8jXzLSJvBWlc012JYotauk=;
        b=RyjVita5pSHIW09SdyXWddpnF8/MdYdoaYF7TlM/aDqtsa/6nD1DdIq9iCEXQslVxV
         Z2f3nyXo9NVkUpFZ61YGDXTajo+R2Pe/l0CdnW3sB3noNhbBriM7CKuV53DBV/6td4mv
         Un72DVrUHfhjNYFtzGCu/CGHdrWXZhxCvSsAe+8EoPl+Pc0nC50XhNbC+ot+UGEw31Kn
         MKj+9VO72QpPFrBm0HovROJd38WGc1v4rVFnFajoZmULLAh8ZShzVViBOVpzZGVBYUl9
         ysvFuc23MA8VNju18da5e18WKp4Ju19Wg56DP9uYnkA33uFpnAhqrRk1F9RhU3X2TRYq
         CNYA==
X-Gm-Message-State: AOJu0YyKKTrXE0HTj2r6w/MOaKtNyoJDpS3YEngCM10tHl9Y0Q0E+K0W
	4Z5kkZDMD1q9nZmTo8xhjlcwOzVEQc8J7X66gfj2H5WNQjk+LFwhN+tNhlyJBIxtC08B0xcd48C
	78Sa5pAd3jQzRnKkZXfIMdilVVDnJTdrT4ZbQX+5PRS1pexTVe5rxSQ==
X-Received: by 2002:ae9:e70b:0:b0:78d:61b6:1c73 with SMTP id m11-20020ae9e70b000000b0078d61b61c73mr3390304qka.32.1712574085330;
        Mon, 08 Apr 2024 04:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1kmAHyHCUlER63MzU4IogIvtkzBiNFkrKk+I6vzDaIpObb8eGoIjXFLUowHhT3VazPTu6eA==
X-Received: by 2002:ae9:e70b:0:b0:78d:61b6:1c73 with SMTP id m11-20020ae9e70b000000b0078d61b61c73mr3390251qka.32.1712574084320;
        Mon, 08 Apr 2024 04:01:24 -0700 (PDT)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id m6-20020a05620a214600b0078d65a42db6sm1008186qkm.95.2024.04.08.04.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:01:24 -0700 (PDT)
Message-ID: <f0819d6d-338a-8441-d12a-771dbfd9028a@redhat.com>
Date: Mon, 8 Apr 2024 07:01:22 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [net-next 2/2] tcp: correct handling of extreme menory squeeze
Content-Language: en-US
To: Menglong Dong <menglong8.dong@gmail.com>,
 Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, eric.dumazet@gmail.com, dongmenglong.8@bytedance.com
References: <20240406182107.261472-1-jmaloy@redhat.com>
 <20240406182107.261472-3-jmaloy@redhat.com>
 <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com>
 <CAL+tcoC8LBQGe7ES01bxKFkU15GoFpEgT5jx1tnwb2Yb_BOKfw@mail.gmail.com>
 <CADxym3ZfC5WF7C2B8oYq=38rsLnQ-DOfvhH3iSk6+L0g2=XWDQ@mail.gmail.com>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CADxym3ZfC5WF7C2B8oYq=38rsLnQ-DOfvhH3iSk6+L0g2=XWDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-04-07 03:51, Menglong Dong wrote:
> On Sun, Apr 7, 2024 at 2:52 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>> On Sun, Apr 7, 2024 at 2:38 AM Eric Dumazet <edumazet@google.com> wrote:
[...]
>>>> [5201<->54494]: tcp_recvmsg_locked(<-) returning -11 bytes, window now: 250164, qlen: 0
>>>>
>>>> We can see that although we are adverising a window size of zero,
>>>> tp->rcv_wnd is not updated accordingly. This leads to a discrepancy
>>>> between this side's and the peer's view of the current window size.
>>>> - The peer thinks the window is zero, and stops sending.
> Hi!
>
> In my original logic, the client will send a zero-window
> ack when it drops the skb because it is out of the
> memory. And the peer SHOULD keep retrans the dropped
> packet.
>
> Does the peer do the transmission in this case? The receive
> window of the peer SHOULD recover once the
> retransmission is successful.
The "peer" is this case is our user-space protocol splicer, emulating
the behavior of of the remote end socket.
At a first glance, it looks like it is *not* performing any retransmits
at all when it sees a zero window at the receiver, so this might indeed
be the problem.
I will be out of office today, but I will test this later this week.

///jon

>
>>>> - This side ends up in a cycle where it repeatedly caclulates a new
>>>>    window size it finds too small to advertise.
> Yeah,  the zero-window suppressed the sending of ack in
> __tcp_cleanup_rbuf, which I wasn't aware of.
>
> The ack will recover the receive window of the peer. Does
> it make the peer retrans the dropped data immediately?
> In my opinion, the peer still needs to retrans the dropped
> packet until the retransmission timer timeout. Isn't it?
>
> If it is, maybe we can do the retransmission immediately
> if we are in zero-window from a window-shrink, which can
> make the recovery faster.
>
> [......]
>>> Any particular reason to not cc Menglong Dong ?
>>> (I just did)
>> He is not working at Tencent any more. Let me CC here one more time.
> Thanks for CC the new email of mine, it's very kind of you,
> xing :/
>


