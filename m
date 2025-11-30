Return-Path: <netdev+bounces-242846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A6C9556D
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 23:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B507E4E024B
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEA2417F0;
	Sun, 30 Nov 2025 22:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858ED1EF091
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 22:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764541905; cv=none; b=cZyhqg3flsfkODWD07Kdibe2cd3c4H3ueNlN8sSSqkoUnb8T1eZVdCq8juYem5dWkVD5eOukGFgqIs5ywyS1Q0IK+9ICRJrzcx9hLjfMDiTTSMF7J2kqGf6JGfX7qlFvzh5Oz8/bdeOF9+CeNjNe9s4xG7MrSq+eweYJP3FngbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764541905; c=relaxed/simple;
	bh=6+4uZImWSiMTBq4+/nhPhZXP1PQJeW9bCnVdfcHjOzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv/sME0cGRfY2kOsyKuG2uKqItRzko5PapYD43z1fCK8GqwWlXPt7fnSM+uRe8+oHRiaR/F/WIc22EoDyRl0PTNvscQttRE4jF6EyNabZc6I2eGyWF0JXOFphH1w/jPgDxNhlyqKRapmJ+9YmsDf/t+t7QIdlwH7VtoHBbK02dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso18515245e9.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 14:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764541901; x=1765146701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcQPpGxPe5sL+9Hgs4hRWML4oh/qUbrpFwVuPEgD/H8=;
        b=hgWzSwLf3Hxw7zECo5rlbidFEO1aha7xP+ObajWE8WTH7glOv4pKvaryHzGKX6Tyh8
         5z6/JjxJSbccsnZRyIsa1lXP2y+J7hc1PAK78PIT/DZC5vsNJQ7IgTZ4A2ajbaU9cUT8
         9TzqFd9wMiT6tXZ40+/s/3s0p9zN9ZgaIFMtsmiKPQfNKR0HhQNu7XAmBFi5U3Mibo21
         ViITPCRFyXWY6BZQKW1QhyCkUfEgcMBH+uyLMjdwvfQ+q4Sf/KMDMM7X8H6+TEBWBSiD
         U0hFHmG2Bi8g3keIZ7JxYSu5lo/nMBXZedHTxvvgfSUVZW9nUyW+g2d0LtaVrOqUH3u5
         A4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB8Eg63Nwl7+0i5YnuDyoCF78hknKfafYWPMZeORoNote4VKL4B/H9So5i2svA8vteHAPEvXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC11DIPZd9qOS+Bm+mIR6TdegeoYu7BbdxKTN0XkIzArOCIrO2
	gQkBfU4A7frZKw+pN3kd8+J9iHz/UkC/e4FWkEX7HZYf8NvUWVpj4/3w
X-Gm-Gg: ASbGnctgyXVOAzdq5J2av9LLx2QKxxOZbkIjigsQktTzQM/cnex9wQJxyKxqu9i3Mxh
	5/RieB1JMNCpJsrXEDVTKwqmvTqq1v7DSjK5s8rjk1gsP0y1NT83w2fWqa73RIqtERb8yBFftEr
	akcB9p8olYXjsizKbE7dyPyaKJvnauAFa3IIVwnkuHm0oSTHfmHI4q1CAy0+Z7StxP7hPMTPd9y
	54reeEALf6akhk7RkpS2lESRreXmGZUaAMzFll3IuiPn5RU9zjO6UMZF3lEEqy8vSlCOnBicr2t
	U5wIs/DBVi4BcMXjv1f4G0khhmbazMScSIwFqIKHFbV0H3S2W/+zIZvTbHUEPlBJIfblfCNCkQX
	fV94pV1gVjAnUTN22+eBkgn7nUSdArbFhBnsQIjgHQIi4tudIwmdZ0d8NlyTQ59vzys+YM4cX9O
	m+a16ihPYxbw8Q3QJcnUYKdcQ1qmH40xbBKuImxEGq
X-Google-Smtp-Source: AGHT+IE06nECDAq+Uk5QtE1+56tfrJDdijXtZ3fW9Zv+27AAc3S+rK/IWGF+IFYLl0pdMZ3C0cSJQA==
X-Received: by 2002:a05:600c:1f0f:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-477c1132bf2mr354572535e9.30.1764541900754;
        Sun, 30 Nov 2025 14:31:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791163e36csm198706755e9.9.2025.11.30.14.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:31:40 -0800 (PST)
