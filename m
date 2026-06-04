Return-Path: <netdev+bounces-295094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id plZ8FdM2IWraBAEAu9opvQ
	(envelope-from <netdev+bounces-295094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91A63DFC2
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:26:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CV2tCiOL;
	dkim=pass header.d=redhat.com header.s=google header.b=rz+DwbAC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295094-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295094-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B19003011C4E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD13DE43C;
	Thu,  4 Jun 2026 08:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648373DDDA5
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:19:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561165; cv=none; b=GxnJ7Vqtbny7tiFka2HtJc5FPMOxTqhZz3M+cQ+9ZMqW5BiGeziMvOt4Xm+78tYIe16LM66Iy4+Nnp5N1Gl7rWJpYyAxfyoR2CDNBKTn35fqcvB1hmwMi/TESfygCIa6qBmAGr0x6HIn7YHXLDeYmTKnUiVAGqzJG6BR45vOu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561165; c=relaxed/simple;
	bh=r/1JZU+p1JTnijcgW9lGSXp3cQDS4Nl8dLA1OtHelPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0VHc1IKjQCYLmuMQz2LbvRj8+dV85wocL57fZhW70BjAE3UHPMHraN/jBUBJkvJdJQpusSmbhRbrshtK/q1qyGHjCjVMIw8aCNkAsANISoOXudpiHQYKDkmA0RubuuqJO84OWUEjErvAVqgiHVxgcpCsu5PflqTzU65NsHw7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CV2tCiOL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rz+DwbAC; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780561163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/xg/NprpFFa1S1OuVvOXsTg8NUTOjkhpfmdrUxTz2Q=;
	b=CV2tCiOLc03oHoR0PNz9uyhr+48MyU3etnGzhLJ0j2C1ZLFh05tdebTXWANTBNVp5k2Tn+
	3GNbhgyPola7sRuklj8RzS4Xh+R2XK02bWAGWYcXagQV/olPEYJexTxqtbvj8Zv12T7ooD
	OchXiopKUWc1Yoy7ZvXdDlpovl4v1m4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-zTbYE2iWP9GXKc5sbdH1ow-1; Thu, 04 Jun 2026 04:19:22 -0400
X-MC-Unique: zTbYE2iWP9GXKc5sbdH1ow-1
X-Mimecast-MFC-AGG-ID: zTbYE2iWP9GXKc5sbdH1ow_1780561161
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso254883f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780561161; x=1781165961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/xg/NprpFFa1S1OuVvOXsTg8NUTOjkhpfmdrUxTz2Q=;
        b=rz+DwbAClZP9UJcZo/TS+NgUejj2nx9sf5xBpBjD9/klnJkE/qp/DTh5bbopm2fxwD
         ijtFseLbS3jXYRB42bm9vsLr0mFLu+HCmHR1Fi+8NzeRm+HJOywEzbmsh7/IBieKsGV9
         D1Pz0Iu07qkQXk7gKc9Y/TuH/EB8zvZ0l0TkLgShVQVaqcsxoDLr1JMqUYbQdvo1Mp4r
         habhCagaQptu04uazOiRiAVuItXs8LFVPebEeOoet3yTK51XWS3vvg6LrWSmyj08JNz2
         GldkVQCpy5UH/XdcemydLi18ktIcVYrFdp8bj+hI/IgjC2E/3kfh2e/JaBVFakVCHVba
         GscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780561161; x=1781165961;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/xg/NprpFFa1S1OuVvOXsTg8NUTOjkhpfmdrUxTz2Q=;
        b=Vpzy0jqcGTaQXToZAqPt2ydpPXtDYODwTWU+xfdzRs66SUe+ngvDak8ufQ9hnns9u3
         tx3kYDoWw5d/2GDlQGHZix9HOTS8a/8lINmCEyNOfdKF3I73OQdNAKQS5uB7cCs0JgNl
         zNmre8F5AXqP+A/+ZyOXJ0aFI9EFuHPIjtaa4YAfscjfO94WlX7sxxoDffMDpoGb3/BK
         exqoODtGmbgWRlg4BtA81POLfz4n1t2V5KfLsqOez2MUgErApKQRB9StDYihCJUpWUis
         T5aSEA/R7gqhY1onKcWTcaYe5WSYQMeHebNfacJb0f0wgRu0p5h7yXPqL+U+GZLj025q
         /1Fw==
X-Forwarded-Encrypted: i=1; AFNElJ/GF3pB4gdOoGtUFHSljhyuJN44m7cc+aVSGJWWpEZ9gGa4VM7htxDK+0lt6puFQ/yIU+x6Prw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl0oKd5+z+It+PrEHDftd3aciSah94ksGNX3b9/QItgaCqIjX2
	7pyOXjEdBFt4bneZknnctyiEJHFk1owTznHgcYwgCVtDKHbv+k5Xsl9ok4T4UiDSNq8RaK/Dq4x
	F3jxT3psM0sVoWy0HUHQdEXTunIroOdMqQqlczO1JTToQzOmDbYwcjT+2VA==
X-Gm-Gg: Acq92OGH1Eh0sqPiuGsJ+VwdTTog93BVtHVuiUDqHVHkwXQVh7znmibQV/0YxoJOaH4
	LWgF00i/BPy+e1SUSF9aGw/t2TBYh0bYAFTIjt7lUnoA2qCvE4gs/APyn8GndhAfwsuYT7ClpV8
	EAJkG9O3G8GqKILSOT44fJArs9iAdDwZmqhIZGjO1ujIfML+dZVSfdjLBdRdjE+7PC+Cv1CXAiF
	IHWBI3bDMLYVL+M2lAf3/nYStEBfU1w1BMsaCyjpZdPZDJWefPIPN7Sn6NRuyDbLHVf6HHAMd3Y
	3YdpdAI7X7OvCBe97YoWbfkTVeUVRP2eH5wVl7M1UIkENGnrXNtC7V6lG8Ujp7oRCw0S+6QqarV
	5osUk7ZGhg/gWAcbwEJ/+ivgMHfqI1qkVcJsuLERyDVZWWfbIyG4oqil//GHfqwsQyQk=
X-Received: by 2002:a5d:6447:0:b0:460:1f34:cf80 with SMTP id ffacd0b85a97d-4602183b991mr7634979f8f.18.1780561160794;
        Thu, 04 Jun 2026 01:19:20 -0700 (PDT)
X-Received: by 2002:a5d:6447:0:b0:460:1f34:cf80 with SMTP id ffacd0b85a97d-4602183b991mr7634948f8f.18.1780561160348;
        Thu, 04 Jun 2026 01:19:20 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm14133428f8f.3.2026.06.04.01.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 01:19:19 -0700 (PDT)
Message-ID: <a7d86867-3c2b-4fbb-902b-61c4e2a561bc@redhat.com>
Date: Thu, 4 Jun 2026 10:19:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] veth: implement Byte Queue Limits (BQL)
 for latency reduction
To: hawk@kernel.org, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260527135418.1166665-1-hawk@kernel.org>
 <20260527135418.1166665-3-hawk@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527135418.1166665-3-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-295094-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hawk@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C91A63DFC2

On 5/27/26 3:54 PM, hawk@kernel.org wrote:
> @@ -348,10 +381,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>  	struct veth_rq *rq = NULL;
> -	struct netdev_queue *txq;
> +	struct netdev_queue *txq = NULL;

Minor nit: please fix the variables declaration order above.

> @@ -1092,6 +1137,24 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
>  		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
>  	}
>  
> +	/* Reset BQL and wake stopped peer txqs.  A concurrent veth_xmit()
> +	 * may have set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
> +	 * synchronize_net(), and NAPI can no longer clear it.
> +	 * Only wake when the device is still up.
> +	 */
> +	peer = rtnl_dereference(priv->peer);
> +	if (peer) {
> +		int peer_end = min_t(int, end, peer->real_num_tx_queues);

Sashiko noted you may need to additionally complete/reset the tx queue
in the <old_real_num_tx_queues> .. <new_real_num_tx_queue> range, and I
think it's right.

/P


