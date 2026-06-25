Return-Path: <netdev+bounces-301881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mXXEKhjXPGqEtAgAu9opvQ
	(envelope-from <netdev+bounces-301881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:22:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B5A6C34F3
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KFS84mNO;
	dkim=pass header.d=redhat.com header.s=google header.b="H4UpW//G";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301881-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301881-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E2CE300AD8B
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AD53C09EE;
	Thu, 25 Jun 2026 07:21:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8812F8EB5
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:21:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782372110; cv=none; b=RbqY6FSykeQavoePs41tuLCkaSUSS9U4llWRHZaHflmv6Hhx8UAtbCxsdRhVlHaEVCdIVbQw4yOYjr/sn0JOKpTcX1OldY+XXz2fp6lEbYv0HgY0f1Yy2VOqj76EyphcLleOSVxRGoXlod7aS0U+Aw+JdWO0VmKSgPEU4RGK9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782372110; c=relaxed/simple;
	bh=GK5OCCGpaPCkWmQItyOrt7IoPN7Vm7IoHjk4uyDscH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVfHZo2hNHt9DnD6LT/ox1nHBrPJVvzpsdZEbwDNJDu7LUwvyOwB03LI/nc79x/A5rTd6+CodLajl1mYcDiB5rbcTIknRhT2XKnbdWCDO7FNE1lmGHXe0PvCbVdMnAt9TYJVOViw9Fhbq07KkaoR6WG55xK9JNtt1T9zS4OObSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFS84mNO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4UpW//G; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782372107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GK5OCCGpaPCkWmQItyOrt7IoPN7Vm7IoHjk4uyDscH8=;
	b=KFS84mNOISC0r2MRv3mhxEvRpS/3SdXnoDIpl03dzs75FCbFZEosFnlpbjkpQ4FDBPeTID
	H7v283S8bvOu+OwzkYn2p65vVwds5D3nZf/LIOmyIWimA8sSO8TZ8YuYIpx5x/HKwoDLNs
	MLGIFUabQsvUilI1P3/PBr+CUcntZbA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-A-m11TRYOUSybVWGVmoh1w-1; Thu, 25 Jun 2026 03:21:45 -0400
X-MC-Unique: A-m11TRYOUSybVWGVmoh1w-1
X-Mimecast-MFC-AGG-ID: A-m11TRYOUSybVWGVmoh1w_1782372104
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c0cf538efe1so131382466b.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 00:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782372103; x=1782976903; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GK5OCCGpaPCkWmQItyOrt7IoPN7Vm7IoHjk4uyDscH8=;
        b=H4UpW//GlrrbeY+Zyx8CWhUcYRMV8+9RFC0o3iw2iqEBuMsZyciwYQlZnUmx+PWOgS
         o3yjZRND/t5NnFy5hMLx1gQ0gl23rTeadD7PLWRQG3kA8tPiluAYOKvq/LL9V3DR6JL6
         IzMSzHAVhXPHoK203fUBUUowrQWY9UMy7/qHHxbRLUiLfi/wFp5UeoJO7hNQLgRp868D
         PJMZTqFyp+M0vx/woayIuekiIFYWOnpb9aJrrh1YsoPmRmvMTAG1wIMwr3eQIAYzD3qC
         BYR5GKZSSH5/xxjmxPD+RUUt/Yo8xgxr3iMUnAdw1mXfk4Zda9MrmILTc201yq4uMjtE
         wxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782372103; x=1782976903;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GK5OCCGpaPCkWmQItyOrt7IoPN7Vm7IoHjk4uyDscH8=;
        b=QUQR3LWYgxp5EbdnJV1++IZBx7PqxbxypKFwGjhRCPC0pbFM0DjyAktcqEnQMt0D3G
         8omf6aSOG171DRraak7PdmG8RtDQacVrqtqkpjssJADnStS+3T0SUAQdSyaNrZW8EoQU
         oeJgacGnt7KP38G9K8AEOtmAd0qPPTamL/uTPzECA5IhqHc2NzSHC8ac+hb8ZfuvmX0y
         PK8R/TYa82cFqb7w82ESArt1/w9LmZaHO8vHiZfadHlw/8veHXP+WdvvPN1zLdRtXhqt
         +CpPGl+Wyi7V6zeRjMgfsDcPYDqS0UB+3eg5OwjGSNABr7JhfP9Dtv+rZN8LUZDl/KIC
         TRgg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+UecAcam094wyo/Np0Ic/VR6wXhYveKDIIkU9DD/sYipjW9CltDoBaPv/N/UWGGvkUTn2xq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHfwT/2GNoL53IZ2vKkpUVJYQpkYmNP/L8cK8R6/3mJohcM4R
	Bh/AAP+PUOr5D9fg0jRdUSJ6YEM8sb/kv52KYF5fVId8mA94W0/CQFQfOlv+Rj+DhA0niGdOju5
	jxP7YdRgA08Z/11DEmh+cdwbXOJkN+7mqPpSZFb9fFxBBHdIosbKd52k4+A==
X-Gm-Gg: AfdE7clp6K5BVkc6yyXNYn5RYBrvPM7JerO+JZOb2vdMN/mhI4Rxa0TKvSKT0BESDGc
	dl1nbQ5xNiKDkOLLXxmb5L/msmvjCTD0Y4WdGFZPsOzv4HFYyWFlKricwdYcJCJf2a9Ge+rIobe
	sYuqPIIjyu+hs28xC7jdGfcgUjmxd/6HodSnaa+fO9FFs1nxHhE39JKJjLA6hO7iYc7K+w4cel+
	j07oqdPe2oBuc8yFAjRjEuSb9Fkh1aCYKw9YB8n0IukT1s7pdFVupBrGPjz82ihxEmGIWDVnTLQ
	LJNMTlZMZfYwee2rM2rGkJXVWgIEa9vMW/1N6rLTfU62Aoh1JaB5NLqlfXkBolLKdKa2QBZceUs
	lxLA+GmYb6KMyupGU7AuV0ykN6pSRgGlTjf0rFAzVChxeielWViuk1Fn1AZMz
X-Received: by 2002:a17:907:97cc:b0:bee:9809:3ccd with SMTP id a640c23a62f3a-c1205d98c17mr70145866b.4.1782372103581;
        Thu, 25 Jun 2026 00:21:43 -0700 (PDT)
X-Received: by 2002:a17:907:97cc:b0:bee:9809:3ccd with SMTP id a640c23a62f3a-c1205d98c17mr70142866b.4.1782372103024;
        Thu, 25 Jun 2026 00:21:43 -0700 (PDT)
Received: from [10.44.49.141] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm117182866b.39.2026.06.25.00.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2026 00:21:42 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: aconole@redhat.com, i.maximets@ovn.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] openvswitch: conntrack: annotate ct limit hlist
 traversal
