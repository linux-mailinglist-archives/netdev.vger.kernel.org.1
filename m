Return-Path: <netdev+bounces-271325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OrpJUETw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:42:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A2B31D670
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 744BF300EF9A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E831F99C;
	Tue, 24 Mar 2026 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ1o/kAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094C259CB9
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392004; cv=none; b=l2PSAr4JVsJ6kx95wOwe4kCahVEnBomI46vhqF3onnEqPgbgvlGS762U/hcPLtfGIuLKNc+MrDcm63LvijCB8KG1Dgps72mgVqErBPyNr04ckLJu6619AGztAdYNHmnPtNXT1p6VLdxz6vJ/2f2fZqJOCLjmAbIt8nO/PI+yzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392004; c=relaxed/simple;
	bh=Yi5gVHi+Z84JI9fESXiU+g2NpbI1EYS5oqNBjW82Tgo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CkYNqe+pfWep53M/A/wfOaC80YgEKMR5xDyphs3bTeQFCN4CDfDC7RL0CaR8Lc+F2ykNtRnCYVO6ve2MHkG9UsUmW49td5R+UqhoJeP+whTX1C1rOQsiyTIUDQmZkerdo5ekv41IpONMIbSRyjKo8/lziYqwWvZOxqc34lqXnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ1o/kAp; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79853c0f5b9so39234427b3.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392002; x=1774996802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYrAOD+SgPzipFpe84eFrSCQ8vWIlqJOUvxoi3E01Gs=;
        b=NQ1o/kApzh+DNi0fzaakCIdVtMHksttyrhpDgBACKVHj2g4axYalJEj1uoMI7AASIb
         rrePXKvb+/PEiFg2Ar0ulCasSuwL2NmynUbz/oWoue1rlc5NDEzu9s3GcPB8HlYX255x
         MCqwwK+4/mhXN/QdO+fyKd+Ql9DUfrLMCjofF/PYDBd75hR3vHsXzM3i1SdlofD/IqAy
         9MP82u6sLQ/bBy3gKsSUTMiOaqMLvgyWfbv3FuhbAz+ApA7pOOAWdFhAYs4VX7GI+c5C
         g4Q0mDqHVnDpQFnzkzYHiAWVzDYEn5118gIJ+npwJ5GS2W8JkaGEjf9sPiMByOE35RWb
         MZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392002; x=1774996802;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYrAOD+SgPzipFpe84eFrSCQ8vWIlqJOUvxoi3E01Gs=;
        b=lMYZyHP6oMbjAM9i2829Me9Rhrh6XVoRToAMEabo0Tk6fYBDzAQ9nRVAPIxpRnzhbL
         eaJTxIP/2fFE2Gh3B0d6oXAgcdyyod78DQwSIqVyyxpfi3sQPGIGEbwEQvXt22MtOqYm
         fU1e8JOEOSjTRE7Wxz39XxWq1rx1EK0RYS7AE3EIV/QxyBCycCBSLd2wJA+hb4zFmWaU
         KHCHhHBKTDDM4z7pmWINqJ2HvTu7E9/TgzL5QvjoVzsg5pVy5x5uDzmH+zUii7tGNeuF
         2pKMBMrvI8QFajZDMVpZdKdMfM0W4SKctTsPs/vEda/ycN3MEss2eFoEGoL3JQG276ye
         al8w==
X-Gm-Message-State: AOJu0YyWbne6pJiZ19Mh9v5qsV0H4fy/NCBVRQjaThKFaWcOqjHjyuSK
	07/jtHLSx49xEGWlWJWUnYV4Ph1Ug86B6fwIm5ozebukuHCntAxgPsYx
