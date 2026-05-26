Return-Path: <netdev+bounces-291931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMeRBgMRFmpPhQcAu9opvQ
	(envelope-from <netdev+bounces-291931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 853165DCC3D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 23:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DD53002B73
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B6B3C3428;
	Tue, 26 May 2026 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvSF5djS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYOR92o5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222283C1F40
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830957; cv=none; b=oMAxZc1cE0f8mw+Yu5FtNQyCRr9/IbOXFIrlzlfSV2HiNwKfqcOrvDO2ITf1yZJyfSs9wj8b0STe0HHvdz8n9pcvVsdNgoUptUl8yHLy6+cZtEcG1I9DSfiwN8LPKth7xksS+yRauAcXCcwCPnZpVEYR1S7BfOXbD5V6j9U6GdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830957; c=relaxed/simple;
	bh=pFMLcN4G+qQybN7/WwcDbRDl8SQ3nzHJFFuVnaBsiYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzwSFZbwnOTf7I0qlVvr77G6RwAeL5JPrFX5wMteGV07Ma0+JR9hnV3V5dgOGJuD4RqPojNwx+wiyR3gyoXYbXLA4UxWxuaCSuGimaN8PV1Wi+D2ZNJ6FAzZAMsdr/67Jk8E4QsnaxE3PBEFx2JejAhhQzmNrXCaCSK1ebPIS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JvSF5djS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYOR92o5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779830952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lsvLacXz8Po3XimOFLS6zC3jXFc1dZ2FM3YORkPmXIs=;
	b=JvSF5djSb/U3sNQu7CmRazSWlasPq1cA++OXfTPzSW9NKav9rXJs6c+5NJCUkukUhvozqN
	RP47kAkMhk0po/LZ/2z184Gg/5BzWwnuzGuW4GXTUQfYJLExuFTILVNCxHYI/kI7wmblsd
	32erXQ92uufj8MLXEY6leySp95ZnYjA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-05f746eHPKSbqJR3lD4vHA-1; Tue, 26 May 2026 17:29:11 -0400
X-MC-Unique: 05f746eHPKSbqJR3lD4vHA-1
X-Mimecast-MFC-AGG-ID: 05f746eHPKSbqJR3lD4vHA_1779830950
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45dbbbf8d57so12750030f8f.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779830950; x=1780435750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsvLacXz8Po3XimOFLS6zC3jXFc1dZ2FM3YORkPmXIs=;
        b=KYOR92o5fOsVXHORoK4d4lS6UZ/H2ijUyEFZ7udaTLyoRCoixe5OTOZLV3OtPl7GHR
         GhmwE/4WqaxLyd3zpQkREspmNqOlmfnXokARDD08rAUdf539GMxvAgTVydM6S3nM3V4b
         hWIQhZbEVdAQ3dzVRlxNjRFGBDWdWw8uMIqqXrGh87hN1h9vWB3GCjwJxCI4m2bCeMvQ
         3DQORBqtz2XxIPmxvEAUPW+gELW4m6RK7Mkvl92uz/dMYhMUAa5xo2Rz5w+ULwv4NCWD
         VyiUvyL0KuSWz0fZZsJQmByiczDQ78Yiy1YZkM/LlhLuie/3c+kWe2l5Kug8ppYpxX8N
         Zmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830950; x=1780435750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsvLacXz8Po3XimOFLS6zC3jXFc1dZ2FM3YORkPmXIs=;
        b=YXEbYltU8ZxhHeK9HoCIQbkI2TC1bJIUN2EFKXLO+EXvDkUymiVxfjybz6ypBFW27x
         WBwEKNVnAxC1Z7Cua6Exz3BNEED/o0UFzI+7EpD9oKr0QlslTxEwapBQBRPGhmdSy1Ti
         RA7yX9X+D+sd/e65jvw371wKPDTpejadZeZhg/tA6mXfAYSHOsVRtwD5x2JZCRvDTZv/
         EZa1zmdgxm70kI6mXQMcHhyd+zHpcl6TyJNHuklkBSNe5eocKE/22BAmSX0PTXXoTDYW
         o2LQpWWU3a8iDB4bLmD0sO/jbgt272f6DCqCq7gyjOaB5Cumk8YjoL9J6NvUp4rjhQCB
         EzmA==
X-Gm-Message-State: AOJu0Yya2De/IZZ3JXM6XNVpxlzUlsY4LbKYJyUhohG9cUHnP+ICsm+r
	G3r1hj5YB3uOKjAdUvrQtUGhN6c8h9Z9/II/jRoK7yLgoKQMRLGlYAYMcUTucrln51nKz7qF6jy
	X5RXvZiTj7dUjIysrg+Tg1igusC1j54nRF/CWirJ8Bbr+BMGQA51c3iMdZciOl8/38LyV
X-Gm-Gg: Acq92OGQXUV41KqU9L8ggnZ9VSam5XtShVieqkfntBO2a+lzgpao97iy/ua3+HotIqO
	U+fDXjqwEPehhigUrpq98hVmT08NDadYAeGAO8nCoaGgC2BTnmh1Fm5wnbcfvLbartFhQ6k8dtU
	9bOlqiAOAPqTvpN6ZzaJB+KliHvipqU7fdun6xlVs90Dnbf07PCcm64C87duLGAd+907b+kfI+V
	drSwKEyeFJignpc+GRnp/VfT0un4stIwZqeFCrXVEh8LL+AGwwU6a4IgQXVtb3CNjt5fn85jEES
	tjhyKRJ1keJp3hYI3ahCRPIA2jHfSRwYxH6UE+gmROxmFbcYVg6Hq546xD7cJz54nBLAtIB6GrG
	Qnvwc9PRzihaPoHqQi70U
X-Received: by 2002:a05:6000:25e3:b0:45e:655d:6f7 with SMTP id ffacd0b85a97d-45eb38b38d1mr33262188f8f.24.1779830950117;
        Tue, 26 May 2026 14:29:10 -0700 (PDT)
X-Received: by 2002:a05:6000:25e3:b0:45e:655d:6f7 with SMTP id ffacd0b85a97d-45eb38b38d1mr33262147f8f.24.1779830949557;
        Tue, 26 May 2026 14:29:09 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5c27e7sm1077738f8f.35.2026.05.26.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 14:29:08 -0700 (PDT)
Date: Tue, 26 May 2026 23:29:07 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jiri@resnulli.us, victor@mojatatu.com, david.laight.linux@gmail.com,
	yimingqian591@gmail.com, keenanat2000@gmail.com,
	2045gemini@gmail.com, rollkingzzc@gmail.com, toke@redhat.com,
	security@kernel.org, linux-kernel@vger.kernel.org,
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v2 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <ahYQoxbskZuaZxxs@dcaratti.users.ipa.redhat.com>
References: <20260526155913.1060694-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526155913.1060694-1-jhs@mojatatu.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-291931-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mojatatu.com:email,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dcaratti.users.ipa.redhat.com:mid]
X-Rspamd-Queue-Id: 853165DCC3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 11:59:13AM -0400, Jamal Hadi Salim wrote:
> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> 
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
> 
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.
> 
> Additionally, linearize skbs with shared frags upfront to prevent
> silent data corruption when pedit operates on zero-copy pages
> (e.g. from sendfile).
> 
> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writable")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> ---
> Changes v1->v2:
>  1. Do better boundary analysis to cover cloned skbs with frags. Pointed
>     out by sashiko-nipa:
>     https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519033950.2037-1-rajat.gupta%40oss.qualcomm.com
>  2. As a result of fix #1 remove the skb_has_shared_frag() check, unnecessary.
>     Also Jakub has plans where the shared frags is not going to be a "thing"
>  3. Make small adjustments everywhere for integer checks, suggested by D. Laight
>  4. Remove all reviewers and testers since this is a large enough change.
>     Please retest and re-review.
>  5. Remove Rajat as reporter since he is the author (which implies he is a reporter)

re-ran mp_join + pedit_l4port + pedit_ip kselftests on patch v2, no issues found.

Reviewed-and-tested-by: Davide Caratti <dcaratti@redhat.com>

Thanks!
-- 
davide


