Return-Path: <netdev+bounces-282883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNWgNutl82lG2QEAu9opvQ
	(envelope-from <netdev+bounces-282883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:23:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 521274A4040
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D227B30209C5
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3640B6DE;
	Thu, 30 Apr 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vk4/gWHa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMLjkuxV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C440242D
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558892; cv=none; b=raZpvA0Y65JFWBdR2EUlH+ZV5SEDxjhImKbnrW7nariwYSPPwwzxgOBY/WJ2Tkbufq3LdZbMdezpHna13Mglxve7AaVSQOlPZH8vTXMffAl1A9Emi2gDC7g0On/lsWBMfwVQjMQpF+pxuLIVrywo0xtH8kNOhSUJxgmTezdKAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558892; c=relaxed/simple;
	bh=0pR2x8//pyF9xL3q2vRTlnGdtD7xdzdl3nI0D0ABwdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKwpSu1/clfy9ADFaj1NO8AZlJgHmjPhO2S5pei1zYSltu+8j9BMBcI8ip34c16mSGwI9ApZf4zx4lo0/Ig2hHiZmGcQAouYDstNILTuVCG4BB26GIDHphtbe3OqJQH1+UUWvtzwdRY/rdRKoYYGfsj701uF4KpsRVqnVU8ze9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vk4/gWHa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMLjkuxV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777558889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qt78KjmTadM8i57CfK4+t3vDTX4phWDue2Oou3Nj7OY=;
	b=Vk4/gWHabzWr4/mVsXBUrPsT5Sful0tNWC65d8eooc/Z8B+J3TYO48OjBTgvfbuGtLonxC
	AP/fbWhM0EsvCu+jHYchkF6FPstwcUHYDorx/FZy1pJFxq/WXAsFK9q7cTg59rD6sH5vjp
	dJVJtXTz4lccZwOXV6FOiEuoQnwLLjs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-M8YLWy9bNzGPzmbTrvSVYw-1; Thu, 30 Apr 2026 10:21:28 -0400
X-MC-Unique: M8YLWy9bNzGPzmbTrvSVYw-1
X-Mimecast-MFC-AGG-ID: M8YLWy9bNzGPzmbTrvSVYw_1777558888
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8f4ef450191so193703885a.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777558888; x=1778163688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qt78KjmTadM8i57CfK4+t3vDTX4phWDue2Oou3Nj7OY=;
        b=XMLjkuxViKuJNFDcrVNVcmCLU8oqq/s+t6OdeKgmkGQVpovQX7fArJewPo5Wsea5RI
         ntOy+tqYBg41moRwrsCrs5yB51zzu9kE2f8qrnruwjF5I0eN5ORD2EN4hApRKwEPECUx
         x6I+Gt91rOgJiFVuHoa2NSPRJaP/55yoWCbXYuFAP5TJjxodprxlltxmyLJzVZSUoFZP
         Rl/bsciLfLyzItDbhm1gIrwwPfTlPAQ+bkQBDVx5wEims8b3esmTUYzfi4qdP+aDsHt/
         qoJuT626KFnsrz5tLiEUfGWAvKRrMf+Nt+8+izlkomh9cIOSPd90/90ZBkgYHFw+4wAI
         uVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558888; x=1778163688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt78KjmTadM8i57CfK4+t3vDTX4phWDue2Oou3Nj7OY=;
        b=pvD3C0Yyz/r8/G05eGn5cktbbrY0PDhDxJ5FfKpKpumjGOnYVf/JyUnWj/lytk9ucs
         PB4ByDDKXCei5I3Faczd3FZ6Twn8ljD0a0r5nWg4FT1X3PxSNF4Ute/FdCJ6ZtB3Tapr
         9RCyqiFEHHu3CrXAfBDHLDhmnXAKwyKhRPDqR83ih04IBsbO9oTqisfhGHpVdnU0j9ZK
         EzAxrUCmjrsvwWRIULAAbD5A3sIx35K4KxNaxA2J5zKgoAtZel+YPyMdTd6DaaV9XuNA
         /GheASelq2nExa6TQ46G3KRwE2YWEWxrVPvVNZXqcH7fRXHDtDAHhHNvwtqFIhq4h99G
         Oq7w==
X-Forwarded-Encrypted: i=1; AFNElJ/WoT419EZkHXNz2xnEG2gr8jNxnJzK051HD72ezpJW/8EYFkEqI1W6mFqLLPNkY1VhGuyhG3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCl1MVDZuPXysBNV09KH/XnhyMBL3jd3SLiKitghcd4ydwSV/
	jQUqI5ApPhgRSjrT+fKDkAzk7uGuzqg7RQPfH4q0izRaJJoqeGyQ1NGqxAZKa15TISlV8f8+fNx
	BoLPTPdsw9fR+00UD1q1D6JmmB9w0GS5T1holvxH2qlKoj1B6qjDmlpWgdw==
X-Gm-Gg: AeBDieta/H9+Vv71TtIkaXkhc/z7IERjoDc83BwCW4TnByaoh3G3kyjq42Bae316D4N
	S02xyqVhycDBjKWpQFH5odmwVqnCbdq+zd/na9MeCnJoKl+2xwc9rgXMQT9Vyp9RdHvzgqrurSz
	fBwVkx2YMvuB5AvOhbLnR8RtK9gC6TsTmYDHLin5sWbKfy9588C2J593TbJNVg+BcEkJTjBu5aD
	MhBPW+yFUEAV2pudzHYKuW+4ylbCZJX04oqf7NTEtI5IwADV+dc/fCUdE316s2BQ1liXyQoG8O0
	jNLQ1TfNRe6yuvI8QUewSIaY7icZLNFpBO19aRtePoqDQj0RklsTWWbMI/GSb73Sx3d1pg3HEkW
	y0gYHQxTFvISp+IFKlqx2oskGSFCCqxWwi/a0SLkl72Nozcdw7NhUDtA0TvsoYMuJ8w==
X-Received: by 2002:a05:620a:390e:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8fa88f2eb8bmr472387085a.32.1777558887657;
        Thu, 30 Apr 2026 07:21:27 -0700 (PDT)
X-Received: by 2002:a05:620a:390e:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8fa88f2eb8bmr472381385a.32.1777558887094;
        Thu, 30 Apr 2026 07:21:27 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fba126652bsm695285a.30.2026.04.30.07.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 07:21:26 -0700 (PDT)
Message-ID: <deb31b99-a9d3-4e24-b645-071b71dfa4a7@redhat.com>
Date: Thu, 30 Apr 2026 16:21:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] dpll: zl3073x: implement pin operational
 state reporting
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Michal Schmidt <mschmidt@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260428154907.2820654-1-ivecera@redhat.com>
 <20260428154907.2820654-3-ivecera@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428154907.2820654-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 521274A4040
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282883-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/28/26 5:49 PM, Ivan Vecera wrote:
> @@ -1828,7 +1862,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
>  	}

Sashiko says:

---
Will input pin operational state changes fail to generate netlink
notifications when the DPLL channel is in FREERUN or HOLDOVER modes?
---

but such modes can not generate any real notification as explicitly
documented in a previous comment.

/P


