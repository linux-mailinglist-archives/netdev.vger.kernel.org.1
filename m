Return-Path: <netdev+bounces-278374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLtXIvAL3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55F3F817F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F12E301022B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3D73BA23F;
	Tue, 14 Apr 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcJF8tMM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqUCO2/E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190182DC32C
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159721; cv=none; b=LeXbchslCDALJcuANxxhO9bRkttIlHyX2bbM5uRT48LS0gOLkWF1wmdQZLMcQgEw0dEGiyaq+Ek9Z/gnBH/MNKxzgQBG/VzJ0rXt8o19Mg7bdkCixQ7vEEW2V8sJdKop4MV7nYH83MRe7XCbEoypB5PC12kj/VsXC55PoDBbBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159721; c=relaxed/simple;
	bh=ydzgHuNWO26DXRwAKMsnQ0HVug0d+eooxg7k0fZvtVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8hcsbnsH4TDqQElrmoCplOsBzkenBilgL32SU+t6xsGgA3ywpaT3ki670nvxgbcWYvxSqM3FYPYVV2vWaD957v54pUzpmGMo58+WD+Lb6ArAuiz4VO5XTCMREDCOxatRGLxaOnns+0Ko9WwkKDerA1uFbz46yqN2/Ta58vw5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcJF8tMM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqUCO2/E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776159719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FELt2dkZpqjTQBtoM2kh22WHuyLD0LqG0oQFeQHOlFY=;
	b=KcJF8tMMk1NOWovxMh9Qw9xAOi31yJ4U+HiYrNQACmgBna50v1xJ7ryab81qocs3MvpOdm
	mnztOyBmPc1v6c4dho6hpK20i47vaSFU4XALagFiTDhMZnrt971TGRoNK90CQfI0lYsYJt
	o9+L5/2896i82z2xnAqqM4dCkk30v84=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-yKPI61kFNWq4S55dSFFCKg-1; Tue, 14 Apr 2026 05:41:57 -0400
X-MC-Unique: yKPI61kFNWq4S55dSFFCKg-1
X-Mimecast-MFC-AGG-ID: yKPI61kFNWq4S55dSFFCKg_1776159717
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so5732483f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776159716; x=1776764516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FELt2dkZpqjTQBtoM2kh22WHuyLD0LqG0oQFeQHOlFY=;
        b=YqUCO2/EsQGmNvzVDe6MMDaVj20yOp7JIHP1x4ZdjMyEq8i2Mqh7NcNe89l4Hfk4/F
         7Cbhjo+DWkIdp+9jLK8dJe15E1CiddjyP9JKfpSkxr43BZkIQ9YmkovieE6eiGyryAm1
         obAinFCT1uvddQVCo1PNIn0SLe69AvStAmHinT+RZ2ZgI2Wsl0Vn+aht5TlB+29rqmdZ
         MHS/eZbyB+rGWNKAxPlwHfMCtIT5CbL2ch6rsPNNni6lY5qmCJ0V94Jn/pgiRFgE6xjS
         5ZxEFdsdvTjy2wjs0VkFngNSenp/qedIN8IwJapaZh6Gxh+wny6QsgdLQjM9XV+8rb5f
         1cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159716; x=1776764516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FELt2dkZpqjTQBtoM2kh22WHuyLD0LqG0oQFeQHOlFY=;
        b=LakPyWHyn7S3sHnXBkGMSkceqxmLqDoYz7JCABAAjtdqdNOPIZ7K8NsAk01OPPZMjP
         PhOGe9bN9/oQm886Dl8QwbiybDNq2Jy6iZlDkf1mIrGU0K6zScMMHBCrb+GF2O+xgMGS
         i04flzO2atn5K0fARd4oilZYPTMF+69ZErXxxKZ5Lt1KYRDoQMZEWrYJdk9TXkp5ynvK
         xEZYw5SL4IfXbKBj1m6f/vugRpZW1DHjAmOfQK7EEQrDKlveX6hXX6koDODQ3d+l0Rmi
         IAJx2W5cxSkxI+J+g4BDeLnFoGxsw71C19p9FYubu9RKSg5JUgj5PiKoKL6x4ula/HPm
         SWEw==
