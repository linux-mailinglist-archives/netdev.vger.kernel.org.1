Return-Path: <netdev+bounces-278032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FcLMYvI3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:42:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2423A3EAC2C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5470B300679C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16F72BEC2B;
	Mon, 13 Apr 2026 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aoyj34RE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kG+i7dbF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756134029E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076626; cv=none; b=N5P7iIkP93K0vcoRhrctH96lpSNK5mEgSiJrkaE5lUwzfNg1f3rFdc+SokF+I07XOTAB0kVPohcw+olNlbyH9GaLKoGPnbB9XXPGpTCmu8HY+wWRsGrNvA/qLyn0XoNwm68g1Wr/LPtCVcQk4PXXEeyid/w9Z93fCoC/VGj85nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076626; c=relaxed/simple;
	bh=FpIAW0M5w8IUbjPic8HX+b3dJ6/Rcgu88oVWem7k5Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfxguwkC4B37M+zauJzL+scdvIkjzVJEPkHAxsXGWF3pjgHiRkqkBN78gOh3OZ9NWX1yJj2WtCTr8BvdPl/oBIdxVB9LptK8uNc3yFsamgKkN//M2zuO8+y633Mha5CX1k/gdEOuVvHd9OcLNKnHUN2KZtqBblD//9coDcy7iIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aoyj34RE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kG+i7dbF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776076622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFh2AFaqga5FGdEpIT+dSF4MkAQiRtJw+Eg8TwDwRyM=;
	b=Aoyj34REE6Xw5B0cUkGh04ZVQajcEGMPxicROvRrNiRLWiJFfiCNFXMQbZY+Ckgx02JeEy
	qKZqP/XAOvonoa2iETmqkkYm/YuYwzX9tTyDQ0fzJtwQP4Zf4LI+RP2Y75Q9x8rHGhogmA
	JrBzfc2w1h4FvmarydPb/W22VHSkqrA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-A9UYNNtSMJS_tBg3k1cJQg-1; Mon, 13 Apr 2026 06:37:01 -0400
X-MC-Unique: A9UYNNtSMJS_tBg3k1cJQg-1
X-Mimecast-MFC-AGG-ID: A9UYNNtSMJS_tBg3k1cJQg_1776076620
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso20917375e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776076620; x=1776681420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFh2AFaqga5FGdEpIT+dSF4MkAQiRtJw+Eg8TwDwRyM=;
        b=kG+i7dbFU+5IZVZzRJyZ8w2dySOfel8gSBiwSv56fUQUOJrhD9IkRxkqdCHko4d2Zt
         kba4J/3pJKOiQcEqPUnlXHCy9Ttm0cmsVm4UetXAdsdu5yJmUWunP0VQXSowOP4rrRIG
         I5be3mzY2Vz9v/T3SLct18eV+S5GlG2CvhAUHeev3dKsrtYfdSNkvShzVM9AnhYmM2S9
         uNJ4ur+w2EGS74HTO9GQoP8Gt8+B/ef2yGirWOFeTXYzL5hCnOmScHcYYQEbLQPG1Fw6
         a+94kTEgQuGIFHuwu1lo30fwFTQNEPBDkpKH3F2M/+Mi6Vw9HUi0CZ7ewRVV/0n9Jcud
         WSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776076620; x=1776681420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFh2AFaqga5FGdEpIT+dSF4MkAQiRtJw+Eg8TwDwRyM=;
        b=KIoDsFBHUz/fv9rFauc5BItkt/4exH71J6njfNYkJi0/FQeU/g909WjTinYefe1Wa+
         pVLuFk5KBUb6dpumnu/25Bv6n9DyPb1lkBHKxdbJbr98u7JeQSa8xw0DsSnLcIIRwYgP
         sNNO1HNa9r8yv3wbjCb17fYy08B3pzrzA5hlI6X0a+KMscbIacnBJXhuW4nvlz17VImj
         rr0wLw2VMoK7+QImeMB3yOmAJ/ut1qXtv9OSEDbtycWoFLoQoZC1jR1LYp+LUREO9YMv
         BZnDWRsHkJMPqn45LQC21xqoywCvHGRHMCq26u37hsJbWappjNexte+I8MX80y946vLH
         RAyg==
X-Forwarded-Encrypted: i=1; AFNElJ9Pd+EdjqdJLOubkCeRWvs6z9LHT1zQ5PZdT9jYKYksYjpVYEDgMKSvmbflhJZ1XgCnRVnDucQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSQXmeCZXuSpbljiIdpKVx+ySAGbUKj/A6bqh5M5MsWN/e8ua
	t3HLzQIELBuVnulh0yDjwYCDo8UdFNJvCaT74XB4J/emN1ydn5r0MgxLKbymXa2ntASy7CP0Pe4
	pCk82PIGAAupre1JxFm0J8CezK4yR2g+Y0Y9DWxzgI0lhN5a0RB/sLPYaOg==
