Return-Path: <netdev+bounces-216817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C14DB354A8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761391899A5F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198172633;
	Tue, 26 Aug 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKw72sCd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FCDF72
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190044; cv=none; b=nIs6EoMCgvxv82wInavQQ6gRlEYnxxDsOYw/lzvmU95RxY63XQzw19ADp18mC1hTHKq/dZ3iLJDBZEIZxUir1rC3IXYGd2A2gj8InqMCdocjZadTbCRUtxzt1mv5BAg8IYjJ8aUDmYQdKyChd0+aENebez05DwnWFw4DwIfeQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190044; c=relaxed/simple;
	bh=H5UPk8soSD1Dhj6vQ5tlVwR8UNMznm24d/sBs7unIAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9g/jBdFJv+xkamrt9mJJbIP3wA/4oe5+hEaGWrx7mn2K2V8Of4lp6hAYTmg8+e8dGfT1JExrewpPkdAsiEc12fMLh77GUOFQfAOCqjeOhWUvnNCRRUuf7wXU9a0Ja56RqlnPomOB2MMdWZMdmFA+W7OtcvuAR9nvch3XJ0nkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKw72sCd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756190038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cuxbKrEyYDYBV80DSoYDo0tQloL94Ba/yPGVe5TeKo=;
	b=iKw72sCdrTEUsRQvGAX+ewd2V3gTPO2S0yR6UGe8NqJCoc+1Ghk6k5NN+OYNDKv3Ov3fv1
	PWFgFqQk3ctC9YK3LjGyb5FhZ1dUndvxp4r8M4dCNk3VzNgG6X4nmPjWw10w8pxRmeWjvN
	L6+z/OwsZYTN/fsdi1R4W7oAY8jmNEc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-SNZkmTfNMKypmhyUJ_NMHQ-1; Tue, 26 Aug 2025 02:33:55 -0400
X-MC-Unique: SNZkmTfNMKypmhyUJ_NMHQ-1
X-Mimecast-MFC-AGG-ID: SNZkmTfNMKypmhyUJ_NMHQ_1756190035
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109c4c2cfso200326681cf.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190035; x=1756794835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cuxbKrEyYDYBV80DSoYDo0tQloL94Ba/yPGVe5TeKo=;
        b=uYWezpSxTi9z8Z9/99OygXsae6QRE1Qnrl+7Jvsu8PJ/+h93ZA32P0diOX+flZe2QR
         a+xAhFchKTBnSHAPv7MFyqyf7Ux4tcvf7zLRQPpZlMgGl+Et+4rFKn6WAz+wQ7BEXjtJ
         t6JSBY0elkj/h8p+IbqKEbi2FXGLjs/5oZr7VkM/cHg/K5XDHgRJ3My1uj3LFnWJ/kJI
         n+xEJAi7dGS6THWV4+Ih9Fd7NBRBeLckooWgyRLbG9vqajKPtRc1Ei9RbNAG9pJ/lpOi
         YaUVqJ7X4NzB/qptODVxANypg4GNu6xjN0IOft6cQhTZiZHD310ehvCGs0ehgV9y9D9q
         AS2g==
X-Forwarded-Encrypted: i=1; AJvYcCVu2pKQsDJCsLWsg6Eers0ZArauraVeaKerTLLkrwIOJiilS9NuID6XFL+6IvCECRhkdMlz19U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fl+s5WcSPQGS37Fnrg3XLuuk1mHKc9KXWnbeqv6hQcUWdHAJ
	OJUrNJhiHoaXfrKv1bGGmBeQjyijEkgrM5PmxNuO63f3SAVF0F/jJweMLPf7VfwHvDy5J9DmSIT
	K1U10C9MkSO3PlMOHlSnTUZgez0tQghrrjXTJ0vRtWM4JC7AdvKuYz+HoQw==
X-Gm-Gg: ASbGncuLuePr2uwot4PBUMOW2olawahHng1qKJNaghBk03+ysBb82PU0bjANjbY9wO2
	BennsbUFRxXPp1kk7+gnnG4ek45K4RUClCXzjwZJqM2PvE+7CCBPTVw9SYncBAsjuqZ22ATC/Ti
	nJ3dg5JSRll+M4Evuch9qtFiVkoRzJ+pVSpwUNzIgF5am2EGhjWhZlchgDbHhedDIGF8yBX/CgR
	hlpv5VL+MePObmuSragnPUwoWfbAyBOa6G6iktjJ4JZGt/W3P2cmIp1VEB2mVKNMEGcR9ybrKUb
	xeoknridEpo35uIIVikPxKZKRBDftjRtb5otQ2T2kdauFGtwKFeWYUfhZp21yeHvesoA5nwA96t
	T5WbJIkZhd5c=
X-Received: by 2002:a05:622a:5c88:b0:4b0:6b99:c25f with SMTP id d75a77b69052e-4b2aaa80e4amr164149001cf.17.1756190035486;
        Mon, 25 Aug 2025 23:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWxrpP3Lw3J4fpP3qDin/UJ8aCgE2YbSjwYLth4M7ZyGpSlWJ6/fJ+x3zBZU7m4exEUNp+/Q==
X-Received: by 2002:a05:622a:5c88:b0:4b0:6b99:c25f with SMTP id d75a77b69052e-4b2aaa80e4amr164148851cf.17.1756190035141;
        Mon, 25 Aug 2025 23:33:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f4eef7101asm58756085a.38.2025.08.25.23.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:33:53 -0700 (PDT)
Message-ID: <6e645155-1d2d-4b64-a19a-a6e90a12b684@redhat.com>
Date: Tue, 26 Aug 2025 08:33:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Willem de Bruijn <willemb@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
References: <20250825195947.4073595-1-edumazet@google.com>
 <20250825195947.4073595-4-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250825195947.4073595-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/25 9:59 PM, Eric Dumazet wrote:
> sk->sk_drops can be heavily contended when
> changed from many cpus.
> 
> Instead using too expensive per-cpu data structure,
> add a second sk->sk_drops1 field and change
> sk_drops_inc() to be NUMA aware.
> 
> This patch adds 64 bytes per socket.

I'm wondering: since the main target for dealing with drops are UDP
sockets, have you considered adding sk_drops1 to udp_sock, instead?

Plus an additional conditional/casting in sk_drops_{read,inc,reset}.

That would save some memory also offer the opportunity to use more
memory to deal with  NUMA hosts.

(I had the crazy idea to keep sk_drop on a contended cacheline and use 2
(or more) cacheline aligned fields for udp_sock only).

Thanks,

Paolo


