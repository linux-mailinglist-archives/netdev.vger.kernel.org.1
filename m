Return-Path: <netdev+bounces-280084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHs+IYVe52lr7QEAu9opvQ
	(envelope-from <netdev+bounces-280084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA46643A150
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB47B300B62C
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A913BC69F;
	Tue, 21 Apr 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgPR+uMl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa7G/RrY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940B3B776E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770632; cv=none; b=KDTZAS9DLP0oyxBBVLGVVHsW/zDdQfalmQ1hYA93+b16RB1HZHGFXvmDMfdYnJkmPOd7YowxFO5RXTRyv+SrYIOS5Lj12ZDs/qMA5C/CxpcrywOioIPV4BOU4hfZtAtXeh8lXNZgNrjnfAP5ka4PlZ0ViQJcIunERZ7ezRArI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770632; c=relaxed/simple;
	bh=bvsNNhXjDuCqvJ4f2MCP+3c83kbaeMjS6Knbdq69M94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF/FLEFTCpxJSZ+EVdcjlLXOHirexq7tnSESWMe7+6m0ePMFhCdW+2bQcXStooemKK4TYkNV4fMQ2vj1nyWqeeSGbsatEJyT8N8GlWLLwqLgnOP40J+qjy1TWsP8rm/cwAT6kFfhn91d/FIaegvTkghHAMYylmeQONlaA8HFKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgPR+uMl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa7G/RrY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776770629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxVa+EsHT5PrcBeK2zG20jzylvTADEVkR1ky4LvMTjE=;
	b=dgPR+uMl04Q2wNh5vMSmdpe2lgXZnrlvxVYMM2clszGzFlUPvGenl90ugrZuQ9AFFPnFbD
	tsJIazEIHg779OTlexvZdBOV835rFA9llfiXs7/R/TrIBgnf9b8iAxhBsS0DQM4vYFn1aE
	QmEFLkGQSnb9MDtiSFPEswGGGwC1HtE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ICJY8UN1M9yh3maoq8yiug-1; Tue, 21 Apr 2026 07:23:48 -0400
X-MC-Unique: ICJY8UN1M9yh3maoq8yiug-1
X-Mimecast-MFC-AGG-ID: ICJY8UN1M9yh3maoq8yiug_1776770627
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso39682325e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776770627; x=1777375427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxVa+EsHT5PrcBeK2zG20jzylvTADEVkR1ky4LvMTjE=;
        b=Xa7G/RrYXOxuXt3XH2HtStzF4g6Fc+WN3RTovNSX19L9TAfC6lupaQjLyEOhnLxh2Q
         xviTHulK4JQ9AuMLR5gFRiKtRjF788rMUtJPMNHeAdlbI4WyWKZ6fZUtl+SxLdwolx7d
         d64GFjC+xDkdbY58fFtm3ejuKqN/GxPFJc0lqbT5AVJPw3DRyS2q4qF4wbW5WrEXHDJ/
         cJ06j3hMiALZal0bh7E6gfog3z2LbCgwmYBS5xvQe/PUYn2huaOxjtg4EYnmWXTa7cX+
         W4eBUU3iyToLVj6D9BJa4ruhkUTmDkdCoi2zeYfqAtpnA6Eb+GtLtz+T3zuKQMdvhX1S
         psOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770627; x=1777375427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxVa+EsHT5PrcBeK2zG20jzylvTADEVkR1ky4LvMTjE=;
        b=g8Tu2oEQkFurLJVE5sfqNZPaLUxy6oET72Lgk1kq8hG0r+AW9UnZ+nx1MMkZeXnYsD
         x3Y95mZxe4CoNl9S+PueVsz+EIy/h8UDz/RTOu2T1vtlNhcEiWGnY2YxaD5w15L/rxkb
         YHTceqRLotCQlcwkN2iUXH+WXAFXcPMJFf8VMr4O3rn1bdQ9IGN1Epf7PXgPWxphoBNs
         LiNtL83KQprb/cHV3KDMIGpTsX/7znoPrQglKD7nJJFTkVZQr1/5jHcvtNWD6Hra84IL
         iK/rb3BATRPIFyBUBgB8RIDeejEl2/YeRyMTdGC6npXeaUs5TN+951kiM68NBQDv0Zbz
         ZEBg==
X-Forwarded-Encrypted: i=1; AFNElJ8CpbaurG/vuMUOQFhUIrSh1zXbk2bS84o5w/dVHEYgAMsso+OOMrjpGwfh9WhYPYtj2o2ydpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyes0IbmXUfS1nD0pVI8Hicfea4ZL7KszMDpiPxJjCPCGqjvSt5
	AIRbOc2Y0D4hKNx2UtKua4GtsJnGiKv9oU0ME3QZSvbb4oT7+4Xw85oo0cUjdr6yy/Nixi73ulQ
	yl/jVqogY3EnyVN9FXzUuJym5Iky4El4yk6RjdcmB9DyAxvuoeW/FUOKSnw==
X-Gm-Gg: AeBDievjsFtyWLiYzqV49LZasS39BbPS7blwwsh7VFcGrmippXDV+gQzcW34n/EktHw
	k20kxCVOzMxDc9avicw4EgBSKlVnuqEHv7s/kbNDXCDbzjBItmYlD2j9kjMOq1+HoIYFkl81tL2
	5M+kJMCYY1i9Gbmb9dhpqPpCPjkjesnBuSp4r3r4TIps35PEc6P3HsWmn8GW0iWqkLVFYb7SR4J
	5MeDY1HWbl0wQ51CO5USqmN4Z/8P3vixyHhubYwO1rMobr4uquWq9mmXxNbieIIDTu4HXZmXcaP
	CwHf4jNbx6AC8cvMX2E9dOBlhVhWyi62PLsOBxTay6otQ14wOAItMKmnoBmYp7lbCLqKZI8H8mW
	abhq8yHCAn2Haw+LMhDLhJRMKjBUP9EOimSgXnkBqfp+9Ve48tAXb9AoWkuoIFBFU9Aw=
X-Received: by 2002:a05:600c:3150:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-488fb792ce4mr260922815e9.28.1776770626884;
        Tue, 21 Apr 2026 04:23:46 -0700 (PDT)
X-Received: by 2002:a05:600c:3150:b0:488:9fb7:376d with SMTP id 5b1f17b1804b1-488fb792ce4mr260922425e9.28.1776770626440;
        Tue, 21 Apr 2026 04:23:46 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.104])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm334535805e9.15.2026.04.21.04.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 04:23:46 -0700 (PDT)
