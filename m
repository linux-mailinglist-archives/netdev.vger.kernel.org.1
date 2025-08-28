Return-Path: <netdev+bounces-217685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440DB398D7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0ECC1C24B07
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E852EDD59;
	Thu, 28 Aug 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulc1opzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200302ED159
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374779; cv=none; b=DcAuKDSC8isH1A+rvVutjWf+tPPJgSZdOLYq/Q88XuP2RMZsEih1Hvy0hnm3J1l4bQAxI3/T6nnvOODafIqVyMULSEHJJOKGm2Buc5uxsdYA/Uyc9TMD/viCk3TBYupqFJXW3k6poMotnWMIEfhRm9Sb5fbek4joEZCr6mQVIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374779; c=relaxed/simple;
	bh=e3uvFNMj8thW/jyNdz19qyU4r6RCtepK7W4bh7/hqCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/aU7y3zyT+IybuKwaWs3nVGTgmLTLDUiEVJlh3AF/gtzxlRX486nK8eiAseEkmd5Xf5Qvoipa0qelJoU+DRKJVOfgauzeCRuzj3HmyluO9r1fUdu9sJEYcidR9qOLTdrvKSPWJsGb06f7h20MyxMNOKaq8ucr5sAIFa3wOxkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ulc1opzH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32597b88f0dso699114a91.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756374777; x=1756979577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d4hJznQap30ATxMczeU/BzQVuO1TgIiqR0Ob0+SNztQ=;
        b=Ulc1opzHc1kBZ75mvL02UooLlAnuxZ2zSGUfF95bJtEmOWTj5BTHFDD7oiWq7E+d+K
         +u33aYxox/2lWxn8k1xGKkKyad7fn9HgHwhSt2yDMU7A7MiCH9YzgwJxVdiBnQeDtOPg
         q/AOrY8qeHCFO+CN4hgOcyyoNqZZNSGWNQyTmhndwc7ZSvOJKnXL2sPVMN0TFBw/pc8i
         q8yEHSbmkoGAZ/8oIDj/QKLlF+bzjU+G0+Ub9CxieGN0fJ0jVa9G93/qRFsvoR1XluDQ
         XpSU6xdcvBsIEMCD30ooKfGSBMMXDbgnzvSujgwMsq/fC9QvAla5WXxmvegtBzbtu6cy
         FOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374777; x=1756979577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4hJznQap30ATxMczeU/BzQVuO1TgIiqR0Ob0+SNztQ=;
        b=DUpmJCcP2e+yZg/VnqWi63FN8JZ7KEDDs5Cs2iGESo959GQU1xrpiIeeWpPej6GAv7
         +f0bjjb3ZjcElbo0Bpj9EY4DVMRpczdrQ8pSwjwn2RixL6MlweV/Q/gqR1rkDhLt83Xr
         6ahCoAL1Rrdf8POc6latdajwp0whnR0rIConLkfxbqsKKEOIj14OF0Cs7X0ifI5KGeU7
         4RK4DMrUcu783ZUViJCVTSvzI0yNuqD4CC2qXV1AtxevQkahtcUZGZ5qxCJjwR6wR7rO
         XwW08D6TCryx7KdJktI7Uh4fHPI7414h0UDin8V/KZw82qSQXaaebGh12KhFz9DSrv4j
         zTGQ==
X-Gm-Message-State: AOJu0Yxlt1B1QCn+iQlbuMR6z3iKOD6i2IH/IH28zvJh/EFEwSVwH34G
	azocT00RoM1CQms9uBdikG3kHCwOUZRF0+AwRkBLNnq2XViG6q8QU7OF
X-Gm-Gg: ASbGncsBxEbE4hp5TORb18y9mvzx5fHSd6Z7MxR1shKm+VtTWKmnvO2v0QYfwrC1Dey
	gKiYmiJXb9YsVV40ga34AnI39L2geQHb3n/Q6G5EOAalwKgcsu9JBW4LdMSsBg6L9AOWvlpxNhV
	3VbnKm0gVXLenUujD67GUzlvxnu1RSweOHPFmtXgv5e4C5c/J6xm7d9XaH45DqcYxoO0MBX9e+w
	fWXI9NDYPU7KBVhdM1nTx5rQ6vLc1FUzviyGyy9FTPbFP4f0jDycyjF6cdrkUrLkp4Lrwg/Zvov
	D/06hFl21n8nZzPjRNN2aV70V6tQ+gwyYqCq+TTF0NnNt6ut5qIvxyd53AKHGPEkZe26/ZG4scT
	2Frq1YtBTpgWZIcyd52BbB93fyqY=
