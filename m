Return-Path: <netdev+bounces-262084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id muKKFzZ3ommA3QQAu9opvQ
	(envelope-from <netdev+bounces-262084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 06:03:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA11C061C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 06:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22A5B302C144
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C971A317D;
	Sat, 28 Feb 2026 05:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llsJnbYs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6315D38DF9
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772255024; cv=none; b=A73VPVIG1w5xKOFPI6WQOweTeZx62xmTUR80DDrtV4EJgxukRLCMW48PNpBIQ6uTEgIxXWRDPil+8BjTXoAYZ28IeSdgaHDrazTO7RNYVUJ84lrslxR4Z77gcGn4kai22BUnMcvC5Di0GqQc7UhrlnO7Ty05A2FkwhXAVg4iGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772255024; c=relaxed/simple;
	bh=WZGn9t6Nnd4BlPrgobIshCbzAK0yZTeNkprJ1mTTlpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCt0Qk0KAV8rZO/AEDUWROHRMT/NJR0dV3TJgpD7RMHNAj0nWZjCS1yEyW5JHxC5Pk26Vsw1WWtwREYUItWZBqWaaCp2Yuk30GauGbKfEn40aEhW4Igtmsvjb01sZZj66IiUowngSjEwt5j/ws7aBAh+uh9+6NCqqMSskN6O0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llsJnbYs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaecf9c325so18369135ad.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 21:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772255023; x=1772859823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riNYAikMZikDJOkTEd8N59a4JFCUVwaQB1blSZtd5Jg=;
        b=llsJnbYsDHHedFX7D8AiR6538cl+h1l8xED/JIJcNU2jxwpIdwAy+AW16GTvMVBUqn
         qniz8ZWSnNOpGa1xO5Swg/n+vcUF3ljrh36GBnd3X25mMx71ExCJi4pKy9JtQeeUwnUz
         2iXd2s2Ox0HY47d+4F2dJqNN7DuOktizhfpF7Yl05QjSd3gIiSVdqb0wRFJfFfypM1Zz
         7CK9HdurM9ZLi64Tu26mIPeJ9d4h0W9Am/CophmDIOB5gW9UCa4rI+xcYpkxI8usyjVR
         thhvN3P2xQ3aIH47bLb/1W8FFR289BCJAcVOAlayT2ARFGaiPvrV7W0OAp8q3hcGjGWY
         hRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772255023; x=1772859823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riNYAikMZikDJOkTEd8N59a4JFCUVwaQB1blSZtd5Jg=;
        b=exj8kVAooeRzU5+xt4bsEHJKd/XalTSmuWctgPtOzZyeKVbY8c1DtaQb/b1DADSpe3
         iaIid1kt8EFjIYGyC7NKS0h3Wi5m0RR+j4R5iokXJllZp4dA/vZB79dEL0XYoWdieSEl
         Ylx8r9+dWPyIsd5+G+VrXAIFt3zaGC84IOExRO0wUl0Tiumgy2NSicQG2pUJUYLTlINY
         Wi0MVB85+5xh5qX07olp3uSE8UJAVuP/rcNPwHE3afqJieWYQZP8wKOrvitBtPlLm3hr
         IpZuZJ29/dGLLNO0+sI6geMe5LJ5Z/nhsyIqy8aC2e3Te5ly0m13TfA29tTC1jumfFlg
         Rq3A==
X-Gm-Message-State: AOJu0YwyvSH1aaQcG5qG8SxsN7+kz5xv7ATVPFMOUMNgCoStW6zy5p4L
	k7/SuyyWj4JGO599qxZkh/LonaEvDX0hEbXknrZ+N+6DjXP7gt/KFRAx
X-Gm-Gg: ATEYQzzh8XS/xzQEUxs0l6dQrE4TaRau/u2b+5SyKRI8Ff6k68KYB75LpWQRocoeWPZ
	Leb3E2L/4lmbKmx3jLJ6jVDzKQ2hxtAeEyI935D24UvPUST+wA7+3X1jvSDnqL2YEPSv0Z/Agfe
	L4f568jrw2WYKU8wTz9kI7dOFs0N+Jr6W+Yt0TmximVwILkFOh39BnKhhCN+UhyE+XYE5BK2y82
	WEwuRdOmp74y323TMz6VS4j9yGPAY0t7ADx995hV5oSSyXg+EnMmbpqYGLewZGXYTB+x12gUTuB
	BvG30If84VDjixN2i6Ubk5iiq0Tn6vY0BYez1xp7obmxYScH8MchYoUSnVOp0+O9sEFvV2/D3kO
	+QWtR4bePKbtA+5DSrbdu6jJVP3NAfjkQ5tz5rZd/oVxT0x6JarWJ5wPy20zWwGCVzyuJ50yTTf
	//pRGLrGSn0AULZxNF6KIJVYQ9NblGIVBpQ9a27oIJrKuSIRAYA7lbTGW48xOO3Crk+HeTxeU7F
	7adrQ==
X-Received: by 2002:a17:903:1a03:b0:2aa:e3d1:1430 with SMTP id d9443c01a7336-2ae2bbd72fbmr53761865ad.23.1772255022668;
        Fri, 27 Feb 2026 21:03:42 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:aab1:76d6:d5d9:2ab0? ([2001:ee0:4f0f:b1d0:aab1:76d6:d5d9:2ab0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c51sm4794775ad.19.2026.02.27.21.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 21:03:42 -0800 (PST)
Message-ID: <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
Date: Sat, 28 Feb 2026 12:03:31 +0700
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
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262084-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DDA11C061C
X-Rspamd-Action: no action

Hi Jason,

On 2/28/26 10:49, Jason Xing wrote:
> Hi Bui,
>
> On Fri, Feb 27, 2026 at 11:20 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>> wasting CPU cycles on polling. Users will be notified and they need to
>> make a wakeup call after refilling the ring.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..494acc904b2c 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>          xsk_buffs = rq->xsk_buffs;
>>
>>          num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>> -       if (!num)
>> +       if (!num) {
>> +               if (xsk_uses_need_wakeup(pool)) {
>> +                       xsk_set_rx_need_wakeup(pool);
>> +                       /* Return 0 instead of -ENOMEM so that NAPI is
>> +                        * descheduled.
>> +                        */
>> +                       return 0;
>> +               }
>> +
>>                  return -ENOMEM;
>> +       } else {
>> +               xsk_clear_rx_need_wakeup(pool);
>> +       }
>>
>>          len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>>
>> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>>          return sent;
>>   }
>>
>> -static void xsk_wakeup(struct send_queue *sq)
>> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>>   {
>> -       if (napi_if_scheduled_mark_missed(&sq->napi))
>> +       if (napi_if_scheduled_mark_missed(napi))
>>                  return;
>>
>>          local_bh_disable();
>> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
>> +       virtqueue_napi_schedule(napi, vq);
>>          local_bh_enable();
>>   }
>>
>>   static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>   {
>>          struct virtnet_info *vi = netdev_priv(dev);
>> -       struct send_queue *sq;
>> +       struct napi_struct *napi;
>> +       struct virtqueue *vq;
>>
>>          if (!netif_running(dev))
>>                  return -ENETDOWN;
>> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>          if (qid >= vi->curr_queue_pairs)
>>                  return -EINVAL;
>>
>> -       sq = &vi->sq[qid];
>> +       if (flag == XDP_WAKEUP_TX) {
> Better use &?

Sorry, I don't get your point. Can you elaborate more?

Thanks,
Quang Minh.

