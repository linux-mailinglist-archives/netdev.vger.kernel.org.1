Return-Path: <netdev+bounces-255901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JeBF4a+gGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:11:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB649CDF27
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7813020D66
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C0D37474E;
	Mon,  2 Feb 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvz43z7Q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7U/y5XG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E25369979
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044910; cv=none; b=nKquX8JxJUahydHtk6QGFsgRx3bJdmizPOBuPasgzq28AmIaoSCNSPOADmvxd0GTOZJHHT0z5du2mJlhJNPxLbtUga3ap+z+8JqtbcDOAod1orDvc9o+IlCjwIeoKGkmI28ffCbn5MeK0GXe1NCI2I4SvWBKBSYaLkJYx+JuTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044910; c=relaxed/simple;
	bh=SVolWuOHyIqcRg+uvjd7iiXovrXqdcc+sa09t+IEIJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/GxQyL6uoiroFYWAG6Bp1g+ifi/7jNYoZ2AH9iPZ7Qrh77qsuIY4KaN2kSRDvB5k49HFc5WZZo9jnYvXqAmeecs4/4S5Y0v3pSS7QB2OeoUSJJiIJnNwDW95xdPQwHuwX/+66dYCOfnsvvEuoVpUllIpDlHQmNgJEJMit1rsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvz43z7Q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7U/y5XG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770044907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jFNC5c+FwcbzYbXzyxYOv7WT8Hr3pWREwm90Rx8QYs=;
	b=hvz43z7QFxJJzY4I97QlD4iN/AzotjaZheJkHvgTJIno1YJ72cJqgMGy/cPShTNBbGXibV
	p4Rk0QJ6bQhpqSuAepcUcZoaN0mkP9h5SNeyexjT+LA8IqfyMKj7E3x1FnOaNNlgeC/K4u
	U6kIU4T7ZvpeeRqKYUR39NN3+tH4NPg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-PRlY9iRTPAiSFHUxURFNYw-1; Mon, 02 Feb 2026 10:08:26 -0500
X-MC-Unique: PRlY9iRTPAiSFHUxURFNYw-1
X-Mimecast-MFC-AGG-ID: PRlY9iRTPAiSFHUxURFNYw_1770044906
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-480711d09f1so65244955e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 07:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770044905; x=1770649705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jFNC5c+FwcbzYbXzyxYOv7WT8Hr3pWREwm90Rx8QYs=;
        b=L7U/y5XGAjZH5Ht8uY9Mos+RXWNdSkkSv/WjSc45bROS0lAvt/t8C2ZsTNsYk9lSzu
         zZutAZTmT7+3zt6Cfr6qWgQPulYECoK0OktHi2VtGAUCDRrKyW7OSeewpFmJetIInAzH
         Af9wqZ2wdpq0HDCJwCNG05py3NnxHLrgutNrJUcBL7BQyv4iJdHv7AU64pCRLMDPXkWJ
         4BHuDv/l14I6h1UGbbRyv1aoPr8FRZUw+xgIGFqOxzZ4wQNI87/kXJFazuhnlRyfLOty
         IbejPMw+V07ndGrJborc1P/RwRa4Re77f+BMmDZnznNMzh8af+Ie1xWKmIMIRgRa62LO
         Blcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044905; x=1770649705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jFNC5c+FwcbzYbXzyxYOv7WT8Hr3pWREwm90Rx8QYs=;
        b=Vf+KBF7ZE0lF8E14hyOdtxL7vN9L4dkRr1cHm75/H6UFg9Vixk/cH5Y1HH8F/2jSka
         Ojo8YYaA01z3B4u/0hp4Sk+NrWGn0rBb3KU5OFKhUGKqe1rEqv0515TdlZlxT5MEfqmK
         PwByjRAqeibUg02xaias1byBzsLkCjN1LT+Ig1/uPEHuqHVQMDHLmcKHjMdumzyPQqUN
         OttqHFl05+Z98oCm7yxYuSqduh6LLaRgAqr7Dtvv11vvfmK/83jSIL25FBJU7KhNEeff
         oXZ5t5KNVKv7vgZ2ATbAsxDsurihDxF1ghyqiyswsblAFOZ0aqV6fejZ1E22u/Ejbts9
         v8aA==