Message-ID: <807622bd-1001-4202-b612-c8504fc7c67f@redhat.com>
Date: Tue, 21 Apr 2026 13:23:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/rose: hold listener socket during call
 request handling
To: Ren Wei <n05ec@lzu.edu.cn>, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, kees@kernel.org, takamitz@amazon.co.jp, kuniyu@google.com,
 jiayuan.chen@shopee.com, mingo@kernel.org, stanksal@purdue.edu,
 jlayton@kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, yuantan098@gmail.com, tonanli66@gmail.com
References: <cover.1776327338.git.tonanli66@gmail.com>
 <52776256bf0fc38de92fe3edf39434538b672b69.1776327338.git.tonanli66@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <52776256bf0fc38de92fe3edf39434538b672b69.1776327338.git.tonanli66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,amazon.co.jp,shopee.com,purdue.edu,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280084-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: BA46643A150
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 1:01 PM, Ren Wei wrote:
> From: Nan Li <tonanli66@gmail.com>
> 
> The call request receive path keeps using the listener socket after the
> lookup lock has been dropped. Keep the listener alive across the
> remaining validation and child socket setup by taking a reference in the
> lookup path and releasing it once request handling is finished.
> 
> This makes listener lifetime handling explicit and avoids races with
> concurrent socket teardown.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Nan Li <tonanli66@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

we are moving rose out of tree:

https://lore.kernel.org/netdev/20260421021824.1293976-1-kuba@kernel.org/

please hold off until Thursday (after that our net PR will land into
mainline), and eventually resend if the code still exists in Linus's
tree at that point.

Thanks,

Paolo


