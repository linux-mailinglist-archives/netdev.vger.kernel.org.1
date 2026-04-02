Return-Path: <netdev+bounces-274487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEqYFUxSzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65F2388492
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7742D30EB191
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBB83D090B;
	Thu,  2 Apr 2026 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBBnWrG6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyQoorG1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972236403A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128661; cv=none; b=GNoEe0ktky2UDZlOnroy5CvYHP6OaPmoLBk178MLQTdZy8EUAx6n64P7sggmItRnSpHJ0jMDr3WvHWr6YUi3rvMMycblqQPh/hqc5MHPkDwvcBultxI0WEPQTejwZhHHp6i8cK6htLBQ5MsHZhS+djtEs1Fe6nYGgbyxPQ4PsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128661; c=relaxed/simple;
	bh=GWWUAnMaoAnXvUfbVWwutVCS6bQJQeajr3pFkbiEsfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXUyay93DVGL59V1vSHlzkck3psKsD1VWeMxz+Se68DpFoEqsb1KbPBKMaXk4ilih369LjabGFyb6lhrdjjYElRb0i6O8JxAhbte6sDI0ADldkaW3mSeYm4qbl1rygdyiY2/lh0/4FzYdXOvNxlLKN8ZggbbbMiTGZjNyWgkHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBBnWrG6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyQoorG1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775128654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8eKcE5S57vmQb8/l9YcFNLF3LkeSC2enqXF3R6bEYVk=;
	b=HBBnWrG6g5cze9nuBRTIxklGsHAA+aevWeuCrX2JcndhRr0+FDHRLpAppEw27cIjyAhnaM
	Jh9+jh0sElQDeJ/pITSsnTDOosZSvE8nUaKziWPmolwpscgfr5Xfa0wdJH0Y0mjTWEhOvp
	E+2T3RCItZX4rzJUIdYUP3a89mZGRkk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-TtFgk2cYMt636qRaYXPAkQ-1; Thu, 02 Apr 2026 07:17:33 -0400
X-MC-Unique: TtFgk2cYMt636qRaYXPAkQ-1
X-Mimecast-MFC-AGG-ID: TtFgk2cYMt636qRaYXPAkQ_1775128652
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso11767625e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 04:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775128652; x=1775733452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eKcE5S57vmQb8/l9YcFNLF3LkeSC2enqXF3R6bEYVk=;
        b=KyQoorG1szluKpdf511A5DSC6k/YSoUZqE8RL4iYjmG4bwEXm1vEFSkUI26q7PipNs
         walVn28m5mX9uJw4Wq3Cvm9WHCTgSnBsNbdaptBogTEweNPpXAH32v90318Up3ab0pPH
         aFKqHlXYvtvrbZJVf4JJ7QlHZIX0CImLqgxKD2qq7kvYl62gQLEmBF0YtXkdQOPCJLdf
         Lw0X8ipzsOPJAQF+oBhOxz1tluuHEpFcoMpB/8qIpjgX49RBW61FR8YjMqxafXVlTqbg
         xq1FpOKIEHbqMMqtIkZ/QIiiIUylylFwFcJJo2CcykRuv5TN7vk8O+UD5YRWoXNSgJY3
         FkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775128652; x=1775733452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eKcE5S57vmQb8/l9YcFNLF3LkeSC2enqXF3R6bEYVk=;
        b=YaKavThUXY915HLF7glYaq4e14QKW41Wu3BVMlYaSu7SXDR2McVMsClPoBhNszHuIQ
         MjZHeqF7jW7SSh1Om5APK7QOxZcOqfunX/bbgtSgy9HPnzO8FHAVpyAqz3666ph0r+5o
         3Bo607VVtSD2uD70Em0Vt8XQHmONBVF94Rk52zoNUyHVhy9jd/I9yVOwPMPEk/s2gG+L
         3HgMhD2zfPLyaltF0z9ztKzwQTu/sVzpt2+3ZoVD5XkFysk4ffkYyboFRBODPKWbLr9M
         hQ353EAaIjyz4Q3Lhr70fT2EM8WRK9gMwG2KgJOGk4WPWUYZIySXx+GFOp0pMHPaaAE4
         +AKw==
