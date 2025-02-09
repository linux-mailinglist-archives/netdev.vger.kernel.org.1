Return-Path: <netdev+bounces-164485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765CA2DF16
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 17:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF657A168F
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB541D7992;
	Sun,  9 Feb 2025 16:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD78250F8;
	Sun,  9 Feb 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739118119; cv=none; b=K5wOU8N6iNJ+WuxYT1EtLlqMkTGwXzfFcymlZNHS3e+TLGM1SQnQKfkhGaCrMbY1gl95vxbClBmHCfc31X/lvFsw5lD2LawWnFWDUwILoFAsrHQx0iYbCqH3JHE/RWkFMJR9Ak+o2AVW/QVZujYMuhXnNIMssbydWz64hdMELBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739118119; c=relaxed/simple;
	bh=yTRL92i9xxJu+OIgh24kWWnSH18C0/xXTtFF3yjU/eo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CD5PjNgXiigUL0CXcdWYogPi0EZriZu37yqesBApsE/yRT3V0VQU9C0kauyxAhOEApsZ4N0ovKLQceqsIDLwcaX9J372sbGNrR5YzEZ43994g1IEsOsZuT5wFt6n5Aq8/VClQ4hNI1zkxwWze1wyL/U1/vgpqtlfcGEtGfLvZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5de75004cd9so525496a12.1;
        Sun, 09 Feb 2025 08:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739118116; x=1739722916;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKTV1eXVWUWEXlhNlVrR2N+qcGMhEd4tYThOkgkfVVA=;
        b=cbTrU1WxT28Fwgw3lfTrGMIgftczfnHm4F86WovWNky59QHsuCJY8eSR8hIxIaq+uz
         wfGpXlbfIEkbJ4WsdZMHUgjV10QN/G41bDIeS6YdcElhSgmFv6azekLGB0zQNgwPkh/X
         NX0j7VeE8i5JdRALtovyC2HoqtICV3ApGX+9z7x4nYbhIDZO72CMMKSJdhbtrJh74IMd
         nhfhX70mV37QAyytD4ORNt5gsJ13f1Hr3GiLgB/rvaZ6aC99HWiLBPZcw7f6fEGpjjVQ
         p8ay0jTtt/kJxXIs24mUsiWUmmgAcJyK52wejq9vBuQe4iHzcb/caDdfpGUStvdmskCl
         PqOw==
X-Forwarded-Encrypted: i=1; AJvYcCUd+1MoRiyV5qRbU6N7jh/SG+XECDAhfTJft+TYLxmM8UW2MrPD3U6Qro7pMjIV08AH+3PcUY/l@vger.kernel.org, AJvYcCXUee29OL0dXQma8PVqEuzfAcBNcWuIWVlkJsqRFF1VJccJJo1XhC8r6yUPSnn4asa/pjujx3TJryOVjcXrjCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM9slJ5U3guY90vJB9FcZ9YFFQnq4NN5w1ZoU8PmEHkuhDsfDW
	qm6+QonCbYb+g87wqL/oaKpu+Ugp1zJfMpPtuAU57SPCm8zdhUbY
X-Gm-Gg: ASbGncspyMowVc2FYkxy7+JD8IuAjkudcIlu7Tc6lNZki/+LNXKENfP5JEvauku+ncT
	lvobL61fC5LbO1+8dFQ1b0rKnAMgEKEz/OHPnoVSVbhaVkOUuM1SwKtqSjPwJOo0WTg34eIyvBs
	TXkYt1dpKcO5NoXccsSQ3VTBZUHZilNEWT3I2hiPg6ig6X3D+sladXJUavSNPUQW/QONeby+GgR
	C/oyPMoffAm4pb13H4S7usXMA7qj8zh7UEy60ZjbxLJkXpKxNH9+817uS67x0uaPGwAzq/HFoG4
	pMCe0rsitbY54j7cXOzHw3c/buEat6eZKijW4LMHCmAZ3uk=
X-Google-Smtp-Source: AGHT+IEiXwG+x/Od1Yt45SEd/0ZyFVX8duz+Mq6YtVc2wXofpFajVzsBqSEK474w66NpPfzt4PVlfg==
X-Received: by 2002:a05:6402:208a:b0:5dc:5a51:cbfa with SMTP id 4fb4d7f45d1cf-5de44fe949emr29057186a12.6.1739118115731;
        Sun, 09 Feb 2025 08:21:55 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7aab8d8fasm268425266b.58.2025.02.09.08.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 08:21:55 -0800 (PST)
Message-ID: <2ef88acc-d4d7-4309-8c14-73ac107d1d07@ovn.org>
Date: Sun, 9 Feb 2025 17:21:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: dev@openvswitch.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Kees Cook <kees@kernel.org>, David Ahern <dsahern@kernel.org>,
 Yotam Gigi <yotam.gi@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Cong Wang <xiyou.wangcong@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 i.maximets@ovn.org
Subject: Re: [ovs-dev] [PATCH net-next] net: Add options as a flexible array
 to struct ip_tunnel_info
To: Gal Pressman <gal@nvidia.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250209101853.15828-1-gal@nvidia.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250209101853.15828-1-gal@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/25 11:18, Gal Pressman via dev wrote:
> Remove the hidden assumption that options are allocated at the end of
> the struct, and teach the compiler about them using a flexible array.
> 
> With this, we can revert the unsafe_memcpy() call we have in
> tun_dst_unclone() [1], and resolve the false field-spanning write
> warning caused by the memcpy() in ip_tunnel_info_opts_set().
> 
> Note that this patch changes the layout of struct ip_tunnel_info since
> there is padding at the end of the struct.
> Before this, options would be written at 'info + 1' which is after the
> padding.
> After this patch, options are written right after 'mode' field (into the
> padding).

This doesn't sound like a safe thing to do.  'info + 1' ensures that the
options are aligned the same way as the struct ip_tunnel_info itself.
In many places in the code, the options are cast into a specific tunnel
options type that may require sufficient alignment.  And the alignment can
no longer be guaranteed once the options are put directly after the 'mode'.
May cause crashes on some architectures as well as performance impact on
others.

Should the alignment attribute be also added to the field?

Best regards, Ilya Maximets.

