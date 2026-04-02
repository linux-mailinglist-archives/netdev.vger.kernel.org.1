Return-Path: <netdev+bounces-274446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEnmBK08zmmAmAYAu9opvQ
	(envelope-from <netdev+bounces-274446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C4E38740B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6882B31349DA
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78995393DD8;
	Thu,  2 Apr 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHYvGgSu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNcQt6wA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC154239099
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122299; cv=none; b=sfJJEImsH+bq5Rlp3pug2sl5HLymHE21rEoLvgRZ2pElDWbnb8ba2qqLMFFRTD+C+uoCQDKE3PGkhK8eOd3s2WW3Xz1OH0artPTJ7ifcOnJAV39Wf676UPsj1DUClVlNivLssL0E7dt3UZOfhNqObABDgayVf/bMJTLycW7J+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122299; c=relaxed/simple;
	bh=neS2Z+/yHraVEs8e+4+AgtnHHUKt4sXLDGijfKzQ53A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0+kVbZPtpWe8tjUbvWelz2HE8zoq064E8D99nDDiotuCf20tzB9o9kdsLQMEBQ60w6t1gNdqyDZ95iC6drwvDokIuwAwRPNbOmXHWJIuJqRXNZSDIZBCfRldqT9vc5XAPhvEFIVJOOzlq8oKjUqb4VsIXvApMRQBgb7nZx1j7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHYvGgSu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNcQt6wA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775122291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tlx0wdrAh4331cqKAYtCa47jMzL+erQG3RUcfSvcpAM=;
	b=PHYvGgSuqTMPtah/5cpBok1We+Pcub06GLkG2enla76JXLD9Vuu3XRW2SvcgEPUS43kfaT
	911xZxc6vneojHFLNTNr2CMqHY8ZUdsTtw9lVfvhibhY1ZAItNQAEemoWkSmnLbBedbjt6
	K/Yw5LKh5PzWKPAxhEXedfQud+FH9f8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-ge2nWmqVN4K72k2zNvorUQ-1; Thu, 02 Apr 2026 05:31:29 -0400
X-MC-Unique: ge2nWmqVN4K72k2zNvorUQ-1
X-Mimecast-MFC-AGG-ID: ge2nWmqVN4K72k2zNvorUQ_1775122289
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d0de4bfb7so942495f8f.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775122288; x=1775727088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tlx0wdrAh4331cqKAYtCa47jMzL+erQG3RUcfSvcpAM=;
        b=GNcQt6wACj3pLzxCRLEo+TCE0q1GGgqNHi0wXAZ9bq3jKCPhVzdeL3HborqtUrw3uT
         fZMLRKn3AAdKd/TqIo3fMySxVuHb6ELKQrHd1b8q7tvP3qmmtaG511jWSlheRxXQHHll
         gb0eOufEIdeXNmRrtOtMXcA7wWAjXOoRAwKsooyWgEu0HrhdWnaWRY68fhI9PZ/0WJcz
         87F4rzwiLVL04N3sKGhlp2c54krcItweo1RXGZYl+gKsFGyF6XZjVjhaP5BmY9gslkXB
         dfoKX3e+hmcq13MGEYLZ+RvhYPMhDvMDf4xasx4MUCuvHBaChVVWpaOxsQDT3WEA4F34
         Uovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122288; x=1775727088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tlx0wdrAh4331cqKAYtCa47jMzL+erQG3RUcfSvcpAM=;
        b=pVZMY+wGm41ZMWonDkZc5L0rNEo0oUFLxijnlXsf0bfCeZUVSNA3p6tONToOlMUHvo
         JAlLm3I8RwiNII1YqaA1JhV9Y9T0imXHiJruycu1XC3h4qGdp7l80HDYtlePJw3ElQcl
         iMW5mk4E9P34sCLUNkYs8ZBR449VXyproPJkXR/HVMrP+TnUVIEHEK6sJL2Kkvas0rj0
         +32xPfOb1LcPknXpXoWuS3xWh7BX+YJ4TsMX3TpnhNLC8is8hMHOmsOZ8CLS6CusjqbS
         mTSISBM3S2ISTqiUtIodru+WOcZu1QApqxPsfRLV5N3X4A3vGC6LuHjrzi4Il8i5pr6j
         v3/g==
X-Forwarded-Encrypted: i=1; AJvYcCVzqPn3Zw2RCkcI2Ju6NWiXPyJCaliur0mf/xx+x1OTyezYMcL0mYYU74llJ7bHkxRWGrImg+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiA/aQrhr4aFHArmjzpxGdfjtEyg2N1fI0eH2ilHxnl76j32D
	JBOSHeoxvVBXkbODn6bVZmCpf0QNC4+X4sIRdyC6lThtIDRqLUbREspQnsGcGrf9XfXornluC4j
	VZw4ei/RHY7W6IUcoFr0V9zZ/MD2wgeVnrxHxfPo1srI+9xXp6d+UNxTxGg==
X-Gm-Gg: AeBDietrNq2w3nLWsZKJ8kcUF6tghtyIyMGWqpon0Ig756ISd4KZNeVNkzMN7XsPhBz
	h7tO2EyyFYMkagLas8d/jMpx0nJTcw/mkMVS9kL3P0uJUbLrxN5Sfe/YLiKeH2SPV61nleznvEV
	AoJw3WM8rsUBb0jFssoO80GJM+IyGqB0yTR/RfksrOCag5xFy2F3N+ZFYQD7PeTmr4w2yD2Pj4B
	LW4OQAS5ZodORvpIEPLwJHLnVOyWzeW9qu9dq3zl34Obm84Hwd0ZvOAT5jdDYGqMv+uO6wlE321
	9yfVdWBKECD7Od/vQQfW3J/k4liGn8pz01sccljB0qIcuqAfN2MeiLfpVG/lPOw3ex7YXYTWFKo
	HD9ONTOhohE80SMrwSZnMeMiHys0J/aGRrqFbrOwokaiMeAUobjbhwX23AQ==
X-Received: by 2002:a05:6000:290b:b0:439:dfae:8083 with SMTP id ffacd0b85a97d-43d150f6ec7mr13613906f8f.38.1775122288483;
        Thu, 02 Apr 2026 02:31:28 -0700 (PDT)
X-Received: by 2002:a05:6000:290b:b0:439:dfae:8083 with SMTP id ffacd0b85a97d-43d150f6ec7mr13613841f8f.38.1775122287974;
        Thu, 02 Apr 2026 02:31:27 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm6765274f8f.21.2026.04.02.02.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:31:27 -0700 (PDT)
Message-ID: <88deb91b-ef1b-403c-8eeb-0f971f27e34f@redhat.com>
Date: Thu, 2 Apr 2026 11:31:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] net: add xmit recursion limit to tunnel xmit
 functions
