Return-Path: <netdev+bounces-185445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99FA9A5E8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F847B01A4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D91FECBA;
	Thu, 24 Apr 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4utj+VO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569215579E
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483513; cv=none; b=Qc3Cx5bQS5n2JUDvrKrsgyMIrIzvjCcNqQ9h1xalpYQM/fx7f/73bZjpNA8rjbJtBGsOF9rzcAYCG3fCwXVbJ9mZl532XRLSPe4d4YEXWPj85Efd+5yKb+GyKbG/d2X7K+9zIVRdnuFVK8erda5xY3cT9VVkbdj1YIQJnc37lmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483513; c=relaxed/simple;
	bh=f60dY+Oxm6md1RxHB8DTa8ZMnlBc4YxupW45l4lHYeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqApx9WuYn2RC/GNDu2apCTRzdq9BX85ESMEzmuvLQEs9xcVA1AFj2635BiLFoJtXd86HYufNdkw9sPDsgq7AiPH/evXYZ/sB5/y53A6skCwR1OcCsWMx1jUXxOK+6WN1ivmmEQ2JhE+t587AVozYR+FXJMkcr+wjao+zsGrIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4utj+VO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745483510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f60dY+Oxm6md1RxHB8DTa8ZMnlBc4YxupW45l4lHYeM=;
	b=i4utj+VOn5QDQQ6MHmPOfdbkGpcy7tCs6P/G3ffZSrxeikpCGmNXYS21vKGPuIjJohI2Tv
	yagAOPOno65E32sKaVmSxl8zvlUyCVXhAftmJfY50bz3X3j5e0fX7LoMfXMHjUS3OQvpp1
	0boqEvuN4suzwsJycyKCeLfW7RV2vUM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-qSA4smkzNYCyML6iFfDLMg-1; Thu, 24 Apr 2025 04:31:48 -0400
X-MC-Unique: qSA4smkzNYCyML6iFfDLMg-1
X-Mimecast-MFC-AGG-ID: qSA4smkzNYCyML6iFfDLMg_1745483507
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf446681cso3739365e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 01:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483507; x=1746088307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f60dY+Oxm6md1RxHB8DTa8ZMnlBc4YxupW45l4lHYeM=;
        b=ikrpa6Ad42asJg5wiaVzYT0g+8BHkHZgySmZANGs2WAZ9jUkyTx1zUBfYV3aU3FbH7
         30cygUfzcC/ldTNJ8Jkesi11aYvovUp1Vjf0SSsdoI8SABvB8iopq2xV27Xj3XnTpO/U
         PPrUkkY0ZXV/9aj1wQm6RxAB+xDkwlJYjwgf7JFMfk9rKjVM3IncpbW7u3RjklA8Rd/4
         DKTHE2vfEqEiyoUc0QD+l2mPvTWf2tlXokxCuTJa/VrygfpFpOzwNLpCbtrDVBjWf2HS
         p1iN7DLyaidHaH09U+hNFgpJIy0VjPAPaVqdnjpytPvnxKa+9cugW3+Rp8BY6YipUsS8
         debA==
X-Forwarded-Encrypted: i=1; AJvYcCXev6oB3hrpIhAxuBI8zbLAdxwP28It0ZFMlt48QDCLrTCfJ5Q1a30H3z7TMTbVXG6X3yXyHco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8NNtLhkmUMN6Vd1Cgo1Gb+31VuzRhJuiZ+56VsWEnI7WB+iC
	HtzkdlGrzf7CGWaDL+s7TX63RMqRiYpSXMi6yB9KF49wiyjzU8+lKVM6PSxj9ySOZDs1NfI0yYr
	QRg6lsxK53YedE38uIWsx96C3Cu+4jrs5Vcjp67AMRXcJj00Jl7OJOgiX1l+jvQ==
X-Gm-Gg: ASbGncsFOwxkdyTje1WLAxSUTDOyIyWDE60X47o1zQnvbLHTYYpTxLUxCBnpDRYWFzT
	oav8yaOFIPDJVSuqlPI1UayGmezfNwd0PSphqZJc4rX8Ck9eNvdLhoROL3qxqifQ2Z/qa2QJKZh
	6DK6OlHK1LSSXsbE67ruiVSAKEXmghDrpQoPoMnyOupYcxYL0IHabCj/vyW3hLbSLJdkiknaKle
	W2lEkiy3vY/AnQa80LIG+GjKAe2FdpySU+phkeOYmtfkCzLgjcMdAUgzGJQ8K5jH/qBxRceNEkB
	9GxNpA3GXtt9gmfQDGlYOy0mKqxM7OfAfofWBlQ=
X-Received: by 2002:a05:600c:4708:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-4409bd158efmr10501495e9.8.1745483506957;
        Thu, 24 Apr 2025 01:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlLGYLl1ev6b+Nnl/BQHXbOiQZWegxBCuI4gbJwCUxtYb0rvmrszG0Ge40QNYZglaAXVUiDA==
X-Received: by 2002:a05:600c:4708:b0:43c:eec7:eabb with SMTP id 5b1f17b1804b1-4409bd158efmr10501135e9.8.1745483506458;
        Thu, 24 Apr 2025 01:31:46 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c3087sm1285718f8f.41.2025.04.24.01.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 01:31:46 -0700 (PDT)
Message-ID: <c06f9032-4b9f-483b-8d72-0c70f39a398c@redhat.com>
Date: Thu, 24 Apr 2025 10:31:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 5/7] neighbour: Convert RTM_GETNEIGH to RCU.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250418012727.57033-1-kuniyu@amazon.com>
 <20250418012727.57033-6-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250418012727.57033-6-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 3:26 AM, Kuniyuki Iwashima wrote:
> Only __dev_get_by_index() is the RTNL dependant in neigh_get().

Very minor nit catched by checkpatch and only noted because I think the
series needs a new revision for other reasons. Typo above: 'dependent'

/P


