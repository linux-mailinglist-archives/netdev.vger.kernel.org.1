Return-Path: <netdev+bounces-291881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FOUJt7sFWogfAcAu9opvQ
	(envelope-from <netdev+bounces-291881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:56:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D525DB9E7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FCC13035F07
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304AA3C063F;
	Tue, 26 May 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHwT1tLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07423BB100
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821786; cv=none; b=AoGYqVRAHU9/k90amQNezTIy0LZNbb9X7d4XeTNRRWK5oZXzLa234uwz8ZQcch3Zq1HvQHYyFoy9d882Vig6n8tRNvt7eG4J33ntf3j6WfUoLhaMMchVWMsN3tBwHX5J6uZJ0QsEUk085ogxy6HNOeagTb22T+lonN2ZfOD/Zjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821786; c=relaxed/simple;
	bh=XqMY26u2z+xwaIKr9ECgFka/1TWOtkcS8KQI6YYzcek=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Eub01j4FEY9VYeDSc/8AlFzfmE1880cLFeJ39LgXvTNUmIN2shjp86/aqQe6jKAn3lpbDp6vgAg1n62kz4DZVLp5+mqeEbealD0Wx7DB3V5zs+WmUC612fV6GjLW4aZyjNjor572xgKMSEtqakBulc5fv5lBiAmRjFYs2lrd3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHwT1tLn; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7cb343d343fso101946327b3.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821784; x=1780426584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaXK4ycTk/ak0Eg13tSj70uvX+GVGk/yxG0GEJXhDVk=;
        b=SHwT1tLnqyMQoW7tOZzKVFOVr5n4BWKqWm/pvI4UZjDc7JGX1nMq5Nu5DBmeL1yBiU
         t6japKJpK/LEDAmbm+KMh+JapmI30roY2gpCdEkNc+Fi9V2KRZus48u/oIQYAeXICgo3
         x5WHHZLJbK90Ca9JfjGy2ZsZ/5iD2yFSG+58ypwzUWXJbSF9YWdAh2MyigJUjiy92mmq
         rpYDRBdUYpdjA5T8iL9aDCVALydEurXdMnCiFFP8OfsBTYnyBL90P0tGyVnex5d0VDYI
         juGmb5+pyAMQIjIh4L22xdpbEWP/boLOozBqmwHGrldy+IEb+eYcHNe1N3mBvI8bw5k0
         ofoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821784; x=1780426584;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaXK4ycTk/ak0Eg13tSj70uvX+GVGk/yxG0GEJXhDVk=;
        b=DYHJObcvn8FctWrpXpC07p2YA1ikSUS9SCjmXPu6VqG7z5uIiAvquYVv94lrcaXi6s
         W32qh5aZVhWvnBmt0fcDPRzaQbfDKRX82aNb8+LfOHD7v/KjmsuEOFWjmnePqseaLe0Q
         IlMRtv1lDToS9XudLmdYFy5DabeJJ0EsYIFjBiq3OJLZKiy0QxeC5uincjxHeVveDJ0v
         T+A30gtkEr6ea5vEGy0m3eRwpnx2vEKw/AKcge/MuibyplzW0Z4U+UQkk24Ke1FVfDHd
         O3Mpzj24WfMwALWp+hvFln2XCc1MWcjUgDTgRYFiuXbFZYCKQIqeT8yS24apFhe41CA1
         Y/qQ==
X-Gm-Message-State: AOJu0Yzr1OpLt2ok3WvU6uFlUJUM1NFRoKFE0ZjJ9VCFmZdaE/62OdVM
	6apyyptOdQtqjAPXQouP1ndj7lFNNfcJkfyuda4AMw+EuWSWsj8CNNdY
X-Gm-Gg: Acq92OG2DSThm0P38G9coxl9b/hPM2z7EpVmffk142NrpU9avkChqVLUYnBw0Wp/ca6
	6VSbLdizXXtg0DFbEWmEgwebfGA3KuokkW9Pk2EoiJjv6wN1wH0m4bQR7bfle/50MkRCHDWSS6A
	nrB6uul/230jQd1sR3OuN5eBlsTBZ25nS6a5rGHllL3YW2t7pKS0DEprrWRBjRA+gF9v8Nux1sh
	RPg5+zA6m07myarkmS53LLHuM2I6wgefexPJMUgW/0vG54XLTPjUbUpc0YtLfL/5l9XX6AetKiA
	FZJlg8udMqnQSyfc6+A9mWAOOjcgr5FjCUbBldsflI+9/N+2miSAc3Go4yEsZ2UAcBvXF9zP24g
	bC0M9XPXnoCtFpZy8IoMbW177Cgdl2+d4BRV66pOjgl+gVU7/+K9mEYkQjFCPS3wLLquHlWfzBj
	xULsoOUw6P77s8QWMcwftoKJVgEJaxUHgkLCxWgFgqUR5ayTCJFlItUlhLo6ytVoSl6S+/1rUwr
	Gwr2Mw=
X-Received: by 2002:a05:690c:a94:b0:7d0:6155:480d with SMTP id 00721157ae682-7d333bd8497mr226499607b3.5.1779821783527;
        Tue, 26 May 2026 11:56:23 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c33c935sm64694427b3.36.2026.05.26.11.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:56:22 -0700 (PDT)
Date: Tue, 26 May 2026 14:56:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 corbet@lwn.net, 
 vladimir.oltean@nxp.com, 
 willemb@google.com, 
 sdf.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 jesse.brandeburg@intel.com, 
 linux-doc@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.1975ceee9d4ce@gmail.com>
In-Reply-To: <20260526160151.2793354-9-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
 <20260526160151.2793354-9-kuba@kernel.org>
Subject: Re: [PATCH net-next 08/10] docs: net: add Rx notes to the checksum
 guide
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291881-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.754];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 09D525DB9E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> The Rx checksum processing gives people pause. The two main questions
> in my experience are:
>  - what to do with bad IPv4 checksum; and
>  - what to do with packets with bad checksum.
> 
> Folks often feel the urge to drop the latter, to "avoid overloading
> the host".
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks, this is is an important clarification.