X-Forwarded-Encrypted: i=1; AJvYcCX5riXqbN8WcrD1HaqvZgZVsjqz9x63ZS7npRCFkx994JQ7W473AtXke4wwBXBNe8ZU36v7IvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6gmW9+7mMZRL7y3QLNqhUe9CIaqnYfkTNZiiwexwAVw/0Kfv
	g70LWp5lWRWrXcOXvFkEJ1ASsVljVHqfqujaXk9nWxCQU7b57ZVCKwmOtG3T4KKqOvGhOQYV0kD
	o23USFDtg55+pvN8Z/wmZkRmh4eC8/PcZdnFcl/4k6XKhfFblmN2tzUpc4w==
X-Gm-Gg: ATEYQzyOKCfg8WoZj3ivanGpaXkAIUT7GAfDz+XX77gCaE8Iiue8VjUov+fenOzNiPg
	CvRc9a7O5h2x2cYsfmnVqLZKAkKEVRrHNiLz9UYgHergJyr+h8iys5+gcTwe59T0QYiY+F4Yiuz
	1jCMJ7x/pSqxObC5sLIa2MQZ2HT6U8hHAdh0NnfXHABM68jwp/bV/6qcvc8/A+7TcD0M7gBUp1l
	58KOVgZmura7R+4Gs1aveung5/WpuPOox+8wpiRoLxVoVex45uZobvD0uomK2AJmU9PJgDF16pZ
	pSRLp8LmNw7xTbYbUmcmRWtgHdL9X4ZaUc6TqAWdom2dVqL8r0DtQa3/UHfzFtIXGuA02YRI6/J
	ihAw7PvXP2RyRmHc/Rb58bayenxLRp5IE/lBRI3/kTJWeFS7dwkbpSEaaew==
X-Received: by 2002:a05:600c:4f95:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48883568005mr124877575e9.13.1775128652098;
        Thu, 02 Apr 2026 04:17:32 -0700 (PDT)
X-Received: by 2002:a05:600c:4f95:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-48883568005mr124876705e9.13.1775128651550;
        Thu, 02 Apr 2026 04:17:31 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad477f6sm64087705e9.7.2026.04.02.04.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 04:17:31 -0700 (PDT)
Message-ID: <cb43761b-d414-4878-bf41-4ef6c988f881@redhat.com>
Date: Thu, 2 Apr 2026 13:17:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7] selftests: net: add tests for PPP
To: Qingfang Deng <dqfext@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Dianne Skoll <dianne@skoll.ca>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Felix Maurer <fmaurer@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
 Jaco Kroon <jaco@uls.co.za>
References: <20260330035604.133073-1-dqfext@gmail.com>
 <20260401081030.29b050d5@kernel.org>
 <CALW65jahWApDnVmFReW+Y3HDxBEmCwzsT1oyh03SW7X5ry6PzA@mail.gmail.com>
 <20260401175621.549c492e@kernel.org>
 <CALW65jaTbaosbO8ypKZ6G37HxuxXabeTaP_Fhq72xTovmDj+8g@mail.gmail.com>
 <50ae3c69-2c4e-499f-a46a-cbd207ff5f09@redhat.com>
 <CALW65ja1FV-OcqSazgKZhQhKf3oqr=kcGxyGkOGbhurGLOJ0-w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CALW65ja1FV-OcqSazgKZhQhKf3oqr=kcGxyGkOGbhurGLOJ0-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D65F2388492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 12:13 PM, Qingfang Deng wrote:
> On Thu, Apr 2, 2026 at 5:48 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> Note that similar failures in the past in other test-cases were usually
>> due to timing issues. i.e. the pppoe-server starts in background too
>> late for the client.
> 
> I don't think it is a timing issue, otherwise the PADI negotiation
> won't succeed. The "updetach" option on the client side also make it
> wait for the negotiation.
> It's likely that the pppd instance spawned by pppoe-server fails to
> find the "rp-pppoe.so" plugin, so the connection fails when handing
> off the session from pppoe-server to pppd. Note the naming difference:
> the client loads "pppoe.so", while the server loads "rp-pppoe.so" by
> default.
> 
> What distro do you run CI tests on? On Ubuntu 24.04, "rp-pppoe.so" is
> a symlink to "pppoe.so" in apt package "ppp". Maybe an additional
> package is required for the distro you use, or I may work around that
> by manually creating the symlink.

It's fedora 43 with ppp and pppoe installed.

ppp provides pppoe.so, and AFAICS nothink provides rp-pppoe.so, and the
pppoe-server is looking for a non existing /etc/ppp/plugins/rp-pppoe.so
plugin.

Before I mess with the nipa testbed, could you please double check that

ln -n /usr/lib64/pppd/2.5.1/pppoe.so /etc/ppp/plugins/rp-pppoe.so

should solve?

Thanks,

Paolo


