Return-Path: <netdev+bounces-206715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FF3B0428B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3666C167E1B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BB23D280;
	Mon, 14 Jul 2025 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKSESQ8A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD172459E3
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505420; cv=none; b=Vxjmwoiur3ghUEjz+xLpUVe9lhLn//WMuIjPTO4Lx0BHhNS0AoxBFGwQuAoEhk5Bwk7XRwJlrWS1S8yEKMjjjVYsED/hivrQg3ZQrR5+JlaA3873MFwx2ieYpPVAoYReCWL9kg26stAFhb/hgkjj+zzTXm0EEIz60VLtO0Y9ZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505420; c=relaxed/simple;
	bh=HgEdt27/fadF/UDelzRUDfGMNwFhsLgZIGfeu1efcvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tO9SkbR4vHhPTH6wMHQcFNC0/wD9JBNY2km2ni7kNYmDNTZjRlZARBlKGTaF5XTFcyDLkVaN8bELsbPiR/CiwXH/eo18Xeaj3A1SpME2alOpkrDsR/CH4T40IiN1SrhR9dcDfvVs/AxwVJ0lmN/Z+9x8EqWqivy2gN9brcyj3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKSESQ8A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CHjUCxwTYZsQwTU8Zui9gNjcOnUwNl2oic1dvzZPsoo=;
	b=FKSESQ8AJIcNf3DbO3poAH4NW3ZP3lZpM+CAS4ffDH2yvL4mJxkNiSBbtW670dLBaJyq4z
	Jav1oiuv0ueZp/HPYksrNudVjrvG0GjKmGEXiKYbKiQC1wWUTb6ToDFDOq4IphlhSrGw84
	Sr+PLSfDHEXCXMcmZXmQMSw+0T2RDpQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-izXSsyWoO3iie5nk1rwdOA-1; Mon, 14 Jul 2025 11:03:35 -0400
X-MC-Unique: izXSsyWoO3iie5nk1rwdOA-1
X-Mimecast-MFC-AGG-ID: izXSsyWoO3iie5nk1rwdOA_1752505413
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-455f79a2a16so22116655e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 08:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505413; x=1753110213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHjUCxwTYZsQwTU8Zui9gNjcOnUwNl2oic1dvzZPsoo=;
        b=RA244GzjyWUdVebypfaeiD9mZpfRPbC45ZlpWjhUvEWj24Zz8+VUE+e1GA/nWEMXlN
         +QGNX2lXebbMJZcfVjegrmcouJjMPhvidA3Tjy/mJtWgqSX3vyWNeLrtBH5uDlf5cFd3
         bKNC4OHWk2NstcrNWj7UcmkNVSNXbWP3ZBmPUVLJZjtg1bl/okFApx478Of4CeyXFqjn
         kjuLGCI5c4Lob2H5IdTFGxIokuB4TY8ha4sU8vbd+9qzY+5miGzXopvCNaowG+DOOO2U
         L9fseEn8T51iYUYiqEhK/odr/2hwFZ82KtXaUuuUroVmBx515Gg8fY3tqx+k36HKYitL
         2LSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUXqHYis9IfWwRh7/+oFWPIzsBE5Nfdxm7XRZ4gy4SwQHAuszxTJ296ubS+8LJiZ5yQlEWMuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4uSzIYym/V+0W3jR2AqNWu6P+AwuuhWQ6fWapF/+6W0Rf1VV7
	PvA44KMLvphfOqfrNDDsqEF9UINgabDaem9+mstwXFKt4McCvcFq3IP4Kk03akxetrK1LZcPMUL
	QJX/OojoPdeDDNcSYpDJkfmqOyrcQaUFWz8/31PIw/j7l5+g75vLSyjFguA==
X-Gm-Gg: ASbGncuZKS+Hv+QvBnNxgB2wOT+Oy29iQbVm8+Eh4Mbq35rpiqelBcXGXUnJiY0xolc
	YJeq3j3x2krsAI1+Ofx3gWOght5kXDYumC8fiABoFzeYCndWdeJJaOouyWkLOC9XkjYSiyLRrvG
	N9oXBKdXbepIrfntECWvMb3fEQdaE30prTGKyQAqzeIrNjgDBQf21KxYdpIZ2BRZKe0aDNcvJ3P
	lJR9H/fhnh0JbMIxtAe1pxbZ6JhcBZuSd/YOAlh/3/UHq7AG4I2lVwAvHTvg6BsZPvVjSlWFvKe
	DRQ1y74uBYu6AQ0SKXPPS1IqI5cE7U4X230cXbN66yI=
X-Received: by 2002:a05:600c:1f14:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454f4255695mr113362155e9.32.1752505410946;
        Mon, 14 Jul 2025 08:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgGUQLi8QIz9qJck9h2onkd29NM35VCq7kR/qUQg+hshIrtci80OF3+t9fpKWQoP0MLQ3vkg==
X-Received: by 2002:a05:600c:1f14:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-454f4255695mr113361195e9.32.1752505410294;
        Mon, 14 Jul 2025 08:03:30 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.155.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm12513593f8f.22.2025.07.14.08.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:03:29 -0700 (PDT)
Message-ID: <d16bda13-2f84-4d15-a737-d2782cda480f@redhat.com>
Date: Mon, 14 Jul 2025 17:03:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 net-next 14/15] tcp: accecn: AccECN option ceb/cep and
 ACE field multi-wrap heuristics
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-15-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250704085345.46530-15-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/4/25 10:53 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> The AccECN option ceb/cep heuristic algorithm is from AccECN spec
> Appendix A.2.2 to mitigate against false ACE field overflows. Armed
> with ceb delta from option, delivered bytes, and delivered packets it
> is possible to estimate how many times ACE field wrapped.
> 
> This calculation is necessary only if more than one wrap is possible.
> Without SACK, delivered bytes and packets are not always trustworthy in
> which case TCP falls back to the simpler no-or-all wraps ceb algorithm.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