X-Gm-Gg: ATEYQzzGvsr+6Bad0ajRja+8zFryPsvoLzMap1mXkOIVZRWf/bxbIqG3QbhLzBhx6c3
	kc0n3msFE3f69/uIk4AJP+Ypb/KCJjWBzvGCFMyD5j+vMtTjX0Z5SiTkWjArUJWEUcuAIZM7h53
	Dce1dMRTklQf0qK3tes1sBHLyjTVGCiATrOyoRykl9Phdyttk/voZpbymcYhePOeP3gjQPAX1JC
	errm2gAyyqq1hUHd9EIvHCetzUKWcDXOLYRasOgL3o2hIrmzp/H+z/F5/EfpQAGUSQ6lJ+QMDjp
	Q2Bgrg4WR+/w/pST2t1pplZp6SGBEBWlgR8CSaU6UzhgF+fQfZVo7+wQjgP2TKX1taU+BtwbT8u
	ce8ROhSxaGZDIGtOHyYQVigjkQorVwLPnJZPq9U5nvqrlnKRxYNw7sfbpYcq8vmDVQoU36NhaqX
	g8lAOAR/7EzjC+JL1lmKV9BGrd5uY+XEhVTrjeFvuZzrHXsS/X5ctfDcfQF8MQAjz5H5SkANciK
	yAv
X-Received: by 2002:a05:690c:c4fa:b0:79a:36ea:2c2a with SMTP id 00721157ae682-79acf6ed3d3mr14879607b3.59.1774392001917;
        Tue, 24 Mar 2026 15:40:01 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a903f5a20sm78981247b3.14.2026.03.24.15.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:40:01 -0700 (PDT)
Date: Tue, 24 Mar 2026 18:40:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 Yiming Qian <yimingqian591@gmail.com>, 
 daniel.zahka@gmail.com, 
 willemdebruijn.kernel@gmail.com
Message-ID: <willemdebruijn.kernel.39ac32125c0cc@gmail.com>
In-Reply-To: <20260324205107.318303-1-kuba@kernel.org>
References: <20260324205107.318303-1-kuba@kernel.org>
Subject: Re: [PATCH net] net: psp: check for device unregister when creating
 assoc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-271325-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1A2B31D670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> psp_assoc_device_get_locked() obtains a psp_dev reference via
> psp_dev_get_for_sock() (which uses psp_dev_tryget() under RCU);
> it then acquires psd->lock and drops the reference. Before
> the lock is taken, psp_dev_unregister() can run to completion:
> take psd->lock, clear out state, unlock, drop the registration
> reference.
> 
> The expectation is that the lock prevents device unregistration,
> but much like with netdevs special care has to be taken when
> "upgrading" a reference to a locked device. Add the missing
> check if device is still alive. psp_dev_is_registered() exists
> already but had no callers, which makes me wonder if I either
> forgot to add this or lost the check during refactoring...
> 
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Fixes: 6b46ca260e22 ("net: psp: add socket security association code")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> CC: daniel.zahka@gmail.com
> CC: willemdebruijn.kernel@gmail.com
> ---
>  net/psp/psp_nl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> index 6afd7707ec12..c7c377a7790d 100644
> --- a/net/psp/psp_nl.c
> +++ b/net/psp/psp_nl.c
> @@ -320,6 +320,11 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
>  	id = info->attrs[PSP_A_ASSOC_DEV_ID];
>  	if (psd) {
>  		mutex_lock(&psd->lock);
> +		if (!psp_dev_is_registered(psd)) {
> +			mutex_unlock(&psd->lock);
> +			err = -ENODEV;
> +			goto err_psd_put;
> +		}

This ensures that psd is valid for this caller of psp_dev_get_for_sock
and psp_dev_tryget, which is its only one (for now).

But is it confusing that psd can be cleared out while a reference is
held? Is the assumption that psp_dev_unregister usually holds the last
reference and its psp_dev_put will complete the clean up by calling
psp_dev_free. If so, would it make sense to defer everything
to psp_dev_free?

This is a simpler changes and fixes the issue for the only caller, so
LGTM. Just curious.

>  		if (id && psd->id != nla_get_u32(id)) {
>  			mutex_unlock(&psd->lock);
>  			NL_SET_ERR_MSG_ATTR(info->extack, id,
> -- 
> 2.53.0
> 



