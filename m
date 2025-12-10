Return-Path: <netdev+bounces-244265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0C3CB3549
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00EA31B7224
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF231283A;
	Wed, 10 Dec 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFZpAmJs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC524BBFD
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380811; cv=none; b=uWUOLi90tN6xCtFQUcWhMDTuLSA+MdQA+NNBhzeTt/EyvZZGh+g1ZD4cH5h875Y9uZk6xZEwi+U8SLF9HawoKcs5DVTHIMiQc+haStAIL4LmfRCCmchgEnEwS42ospb9GUekgPXuZx5zjlkzCkq9Nk+iCr4bYv6thBS1VfmWB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380811; c=relaxed/simple;
	bh=Yx19Cw7PrTxmK2aj7a0su0iOLHk3ekoOT2KchGcwVTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2iF7vAP+7FwOA4lkJ1JF2vHHv2jFUKaiK1TrMeFzlZSFzFZoOS7gDakK5wS9sVsuNGpRQ8YbDqwRxY0QKyVUTWGx3BsIC7nMzpmHnvGtJcA/jUrNRXgdtzolh+A7orVuAeK48PsRD6OS6yXFl7+5L5SOkzSjcmCE+f0JKNekiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFZpAmJs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2956d816c10so80594415ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765380809; x=1765985609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESuYFpOjYXjLgX7Fp3qymkbq56ElvjhTl63RkbJTEwg=;
        b=XFZpAmJsPEa56/oA8pVgOCGNUOIO4vYGxnUAReDHHmZ+vH8rYPw6VSR09bSvWz9qYA
         TYMpm+sZeK9GTJcA5/UBLCsZLFjerwBBiIGyOgpr6Oj+8vPIk94UUEpjOUhPWiMRWPko
         5IPw8Dr+Xl/RSglyT/JedufffG4CUogff1+pj58Fve+Loo/2EYvK/J2/SYPOWKm9T3gE
         kouG8XyWKIpOnAn+lu3u269F2Dadd19fYhAKMPcBgx1eAP9hVoEC63Su/VqE+GGmN456
         h++4qYsE6PFnHwoboxDsReWGayOoQ9CVv9Lr9zYh2kcov/2pyEVj5yjrEn/C30u3ZxIv
         aXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380809; x=1765985609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESuYFpOjYXjLgX7Fp3qymkbq56ElvjhTl63RkbJTEwg=;
        b=NHXf20Ko/ffbcCd0nyeHf2eAAQzVHksndHJJ/cnuV70YegVi7q8Bk0I0zjaUAt6FZ8
         EpSPqHqOB+AENMmAuR+LE04AF1ubfIuZPQif7TriWXNigqa14yvo3NB9h+CyK9Ga7x00
         K0sQaq52YBPr+PSgNrtt/tQnpuuC9f1pXCKeR6kUWTXVYnV8+zPDq4n/G6qJB/QYaGo/
         QhmRhLAQhlRaR/DdV6avMNM/imAjFcGqT788g1qV0n2lW8ARiUoEnjg0ZOvrDJh5QIgK
         I9fvcOXwCpEh+aJnfwOq7GPsDB/aICbWSbmVqSypHUU6BccW5SC8AsxUYLqjHiAwCTMi
         d/6g==
X-Gm-Message-State: AOJu0Yyrts4Oq+Fvzj5ITsRRka9Omn6ZIec9FDPrYxPVBkkNMp6dLpmP
	S5iv+nH0jOktudoTZCj6ULpW1KkpeKEbfmW2hXsrV0f0lTuZIP3/J4qy
X-Gm-Gg: AY/fxX6UCv5BylE4eq1twk3bHmmG6vsA0xz2N0LhqeEK8F+mVqevIyKAp674ZruQPky
	66IVMLdn8bYaSv+EeL0evwUN4Fn59JW8LjPlAKN8p1Erwn8H7V03fv7KeqVCMR8XKVBZB0oGqmc
	VfWNlySpAJTmvxstm+oZ29xcinADBZxSq98EHkozyv8PWJgQA5q3K2Z9TDwQ+xHmtGUy1UPHCV+
	DpDG4ag/i8nRX6Zf1QYcuTL5ewev1BYrZs1cxPq6CrOHAFWImPBxDVs0dovdxNC4TqfFUP8Zvur
	wYcLSijdD/fixl5JohahYCVBZkw5U0unE3bXhqCJN7N5lOx3YhIuSRGpKyM7aKh4c/uqaTeNics
	DvRSIS7t/gW2cVAGp6alOFkNwFJJ+Odetj4gPCyaWr8PA/cxw3F/cOV4aljQlMNvVco0H0wcs/V
	HOSvJRIyZ01L5frLiPjbSmCSUzfN/jW+v3n1XcIF5aceW+ftRp3j3Ws04tTWz0jA==