X-Gm-Gg: AeBDietlh/9goE9o6yKNcMPC8vFyXOtbbFTZlDtpUrw6ZFG6GXkx8ylzAncq5KAUopQ
	OQzMC3JkrZvPUTT5h/6JOV0V3evuAOGg32nCL4HL2I6NgZ4KvRGOzoVFPoyBD+uVPJeVJUUeN5S
	3k5tC6cTLJKhL+JlVq0rybp5HpN/VvQSZlHANPD5Pw2tSYVz8278rXv2Wo1t4f8YMJl8Oe8PDtU
	qFp8Gkk3RRMNhE7Ba0zxzeva+ppDrJYdwfQcep6el0V73bZfEHOIwPe5I+FZL7T452z2Mt1Vdth
	yskEwkkhWtb1uB2z5JlxAtZmElUa+8eJvRN+rW3h69EMS8JmFd/sIisvDDLbwFTvouCtC3S1VZm
	dUzPY/NAGc8ICfXMdwH258kGA8u9gxAvPSrs3awa6pO+AAiWm1T8Q1VU3
X-Received: by 2002:a05:600c:528c:b0:488:a2ac:a337 with SMTP id 5b1f17b1804b1-488d68c2bffmr164242675e9.21.1776076619834;
        Mon, 13 Apr 2026 03:36:59 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:488:a2ac:a337 with SMTP id 5b1f17b1804b1-488d68c2bffmr164242305e9.21.1776076619276;
        Mon, 13 Apr 2026 03:36:59 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488df2a1237sm342390985e9.6.2026.04.13.03.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 03:36:58 -0700 (PDT)
Message-ID: <bc8ef831-a4ea-4d85-ab7c-a287c9b80e61@redhat.com>
Date: Mon, 13 Apr 2026 12:36:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
 <20260408231415.522691-3-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260408231415.522691-3-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-278032-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2423A3EAC2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/9/26 1:14 AM, Wei Wang wrote:
