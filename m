Return-Path: <netdev+bounces-276905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePivDMpx12maOAgAu9opvQ
	(envelope-from <netdev+bounces-276905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF583C8831
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 851013009F05
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B13B27E8;
	Thu,  9 Apr 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi1MI/En";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WywTF7/H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8C3B19C1
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727010; cv=none; b=LV3wZE1q92kRsxb7ZoPYmrqEgWlNPPovW3x2PgYR6bCpkiGzrzGbsrmUNeauiQMv1EOibm2THhTyZ+AX/rGTf2LfZOG0c23nFa6gElcoB0wdZPhd+EowMGeDVn1VQ6ZehnfB1ijg11WmdBNKBp8H0JVf7wN5DJ4WgKD/RyUjA34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727010; c=relaxed/simple;
	bh=utBpeyHf5B9ahcaUGjVmSVgU73UuCO4p44e+rDod+3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUTyWkURSFurdRCrnSjFcON8xIj4/z+VWC33jmnGVAcLmo1Cvxjws+6FlKzSxOZFUNM8XM1YwXRynaO6ng1MbwyD+c7v5wpgkJq5+VKF70nFEcVIpxfKhCAUOeKT/RroDcJMaFrJtEXh0qitkFxzft32bMmFKzJpptvJ4JrJxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pi1MI/En; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WywTF7/H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775727005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIlu63YYxk1ewnvHFxHuvTVCREVfM3vbRJ7L4z4Sf6g=;
	b=Pi1MI/EnMpQVY52juBG8bFisabfHArq2+dpi7L7hc+Rpwi+nB5wmtAM5bvdFUYiINqxTq0
	QLl2SKnwmWC9Qzb2g6bRF1nbDWccKg8+Q5bGnt7YCaH4i5Qa3zOrBDK0NLJsJIGpmsdcv0
	EkKyDZYmA2x/GLGzhPWOTSlh4wdTRls=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-KpPOIqRJP7yNZLUys_oFzw-1; Thu, 09 Apr 2026 05:30:04 -0400
X-MC-Unique: KpPOIqRJP7yNZLUys_oFzw-1
X-Mimecast-MFC-AGG-ID: KpPOIqRJP7yNZLUys_oFzw_1775727003
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d177fb157so531418f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 02:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775727003; x=1776331803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIlu63YYxk1ewnvHFxHuvTVCREVfM3vbRJ7L4z4Sf6g=;
        b=WywTF7/HmZm/umTInvRb5287rh4l6c04+z+5KdDWK7jV7fNCHshJj0gI44oSgTcvT2
         1SKo/vzqhVulm5gyf8F5WfRzFtiYDtxwAsI09hx5HZG9dTrtlhr81h3Cy5SkGXaa1g3s
         9eOzIzJppNocLtn0YHbm2OOYs9sOQSAtvEIspzZNqXP3afl5HDv2FGpWWaCMK85XAIW5
         qB9hblo9XX/ctiaKXrpfO8zc1i4Wz2iVi/mxvFcGLonNXfkGFwMICb33rVk1iLUNkGyG
         6UM6eOG2XZs/UJiI8fvLUTBFeHkv5LjTMlymfmt1GKZDl583ayViAFTzI+er67jA18Ik
         W7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775727003; x=1776331803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIlu63YYxk1ewnvHFxHuvTVCREVfM3vbRJ7L4z4Sf6g=;
        b=apJavm7SJxGCmoj9kwwztmzYY2Y6w0nsdkuW7aLDZAoaTn0CeZibCB8S6BaUgE7/aY
         YUGc8LBT3FCekjWouRLLzmtNLSOOvW27uPULG7fo5uae1oQXW+VkugyGMyAl0mRc9GId
         TyI9KsU8xB9kF59//lWmAq2p8jkthXbRAwMae8tKf0L2jgz5WPn5MPSTviSGF7efF2gM
         jKTFMfC/DH4Iar2adbwIRTmdmAL3SlL5NKzl8ixb7+s6gTAJRrLbQFVVEvKbxcodv+14
         AzoMSCOESWukHQnrOhGjc5f4GkFMrb7gtOGYIbt5ojNb2v6Wy/fHsNoCKtLEHV7xhRhn
         3mrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjinw7+2l9j6OkrvLiyZSu9yflHJVP4tNU1P2kOBqhQiyMT42jpCWt3nnmTQ6KaWID4TeUous=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzh8xI1gBsTQAHBjKuOcjXt1J/lPftxa120iJZrqKEJyZSDBxZ
	Y3uw/wn8Qg2gAjrfEhoYdmnK0kFeU7ZkTICRrNLbyCPfL3xfOh40/bcHZQlbGOdeFGU2sXdRCQ6
	byruBXLGRQNhHiVQssR+BLFJScWf0Y8Wm3FemZeDOJj72MieAHd2rjkSzBQ==
X-Gm-Gg: AeBDieuEYLfKpofMm+ot86eGYbdXdJ6UngMS7K292Rqi9PCx4cgrkBQy0WkwZuFQ75y
	1nu5/0unEQi2e5e+95S5swgOw9dq81O8A/7e6kZQZ+K7ShoMUhz5ur02Vq3YBtVa6208+OaPWXY
	p2z5kWpDnk47DK3H9vVOPVX3L1xHR2O0dXS7lnUCTpTmMgbabHEfjfMcc3NII8VC/q+Gy6SvUGx
	lwjbyYm/xmW82MUTN7HbCgmgmc9pQR2YPqNHXrjklSjUYU2lyfzqSZGqKghKupxL8KCgHqfmoca
	THdq1P4Yk/K5twJ/zWyGW6vquXkcIgcgLgxrKhOwfvDdaHrJn/v0/XPlvdEE1WJMAuOyahTuqKN
	JRVLVDZUahPC3V3RgGGQZJJJd6w8nrUdsh9AnVjk9KXPFVCaDTQn7fZ8v
X-Received: by 2002:a05:6000:4305:b0:43b:50d6:4f04 with SMTP id ffacd0b85a97d-43d5a1a274bmr3681982f8f.38.1775727002730;
        Thu, 09 Apr 2026 02:30:02 -0700 (PDT)
X-Received: by 2002:a05:6000:4305:b0:43b:50d6:4f04 with SMTP id ffacd0b85a97d-43d5a1a274bmr3681929f8f.38.1775727002228;
        Thu, 09 Apr 2026 02:30:02 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d473b8c1esm25684356f8f.12.2026.04.09.02.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 02:30:01 -0700 (PDT)
Message-ID: <36e86b68-f7d9-4455-a0b5-613f717e670a@redhat.com>
Date: Thu, 9 Apr 2026 11:30:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net/sched: netem: add per-impairment
 extended statistics
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260403225324.476787-1-stephen@networkplumber.org>
 <20260403225324.476787-5-stephen@networkplumber.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403225324.476787-5-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276905-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CF583C8831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/4/26 12:52 AM, Stephen Hemminger wrote:
> diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> index 66e8072f44df..fada10cb9b7b 100644
> --- a/include/uapi/linux/pkt_sched.h
> +++ b/include/uapi/linux/pkt_sched.h
> @@ -569,6 +569,15 @@ struct tc_netem_gemodel {
>  #define NETEM_DIST_SCALE	8192
>  #define NETEM_DIST_MAX		16384
>  
> +struct tc_netem_xstats {
> +	__u32	delayed;	/* packets delayed */
> +	__u32	dropped;	/* packets dropped by loss model      */
> +	__u32	corrupted;	/* packets with bit errors injected   */
> +	__u32	duplicated;	/* duplicate packets generated        */
> +	__u32	reordered;	/* packets sent out of order          */
> +	__u32	ecn_marked;	/* packets ECN CE-marked (not dropped)*/
> +};

Sashiko notes that the counters size will be set in stone by the uAPI,
and u32 can wraparound very quickly (especially for unconditional delay).

I see other qdiscs generally use __u32, but some have __u64 too, so I
assume there are no architectural blocker to larger counter.

Could you please move use __u64 above?

Thanks,

Paolo


