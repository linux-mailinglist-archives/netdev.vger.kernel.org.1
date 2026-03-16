Return-Path: <netdev+bounces-268126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKjSIirrt2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:36:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F5298C4C
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2242B300A616
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785D133ADB8;
	Mon, 16 Mar 2026 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/yymGbn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDppKzRu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF00734F275
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660685; cv=none; b=PhegS5Ry4v9+/UfAZyM8Ud/rCTuMmGU2D8oRMV3AsF8TbXEF30vVK52xQSzvgpxpWhbD7VPRo78fLw25+CKpnl4JE5GOGhQ6R1y3404nUdrs/d5I4wVaXHZAmnPBIDKcE1/KuyxHSlPAhpGR2prR6jAX4E8pw+MjRgoSW2Xbypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660685; c=relaxed/simple;
	bh=RnzcoqiCgiO1PMBkGL95IiCkLD+8z6QAFA5shSuEMyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKCDgIcGMFA+3zDKxKr5SnLAsA3Ou/YvVh+OTa5g/+e6ao89s+fF8OFXs/FhbCtkeebIeBEaEkWP1htJD1x2v/DhzJgiy9cWoFglTp56NXhg+b82VOy78hNdpi69CMsshCJugR9ptzHwwAjHNu+qMxczLOFPaumWn2gAU4fyktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/yymGbn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDppKzRu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773660682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
	b=d/yymGbnR6Zo4Cp56EDz80mzlMy73/hUUT/ZOtUs3LWua/Nq+o1rsGONOBkzMkgAdn+rY6
	GVD5Ei4bDiHg0biABtDnPnmVWTC0PDUTLQ9q0teeZLXYoprPVZMrl6D77bBIo6Du8+uIsQ
	57JpZ/JmDN59mc/Zwze0R8yPmGkLerc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Ir7TRaoONjm2d_RVJcrrqg-1; Mon, 16 Mar 2026 07:31:21 -0400
X-MC-Unique: Ir7TRaoONjm2d_RVJcrrqg-1
X-Mimecast-MFC-AGG-ID: Ir7TRaoONjm2d_RVJcrrqg_1773660680
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439b3011be7so3024502f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773660680; x=1774265480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
        b=UDppKzRuU7Pe/GCKKqNYcueBD/LliCnEK3jXMx4fh0840B2SsiFqRidgEEIePWreL9
         5Mf0ZttplO9N+IdusUXUFUS7Sv2fP17FngrSaqIcxDn3T+0tGaORf9IkRCm/M7yZl9TT
         wZR61g1b1LFXUEICy3rRgeQH69lsBzd8t0XA55QmuJVRFIxJ4a2nrT6rk0JuqrY52YuX
         l4YZaIqIEwY/xVvDXZy93egx2P1b3S7E/yxMEq+aGm9KImJOZFA8qX0NrdewW9Qar2jK
         K5lLAcJyXy32WtU+ohOVQL5Uv/3c0ZpxJMxL4reuLFykINnhp78lAJ4iNkORGmACj73r
         7DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660680; x=1774265480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoMK2QRfTtUly3K0u8u4VXZMMCNoL+hLg9jh7niAtnw=;
        b=oFW5ec2JT795xzUAEe+GCxaw49sVyFoKF6yTcH1M7bqN6gAxFafa7sBluqMFCWRG13
         mZYzNXRAinZnK2KcH/mfqjAfhN6rqxa3W3Jnz5ADE7R3TdQM+Rvgzu/k29F+5Bvip2gt
         DkMX5Ee6txhBTKQvLUpIaArX37zcNcQLs6dDImgo/odRiMq+oZzywVEdkNtesEpsO0TX
         0MDd5pVDy8SdCvkKodsVE3e92lFih8eI39cegRt8GI0DJeBzAQPExyJD16REUubthJmX
         EC6PVVQl7kjAiEqyA+xOIRB2EmuEVlw81xTOgr6ePZfw46LWph8flE2flLtlULxOAEWh
         dIWA==