To: Jakub Kicinski <kuba@kernel.org>, Chris Arges <carges@cloudflare.com>
Cc: Weiming Shi <bestswngs@gmail.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, kernel-team@cloudflare.com, jgriege@cloudflare.com
References: <acwp_cVAflwTQCBh@20HS2G4> <20260401173843.7a2bb607@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260401173843.7a2bb607@kernel.org>
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
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274446-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16C4E38740B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 2:38 AM, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 15:09:33 -0500 Chris Arges wrote:
>> Commit 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
>> introduces a regression in our systems using legitimate multi-level tunnel
>> encapsulation stacks. Our testing was with stable 6.12.y and 6.18.y where this
>> patch was backported.
>>
>> One of the usecases we have are packets being sent to a GRE device, then
>> MPLS/LWT route, then IPIP device, then SIT/FOU device. What we observed is that
>> packets are getting dropped at the last device and we get the message "Dead
>> loop on virtual device" sent from the iptunnel_xmit function.
> 
> Last device meaning limit of 5 would have worked for you?
> I don't think there was any hard math behind the 4 so ++
> on the limit may be simplest, but I defer to Paolo..

AFAICS the '4' limit was an empirical choice, and the reported splat
used 7 devices, so moving to 5 should fit, even if I must admit it feels
a bit a whack a mole situation. On the flip side a revert of the blamed
commit feels not safe.

@Chris, could you please share a patch increasing the limit to 5?

Thanks,

Paolo


