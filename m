Return-Path: <netdev+bounces-290693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLLXKnUFEGqLSQYAu9opvQ
	(envelope-from <netdev+bounces-290693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:27:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 547C45AFFC1
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BDB33040224
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840C38E8D3;
	Fri, 22 May 2026 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="F/wREpkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C72385D6F
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434720; cv=none; b=KsmNhnzb71HAkuwUVwDdBck6CoF3hnBxy09zWPNuU7sJqK6YmxAHLcUmVCXkFGYZC5Hhoos587TjaLGwhPt8ztbgTnMh5AzZLRye8LpzAfnLhwjU9iFCK3olDuUYRXD1VJqkBOvZ9WrX/n7MuuokQwngTA6YTOxCLRtB9GpB96M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434720; c=relaxed/simple;
	bh=DR1AkpCg19vmza3y1XhaOoXFEA45xJVCNkq6eE85JyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/yQmYkYU54t9BQA1DzEybmIS94yQVYlb09GnoZzZE3Bb3ly3G+Wi6pTTy/6bePZ67d6T9GRZJjqxf+gCYclMzVU0QijbzZrQccwFIJTbcksS9aov6wkrSuS6KLY1eZuZlKl3WF0633bD+d3mJylg4ZM6/6nOL1GBUBFDXiDRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=F/wREpkW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso6368415e9.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1779434717; x=1780039517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+sd+YQcPZ4Wvn7Tf8ziui+EYH4Lu3lY9BCWXszm0/a8=;
        b=F/wREpkWGbxx9s/fyP+PbaJfHfeD6/GWtwCdsEtzDn8y3jvT6BqByijkYNejRW3Lj1
         1N0wXy+xRDhEEiyoDc0I7FzacdIilbY8htE3JLcUROSZ9/vQ3RxRJpxYGeX04cBYm2bC
         MCLPBrfw2N2cnOyCGowyjAli4Tt4B6x7jEc33BQNL9Fgw96MFDS0J7VSmQxJYiH6jUGw
         s0CGTSGuTZrByLcHmC/2KdNclSgcsd9E/PW5rm0DabuDXQJHxanrD+dL7/YJJfvy34Eb
         FcqyQAQr9yqgj3cHSnVHkvJ2kjG+cfzx/2j08gycv3xqs6zzLRGo3fczQh3uh2pMVk0K
         RWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779434717; x=1780039517;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sd+YQcPZ4Wvn7Tf8ziui+EYH4Lu3lY9BCWXszm0/a8=;
        b=Q+JCJOFFAMKXauWttPug4EUOy87gHto3CXIeRl9jfEmaoiB0R2m16pn3luzIO3+Xdv
         piEssmhTthJvwhXsHGdBw3GwvUlJSPHbl5wFTqxGS6UH1iaUKYaDMO1jzGqPXUMa0C+r
         jOj9ew2uxwmkwvwtjet+DgQl99VMDkClm3Lhc/Cnjniv0FWU8CDRF6FE8v92l6bJfcPs
         Ix+tUnUIshRcPXIqUEEvjIHEBDBUgygKlvwY7yM8U5n0e56sN8s1NAwzJyObR81H0rkk
         d6LLNc3bkxGmzdU3c4IzqOhd8AafxO7ZNgqqJ/xxnp3RP1umkagKyerYVJzWoNHZeJvv
         vu6A==
X-Forwarded-Encrypted: i=1; AFNElJ9xuul6KLNIxSMuMy8m2xTM9eTnPK8OKvN4CdWEC3vpbQlskoVR/hHpIjCz42jFaV2i0ev5I1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwafjDs9U8I6/rJOsuviQ72Xqy43JE0NjQDB4UPFoRvH/cp+8m/
	QiPwqu+O1Zbovdlv2tsgO5MNIow2FAPphrjyjgWOvp5Ug50MzZYzUNkIytiajep+1gc=
X-Gm-Gg: Acq92OGNeFX9JAtwbJ3XXZws2K1UnPqgJ0sibp2G2yJPCTh629W6QlgwApSHqf2B3g7
	q4Bj4kynuPaeZ7Og0uKZ7uNBUjaNsOkA2VsLEcAPT0MEmin4mX+i7xV5igjiMRTaby/Djc2nrJy
	zPwrq5BXR2S5I47eqsvlCQnt+HGP+5VtpZiCfLS3aX2+Q7ELMCHJhRzzSYvk6pfsKo2PCnfZkAH
	n8JocJCOaXAp+ZKxRJiaIDbHSCl2dyJ1/xgpH9Z1AyMalO77+LMWAL3vWdXUiT2Ihg1Nycrfejz
	eeZ8plKib4UOBQHj3YGpa6jlP0dz0jcDvPQysjeM8sgDScckTzQ+0cgNvp+BpRnIzbufufWB1C0
	7jPaEZPevBZ/hr2H749hXB4lyS0LLN7WokWzj2VeTsMVaJRt01zsnZdHBntqq6qa/VYt7e1tNqo
	YfJZnptcXGCyIufJwTOiQKsz2XPeNa3MedaaxTU5Wrsd/hL3sH3D88TgLEVwg0fip8yMlZ3ThLy
	vgR
X-Received: by 2002:a05:600c:c4a3:b0:485:c456:5e4f with SMTP id 5b1f17b1804b1-490422529aemr12940665e9.0.1779434716903;
        Fri, 22 May 2026 00:25:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904527f7f7sm41628455e9.7.2026.05.22.00.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 00:25:16 -0700 (PDT)
Message-ID: <c34e04b3-d807-4287-8c64-dfb3d7232802@6wind.com>
Date: Fri, 22 May 2026 09:25:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 2/4] net: netlink: don't set nsid on local
 notifications
