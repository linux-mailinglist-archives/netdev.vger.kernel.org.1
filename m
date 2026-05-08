Return-Path: <netdev+bounces-285937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFhXFsMc/mnymwAAu9opvQ
	(envelope-from <netdev+bounces-285937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:26:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E18294F9F1F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C5F93046FA0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F533A702;
	Fri,  8 May 2026 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvciuZH9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7764175A77
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 17:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261029; cv=none; b=u4UnK0IasAhWPd4tUV6monIMXqdlw517jZ4tZdHM8IXoEytq6sMJzcjhI49OH2HHyExqHKU+yyQT9YJs4SeFB5NWx850O9i3A5VFPOA9S/1bxZpdhIcFcT+BBDzF0Y0eI34xx8VUWYLudaxq/KWE/vo8E8VVTlM4DNDZvVWj7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261029; c=relaxed/simple;
	bh=WOyx8Z48htcxwyxmNQbyPqTjfn7K0keNSd9wlveroLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VqPp88EDDEVqEDF8+BQX51bMjPIPbTUbwYCfASDUlN1mCfiqeEgXXmZ9Pp/mrKCq7QkErVTLGchnYvKb4kZI4dpyQaD1dqEdICZKkIdKl1ou8zpHcyJ8Gd4wISXZShf+lDYOtPBlhwLUbBrHMBbiHTFy09RJTkpn/zsLSzUqE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvciuZH9; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de7dc85b74so1924065a34.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 10:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778261026; x=1778865826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1DP+JuCnIiM0V9Dxy5rK6Ns6ZckVWIlwW+CDaFwu9r8=;
        b=gvciuZH9/GpAabeNj7v0/yjRAaqzwh3FodU+bWFch5mONSfYvY2Je6Y+UVgivqN/0Q
         wrc4bUh7DlcuPQUwjYpf+od8DT07F7xlRYQ7c+0IF1kYiFeeXtKUuddZtzQgEwWy2x7L
         6+TJ/kQDyJsZjcy+uKhN5oltUqLo4Ylsa6ANo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261026; x=1778865826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DP+JuCnIiM0V9Dxy5rK6Ns6ZckVWIlwW+CDaFwu9r8=;
        b=H/TqKdbQ2R6s6ZBdFXWykZPMPiB8xv9rxYKRkskS5NHY7QRC3cG/wHqnbdz52p6NrJ
         G0Pa1VQO2jNr7XPns+9quF+IcCAgG7Qg9bjoHNo8RKriKYymeVBBTjnnMYnoje4F3DCM
         JH6nt1pTLFWLkrkoBQBrMDnFIL5neNfa1w7QZJYCSkgAo+jfwQkCnXfYhjhAf0G2bDbL
         CIYZVSHQqaJhC3OnLwJaTmik7e/UE+DMKzGpl4lh3rF5aW2soL63X7NK5OnlwONe7rDN
         k/JuaZ+R3XGE8SLX7W/x7hXvjJgaStV3Aw/zUfGudRpvur/9KS1Mhbi1pX33jQZ6llJ3
         OvcA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ns7HcJPgSnqE7W2V4jOdWyONXiO2jrE+XkIlSge7pRSEnc8HCy8DsSzvJX9m/NEu38lm/Rn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPEL8rXvS5wiiBLEKyo+OhyisUbNzeyeXvvochqZ7gqT+MRKG
	AN/4BqGTulZJyTwoXAbiZgcCbfRwWgUabaxSTujLCm+wegfE9cTzT1+4ETO1s9h0+wQ=
X-Gm-Gg: AeBDiev1ZiM/cXt+3p9n/p7c0x4u+T9LEuzHtd73KSsZvOiSQiSYbfxvhCyhZKrTAjx
	OuKnMfGMJKierInVKG8JnKDHb2vlkMfol1kGNxJqkuJx/99aOWLRvpJjuzyqGB/yxKVh8KCDK+w
	HKrMxbi3JrZELzIYkV2vgIaeNTxEQRbFJ/w43TsjIaJhhWZX5o/po/WfFNT9Y7v34sBPZjp9Xik
	tA+J4rQsdXTpm5KNEa76xmEQngCHXZQtIJrICOZePQ4lc28PsLYfpheejutL+QgYsgKnIxmuGpX
	O8O9yPzEPSLMmqwMlxcSf772kbVWXxQzcR1AE/kDd8xwfMi3EkXWfK24bESFIGwmHybSdyZ3+as
	o5Suflq0SkXjs/qhf7GJ727jndgDotkcSgklMqeaXdPGquCW3DuEe0pMmZiwpMIWt5FWjiiQKGH
	8HtdtWTp7aWPf1ax7yS25CT1pZUOrzJsE=
X-Received: by 2002:a05:6820:178a:b0:696:982b:1c24 with SMTP id 006d021491bc7-69998d56a5cmr7340448eaf.57.1778261025735;
        Fri, 08 May 2026 10:23:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c1a58asm1448361eaf.1.2026.05.08.10.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 10:23:45 -0700 (PDT)
Message-ID: <2b771350-0562-4cb1-b9b3-cc3ce59b1a63@linuxfoundation.org>
Date: Fri, 8 May 2026 11:23:43 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] docs: fix repeated prepositions across documentation
To: Adrien Reynard <reynard.adrien.08@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "open list:KASAN" <kasan-dev@googlegroups.com>,
 "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260508163804.16267-1-reynard.adrien.08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E18294F9F1F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285937-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,arm.com,lwn.net,davemloft.net,kernel.org,redhat.com,nod.at,cambridgegreys.com,sipsolutions.net,googlegroups.com,vger.kernel.org,lists.infradead.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/8/26 10:38, Adrien Reynard wrote:

