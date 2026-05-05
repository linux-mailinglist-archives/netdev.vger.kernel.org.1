Return-Path: <netdev+bounces-284417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHlNCDDz+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:40:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751734CEA9A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E91E430607D7
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB133C50D;
	Tue,  5 May 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXfZzjQ1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YospqjKt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FF346E74
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987939; cv=none; b=GyeRiQyilputWx6oZaJKKAbsLzd8gKZ0CgnIX84igMJeca5cQcNkg995GUDu8pCSmqxWH/RxWUX1kI8deBwcfwkTOU8KhZTjSyO/52Vqtbr6CjM0B7HCDnO4oz1CqeGVOJukevsONvfMOza1KynbWxG0N+Oo+hLEN09YcI3y7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987939; c=relaxed/simple;
	bh=0s89vfwi9u2GmyoZr12XQ/VmH/dxXgL1PDXgs/5ffAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDU4rO4PDS6r4C3bEP2x706Q54wftiCRm9yuri0aWIRplQTBLAIG5wayY+/hfE+AbDPpHCpkCCIGcqKtuq+G+DtU/BX/teV5fIjh/gppV3VZ0ke50fL8zQqaGKt5TN0ccbFgfYZ68VX5JZyohNYovOQPTFF2QiOyUVh4macFfuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXfZzjQ1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YospqjKt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777987937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKwv69+ZbjlA9yYfwrMMQoESYnCKOjctNrQItlrYybQ=;
	b=KXfZzjQ1Pg8SyvU1RTjNJwIQWDQzV0/Zu4sN7+Ehe3xIHpLCp7jDUR5F4od4JJTgfbh2/3
	KNO1QNno1cZryfMQ4jMRyzesVSR7hn1b75XLtHauQWixtcVNjvCxa8JHLabVEfEHjofbez
	nHqtkwhub4m8zPTwZTVbPLAc4qOjHfo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-C2bEU8gIN6OD_1xPWuVUaA-1; Tue, 05 May 2026 09:32:13 -0400
X-MC-Unique: C2bEU8gIN6OD_1xPWuVUaA-1
X-Mimecast-MFC-AGG-ID: C2bEU8gIN6OD_1xPWuVUaA_1777987933
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a9592f666so23477045e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777987932; x=1778592732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKwv69+ZbjlA9yYfwrMMQoESYnCKOjctNrQItlrYybQ=;
        b=YospqjKtBoSuN8XM6UboXywz5TnUJtC+tg8PyBxGViW2pAKrMAqoHiLuLfJ0tyM2E4
         6bASS1/1k99IJAsKdMfoUqIUKfjHMAR/XjAA+UBW5VFY3T2nAW54RIvq5q4gJnDfYA7r
         oTHANx8lEpdSoMeDWOtA+DxLIdwViCluMiRpZr3aQsgdXN4ls4SOADsC2OyWyyoFRgPY
         aQijhu0EYhGpStfL6qo3H7MkFzF2pCkmcaFFBpPuaeDWnfy4RiSJM5nnLbOeZkTMPFSR
         LKc8vzsSu5YQN9U/4FW70bFp4wfaJCOEf0qalgapJiAe/CPvFgPLQj8oQKzGgFyuB+dG
         dpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987932; x=1778592732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKwv69+ZbjlA9yYfwrMMQoESYnCKOjctNrQItlrYybQ=;
        b=Klx3oKvW8FA1EXH2dPkP9M3+kYAz40J+/6uWBB6fCbbwfQhEKzX20pK/mSKjlty1Im
         5qwzeOd1GlAVYS/i80HYRFvOJMssokji3CULSyWiWcIFiqlp1jwLqNMHmJCTfnX0pFd2
         Gxi5+vTsZdy8K3g5mvUx7wl8RaD4bSwla09oz5rDKJ74W1XqtStMCF/Ln0FUSBPE/3g1
         rEmZ+j1uCU2ZMglBXIUlYKz+VzKmDjZ2o1+tvh+jI8p+j04G9DSkOPsqkQY7AXBn6rxa
         VZPrjCELT+DgWU831O84Pf8StfnbHmcFlPaVmsCpxD8Wcyh+GsVw3loSFRqxDhacYA3p
         3czw==