X-Forwarded-Encrypted: i=1; AJvYcCUrQYvG1qpuyzK7Vr1UozItWdkwQIFSzVxJ8x+Z4/lJK9T5Lt279lP0K+QnNFZtsPuaSa7whE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2GMjkAqQxvRiOlerVv/g4xA7TWvWGWgu16uMuHVp0thrTwt6
	PDEktaJS6aCjxEH/2bN59V9OfMCN75uWKvyLwuxVNuUsfSENdGzd9SfWXZa+7Bvbyt1Bg2dX4mH
	R+Mawmn7iHdkBmkXuwYoY8coZdbfe4E0wH4E3rKZBy+LzZGIRTdjrw4sizeaGuwQLRA==
X-Gm-Gg: AZuq6aIJm7I0PZsDQ2eqFBPfPa+zreQ6bPKL4tKorfkxnt9tejMfy+oJn8qa0+Dhb0l
	X7ZV41zCytMcwtui1JrdMIlquEy/AxYQA93Ll0oGwr/4UzvpwNlKFgK6gnYXQgwy1k0K+VD1xzw
	Tsa7qNCAMjDKiIGcc6lyZb5lTP8vetvwD85otsW+ShHuYGa3SG0ThiCk4Bh2RgAkrNqH/pbOkre
	Us+NhrF7VopxPTwylvYCUTK1r9GgWKHyNt07TFRorIVx37SIDMLo9LVyq+gsckvTH/vLkh5uxpD
	dWueg0MVrZPgdRDqfVjMjUjGIonheNbw35xn1JsqFRCfwkbsXkhk2QUpPbPfzl4YqOy26Zsq4Mp
	FRmTl9jkM
X-Received: by 2002:a05:600c:628b:b0:47e:de9c:92ec with SMTP id 5b1f17b1804b1-482db46074amr147715095e9.14.1770044905052;
        Mon, 02 Feb 2026 07:08:25 -0800 (PST)
X-Received: by 2002:a05:600c:628b:b0:47e:de9c:92ec with SMTP id 5b1f17b1804b1-482db46074amr147714545e9.14.1770044904521;
        Mon, 02 Feb 2026 07:08:24 -0800 (PST)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd21f5dsm112595095e9.8.2026.02.02.07.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:08:23 -0800 (PST)
Date: Mon, 2 Feb 2026 16:08:23 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: don't use dynamic lockdep keys with
 clsact/ingress/noqueue
Message-ID: <aYC952E_49Se6MOA@dcaratti.users.ipa.redhat.com>
References: <68f55cee98e5402af2509f1d3873fbc7a27f67e9.1769699825.git.dcaratti@redhat.com>
 <20260130192921.1fbf5e21@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130192921.1fbf5e21@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255901-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB649CDF27
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 07:29:21PM -0800, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 16:24:35 +0100 Davide Caratti wrote:
> > +static inline void qdisc_lock_init(struct Qdisc *sch, const struct Qdisc_ops *ops)
> 
> wrap at 80 please

hi Jakub, thanks for reading. Sure, will fix in v2.
 
> > +{
> > +	bool skip_dynamic_key = (ops->static_flags & TCQ_F_INGRESS) ||
> > +				(ops == &noqueue_qdisc_ops);
> > +
> > +	if (!skip_dynamic_key)
> > +		lockdep_register_key(&sch->root_lock_key);
> > +
> > +	spin_lock_init(&sch->q.lock);
> > +	if (!skip_dynamic_key)
> > +		lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
> 
> is there a reason for the order of things here? 

I was self-convinced that CONFIG_DEBUG_SPINLOCK and similar would
complain with the ordering below, but I'm now seeing empirically
that it doesn't.

> The code flow would be far more natural with:
> 
> {
> 	spin_lock_init(&sch->q.lock);
> 
> 	/* Skip dynamic keys for qdiscs which can't nest */
> 	if (ops->static_flags & TCQ_F_INGRESS ||
>             ops == &noqueue_qdisc_ops)
> 		return;
> 
> 	lockdep_register_key(&sch->root_lock_key);
> 	lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
> }

will do some additional tests and re-send this way if it doesn't
complain.

-- 
davide