Missing commit log

> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
> ---
>   Documentation/dev-tools/kasan.rst                   | 2 +-
>   Documentation/networking/switchdev.rst              | 2 +-
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 4968b2aa60c8..3a8bd40ad905 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -392,7 +392,7 @@ reserved to tag freed memory regions.
>   If the hardware does not support MTE (pre ARMv8.5), Hardware Tag-Based KASAN
>   will not be enabled. In this case, all KASAN boot parameters are ignored.
>   
> -Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> +Note that enabling CONFIG_KASAN_HW_TAGS always results in-kernel TBI being

This is correct the way it is - no need to change this. "results in in-kernel"

>   enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>   support MTE (but supports TBI).
>   
> diff --git a/Documentation/networking/switchdev.rst b/Documentation/networking/switchdev.rst
> index 2966b7122f05..948bce44ca9b 100644
> --- a/Documentation/networking/switchdev.rst
> +++ b/Documentation/networking/switchdev.rst
> @@ -162,7 +162,7 @@ The switchdev driver can know a particular port's position in the topology by
>   monitoring NETDEV_CHANGEUPPER notifications.  For example, a port moved into a
>   bond will see its upper master change.  If that bond is moved into a bridge,
>   the bond's upper master will change.  And so on.  The driver will track such
> -movements to know what position a port is in in the overall topology by
> +movements to know what position a port is in the overall topology by

This looks fine.

>   registering for netdevice events and acting on NETDEV_CHANGEUPPER.
>   
>   L2 Forwarding Offload
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index c37e8e594d12..7b08738c30aa 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -1092,7 +1092,7 @@ be formatted as plain text.
>   
>   Developing always goes hand in hand with debugging. First of all,
>   you can always run UML under gdb and there will be a whole section
> -later on on how to do that. That, however, is not the only way to
> +later on how to do that. That, however, is not the only way to

This change is not needed. If at all add a comma after "later" to make
a distinction between the use two back to back "on"s

  "later on,"

>   debug a Linux kernel. Quite often adding tracing statements and/or
>   using UML specific approaches such as ptracing the UML kernel process
>   are significantly more informative.

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

