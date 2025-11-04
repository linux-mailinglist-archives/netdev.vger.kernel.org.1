Return-Path: <netdev+bounces-235465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D530C310BC
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86AF334D48A
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAEE2D2387;
	Tue,  4 Nov 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp8b3IW6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VKba1yXw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBD221FB1
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260464; cv=none; b=h2sSG9PNCgULTGAWLEuYKYj2ZjQeTOvjayFv/3mEzN+20tYifquFRqfvjz1Y0iU6fVu8gs/e+vfWZXvOdAM82KwntvIA2pO9YLa/6GO9QpuvKMmvjvWv7ssYf+gnPLPz+rPmF2Hjkxupl2KTBZRwj+5GY5UQ6uPpQGkQTEhPfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260464; c=relaxed/simple;
	bh=g4MzobWCgMAbdFKqXdws3q6G9OR+n0+6vpq9/2gGiYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2KJMqDzIXfKk+cE9gB4mdUWId8nVKzeCN6h84ZXFYmd5PCIScewMFyYFFxwe3DpkpcAsbbHQeA8A7QZSzbcaft2o99+GLvxjtXOawgD5VM0XdUzlJNAeKs8Cox2YfdQCFV5CgrDc5tn6rgzsT6yiDH31iojbtZXpmhsdbtQrGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mp8b3IW6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VKba1yXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762260461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWnifgGT0AcayVvuS2yfUcRlYF71GXMXDqlq2lq5xps=;
	b=Mp8b3IW68dk5F3iMH1X0sj/+wDHG+j01bA5G4NrkktUKG6qQn2NZwGAN/xcZwMXKmSBI8j
	N1Sidb9iXWwDnE3qSiZHBEK+Ire4EDoxSahfoweDBYPb4EupaL2O8RD5UHDB91GzywXur2
	uipVLuvRLEEHWgAN008PEj/C1FjuhfE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-N59fqvcxMl284Ajl0zlZMQ-1; Tue, 04 Nov 2025 07:47:40 -0500
X-MC-Unique: N59fqvcxMl284Ajl0zlZMQ-1
X-Mimecast-MFC-AGG-ID: N59fqvcxMl284Ajl0zlZMQ_1762260459
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-428567f67c5so2678005f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762260459; x=1762865259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWnifgGT0AcayVvuS2yfUcRlYF71GXMXDqlq2lq5xps=;
        b=VKba1yXwSlT1JSdoiZtO6T6xLfIlZxUkWQszQHB/6WwvFY4GG23P2xr6znm/fkx9MT
         szW9fqwrHt29xJLGFCMLXkkd2YN1fl8MRjJcSs8A29qVmLxoFtdwPOoFF3VNGr6xT+Vm
         ffFBnyJTJfSJqqoPqaLVZ6TDOypmdnWu90RHOxvYkShy+9Zc95b4nhxVW+5/RCWebyNw
         QccLTN0DGfhRods6hukqQ0dfJ0IwDsE/u8hvg4KP5AVHHQWkZMNLia7hJ0/p+fBgDJE+
         1jUuJNdhfduVfimFsucqmTnqe3WHa72MUk+LvA32mtpHezOmc08rUnEgvJ8QVQWWw93u
         7/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260459; x=1762865259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWnifgGT0AcayVvuS2yfUcRlYF71GXMXDqlq2lq5xps=;
        b=dbDiWNo9RCLeRYtz3P2FpY9eYMULzolrGkched8ADf/AjmMlmVomsX0zdSd2V0xKgE
         lT0UJXY2Q3PNZm40iAolFx1dd5vIVdwFFgfFDJajhd3BNogrn8AYP03QDz6Zb6RBMwvw
         PaBswMCgYyBNhpbuFQ9E1M4JJ47l66mhTElNaf33PrCGTt7Vus+laBHpqD7sou/Te7JS
         D3dcn0D3rKzrQLeJJOlroo/kHEmj6EvghfrzIw0tlzV1OCD4T2l+6FG2AEPau4t3qo4h
         UTGdG65Zs/YtImmumintM5OiZ9JFVmYpfLNMwlFsSReQjmZlKAuJAJsiAaVDAmoX6PMG
         naRA==
X-Forwarded-Encrypted: i=1; AJvYcCXkv7xLpTMinCUI7u231V7DC7rLWiwztLBucIHURzcrIfr7mUIHq1H56Qu4N7f1IlM4TmbVPLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7r1BXp3VV+kNIXVPS2ajOr+PkN7ASKTJrJi/z0FVYSOQCwJnW
	CWbkCHpBPQ6rK8tsBOsEEf8DGYct4+nP5cjsXqYK5oog1lX+7Zx99x0d9udatj2av8qdE4agsDC
	tLu/B/m3H5kbpM3+DEH5L4J2QF3PORP6/kc8yVGSA6wqlZNl3fSrKvHIdcQ==
X-Gm-Gg: ASbGncuP2dpUQYuoTOskLPYCS/OiFkhwLa+CkTI04+2bxxQlGJiTMw4xIO70sTV50vT
	qYG9Dt0L8cEVlv0BHJCCQCSmh3jYFhT77ebWHK4+ZWMMNmZvklxfnjOBJhVZgsbP9r7NTBoNSxA
	w3UXvrxUNx70y1VQdFqChFvGDhEZLMwWtcNAGnGQBMkFFgwmmbTSdav/6zZJmSIPPoypFt7/C1P
	qPCn/qJLA/ojA+3gHV4hzlT0CRYrPHpnXthGmD/ww9jbt/Xam88CkxUY7U6SUkEeam+8r7RM1ih
	RoAtU2V3nj/mIXooaUXtcekAeuqJPLYSs/l5vc801KZpO7y21k+nu3XzlkUHA6/AVN5WZRrF4Xc
	pKyzU5hZvorYeXIrQfHQkrxdJz7OVcOK4IEisYXL+eh4D
X-Received: by 2002:a05:6000:4b0f:b0:429:c965:afa with SMTP id ffacd0b85a97d-429c9650c2emr9026841f8f.36.1762260459273;
        Tue, 04 Nov 2025 04:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiJ1SiVaPavd71LCb0yruPCRV4eS0waiUfxW8OCw2NKcYZLnottK8w5LOXobrD0/V4oRg99w==
X-Received: by 2002:a05:6000:4b0f:b0:429:c965:afa with SMTP id ffacd0b85a97d-429c9650c2emr9026809f8f.36.1762260458840;
        Tue, 04 Nov 2025 04:47:38 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dbf53e86sm4620311f8f.0.2025.11.04.04.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:47:38 -0800 (PST)
Message-ID: <989d3df8-52cf-41db-bb4c-44950a34ce89@redhat.com>
Date: Tue, 4 Nov 2025 13:47:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 14/15] quic: add frame encoder and decoder
 base
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 quic@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>, Steve Dickson
 <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <56e8d1efe9c7d5db33b0c425bc4c1276a251923d.1761748557.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <56e8d1efe9c7d5db33b0c425bc4c1276a251923d.1761748557.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 3:35 PM, Xin Long wrote:
> +static void quic_frame_free(struct quic_frame *frame)
> +{
> +	struct quic_frame_frag *frag, *next;
> +
> +	if (!frame->type && frame->skb) { /* RX path frame with skb. */

Are RX path frame with !skb expected/possible? such frames will be
'misinterpreted' as TX ones, specifically will do `kfree(frame->data)`
which in turn could be a bad thing.

Possibly add a WARN on such scenario?

/P


