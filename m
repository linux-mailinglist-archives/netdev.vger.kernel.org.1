Return-Path: <netdev+bounces-92078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69968B54C1
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E0C282542
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB4E2942C;
	Mon, 29 Apr 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3q+NFEs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31D2837E
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385434; cv=none; b=lq4FpoIr+ioohJmzqmWKrFbuCOkYfovkkLhFX/kFy6bzS+qJshwYWmdSqpgTUPRRqZIEAhRm191iIngWZJ1wRI4UwKfs6BmRzdFNLaMI4MMeOdwV3GfF8qig/Db/yD5THzKK4HFNxjGkbLd8rSIYjmUgGiAtjJ7OUqUFqRM92Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385434; c=relaxed/simple;
	bh=xQ7hNCE0DNOP4U41pP3s0ClJGxIz6zSi+Jgjtu12jcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlhnkkfkw+7W1drad/zIKfHmeYm4/gqsI7gi9wW6dj0VD3PbdCX8Ks4llMTYwGWGGB2h6NRyVk/ooII4UeTUQxOo4V/Fwgbo4Jca3Cx6VjweF76rEYLNEOOdm0cIY0IYh/t67i09Ou8LjFEiufedCjrf+KFZH7MZW4FBduP6SAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3q+NFEs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrFSV+enroO5/Kb8/GKX96Hz0vjFPPsWJvTVuF9uIxc=;
	b=D3q+NFEsSOS7cODd4bLUOima3BfVpJQCIhwVr51xeRadF25F6H0oejVdLkVm2tc60dbBlW
	TLPw8MOPTJNkOvG3tqS5LZONhxIAb7VRMcDesaJCE1GYYe0p7jfmMXwzexlZnjKykU7ykj
	13pYRlGOTBaOm5yPh0vZB5UbSsibsyE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-fl8HxNUwOTGxGELDvU6hTw-1; Mon, 29 Apr 2024 06:10:30 -0400
X-MC-Unique: fl8HxNUwOTGxGELDvU6hTw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ee2846ec10so1385766a34.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 03:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385430; x=1714990230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrFSV+enroO5/Kb8/GKX96Hz0vjFPPsWJvTVuF9uIxc=;
        b=SCryDDS7wAMngZuqAk7HRmtCkFMwhzmpXHqpc7D3EZ1r/XZNYoVPvewuUsXBTKwvom
         0gf08jALOFZG8iyjc8gc9GssUC9HoxqvQWnzXc4v4HQztihs1fVbOXGhLl34AtN4qz2i
         ZGZicI65fWr6E/lZAnm/pinBCA8OML86AQv4uLs1YAnTWvVfyJSyb2T7uaAvrhfeEPbi
         xca8M/4a67D6Ibsv98RzMTsQ+aDJ/TfcJVJuTcRMTaVGjG7WX6fu4IIxGYJfFZExgnZ1
         jLfJsdu44XUH5nR9mx4whAbv08M+IHD1aLCurczrlLdKaraCes6gVwWQAzNOeLTWspv1
         4zwg==
X-Forwarded-Encrypted: i=1; AJvYcCW+WoXVJI9sySC3JPy1ma77XXQbaUT/UHYA0auJ7op4RJ6D43ayKWSqHUnHHdZQyFchJCBRV+yRxVehWP+Fto46o5NqjQao
X-Gm-Message-State: AOJu0YyVSMUM29HFWqRZJ4l6741ZxkVMW0gBDm3r2K5espE0mN+ew45f
	TCLeZOEr78TsTyX819jTe9zQ09FP9+avgT6vDVF3i4XTH+Kbmb0RZ+GEMi2ssNTv3fyDIBjUXrN
	1AULNP2Ka5c59lvB+SMf4codP/RgPJkmiZVIa9Vu5JmAO4m9wXxvqfg==
