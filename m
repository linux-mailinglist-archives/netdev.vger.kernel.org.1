Return-Path: <netdev+bounces-280770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF77C3cl6mnwvAIAu9opvQ
	(envelope-from <netdev+bounces-280770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:58:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C754535EB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D42033015D04
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334552F745C;
	Thu, 23 Apr 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjHVWTuL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORpcTa7l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA02E8B9B
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952692; cv=none; b=JACUpaHgbLAlzRqGzaqDW9DRI8LlTZBkh5oCJN4DOEmkaUBCFYANQLU8ahfCqHMIlfkmQtakYTxaOdQeYhi/mMOyY7i2dLFgd3DruIa42oBQJhzWN1VhSh7XYPs26LT0GAAoVK8cYglgR6q1/phewAeUBryYOEY2U5TNW12cgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952692; c=relaxed/simple;
	bh=hfGGgBPokEAfvho2d5Jj3Js9d9sXeoFPSjF1jhLSyvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dzrx+fnqnmtc20hdOrCsdDFwER4M7lUWyD9doXYbCUuJaqQ6QxqsdO++I72bXwPhHqQau7/FI/GCPm77U0OD0DGLclogxbMGnndAOC4n/EKKWSuBhV0NVNEScDX5w1fJ0t0HmT65MRZtoJimem+4J4+AVMa5lG7/sAIl8Z4wlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjHVWTuL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORpcTa7l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776952690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i3R4cwsVYgf0ZmkRzBQJFfe0SckWkwOmgIlQyqb2AtE=;
	b=TjHVWTuLkrB+rF6FJCWN8J55xg6NoPGvcWJSx+eo5AJoA17ItEJNyKtKH5Kj76CyqFEy4B
	B9a1q0eauA2fOQuPORape3LZzhPDpr4cocPqBwUqXSapIexEbpGLL/H9G9oknWNgm5gKPS
	LENd/K1nI1cOwDyVyPp5Ut6jaN35KGk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-h2d2Gcn2POOVQLTSh8qDcg-1; Thu, 23 Apr 2026 09:58:06 -0400
X-MC-Unique: h2d2Gcn2POOVQLTSh8qDcg-1
X-Mimecast-MFC-AGG-ID: h2d2Gcn2POOVQLTSh8qDcg_1776952685
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3568090851aso16203844a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776952685; x=1777557485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3R4cwsVYgf0ZmkRzBQJFfe0SckWkwOmgIlQyqb2AtE=;
        b=ORpcTa7lT36ul7ezIk02hXHA0ZpaGbxgz8ukTbGgoF0EDMyArEkGIJNcWBDxLFYqlr
         qZig7gWyAbVHqDkq05GXZNbIpCgtOJgcCBYbCFsCzAC81dFWDWDsS4h9FQb08EqjsteE
         EUm81PKdOkd6OcTng+y5KfMSW7onpuHvfjoN/rCy+LhyEj7pkFA95okh4W60SKI+4flx
         HwPG7FIy68Mi1iVxpFnYneoxHvnVd/X+4iQ4xAF1cEkXTLXlELKsxk31eAM3B8bEaM99
         6HPP7FjXMwZhCWfY+hpre6tlK0d/KSFL7Ye0XACt4VVZhVYDzbcz5rVAj1cdx7LA39ir
         +I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776952685; x=1777557485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3R4cwsVYgf0ZmkRzBQJFfe0SckWkwOmgIlQyqb2AtE=;
        b=bg8bJ+yvvDjg8E7x/tJ30a+nYQKFXL8bIqudWUn/GYqVTXjLxE9DCCqp0go9BTs3Qi
         pO58ZY3hjDijeZ7YpZEbCRpgV+3pJRf/qcEBUPPwrmri8S1Ne95/bxi9Dl3jKJXWbbCB
         C8OUMHiAU5RTBKEoo6KRbJ6QHcpxsvcPRQ3w7yEY7BqVwpQvcS+rK9b9pzEKrpUFFQRz
         NHl7Ku5ASJHcD9QzCxn4uBFimk9HzGwBb9452L4LYsGOV7Eat/8l803aBbd4cR/q5Ifp
         uWhjhTXDbvz4JRsAht2n1cLN47Uoi10ziaLJmRsyUr+efGJnhC7weE4lXT0SM9jPzbPL
         RauA==
X-Forwarded-Encrypted: i=1; AFNElJ91s+Uf7BcOSjm0wYD2G7xHKJ9rNKWw9bqVbyoZKmoAz9RK4N4odqEK6fqOaMpSS/xCzeRw0xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOlDrt7Kr66hIu9WUoL4T1JAyZkxBY5cjQd9m+9xeSh4w09gJg
	huVS/OT7Xb88E0EGMt+2KRZvgkJ+FnwaaWMa7Pryge9I48DV1cLEsksYQB0n3DUSvJPrIGxEqvw
	tSuKB4XKCXmotGkEZDTzldPp/iWwV77gtQIDxCrTglwFkIq23FXI4wJwtNw==
X-Gm-Gg: AeBDiesHxiIDASeLPF500ng5znTYeR2arCHwxwqLHaEX9lAvt7NVc/Zpsa45IocgsRq
	ygcAtTAZMEUDfHMgY7gDDi+tbGIrn3fNl0eZBYpJRd/HP3vhcEqRfZB3R8kpvQoakbtDvXlsj10
	gfDgtCF8qz4+NgOvHuEzZ//vI5ZUdJv9FF2EyydBRobIj2sbI+SejxriocsMkZRYKAXUSkT7Twb
	lLiIzS7fU6OMImuUdtuMVbhGuJj9XKkj67bbgkg+c3j4HuCo03vqvm4AozLc8vCLIBccJT8vybx
	kqjTiwqQZkr+eULfwI+D9FZ+MpydziG+1q9SSnfKYgzmt/5bxLdHNmZ1iQinxXT5hwYVAb7G/b0
	OZjt5dO0WytTDQ1BxWcJ2OvOh5pOR/+f8TMh6lwmLl8bJGasysUed/ysg/0IPCP41dFE=
X-Received: by 2002:a17:90a:16c2:b0:361:423d:203d with SMTP id 98e67ed59e1d1-361423d248bmr17653606a91.8.1776952685320;
        Thu, 23 Apr 2026 06:58:05 -0700 (PDT)
X-Received: by 2002:a17:90a:16c2:b0:361:423d:203d with SMTP id 98e67ed59e1d1-361423d248bmr17653579a91.8.1776952684805;
        Thu, 23 Apr 2026 06:58:04 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36143b0dc2fsm19917307a91.3.2026.04.23.06.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 06:58:04 -0700 (PDT)
Message-ID: <17e348e1-b551-41e4-a512-906109dded4d@redhat.com>
Date: Thu, 23 Apr 2026 15:57:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv4: clamp MCAST_MSFILTER getsockopt to optlen, not
 gf_numsrc
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 stable <stable@kernel.org>
References: <2026042054-dime-spectator-820e@gregkh>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2026042054-dime-spectator-820e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280770-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2C754535EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 9:26 PM, Greg Kroah-Hartman wrote:
> @@ -1486,8 +1491,12 @@ static int compat_ip_get_mcast_msfilter(struct sock *sk, sockptr_t optval,
>  	gf.gf_interface = gf32.gf_interface;
>  	gf.gf_fmode = gf32.gf_fmode;
>  	num = gf.gf_numsrc = gf32.gf_numsrc;
> -	gf.gf_group = gf32.gf_group;
>  
> +	if (num > (len - size0) / sizeof(struct sockaddr_storage))
> +		num = (len - size0) / sizeof(struct sockaddr_storage);
> +	gf.gf_numsrc = num;

Since this is exactly the same code added above, likely a common helper
would be useful.

I guess we don't care if this would break bad application passing optval
area properly sized for gf_numsrc sockets and a small optval, right? I
don't see how to eventually save them.

/P


