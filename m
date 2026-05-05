Return-Path: <netdev+bounces-284388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMvXLd/r+WkLFQMAu9opvQ
	(envelope-from <netdev+bounces-284388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159C4CE2D5
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4193303E8EC
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47855423A9C;
	Tue,  5 May 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqSi3hac";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9yhBCQg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0633D4121
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986511; cv=none; b=U2RvxyRwnpRWF1DlfgTDudYFlQanOvl4nxCKY2IUdi6v/52XbHenp2vU+FAonFeFVgkSn+D1cERqKvHUfN1n2QaH7sFKesWteVv3T0p11iJgibhouVSucTwdz5Ba38tzgFcGVF2Tnf54IrNWc6lRNqL2jY1Le1/mQjTMkegRDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986511; c=relaxed/simple;
	bh=eSb8yGZPRxqXbm84EUfrcvZrQoLzOvoQWMVhnjIb9HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ghpp1aUH3ANUqEoMuP7Ypbj9VeC4oWdrx/Q+dLr1GEszbHEavy5ZqRfCQ1whmUyEi4ctSLZbBVCM/EtALkFMetcCN8gvVyZHhvvNb6V2qdASaSiJjRzQHU7scJ4StmyCzZBwXet3jNwMTjFPTzS0J/WnSIjKfwhyRUuvX+EBs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqSi3hac; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9yhBCQg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777986509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xy0lm0SExowsvHUUMVFumx654ZghKHJklDIPqd81HIg=;
	b=eqSi3hacWrycOUz5g39FhtqNgoF0QW1ufOJTyPs+7gvBp7TL8ov2JNeXzQeWmVZO6LDQe2
	2wDdQqqVAzbyBgo5aPiAL6bfCejH92C4bkBVw32rOVYpPZDJeOHVISS4eJXBr+ZEU2jMjE
	WHM/0zYvviQvXK66WD+cUPA8amSgsw4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-1E2abCi5Ma6FcwTnLjZeJg-1; Tue, 05 May 2026 09:08:26 -0400
X-MC-Unique: 1E2abCi5Ma6FcwTnLjZeJg-1
X-Mimecast-MFC-AGG-ID: 1E2abCi5Ma6FcwTnLjZeJg_1777986506
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso42957395e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777986505; x=1778591305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xy0lm0SExowsvHUUMVFumx654ZghKHJklDIPqd81HIg=;
        b=E9yhBCQgaCb7+bHowU+EVgkBxCifKStCkmlU7jsziygYqd+d5OvItehtdjcs/Lycj/
         gcYRwG5eDj+sNvWLXcqx33b8BbTne9sgto428dDPupjvbw0cBi358SoTjUL7rJvd5C9k
         cfIGzCK4eQKFJpLy1nduBtLb4Cu8owVFO3oHTLIlOgEovd7gQuU+iwJsx6jdk20mNVOX
         WxEnDipytok5QPVsO997O9fcriJWtDpmHvVl393s4LxkCWOZ4gA4Y5uoHUuMKU0KPkrB
         Mrrw5V4J57Q8xQZyq12s7QNQcnT2KSlf2Z/IOxyEGCdPAfp1iYwzbXDHmkuqi4sAiwGS
         MTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986505; x=1778591305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xy0lm0SExowsvHUUMVFumx654ZghKHJklDIPqd81HIg=;
        b=de7Id6x+hXG2sLmzsvldoo7/nWcW6PrvgYGXtHBfNlx2uh/cl4j9TnzjXSWjvT5lt4
         DerwIDqWI3ncBW5XtRZcdKsYhDXyzVxY8uqTmK6cWZU1F2MCz4baa3XMu9lcovcFCXPA
         BpnsoTZlAVylClvHhAsVrNFvhee/rgEzb3+udMBG1pn5/ibY3XcfhfZQumBZhW8Ei3aF
         e3qyVKVvw+K6w6zkrbrJB07ZbEoU5KU7uJhcIeRNNDecl+DT2Pujcs5sEvEVtCrnCbnW
         KzAXsXAhdx59BGtrWHjT0fNaFj8LdfmelqqLygLknZj/nb41mw0edIkJ5euoAq6f5qjt
         bnRg==
X-Forwarded-Encrypted: i=1; AFNElJ9zt6WGD0t+Itl9j7/hb2VyQSW7CfWGwjJQGdWSvI0Y+PxRGgVuR0KNarObHNfqOA8QLEo0cvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+aSys5awP3Xb54HQ/wa4mEP7HN2iOyl74yBb1tqY/Fj1fEjg
	IoCWu14HdTuW+wl3LgG+oSrhuY0tnDwKaF8NrPH7BhhRC8+Tlh+8UEVEXSwp2oInxvdl6BIe39l
	4E8S1cVMPOe9KvrsMVIIVEnPAsxR4XdyOHzYZt53up1WW1ZmWLU8adbS+eg==
X-Gm-Gg: AeBDieuo3KPLOWz8hytaMoqbZUDMP58zWgux5jMK1An6HxIiPoSFos8TSF2wX+NaVoq
	oDglMb/+uwH3xkU02qv2KXZMlW/IJH2z/eL1RuQZVMnWaRMtLFbO96dKxvLHiZIATb4hIrasZOk
	H2QSmtkbdZ580bcq1D5IfFQz5PTZvkCdLtUg2uqr9lWT0RnMnsaeAHehFHY4JnlOzC2ggtXwtb1
	pwdhh01cpoc0dx86IM/QA/DKNc8YSGIy8xa0rtok5oUmevTuHSFK83bQY1OZ34rykMJwqeheb4W
	uxWUqsGFJ5ijiG79xdDjBYCwOkbraD5DWOX+Q/BGTHYqQW4jnj2F9TpRd5rl/9sq8znsd9HTyRQ
	OE1PYHaosUsSBa/mJbIXfN7KzVyeDWVqA5/p8g/Nm3jr91woSrAJHQemsQaAEK9/chaU=
X-Received: by 2002:a05:600c:8907:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48d18cfe207mr37180995e9.29.1777986505577;
        Tue, 05 May 2026 06:08:25 -0700 (PDT)
X-Received: by 2002:a05:600c:8907:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-48d18cfe207mr37180445e9.29.1777986505150;
        Tue, 05 May 2026 06:08:25 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d184ed3b0sm17051105e9.34.2026.05.05.06.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:08:24 -0700 (PDT)
Message-ID: <df7045cb-44ef-48a1-9210-73e23ada7c61@redhat.com>
Date: Tue, 5 May 2026 15:08:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: broadcom: Save PHY counters during
 suspend
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 linux@armlinux.org.uk, hkallweit1@gmail.com, andrew@lunn.ch,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com
References: <20260430211117.2348478-1-justin.chen@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430211117.2348478-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5159C4CE2D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284388-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]

On 4/30/26 11:11 PM, Justin Chen wrote:
> The PHY counters can be lost if the PHY is reset during suspend. We
> need to save the values into the shadow counters or the accounting
> will be incorrect over multiple suspend and resume cycles.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

The patch LGTM, but why are you targeting net-next? This looks a fix for
net. Please share a relevant fixes tag, or explain why you prefer otherwise.

Thanks,

Paolo


