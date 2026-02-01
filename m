Return-Path: <netdev+bounces-255583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNHGNOUOf2mBjAIAu9opvQ
	(envelope-from <netdev+bounces-255583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB63C53F0
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 09:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B64B430137A2
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7031AA84;
	Sun,  1 Feb 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="BlHIV2wE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73972F6164
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769934559; cv=none; b=m9Jvra5afoKoSvXgFeMUX3L9/hPmrk4I07EVC8u22qFCDuglBgh35oNu9UO2txQSvBhguUdl2lc243JSbNCoBDEt7RgZ0Vl7TPsHT41uH0TCHO8UVXr6x+1WiuCC8d+4d5j+o2AvWaBEyUqItadJx71fl1UopDjxnHLXJiO5mMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769934559; c=relaxed/simple;
	bh=6JBUx5f0OtPOVTySvaqIgC/De4Hhkb8Gn7hMOdnqxxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhaP3x0kqxd8i5i/FeFwCB39B29JEconu49HUwSJQe68aMGryZ+VUOF7Ru6hgm90UdmWB0Ek/8yV/SCgp9ngsCW/8hRB9I5lKhRcurmcZaNDdYejYrX2W5rbwF5nGw0VD76Tew2Z5kIFmA9wt/PP5iCavrnNhA4Chb4MXJFqvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BlHIV2wE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so25169515e9.2
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 00:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1769934556; x=1770539356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeZOjfl31A9xEaccgdXksgXuAf1M1N9YkibI/QkCSYk=;
        b=BlHIV2wE69qSvBO7ViBVEHnlMep1pP7Ti3Sh9mA/qmdybbN+aFSt9oANhhPK2L889m
         ml8Juie4dMZXIrKrQgrKYIIkEC8GOaOnDlZauXB2TTzk5BrhAuwPKj1zobWtznNw57bY
         nT5E1apCmyrf+BEMSeiXOKMeHPljQa5OtxtMxLN6ZVMcjcpv+rpkvCHZTUtVf/XmUpaz
         zr0OX9tLw3PBhxC0TKZfS0aTiVNJTINa6GnpAWum63JEu70+NIIy8OvjoTS7kQFyZTpT
         z5J80zYdPYfoFijtbI+f80sMwEarTVhEljdpk0I2tqQiwcJNMaUZfgjOMpPOjm3mH1wK
         qF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769934556; x=1770539356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeZOjfl31A9xEaccgdXksgXuAf1M1N9YkibI/QkCSYk=;
        b=bUtjFpt1SE4mGSv3LfG8bf+RtWNMRHS4lZv4I0z15fepf2BsYU68+XB4f9xfkZGNmz
         /s9LgkqAn6VPJ/oanM93rMgXQA2cnqMuKdayMu/yJVAajmiKVT38ukXjSd45jVbryHLN
         nREqfwcj3re9fJfYrsFyQYqa8GyKCA4nfPTqXg/QXpEferRdxVGQTGld6wAWue13DaF0
         WQiCfFQREHsFvaTUsOoeJX2S8Dwv6GUgZAQeqncKielhfefNhE2utMKOM16gnfQgRQlu
         WiYR2P0QWbLkWJlYmbi9YR0VdXhuLRtfuMnilSsGko3L/+gVRymjpHLJuiWAFpp36b24
         jepQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPX0Ltf6wvPj7WEAhtZst3IGXdy6NsDpS7OyS5jJPolP9FziOQHN96exmdSueur4lVAbc/8bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHV74DXOQ7jY7LeaRmLvuwV4sDtjnKnYYZqnX5xYGxxrUbKOI
	jezUnWqzuTBbeUzz4+gkRA8xms35RxBWmjNIisqfO1/Q/GKNzxvoXW9+NygSXlIMACs=
X-Gm-Gg: AZuq6aI7gBEmvGBHytzLfewHw9rNkRTdL0PAgSKy0sO5IjPouOEkWcPUdsRqpR0fGqa
	szD9V/SkZxB2v5pMRStLFATNOWJgYrbioSJZd0pDfmDGXGXzDmEsi0OoAGqeVO608ZsaS+gVz0T
	3hAg3ilh0wQVnvqBRExL8SWiiTQ6gE4aqfn170IC4mdjSyPlOgnaM+oWzs/XqDBI7TIebYXWXY/
	fM/4qe9iIHOwN+7IHlXW3UHvWy3zWJTdKTgRDfobUrFcy9WFUvGeeRHJIwHy5Uwj+SfV0P5o6XG
	t9eVryf4r2gC60SvBJlKpkGnBKgPOcOx3C97u5Twu9nLX4AlVoYjsQAWxlJLs5U20FvCddF4OVZ
	X6sqnFNd7xT30pJwFhjfgybCEDJmtbdl/9TAoGACHaz8nT41lDpAgaeWf+I5udAlZb4Vr1nOa9O
	LSv0r8+YwSqU8E+Onf9ZeDSaNWHYapd539Hf7hEPUzJA==
X-Received: by 2002:a05:600c:5288:b0:480:4d37:e742 with SMTP id 5b1f17b1804b1-482db451e66mr97897665e9.10.1769934555855;
        Sun, 01 Feb 2026 00:29:15 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322dc7sm35418959f8f.37.2026.02.01.00.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 00:29:15 -0800 (PST)
Message-ID: <076bd8aa-e06c-4b0f-a659-d35de0319b55@blackwall.org>
Date: Sun, 1 Feb 2026 10:29:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: use sysfs_emit instead of sprintf
To: David Corvaglia <david@corvaglia.dev>, idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0100019c14f90490-950ddd9b-1897-4111-bddd-0d4b8abf380a-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	TAGGED_FROM(0.00)[bounces-255583-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:email,blackwall.org:dkim,blackwall.org:mid,corvaglia.dev:email]
X-Rspamd-Queue-Id: 1FB63C53F0
X-Rspamd-Action: no action

On 31/01/2026 18:53, David Corvaglia wrote:
> Replace sprintf with sysfs_emit in sysfs show() methods as outlined in
> Documentation/filesystems/sysfs.rst. sysfs_emit is preferred to sprintf
> in sysfs show() methods as it is safer with buffer handling.
> 
> Signed-off-by: David Corvaglia <david@corvaglia.dev>
> ---
> This is my first patch to the kernel! I've been able to build and boot
> with the patch. I also tested the sysfs reads and they seem to be
> correct. Any feedback is appreciated.
> 
>   net/bridge/br_stp_if.c   |  2 +-
>   net/bridge/br_sysfs_br.c | 84 ++++++++++++++++++++--------------------
>   net/bridge/br_sysfs_if.c | 32 +++++++--------
>   3 files changed, 59 insertions(+), 59 deletions(-)
> 

Hi,
IIUC it is safer because it takes into account the provided buffer's size (PAGE_SIZE).
I'm saying it for the curious as  I only found in Documentation/filesystems/sysfs.rst:
"- New implementations of show() methods should only use sysfs_emit() or
   sysfs_emit_at() when formatting the value to be returned to user space."

Which does say "new implementations", also most of these are numbers
and cannot really fill the provided buffer, there is one instance of a string
but it is an interface name, so that is limited as well.

That being said, I'm ok with switching to sysfs_emit() and the patch looks good
to me so:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
  Nik


