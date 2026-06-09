Return-Path: <netdev+bounces-297022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iADCAFD5J2ob6gIAu9opvQ
	(envelope-from <netdev+bounces-297022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:30:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D765F807
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 13:30:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Ka8dkaBg;
	dkim=pass header.d=redhat.com header.s=google header.b=o2zJnl8O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297022-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297022-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 419E2307E3F3
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51FE3B19D9;
	Tue,  9 Jun 2026 11:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68137A485
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 11:18:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003914; cv=none; b=CcMLFx1IqpLcXWsSTh3ds47kTMNY5+izONJoj47IHpyyX62VujN9o6+5mi7NI8owf34wNZ7w+EleO12XkP4BQhpA/YHMtkQYhtYOE6GAZb/0rNpI2gUO9gIEW/IqgggUheZBBdx30tqMNd3x7cotWVbuAQs/eFsrY4/fzjsr5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003914; c=relaxed/simple;
	bh=35AGFm1UCN7LWvbWypSmoba5so4PsJxaREEzADK1J3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZu5rI5D487RR7LU52mfRyN3mhe+gsuuDqGgISVfEvBb2ojrqjgwEGRp8HtQeon5p+sTSn51dHVb6Rs5wg4B6O44haYGMjOGeJ0XhE+9CzM/26TNX7fTsPCHOytDLhY8vbsIIDaRzA+oT/5oA0LcugpKRsOUdmEefb7fFAwQzXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ka8dkaBg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o2zJnl8O; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781003912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35AGFm1UCN7LWvbWypSmoba5so4PsJxaREEzADK1J3Q=;
	b=Ka8dkaBgteuAQcUxhBjbpqLxj3jK5dn8KhOU75WF+E9aAk5zhtmg3w7wf1APE+C3iMo3Ys
	E05oLwgS+mMkaQbn6jh3DJbRvM5Yl721Msk3ZCpM2kwUX321K1HjLimwbKD4eSQApcgMGK
	BM3x4oGFawUgDrUf2XlIOoXg+tVWWWY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-vMeAGxOwNDWHCrspyL8YuQ-1; Tue, 09 Jun 2026 07:18:31 -0400
X-MC-Unique: vMeAGxOwNDWHCrspyL8YuQ-1
X-Mimecast-MFC-AGG-ID: vMeAGxOwNDWHCrspyL8YuQ_1781003910
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bf381078ac8so10951566b.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781003910; x=1781608710; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=35AGFm1UCN7LWvbWypSmoba5so4PsJxaREEzADK1J3Q=;
        b=o2zJnl8Oimhc9e2hjfLlyTXNauT1o6qv8PIm9SnRXW1yq6tiG3NhHekPmK1nlNxIZX
         TohMhEVM7bOUg4NiRf4v8eP+4DQk1e7hJehKzDUyrn6qeuC499FPMRTNmqLeiPUmqS06
         GoWlFV3TzDG+OTfwURIlcUN2FiXdU0agIta3tQR4VIlZkYik4vLKiJINDJeD7FKgIuIh
         ftGYN5OoPWlmAsW1N+a0r+1TUqOSJ416q18CxdwZkpH7LX/ENsLe2mR3/Q8d4jwWYbAa
         a+Wx+oK84Sekd5KRvBt4V70u8cqtHkBxYrCuWkNOAzlSePjlTN/XH89d9aTjbOanXyon
         NDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003910; x=1781608710;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35AGFm1UCN7LWvbWypSmoba5so4PsJxaREEzADK1J3Q=;
        b=pZGCZlWa2OuUdmzS7M+NuYfH8vBptyP2jR6ZGtjU8ROvuVWXRxgSuQdUB8oQiPtPKX
         bk45JZVjWk6aFltL9/wZACl8i3AVFIRRMAUw+PpUZfGvhJw+CadCQKn3T0GzoUVAAv9u
         pVv1sroPKwZyix8NzDWzcY/eyDnM1DG013RhzzHkReuStbH31B+GqICwVxk63wbWSyXM
         UVlZL9QKDBIA6m52vf4Caum5UcM0ZW8bBaR9je9mXiCP5EVFWKqbmqjLYdRP3IkcFuj1
         Bx2ltDIe9r5HJz2ZKuqMjd+Ux+bnucrd3TtA32qwZPdART/kzBFiojY4OGSyNnyQSBC+
         wgaA==
X-Forwarded-Encrypted: i=1; AFNElJ+qa2PzXVoY64V1L671nvmO9+cwaEhygRVOLi+woYbY3V1Oix7u1SXb+/BPFRUoexLx97xWfGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFd46RGf8oEYLxR1cCX5YMlrMkbj7wpQeWeIMVuYgZSSiGr/i
	S3ZEGmAMrt2VaPzvimR/paqGhgQcWscj3aYPSmEuwdl9vIBpjjjomvcDINMYsnhSlej7ej7F8Hf
	gQCFNeB3dfUeWCXvoC96YtPIF+khxGLQQAEsSjy7YqaXh997AjTi+PW/eew==
X-Gm-Gg: Acq92OEcQ1mInry+HKTSwWY2aLCxBkyTCJOsv+Z8clKUr81d1K4YcJYp4c6AeUl7blO
	2r6ANZ2idivndzs3DkfGc/NZzwUc60PS/WJNhp3/nzl3pzy9GhwHV3pO9FNnGSW3Nr1aPoZVcoT
	76LsLPs+63G0gH+tnONy+pEBxFkVeEC0vbg4VE48lhIPHotal7TJRltbpe2Wu5GDIlj511ShdZx
	VgMUUeY5V1MWOCV33AYua4ODzAFmw1flV542uwS5RD4WhAdgx0JXLpQIdzlC89ZCCNnS6J1tne4
	I8ex5MJ8FORJpshoe8jjv1Z2jxZLpjOqZIhRDSM1o6GFVaJhLj4UxUDG0SwwVm2DAtJA6GkCsRh
	GRvKcyo3hvmcDKHauwrXMccjP57UqItsvpmJplws1AwipECKnGAqDhRG/o3PkgMw1kG1wEsvBQC
	34+wwb
X-Received: by 2002:a17:907:96a2:b0:bee:9d02:6e6f with SMTP id a640c23a62f3a-bf37135dc59mr932737166b.9.1781003910066;
        Tue, 09 Jun 2026 04:18:30 -0700 (PDT)
X-Received: by 2002:a17:907:96a2:b0:bee:9d02:6e6f with SMTP id a640c23a62f3a-bf37135dc59mr932733666b.9.1781003909377;
        Tue, 09 Jun 2026 04:18:29 -0700 (PDT)
Received: from [172.16.2.95] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0553fd86csm1033289466b.46.2026.06.09.04.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:18:28 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Minxi Hou <houminxi@gmail.com>, netdev@vger.kernel.org,
 aconole@redhat.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, i.maximets@ovn.org, kuba@kernel.org, shuah@kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4] selftests/net/openvswitch: guard command
 substitutions against empty output