> From: Wei Wang <weibunny@fb.com>
> 
> The main purpose of this cmd is to be able to associate a
> non-psp-capable device (e.g. veth or netkit) with a psp device.
> One use case is if we create a pair of veth/netkit, and assign 1 end
> inside a netns, while leaving the other end within the default netns,
> with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> With this command, we could associate the veth/netkit inside the netns
> with PSP device, so the virtual device could act as PSP-capable device
> to initiate PSP connections, and performs PSP encryption/decryption on
> the real PSP device.
> 
> Signed-off-by: Wei Wang <weibunny@fb.com>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  Documentation/netlink/specs/psp.yaml |  67 +++++-
>  include/net/psp/types.h              |  15 ++
>  include/uapi/linux/psp.h             |  13 ++
>  net/psp/psp-nl-gen.c                 |  32 +++
>  net/psp/psp-nl-gen.h                 |   2 +
>  net/psp/psp_main.c                   |  20 ++
>  net/psp/psp_nl.c                     | 325 ++++++++++++++++++++++++++-
>  7 files changed, 462 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
> index c54e1202cbe0..3d1b7223e084 100644
> --- a/Documentation/netlink/specs/psp.yaml
> +++ b/Documentation/netlink/specs/psp.yaml
> @@ -13,6 +13,17 @@ definitions:
>                hdr0-aes-gmac-128, hdr0-aes-gmac-256]
>  
>  attribute-sets:
> +  -
> +    name: assoc-dev-info
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: ifindex of an associated network device.
> +        type: u32
> +      -
> +        name: nsid
> +        doc: Network namespace ID of the associated device.
> +        type: s32
>    -
>      name: dev
>      attributes:
> @@ -24,7 +35,9 @@ attribute-sets:
>            min: 1
>        -
>          name: ifindex
> -        doc: ifindex of the main netdevice linked to the PSP device.
> +        doc: |
> +          ifindex of the main netdevice linked to the PSP device,
> +          or the ifindex to associate with the PSP device.
>          type: u32
>        -
>          name: psp-versions-cap
> @@ -38,6 +51,28 @@ attribute-sets:
>          type: u32
>          enum: version
>          enum-as-flags: true
> +      -
> +        name: assoc-list
> +        doc: List of associated virtual devices.
> +        type: nest
> +        nested-attributes: assoc-dev-info
> +        multi-attr: true
> +      -
> +        name: nsid
> +        doc: |
> +          Network namespace ID for the device to associate/disassociate.
> +          Optional for dev-assoc and dev-disassoc; if not present, the
> +          device is looked up in the caller's network namespace.
> +        type: s32
> +      -
> +        name: by-association
> +        doc: |
> +          Flag indicating the PSP device is an associated device from a
> +          different network namespace.
> +          Present when in associated namespace, absent when in primary/host
> +          namespace.
> +        type: flag
> +
>    -
>      name: assoc
>      attributes:
> @@ -170,6 +205,8 @@ operations:
>              - ifindex
>              - psp-versions-cap
>              - psp-versions-ena
> +            - assoc-list
> +            - by-association
>          pre: psp-device-get-locked
>          post: psp-device-unlock
>        dump:
> @@ -279,6 +316,34 @@ operations:
>          post: psp-device-unlock
>        dump:
>          reply: *stats-all
> +    -
> +      name: dev-assoc
> +      doc: Associate a network device with a PSP device.
> +      attribute-set: dev
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - ifindex
> +            - nsid
> +        reply:
> +          attributes: []
> +        pre: psp-device-get-locked
> +        post: psp-device-unlock
> +    -
> +      name: dev-disassoc
> +      doc: Disassociate a network device from a PSP device.
> +      attribute-set: dev
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - ifindex
> +            - nsid
> +        reply:
> +          attributes: []
> +        pre: psp-device-get-locked
> +        post: psp-device-unlock
>  
>  mcast-groups:
>    list:
> diff --git a/include/net/psp/types.h b/include/net/psp/types.h
> index 25a9096d4e7d..4bd432ed107a 100644
> --- a/include/net/psp/types.h
> +++ b/include/net/psp/types.h
> @@ -5,6 +5,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/refcount.h>
> +#include <net/net_trackers.h>
>  
>  struct netlink_ext_ack;
>  
> @@ -43,9 +44,22 @@ struct psp_dev_config {
>  	u32 versions;
>  };
>  
> +/**
> + * struct psp_assoc_dev - wrapper for associated net_device
> + * @dev_list: list node for psp_dev::assoc_dev_list
> + * @assoc_dev: the associated net_device
> + * @dev_tracker: tracker for the net_device reference
> + */
> +struct psp_assoc_dev {
> +	struct list_head dev_list;
> +	struct net_device *assoc_dev;
> +	netdevice_tracker dev_tracker;
> +};
> +
>  /**
>   * struct psp_dev - PSP device struct
>   * @main_netdev: original netdevice of this PSP device
> + * @assoc_dev_list: list of psp_assoc_dev entries associated with this PSP device
>   * @ops:	driver callbacks
>   * @caps:	device capabilities
>   * @drv_priv:	driver priv pointer
> @@ -67,6 +81,7 @@ struct psp_dev_config {
>   */
>  struct psp_dev {
>  	struct net_device *main_netdev;
> +	struct list_head assoc_dev_list;
>  
>  	struct psp_dev_ops *ops;
>  	struct psp_dev_caps *caps;
> diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
> index a3a336488dc3..1c8899cd4da5 100644
> --- a/include/uapi/linux/psp.h
> +++ b/include/uapi/linux/psp.h
> @@ -17,11 +17,22 @@ enum psp_version {
>  	PSP_VERSION_HDR0_AES_GMAC_256,
>  };
>  
> +enum {
> +	PSP_A_ASSOC_DEV_INFO_IFINDEX = 1,
> +	PSP_A_ASSOC_DEV_INFO_NSID,
> +
> +	__PSP_A_ASSOC_DEV_INFO_MAX,
> +	PSP_A_ASSOC_DEV_INFO_MAX = (__PSP_A_ASSOC_DEV_INFO_MAX - 1)
> +};
> +
>  enum {
>  	PSP_A_DEV_ID = 1,
>  	PSP_A_DEV_IFINDEX,
>  	PSP_A_DEV_PSP_VERSIONS_CAP,
>  	PSP_A_DEV_PSP_VERSIONS_ENA,
> +	PSP_A_DEV_ASSOC_LIST,
> +	PSP_A_DEV_NSID,
> +	PSP_A_DEV_BY_ASSOCIATION,
>  
>  	__PSP_A_DEV_MAX,
>  	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
> @@ -74,6 +85,8 @@ enum {
>  	PSP_CMD_RX_ASSOC,
>  	PSP_CMD_TX_ASSOC,
>  	PSP_CMD_GET_STATS,
> +	PSP_CMD_DEV_ASSOC,
> +	PSP_CMD_DEV_DISASSOC,
>  
>  	__PSP_CMD_MAX,
>  	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
> diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
> index 1f5e73e7ccc1..114299c64423 100644
> --- a/net/psp/psp-nl-gen.c
> +++ b/net/psp/psp-nl-gen.c
> @@ -53,6 +53,20 @@ static const struct nla_policy psp_get_stats_nl_policy[PSP_A_STATS_DEV_ID + 1] =
>  	[PSP_A_STATS_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
>  };
>  
> +/* PSP_CMD_DEV_ASSOC - do */
> +static const struct nla_policy psp_dev_assoc_nl_policy[PSP_A_DEV_NSID + 1] = {
> +	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
> +	[PSP_A_DEV_IFINDEX] = { .type = NLA_U32, },
> +	[PSP_A_DEV_NSID] = { .type = NLA_S32, },
> +};
> +
> +/* PSP_CMD_DEV_DISASSOC - do */
> +static const struct nla_policy psp_dev_disassoc_nl_policy[PSP_A_DEV_NSID + 1] = {
> +	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
> +	[PSP_A_DEV_IFINDEX] = { .type = NLA_U32, },
> +	[PSP_A_DEV_NSID] = { .type = NLA_S32, },
> +};
> +
>  /* Ops table for psp */
>  static const struct genl_split_ops psp_nl_ops[] = {
>  	{
> @@ -119,6 +133,24 @@ static const struct genl_split_ops psp_nl_ops[] = {
>  		.dumpit	= psp_nl_get_stats_dumpit,
>  		.flags	= GENL_CMD_CAP_DUMP,
>  	},
> +	{
> +		.cmd		= PSP_CMD_DEV_ASSOC,
> +		.pre_doit	= psp_device_get_locked,
> +		.doit		= psp_nl_dev_assoc_doit,
> +		.post_doit	= psp_device_unlock,
> +		.policy		= psp_dev_assoc_nl_policy,
> +		.maxattr	= PSP_A_DEV_NSID,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd		= PSP_CMD_DEV_DISASSOC,
> +		.pre_doit	= psp_device_get_locked,
> +		.doit		= psp_nl_dev_disassoc_doit,
> +		.post_doit	= psp_device_unlock,
> +		.policy		= psp_dev_disassoc_nl_policy,
> +		.maxattr	= PSP_A_DEV_NSID,
> +		.flags		= GENL_CMD_CAP_DO,

Sashiko notes that the above allows deleteing an associations bypassing
the netns boundaries. Do you need ADMIN_PERM flag or exlicit checks in
the doit cb?

> @@ -292,6 +455,145 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_dev *psd = info->user_ptr[0];
> +	struct psp_assoc_dev *psp_assoc_dev;
> +	struct net_device *assoc_dev;
> +	struct sk_buff *rsp;
> +	u32 assoc_ifindex;
> +	struct net *net;
> +	int nsid, err;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
> +		return -EINVAL;
> +
> +	if (info->attrs[PSP_A_DEV_NSID]) {
> +		nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> +
> +		net = get_net_ns_by_id(genl_info_net(info), nsid);
> +		if (!net) {
> +			NL_SET_BAD_ATTR(info->extack,
> +					info->attrs[PSP_A_DEV_NSID]);
> +			return -EINVAL;
> +		}
> +	} else {
> +		net = get_net(genl_info_net(info));
> +	}

psp_nl_dev_disassoc_doit() has the same code; perhaps it would be worthy
move it in a common helper, called via pre_doit()? It should also
simplify the cleanup paths.

> +
> +	psp_assoc_dev = kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
> +	if (!psp_assoc_dev) {
> +		err = -ENOMEM;
> +		goto alloc_err;
> +	}
> +
> +	assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> +	assoc_dev = netdev_get_by_index(net, assoc_ifindex,
> +					&psp_assoc_dev->dev_tracker,
> +					GFP_KERNEL);
> +	if (!assoc_dev) {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
> +		err = -ENODEV;
> +		goto assoc_dev_err;
> +	}
> +
> +	/* Check if device is already associated with a PSP device */
> +	if (cmpxchg(&assoc_dev->psp_dev, NULL, RCU_INITIALIZER(psd))) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Device already associated with a PSP device");
> +		err = -EBUSY;
> +		goto cmpxchg_err;
> +	}
> +
> +	psp_assoc_dev->assoc_dev = assoc_dev;
> +	rsp = psp_nl_reply_new(info);
> +	if (!rsp) {
> +		err = -ENOMEM;
> +		goto rsp_err;
> +	}
> +
> +	list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);

Sashiko says:

---
list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
There doesn't seem to be a limit on the number of devices that can be
associated with a single PSP device.
If a user repeatedly associates devices, could the generated netlink message
in psp_nl_dev_fill() exceed the maximum allowed size (GENLMSG_DEFAULT_SIZE),
causing it to fail with -EMSGSIZE and permanently break PSP_CMD_DEV_GET
and management notifications for the device?
--

/P


