Return-Path: <netdev+bounces-190182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AC5AB57C2
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FDD7B6F05
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD641B4132;
	Tue, 13 May 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Kr+3xnzr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8F1C84DC
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148150; cv=none; b=mqfuU162OdoBPvRk9jf89TsLFuLMj/Nm7voo6YkvTU7jGKs7qcrEjexj+xRV2p6pneU9zf6lWvvWBqu4RJOmZdNyKHapsCDirzTLL/rpr9r1YR2AAOy44HGLwL+F1MEDnTk87UU+V+3l38uNfWfRXpsi1vyBgn15Og0EtAtA6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148150; c=relaxed/simple;
	bh=cjG5JcGmwve+aOo9ccllqHKn/eZk1rYD7li7q17KeKA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e4E6o+WKCkpvoAX13jUCUYGzMb27YzyYhXjIHrlTWdwEAwi7bdI9fTDisAHada1bO45jFVOyAEhyuVlM2Jo8jlvMvY9vhOY5fYN2/kWn1t2Tk7cLZleoAsIS6N3fA8zwfUsXPz4Nht71/vJTj39+rC4AgqjESKgt/f/IbVpGsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Kr+3xnzr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad21a5466f6so827230266b.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747148146; x=1747752946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JKm/LBBokWGsOeoG50jghRZUC14bU5etDYCncV74e8=;
        b=Kr+3xnzrmdr1DGgaZw5tFtBCavXY6Pc0v7E1YG9X5d5UUsZAlWC/n3hd8Dcu6tdHMO
         ma0/7ER4jIn2REGy898pkCHeOkggdAqO24JI5B8EH9LCExHMkrDfBKmM0wpURO7Y+zqK
         dkB5k1CyMEfeZN0lKeQMSjfWzhVogs2yjGXCGmTQXTgQTRavJkIsF4GLRJjExfUK6GR5
         3+PpjY5mvonAAXtXsac+LfdnxVJXa+WJsUSMUV6UsjZmvFhzKH+gt5bpoCXk5YZPUhUW
         Sxsy9JpzGryoT6QYxRDNLEQnArWr5RDcl2X3StiG+xdyMRFCMvm9HRPkw2zrwrixv8rJ
         ftRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148146; x=1747752946;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8JKm/LBBokWGsOeoG50jghRZUC14bU5etDYCncV74e8=;
        b=loIfTfB1EjvmBrAyrbjAVe1wyX3+fxYDiz77hL7lGoLq1Z8iCh39ymO+IzDp8xXnfP
         Hy+k4W44hNz1QZP+AWBzCeAroOj6Syz2ZHKI92IGWCCdWGNsllFTd7BPSPoZi/P85S2c
         VzQpqLm/TR7mDGI84PNP9LCjlJcASgRJW8tksHOttavJCyGLHhwIEqm6EJMrpyEnbqZ1
         sLrxHBpn8YsXCldMpg2iC3gUeoxy0+39D2jA/8D0kjBjT2UUAW5/8TwdEiyccQHDn5VC
         j+iRDHJxGVy2MOC4ENW0ejxAuhO+FZdRV48kRbD89jvzNTYrCN1Pzc9h1P7nIiHzPgZY
         dpog==
X-Gm-Message-State: AOJu0YxKHU7gCcJEhtVCUEb9MdTBz/p0wfSUvwLXy3pSSf17t0pHwVv/
	30HODYwfje8TVfT87+tdsZExCUHvy53hjPkEuPimY9hq5Po2Rn8TzjE38tjJWgdNxOWH1/baoTQ
	d6OKKiW+JdCJjTfB5sMz4yi5Req1qIfrYDVpAvK6uDMUfGpc=
X-Gm-Gg: ASbGncskfmz3k41gNU8ebrF4IHOkZ7Z46eFV8FCfYVI4OtxkYOfDPjzVkH7fg6MEqFP
	34BNVM3XYtb3aq356an3V6NbDKdoy4eDaUINEgxx4mY9js8Hs6M5to1XDXaOWIjcP+bYADW/RDd
	IfTyBbmxkjbzViQcp/EPlT1vIGTlSLlESkqJDn6PKLHOVhY+/qBnX3gUraIg0D2ryBKGsHaPuyp
	XAVDfv12jADXwzBbJReg7L5NKvoGi0OAw0+62pdd0Rrj37fg3Wne+NBg1jW1nJ2UBDXYG0OUuAg
	vkF5qoChnaUc3Ws+TWl3jcTZHz1BL3kt/g4fNdm4b2g/mwlPlkfLlYhAxfOJSG/dOSdwZIV1V47
	5Z9eSWJ8rWHNtVw==
X-Google-Smtp-Source: AGHT+IGL4Bk+epxmG7eGNwNlIBgK4exT40riHYPFTVkmgXjpfUXBP+mcOT2JIvmt//v76p9IMaNbEA==
X-Received: by 2002:a17:907:2ce4:b0:ad2:3c4e:2fc2 with SMTP id a640c23a62f3a-ad4d52be8e5mr393275866b.29.1747148145775;
        Tue, 13 May 2025 07:55:45 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:29cc:1144:33c3:cb9c? ([2001:67c:2fbc:1:29cc:1144:33c3:cb9c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad23fc53213sm545239666b.56.2025.05.13.07.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 07:55:45 -0700 (PDT)
Message-ID: <fc2758fd-834a-4a8c-9bdd-87cc6e874005@openvpn.net>
Date: Tue, 13 May 2025 16:55:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] ovpn: ensure sk is still valid during
 cleanup
From: Antonio Quartulli <antonio@openvpn.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Al Viro <viro@zeniv.linux.org.uk>, Qingfang Deng <dqfext@gmail.com>,
 Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-11-antonio@openvpn.net>
 <20250512183742.28fad543@kernel.org>
 <1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com>
 <f0d7cbd7-6bc2-4034-b912-17c3a1959021@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <f0d7cbd7-6bc2-4034-b912-17c3a1959021@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 11:19, Antonio Quartulli wrote:
[...]

>> Side note: the ovpn_socket refcount release/detach path looks wrong, at
>> least in case of an UDP socket, as ovpn_udp_socket_detach() calls
>> setup_udp_tunnel_sock() which in turns will try to _increment_ various
>> core counters, instead of decreasing them (i.e. udp_encap_enable should
>> be wrongly accounted after that call).
> 
> You're right.
> I had the impression I needed to "undo" the setup.
> I see now that the encap key is decremented in the UDP sock destroy, 
> right after having called my implementation of .destroy().
> 
> I'll drop the call to setup_udp_tunnel_sock() with empty config then.

Paolo, the reason for calling setup_udp_tunnel_sock() with an empty 
config was to "reset" its encap state (for udp_tunnel).

Technically a UDP socket could go back to being a pure userspace socket 
only (i.e. when all peers using that socket have been deleted), 
therefore I wanted to make sure that the kernel would not try to 
intercept its packets anymore.

I understand setup_udp_tunnel_sock(cfg={}) is not correct, but what are 
my options?

1) I could nullify manually sk_user_data and udp_sk(sk)->encap_type;

2) I could implement something like "stop_udp_tunnel_sock()" that 
reverts what setup_udp_tunnel_sock() had done and call it.

Opinions?
I'd go with 2.

Thanks a lot!


-- 
Antonio Quartulli
OpenVPN Inc.


