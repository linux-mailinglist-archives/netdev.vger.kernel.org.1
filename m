Return-Path: <netdev+bounces-219168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1FFB40246
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28387A8301
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916252DE70A;
	Tue,  2 Sep 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/tm9/aZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A50275861
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818821; cv=none; b=JWikq54nE8O5pnThkluVxzwSBiHHRDAvHZ1GYUX8riBynTh2U+F0GFN51IkMm80KPNa/2uttA0Vgpm51EoZKvqgVGeosjIBR5Gm/Trmh1WoD8u9V0C0D/kXyjhl2nJsL3SMbonzHMcuF5SoRwnzKuysF7fp5hV2f4i6RLQk8pbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818821; c=relaxed/simple;
	bh=pHGzey38XOUPjiq1bS8AI/NtErCpH6tE5wMa0riilPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IU1B0Tf/xXOrj4IDXKtfUvDX7RfrtU585kBdPWGVLZeWmVV2MbwC7xhVF9TtCCtrMMpe6qZjyiGJxNUVDeH/G3GVHLVJVvIVPuG+PC4PJQfqy/wsWB/QJhlFgDmEPQu2uwu4ju70lq9fddBxGUR5nz8wK7iy5ImDkVaZWP0qX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/tm9/aZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756818818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kz5QX87nySOX3RVBMgqVueI6ebl5Grtiu3IVYkb6F7Q=;
	b=h/tm9/aZdWRmoCjYGze6mpjj+dgDcqTUwtVEznodPbApcTlQ/pHgfqjVh0NrQsBb/BqZzH
	nLUbzC8ROcf0punxbeoAV6Wr71H6uZ/Mi2uqpyMRNdizocAxu0VKkSeXzojnseQr7XWisz
	yWjnkJNz7H7EvmUvVhscu0K4Mqe5N/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-dE1DGEOHPqm1tWF3MyfbBg-1; Tue, 02 Sep 2025 09:13:37 -0400
X-MC-Unique: dE1DGEOHPqm1tWF3MyfbBg-1
X-Mimecast-MFC-AGG-ID: dE1DGEOHPqm1tWF3MyfbBg_1756818815
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dabec38299so486071f8f.2
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 06:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818815; x=1757423615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz5QX87nySOX3RVBMgqVueI6ebl5Grtiu3IVYkb6F7Q=;
        b=v1HmKfrisosn/d9s0QrzsqcsRS/2xMVPWkWu0quZxVRcmONwf1DcvgSZcpH1PJbefR
         D5qYkf/fRyGLg16JnhzzGnvcZRPWSL8cOvPGcQm2vyoNgyRGWt11sdy0rtJjdzPcnPyd
         6uXha1GKEmaFqYQtFAkVod+cf56ltn9Q8r58m9yflf3BfukHgWu9GhHn1gv+nCA1IK8t
         peSHjRvFw7a4ldZTbafe52oupHxhPW9w4VuWMtQeihYLeX17594mwPg/8bbeip4YO/UA
         Pmysl0INiMhEQW4ppPXl1Fc+q8uf23VOzpTTUgx0I+JnFQBBasNdwwxGgCdfTwuIdVlm
         /ubA==
X-Forwarded-Encrypted: i=1; AJvYcCVfqfJ0NjcCZ62VDTCfiQfDUM4Wqrntm7HDRtIqlUaLIe1kPEH5WgixvjiojMROWos9PHqayPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hJ7omLGtH72M5OlzQHcq7gOQOEaxGlk6XCjjfhyhuGbsEInV
	ufMFzY3U/ripufJxvjOcaaqN8AITDyquo7MdXvVanMNhS8ZXr3v9lXf3KqMVoXb/TNxSE+x80Ro
	pVsMAjQaQZvqesq6wu27YyYRoIHNkgLQIpREHfmIlOfDHSgHJH9zQ5Etniw==
X-Gm-Gg: ASbGnctX64xw/0HsU8qTfLHz23nJotKqY8wGbtf08dV1k6b7/QY86c+cZlKyQiR6uOU
	AIT06u42zEjqB2Eex8SW8f7bHh6Rd5PMbpQseFEun1JhiTeGUwcHG+qXn1g4mKcHyYe/WA2uKRr
	4Hn51CT5CpGHRzbwRZ84gWA4Fo519+uS5Im2nyFxXeTXX7eFQJ/kuw8tlktPW4heNs7JmrB7dUr
	cS0cgAQzi/vKSoE73fqxZZbi7r957x113qfxv4V4CicYSQE03zsmI3Og529U7QynzmRjv/D/Nz9
	a61wmGZC7gvnbP/W9iq2Ww1Iqj4dIYj4mKMjh87bSAQGBOK8Jj98Pipa1a6CKPU6yt0tzX8VZGy
	HmmXPyafDQAs=
X-Received: by 2002:a05:6000:2112:b0:3d2:6129:5505 with SMTP id ffacd0b85a97d-3d261295a85mr7941933f8f.36.1756818815087;
        Tue, 02 Sep 2025 06:13:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDGaSB01C9v+w2MDFlDInEcGknzi27EVQ3yepByIL3I3dRIL5ujF1laC4xqzIJ9q7ccU8k3g==
X-Received: by 2002:a05:6000:2112:b0:3d2:6129:5505 with SMTP id ffacd0b85a97d-3d261295a85mr7941901f8f.36.1756818814688;
        Tue, 02 Sep 2025 06:13:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3dbead0b247sm192594f8f.6.2025.09.02.06.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:13:34 -0700 (PDT)
Message-ID: <1ea8004a-1a1a-4777-bf09-14207e47d41d@redhat.com>
Date: Tue, 2 Sep 2025 15:13:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 08/19] net: psp: add socket security
 association code
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-9-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250828162953.2707727-9-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 6:29 PM, Daniel Zahka wrote:
> +enum skb_drop_reason
> +psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
> +{
> +	return __psp_sk_rx_policy_check(skb, rcu_dereference(tw->psp_assoc));
> +}
> +EXPORT_IPV6_MOD_GPL(psp_twsk_rx_policy_check);

I think it would be better to move this function definition into the
header. Are there any specific problems (i.e. hdr dependecies) to do that?

/P


