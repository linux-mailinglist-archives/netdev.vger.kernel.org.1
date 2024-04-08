Return-Path: <netdev+bounces-85693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A679A89BDD8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E0A281A5E
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564FD64CE8;
	Mon,  8 Apr 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEF9W9Qu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D364CCE
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574824; cv=none; b=WKVV2yAH44YEukH106EGZhPCfadhKHQkA1/iX9uHFbYWmyPN6VUCRbUdgOPah5wVltpDuruM+DuyTRnpXnwyFX6ooo0OGzdIxNHu7VaUGU1CSO+0l8GV/GQRibIOi/0gcqH2Cs2XhljY1dy5fRkWg1u5g8n4T527ljpDH0fLVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574824; c=relaxed/simple;
	bh=4+VBQDVN/mvrrFJ8RaV99wghGscxaFCUSEUH9mjVd24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImEuBTG1EB0HrTgWQ0Ne3JTGBSYuIXMRpGtC8kA1SaD33IlXDi4gh98eaIgfcQb98+7/dtuHpVQb2XsF0xQttYWn/41gBqvZ2zeTMigqdjgTjd33TKZuahtobLmuNX8/xn3FHJ4urN+5oXnMRO4YC76qTceGXUROPRK+fCfhk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEF9W9Qu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712574821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4DNOq7uzSfhWeqJhhga1Wtuk6KwXhSh9ZIwa3rXSar4=;
	b=CEF9W9QuLSX3U4+T6E8m5HsqeqL3GxC5eVQ1MnidsH53GekiiY9EezjVoUOAmK78BjgBdo
	IRF8RrLN9GqyGVc2OLokd+2amkQZF4dlUQot+T0FgCT3mIhvQCbTvaDBclNB+h8UmCBxfV
	QlF12hcg8pmRz9kpiU9DFCcPEefo+2c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-onpRg52MMT2FiNWHA1qH4A-1; Mon, 08 Apr 2024 07:13:40 -0400
X-MC-Unique: onpRg52MMT2FiNWHA1qH4A-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43493db2263so12827591cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 04:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574819; x=1713179619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4DNOq7uzSfhWeqJhhga1Wtuk6KwXhSh9ZIwa3rXSar4=;
        b=Ozhb2dkcGg245SJirx7nXgYomh7uiHvQjXfQKtU/jlwAXSzoE1m+COUuLl7TLGCX9C
         Mp6VBCThWJ+4mGAyscKuL6NlJz0IqlMcfRtrFGI8bXr0zjC1XOGQ1NqQplPKqyu5ic9y
         tBFforfHKKIJ84IsSYyk7jTcuWx4zI9uuGJ/dG5OWBcFcAjg1UvIPaquEMhJJ6wAPyPW
         Oh0WLdnZINGm17NkUO9NRIcqZ1ia79bq8VNBTgjRA+uYiuFzfCciSlsHiMkxaNUX8k8s
         nFhjSIXauIuyvhGCbKlqkjsom+jmYNuD3doscU3xQCs00Rq/hift6bAG8Sw56JLez7ad
         I8Ng==
X-Gm-Message-State: AOJu0YyxxnKXIg/BZpY56YZR4zZgIQUjNxnXqhXr4EJwBrIdVnuDlJVs
	XTe2mp6C7Tq3oEFdMKyPWUzV0iDc1r7FUEJlexymTtgyGkrXBLvPupRCAGgo1xKixmZgM4L/8im
	RrII6upPwnUW61Hbta0lHrnLedyTGbCUf21Gb9GDwhOSP64aEyof20w==
X-Received: by 2002:a05:622a:13d0:b0:434:53c6:3fc0 with SMTP id p16-20020a05622a13d000b0043453c63fc0mr10351754qtk.31.1712574819453;
        Mon, 08 Apr 2024 04:13:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0la4a/LpRLGJzUw6fsG5wFS9JofnuLDQ81jsW/BOprnVxhyiMS9Qc3sU0QHHrrRDjIT9wlw==
