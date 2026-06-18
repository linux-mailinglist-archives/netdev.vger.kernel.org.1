Return-Path: <netdev+bounces-300353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sV3pJ7OrM2qbEwYAu9opvQ
	(envelope-from <netdev+bounces-300353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:26:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF269E712
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=6wind.com header.s=google header.b=Aptl3T9b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300353-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=6wind.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D375230056EE
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361B395AF2;
	Thu, 18 Jun 2026 08:25:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3038D3E9
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 08:25:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771155; cv=none; b=fA7YFkAXYGQf6lBJc+Zi2pD95yHjxD6W0XkzXONDa3RHpVRyDVWTfpP2rm54BwQF6eYoFvFg3g8uJeYDak14CgxHII/d3NFRE6uWKIAb9bUdMbaM443UsUAJt1o+EhwYQHcvYo1+A/e3mWRXpKgVjIm8IktTraOCplIoSnUmmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771155; c=relaxed/simple;
	bh=wdR1rT3MAyiu3Ea1dt4T0QwSz8nrbGqxl69q9c/1IZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppC/8YbShjgpRo/u9w328CW8QkOoBF8gSI/yVEzQgjlou0yMZD+tay5IbEj0FtI2OvIn3ZVDlW4oasR1xTRMQjLAMN0AQ8XFgK0JcMlLcjLvX6ALaLZar33YjhQfw1sVHD5eFT4EuwIzhoMAJGFqcZT6EZ6euV+40jsRc+J5dIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Aptl3T9b; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490ae34298aso531805e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1781771152; x=1782375952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OWAZjUn2QY8Ah9cygHd5UGQrkIY9ghZ+KP/7AwdG/lU=;
        b=Aptl3T9bTFoOuu83CfuTSnmeOPXffRrcGWQMEQQ1Yz6fqi9Rp5H/ovYsK/jvl+shEB
         nMVF11BD1oQMUG2OW/OBkS1NiTcOLuX4XuIi4ZkXnvMzOUfSZ5J1/A4n1VZp1C7UavMG
         H6zlmMxlWjwWJDZt6OouqYp+DghIH4RrHgrT63p3RorA6K0TPX9bw17T/KcDG599NVs3
         eD+KZfHXQ4FtF5ml9FaR7BbywPWesoa9juoEF+PTZIUZoEsWJYGHK/c2dzsnJpnUOdBC
         S+CgYYqlDAxdpOzFyarpuuXx1nnG/IidkWMQqAQ1jIULKbxmRDTKNmEUdl7fyH8lgdGS
         n0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771152; x=1782375952;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWAZjUn2QY8Ah9cygHd5UGQrkIY9ghZ+KP/7AwdG/lU=;
        b=EXD0LOuXqGYExeH7pSFO6Z2TWs6l89fipcRCwZN/aRfTVmC/W36nnVXtU2snGOULkh
         HwhwoGiY3h9leAoEonszjdVR1t1JVEVZp4qIKkNjg0+eN8sxpjENu/jJM775GgmJ0Pls
         +4dAn+htmBStGF/p/QmgNvypPrQQrxZLGeYxlFtj+y0U9VJp7q1cF2OMKwBAvITaZOO2
         O4dAsiboaKG9JJ65q/XynLDjARQDAq4WIWmiWwrSVTpzvIi7gCkjmz55PL1NmX6MrAaO
         rD4QaLgxqb4fsGxROW3XaBxXeymSKKdjBVHbcEAq7C342BFxbujS8EHkeXo/bTHfmMWc
         POlA==
X-Forwarded-Encrypted: i=1; AFNElJ8AFxNRFu8KuofX9Gj51s19uI4HLpZdmnV2lA3FI4SOnJBL1IUzBlv302ZLHQcaC6t5g3xcEJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6VMHVtMxWAaKYTAFZupN+9zAnLwNyRgGURLOF4R4GKewKpY+
	YwP5q0tvzViOmVKKpwxk9qtO4mQSOo4UWmQiQ2JaYKQ+b4mHkKRJ+Vy1FFwYmv9BbQ0=
X-Gm-Gg: Acq92OE2PMgAKWJR7Mmy/w369m2tU0E0CIMEFdUuJLuHohAkkCqnY0gNYZ7Zk/gWsGC
	htDLXq7sSevpG2+i+54mblueoqbZ/zSl0MXxeK4cPxkJ0CVewZ5hFYkO3jEBqtjHDwGX9UoOjSo
	MwQ+Zbq1JXgorkafWE15DKINXGH6QzDvHvLB4b2kCmGEdznhNwUNY7dW/zLDEFsW2WAr5c0WiRv
	pW3f+k3ZFjeiIJPuBz54o+lk4NUNWqzBiG6vmELXktMiIHeRYaoLAd7jI2ezjo59cS4D+xJKnEs
	ln9ppJ0lLkp6gQEc2/XeJ7CC5DoAPzBs7bRArVxMBKXiBSjsNA9nmVdhyXjP+vHhRop8RYplldY
	xZ04DJh2+gHw7PNVKkHy6yaYvZEJrklH3spLx+4RauOxdj3nm1Iy/IXRhkOJbeXmlOYU+w4HUro
	WeIbN9vEfb77FQX7zobb0NlPaauBCSCv7ZcmwOw6IexgJ7TfYOn2tL02pOH+PPvNN47g==
X-Received: by 2002:a05:600c:4fd4:b0:490:e190:38f8 with SMTP id 5b1f17b1804b1-49238261a6fmr19061935e9.5.1781771152048;
        Thu, 18 Jun 2026 01:25:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922f9cd140sm210641635e9.0.2026.06.18.01.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:25:51 -0700 (PDT)
Message-ID: <a744f766-8b70-46c5-8548-0259c373aadd@6wind.com>
Date: Thu, 18 Jun 2026 10:25:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] net: sit: require CAP_NET_ADMIN in the device netns
 for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Xiao Liang <shaw.leon@gmail.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300353-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,6wind.com:from_mime,6wind.com:dkim,6wind.com:email,6wind.com:mid,6wind.com:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FFF269E712

Le 18/06/2026 à 09:08, Maoyi Xie a écrit :
> ipip6_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
> 
> Gate ipip6_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed. sit was the one tunnel type not covered
> by the recent series that added this check to the other changelink()
> handlers.
> 
> Fixes: 5e6700b3bf98 ("sit: add support of x-netns")
> Link: https://lore.kernel.org/netdev/20260612085941.3158249-1-maoyixie.tju@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