To: Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>,
 Adrian Moreno <amorenoz@redhat.com>, Jiri Benc <jbenc@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Matteo Perin <matteo.perin@canonical.com>
References: <20260520172317.175168-1-i.maximets@ovn.org>
 <20260520172317.175168-3-i.maximets@ovn.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260520172317.175168-3-i.maximets@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,canonical.com];
	TAGGED_FROM(0.00)[bounces-290693-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ovn.org:email,canonical.com:email,6wind.com:replyto,6wind.com:email,6wind.com:mid,6wind.com:dkim]
X-Rspamd-Queue-Id: 547C45AFFC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 20/05/2026 à 19:22, Ilya Maximets a écrit :
> In most cases, notifications on sockets with NETLINK_LISTEN_ALL_NSID
> do not contain NSID in their ancillary data in case the event is local
> to the listener.
> 
> However, when a self-referential NSID is allocated for a namespace,
> every local notification starts sending this ID to the user space.
> 
> This is problematic, because the listener cannot tell if those
> notifications are local or not anymore without making extra requests
> to figure out if the provided NSID is local or not.  The listener
> can also not figure out the local NSID beforehand as it can be
> allocated at any point in time by other processes, changing the
> structure of the future notifications for everyone.
> 
> The value is practically not useful, since it's the namespace's own
> ID that the application has to obtain from other sources in order to
> figure out if it's the same or not.  So, for the application it's
> just an extra busy work with no benefits.  Moreover, applications
> that do not know about this quirk may be mishandling notifications
> with NSID set as notifications from remote namespaces.  This is the
> case for ovs-vswitchd and the iproute2's 'ip monitor' that stops
> printing 'current' and starts printing the nsid number mid-session.
> 
> Lack of clear documentation for this behavior is also not helping.
> 
> A search though open-source projects doesn't reveal any projects
> that use NETNSA_NSID_NOT_ASSIGNED and rely on metadata to contain
> self-referential NSIDs (expected, since the value is not useful).
> Quite the opposite, as already mentioned, there are few applications
> that rely on NSID to not be present in local events.
> 
> Since the value is not useful and actively harmful in some cases,
> let's not report it for local events, making the notifications more
> consistent.
> 
> Also adding some blank lines for readability.
> 
> Fixes: 59324cf35aba ("netlink: allow to listen "all" netns")
> Reported-by: Matteo Perin <matteo.perin@canonical.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