Date: Thu, 25 Jun 2026 09:21:39 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <8D2F8228-CA85-4522-8B39-07C1DB463AEE@redhat.com>
In-Reply-To: <20260624150149.3510541-1-runyu.xiao@seu.edu.cn>
References: <20260624150149.3510541-1-runyu.xiao@seu.edu.cn>
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:aconole@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301881-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7B5A6C34F3



On 24 Jun 2026, at 17:01, Runyu Xiao wrote:

> ct_limit_set() is documented as being called with ovs_mutex held. It
> walks the ct limit hlist with hlist_for_each_entry_rcu(), but the
> iterator does not currently pass the OVS lockdep condition used
> elsewhere for RCU-protected OVS objects.
>
> Pass lockdep_ovsl_is_held() to the iterator. This matches the function's
> existing caller contract and lets CONFIG_PROVE_RCU_LIST distinguish the
> ovs_mutex-protected update path from the RCU read-side ct_limit_get()
> path.
>
> This was found by our static analysis tool and then manually reviewed
> against the current tree. In the reviewed CONFIG_PROVE_RCU_LIST triage
> run, the writer-side ct limit update produced the expected "RCU-list
> traversed in non-reader section!!" warning while ovs_mutex was held,
> with the stack matching ct_limit_set() and ovs_ct_limit_set_zone_limit().
> The change is limited to documenting the existing protection contract.
>
> This is a lockdep annotation cleanup. It does not change the conntrack
> limit list update or release behavior.
>
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---

Hi Runyu,

I think net-next is still closed, so you might need to resend it once
it opens. But the patch itself looks good to me.

Reviewed-by: Eelco Chaudron <echaudro@redhat.com>


