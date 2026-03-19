Return-Path: <netdev+bounces-269409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN1rKpzgu2lXpQIAu9opvQ
	(envelope-from <netdev+bounces-269409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:40:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E9E2CA6F2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8A033029B9C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AB3C343C;
	Thu, 19 Mar 2026 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlAnH1md";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqj5fwOY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4ED3B893A
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919565; cv=none; b=Pq0/r8Am8ZYvwbD2F3+0ZN4PPYLvO3WGz5oy0ASVDE1CCCjxo4H6FQO5iH4lM79s2O7Scs/FAPW+YPSSMYfqNZ4mnc5rROZiaFueRb272QeIxcy5AdSIZlhMDKyNXC3u+t3X7uBEEnKJFUxwrJh6jJVMhCb8m3TWY9V57tzIKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919565; c=relaxed/simple;
	bh=kZQroTZ25Wqfxzr4T5Rq+5FHnD6nGQEjiChb+d1E3LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxlNmQVtTe54jLZFxA6f91d2q/HdGVLiS5BZXDYk56N5yFzNPC2HGU3gzDnznUytSQhhRyYGYVHD+XGsdEr1WREwGbH7WreC/qro8LHIGE7n/aTjuDfEK7AiKmSXv/0ByRWIVPY1iDFPlNP5Js9VCbTakcYsSBk2YTjFmLyclto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlAnH1md; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqj5fwOY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773919556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Itdz7wDDSx/kCOctHQr/UVkvQIv0uyImjjBnu9pFKko=;
	b=QlAnH1mdr8cs1lcSpxdl0yHri8Kj7ZGL1JVBb1oJbIN6HJebEW3DxXlPcN9h+ZKy6ORrDx
	Cs5CTyQmpuAAY0GLP65tIvX2S4saGqpAVPDye+r3IVsbw8SP9dr+MaYi4uOxidSHTMYTTH
	ss/p44fdOhw0NtzC/mQ/cmlhjZyNYic=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-q63NVfSAPcaiovtbc5NH7Q-1; Thu, 19 Mar 2026 07:25:55 -0400
X-MC-Unique: q63NVfSAPcaiovtbc5NH7Q-1
X-Mimecast-MFC-AGG-ID: q63NVfSAPcaiovtbc5NH7Q_1773919554
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b92323d85efso100507866b.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773919554; x=1774524354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Itdz7wDDSx/kCOctHQr/UVkvQIv0uyImjjBnu9pFKko=;
        b=cqj5fwOYjW5CxN1v4Qw1uAYwxgQ/B2YZ+HbaQxdfYZicSxh9G6Qt0osi+kSd22Fzjm
         qF3DNtXYYJSbm4W6CVM/QobvECNho0LhYNt9RSXBrrEqA0Pr0LrejNWu5DoUfp60pIbW
         6YFDN/6GDzrLNMoh6kr+eQM2uKMlpfUpxS64Cx+BlwXe2WJxZgT331B/cx1/bMKMiA7p
         GF/DlzerelLld7DTtRvXk2jaO7SD2Ob63OWZ6T3GQ0GSUnS9+9mjdWYIiuPDq4bpz9yu
         RlGm50xUP9dQuStybpqAL3upBm/4zwfilyVuPr6dYkooDck3yWhSJq0d4+WjPTAGZNyn
         SzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919554; x=1774524354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Itdz7wDDSx/kCOctHQr/UVkvQIv0uyImjjBnu9pFKko=;
        b=EOAG6E4UYHlG8REMDono9cbvT+T1YOG13GSKldcRVaGaEuC8TKZzylYLG8SjNlLDX1
         rl2GFM0yUVWT71N9ToPw2nuVDEkH728AYhLolIJqrg32hqHf0vZQcG58BZK28w6osxxJ
         FnWaJys/HnWeyWu5E5dS0fKM4+Ttcl027qU+cFK6t3Q9y7FQyRehdN6Z36GqFOpIPCcq
         IAA6o0iCeH3XtBFD/xYJITk78EntgAoQzE5wuz252Ql0af1+PU7wf6axJQ5MyQrA+Yl2
         PCcaM33pa1Ubb5lSLdmfwnfO9s0vEhq6tH9/LpU8DQnX55glrs7IeuqV5UlCCFZmyv+D
         qUVw==
X-Forwarded-Encrypted: i=1; AJvYcCW4n66j/g7rgy5y/jyPYuhFpyqPTPIYoJNMP6VdRdufWlqTSRQGT/FQAlyCFKCT1HuRfRL6JaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7iohcFA7XIdgRPqfk9ytPx4baLLdD9p4iJOWigDf4irbmXLm
	ABnjaR7MAHrkIbqMiN768enXzk28kAV67SPj+GRnewkZhROrZQdHBuC6vsmTIeJ19mSSC3YvIVt
	bf0Lwk+pzQM5+0EYP9GqE70xiOhUEz54lJxBh8wy2o4nLvuwfI49q+yhR5Q==
X-Gm-Gg: ATEYQzy9GQsbCWD2k7VzS7hggixSSNSa4F1vK52kaJCtAVPfdQhx66NH269VuG494qY
	z4YCS7Jr2V2o0RTj6G7dL25u6DZfqjN1z2SmAzc1I0uodjl2fZ/r8q81/RvT9C1qacWDrMvH77A
	ZKsmAGbLjOBGLQDvfQiCoHHdiBzcm7Ymiw1ufNyjHcQiLVYItF1cqGDiuUbautYWdeqBnB8a2wR
	ymNwGVRmGhsc9fX+4igf3DLbqZNWw3yq/sboiYwpC2GJHUH6TIQp1/qTnpMmHAM4OD3josIYy+Z
	JpFVHyWCu9ZGLLTKEjpNYE1j9XEDIcSPDTPBsufy7eC5undXu0HbmrN4vKb/Kngt1EDJVRDrKWI
	DzB59CPFOpVyqA/G1uZAsW5Vgao0FxIn6JwrH9917kkuAf8WC7vnxQiAX
X-Received: by 2002:a17:907:60d5:b0:b97:b379:b3fa with SMTP id a640c23a62f3a-b97f4aa62dfmr461195566b.39.1773919554339;
        Thu, 19 Mar 2026 04:25:54 -0700 (PDT)
X-Received: by 2002:a17:907:60d5:b0:b97:b379:b3fa with SMTP id a640c23a62f3a-b97f4aa62dfmr461190166b.39.1773919552950;
        Thu, 19 Mar 2026 04:25:52 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d7ddfsm427135566b.44.2026.03.19.04.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:25:52 -0700 (PDT)
Message-ID: <911c9f2c-ff15-4539-9295-94475b969b2a@redhat.com>
Date: Thu, 19 Mar 2026 12:25:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 04/11] net: ngbe: improve the reset flow
To: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Kees Cook <kees@kernel.org>, Michal Kubiak <michal.kubiak@intel.com>,
 Joe Damato <joe@dama.to>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Abdun Nihaal <abdun.nihaal@gmail.com>, Breno Leitao <leitao@debian.org>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
 <20260317073827.4300-5-jiawenwu@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260317073827.4300-5-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [4.34 / 15.00];
	RECEIVED_BLOCKLISTDE(3.00)[209.85.218.70:received];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,armlinux.org.uk,intel.com,dama.to,debian.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.835];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5E9E2CA6F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 8:38 AM, Jiawen Wu wrote:
> @@ -383,6 +384,12 @@ static void ngbe_disable_device(struct wx *wx)
>  
>  static void ngbe_reset(struct wx *wx)
>  {
> +	int err;
> +
> +	err = ngbe_reset_hw(wx);
> +	if (err)
> +		wx_err(wx, "Hardware Error: %d\n", err);

AI review says:

"""
Andrew Lunn suggested in v1 review that ngbe_reset() should return int
to propagate error codes to callers, rather than just logging errors
and continuing. While the response mentioned hardware errors are
handled in another work queue, should the callers (ngbe_down,
ngbe_setup_tc, ngbe_do_reset, ngbe_resume) be able to detect and
handle reset failures?

Reference:
https://lore.kernel.org/netdev/4ddc6f7d-ee6f-48a9-857f-a10448815675@lunn.ch/
"""

There are a few problems with the workqueue approach:
- AFAICS the workqueue is scheduled on xmit timeouts, which are
apparenly not directly related to ngbe_reset_hw() failures
- the worker try to reset again the H/W and unconditionally clears the
error status, even if such reset fails.
- ngbe_reset_hw() is supposed to stop interrupt generation; if it fails,
it looks like that the sequence:

	ngbe_down(wx);
		// ngbe_reset()
	ngbe_up()

can have very bad consequences (like ring reconf with IRQ enabled).

I think explicitly propagating and handling the failure here is needed.

/P