X-Received: by 2002:a9d:7991:0:b0:6ee:2ca2:4370 with SMTP id h17-20020a9d7991000000b006ee2ca24370mr2789814otm.15.1714385429719;
        Mon, 29 Apr 2024 03:10:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrvfVsOcM4emYdUYKViS3N6+afe+LNkfiEGNb0K0Zlc2Ov17BGL5mY6doHoVFVADHAZxJpjw==
X-Received: by 2002:a9d:7991:0:b0:6ee:2ca2:4370 with SMTP id h17-20020a9d7991000000b006ee2ca24370mr2789795otm.15.1714385429234;
        Mon, 29 Apr 2024 03:10:29 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a034300b0078ef13a3d9csm10354459qkm.39.2024.04.29.03.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:10:28 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:10:27 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Casey Schaufler <casey@schaufler-ca.com>,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH v2] netlabel: fix RCU annotation for IPv4 options on
 socket  creation
Message-ID: <Zi9yE099IYtqhCzN@dcaratti.users.ipa.redhat.com>
References: <c1ba274b19f6d1399636d018333d14a032d05454.1713967592.git.dcaratti@redhat.com>
 <b6f94a1fd73d464e1da169e929109c3c@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f94a1fd73d464e1da169e929109c3c@paul-moore.com>

hello Paul, thanks for reviewing!

On Thu, Apr 25, 2024 at 05:01:36PM -0400, Paul Moore wrote:
> On Apr 24, 2024 Davide Caratti <dcaratti@redhat.com> wrote:
> >

[...]
 
> > @@ -1826,7 +1827,8 @@ static int cipso_v4_genopt(unsigned char *buf, u32 buf_len,
> >   */
> >  int cipso_v4_sock_setattr(struct sock *sk,
> >  			  const struct cipso_v4_doi *doi_def,
> > -			  const struct netlbl_lsm_secattr *secattr)
> > +			  const struct netlbl_lsm_secattr *secattr,
> > +			  bool slock_held)
> 
> This is a nitpicky bikeshedding remark, but "slock_held" sounds really
> awkward to me, something like "sk_locked" sounds much better.

ok, will fix that in v3.

[...]

> > @@ -1876,18 +1878,15 @@ int cipso_v4_sock_setattr(struct sock *sk,
> >  
> >  	sk_inet = inet_sk(sk);
> >  
> > -	old = rcu_dereference_protected(sk_inet->inet_opt,
> > -					lockdep_sock_is_held(sk));
> > +	old = rcu_replace_pointer(sk_inet->inet_opt, opt, slock_held);
> >  	if (inet_test_bit(IS_ICSK, sk)) {
> >  		sk_conn = inet_csk(sk);
> >  		if (old)
> >  			sk_conn->icsk_ext_hdr_len -= old->opt.optlen;
> > -		sk_conn->icsk_ext_hdr_len += opt->opt.optlen;
> > +		sk_conn->icsk_ext_hdr_len += opt_len;
> >  		sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
> >  	}
> > -	rcu_assign_pointer(sk_inet->inet_opt, opt);
> > -	if (old)
> > -		kfree_rcu(old, rcu);
> > +	kfree_rcu(old, rcu);
> 
> Thanks for sticking with this and posting a v2.
> 
> These changes look okay to me, but considering the 'Fixes:' tag and the
> RCU splat it is reasonable to expect that this is going to be backported
> to the various stable trees.  With that in mind, I think we should try
> to keep the immediate fix as simple as possible, saving the other
> changes for a separate patch.  This means sticking with
> rcu_dereference_protected() and omitting the opt_len optimization; both
> can be done in a second patch without the 'Fixes:' marking.
> 
> Unless I missing something and those changes are somehow part of the
> fix?

just checked, rcu_replace_pointer() can be used also in the oldest LTS
but I'm not sure if kfree_rcu(NULL, ...) is ok. I agree to keep
rcu_dereference_protected(), and the useless NULL check - I will
follow-up with another patch (targeting net-next), after this one is
merged.

--
davide