X-Google-Smtp-Source: AGHT+IEjeFFb28UfVBKfHAlddzJzq2SpeXPquDDyB5hAloSkhIPzb8TQaiRB5Zv42aOdwz7SFV0WHA==
X-Received: by 2002:a17:90b:48c5:b0:325:c120:931c with SMTP id 98e67ed59e1d1-325c1209375mr16104546a91.8.1756374777166;
        Thu, 28 Aug 2025 02:52:57 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e39cb4b8sm10706021b3a.92.2025.08.28.02.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:52:56 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:52:48 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCHv2 net] hsr: use proper locking when iterating over ports
Message-ID: <aLAm8Fka8E19JOay@fedora>
References: <20250827093323.432414-1-liuhangbin@gmail.com>
 <147f016f-bf5e-4cb6-80a7-192db0ff62c4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147f016f-bf5e-4cb6-80a7-192db0ff62c4@redhat.com>

On Thu, Aug 28, 2025 at 11:19:11AM +0200, Paolo Abeni wrote:
> On 8/27/25 11:33 AM, Hangbin Liu wrote:
> > @@ -672,9 +672,13 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
> >  	struct hsr_priv *hsr = netdev_priv(ndev);
> >  	struct hsr_port *port;
> >  
> > +	rcu_read_lock();
> >  	hsr_for_each_port(hsr, port)
> > -		if (port->type == pt)
> > +		if (port->type == pt) {
> > +			rcu_read_unlock();
> >  			return port->dev;
> 
> This is not good enough. At this point accessing `port` could still
> cause UaF;
> 
> The only callers, in icssg_prueth_hsr_{add,del}_mcast(), can be either
> under the RTNL lock or not. A safer option would be acquiring a
> reference on dev before releasing the rcu lock and let the caller drop
> such reference

OK, thanks for the suggestion.

> 
> > +		}
> > +	rcu_read_unlock();
> >  	return NULL;
> >  }
> >  EXPORT_SYMBOL(hsr_get_port_ndev);
> > diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> > index 192893c3f2ec..eec6e20a8494 100644
> > --- a/net/hsr/hsr_main.c
> > +++ b/net/hsr/hsr_main.c
> > @@ -22,9 +22,13 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
> >  {
> >  	struct hsr_port *port;
> >  
> > +	rcu_read_lock();
> >  	hsr_for_each_port(hsr, port)
> > -		if (port->type != HSR_PT_MASTER)
> > +		if (port->type != HSR_PT_MASTER) {
> > +			rcu_read_unlock();
> >  			return false;
> > +		}
> > +	rcu_read_unlock();
> >  	return true;
> >  }
> 
> AFAICS the only caller of this helper is under the RTNL lock

Thanks, sometimes I not very sure if the caller is under RTNL lock or not.
Is there a good way to check this?

> 
> > @@ -134,9 +138,13 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
> >  {
> >  	struct hsr_port *port;
> >  
> > +	rcu_read_lock();
> >  	hsr_for_each_port(hsr, port)
> > -		if (port->type == pt)
> > +		if (port->type == pt) {
> > +			rcu_read_unlock();
> >  			return port;
> 
> The above is not enough.
> 
> AFAICS some/most caller are already either under the RTNL lock or the
> rcu lock.
> 
> I think it would be better rename the hsr_for_each_port_rtnl() helper to
> hsr_for_each_port_rcu(), retaining the current semantic, use it here,
> and fix the caller as needed.

Do you mean to modify like

 #define hsr_for_each_port(hsr, port) \
        list_for_each_entry_rcu((port), &(hsr)->ports, port_list)

+#define hsr_for_each_port_rcu(hsr, port) \
+       list_for_each_entry_rcu((port), &(hsr)->ports, port_list, lockdep_rtnl_is_held())


I'm not sure if the naming is clear. e.g. rcu_dereference_rtnl() also use rtnl
suffix to check if rtnl is held.

> 
> It will be useful to somehow split the patch in a series, as it's
> already quite big and will increase even more.

OK.

Thanks
Hangbin
> 
> /P
> 

