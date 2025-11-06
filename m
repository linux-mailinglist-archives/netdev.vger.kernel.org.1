Return-Path: <netdev+bounces-236321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3EC3ADEF
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 13:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDFC6425289
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731A9320CB3;
	Thu,  6 Nov 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Km1ICHqM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNJfxlhp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D12D9ED9
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762431465; cv=none; b=Iz/dD2X5X2jQj50NIDQ5umf/6oUJGNsqan3dm6+TWLqjDFhzJxGg1KJDin6mtlCpdHstzxi1qskftwl+3dTnUV5t0wVq0Z66Dv3of0iIRkfSFLahwIWIT2PMbDi1UrcU1Ny/RglFtcv4JsY3JN+6loPZMvYcudeurQ7PQFofOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762431465; c=relaxed/simple;
	bh=9LV353o44e7iaytKxoKO3m56wFwJYwJhc6jN9BswQpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pwA4VdnCQU2Pk/YW7DEo/uX4x/Dl5+tT+/fRBffozUEArdqac+uwtg2v2Am50JAZdYk1CVhu32vMSJe3d4bedJDJM8i49E+bxtf0n2/CfLdV4z0kJJj08VKB2+HN6b616M5Ni/buDbnl1408imXK4H1qmvZLgv46hWDSI2h9xEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Km1ICHqM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNJfxlhp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762431462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJOFsQmt4z32StWI73+K+fCNACFUE/4kjllWzy5Yuds=;
	b=Km1ICHqMq3xin53ItIWtUFhJ57OHDV1zDdgZscF8NJY9yN40vZjMgJtaHbUuqGLepGAaKA
	lUY0Lk4Lr7fTA021zAX7F7eUiXatinyjkLbygAozs4e/sVbeuKiZip9Iu/rG5ijqTdFDc4
	zGqJSQQLW4gYPM4cyDGYAu6fgkqjLMU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-onp14N6kMuKRJ0lAkZb9qg-1; Thu, 06 Nov 2025 07:17:41 -0500
X-MC-Unique: onp14N6kMuKRJ0lAkZb9qg-1
X-Mimecast-MFC-AGG-ID: onp14N6kMuKRJ0lAkZb9qg_1762431460
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775e54a70aso8629825e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 04:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762431460; x=1763036260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJOFsQmt4z32StWI73+K+fCNACFUE/4kjllWzy5Yuds=;
        b=eNJfxlhpb0EtmNe4zpHP4H+ssnYCTOxUxUbU26NKQVuag87NkWcpY94Docy9z1GEJ7
         DDIbEuab3l+8e+EhFt4wwYjOBlTYobHeMtKPRRzrqSUnzjK9gbyAOVYq0IChSAiR2zHU
         tQ+V/8YpvXmhiGpbM7kruWmRFxBTIuKqnWZ19D8NWwVuSieLhA1BOLwZEG3HtLrXcVgm
         eFD3cDtTYHEXQVI4pFT/NZbjebs4hCfs3K31r3P/ZXufnDZhtZtiPbiJAzhpWJ2vRB1/
         2djJEqci5M3DGEJg6e+PVFlof00Pck2WSEIFVemog8DopKHFc/qxUKMEG/YLBq1fJAGu
         yLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762431460; x=1763036260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJOFsQmt4z32StWI73+K+fCNACFUE/4kjllWzy5Yuds=;
        b=eXDy2QpvrkyqYlGdpZmXJVmAvDIGt5hG0wC1NOn6fpboeIjrtBOR8lFu3hHvrMHYpO
         KMx5WeCEHw1NnqO5Kk3S7ska9Zhj3ScVqJZnghy+5pO1FqG/uUUE4oMQOciIp9eXoxcg
         oij99/jVvaiMCZrktsL403SiAa63nEah3Ba+YNdRKKTkNGhMuAXyXIxle5g5Uwj8Z+40
         DI6TOCo5W/JrsoqiskCg2NJaLh0eBA+RVtbtSNnhcfmk9h5I0G+prKkVYEMEGCUZP4OU
         9XsimrDXkKZLQ+OS4wrSf/dcjCuXVMY2viMIdVbBuyDHNk8euSSb21nz7UmGwP5I0f7M
         KBaw==
X-Forwarded-Encrypted: i=1; AJvYcCV6XhMh6Y/lZI9BwzhRJKcgbuCo4YFFvi8EZ5AvruOp0XBFUWmjcuh4wuRR9R9oApwpUIFqOmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFkuHotx1WVMtUBCXYUZZ4ShCOqqbFVMh+TF16G3wUxKlRa10a
	Wrku1fjcVtekM6DXoE55tiQoWzE3NDUXCtHsTBikJ/Bfd2jxg3HaQCdGwbaVr3YyaQ2gbhjff8n
	dVLEe7a8Liw9dNbSZTqK9u2c+cPYJkkSS2MrA9uR417jxDjKfU+zJscaceA==
X-Gm-Gg: ASbGncssx2uYJdwEqyExY/LCC6PwUwQUIvfw9eg9lQj8u48HT7w/eZwmXoDm6QO+T1+
	yr5vT5V3OLxHUGIRlnzIusb4Dryq/Mj/wtqWAsixKb9WdD6JKfw4zFe/s3ftfa/5MLB/0ZjjNB5
	uNyvrVQ/qN87QhAG1WJM7838hyLlCp51z2JmzlYK3i4y6hp2Guu6ZBJoJiPLmeKidEKBYkEpjWT
	lDGbmHl3hDKM1MfooF00MUZkdM+7dBtXThXIKuBTF+6Q2EWKjsn616cvShrNwB6AWidBd0RmaCO
	ie6eGIONx9REB+/+wmTfiydnF4r/fa3aNhJnVYgU2VPQElE4+49Wg+glcyhIl3onaxElIXPulLu
	s/A==
X-Received: by 2002:a05:600c:4ed4:b0:477:3012:d285 with SMTP id 5b1f17b1804b1-4775cdacf5amr60826955e9.3.1762431460434;
        Thu, 06 Nov 2025 04:17:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPlniGNFV9Ibj9f6xLOEXX+53/yBS8AakakQvea5myq2HDP+liFvl4AiG9oo5p7c3OOkui0Q==
X-Received: by 2002:a05:600c:4ed4:b0:477:3012:d285 with SMTP id 5b1f17b1804b1-4775cdacf5amr60826455e9.3.1762431459953;
        Thu, 06 Nov 2025 04:17:39 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477626eb4fdsm44212655e9.17.2025.11.06.04.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 04:17:39 -0800 (PST)
Message-ID: <f88dac3b-3467-44cf-9725-7d8525615bda@redhat.com>
Date: Thu, 6 Nov 2025 13:17:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 11/14] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -4006,7 +4008,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
>  	memset(th, 0, sizeof(struct tcphdr));
>  	th->syn = 1;
>  	th->ack = 1;
> -	tcp_ecn_make_synack(req, th);
> +	tcp_ecn_make_synack((struct sock *)sk, req, th);
>  	th->source = htons(ireq->ir_num);
>  	th->dest = ireq->ir_rmt_port;
>  	skb->mark = ireq->ir_mark;

Whoops, I missed the const cast in the previous revisions. This could
make the code generated by the compiler for the caller incorrect -
assuming the changed field is actually constant.

I don't have a good idea on how to address this. Changing the argument
type for the whole call chain looks like a no go.

/P


