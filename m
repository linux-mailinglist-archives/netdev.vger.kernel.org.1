Return-Path: <netdev+bounces-295133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W27CI3hFIWpJCQEAu9opvQ
	(envelope-from <netdev+bounces-295133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:29:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F163E8A8
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:29:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=SnPPUjs3;
	dkim=pass header.d=redhat.com header.s=google header.b=qApYtqVM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295133-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295133-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C0CE31A0E89
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACD73FE679;
	Thu,  4 Jun 2026 09:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553433FE357
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 09:11:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564302; cv=none; b=kOb5jmdIEyRh84vj+orlRR42u3X/4tM8czbgk5f1rabtXUzqKAHbqfHakQoaVs9axgv1VJkZEYvZbwe1GqWiX1pORbTMzqzrPCKZuOntsKCGwU90oH/1+gYYEOCI47uqjAxxYByew7EDbuqB+tS9v/KjcBwrKDp5etDxVTuKmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564302; c=relaxed/simple;
	bh=ENzABfFSnHZNTaseRBhTe76JslvG9/OVWebygGCYPMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MP+77xhofIr4SAhwtvhCsj85IPrMpdUyrB+m4hE+yiAyV5HwkE1BHwRtn35ykwwzqWk7u+DrKRF4Nve5KtvjPcv7i0Tv8vtKxgtF+Kz3d8rC9Doa15s+yFAxRz+MCQ5hHCYRk+s4omkg4XPy0VNMgCQJqOJH7NrqEdidR9htdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnPPUjs3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qApYtqVM; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780564300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PocJ/NUTE4E0S5HeZhCaCIbuyAspIpMbmuzKuC8QEOE=;
	b=SnPPUjs3OASKpW7IIZOK9EoDaD/S6hCwr7J5eHyr0iluyRpqS+COiTqu1F8q3CSM5MhblS
	K6/gAa+Q8DVXsduqqP8KAX8X9nFQ5rGqK/QyaZtSAN/e4rFWWjoqawcEYc4nCzNZ0C4T6+
	oJ9DiWMRHU6bwZEncopxgX1ilY1M6Ko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-NIkNsO4MMB-IO3iP08KZGQ-1; Thu, 04 Jun 2026 05:11:39 -0400
X-MC-Unique: NIkNsO4MMB-IO3iP08KZGQ-1
X-Mimecast-MFC-AGG-ID: NIkNsO4MMB-IO3iP08KZGQ_1780564298
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46010392f89so430528f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780564298; x=1781169098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PocJ/NUTE4E0S5HeZhCaCIbuyAspIpMbmuzKuC8QEOE=;
        b=qApYtqVMLhtFBvZOMR8MvIo8M6U79xYT/EjHb308ZJo/P0dkjFK7ej4BRcb/wcnBJg
         aSgehy12ZhtNiYqc3VJrbWSUFRrQdhB42yeFTKsuONYdKnvPC6wea++7jFF/+2wfK9gG
         VOI2wIZ8J2yrT0xaeTsAaSb10OVP87hZQEnK2RmaRpjgYwv9Ic+HcQGOc4vrm+pien4Z
         j3YPbXTMtbrHmH0kn6+I5s+99oo4Bk/QzUq/a1awNKMP+9hX+KxiMQSq7pd1V4UEShWA
         w93FF4N6afAWLuumui81pQ1at2tcPFdsmz8hXZHJ8eZH07GBI81OcdBXbVKAeBGGLfcT
         1c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780564298; x=1781169098;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PocJ/NUTE4E0S5HeZhCaCIbuyAspIpMbmuzKuC8QEOE=;
        b=C0UURyejZz3Pm8cQxoumD/vGI2S2CMk5dxPiG9K5z4UOvE1uwp5RL9pInzuGaGxhhW
         kPl9fo5/AqiEH3jxVWnj6ukW2Js/KEH8FfhMgyFZ8t3ZGqK/o6mVqoLXJCKCeaveNOWh
         ITQDKLOMh7fwR7VALtoWgnc97STrubMIWpK+RDNT3frQx/FXoXbs1I8DPZTHfp5q9rrw
         0c4MxfhMhyiNBhAj9CWtjfLbn7huImkbVX/MZG51WxRhCvKWWuRlzAlnJrEjaMUlSU1v
         X9oIUM75dMX1txaxiscES/Rdkg/sNV4ZEK9dTVHrbb4JLlJRmiEagIe8ou8PcwjE7h70
         EeRA==
X-Forwarded-Encrypted: i=1; AFNElJ/hMQH6+Vo+zeWn+DVo8Dhp3al6eMBg7cHzb/QM9VPOJzEX7iyGk5fa0HUUptrSAFthR3PVubo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsZ6yazhm8R/js5h64PpgC/f5jK7WydBuZhQOtBtgio5tMcj+
	TURHXGzQdc1q6L1H3L9638tjGwIha/OTKO9HXpMLX0nAAJg5jpKlhIXPM3/FcTmdeAOU6mgy2oI
	uB4HDKrM4QEhqJoHYgYVDMWdb/Rk7jRYjo4BaV/mRrfGUlfhgxz+Gtwq9DQ==
X-Gm-Gg: Acq92OH/mAnEJdqIFcgpfLu2pHldTFXNLh82qHxBkBtcTAfvyP/Zv66gY3Tr3gpSt20
	IONyoW2H9q9vQQoWE4zgz7Go+92wLrRt7Uiqsin5lmY6rBcgqhfj/0lHwGHJMqRjTpRpoHk3jog
	xyTh2BcCQRyOq6cjlq7FE4mn18PE2gQ3FPyfojMeH1MUwtp2/RTs3VzvIs/nqH66Q/yQQ6iprYo
	DB85oy34IZ4tlZE2hYaGrQMHmllQU0i+WK2TDkZbd1NqLdrsvBXMQ3nnobIrsaN7K3guoLFOfbx
	SkzG2CE4HPlPcTPgOFW5LO4RcJ/kxf/H04kFcEx2fOjweYlULgbGlVjPGUKYZLg1DyL/bbuezxZ
	zyeMNvn6smrG3IkGVCyZXhRjaAWrD9bFDKOmLpDODa9ftUo9aio8Oy2wtbcu7ZLK3dY0=
X-Received: by 2002:a05:6000:491d:b0:45e:edcc:f6dc with SMTP id ffacd0b85a97d-460216bd84cmr10725913f8f.6.1780564297741;
        Thu, 04 Jun 2026 02:11:37 -0700 (PDT)
X-Received: by 2002:a05:6000:491d:b0:45e:edcc:f6dc with SMTP id ffacd0b85a97d-460216bd84cmr10725848f8f.6.1780564297247;
        Thu, 04 Jun 2026 02:11:37 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm14825452f8f.0.2026.06.04.02.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 02:11:36 -0700 (PDT)
Message-ID: <95adff35-ee56-49d3-8567-382ac17810b3@redhat.com>
Date: Thu, 4 Jun 2026 11:11:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ipv4: igmp: annotate data-races around
 in_dev->mc_count
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260531030705.3754389-1-yuyanghuang@google.com>
 <20260531030705.3754389-2-yuyanghuang@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260531030705.3754389-2-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295133-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:yuyanghuang@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D95F163E8A8

On 5/31/26 5:07 AM, Yuyang Huang wrote:
> @@ -1922,7 +1923,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
>  
>  	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
>  		in_dev->mc_list = i->next_rcu;
> -		in_dev->mc_count--;
> +		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
>  		ip_mc_clear_src(i);
>  		ip_ma_put(i);

The patch LGTM, but note that sashiko has identified a pre-existing
issue which could deserve a follow-up:

https://sashiko.dev/#/patchset/20260531030705.3754389-1-yuyanghuang%40google.com

/P

>  	}
> @@ -2974,7 +2975,9 @@ static int igmp_mc_seq_show(struct seq_file *seq, void *v)
>  
>  		if (rcu_access_pointer(state->in_dev->mc_list) == im) {
>  			seq_printf(seq, "%d\t%-10s: %5d %7s\n",
> -				   state->dev->ifindex, state->dev->name, state->in_dev->mc_count, querier);
> +				   state->dev->ifindex, state->dev->name,
> +				   READ_ONCE(state->in_dev->mc_count),
> +				   querier);
>  		}
>  
>  		delta = im->timer.expires - jiffies;