Message-ID: <1184961b-5488-4150-b647-29ed363e2276@grimberg.me>
Date: Mon, 1 Dec 2025 00:31:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
 hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251112042720.3695972-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/11/2025 6:27, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event as described in RFC8446
> https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
>
> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
>
> This patch allows us to handle the NVMe target sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

I see this is on top of Hannes recvmsg patch. Worth noting in the patch 
here at least.

> v5:
>   - Cleanup code flow
>   - Check for MSG_CTRUNC in the msg_flags return from recvmsg
>     and use that to determine if it's a control message
> v4:
>   - Remove all support for initiating KeyUpdate
>   - Don't call cancel_work() when updating keys
> v3:
>   - Don't cancel existing handshake requests
> v2:
>   - Don't change the state
>   - Use a helper function for KeyUpdates
>   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>   - Remove command message using recvmsg
>
>   drivers/nvme/host/tcp.c | 85 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 70 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4797a4532b0d..5cec5a974bbf 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		handshake_session_id;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
>   static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   {
>   	char *pdu = queue->pdu;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   	struct msghdr msg = {
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
>   		.msg_flags = MSG_DONTWAIT,
>   	};
>   	struct kvec iov = {
> @@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   	if (ret <= 0)
>   		return ret;
>   
> +	hdr = queue->pdu;
> +	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
> +		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> +		return 1;
> +	}
> +
>   	queue->pdu_remaining -= ret;
>   	queue->pdu_offset += ret;
>   	if (queue->pdu_remaining)
>   		return 0;
>   
> -	hdr = queue->pdu;
>   	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
>   		if (!nvme_tcp_recv_pdu_supported(hdr->type))
>   			goto unsupported_pdu;
> @@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   	struct request *rq =
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   
>   	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
>   		return 0;
> @@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   
>   		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>   		if (ret < 0) {
> -			dev_err(queue->ctrl->ctrl.device,
> -				"queue %d failed to receive request %#x data",
> -				nvme_tcp_queue_id(queue), rq->tag);
> -			return ret;
> +			/* If MSG_CTRUNC is set, it's a control message,
> +			 * so let's read the control message.
> +			 */
> +			if (msg.msg_flags & MSG_CTRUNC) {
> +				memset(&msg, 0, sizeof(msg));
> +				msg.msg_flags = MSG_DONTWAIT;
> +				msg.msg_control = cbuf;
> +				msg.msg_controllen = sizeof(cbuf);
> +
> +				ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> +			}
> +
> +			if (ret < 0) {
> +				dev_dbg(queue->ctrl->ctrl.device,
> +					"queue %d failed to receive request %#x data, %d",
> +					nvme_tcp_queue_id(queue), rq->tag, ret);
> +				return ret;
> +			}
> +
> +			return 0;
>   		}
>   		if (queue->data_digest)
>   			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
> @@ -1384,15 +1410,39 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>   		}
>   	} while (result >= 0);
>   
> -	if (result < 0 && result != -EAGAIN) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"receive failed:  %d\n", result);
> -		queue->rd_enabled = false;
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> -	} else if (result == -EAGAIN)
> -		result = 0;
> +	if (result < 0) {
> +		if (result != -EKEYEXPIRED && result != -EAGAIN) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"receive failed:  %d\n", result);
> +			queue->rd_enabled = false;
> +			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		}
> +		return result;
> +	}
> +
> +	queue->nr_cqe = nr_cqe;
> +	return nr_cqe;
> +}
> +
> +static void update_tls_keys(struct nvme_tcp_queue *queue)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +
> +	dev_dbg(queue->ctrl->ctrl.device,
> +		"updating key for queue %d\n", qid);
>   
> -	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
> +	flush_work(&(queue->ctrl->ctrl).async_event_work);
> +
> +	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> +				 queue, queue->ctrl->ctrl.tls_pskid,
> +				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);

No need to quiesce the queue or anything like that? everything continues 
as usual?
Why are you flushing async_event_work?