X-Forwarded-Encrypted: i=1; AFNElJ86ksm9Kt5CgrtuDFjz2owrcZKdVQLLbgiTCum8kxJ+8Gru/61MAH9TyxSujY3mNQjlYra5hHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NJvtJ/YZkesV5GngSLAjR7l9x1BVGK3kuIBh3NFwx78vj0/s
	IFmAGGQprsZsELuEFHSeyDsWGOEya7jbvg5MlEo1W4VcEuxRus0JMQzFEYxotxBFOCzsW3ErKwf
	WVmUL2hFxvp8O/IBohUEFp2ztlfG3dlMmGgZQKyrIND/0JRLINlWbowtM1Q==
X-Gm-Gg: AeBDiev4WreNWEL+YjX6NADj6UnU/GyHQLVIUKVeTuglq6HPA+PGV2voAW8TFTAp/qL
	bKC+ItdhW0ilpvGwDAAi/VFimhctVFShB5SMeM0q7MLhNkj25GKa2yKS854dn91kwWDA2VHMTcu
	cgojFhokUMtHs71hcOvy3M5zSWZ3+9Uh2xlzFTHqz2XoeKVOmjd8D/5hBAgvdwzk5w2zaBz6sJ6
	mTBoVLB1AR6/KkzqLXUeslezub07Qp5i4EQePOk3hp65HUE8oKvjaJ1zbXC+vlm7NXLr6N9/lII
	LrHRcEGrtFegZtwfcjZA6j99sKz1ZtikfeTedpfb0SUo7yN4mLtEhq5Q3ydsS5y/gHrCDEz74xu
	KKClJ7PTSFxCIoMT0ljguraH4ZfoHE07QFhiAuqXpdmREL/GOvSk4h5cpOCOYJUAk14E=
X-Received: by 2002:a05:600c:4e04:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48a98638cebmr245847125e9.10.1777987932493;
        Tue, 05 May 2026 06:32:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4e04:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48a98638cebmr245846325e9.10.1777987931898;
        Tue, 05 May 2026 06:32:11 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm628732505e9.9.2026.05.05.06.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 06:32:11 -0700 (PDT)
Message-ID: <673288e7-37ac-4533-a4d3-2fa87dc282f1@redhat.com>
Date: Tue, 5 May 2026 15:32:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/rds: handle zerocopy send cleanup before the
 message is queued
To: Allison Henderson <achender@kernel.org>, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org, santosh.shilimkar@oracle.com, sowmini.varadhan@oracle.com,
 willemb@google.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, lx24@stu.ynu.edu.cn,
 tonanli66@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org
References: <cover.1777550074.git.tonanli66@gmail.com>
 <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
 <87f79bc7483aa1a7b3a44718b62a5cd5bd016f8c.camel@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <87f79bc7483aa1a7b3a44718b62a5cd5bd016f8c.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 751734CEA9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[ynu.edu.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,oracle.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284417-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.661];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]

On 5/1/26 9:40 PM, Allison Henderson wrote:
> On Fri, 2026-05-01 at 09:08 +0800, Ren Wei wrote:
>> From: Nan Li <tonanli66@gmail.com>
>>
>> A zerocopy send can fail after user pages have been pinned but before
>> the message is attached to the sending socket.
>>
>> The purge path currently infers zerocopy state from rm->m_rs, so an
>> unqueued message can be cleaned up as if it owned normal payload pages.
>> However, zerocopy ownership is really determined by the presence of
>> op_mmp_znotifier, regardless of whether the message has reached the
>> socket queue.
>>
>> Capture op_mmp_znotifier up front in rds_message_purge() and use it as
>> the cleanup discriminator. If the message is already associated with a
>> socket, keep the existing completion path. Otherwise, drop the pinned
>> page accounting directly and release the notifier before putting the
>> payload pages.
>>
>> This keeps early send failure cleanup consistent with the zerocopy
>> lifetime rules without changing the normal queued completion path.
>>
>> Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
>> Cc: stable@kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Yifan Wu <yifanwucs@gmail.com>
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Xin Liu <bird@lzu.edu.cn>
>> Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
>> Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
>> Signed-off-by: Nan Li <tonanli66@gmail.com>
>> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> 
> This fix looks fine to me.  Thanks Ren Wei!
> Reviewed-by: Allison Henderson <achender@kernel.org>

Note that sashiko spotted more pre-existing problems in this area,
please have a look:

https://sashiko.dev/#/patchset/d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66%40gmail.com

/P


