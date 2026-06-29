Return-Path: <netdev+bounces-302565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 43tNOrtOQmob4gkAu9opvQ
	(envelope-from <netdev+bounces-302565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:53:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC126D9146
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LKgYscuL;
	dkim=pass header.d=redhat.com header.s=google header.b=fcz85BtR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302565-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302565-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34FDE30008A3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 10:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B67352C52;
	Mon, 29 Jun 2026 10:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47723630BA
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:53:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730422; cv=none; b=eHvKg99vEq3dWyWynWw4hVS+jkph9xZyLt8L0QbgX9n9/3b8NOj60Rw3Axpq8qiMSGXUmdAljZJAf3RbTo+QA1oxmpcMYOUsEyjLdD/Fkn8ZljBpvigfBParjC4ynLFjtHwUkwLw2ZTQLBSNsKXhNSZHEc74pO7sNRfMjj30/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730422; c=relaxed/simple;
	bh=VROcJ4/7vOil53J2NbkDUAE98tEUYWmTCtxqaLTGSm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDNiG66Vc+lEnzCwNSV8K6gpV9y2IHMMM4o+hUumOD52SCuRkTZuYJ8ju4XyeaPckRgnQQPozcynxACwe/wZ6KHdBy0j6cmQsxAPVBNmkmmo0IhO9Pa9Bg8bU/xLjrv91V7xQGMq0RHSoCXBqELA4sEERc6x3Vyqt6m9QBY1iXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKgYscuL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcz85BtR; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782730413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/IO1ZooLtRgExgFDTANPx/TSDVSN8NUTyd35xKP2q0=;
	b=LKgYscuLOilIwqWjeE9GpEZ+ff6cpMYeEn6abIgO7DxDl2TlV76Iqy76uhAaz3jalYp+E+
	z1nIbhU5tKQqyCb7cBGg9wrKDGeJAQuEaGEV3r4LorWtY3cN0U0v0BZCj2E1TD0LtnfxtD
	1cL/R5rB67DLE0tglUsEOh73KzxuZYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-SIsyp9zNPMCm4CaKT-pR1Q-1; Mon, 29 Jun 2026 06:53:29 -0400
X-MC-Unique: SIsyp9zNPMCm4CaKT-pR1Q-1
X-Mimecast-MFC-AGG-ID: SIsyp9zNPMCm4CaKT-pR1Q_1782730404
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so25045045e9.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782730404; x=1783335204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/IO1ZooLtRgExgFDTANPx/TSDVSN8NUTyd35xKP2q0=;
        b=fcz85BtRxro94ZZc7cvSawWnGHhWrbggCy7J/s1d5apn89lFD1ubbrmNbPwUNzUztu
         6sisNHC2A9PlSYXRO1+PeQPKioC7pYem7o6rkwU6xaGL5ggX/LZiMo5CZOXEnxcLK4FQ
         KO7R+UFcEIRDvRloTdzBY2YfRmZGlwhfJu1o6YUDMeFDu9JryUJZWKCHgOxsPs4zDQDm
         UwUsrTSizvVQmYH6jYyQVwOcWNRTFNaIw0dCti9IrQUrEXX2hTaVuuq7BhuNtwX3JGKl
         QN154f44vQyBFQZcGZ1PLPFxFgxbPW9yY8wjQDp86Z4qsNFo1IAcVoyh77Ml5Ga+rZX1
         8FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730404; x=1783335204;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/IO1ZooLtRgExgFDTANPx/TSDVSN8NUTyd35xKP2q0=;
        b=KhRjFDZN6j5tgNAWiG281QNzhJBdaIQJvWQfaVzkqsyuHUah2l+SLrMoU4CdVSd6Qu
         VoZaRy9uIIO//MitmTZufnVGdaDbkKAXL4cQ78oZ3bRbrZhdl+N8snib4wkCGFvr2EE0
         W2w0cyQXJU1Ol1h04vieO8XaOc6xjWBD2bAlZuwKputfcBxJ57YRgUsVPUctnOtgT/4n
         9u9Xt/CXYF/ihfDfjGX/93W0PrPTdPZXR0quRwxS0AQKC9vtVjZ4vf90+DZRkp6LFHi+
         GfPkhY/IwOVKue+lFRMfogRb9Xbh5ROah+hwT3n5eqX6ajUMlNaRRNCH+82sUhOT+urk
         Xnuw==
X-Forwarded-Encrypted: i=1; AFNElJ+saF3lBWktCT4zfHCHsLI6bSEjPJ0tEROWoIIM/dHuMDmo4TmkWDLpivM2bbLYk4D3eo2ebew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHD1WStsKRqMrIllCE9vmUJdPjXlqOWLo6IHCI2l9Gnk6UdJHO
	/w9IkF4axh3/v4L+/9INcIAhQCLSRaf+V3OePMzSsr2l7wTsJKRo3RaFQBX86l6AmG9LFXMcR0U
	S5LM7UCIiCeyC5UJ2LiKIJXdopccz8M2bTZQ36ZIvj+7fqy6AH5ijYXGEEg==
X-Gm-Gg: AfdE7cl2iRy+PUMeS95WCwrLR8niK7WbN4gKx0x2epqK2MrXGxuZ7+Cu2ocm9ZRwBTS
	odP8BqakzBp6Uu/bhjLFJtNi2zXHB9BOPMpQ0VtTGroYgOgIwGOl78YsEGPhFhgNYs3dHc1fSrT
	uvZmJ7RiLAvfBffx61Xqb/rHiTslUXL8mSTiv+Qdy5EjVonJ+kBW+fK1EGKij9G+cU/Eb36puHf
	VgnkGf4wqzd4Ch4xNisQejqkfrpbm78vbPzgkoWDzhlytkcfj7jJvvKVB+pGCS4pxBqpm0Xynw2
	o2mDwTaIrrO1zr9BOXSSSN7BxcRhkxYuK7lhwQAH9tuuUhLt/+LjH7ycY3Y2A/aMXNir9idSJcv
	NvkvE/hxUwWM3WjtITd5k4KcF1fTjCTm3BXE+sx1spkajtayJ5dGYWuIz1RIdegYEY2p2gm7k8u
	e05lLr1pY4Xg==
X-Received: by 2002:a05:600c:3513:b0:492:564f:5603 with SMTP id 5b1f17b1804b1-49266850086mr244139805e9.14.1782730403836;
        Mon, 29 Jun 2026 03:53:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:492:564f:5603 with SMTP id 5b1f17b1804b1-49266850086mr244139405e9.14.1782730403451;
        Mon, 29 Jun 2026 03:53:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690100c7sm338015215e9.12.2026.06.29.03.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 03:53:22 -0700 (PDT)
Message-ID: <a826d09e-b9ff-4696-a46f-f56913a5cf9a@redhat.com>
Date: Mon, 29 Jun 2026 12:53:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: clear transport header during tunnel
 decapsulation
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com
References: <20260624073209.3703492-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260624073209.3703492-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-302565-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+d5d0d598a4cfdfafdc3b@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d5d0d598a4cfdfafdc3b];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EC126D9146

On 6/24/26 9:32 AM, Eric Dumazet wrote:
> diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
> index d3c677e9bff2080e4760347a3d873da4e83ac3ca..59192f58da2e3aae19d00505cc3bb04b083b77c5 100644
> --- a/net/ipv4/ip_tunnel_core.c
> +++ b/net/ipv4/ip_tunnel_core.c
> @@ -134,6 +134,7 @@ int __iptunnel_pull_header(struct sk_buff *skb, int hdr_len,
>  	__vlan_hwaccel_clear_tag(skb);
>  	skb_set_queue_mapping(skb, 0);
>  	skb_scrub_packet(skb, xnet);
> +	skb_unset_transport_header(skb);


In geneve_udp_encap_recv() the above is called a few lines before:

	geneveh = geneve_hdr(skb);

which in turn accesses indirectly the transport header via udp_hdr().

Also AFAICS even vxlan uses __iptunnel_pull_header() in the receive
path, possibly no additional unset needed in such driver.

Side note: it would be helpful if the syzbot CI reports could include
the fully decoded stack trace.

/P


