Return-Path: <netdev+bounces-263685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJguIkH2p2mtmwAAu9opvQ
	(envelope-from <netdev+bounces-263685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:07:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0161FD31F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86463302CB11
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45483932F3;
	Wed,  4 Mar 2026 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lcw9Zhac";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mMsY2mdY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF039184D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615230; cv=none; b=d2diQhTrGhGxpMwbeu2ZilSEm7QgMagRhI9PFuz5q4AWlHxkoQeq8IZmuP7mCpaVYggcZVpnW+dEw9XM/63LM5eKH863kGItBdnWaKdJ9SGtFV6lSEHz3cikf6yec2IVCHyIjcOhP4HHku9FRhgLVz+Dlgwa5RvYdU3Pwj4TIfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615230; c=relaxed/simple;
	bh=MenES2bnD3YIFT8HkiuN9URfZnWIKlc//r8AacAz8MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/iyHxfGoue0VtKl5yBwf3RMR7FiYjdpQPmNPIiDo4EdlfUb7ZGDb1/cHLJTrfy9GxaVHYxkvqnPENoDdx39dnORJdur3TEhmQUUP9Yy17WJQxIpQ296IdOMtZ9gc7i8zZ18DIYXHuZcEJWv9wos6gQLdTEnXiOQwDbXQFX300E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lcw9Zhac; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mMsY2mdY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772615228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJ+svJhZviY13V6jetu+2Lop8pt2Tw6oU+fGIcexD3k=;
	b=Lcw9ZhacHRnJ4Mi92ZqnQy6x1eixD8GrUDdJk85td5pcsYoUDeRrVFuWkb2EElflmFGUAP
	hECxvRVxXZ+rG3meDzfegX7FIryeGIfYnLYOGfuQ46qpyRz0CTofsfkC270+sXRUaclYnS
	a29yWGnHY6lc7R7X36BZPwTml6AkXvw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-I7P6hIe3N2CiBHZq_Ms2Jg-1; Wed, 04 Mar 2026 04:07:07 -0500
X-MC-Unique: I7P6hIe3N2CiBHZq_Ms2Jg-1
X-Mimecast-MFC-AGG-ID: I7P6hIe3N2CiBHZq_Ms2Jg_1772615226
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so71783235e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 01:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772615226; x=1773220026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJ+svJhZviY13V6jetu+2Lop8pt2Tw6oU+fGIcexD3k=;
        b=mMsY2mdY1DyLC8jO2QM8WuGFJgPZg4QmlyjbYN47LKzXYBrmr418/HvdSWw+wBxoSj
         m/tlp+hO7hcSS0ochN/SISnJELjFb3Y6abOj1Zo9VgbEhq/xdGBfZEdFykPyupilGYld
         drPjBxq/7pr1IT0EDBV5QLzWPDj4jU+PC6YIZ2+pnPKAj4rbGNQ9VxXrV9GwxBW9qfUa
         SZZAHUTe1yoK6qhMkgzNryTV+5xatsaaaaYKO9bSMX/DG2Zt/lhpzUMk1yuViR8C7Jks
         S8N7E/ij4E3tYy1SUWUEmQPzqhQTaQH+9dKI/wCwc91XSS6/VXCR03iy1O1fshWW4laq
         mlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615226; x=1773220026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ+svJhZviY13V6jetu+2Lop8pt2Tw6oU+fGIcexD3k=;
        b=dY+Mq5jMSLWtUth19p64lL7JPSxJ2B0IL8HtVpOpcvv7ZiHYky/fkzP1pb7qzhpBgd
         luntKrTZzDVPc6qqSLzD8X9nSxWm1rQWgcsv8neXmDQwmRx4UDj6YQXlbQWY0E7it6I5
         D3wd8NCCm/bAiBkhDaPpnePnD+PszPvJIQDJtHN4CzF//vERQ8ysHu5s4BNKjlIjpttJ
         PnsYjENb/+joer3lhzKieQPmloiYO7xOz/peiCbb3S5d/7Ae+/YZZg5j9XdtH8geNQhM
         jO9YdlhNBfNkG1fqioa+FuSmyIhSEb5i/QIZlYNfpLDAt/flJ5VTDoDuxKSnsu8HdSuB
         DIhA==
X-Gm-Message-State: AOJu0YzgSyIRQXhk/o9GfuqHamlJrInS2rnoiEyQ70Sy2clrdwAc6S9N
	910JmlRElJu2dET7NWJDMuKljzgxJcilMSnxbVyNsa6gjhzUcaOuDAnG6p1rtbV1Pga+pnLNbd3
	5DbkXmL9/i+0yYP7QT902/GKxhjmQWi/z1Ry4/xG+jbRGJWPHx83OvPMqJw==
X-Gm-Gg: ATEYQzw50I+eCqC2J8otVOkwJd1ldPnXirgb8kR6Z/DaPOU2/BM4u1ozarT2q2pIucZ
	0Q439jRsReiGRmhiv5G0HMcQuFV86OdbUO3cTIjIFuwNcSc0dSfAckNl5HowFwRGai8HZu64rtU
	x/lLxEpixFoyCzDiUoZtjUxtmTNKGH90b6iLYbo7F8APqiTefqp0tD5+nxhomAWhJDS3M2noQ/J
	2RT/D3FHSisi+54KYMJNJ32+RBpQv4d6Dk2vcCaGJ7qtMmD3YjHIM/351VwnvF4wGK6Nz052IsK
	95Ss3l79oC47+9/saIMtI33ha8h4GabzYif1azaKlMRsA3HSD5M37sQMmK6YMxnJE3rOK/HN8BI
	79pqEjO43kfF1U9nL8QsGoZJp1w==
X-Received: by 2002:a05:600c:608c:b0:483:bcff:7948 with SMTP id 5b1f17b1804b1-48519847972mr20302075e9.10.1772615225923;
        Wed, 04 Mar 2026 01:07:05 -0800 (PST)
X-Received: by 2002:a05:600c:608c:b0:483:bcff:7948 with SMTP id 5b1f17b1804b1-48519847972mr20301505e9.10.1772615225458;
        Wed, 04 Mar 2026 01:07:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851aceb94dsm6878875e9.4.2026.03.04.01.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:07:04 -0800 (PST)
Message-ID: <64132462-e640-4ea6-82e8-48ca07a6ad44@redhat.com>
Date: Wed, 4 Mar 2026 10:07:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
To: Li Xiasong <lixiasong1@huawei.com>, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, weiyongjun1@huawei.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20260302052651.1466983-1-lixiasong1@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302052651.1466983-1-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2E0161FD31F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-263685-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/2/26 6:26 AM, Li Xiasong wrote:
> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  
>  		pr_debug("block timeout %ld\n", timeo);
>  		mptcp_cleanup_rbuf(msk, copied);
> -		err = sk_wait_data(sk, &timeo, NULL);
> +		err = sk_wait_data(sk, &timeo, last);

Isn't
		err = sk_wait_data(sk, &timeo,  skb_peek_tail(&sk->sk_receive_queue));

Enough?

Also, could you please add a paired tests-case? Thanks!

Paolo