X-Forwarded-Encrypted: i=1; AFNElJ/g17ah98WqmOfhG+RofF6raxPiN8O8b/rbnCC4W4T8J2kxtdvLlXzxlZQ+msRWpL4IPA4ZeY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQQGmKkw/1pa6ymyWy2H4zoDb3uE6d3Oivyj3VWUzsyJZW3Z3
	GL9BZ40Py1MOt10kmO7GlyXplhoIVNupPNWytWQVFbVH7zw5Zwf5D7uA/+wYDxK/M3i+JuQtVgR
	gbeLKTAt180dLcp+GWvwBO/zeqTbGU7EJCjAMwcwRvtB7kx2xLXcYuoH9jg==
X-Gm-Gg: AeBDiev/4NXzWL2+HJ8Xq4E3xC9hHXkSHJyPvlvfJago6ExdK40UjZYbH9KqwqmWUul
	d0tRRT4O98yaMZlnLHIQgMx+koPGoAcAErQVG45rpc7mfwh40lY9rDBeuQghzK9WmCIv+KhqMkW
	iwWf1WQzfUaJb9X44dJsny9GYB8YdxXZiHCjjVXaMg94spVy256yYwU0ZD+3Uf14Z5tSEH9GN3m
	1IVxt/jxsMCzOfdBGRwpw+dE9bWy0oL0Wvj6ELdMOiiL/ZFZZ4mgfugokdHd1jbrv5hkPzva9Gq
	6AktLqke792X/cA2IqjsZ/nq3oth0zVxAW74uV+qAZasARftfL1teZQLpaA6IvHceCpS+mGyGDh
	XzIUQ/hqotbqQmDNq0dwMHq88BzPOQP0+aV2yY3267j1meutqBVvNDP6C
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr238976285e9.2.1776159716625;
        Tue, 14 Apr 2026 02:41:56 -0700 (PDT)
X-Received: by 2002:a05:600c:64cd:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488d67df592mr238975905e9.2.1776159716205;
        Tue, 14 Apr 2026 02:41:56 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488eddb9751sm61642165e9.0.2026.04.14.02.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:41:55 -0700 (PDT)
Message-ID: <3b67dedb-3472-4322-9a30-32bf8e3cef99@redhat.com>
Date: Tue, 14 Apr 2026 11:41:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
To: Pavitra Jha <jhapavitra98@gmail.com>, w@1wt.eu
Cc: chandrashekar.devegowda@intel.com, linux-wwan@lists.linux.dev,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <20260411083957.567676-1-jhapavitra98@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260411083957.567676-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278374-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,1wt.eu];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B55F3F817F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/11/26 10:39 AM, Pavitra Jha wrote:
> t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
> a loop bound over port_msg->data[] without checking that the message buffer
> contains sufficient data. A modem sending port_count=65535 in a 12-byte
> buffer triggers a slab-out-of-bounds read of up to 262140 bytes.
> 
> Add a struct_size() check after extracting port_count and before the loop.
> Pass msg_len from both call sites: skb->len at the DPMAIF path after
> skb_pull(), and the captured rt_feature->data_len at the handshake path.
> 
> Fixes: 1e3e8eb9b6e3 ("net: wwan: t7xx: Add control DMA interface")

Wrong fixes tag:

fatal: ambiguous argument '1e3e8eb9b6e3': unknown revision or path not
in the working tree.

> diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> index ae632ef96..d984a688d 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> @@ -124,7 +124,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
>   * * 0		- Success.
>   * * -EFAULT	- Message check failure.
>   */
> -int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
> +int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)

Undocumented new argument

/P