X-Forwarded-Encrypted: i=1; AJvYcCXXhNf9hix8DJ4QLBk8+PlLBX3WJeRGFg0T5633HwzSiTwIrYGcoB2N6CQau2+njQK0pF2RX9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcPzeReG6UiaVdpZGJ6OmjH83zInXtXhw7bBMitmoSxJ6Sx+4w
	NwDQIFPsFsxa6KyHb69DmzQDnP9rnY1jZuwNowvVXaZTzf48Dq7vuQI0I5EYKn4szMar6KKKNzV
	DU3tmGao2la8mdEublLdwfU3cyoLAVfSPKms/72l/S6P+7cHDNd51bMj+nA==
X-Gm-Gg: ATEYQzw3D1cwQYDrL1vkGjY2ct4IOPGJ9+kCuQvinYo/FOvJCvITDBWTszmuGuipUZw
	B/hCDvWVnhN2IiCaCAuL9SGyRHCi9ukFNsdXm8xuaZXuyt4Cx8CO/e95CkvPITWmVFDTrHQlte2
	uWcc/L99DTFWEqIuz59p5a115sS194qpK9F2iw4g1cbKEXgFV2lp71lvY95FRTSFl/ic1xd2Sol
	cpYx2N3hJnkJVWwOV80ykJrNRoCo+MjGXdzd9v8JLkcF3p9Mxuj4+V6Uw/jNBnYnzgI7F1hti/s
	RBIyEYHVieZ7r++0eOLMGD+a4vLD40xbef4nhWqv2i05FzavzCGY3hO9FGclvNJAiVrKr6Mez9I
	nWikr/cFETLbO4m//j5NtURb/cLUtd3bTPPJh1O7HfA1WRleqA3d9SDI=
X-Received: by 2002:a05:6000:1887:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43a04daf124mr23932743f8f.27.1773660680179;
        Mon, 16 Mar 2026 04:31:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1887:b0:439:fe98:20f9 with SMTP id ffacd0b85a97d-43a04daf124mr23932679f8f.27.1773660679649;
        Mon, 16 Mar 2026 04:31:19 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a0b2e2c71sm28145619f8f.22.2026.03.16.04.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 04:31:19 -0700 (PDT)
Message-ID: <95ecd36e-e32f-4ca2-ba35-6d251a64ad30@redhat.com>
Date: Mon, 16 Mar 2026 12:31:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] tcp: grow rcvbuf to back scaled-window
 quantization slack
To: atwellwea@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, ncardwell@google.com
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 dsahern@kernel.org, horms@kernel.org, kuniyu@google.com,
 andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 skhan@linuxfoundation.org, corbet@lwn.net, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <20260314201348.1786972-6-atwellwea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260314201348.1786972-6-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268126-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 073F5298C4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/14/26 9:13 PM, atwellwea@gmail.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 57a2a6daaad3..53781cf591d2 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3375,13 +3375,24 @@ u32 __tcp_select_window(struct sock *sk)
>  	 * scaled window will not line up with the MSS boundary anyway.
>  	 */
>  	if (tp->rx_opt.rcv_wscale) {
> +		int rcv_wscale = 1 << tp->rx_opt.rcv_wscale;
> +
>  		window = free_space;
>  
>  		/* Advertise enough space so that it won't get scaled away.
> -		 * Import case: prevent zero window announcement if
> +		 * Important case: prevent zero-window announcement if
>  		 * 1<<rcv_wscale > mss.
>  		 */
> -		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
> +		window = ALIGN(window, rcv_wscale);
> +
> +		/* Back any scale-quantization slack before we expose it.
> +		 * Otherwise tcp_can_ingest() can reject data which is still
> +		 * within the sender-visible window.
> +		 */
> +		if (window > free_space &&
> +		    (!tcp_rcvbuf_grow_allowed(sk) ||
> +		     !tcp_try_grow_rcvbuf(sk, tcp_space_from_win(sk, window))))
> +			window = round_down(free_space, rcv_wscale);

It looks like this can cause the advertised window to shrink even if we
are in the 'do not allow window to shrink' branch.

Also why the other branch (shrinking allowed) is not touched?

/P