> ---
>  Documentation/networking/checksum-offloads.rst | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/checksum-offloads.rst b/Documentation/networking/checksum-offloads.rst
> index 907aed9f3a3b..d838fe5c1606 100644
> --- a/Documentation/networking/checksum-offloads.rst
> +++ b/Documentation/networking/checksum-offloads.rst
> @@ -19,7 +19,6 @@ take advantage of checksum offload capabilities of various NICs.
>  
>  Things that should be documented here but aren't yet:
>  
> -* RX Checksum Offload
>  * CHECKSUM_UNNECESSARY conversion
>  
>  
> @@ -139,3 +138,19 @@ In Linux, RCO is implemented individually in each encapsulation protocol, and
>  most tunnel types have flags controlling its use. For instance, VXLAN has the
>  configuration flag VXLAN_F_REMCSUM_TX to indicate that RCO should be used when
>  transmitting.
> +
> +
> +RX Checksum Offload
> +===================
> +
> +RX checksum offload is controlled via NETIF_F_RXCSUM. When disabled the driver
> +must not set skb->ip_summed on ingress packets. As mentioned, IPv4 checksum
> +is not offloaded, the RXCSUM feature controls the offload of verification of
> +transport layer checksums.
> +
> +Note that packets with bad TCP/UDP checksums must still be passed
> +to the stack. skb->ip_summed of such packets can be set to ``CHECKSUM_COMPLETE``

when also setting skb->csum

> +or left at ``CHECKSUM_NONE``. Drivers **must not discard** packets with
> +bad TCP/UDP checksum and must not configure the device to drop them.
> +Checksum validation is relatively inexpensive and having bad packets reflected
> +in SNMP counters is crucial for network monitoring.
> -- 
> 2.54.0
> 