X-Google-Smtp-Source: AGHT+IENrwT2Am+P2vjlTDz+KYOoqnBVC//oOg414tv75XRJNnToBhPmNfWibuLCCf4uNogdSV+RXQ==
X-Received: by 2002:a17:903:2ac7:b0:298:2e7a:3c47 with SMTP id d9443c01a7336-29ec27be899mr30223795ad.42.1765380808606;
        Wed, 10 Dec 2025 07:33:28 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:311c:669b:9c36:4a99? ([2001:ee0:4f4c:210:311c:669b:9c36:4a99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49b196sm191451135ad.17.2025.12.10.07.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 07:33:28 -0800 (PST)
Message-ID: <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com>
Date: Wed, 10 Dec 2025 22:33:17 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
 <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com>
 <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/25 12:45, Jason Wang wrote:
> On Tue, Dec 9, 2025 at 11:23 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 12/9/25 11:30, Jason Wang wrote:
>>> On Mon, Dec 8, 2025 at 11:35 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> Calling napi_disable() on an already disabled napi can cause the
>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>>>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>>>> work too early before enabling all the receive queue napis.
>>>>
>>>> The deadlock can be reproduced by running
>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>>>> device and inserting a cond_resched() inside the for loop in
>>>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>>>> processing the delayed refilled work runs on the same CPU as
>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>>>> In real scenario, the contention on netdev_lock can cause the
>>>> reschedule.
>>>>
>>>> This fixes the deadlock by ensuring all receive queue's napis are
>>>> enabled before we enable the delayed refill work in
>>>> virtnet_rx_resume_all() and virtnet_open().
>>>>
>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>>>>    1 file changed, 28 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 8e04adb57f52..f2b1ea65767d 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>>>>           return err != -ENOMEM;
>>>>    }
>>>>
>>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
>>>> +{
>>>> +       bool schedule_refill = false;
>>>> +       int i;
>>>> +
>>>> +       enable_delayed_refill(vi);
>>> This seems to be still racy?
>>>
>>> For example, in virtnet_open() we had:
>>>
>>> static int virtnet_open(struct net_device *dev)
>>> {
>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>           int i, err;
>>>
>>>           for (i = 0; i < vi->max_queue_pairs; i++) {
>>>                   err = virtnet_enable_queue_pair(vi, i);
>>>                   if (err < 0)
>>>                           goto err_enable_qp;
>>>           }
>>>
>>>           virtnet_rx_refill_all(vi);
>>>
>>> So NAPI and refill work is enabled in this case, so the refill work
>>> could be scheduled and run at the same time?
>> Yes, that's what we expect. We must ensure that refill work is scheduled
>> only when all NAPIs are enabled. The deadlock happens when refill work
>> is scheduled but there are still disabled RX NAPIs.
> Just to make sure we are on the same page, I meant, after refill work
> is enabled, rq0 is NAPI is enabled, in this case the refill work could
> be triggered by the rq0's NAPI so we may end up in the refill work
> that it tries to disable rq1's NAPI while holding the netdev lock.

I don't quite get your point. The current deadlock scenario is this

virtnet_rx_resume_all
napi_enable(rq0) (the rq1 napi is still disabled)
enable_refill_work

refill_work
napi_disable(rq0) -> still okay
napi_enable(rq0) -> still okay
napi_disable(rq1)
-> hold netdev_lock
     -> stuck inside the while loop in napi_disable_locked
             while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
                 usleep_range(20, 200);
                 val = READ_ONCE(n->state);
             }


napi_enable(rq1)
-> stuck while trying to acquire the netdev_lock

The problem is that we must not call napi_disable() on an already 
disabled NAPI (rq1's NAPI in the example).

In the new virtnet_open

static int virtnet_open(struct net_device *dev)
{
          struct virtnet_info *vi = netdev_priv(dev);
          int i, err;

          // Note that at this point, refill work is still disabled, vi->refill_enabled == false,
          // so even if virtnet_receive is called, the refill_work will not be scheduled.
          for (i = 0; i < vi->max_queue_pairs; i++) {
                  err = virtnet_enable_queue_pair(vi, i);
                  if (err < 0)
                          goto err_enable_qp;
          }

          // Here all RX NAPIs are enabled so it's safe to enable refill work again
          virtnet_rx_refill_all(vi);


Thanks,
Quang Minh.


