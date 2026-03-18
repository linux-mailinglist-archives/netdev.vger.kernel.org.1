Return-Path: <netdev+bounces-268856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MmqJoAOumn+QwIAu9opvQ
	(envelope-from <netdev+bounces-268856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:31:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE852B5343
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B78130197D8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C47221F39;
	Wed, 18 Mar 2026 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pxs//G6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B531D88A4
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801082; cv=none; b=QuIhlOA5YCLoNwzSbrimzZjsWIvewB9JDqqc6d8dCTMCAKstXx7KQuiaNzWixXnuIY86oL6fCqiLfipPxX0oJ0dBmSb90/dMsVrXo3nrIyWTofXveET5rTgNx/2qbeYuW1KAfsFFcnUV6qmgzNjbOfHS/3GrCQIwMwxIXJjDjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801082; c=relaxed/simple;
	bh=9AbpNY2Kn4+gQW5dblzLkdJPB31TYxyf0BLfJOBEuQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1eA8yaU9zSu3M2WfFK46m4vXC0D5j4kFVpHWzHbZHcQ8b99fwRpsMFohL2F1s69CRr8f+mM/T3cahdwqaKYGZVRJtxeRXPA9dWPzMWBCV9j2r2P0AKCj58cu1AJIsP6/OEeIUTEzwfDxQTisHLFEQn5/RHL6VphYZmNe/DLDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pxs//G6v; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662f30d3f1fso307510eaf.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 19:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773801080; x=1774405880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0fIjMW1IuphuDfDezfq70l0Rw++6a3+VbGwBPeQowI=;
        b=Pxs//G6vFG3skjU9/H/GPHesIhxmfUDfCd2iZ3Mx2k6sQQ7NlKMEXMVcEpJN4V6JF7
         g7nMKeDVXvTPLWaGtvB+WwOSvdyNjFxtzryHLWDf0gSHlWzlkgC7KLbGg7g0RmvIZN8b
         Pr8P23huUb/WDOJzpERc9BppneSYQCpDfmlRRhbpJM8z8tO6QyPuPrwoNHYC5vwAN7Z1
         GKYj+oFMCryrmgl628/LJ1nsgyTxA0DpIm+iwIAKCBqJSvHAhRVFCjiAhONJgYOqARk3
         RRFv8gdMiAw5lOgK44dnbVUcPukl1271vCfWuiIvZY3Hfq6ztaDBdL6n5b3RWl+rf8Ix
         UUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773801080; x=1774405880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0fIjMW1IuphuDfDezfq70l0Rw++6a3+VbGwBPeQowI=;
        b=DS9v0UIlp9/0k8Jf6XKrhwyCxLCEAkyTMWanv3yMwbtruQCQT6ULEMukhe24QssGvw
         TM++2bOZhaEBoWGwRil//JAddWuhH0Ue5vx/M7daz9P4YJk9zAc/tskkTBNcXB8OqgSJ
         YzJpCknuW2IcbolUtpAeWNo6UMhY+xfbn98TIIc0BFmSxwFiQv41I1+rVRDf4QxIvJHn
         SNkhsGspSEh6mlcqEHDfWKDa44P8Lrz6/WQNW7GWqIF/QSuPgnGhX5CObPjRhDg47W7r
         MX5UHQMuS4rsVmoGJXatZ3h2/cjVyveJCk3szqmQFbt6STPlRNsPyfV6VUcO8tI7FHZP
         BRqg==
X-Gm-Message-State: AOJu0YxqnegsOFYpwr1RPYIA7aE+pGCUETypF6vchjqVQjWmLRhrz9YL
	cs0M4d9P+8xydWp+osD849L3aKeDzT2IU5c3Hp9Rkpz/LsSVyb8Iwr/UW107uwmV
X-Gm-Gg: ATEYQzy8RbcbqSS7BjPIQvUAoFKO/YJ/ImPqjwQiE87zIqttLaHqQN2f7SuWEejy19Y
	fsLx+i68vqmpr3n3XdFt55kcDE6NafVXRhnPdWApioaLXGau8fEcTOFm8126eRP2JHjC2HyBoPq
	6h6NPuLhBopS0p+LA6HKMoVrZVSTWcP4nJLsDqYVAoonR6fBXzUULN6yxAcRgE6jP/3wANtKSfD
	PgWtZMoU7c5fyCnN14IiYyeP5mGLclsI8rY9Z92jcWylG7up7kWeH+WJ3yYkAt01Y0T4JO/f+Fz
	Mz5Ma/kRgykoi1Lf6Vnz8+rN8g0yFfCbTThxbDIr5mvqV6yLzNRZNXGcPpSGSQ/mw2+zXX3URHx
	GhOrN3xtSQWS7Yn4XctDLmze5OqVLIs7PYDqekaV31+vOfXjlsR0qOSlWZEMoENw2WjirxlJC6q
	POhAQAOlk3g3pCLgjV+PfwdKMb7TMWPZgqN4+4DTTnxNHXxOeXs4Rji48M6bX5ki18qtTiYbVC3
	Fqlk2+Ti7LSnQ3/ig==
X-Received: by 2002:a05:6820:2912:b0:67b:ba86:2dcd with SMTP id 006d021491bc7-67c0d097d9amr1101458eaf.32.1773801080402;
        Tue, 17 Mar 2026 19:31:20 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:c171:f40b:a1ce:ea9b? ([2601:282:1e02:1040:c171:f40b:a1ce:ea9b])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-67c0d724e53sm872809eaf.0.2026.03.17.19.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 19:31:17 -0700 (PDT)
Message-ID: <7a9b746d-96ee-4100-8849-9ee2e9773366@gmail.com>
Date: Tue, 17 Mar 2026 20:31:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/3] mnl: add fallback implementation for
 mnl_attr_get_uint()
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <20260316154418.625026-1-jiri@resnulli.us>
 <20260316154418.625026-3-jiri@resnulli.us>
 <20260316091245.05ac89fe@phoenix.local>
 <z4jw6f4asfzbvlxad7owwws7zwfns4gi2k56bmnfb4c6t2dbm2@4wrw7nals4r6>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <z4jw6f4asfzbvlxad7owwws7zwfns4gi2k56bmnfb4c6t2dbm2@4wrw7nals4r6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268856-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: 8AE852B5343
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 2:17 AM, Jiri Pirko wrote:
> Mon, Mar 16, 2026 at 05:12:45PM +0100, stephen@networkplumber.org wrote:
>> On Mon, 16 Mar 2026 16:44:17 +0100
>> Jiri Pirko <jiri@resnulli.us> wrote:
>>
>>> From: Jiri Pirko <jiri@nvidia.com>
>>>
>>> libmnl introduced mnl_attr_get_uint() to handle NLA_UINT
>>> variable-width attributes. Add a configure check to detect it
>>> and provide a fallback implementation for older libmnl versions.
>>>
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>
>> How far back was this? If it was relatively recent would
>> prefer not adding another set of config tests.
> 
> https://git.netfilter.org/libmnl/commit/?id=102942be401a99943b2c68981b238dadfa788f2d
> 
> I'm not sure what you suggest as alternative...

that is less than 1 stable release cycle. I think we should keep the
configure probe and fallback.

