Return-Path: <netdev+bounces-262086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGdzIGWKomlz3wQAu9opvQ
	(envelope-from <netdev+bounces-262086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:25:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA81C0902
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 07:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4512E3061759
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3B2D7DE2;
	Sat, 28 Feb 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1nKIzex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC630F7EF
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259922; cv=none; b=VqB3eYcdcZpL5/NE4OUr5o1vqFmsto8/EWVxfTJ9tDWYJ4+oMbhzMDJIdQ2D1aACEvI0t7Fz9uIvL4JP0qNERRt8tHqOAxCDkCaZdQQUMsnXM9Z41RfAApXpt97+zLFw67nhR5gqMirL7haCVtvLIHmO0+fY0XtJeMr1qz2HiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259922; c=relaxed/simple;
	bh=yoLx06V8W3H0FphAVQaQvkl2uDNlge7+OLs+wk8pudE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nckoFmDXWp80CU7RmrAN+0ivCX1r/Q3B0ZGAch2W8U3GXGHRQ74YvYfUNu3hWVO01lj5eXZXTkPAENgTQ8M1tSdvHiLDeqYNDxIsI9nzObVzF18fw/AkK+NEJhJbwkwa6nikFMha6+ixUcw+nvuzMw24s4ixAFgfwkJZv4k9dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1nKIzex; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1014942a12.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772259921; x=1772864721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpmNa4LRDCDwDZn6prMKh0tlUtQh8okPWCFVVp33444=;
        b=S1nKIzex/yVgULK8rrSeVSbc2ipR6izTbQq9hgb6vmCXDpYAGtJig+FXNKcYVv8dIT
         1zLhQGINyLKmRgCCTW4CAIRZesn3EnEqotJzXYzTaOYdXLLuo87yB9XpOXOPELYO5GFt
         bNjsVPls9SoZ7psr9B2kh/voMQ4nfUF5tJxtGnz8IvSS1CS497QZDBGaWi+VncIf7bSW
         3T8f2TD1195F9186r0/wCXhQwb3rwg9t0nf+9Ap+xz/7v7bmPD9YNeA66HZV04ZIaqkV
         BzYtvtOmAQI/7EfhELQk89N+NDNmcVxovCZHFQxWMA8InWN6kMK/5IUQLq0rrAjN8SY3
         cXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772259921; x=1772864721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpmNa4LRDCDwDZn6prMKh0tlUtQh8okPWCFVVp33444=;
        b=ExxwdD5JRZQ9BvZWbuc9CJJuCRuOJcmUv/+ipSQ44RLCVn/N8BupkcucYImpdimotp
         YZKK19h1tghnogmbTZPIWVsqtXtxprJBx45b6b9Enhq74zlI5LAZ4Uf38fEvpePUFQT8
         5trW6Nk4ACD7xp+fFkrmpQNff22bghqzE90i52pPOFsUybiJboIt7UgWH/LNAbdTCyVk
         R3v+yOgW+nZn43EXshhBtpYn4irJ2OTSmlbLfYdMEnEu8SMN206z9mXvgONk9VdZJQ7H
         RiBrRGRZDJvWwFD4EgU12WD/WEx2eXau/j5CNbmTIOuWCMfC1zIi4nip9HUJk7Dg/7bb
         pWbA==
X-Gm-Message-State: AOJu0Yxt4kS+/HljK2rYh1112l8VVajJxj7OpbVhqCpoJr9GmuoTjY1n
	fx1Zj/DiUG7uXBjsbfehyiJTyHes6ltRSIVS/P+hWT32GddmXtC6qM5z
X-Gm-Gg: ATEYQzzjiFweYmsVqpPmkoSOuwKI6ntGlYJpzvzGPkgHhjN4QiJyj7feVb/QpocPUFH
	JapN82JqqM9A5GMlO+26gfFy33/XrZxB5lGZuBFQLu7mUZlyFzkUFZ2bXWumhfN81EMgj+6zRFs
	1KljsGRHXGKegYEhy/dAOSMncpNVku3h051ZzLCjfkPb9Qc49/zCJ+CQRP7w9bKAXAij/lB9zma
	gjd+0Irz62z+5hdezqVRQ1DilUEOeiqKX+UUXZlZwBWrsjZhSwRpPCxwv2LqXG3RsHmHsYS5Id+
	CADXg3X9h3O9k7pfn8aEvtmQmpAfOC7EakiyEAqoKcEnwrNqQurU8ZQfv+NNBfgCzJzbQel6Klp
	+tNWj54eAn0NtVW55K2r5n4Q7TG4RZFEj3LvmBRRosCamSBBeP+he5cQOrFB7S/j49n0/S9i0FG
	xc1+toYoVCbtWArLpUvHoomqCVsJN2kERzFRqrfFQITxpaNGuiXqvikfHGRnoEnVwszGVAem9t3
	gakIw==
X-Received: by 2002:a17:90b:240e:b0:359:7b9a:2cec with SMTP id 98e67ed59e1d1-3597b9a2d7emr624977a91.0.1772259920683;
        Fri, 27 Feb 2026 22:25:20 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:7a59:6e8f:1a0b:107a? ([2001:ee0:4f0f:b1d0:7a59:6e8f:1a0b:107a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcc9c37sm6888309a91.8.2026.02.27.22.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 22:25:20 -0800 (PST)
Message-ID: <829f4263-dfd2-4664-b66c-0a65f35aa57a@gmail.com>
Date: Sat, 28 Feb 2026 13:25:13 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: xsk: Support wakeup on RX side
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260227150949.13089-1-minhquangbui99@gmail.com>
 <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com>
 <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
 <CAL+tcoAy7YjkODWp=nCagEJwOzhqt_BL4kcfxpj=FSiAXP_+qg@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAL+tcoAy7YjkODWp=nCagEJwOzhqt_BL4kcfxpj=FSiAXP_+qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262086-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6AA81C0902
X-Rspamd-Action: no action

On 2/28/26 13:16, Jason Xing wrote:
> On Sat, Feb 28, 2026 at 1:03 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Hi Jason,
>>
>> On 2/28/26 10:49, Jason Xing wrote:
>>> Hi Bui,
>>>
>>> On Fri, Feb 27, 2026 at 11:20 PM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>>>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>>>> wasting CPU cycles on polling. Users will be notified and they need to
>>>> make a wakeup call after refilling the ring.
>>>>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
>>>>    1 file changed, 30 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index db88dcaefb20..494acc904b2c 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>>>           xsk_buffs = rq->xsk_buffs;
>>>>
>>>>           num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>>>> -       if (!num)
>>>> +       if (!num) {
>>>> +               if (xsk_uses_need_wakeup(pool)) {
>>>> +                       xsk_set_rx_need_wakeup(pool);
>>>> +                       /* Return 0 instead of -ENOMEM so that NAPI is
>>>> +                        * descheduled.
>>>> +                        */
>>>> +                       return 0;
>>>> +               }
>>>> +
>>>>                   return -ENOMEM;
>>>> +       } else {
>>>> +               xsk_clear_rx_need_wakeup(pool);
>>>> +       }
>>>>
>>>>           len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>>>>
>>>> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>>>>           return sent;
>>>>    }
>>>>
>>>> -static void xsk_wakeup(struct send_queue *sq)
>>>> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>>>>    {
>>>> -       if (napi_if_scheduled_mark_missed(&sq->napi))
>>>> +       if (napi_if_scheduled_mark_missed(napi))
>>>>                   return;
>>>>
>>>>           local_bh_disable();
>>>> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
>>>> +       virtqueue_napi_schedule(napi, vq);
>>>>           local_bh_enable();
>>>>    }
>>>>
>>>>    static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>>>    {
>>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>> -       struct send_queue *sq;
>>>> +       struct napi_struct *napi;
>>>> +       struct virtqueue *vq;
>>>>
>>>>           if (!netif_running(dev))
>>>>                   return -ENETDOWN;
>>>> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>>>           if (qid >= vi->curr_queue_pairs)
>>>>                   return -EINVAL;
>>>>
>>>> -       sq = &vi->sq[qid];
>>>> +       if (flag == XDP_WAKEUP_TX) {
>>> Better use &?
>> Sorry, I don't get your point. Can you elaborate more?
> Oh, I meant using 'flag & XDP_WAKEUP_TX' is preferrable. IIUC, since
> this patch provides a way to enable the RX flag, for virtio_net, this
> flag can be set by TX and RX altogether? Please see this call trace:
> xsk_poll()->xsk_wakeup(xs, pool->cached_need_wakeup).

Oh, you're right. I'll fix it in the next version.

Thanks,
Quang Minh.


