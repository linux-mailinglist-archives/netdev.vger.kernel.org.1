Return-Path: <netdev+bounces-275526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8fEnFRoz02nZfgcAu9opvQ
	(envelope-from <netdev+bounces-275526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 06:14:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A588F3A1637
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 06:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78AD30068DE
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 04:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5B3093B5;
	Mon,  6 Apr 2026 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="Jh8nbbuI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B563064A9
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775448852; cv=none; b=o9ebgs+2oHzCl/ENbPmrrAK+qTzPB3G+9BL8JvGs1jWegIHHzAhN+y1M75fsn92y/IY/t9VOb1YoQlNCCvq0Z/sudx/0lIllHZn6NvUwrpeAvfJ85ZJw6COOvbcS83mc+oht9DuBd8ClBKtf2MWc2kO0R3Zp3+uW1R3mcqBpVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775448852; c=relaxed/simple;
	bh=UWukafqK49bkulS5Sg+KJO4z122g7pojjTf5iY+7Cng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIkm8ANlQntKlL//HI3NLKSzxW0UmAZqPuyBH758xC4BLr0Dc0LnmS8w80QJYhSKMpHS/GJrZbUxz3dfB956tgRjMJgvgBZNH5+cRwe33VqNYAPZeV/s5TzYnNy3Td530UIadYiLAJlXaEjxuv9ujA2RJaFkmta5BGsKhpm7DEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=Jh8nbbuI; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c156c4a9efso4163836eec.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1775448850; x=1776053650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FFmfbqUJtg3hdvp5z3Iq8gFNeJQDVPJXxta1wcIAEU=;
        b=Jh8nbbuImDW6zj1BkR3H1gVy68FfYh+ps7Ek32WfFHob+Lvv/ZJlOT+fZQsVd28M68
         sFl+62VAY5+45cz/KxfN+6eGDjTgfC5uAX8LeAD/se8T2nqO552jQ8FANi5jdB6aRU0B
         Y852mkvyB/ksdBzbJDQ5ZznSAPzpa4iDT+KFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775448850; x=1776053650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FFmfbqUJtg3hdvp5z3Iq8gFNeJQDVPJXxta1wcIAEU=;
        b=SRZki535nk3BCs4vJx2kaxDLwop5jqS7mzSBVn49HC84wyi4BiOD39chyDdxvM/GMA
         XdlQispQu5AMxrmtX2sxt/dTpz3vr2s+yJZ1A7O87w6fvfN165HVXD/cgRnS9EhN45Gx
         8pLh8PqSEyxWDn9YK91A6jCVBd8vqg0lYvJuoS+ddkQD9MhZPacDf+dCd8NexQD6Q3xs
         T3o6tIdzswbN+PstHEOz8e6XpnowLaS+q8np8eNWk7z5Z58W5mG4ctaDDtN55ec4slDe
         I1m5gFVWWu3dsUggGSd+LvzMyS5NOSuOcKoVRqR3CLFPfWzghl8DoiqjtH9R3mSCOV1C
         rqeg==
X-Forwarded-Encrypted: i=1; AJvYcCUD4kwIA3kz5pGs9MqtQ9XOtY89eZ7zzdHuth1OgugeAxT3ZHuoGQpCE8+QemF/1U8RdWctzv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxb0PygiLzaf0+qlpQCWCD9pnE1FPmiBax2VHYPxuEloag9rDO
	vRqMpw63XxeespCIIiyVd5KhHxFMvWLqzaiiW1cfZrqKeRjKX0e6Fg8UoS8DogZlC/k=
X-Gm-Gg: AeBDies1O9BubYDBVP60dAi1cV9kGSlJOgXSQW4gslE9VKJS1yNKlSsn7KYTloq5kbv
	pd7irykyKJPesGYjxJ/MIaOzxeVLCVWhSbYtItzDFULP+eA/zcVZ8gmC4O4F4VcqeUqR2Sro7xu
	f8tNyK6Fzc5iC6GhLtx8qYdE1HeQwVABir8BAG8Di8sdZaa2NqI1NvsWAcqwuPpvjtpQKEe8tTb
	gFi5H/086QFB/2YFaBN1btoylJDLthC18UAQ1uXKM7YrEerz62+iyQ9S/9LmOVGI6z3y4nsRMQG
	tmQK0dkUEe3aBzHIQ5cuyH4ZyevEyHOxmM8MaNu57lC+Nf8e1xh0onSr6fYRTtyHtRyWvdrU3ZI
	TuvOoBw08foKmN0AeWSOTxfaLaRh1ne0rpL5uAXtxQzj86JrmEtDONNEqLzdfeIhNOHkt+nqo9H
	v+10Kkdh1TvlO1VzZZERA6rqTOSoHIYx4m3oDH
X-Received: by 2002:a05:7300:dc8e:b0:2c1:3f85:756 with SMTP id 5a478bee46e88-2cbf9fe3608mr5005632eec.11.1775448850222;
        Sun, 05 Apr 2026 21:14:10 -0700 (PDT)
Received: from [192.168.1.2] ([179.105.152.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cee97ff4e8sm3395736eec.25.2026.04.05.21.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 21:14:09 -0700 (PDT)
Message-ID: <a14b354c-3d53-4f06-8d50-98b510a235e1@allelesecurity.com>
Date: Mon, 6 Apr 2026 01:12:56 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rxrpc/proc: size address buffers for %pISpc output
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, anderson@allelesecurity.com
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
 <20260406141000.1-rxrpc-proc-reply-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Anderson Nascimento <anderson@allelesecurity.com>
In-Reply-To: <20260406141000.1-rxrpc-proc-reply-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275526-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A588F3A1637
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/6/26 3:10 AM, Pengpeng Hou wrote:
> Hi,
>
> Yes. My original changelog example was too loose, and your quick test is
> right for a fully expanded plain IPv6 form such as
>
>    [ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff]:65535
>
> That form is only 47 visible characters, so it fits in the current
> char[50] buffers.
>
> The reason I still think the bug is real is the current %pISpc
> implementation in lib/vsprintf.c.
>
> For AF_INET6, %pISpc goes through ip6_addr_string_sa(), and the compressed
> path uses ip6_compressed_string(). That helper switches to a dotted-quad
> tail not only for v4mapped addresses, but also for ISATAP addresses:
>
>    useIPv4 = ipv6_addr_v4mapped(&in6) || ipv6_addr_is_isatap(&in6);
>
> So a current-tree case such as
>
>    [ffff:ffff:ffff:ffff:0:5efe:255.255.255.255]:65535
>
> is possible. That string is 50 visible characters, i.e. 51 bytes
> including the trailing NUL, which does not fit in the existing char[50]
> buffers used by the rxrpc procfs helpers.
>
> So I agree the example in my changelog should be corrected, but I do not
> think the underlying bug goes away. The claim should be framed around the
> ISATAP case rather than the plain IPv6 or mapped-v4 examples I used
> originally.
>
> If that makes sense, I can resend with the changelog corrected to cite the
> actual maximum case explicitly.
>
> Thanks,
> Pengpeng

Thanks! I confirm the ISATAP case really triggers the issue. It ends up 
writing 51 bytes, including the NULL byte.

$ cat /proc/net/rxrpc/locals
Proto Local                                           Use Act RxQ
UDP   [ffff:ffff:ffff:ffff:0:5efe:255.255.255.255]:65   1   1   0
$

Regards,

Anderson Nascimento


