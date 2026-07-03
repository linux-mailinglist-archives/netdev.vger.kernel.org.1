Return-Path: <netdev+bounces-304610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuONEC7mR2o3hQAAu9opvQ
	(envelope-from <netdev+bounces-304610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:41:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE98704588
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:41:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EglXRgHc;
	dkim=pass header.d=redhat.com header.s=google header.b=GLuF2cc6;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304610-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304610-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4683A306F637
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194632D6E5A;
	Fri,  3 Jul 2026 16:37:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A5301486
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 16:37:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096673; cv=none; b=Ki2ZG/dKogxvoJHsCOFDPurnB/PNpQYmvP6fwMyMUL3IWYwNGk17SeuiXG4eglj2cnwzWgJ0taQpDqE1qfYq16d86nll/XOCeWmYrywXTGacLK8rJU4l3UtIkH/VK1ztbzq/rG4pKniaK4UShx/rdRApNg7ZzabjcJDoCyhM86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096673; c=relaxed/simple;
	bh=rvTGz4LGpj64vmtUCByDEmmEVxFtHAKgKCZFNyO3Rd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWMgrgrx3yV6XFM6CtsPtk5I8Iop04i8YYkP23KFXPKNpIyBzHUKBsW2dXemEnrndQMVndxu3+XNPS+H63lyDXfiSIU3RNhtNGJY3TjokgiNnYYXpB0jQrzNd6by5dhZAe2yFcr9m85sXEo4ezNoLd0HDj+jYwEuPCTTuazidp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EglXRgHc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLuF2cc6; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783096669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcx1EKzkvkabWkcySDgIRTWl705sfc5nfabQik0GNdE=;
	b=EglXRgHc3fv0xfgH6AaZiAEbPHEs4Ng6WD4QZUCurXnEpMCHN2hp7fHCU5gUlydKZBdqt9
	QgNwhEJbaX84N+KrRy0jmmVA/M3AbTxCvU4LghBTG0Wemqo1hGcOo2RAzeFcsTbCcpQwFP
	9xwGraRhFO/Q2mtwnvzqrrMbUPPAIig=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-KmWHj42kPSyreF7TVO7tDA-1; Fri, 03 Jul 2026 12:37:48 -0400
X-MC-Unique: KmWHj42kPSyreF7TVO7tDA-1
X-Mimecast-MFC-AGG-ID: KmWHj42kPSyreF7TVO7tDA_1783096667
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4925bf70f5bso6903755e9.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783096667; x=1783701467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcx1EKzkvkabWkcySDgIRTWl705sfc5nfabQik0GNdE=;
        b=GLuF2cc6ClIiuj7vUP20gbZwwzUEY01lzB6Snovb9N49YkEQlnYd3KNwblJhEmnTLV
         sCRNO9xl4dASKYcMJtNalt0CgU4vOc67+0jJrTntRB7MkGbcYBqYhzP43v7x+cGSkAOt
         wwSimfvH1Z9rIzZuMALnmwZrlyRmNptan53mxLR1NrXoGx1JgJgvWExjKKOHZEsBIvBI
         0M2spKyCMye9v04tEysbxCgHJdhdolwqnTMIEsg10WmPirQjbYW3dfpqBism37mY4Oua
         oECyKX+RLTeEARRoZRw4gGPRBAwO1u+99B+GMNgSJGp2d+gkYK9/MJ/XBQ5Zh0EKJRgQ
         eIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783096667; x=1783701467;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcx1EKzkvkabWkcySDgIRTWl705sfc5nfabQik0GNdE=;
        b=LXt76JAXkophNNR3cjGlnRQ9ncKRwlTgSPClH/x0M+/mU3qgKX6QtlafMSsJLHSnE8
         rtWtaXVf+GAJKzLQJELrl275alMkQxpDuCQDkOpztRnc++NBaGfQl9DJ2FzL4Wm8edXE
         w8ASOKBJ09CtJ/5tSux4Hl/P0BKPA6Hp6gC/Oj1CIK1HBrI/Pr/l5N9yNNbRZtKSHAXC
         WAnYeN3m4Os52LT/OVylm1vFKaUi36Rje56rubtYZekNabppni97QQWfAptAkIc18nHy
         qbKwhb32rLEtXxFgpa3oS/UEMpvf2XvQwhOL43lo/YauuzOyLDPsV2mecLLMH6qLYiIJ
         1+uw==
X-Gm-Message-State: AOJu0YyS3+uK/tnUKmLv9b+eH3oPRH6qNrfLKcMUGt40qlzHZ/XQ4Flw
	Qi9hxeQGszQWh7AEwATGaTkGHlBG0vRRzf+vj4ZZtwDxZzZBYm8QqLp1+FAZkNp/Pb5//sowHBr
	7+VhBQqJqRiH402g07xGBJheHAmW131F/Z75pxTEHmwOOzBa/9TOSrr750nfc9ssCjw==
X-Gm-Gg: AfdE7clf0Nz5XGE65t/Z/BIJlUyZAE10oDj15AuLj7pzYgi34LYb3ctVmzJgq53KYFK
	lJt9FqRXFk0VhpUJPZuwjkErC8jyb3FbRZix+h1mFmDxkDVDR/jSbxja8Sh2oDMaWWWjKR6k7uT
	5vbYtVqDburt8Tjajuu89tjn5pMvZYdXjEeaKEK6gOfFXw9r8epaiD/5QEgJ8VzT9d0B2pwC5bJ
	tO8MclBVPTuj4+OT7lvnLGpLqusHGuVsWQR8rrSVW6ivxMkv7xbQaZ1qt6t+DpWx7/oTEmYA14O
	LVCQSOcybmJY/tfC7KRsB4MHIn5zK7VN4M3Pr/JRj1TDw69dLtPRcjphCGFiVo5VGqri2buDk+F
	wXG6TI+K8z5MvlUqdnneaYgm6SEdU5odaT79zof7A1cVd8hGh8Z9V+ejzkCfw8C96VLheN/2cGi
	9Q62frOoe0RA==
X-Received: by 2002:a05:600c:8010:b0:493:bb2e:11a5 with SMTP id 5b1f17b1804b1-493d11d7e1emr680935e9.15.1783096667286;
        Fri, 03 Jul 2026 09:37:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8010:b0:493:bb2e:11a5 with SMTP id 5b1f17b1804b1-493d11d7e1emr680685e9.15.1783096666873;
        Fri, 03 Jul 2026 09:37:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d620sm66148315e9.1.2026.07.03.09.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 09:37:46 -0700 (PDT)
Message-ID: <e3f99de6-cf19-451f-8175-50fa30012f7f@redhat.com>
Date: Fri, 3 Jul 2026 18:37:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests/tc-testing: Add tests that force multiq and
 taprio to enqueue to child's gso_skb
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, hexlabsecurity@proton.me, pctammela@mojatatu.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us
References: <20260630153651.249752-1-victor@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630153651.249752-1-victor@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:victor@mojatatu.com,m:netdev@vger.kernel.org,m:hexlabsecurity@proton.me,m:pctammela@mojatatu.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE98704588

On 6/30/26 5:36 PM, Victor Nogueira wrote:
> Add test cases to reproduce scenarios fixed recently [1] where
> multiqueue and taprio forced their children into enqueueing an skb to
> gso_skb (during peek), but failed to dequeue from gso_skb because they
> called the child's dequeue callback directly. This causes a desync in the
> child's qlen/backlog and results in an eventual null-ptr-deref (with a
> qfq or dualpi2 child).
> 
> Test cases are the following:
> 
> - Force multiq to dequeue from its child's gso_skb with qfq leaf (fb6c)
> - Force multiq to dequeue from its child's gso_skb with dualpi2 leaf (1922)
> - Force taprio to dequeue from its child's gso_skb with qfq leaf (476f)
> - Force taprio to dequeue from its child's gso_skb with dualpi2 leaf (0235)
> 
> [1] https://lore.kernel.org/netdev/20260625-b4-disp-31bcb279-v1-0-85c40b83c529@proton.me/
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Since the fix has been propagated to net-next, this is net-next
material, right? no need to repost, just ack/nack, thanks!

/P