Date: Tue, 09 Jun 2026 13:18:27 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <E25A2A83-F499-4F3D-87C8-9E604AA1DD02@redhat.com>
In-Reply-To: <f4643f4f-8db9-4621-bc53-34992820ce19@redhat.com>
References: <20260604163016.3929371-1-houminxi@gmail.com>
 <f4643f4f-8db9-4621-bc53-34992820ce19@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-297022-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:i.maximets@ovn.org,m:kuba@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,ovn.org,openvswitch.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 017D765F807



On 9 Jun 2026, at 12:58, Paolo Abeni wrote:

> On 6/4/26 6:30 PM, Minxi Hou wrote:
>> When ip-link output is unavailable, when the upcall daemon log has not
>> been written yet, or when pahole does not know the OVS drop subsystem
>> ID, the affected command substitutions silently produce empty strings.
>> The caller then passes empty sha= or pid= arguments to ovs_add_flow,
>> or matches against wrong drop reason codes, all without a diagnostic.
>>
>> Add [ -z ] guards immediately after each assignment. For test_arp_ping,
>> also align the MAC extraction to use awk '/link\/ether/' as in
>> test_pop_vlan. The drop_reason guard returns ksft_skip because an
>> absent subsystem ID is an environment issue, not a test failure.
>>
>> Signed-off-by: Minxi Hou <houminxi@gmail.com>
>
> Whoops, I unintentionally replied to an old revision; same point, I
> think this is net-next material.
>
> @ovs crew: WDYT?

+1 on net-next.