X-Received: by 2002:a05:622a:13d0:b0:434:53c6:3fc0 with SMTP id p16-20020a05622a13d000b0043453c63fc0mr10351738qtk.31.1712574819168;
        Mon, 08 Apr 2024 04:13:39 -0700 (PDT)
Received: from [10.0.0.97] ([24.225.234.80])
        by smtp.gmail.com with ESMTPSA id e8-20020ac86708000000b0043496bcfc2esm1167081qtp.12.2024.04.08.04.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:13:38 -0700 (PDT)
Message-ID: <3b78aff5-a7d3-5af0-ec27-035d99cb1bd7@redhat.com>
Date: Mon, 8 Apr 2024 07:13:37 -0400
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
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, eric.dumazet@gmail.com
References: <20240406182107.261472-1-jmaloy@redhat.com>
 <20240406182107.261472-3-jmaloy@redhat.com>
 <CANn89iJgXBXaZyX5gBwr4WiAz5DRn8sH_v0LLtNOSB84yDP3yg@mail.gmail.com>
 <CANn89i+UjuasDbqH2tUu0wv=m+roHocBHwzcV4VS+Wotz-8hng@mail.gmail.com>
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CANn89i+UjuasDbqH2tUu0wv=m+roHocBHwzcV4VS+Wotz-8hng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-04-08 06:03, Eric Dumazet wrote:
> On Sat, Apr 6, 2024 at 8:37 PM Eric Dumazet <edumazet@google.com> wrote:
>> On Sat, Apr 6, 2024 at 8:21 PM <jmaloy@redhat.com> wrote:
[...]
>>> [5201<->54494]: tcp_recvmsg_locked(<-) returning 57036 bytes, window now: 250164, qlen: 0
>>>
>>> [5201<->54494]: tcp_recvmsg_locked(->)
>>> [5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
>>> [5201<->54494]:     NOT calling tcp_send_ack()
>>> [5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
>>> [5201<->54494]: tcp_recvmsg_locked(<-) returning -11 bytes, window now: 250164, qlen: 0
>>>
>>> We can see that although we are adverising a window size of zero,
>>> tp->rcv_wnd is not updated accordingly. This leads to a discrepancy
>>> between this side's and the peer's view of the current window size.
>>> - The peer thinks the window is zero, and stops sending.
>>> - This side ends up in a cycle where it repeatedly caclulates a new
>>>    window size it finds too small to advertise.
>>>
>>> Hence no messages are received, and no acknowledges are sent, and
>>> the situation remains locked even after the last queued receive buffer
>>> has been consumed.
>>>
>>> We fix this by setting tp->rcv_wnd to 0 before we return from the
>>> function tcp_select_window() in this particular case.
>>> Further testing shows that the connection recovers neatly from the
>>> squeeze situation, and traffic can continue indefinitely.
>>>
>>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>>> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> I do not think this patch is good. If we reach zero window, it is a
> sign something is wrong.
>
> TCP has heuristics to slow down the sender if the receiver does not
> drain the receive queue fast enough.
>
> MSG_PEEK is an obvious reason, and SO_RCVLOWAT too.
>
> I suggest you take a look at tcp_set_rcvlowat(), see what is needed
> for SO_PEEK_OFF (ab)use ?
>
> In short, when SO_PEEK_OFF is in action :
> - TCP needs to not delay ACK when receive queue starts to fill
> - TCP needs to make sure sk_rcvbuf and tp->window_clamp grow (if
> autotuning is enabled)
>
We are not talking about the same socket here. The one being
overloaded is the terminating socket at the guest side. This is
just a regular socket not using MSG_PEEK or SO_PEEK_OFF.

SO_PEEK_OFF is used in the intermediate socket terminating
the connection towards the remote end.  We want to preserve
the message in its receive queue until it has been acknowledged
by the guest side, so we don't need to keep a copy of it in user space.
This seems to work flawlessly.

Anyway, I think this is worth taking a closer look at, as you say.
I don't think this situation should occur at all.

///jon


