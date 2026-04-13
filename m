Return-Path: <netdev+bounces-278064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H03Bg3f3GnrXgkAu9opvQ
	(envelope-from <netdev+bounces-278064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:18:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED73EBCC2
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE77F307CA37
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254743C345B;
	Mon, 13 Apr 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KoMOad7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7F93C3C12
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082321; cv=none; b=ad21Z9isjkR/4gHTM8Sl7+1Tkf9foQdWA3sAC2aoBOsffGXUUOwnxUACUSVX0oK/f/jvZHouupTa3TZc+z9LqABTGAEwgCp6yZsjX2ZDqcXrCSReVp1Vv2VuXSO/1JHT519EHWX6wnzgcj4jYp7LciT+tBW67bzedBGlJswjLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082321; c=relaxed/simple;
	bh=BOMkJNZe7ziU198TlUPDD8T7GrSLx2ZHdq3BCysj9to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJwVxpCCcwIPL1zjlFBW3T/AkwxAK35suTMicHivXvua8ln+hLWK9J7y2YPEv4pmzUQXhsqJTGpqpE+CEYx7AnLx5QOFNp55uQIm7x+sb29+et485KfESFSVvdW95d4+W8gEuAO9oUDIlOelS/YGhVcZlLEYe6xzvWHxeExqnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KoMOad7U; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso50936385e9.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776082317; x=1776687117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1d0Zke0oSY75WUereA/hlkl+rDQeWUvM6YTyJyDqC4o=;
        b=KoMOad7UUU4ksFlEhIMiH26sEjv2oNaAiS3Fo49rFc3jENaHgF+5eg3m2ZHm8Cl+T2
         jYO7IkzAEGLU3Xn3y5tSeqPLLbYfxVETDfBKtaaqOhC/RAe2HP9l8SEqRGMxGAE7ozZp
         PrB9drUJZChI6M+0rW5sOMWMwypjTp0v+NUQ+IZR60R95uVwyGxqDZ1JNCU99XDAC3VD
         bPftYsPjwb5jiCAtK/ivefPQFN1AO7twNB+PKvCkw71BkNXMeUY64jOqJeTvTzQJ+B5U
         IeRtl6T41OY+GSJYvcxSMBm4u74gaXj+jrKPvWjHnEhQkvWO3fI4By1TlguIa+x6jRm2
         FJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082317; x=1776687117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1d0Zke0oSY75WUereA/hlkl+rDQeWUvM6YTyJyDqC4o=;
        b=S8zuHAhp/z7kBXg4KhqRnR8isy1CipLRvTlTeAHAcdBqMwJ5h2pK+E0z881MEfbsCI
         VbLL9Y3eGp51YDxeO4QmtNy7cr7TcvmYLQ9PwgEBNbWpE5PX/3wngdjCLluFZlzXkKrv
         btI0PfDE6psMTL92a4o5c+mKQaB88fOcmd4kSvY3i2S89MzdlS+BR4Gsm5aYHC4KS5a5
         /UXdcjiHV31eYDHmUfTtgwI1c+dKa0NxwwCPZlotwqQSmAnb3EqdQKG3ypWqSBhLIDKi
         CzNLF3CamcaZgwCxD9RilpgVymbqRo1AyD8bBrkb3pCOAdn/uNE5TBjojP9BLRewq0Js
         4p+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/JLIq/pDekLdW5AekpsgU6IgkmivSUVfXS/aasfaPupgMVv34c7WPYZHhSfZWhMNggU1kZqs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5nZrpXHpeZaESCvdRdJPTHO7bSGkFuLP8iv9T272s3W98JPk
	DGPfqlWHoeI78cCyg0l9M+YOetmTk0es6KlzTDr1IjvclHVy5KEaGLJjccD+bwAedEw=
X-Gm-Gg: AeBDietU1T8lWHsw7agzS6/pjP5ZzLRD2jK/+147DfMn+0IhvkZB2juy9hB+jdcfkLB
	Zb6+plBtbPX3RchDGHIxEcdgHCP3zLfo3J71EmH7YpgXFvCPYARwdH04RUFnQCAYDL26X/O/5ar
	VN1KjwCO5fKSnsj8/Iv7ojXxAR7lyUeWv8Q/jbZhTdK1bUwUpx9MD8OiL3R7kX5U29FjIc4HHlp
	DYNtPwE7/d6yGKQVRZFxYXHH17+Vvk7F9PfwOzkmwitdwBFCGvoYSYd9PcIrVJUkbncV1nc69Yj
	+g2QK8OWeq1txy26I1gr8cwvVoMx4dPDvJ7Y8DpvrfsY/2lr7Z3PlY/Fx0XAcaGogCm99NSd7zP
	W2rDk4L1rkin/fZAPuPa2tuh/tFcPQo6w6OuceznM4CIz3I/jdljoJ5vzMnL136Fm72HTgNQOCK
	P47mblXLY9/G+a3l0N4ScO+fJZoJ5uX1hN+iTphF5Zlzgz2Xq6qXXjZt0Zc/lujxv3cA==
X-Received: by 2002:a05:600d:1c:b0:487:2439:b7be with SMTP id 5b1f17b1804b1-488d67bf6ebmr141736955e9.6.1776082317203;
        Mon, 13 Apr 2026 05:11:57 -0700 (PDT)
Received: from ?IPV6:2001:a61:1301:4901:4040:13bc:108d:8118? ([2001:a61:1301:4901:4040:13bc:108d:8118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm386966275e9.3.2026.04.13.05.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:11:56 -0700 (PDT)
Message-ID: <198c1240-80a6-456c-8b12-25158c90c965@suse.com>
Date: Mon, 13 Apr 2026 14:11:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject negative chained NDP
 offsets
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 stable <stable@kernel.org>
References: <2026041137-comfy-eaten-a1ed@gregkh>
 <2a6963c8-4a87-4fed-b875-d46f3ce53e42@suse.com>
 <2026041325-giggly-wrecking-e6ef@gregkh>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2026041325-giggly-wrecking-e6ef@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278064-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 63ED73EBCC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 13.04.26 12:43, Greg Kroah-Hartman wrote:
> On Mon, Apr 13, 2026 at 10:36:19AM +0200, Oliver Neukum wrote:
>>
>>
>> On 11.04.26 12:53, Greg Kroah-Hartman wrote:
>>> cdc_ncm_rx_fixup() reads dwNextNdpIndex from each NDP32 to chain to the
>>> next one.  The 32-bit value from the device is stored into the signed
>>> int ndpoffset so that means values with the high bit set become
>>
>> Well, then isn't the problem rather that you should not store an
>> unsigned value in a signed variable?
> 
> No.  well, yes.  but no.
> 
> cdc_ncm_rx_verify_nth16() returns an int, and is negative if something
> went wrong, so we need it that way, and then we need to check it, like
> we properly do at the top of the loop, it's just that at the bottom of
> the loop we also need to do the same exact thing.

Doesn't that suggest that cdc_ncm_rx_verify_nth16() is the problem?
To be precise, the way it indicates errors?
As this is an offset into a buffer and the header must be at the start
of the buffer, isn't 0 the natural indication of an error?

	Regards
		Oliver
  

