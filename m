Return-Path: <netdev+bounces-285026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON3WNoGo+2myewMAu9opvQ
	(envelope-from <netdev+bounces-285026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:45:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BA84E0504
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B1A0303EC39
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 20:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3126F3B0ADB;
	Wed,  6 May 2026 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDec6DiK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64F3AF660
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100212; cv=none; b=Vy8Xgj+rqzlEw2yHo4wj56SiVNDFmaqiXC+fFp1pBrcZppJFYjfRe4Qch76EcvT7GMyrtxIncjmDPZfFk4bS8ZctcMoJqyYXEncUThHdUD6NaVMSatTca6ZVnKrC+5CasAAWJBxe1IlnmegMX2K/WiVNwiTv9gcPmeRc8ihSb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100212; c=relaxed/simple;
	bh=dnfjyN0iESFBQhGX4yyWG5e0UnilO+QqljvnttYEcEU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EICXsRAidf8rH71SxjBiFAkjw1wY2DolQnLiHOiGaWktjMl40hsvugJeqY/iSJh2A8ggoFToZcZUUxaLnf+WBY5oL/3xuGI+XIoKm1b1VgTGR+vlgDF9okTmEhOl+943JmZMEqqmitIEwaEX8wZz2JFfnaxLNogefh1VlUpPIjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDec6DiK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bd5c582c6cso834167b3.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778100210; x=1778705010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeIGDwIloR6wW2XDZbQPZr37CB08xADpVWPsXdCwNpI=;
        b=YDec6DiKP26RzvwJgS0Nt0EGmCDf71MO3wuimoEr9obil3Z8+U0jnrNS18p4XbvQQ6
         B+J0MqAOFGRNupfpxVCBZExLJDOl/2u6tkqFliNLoYF6M32Ce9ubpDQW2yPqxIPmWocu
         KfIDLz2YoTE90q+BYxLxhvXXDPHS3pnHRzJ3thVbNc/yrhx8n9lZT0mcNY/bThH25swl
         GX0J7cfngdEXBh0Y2LKJSqv1EB/m7nfZx9ukQ32ieqLOkVjv4F8OXVUlk9p3Xj55jTmy
         sW+qLE2oXRjTjB8tUdr01odkKPB8cTGFrzF7rP1o0jZL/pWeTgKA3L16CAQ5SimNY7Gb
         yKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100210; x=1778705010;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeIGDwIloR6wW2XDZbQPZr37CB08xADpVWPsXdCwNpI=;
        b=lFoEhIEnZwhYSSic4l+aaAl4jYv41h0+mTZ4M4GXbaqwp07eR2vxyTnuRYvIAhul9o
         N9rVGXRX2Ptnr1jU7zgcNyo5q28t8OF0JeTidBlqh3nou6BFi8ujrnEyrS1czDhBFOLp
         Hn6NQxxWzuW6ShQhZHDlqmexHZjrRYg20gJ3pU/R2w2nzHbwk+xGGxRxy25bWlNT1vg2
         ErW/KEYKqb6eSeeWMNXlKs1p7T7xjZV9w1K7br0vITvQIVkAaWKaxndLtgqYeUDtbRi1
         Y6VWyE4DQqG2CU2RAwQ7eMx62ZI7OVExvsTigrw13u9+2O6SHjO2oNC25PQVzEUcVYYc
         YEXg==
X-Gm-Message-State: AOJu0Yw4YB/kj9ec923g3HyBVuMIIoc55kQXiMrKHyJqTLMHQOqtnyyX
	U24WkbuGYl+QK/vfHSDPjUQr/I1YqH+xJ28L2dWk97lfERK1ZHDibIs1
X-Gm-Gg: AeBDieudkXI93E8FvLCPnobtpMNCVij71Cx0PVxsAaFrPCo09IxdNf+pl97C4nXyQGM
	a+RsEPhFvPy2sXxkNHrOswM5HuMEs4qfa/Dm6qrpd8cVQzn7ITvIc+SU9uDxS8KJdrpYJ9v5nwt
	HKSKxUKopMDM04vihMCxtrnPEWeEW53q5hd8SOMdFIhhdzAaG+sRhUC0msDU0nMOyDsfaoKgUAs
	xUP0xOhJfIP0z37/XeuhYOX7lzwPyGFb0UiMA7zMcGyrv23/LeytJaqQmNrjk3jvkrA5iFqAz26
	dgRQHQUXtpB5GfscQfpryy64UwQzoPul6EnjluwZqgz08J4t8hJ071lS0hgrxWt+ivFx1e2/nvN
	Xgq2IzCz0ZWTlROKXF61B2RDpthYmdzvOO1rk3lvIDFHJjRYmDa+sEDe5xgsbtmZqBFUQl5ceY1
	ZL+r3ZEegHbt3LHC7rHGU33/YqChTx43WSc/h2JbcSMNwk2htxk5r37lVTKshyHOyOKwAd9CmQY
	TtQ0O3jkntZX7w=
X-Received: by 2002:a05:690c:c371:b0:7bd:93b0:bd25 with SMTP id 00721157ae682-7bdf5d6bde6mr58985457b3.4.1778100209510;
        Wed, 06 May 2026 13:43:29 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d0cbsm82291157b3.35.2026.05.06.13.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:43:28 -0700 (PDT)
Date: Wed, 06 May 2026 16:43:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.9e3ba70c52d3@gmail.com>
In-Reply-To: <9e691c63-ef7d-4e35-8cc4-77f83a16c970@gmail.com>
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
 <20260505-psd-rcu-v1-3-a8f69ec1ab96@gmail.com>
 <willemdebruijn.kernel.173236793ca@gmail.com>
 <9e691c63-ef7d-4e35-8cc4-77f83a16c970@gmail.com>
Subject: Re: [PATCH net 3/3] netdevsim: psp: rcu protect psp_dev reference
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 41BA84E0504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285026-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Daniel Zahka wrote:
> 
> On 5/6/26 3:34 PM, Willem de Bruijn wrote:
> > Daniel Zahka wrote
> >>   static ssize_t
> >> @@ -228,16 +237,23 @@ nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
> >>   		     loff_t *ppos)
> >>   {
> >>   	struct netdevsim *ns = file->private_data;
> >> -	int err;
> >> +	struct psp_dev *psd;
> >> +	ssize_t ret;
> >>   
> >>   	mutex_lock(&ns->psp.rereg_lock);
> >> -	__nsim_psp_uninit(ns);
> >> +	__nsim_psp_uninit(ns, false);
> >> +
> >> +	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
> >> +	if (IS_ERR(psd)) {
> >> +		ret = PTR_ERR(psd);
> >> +		goto out;
> >> +	}
> > Do you want to create the new device first and only delete the old
> > state if that succeeds? To avoid a netdevsim in state without dev.
> >
> >>   
> >> -	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
> >> -				     &nsim_psp_caps, ns);
> >> -	err = PTR_ERR_OR_ZERO(ns->psp.dev);
> >> +	rcu_assign_pointer(ns->psp.dev, psd);
> >> +	ret = count;
> >> +out:
> >>   	mutex_unlock(&ns->psp.rereg_lock);
> >> -	return err ?: count;
> >> +	return ret;
> >>   }
> >>   
> 
> Unfortunately, the way we have psp_dev_unregister() written, it would 
> clear out the main_netdev->psp_dev field from the second 
> psp_dev_create() call. I don't believe there is use case to do this in a 
> real driver, so I'm not sure we need to change how the create/unregister 
> paths work.

Thanks for that context.

Reviewed-by: Willem de Bruijn <willemb@google.com>



