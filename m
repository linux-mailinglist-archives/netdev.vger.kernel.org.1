Return-Path: <netdev+bounces-280780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJdYMz0u6mmVwQIAu9opvQ
	(envelope-from <netdev+bounces-280780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:35:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14880453C7E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C0A530432D8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2F9311967;
	Thu, 23 Apr 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3OPJzSH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtFDFXIE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F11A680E
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954554; cv=none; b=AzFcwz3BzoAavcuShtu2fo9MbUDcW0lbkeBmS4PaYtctocAMW25kmGIrQ3XXJ+c1YUzSIQC8rqHqlw6RRqaUKGseUjeDQzm2n8TydLrtEAVAoXrCKkj9N1/sVQXzfouHA1ud7ZGtkVTBEVCjOq4PFOY03jsgqiTM/AF0RqlVSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954554; c=relaxed/simple;
	bh=GFNw/wZGwOTusl3rL6b9d1EVaGY5WK1WmpecL466I30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIFeGl9cgOb99sQBDR8ns7kRXKad+J3SFWAGunOfL9Fqy9XsZdN5zDnjKiQExnYaZGwPwyEbM0padcpM2k9pc8/E6TNTS93HhSrkrhKZpWOxd74/FiRqOkwHJSrf05Avt5koxZuBmIsYD7hUAGzCIrBOviCXJtWWKigLfNR0wPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3OPJzSH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtFDFXIE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776954552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJXAYCiKedl47jf6xE6Z60fJSrR9e2EHlsKXBtesuI4=;
	b=f3OPJzSHzGmz+uv7l0mUT36o6rX+Rhm7RgZ6ZT/c+WxdwW5ief0AV1ggDra/9nBqlASPab
	CwO/XBpGejPNlxAA8Q1AqZPM/MvSjtwq6kX6ZVfhA/yv8XdY1gPv4QXUQ8RoVDcxKtAWbD
	uanaMSshDy5IEIz/q0em0V8UKMuqR+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-afsn_4x9Pm228Yg9oJ7enw-1; Thu, 23 Apr 2026 10:29:10 -0400
X-MC-Unique: afsn_4x9Pm228Yg9oJ7enw-1
X-Mimecast-MFC-AGG-ID: afsn_4x9Pm228Yg9oJ7enw_1776954549
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48919890a95so33470585e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776954549; x=1777559349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJXAYCiKedl47jf6xE6Z60fJSrR9e2EHlsKXBtesuI4=;
        b=ZtFDFXIEAFL1lOddBMl7R3JlXSzCTZi59GTEMU2xoEZ0Cp/evVQ4ofGHTEjvPCbe1H
         aVyzysmD27baL/VCxQAZavAhmiHIZCU2KQiebYP9husah8/ECNphRc/oL1g7WM1OfVl5
         rQXM1PonQV+qQwuJfS4tZcn7wZc3Xfh0lJD102MWYUf3JoyZu7CYn4vIOW8Ras9gPRPM
         /0QlgKOMZLwH+iwHFRExOWL1TNiNFZX/3QAhGTSXmg7BoNmqJ/272/f3j1ojlxAebX+n
         Ge7eOfu1lhrClo5Z8E7jH9mDj8KuPTOFtdM3vFkCGoz3l62hB6tEa6WHqvDJcJCXtrIP
         n8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954549; x=1777559349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJXAYCiKedl47jf6xE6Z60fJSrR9e2EHlsKXBtesuI4=;
        b=bGScyW78dRPAUDdNmBPxeGF4yWg/m6FZYdi00rUeSYp5qHv8LWb6UWFwPfXgaLKUP8
         5myhubTNYA24nnM3MqynNbn+sLz5lOwpThzoZpgcJfEHPeA2B9CTWVPl1E38L84JZq3+
         HQLIdxOQnf8K3aVcVterpPw21hn7TEpCfCw7bhgd6X1y1n5ugXtUIRpBsStADpK96cmm
         T3sp/7K9e9A9rOQAqBvTnaSvNpqXB5Td7BwzbiQ7KcKlaCT3TFx78i6xs9ZKYiclviCE
         XyRe4IGcbysyVI6sEaA7LZNz8bOO3lIzog2+BgIa36vp2zh3yB1XlzU0+6T1NbjUZJsx
         FMIA==
X-Gm-Message-State: AOJu0YxjbVJ6WXr2LxYFHYGOhhYXM+p4nC9JBncL47CjWCzM83VQZ8zp
	dbNU1SzJQKtgbY0XfV/62Fh4Pb4FUoxeqH4mhpQvzkbZOyGxjYWzLHLtpwqWETCfTIBOpb8j3nP
	rHNSfLPuXQ/w9M/IetH9+wvX+zaYiYvVlyAwGnqDHXczzWfgWpNzRDdizRstiY4DRRw==
X-Gm-Gg: AeBDietv/1YvSJAe02nWHTAkUUCfCKMN7POd0FADIJr0RH690zkPu2A47Ne/zXHJBDK
	tD1ymMffnljoTU9LHi+aXbpd82czy45ueps0Ve4KtASreI8Q6UEZ+HBPEQeOrKqB66INJiiWcmr
	fmIxCMyQHA3btJqLqD8tzexho4na/4zbjfRUYG1eR0eH514PyD5+FPqb40m3SOXvIfSnIGQuxGv
	YDTs/nneO48LCH+fXVnjJWA33vRFNQGWrtOn0r3B6uZpFx5uM2EJzaeJQIz5EJE/F4M050+cm2T
	4f8NJwK10Wl14eMC6PxoiXXiBHvFF3gC7V+6Yfaj+I7y26N4Fza7xuiJHc/j5+HwkQ3vK+6vnUh
	YdQh/15cPbGXOBW5WIR3HbrkXxhUIcx4O2R441nkmQ/YCRy7WtGtKqUsL6SmWoWcBGkw=
X-Received: by 2002:a05:600c:1e28:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488fb77fbf3mr389501915e9.20.1776954549205;
        Thu, 23 Apr 2026 07:29:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1e28:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488fb77fbf3mr389501355e9.20.1776954548690;
        Thu, 23 Apr 2026 07:29:08 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm164855685e9.3.2026.04.23.07.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 07:29:08 -0700 (PDT)
Message-ID: <a8634793-e905-4298-bf48-ba9a2e9c3eee@redhat.com>
Date: Thu, 23 Apr 2026 16:29:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: clamp MCAST_MSFILTER getsockopt to optlen, not
 gf_numsrc
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, stable <stable@kernel.org>
References: <2026042054-dime-spectator-820e@gregkh>
 <17e348e1-b551-41e4-a512-906109dded4d@redhat.com>
 <2026042345-prompter-boogieman-1f5e@gregkh>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2026042345-prompter-boogieman-1f5e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280780-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14880453C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/23/26 4:18 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 23, 2026 at 03:57:55PM +0200, Paolo Abeni wrote:
>> On 4/20/26 9:26 PM, Greg Kroah-Hartman wrote:
>>> @@ -1486,8 +1491,12 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>>>  	gf.gf_interface = gf32.gf_interface;
>>>  	gf.gf_fmode = gf32.gf_fmode;
>>>  	num = gf.gf_numsrc = gf32.gf_numsrc;
>>> -	gf.gf_group = gf32.gf_group;
>>>  
>>> +	if (num > (len - size0) / sizeof(struct sockaddr_storage))
>>> +		num = (len - size0) / sizeof(struct sockaddr_storage);
>>> +	gf.gf_numsrc = num;
>>
>> Since this is exactly the same code added above, likely a common helper
>> would be useful.
> 
> Useful where else?

Just in these 2 functions, to avoid duplicating the logic.

Not a big deal, but it would feel nicer. Also the

	gf.gf_group = gf32.gf_group;

statement is moved around but such change is not needed, right?

>> I guess we don't care if this would break bad application passing optval
>> area properly sized for gf_numsrc sockets and a small optval, right? I
>> don't see how to eventually save them.
> 
> I couldn't see how to save them either, and if an application sends bad
> data we should be rejecting it, right?  Especially as this overflows
> things as-is :(

Agreed.

Thanks,

Paolo


